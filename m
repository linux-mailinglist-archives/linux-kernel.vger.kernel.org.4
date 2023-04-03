Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB26D53C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjDCVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjDCVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:43:32 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7E94EEC;
        Mon,  3 Apr 2023 14:43:04 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w133so22874470oib.1;
        Mon, 03 Apr 2023 14:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWlZdx93F8nlmoogzqtxamqJwghDMjvRjuP8AXjAumk=;
        b=d1e0z0Plg39F8+xt8MAxBCrEqW/Nj/tTRl+wQHsseEmzMXolLwAy7+aRE053AM7sZW
         0VXBedkESC0/1g+AJo7NbgxpueO95SovNAv54RAtVj89UeBTwH0vuhzGOaVBB0zLUCAd
         YTC1CdbW8E0hQOo4J5RhFvr70/KmdtU/9bj+aF1fYaLpExmKCRG+VzjoU8T93W+1nUG1
         v3qFcC/JeWqOy0l/2Y8Ypqlv9kGxlt13htsqnWQB8KK77dFiEgH73ZpzaDgCDABjttaW
         4+1SOXZqdeqP3B5QaAMQ3KhRMS2dCeD0n1iG/xazkiK3+63v37ri4VzRldFbpfdw+RvI
         JBgw==
X-Gm-Message-State: AAQBX9e7EdCnRmFC5SiLHMmUYkBk+mgi4ru+6pQQZgE3XsWb2aDS24St
        ZKKvB2DWwFnhM6wRl5eb0Q==
X-Google-Smtp-Source: AKy350ZzyFiY9jN9Cvy2Hys9a4xq8l53ckqKWhZHLpaYeqPk2/OunwhrYji6fGE39YdMZeeXG71sCA==
X-Received: by 2002:a05:6808:229e:b0:387:31d1:d069 with SMTP id bo30-20020a056808229e00b0038731d1d069mr265605oib.10.1680558103450;
        Mon, 03 Apr 2023 14:41:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0906000000b00389533b1cc8sm3736324oij.18.2023.04.03.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:41:43 -0700 (PDT)
Received: (nullmailer pid 1922851 invoked by uid 1000);
        Mon, 03 Apr 2023 21:41:42 -0000
Date:   Mon, 3 Apr 2023 16:41:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] of: address: Reshuffle to remove forward declarations
Message-ID: <168055810164.1922790.9260589714673662646.robh@kernel.org>
References: <cover.1680248888.git.geert+renesas@glider.be>
 <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Mar 2023 09:52:30 +0200, Geert Uytterhoeven wrote:
> Reshuffle the code to get rid of the forward declarations, which
> improves readability.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/address.c | 271 +++++++++++++++++++++----------------------
>  1 file changed, 133 insertions(+), 138 deletions(-)
> 

Applied, thanks!

