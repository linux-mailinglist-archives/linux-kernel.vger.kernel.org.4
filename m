Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4705F32B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJCPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJCPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:38:32 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204E27CE6;
        Mon,  3 Oct 2022 08:38:24 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1321a1e94b3so7637235fac.1;
        Mon, 03 Oct 2022 08:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=o9tyAHoFBze0gmpWGtkgp3sleUFke7gglXwwNjWc4ys=;
        b=KjmX0+gzZJrUOBRfm6EWSoyX6of+0gBI0saApjmV1H28tNSKylbWq650O5xPslsAmu
         SVlzBXi1Z5iQ8BaOKWU2yeO+HCT0dFJc+00S39svLrh+TlsEfDsLHQmY7osPIBZj01jo
         duWSIRLEufVFSZpgpyrt2QpTxT+AHjX55PKusiQe6TiMQyRsYvXDystTC2IKN5358gtL
         HBPCQ3LYNqWgFh55/KeZrYPSY4Xz24juscsA0/0/hWikrpcNy6twoxLhqvT6h1K0ElZ/
         Vc4JXss/hv8HjtoT8owvb2qxQfdCq7zQLL4QxLUSKrPisvv2oJBSFm3dE0BYPsZBP8n/
         mXpw==
X-Gm-Message-State: ACrzQf2X0BuwgT5R3gCcvxn50AV5d/nXOLUovVakptDQHHikYWSoTvzZ
        +MZjdCQLPIDVKWQ8M6wp/g==
X-Google-Smtp-Source: AMsMyM5d5oI/HLMxN/5cSyd7PwbMiup/QxvlbuLeXMrnykgKhb+jP1zkorMQuhf3++sio6mLpTRRIQ==
X-Received: by 2002:a05:6870:178e:b0:126:7055:fc78 with SMTP id r14-20020a056870178e00b001267055fc78mr5805562oae.58.1664811500401;
        Mon, 03 Oct 2022 08:38:20 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z33-20020a9d24a4000000b0063695ad0cbesm2411586ota.66.2022.10.03.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:38:20 -0700 (PDT)
Received: (nullmailer pid 2350958 invoked by uid 1000);
        Mon, 03 Oct 2022 15:38:19 -0000
Date:   Mon, 3 Oct 2022 10:38:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        chiaen_wu@richtek.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lars@metafoo.de,
        jic23@kernel.org, cy_huang@richtek.com, pavel@ucw.cz,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v12 2/5] dt-bindings: leds: Add MediaTek MT6370 flashlight
Message-ID: <166480917702.2250974.12439864185418442009.robh@kernel.org>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
 <5632ef04d7807f78259e4e9f3d952849a839a50c.1663926551.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5632ef04d7807f78259e4e9f3d952849a839a50c.1663926551.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 10:51:23 +0800, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
> 
> Add MediaTek MT6370 flashlight binding documentation.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> 

Applied patches 1 and 2 as the MFD binding depends on these.

However, these introduce warnings in the example, so please get those 
fixed.

Rob
