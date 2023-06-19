Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA173519D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjFSKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFSKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E60198A;
        Mon, 19 Jun 2023 03:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9313060B3A;
        Mon, 19 Jun 2023 10:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06673C433C0;
        Mon, 19 Jun 2023 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687169372;
        bh=5Np+sxHQIoqYArOAdjg5NCTb91sF1ngya/MfQ0u+IUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6D6KOOkrHQ277+yyUPkKU98ivRv7G57P6kGjaWjmKonQQHqIG7CR8g4QEED2IZdF
         x6K/LHikCTINoUTn2maoonKKZ8DTMZgB5PhPfWLFDnK277lhtSFTulhOWUkNELjRzR
         Vu7yybNJKkxUyxwJLcgGilGXfX3UjaOfo/YbSuwsouatWdjUlvwBnSKpiQ+d//6Qs1
         /+QCwgoV4OLMaPhJTaKD7b1ZmR6IygbTvlDa0M1BWF8stRHpi56h7T1AlLVCMz1buk
         U0it8gLE1yj4lnGQT22MtmBBQhNUQXeGTx/7lOiRECglZqHlK7R1/P4eLRrl+4uyqD
         DlH5nOJPQiTaQ==
Date:   Mon, 19 Jun 2023 11:09:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Junhao He <hejunhao3@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20230619100926.GA13483@willie-the-truck>
References: <20230619143736.39949f20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619143736.39949f20@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 02:37:36PM +1000, Stephen Rothwell wrote:
> After merging the arm-perf tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/perf/hisi-pmu.rst:107: ERROR: Unexpected indentation.
> 
> Introduced by commit
> 
>   ea8d1c062a0e ("docs: perf: Add new description for HiSilicon UC PMU")

Cheers, Stephen. I'll fix this.

Will
