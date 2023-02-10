Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179CF691FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjBJNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:41:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AC1555F;
        Fri, 10 Feb 2023 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676036467; x=1707572467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BW+wBj/OAjPTC+OK/TehhbSR6rGKqrmkqjubJXxF/eI=;
  b=DAPPRt2+L5dNNjC3SydKncend26oHDFUAzaci2t60sVg2DMmRssoNsJ1
   GM8dFI9e9+4yuLW3scXfPiCUt0OacWielnpeqzfvWydom953zl6GtPDPu
   l+2kocven9fYD0Z4szdrAe1nNZd069dkV5LSbBRkfHXlvS//cLPlF5OpU
   vOVu+075HZ1ZTX1oZ6EBq49cvNN6nD/sd2o17AyGSIrRSPWFKnwH+Ijb5
   mnXy4cQKK/q161yAnT/3g6DZR3rMxignMx1eFp90DLsijU+u20oIls7Gx
   2whA9l3sGx4si7wyUMBf7wU9UVLoZdpJ5ZIZ9S4g6tMdVf32QaRbevbpN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392824599"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392824599"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:41:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="645629349"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="645629349"
Received: from tnemeth-mobl1.ger.corp.intel.com ([10.251.213.60])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:41:02 -0800
Date:   Fri, 10 Feb 2023 15:40:56 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
Message-ID: <95c8a699-7293-8d89-222-a69c56da08f@linux.intel.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com> <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023, Paul Menzel wrote:

> > +MODULE_LICENSE("GPL");
> 
> Should it be GPL v2?

No, it should. "GPL" is the correct for in MOUDLE_LICENSE(). SPDX lines 
are a different thing and more precise.

-- 
 i.

