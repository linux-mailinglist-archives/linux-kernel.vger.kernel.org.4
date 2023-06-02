Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8D71FEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjFBKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjFBKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:13:06 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816D197;
        Fri,  2 Jun 2023 03:13:05 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7747df5b674so35863839f.3;
        Fri, 02 Jun 2023 03:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700784; x=1688292784;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/PIFR+ZIA9eZqhv8ThRSE/EHs2TLrNkw8dWpu4ejEo=;
        b=EWgZyOouIxS5i+8MJ02WPWOlmN3P37zHI8h5KSEzVXKyg5gH6K4SYQPUXrmuiNO3T9
         Xjc5eiPV44Y0McnGAxz+r8BAk1s5maeJyzpoitepdIHkp+ktx6/MPXnqJQOjnTJ9Wbpr
         KoyZdVRVTdqhhWXolXGiKTYU22KK8kWXfnvThXo/V4ED3Oe7GlZQ5OuT48eOTc75q0Wy
         LYvSCKoVhghOqoMeiTujy+Ju68mvZ+itUc9j+CXcbYY9VUzMA6nXI44Wabm48er3VNao
         yQGbBKFodZCmIeL02XeK6CZulkZR311ssw99VvfpYEzXjPhhYho5hmn9xlXdIotIBd6E
         SMHA==
X-Gm-Message-State: AC+VfDxJyEbZsO98yq5eDA0WV7x6YjqZlMugM41pKNbm26d0Oam8sNv4
        +Euk5dn9ekwpOIG145hyXHCG5wVMMA==
X-Google-Smtp-Source: ACHHUZ6CYRer4ThVGQY100UimlMmqDeEPZXk9gl/qzrUD8+oKZRBwxw0FiZma7Yt5Kk1HtF3Qk5qGA==
X-Received: by 2002:a6b:db17:0:b0:76c:71dc:55f3 with SMTP id t23-20020a6bdb17000000b0076c71dc55f3mr2219262ioc.6.1685700784312;
        Fri, 02 Jun 2023 03:13:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a029f03000000b0040f94261ab1sm208404jal.12.2023.06.02.03.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:13:03 -0700 (PDT)
Received: (nullmailer pid 1359772 invoked by uid 1000);
        Fri, 02 Jun 2023 10:13:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230602090322.1876359-2-alvin@pqrs.dk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
Message-Id: <168570078201.1359749.10287160624641352834.robh@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new
 symmetric-clock-role flag
Date:   Fri, 02 Jun 2023 04:13:02 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Jun 2023 11:03:18 +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The new flag specifies that both ends of the dai-link have the same
> clock consumer/provider role. This should be used to describe hardware
> where e.g. the CPU and codec both receive their bit- and frame-clocks
> from an external source.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/sound/simple-card.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/simple-card.yaml:33:5: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/simple-card.example.dts'
Documentation/devicetree/bindings/sound/simple-card.yaml:33:5: could not find expected ':'
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/simple-card.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/sound/simple-card.yaml:33:5: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/simple-card.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230602090322.1876359-2-alvin@pqrs.dk

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

