Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6BB5B78FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiIMSBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIMSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:00:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C698D3CC;
        Tue, 13 Sep 2022 10:02:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t14so21836237wrx.8;
        Tue, 13 Sep 2022 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=zme2lWuvoGrfFBsqa9yom9/QfDJ4HQGLRNit4i2UCVU=;
        b=gb5gMEWhgM2EKjkHbhhv+6J3zPFJrpiiT64EymmpcoBssE2lsv05Vu8qX3wZqinZ0h
         BMkQzntjCT38sdMIE8n+YMkhXeTShtcllFx8kXZil898lK2ZZo9hfr1irkoN+FOmmn/G
         18s4LiPWt+uokg4vMEHkemUlSVJAK0I30L8IyXkutU9UTBD5kc7QZOlOTjXB0ioclMBh
         TyxbaEtvajMFgJJUbaJ4pZldCBNrXUllfaraMq7OdHi8BQ3LlVWQpy+BNdM1JsbGL0md
         kkbqRz/c5fyZpRYq2jqSzJB0hNci6mANsEMATWwGW0xG8Y0is54TVT/9cMMFST7Ujyt1
         Fsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zme2lWuvoGrfFBsqa9yom9/QfDJ4HQGLRNit4i2UCVU=;
        b=D5FYDvxiSfgp/T2q3zOHbRV2oY39PX4+qzDNsZukT+z574OM+1nPs9wLcaZ5TGcRTU
         Ffl+DhWvlUs7tfi3GWaQ5lsrx0OiiOTHKIyDl4nxeV1jXtsbobI+Uf80BjksKP/uIze2
         PiegU/82N7YIPBNOMONXrCCKwwCrrpM6YS6uG2iWl2kT4/cDGaTWPsOz9MV0IvB05HKR
         /v8fJff+/mxL+7sGVzZmsYpJA66nA3UPYhGQXxImGY9HA93A6InKn3wVQTZnglbytqRr
         AfNbmrKUsWHzEZLcX6InLjPsWRA2sGOaMNFowQTsRC7FqbvlyOBNBuByrvGrEi3TW50W
         BAXQ==
X-Gm-Message-State: ACgBeo1nzAKH2NmbUwdW0bs0nvM2/IO0SJwElhxNaAYsbrphFKE5qnU+
        rc75Bb/eXzgKRxcZE2A30tw=
X-Google-Smtp-Source: AA6agR7Vy7lRYafgDhqFC8YEpPO0p60Igi71WulBnX+t34itz9FoRQym/jbyQ5d8Jiv2gkoDFnAGRg==
X-Received: by 2002:a05:6000:2c1:b0:226:e816:b6a4 with SMTP id o1-20020a05600002c100b00226e816b6a4mr19498275wry.330.1663088521736;
        Tue, 13 Sep 2022 10:02:01 -0700 (PDT)
Received: from [192.168.23.141] ([212.2.175.203])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c4e5300b003a62bc1735asm14668109wmq.9.2022.09.13.10.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 10:02:01 -0700 (PDT)
Message-ID: <b7eada4f-9625-d2a0-d58b-73bb08d17cc9@gmail.com>
Date:   Tue, 13 Sep 2022 20:01:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        peng.fan@oss.nxp.com
Cc:     festevam@gmail.com, linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, marex@denx.de,
        mturquette@baylibre.com, peng.fan@nxp.com, sboyd@kernel.org,
        shawnguo@kernel.org, tharvey@gateworks.com
References: <20220913152140.iikckob5h3ecagfi@mercury.elektranox.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
In-Reply-To: <20220913152140.iikckob5h3ecagfi@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the input Sebastian!

On 9/13/22 18:21, Sebastian Reichel wrote:
> Hi,
> 
> I had the same trouble before for QMX6 system on module, which feeds
> the i.MX6 32k clock via I2C RTC's 32k output. Here is how it has
> been solved upstream:
> 
> https://lore.kernel.org/all/20210428222953.235280-1-sebastian.reichel@collabora.com/
> 

So, if my poor brains (that have been conferencing the whole day) can 
still read this correctly - upstream solution is that drivers 
controllong clock gate need to have this "fixed-clock" propery check && 
not register the gate if fixed-clock is present, right?

I think the fixed clock is better than the vendor specific property as 
it still describes the real HW. I am not really thrilled by the fact 
that each clk (provider) driver may potentially need to implement this 
as no one knows when the clocks are used in such an environment. This is 
why I feel the support would better fit the core. (Yep - I didn't yet 
read the linked discussion - I know people who are smarter than me have 
probably thought this through already).

So, basically this would require adding fixed-clock node in PMIC node 
when the 32K clock must not be touched. I hope this suits the people 
looking after the board dts files. In the clk driver it requires the 
check for "fixed-clock" node + return w/o registering the clk if node is 
there.

I guess we could at least have a registration API (something like 
clk_register_if_not_fixed(), but "naming is hard" said Rob once to me) - 
it would not only slightly simplify the drivers but it would also help 
avoiding this same discussion with the next board where similar problem 
is surfacing. This of course needs buy-in from Stephen (as does any 
change to bd718x7-clk which goes through his tree).

Finally this probably requires the binding docs changes to all PMICs 
which use the bd718x7-clk driver - and I guess that is Rob's territory.

I am happy if someone patches the bd718x7-clk + all the binding docs. 
Especially the binding docs - I never get the right at first shot. I can 
also try giving a hand with the clk-bd718x7 if no one else will, but 
that will take some time (I'm currently travelling) :( Tim, others, 
please let me know if you wish me to try looking at this.

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
