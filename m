Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DF632DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiKUUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:31:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A9D9076
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:31:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so13667237wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOwmSGSbibS0Uto3PS8hOpgTDC9tEJQIR9Uesk+1yhM=;
        b=Wg8pcldbMHJB2zC0xo4OlG5vfldwNalDml12LB8ao+dEvcThuSNofe+9/OVlhBCtR0
         MpLnwncaXKce9IpVyQVNWs9IMoihzBar+TcAnFMPBM2bvPMn3NlWHR1s43m5cvvrAqCR
         faPAIEXLIFGq31m1628HTK2UF6eqDFqWlfQ/UGh9cNkp95HMBHKHpdI+fFWoADXlaAXv
         H6Or3diZ0slUcLqLtMCiqDrmg1r431NGD4dIjclQpTW+sLiV9Rp7EWJfItJgv6gnGIIH
         XuhlNPzZz6c41FKpLUJS4oKpboPQ0tEucB1iKW+xSafhZyiSNhDOlqCD4cEVVxZ7GrRX
         Vv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOwmSGSbibS0Uto3PS8hOpgTDC9tEJQIR9Uesk+1yhM=;
        b=mnA7f1cQLPB9nlSfU9klhq3Q+QW538TXIVdiZx5p+F3qG56ac6Lz2FOOG8dZVEI/Su
         dAL/V9LORctZonkfJaMLVTFPzFAFj4zehkFVIbQ+pPhc1kpioNPG0nIkIEnCaGa8c5pq
         A+bFPyvQ7QN5InAixxfCa43IhpBbsJfkqyp5mWlIQ7dSx5IQYss/e4d1AkfpJfLojjpB
         D89d/KRGJTyBdlHdnD2h/FaAWrEl5+HksGQTCsDmfXj53N/ppxKNAXarJocrL6/0a5Az
         m1cZEZIbPiC/IC2es6hOzHtRXZ39aDyLQ61hA6J3XscRqdh0V/gLbpfxKBfj7Cqy8JbO
         a9Nw==
X-Gm-Message-State: ANoB5pkQnuu9GeLJ/SKYeCDyV0pxA5+q8pkfljcmdCgugR22QaURUHtw
        fmEpr3YVNmVL2ZKciYwmhs8dKQ==
X-Google-Smtp-Source: AA0mqf5PJXz7NriEMEnf+dwEciIMBb19U/ahmM4fXSTm3FMsZ/EB9WV4vjlK7g+sk1gu5dTXUyE1fw==
X-Received: by 2002:a7b:cd85:0:b0:3cf:931c:3cfa with SMTP id y5-20020a7bcd85000000b003cf931c3cfamr5240504wmj.203.1669062706922;
        Mon, 21 Nov 2022 12:31:46 -0800 (PST)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o9-20020a056000010900b00228692033dcsm11954238wrx.91.2022.11.21.12.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 12:31:46 -0800 (PST)
Message-ID: <31efe48a-4c68-f17c-64ee-88d45f56c438@arista.com>
Date:   Mon, 21 Nov 2022 20:31:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/5] net/tcp: Disable TCP-MD5 static key on
 tcp_md5sig_info destruction
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
References: <20221115211905.1685426-1-dima@arista.com>
 <20221115211905.1685426-4-dima@arista.com>
 <20221118191809.0174f4da@kernel.org>
Content-Language: en-US
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20221118191809.0174f4da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/22 03:18, Jakub Kicinski wrote:
> On Tue, 15 Nov 2022 21:19:03 +0000 Dmitry Safonov wrote:
>> +	if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk))) {
>> +		if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC)))
>> +			return -ENOMEM;
>> +
>> +		if (!static_key_fast_inc_not_negative(&tcp_md5_needed.key.key)) {
>> +			struct tcp_md5sig_info *md5sig = tp->md5sig_info;
> 
> I don't think sparse will be able to deduce that ->md5sig_info access
> is safe here, so could you wrap it up as well?

Sure, that sounds logical to do.

> Maybe it wouldn't be 
> the worst move to provide a sk_rcu_dereference() or rcu_dereference_sk()
> or some such wrapper.
> 
> More importantly tho - was the merging part for this patches discussed?
> They don't apply to net-next.

They apply over linux-next as there's a change [1] in
linux-tip/locking/core on which the patches set based.

Could the way forward be through linux-tip tree, or that might create
net conflicts?

I'll send v5 with the trivial change to rcu_dereference_protected()
mentioned above.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=d0c006402e7941558e5283ae434e2847c7999378

Thanks,
          Dmitry
