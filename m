Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A984628221
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiKNONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKNONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:13:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDCF24F19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:13:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s8so2345833lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUVeOBnyNFqKWpHwwbHrMkJUKp2z+BJ7NRt5LPL2W8s=;
        b=PnNB2vRQgdQoXeozyrUyiyiR2rVAFNOhg0UmPiHR76OSu3Ue5RkktMixU8FFLt+66o
         4uc1gnXj3q/CYl5eOZaPWUx0z3YzbZIX3vAVJgjLG7IJeRk3toQFo1C6SkGX8jME8rVn
         YkCoUQNwFQT2Muaz5IDoBEeWqZl/trB0uJdNnAWt2bsJbKROxy99OfHeremDThll+cJX
         Br3jeFjwW6gpwXcqSy4zQdh+ad3zuGqoO9u0L1IcTwR1KoLljony38b8kMNHaPZz9M8L
         yOWxrBHPUF26GHgOLYPaWGCB4isVKofSLM4SkUVvggHiOuXMa3FBYbcjTYGcw8l6y6vK
         JIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUVeOBnyNFqKWpHwwbHrMkJUKp2z+BJ7NRt5LPL2W8s=;
        b=JOYz239Kb54jBsY8jjynUMNcXTfkZbaYxniaJ1j3D8yBRZ+azHHphH50Ta8O4g+HIl
         jqEpauPAuNvpszrTsCwxupCiZcEhZPplFh07f2NIkqGoqH3+23ydCOgZehGHrboUyjrU
         UUpSnqPA9nxnWDMA7iuS/2ExybB+P2D+GleluIs1oR5KqEsFulxiGrURTJH42hvNmbRf
         xc7biuSMngcjGRtFyvsyZVQSa+/01N6QbQNucZVpg82vroJ0JcXFhfQIAvEl2N984C85
         Sgv6NCB6sjus1e/Y0S88jz/V6XpvXIbikVixnIyMoRzhodGKmaxuZjBSxqXm1cV9H+D5
         vQLA==
X-Gm-Message-State: ANoB5pl3a33LOpUjdJn+G+C9rFpSe9uWpV63aI5f/x5tLdy8vWjoVkuE
        DNwZt0Z1OhaGv3LmyUcYDdc=
X-Google-Smtp-Source: AA0mqf5agIjQnp+wdt/U4ARfYbRQAR3FTljKwRVah8RQcD4CQdNSEplxhDI+FPWf8V8U9W0Um6bdSQ==
X-Received: by 2002:ac2:4d2c:0:b0:4b1:2447:6971 with SMTP id h12-20020ac24d2c000000b004b124476971mr4039755lfk.83.1668435190240;
        Mon, 14 Nov 2022 06:13:10 -0800 (PST)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id k2-20020ac257c2000000b004b4930d53b5sm1271041lfo.134.2022.11.14.06.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:13:09 -0800 (PST)
Message-ID: <a501e1e7-f6ec-6b8b-e7de-cf79d7646de6@gmail.com>
Date:   Mon, 14 Nov 2022 17:13:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/5] x86/kasan: Add helpers to align shadow addresses
 up and down
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-5-seanjc@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221110203504.1985010-5-seanjc@google.com>
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



On 11/10/22 23:35, Sean Christopherson wrote:
> Add helpers to dedup code for aligning shadow address up/down to page
> boundaries when translating an address to its shadow.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/kasan_init_64.c | 40 ++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 


Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
