Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B56233A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiKITlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiKITlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:41:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4522A96E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:41:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2908381pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1VP0ON/R/XNlpNpYrF7swSAsbd3KSc6Uo6XVXcsTwU=;
        b=yiVotmZB2Sbm9qDeTAvvcgQhDxSpuANW1NkuyhiOLzcuS4tPYDuP9XCrW/u/jyGpo3
         Mtu79aNm4z3CrVGL1nDmz9cY5TGWnQphoZjdwPbAlLScd0/iHFW0GN17XUDNdtFR8hkq
         Xne0iHnMg4E2V6QXpU0w1wGvzIIbbDN7hGCHrVdR7tYmprlFjnXLtn2NjDGgZ3MbEVqi
         QEFJ9Z77TZwqgxrrGtUVdUIJeW5WwQf2HwHwk5jAH8odLm/NtlE+B8qrk0/uxbK3eEJt
         y13OeCVS4LTHbwblFiZdrLu3rNVhXBFCVUL8ngKmnb9+/8TKRO98tzHW6gh0x8f2kE5R
         y0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1VP0ON/R/XNlpNpYrF7swSAsbd3KSc6Uo6XVXcsTwU=;
        b=otDTU7FHyhb1xejGKp1LguJmbR2PRj8329GO5MNroxxpDoHJ228FYvkDz7O//KT7u3
         nOtsmmFljH02KMiuaqY2/T3bFx9HVhHuAbpzZoEI5jyysv/1nIPyvw8yn9lV59Y8iJv7
         bFvyxp43qMXhSr9+uIDHkgq5LfXdqhL1rjgc9leBSQiajaUF4taJlfWsFZ3mFjwWxs/f
         v6LDf8VQasPp9IgXhMr3k5Hwxg3+C1Ck+Wi1ofOJUYGhvZCwfmN13Ym2nD0cqfo+KSp8
         sk0Bt7e+5UOEoCYY1yo+foUDPVTSYzpEaerXY564OJXYMKhYqkvAMwRPhBdF/8fOMbEv
         zQsw==
X-Gm-Message-State: ACrzQf0Pba1vmupOb9MW1oWWUzAGE0dOdqFAKzyRMIWmbFsoFqpYbLGi
        wukGBsyC2mGki3jjwksRsWrh/A==
X-Google-Smtp-Source: AMsMyM49TSh6z5LyV/VltfEckXkKbPOSCs7nKZgP8CRF+QeMrA2wQRKiLKxA6RpLVjELI1zL6PAaYQ==
X-Received: by 2002:a17:90a:1946:b0:212:f926:5382 with SMTP id 6-20020a17090a194600b00212f9265382mr62639532pjh.218.1668022871185;
        Wed, 09 Nov 2022 11:41:11 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090ad80e00b00213d08fa459sm1612677pjv.17.2022.11.09.11.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:41:10 -0800 (PST)
Message-ID: <f249f608-d9cf-7ba9-5050-dfc97e543d55@kernel.dk>
Date:   Wed, 9 Nov 2022 12:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221109144843.679668-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 7:48 AM, Greg Kroah-Hartman wrote:
> The devnode() callback in struct block_device_operations should not be
> modifying the device that is passed into it, so mark it as a const * and
> propagate the function signature changes out into the one subsystem that
> actually uses this callback.
> 
> Cc: linux-block@vger.kernel.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Jens, I have some dependent kobject/driver core changes that require
> this change in the works.  Can I take this through the driver core tree
> for 6.2-rc1?

Yeah go ahead, you can add my:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


