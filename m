Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E755EF1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiI2J0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiI2JZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:25:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63610FE16;
        Thu, 29 Sep 2022 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443545; x=1695979545;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mOKSZ4gt8N3oR2TFgzHf+H1VytXoQVKrtFoK/lXXaQ4=;
  b=AO45MrGI3bWm9dmOJYsjQEuMNeTCSLuAYRBVITr44LOU7W97Pk84qh9A
   ftfVJjkDEUdWy67WMUsiGYCehmZsCpge4IrQSmOiHiMGHn1XN8l/heiZl
   S+edYX189Syzd5vnnZWP/gsTu8/GPVgrtUCt8wAxYyOMl1NX3TqzWhVSo
   aX6eZIZUfJM0gIIN6+qfiY6MkuokmMqW0UXWg4azTBGCYLKD9NcprkEbI
   KFhYBipuevjcOVo+YT5jMh7ihwU02j09gszMcPx6azbyNOHTg8meuQJcu
   sAOu7/zxIqV1DU2wr8vu2rglVDbbXWroXrUbZQQ7eiobaeJclf6ZklLC8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="303329359"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="303329359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:25:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573386024"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="573386024"
Received: from pramona-mobl1.ger.corp.intel.com ([10.252.60.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:25:40 -0700
Date:   Thu, 29 Sep 2022 12:25:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 1/4] serial: Convert serial_rs485 to kernel doc
In-Reply-To: <71effcc8-7345-28cd-6585-eb729fb4c6db@gmail.com>
Message-ID: <f05c437b-db3c-ad3-f393-3ff369d8f1c9@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com> <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com> <YzURJa1RnxP+uj5/@debian.me> <75f07dbe-d1dd-ac18-5c8e-e6972e7fb28b@linux.intel.com> <71effcc8-7345-28cd-6585-eb729fb4c6db@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-209069814-1664443542=:1640"
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

--8323329-209069814-1664443542=:1640
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 29 Sep 2022, Bagas Sanjaya wrote:

> On 9/29/22 15:39, Ilpo Järvinen wrote:
> > On Thu, 29 Sep 2022, Bagas Sanjaya wrote:
> > 
> >> On Wed, Sep 28, 2022 at 02:05:06PM +0300, Ilpo Järvinen wrote:
> >>> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> >>> index cea06924b295..6e347eb10b1f 100644
> >>> --- a/include/uapi/linux/serial.h
> >>> +++ b/include/uapi/linux/serial.h
> >>> @@ -107,37 +107,57 @@ struct serial_icounter_struct {
> >>>  	int reserved[9];
> >>>  };
> >>>  
> >>> -/*
> >>> +/**
> >>> + * struct serial_rs485 - serial interface for controlling RS485 settings.
> >>> + * @flags:			RS485 feature flags.
> >>> + * @delay_rts_before_send:	Delay before send (milliseconds).
> >>> + * @delay_rts_after_send:	Delay after send (milliseconds).
> >>> + * @addr_recv:			Receive filter for RS485 addressing mode
> >>> + *				(used only when %SER_RS485_ADDR_RECV is set).
> >>> + * @addr_dest:			Destination address for RS485 addressing mode
> >>> + *				(used only when %SER_RS485_ADDR_DEST is set).
> >>> + * @padding0:			Padding (set to zero).
> >>> + * @padding1:			Padding (set to zero).
> >>> + * @padding:			Deprecated, use @padding0 and @padding1 instead.
> >>> + *				Do not use with @addr_recv and @addr_dest (due to
> >>> + *				overlap).
> >>> + *
> >>
> >> I don't see definition of fields after @delay_rts_after_send in the
> >> htmldocs output.
> > 
> > So it seems, this one I had missed. I guess the reason is that those 
> > members are inside anonymous unions. But the formatting follows what 
> > is documented here AFAICT:
> > 
> > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions
> > 
> > Kerneldoc doesn't seem to live up to what is documented about it. It's a 
> > bit ironic that documentation system fails to document even itself to 
> > sufficient level, and what's worse, seems to be full of faulty examples.
> > 
> > Any suggestions how to make it work?
> > 
> 
> CC'ing Akira.

Nevermind, I figured out where the problem is (my incorrect use of 
private: markers).

-- 
 i.

--8323329-209069814-1664443542=:1640--
