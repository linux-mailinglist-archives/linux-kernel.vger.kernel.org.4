Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5E6D8C94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjDFBNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDFBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:13:28 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F457AB3;
        Wed,  5 Apr 2023 18:13:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso20009410otb.12;
        Wed, 05 Apr 2023 18:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680743516;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufRr1P5zgDydxR7b/xl15Olfy3++TXWLHdwr3z6Hl80=;
        b=juccscYiNNkT9BFQUjnLnuQGbKPijjmG3LwEB7dvp8gL1gTwcS7S935mAnroJhc/0w
         JP0wm57PWNWwsjjjTyH2R54UwhDhp7C88AnEn4C8rKrPfXWuG/mV132m6qap1ReR3lEY
         Gukh95gcIJUpNm2xsV7u96DHYTofXCBjKTUYW4w8i5AdebPPmGdENW9NJjJ0FGwwrYw7
         c1rTqqL2FaPV8F2nOZ1OkXLJ1js6d2Dkv8xoLmT+DgLto09KAdEm/zbr4x+Et/sSmiPL
         llzAafMUaJ3QpV9avWudKz0CyM8pwm/CbffJ6SdzCoPjl9vWjCOtB2Hbl74ki7hdXCDu
         ye2A==
X-Gm-Message-State: AAQBX9dnc6vkoL11b9XDyKbsHBteaWJVxDjLkgmIzBgmoha/uFm0edzW
        7yAXBfddhmHJIv+MrVXhDw==
X-Google-Smtp-Source: AKy350bjf3FJ5xVtkh5VmxXCJxAvfdFKyyINw/vI2AsMAiyk9L0BlsBlKjgXXhCYTQPz2uIVnTTHIw==
X-Received: by 2002:a9d:65d1:0:b0:69f:1c2c:8f8c with SMTP id z17-20020a9d65d1000000b0069f1c2c8f8cmr3847278oth.25.1680743516609;
        Wed, 05 Apr 2023 18:11:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y19-20020a056830209300b0069fb749271bsm193458otq.15.2023.04.05.18.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:11:56 -0700 (PDT)
Received: (nullmailer pid 1305711 invoked by uid 1000);
        Thu, 06 Apr 2023 01:11:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saalim Quadri <danascape@gmail.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.baluta@nxp.com, robh+dt@kernel.org, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20230405200341.4911-1-danascape@gmail.com>
References: <20230405200341.4911-1-danascape@gmail.com>
Message-Id: <168074344623.1301612.621743725976519280.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8904: Convert to dtschema
Date:   Wed, 05 Apr 2023 20:11:55 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 01:33:41 +0530, Saalim Quadri wrote:
> Convert the WM8904 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 66 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8904.txt      | 33 ----------
>  2 files changed, 66 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230405200341.4911-1-danascape@gmail.com


audio-codec@1a: Unevaluated properties are not allowed ('AVDD-supply', 'CPVDD-supply', 'DBVDD-supply', 'DCVDD-supply', 'MICVDD-supply' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb

