Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93C74496E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGANmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGANml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:42:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CB3C30
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:42:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7f2239bfdso22404695ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688218956; x=1690810956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIcrTyhBVMZdXfdQxOUQpBVZ5Mv9FfDAzxWay5IM0gc=;
        b=lfAebk6qMLb2dTym07ZEc12ys4pFm0B7LNEyz+Lxi0vUeX2+aOPh5059VV42OTEr3f
         cdjkKkNsbsO8Ha4N/hHSj855KFgSac8Bf41xZ/0jS4RRBTToYznQCkHZgfCb19Uggmat
         lNtXV8GdUghW65FDCMuUUGsqjXKwtA0K4X0YnmDQjVisEdMebmxlz33uYvMBj22XCG+b
         aJkESsIBdlxrf/Oexe4AKyeHX+Wpx+hnJFXuf50kwSRWjmFIZUsKrl/hiGSpg41rIJXx
         vzKsqq5G4i9TPINce4G9Os9nj2yh3YFS02nhoK17nM86LTJSVQ7LvrXy6pCCwlUELzC6
         cAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688218956; x=1690810956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIcrTyhBVMZdXfdQxOUQpBVZ5Mv9FfDAzxWay5IM0gc=;
        b=YuhwbPVnVTc2DApx5xJJUWYEiceCctioZ6KyN2j0eBAPLqU19E5coJagOYssW4T1HU
         7o+7CR+h4I1dHGSOzWJeoR8e3/7I7i5fCjsAtDCfidYhjUF1DcC4711f1y3j0DoBucp5
         zzoAHSRMt4J7ldMRDdFCUAACPYV9t1LPvb1fCsIPl397+kgmK6uZqsEtDePjZzB61qLA
         R4ARzFBWn6+Eoyf6/MEk8P39yMa9Bfw2NcttnbEzZ3JxBDFlAf8rTnqECk8bpm7KjWUy
         HsAstmXZdqfAchMcYuxb8XDPNTJLeLNEb2BMeRaETX/q/vKIN4B4+rWEYpb9lJ4h78MB
         1mhw==
X-Gm-Message-State: ABy/qLbnXjLHp2beNXb6HHAq1xoyLbeA0bFIaepQsb66DV2uFKRaXSdg
        ri2wUelpLvW3zM7U3uR+IFk=
X-Google-Smtp-Source: APBJJlEEx1xsXabB8nYZ0gjR9TuLfadUC1rA3Enfl6Gxq631rsP18fAu4/iZoH8WH+x00yLVKZHbcw==
X-Received: by 2002:a17:902:b488:b0:1b8:475d:ebf6 with SMTP id y8-20020a170902b48800b001b8475debf6mr5225629plr.0.1688218956435;
        Sat, 01 Jul 2023 06:42:36 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001b6674b6140sm12364970pll.290.2023.07.01.06.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 06:42:35 -0700 (PDT)
Message-ID: <e65bf45f-72c5-7239-6caa-609f3c9f24d2@gmail.com>
Date:   Sat, 1 Jul 2023 20:42:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: commit 9df9d2f0471b causes boot failure in pre-rc1 6.5
 kernel
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
 <ZKAboYIj6pAd9CMO@debian.me>
 <74014a7a-7d91-0854-8002-faf32d9c65e1@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <74014a7a-7d91-0854-8002-faf32d9c65e1@leemhuis.info>
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

On 7/1/23 19:43, Linux regression tracking #update (Thorsten Leemhuis) wrote:
> On 01.07.23 14:27, Bagas Sanjaya wrote:
>> On Wed, Jun 28, 2023 at 09:06:22PM +0700, Bagas Sanjaya wrote:
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>> [....]
>>> See Bugzilla for the full thread.
>>>
>>> The reporter can't provide requested dmesg due to this is early
>>> boot failure, unfortunately.
>>>
>>> Nevertheless, this regression has already been taken care of on
>>> Bugzilla, but to ensure it is tracked and doesn't get fallen through
>>> cracks unnoticed, I'm adding it to regzbot:
>>>
>>> #regzbot introduced: 9df9d2f0471b https://bugzilla.kernel.org/show_bug.cgi?id=217602
>>> #regzbot title: early arch_cpu_finalize_init() cause immediate boot failure
>>
>> #regzbot fix: 0303c9729afc40
> 
> Bagas, FWIW, there was no need for this at all. Regzbot would have
> noticed that patch automatically due to the "Link:
> https://bugzilla.kernel.org/show_bug.cgi?id=217602" in the patch
> description (thx for this, tglx) once it landed in next or mainline
> (just like it noticed
> https://lore.kernel.org/lkml/168813193932.404.2885732890333911092.tip-bot2@tip-bot2/
> earlier).
> 

OK, thanks for another tip! I was doing above because at the time
regzbot doesn't mark the regression as solved, so I had to manually
told it.

-- 
An old man doll... just what I always wanted! - Clara

