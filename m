Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CBD65D6F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjADPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:14:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6841AD80;
        Wed,  4 Jan 2023 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845280; x=1704381280;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=QZCwprZw1+mKr5+bFcTpFv2qhvbs1l7/XdAVfCoIPFs=;
  b=SEWb8UTYJVdEng0I/h37yeXnyehRTINh3OVUjh+Qxi5vCmxykG9KwM0R
   CYAWGq6L056TrF4xFwYxSLfjsrNPrcOtVqq44HAaXy4KAZWfYW+GMH3YA
   klR5isnF83F4v16iu9T84tAi/TeqnplFU+OJFifh4M3+E9dDln1WcTsm1
   IDFrTHHxWhSNfrCUY31SW3hfVq27lgHbPwGIHFy1hkHujMi4hN/NG6wfN
   FRNwcfTEwHBPeV2FvXOdCdIablmtkc+BimR4v7xDauyjgw2tyPQEXXj9z
   LSjgo8UvKJ/qOY3p9iZcyF2CglyRW5sehPohJoTSgFuWiIOj4I5XHuTR9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320663935"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320663935"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:08:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900578039"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="900578039"
Received: from msvoboda-mobl.ger.corp.intel.com ([10.252.48.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:08:19 -0800
Date:   Wed, 4 Jan 2023 17:08:10 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     lizhe <sensor1010@163.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] serial: linflexuart: remove redundant uart type
 PORT_LINFLEXUART
In-Reply-To: <20230104150023.3115-1-sensor1010@163.com>
Message-ID: <2f726128-29c-b7dd-ad8-f8b536fbe5f@linux.intel.com>
References: <20230104150023.3115-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-339339727-1672844700=:1783"
Content-ID: <e93d745b-9e9c-5d3a-543a-e85c32f3afa1@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-339339727-1672844700=:1783
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b2fb696-3a25-6625-2514-ca3ac3e980ac@linux.intel.com>

On Wed, 4 Jan 2023, lizhe wrote:

> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()
> 
> Signed-off-by: lizhe <sensor1010@163.com>

> Acked-by: Jiri Slaby <jslaby@suse.com>
> Acked-by: Ilpo Järvinen<ilpo.jarvinen@linux.intel.com>

Eh, you're not supposed to invent these Acked-by tags yourself. Don't add 
any tags besides your own unless somebody explicitly gives them to you in 
a reply!

And the subject was supposed to be (as per Jiri's recommendation):
serial: linflexuart: remove redundant uart type assignment

You also didn't include the history of what was changed in v3.

--
 i.
--8323329-339339727-1672844700=:1783--
