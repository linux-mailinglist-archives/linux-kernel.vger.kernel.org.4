Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48D73C5C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFXBNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:13:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592126BD;
        Fri, 23 Jun 2023 18:13:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so1066188b3a.1;
        Fri, 23 Jun 2023 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687569227; x=1690161227;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XPifuwGr7qotS1J4egDcigsPGqIRoWlg/6w0xflvqXc=;
        b=os0PUm6FrKL+A1DoENP/u20TiGluWujR7+ihWm5WpvDPntOiaFqI+zagF77EPxUeFd
         gr58N43P9mAq2znfThw1PfGQKEPSYSXsYzcEoKK9A5Du4HKGvzQScblJDy/iGqZAKuWT
         a4wWxbqnCDJ7t06JAr5Z8X0hOH//fnXZWeq9NqYVRLpKrC6kx5piOAgW//ZY9LTxMEnL
         jqOhCNst0AIt7XcCt8LzYtm++QMHG2HaCRrv86PEx6ef3m7DMWmPFU5054WCk+Mv5os1
         kXSEIEH24AbdO3seGYjPXpcaT5TcOUwYnekVdahikCV0h8quKcRXl8JnajWrTwBJOX4a
         9cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687569227; x=1690161227;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPifuwGr7qotS1J4egDcigsPGqIRoWlg/6w0xflvqXc=;
        b=PBV1HigZeZkxB88zXxbYyiW2UCu4s/R/TLBwUif7/sSDF1hLnIYNOkhioT3Eu1eq9O
         WJVEMkmUyaCqJNkZS5KmECIuzjhtxMA786mgfdvujZk4OG7zJZr5edOH3IJiYzvKYLxF
         vPPqf/nbV+bLyJ4pR0ubvpBu52LNsp2/7xtYa/CDbw6u6Yq8GTPboC7BjjER1+g93XXF
         efFwJCQaEAMigK/uhC89Bsj3/JVIIgTA74Pr9aimJb6Dm/ujDs1xjUV18EhwKJn+IllP
         tdAKeHqo7CAvYWtpLnPN3FNgmaKxXiXtgSq2EonHNLs4SrHLoqr+Z2jtJvN8xaDfeXiO
         8Vdw==
X-Gm-Message-State: AC+VfDw5OYWez6HoUN96BV26uAoJwCbcsKXidG8DKEAMU8ksBgQKCWun
        vZSQ/jjR/j4J+io0hjPXPb8=
X-Google-Smtp-Source: ACHHUZ606czjila05woldXKyuDA7Rq8dbV1i+0k6tpmn1h59UzY57EaMRyDQG9n05OaV37lSyFMttw==
X-Received: by 2002:a05:6a20:12d1:b0:121:b440:2820 with SMTP id v17-20020a056a2012d100b00121b4402820mr19195240pzg.19.1687569227466;
        Fri, 23 Jun 2023 18:13:47 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j6-20020a655586000000b0054fe7736ac1sm195469pgs.76.2023.06.23.18.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:13:47 -0700 (PDT)
Message-ID: <0e85ca99-d1d6-097b-2e04-4cd6492098a1@gmail.com>
Date:   Sat, 24 Jun 2023 08:13:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Dell XPS 13 ath10k_pci firmware crashed!
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Garry Williams <gtwilliams@gmail.com>
Cc:     Linux Atheros 10K <ath10k@lists.infradead.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <2db51694-aa57-cbfd-096e-4925b76232b0@gmail.com>
Content-Language: en-US
In-Reply-To: <2db51694-aa57-cbfd-096e-4925b76232b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 08:15, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Beginning with kernel 6.2.15-300.fc38.x86_64 and continuing through 6.3.7-200.fc38.x86_64, the wifi connection fails periodically with these log messages:
>>
>> ath10k_pci 0000:02:00.0: firmware crashed! (guid 6c545da0-593c-4a0e-b5ad-3ef2b91cdebf)
>> ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:143a
>> ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 0 dfs 0 testmode 0
>> ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
>> ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>> ath10k_pci 0000:02:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
>> ath10k_pci 0000:02:00.0: failed to get memcpy hi address for firmware address 4: -16
>> ath10k_pci 0000:02:00.0: failed to read firmware dump area: -16
>> ath10k_pci 0000:02:00.0: Copy Engine register dump:
>> ath10k_pci 0000:02:00.0: [00]: 0x00034400  12  12   3   3
>> ath10k_pci 0000:02:00.0: [01]: 0x00034800  14  14 347 348
>> ath10k_pci 0000:02:00.0: [02]: 0x00034c00   8   2   0   1
>> ath10k_pci 0000:02:00.0: [03]: 0x00035000  16  15  16  14
>> ath10k_pci 0000:02:00.0: [04]: 0x00035400 2995 2987  22 214
>> ath10k_pci 0000:02:00.0: [05]: 0x00035800   0   0  64   0
>> ath10k_pci 0000:02:00.0: [06]: 0x00035c00   0   0  18  18
>> ath10k_pci 0000:02:00.0: [07]: 0x00036000   1   1   1   0
>> ath10k_pci 0000:02:00.0: could not request stats (-108)
>> ath10k_pci 0000:02:00.0: could not request peer stats info: -108
>> ath10k_pci 0000:02:00.0: failed to read hi_board_data address: -28
>> ieee80211 phy0: Hardware restart was requested
>> ath10k_pci 0000:02:00.0: could not request stats (-108)
>> ath10k_pci 0000:02:00.0: device successfully recovered
>>
>>
>> If I disconnect and reconnect using network manager, the connection is restored.  But this same failure recurs over and over after some few minutes to a few hours.
>>
>> This is a regression.  The error was not reported with any previous kernel since 6.2.14-300.fc38.x86_64
> 
> See Bugzilla for the full thread.
> 
> Unfortunately, the reporter can't bisect this regression (he only tries
> distribution kernels instead).
> 
> Anyway, I'm adding it to regzbot (as mainline regression because v6.2.x
> has already EOL):
> 
> #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217549
> #regzbot title: ath10k_pci firmware crashed on Dell XPS 13
> 

It comes out that the regression is due to Fedora patches (see Bugzilla thread),
thus:

#regzbot invalid: regression caused by downstream patch

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

