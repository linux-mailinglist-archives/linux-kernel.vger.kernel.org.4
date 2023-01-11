Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C466656F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbjAKJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjAKJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:08:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921664DD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:06:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id az7so14340433wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIsUPUecMvi/dh9D3wfPOIIQmlpkhA0BZRMglhGub8w=;
        b=aHKpFFVo0bVSeDzB7XhB2heGwb+6uMxkGNvh1Cqpp/uMqhEaP+rifSCdxDPNJO/1KW
         CbLCCUfRk3W0FvHPC9ED7++lUrqrNbBJh/E0D7MzbfP9d6CjwraMdK0gIe1O2sGpXKqT
         1FxvHPWkXe4+15NRm7fcsRmFMJ54kwoVkWepuRtTZFyaKeLIMqS9Cqw2NlQuRNExiugv
         RSi876XYEU4LI1LdYgxhEJgyZvnwLNqAEIBpPRP0nnV0YA6DxYRSxv0PhPqJI5nw1A3h
         jYQo4tLxDQPZg20PWqAAi/d70NoVv1KzT7A7O25GhLQlFBYnjGXUg+0kZOEtqppKJeny
         NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIsUPUecMvi/dh9D3wfPOIIQmlpkhA0BZRMglhGub8w=;
        b=sviwlCUPs5DDMe5RkSUYEMBqzkeLuFjU8SmGRhexyAmt7bPRGhQDaGRwSLXS282GBs
         nGhVm6krcd3D5f8UirWKwbrGJ+KlsNvhhZealyRigJXeGnuH1TgfWjAo3N+8Se3/YwbO
         EgPmxadDkfWAr7/tCWeig5mDgoOgqAv8LM34XpsPHLUIiwDJH3XM8S0Xnwee4jvk6UHg
         z8ysC6xlXKR1rBOhbf+ozRlYHyNhOJlvT3ibiDTVd5yB16g6xgSJIZRVAC0ndyLFDrSg
         1RrBezZcY7JmMbSVGQICkiq+J5KpFLCa+6BuGckUJALZWU+u0fuYB9KXr9n10bM5zyYA
         l7lw==
X-Gm-Message-State: AFqh2ko70XxL4cl8K/Al1Fm43j4yxfJJiOGSer3J53JI5XiZRdYUgFJU
        PbPbt2zlDt5w7ESy6NwlKrilDcteJdBP+ZWh
X-Google-Smtp-Source: AMrXdXvCF3wf262+zjQxBUEQMKzqK5s9WaAPtI73QRq+5GaGU6IX/GmdBavm7emM1FzWdMp8ZRilmw==
X-Received: by 2002:a5d:4911:0:b0:242:4bbe:2d20 with SMTP id x17-20020a5d4911000000b002424bbe2d20mr44433193wrq.42.1673427965879;
        Wed, 11 Jan 2023 01:06:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5007000000b0023662d97130sm13120903wrt.20.2023.01.11.01.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:06:05 -0800 (PST)
Message-ID: <3fb51f6a-84b7-c35b-d4b0-332671988594@linaro.org>
Date:   Wed, 11 Jan 2023 10:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device
 tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Content-Language: en-US
To:     forbidden405@foxmail.com, 'Andy Gross' <agross@kernel.org>,
        'Bjorn Andersson' <andersson@kernel.org>,
        'Konrad Dybcio' <konrad.dybcio@linaro.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     'Jaime Breva' <jbreva@nayarsystems.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        'Nikita Travkin' <nikita@trvn.ru>
References: <20230110155014.31664-1-forbidden405@foxmail.com>
 <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com>
 <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org>
 <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com>
 <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org>
 <tencent_235CAC16001D1C38CE7D86BF7B0E365A2105@qq.com>
 <0453b098-91db-1918-38ae-a7db0408460c@linaro.org>
 <tencent_2068AC70F1DA5AF46F600C7718FEB1B98307@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_2068AC70F1DA5AF46F600C7718FEB1B98307@qq.com>
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

On 10/01/2023 20:56, forbidden405@foxmail.com wrote:
> On 10/01/2023 20:32, krzysztof.kozlowski@linaro.org wrote:
>>
>> Then I am not sure if we want to support such devices mainline. It is not
> only
>> anonymity but simply not following standards and practices.
>> What's more there is no guarantee what this device is. If there is no
> known
>> manufacturer, anytime another device from anyone can claim it is also
> uf896.
>> IOW, what guarantees you have that other person who has something looking
>> like "uf896" actually has something the same as you and can use your DTB?
> 
> There is a label printed (i.e. ufi001c or uf896 or something else but not
> getting mainlined now) on the board, different models have different
> labels(and different board design). And currently I know all ufi001c(even
> some other models) shares the same device tree, as a downstream device tree
> has been tested by thousands of people. I'm not familiar with uf896 as it is
> owned by Nikita Travkin and tested by him. The device sells very well and
> many people will benefit from mainlining.

This does not solve my concerns. If you cannot point specific
manufacturer and model (if there is no manufacturer, there can be no
official model, right?), how anyone can be sure that their device is
compatible with yours?

Best regards,
Krzysztof

