Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FA6B66F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCLNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCLNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:47:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CB2B2BA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:47:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so7571243edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678628859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Icoi3sgs1OSGfCrQlXn3HpafJfSEzKy93f0un4YDkDo=;
        b=ZRZ0ubtCMWBWGSmyqsep9DaxJZtq+u77ts7HoKkf0lWXNcNomQ98FOSBWDYqkjLkpo
         p3ihl4eqqWEQFzetDjYzDQYQ9Hysls+LjA0bWj2Gt1jgugzpWHjr0qNJj+eL2kqYovV2
         hauEoU8FLnEQETz3+MaK97kP/9DnvjPIvBIDeXXLAugJBIuwBUwx5DEvXdxg+X3ReOQN
         0Gw2ZIA2uXCMz6mZsjxoGKMQebaVxfXvz5kNapeOXQMiWOvVtoD8+w97Fu3n7ZrwzXa/
         YQ6KSgjPdpFIIR1K29x/FlYAJpyusiZZWUrCtDGw7AE+GMAOoaaE0s79n2tc9dvzctRh
         dGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Icoi3sgs1OSGfCrQlXn3HpafJfSEzKy93f0un4YDkDo=;
        b=BGMDVXvnFSSuq5KjcLDfD/qMDB7fcSBYYyIGVKWHjhnrJfHl4jatsykvJDLsOTMdlf
         ktd+f8H0UH6FtkinS6x6OdAPe2+O1VQ6sJlma0+xa9sLuZn473yLoku1gtUJB3VvMo2p
         cu71R+3EbUCoxBEznr/oVpjrgugXNSlSftGdvxBalbBgzbt4oQkU0QJvOCUT/WkKNmp+
         6Mia2ctIUV8FPFYEsQNIFjh+b+SmGXhU/Rej+GRm7BTPZ2EuxX2DcwQsWlGoR3PJ8iih
         tA4U0+Ajxsw+/jb68k99ggMbSGAQItlFf7zOcwC6QZYv4wqlHqZjBXocJbthZR7YYpNt
         xP6Q==
X-Gm-Message-State: AO0yUKWzHjQhS6XCRBbq3jjWsaPd402CUG9Adv8mNR1dYTGeXzgjwUjT
        iPC88uFybsJOdkSSpzojQO53cLFMWvsEEKuJcEc=
X-Google-Smtp-Source: AK7set+1xK1uONKIghi8hrKPFFaXbpKQv6Wy4cZt5hKYhevvoavbYOarVt4AwomFSc4gi4m81mlgwQ==
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr39929837ejc.75.1678628859714;
        Sun, 12 Mar 2023 06:47:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm2261019ejh.179.2023.03.12.06.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:47:39 -0700 (PDT)
Message-ID: <3fefcfd9-5783-3f83-da30-c14196958c0b@linaro.org>
Date:   Sun, 12 Mar 2023 14:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] pwm: rcar: drop of_match_ptr for ID table
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
 <20230312134647.kmjcbilb3puumcu6@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312134647.kmjcbilb3puumcu6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 14:46, Uwe Kleine-König wrote:
> On Sat, Mar 11, 2023 at 06:37:34PM +0100, Krzysztof Kozlowski wrote:
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it might not be relevant here).
>>
>>   drivers/pwm/pwm-rcar.c:252:34: error: ‘rcar_pwm_of_table’ defined but not used [-Werror=unused-const-variable=]
> 
> The commit log text sounds like a harmless optimisation, but the error
> message here either means you're fixing a compile failure, or (and?) the
> patch was sent out before the commit log was finalized.
> 
> Looking at it this is the error message that triggers if you compile
> this driver with OF unset. I'd like to have that mentioned, then the
> patch looks fine. Ditto for the 2nd patch in this series.

Sure, ack!

Best regards,
Krzysztof

