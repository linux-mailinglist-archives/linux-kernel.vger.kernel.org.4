Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2675BFD14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIULns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIULnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:43:46 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96888E4CA;
        Wed, 21 Sep 2022 04:43:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5D40D418B0;
        Wed, 21 Sep 2022 11:43:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a307 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5FC65411CD;
        Wed, 21 Sep 2022 11:43:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663760618; a=rsa-sha256;
        cv=none;
        b=iVMTa3gS5VZ5HmlUxlSScCNmQTCsA+uYNzKUBUi9W3UYp/CBQNIUGI8/mBBg23w4WrOsJV
        pjl/Ls+rCFmt7F5m8ephBwPkZ1DPkUQ9Fk83lzWAyvMdUmZncAN1ypNU5QLo9QmWItdy9F
        BbWHfKJw6PG9lf5UzqEfkEaOhmQHMxEE+H7CfsWO5lfX9mGWUoiU3alu61UqyFL7/HCkKn
        CCCobfGSjsPPMlqr8C8E7niMEGE/FuN9SmUDUXIY02IdbnsqlDJV0BhmLk/CJ8W4UVghJa
        n+MuNgFU1sjl5d1aL3k2ZfV2fFEXKwILuKhG2gwu1xWMf1nNSVmmwuYgTGsWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663760618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=47nEMkjYsLXQ6Ot/FDVaWGYLcBDevAZpyjCyYbZxiw0=;
        b=sLJFUVksGYsPfzsSBmqD7UC5msm82YRMwx3/Ib2fUdfK5o+ThJ5rndJyXfXNkBIYK36yEi
        LBIDB1UzqFqMNJnsLgNs07VT/2zjBs7Uuzfvhd6D7+bflW3kZCqKKeHt4T190GlU1h7jDP
        EBiAGBftWa5tWr/IFQqmLxj8PAqdEWRDkLTEFMHr72w0FrWgaZ5CIiliOAgGIb6rWkqeDk
        qlZQUoXwfZmXyWJ2u0h//7qIV042IKy4kUSc9/9ouV9aVJOjkIn6V5Nzii3i5o1U8MIH6Q
        yymWol194KEGF0YmbsInIE6ZvkHnDXcHavjE3L0RNsssQWIP6PZUDnHj2rOA/g==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-wstrr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Spot-Madly: 26531f3901adeeb8_1663760619146_1954411553
X-MC-Loop-Signature: 1663760619146:744041307
X-MC-Ingress-Time: 1663760619146
Received: from pdx1-sub0-mail-a307 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.234.205 (trex/6.7.1);
        Wed, 21 Sep 2022 11:43:39 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-16-184-147-84-238.dsl.bell.ca [184.147.84.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a307 (Postfix) with ESMTPSA id 4MXc496vrVzYH;
        Wed, 21 Sep 2022 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1663760606;
        bh=47nEMkjYsLXQ6Ot/FDVaWGYLcBDevAZpyjCyYbZxiw0=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=CZUfUAJpWTYlImU2ZXuYcyQK007mxDfXXMFolecWpXffOmrOZKKZ68zbRiCD7X1n4
         eMyOtl29ST3OvtwAAr/ksKnX41fYQH5Of8gFdZ3MaXE/8jJNlDrCIHDAL42G4hxInw
         CAQC5eRQiqDtCl04fn/58I371UlzKf4CbqiiDCn3h+gvGaaIWNixw5PVqIu1peXNyu
         NtVn0C4qu8V8MLqPrBoDfS09USVcUDWmFjVjQmnWjQLQ6t5XcZulp3r55O7Nc7Bg0P
         US5UMMdWoGtAYEOOzPzUN4N+2mjRMtdcJ6SvWv9TLBVqSLwltCiVX4FJWE/qbEvEsf
         ud2nnmJ+kCejQ==
Message-ID: <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
Date:   Wed, 21 Sep 2022 07:43:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20220920192202.190793-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 15:22, Kees Cook wrote:
> Since the commits starting with c37495d6254c ("slab: add __alloc_size
> attributes for better bounds checking"), the compilers have runtime
> allocation size hints available in some places. This was immediately
> available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> updating to explicitly make use the hints via the associated
> __builtin_dynamic_object_size() helper. Detect and use the builtin when
> it is available, increasing the accuracy of the mitigation. When runtime
> sizes are not available, __builtin_dynamic_object_size() falls back to
> __builtin_object_size(), leaving the existing bounds checking unchanged.

I don't know yet what the overhead is for __builtin_dynamic_object_size 
vs __builtin_object_size, were you able to measure it somehow for the 
kernel?  If there's a significant tradeoff, it may make sense to provide 
a user override.

Thanks,
Sid
