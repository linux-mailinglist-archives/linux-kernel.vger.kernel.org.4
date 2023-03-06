Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AF6ACEB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCFT7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:59:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131F65070;
        Mon,  6 Mar 2023 11:58:42 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c3so11930321qtc.8;
        Mon, 06 Mar 2023 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678132676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fcear7SkG9TmnSwIELIrY7+1NyaOV8lflIIPHX2QmK8=;
        b=WGjLRckl281DCVlHPpmlzGIN/jVrcmhh5kKLciScBCHtk+amtS/6/t4urkFbS2pA3u
         07on6PPWceK62oGnAqS7/+v+401JZJqNJB6BdVuRObXwOoLqfl/JVBiS3yGP51CqW/I2
         ZzY9hwn6PSoKgV9iNYZxZFMSZzetb4rtzLQfN2JTeg1+Qx7gM3TGDUHVJZSGANu/w4jH
         iksTOHuImXCj/V+tdhzbNGhmbtBhx2OHYXc15vI4VBYpk63ZJUcJcsVc4tdP3AN64uKj
         +mtBCAYTktuAa1f+p5xWuDHFdvrZgW8nv3WFaZtNsQiGVn6q/UPkrSr6DRxIlRcr30Iz
         JWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcear7SkG9TmnSwIELIrY7+1NyaOV8lflIIPHX2QmK8=;
        b=QPtgW46JgV6plpKS+39nbUAEaWZMwRUupjOw66CwXrVPowrKFzJkOU57tLFtIyww2T
         oh7y09NbUqDAJbUSKRcczMWLXmbvKAImdow0yNEYXmv0njV2Rqm/7g9fCJesgxOibot0
         +khq14Yqk0X8oPFfy3dsyAFs16nwn7rv/LApk9bIaZ8QbXsLKoSlrUU2ri9XYFgEiPTH
         5uMgWnYXzEHrN9deUz5CfSbGkcAMdswPg8G/1rMS8lbTXyiP0SlNnG8muBDkszCJmDJ9
         nxK8EYAnp4qjVSeUtk0h7sEej4v3xEfklVThARe2xF4+KzAbI/FxlFslvbQudhlpgKY/
         9UrQ==
X-Gm-Message-State: AO0yUKUPhTk+flBUzK9pimDGBrAVijV9VBTidWRWluZNpzhb+qq1ZlVo
        ybPxHPbIUwsETpNrDbMj6xE=
X-Google-Smtp-Source: AK7set/670uYwxALTojyHbMIdyaecZVHhjNJyQIIeA/qSS1xpmTRM60vLEXXjINc/dPl+ojNjtYx/g==
X-Received: by 2002:ac8:4904:0:b0:3ba:2b4:7b39 with SMTP id e4-20020ac84904000000b003ba02b47b39mr13795686qtq.46.1678132676348;
        Mon, 06 Mar 2023 11:57:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x8-20020ac87008000000b003b868cdc689sm8203872qtm.5.2023.03.06.11.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:57:55 -0800 (PST)
Message-ID: <738a5705-74eb-d339-60ee-6f18a08822a8@gmail.com>
Date:   Mon, 6 Mar 2023 11:57:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 07/16] gpio: brcmstb: Utilize helpers from
 string_choices.h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
 <20230306195556.55475-8-andriy.shevchenko@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230306195556.55475-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 11:55, Andy Shevchenko wrote:
> There are a few helpers available to convert a boolean variable
> to the dedicated string literals depending on the application.
> Use them in the driver.
>  > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

