Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D5664AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjAJSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbjAJSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:33:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8624D49E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:29:29 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12633403wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RA6ekNgxx7SSbas5DiR46PtYuVSS5EoWQj2eL3S79SM=;
        b=s+BUzm1BmJTq1urhSIRTqaW/HrBWnrdjUZRyjbd8XCdtwdD4bs2wmOH7DcXZIkpj2m
         HwBBm1nPp7qv63GG+ggt4J20Z+cWTx/fQeq4HwV0V3ejgBXGGgS+EsJDOdMB0mUu9CZY
         4XtY/CLBSmp3iT8AmguSzVSu5KrMTVn/cZ1ENQjfjk1ly7/U9BXgFDFu8KAqM5Fjv/jW
         7dUl1AtaSbljVGyaB5/n7F8iHGE/XT40FPKlgg5KtMeC16XYKOHRZtxvqqgi1Uyzvb+3
         ykFUyLm98OT0HhLcNGi0GiX0QNjhpqlM8vX2amXHrnDCwi4/o9Nv/y07TUvRit5dF71h
         /44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RA6ekNgxx7SSbas5DiR46PtYuVSS5EoWQj2eL3S79SM=;
        b=IZ+PmmbIbMDBzFo1FmQPidcepcFq2ilscS3BJEPRHVuznBtSoE5nDMqmYhzqggm5aw
         pMo/vxn1Uy/xNn5cHAVyYbKICQkcqh3aQ9e7KdqkVbMnt2nlUGq0EaLtyT+xruyLz86O
         oWk2iGAevFseiiZt5AO6E0zXNQbLsKR4gVhEYPHen1as8LsajuJ0dMgbbDrTge4ZwoLE
         dEOnLHxqXUOaVuxNYUxj3WKPKAGWV9JRsnjsDPx4RtQHuR7JcK9rklPISUj9X9MAnSCe
         smS6Qz6Ui1vL1w4tfcwYfiDgU8rQXitmaLbB1giKTkibc4ATatb9k+eq50JFp+LIyvI8
         hQ7Q==
X-Gm-Message-State: AFqh2kpmEjaHB0TlovL4OHoD3+jFJ4rM30G5AiDAtJpQhCXVH5too+gv
        u519l80lGTLc+bP3i+MhHLNXEg==
X-Google-Smtp-Source: AMrXdXs7ciB+o7x92JNqbgbmOg3ruP9jwcZJaZPGOdqCunhD82y4PBXQVw7FwyAl3xR0cqRr6ndrCg==
X-Received: by 2002:a05:600c:348b:b0:3d1:f16b:30e6 with SMTP id a11-20020a05600c348b00b003d1f16b30e6mr50397222wmq.28.1673375368064;
        Tue, 10 Jan 2023 10:29:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003d9aa76dc6asm23980098wmc.0.2023.01.10.10.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:29:26 -0800 (PST)
Message-ID: <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org>
Date:   Tue, 10 Jan 2023 19:29:25 +0100
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
References: <20230110155014.31664-1-forbidden405@foxmail.com>
 <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com>
 <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org>
 <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com>
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

On 10/01/2023 19:17, forbidden405@foxmail.com wrote:
> Thanks for your review, but I don't know how to deal with such a 
> device with unknown vendor. Do you have any idea and show me
> some possible solutions? If "zhihe" is dropped, what can be a substitute?

Please do not remove the context you are replying to.

You install this kernel with DTB on some device so clearly you have such
device in hand, right? It has then some manufacturer, some company. If
it is USB stick as you said, then it has even vendor ID, which might be
or might not be real.

Best regards,
Krzysztof

