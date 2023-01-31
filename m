Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5F68230D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjAaDyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAaDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:54:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA82B0B1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 19:54:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 03:54:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675137287;
        bh=7rBe0CTn1PjUAYzff9PwyfORzzH0aZoNDZpzq+Gc/xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCrA++6twRVygbhoyXdG7FVvDj49oWFMiKBpStr+Ip4UsdSRG4KfrX41incDFcINz
         Ap/ztZ59Bqx6nqJjt/0X4sloyKGyO5RQF9gnWukrr9nvfq6bB0nWRR4oqGFUiVvc0Y
         H1FA2U8nwLqElT93UQbw4IxZCZBSMHSZ8FyuN/gI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] objtool: reduce maximum memory usage
Message-ID: <20230131035442.yzq4opasci7azt2j@t-8ch.de>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20230129214339.76hyytrllggbvuat@t-8ch.de>
 <20230131000356.5u2siglndnjyarql@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131000356.5u2siglndnjyarql@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:03:56PM -0800, Josh Poimboeuf wrote:
> On Sun, Jan 29, 2023 at 09:43:39PM +0000, Thomas Weißschuh wrote:
> > On Tue, Dec 27, 2022 at 04:00:57PM +0000, Thomas Weißschuh wrote:
> > > The processing of vmlinux.o with objtool is the most memory-intensive step
> > > of a kernel build. By reducing the maximum memory usage here we can reduce
> > > the maximum memory usage of the whole kernel build.
> > > Therefore memory pressure on memory starved machines is relieved during
> > > kernel builds and the build is faster as less swapping has to occur.
> > 
> > Friendly ping.
> > 
> > These patches can also applied one by one, the only dependency is from
> > patch 5 to patch 4.
> 
> Thanks, I'll go ahead and take five of them now.

Thanks.

I have another half-finished series that replaces the doubly-linked
list_heads used by elf.h with a custom singly-linked list.
This would save a few pointers per struct.

Do you think this is worth it?

Thomas
