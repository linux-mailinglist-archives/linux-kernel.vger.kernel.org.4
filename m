Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEF74FEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGLFPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGLFPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:15:47 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4481992;
        Tue, 11 Jul 2023 22:15:41 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-78360b822abso224720239f.2;
        Tue, 11 Jul 2023 22:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689138940; x=1691730940;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wKSzmt8hMlbZubw8Bz3GqPF8upMRfti75E4k3sjCdto=;
        b=Z3DoycGsbJo2KoFtDR7i+icfD0K/tDBdsKMsZ4hV6DVwQsunEc2ZThxSIinAT32DQV
         SxXkwXZ6/SUJiOnuqprY83qk81UFQ3uCgsIDI8cBsa+EAKISWTS+jIF0zE1OatlAaOQb
         VV9c+uesuxUkhyTQEac37xDLMWGg8YeEoz9G4qaum4G2ZisfDIWBeSM2gIcSZkw/5pH4
         6uR4NE1H4qD08UYtUrffHU/4KSzGUXdX/z+A0Xk1JcbY6B1sF9BvDhGsI3/JvSdw2f1p
         HUuKc1ID4nTutwY6jQ+U5qrXlwXaKss4Ht1i6Ab+nekL0cv04n7LldgXBqXphD5qCYou
         2uCA==
X-Gm-Message-State: ABy/qLY5fqcmxkRXtjj0HPYVh6E95rd+QQzOOt4t3FNyHoKE1q4U2eXZ
        cunwpdLsEfo6E5tyUx0YGg==
X-Google-Smtp-Source: APBJJlE0f1oUAsIvW5GwlxLOupfX0EVF6NhYj5beTh+z/lUbyjbik9bA0PsrX8MCvQVOw7HT0S4f1A==
X-Received: by 2002:a5e:c910:0:b0:77e:3d2f:d1f4 with SMTP id z16-20020a5ec910000000b0077e3d2fd1f4mr17007246iol.15.1689138940157;
        Tue, 11 Jul 2023 22:15:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v6-20020a6b5b06000000b007870289f4fdsm1068756ioh.51.2023.07.11.22.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 22:15:39 -0700 (PDT)
Received: (nullmailer pid 2909708 invoked by uid 1000);
        Wed, 12 Jul 2023 05:15:37 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shenghao-ding@ti.com, devicetree@vger.kernel.org, kevin-lu@ti.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org, tiwai@suse.com,
        broonie@kernel.org
In-Reply-To: <20230712044006.48456-1-luminlong@139.com>
References: <20230712044006.48456-1-luminlong@139.com>
Message-Id: <168913893753.2909692.17813614972049441778.robh@kernel.org>
Subject: Re: [PATCH v1] ASoC: dt-bindings: Add tas2505 audio amplifier
Date:   Tue, 11 Jul 2023 23:15:37 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2023 12:40:06 +0800, Kevin Lu wrote:
> Create tas2505.yaml for tas2505.
> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  .../devicetree/bindings/sound/tas2505.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2505.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'iov-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'av-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'dv-supply' is a required property
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/tas2505.example.dtb: codec@18: 'clock-source' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/ti,tlv320aic32x4.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230712044006.48456-1-luminlong@139.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

