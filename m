Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAF5FAB02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJKDLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKDLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:11:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560B80F59
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:11:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c20so2421906plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTAfYsbOtFvtvqiWBTGIW5SrFGY1WvU38VWPZFuksuo=;
        b=PGaSR7UKyhRUOCcgSBulfS7m9SVQfRvoQ9VUGGFPWDD2PumauAxBTOVmVa6sZ72tIN
         FEKCqq1XTMOH9tuQ5VlUuFOsJcPJ9NmAiqqeBQsR8g5ZMQTkAfOgD+d7p9QSLQk7AhKC
         YmxzU9GCheoyaLuwC1Nrw7pLXlka51aqtPrMhi2EVBGrXB3ns8rMpDBNiO5wp8+OSbRs
         MjteoZ5roNjW2OBvIA2BajgXdZRQ7pZIeLSF7KE8MmBpuC5vaLdUv6XnD1HQAbfmYcJ1
         uqEgH6M9tMAm1wbYbpFqro7SyLge4QGZu6zdhjBvc1/+nECWEJovLlEPk8ecE0Y0pNre
         OKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTAfYsbOtFvtvqiWBTGIW5SrFGY1WvU38VWPZFuksuo=;
        b=tH0YyPoh1M0u0eztzto9GrLT9shS6KJd8UlXh7mrJ0xcdKGqAr6d4iUbcqAgpiYrS6
         2vCbmXI0K9fapVYmmy8rcizBrl7ITsEgNwturrU+IpABEMuRV4awY1WHRYD6RESnU4LL
         xyiDztQMKy3jSj7EhpU4NrmgLwyyP9kp5mMUk80gMxC8piPEuzsxjZJsm+bL6B6QI13K
         8t/cFxvN//iJgbMxKMwWKddtb+PhpSLI8RW4QHSM4/mw9y8wjScLlNsXhO7qY00lVFoU
         vthhAU5RVjvmLMj7XOz4Cu4f2VdXFEexlTbe/emgEj5HGG+rk9KVly5mNklw2WRT7ULs
         VhSA==
X-Gm-Message-State: ACrzQf1PVtFK1/+5C42wtBb3SS4wuQpWCit0bmDQy3zmVg4waMWVizcn
        9tWGp6BE35RTOzV5pkO6hW6djA==
X-Google-Smtp-Source: AMsMyM7AsryBn7diqfnZGV99J5DsEPP+gjPJ/BTTrBn5RpG8aEx2pM4fMziiDUvFnGmZybJ0ybfUcQ==
X-Received: by 2002:a17:90a:d48b:b0:20a:97fb:3eb with SMTP id s11-20020a17090ad48b00b0020a97fb03ebmr34324711pju.189.1665457866732;
        Mon, 10 Oct 2022 20:11:06 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id e24-20020a63db18000000b0040caab35e5bsm7005412pgg.89.2022.10.10.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:11:06 -0700 (PDT)
Date:   Tue, 11 Oct 2022 08:41:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, soc@kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: spear: Move prototype to accessible header
Message-ID: <20221011031104.5gvw47ocbhj52oxy@vireshk-i7>
References: <f334e8bcc22fde795de9c8067898d4c0522d44ae.1665375739.git.viresh.kumar@linaro.org>
 <20221011010116.A6245C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011010116.A6245C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-22, 18:01, Stephen Boyd wrote:
> __init is meaningless in header files

Technically yes.

But then I grepped include/ and it is widely used, even by core kernel
headers. Why is that ? Maybe just to keep prototype consistent ?

Also init.h says:

 * If the function has a prototype somewhere, you can also add
 * __init between closing brace of the prototype and semicolon:
 *
 * extern int initialize_foobar_device(int, int, int) __init;

Hmm, I understand that it is just saying that __init can be used after
function's name instead of just before, but isn't it also suggesting
that headers may also have it (maybe just to keep it consistent) ?

-- 
viresh
