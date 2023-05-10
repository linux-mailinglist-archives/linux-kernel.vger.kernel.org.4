Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6A6FD821
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjEJH2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjEJH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:28:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E9576AC;
        Wed, 10 May 2023 00:28:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so75710701fa.2;
        Wed, 10 May 2023 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683703697; x=1686295697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYmd4jZ4uKJYBWkoRF0QajqwynVbLsLUJz+V+LkFPUQ=;
        b=Th/zxDObwpYwY9d+oBj/zxhDQlG7F4CuBi2drJgZzj1032Bzab1bAUgXzQHvetrN+H
         l5VVuw9Y2+OuBIxP2x0wuywFldZXvp9PeQb9kIzcEOe66tzF4XTyd8dDzDK5fL2mUE5v
         gFeXj5U6t/1wf6uHGEDfXFgHNBjh3HRpyuTnQbFw5BHTYt+CsmEmFDeH7CHNlJqNb5OE
         GHSaP9pjLcFn1VJHG0dxTZBxUFSP8ecmomta6ZOBJsph3OtZ1WpCUwjt8LDX45IGUZlm
         K8umv5ZoeE3AZyjCibBwiJ2K+HUwX2BCwRFdQNgGtdjM5DlyDH1pbsV5YOsp+//EprVz
         +oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703697; x=1686295697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYmd4jZ4uKJYBWkoRF0QajqwynVbLsLUJz+V+LkFPUQ=;
        b=EoZQ1Kw1CGkW4hdPAMgO2HL39A8KPi05QSvsR2a0uqLpSGlSVjX6tZMvzBY3RBRTHN
         iRGnbQLM1/fn1ENsXTA3tOiWYZ4NDXKTrK5d3C8S6/wBoJ//O27nbB3dciYPS9EBc7MB
         rJ9CPWKXZKl5FBmwgyfRd2D+004qkBoGQeSJ8VOCMi7tn8RLWkBt/Z1/Sr/utJNWdGsQ
         pZNudgU4MjNi99svUMEAlTM927ULJR221WbZ8G5SlTNsmzQbWjbzBFvdXuanYB/r2+jp
         6BY8a9BVemcQFTUkTMuPx8gh67srmNka8kbsTDMqsFmuczXH2N2zlkcgQD4T4HzlYSx1
         nIgw==
X-Gm-Message-State: AC+VfDwZHqwb87fDaw3+UDZ70KsPD2TWty88GeKMZA948aIbdzNn+MeN
        89fBSZFI6uwtlCOJW67uC1/UqmoL1oNsuQ3W
X-Google-Smtp-Source: ACHHUZ772AWf8qrWaquyBIknc0nHxrJ/m1rxw6lYNMpBF9RcKYGF9BojsknDe+icKsuoplASYG3llg==
X-Received: by 2002:a2e:910d:0:b0:2ac:6858:45ba with SMTP id m13-20020a2e910d000000b002ac685845bamr1672370ljg.48.1683703696886;
        Wed, 10 May 2023 00:28:16 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.95])
        by smtp.gmail.com with ESMTPSA id l29-20020ac2555d000000b004f25c1e2cf5sm464267lfk.173.2023.05.10.00.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:28:16 -0700 (PDT)
Message-ID: <af4eb7c9-52ad-4173-ec91-0d74b1ad265c@gmail.com>
Date:   Wed, 10 May 2023 10:28:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] audit: refactor queue full checks
Content-Language: en-US, ru-RU
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <20230508075812.76077-2-eiichi.tsukata@nutanix.com>
 <527bf278-48a3-1b43-a23f-dd4cbb92ef19@gmail.com>
 <53C78149-AE5B-4554-B08C-AEBBEBA1EA95@nutanix.com>
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <53C78149-AE5B-4554-B08C-AEBBEBA1EA95@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.05.2023 10:17, Eiichi Tsukata wrote:
>
>> On May 10, 2023, at 15:54, Rinat Gadelshin <rgadelsh@gmail.com> wrote:
>>
>> Hi Eiichi!
>>
>> Just one one for your patch.
>>
>> On 08.05.2023 10:58, Eiichi Tsukata wrote:
>>> Currently audit queue full checks are done in multiple places.
>>> Consolidate them into one audit_queue_full().
>>>
>>> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>>> ---
>>>   kernel/audit.c | 21 +++++++++++----------
>>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index 9bc0b0301198..c15694e1a76b 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
>>> @@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
>>>    return retval;
>>>   }
>>>   +static inline int audit_queue_full(const struct sk_buff_head *queue)
>>> +{
>>> + return audit_backlog_limit &&
>>> +        (skb_queue_len(queue) > audit_backlog_limit);
>> It seems that we should use `>=` here.
> Hi Rinat
>
> Could you provide the detailed reason?
>
> Currently queue full checks are done with ‘>’,
> on the other hand queue NOT full checks are done with ‘<‘.
>
> Looking into other similar checks in the kernel, unix_recvq_full() is using ‘>’.
Was (OR statement): `if (!audit_backlog_limit || 
skb_queue_len(&audit_retry_queue) < audit_backlog_limit)
For AND-statement it should be `if (audit_backlog_limit && 
(skb_queue_len(&audit_retry_queue) >= audit_backlog_limit))
Otherwise we get false for case `(skb_queue_len(&audit_retry_queue) == 
audit_backlog_limit)` which was true for the old implementation.
>
> Paul, how do you think about it?
>
> Eiichi
>
>
