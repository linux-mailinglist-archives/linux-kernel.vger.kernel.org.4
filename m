Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00846D6754
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjDDPae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjDDPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:30:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12144AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:30:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j6so17274095ilr.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680622228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzNSpfOpCTuck8DnK8SYlplxYem4pCgcVOgCOW7X72Q=;
        b=HJqohBGu0ap700/lP3wszi5dAwYizLpfMBxcWnnepxoRsA0u+eULnq1QzQVgqcezQV
         ITHRuVl0LpwlqBAHe/Y+Go4zzCoKLwQa9NwMLo10mSAeWty5mnFvNdM5RXjiG5XDXaEo
         QjxqV45MlOZhrglZZd9AukDvb7MFaE57mvXzPd9ch2lhS2fIdqUEd3D68l2T/K3MIpvB
         Eeu3h3mwIKZEB8Gg+wQ3/NN6YzBfD9p9un54kPT0vjA9HPGtKYgl56v7Kx+s4PneCxtG
         KYr1gKqYn1xSH3En+RdoXbRsr4y7UFuX4d+2VVL53OCHoFedvvIuNaGjBEHnynqUtgZq
         pqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzNSpfOpCTuck8DnK8SYlplxYem4pCgcVOgCOW7X72Q=;
        b=bUmvt6TFtGt+PCghj+4PMNHQMjMhC/L6waq/jXixoF1GkehVltyCdepS16wa9Udwia
         oiTW1dnD2MBsnaHrZjLB0I50FIWpcMesNcbhZ0qQQnhoI+ZavM52RZ3NL+y5flMxlHLD
         4M5F8WMOHhS6Vk8+KEl3zIrntAfMSnt3PINwWLqmS9yGvGULjocUm/crhfhDjHTxn+1e
         WpD8QzapFKfqrsH231oeGPtSH30otMuMs81Az3ZNrAhSEyW+P+Zc0U94XDpHLQCaMaNE
         6+ZycWzHgTmA4K0HGojKEZP5a7gu0fAUoe23fwQUINB3df064sTuCAOc8MLh0JA8pN0v
         k/9Q==
X-Gm-Message-State: AAQBX9cwYPOEc4ytpzbgbtH82hRGHqqQwbYMDx9CE+fP+nyXPwHxOoDB
        ZDRdOFF4Bg0ui4zQkzpuo5BZt0Kl0bzTvNMBNL6Avg==
X-Google-Smtp-Source: AKy350Ynu2IICpKmSUtrwSDC1BYFYl6/1Te8mjo0+igGYoWBUBvH5gm0XsWYTG/+Haraw2xC0a+dSA==
X-Received: by 2002:a05:6e02:2191:b0:326:1778:fae3 with SMTP id j17-20020a056e02219100b003261778fae3mr2061450ila.2.1680622228157;
        Tue, 04 Apr 2023 08:30:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c20-20020a023f54000000b003c2b67fac92sm3435429jaf.81.2023.04.04.08.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 08:30:27 -0700 (PDT)
Message-ID: <d72f1acd-e0d7-6937-a263-00ebda4e3d61@kernel.dk>
Date:   Tue, 4 Apr 2023 09:30:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/13] optimise registered buffer/file updates
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1680576071.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1680576071.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 6:39?AM, Pavel Begunkov wrote:
> The patchset optimises registered files and buffers updates / removals,
> The rsrc-update-bench test showes 11x improvement (1040K -> 11468K
> updates / sec). It also improves latency by eliminating rcu grace
> period waiting and bouncing it to another worker, and reduces
> memory footprint by removing percpu refs.
> 
> That's quite important for apps updating files/buffers with medium or
> higher frequency as updates are slow and expensive, and it currently
> takes quite a number of IO requests per update to make using fixed
> files/buffers worthwhile.
> 
> Another upside is that it makes it simpler, patch 9 removes very
> convoluted synchronisation via flush_delayed_work() from the quiesce
> path.

Ran this on the big box. Stock kernel is 6.3-rc5 + for-6.4/io_uring, and
patched is same kernel with this patchset applied.

Test				Kernel		Ops
---------------------------------------------------------
CPU0 rsrc-update-bench		Stock		  165670
CPU0 rsrc-update-bench		Stock		  166412
rsrc-update-bench		Stock		  213411
rsrc-update-bench		Stock		  208995

CPU0 rsrc-update-bench		Patched		10890297
CPU0 rsrc-update-bench		Patched		10451699
rsrc-update-bench		Patched		10793148
rsrc-update-bench		Patched		10934918

which is just ridicolous. It's ~64x faster pinned, and ~51x faster not
pinned. 

On top of that, it's a nice cleanup too and reduction in complexity.

-- 
Jens Axboe

