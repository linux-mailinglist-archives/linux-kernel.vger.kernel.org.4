Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E263FBC5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiLAXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiLAXOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:14:23 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16C14D1B;
        Thu,  1 Dec 2022 15:14:21 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12c8312131fso3911717fac.4;
        Thu, 01 Dec 2022 15:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIr/2j9LR1jIfb9YzWHXNooHqxKrRbLzbkzM0aNI0hY=;
        b=tTqpjdeW1hciag/xwL7I3CyncUsHoxpk+h/sN/lKEcoucGv//ZAzrY052tBRWd4FEx
         mVFiyohqZ1uaq4zh0kOvh8UwnagRv9XVrNzke0L3hjW05+ayVj4a8xQKZt+fDYF1SBYd
         b5TodLC8HEo0C9L7BwXwm1F8IeLtb5RGtt59YQ3Pz1B3WFxdqmyT934dSECj5GptgqIj
         wyOdPgTedtUCkEy4NRVvASgeniTAY6M3n4S61Y+qrII71UHV6894PPGe5uU/zt8gnXwr
         YBjTmluPgZuLE9UrRLDuExNlfCkt8dQl/kxr4gCx79mtQVoZelBzVwPdPngAd6wKiO44
         ysgw==
X-Gm-Message-State: ANoB5pnnNOhaEbGIl/vF+qesKjyEoZBo7OMrPOC6xaGm11PI9HBFRTtQ
        2/GIUOHCPEtphrLvtiQWD6yP+zkJUg==
X-Google-Smtp-Source: AA0mqf6/AEyeJtfEHqUXesdIbRoCbHyrdgWlY2GE2eJ13EW0nBRgJuMGOIfp7YWvfzPUFn9MKaX3AA==
X-Received: by 2002:a05:6870:b39b:b0:142:aa9b:2668 with SMTP id w27-20020a056870b39b00b00142aa9b2668mr30841958oap.166.1669936460377;
        Thu, 01 Dec 2022 15:14:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q13-20020a056808200d00b0035b4b6d1bbfsm2410122oiw.28.2022.12.01.15.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:14:19 -0800 (PST)
Received: (nullmailer pid 1660505 invoked by uid 1000);
        Thu, 01 Dec 2022 23:14:19 -0000
Date:   Thu, 1 Dec 2022 17:14:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yunfei.dong@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 2/3] media: dt-bindings: media: mediatek: Remove
 "dma-ranges" property for decoder
Message-ID: <166993645851.1660446.2817424583068885626.robh@kernel.org>
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2022 22:38:31 +0800, Allen-KH Cheng wrote:
> Since commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers") was merge, we don't need a dma-ranges property for IOMMU
> in mediatek video codec.
> 
> We remove the dma-ranges property and fix the example in
> mediatek,vcodec-subdev-decoder.yaml
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
