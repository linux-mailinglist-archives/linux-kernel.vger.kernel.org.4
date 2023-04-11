Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB86DCFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDKCmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKCmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:42:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662F271E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:42:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id la3so6307234plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681180957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RQqy4nziZQ9TzxFYe6fW2+oSrf9NkaryzYcLUrT7bc=;
        b=qBjHuRwQIPL9ezEgmI6+TrMizavv6U+wrGvwoAkqSv5794xkWOxTdrXKuwdRCPJfFZ
         Oemt1S8gIjZTNdAXgErFuwd4LU8I4kvh+GqwWS8FzXgasHUapBLNpU9YBbLjlCjSrNlf
         gAXj7JG2T7anWv1QXPw7WO7XEADEh4ienDv+kxzj0y652zj/UrHhqJafvaJAlabhjA4v
         tFzpz+0F+Zw3zeZpnGvJGUCXnvcFm5RTcVcq5kvfjn0xLAhp7/aSY/dqcFgnmPh4QoxK
         AfLgN4lcufRCU7iwspVtavEt4RPButw/kyq+XnVWP6cl4a2Xk7I5ti09l+gMZXG9tY/X
         8Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681180957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RQqy4nziZQ9TzxFYe6fW2+oSrf9NkaryzYcLUrT7bc=;
        b=xwWVOHsNkJdhriiUeCdfYQ96xLUmkp/nrXBs/wlgGlZh3lR1dN4qIJJECCRzzNX26w
         zx8/NnO5pI9jm2CLJa73iCtw3PpiiXIDCVOe/xZxhmTx0oHhTxORec5vPFQJHB3QDquI
         UalQRmnAmDYbed7cIXXlwNHxicVUqQ7BCKeBOfnZ/oSazyVet7sRDSbuDQnQNbfURZIo
         X8xqo9exsxnvBrol8JPiRrd7IXmAK7cK4LEK2hotRlvlZqNOvx/cqnC6ZUE1lBKfvQT4
         35KcOGVgLuxjUZ1C+PgZNfu19iIafoeqiQlR+WQEzLHgpLyW7ngrNwWH22xTc+Vm8KAL
         BnTQ==
X-Gm-Message-State: AAQBX9frJU1r2fbGeQIYeHu/QPRvLKZJ4tywOQifKf+Okcj+G/AWmc+d
        xXkdSSCPRjwzRCtXeFNKOAH+h+tq4Niehw==
X-Google-Smtp-Source: AKy350bM9O6hqu8223e+V+vbYeVjcQ2G3GG3J42o4cNPl3kfIvnRkOjNmuPfk6WalIqssrcw9Y5zWw==
X-Received: by 2002:a17:902:d40a:b0:19b:107b:698e with SMTP id b10-20020a170902d40a00b0019b107b698emr1062261ple.14.1681180956937;
        Mon, 10 Apr 2023 19:42:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8417833plb.125.2023.04.10.19.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 19:42:36 -0700 (PDT)
Message-ID: <945b644a-04c4-b29f-c720-d6ac43b3bed5@gmail.com>
Date:   Tue, 11 Apr 2023 09:42:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBtbTogRml4ZWQgaW5jb3JyZWN0IGNv?=
 =?UTF-8?Q?mment_for_=5fkmem=5fcache=5fcreate_function?=
To:     zhao xinchao <ChrisXinchao@outlook.com>
Cc:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DM6PR22MB1836791E3AA65BB61B3FE933C5959@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <DM6PR22MB1836791E3AA65BB61B3FE933C5959@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 21:45, zhao xinchao wrote:
> The meaning of 'others' is non zero.
> 
> This function has three return positions. In addition to successfully return 0, the first failed position will return - E2BIG, and the second position will return Non zero value for setup_cpu_cache function failure.
> 
> 

OK. Please send v2 with all error return values described.

Also, don't send HTML email (like one I'm replying to - mailing lists
reject it) and don't top-post; reply inline with appropriate context
instead.

-- 
An old man doll... just what I always wanted! - Clara

