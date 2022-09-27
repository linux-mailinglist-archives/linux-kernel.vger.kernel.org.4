Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A235EC6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiI0Opt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiI0Oo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:44:59 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44B3ED73;
        Tue, 27 Sep 2022 07:39:45 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id r22-20020a9d7516000000b00659ef017e34so6421590otk.13;
        Tue, 27 Sep 2022 07:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Wv/lnq7etpZZ5IqM9sVONW3uciXaLX/bTWFj3PI4Hqs=;
        b=Otk7yvZgaw1WEcE5RLzJGG8khErxaAeRbgpgxezhBpnrxoN9N/+drjcnGIIuLEId7u
         BVwo4p38YjN+DqMOf/2clqJ+6tvdJcJDpbqL1X1abNPBprNY2tinYnfR8eT8ds7/xIyr
         WlwfsfsjzfOygiEsZmXvABhV4uJxeYXQ6mUwlQ6NvAzbklMtavN9JEiEro4Yy7fMFF/H
         a+AxjyemXt3c/4N1EGC5PfBnZjg+SBJEpL9HYPmikh9ox9koFJphwysIJ+zJbi7NXnic
         GRqmE9kUxPyBwJ0ihuxXmesW7ePPmuo1FQqpp7rUqvPbsOmc1/MDqWhkNz8hKRXv8WOX
         k+Yg==
X-Gm-Message-State: ACrzQf2Z6QKAVNox60zs8EXKB5dLmJZZcor0TULimnrb9PVka+fYDWOx
        rH0h8Hl7YvQouxZVgox26A==
X-Google-Smtp-Source: AMsMyM6fjL9ALpn8MexY1CA6Xq24UB81fooaiMYfvSnydXMdkXNLt9Fetdr7y+XHi5xu6r+dcYwV+Q==
X-Received: by 2002:a05:6830:3985:b0:65c:34f7:6bb8 with SMTP id bs5-20020a056830398500b0065c34f76bb8mr2946708otb.122.1664289562323;
        Tue, 27 Sep 2022 07:39:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p10-20020a0568708a0a00b0012d939eb0bfsm849916oaq.34.2022.09.27.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:39:21 -0700 (PDT)
Received: (nullmailer pid 943213 invoked by uid 1000);
        Tue, 27 Sep 2022 14:39:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Zhang Rui <rui.zhang@intel.com>
In-Reply-To: <20220927013951.12833-2-zhuyinbo@loongson.cn>
References: <20220927013951.12833-1-zhuyinbo@loongson.cn> <20220927013951.12833-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: add loongson2 thermal binding
Date:   Tue, 27 Sep 2022 09:39:18 -0500
Message-Id: <1664289558.346744.943212.nullmailer@robh.at.kernel.org>
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

On Tue, 27 Sep 2022 09:39:50 +0800, Yinbo Zhu wrote:
> Add the loongson2 thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v3:
> 		1. Remove the sensor id.
> 		2. Remove the interrupt-parent in thermal required property.
> 		3. Update the thermal binding file name.
> 		4. Fixup the commit log information.
> 
>  .../thermal/loongson,loongson2-thermal.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson,loongson2-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/thermal/loongson,loongson2-thermal.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/thermal/loongson,loongson2-thermal.yaml#
Error: Documentation/devicetree/bindings/thermal/loongson,loongson2-thermal.example.dts:25.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/thermal/loongson,loongson2-thermal.example.dtb] Error 1
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

