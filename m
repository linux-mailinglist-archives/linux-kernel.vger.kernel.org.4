Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D56BF916
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCRIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCRIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:51:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FB38E91
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:51:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p20so7610606plw.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679129464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bovk15UMlVAcSGthg5cURoe0MyXmWN6RteeHHI98a0g=;
        b=NZyo/rLE1N+4/FGAgnjQyf6xm8QYgK+ThSJcyP1JopEM+phGvM3QgFkuukBP9z/k8/
         zVg6ZF+JC5nc3theQSIgJFuJx+Ys4WirYs8vlKPQvHUyw3EeYM/mOEPTgfDcq8NTaksY
         5ddA/bk3DkOGSLA+oHbDY5al0darJYTrzUOn4k6FbIWGwNdc/N6+ojP53OqQDqs1nsaK
         wFOUjd2ebqrxfqXswGmh/gIP+F3DTMvbUk3oudOBEtSvWJOYiPV8lH06iCqj3Ws9yPJQ
         53/88VCD1evt50DUiZeBmZYY7yEvWc6lpek3ahL8CU2nWgBc8BBlSk0HbnyoB2TahxtR
         LZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679129464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bovk15UMlVAcSGthg5cURoe0MyXmWN6RteeHHI98a0g=;
        b=Ft8U0+wrjDuzcUXZoobba7jPyRZ1JQbClowwOfe3s12Nj4F5S4mmAPswE07Yq/UU/v
         mTFm5PYIqicp7+QyezgP1XOaeKPuYlxUhrzSHR83U/+Y4ma67tQG+onUeM+QPGUjAwOp
         +t4qTfDlW/epL1R/RfsOBG7sW4V/Z7q9fdBbAhuFul2B7KJvlLJMJTX51KIntyNJhiah
         EevKlp751EquzBPNKCmn9LUCYsFOXt4Snh4+cq5mxHjU1YjR3ewOZuDQuHmRFcqDz6V8
         ZMfTJHRp+sQE15m0jWCGZzifMmTa92iYlbbLHXmi7zv3SiSWYZAXvW8bR7nMhtTxc/LA
         85Eg==
X-Gm-Message-State: AO0yUKUlC7LU8naP6byeOR+1Hg5scDY0xGyKRZHz1Z5Py2qeleyZl6kf
        oTOKoUFuIJiAUer+dLfykgkRjLLeret0TQ==
X-Google-Smtp-Source: AK7set9aZI4dMxgz6zsPDQe+IXpHSm0HhwbdMcTyjBAzqeWeW3T/xhkqCcw7IgVkhmuMXCAQKqSrKQ==
X-Received: by 2002:a17:90b:3908:b0:237:9cc7:28a6 with SMTP id ob8-20020a17090b390800b002379cc728a6mr11502934pjb.26.1679129463718;
        Sat, 18 Mar 2023 01:51:03 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-29.three.co.id. [180.214.232.29])
        by smtp.gmail.com with ESMTPSA id ay16-20020a17090b031000b0023c8a23005asm2345368pjb.49.2023.03.18.01.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 01:51:03 -0700 (PDT)
Message-ID: <adb3e640-752a-0b93-f91b-d9198b270fe4@gmail.com>
Date:   Sat, 18 Mar 2023 15:50:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
To:     Ira Weiny <ira.weiny@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZBHlycBoZ0JRwHZm@CloudiRingWorld> <ZBKDddHeKlWohA0T@debian.me>
 <641548b142559_28ae5229425@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <641548b142559_28ae5229425@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 12:14, Ira Weiny wrote:
> Bagas Sanjaya wrote:
>> On Wed, Mar 15, 2023 at 11:35:37PM +0800, Kloudifold wrote:
>>> Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to snake case
>>
>> If I only see the subject above, which functions are renamed? I have
>> to see the actual diff if the patch description doesn't answer that.
>> In this case, I think the proper subject would be `[PATCH v3] staging:
>> sm750: Rename sm750_hw_cursor_* functions to snake_case`.
> 
> No.  The oneliner is a brief overview.
> 
> It is perfectly appropriate to have to look at the diff to see what was
> done.  The commit message is to state what the problem was and how it was
> fixed.
> 

OK but I prefer to be more explicit in the subject and the description
so that I don't have to guess :)

-- 
An old man doll... just what I always wanted! - Clara

