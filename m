Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182A6A29D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBYMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:48:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116D119;
        Sat, 25 Feb 2023 04:48:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so1762843pjj.0;
        Sat, 25 Feb 2023 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677329337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBmmEZ+xj+EnxIhNUmWpzHEwWrOHRzPd3fdEYRBlMD0=;
        b=BGpzO7DxiFWqBKydS+C0BKagQQ77RMTahczeewklGp+fMpXhYJMjNwLQn1BmbSv5jO
         X33kVbDZlvz5wExkEnyOgpd5Vc9BmExqmlis+zu00bBbU6iXk7rQx8CdJd6vtKI283uR
         tdeGkGWaeHCE+RAs0TE16Drqbk2Uzy+J6n2LWwK666H2745fQ4nonwwmT5391N3kfF5Y
         bEwPzlKFh3aEr/7wm6lXmmjiC5CE6btRSf4ViKJamADBoW0mfKtLrTIdya8maZ/BSbDD
         gDjjoetJieIuQ6nLXhKKzzkkzV49hiHUR1+P94EcXE8MX0PQCqXfOqhjv+5uoITJd0i2
         pRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677329337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBmmEZ+xj+EnxIhNUmWpzHEwWrOHRzPd3fdEYRBlMD0=;
        b=vlUm8M6fbXnqMTwLvUDe6tgXSDHokUkimNqiTaTipDQkdpTeegNqXXbC2IK0KgWviW
         QbIhm9JKpqHmRrGvUNEdC0RY7Djgk4osV4hsbdRYbqiHIFcXpLOkWLwugwui5Ue6k1oL
         iAp/AEAq6MFCwRjw7uwy+3GFUzUfnYD0ZKqUHoFFZeFHOgKdTAz1LMu2TNSk+TTzeNp6
         IskS4BFl2gk73HCNCCAaQz1Hyi0Z00dcxRMYChJpwKUtB87FticX14jrB8WnW7yfv8/K
         eKrU9fUA/WkRVa/AxQTVhajkMnbq8GFNx/gaQPr85kWpowzLCaZ4ghX/ytRnZinwxAPH
         rang==
X-Gm-Message-State: AO0yUKUUK2I5iPtUDjuSMR5SPkAkc6rQ+PxYNVNcJS7sX3tf9cciLOwe
        vSOmiiXC6MAYcAybOFKHUhQ=
X-Google-Smtp-Source: AK7set+7no7Gmy+QEW5ZUFjnfS1LvswzjFD/dq9qoPDTaFwd8Nmlgl6dsCzbbQOEGvQsAVBg9l2QZw==
X-Received: by 2002:a17:902:e542:b0:19a:b427:232d with SMTP id n2-20020a170902e54200b0019ab427232dmr22324114plf.45.1677329336959;
        Sat, 25 Feb 2023 04:48:56 -0800 (PST)
Received: from [192.168.1.39] (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b00502f11f9d19sm1054166pgz.28.2023.02.25.04.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 04:48:56 -0800 (PST)
Message-ID: <473e0ac5-f12a-c66f-6696-8b7fe6e540f0@gmail.com>
Date:   Sat, 25 Feb 2023 21:48:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com>
 <76395d89-1c56-12b2-b6f7-e77603019b70@linaro.org>
 <e9da7a1e-d48f-014b-a0a7-841c77feb12f@gmail.com>
 <9a25020c-de26-5c1d-f7ff-c2dbb38d3872@linaro.org>
Content-Language: en-US
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <9a25020c-de26-5c1d-f7ff-c2dbb38d3872@linaro.org>
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

Hi Krzysztof,

thank you for the response.

On 2023/02/24 21:53, Krzysztof Kozlowski wrote:
> On 24/02/2023 13:28, INAGAKI Hiroshi wrote:
>
>>>> +
>>>> +/ {
>>>> +	model = "IIJ SA-W2";
>>>> +	compatible = "iij,sa-w2", "marvell,armada380";
>>> It would be nice to start documenting the board compatibles, at least
>>> for new boards.
>> So...how do I do that?
> Start with something like this for Marvell:
>
> https://lore.kernel.org/all/20230222203847.2664903-2-colin.foster@in-advantage.com/

Oh, got it. So marvell/armada-38x.yaml needs to be created from 
armada-38x.txt like armada-37xx.yaml.

Questions:

- who should be assigned to "maintainers:" in new yaml?
- should the old text file be deleted when new yaml is created?

> But maybe someone already started it for Marvell? Marvell SoC
> maintainers might help here to coordinate to avoid duplicated work.

OK, I'll try to add it if no one is working on...

>
> Best regards,
> Krzysztof
>

Regards,
Hiroshi
