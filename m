Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49855BCFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiISOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiISOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:51:08 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C984A2B603;
        Mon, 19 Sep 2022 07:51:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oaI6u-0005ft-00; Mon, 19 Sep 2022 16:51:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 372EAC12A8; Mon, 19 Sep 2022 16:46:37 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:46:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 0/3] mips: use DEFINE_SHOW_ATTRIBUTE to simplify code
Message-ID: <20220919144637.GA7636@alpha.franken.de>
References: <20220913101038.1902389-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913101038.1902389-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 06:10:35PM +0800, Liu Shixin wrote:
> Use DEFINE_SHOW_ATTRIBUTE to simplify code.
> 
> Liu Shixin (3):
>   mips: cavium: convert to DEFINE_SHOW_ATTRIBUTE
>   mips: kernel: convert to DEFINE_SHOW_ATTRIBUTE
>   mips: ralink: convert to DEFINE_SHOW_ATTRIBUTE
> 
>  arch/mips/cavium-octeon/oct_ilm.c | 17 +++--------------
>  arch/mips/kernel/segment.c        | 15 ++-------------
>  arch/mips/ralink/bootrom.c        | 15 ++-------------
>  3 files changed, 7 insertions(+), 40 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
