Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794806D53C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjDCVm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjDCVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:42:55 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280484EE3;
        Mon,  3 Apr 2023 14:42:28 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id w13so11489352oik.2;
        Mon, 03 Apr 2023 14:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zY8wGphhmOPMTIGrod5Ujs3CrNlKFq5TexmiJr4DtE=;
        b=b6e8TLwxqB1LxKcBOW3iozsFuqJxQL/wHsFnzfc9/kAU0jB1x1TbAkxJ9AhVl3fiQa
         Q0is2RW4uhbvuLXNXSTILu9fdOFyFUvnmpNLk3ARapYQl1gca4KawB05ua85RV0o0IGs
         vKkF2A0A8t52YU1rT2UR7ZWB3f+ZNYYwUNUVpCbio/8p382XWuP6vdQAD8MKrvE+QuMR
         Dz8C8CEFvQIWAtmXEqN7+XecF4ewxC5bsEjy4DTypcuKhwiY7HorQtggcBd2qv6RvSCL
         5xGeu+stg3dN8ViF6ImLk8i3p34vKm7KtetIuRY6/7+Vw1yjtSel+nSkOPeJs4tj+zOR
         /szA==
X-Gm-Message-State: AAQBX9cP8WWXDc939YkleHPQrQ4iEerJCSzzdG3eoj/LilGocICulFhp
        572H7YSZ77/A/Me4LBqsRQ==
X-Google-Smtp-Source: AKy350bAiTuRQ3iIfNgW96eEHb+CX95qJW6c8/M0VUQx0PZBmXU28unitxmIHBTpWK4Gkfh/jYACOg==
X-Received: by 2002:a54:4710:0:b0:387:12e5:543a with SMTP id k16-20020a544710000000b0038712e5543amr295883oik.29.1680558088135;
        Mon, 03 Apr 2023 14:41:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020aca190c000000b00383eaea5e88sm4301556oii.38.2023.04.03.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:41:27 -0700 (PDT)
Received: (nullmailer pid 1922211 invoked by uid 1000);
        Mon, 03 Apr 2023 21:41:27 -0000
Date:   Mon, 3 Apr 2023 16:41:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] of: address: Document return value of
 of_address_to_resource()
Message-ID: <168055808572.1922125.2992250088774808515.robh@kernel.org>
References: <cover.1680248888.git.geert+renesas@glider.be>
 <61ffcb5e87511dfa21af169efd04806101c48b8a.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ffcb5e87511dfa21af169efd04806101c48b8a.1680248888.git.geert+renesas@glider.be>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Mar 2023 09:52:28 +0200, Geert Uytterhoeven wrote:
> Add the missing return value documentation to the linuxdoc comment block
> for the of_address_to_resource() function.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/address.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

