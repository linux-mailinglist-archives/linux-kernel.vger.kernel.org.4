Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC866D7969
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDEKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjDEKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:17:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B84198D;
        Wed,  5 Apr 2023 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680689862; x=1712225862;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EGf9OnEDe3hrZhNghZlA7uytU/26J3PuuPCSwZuV6VU=;
  b=Q0qSPoXc9eXYvSEWmBpNiGhrHVJZSAqC15dLlMer+/NBgkovDK0e71VQ
   gmOQd6z2jmUzFwLTHNLhMNd8Ig3BjhofI722ngCZlRhDlI7Ya7VIbmzu/
   IgNFX4mKJttcoUNVvwB1jRwZCBbdlrHtfJKkWb+HPQSi3xn5GO8+9wY6d
   DPyr+sWysBCOTpA5kGVUCcKo+EVkE6gprTd2fGwfxRoGC/w2RjWH9QvHf
   lDtSUap094gKpRunmWjJSj1VOKDOUn+LmtzhmvZEZikeBCU232kpXIuxI
   o7sn2DwHQePl/5uxRNFplr5VluxBVsfmo41ygYN9JU7CMFYqVxL+/D0Zp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344132895"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344132895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 03:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="810584030"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="810584030"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 03:17:39 -0700
Date:   Wed, 5 Apr 2023 13:17:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
In-Reply-To: <862a78b5-b89a-0b26-e0f8-f910dd3434ba@ni.com>
Message-ID: <b5736c6e-6b2d-875e-5a81-8f7b66a19d5f@linux.intel.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com> <20230329154235.615349-3-brenda.streiff@ni.com> <4687fc63-65ad-c717-70b4-731079be38f7@linux.intel.com> <862a78b5-b89a-0b26-e0f8-f910dd3434ba@ni.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-906799157-1680689861=:2159"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-906799157-1680689861=:2159
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 31 Mar 2023, Brenda Streiff wrote:

> On 3/31/23 06:46, Ilpo Järvinen wrote:
> > On Wed, 29 Mar 2023, Brenda Streiff wrote:
> 
> > > +	int irq;
> > > +	int rs232_property = 0;
> > > +	unsigned int prescaler;
> > > +	const char *transceiver;
> > > +	int txfifosz, rxfifosz;
> > 
> > Try to follow reverse xmas-tree order.
> 
> Is reverse xmas tree also the rule in the tty subsystem? I was aware of
> it for netdev but I thought that was a netdev-specific rule (since it
> only shows up in maintainer-netdev.rst and not more broadly)

I'd say that not as strictly as e.g. netdev does so if e.g. due to 
initialization order it cannot be fully achieved no special trickery is 
required (in contrast to what you'd get from e.g. netdev telling to put
them out of line).

It seems generally useful for declarations, especially when they're as 
many as in the one I picked up above (I think might be due to less eye 
movement required when looking for a particular variable by its name).


-- 
 i.

--8323329-906799157-1680689861=:2159--
