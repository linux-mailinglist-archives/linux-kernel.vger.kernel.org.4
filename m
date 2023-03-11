Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53126B5970
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCKIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCKIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:14:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEA140526
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:14:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2969968AA6; Sat, 11 Mar 2023 09:14:47 +0100 (CET)
Date:   Sat, 11 Mar 2023 09:14:46 +0100
From:   hch <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        Daniel Palmer <daniel@0x0f.com>, hch <hch@lst.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for v6.3-rc1
Message-ID: <20230311081446.GA17461@lst.de>
References: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at> <CAFr9PXktRBm66vgVjOnwTeucBD36OuPjDVNd9cH1F8u0nesKrA@mail.gmail.com> <CAHk-=wi29bbBNh3RqJKu3PxzpjDN5D5K17gEVtXrb7-6bfrnMQ@mail.gmail.com> <349964589.230468.1678469537890.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349964589.230468.1678469537890.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 06:32:17PM +0100, Richard Weinberger wrote:
> Indeed, I'm able to reproduce the problem and adding blk_mq_end_request()
> back fixes it.

Yes, that was my braino about failures from ->queue_req being handled
by the block layer by doing completions, but successful I/O of course
is not. 
