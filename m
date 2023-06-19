Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C56735C32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFSQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFSQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:31:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985FE5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:31:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f87592ecaeso1002579e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1687192266; x=1689784266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdiTufmntBKxHYVqndBlq4tSAUMFnmTZJfyhg7k/aW4=;
        b=Fpi6ANz8tcmx8QQBP6DVNqNqHLKy+l9UHr3RmqhCYHZm5DUYoVqj7FR6ne94ZS9zcP
         k6qiUTRIL2f9RinfMUIkpOZi8Ipe4oR2jvlvR+Oq/vmWOpxV0ZLQxHghEckQtvMRwGAM
         +GKI29NYxbqXDQ1BPQKYX9u3IY9SG/Wv3Y1agDxB8b0vY37JYK4xvZItk7NcE9TgVKyu
         SVIFkhsv/jE9DznsvyVl1BiH7r7/gpxJYQOVRg6uuw+G8r8oPwhOxI6/tbkv+nUTexZX
         6m2WLqFXVpLEncbkmetUdCzP84Vf1r1o6T7WAFLrXfKYvw5JRiL7bty2iB5ef8ckUGwd
         8tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687192266; x=1689784266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdiTufmntBKxHYVqndBlq4tSAUMFnmTZJfyhg7k/aW4=;
        b=PP2F+LbM1+LzeopIKaJav5YML1k1+Esjms5lEWpIjDbXLWgeC0Mzurc30U4FDcdlyd
         dG8HrGyb854j3MOkFfOZDU6bwM5dOhJEJKup8lm3muc4+3ggElGHf13GpOtbO/8oLL8c
         nPoIKgBhZhGZ4gmj3qWXdzT6fWd+xharwAGXmDzNtldm1Vaf5Nc0ma1Nvf+3CLdcnafN
         wZuZsj7MxI2xPBxLt7uMrynlvfSu7m6liDGt9668y7WJ1YJtfXIOf1CBjbKoqyD0agX7
         RAjWHWInYYX+nkTr7CXos19KW/rxUQn93BA1GzPrAg0OPoyb+rpR3FMex1/N2Xcp0s4S
         FjQw==
X-Gm-Message-State: AC+VfDzP92TE2D0KtVIz58jxCHU/J6/66CnzKilu4SnA1YxXrsaZ0Oag
        VDkEzUdyzNsbiaGNwuPwSDndBA==
X-Google-Smtp-Source: ACHHUZ79Q/DZL3czmxEW/5Uq3pwT5NNTHwbxXODpzi2zIYCZEqH1vsV32toMw5s4hmWMAA0Zm1fLBA==
X-Received: by 2002:ac2:5f9b:0:b0:4eb:2d47:602 with SMTP id r27-20020ac25f9b000000b004eb2d470602mr5578187lfe.59.1687192266165;
        Mon, 19 Jun 2023 09:31:06 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a7bc7cb000000b003f5ffba9ae1sm151369wmk.24.2023.06.19.09.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:31:05 -0700 (PDT)
Message-ID: <1c2537d0-cf64-c010-fec6-9fa9ad758f42@arista.com>
Date:   Mon, 19 Jun 2023 17:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 04/22] net/tcp: Prevent TCP-MD5 with TCP-AO being set
Content-Language: en-US
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
References: <20230614230947.3954084-1-dima@arista.com>
 <20230614230947.3954084-5-dima@arista.com>
 <85077827-d11d-d3e6-0d23-9e60974cad0f@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <85077827-d11d-d3e6-0d23-9e60974cad0f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 6/18/23 18:50, David Ahern wrote:
> On 6/14/23 4:09 PM, Dmitry Safonov wrote:
>> Be as conservative as possible: if there is TCP-MD5 key for a given peer
>> regardless of L3 interface - don't allow setting TCP-AO key for the same
>> peer. According to RFC5925, TCP-AO is supposed to replace TCP-MD5 and
>> there can't be any switch between both on any connected tuple.
>> Later it can be relaxed, if there's a use, but in the beginning restrict
>> any intersection.
>>
>> Note: it's still should be possible to set both TCP-MD5 and TCP-AO keys
>> on a listening socket for *different* peers.
> 
> Does the testsuite cover use of both MD5 and AO for a single listening
> socket with different peers and then other tests covering attempts to
> use both for a same peer?

Thanks for the question, I have written the following tests for
AO/MD5/unsigned listening socket [1]:

1. Listener with TCP-AO key, which has addr = INADDR_ANY
2. Listener with TCP-MD5 key, which has tcpm_addr = INADDR_ANY
3. Listener without any key

Then there's AO_REQUIRED thing, which BGP folks asked to introduce,
which is (7.3) from RFC5925, an option that is per-ao_info, which makes
such socket accepting only TCP-AO enabled segments.

So, 4. Listener with TCP-AO, AO_REQUIRED flag.

And then, going to non-INADDR_ANY:
5. Listener with TCP-AO and TCP-MD5 keys for different peers.

Here again, for each of AO/MD5/unsigned methods, attempt to connect:
6. outside of both key peers
7. inside correct key: i.e. TCP-MD5 client to TCP-MD5 matching key
8. to a wrong key: i.e. TCP-AO client to TCP-MD5 matching key

And another type of checks are the ones expecting *setsockopt()* to fail:
9. Adding TCP-AO key that matches the same peer as TCP-MD5 key
10. The reverse situation
11. Adding TCP-MD5 key to AO_REQUIRED socket
12. Setting AO_REQUIRED on a socket with TCP-MD5 key
13. Adding TCP-AO key on already established connection without any key

And then another bunch of tests that check TCP-AO/TCP-MD5/unsigned
interaction in non/default VRFs.
I think the output of selftest [1] is more-or-less self-descriptive,
correct me if I could improve that.

[1]
https://github.com/0x7f454c46/linux/commit/d7b321f2b5a481e5ff0e80e2e0b3503b1ddb9817

Thanks,
            Dmitry

