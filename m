Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2F681D28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjA3Vqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjA3Vqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:46:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423353ABD;
        Mon, 30 Jan 2023 13:46:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so12486261wrv.10;
        Mon, 30 Jan 2023 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+625/Bqulur4KZ1EHmL5p6cKcEZr14ZlhksM8ID3dw=;
        b=p+hvsKVA1pgF0YWyAPK11sFss7+qh1Wmy17xOH6Qcnr8zSWWDP/QGJi/1he8hhDNg2
         /Ph1XMIhZrN1IVY+IOWgjVyxJz+CN7dOfVCUKoim/5bbfUvRECNeJxpg1VkyOO9tyz97
         fEMNOHz93ah2opok6hXhd+OAVTs1EQmJ7yFWt+rIHjVdpz9vhxMyRFrPnHlKzTXBOiD1
         9Uda97uAFM2Bko6yFeW19YXabY2ph+dnl9AJD2qfQrGOLTg25DBDbZt/ctbdDdrYF537
         XD6DhBbFTquf+im6V4BwbA2Q/hA/mLUoYPQjBlVLk71mQjl1OD4fLPaIyzyil99sIAlz
         lyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+625/Bqulur4KZ1EHmL5p6cKcEZr14ZlhksM8ID3dw=;
        b=xakXeDuwYlpYTb+jQDmowHG3phpMKu9w/qywfjOfPjy5DD1jmLOTBeTtb8GV2/x/Oi
         SGVFnWUejA4lI9qzpAtlgy2kNo98oKhhLiRnceZiYFymLRI1Vu0C2SJOzv6pRDoQeViT
         n64gMJtbkpWUHGObHv5XcxzLUwnhIJF5UYEoYGPg5iGH6nACLtdnUgEGdQryG0YqDzpj
         G/BA5nWu58pzLmid9Tdd7PREWXEsuObHZHgLZZRALQBCdmkH5l7N+vffMDlN6q3GvDgq
         yyEHAAKg+ihLtUB92T+IUruyF5o5QPnTcYcFEO9/ne3VUisdeq712NnXiDf1lqcybYFT
         6wwA==
X-Gm-Message-State: AFqh2krcwQWSWApv6CyXuVROadYkNR1vd8xye2YMIPBC2I5DFo/2sshA
        af4Pu2Jjai1pzfKNdb8acjxcQQIGZDw=
X-Google-Smtp-Source: AMrXdXvqxKrlRFU3eDZXIZ7VniVxT3C2s7LBCag2aCeQ1jeZQNTvj4KLzXpD+Z7hdY5EqwON6cUO3w==
X-Received: by 2002:adf:f242:0:b0:2b2:1db6:a6bb with SMTP id b2-20020adff242000000b002b21db6a6bbmr44545475wrp.20.1675115197635;
        Mon, 30 Jan 2023 13:46:37 -0800 (PST)
Received: from [192.168.2.202] (p5487b129.dip0.t-ipconnect.de. [84.135.177.41])
        by smtp.gmail.com with ESMTPSA id o9-20020adfeac9000000b002bfebe2d67esm5488027wrn.9.2023.01.30.13.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:46:36 -0800 (PST)
Message-ID: <1459147d-8944-b01b-6f45-65a7fb7018c4@gmail.com>
Date:   Mon, 30 Jan 2023 22:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230127184650.756795-1-luzmaximilian@gmail.com>
 <20230127184650.756795-4-luzmaximilian@gmail.com>
 <20230130210530.GA3339716-robh@kernel.org>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230130210530.GA3339716-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 22:05, Rob Herring wrote:
> On Fri, Jan 27, 2023 at 07:46:49PM +0100, Maximilian Luz wrote:
>> Add bindings for the Qualcomm Secure Execution Environment interface
>> (QSEECOM).
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Changes in v2:
>>   - Replaces uefisecapp bindings.
>>   - Fix various dt-checker complaints.
>>
>> ---
>>   .../bindings/firmware/qcom,qseecom.yaml       | 49 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
>> new file mode 100644
>> index 000000000000..540a604f81bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/firmware/qcom,qseecom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Secure Execution Environment Communication Interface
>> +
>> +maintainers:
>> +  - Maximilian Luz <luzmaximilian@gmail.com>
>> +
>> +description: |
>> +  QSEECOM provides an interface to Qualcomm's Secure Execution Environment
>> +  (SEE) running in the Trust Zone via SCM calls. In particular, it allows
> 
> SCM is SMCCC or something else?

It's whatever qcom-scm.c uses. I'm not too familiar with the specifics,
so maybe someone else can answer this better.

>> +  communication with secure applications running therein.
>> +
>> +  Applications running in this environment can, for example, include
>> +  'uefisecapp', which is required for accessing UEFI variables on certain
>> +  systems as these cannot be accessed directly.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,qseecom-sc8280xp
>> +      - const: qcom,qseecom
>> +
>> +  qcom,scm:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description:
>> +      A phandle pointing to the QCOM SCM device (see ./qcom,scm.yaml).
>> +
>> +required:
>> +  - compatible
>> +  - qcom,scm
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    firmware {
>> +        scm {
>> +            compatible = "qcom,scm-sc8280xp", "qcom,scm";
>> +        };
>> +        qseecom {
>> +            compatible = "qcom,qseecom-sc8280xp", "qcom,qseecom";
>> +            qcom,scm = <&scm>;
> 
> Why do you need this in DT? If you already know you have a firmware
> interface (via "qcom,scm"), then query the firmware to see if the SEE is
> there.

Unfortunately I don't know of any way to query this, but please let me
know if you do.

As I've briefly mentioned in the cover letter: There are two interfaces
to manage secure apps. QSEECOM (on older and current-gen laptop devices)
and scminvoke (on newer and some current-gen mobile devices if I
understood right). ACPI also uses a separate device for this
(QCOM0476), so it seemed like the best option to follow that.

Ideally, scminvoke would be preferred since that can be integrated as
TEE driver, but I've been told that on platforms where apps (like
uefisecapp) are loaded via QSEECOM by firmware, we can only use QSEECOM
to communicate with those.

Regards,
Max

