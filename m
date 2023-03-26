Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020F6C951A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjCZO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:26:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960D5FDC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:26:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so300504wmo.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679840802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pNoDyjgbswOmadwshB/0yv76Mq66PdLAH2h39TGl1A=;
        b=BPN1GiOck8x21rj/trG+6jz+pFyCgvzlzbJ6G1ugM3k3IZGE0Ez/Z3ycxZ5CLZbh3t
         20BsVt3vNKW7Is/QV7VHibhxdbkARPxoJHA13+m/VwsGfCokL8HsV5Jr658ylSBYbgKQ
         Xt9re8nHsCyOyaadBlz7RUqRe1VEnnaJZBSL1gd92mrVidfrJH+h3zCmenQaYMac78cR
         5zdDdUHqgAItsJkGs/dRfGD8Kw5VIPLqHFQ5bS69V4/GVIbqUXybUFnH0smn+Z6VPuID
         lXiW1jqKAN4HN2Z4sffJZoi0Y/CaJnUF82BNgOLMw1+f8y3ztG+DzIQ+qkvbssBV61JK
         GatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679840802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pNoDyjgbswOmadwshB/0yv76Mq66PdLAH2h39TGl1A=;
        b=CQAzYp+2xrASzgXQ9LL9+jBaGCidW8BBWYSfgdAe9FZVjpA2xV1QWQBVN1qB5TOqKt
         rj1sg0Y6OOeJUnbiKOxDiFK4MV1UFfiiKBeXUbJjjvZ1RxnrwjmyFGBSrOmr8JniX1+S
         swSTFRlna9Lj6uifaTfqKbbroOXxnSwd2acXSmu07no+ZuV6y4DTRbsuV1tuVLCHly/x
         QaFFaTUiIuEg5Zofh6aI85b1qSZY1ABoAeFQ+Cn/U9Vdda51CJJzL2LRC+KRTSMGc4Cp
         N+i37ysPH/a98WS7eZdJTZu1Rma00hFOldm0AYIBqdkL8ADHKD6uVtajxhDyUP043hTq
         VZ2g==
X-Gm-Message-State: AAQBX9dINRDfI1xCwg0aiISFVwFBZCdGfVCWD0gd/zhMrMs8FzmKjw4n
        PJKFq5pkVHEB6oZL2oVGaM65Wg==
X-Google-Smtp-Source: AKy350Ye3WdSyrFaEDnsnwal5+62O9RR7xNx7rSyZJJzWl/iycLIHDvEyil+YJUDorsJtkmc1AtgUw==
X-Received: by 2002:a05:600c:21cd:b0:3ef:6e1a:5f3a with SMTP id x13-20020a05600c21cd00b003ef6e1a5f3amr832762wmj.39.1679840802310;
        Sun, 26 Mar 2023 07:26:42 -0700 (PDT)
Received: from [192.168.121.27] ([95.178.111.30])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm10730890wmk.7.2023.03.26.07.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:26:41 -0700 (PDT)
Message-ID: <cebe1ee8-280e-e0d8-bb78-f75ec2d471f2@baylibre.com>
Date:   Sun, 26 Mar 2023 16:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] scripts/gdb: timerlist: fix rb_node access and python
 errors
To:     Florian Fainelli <f.fainelli@gmail.com>, jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org, ouledameur.amjad@gmail.com
References: <20220727141443.133094-1-aouledameur@baylibre.com>
 <609742f5-c280-53fc-3b7d-84a5abf3459e@gmail.com>
Content-Language: en-US
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <609742f5-c280-53fc-3b7d-84a5abf3459e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for testing the series.


Regards,

Amjad

On 3/24/23 14:03, Florian Fainelli wrote:
> Hi Amjad, Jan,
>
> On 7/27/2022 7:14 AM, Amjad Ouled-Ameur wrote:
>> This patchset fixes use of lx-timerlist with kgdb.
>>
>> It has been tested on Amlogic libretech-cc s905X and works fine [0]
>>
>> [0]: https://pastebin.com/RAhQYh6L
>
> Was right about to submit similar fixes. The whole series is:
>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Jan, it would appear there were earlier attempts at fixing timerlist.py, however as of 6.3-rc3, none of those patches have been merged, can you take them? Thanks!
