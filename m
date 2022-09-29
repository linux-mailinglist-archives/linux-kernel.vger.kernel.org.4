Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5415EF0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiI2Ijy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiI2Ijq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:39:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08A1ADAA;
        Thu, 29 Sep 2022 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664440785; x=1695976785;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5ZIGBUcxLSm/CK0zM/5R1D7/PfgOCEXhU60Fxb19yVM=;
  b=awQLQHEOGdbcSwM4n+TPM1XofzEbbUdlwQogKkhTSTKSRhMQR5n+jff4
   cOjADj+wdJOYLOqcNXnS3pS9wOllFFZekWKA0Nn0lZlJ124NT8sAkUaSP
   SvrL8auNnMSJwdIKb+ziRNV03OLXaLpmozXudaFVStRFDthiunjyCLU2c
   r0IDsOjJ2risSihSyLhDxUUARXM2IOsBnAeheTyDG9Egj7l+64dbtVGKD
   gWCozVt1O8pAUxgU+p8asfvl2IxwOvePF0V/+WL0WwKiVve4PYnxbfmRh
   TXKGTebIlZFFEsMBqKMdUeaG8Z3UV2BTvOkrcP+yFae//S+UuAjyubaMo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="328207925"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="328207925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:39:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="797473966"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="797473966"
Received: from pramona-mobl1.ger.corp.intel.com ([10.252.60.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 01:39:24 -0700
Date:   Thu, 29 Sep 2022 11:39:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/4] serial: Convert serial_rs485 to kernel doc
In-Reply-To: <YzURJa1RnxP+uj5/@debian.me>
Message-ID: <75f07dbe-d1dd-ac18-5c8e-e6972e7fb28b@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com> <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com> <YzURJa1RnxP+uj5/@debian.me>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1716970536-1664440767=:1640"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1716970536-1664440767=:1640
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 29 Sep 2022, Bagas Sanjaya wrote:

> On Wed, Sep 28, 2022 at 02:05:06PM +0300, Ilpo Järvinen wrote:
> > diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> > index cea06924b295..6e347eb10b1f 100644
> > --- a/include/uapi/linux/serial.h
> > +++ b/include/uapi/linux/serial.h
> > @@ -107,37 +107,57 @@ struct serial_icounter_struct {
> >  	int reserved[9];
> >  };
> >  
> > -/*
> > +/**
> > + * struct serial_rs485 - serial interface for controlling RS485 settings.
> > + * @flags:			RS485 feature flags.
> > + * @delay_rts_before_send:	Delay before send (milliseconds).
> > + * @delay_rts_after_send:	Delay after send (milliseconds).
> > + * @addr_recv:			Receive filter for RS485 addressing mode
> > + *				(used only when %SER_RS485_ADDR_RECV is set).
> > + * @addr_dest:			Destination address for RS485 addressing mode
> > + *				(used only when %SER_RS485_ADDR_DEST is set).
> > + * @padding0:			Padding (set to zero).
> > + * @padding1:			Padding (set to zero).
> > + * @padding:			Deprecated, use @padding0 and @padding1 instead.
> > + *				Do not use with @addr_recv and @addr_dest (due to
> > + *				overlap).
> > + *
> 
> I don't see definition of fields after @delay_rts_after_send in the
> htmldocs output.

So it seems, this one I had missed. I guess the reason is that those 
members are inside anonymous unions. But the formatting follows what 
is documented here AFAICT:

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions

Kerneldoc doesn't seem to live up to what is documented about it. It's a 
bit ironic that documentation system fails to document even itself to 
sufficient level, and what's worse, seems to be full of faulty examples.

Any suggestions how to make it work?

> >   * Serial interface for controlling RS485 settings on chips with suitable
> >   * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
> >   * platform. The set function returns the new state, with any unsupported bits
> >   * reverted appropriately.
> > + *
> > + * serial_rs485::flags bits are:
> > + *
> > + * * %SER_RS485_ENABLED		- RS485 enabled.
> > + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> > + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
> > + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
> > + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
> > + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> > + * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
> > + *				  Requires %SER_RS485_ADDRB.
> > + * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
> > + *				  Requires %SER_RS485_ADDRB.
> 
> The last two items are rendered as bold text instead (maybe due to missing
> fields rendering above?)

It just goes into some random formatting mode here. Even if I remove those 
field markers (@) it doesn't do formatting differently so your guesss is 
wrong.

I found now a way to make it work though. It works when I put the whole 
description on a single line but it comes at the cost of removing the 
alignment of those "-". The other way to make it work would be like this:

* * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv).
    Requires %SER_RS485_ADDRB.

...And that's no good. I guess the single-line approach is an acceptable 
compromise for this case.

-- 
 i.

--8323329-1716970536-1664440767=:1640--
