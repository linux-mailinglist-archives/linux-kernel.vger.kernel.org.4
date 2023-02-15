Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E446698286
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBORo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBORoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:44:46 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436203C29D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:44:40 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h5so1925329ilq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtgH/fLyPn1TKILRL3koJ5mg56zLiB975mZQLiqUguI=;
        b=mH8VJE1p5+OhCEWSUv3z+9o98q/PbvjH6Q7VJBvRQtGPp0fJFiADRN3wtIcGQsytPx
         YAv+5YiAJqrGOCBT7JerEi2/zGvFFgCXNLdUeNxiincWgh5lvXdsyIMzWEyqNj79E+Bw
         Z6t16iJfKEeevG518I76lDBrHhuWvGFWnI8rzcOAV6U11RxkzhL4AdHm/+u+XKw4QzdL
         t6JkSEZwDsnA14Z3fQUzayGpLQpemlYngA/iEzt5TFpNPAesTF4AILx2NVFwPaOYHvt8
         AKqnwklheYtPAbgDijxFHgAYpi4K4uQf9JC/P+C9ukmPFC1Si3JN1A8vJXPfuGmz4khY
         065Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtgH/fLyPn1TKILRL3koJ5mg56zLiB975mZQLiqUguI=;
        b=hAvrLikOv30GY/2/lu6Wko10XxGSxG6skBK9VeWaKFbMuvyPvAR7Nur0eEqpUzFJPK
         hMyP5Zgf1ewPtQ2qyrwN8ocDK/pFTgtTWDrcJ0D+TT9ej3JFHrvFFdmzM2w3Xh9LVXwu
         /JxJy34daBcR7xGm35ugQuBIL4/CLHpZzbWdqM8L1/L6ZfBMyqZpr0NzJwuZ7Eglncxy
         4MqZOlpPWu8uihcjQ2t51oGMj6spY07jGmi5tibuhomWlu0aqDDmGSt2E63dY3tz+0kk
         AyddgNNzlEAyKJ+U2VBHfxGRcfDXj68OL3ZTLrijbE03zLLWe/EQivVpMz5hqV6z2onT
         xC3Q==
X-Gm-Message-State: AO0yUKUoMxO3cXNnr5JVGtU8vttKRyHLOEB7epbRF3OwnWmBNVDO+S7o
        GIxqIcoHrnZKVqTRicBbERGEOILcaF0GGkk4
X-Google-Smtp-Source: AK7set9hOQmrEaC37Zt0I/dqH2TOSnuOZs1BBefVHH7Zgdgts8DI8ksvYJPVhcdrIxTxKNr2T7hn3Q==
X-Received: by 2002:a05:6e02:1d0b:b0:315:29e8:6ef3 with SMTP id i11-20020a056e021d0b00b0031529e86ef3mr2608502ila.2.1676483079424;
        Wed, 15 Feb 2023 09:44:39 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b00310a5b8504asm5807571ill.36.2023.02.15.09.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:44:39 -0800 (PST)
Message-ID: <03895f24-3540-dae9-1cdd-e3f6d901dec6@kernel.dk>
Date:   Wed, 15 Feb 2023 10:44:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCHv2] io_uring: Support calling io_uring_register with a
 registered ring fd
Content-Language: en-US
To:     Josh Triplett <josh@joshtriplett.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f2396369e638284586b069dbddffb8c992afba95.1676419314.git.josh@joshtriplett.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f2396369e638284586b069dbddffb8c992afba95.1676419314.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 5:42 PM, Josh Triplett wrote:
> Add a new flag IORING_REGISTER_USE_REGISTERED_RING (set via the high bit
> of the opcode) to treat the fd as a registered index rather than a file
> descriptor.
> 
> This makes it possible for a library to open an io_uring, register the
> ring fd, close the ring fd, and subsequently use the ring entirely via
> registered index.

This looks pretty straight forward to me, only real question I had
was whether using the top bit of the register opcode for this is the
best choice. But I can't think of better ways to do it, and the space
is definitely big enough to do that, so looks fine to me.

One more comment below:

> +	if (use_registered_ring) {
> +		/*
> +		 * Ring fd has been registered via IORING_REGISTER_RING_FDS, we
> +		 * need only dereference our task private array to find it.
> +		 */
> +		struct io_uring_task *tctx = current->io_uring;

I need to double check if it's guaranteed we always have current->io_uring
assigned here. If the ring is registered we certainly will have it, but
what if someone calls io_uring_register(2) without having a ring setup
upfront?

IOW, I think we need a NULL check here and failing the request at that
point.

-- 
Jens Axboe


