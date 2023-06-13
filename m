Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5272E321
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbjFMMeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjFMMeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:34:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4912A;
        Tue, 13 Jun 2023 05:34:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3a9eae57cso21273975ad.1;
        Tue, 13 Jun 2023 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686659651; x=1689251651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP+Due+xcyqIxukkDpwNVEnKW4STGnTfS6nfAuPAL7A=;
        b=K5Hgc5DtBQxj/Wa0tw+WCvTlqVB4Zy0xqsybX/soQJKUdE9XUxnmYc6jAEZDC+D+kv
         rP6MZgMiUCBX/IqOG9YNzXPMcHTjAKYuJjHQYKxPtPgOkPR7jiuSZ8WqUHk4RDRllz+G
         YVibJO86wbHDIIRgnoFO9ZCDNl/BiD6cGFmkrEvp/e2EucBN4xFWeMGjfAxjpAt6ICR2
         McwlcwOvYlnz+TFHV4Ty6ENwA9pz/Xx9eNSyo8G8Lpy2ijrKm419JpdsqQzyIwjWG+Ck
         aNKoFqxAviTzM0pq2z1Pp+zXK0Cn0RjMegVM4xnYBtSghWSRIE8Vu9aZS2DN/zCaXsbu
         fEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659651; x=1689251651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP+Due+xcyqIxukkDpwNVEnKW4STGnTfS6nfAuPAL7A=;
        b=i/4hWXFbvIOQ3Lwg3AElFDil7l5UOq/SFRHnRKxvq5AvQR16tmjaT+qwsII6/40YYt
         3ysd6o4sT2h4DZBkLiEPHerS9qti/AF+uXBYD4ST7cM5BFh7vjhgCJUA/0MgzSJpNXH1
         8Jma197n4GgdTrL8zdwxeG2Na+LBDbwjZNKj8YH47ebltdC2TqlwtXTaDhizthy80+6+
         Fd75M/SleCjuNRZ3LQi/OJfw2KPi6d7vJ3X+uLELRgd8vQLhFp1sO7zX873K6bsAEHYY
         3FGcAHIRJR36W6/dPT3QOLHBXN5/Gow2Ya/mdl8RtOjv73MXoTiooW9zzAE4mIllz+kG
         LHYw==
X-Gm-Message-State: AC+VfDwaBnNilBC+BkPbgIgc4Tm5NBfuJy4BW/G/IOv5/KM1vD9z4eJg
        C8bCjblQuG/DEHriprMmZgc=
X-Google-Smtp-Source: ACHHUZ4v6H6sU9pazv21wT5eWDXGnYMmbYn0txyL9zLNvU8fNrhm6cJKV6BDUeH1nkQ86+nsg4sZPA==
X-Received: by 2002:a17:902:ba83:b0:1ac:820e:c34a with SMTP id k3-20020a170902ba8300b001ac820ec34amr8613810pls.0.1686659651235;
        Tue, 13 Jun 2023 05:34:11 -0700 (PDT)
Received: from [192.168.0.103] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b1f991a4e2sm10192514plb.20.2023.06.13.05.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:34:08 -0700 (PDT)
Message-ID: <f5bcc9d5-2022-8c28-b84c-806e9c9d1d20@gmail.com>
Date:   Tue, 13 Jun 2023 19:33:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: w_scan hangs on 6.3.7 and does not react on kill -9
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Kalamlacki <kalamlacki@gmail.com>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <67afa974-835a-77cc-d4bb-49cba0ff5bf5@gmail.com>
 <cc577237-7814-0bea-a152-8acdea844088@gmail.com>
 <98909a2f-cb55-b732-409c-ad14c802bf13@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <98909a2f-cb55-b732-409c-ad14c802bf13@leemhuis.info>
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

On 6/13/23 18:59, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> 
> On 13.06.23 13:23, Bagas Sanjaya wrote:
>> On 6/12/23 20:52, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> w_scan tool on kernel 6.3.7 hangs so badly that it cannot be killed by kill -9 
>>>> I tried also w_scan_cpp 20230604 but it also fails I have 2040:8268 Hauppauge soloHD device as reported by lsusb. During reboot of the OS it prints a lot of kernel errors but it is after syslog is killed I guess and in syslog messages I do not see anything. On default Debian kernel 5.10.0-23 this problem does not exists.
>>>
>>>
>>> See Bugzilla for the full thread and attached dmesg and kernel config.
>>>
>>> Lukasz: On what hardware you have this regression? Also, it is really
>>> helpful if you can perform bisection (as outlined
>>> in Documentation/admin-guide/bug-bisect.html) to find the culprit,
>>> when developers can't figure it out by inspecting the code alone.
>>> Last but not least, please also try latest mainline (currently v6.4-rc6).
>>>
>>> Anyway, I'm adding it to regzbot:
>>>
>>> #regzbot introduced: v5.10..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217540
>>> #regzbot title: w_scan zombie (unkillable) on kernel v6.3
>>
>> Another reporter on Bugzilla with similar regression as this one had
>> bisected the culprit, so:
>>
>> Hyunwoo Kim: It looks like this regression is caused by a backported
>> commit of yours. Would you like to take a look on it?
>>
>> #regzbot introduced: 8994830135b38b
> 
> TWIMC, revert for mainline already in preparation, for details see:
> 
> https://lore.kernel.org/all/23d5f9d6-f0db-a9af-1291-e9d6ac3cd126@leemhuis.info/
> 

Hi Thorsten, thanks for additional discussion link. Telling regzbot:

#regzbot fix: Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"
#regzbot monitor: https://lore.kernel.org/all/23d5f9d6-f0db-a9af-1291-e9d6ac3cd126@leemhuis.info/

-- 
An old man doll... just what I always wanted! - Clara

