Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D6664C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjAJT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbjAJT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:26:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B37389D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:25:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso12708031wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KG+ZRdx/AOYiB34HBS6JIzEWXifHlhhKkRS2/AG8Kls=;
        b=aO6OOYOFAYcz+jNA7/5iAEQ/Fd7Sf7hD41vVsxVDhVJe9nut3NRqVio2PG0Qjqbwfq
         OYzfsPoxsN/hNOJC9/zr+cXBQ7WiwZbPNCzbZpDbGHDhWpMYhhOa6q7rWixxhLchwlNg
         pFJd28RWY1Dzh7lYHh7phTkcFJxNvLhNssZUSW9H2PH1AdRZQvJ6f2RfFuh8h5mPdM5T
         6OaWlwfd/VCVdTcqkaSIW/dWdfamTbKXV4nYJYZib8cFZl+8FSLQoazMWWpIGCvxEDZz
         1JFmjDr/wPUZRkz9ezlrF+5q/NR1pvZY6gI/ub+ByXmYNaAlgIWsi+GwcAOF8jZO0/8D
         OigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG+ZRdx/AOYiB34HBS6JIzEWXifHlhhKkRS2/AG8Kls=;
        b=Yd6yJP405IhTTzE1XHTBjoyUX8TIuI8QH3HmK3+XiceRe/Y+cgiudnqRI4Qs5k9gjA
         V5y6idKnwQTp5x7/HxEphSi+KRq844mn13n2IDO71XWZSBNpVf1qLNS7/3bx2H/ZXH/q
         mrwPCFfjHXkXiTmvlWQ3HdMbNxjpRVZr+HGnuKBjZ+0YZtRbLTaZQIxk+nH2/Vq09xq0
         TI3CRq+frg4iZjJDQyCGE8iflhQ/iATQ9HcASe/qjBtQKQ+HV4G6GoCKk8Mm4WI/G70m
         LaXpIijjWVzJnNHvXeSgtRaF7S75UeP7/P7hAIXfl7cvugYdaH9SImOC1pMB/wlu2woi
         qjlg==
X-Gm-Message-State: AFqh2krK7i8gsXGUG4A8Pecg751V48LxaJ7fdGbHsxJHeE9weWMrOpi5
        OQ/srpo82nmXWdySmhQ1n0Hvzw==
X-Google-Smtp-Source: AMrXdXuVIXPcscWYpIaTc+DxxOGWLCOMIhe4CqqanKd+UEQ5kvLOcQRNLCXuaCGlYEpO9t7/ux5wAw==
X-Received: by 2002:a05:600c:1911:b0:3d9:8635:a916 with SMTP id j17-20020a05600c191100b003d98635a916mr47086737wmq.9.1673378757980;
        Tue, 10 Jan 2023 11:25:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm17175575wmq.25.2023.01.10.11.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:25:56 -0800 (PST)
Message-ID: <0453b098-91db-1918-38ae-a7db0408460c@linaro.org>
Date:   Tue, 10 Jan 2023 20:25:54 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_235CAC16001D1C38CE7D86BF7B0E365A2105@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 19:58, forbidden405@foxmail.com wrote:
> I removed Cc temporary because I had sent them the same email once. No need
> to send the email to them again.
> 
>> On 10/01/2023 19:30 krzysztof.kozlowski@linaro.org wrote:
> 
>> You install this kernel with DTB on some device so clearly you have such
>> device
>> in hand, right? It has then some manufacturer, some company. If it is USB
>> stick
>> as you said, then it has even vendor ID, which might be or might not be
>> real.
> 
> The vendor extracted from `/system/build.prop` and USB vendor ID is fake,
> even IMEI is stolen from some other mobile phones. Seems like the vendor
> deliberately tries to be anonymous. Some people had tried to extract info
> from stock firmware and on the Internet. But until now, we have no clear
> evidence to know the manufacturer.

Then I am not sure if we want to support such devices mainline. It is
not only anonymity but simply not following standards and practices.
What's more there is no guarantee what this device is. If there is no
known manufacturer, anytime another device from anyone can claim it is
also uf896. IOW, what guarantees you have that other person who has
something looking like "uf896" actually has something the same as you
and can use your DTB?

I don't know how to reasonably support entirely unknown devices.

Best regards,
Krzysztof

