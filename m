Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841E601605
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJQSLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJQSK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:10:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080E7287A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:10:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y191so11843772pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moxKXe7U1ebuMzqu7/cZGChet+W4gvv+t8NNPuSo720=;
        b=XY0kF2gzGSA1+uw3SMLARMefKSvfWCXE8ZiDDlepUNu99ZYVA3r/SBHgaqYw3Mg0ts
         v5stIB0KkLpixzZIq7wotGiIooIZkdJ8os3Fog1avvzZlUAHZaNIPp44b0Ma2DRd6E++
         TyZIIfFeO8+Tqs0V4KuNtdAU9PthXqnfCmA+lyzivuajvfgb97uVydZ+AVHmCD2yOLpC
         gAQAcItx1SOLPMykU+flvQoS3Ft0ss4HNZk+qcFVra96Itv7jZhD2LH8zN0DiHmm0yOC
         XrC6zoYfYSUqhFZdU8oL8HrKtop75wK1NnnfegOnIROCE9xQ0jvhr8TmOgNg8aBhHiwi
         1raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moxKXe7U1ebuMzqu7/cZGChet+W4gvv+t8NNPuSo720=;
        b=vZOut5+wV0kXoRovt2C9XH3TlfBA4TIa1vQD5vMpEdv7B2HQFDNzwnHQPYvOST02yO
         MuJ2ryDbbXw1B90f+K5Y/10665Nnhk/oLPnimhqEdZ+cTlhxEy7gGVu0iSi5mL3CUWhk
         Qre3+AgwDyDcBlT1fc43EAQ7BHtArERHmUCu3MCOYamDgxoz8a3/zy4pWmFW5L9WGXJD
         UKOh1l68jbjGGpNxda1y7q8N7A72jwpj1MC5RMTcN5R0aKvznaN9oNsQS8Qgq49jnap4
         If/aBdQpDOC1PbxTOqysZ4P9gghBuavlRPfbBpOZvSOz+qIOhrUl8I4z/Qc681yo2m9Z
         3Krw==
X-Gm-Message-State: ACrzQf3ljNN1pUIOo5iaJQX9ATxnOcbOLeORn7IRUKdxs/nsEeYNqWWb
        KclrdRYmzySckJqS6Mn2PyC/Rg==
X-Google-Smtp-Source: AMsMyM57hkAdLilgEOnNj8HB9ePsvlL/RYriF/tFJYYUFcy9FcGFY4mlR4OXBdTCbRTwUrsYVAWftw==
X-Received: by 2002:a63:5a5e:0:b0:434:b739:206f with SMTP id k30-20020a635a5e000000b00434b739206fmr11694182pgm.82.1666030256660;
        Mon, 17 Oct 2022 11:10:56 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm6900180plh.117.2022.10.17.11.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:10:56 -0700 (PDT)
Message-ID: <b8319bd7-ff28-5c79-a024-de8a21acedba@kernel.dk>
Date:   Mon, 17 Oct 2022 11:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH cgroup/for-6.1-fixes] blkcg: Update MAINTAINERS entry
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <Y02aBVTCSggxKWXT@slm.duckdns.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y02aBVTCSggxKWXT@slm.duckdns.org>
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

On 10/17/22 11:08 AM, Tejun Heo wrote:
> Josef wrote iolatency and iocost is missing from the files list. Let's add
> Josef as a maintainer and add blk-iocost.c to the files list.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


