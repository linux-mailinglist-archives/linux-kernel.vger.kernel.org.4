Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72E746151
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGCRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCRTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:19:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F458E59;
        Mon,  3 Jul 2023 10:19:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so2348160b3a.2;
        Mon, 03 Jul 2023 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688404784; x=1690996784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YQM7lFuVD4W1t3SE7hSv4jfk2Y/VsgE1SkaDnTLWS1E=;
        b=k2qWWVrQz67rwhXy5mKhI9QPceGWjpWaJ/vl0t+wOSuv4WXQJbhGiuSD+4g5PdE2LW
         MPEETAtmVQ3o6iMS+767jjshta5uQ+XYeNqJ9RseaHgqoAsyrDqueccGdUNtzlEEPV/z
         8mSwuNTBeAi4CgOScqxxTXDqgWthUsahyP0kPYKSRVLV+omyDa6FiYiRlmVGVHq9hnmJ
         PhKHHfwqMWYUwAuA2IxtpOsDbqHqLNMDsc3Nr+zqPXH/PSisny8D+B34PKNHAwsSHqID
         fDaz8zGmQoC0YM4+3dFAoIOhxDIuTXESzIBr5RJqj7XiOZdkTeyFoHfbNG/qEGtqFrTa
         KhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404784; x=1690996784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQM7lFuVD4W1t3SE7hSv4jfk2Y/VsgE1SkaDnTLWS1E=;
        b=dM79fNgAHkia9M12Tq/pttAfQgTQn0jiS6f/EYFNKTvHcpR1JWHSURJVXNKss5GlhA
         1fvNdRZL2zIXqQhpTtqD7++UO3vTKTaekS+0XLisGrM8LavxZSc2C96h3j1xhxlA+aSK
         emiV4itcH1NHm8iu1yBUbSN9soaw6DIg54z1rP7+VGvQGzMZqowH4IlHxkWq3S7u2sup
         groGTPAQ/ykDClKF4BVzlrc8gBZO9ghnpM0dFZPjdSb0yu/EkL2U5vBvKzBOay5b1Bsc
         IQoqprsyqQu9kBdKpCV2jpLGREcznczag5gcfb7eaB6Pfs4/yhVL/0uQKKtKvaQJVGHZ
         p2zQ==
X-Gm-Message-State: ABy/qLaA/MOvVUhzs+SRhgJLFM2+tfjv2xAJR0N+dDXGdkWlULgHbedx
        rLjesqr9y4HEY01Jvd963RM=
X-Google-Smtp-Source: APBJJlFvk503EdfDGKBw/xTf52kVInfGiE0pg0Y6cY85b8fhK7hPP0OE/OIgze5Xc4w78aE1+H9auA==
X-Received: by 2002:a05:6a00:2e22:b0:66e:fd84:c96d with SMTP id fc34-20020a056a002e2200b0066efd84c96dmr11644628pfb.13.1688404783998;
        Mon, 03 Jul 2023 10:19:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h21-20020aa786d5000000b00678cb336f3csm12184914pfo.142.2023.07.03.10.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:19:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <964806c4-db73-a70b-2168-24168e4b5aab@roeck-us.net>
Date:   Mon, 3 Jul 2023 10:19:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
 <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
 <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
 <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de>
 <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 09:49, Linus Torvalds wrote:
> On Mon, 3 Jul 2023 at 00:08, Helge Deller <deller@gmx.de> wrote:
>>
>> Great, that patch fixes it!
> 
> Yeah, I was pretty sure this was it, but it's good to have it
> confirmed. Committed.
> 

FWIW, my qemu boot tests didn't find any problems with other architectures.

Guenter

>> I wonder if you want to
>> #define VM_STACK_EARLY VM_GROWSDOWN
>> even for the case where the stack grows down too (instead of 0),
>> just to make clear that in both cases the stack goes downwards initially.
> 
> No, that wouldn't work for the simple reason that the special bits in
> VM_STACK_INCOMPLETE_SETUP are always cleared after the stack setup is
> done.
> 
> So if we added VM_GROWSDOWN to those early bits in general, the bit
> would then be cleared even when that wasn't the intent.
> 
> Yes, yes, we could change the VM_STACK_INCOMPLETE_SETUP logic to only
> clear some of the bits in the end, but the end result would be
> practically the same: we'd still have to do different things for
> grows-up vs grows-down cases, so the difference might as well be here
> in the VM_STACK_EARLY bit.
> 
>                   Linus

