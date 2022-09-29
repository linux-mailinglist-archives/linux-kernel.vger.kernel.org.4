Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26215EF13F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiI2JFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiI2JEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:04:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0F4F38F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:04:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so1268385lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=S2099XaXfCuuAEa+EkneFK7QD5CrN3fKCdlOcqsOw18=;
        b=hbhdVoTcAXobyz/snHuBU9Vq2yj5nx2bcdbw6NcumzV1mpq7WaUx5JOCt5wBPiBZxS
         TXqJl1ac4r3n8/utB87fHGhysDkma8nyB4BdlUVom3ScbeNpdDvxlQCs0eMFy5kE19h/
         KE3hxCNj3V4bOhP+zE0tD9+psDhbYTOQTUd2QwwkB8JLMNlAgvws6XGBi4gela39OD/S
         8+p5E2gb9gWTdwrsKjzKwVBxlS8Jo9vVpHlD7LjVIDdO21Gosu++yaPOpqKAJE5WkV+3
         juQdb33sDtuEX70lVch0XaQnEYGdrmxJaQNQ2qWofWn0ZuZrKpG18u1kuWCwpUXJciHl
         Td3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S2099XaXfCuuAEa+EkneFK7QD5CrN3fKCdlOcqsOw18=;
        b=rIATgokPb5aS0KN32xyVDcs+vsiDqf+KNLKF2Mw9bprqWvTCveRPjlPUUgpHnyzwSL
         R2F/burvm8CWK4SAi9/M0YHyZch+i3hPrEm9CAspYemcb4q3LqGKCAMnfUsWExWwomSL
         9jNdFcCeSEHcJGzhey6UEZdG+ILPIfKJZ4VK7DiVIn86IwLggX35IUOV2p5kDN/4ETne
         eAuMsSQeAiUWc+QT8dEWdyP44L06OR+eVN6xjwvmUqyrbzKUlSfz/PxLdVIv2iHDIGcj
         /PkVtrYNa7gwh1/TD5nV+3xhuGD9fEXM+8zXAGpfXW7zLrTRMrQs0efM20aAs8PuZUa2
         cdCg==
X-Gm-Message-State: ACrzQf3Oj48PpiTcjTCrLaWedINrq5rGtQSAHLKlB2WeOWom9cJq6XWV
        Qqqy/zs17vz4p47PyDRAD8GW7g==
X-Google-Smtp-Source: AMsMyM7UcjZPLFuyJE1sHm95uLmVltxGRI/vS4Co/MQ3JaN8fHbz4H6ktZMf2y/YUd6Dm+KqXUlPYw==
X-Received: by 2002:a05:6512:3983:b0:49e:2ef9:8375 with SMTP id j3-20020a056512398300b0049e2ef98375mr976538lfu.678.1664442282493;
        Thu, 29 Sep 2022 02:04:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t3-20020a056512208300b0049486c66140sm728740lfr.119.2022.09.29.02.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:04:42 -0700 (PDT)
Message-ID: <06fa0bd2-c447-d705-01be-791207a4be8a@linaro.org>
Date:   Thu, 29 Sep 2022 11:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
 <20220928083702.17309-2-zhuyinbo@loongson.cn>
 <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
 <9b2f2d43-981d-3ffb-7526-dc3e58a9f367@linaro.org>
 <f0946817-cc2c-449b-d93b-0dd94a0f51f1@loongson.cn>
 <ed762d71-7104-b1ad-009d-51c1a4407472@loongson.cn>
 <9b62594f-7473-9974-8ab3-4c93aae5fa64@linaro.org>
 <abaf9b69-487c-0f1e-7a94-201155f5e3d2@loongson.cn>
 <f54a40ea-99bf-e341-3bbd-851b250cc9cd@linaro.org>
 <a205592c-9e5b-0cf2-88d7-aabe0bdcc2ae@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a205592c-9e5b-0cf2-88d7-aabe0bdcc2ae@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 10:23, Yinbo Zhu wrote:
> 
> 
> 在 2022/9/29 下午3:45, Krzysztof Kozlowski 写道:
>> On 29/09/2022 09:07, Yinbo Zhu wrote:
>>>>>>>
>>>>>>> ... and please test your patches before sending :(
>>>>> You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
>>>>> Need fix that warning, right?
>>>>
>>>> Yes. You said you tested it but then sent with an error... so it's not
>>>> really a testing.
>>> sorry, I did do some testing. but I think It is okay that can generate a
>>> dtb  without reporting an error when compile yaml file, in fact, I
>>> ignore the warning,  I will fix it in v6.
>>
>>
>> Do you also send the code with warnings reported by GCC? Judging by
>> number of kernel test robot reports, it could be. So just to be very,
>> very clear: do not send any code which generates any warning. For GCC
>> this means W=1 builds.
> I don't find about the warning about GCC when compile yaml file.
> and I dont't know the meaning about W=1, you said about "W=1" is to execute
> following command to compile the yaml, right?

GCC is about your C code. You were sending patches knowing that they
have warnings. It's not good. All warnings must be fixed.

Best regards,
Krzysztof

