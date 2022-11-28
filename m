Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437AE63ABE6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiK1PD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiK1PDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:03:54 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556D1BE84
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669647833; x=1701183833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mV6mGjn6xyU/syjv4PVHCFilQDa3HOhyMdRbkmoHDLo=;
  b=EspsHB34Shmyr7X8Y+C2rLCiIgcT49wFwqO6WtM/rTksIqQ8q7PuaC3s
   /8dZ8TUl9rSwtqYpA1lJOvlrkk6/I1xjKg8tMvRYC3uJU4NOdoi6HB5ut
   2InDLN3vqZX5M2wzH7aBpGwLFgnWNNE4ZGkPY4O2iKqpZFRP+R6GJBDJk
   RUGVUNWYZ4eY/pL4fzdhvZx4p2pA+plNRi/C8OskpETe9W1HIXh3CrxB0
   lLZtWb3QRaOR1WlJjkteQYj/hrWI9pORMXSKjXMpYNLVyPAgZH/7W/OWB
   5/Ya1R13Ny46BBQewaaX8flLOkgNlI190AN+tMcW/Gv0YrbgQkAkMZkIE
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665439200"; 
   d="scan'208";a="27620381"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Nov 2022 16:03:51 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Nov 2022 16:03:51 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Nov 2022 16:03:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669647831; x=1701183831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mV6mGjn6xyU/syjv4PVHCFilQDa3HOhyMdRbkmoHDLo=;
  b=alA6ealE2GgQHOclsy+M0SkSh3rDfAdz6I1DcbFdqFuSQN1m2ZmZKO+F
   un7vF1JnAl40gYmnKKq54OvJz9YJrdW+ybgS8WEI455gKRc9z2BZ2Faaq
   i2sHaGSnUcM7yY2u2CPLKgEO4Amjv8DHJnvkfXT1plV0mVDEmh6DRzVik
   axIomFdVEXdFmBVXEcleGU7LoaQvWkFlvKit0TDSMP2LiU3t6ggrv+224
   bjynqyaAk9/YtgRPhtfeqSDNVbjKcmpj3oHjFsN8PE5eGLwovAUw5mV5I
   N+Z4ATZ6C6Jcn/rMn/ZqgyzDVnic09eZ91HjodB4ICjZsaOxsYHy9nA98
   g==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665439200"; 
   d="scan'208";a="27620380"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Nov 2022 16:03:51 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8CE5D280056;
        Mon, 28 Nov 2022 16:03:51 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
Date:   Mon, 28 Nov 2022 16:03:55 +0100
Message-ID: <2206995.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220826120413.712896-1-alexander.stein@ew.tq-group.com>
References: <20220826120413.712896-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 26. August 2022, 14:04:13 CET schrieb Alexander Stein:
> This includes the arm & arm64 module + board DT files as well as x86
> platform GPIO drivers.

Gentle Ping!

Regards,
Alexander

> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3837fe33e756..56b660d79b0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20622,6 +20622,20 @@
> Q:	https://patchwork.kernel.org/project/linux-integrity/list/ T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> F:	drivers/char/tpm/
> 
> +TQ SYSTEMS BOARD & DRIVER SUPPORT
> +L:	linux@ew.tq-group.com
> +S:	Supported
> +W:	https://www.tq-group.com/en/products/tq-embedded/
> +F:	arch/arm/boot/dts/imx*mba*.dts*
> +F:	arch/arm/boot/dts/imx*tqma*.dts*
> +F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> +F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> +F:	arch/arm64/boot/dts/freescale/mba*.dtsi
> +F:	drivers/gpio/gpio-tqmx86.c
> +F:	drivers/mfd/tqmx86.c
> +F:	drivers/watchdog/tqmx86_wdt.c
> +
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Ingo Molnar <mingo@redhat.com>




