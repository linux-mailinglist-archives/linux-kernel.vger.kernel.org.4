Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0576C5F39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCWF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCWF4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:56:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD02312A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:56:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso429270wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679550994; x=1682142994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pY6n5J6nh7sc6BZPrtW1Af5iIpNiv08jLRK1EZDr/Y=;
        b=kYCf0RAszOEg9bkDgtsJ82BX5g8JwgtElM89s+ujOPDkz/jt1ucDniqxAcxTCRA3F7
         455ZTTlekoP/kHAcQMrgevEI8jDBTC/lN4zyiRyJCBpcbSzJ7Zq0KJ1hDYyqtRWzZ054
         8gWnbGwG5v1tlw5qeoyHQtQ/9KMCIxuS9QOcLQEWCysL0Uks0KO2EdKL30aFvXlcvltO
         QA/6dhghtNmrCd/fmtjjfcpqtg8NlOubBlKLTe4hUNSzFnb7JN5Umiu4fFzJH6o8L64c
         Qac1hWr1D5TDucHyTvOJ6dnnsYN1CQJ4baIUBxVH9i+aIR33n/jviJS7e2EZZpRnuKDd
         /5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679550994; x=1682142994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pY6n5J6nh7sc6BZPrtW1Af5iIpNiv08jLRK1EZDr/Y=;
        b=u7B9hbhWp57NVTdILtotjwGduA7SBjQazwSDP7wkbaHUE0iXXbilKfB7rfs4Gjb604
         lGvwlaVy0WR9m2PLxHTOMabfBYrwfe2S/JYVElppdWjdx9YW5gIE5T1braIYMemX8nof
         je2KPkz8iihkV3rI/biyNNdBA8NyW+l2MUJAMSmEO5UyOHC7GIk7XstbmXZHyam9zwLz
         cQ8pC5L19EFW3Ura5/+4hR3dSFO3NThsU7z42lHLrmRI6yNObMxpZOC/8xjCpckF51gv
         nmF8cttC3tPV6ufY8JhbdLZaiJCB6X2ZtJ049fPFyok2N8NSj9B/HPvUMZN63Kxrh7zN
         deZQ==
X-Gm-Message-State: AO0yUKXj6rg82vEKP/YCXYpE9/0JnCBL0jQYmfpTvSCJxR/Ni5nJPYrv
        pewqX+bRoOC+dF+du2i7jEY=
X-Google-Smtp-Source: AK7set88g+PhzfJWEbM0eHlqrdsc/zQZK3vdrSgOPFrvQYoe6frpHYLB1SoXS21mb48QA3EysJGvVg==
X-Received: by 2002:a05:600c:3103:b0:3ed:d2ae:9adb with SMTP id g3-20020a05600c310300b003edd2ae9adbmr8230524wmo.0.1679550993976;
        Wed, 22 Mar 2023 22:56:33 -0700 (PDT)
Received: from [192.168.0.104] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id b13-20020a056000054d00b002da1261aa44sm3691623wrf.48.2023.03.22.22.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 22:56:33 -0700 (PDT)
Message-ID: <9cdfab96-ee7d-db11-4bde-71648a640385@gmail.com>
Date:   Thu, 23 Mar 2023 06:56:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/4] staging: rtl8192e: code cleanup patches
To:     Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
References: <cover.1679521517.git.kamrankhadijadj@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1679521517.git.kamrankhadijadj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 23:07, Khadija Kamran wrote:
> Fix several cleanup issues reported by checkpatch.pl in module
> staging/rtl8192e in file rtllib_rx.c
> 
> Khadija Kamran (4):
>    staging: rtl8192e: remove extra blank lines
>    staging: rtl8192e: add blank lines after declarations
>    staging: rtl8192e: add spaces around binary operators
>    staging: rtl8192e: remove blank lines after '{'
> 
>   drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
>   1 file changed, 29 insertions(+), 44 deletions(-)
> 

Checkpatch:
WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija 
Kamran <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija 
Kamran <kamrankhadijadj@gmail.com>'

Is this wanted?


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
