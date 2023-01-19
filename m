Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8267352C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjASKLl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 05:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjASKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:11:36 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D3EA768A;
        Thu, 19 Jan 2023 02:11:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 61F9B80F1;
        Thu, 19 Jan 2023 10:11:34 +0000 (UTC)
Date:   Thu, 19 Jan 2023 12:11:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Juerg Haefliger <juergh@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the omap tree with the arm-soc tree
Message-ID: <Y8kXVekfGHEcPvWg@atomide.com>
References: <20230110095041.0d6311d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20230110095041.0d6311d2@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [230109 22:57]:
> Hi all,
> 
> Today's linux-next merge of the omap tree got a conflict in:
> 
>   arch/arm/mach-omap1/Kconfig
> 
> between commit:
> 
>   67d3928c3df5 ("ARM: omap1: remove unused board files")
> 
> from the arm-soc tree and commit:
> 
>   609c1fabc7c5 ("ARM: omap1: Kconfig: Fix indentation")
> 
> from the omap tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Thanks, I just dropped "ARM: omap1: remove unused board files" to
simplify things.

Juerg, care to update and resend in a few weeks after v6.3-rc1
after the omap1 clean-up patches are merged?

Regards,

Tony


