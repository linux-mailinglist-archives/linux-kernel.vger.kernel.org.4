Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F46DDD25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDKOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjDKOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:01:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD040E8;
        Tue, 11 Apr 2023 07:01:25 -0700 (PDT)
Received: from [IPV6:2804:14d:72ba:89f6::54d7] (unknown [IPv6:2804:14d:72ba:89f6::54d7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F06266031EA;
        Tue, 11 Apr 2023 15:01:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681221684;
        bh=EYGWwnPROZzN2bhC/9ghXtcVDKwLhKwK3egm6aLzTTI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KPvDPs16JUS2BCC3WvKZkkdkK7l8rrg2fWmm7/eGL4YjET8E9YRxTpR5LqfkcPM/Z
         Rmqz/wJm/pLVqz6IiLNx6k0StrqvOYnVJe9BP/abuOMJTJPchKiJ8Az7+BSof5Cbyr
         Sf9nlaqkAL589VRR6jj3gz7oZCxvOYUe/+ugJ2BB8Z9+GT6dTqYxmmYocMfIihpQG5
         0N8uZCmntrthpOPEQAyYZ7lvBHB5djpRMr6swUj1LEfrhSF1QOG1UAMgafM9zF7Erq
         rDPDP3AjXtbT3VIyKnAnl0+9YfQz+IEgX/Xrt5Y7NLHFYc9D4kygTgB4uo9r7T2im7
         ycTuAD9usSaFg==
Message-ID: <f8e11d45-3803-47eb-4323-48efe36d102f@collabora.com>
Date:   Tue, 11 Apr 2023 11:01:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Willy Tarreau <w@1wt.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu>
Content-Language: en-US
From:   Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ZDVXbw/097jvjKvK@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans (Verkuil),

> One potential solution is to have somebody step up as the maintainer
> of the Rust side (e.g. the author of the abstractions).

I'd be willing to step up as maintainer for the Rust V4L2 stuff. I will 
also be contributing more bindings if we decide that's worthwhile, 
because right now this is obviously very incomplete.

IIRC, Benjamin was originally looking into Rust for the AV1 driver he's 
just written in C, but back then there was just too much work to be done 
to even get started on the task. My point is that maybe these type of 
drivers - i.e.: m2m codec stuff - are good candidates for Rust, because 
the codec-specific bits are very self-contained.

-- Daniel
