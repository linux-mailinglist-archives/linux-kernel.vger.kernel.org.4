Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770A5B3E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiIIRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIIRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E571365F3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0C16203C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE74C433D6;
        Fri,  9 Sep 2022 17:38:40 +0000 (UTC)
Date:   Fri, 9 Sep 2022 18:38:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] arm64: support huge vmalloc mappings
Message-ID: <Yxt6HbbWEqnteYHb@arm.com>
References: <20220907114950.125433-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907114950.125433-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:49:50PM +0800, Kefeng Wang wrote:
> As commit 59089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with
> VM_ALLOW_HUGE_VMAP"), the use of hugepage mappings for vmalloc

What's this commit? I can't find it anywhere.

-- 
Catalin
