Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECC62A02B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKORWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiKORVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:21:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610F13E39;
        Tue, 15 Nov 2022 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668532876; x=1700068876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0jqqtRNplKE/vAU4W9nyyIVHLGOvrsi3wlgDl1IgVSU=;
  b=cGWPKuCWeoVjgn+JlV/XA574GmNaBngD5bkfWsR8P+XghxhryAdWKfSU
   GpGD07Ks+4S9jweLwiROFX9o1aO6O6sD3Qw5yzeZHAJMPtxjtXCifh9/N
   IJ+BnVbftvgN1+EAmsYXFwifhltLkSrGUjiCDn8VWzwQajqu5wONIxTC9
   ay/iOnSIUdjz5AAzcBX6AfXN2cEv/sUdm4yB+1b1/kVH1VNhsSbQnYvDS
   XMwWeVYIQGWzCgcD75vPFY9jedoUajnZv0ynkrdMTDlS3UlfU6+R6UVc7
   NO8lm0vKQYuYm8mawKp4/9+uDc/ir7AIHktuvV9kkeMmMBboqW76UbMTx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="309940985"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="309940985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:21:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813753093"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="813753093"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:21:13 -0800
Date:   Tue, 15 Nov 2022 19:21:03 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kai Vehmanen <kvcontact@nosignal.fi>
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/linux/hsi/
In-Reply-To: <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
Message-ID: <alpine.DEB.2.22.394.2211151909150.3532114@eliteleevi.tm.intel.com>
References: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr> <20221114210155.anq5gkggfrvj6nki@mercury.elektranox.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Nov 2022, Sebastian Reichel wrote:

> On Sun, Sep 11, 2022 at 01:56:59PM +0200, Christophe JAILLET wrote:
> > Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
> > license identifier to uapi header files with a license")
> > 
> > When the SPDX-License-Identifier tag has been added, the corresponding
> > license text has not been removed.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> 
> IIRC that was intentional, since the plan was to seek for an
> explicit Ack from the copyright holder when removing the text.
> I've added Greg for clarification and hopefully the latest
> mail address from Kai and Peter.
[...]
> > --- a/include/uapi/linux/hsi/cs-protocol.h
> > +++ b/include/uapi/linux/hsi/cs-protocol.h
> > @@ -6,20 +6,6 @@
> >   *
> >   * Contact: Kai Vehmanen <kai.vehmanen@nokia.com>
> >   * Original author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > - *
> > - * This program is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU General Public License
> > - * version 2 as published by the Free Software Foundation.
> > - *

sure, this looks ok. I cannot speak on behalf of my old employer,
but as one of the authors of the code in question I can confirm
this patch is ok and thus:

Acked-by: Kai Vehmanen <kvcontact@nosignal.fi>

Cc'ing my private email address.

Br, Kai
