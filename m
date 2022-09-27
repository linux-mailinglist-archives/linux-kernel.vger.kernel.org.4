Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4B5EC0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiI0LKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiI0LKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:10:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50518E00D;
        Tue, 27 Sep 2022 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664276863; x=1695812863;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tcwqTKkmjuY0nwfev1EP+2kk/8CrTWcsgrN1s3ucsAs=;
  b=nMi6+/wulWnlj7ZFgfi3cEc6PJ1L/xCuCzXY62zUY4f3JFewddFIiapB
   5j96ezViTnTOe81YkLI1xKVvVBZDHOW2no3REfBLBfSXvMHMwdFTs5lYF
   J8cA2mkXmtdz/fDZC9J46xsP9Gzr53erg/yJwLLqJE2o3shJGaQwT8oqt
   dj0gqhNiMbZ3/T8N8NzaL7imI1dxuqve5Jp1mZpmUUl0+gmfMlmyBkeYM
   Jy2H6raW2lrYdIplEUmMGfloueM6XzaFvd7nCXWwir1IDioEZ+2kkYFJ3
   D8QGO914O0IS0//zU3ItRkj7OU7k+mMO5aAVtERpMFERKwZveD1d2Hy51
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281657026"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281657026"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:07:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="747006266"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="747006266"
Received: from aksaxena-mobl2.ger.corp.intel.com ([10.252.60.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:07:40 -0700
Date:   Tue, 27 Sep 2022 14:07:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial: Convert serial_rs485 to kernel doc
In-Reply-To: <d571f4ec-494e-d9fd-70c4-ab96a21abf03@kernel.org>
Message-ID: <958bf61e-6d85-4843-128-2f76e632b920@linux.intel.com>
References: <1c401476-8f4d-827c-f8e1-b4853988e2@linux.intel.com> <d571f4ec-494e-d9fd-70c4-ab96a21abf03@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-509239014-1664276364=:2334"
Content-ID: <2dda4b1a-6fd6-108d-4395-d68696feb6d@linux.intel.com>
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

--8323329-509239014-1664276364=:2334
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e5e8c65-1812-12ff-b4b-b029407aec6d@linux.intel.com>

On Tue, 27 Sep 2022, Jiri Slaby wrote:

> On 27. 09. 22, 12:47, Ilpo Järvinen wrote:
> > For reasons unknown to me, the formatting in the flags doesn't produce the
> > effect promised by kerneldoc's documentation:
> > 
> >    https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#return-values
> 
> Returns are special.

Might be but I understood that formatting thing to be more general.

> >    * Serial interface for controlling RS485 settings on chips with suitable
> >    * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by
> > your
> >    * platform. The set function returns the new state, with any unsupported
> > bits
> >    * reverted appropriately.
> > + *
> > + * serial_rs485::flags bits are:
> 
> Put one more \n here.
> 
> > + * * %SER_RS485_ENABLED		- RS485 enabled.
> > + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> > + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after
> > sent.
> > + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
> > + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if
> > supported).
> > + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> > + * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
> > + * *				  Requires %SER_RS485_ADDRB.
> 
> And perhaps remove the second * here?

It gave me error earlier but now when I added also that newline above you 
suggested, it seems to no longer triggers the error. Thus, I ended up 
making both of the changes you suggested.


-- 
 i.
--8323329-509239014-1664276364=:2334--
