Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0632669B330
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBQTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:33:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1224BE88
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:33:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c34c400b003e1e754657aso1746238wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7P7MflaWpXYQfD6IKZsdwP5oFsSsaEC7e6p8ArHuhRk=;
        b=MM77SFJNQaAr50RLNAkmsYdV5rbkafzGlHGV2lcEqC0AqS0bXw9RkZ/nCL0fYxO3ey
         9wGLn0WjtY122/lgQWQiwtemieT1gYCb6/Jjt7a9N6uyq/mJql3a3HtRyvXcsLg3eeRE
         ykvzZka1uteNMG6pk4GwFJC+8GAVawxAuz5tDYdKQf5DlOgMhpMRnyHAVcCYYaEF27Oq
         nzXOPnK+DrqUL9nU+MpCC/7O1JafhQnAf1LHbDg5VCh1VFU+gCtnob3nZD4nJQt0DJBI
         isbw2C/c9v6mgLpEwMJltxEw0y7KqhVH0XOlMSYKMAMje7thabQ/NKtPzJ5mIhdD2A+4
         OMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P7MflaWpXYQfD6IKZsdwP5oFsSsaEC7e6p8ArHuhRk=;
        b=7o2KiLbTe2Qlqa/2of0sQzZBdOM6x2wEE6K1krUjl79ALpQK2PEMWdJjx9zc79Tx/P
         OPbHfgaKOAzi4w9gsgfMyVwL8Pv9g9JQYb53AvDCvbbo/jgFms/et9bICYheJTvkRyXy
         T0wwiqD5StLFwpzoIaUqfk5WL6KFj+FnXE8roYRNYg/hJ0oYEtRmvRBpoQ8+SKVEKaaL
         fCklrvnAfRsZJf7Kba4sALkjkK0sSfB/KnWXApL+N5B4N+BMcTCXGWuEQ5mnNGB4itKM
         wkk8OjYT0q7vo3UWvBQwJYLfaYDUT00Cl2hFQ/FGaNE8XKK+daPtRlBmdznUi3bSUBBL
         qbRQ==
X-Gm-Message-State: AO0yUKX2axNe9vj+c+pQ8wPTIwioOCFQ3/bXV4zPyjCgqY1Ljz6/E7QQ
        eH95Ksz8qTk9RNtEcDy56SUnhA==
X-Google-Smtp-Source: AK7set+1BE3TKM3KTrihpM0VlLi49tlM7qrFm/+jUkKOALb8aIBmBnr3dura/EZeRe90kEScbQsqlA==
X-Received: by 2002:a05:600c:601b:b0:3dc:545f:e9ce with SMTP id az27-20020a05600c601b00b003dc545fe9cemr1296991wmb.24.1676662386249;
        Fri, 17 Feb 2023 11:33:06 -0800 (PST)
Received: from ?IPV6:2003:f6:af46:5a00:93e3:335:818b:a454? (p200300f6af465a0093e30335818ba454.dip0.t-ipconnect.de. [2003:f6:af46:5a00:93e3:335:818b:a454])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003daf672a616sm6015667wmj.22.2023.02.17.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 11:33:06 -0800 (PST)
Message-ID: <b80bdc6d-a9f9-249e-77fd-bc5c553126df@grsecurity.net>
Date:   Fri, 17 Feb 2023 20:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] KVM: Reorder fields in 'struct kvm_mmu_memory_cache'
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kvm@vger.kernel.org
References: <f9423a6ee10d91bd6bad32beefd1b96cad4d28f1.1676620879.git.christophe.jaillet@wanadoo.fr>
 <Y++uHlQz7OEOzojb@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <Y++uHlQz7OEOzojb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.23 17:41, Sean Christopherson wrote:
> On Fri, Feb 17, 2023, Christophe JAILLET wrote:
>> Group some variables based on their sizes to reduce hole and avoid padding.
>> On x86_64, this shrinks the size from 40 to 32 bytes.
> 
> Heh, a hair too late[*].  Unless I'm mistaken, Mathias will be sending a new
> version in the not-too-distant future.

Jepp, patches should appear here anytime soon:

https://lore.kernel.org/kvm/20230217193336.15278-1-minipli@grsecurity.net

> 
> Thanks!
> 
> [*] https://lore.kernel.org/all/Y+puefrgtqf430fs@google.com
