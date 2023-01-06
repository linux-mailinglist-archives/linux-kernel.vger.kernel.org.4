Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CC65FFA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjAFLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:42:11 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218769B17;
        Fri,  6 Jan 2023 03:42:09 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 130191C0006;
        Fri,  6 Jan 2023 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673005328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lc5wbPbSxvSys4GxjqvJCgyn08yf4HnRSF0Z0k59LQ0=;
        b=Skm47uHPxp0YfxBmGN2FloyBWX03lzCulsx+QGHYCY8x+5o37hfVI3sD3Z9tyxJ5c85fG9
        7IyC4ZHEjob0fC/00T58SL0W0XC2ZxpEWw9XCvWXW3duvARaAshNbQCLjuS78I1hpj0PnL
        rdBJqZucqWRVhbDXoosnk9ClZPIsX/7CyBGj+cBc1FH650P+gDGbeO4eVWmaqd0kiN04A/
        RJSSOeAeO9L4hVmDWiTYQkqm99Mka+7m79y3F2fsDJCfcvyE1LShql3KBpIEWaJMawmTK5
        X9Mqnssi+qcaCnJxy+FOKowklzugJvVY38N/d44H1NngBkCNFpPd6vN9odCt4g==
Date:   Fri, 6 Jan 2023 12:42:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Walker <dwalker@fifo99.com>,
        David Miller <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, Lee Jones <lee@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rich Felker <dalias@libc.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        1394 <linux1394-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: old trees removed from linux-next
Message-ID: <Y7gJDJ8kdyO3mh4+@mail.local>
References: <20230105095506.69ff567a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105095506.69ff567a@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 05/01/2023 09:55:06+1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following trees have been removed form linux-next today as they
> have not been updated for more than a year.  If you would like your tree
> reinstated, please just let me know.
> 
> Each trees is followed by a list of commits in that tree that have not
> been merged into Linus Torvald's tree (if any).
> 
> Tree			Last commit date
> ----			----------------
> actions			2021-04-01 11:08:21 +0530
> amdgpu-fixes		2019-11-06 22:06:23 -0500
> cisco			2019-03-17 14:22:26 -0700
> folio-iomap		2021-12-21 13:51:08 -0500
> gpio-sim		2021-12-05 14:08:22 -0800
> i3c-fixes		2021-02-28 16:05:19 -0800

I'm not sure I will ever get urgent fixes. I'll ask you to add it back
when this is the case.



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
