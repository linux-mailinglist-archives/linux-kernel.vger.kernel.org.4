Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAED5F2386
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJBOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJBOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221683A143
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B164960EE0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938EBC433C1;
        Sun,  2 Oct 2022 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664720045;
        bh=QZDngjTJkdqobmd9wtbc5r5m4kH9TupFbVfQ/RgadMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Scq0b3X3jsIXNB/ilhGzg3jD2thnZfhtqZxL3VlbH2vQ5cFHJyDxDYp0xZ+D6BPte
         Yi2hCLx6UXgPBQBp+qUb7Ua8o57N4oheZtrP0da45v6C/71q6JDXlxkW2D2u9KtIy2
         aMiAxvotNhqse7p7CzP/xFQmBJEAtg5S9ST0lbX0=
Date:   Sun, 2 Oct 2022 16:14:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Yzmc0kAQQeiUZkq9@kroah.com>
References: <20220926043618.566326-1-zyytlz.wz@163.com>
 <YzFkpRfkdnwgDDw6@kroah.com>
 <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
 <YzMmp9llFUN1yUDH@kroah.com>
 <CAJedcCxjjNFsHibTO3-M6a8vay3-2LcSN=0dNkqCicLakG4wOw@mail.gmail.com>
 <CAJedcCxjYDj5s2XbGDYSVMkcdZPOLqz5joN-L6P3aJzQ1Jy2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCxjYDj5s2XbGDYSVMkcdZPOLqz5joN-L6P3aJzQ1Jy2_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 07:25:32PM +0800, Zheng Hacker wrote:
> Here is the link of new
> patch(https://lore.kernel.org/all/20220928025957.1050698-1-zyytlz.wz@163.com/T/#u),
> I added the Fixes line to tell which commit introduced the bug.

Did you not see my bot's response to your submission?  It is in the link
you provided above, why ignore that?

greg k-h
