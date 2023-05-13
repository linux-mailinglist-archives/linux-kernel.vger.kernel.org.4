Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051DA701AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjEMX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:58:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A722130;
        Sat, 13 May 2023 16:58:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6434e65d808so12077445b3a.3;
        Sat, 13 May 2023 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684022285; x=1686614285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6IPSqQ6NaOSfnUS0GpkC+isDFooikpsFH7l63MYdTo=;
        b=c6TQoKpeUT/xnus50Ag62eU/c39VunpDNtF/MKoJddF0jD6f3+TYJoIPhfkljoRSUP
         FsIStrF5AoIypO5VQ0CsJsWEeuRgT/XiSbZJ8vD6oh6tqmSkIZu2eadDaMRs2ytcGuFl
         /OS2p8h06OVmyhcjP5Jls80loAbw2tPq+mgwDSdO4dI0/Mw5wd8wDn4KHn4Wc/c1o52c
         T6aRqd3qZog1s0mA47WYKDtPvKsSQ4tBU57NLH6pvGVl8W3noU04rDMAXm+CB2SOopB6
         VWE+4DRG/fR8pQUmehdiYKkTSqNem72yBbSDgvTcNSbVWGgBXUj0RmRplrnZ8jzAEOSy
         7d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684022285; x=1686614285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6IPSqQ6NaOSfnUS0GpkC+isDFooikpsFH7l63MYdTo=;
        b=XyvZFM+A8WCMHylLei52x4Fib/QE36ynI/Xj7Snga2JXmMOpTE1h503mMwmlP1cDbf
         8K+Wmnf4+uwJgFcouN8pZJ9XcHiJjwJgNTecl4CVpZ/XvKASOA6aAq9Fc7K/KPdK2p4a
         NrwoSNOm0DbOdLe63fhyW7C9tndYE+mm3xuycEKGdXXHwQkEbl0RLsrMdSJe4D2rbsZx
         NiBNh+qG4xwpbE5KBak74E8rXdzU4VA7QJXny7UXydmJIFJLA0sOO0jRwU0BFZSjsYq2
         tcoRxwCDOdc2w7/Xjj17lMjqtw7RLQ2Gdl+UGyO4sf8LHLrxFQ3emWmP+ExXdWIbHIBe
         wE7w==
X-Gm-Message-State: AC+VfDwEBv9NJ9wXC66H+sgZJ3qhkfP5/4198tn8kw+0mhMRc36eHjQ1
        FrWwnHHvufAOycqLXfYMGoA=
X-Google-Smtp-Source: ACHHUZ40CHAdVD8zkf1r7hESgn2oYYdABf/NG73liqLqpxQ9GuLpKSyt9jFE2/Sst3fK7fVsfse4Ww==
X-Received: by 2002:a05:6a00:1a92:b0:64a:a1ba:510e with SMTP id e18-20020a056a001a9200b0064aa1ba510emr9413823pfv.27.1684022284858;
        Sat, 13 May 2023 16:58:04 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x9-20020aa784c9000000b006475f831838sm8137449pfn.30.2023.05.13.16.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 16:58:04 -0700 (PDT)
Message-ID: <23195f15-7024-6fde-84f2-4cdd45c9abfc@gmail.com>
Date:   Sun, 14 May 2023 08:58:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Content-Language: en-US
To:     paulmck@kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
 <ZF48uBYKczItubrU@FVFF77S0Q05N>
 <b5498819-c2d4-414d-ba01-5373e749dc52@paulmck-laptop>
 <ZF5xXuPsrZEgAEEE@FVFF77S0Q05N>
 <e767dcc6-ea63-4ed8-9a15-9e5bb133fafc@paulmck-laptop>
 <b3956719-d478-4dc6-95fd-ec0744acc662@paulmck-laptop>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b3956719-d478-4dc6-95fd-ec0744acc662@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 May 2023 19:11:15 -0700, Paul E. McKenney wrote:
[...]

> 
> And here is a rough first cut:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/fallback-rework-kernel-doc.2023.05.12a
> 
> Or via HTML:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=fallback-rework-kernel-doc.2023.05.12a

Running "./scripts/kernel-doc -none include/linux/atomic/atomic-arch-fallback.h"
on the tag emits a lot of warnings.

Looks like there are kernel-doc comments who don't have a corresponding
function signature next to them.

    /**
     * function_name() - Brief description of function.
     * @arg1: Describe the first argument.
     * @arg2: Describe the second argument.
     *        One can provide multiple line descriptions
     *        for arguments.
     *
     * A longer description, with more discussion of the function function_name()
     * that might be useful to those using or modifying it. Begins with an
     * empty comment line, and may include additional embedded empty
     * comment lines.
     */
    int function_name(int arg1, int arg2)  <---

Note that the kernel-doc script ignores #ifdef -- #else.

BTW, I couldn't checkout the tag so downloaded the tar ball via
HTML.

        Thanks, Akira

> 
> Thoughts?
> 
> In the meantime, enjoy the weekend!
> 
> 							Thanx, Paul
