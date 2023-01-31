Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B3682056
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAaAEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAaAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:04:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC7D184
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F218CE068B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5635EC433D2;
        Tue, 31 Jan 2023 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675123438;
        bh=OoMr6vXX+ozdyLfbfDdKFYHI0TxUbuwdprwgLlEpxTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soSpiZ1MOsntQQHqthTSB6YqIMCIC86+144cpdUDH8MNGnKpRiEH1tzluG6nwoAn2
         JnUEjzmw1QNjr6DO9LeQKSHFyY6QYm8jERlTRq7k0BpFT7F3hQJ4FNjcOF+owP3ykk
         9iptSL4F7BLtezjpoxNUYnWtNSuUKE2om6rkjxE9A/Si5acdFaFEZq36gBhc+stvQF
         R5vlwTz9nbjDIc/42xkxnXWUkEpRTuuy5+sO8RRsd0sWvKu0phAmshuAtB9Ho07ZQN
         5PDGBBWVnUXu4PtAnDe9U9DLG38BeYWPHflQ5G5jWJztJI+v/1So3u4mhnLvEMdZiU
         AMWfMXycmZMZw==
Date:   Mon, 30 Jan 2023 16:03:56 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] objtool: reduce maximum memory usage
Message-ID: <20230131000356.5u2siglndnjyarql@treble>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20230129214339.76hyytrllggbvuat@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129214339.76hyytrllggbvuat@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:43:39PM +0000, Thomas Weißschuh wrote:
> On Tue, Dec 27, 2022 at 04:00:57PM +0000, Thomas Weißschuh wrote:
> > The processing of vmlinux.o with objtool is the most memory-intensive step
> > of a kernel build. By reducing the maximum memory usage here we can reduce
> > the maximum memory usage of the whole kernel build.
> > Therefore memory pressure on memory starved machines is relieved during
> > kernel builds and the build is faster as less swapping has to occur.
> 
> Friendly ping.
> 
> These patches can also applied one by one, the only dependency is from
> patch 5 to patch 4.

Thanks, I'll go ahead and take five of them now.

-- 
Josh
