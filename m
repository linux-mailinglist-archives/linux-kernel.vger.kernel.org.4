Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37262091E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiKHFwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKHFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:52:06 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FB2DA8C;
        Mon,  7 Nov 2022 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=lsrFGeuHZ9wh8asjvxV7/MIVVp+g7KTY9yxrdvD0P6c=;
  b=UWLpBxlDy/VnAHHLh1j7OGv93INeQFb4X2fth/yxf6QW/qB4xy02eUmw
   qHlEzYkmm9meSFlp7ymIezuH6ykcq4B6zaQ5ZNSz3oMF0X/EmzjCUcFOt
   ECOJwaH7JXu2Mr3mvs9oQLZhiRyF442P/iiESZjTcsj2hvRtz7+ZUlQyn
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; spf=None smtp.helo=postmaster@zcs-store9.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of julia.lawall@inria.fr is inclined to not designate
  128.93.142.36 as permitted sender) identity=mailfrom;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="julia.lawall@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store9.inria.fr) identity=helo;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="postmaster@zcs-store9.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77134485"
X-MGA-submission: =?us-ascii?q?MDEs0A+XODSBwig36FY8W1LHf9eQB1swn5ImB2?=
 =?us-ascii?q?RJVGBYwaOpOX5VeMpKjrHc00AoyGbu3XqmnQSTYBPYnZrEn/sj4nrnsV?=
 =?us-ascii?q?OS4cDKK44TcnrkpMcOfEy0MDS92UrHy8Z3joTvvnC8mrytnfaRRWEz41?=
 =?us-ascii?q?rvLlpTwYsyE/jUq56bqOVtow=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 06:51:53 +0100
Date:   Tue, 8 Nov 2022 06:51:53 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        nicolas palix <nicolas.palix@imag.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Message-ID: <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
In-Reply-To: <20221107200815.u7hcwejileeabnct@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de> <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de> <20221107200815.u7hcwejileeabnct@pengutronix.de>
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [122.11.248.245]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - FF106 (Linux)/8.8.15_GA_4468)
Thread-Topic: coccinelle: api: Don't use devm_platform_get_and_ioremap_resource with res==NULL
Thread-Index: SY9eA2PxzCVONI9yuvNaH3ovzzKcCw==
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> After uninstalling python2 this ends in:
> 
>	Cannot find Python library
>	coccicheck failed
>	make: *** [Makefile:2076: coccicheck] Error 255
> 
> Didn't try to debug that any further. Is that worth a bug report against
> coccinelle (which is shipped by my distribution)?
> 
> I tried to adapt the org and report modes from other patches in the same
> directory. So a critical glimpse by someone more knowledgable than me is
> recommended. However I don't know how to react to "I doubt ... is
> appropriate", I'd need a more constructive feedback to act on.

I'm not a python expert, so I'm not sure what to do about this python2 vs python3 problem.  Is there some strategy for printing that works in both of them?

julia
