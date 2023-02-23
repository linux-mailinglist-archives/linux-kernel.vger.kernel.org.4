Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B86A10E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBWT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBWT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:57:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174459434
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:57:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so512689pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSzUOJfdtN9HqYc/iUHo6JBED4EqtZPD2VYPVWa2ehk=;
        b=CqObwow7N9ynxd+bV1Rl60ADS9LJwNa+GAXvOy3aLHz8vN/Hn53Bk9Y+FIrZWunnX4
         gUmzPG1mo011y0mLLOqQFB0MRKxk3wsadmy3Y84WunvMV2QVgviVUml6OZlTjCXnpIuk
         AD3OYzXepLMhH/lxtqkQyqzcoA6y8I4Ahf54nx9OSl7vaBmrv372UeVDR883nuMDbRHx
         3On44dy6n3wV5sje1m1Z0PSvS9x6r4tQHB+bnICcbrdoXAKTA9tiJ5RD45xR9yrDT/uV
         2/eBv85oREvpJDOSLpq7/wu37KaBbk+GwSRGj9Z6FJsSt57ymj1OvJRsoO5I/jVk0rsi
         qXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSzUOJfdtN9HqYc/iUHo6JBED4EqtZPD2VYPVWa2ehk=;
        b=aiHIE3XLExJOx3ZvfZf7dhEfNKlP5ps4JDS+hXeICcWTm57/yVan94Iov2jcsh68nr
         KiRKWMC8idURoMzDuBA4OFOEIRuVDUuOxk6AWECj8FjJUiV8xAJTHMdHgcTuYLYNjrrB
         4ncFn7bWFdh6FGiOYIIdjYKbWCYOQpTlK5egunBY8i+A8VLJoqPUca4OPDVR71sPCngS
         xBJUv6nYcsp9mDJcOVNfp8dN1hncTROsbmKzHRucM0ZdtxxhN5a/mURhQTF7RGu1gcw1
         bVlhAvlK5W/tYkNMvx0UCqyz9AGXOw3cAAPpJQWRjFQTzWYzATdPdYVrjRtBmdjszqyt
         OlmA==
X-Gm-Message-State: AO0yUKWSRI5agMVbDvh37nInQ7MWlbS6lsnzJ1Ox1KR9WC16aHoG2O/j
        FiNnSqh2q2auRykNzIg5/doiDA==
X-Google-Smtp-Source: AK7set9d41ckYjUJSo//hzWtdXQZ7k7/qNPHIfBDpE4KC2bPtdUuTjzf3Jz4Tid9YndBYm+VHLXKvg==
X-Received: by 2002:a17:90a:f0cd:b0:237:40a5:77cb with SMTP id fa13-20020a17090af0cd00b0023740a577cbmr5897552pjb.1.1677182228038;
        Thu, 23 Feb 2023 11:57:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a6f8400b00232cf6186fdsm86404pjk.30.2023.02.23.11.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:57:07 -0800 (PST)
Message-ID: <a25bcbff-b759-7814-1454-9edfe1df7314@kernel.dk>
Date:   Thu, 23 Feb 2023 12:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <84fd00b0-aa87-e4b7-e0a4-d57b720216c0@kernel.dk>
 <20230223183124.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <ae3a6434-1b3a-b848-c8f9-bf6b3d0521e6@kernel.dk>
 <20230223194708.GI2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230223194708.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 12:47?PM, Paul E. McKenney wrote:
>>> Hey, the combined one/two-argument form seemed like a good idea at
>>> the time!  ;-)
>>
>> Hah, not sure what you were smoking back then!
> 
> If I remember, would you like me to send you some?  ;-)

Definitely, might improve my reviews :-)

-- 
Jens Axboe

