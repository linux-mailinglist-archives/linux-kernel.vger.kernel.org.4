Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D031721791
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFDOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:01:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DCCF;
        Sun,  4 Jun 2023 07:01:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b01d912924so36138905ad.1;
        Sun, 04 Jun 2023 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685887293; x=1688479293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGHDepzavGuE83PchG6Ifo8HIEjyqsZ7nz/7LX1OmGI=;
        b=ExlXXAf4O6jig1b/rfi43C25mDdUj5bJQHMsQMp5mBNHGPQmNDgxGDZhQdoJTxvt+w
         1RuEvxdKrjJmTHhaibE6j9a2lkbR7GX9a1YbvxMsYx+70EfEcbW68PKn230qhxNSYvyN
         wCF68SZcJqkkp91Pm/sIIzSJ9RzQCjkNHe/MzlSkn6XeNcTjEMLlZ/xGlHM8pZr1oKp6
         e1bqmBvy0eE7g8Jgk4NiSy32bc5Ji28CPa1u3ShZRvlw/c0GH4751Vq+hmz6pWM6e2kJ
         eNr4UyXH48zt1fMrqsAX8fHfOwUb2fMfd1eowirXpTcy9F6+8mQz49EtLQx3r3zttKAq
         R85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685887293; x=1688479293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGHDepzavGuE83PchG6Ifo8HIEjyqsZ7nz/7LX1OmGI=;
        b=M0Gl1sZjks3MHOSiR1sJkJEsezFAeSGi9vN462KQHCcSD44wMOSJLaurhaoKAwORTU
         sI7MEYc3MJ4O0UkMYp/Ju/T/KTW8xe94DS1kyUNuQlXSeln+X/ZcVEKABqg/hDYKUwl8
         bMBMnkWanl4708azg2h8pxYIHZd0K0ebwKetcJDh7K681RNNnt68+OndQ7tPOYB4HqkV
         adqgJpm8Mbmp6Kjttd6g6M36IGFs6V4Kj/Ot5dEJXQX1FTui8dcmXT98iOBZj6026hL3
         1ondcNEXV9eA0z3q88Zfxt3EPeuyMT1Cqdr8qMe3SZlpz3de9rLg3Cka+H3eHSwuVJwy
         V6Cw==
X-Gm-Message-State: AC+VfDw7+PRo5MS30MYC8VvG/J2+g4JgT9sk9qD29ET7WDtla82qr5M9
        1s0NknYXxMHCNxZkGHJfNNg=
X-Google-Smtp-Source: ACHHUZ5olLI4H9tXFHWVTFNSmHMVCx5b78J0aCp08Om7tek2DOOaEL+crIoRBFaJK7sobABtfmcvww==
X-Received: by 2002:a17:902:f550:b0:1af:c1a7:3bb5 with SMTP id h16-20020a170902f55000b001afc1a73bb5mr6244163plf.4.1685887293403;
        Sun, 04 Jun 2023 07:01:33 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001a96a6877fdsm4763410pls.3.2023.06.04.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 07:01:32 -0700 (PDT)
Message-ID: <10e68064-42a3-c80e-10cc-079a3cf4eb35@gmail.com>
Date:   Sun, 4 Jun 2023 21:01:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>
Cc:     Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603151447.29288-1-james@equiv.tech>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230603151447.29288-1-james@equiv.tech>
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

On 6/3/23 22:14, James Seo wrote:
> To reduce ambiguity and eliminate this class of potential (albeit
> tangential) issues, prescribe sending patches 'To' maintainers and
> 'Cc' lists. While we're at it, strengthen the recommendation to use
> scripts/get_maintainer.pl to find patch recipients, and move Andrew
> Morton's callout as the maintainer of last resort to the next
> paragraph for better flow.
> 

IMO, To: and Cc: don't have any practical differences between two,
and I usually do vice-versa when sending patches: lists are in To:
and individual maintainers are in Cc:

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

