Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC046BBD18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjCOTQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCOTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:16:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687717ABA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:16:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b5so8304336iow.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678907783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjib63I4/E2+bLbON0FvXB9InrxpaQrzV2uNVZmxACg=;
        b=4wDw2+LMGXQ1PK0U+9MqhBl0HOt2MkVZ28iAQWE6z/yOqgANBCjqvBocCG9ExaTEkI
         bmqIxAGXWJuZJxYdfJEe0rtm0E115npaWy1VcmJuv3dFM1cuUjv/1Zjht3/dLTrtQCfl
         mMOpNkDZxp0HsumZpOPJ9Fj7v+QqI4kFAWP9ACbC58axn5n6aCwe0YlX12OnWiJB8FKX
         K7LNbo3pJz1c/iBksxWNYavYk220EnA5Alp0KcV3flz3eIOPJUsqEk2AWx1YGZ8QtU6M
         c1W1/5Shqz+8fnoIa2AGw+j9RTPf2KgAu1LggsN5mXiABmusrPWMhO7uHQv7hgq+Wn+m
         tD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjib63I4/E2+bLbON0FvXB9InrxpaQrzV2uNVZmxACg=;
        b=MzyAI1qtrfrIG2tnDetcgJI/9NKSaLv32MEzhX5UICfE0NHujpGK5Pg4G8/BDLCH4n
         frT+KTs63WVJL2PeXVo/ReHIkWWaSDeR+oSSGqB3SmIvmM6Js8ZFPEcE9b2KYXSMMSei
         6AAm9z0dSRNmNrD8ssFq1Nk2SbGYsAzUIbr5nxlVnC8hRePRfokpeeZUdgwJ7SV53SHV
         VMRAUc939Lo3U0RQv8Z4Vdkz/qxzfemTjWpTIFvdSLUrGaHOenN0m0UQm/UNcebHWLG7
         RnPLCsmXsSKB/qbw6bWA5WZO4KW+3PQ1cAB9HOQKNQ68umTcD+PZrhxlRgefJ3FBkE1Z
         WqqA==
X-Gm-Message-State: AO0yUKWyGsZqlXHGpmih3OfISCy6/Q3LweT21rq0NTjwssOE4KuDCgbo
        PIllolCgeHasq7x399dFBB0aXg==
X-Google-Smtp-Source: AK7set8Wd5bI1U8OwOnqY75pljVHUxJz0I71aibZ56JieXMkrHFAe99lgCAPANpc+qYnQPMoCBMTMA==
X-Received: by 2002:a6b:dd0c:0:b0:74c:99e8:7f44 with SMTP id f12-20020a6bdd0c000000b0074c99e87f44mr210198ioc.2.1678907782700;
        Wed, 15 Mar 2023 12:16:22 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dj5-20020a0566384b8500b004061d3cce02sm527098jab.67.2023.03.15.12.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 12:16:22 -0700 (PDT)
Message-ID: <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
Date:   Wed, 15 Mar 2023 13:16:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230315151415.2534e11c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 1:14?PM, Steven Rostedt wrote:
> On Wed,  1 Feb 2023 16:08:06 +0100
> "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
>> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
>> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
>>
>> 1.
>> The problem is that, recently we have run into a precedent when
>> a user intended to give a second argument to kfree_rcu() API but
>> forgot to do it in a code so a call became as a single argument
>> of kfree_rcu() API.
>>
>> 2.
>> Such mistyping can lead to hidden bags where sleeping is forbidden.
>>
>> 3.
>> _mightsleep() prefix gives much more information for which contexts
>> it can be used for.
> 
> My honest opinion is that I hate that name "kvfree_rcu_mightsleep()" ;-)
> 
> As I honestly don't know why it might sleep.
> 
> I didn't care about the name before, but now that it's touching code I
> maintain I do care ;-)
> 
> Why not call it:
> 
>  kvfree_rcu_synchronize()
> 
> ?
> 
> As that is much more descriptive of what it does. Especially since these
> ugly names are popping up in my code because kvfree_rcu() replaced a
> rcu_synchronize() in the first place.

This was my main complaint too, kvfree_rcu_mightsleep() is an absolutely
horrible name for an API... But nobody seemed to care about that!

I like the _synchronize() suggestion, as it matches other RCU naming.

-- 
Jens Axboe

