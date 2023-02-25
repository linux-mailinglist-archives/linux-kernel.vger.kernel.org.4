Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD96A2B78
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBYTRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBYTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:17:05 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8518B0B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=IeKrqswpCP48KJ7xdsc98CWu2jMVk7oGFloYd7qL338=;
  b=LsIzzOLU1UQ6QulREpDQY4TSYGFWEQhsblcFgM7E8oqFggQkCRd7op8e
   he1ujhAUSpSeG/P2L6GGEEMq8Sv5HI1gA859raLkTb6tS+Gcc8co6A9ak
   pHmOhIQuu7mUBYt0wP+VqUvs3hiaQJzLDlNODwj2tnLVG5bgFGjdFgmIc
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=julia.lawall@inria.fr; spf=None smtp.helo=postmaster@zcs-store9.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  julia.lawall@inria.fr designates 128.93.142.36 as permitted
  sender) identity=mailfrom; client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="julia.lawall@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs-store9.inria.fr) identity=helo;
  client-ip=128.93.142.36;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="julia.lawall@inria.fr";
  x-sender="postmaster@zcs-store9.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345582"
X-MGA-submission: =?us-ascii?q?MDHl8OGuQespJSpiw5iWyCBv7j37eooy9yemSb?=
 =?us-ascii?q?8kPe/iOIswjwSZqYTk0NQcZnV0rN/AIYCM5irUOQEp3Nby+5bSdhxuZd?=
 =?us-ascii?q?uVeEL3KH08Y+MHQMxu42DndfJ8ziDdmL/ayp8zn6xNRVxWCDiOHpKFTj?=
 =?us-ascii?q?P2g8DMPQJtjl1kDCyBsIInvA=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2023 20:17:02 +0100
Date:   Sat, 25 Feb 2023 20:17:01 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
Cc:     nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
In-Reply-To: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
Subject: Re: [PATCH] coccinelle: put_device: Include of_node_put to avoid
 false positives
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [92.89.85.231]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - FF110 (Linux)/8.8.15_GA_4481)
Thread-Topic: coccinelle: put_device: Include of_node_put to avoid false positives
Thread-Index: 3DXmNOMwrbdQmKUtPDQPTZ4nQdxHkA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The node reference increased by of_find_device_by_node() can also be
> released by using a call to of_node_put(). Hence when this exists, the
> script should not trigger a warning, which otherwise will be a false
> positive.

Could you explain more about why of_node_put is sufficient?

thanks,
julia

> Also, improve the warning message to include of_node_put too is missing.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> scripts/coccinelle/free/put_device.cocci | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/free/put_device.cocci
> b/scripts/coccinelle/free/put_device.cocci
> index f09f1e79bfa6..259195b501aa 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> 
> id = of_find_device_by_node@p1(x)
> ... when != e = id
> +    when != of_node_put(x)
> if (id == NULL || ...) { ... return ...; }
> ... when != put_device(&id->dev)
> +    when != of_node_put(x)
>     when != platform_device_put(id)
>     when != if (id) { ... put_device(&id->dev) ... }
>     when != e1 = (T)id
> @@ -42,7 +44,7 @@ p2 << search.p2;
> @@
> 
> coccilib.report.print_report(p2[0],
> -                             "ERROR: missing put_device; call
> of_find_device_by_node on line "
> +                             "ERROR: missing put_device or of_node_put; call
> of_find_device_by_node on line "
>                              + p1[0].line
>                              + ", but without a corresponding object release within this function.")
> 
> --
> 2.34.1
