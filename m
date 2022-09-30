Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08B5F15B4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiI3WFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiI3WFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:05:48 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75E79A49;
        Fri, 30 Sep 2022 15:05:46 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127dca21a7dso6929942fac.12;
        Fri, 30 Sep 2022 15:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OCha88PaYgifgFcd4uvVIztgcK5zt4FhzTG/3Ul1xes=;
        b=DAUlPPc6Wlnt3aIG+6eW3uJYK7yUflCEkoZsUoW+SPyP8m9V2LgSBWR6nJ6HwX2b6l
         dvUsJu97XzXh/W25VdkIGdpjVumC9Zlv1KK5RgNz41vr85KrpkBxsBR+SPtqV+ukRj+7
         mL2nG7npB5/b4bb0zZo/4fCQKQjcWecx93lQ2E8iUJNmGcKT4V7o0UGij7bc9CR49Jgt
         koq8GZN+eedLSCgIzHv/qg5FbE6+STdVA9OgKk1jcdeRXeGVEbbZnpDOCA2KZSdNiqnT
         PAO+NZZF9SlzNDLKzEDy0U46KdHZHyooi2Nxh1WizW2oRSNBk0Cdgay1qmanCfU3g79X
         FkJw==
X-Gm-Message-State: ACrzQf2WoM9vYUFIGAFoEuu4S/alZ1fHYlLcSE4Mo57wQn4/AYz6/noi
        wDDq0/7VDUBWNFy90Qf8UlxRmx1luQ==
X-Google-Smtp-Source: AMsMyM6wQkdkeuoMwiXngdbVWbO8gt78XK6h82limIVmKAdjhVl1fZtjFwbcpx8NGI3tyLKuDBDMyQ==
X-Received: by 2002:a05:6870:523:b0:131:2d50:e09c with SMTP id j35-20020a056870052300b001312d50e09cmr144209oao.129.1664575545273;
        Fri, 30 Sep 2022 15:05:45 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870241600b001317413344esm992413oap.47.2022.09.30.15.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:05:44 -0700 (PDT)
Received: (nullmailer pid 1129749 invoked by uid 1000);
        Fri, 30 Sep 2022 22:05:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220930145701.18790-11-trevor.wu@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com> <20220930145701.18790-11-trevor.wu@mediatek.com>
Message-Id: <166457526101.1112313.13428811477972046652.robh@kernel.org>
Subject: Re: [PATCH 10/12] dt-bindings: mediatek: mt8188: add audio afe document
Date:   Fri, 30 Sep 2022 17:05:43 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 22:56:59 +0800, Trevor Wu wrote:
> Add mt8188 audio afe document.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-afe-pcm.yaml        | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mt8188-afe-pcm.example.dtb: afe@10b10000: clock-names:17: 'adsp_audio26m' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mt8188-afe-pcm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

