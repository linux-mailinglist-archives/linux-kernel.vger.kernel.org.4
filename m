Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AC6EC0F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDWQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 12:06:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35391703
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 09:06:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-5ef51409426so5393176d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682265967; x=1684857967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AAdDru2gosVWzSaTeGo2XJSdTU34ecCLu3cv+Bv/mU=;
        b=cbxwFCe8htC2p7cZI+Mmz6BUTpbhjqhOhqqlSrRpM791ovF0R0/nYww+EIMOKeVj65
         /AuXEvICViXkt19mBa2jwpiEd4ueKrXDcQwCslksDEdi4tJL7M9OWshYDFKG2VtFEpXB
         IAJeM1LtSnL+bo3NZoY6HYnC+cl9Jqm8UNEng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682265967; x=1684857967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AAdDru2gosVWzSaTeGo2XJSdTU34ecCLu3cv+Bv/mU=;
        b=AhwBr1RJL05J3iDs+NpyUeL6NmnPRXFinsBIl39L1IuqVGxx+Wn/3TqEtU7yhwDber
         hXb5NV8pM4SWGKD5/oO7esiMBbYVg0CJfxjhsXHiSOntBU8oLK8TP3mQVKgORd1q6wnn
         uN+d3UOc3J5xH+DUcfvM7BDGhNW20wyrSJWerI12E46FlXW+jJryc855RxIs565Dosh5
         l7/9kWuT8uNb7SXf3IqYhKnUxeaXDZbiVVHvvPIg3IVY9+SLzC1ZFlOzbvmZX7hEzejY
         a6nxoRoIef2Skoqe2JwJWnkLbw1eNToSpY/Rb0IPuu+PPZbhv6B4ALzeNrNbrqYCLw0j
         Xn7Q==
X-Gm-Message-State: AAQBX9czy2AEaf3pxahOFXjx14GsLZouD4k9LyOlg+6iBdiJOp3NWSN0
        ymk3OqmWunrQUeIX0FYvAw4vGQ==
X-Google-Smtp-Source: AKy350Z7fUy2PJypjdgnQ7c+t5KtxiyxusUOJ03mnHBBbL28jDVpWPtmCBKK4Xs3BQ5eb20nfHlPBw==
X-Received: by 2002:a05:6214:4106:b0:5ef:4de8:fb0d with SMTP id kc6-20020a056214410600b005ef4de8fb0dmr18409973qvb.5.1682265966946;
        Sun, 23 Apr 2023 09:06:06 -0700 (PDT)
Received: from [192.168.1.155] (208-59-141-203.s7369.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [208.59.141.203])
        by smtp.gmail.com with ESMTPSA id x15-20020ac84d4f000000b003ef28a76a11sm2922086qtv.68.2023.04.23.09.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 09:06:06 -0700 (PDT)
Message-ID: <73a3e34f-e455-fb89-6a86-f2787da2fa34@linuxfoundation.org>
Date:   Sun, 23 Apr 2023 10:06:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: duplicate patch in the kselftest tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230329122319.76b73d11@canb.auug.org.au>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230329122319.76b73d11@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 19:23, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>    c83f320e55a4 ("selftests: cgroup: Add 'malloc' failures checks in test_memcontrol")
> 
> This is commit
> 
>    afea51f8cf60 ("selftests: cgroup: add 'malloc' failures checks in test_memcontrol")
> 
> in the mm tree.
> 

Hi Andrew,

This patch is included in my selftest pull request for Linux 6.4-rc1.

thanks,
-- Shuah

  
