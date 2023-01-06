Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919AE65FA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjAFDS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAFDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:18:25 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B3625C9;
        Thu,  5 Jan 2023 19:18:24 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id y4so281227iof.0;
        Thu, 05 Jan 2023 19:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYKFaUU4WUwK+xZfWsHkCMpC56jh+w0/QlmTFIkRs60=;
        b=s7oS24dW0b1UNQpxrDcX20ruB28XwB0I+C93fIwzM0RgWNdWuCXvsaA8cSvGKkdPvJ
         nj9aPTEMMx+Lr2eGpCdZM0kkd8S+OnbHv39ProvDXUo+Q0w9GD7UhohOoECfUjjbatef
         UPSX/a0mLAoZs1uxizWZzosJox1uP9cfH8p1fsp87nk/bTP/4Cv8ehwy6IQnO0FEH4Sc
         mZBUuwmalsU3Exf1Zw2ow8/FFWJ2VQHq3zeSUGmFAwzvZD42FUwVFN3mrXi2xGM9RDDw
         5YzcyvO16v9PrHyO5cANpP5TGDux6Twx4uGF/rFxCPNsBxFyOqIlMTkNhfUrojy5PR//
         RFjQ==
X-Gm-Message-State: AFqh2kpkvE/Y9afKHzrfRlSgV+9kiV5ZaUqxtMOdLk0XUyrmqtGfROqC
        GmOUEtT/XGbfumIWYZ6bWw==
X-Google-Smtp-Source: AMrXdXsDBq+c58aF7nVFnVtwsw1bd0pMqZ3FjaWxnzSYHCQSOa7QxBXE9B8Uo7bbzH4pwSuY1aeihw==
X-Received: by 2002:a6b:dc10:0:b0:6eb:abee:634e with SMTP id s16-20020a6bdc10000000b006ebabee634emr35457157ioc.7.1672975103094;
        Thu, 05 Jan 2023 19:18:23 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n35-20020a056602342300b006bb5af55ddfsm13874837ioz.19.2023.01.05.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:18:22 -0800 (PST)
Received: (nullmailer pid 2198646 invoked by uid 1000);
        Fri, 06 Jan 2023 03:18:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz.abbas@arm.com>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org,
        Deepak.Pandey@arm.com, alsa-devel@alsa-project.org,
        Anurag.Koul@arm.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20230105160346.29018-1-faiz.abbas@arm.com>
References: <20230105160346.29018-1-faiz.abbas@arm.com>
Message-Id: <167297490078.2192494.10604791859897237948.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document simple-audio-card,plat
Date:   Thu, 05 Jan 2023 21:18:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Jan 2023 21:33:46 +0530, Faiz Abbas wrote:
> The simple card driver has support for adding cpu, codec and platform
> nodes with the simple-audio-card prefix. Add documentation for the plat
> binding.
> 
> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/simple-card.yaml:293:2: [error] syntax error: expected <block end>, but found '<block sequence start>' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/simple-card.example.dts'
Documentation/devicetree/bindings/sound/simple-card.yaml:293:2: expected <block end>, but found '<block sequence start>'
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/simple-card.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 33, in <module>
    sys.exit(load_entry_point('yamllint==1.26.3', 'console_scripts', 'yamllint')())
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 210, in run
    prob_level = show_problems(problems, file, args_format=args.format,
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 106, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 203, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 140, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 580, in check
    for problem in _check(conf, token, prev, next, nextnext, context):
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 346, in _check
    'wrong indentation: expected %d but found %d' %
TypeError: %d format: a real number is required, not NoneType
./Documentation/devicetree/bindings/sound/simple-card.yaml:293:2: expected <block end>, but found '<block sequence start>'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/simple-card.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230105160346.29018-1-faiz.abbas@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

