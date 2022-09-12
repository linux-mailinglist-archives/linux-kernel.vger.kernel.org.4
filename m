Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27495B53C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiILGMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILGMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:12:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC222B00
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:12:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso6459496wmr.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=grrTW+RaMaOwOYe75YF4nf2REprHXMshlrnMxopZgJI=;
        b=5tANbZJsxjI04rBPeXgR8HOX/F/1nhWoQNSekYF0mKNA2/8DXYUIooTNuOo1ey0X9F
         HFc9UX6mSzE7WBm82mRx9rSzvm7Im/T7GK469cDdawvwu8/9aDNazk6EhzzrZ+7R6exi
         YqC3dD16SxxDcI0aZ3yt+3i/lbGXk2p7v+LrHmXk1xHm0oJyyBdn3CHoP4k7CLVmbgiV
         Hu6r/FE0i49zVZtebdzQMMwhxSGL0c+/M7X6CI3LaIl+jkNXM6xYlwqgu9GIWpJ1P0qV
         Te52a2dCGGqF9u3TjM1ipZ2+csqkCTUgarpwo6Tb1JoNyLFJKjzYxSTUQqlvLmPNZKUa
         +eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=grrTW+RaMaOwOYe75YF4nf2REprHXMshlrnMxopZgJI=;
        b=Us+ZuXcRz33WSUsXmkkjTGumUIXI5s3RRHPx6eYHkhoHRTxS9fqORNHWMjl3AorQfu
         Gfwf/1HT0f05H0GeE1gUbpsfFCIT7bk7aJvn5CODEwLdoOWFDtGJuQl1LIWq5LAPzkKG
         G1ql1Hoz49ex0oaJ7wg61EOvBocq8tiX7awmzzMOqtbcRV6O4csmrly0NHfglDa4k7B6
         Thb51ABVPDS3T5NRbIbaPaU6fFCjxBZMY0g7KwJZ8NuZ8MM4cZ3BUhd+3sS+k/p+bf2y
         komZcntCf2pB3KdTYFdoAu2BjPdYKKsbZdrthbdqQ2RQeeJJNRGoo20b0jYTOLmhHRgK
         n/aA==
X-Gm-Message-State: ACgBeo0K2BY+YP0jNqsqB6NQeRiig+Feb+rDZn9BVZsgH4jNjBNaM0WJ
        SFFfcRg7EAear52UtUaLBD9WPaJ5w0ORioRZnTo=
X-Google-Smtp-Source: AA6agR5lpsZeyODZriWY/w6LwDd3hyoc2qLzL7D7AQjKVlguVyynGd9u/7Srne6VwU6Pnt1APzEJqw==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr12533144wmb.91.1662963139547;
        Sun, 11 Sep 2022 23:12:19 -0700 (PDT)
Received: from [172.16.37.121] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a54d610e5fsm9360635wmq.26.2022.09.11.23.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:12:19 -0700 (PDT)
Message-ID: <3167eb0e-2aca-a57d-ea7f-0d42292caf66@kernel.dk>
Date:   Mon, 12 Sep 2022 00:12:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block: remove unneeded "default n" options
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909194545.85603-1-jingyuwang_vip@163.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220909194545.85603-1-jingyuwang_vip@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 1:45 PM, Jingyu Wang wrote:
> Remove "default n" options. If the "default" line is removed, it
> defaults to 'n'.

Since this code isn't upstream yet, nor in my tree, it should go
to the owner of that patchset and get folded in.

-- 
Jens Axboe


