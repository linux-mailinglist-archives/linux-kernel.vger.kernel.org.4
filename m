Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1775EDC07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiI1LwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiI1LwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:52:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004611BC;
        Wed, 28 Sep 2022 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664365927; x=1695901927;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JbPedr5Aug0M5rs26jYGMN7zaZdiXgsSQ4iu0gsMQUQ=;
  b=gZJ7A2BMy8QZzt+PRwQRjwDg9zgpLVZZjvZih30akIU7Z5llXOZ2PqOR
   rDf9Zhm4M7Tb1FCZVdu/l72k39/XgeZO2jAE/Cd0SVofMIQUvdYgfIHfx
   kf7ooK4QS4osHh2M8cCOBwMp6M/EVuN4PIS3cxoNhDf1AgDlz5nol/JAR
   SJq9nlOGcVJvT0pK0OUpx0FDqChgt+6WU1Oa78ACBR6btdOoszzfiOKDU
   h8V8UzEATxjAEyHjw7EaMYR7gAt5CwngkIsYWw2M1vgzQUcNxCliCISLt
   pMQE43VeQcMnctgF8afuBY16MwzrA5LK6oSMenjsFNfeweyShJ5Tmgsfb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="303064158"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="303064158"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:52:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599549670"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="599549670"
Received: from kjurkiew-mobl.ger.corp.intel.com ([10.251.211.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:52:04 -0700
Date:   Wed, 28 Sep 2022 14:52:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] Documentation: rs485: Mention
 uart_get_rs485_mode()
In-Reply-To: <CAHp75Vd6OJ68BbaYt21hPpOpDbvT9pow6PSDhedGULjikGhoNg@mail.gmail.com>
Message-ID: <c4df6e19-5390-3ce8-eb7f-8059115187d0@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com> <20220928110509.13544-4-ilpo.jarvinen@linux.intel.com> <CAHp75Vd6OJ68BbaYt21hPpOpDbvT9pow6PSDhedGULjikGhoNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1426318885-1664365926=:1695"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1426318885-1664365926=:1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 28 Sep 2022, Andy Shevchenko wrote:

> On Wed, Sep 28, 2022 at 2:05 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> 
> >     The device tree can also provide RS485 boot time parameters
> > -   [#DT-bindings]_. The driver is in charge of filling this data structure
> > -   from the values given by the device tree.
> > +   [#DT-bindings]_. The serial core fills the struct serial_rs485 from the
> > +   values given by the device tree when driver calls uart_get_rs485_mode().
> 
> the driver
> 
> Feels like this should be before the previous patch and actually have
> a Fixes tag.

I don't feel it would be an appropriate tag for this kind of cases 
where documentation is simply lacking behind what the core code now 
offers.

-- 
 i.

--8323329-1426318885-1664365926=:1695--
