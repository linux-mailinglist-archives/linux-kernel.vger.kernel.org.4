Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75FC5F6C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJFRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJFRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:07:47 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFB9E691
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:07:46 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so2331752pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2lSddms9UBPJ6F86/ka6EvptVv6WN5tR4+BrO/DG/g=;
        b=XiMQ8NjD0D6mEevIbZCoZBYIjl2LAtwhdQZAmoicBzyOLhV88SK5pvsvzleJlGtvPM
         GI/nu71QNjx3G39L3krNp6nF4f5I09OsquFKU7stBTUGXHYESbh46hLuz1KsuNpesn5X
         i+ebaOA5xSEJ9UqbIBvC1ww8cqUkhdz8j0J/bfENOWIPSdUFO6m4O37eh1usBuJIBlf4
         hoACeCIwN8AXlqp0uyAbEcnYv4grpHS2GBSFAseyiaF0I5+G/X+5xmnBWtp30GKUm+DW
         u/gEJmYzVtqy4RpsFVmU5LfMTQBEEFwYRR2a64IL+D6rWYxD4alnIirHuBbVnM534F/K
         bl+Q==
X-Gm-Message-State: ACrzQf2WO42CAOM+P10kgJMbCylctqlCB3ah1ETz852Qi7YrXN/HyduP
        PUnoc2pghB4E9Xq7mLKjJHUoucs4SuXkDg==
X-Google-Smtp-Source: AMsMyM61TYTGDq+TBDGn4KzHjDT6msmo21gdzGXWQJISwyD86MAfA4Y0jBEdCDpNIPwQPGnlkmB8KA==
X-Received: by 2002:a17:903:181:b0:178:703f:689f with SMTP id z1-20020a170903018100b00178703f689fmr780386plg.129.1665076065710;
        Thu, 06 Oct 2022 10:07:45 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1d3c:9be0:da66:6729? ([2620:15c:211:201:1d3c:9be0:da66:6729])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903404a00b00172a670607asm12454834pla.300.2022.10.06.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 10:07:45 -0700 (PDT)
Message-ID: <712a9412-795a-29ae-002e-4a77356ddffe@acm.org>
Date:   Thu, 6 Oct 2022 10:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: include/trace/events/jbd2.h:356:1: sparse: sparse: cast to
 restricted blk_opf_t
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202210062152.UVjgI2io-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202210062152.UVjgI2io-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 06:49, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
>     fs/jbd2/journal.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/jbd2.h):
>>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer
>>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer

I cannot reproduce this. The above warnings should have been fixed by commit
92d23c6e9415 ("overflow, tracing: Define the is_signed_type() macro once").

Bart.
