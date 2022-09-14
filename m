Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F65B81CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiINHJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiINHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:09:53 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1E12AF5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:09:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663139382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVX6wYCHr1Muv7U0ni5Gzy2veBGOaOy55vMQEkKeVcQ=;
        b=Uld1IRw7cd2UeCsv9VvNSYSOIwpWe6WMbNLFPrY9Jm3N/ueWiCELRf6BnRNL/+AT8xkzvK
        pvrT2q2C5VNEpByBOm6RPh815qDwHDO5OB7/ETDNXA6U4CvmliwBCHQ0zDPly8ibYVmrQ/
        2I9NW4SdJhl2vKELRqBR/VrIe5qDtlI=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon/sysfs: use the wrapper directly to check if the
 kdamond is running
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
Date:   Wed, 14 Sep 2022 15:09:38 +0800
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D28241BF-FEE4-49C1-AC4E-B1A48240E193@linux.dev>
References: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
To:     xiakaixu1987@gmail.com
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 12, 2022, at 23:11, xiakaixu1987@gmail.com wrote:
> 
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> We can use the 'damon_sysfs_kdamond_running()' wrapper directly to
> check if the kdamond is running in 'damon_sysfs_turn_damon_on()'.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

