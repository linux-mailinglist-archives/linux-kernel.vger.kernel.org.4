Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30E8614E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKAPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKAPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:50:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1D17E3D;
        Tue,  1 Nov 2022 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667317807; x=1698853807;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=w9UQyPuZ+Hlj8rKvoSh33jcdRi4ssbzxCPzgI/eKvTY=;
  b=VUloBj/l1lJVPlUJU0hkzftoUxE0oVJAETILMaQINtjm4uuu2M/bvwRZ
   DHL9fIYFzBhl1qSHfYXfaQldUVU8M8YOcAcA2h9/LPGKDq9ponxMxgn5U
   wEpwJNvemzLzKnlHFB0iS+UCFTvsQ+YwOJVPyYGAQkfqwgphp2kcHNjyd
   xoQkB+4893RYO6jHVDynpFPf+61AmMQTeyGy3y/5+Y8dFL4Tala6ArXA+
   FK9UpHJYj0CiZ7ruidHnzvL90PAKf01yO3ntDdpejdYHc0S1s8FraF4NK
   fAI0gJiu83GBgO4P/+JfRaC5DCpMmGkqdw7uRYp+S2HIGuNp6Bsb8QYaa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310263176"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310263176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:50:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="879125747"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="879125747"
Received: from mweigler-mobl.ger.corp.intel.com ([10.249.40.213])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:50:02 -0700
Date:   Tue, 1 Nov 2022 17:49:55 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Tharunkumar.Pasumarthi@microchip.com,
        Kumaravel.Thiagarajan@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
In-Reply-To: <CAHp75VeuYDbjvShTTW5797opunO4DvGSLQG3Aiv0pTpx-6ZZXg@mail.gmail.com>
Message-ID: <2646f5e7-7f26-e748-8812-f1d17c799b8a@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com> <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com> <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
 <adb2d184-a247-ec16-10f-dfc13831ffc9@linux.intel.com> <CAHp75VeuYDbjvShTTW5797opunO4DvGSLQG3Aiv0pTpx-6ZZXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2129762944-1667317709=:1608"
Content-ID: <4cf03961-274f-876e-446f-ed6a5635f268@linux.intel.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2129762944-1667317709=:1608
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <26c4e49f-5f6f-6727-a0e7-77c64adb6b0@linux.intel.com>

On Tue, 1 Nov 2022, Andy Shevchenko wrote:

> On Tue, Nov 1, 2022 at 5:25 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Tue, 1 Nov 2022, Tharunkumar.Pasumarthi@microchip.com wrote:
> 
> ...
> 
> > > I went through the code and it seems like this is not taken care by the core.
> > > Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_config' callback?
> > > This has not been done since we do not need all the configurations done inside 'serial8250_em485_config'.
> >
> > It has nothing to do with serial8250_em485_config.
> >
> > It is very hard to believe you couldn't find
> > uart_sanitize_serial_rs485() and uart_set_rs485_config() yourself, the
> > latter calls your driver specific rs485 handler.
> 
> Which version has this API? If it's v6.1-rc1 and patches are made
> against v6.0, it's possible to miss something.
> 
> In any case, the patches to the serial subsystem should always be done
> against the tty/tty-next branch.

It has been for multiple stable kernel version already. It was moved to 
own function by this commit:

git describe --contains 2dbd0c14ebe8836eaf890c7f50f3fc5d26d67d95
v6.0-rc1~64^2~129

Originally introduced here:
git describe --contains 0ed12afa5655512ee418047fb3546d229df20aa1
v5.19-rc1~47^2~142

There have been perhaps one of those things I pointed out that was added 
later than the others but it won't explain why nothing was found from the 
code.


-- 
 i.
--8323329-2129762944-1667317709=:1608--
