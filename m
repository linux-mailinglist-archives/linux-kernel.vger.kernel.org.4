Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1937B69EF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjBVHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBVHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:21:21 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BD3609F;
        Tue, 21 Feb 2023 23:21:19 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id f13so26020100edz.6;
        Tue, 21 Feb 2023 23:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwN0t4GS2EA37bAfRFwPBrirPEBoDMe7YD2TezLxAi0=;
        b=FKLbeo8NLw7wJDT2fj8wIp8ydE+AUaZ2SrgB5ozc82gC0eobx+JNqHK6QIS/Rxw6D1
         gRgAI3Avqls9lJlwvRGLL/SdmNZ6A6ZQT4wtEi2kEc4VwTZ+m/Fb3Q7whCstEwTfI2in
         lzvHZNnMcbRS3ax7gY97tjh02Ibd5MNFDobd/isDbLdSHqsVad13CynBlY6m0M6tJ2a8
         rthhnyw2IBHj9q88yuLHHJoNG9Bv5E6dFgJ0NIT36NAHVuX/za4JEBpCpmi0loxojXPu
         ryKFf5itYTFt0uDaA9XwGYJyipj2hMPEoUM0gKghCZm1LA/NYTH2N7l5JTXc477lAyyv
         239w==
X-Gm-Message-State: AO0yUKW1LZlXSTuMvslwkDZUU0PJolAO4Ex2SYBKiKfk7uEGhpdW25Yk
        7ugX02Y4cnKNqXcqPnQk4co=
X-Google-Smtp-Source: AK7set9yNxckoSkCYTPYdKTJJUBJYr1kPiQN1t7uibrIpStAS6OhXwXiDtMdwPWeYydOuwGwOMqJFw==
X-Received: by 2002:a17:906:9497:b0:8b1:9e47:9101 with SMTP id t23-20020a170906949700b008b19e479101mr17194785ejx.12.1677050478502;
        Tue, 21 Feb 2023 23:21:18 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id kk17-20020a170907767100b008d3abe8726bsm3517242ejc.154.2023.02.21.23.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:21:18 -0800 (PST)
Message-ID: <b130702a-9886-f18f-c377-489db1cee067@kernel.org>
Date:   Wed, 22 Feb 2023 08:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>, kernel test robot <lkp@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230221081901.15557-3-fe@dev.tdt.de>
 <202302220740.2RKDHnof-lkp@intel.com>
 <deee30ef43e397233dd15d11b86ae91a@dev.tdt.de>
 <4e5aeac3-2a99-8fd5-cf1d-a35870ecd807@kernel.org>
In-Reply-To: <4e5aeac3-2a99-8fd5-cf1d-a35870ecd807@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 23, 8:16, Jiri Slaby wrote:
>>> vim +9 Documentation/ABI/testing/sysfs-class-led-trigger-tty
>>>
>>>    > 9    Date:        January 2023
>>
>> I apologies for the question! But I don't know what the test buildbot 
>> here wants from me.
>> I've looked at the other files and I can't find anything that stands out.
> 
> sphinx is always misleading.
> 
> It's the indentation of all "LED on if ...".

So this should work:

                 Specifies the operating to trigger the LED.
                 The following operating modes are supported:

                 * Tx/Rx: Flash LED on data transmission (default)
                 * CTS:   DCE Ready to accept data from the DTE.
                   LED on if line is high.
                 * DSR:   DCE is ready to receive and send data.
                   LED on if line is high.
                 * CAR:   DCE is receiving a carrier from a remote DTE.
                   LED on if line is high.
                 * RNG:   DCE has detected an incoming ring signal.
                   LED on if line is high.

-- 
js
suse labs

