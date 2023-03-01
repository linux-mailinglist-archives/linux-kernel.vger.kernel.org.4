Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FC6A663B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCADGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCADGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:06:31 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21A38B58;
        Tue, 28 Feb 2023 19:06:29 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso6786686otj.13;
        Tue, 28 Feb 2023 19:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lymjuNFmV6QcZeVTgX1MDgfpatj25sVBNmFeqcabB2A=;
        b=sjFWOoxI5V6w1J1uU8y/cYsTAf1R4UtCh54bVvhxkrtm863A48bmS0+B9t46NepTuW
         hTFR+EIvSgadKmum7ijtpUKmmhE/yWoNdkqrfn0DWroSGDuLMkQZkKkLV/Tkd+FE/juH
         gtUyS/NZH4l5OkkQ9uTE9Q7wCMoANfY6KM9v8zafm2GCQOx2l8vGvvz/4fwqwomoReTe
         lIh+pT0fuXXqya59/WAxczxnB4FEZ13hW9FPK+LDXbHKTPmO64X2bgT8PKmULUmdMkpo
         JakwB2LMGZi8p3pmKgIZGD2w5e7NLMb/EeMeQnSXhI5sgCfCNz5GmA3vCfs60njFoKeB
         X31g==
X-Gm-Message-State: AO0yUKUjjVzeN1GLKpSRmPH2+iuNAY2G8LA31msXAOkn3GYAi+4bmVVF
        mQrk+9nXc2XSIk1A9j45HQ==
X-Google-Smtp-Source: AK7set/8nDk8IJI2Vc2Wf1n+juhBnx0Dhc/u31cxg0crp6mAauSVKJU8fn/hDfa15OmFijII6/2BTw==
X-Received: by 2002:a05:6830:1f45:b0:68b:d7c1:d095 with SMTP id u5-20020a0568301f4500b0068bd7c1d095mr2636688oth.25.1677639988459;
        Tue, 28 Feb 2023 19:06:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d7308000000b0068bce6239a3sm4457563otk.38.2023.02.28.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:06:28 -0800 (PST)
Received: (nullmailer pid 295794 invoked by uid 1000);
        Wed, 01 Mar 2023 03:06:27 -0000
Date:   Tue, 28 Feb 2023 21:06:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org, horia.geanta@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/9] dt-bindings: crypto: convert fsl-sec4 to DT schema
Message-ID: <20230301030627.GA287352-robh@kernel.org>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
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

On Wed, Mar 01, 2023 at 09:56:53AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This is effort towards SystemReady IR 2.0 to convert the txt binding to DT
> schema.
> Patch 1 is just to drop uneeded number since following DT schema will update the name
> 
> The fsl-sec4.txt binding has two parts, one is crypto, one is snvs, so I split
> into two DT schema file. patch 2,3 is for crypto, patch 4,5,6 is for snvs,
> patch 7 is to drop fsl-sec4.txt binding. patch 8,9 is to add new node
> 
> Peng Fan (9):
>   ARM: dts: vfxxx: drop the number after jr
>   dt-bindings: crypto: fsl-sec4: convert to DT schema
>   dt-bindings: crypto: fsl-sec4: support sec5.4/0 and i.MX6UL
>   dt-bindings: crypto: add fsl-sec4-snvs DT schema
>   dt-bindings: crypto: fsl-sec4-snvs: add simple-mfd compatible
>   dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x compatible
>   dt-bindings: crypto: drop fsl-sec4 txt binding
>   dt-bindings: crypto: fsl-sec4-snvs: add snvs-lpgpr support
>   dt-bindings: crypto: fsl-sec4-snvs: add poweroff support

I'll leave it to you to work out which one to take[1]. :(

>  .../bindings/crypto/fsl-sec4-snvs.yaml        | 181 ++++++
>  .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
>  .../devicetree/bindings/crypto/fsl-sec4.yaml  | 366 ++++++++++++
>  arch/arm/boot/dts/vfxxx.dtsi                  |   4 +-
>  4 files changed, 549 insertions(+), 555 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.yaml

Filenames based on compatible strings...

Rob

[1] https://lore.kernel.org/all/20230220213334.353779-1-robh@kernel.org/
