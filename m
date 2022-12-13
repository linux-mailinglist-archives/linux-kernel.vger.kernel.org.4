Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92664AD94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiLMCXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLMCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:23:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A52D5FE2;
        Mon, 12 Dec 2022 18:23:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 261DAB80E06;
        Tue, 13 Dec 2022 02:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A6BC433D2;
        Tue, 13 Dec 2022 02:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670898185;
        bh=4dd0Jbjx0gjIAljkmA0ZgSH+i9WhUDx2iCgULP7i/E0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X0HDRs3avxe+K/MYbWB6BMM0/LmaRrkAg7glg+raHBuLqz/wqrjVxgQF9Ag0CyoFt
         7Ce2timhwby7O+C9TqZi/wWJ/PwJDm4m5Gox/fUB5AcILVJ/8zYBNQz/nrCzN0FH7g
         LAx2ahqr3StMu4/N8zAvp6um4SHt+i+EF1yBel+c=
Date:   Mon, 12 Dec 2022 18:23:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Message-Id: <20221212182304.fc148bf08bc17e58ec4b6674@linux-foundation.org>
In-Reply-To: <e8dfaf60-ff35-66d3-7bc1-f11eaaef642a@huawei.com>
References: <20221213093054.5211da74@canb.auug.org.au>
        <e8dfaf60-ff35-66d3-7bc1-f11eaaef642a@huawei.com>
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

On Tue, 13 Dec 2022 09:34:24 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Hi, this patch relays on Tony Luck's Patch series "Copy-on-write poison 
> recovery".[1]
> and tested ppc64_defconfig based on next-20221208, it's no build failure

I reordered these a couple of days ago, not sure how Stephen got a hold
of this tree - perhaps I wasn't pushy enough.

Stephen, quoting the mm-everything tag would be helpful, but rarely
useful so only if you're feeling bored ;)

> I think it is not very hotfix, also will send v3 to address some comments
> we could adjust the patch order in mm tree, thanks.

This patch is still in mm-unstable so updates won't be a problem. 
Soon, please.

