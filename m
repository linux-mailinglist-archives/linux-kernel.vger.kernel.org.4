Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CAE616072
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKBKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKBKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:05:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC3248EF;
        Wed,  2 Nov 2022 03:05:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1466347pjd.4;
        Wed, 02 Nov 2022 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMZGynsVBldapEggqqWQswcP13k8N/tUCzBN2hX6JyE=;
        b=d9lCCQ8FCYRg9DNALNcFIs8V9hUc0Hqr0lFto04YGeUtZeaMJ+pAU2GnyLFefClHPm
         SPKDAQOGwJHWQJSzaFKWANRX4pwQp71ztCoeNMnuZ1yajxuCGEjM5k3BOaO3mptSdwO+
         vzsoKVxIwpAlFUr3qH+AlbrlXgEBehnEjRvQgSng+zrEEDy8N2YdPVP5Lqvj6KKGJf9W
         25v2MC7LL3+5MFywyKrIZZIQnlx54IIL9emLxScDB3ftSqy7B141yqn/KzkKLabImFFq
         yF4Y6CLJ1HpelOO02uIy1dpNuOLD/3dC72ThmEm3f6k8tIiEOwiyHWDDRbk1xYI0Kt7K
         Dfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMZGynsVBldapEggqqWQswcP13k8N/tUCzBN2hX6JyE=;
        b=5fOaPh/bLU/7+v4Y4xuuzGwHUDKyt69jUfQB3VSk5H+bVVg+E5x2rcgVc46QH/lM5P
         DbWF2ny9ph47FpUcK+GTFHTKXXvKoJRQwwt4qy7Z1626JwLIOeV31jJqFcA5vb59S+86
         BWGNyKbFj8EwwJ6/kTEMtkP2qi1eyvr8zRqUj7ATtcl9oabNRqkruUjx7uZvQU8UvOL/
         D3LbVLUSuo+9oj7DHIrJvd8bgnPSvC4L/xL4qSxxw8m9jf5nHKsZCO5viDbFVjUM597W
         MqoKlXisfYRg4kwFwfdIFPNaLKzKy6DQxEUpW8IvCnfStFFPZeNM5Xz/S1uERTYc/sO6
         UKaA==
X-Gm-Message-State: ACrzQf23i6ri77nyxeAhqhjqsQhHOnBeM+pMH45DcjRn8gVy5w5yafIa
        yE7ZyKv+4pcpWvyKn3O2Xac=
X-Google-Smtp-Source: AMsMyM6N/TVoUpFfF8uqOCgAGyxQlYCLDX1VKzXJpP7qR0LgZ0g7sekiQ7GxJ7VGtfFiKQTDGcpEIw==
X-Received: by 2002:a17:90b:4a04:b0:213:587b:204e with SMTP id kk4-20020a17090b4a0400b00213587b204emr24733399pjb.98.1667383545929;
        Wed, 02 Nov 2022 03:05:45 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 9-20020a631749000000b0046f1e8cb30dsm7229747pgx.26.2022.11.02.03.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 03:05:45 -0700 (PDT)
Message-ID: <b705e85b-c58b-fea4-508f-99ca4bc830b0@gmail.com>
Date:   Wed, 2 Nov 2022 19:05:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, willy@infradead.org,
        miguel.ojeda.sandonis@gmail.com, Akira Yokosawa <akiyks@gmail.com>
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
 <87wn8ext0m.fsf@meer.lwn.net> <5fd2092e-2f3e-27c0-66a9-94e02efa1e8d@amd.com>
 <87edumxow2.fsf@meer.lwn.net>
 <0d210871-a24a-8e61-b734-ae6df992011d@gmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <0d210871-a24a-8e61-b734-ae6df992011d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 16:13:57 +0700, Bagas Sanjaya wrote:
> On 11/2/22 05:59, Jonathan Corbet wrote:
>>
>> I'm sorry, it was b4 that complained, not git.  To see it happen, try:
>>
>>   b4 am 20221024145521.69465-1-carlos.bilbao@amd.com
>>
>> There were, in fact, two zero-width spaces in there, and two more in
>> Junio Hamano's name.  I've taken them all out, and learned all about
>> searching for weird characters in Emacs as a side benefit :)
>>
>> Series is now applied, thanks.
>>
> 
> Hi jon,
> 
> There is still outstanding issue regarding language identifier slug [1],
> which isn't addressed yet.
> 
> [1]: https://lore.kernel.org/linux-doc/48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com/
To be clear, I'm OK with sp_SP/ with the explanation given in the changelog
of v3 1/2.

Regards,
Akira

> [2]: https://lore.kernel.org/linux-doc/Y0ork19pGMhZq8qn@debian.me/
> 
> Thanks.
> 
