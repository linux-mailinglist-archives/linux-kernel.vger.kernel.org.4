Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD85659A92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiL3Qet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiL3Qei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:34:38 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B881C408;
        Fri, 30 Dec 2022 08:34:37 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id u8so11501608ilq.13;
        Fri, 30 Dec 2022 08:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qCFiFhr0DQPqKmGNLpxSeO70Nn9s9xGFSB4LOgYnXw=;
        b=qaHac45RcIoEFwbpXAc32IVXmJbm0Sset8CnJerXmBQhwxeSoZOORbR/JZqKKV85vG
         1RPPVy2Z9DahiiJF2azRE2dvSXarSCDNg9QxNDlgH3XDUwiNCbkepGaC+5mR7QH2QLST
         rXcNbMo29GgAHGSMdbv7O3epioZRs5TTfcezMY7LBB1l5Ot6rsBpp7P9Ik5//sg5R6uU
         PmqrkJfEXfwflvh7CoISTwKFGcmzvyed6we6+B1RVmk9Fv13lRnzwKwMzib+mi+lTy2P
         8O66WcpgwqQUweySdrAJMqXUnZ3WkEKlYvANjhzAwcOIReHcNuovggK6Amp07mpS/x1P
         nkDg==
X-Gm-Message-State: AFqh2kqektIy9Quai0E4k1H3do+vcutkY/8Y45d2uGil3+lmpUEEmJU4
        XNIhZebmi035Mss0nlyb7w==
X-Google-Smtp-Source: AMrXdXsrunY7o/6mCaL+SQFRgNYEeWlguOTFS+A5Edf7YR0n7hEhWIph7cWjYLAgeDIKK/OhX3Xqnw==
X-Received: by 2002:a05:6e02:f53:b0:30b:f436:930a with SMTP id y19-20020a056e020f5300b0030bf436930amr15645641ilj.28.1672418076269;
        Fri, 30 Dec 2022 08:34:36 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638110c00b00389d6a02740sm6731560jal.157.2022.12.30.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:34:35 -0800 (PST)
Received: (nullmailer pid 1935057 invoked by uid 1000);
        Fri, 30 Dec 2022 16:34:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     liweilei@awinic.com, povik+lin@cutebit.org, shumingf@realtek.com,
        yijiangtao@awinic.com, perex@perex.cz, stephan@gerhold.net,
        flatmax@flatmax.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tiwai@suse.com, duanyibo@awinic.com,
        pierre-louis.bossart@linux.intel.com, zhuning0077@gmail.com,
        cezary.rojewski@intel.com, james.schulman@cirrus.com,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        zhaolei@awinic.com, rf@opensource.cirrus.com,
        tanureal@opensource.cirrus.com, steve@sk2.org,
        ckeepax@opensource.cirrus.com
In-Reply-To: <20221230093454.190579-6-wangweidong.a@awinic.com>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
 <20221230093454.190579-6-wangweidong.a@awinic.com>
Message-Id: <167241769462.1925797.17416584377760317319.robh@kernel.org>
Subject: Re: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Date:   Fri, 30 Dec 2022 10:34:28 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 17:34:54 +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
> controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/awinic,aw883xx.example.dts:24.41-42 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/sound/awinic,aw883xx.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221230093454.190579-6-wangweidong.a@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

