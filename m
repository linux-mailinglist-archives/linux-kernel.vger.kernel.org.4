Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E869C9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjBTL3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBTL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:29:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138E14E9B;
        Mon, 20 Feb 2023 03:29:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="312010717"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="312010717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 03:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="648808407"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="648808407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 03:29:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1pU4MO-009O14-0L;
        Mon, 20 Feb 2023 13:29:32 +0200
Date:   Mon, 20 Feb 2023 13:29:31 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v4 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
Message-ID: <Y/NZm22JQKeF1+6R@smile.fi.intel.com>
References: <20230218090709.7467-1-orlandoch.dev@gmail.com>
 <20230218090709.7467-3-orlandoch.dev@gmail.com>
 <CAHp75VeF6ypA7mSYZrMsNr777f6zjEJ6nkygEc_NQe-nMhjRFQ@mail.gmail.com>
 <20230220180932.2a7aa6b1@redecorated-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220180932.2a7aa6b1@redecorated-mbp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:09:32PM +1100, Orlando Chamberlain wrote:
> On Sun, 19 Feb 2023 16:09:26 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, Feb 18, 2023 at 11:08 AM Orlando Chamberlain
> > <orlandoch.dev@gmail.com> wrote:

...

> > > +       help
> > > +       Say Y here if you want support for the keyboard backlight
> > > on Macs with
> > > +       the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note
> > > that this
> > > +       driver is not for external magic keyboards.
> > > +
> > > +       To compile this driver as a module, choose M here: the
> > > +       module will be called hid-apple-magic-backlight.  
> > 
> > Is it my email client or is the indentation of the help text
> > incorrect?
> > 
> > Hint: the text of the help should be <TAB><SPACE><SPACE> indented.
> > 
> > I believe checkpatch.pl at least in --strict mode should complain
> > about this.
> 
> Looking at the hid Kconfig, it seems like some have it as you've
> described, and some just have tab (and a few have just tab for the
> first line, and tab space space for the rest of the lines).

Okay, I have checked in the other MUA I'm using for patch reviews and indeed
your Kconfig indentation is broken.

> checkpatch.pl --strict didn't complain about the indentation so
> hopefully it's alright as is.

No, it's not. Must be fixed.

https://www.kernel.org/doc/html/latest/process/coding-style.html#kconfig-configuration-files

-- 
With Best Regards,
Andy Shevchenko


