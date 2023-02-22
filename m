Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005EC69F7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjBVP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:27:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40E36FE9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:27:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ec43so31384170edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0kZFUwewf5aQKoU7JNQTU3rdc/9qM6B2o2TjC+Y4n8=;
        b=N9kXWnM8tkFPjn/UVwfz9gZAGjgBMcqE8vnRVTtTrzgZgNGK6sWz+xCoencpoEGFzF
         aULpI65Ru73ofu6Tlno3VDaJkHu4dGjoo/X1ypPo/PqO+MmXZ6zdy3NmP4vpGM724wIn
         b9YtiieQEBoitc2KfCCSDyVT9YstR2dXtTEKdTCKHkb01gWhXZpvR+A1cpOJuVBPWARf
         o23dMelPyeLY2SO39wfUa7ALC8DbP8/uRiza5hMMToAWxx6JoPUMiAXCsQJjz3yhzhyc
         CfTTMlsvM82T0YCMNJfTsPGJ7Cg4mG0EcQQ4cUuyNh3ACM40UXafBiIGJux0pDGyQRTM
         oOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0kZFUwewf5aQKoU7JNQTU3rdc/9qM6B2o2TjC+Y4n8=;
        b=R5wCu/UmowWAHl62dBelbIRtOllT9RxDgImHz5lvZQ7m5ekrLe0hiiWYEWm2V9l67G
         wfjIou6mt1x0+HacfWreIx6dHFJUKZjW2YdxLy6AwzLYJbMShcNapCOHOgNf3SzbBU7f
         ZhmW7UzfzvxXGk20A1xO77nXw+7OBPpFiGmlysJ8FtPTTYzZTfGn/XJqUzhebGJZ7pft
         eXWzQJexIIQyL8wJ8tL0t5Qym1sRVyLIgSJopYVfYgbH8unXbJzG1tHjqTTATEIXB0Hd
         dkxBKJ/jUW2tjuhEI79oaYU/uHbYXpBnEhm1mBhjeN31rLU3V7bor53r7zYffNhwFSSa
         pdww==
X-Gm-Message-State: AO0yUKU9qwYAVPwnsEKeNx42DSQwmvA7J3xbeK+NM3t+DitpKdkPPjl/
        B2iLb+rNY1DmNSODRi8MurB4D8oYxWFJbBE+tybzLw==
X-Google-Smtp-Source: AK7set8FGVA0fjkm5Eu/ivnYjc0+haXYHWVZKMkyUSHUMLA8pbfd3JB7yPsmTCw/MNRrT69nNdVRtw==
X-Received: by 2002:a17:907:f99:b0:8b1:3b96:3fe8 with SMTP id kb25-20020a1709070f9900b008b13b963fe8mr16207880ejc.52.1677079660296;
        Wed, 22 Feb 2023 07:27:40 -0800 (PST)
Received: from [192.168.0.109] ([82.77.80.204])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b008e7916f0bdesm798640ejr.138.2023.02.22.07.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:27:39 -0800 (PST)
Message-ID: <5e75fd39-3761-4402-1fa4-f4d2fac01ea4@linaro.org>
Date:   Wed, 22 Feb 2023 15:27:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Jun Nie <jun.nie@linaro.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
References: <20221229014502.2322727-1-jun.nie@linaro.org>
 <Y7R/QKIbYQ2TCP+W@magnolia>
 <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
 <Y+xgQklC81XCB+q4@mit.edu>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y+xgQklC81XCB+q4@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2/15/23 04:32, Theodore Ts'o wrote:
> So if someone can explain to me what is going on here with this code
> (there are too many abstractions and what's going on with keys is just
> making my head hurt),*and*  what the change actually does, and how to
> reproduce the problem with a ***simple*** reproducer -- the syzbot
> mess doesn't count, that would be great.  But applying a change that I

I proposed a patch fixing this at:
https://lore.kernel.org/linux-ext4/20230222131211.3898066-1-tudor.ambarus@linaro.org/T/

Darrick proposed a similar one at:
https://lore.kernel.org/linux-ext4/Y+58NPTH7VNGgzdd@magnolia/

I explained the difference between the two in my cover letter.

Cheers,
ta
