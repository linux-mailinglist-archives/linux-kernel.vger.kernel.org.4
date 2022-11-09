Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0F622330
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiKIEkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:40:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2171F63E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 20:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5952CB81B05
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A65C433D6;
        Wed,  9 Nov 2022 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667968833;
        bh=dTarkc9zobWgtC3VLX/FM6WgyaxxX2BhAsPzHxaUZ5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yDp3zvA3tlAVk6Lt7jBPdp8k/RZlomn0VjDA5/WWgJfCF8woh1VSsij6d6vJ6pcda
         A2a+rnmpJe05HFMCqthU7Z33YFuhJTKYGBRRDwa5bwbNAHXbAQaGFEa8urGRk0DruA
         vmdnRrh8WGWd8bL5evAf1Qlsap12cw21nzFARKI4=
Date:   Tue, 8 Nov 2022 20:40:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 0/5] Implement writeback for zsmalloc
Message-Id: <20221108204032.09eed696ecfdc2dccf331198@linux-foundation.org>
In-Reply-To: <20221108193207.3297327-1-nphamcs@gmail.com>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Nov 2022 11:32:02 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> This series of patches implements writeback for zsmalloc. 

There's quite a bit of churn in zsmalloc at present.  So for the sake
of clarity I have dropped all zsmalloc patches except for "zsmalloc:
replace IS_ERR() with IS_ERR_VALUE()".

Please coordinate with Sergey and Minchan on getting all this pending
work finalized and reviewed.
