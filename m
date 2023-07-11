Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE974EB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGKKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:13:36 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756F4139;
        Tue, 11 Jul 2023 03:13:35 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-78360f61ba0so262616139f.1;
        Tue, 11 Jul 2023 03:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070414; x=1691662414;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3w0658T+UU4cFr1rnzl3x/GXWKfBQHyLpeL2ziojvT8=;
        b=EMuMd8ddN0wxpGuRRovvKObB7AGTBGqF8XNYnYSOwHGc8NfVCPtku7cLvLMzFnhj/M
         RhjcvW5lB0Zk5cPLaMNAir4eNhTmEX/fRZ16a1xwuy1kp/yZtmVyJx6VM43/yeXbKOH/
         BD/hNg+dbsvzKUV1rT2Njh4n7NJYm9IivP4VItGaoVM1NLz6elJc2mCVOWLUn9K70NF0
         MMmcg7QINuJ1VBf+Jbd1pjU0rlcDQTSJUqqQP+HZmBsCm4DkVkQTg/vTVbS1JPv/bgRZ
         FtfzHvU9qHORC4MRYPfxyVT1fGfqHXT3vnPNxuJ4XRDLDlmKkPdgUVXKFJKOUxkuPnUJ
         QIKA==
X-Gm-Message-State: ABy/qLbjIvmHwZWSWQV57HL0rErqbhUpnMv2jUaZSbmvCqRQI6+mIdaG
        uiS8gYJ9m6rpjwzZ/KoIuaQfLmBmZw==
X-Google-Smtp-Source: APBJJlFIjG8u6hOrpmMC9sB9S7zufWwkJC25mhG0Xdf8zeYsTvlUk82UWJtLmPTM+fypjjTsmuFV8Q==
X-Received: by 2002:a5d:9a0c:0:b0:786:285f:a9b2 with SMTP id s12-20020a5d9a0c000000b00786285fa9b2mr14614830iol.12.1689070414590;
        Tue, 11 Jul 2023 03:13:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l10-20020a02cd8a000000b0042b149aeccdsm467528jap.104.2023.07.11.03.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:13:33 -0700 (PDT)
Received: (nullmailer pid 552619 invoked by uid 1000);
        Tue, 11 Jul 2023 10:13:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     huaqian.li@siemens.com
Cc:     baocheng.su@siemens.com, krzysztof.kozlowski+dt@linaro.org,
        huaqianlee@gmail.com, robh+dt@kernel.org, nm@ti.com,
        jan.kiszka@siemens.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        kristo@kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, wim@linux-watchdog.org, vigneshr@ti.com
In-Reply-To: <20230711091713.1113010-2-huaqian.li@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
 <20230711091713.1113010-2-huaqian.li@siemens.com>
Message-Id: <168907041196.552587.9843900798401014394.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Date:   Tue, 11 Jul 2023 04:13:31 -0600
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


On Tue, 11 Jul 2023 17:17:11 +0800, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
> watchdog cause. Add a reserved memory to know the last reboot was caused
> by the watchdog card. In the reserved memory, some specific info will be
> saved to indicate whether the watchdog reset was triggered in last
> boot.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  .../devicetree/bindings/watchdog/ti,rti-wdt.yaml    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml:30:18: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/watchdog/ti,rti-wdt.example.dts'
Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml:30:18: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/watchdog/ti,rti-wdt.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml:30:18: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230711091713.1113010-2-huaqian.li@siemens.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

