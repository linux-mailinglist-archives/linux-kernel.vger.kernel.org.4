Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB0629CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKOPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKOPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:00:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0BF2C130
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:00:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h9so24760311wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wGd0eX9dHnbMWbZ42d1c86XckxWPxOIEV8Vb6s6+IpQ=;
        b=BcsGr0Rq+viCW0Ll8pHykvGWU6QJ+XVHP6g81m7DojwvWk4YbMmyPOYnWs8FLuyUNi
         INdfeAe7wkRlUSu/t2vgaCkEze5QxvBhiWHCGRgP8ZE0Pn2YXjvoDqV7jLk/E6ChYh9m
         yBUwQwoCbLaYigIYIxL6kt+9IAuDaLGyHmFoRXJYfRoHr8N1lYNRLVq4ej2shT93aCti
         5sUbr+3mo1NM3/fH4lV6vSg7C2aZARlqch4wswroCGHoDqIhHdtX8Zd2ANA/rGo6FOUE
         qahVHa4PiqXqWqmnaA1kSH79Jn8dlJB0BV2tGqCsNxafM24cNZ2djdtR4goUXrNCiePm
         2yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGd0eX9dHnbMWbZ42d1c86XckxWPxOIEV8Vb6s6+IpQ=;
        b=bHvWYuWWXzfdRIy5IJdk9KmFYXYVz2ecwwP7L5ZtJm/Mi093v/7x0euiHpwCJ6eZuP
         lvmWsIGCut8jDqVtPdh0xwtSZ5DQ94kF/VnHjrYrujJkUbWeYDXWyGe77thSuJgeslif
         e/0D+T4uhAUyXW54aiUeSOp7SRub+B+owxUlO05zodKKeY8oqJb8utlsoAREEa0/J+oU
         yG4Sadpgrxs3gmhRb4hKpvd/LSMhxivVweanrLIgzbaebyNw5mPGrJw+WUYyTXn3EMpT
         H0oQJZL7kM9rjKzUuA3fzAKjHIPcRHT98L3GRjTqYFDFwFBp9m2fPH5rYGmd++CUCYpf
         Ds+w==
X-Gm-Message-State: ANoB5pn7xpjjG5t7FKPF1aHtZmeXQkyU1gu3mlTG/CgNDxjQJrc9cFRE
        3OpGaRDGsgWTd671uQDzLfjDsQ==
X-Google-Smtp-Source: AA0mqf5BIhE9LqTRNtr8yELm7gIiWdFkyK3CdvNNzl1T0wlk3NkIVEvus9hfeCAuUASWJI2txLvtdQ==
X-Received: by 2002:a5d:6086:0:b0:22e:71db:47ba with SMTP id w6-20020a5d6086000000b0022e71db47bamr11491222wrt.359.1668524401507;
        Tue, 15 Nov 2022 07:00:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fcf3:1c15:2e51:def7? ([2a01:e0a:982:cbb0:fcf3:1c15:2e51:def7])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b002366fb99cdasm12567649wrr.50.2022.11.15.07.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:00:01 -0800 (PST)
Message-ID: <1ec5c839-ea5d-e6eb-3a51-f5824c322b76@linaro.org>
Date:   Tue, 15 Nov 2022 16:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 2/2] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v4-2-463523919c19@linaro.org>
 <166851961723.867617.14976811191392756271.robh@kernel.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <166851961723.867617.14976811191392756271.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 15:11, Rob Herring wrote:
> 
> On Tue, 15 Nov 2022 11:12:36 +0100, Neil Armstrong wrote:
>> Convert the non-SMD RPM node bindings to dt-schema, the old txt bindings
>> are now removed since all bindings were converted.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Lee Jones <lee@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
>>   .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 101 ++++++++
>>   2 files changed, 101 insertions(+), 283 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/regulator/qcom,ipc-rpm-regulator.yaml
> ./Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/soc/qcom/qcom,rpm.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb: rpm@108000: regulators: False schema does not allow {'compatible': ['qcom,rpm-pm8921-regulators'], 'vdd_l1_l2_l12_l18-supply': [[1]], 's1': {'regulator-min-microvolt': [[1225000]], 'regulator-max-microvolt': [[1225000]], 'bias-pull-down': True, 'qcom,switch-mode-frequency': [[3200000]]}, 's4': {'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]], 'qcom,switch-mode-frequency': [[1600000]], 'bias-pull-down': True, 'qcom,force-mode': [[3]], 'phandle': [[1]]}}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb: rpm@108000: regulators: Unevaluated properties are not allowed ('compatible', 's1', 's4', 'vdd_l1_l2_l12_l18-supply' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
> Documentation/devicetree/bindings/soc/qcom/qcom,rpm.example.dtb:0:0: /example-0/rpm@108000/regulators: failed to match any schema with compatible: ['qcom,rpm-pm8921-regulators']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Damn, will fix in v5.

Neil
