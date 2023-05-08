Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193216FB636
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEHSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:10:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BF31FF3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:10:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760dff4b701so30234239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683569437; x=1686161437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JwdpXEqQ97bUhW7TY+tMNOxyUp0iCeINu8skmwdk1w=;
        b=GS5V6DL/7Zyr+A2S1/NJkb3Pc7aR6/WG8EJxLSFlE6N4HGSdZ41QHV+XsgfhAiya+K
         ViG9pqxlWrmKoWg5CGIQb9e7k1KNeuBBGJx0GA38PwwyjBICRq/tPS/l+0/FP/aGt8M9
         VKMQwyegiSWm9I8V7BVjiHy0OpFElpnnUvrnhzKjCAsmfFWVO0isU8uG3rZ1y+2FnjoU
         zs9SB7iTVll6rHVOSIwCMjiO45IVBHtFx4BjDnhFvvXrjjs4zabOutc/mZ5sCJu3/b/u
         eTZagGu87pjMQk8pbqWqrERuB0OmcPgWuK5JfYJVNt/HFTOq2eduifjUAf4V5YSATbBZ
         YGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683569437; x=1686161437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JwdpXEqQ97bUhW7TY+tMNOxyUp0iCeINu8skmwdk1w=;
        b=KqSrnpOdNbPoFYCvUVXJ/XjgjKkwQ6PeGO/On1jevUiAKefMtsNvMUVKx0jy4szKuu
         dvP66nFOKTPGGLwlTb6k59eNHpRLEYtDkToSN/Mp0jwbrxSs6yon/POvTxfjPhv0iktP
         temwS407wsK3i5cKfBRGQaunXVyUfU2DDvNrEaSsqJ0CKh3XPbtD2p9ZKvjzLZJTEk6d
         X29EX8wpiguWOQgDfJRf9SmyQRHvOyqqeBgYAwn3UzG9L685K6ieFvNy4t/pjuT16WoZ
         VT172HQfjrlB6e8Mk35bVFmGkywBgk4XvKy2XjsXrhN4rbP/5p0mvmrohZtuZEdm3YMJ
         7dYg==
X-Gm-Message-State: AC+VfDycsBUPHKGqp8L5lQ6fiLsrYbHRqMhFl4QzmdezF+kidFnSUPrT
        gpRXAtkxKe8t/slFZ7N0HTG2FQ==
X-Google-Smtp-Source: ACHHUZ7Bo0SElwGUOYsOnwAYt4Wefi9lrogdHn4e+Asn1KDEkBgnhpQv3VyKYmyLLGplyYeM8f/tqw==
X-Received: by 2002:a05:6602:2c81:b0:763:86b1:6111 with SMTP id i1-20020a0566022c8100b0076386b16111mr7936790iow.2.1683569437467;
        Mon, 08 May 2023 11:10:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i33-20020a026021000000b004165f64968csm2176407jac.103.2023.05.08.11.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:10:36 -0700 (PDT)
Message-ID: <0df23fc9-fcfe-cb53-3ee6-ced88751451e@kernel.dk>
Date:   Mon, 8 May 2023 12:10:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] io_uring: add dummy io_uring_sqe_cmd() helper
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Breno Leitao <leitao@debian.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508070825.3659621-1-arnd@kernel.org>
 <ZFkJ2x+XCMmDzOR4@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZFkJ2x+XCMmDzOR4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 8:40 AM, Christoph Hellwig wrote:
> On Mon, May 08, 2023 at 09:08:18AM +0200, Arnd Bergmann wrote:
>> Add a dummy function like the other interfaces for this configuration.
> 
> Why do we need a separate dummy? The structure is unconditionally
> defined, so we can just unconditionally define the helper.

Yeah, no reason for a special one. I'll send one out.

-- 
Jens Axboe


