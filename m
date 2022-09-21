Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB835BF6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIUG72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIUG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:59:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D878168A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:59:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h3so5849359lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NmJ1ky94R3TydWshdEnT7QkhQ55Opa2pbsWIWb/PLzU=;
        b=HhNHKhYTz5ALtyqiXfUOHtKrrko2VcWHyahB3IZyhU+pGovf+Px5ox5tDcszKkebuW
         uLxlzDq0VY9I7JFg5+iZ4yHABGNgVM0RsWEHH6s55s6tMsHKv4UUa014BPj1blI63sGa
         4XhBKkPRX+bTyW7unTw7E5xsjr85aJCLVdra1RGqewk0CMvXMB2Sauu/AchjyL3cdaLH
         mHlBeRUQMMsUMPRfFwTt8RSLHphN6/2uM/KBhtlvOlWTydFGkvE/38NtgXm3xIya9cPR
         oQ+Dhj+TOk42XKizmI334nAXG05yhcPmYEPUsi0oshLFMBxOCfZuKCiAcZZoRxaMh0Sj
         M2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NmJ1ky94R3TydWshdEnT7QkhQ55Opa2pbsWIWb/PLzU=;
        b=t4ZJJLKCvI9wF0Lw42qnU8GY4HvxlvNafKLt7iux/YSkyVdsbzHh+tY1phmvCwieJN
         5J8ZPH24mvrVjBk+sOTUHSY/73Shb9HDp0tZXayScO/KBpxkO8Fud0yIyHfqtLBMY2I6
         DPvXZthOMEHmJbvXmsDpLmIDsdwGazacMW9wRrbRjfw5xXRkQF6E7VtXZerILOAPoQ30
         j9Mlp1N+pNdXcBkmJYzEXGT9AqK1xXSNKXRyt8zaKxW5+LKMIHjq6muM5JiK4srZiz38
         2WZe4brYih5Tm8ScQheeq2dBL/ZRSLWOT3aUg/GxDO9oRRn9OtaC85A6nzEvZSuZuKqR
         XHeQ==
X-Gm-Message-State: ACrzQf3q8+QspAMMznRJC/VKNaMEZ+6JSMRWF/VHyy9dU3hHtSAo10as
        PyLhVVooLjczJyUmflgWbLc2Hw==
X-Google-Smtp-Source: AMsMyM67+W3xcMYvbfC92MP7UbXJppeQ+yXtwC3sCdPRGsLIkYI+reN4Vwxfb2fdjEwwiptxfRSJYQ==
X-Received: by 2002:a2e:a887:0:b0:26a:871b:a16d with SMTP id m7-20020a2ea887000000b0026a871ba16dmr8815200ljq.482.1663743557201;
        Tue, 20 Sep 2022 23:59:17 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e7e02000000b00267232d0652sm308120ljc.46.2022.09.20.23.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 23:59:16 -0700 (PDT)
Date:   Wed, 21 Sep 2022 08:59:14 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Amit Kucheria <amitk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
Message-ID: <20220921065914.xvsj664dgwmd3vcr@krzk-bin>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921015605.17078-2-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 09:56:04 +0800, Yinbo Zhu wrote:
> Convert the loongson2 thermal binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v2:
> 		1. Add description and type about the "id".
> 		2. Make the filename was based on compatible.
> 
>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml: properties:id:$ref: '//schemas/types.yaml#/definitions/uint32' does not match '^(/schemas/|\\.\\./|#(/|$)|[a-zA-Z0-9]+)'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
./Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml: <urlopen error [Errno -2] Name or service not known>
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml: ignoring, error in schema: properties: id: $ref
Documentation/devicetree/bindings/thermal/loongson2-thermal.example.dtb:0:0: /example-0/thermal@1fe01500: failed to match any schema with compatible: ['loongson,loongson2-thermal']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
