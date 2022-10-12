Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A895FBE91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 02:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLABy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 20:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJLABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 20:01:49 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FCA487F;
        Tue, 11 Oct 2022 17:01:46 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1321a1e94b3so17836385fac.1;
        Tue, 11 Oct 2022 17:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu7+tEZ6aYM6e8Y/GPKskmbmDxOQCtazL2x0VzwdFp8=;
        b=XJm9xz6NTNNYRMh6wiFIppaZ9fXy28rpBqpQZpA0aFmcnOzIEAqk9GRRJ7pObR35jR
         w4PhqzP0IVKMHs6E+T6EAXDlusQa2n1Uxf1sxHIsnsKpIpVBmvBnxpa8jiAp5TPxTA4W
         /S7uQd1isocxy8tweEUKb2e09GceubwfBIA+jlDQBmGDbRttclWW4W2dOp6m8dWuzorg
         7dR2QlHiia4B9bDcAJYQLXDCdRu/mrQSrlL8KNk+MKfCgO4wFysEH7hqX+ojKPPmqSHh
         /kf1jDQsbbKN23Lu59Kr58MD/v9Kv+kHllCiTSMuy0ZvCnCsmYWSU/2kjasNH8CaP6n7
         HICw==
X-Gm-Message-State: ACrzQf0C/eRIoHHvHzxNN2f3k+5fhCwg6wjLjmGzHp1PITcWkcAUtfIl
        rLpJn+4iEaNEZmD4V0IJzg==
X-Google-Smtp-Source: AMsMyM6p0HBUTyPXJ8P4LZSlHr46dkxleO8f8BdMw6orJHncRRJCeYkVoVfsQ9bAvCRazLwTfJ6WNA==
X-Received: by 2002:a05:6870:3415:b0:133:197:3ca3 with SMTP id g21-20020a056870341500b0013301973ca3mr1000187oah.115.1665532905521;
        Tue, 11 Oct 2022 17:01:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w22-20020a9d6756000000b00661a38ebbdasm2330547otm.59.2022.10.11.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 17:01:44 -0700 (PDT)
Received: (nullmailer pid 418283 invoked by uid 1000);
        Wed, 12 Oct 2022 00:01:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
In-Reply-To: <20221011184119.3754096-1-robh@kernel.org>
References: <20221011184119.3754096-1-robh@kernel.org>
Message-Id: <166553283000.416500.15587145212925837942.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Date:   Tue, 11 Oct 2022 19:01:46 -0500
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

On Tue, 11 Oct 2022 13:41:19 -0500, Rob Herring wrote:
> Convert the dmic-codec binding to DT schema format.
> 
> The '#sound-dai-cells' and 'sound-name-prefix' properties were not
> documented, but are in use, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/sound/dmic-codec.yaml | 55 +++++++++++++++++++
>  .../devicetree/bindings/sound/dmic.txt        | 22 --------
>  2 files changed, 55 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/dmic-codec.example.dts:18:18: fatal error: dt-bindings/gpio.h: No such file or directory
   18 |         #include <dt-bindings/gpio.h>
      |                  ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/sound/dmic-codec.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

