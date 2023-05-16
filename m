Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF02D704F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjEPNZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjEPNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:25:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F3659E;
        Tue, 16 May 2023 06:25:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso5081385ad.0;
        Tue, 16 May 2023 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684243508; x=1686835508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWi01wLtIOXbHfuhqqUADsTGGpStITYjGOsZBd8BFHI=;
        b=F46T2dm5MmhIigb7SmI+F6+F24NfgjE9C5Ci92aGV0CTfTqSzrGiLkaV2ajmCg5QJh
         aTn7AOsPYxw8tqhqbj3hZ96PeYBKF1SXgKSt5Z7wEJz+XJXSwaY6/0MgaPRwEuLfBSpi
         VXbd3Vhp+lNA/dVXIcjpKiS9ERqKPWrEXc36+EC+8AruHkHD3MDvyINZ8uXd/zHSAal6
         jpaOql4Ca4m3isbkw3+mVp8JuIzDI18jR+bDoMY1oJyAo/mL/DyPsHrTW8VzlV12u3RA
         F5e+KTdz6mtg/u2kbKYAsD8dNVaYg6xausq4crFfmmBP7ykSt62TxP96GdUww8njJ8QA
         eWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684243508; x=1686835508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWi01wLtIOXbHfuhqqUADsTGGpStITYjGOsZBd8BFHI=;
        b=RgGIiW4/4VXEhY/AkQe66Fai2SW+xMK1397co/zWGNilKrQAsI/or0kYM78xoCrlXn
         5LstBHQjXWXU5cHuEXI/F+BngYtyBzY3OuzCEvNs9TtJBmEUdchOxTc5H6XM4+3Zo71F
         lMVzh7prJHjuQK+6pvIZmwVIez8f0ldmF5kBGnglRAsaPT+PS2vNfs9KhJxW4SH/sEJR
         2YRrXG8+dufmVENDrwXbuklrWoTPdrZmXBGzjg6UrAueaqjzM5U4kjVbUWOiqR79poDc
         E104uZFwj5Wedq0mIKK+Baqubjuxf6FnNw0xF5J3ZAkF8G1aawaUUVwfTBjf293PGaIK
         3ydw==
X-Gm-Message-State: AC+VfDyiNZ1f0zJU4VAbVQ3X2LrnwMVhJjStUj9Jve5dAC6W/9UJHPo8
        bVo3MRuJ5pexp74ld23nb5w=
X-Google-Smtp-Source: ACHHUZ7aBAFcHczn4rLTZMgINQxwx3tkwtYj0wUopEiBuA89F88McrE0RR+vlickR6fNAfeTbsBEqw==
X-Received: by 2002:a17:903:2445:b0:1ad:c627:87de with SMTP id l5-20020a170903244500b001adc62787demr24864570pls.32.1684243508387;
        Tue, 16 May 2023 06:25:08 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b001a1a82fc6d3sm15453358plg.268.2023.05.16.06.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 06:25:07 -0700 (PDT)
Message-ID: <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
Date:   Tue, 16 May 2023 20:24:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 18:58, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 08.05.23 11:55, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217412 :
> 
> TWIMC: a few other users (three or four iirc) showed up in that ticket
> and reported problems with the receiver, albeit the symptoms are not
> exactly the same for all of them, so there might be more than one problem.
> 
> I'll try to motivate the affected users to perform a bisection. But
> would be great if those with more knowledge about this code could
> briefly look into the ticket, maybe the details the users shared allows
> one of you to guess what causes this.
> 

Hmm,

You noted in the similar report [1] that developers involved here
ignore this regressions. I wonder if Linus has to be hired in
this case, and if it is the case, let's take a look and hear closely what
he will say.

Thanks.


[1]: https://lore.kernel.org/regressions/8941c5f2-3861-da68-06ca-adc68a37e53b@leemhuis.info/

-- 
An old man doll... just what I always wanted! - Clara

