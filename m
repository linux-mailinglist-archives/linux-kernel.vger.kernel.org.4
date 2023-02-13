Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C57694001
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBMIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:54:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AF8A73;
        Mon, 13 Feb 2023 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676278483; x=1707814483;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3Qrvb86xqpAxI2HTmIA1ize0Wpi8KHhQvVKxmBu4qVo=;
  b=io6afZ4/oY7AgSNp7JbUJUYxfvvhZvvntKd8iawL9mUDgLksE5RaLVuY
   JpJYTKrs6LPEromjF7vyVIM1QjGqJ8oxCABYOJaJkARe7P0gGEp4ojaSF
   s6UsFyoBM15Ety1Vz7sbaTspuoVO8cUq/7OrkIfiPuEH+TzKHKWAtsedx
   p0cgunexwNjYza3OQWGCjNndAzeGp+MgVUNdVPse5TCcyllUVxKlFW9WN
   Vul00mw0M0AuO/Iyj4IFTplzvmYY1rnJ2DXx+TrYHUpmuy2sElePKcaUn
   WPx+BGcWsyHfuV9BUuga8X4X8xbFADY2PU+mVVVf4pNgPNKYXEAopfYOC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332152145"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="332152145"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:54:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="618579861"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="618579861"
Received: from hdevries-mobl.ger.corp.intel.com ([10.249.36.140])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:54:39 -0800
Date:   Mon, 13 Feb 2023 10:54:36 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <KL1PR0601MB378160E42842A0A55947BF7191DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Message-ID: <bc8a6d9c-48ec-e394-78d8-c53bc267af1c@linux.intel.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com> <2d389fc9-0d5-42a1-b6d7-695c70dcf0fe@linux.intel.com> <KL1PR0601MB378160E42842A0A55947BF7191DD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-257282810-1676278189=:1712"
Content-ID: <7f777bc7-635e-5cdb-3621-16f888c6153c@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-257282810-1676278189=:1712
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <655a3651-c08d-25b1-4a44-7f6d39894cb8@linux.intel.com>

On Mon, 13 Feb 2023, ChiaWei Wang wrote:

> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Friday, February 10, 2023 9:52 PM
> > 
> > On Fri, 10 Feb 2023, Chia-Wei Wang wrote:
> > 
> > > Add the driver for Aspeed UART/VUART devices, which are 16550A
> > > compatible. It is an wrapper to cover the generic 16550A operation
> > > while exetending DMA feature for the devices.
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_aspeed.c | 502
> > ++++++++++++++++++++++++++
> > >  drivers/tty/serial/8250/Kconfig       |   8 +
> > >  drivers/tty/serial/8250/Makefile      |   1 +
> > 
> > Hi,
> > 
> > Before I look any further into this, could you please explain why this is made to
> > be entirely separate from what we have in
> >   drivers/tty/serial/8250/8250_aspeed_vuart.c
> > ?
> > 
> > I quickly went through some functions and they've significant parts in common
> > with no variations at all in many functions and you're defines are 1:1 too
> > (except for the DMA buf sizes). It would seem much better to add the missing
> > functionality into 8250_aspeed_vuart.c rather than creating something from
> > scratch with large overlap with existing code.
> > 
> > If you intend to keep it as a separate one, you should have a rather good
> > justification for it.
> 
> Yes, the main difference is the UART DMA support.
> However, due to the UDMA design is not quite fit to the DMAEngine, the implementation is kind of hacking.
> We thought leaving the original VUART driver unimpacted would be better.
> The UDMA covers both UART and VUART DMA support, and so do the new 8250_aspeed.c.

To me it seems rather weak reasoning.

If you want to go to this path, then you need to anyway share the common 
code between those two drivers rather than duplicating it. It's likely 
more work for you than just putting it all into the existing driver and
having just a mostly separated setup() for 2600 case.

The DMA functions should probably also depend on SERIAL_8250_DMA anyway 
and the driver should fallback to non-DMA if SERIAL_8250_DMA is not set 
which is yet another reason to use the existing code.

-- 
 i.
--8323329-257282810-1676278189=:1712--
