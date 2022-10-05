Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51C15F51E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJEJoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:44:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B828E24;
        Wed,  5 Oct 2022 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664963050; x=1696499050;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IG4eeVo0o0ZX8usM5+UZ5ju6UZk+OfIU4VkFCt8UokQ=;
  b=Qq/nA1bDuL2ewBO9qQYxrMvi1CaD8ISZ2C4p16F73zEQS5Ssz0wEM8cf
   k++ciVzmIvMoPvaqOJKCa16y/dCf/qPCUZnsdMcOYaZzYz48nI3xzrFgE
   h0fcm9ed34nET7FqgbedAzO+rijTtTVOZG9a2w7ImipQZ6yTKUl9EJN3l
   MEXaHjeXNZ3DJcSh17m4plcfR3QYLjsqC3m1SUzwCaMZ68UsgykV8ktER
   S8xmw9GJzCitArWtQQ2f8LG/RmAlRqL7Dv+fBns0srhz5Chof+lXREPRj
   adVNLpg6/42cz7BB24EKlNOz41hczCRiFMn577YVvGE0ybdM4TS7D25Ra
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="303097975"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="303097975"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 02:44:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="624259828"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="624259828"
Received: from mtantera-mobl3.ger.corp.intel.com (HELO refaase-MOBL1.ger.corp.intel.com) ([10.252.39.164])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 02:44:04 -0700
Date:   Wed, 5 Oct 2022 12:43:44 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel.Thiagarajan@microchip.com
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: RE: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
In-Reply-To: <BN8PR11MB3668B169D079C3F9D1C3BB72E95A9@BN8PR11MB3668.namprd11.prod.outlook.com>
Message-ID: <10e3e06c-10b2-1e65-2f4-32a5f0965c8@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com> <d184aa6d-23e-edf6-4cee-f5f4ad6bf90@linux.intel.com>
 <BN8PR11MB3668B169D079C3F9D1C3BB72E95A9@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2055571603-1664963048=:1580"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2055571603-1664963048=:1580
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 4 Oct 2022, Kumaravel.Thiagarajan@microchip.com wrote:

> > -----Original Message-----
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Monday, October 3, 2022 2:51 PM
> > To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
> > support to quad-uart driver.
> > 
> > On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:
> > 
> > > pci1xxxx uart supports rs485 mode of operation in the hardware with
> > > auto-direction control with configurable delay for releasing RTS after
> > > the transmission. This patch adds support for the rs485 mode.
> > >
> > > Signed-off-by: Kumaravel Thiagarajan
> > > <kumaravel.thiagarajan@microchip.com>
> > > ---
> > > Changes in v2:
> > > - move pci1xxxx_rs485_config to a separate patch with
> > >   pci1xxxx_rs485_supported.
> > > ---
> > >  drivers/tty/serial/8250/8250_pci1xxxx.c | 57
> > > +++++++++++++++++++++++++
> > >  1 file changed, 57 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > > b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > > index 41a4b94f52b4..999e5a284266 100644
> > > --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > > +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > > +
> > > +             if (rs485->delay_rts_after_send) {
> > > +                     baud_period_in_ns = ((clock_div >> 8) * 16);
> > 
> > Is this 16 perhaps UART_BIT_SAMPLE_CNT?
> Yes. Is there any macro definition for that? I could not find any 
> definition in the above name. 

You're adding it in your 1/3 patch :-).

-- 
 i.

--8323329-2055571603-1664963048=:1580--
