Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C4694EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjBMSKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjBMSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:10:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327472D7F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:09:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a10so14093897edu.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrFNz/cjsowXwlETtP+kH6cs7rMkGd9pIsymtXm93iQ=;
        b=ASyqHv5ovC0LjAt2DWkMvKUt04iRjs6rRLP4ccLJGnP77wwpfmJ1GIgQ0iU9cHeXBe
         /eHCYl0v74p/8L9G1SxvtJMii0G3uRmdTzmW9dEfzxnTkM5KajK0H3WD/5bRy6d/LWc0
         EgfH4bNeCLaZWQNX8Kn8+apeQsjJrfrjr1q76u6MFcSv5jHmELOvc+B/BZM9txqFuxft
         636odzY5r5dOlnQDNZbI2k64cl2nO+ZwsrUN7xm/vzNv6aaUABnM+rT/3mPhyYVeNjs/
         +smyO7VDlDCpPgh7jgreWa4h8xJULv5TBvhSGE27BcsiiQoJGQ0FoB6P0OflMu4eLc03
         pclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrFNz/cjsowXwlETtP+kH6cs7rMkGd9pIsymtXm93iQ=;
        b=TRBjqr3Ko/xcHh64Nk8mpztXJW/falw0PzBa1XFCnJbiCFg/lN1L8J0Q7YQpYhUDc/
         el4HYHK4Xv7gPYztojJSnn1vwPsFpytbqugaGdrtOdFpIia7pAAtZRBDRp5v9a04YE9b
         BMJuBRlQfj0/3fHqoVe5o3hmBOAqIAveB7T1+PzeHRYK+H9lYrVek4fxCYfgt+827uXP
         4VzxTrPPt+CSDhZXszuq2kcvWMScBhWhyN0UruGUhgZswkVSJ97nAPqXaJycoaKiHipC
         xY8HgpUqF8lmlCNOmVIqtV+Fii7eIAwG5nNDHa8n15Ow1oK2daMr7Abs5dPvqOkzMBiV
         OoKQ==
X-Gm-Message-State: AO0yUKWPM/EzOLWSAc/Am2P6bkS6omQEf00WTrQZbNB+QkcS5wtzVCDY
        puPLoYYOzHQTOuEriUx5ZeEWGA==
X-Google-Smtp-Source: AK7set9mcIeXp16D0D3cqp+JoeU1B51F5RlGG7CPB1h5PDRD0O528l6eKI/rurYDyjp1eZ2rn+kPcw==
X-Received: by 2002:a50:8ace:0:b0:4aa:a4e6:249b with SMTP id k14-20020a508ace000000b004aaa4e6249bmr26014988edk.7.1676311778917;
        Mon, 13 Feb 2023 10:09:38 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b004acb7f05589sm4037935edi.94.2023.02.13.10.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:09:38 -0800 (PST)
Message-ID: <6131c8bb-6d21-60a6-14f9-dd7a2642a1cf@linaro.org>
Date:   Mon, 13 Feb 2023 19:09:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/4] dt-bindings: remoteproc: qcom,sm6375-pas: Document
 remoteprocs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20230109135647.339224-1-konrad.dybcio@linaro.org>
 <20230109135647.339224-2-konrad.dybcio@linaro.org>
 <167328555792.1012753.8015526796598804432.robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <167328555792.1012753.8015526796598804432.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.01.2023 18:32, Rob Herring wrote:
> 
> On Mon, 09 Jan 2023 14:56:44 +0100, Konrad Dybcio wrote:
>> SM6375 hosts an ADSP, CDSP and modem as remote processors. Create
>> related bindings.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
Could you take another look, Rob? I think it errored out because of
me not having specified a dependency (which is in -next since Nov,
but not in -rc), which I should have noted..

Konrad
>> v2 -> v3:
>> - Separate out 6375 bindings
>>
>>  .../bindings/remoteproc/qcom,sm6375-pas.yaml  | 137 ++++++++++++++++++
>>  1 file changed, 137 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.example.dtb: remoteproc@a400000: False schema does not allow {'compatible': ['qcom,sm6375-adsp-pas'], 'reg': [[171966464, 256]], 'interrupts-extended': [[4294967295, 0, 282, 4], [4294967295, 0, 1], [4294967295, 1, 1], [4294967295, 2, 1], [4294967295, 3, 1]], 'interrupt-names': ['wdog', 'fatal', 'ready', 'handover', 'stop-ack'], 'clocks': [[4294967295, 0]], 'clock-names': ['xo'], 'power-domains': [[4294967295, 8], [4294967295, 9]], 'power-domain-names': ['lcx', 'lmx'], 'memory-region': [[4294967295]], 'qcom,smem-states': [[4294967295, 0]], 'qcom,smem-state-names': ['stop'], 'glink-edge': {'interrupts-extended': [[4294967295, 3, 0, 1]], 'mboxes': [[4294967295, 3, 0]], 'label': ['lpass'], 'qcom,remote-pid': [[2]]}, '$nodename': ['remoteproc@a400000']}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.example.dtb: remoteproc@a400000: Unevaluated properties are not allowed ('glink-edge', 'memory-region', 'qcom,smem-state-names', 'qcom,smem-states' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230109135647.339224-2-konrad.dybcio@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
