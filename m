Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C27647CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLIDgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:35:58 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2402CA432F;
        Thu,  8 Dec 2022 19:35:50 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3704852322fso37290057b3.8;
        Thu, 08 Dec 2022 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoAXY4oz3//YssskB6bdc2J+HywWJ8gfQL6OHbwqXnQ=;
        b=qPn/IdpAvQN0x1RC9GZAUdQ3nX8aRjRiJGGxyRZTTQHtzAxnkku+L2enxOQsRz6mYN
         xM1s6Yz+kYWZnXV//Bt6nVgS8dU1Av3lbElqBhOYzIsntAYAIDPgY5Tpy/NpAxPMcb9r
         IygSDTTz4x1zKlkhbRoQFppo0Md6r7wdPAk7qk78XbM1GMYvUuV6+SDUNa11OjOvjGyx
         psmVEICiz6O8Pg6/uHd2ZV1h4c2hQ9Cg8cqVlYHQBsXd6+9iSKzcAGCO4otG64Z0ZflB
         TMTFJBz4XmVu5kTwPP1kMn6+aFPV0BSpo+zmm7qMowcyuVpqkhJgex8cKdU7Hk+Wdi4g
         DVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoAXY4oz3//YssskB6bdc2J+HywWJ8gfQL6OHbwqXnQ=;
        b=B00M59bGEdz3E/s1LASR9chlZoBgbAT54hZGvxfHB+ZaSs6/9DeojH+1j0dKslJdU6
         2nT1cuzbhnNzqZ7ERL5hR7FsIhSFcWz1FvLLLuVGioakZvV5+a1UnkpszaKuYkBetW5/
         Ccek/6vrDqsOa+7/IJNnUv32/6TwL2idxeNHuZOsEKzmDAcdujUczpVpMwjB21X/Ef2m
         lOg07rR4Krz8D5chJJVod1/PFbctm3oXWwwFOALP//zy6l/NXUKL1cOywOAntzjM5AA1
         QH5neHkwUiLBbbmS/3+BSfYTFb9L09AhO7X6S007zdjhPUdhkw3w5UPgZrXOtPdMHdmS
         xcig==
X-Gm-Message-State: ANoB5plghXZpbyzKA+1A/WU7ECgoVCuj9BO9qrm2ASa1kb+NMNE+zT/p
        N/gDWLMIMJrL5GqW3tlDFciupXgjN0U=
X-Google-Smtp-Source: AA0mqf7SL0bj3yP2oDTllApvM/dkL5rh5Zlw++oHpdvVmI0Xkrz3dAETMZMSzTjg8ShPpvSf9ECX/A==
X-Received: by 2002:a05:6a21:78a1:b0:a4:829e:de65 with SMTP id bf33-20020a056a2178a100b000a4829ede65mr7391414pzc.9.1670556420116;
        Thu, 08 Dec 2022 19:27:00 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-21.three.co.id. [116.206.28.21])
        by smtp.gmail.com with ESMTPSA id w206-20020a627bd7000000b005748aca80fesm230979pfc.32.2022.12.08.19.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 19:26:59 -0800 (PST)
Message-ID: <a755a60a-7ab7-0d7d-5817-c4c88b7781c6@gmail.com>
Date:   Fri, 9 Dec 2022 10:26:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm/highmem: Add notes about conversions from
 kmap{,_atomic}()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221207225308.8290-1-fmdefrancesco@gmail.com>
 <Y5FmjdBNEO8aP/Ls@debian.me> <21697972.EfDdHjke4D@suse>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <21697972.EfDdHjke4D@suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 03:05, Fabio M. De Francesco wrote:
> You provided valid suggestions, thanks!
> However, immediately after submitting this v2 patch, Andrew added it to the -
> mm mm-unstable branch.
> I'll do the changes that you suggested in a subsequent patch which will build 
> on this.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

