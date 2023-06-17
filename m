Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B172733F30
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjFQH22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFQH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:28:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E52688
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:28:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-985fd30ef48so237296266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686986904; x=1689578904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNOXDR8ammGfhSACaL8GR+6Nt9orr8dF7n6TFf183BI=;
        b=qA+WvJ4hNQbyu/ACCtBfo8NrOiRUJJsOv2VOujI9VBUaTryLoSEHQ9Tuq9GNM9kw8b
         pYWAVBmXglKYw10E5rOfOpKqY/QmJtvyB5GWFYmzaWj/mQZqii+aHgNv62HhXgvHius2
         D7R4Ju0yD2qUzxwY9FY9zS7Z4W57zmIqnLMiKk6bM2JX85TrIeAwKJOrgskvantYq26u
         dDqDQsTcIzeyl7fpmAEOq0NrSXfH1IX1xv6TLcn4nfewHcJYm74oZP/Rx5xgmLOa1ft3
         FWFUrpsUZSmFOUe6YV9cwWvkL73ltimhmXShmLbL3mkkD1YmdpCqZYscRZn+1EoxDic7
         95Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686986904; x=1689578904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNOXDR8ammGfhSACaL8GR+6Nt9orr8dF7n6TFf183BI=;
        b=GTFkUZbgAvZ8xYeJ7NwGD2VbilnP7RfWl0ROx87XVJVtWfvNgGDkghlpm/Doqq+2qx
         sHmCgcfOZ7LMLZPk3+0P8ujXaKCLhjrevY3zW41c9AVCnhRDyu9FKgmicPowErGD+SwA
         rmmYMmMFnNR1lR3coxdAJEZRT3wxKkKH3JfF15VLzq+acbQtXoH7jMAU2wHN0MnINovu
         3HuG/d3zy5IOSA4mrk3vxOAPBZxkQ7CEv2vg6oD9LY5ODq/uCJDOXu9CyvTWbnC/+f1a
         9OrapkWwcmBwfoKNMAsByZ1CU4ibXteSa3oLGF1zOLhzPA9ULumn25N7c6vci5jckOat
         TEDg==
X-Gm-Message-State: AC+VfDzFELgF/Hep+K63d/3nBwN0zKz61qKwacenz4W161Z1wr5uTjQy
        l/XxSZH0LBUFcQ8mU/tgKRFcFw==
X-Google-Smtp-Source: ACHHUZ64pqeOFhHo+B+O2squOClmtsXC2rT2z2VNvrH1Uhz5PU02jMg1G7EMy4k5dz26C/Vc342YkA==
X-Received: by 2002:a17:907:3e27:b0:982:30e3:ddcb with SMTP id hp39-20020a1709073e2700b0098230e3ddcbmr5108273ejc.65.1686986903823;
        Sat, 17 Jun 2023 00:28:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906684d00b009828dac8425sm3713144ejs.105.2023.06.17.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:28:23 -0700 (PDT)
Message-ID: <83807d70-c35c-6b66-e7f9-521bdfc6d1b4@linaro.org>
Date:   Sat, 17 Jun 2023 09:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine
 support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-11-bhupesh.sharma@linaro.org>
 <d239ad07-fbdd-16fa-3555-5bcf33c67059@linaro.org>
 <11c3eb6c-823d-9688-ec53-e05c7bb557c5@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <11c3eb6c-823d-9688-ec53-e05c7bb557c5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 01:33, Konrad Dybcio wrote:
> On 16.06.2023 19:36, Krzysztof Kozlowski wrote:
>> On 26/05/2023 21:22, Bhupesh Sharma wrote:
>>> Add crypto engine (CE) and CE BAM related nodes and definitions to
>>> 'sm8350.dtsi'.
>>>
>>> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>>> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>> Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
>>> [Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>
>> #regzbot introduced: f1040a7fe8f069d2259ab3dab9190210005ceb33
>> #regzbot title: HDK8350 silently crashes early on boot
>>
>> Hi, this landed in the next but unfortunately it causes silent crash
>> (and reboot) of HDK8350. Reverting this commit helps.
> Downstream also references the following SIDs:
> 
> iommus = <&apps_smmu 0x592 0>,
> 	 <&apps_smmu 0x598 0>,
> 	 <&apps_smmu 0x599 0>,
> 	 <&apps_smmu 0x59F 0>;

I already tried iommus from downstream from:
1. qcrypto node (0x584, 0x594)
2. qcedev (0x586, 0x596)
3. qcom_cedev_ns_cb (0x592, 0x598, 0x599, 0x59F), although with 0x0011
last argument.

Same results, but indeed iommu would be nice reason here.

I also double checked the version of block (BAM DMA is v1.7.4) and other
properties. When I disabled crypto but left BAM DMA, the result was the
same, thus it is maybe the BAM who causes abort.


Best regards,
Krzysztof

