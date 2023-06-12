Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8E72C320
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjFLLjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjFLLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171007EF2;
        Mon, 12 Jun 2023 04:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF9F61307;
        Mon, 12 Jun 2023 11:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B59C433D2;
        Mon, 12 Jun 2023 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686569380;
        bh=lcmmhA2dNvgHq+K/Xj1hXgfEs22fk0OtWUMVkmdqrsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4BKEGMZX6+4iJxLkrt5eOyGUSEjeVOpFlq8nqy7pAqrzB4nCCmwEPZM137201ob9
         JburbX7ihz2eAbSI3ZZ8vcVQ0V5kFeYmAKkBzM/dEvXLspjAxtKmzI5sTHsFTBrhe9
         /xzrQbVKYLFUyQAFHox2UWd+5AIoHaSH/1ojy+ODusuo5P49zMJupN5gj3QWNshgJj
         BUQLZ/1ggLr7Toph4AtoNCt4n6aVxyEpucA8yACyU6UJYSG0bAPSMaQ37KDIrdi9wd
         705qTXIzmsdlzvEBo67tLcKOxVQRGjR/NEPUXBIJcyRPP9TLA1EWxnFgXlcH9iYtct
         MAYTX7835eOHw==
Date:   Mon, 12 Jun 2023 12:29:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <20230612112935.GQ3635807@google.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-2-henning.schild@siemens.com>
 <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
 <20230530171100.75e5b86c@md1za8fc.ad001.siemens.net>
 <ZHjLjU7WPv2W9SuJ@smile.fi.intel.com>
 <20230608173027.GL3572061@google.com>
 <ZIM2VK9MlxGqBfDT@smile.fi.intel.com>
 <20230612112719.GP3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612112719.GP3635807@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023, Lee Jones wrote:

> On Fri, 09 Jun 2023, Andy Shevchenko wrote:
> 
> > On Thu, Jun 08, 2023 at 06:30:27PM +0100, Lee Jones wrote:
> > > On Thu, 01 Jun 2023, Andy Shevchenko wrote:
> > > > On Tue, May 30, 2023 at 05:11:00PM +0200, Henning Schild wrote:
> > > > > Am Sat, 27 May 2023 11:54:08 +0300
> > > > > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > > > > 
> > > > > > On Wed, May 24, 2023 at 02:46:25PM +0200, Henning Schild wrote:
> > > > > > > The entries do not seem to be stricly needed when the number of
> > > > > > > entries is given via the number of LEDs. But adding them is a
> > > > > > > safeguard should anyone ever iterate over the tables to their end,
> > > > > > > it also gets us in line with other drivers that register
> > > > > > > "leds-gpio" tables.  
> > > > > > 
> > > > > > Reported-by?
> > > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > I think we could do
> > > > > 
> > > > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > on merge. But i would not want to send the whole series again for that
> > > > > one line.
> > > > 
> > > > Since you added it, `b4` will happily take it, I believe no manual work even
> > > > needed for that, thank you!
> > > 
> > > b4 didn't pick this up.  Nor the whole-series Ack provided by Hans.
> > > 
> > > I added both manually.
> > 
> > There is an option to take this
> > 
> >   -t, --apply-cover-trailers
> >                         Apply trailers sent to the cover letter to all patches
> > 
> > have you tried it?
> 
> Doesn't look like it:
> 
>   b4 am -3 -slt -P_ -o - ${id} | git am -3 --reject

No wait - it's there.

> Can't remember if I had it before then removed it, or never had it.
> 
> I'll attempt to add it now and see what happens.

-- 
Lee Jones [李琼斯]
