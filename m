Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E86150D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKARfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKARfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:35:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6EA1FC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:35:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o4so21145445wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C78g1dyE8bjnWPnzl6S8kDNN8PhTwEKUokt9KJdMECI=;
        b=eMke/7lc/pqWu2ljT+MX01FQ0JIQ8b5E5agnLqc0KsI5u90IyBIa2N+iY/CJlVL1wy
         eiqu2GD8Ez2RvAgutiGeuVRmn+efM5//unR88M80F/iAjRII13HvCIV2V+H2WYV7vZZX
         WpzkSg+4sL24Z7qN1Toxn7U3AwNLRabUivWQsLFDaqdoAGovpc0C6c+tYsPq2whqMaXt
         4mgD6BsQ3k4cZD5p2EYk6VzcBu1mZboNN/l/dDD6KXGhTUIRSwaWXkKCJc0CjBWO7dpO
         KYRgMElPdsVnhTfVOYJdrPxLqUrdUrPozy3nH0NI7pUY6CoWOup6vvlER1zwpBcQaoWK
         AbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C78g1dyE8bjnWPnzl6S8kDNN8PhTwEKUokt9KJdMECI=;
        b=CiXCkCycRP6w6sH6TDLsi+/Gb5cliJDgj8OJdYgmqRwn63xjBOodlAFLyVPcrNYe4a
         Ud2wXl0zWh4KCxo0wqgXxDIwkZ6Tk4qhpHO4OJ/dq4bD99Azh9AXyWwTIzoL/lVLNCTu
         Xcp7m7m/usJ58a/UK9+TUbqrbjMjlxk6ett6Lp6uIj0y6/vWmv0S0+vuNH0azz6ZEPRB
         byv2TKe0Gex+I0/M4ULVlWxNH2qPoexyR5suJvJKONGY0P3EYug9nwhDgCYCFkN7FtKJ
         yfuPIYoUrABvRR4PZRRUUCEKC57BE7pSEc9r6b7iW0kVsitf6hAx0Zn++nuke7axjaRH
         uBdg==
X-Gm-Message-State: ACrzQf3kNIqyPYPEy/AQ70LXgLFTzLFIHbiL1zyVOjwzDo6E0/1qVWZK
        GAalPIXBBSxyoq5lRSso26HBAQ==
X-Google-Smtp-Source: AMsMyM4VDT7qWGP0Sg5b84gM2Bq786aWgi7tLXL6MQblBKadK7u986GU6Qfn9F0ol+vIPRkOfQOCqg==
X-Received: by 2002:a05:6000:504:b0:236:5fe9:883e with SMTP id a4-20020a056000050400b002365fe9883emr12523706wrf.65.1667324141107;
        Tue, 01 Nov 2022 10:35:41 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c192-20020a1c35c9000000b003c6f3f6675bsm11297413wma.26.2022.11.01.10.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:35:40 -0700 (PDT)
Message-ID: <5618b5e8-4ada-7d08-b7af-178a862f452b@arista.com>
Date:   Tue, 1 Nov 2022 17:35:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 00/36] net/tcp: Add TCP-AO support
Content-Language: en-US
To:     David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20221027204347.529913-1-dima@arista.com>
 <c0b6c5f1-9b4f-2d3d-69fd-533daa023e09@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <c0b6c5f1-9b4f-2d3d-69fd-533daa023e09@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 11/1/22 02:22, David Ahern wrote:
> Thinking about how to move the TCP-AO intent forward: clearly a 36-patch
> set is a bit much. The first 6 patches are prep work, and we know there
> is a use case for those.
> 
> We could handle patches 3 and 4 as a stand alone set first.
> 
> Once merged, deal with the crypto API and users until those maintainers
> are good. That would be patches 1, 2, 5 and 6.
> 
> Once those are merged it drops down to just networking patches with
> selftests. Those can be split into AO (19) and selftests (11) making it
> 4 total sets of manageable size.
> 
> The AO patches can be reviewed until convergence on a good starting point.
> 
> Sound reasonable?

That sounds reasonable to me.
I'll submit patches 3 & 4 for review and then, once merged, 1, 2, 5 and
6. And later (re)-base TCP-AO on linux-next.

Thanks,
          Dmitry

