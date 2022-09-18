Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B215BBB2B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 04:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIRCgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 22:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRCgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 22:36:46 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6BA240B2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:36:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663468603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mt4EevSP2UXpOuDshgDqIVBSaTOuTupp17SEl5NDqXg=;
        b=TJvEPU5EJxYQYfqjeqgXwtBInyVyBZ9dIKb7eJCybflERk/L6hMKDFVlSpHNOVON8Tey/m
        DSCEb9RgIRzqUnB9f+AQLBzUD3udAl/bn2PFN9r/Lr8xwJg5W37xRYbRY8KsLPX/KUSL46
        PwOhViZkUj8Q5M5elAIVdQs7HM/kApA=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon: return void from damon_set_schemes()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
Date:   Sun, 18 Sep 2022 10:36:39 +0800
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Content-Transfer-Encoding: 7bit
Message-Id: <6843CCD1-F6F3-40AA-9A5C-7DFD65475864@linux.dev>
References: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
To:     xiakaixu1987@gmail.com
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 16, 2022, at 23:20, xiakaixu1987@gmail.com wrote:
> 
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> There is no point in returning an int from damon_set_schemes().
> It always returns 0 which is meaningless for the caller, so
> change it to return void directly.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

