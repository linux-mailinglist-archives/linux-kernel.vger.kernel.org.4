Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7BF74DE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGJTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGJTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:47:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E4187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:47:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so733948b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689018462; x=1691610462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wx6jz07CguKA7YsY2NRJvMLsnINssTVQYdDo1GqP/S0=;
        b=0WbQHgoaMO2YKQRgiCfjEHrrT2yuQHX/f5+FVtNOd/TF+XhAcM1rFA3VH7tFY0mCOB
         Ok/u+UCt99IWrtDyeipbwp/Rl6F2lOxRKm45S5oZKg+y0QUCcsiUe9x5REQoJWdeHwax
         k+NqygxlmdkXYtrHGg15uk550SRgl0j3jCMPpq2Ow3c6gX017KTkbmBSfvKKSlGFmeY5
         mn/lwxJ7pCHqBt4Qfc8lULN6OMs8I0oaVjAzAOGgVTJz3nKSkb/mZ2EuAHF+zP7RbtVk
         Iy8FNQUYVzbGoPKfvmKvR3eDc0rM/5aL7Unx8ejt+MkTUv/32WHlwbg7qg9emODucEye
         dUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018462; x=1691610462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx6jz07CguKA7YsY2NRJvMLsnINssTVQYdDo1GqP/S0=;
        b=li2Aq8e8Ysu7c4ZTfDd0Oz4AOGqvwVETN39IbIDo4/BcO/orJAXrmv4ntiNK0gAjPj
         y3xS2E390XB+PiSgwOcQQVSLQ47CRgsCKehhq1DZfAyFxf18nHX/VapLQf38f2dmheSz
         CXU5O0Z91q2XPB+X9xJT+/uTCfaxTgMqAoXLaT3/Hy2GPNlLqHrAqBaW1nH2Spb9cZ66
         pSkzuqTvBfeANiA2d4NSkKYAkGcUwI39HI7T09TCoQB8tpeM7vnNQNum05KosJP3Kzex
         RgIOPPPyBL7M9EyM6i4aQp7VZb8BlQBtEPIid9P0qCLv9bN9CUTlhL6mT+zU/xkskxqk
         MmQA==
X-Gm-Message-State: ABy/qLZAAJfwAa5N4pLVrn+5hUb5rs/xHkC2z1MNRCXbOmPcgC9IkeoM
        fQsQDoITil2hMudFBw3p/AmU+Q==
X-Google-Smtp-Source: APBJJlEjX5EE9AMOjnRkIhttTAuRuoQbE8zIt1M3jXvoaVqZ63sguWSrScz/k8tGFCDwa4d3c6QKJA==
X-Received: by 2002:a17:902:d4cd:b0:1b8:17e8:5472 with SMTP id o13-20020a170902d4cd00b001b817e85472mr17625205plg.1.1689018462501;
        Mon, 10 Jul 2023 12:47:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090a714700b0025bdc3454c6sm6749421pjs.8.2023.07.10.12.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 12:47:41 -0700 (PDT)
Message-ID: <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
Date:   Mon, 10 Jul 2023 13:47:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, tj@kernel.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 4:55?AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The iocost rely on rq start_time_ns and alloc_time_ns to tell
> saturation state of the block device. Most of the time request is
> allocated after rq_qos_throttle() and its alloc_time_ns or
> start_time_ns won't be affected.
> 
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we
> can rq_qos_throttle() after the allocation of the request. This is
> what the blk_mq_get_cached_request() does.
> 
> In this case, the cached request alloc_time_ns or start_time_ns is
> much ahead if blocked in any qos ->throttle().
> 
> Fix it by setting alloc_time_ns and start_time_ns to now when the
> allocated request is actually used.

One of the single most costly things we do in the io path is the crazy
amount of time stamping that's done or added without attention to what
else is doing it or where. And this is why we have a ton of them, and
why the batched time stamping made sense.

I'd much rather see this just get the saved timestamp updated when
necessary. If we block, that's certainly one such case.

-- 
Jens Axboe

