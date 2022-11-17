Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BC62E859
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiKQWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiKQWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:24:09 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77B786CC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:22:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v28so3109342pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWX8xZ3siPWUJmFJ+ak5rgGJi5tbSkwD+aeiBnxAmP8=;
        b=EM8Vk/IuYu8zsCx3D/aXB1ydE3hr9wSOvvA42mWznF7gALJ+S0g32LM4VMRNu1vT0I
         IPnZPUy1UHRB7LAfgLDHAN9pUPbP7x9qAzaFWa855hCAHbw9CsPIIBF5+anBUiN/O8k3
         wugLM9mY7sID2s8OU8olcNXrMbck9LM8PlAVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWX8xZ3siPWUJmFJ+ak5rgGJi5tbSkwD+aeiBnxAmP8=;
        b=lf652IvY4OklxruOO8SMzJnzrT6ufb/yqcUVzk9hX4tLYhrXokchRz0v3ouvfXE3zn
         9UZcawt61XBH901VhU8+wMJO9G7NnVd1VFemMhX5CWiL0S9I2oVTSmPi5HbNmOyjhnyg
         OYGbXacCkPKD+HdL/NxoKIbO+d+/WpbLzNm06qRvuh9TTTVGoFKRpUgBwJ7zUYV2h9e5
         J3GLkNCKSk9710ElU36FEMAv9tU+k2eO7ESRPZENoWutEk3FelSoAEaPiA65PQQi5RQT
         JwRoENZ2LbQmcwUZCXkgfgWKwmrDu/inrz39ROQC0nIi8US7FY0Vo1sWO38niweDx+pg
         Fd1Q==
X-Gm-Message-State: ANoB5pmucBum1Z89OrSfTCbnj4RWIaRG1Bqk2Qs4HZ06cCjQ0yHWrYwb
        ct1ZZSXJk9YZB/YqzQkoj5P+/g==
X-Google-Smtp-Source: AA0mqf6X+fpknreQzV9svORhPmRkzR9ZQ875/5OC9hPXiNreh29vMThcE29r/hJZCyBpnjdvstKNoQ==
X-Received: by 2002:a63:1626:0:b0:46e:96b9:ed63 with SMTP id w38-20020a631626000000b0046e96b9ed63mr4102293pgl.258.1668723754996;
        Thu, 17 Nov 2022 14:22:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w1-20020aa79541000000b0056c360af4e3sm1690348pfq.9.2022.11.17.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:22:34 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 17 Nov 2022 14:22:34 -0800
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: __sock_gen_cookie(): Error handling issues
Message-ID: <202211171422.7A7A7A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221117 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 16 12:42:01 2022 +0000
    4ebf802cf1c6 ("net: __sock_gen_cookie() cleanup")

Coverity reported the following:

*** CID 1527347:  Error handling issues  (CHECKED_RETURN)
net/core/sock_diag.c:33 in __sock_gen_cookie()
27     {
28     	u64 res = atomic64_read(&sk->sk_cookie);
29
30     	if (!res) {
31     		u64 new = gen_cookie_next(&sock_cookie);
32
vvv     CID 1527347:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "atomic64_try_cmpxchg" without checking return value (as is done elsewhere 8 out of 9 times).
33     		atomic64_try_cmpxchg(&sk->sk_cookie, &res, new);
34     	}
35     	return res;
36     }
37
38     int sock_diag_check_cookie(struct sock *sk, const __u32 *cookie)

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527347 ("Error handling issues")
Fixes: 4ebf802cf1c6 ("net: __sock_gen_cookie() cleanup")

Thanks for your attention!

-- 
Coverity-bot
