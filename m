Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF62618DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiKDB3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiKDB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:29:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7023BC0;
        Thu,  3 Nov 2022 18:29:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k59-20020a9d19c1000000b0066c45cdfca5so1943880otk.10;
        Thu, 03 Nov 2022 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hEBcm7p0xk0vESKY5HMmcIQ1ZPd78U69LjZYilp5ZvY=;
        b=Pb2zE5wb9T8ZmbLdpFiq0pbJ6TqqWlXl6LfNuGToF7QPZIAM9F6PFT1kNz5mKEaz7m
         /7fpuEZncuNyDVN6Mz7ZF2u/AGExF8gTTpB+pBJwMvjj8zPGzF4aztARjLH9/v1vD6xg
         n3b6c7PbLwLElQf9fmOv3INGXzysh7XYO6M92aLB20UWsmJ4dTRB1j/r8r9Z8YxE7ZvM
         h0FkzdTMRWq/gPtbed5yanW8kC/fyIkx5IUL7EGoG2KpvBYgMo8LH0QdbfgaS8Gry4kC
         GYlAtQia/T94X/SPPTq41EovaASXT6aHThCRo+4jFH1gh4nGZWAvVmep8zerT5bwEoWJ
         G0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEBcm7p0xk0vESKY5HMmcIQ1ZPd78U69LjZYilp5ZvY=;
        b=qE/Gf6/JxowdUb3KRG/i/OjT2mDK2RcwGKI5jCxNpKdfaUImzFqgQ5wssvZebPWZ/l
         IKDv+zFFU+POS6HfuSGQyIdfSNxUDa3sVkwybjK95yPKQYh+w41ketyu7ldyzlkRrnxw
         3jcNa/eBIdFurcIRMF9YqkcTIP32Q03Dq8j6KrMRUyVIsNHWaDhOwfzxsoapGkhCtE/x
         sMAOwuHR0c37JFIr2a8oI9BopvU1ki8zctS6T5q4iwriYNVx1ewgFnjibMZUDg9dBu55
         +3hCRe4Yo9wSVCLn89h6HhFg6s8EwbgPeoCz7ngp4X2kCo4WdJFG3fC2tT6T2RqAoZ55
         uPwQ==
X-Gm-Message-State: ACrzQf0Kxt6NQIlEf6k/4XKvPAl69nOGV/5xE55voTtsK2rX54GKZUpF
        YqyKlXC6NxJTiISwLJuTMKMMCleAz1U=
X-Google-Smtp-Source: AMsMyM6y5GVnuXfGrm2metk15WUXK1msAbHLxndz4/CLs+lK3Plzi6VEJdfvsMXRCeJudqxqzmAJpA==
X-Received: by 2002:a05:6830:1605:b0:66c:55c2:8780 with SMTP id g5-20020a056830160500b0066c55c28780mr12107516otr.378.1667525341519;
        Thu, 03 Nov 2022 18:29:01 -0700 (PDT)
Received: from [192.168.0.158] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r69-20020acaa848000000b003509cc4ad4esm977548oie.39.2022.11.03.18.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 18:29:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <0c0773ed-8a16-3082-0b13-38ed37058f44@lwfinger.net>
Date:   Thu, 3 Nov 2022 20:28:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: rtl8192e: Fix divide fault when calculating
 beacon age
Content-Language: en-US
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20221103200507.14304-1-Larry.Finger@lwfinger.net>
 <2c51855b-cd74-5701-d9fc-ad75818e7c28@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2c51855b-cd74-5701-d9fc-ad75818e7c28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 17:01, Philipp Hortmann wrote:
> On 11/3/22 21:05, Larry Finger wrote:
>> When the configuration parameter CONFIG_HZ is less that 100, the compiler
>> generates an error as follows:
>>
>> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtl819x_translate_scan':
>> ../drivers/staging/rtl8192e/rtllib_wx.c:220:57: warning: division by zero 
>> [-Wdiv-by-zero]
>>    220 |                       (jiffies - network->last_scanned) / (HZ / 100));
>>        |                                                         ^
>> In file included from ../include/linux/skbuff.h:45,
>>                   from ../include/linux/if_ether.h:19,
>>                   from ../include/linux/etherdevice.h:20,
>>                   from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
>> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
>> ../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero 
>> [-Wdiv-by-zero]
>>    261 |                                    (jiffies - network->last_scanned) /
>>        |
>>
>> In fact, is HZ is not a multiple of 100, the calculation will be wrong, but it
>> will compile correctly.
>>
>> The fix is to get rid of the (HZ / 100) portion. To decrease any round-off
>> errors, the compiler is forced to perform the 100 * jiffies-difference before
>> dividing by HX. This patch is only compile tested.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> ---
>>   drivers/staging/rtl8192e/rtllib_wx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c 
>> b/drivers/staging/rtl8192e/rtllib_wx.c
>> index da2c41c9b92f..7013425102dd 100644
>> --- a/drivers/staging/rtl8192e/rtllib_wx.c
>> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
>> @@ -217,7 +217,7 @@ static inline char *rtl819x_translate_scan(struct 
>> rtllib_device *ieee,
>>       p = custom;
>>       p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
>>                 " Last beacon: %lums ago",
>> -              (jiffies - network->last_scanned) / (HZ / 100));
>> +              (100 *(jiffies - network->last_scanned)) / HZ);
>>       iwe.u.data.length = p - custom;
>>       if (iwe.u.data.length)
>>           start = iwe_stream_add_point_rsl(info, start, stop,
>> @@ -258,8 +258,8 @@ int rtllib_wx_get_scan(struct rtllib_device *ieee,
>>                      escape_essid(network->ssid,
>>                           network->ssid_len),
>>                      network->bssid,
>> -                   (jiffies - network->last_scanned) /
>> -                   (HZ / 100));
>> +                   (100 * (jiffies - network->last_scanned)) /
>> +                   HZ);
>>       }
>>       spin_unlock_irqrestore(&ieee->lock, flags);
> 
> Line length of the description is to long.

Addressed in v2.

Larry

