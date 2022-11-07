Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DD620154
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiKGVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKGVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:38:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAB286E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:38:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15975568pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSWBCInOZ8lwFHElcVyXM9M7hAq+ZgJBwiXC5LNk8l8=;
        b=wc3XAxBhO7EcBC7IA+DKdEhYRrW6f1yY582PnntGpZLqizr8aubu5L/NCA/5EOr4qf
         5ON/t708ML0UW9xnNdyY7hpb3j3eclCc3YHprz+G3jNlCyoloi76w2Kr1CJjOpI7p+by
         C0Cqzk1cKE4UG5Vu8R9enWCm/gPVUWkAEtZ0+y+lDyTnr2kYjmd8CfoXNAdOpqBXxq2A
         glnhm5Yh81OOPhm5qPkdsdgenuZxjKBHA6U/5zTMWR2zLXfGeVC2H3CoGYI1QL60MmET
         GFvTfMR9lIja2n7IHcO/njAEu0yMIrhg3NhbYy3aeUe8/vQO9iiCJ04LihMv0DA58XRt
         uAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSWBCInOZ8lwFHElcVyXM9M7hAq+ZgJBwiXC5LNk8l8=;
        b=wL05/vdWGWtLr4Sp1JnQ2LsNfDT6eXZO/S5eSMo7wmb8oMX6/gfmIIM/KAjxZwEjH5
         efuvLURyKxRjDyiKVMj09yMm4srL/JNmJQPVLnAgyQRKtEnP6abY980RyA9zEdkpuC4b
         dwbXrjqy6Jsc/mEC4xSiXLPWTQggywjI2mSQ0sWKIQjKWkChKqYa+dxZBp9clMjvoZ55
         Xb/bE7nATFf0phQcGb1OonaH8taXBsW5dLGjPcojS29Psnpg+SY5mSToPedievXUANcy
         +BTguhmU5LlWvSM7SSFq8e2xx1CYYBHznAjCh5wHCzeu1JcHE0Fb8BjpSYYQmDw/k8KO
         F2sA==
X-Gm-Message-State: ACrzQf2ajCghyYe/v3nTo+yoLkypwfCgdq63Xj/jfJtneF1UHmIRqLvR
        2MWGNAGn8Y6e7XUsKPJ6cErjsdSCfenWuQKU
X-Google-Smtp-Source: AMsMyM59vlvK4QKSlQqEVwfH9zxOo7I1Eiz8PJWD2Wsgj6iePiXCB+R8h2/hfGUwR00kay24T3GYKw==
X-Received: by 2002:a17:90b:1c88:b0:203:8400:13a9 with SMTP id oo8-20020a17090b1c8800b00203840013a9mr54920141pjb.46.1667857133644;
        Mon, 07 Nov 2022 13:38:53 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 101-20020a17090a0fee00b0020669c8bd87sm4679555pjz.36.2022.11.07.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 13:38:53 -0800 (PST)
Message-ID: <4281b354-d67d-2883-d966-a7816ed4f811@kernel.dk>
Date:   Mon, 7 Nov 2022 14:38:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCHSET v3 0/5] Add support for epoll min_wait
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <Y2lw4Qc1uI+Ep+2C@fedora>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2lw4Qc1uI+Ep+2C@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 1:56 PM, Stefan Hajnoczi wrote:
> Hi Jens,
> NICs and storage controllers have interrupt mitigation/coalescing
> mechanisms that are similar.

Yep

> NVMe has an Aggregation Time (timeout) and an Aggregation Threshold
> (counter) value. When a completion occurs, the device waits until the
> timeout or until the completion counter value is reached.
> 
> If I've read the code correctly, min_wait is computed at the beginning
> of epoll_wait(2). NVMe's Aggregation Time is computed from the first
> completion.
> 
> It makes me wonder which approach is more useful for applications. With
> the Aggregation Time approach applications can control how much extra
> latency is added. What do you think about that approach?

We only tested the current approach, which is time noted from entry, not
from when the first event arrives. I suspect the nvme approach is better
suited to the hw side, the epoll timeout helps ensure that we batch
within xx usec rather than xx usec + whatever the delay until the first
one arrives. Which is why it's handled that way currently. That gives
you a fixed batch latency.

-- 
Jens Axboe
