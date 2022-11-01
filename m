Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79398614E46
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKAPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:25:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE939589;
        Tue,  1 Nov 2022 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667316348; x=1698852348;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IlJqAbU3y+VY+MO6lSfCIXqnUVoHU57DkpIJh1KnXjU=;
  b=GYSAG4k3jlhGGxXn1h6VfIIkXeYncSFAtrGEtPGBlCpvQtX4ZQMUqlJ6
   rYkqpq+TWjKLtJDCsNy4dkjDa7MErABSqVNUZlFlKRDyTuQNdt6ptI1QZ
   Dtz2kHZourCRA7lMp25YgclcGN/rP1WwMBV85KZVjo/aN59uSenidzlZT
   mxUI2g1EPDCexovqppnQW/rWGI30pf6Do8sH67tEoLI+Xj8a1T/WvQqYZ
   VgjxBmwgId69NbHG+lChZfmccIq0MB2LTgmZi1bqqr3kU3J5WSog7qCcW
   NZIe+iFNuLTAW7A7A4RDPNtPwJlXYwlaXchZfR41/sydxQ/1bptLZX565
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310870159"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310870159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:25:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="611877247"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="611877247"
Received: from mweigler-mobl.ger.corp.intel.com ([10.249.40.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:25:43 -0700
Date:   Tue, 1 Nov 2022 17:25:36 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
cc:     Kumaravel.Thiagarajan@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
In-Reply-To: <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
Message-ID: <adb2d184-a247-ec16-10f-dfc13831ffc9@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com> <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com>
 <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1851274057-1667316347=:1608"
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1851274057-1667316347=:1608
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 1 Nov 2022, Tharunkumar.Pasumarthi@microchip.com wrote:

> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Monday, October 3, 2022 2:34 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
> > support to quad-uart driver.
> > 
> > [Some people who received this message don't often get email from
> > ilpo.jarvinen@linux.intel.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > > +             memset(rs485->padding, 0, sizeof(rs485->padding));
> > 
> > Core handles this for you.
> 
> I went through the code and it seems like this is not taken care by the core.
> Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_config' callback?
> This has not been done since we do not need all the configurations done inside 'serial8250_em485_config'.
> 
> > > +             if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> > > +                     data |= ADCL_CFG_POL_SEL;
> > > +                     rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
> > > +             } else {
> > > +                     rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
> > > +             }
> > 
> > Core handles that flags sanitization for you.
> 
> I went through the code and it seems like this is not taken care by the core.
> Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_config' callback?
> This has not been done since we do not need all the configurations done inside 'serial8250_em485_config'.
> 
> > > +     } else {
> > > +             memset(rs485, 0, sizeof(*rs485));
> > 
> > Core handles this.
> 
> I went through the code and it seems like this is not taken care by the core.
> Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_config' callback?
> This has not been done since we do not need all the configurations done inside 'serial8250_em485_config'.
> 
> > > +     writeb(data, (port->membase + ADCL_CFG_REG));
> > > +     port->rs485 = *rs485;
> > 
> > Core handles this.
> 
> I went through the code and it seems like this is not taken care by the core.
> Do you suggest calling 'serial8250_em485_config' inside 'pci1xxxx_rs485_config' callback?
> This has not been done since we do not need all the configurations done inside 'serial8250_em485_config'.

It has nothing to do with serial8250_em485_config.

It is very hard to believe you couldn't find 
uart_sanitize_serial_rs485() and uart_set_rs485_config() yourself, the 
latter calls your driver specific rs485 handler.

-- 
 i.

--8323329-1851274057-1667316347=:1608--
