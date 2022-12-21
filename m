Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2313A6530A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLUMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLUMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:15:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311B2314F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:15:10 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so23178031lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ei2wiph6SuRSCb268ohc3SeGTY4BbHhEXYgk9wMq0ZE=;
        b=fOkt1qwQiyPyHPtxLQ/9osQZSDaOkjnadjiEydP8euo7M/ZodaIOHRLtnihPWzqHIx
         GkmmhxQTrEMfUF28TNtEMmpjdU2fFZvGVDUyd6rLD+G2lq3ESGQ+vvIFaLZ/lMclV9PF
         Zh90I4pN1TwrIBt3FNHSDIU/gy7RGWo+EaqXFAX9R82di/I6NzAbuqZ4z+YfgkRUp4jk
         T/vQVnvVcKwTJUXnkEywjlgaahRF8oaQCsqEyQF67EFc2fk1fG95OXd3ABq6lj1Z6h0U
         BeAlN8b5P6Y9jKuVi5016yudZ254mCZ+ycCFGJgF7nN+bcoON76MU+RGxcHwN132cO4X
         YxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ei2wiph6SuRSCb268ohc3SeGTY4BbHhEXYgk9wMq0ZE=;
        b=JZKrEhc8gB0SCeaOtyo7lMYQF6N1W7uIWcvUV9LTGg8FRWuvaR1ePg9IMH+DYoqPq0
         //W8AXeD9WZx4cWuwAotJSdQCbJQW3dL3jLb8xsRi7r4OvmN9SWiqUHnCNe6ArfY/c2y
         f2IfbObs3RsugDDcR1C8eJWbYzswi7l7+ZhhfmaNtsmejAaqEx3iCrOuROa8kM1vXiYI
         thNRM+hEwokZrXx8xt0aYwxqUyQwpNdqDJA6IZe2doyqhG08zqFkWVZFawoSrrIqvr63
         AZx4WxNjvy3ZCkquu9LnsCjOEeK1WGAd+lLO+O5TbwkM92ZhQnJQlk0LtUQ7c91G4+HD
         YoJw==
X-Gm-Message-State: AFqh2kqQu0WzhJ8h7id27ng5V87nWHRhBSmdY3RUj+7ZdHpP5ih865P1
        2FBl6O8ymVEdY2NvOo9PJaQHUg==
X-Google-Smtp-Source: AMrXdXvEIYapVwokYBeZ8T+UxGWSaE8AFmfC4fVrwgrdJTaZsXGiJjcvZGYGHW9hnz/52waurzdcJw==
X-Received: by 2002:a05:6512:2a8e:b0:4b6:e4b3:d82d with SMTP id dt14-20020a0565122a8e00b004b6e4b3d82dmr568449lfb.7.1671624908350;
        Wed, 21 Dec 2022 04:15:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b004b5774726dcsm1817293lfu.236.2022.12.21.04.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:15:07 -0800 (PST)
Message-ID: <18f4b0f8-a11c-a706-aafd-063cd6af9e3f@linaro.org>
Date:   Wed, 21 Dec 2022 13:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
Content-Language: en-US
To:     ty <zonyitoo@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6KfFEChA67E7oX/@VM-66-53-centos>
 <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
 <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
 <2673859.iZASKD2KPV@diego>
 <CAMmci2XoF0M81mVt8zko3D3G2oTHq0ia_nZ9CPX9Xz20j92c9Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMmci2XoF0M81mVt8zko3D3G2oTHq0ia_nZ9CPX9Xz20j92c9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 13:12, ty wrote:
> Hi, Kozlowski and Stübner,
> 
> Thank you very much for pointing me in the right direction.
> 
>> So how did you solve the comment "Does not look like properly ordered.
>> Don't add stuff at the end of files/lists."? What did you change to
>> solve it?
> 
>> for context sorting order in that file is alphabetical by description
> 
> I finally got it. It should be put right after the "Elgin RV1108 R1".
> 
>> You do not wrap at 75, but at some other place. Just put it to editor
>> and check where is wrapping (count characters).
> 
> The original message was:
> 
>>  from: DHDAXCW <lasstp5011@gmail.com>
>>
>> LubanCat 1 is a Rockchip RK3566 SBC based
>> is developed by EmbedFire Electronics Co., Ltd.
>> Mini Linux Card Type Cheap Computer Development Board
>>
>> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
>> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> 
> The longest line is "Mini Linux Card Type Cheap Computer Development
> Board", which has 53 characters. Or ... I should use the whole line as
> much as possible? Then I see why I was doing wrong. It will be fixed
> in the PATCH v5.

Yes,
because
such
commit
msg
is
also
within
75
characters
but
it
is
not
correct,
right?

Best regards,
Krzysztof

