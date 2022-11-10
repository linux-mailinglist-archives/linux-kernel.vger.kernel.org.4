Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211BE623DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiKJIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKJIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:41:10 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A726AC4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:41:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so1882872lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQlbJtxtTtFxWmMUXhk5MOTPiDSsGPZ1alWy8ZgsoR8=;
        b=BwE7Oa0pEMPNBS7CTqesEg8uaUuaGxC3Jljplii9sHqvrB3pG6qa6bzn1kUPUF0+ut
         VUKr599ZX4G95/qsw8EQmET8SKFNL60AvftLCT75cmkwF82dwSuiUS99wM9pCRlDDC8/
         Bs/kD3JZ2vD80Br7uInlNuH7b+hX0EvjEchEc+P0R1mQVe5fBJZxZpwC3m73gYmHLNYJ
         ssD7Dt9LQYcVZ8h9wsKrmsUy8uFBqoWbvrcilmdZFnRYUGBg7sCF7H5EyzpxHba9KQXG
         AB3vjj9xlCIw4ytZ4NGE7izQ+qSVnJDW8YvMjD2OI0RQg2imWlgW6FzraRxepvWVd+9j
         qmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQlbJtxtTtFxWmMUXhk5MOTPiDSsGPZ1alWy8ZgsoR8=;
        b=IyDot7/FPDwk8NKEL5clAuvRIOC1+8N91p6609TrueQklWFz3qswbCKjelFl6718eC
         j0S6YJM18kiPBhUltyPhWbWD1RlweGFoBAEBKmVwmk8O5i16ntRQN7LdF3izoF/4v43z
         co9P/Rn1BxHzJhNsEW8kVg4Nz5mIPXgirA6CmzQvYsOqvUotFsntd1u49zAmdqh+zRii
         BfxcWTGiAh1iYsLf2vMIsy9NU0yod3Kyxn86yK9KLxd9DqLw5f1aw3kWgaWh8Zwak3Mo
         2qQz8gWjoJzv6IpnvJ5uJT/y3rzWxO8YGGwgzz62c5trDaNzUdVfMaWQPbbaQAM7n5qC
         wAxQ==
X-Gm-Message-State: ACrzQf10s1xlD79/kOfbPE+A9quv5leC29DCMV19zwXeLaDQu8P/2A2o
        yNTlUpJl1RmJowcJo5b1sV4dTA==
X-Google-Smtp-Source: AMsMyM6+MsI5486Mf0FfCWdvOhLPo4ijn1KYKF47ijh8WoiVUsPPjtw4lV4A9Wh+LugZFgcBW8OSnQ==
X-Received: by 2002:ac2:46ef:0:b0:4b1:753b:e677 with SMTP id q15-20020ac246ef000000b004b1753be677mr1053599lfo.407.1668069667566;
        Thu, 10 Nov 2022 00:41:07 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bj11-20020a2eaa8b000000b00277078d4504sm2600397ljb.13.2022.11.10.00.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 00:41:06 -0800 (PST)
Message-ID: <d882761a-7e8c-1c15-b469-c2ee8734a795@linaro.org>
Date:   Thu, 10 Nov 2022 09:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,msm8976: convert to dtschema
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108140909.51422-1-krzysztof.kozlowski@linaro.org>
 <20221109113334.u2jhlwqgpfubfg5w@SoMainline.org>
 <20221109204810.fyestfmom7nzgqt2@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109204810.fyestfmom7nzgqt2@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 21:48, Marijn Suijten wrote:
> On 2022-11-09 12:33:37, Marijn Suijten wrote:
>> On 2022-11-08 15:09:09, Krzysztof Kozlowski wrote:
>>> Convert Qualcomm MSM8976 pin controller bindings to DT schema.  Keep the
>>> parsing of pin configuration subnodes consistent with other Qualcomm
>>> schemas (children named with '-state' suffix, their children with
>>> '-pins').
>>>
>>> Changes during conversion: update the list of non-mux pins (like sdc1)
>>> to match Linux driver.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Thanks for sending this right as we are upstreaming MSM8976!  With one
>> question and one nit below:
>>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> I retract my review on this patch, see below.
> 
>>> [..]
>>> +        items:
>>> +          oneOf:
>>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[0-4])$"
>>> +            - enum: [ qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2,
>>> +                      qdsd_data3 sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk,
> 
> Missing a comma between 'qdsd_data3' and 'sdc1_clk', making the bindings
> checker treat this as a single string 'qdsd_data3 sdc1_clk'.

Good point, thanks!


Best regards,
Krzysztof

