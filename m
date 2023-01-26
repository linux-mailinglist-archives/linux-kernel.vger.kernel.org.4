Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64FD67CC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjAZN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbjAZN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:29:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE66F226
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:28:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so1313928wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx1DAkubOAlYe3YKXCmyxQpUHCB1kRDO2QcQY7OYxMs=;
        b=pq+99UzAUffw0B5EaOLSqCukAfbBg5cy0Zyv114NM3mReAyn09ZzdwfeQtd1yi80Xv
         BFR4xxBW10H88OGoSlSv8cBVtq4t6lTAekNnAk9SuBFoNSejm8JJpDeJm8SXnDlj3ocU
         wa5EBXSq427FtLItR/UekrIbinAmne9P5T4n10jn8p0gKwT2Sm/PnWX5tkP2Bl2tohnq
         kEgcm6/ZipxQNzmdfQv8s8X3BX+LjHPuNhHaQdk+zE2AdCvHbx60el1HWaghGN8oGtC4
         7UXq9fmkV+8Yl5Xh7wJi07E7TGR34joBh6mqZujW6cGNp67VoS9JrBhjSsXUEQZ/HNnA
         1UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx1DAkubOAlYe3YKXCmyxQpUHCB1kRDO2QcQY7OYxMs=;
        b=lbZO3Xb5gC9ekH6MD9xUXOVXvy8TK0PlVB39tphzYr5INRPbcKjzyQnxXkpDKX7ygD
         DoATzfr8Uo1ZsYHyBxXcv0I2VoIM88eCajz6oULuhDJZUluLZa8kgU3RK7jII5RCACfM
         ihP9guc+Ov+jt8cPYsFSiEJhCLP/AQtM+LSggDGrK5X3SI9Nm5I3VOHOeNRgiT/qQpP3
         fk3HNgbPwjfmBUVehPT2kqXNiLPfPlAwqrKSJeLLiddNnokhLhm5Vk34gKLif4rfDl6b
         J5wu0z9SK5blmD7ru+djFKpcFPakUSuEUrb4uaA9QOrRQi8FSzzGRSG35QOhe9JuLZNB
         L/TA==
X-Gm-Message-State: AFqh2koBXvMST3Pn/b8amHMB1grS6wzrJyjsCyMoi9s/QGqDUF09UErW
        POFI4M1DzmceYIwiryQfWrxyJw==
X-Google-Smtp-Source: AMrXdXs/beqvYpPiPnonpjIItu1cPLPKj6Samh65jUCGRVhdi9JtDNGb0Sg72VPia4bfs/daV7+9wQ==
X-Received: by 2002:a5d:4bce:0:b0:2be:4ae1:215a with SMTP id l14-20020a5d4bce000000b002be4ae1215amr20630645wrt.16.1674739726577;
        Thu, 26 Jan 2023 05:28:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfae6b17d2sm1324488wrp.55.2023.01.26.05.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 05:28:46 -0800 (PST)
Message-ID: <22067557-5753-9bff-a060-7be587b92478@linaro.org>
Date:   Thu, 26 Jan 2023 14:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/6] ARM: dts: add mmc aliases for Exynos devices
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230126103828.481441-1-henrik@grimler.se>
 <0807a4ab-c544-2695-67d4-df9a3b1de4cf@linaro.org>
 <Y9J97CU7f5qoiO/F@grimlerstat>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y9J97CU7f5qoiO/F@grimlerstat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 14:19, Henrik Grimler wrote:
> Hi Krzysztof,
> 
> On Thu, Jan 26, 2023 at 01:22:54PM +0100, Krzysztof Kozlowski wrote:
>> On 26/01/2023 11:38, Henrik Grimler wrote:
>>> It is convenient to have fixed mmcblk numbering of the eMMC and
>>> sdcard, and with these aliases all Exynos 4 and 5 devices (and
>>> probably Exynos 3, but I do not have one of those boards so cannot
>>> verify) will have the eMMC as mmc0 and sdcard as mmc2.
>>>
>>> I also removed sdhc aliases, as they should not be needed after [1] as
>>> I understand it.
>>>
>>> [1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com/
>>
>> Marek sent the same in the past:
>> https://lore.kernel.org/all/?q=%22exynos%3A+Use+fixed+index+for+the+MMC+devices%22
>>
>> The patches are fine for me except, that these actually do not belong to
>> DTSI. Aliases for board or user-exposable interfaces are actually board
>> specific and each board should customize the ones it uses.
> 
> Thanks for reviewing!  I will change the series to only add aliases to
> the boards I am familiar with.

I think you can move all of them to all of the boards. Add aliases for
interfaces which are enabled in the board.

Best regards,
Krzysztof

