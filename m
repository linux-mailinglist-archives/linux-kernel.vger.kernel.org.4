Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306EE723797
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjFFGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjFFGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:23:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBC1BFE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:22:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so6132317a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032546; x=1688624546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awyPqVAflJ9HW7mRusvVZFjRIMdP5oGweyBZiHENeLc=;
        b=HREL2QlbSNI55ddaivjqqQYDRAsordq18Ce41nZK8NNcZ0E+Qu0nBM6LjzFjBpOjz1
         8nc6/233uTZNDMOERCxjsLH4/n7sxno888oZ1x+W3QRY/6RcoYDr590Qju+kfa1EHU/I
         VGSJcd/umzLBH5Kqg5gd+XcKWzM/4ix6CKLz2Se1IUNDLZ0b4YMmucBI2mhIJIYeHpZy
         Iyth1qVfMPh/Gq3dTJJ9+ldDPEs3IJSXAUeocQBVhJ78pTj/GKX11zOpvHcPf6GzGD0Q
         pcd4emFAMIgNxxFMhNSYIHKh03KUpI/wTyo8fpom6B3rsSCzYBWKbS/P/aGv2/8rDVdv
         EN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032546; x=1688624546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awyPqVAflJ9HW7mRusvVZFjRIMdP5oGweyBZiHENeLc=;
        b=gC9uYeWZkrONWgO4PGwgUA9n8XMvpaSHltUPGb5+AuvfSAqxa4Bsen36XWDV8j2TJT
         B392i3Y5ithj6O30oj5vHZQgTcTn+LX4AGyTBdr/M64XaMGZ6CFsvQM7xr02v9iamhzP
         5AwzDF7s0QAr0hpV1EaRXywBuowLAbVZDt/HWzRfsCg8798MHDkY1xCS8QE2GlpNs+Vj
         CAH8uapexTxgCZJNabdYLX4s7Fp5TYgWj6ocGTfcreE4hw6oGwRzlO6Wqz8ZGh5rkmC4
         JpeVrTWTPZWhst+JQqDoqpcH2oywie1VF8cU/AKU2X7egL+yVg2aBgU5qH/1BvdGOu5n
         EYpQ==
X-Gm-Message-State: AC+VfDyxsj6/ZBM9srfUvrOn3GheXcn8Gp1XthpDBrmtKAV108OwQkpq
        ll8IF3bLDeK1cb8bmL8L2eutRw==
X-Google-Smtp-Source: ACHHUZ4lQQLCUHb0etGsOAcpL6rQaxYC2rekThP+u2yThClAae5wuLBDKidMXKm5OdkorlU2aQ+dtg==
X-Received: by 2002:a17:907:97cd:b0:973:d84a:33a4 with SMTP id js13-20020a17090797cd00b00973d84a33a4mr1234857ejc.6.1686032546349;
        Mon, 05 Jun 2023 23:22:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d897000000b0050cc4461fc5sm4622224edq.92.2023.06.05.23.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:22:25 -0700 (PDT)
Message-ID: <29b720ab-4b9f-c415-3caa-e4c1b04aa568@linaro.org>
Date:   Tue, 6 Jun 2023 08:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/5] dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2
 and pl regs
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-4-nick.hawkins@hpe.com>
 <d2232369-c7e9-c572-8528-243800f0bc08@linaro.org>
 <DM4PR84MB1927707FA782DC565C22B8A2884DA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB1927707FA782DC565C22B8A2884DA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
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

On 05/06/2023 18:52, Hawkins, Nick wrote:
>>> Remove the fn2 register and pl register references as these memory areas
>>> are now consumed by the GXP GPIO driver. The fan driver now gathers fan
>>> information from GPIO driver.
> 
>> How is it expressed in bindings? I don't see it.
> 
> Greetings Krzysztof,
> 
> Thanks for the feedback. Just to confirm: Is this comment referring to the
> content of the patch description? For the third version I want to make sure
> I address your concern.

The concern was that one of your drivers have clear dependency on other.
How do you solve probe ordering and dependency?

Best regards,
Krzysztof

