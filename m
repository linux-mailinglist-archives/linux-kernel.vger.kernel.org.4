Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A070682EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjAaONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAaONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:13:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEB5FFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A20F2B81C96
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868F9C433D2;
        Tue, 31 Jan 2023 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675174388;
        bh=0c1biNhNyBNFlLfWvxlNB2PctpozsZejcTkEbXClTPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWkA18MpSk8e7EArBgXV3SfFeRKbScuWpuGCxaYVTee28m7IlXjsVBdtu1I16SBtL
         9XC9BRoCAg8F+PAPbxUEtPWEkRztsX0sDOji6FjZ49UjlG8hwHxLJ/3g6TfUt1E8pJ
         3uAvfHGvCuikMykMeUZGIsD23n7u8xnayp+jkS4ydz6qlJqlUCNNrHnZI42FUy5Aaa
         ZLCh3CCBTACmwUfF2Th0c50XIwut9yFaaEkBCZ4BzgfNuelhmtnwxHFVM0fw6JPsY2
         TyHRzwwH29fV2bRKn6Gv5cFW8Kwl6KbssxohBnrJgkfzw7MCxWjYbcNkh4yGCR56KS
         f3895kHF4ucLw==
Date:   Tue, 31 Jan 2023 16:12:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Some small improvements for memblock.
Message-ID: <Y9kh59lEjJ7PoID0@kernel.org>
References: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 05:00:32PM +0800, Peng Zhang wrote:
> Some small optimizations for memblock.
> 
> Changes since v1:
> - Delete the second patch that complicate code
> - Adjust the code of memblock_merge_regions()
> 
> Peng Zhang (2):
>   memblock: Make a boundary tighter in memblock_add_range().
>   memblock: Avoid useless checks in memblock_merge_regions().
> 
>  mm/memblock.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)

Applied, thanks!
 
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.
