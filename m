Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D8685D0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBACHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBACHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:07:24 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EA4B4BE;
        Tue, 31 Jan 2023 18:07:19 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso2139900otp.1;
        Tue, 31 Jan 2023 18:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SSG6xVw92U1C4W14m/Ci6luDapa20UVlH7uFJDbFWM=;
        b=rVDLNGYHDYuU4j06a7iSy5PM+IjdjPxxSLBUrKjncYeXpu6zwJ9dApp5j+TP75G/L7
         GIQlrwEO+/fZw21mxVKy0UwJPJjyq+MEUxKSf/nmL/8IiIa3+5bIMgmYgxYtgHZr+2Aw
         JlRHqLUI64iEMXGExSDe7oV2mjiB81l9UoLGHwGW9AX0opGhnJwNFOeub3XSZ4tc+L/l
         RRuLCGQmcClBw/0Ua/nwr2JdmbOlMs+t6j/jlpfSLgz1l6BktSYTjLwWTSQS0OKFz4bB
         D8qAq8lVmKIUlAmU4HBhIeKuGACumAODVGpMyN7u0R8Sft0Jak1C4WoTMJrmDdkdo4Y1
         FovQ==
X-Gm-Message-State: AO0yUKUCzQfEY6Q4N6qDeVO6VJqcWX+3DmNuH3s/jkgo/93LVtz9DiW+
        lIAknO3by38rGq/pOHsuDw==
X-Google-Smtp-Source: AK7set9or9Yee73uoFSU/OSUpRdz3141MrwdsnBES5J4X9oQE6w9NhnhHukW74o9XCRJ0BqZ0t7jwQ==
X-Received: by 2002:a05:6830:3360:b0:686:7992:9dfa with SMTP id l32-20020a056830336000b0068679929dfamr504882ott.6.1675217238556;
        Tue, 31 Jan 2023 18:07:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k25-20020a9d4b99000000b0068bcc902b82sm3858542otf.71.2023.01.31.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 18:07:18 -0800 (PST)
Received: (nullmailer pid 2322070 invoked by uid 1000);
        Wed, 01 Feb 2023 02:07:17 -0000
Date:   Tue, 31 Jan 2023 20:07:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Fix typo
 in description of msi-controller property
Message-ID: <167521723608.2321996.5170085909101903467.robh@kernel.org>
References: <20230130234335.13952-1-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130234335.13952-1-prabhakar.csengg@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 23:43:35 +0000, Lad Prabhakar wrote:
> Fix typo functionnality -> functionality.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

