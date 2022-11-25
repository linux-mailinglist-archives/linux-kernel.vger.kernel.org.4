Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1B638596
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:52:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EC1F2DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:52:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so5881277lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HOoSTuq4XmGVlN86fKAOkleTlxcvh89psdCg1LMg4A=;
        b=xVID0zJQJp2QJkmW1SBo32zh8XH3xzkv8aG8WeB96TzyJI45ZN8ROc4yikA+WlfIQN
         YyIXuVTCii3kyRz0MzUiFJkPtWFp3OSIoMcY+xY6bX/spvJbiHZjhTZ31geefUTYZaKu
         9prcSyg5At5TqqA6ZDHeBr16S13v/28Jipge+rEqVwMZjZYR+DkWKtTc+lN7WNvNuivO
         CSlDphVEdhoaW3N2m6mUg8mLGMCOIXVZ9w3N80Cwwctel85dPOwdX6IDsvlyvqOzmTuv
         ROPNdfwidvk4XXRFmBoIWpbL5H3G6YblZCZiLyVWpytqTSCBPNLuZCjWrgGX05b6RKel
         q5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HOoSTuq4XmGVlN86fKAOkleTlxcvh89psdCg1LMg4A=;
        b=But20/nmV5c8YWoqQT0O066oKc0PeTphkrjSCthgDS9yPmuvXTPNFVPr3cnY9qHHYm
         D/n6KNr7S8PPAksSgAtqrW/ZCtNiEdy9h4JWRkoLawjBYsvzue8KQMzjqWEr1SWfsHZi
         DRh6zGSjb2suXgjbfX5wCT2pbQydaByYRHzoQ9cFZ85enmkufEK7BZJI29elOJQrfrNH
         0Qo9M/Q8odOl1R52bLawQ0QNZw1W/6xvmJiENbbQVFAA/mo7SH2S9b28udHxLm4BrDkY
         PRpq77Dde5xlbejCxvWzaxTkR5T/kIQh1MtemrFR10z9Ulr1BZk4CcLvvEyJhLMGlb29
         r63g==
X-Gm-Message-State: ANoB5plmiAp+bICNONQptmZuxKQXNxDVNna7baY8wV2AjvuF+UKkbyt+
        bMgYAUiXLALfiNLc2thppDRLxg==
X-Google-Smtp-Source: AA0mqf5hdKwX1Jr/0xm1ekWXXWPH7sNyiUXb+ircocZn1YbXicl7J/ecMU+IwqFeLH/p3Uc4Rr4QNw==
X-Received: by 2002:a19:381c:0:b0:4ae:d4db:9f89 with SMTP id f28-20020a19381c000000b004aed4db9f89mr8034920lfa.174.1669366373160;
        Fri, 25 Nov 2022 00:52:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a4-20020a2eb164000000b0026dd24dc4ecsm294276ljm.82.2022.11.25.00.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:52:52 -0800 (PST)
Message-ID: <7f5cf3d8-4a3b-41eb-fed9-1ade4ba1e4e2@linaro.org>
Date:   Fri, 25 Nov 2022 09:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ARM: s3c: Fix a build error after the s3c24xx dma driver
 was removed
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel@pengutronix.de,
        linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>,
        linux-next@vger.kernel.org
References: <20221021203329.4143397-14-arnd@kernel.org>
 <20221118215401.505480-1-u.kleine-koenig@pengutronix.de>
 <f0425349-d965-0a40-0672-27dfbe45eb44@linaro.org>
 <b759a3e7-7a45-3dc9-14ba-8b01da798f10@linaro.org>
 <20221125085117.23p7yv6wgo6b5l3v@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125085117.23p7yv6wgo6b5l3v@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 09:51, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Nov 20, 2022 at 12:22:31PM +0100, Krzysztof Kozlowski wrote:
>> On 20/11/2022 11:31, Krzysztof Kozlowski wrote:
>>> On 18/11/2022 22:54, Uwe Kleine-König wrote:
>>>> The linux/platform_data/dma-s3c24xx.h header file was removed. It didn't
>>>> declare or define any symbol needed in devs.c though, so the #include
>>>> can just be dropped.
>>>>
>>>> Fixes: cccc46ae3623 ("dmaengine: remove s3c24xx driver")
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>
>>> The file was not removed... or it should not have been yet. The s3c24xx
>>> dma driver removal should be part of Arnd series taken via SoC ARM.
> 
> The patch enters next with the merge of
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
> 
> Ah, the patch that became cccc46ae3623 (i.e. patch #14) is part of a
> bigger series. Its patch #1 removes s3c24xx.c (which you pointed out to be still
> broken) and patch #2 includes the change I suggested here.
> 
>> I think that commit should be just dropped instead.
> 
> +1
> 
> BTW, cccc46ae3623 is included in next since next-20221107 and breaks
> (at least) arm/s3c2410_defconfig. So I would consider reverting
> cccc46ae3623 a fix. (Added linux-next to Cc:)

Yes. The build failure of next was reported already by kernel test robot.

Vinod, can we drop this patch?

Best regards,
Krzysztof

