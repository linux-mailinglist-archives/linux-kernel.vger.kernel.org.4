Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE8616FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKBVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKBVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:40:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F5E0A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:40:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so2120442wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ETKW87oD1PaKF18iDMpYJJYkObMGHPNzp/3KEFUums=;
        b=PORYkH1v/fjnOxVBN59/9kTAHu6YZoGqHuVEDf8bMVo3lsfN9w8VBUmtGu+1cVkgDM
         fjRsVL8UHTIH9PEVwcQt6JFsxzOCp/JmPm01YhW3swWVs07hikBpFusuib7khF7skDEN
         YR+WHF50IGOvLxqV/OU9ZGMyGAFy6CkUNC4yClR9+uiZ2jb0IiHCFEfm+oE7NnuPnPLO
         O5lwuSbh/2WiJieFuCRSK5WQzCVfFSYz5UaZAAcqD1cT/t1Pke+FUHo5nQiFDwoUqPjq
         s+pVbPnJPV2CT4mM5itDNJ4JjO6GBG7LqJ3RSArrIv72HR93jl1tUuSoasHQl6KdjHuh
         pMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ETKW87oD1PaKF18iDMpYJJYkObMGHPNzp/3KEFUums=;
        b=bk3NnEYwpT0YWLezYWuwjne1Sw8RpcJske5xSic1esvMai2E8g/1DxuU0SNbq5Gjc3
         uBQrva774RVDz2qmrqh87MPB0CkJppKhsBIAIWisSa/6wVdgx6BOkdE3DbaGMd7CNa2x
         0WKQSLkwyDF0kWfB09sQGvtJgD9HGfMAP1s+IYJN9T5Z9M6pmV/hyE3a1I/bU+dSeZjm
         nOkxzv382AwAIGFqBHJRNMPOWLMbk71dh6kvDP/WX0WM9ggag9OhEwJ41s0EQMR/cTk7
         TpdMqB7OrBRgivW46SGwvDz3T5XKfjSMRh5q9fDyAdNj6uZXoUaEC0EHZZsOP8wjZS2d
         nmlg==
X-Gm-Message-State: ACrzQf0pGBtSolHxSkT0Ej2+aQX5wpA/lUmWS0ecGwI1FLhCaEfgsPxa
        pHSxz5ZkVPvY2iH+b3iH6wrMcw==
X-Google-Smtp-Source: AMsMyM6t7pF3U9hm+AJ3O65rUN7ZhwXDzF+QUY0HQXvXeMST/0/7qIsalaOB9DCs6rgrHbS4inKhhQ==
X-Received: by 2002:a05:600c:654f:b0:3c3:b5b7:43a9 with SMTP id dn15-20020a05600c654f00b003c3b5b743a9mr27647075wmb.201.1667425210619;
        Wed, 02 Nov 2022 14:40:10 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5547000000b00228daaa84aesm13375876wrw.25.2022.11.02.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 14:40:10 -0700 (PDT)
Message-ID: <483848f5-8807-fd97-babc-44740db96db4@arista.com>
Date:   Wed, 2 Nov 2022 21:40:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] net/tcp: Disable TCP-MD5 static key on
 tcp_md5sig_info destruction
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
References: <20221102211350.625011-1-dima@arista.com>
 <20221102211350.625011-3-dima@arista.com>
 <CANn89iLbOikuG9+Tna9M0Gr-diF2vFpfMV8MDP8rBuN49+Mwrg@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLbOikuG9+Tna9M0Gr-diF2vFpfMV8MDP8rBuN49+Mwrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 21:25, Eric Dumazet wrote:
> On Wed, Nov 2, 2022 at 2:14 PM Dmitry Safonov <dima@arista.com> wrote:
[..]
>> +int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
>> +                  int family, u8 prefixlen, int l3index, u8 flags,
>> +                  const u8 *newkey, u8 newkeylen)
>> +{
>> +       struct tcp_sock *tp = tcp_sk(sk);
>> +
>> +       if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk))) {
>> +               if (tcp_md5sig_info_add(sk, GFP_KERNEL))
>> +                       return -ENOMEM;
>> +
>> +               static_branch_inc(&tcp_md5_needed.key);
>> +       }
>> +
>> +       return __tcp_md5_do_add(sk, addr, family, prefixlen, l3index, flags,
>> +                               newkey, newkeylen, GFP_KERNEL);
>> +}
>>  EXPORT_SYMBOL(tcp_md5_do_add);
>>
>> +int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
>> +                    int family, u8 prefixlen, int l3index,
>> +                    struct tcp_md5sig_key *key)
>> +{
>> +       struct tcp_sock *tp = tcp_sk(sk);
>> +
>> +       if (!rcu_dereference_protected(tp->md5sig_info, lockdep_sock_is_held(sk))) {
>> +               if (tcp_md5sig_info_add(sk, sk_gfp_mask(sk, GFP_ATOMIC)))
>> +                       return -ENOMEM;
>> +
>> +               atomic_inc(&tcp_md5_needed.key.key.enabled);
> 
> static_branch_inc ?

That's the difference between tcp_md5_do_add() and tcp_md5_key_copy():
the first one can sleep on either allocation or static branch patching,
while the second one is used where there is md5 key and it can't get
destroyed during the function call. tcp_md5_key_copy() is called
somewhere from the softirq handler so it needs an atomic allocation as
well as this a little bit hacky part.

[..]
>> @@ -337,11 +338,13 @@ EXPORT_SYMBOL(tcp_time_wait);
>>  void tcp_twsk_destructor(struct sock *sk)
>>  {
>>  #ifdef CONFIG_TCP_MD5SIG
>> -       if (static_branch_unlikely(&tcp_md5_needed)) {
>> +       if (static_branch_unlikely(&tcp_md5_needed.key)) {
>>                 struct tcp_timewait_sock *twsk = tcp_twsk(sk);
>>
>> -               if (twsk->tw_md5_key)
>> +               if (twsk->tw_md5_key) {
> 
> Orthogonal to this patch, but I wonder why we do not clear
> twsk->tw_md5_key before kfree_rcu()
> 
> It seems a lookup could catch the invalid pointer.
> 
>>                         kfree_rcu(twsk->tw_md5_key, rcu);
>> +                       static_branch_slow_dec_deferred(&tcp_md5_needed);
>> +               }
>>         }
>>  #endif

A good question, let me check on this.

Thanks for the review,
          Dmitry

