Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A189974617B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGCRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:35:28 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21ACE;
        Mon,  3 Jul 2023 10:35:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b5cf23b9fcso4082352a34.0;
        Mon, 03 Jul 2023 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688405723; x=1690997723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0NL0ySbb2Xb/iRrjprrBD36mGMRGbHoN4gFIm7bPFVI=;
        b=l/q+U9ng/s84zKLFLt/NEsWSK4cDVHoctXMiY7noTh3ya6AgR+A1BogdSFRHbzBikc
         IgUgMYkCAeTP3bLu2mQWyZTtqWxLTsDnmDVSxCSBMN9CsisJyhNTnesQUywc2hx4lLd8
         9dPMdOD9qkrA4soKVJJtrDmUQ1xX/7ceF3z3U2CcM8xggiZScfea4fP2814fIxFsWKzh
         UrXBQ+XDh+bFyI4kdNJrzDezZ0w+MQ1q2gw5STIGmpEC5TgY6d9iNlT0nXKywmk3PEzc
         6ZA7jbB4QizTylp8kclYcqvKm16ZaeHihFMAotzYW2Q+lt7jISZzquRhN3GAmXBot16K
         9nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688405723; x=1690997723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NL0ySbb2Xb/iRrjprrBD36mGMRGbHoN4gFIm7bPFVI=;
        b=K6TPuzngjk8ZuEzpVyN1B2YqZl5WY2GCw0iVfKn1DBl2TQIzOgbLD2vjM0s2vXsDO/
         RC3qZkUx4Jb6nVBZdyaHShhwCIzInUdWPtI57usX2H17dVd73kGK4F0JOSAi2+D5zWYQ
         /LuKfPFh43sqUi1WLNiGbVSOZaK/TsLrHMwFqcNr7TzCl0Vtm4cNr8nMx1GMxxIsdMjl
         YOhtcxGJGWk8A1su36b2Zn7sqx6Cx6dARO1DEqNHmjAoDLUtW8e4fHOFPIehSHVQ3nYd
         hCaCfllQ00RUvqM4GVG45UZcUNyOfo48NqXewOfclrPhEekVtkhEDZ0t3naUyM1k+y4c
         h1lw==
X-Gm-Message-State: AC+VfDzKG9V9/V0BTz7RFxuj2sQ85eRTmwUKxB3zMXvJYZpG1FaTLHs0
        KWifcchmfw9MO9vN72q4/po=
X-Google-Smtp-Source: ACHHUZ7oyJiF+8yO1ePhexm7fnkxb2DJ13EXS5+5fp/AffHM6v7o1c6Q1bnTRCVRr2PWByVMjWj/jQ==
X-Received: by 2002:a05:6830:10c4:b0:6b8:8f8f:3f4c with SMTP id z4-20020a05683010c400b006b88f8f3f4cmr11485107oto.26.1688405723530;
        Mon, 03 Jul 2023 10:35:23 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z6-20020a9d7a46000000b006b8ad42654csm2974673otm.0.2023.07.03.10.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:35:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <89429625-5b5a-d0d3-ae82-0b7204262980@lwfinger.net>
Date:   Mon, 3 Jul 2023 12:35:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Sardonimous <sardonimous@hotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
 <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 16:33, Sardonimous wrote:
> 
> On 6/26/23 10:21 AM, Larry Finger wrote:
>> On 6/26/23 07:44, Sardonimous wrote:
>>> If I were to send you some test patches, could you create a kernel with them 
>>> applied?
>>>
>>> Doubtful.
>>
>> Sardonimous,
>>
>> OK, that essentially eliminates  getting DMA to work. The cost of a 
>> MacBookPro7 is too much for me to acquire one to debug that issue.
>>
>> On my PowerBook G4, I also got the failure to connect, thus I should be able 
>> to fix that problem, but getting a new kernel with the fix onto your machine 
>> will not be easy.
> 
> It might be possible to follow the arch instructions for patching the kernel
> 
> https://wiki.archlinux.org/title/Kernel/Arch_build_system
> 
> It takes about a day to rebuild the kernel following this procedure.
> 
>> Is it possible to ssh into your machine, or to use TeamViewer? Those questions 
>> do not need an answer now, but think about them.
> 
> This is complicated by being in a CGNAT environment.  I usually do this via 
> tailscale.  Will have to think about it.
> 
>> Larry
> 
> Should pio=1 qos=0 cause the problems that it does?  It if is no longer a 
> supported configuration, perhaps it should fail more gracefully.

Sardonimous,

Sorry that it took so long to get back to you.

For my ppc32, there is no regression. It took a while to learn the pio=1 and 
qos=0 are BOTH needed. That I do not understand, but with both set, the device 
works with kernel 6.4 and all earlier kernels that I tried. Fortunately, I did 
not need to do the entire bisection.

I am working on eliminating the warning that appears with qos=0, but it does not 
inhibit operations.

@Bagas Sanjaya: Please mark this "regression" as invalid.

Larry


