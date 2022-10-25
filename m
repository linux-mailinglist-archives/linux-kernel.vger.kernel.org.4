Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470360C3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJYG3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJYG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:29:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC5326CD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666679378; x=1698215378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxPv8+AqtsgkWZihcoCOXdlEQHenVCMwLlZCTTaWJUs=;
  b=pMupOjtmA1MXAOZIuManTcXIEIROsZeyTkhH5RUZgxgu0yrllSM3e+58
   QVqbARtxBmpRJabhl0ZGmxXsLfALZdptbQPjplkvPBkedt6LPYMdZ9aip
   JHQjmHbEx/ffqY6NNmOwA4eyOHoQYq/oAqtDIY3mISIJTx5z0+AHokyvd
   xH+3lefDRA/xjaA8injlHsbWj9wEr2GQ6woqVg9GIapPOLYy9+gitwR8V
   ZlWrkqUevZGRvw5Hvb0pifepmTHiVoVJXNqULRUyeQSBTmhGeO1SA/SoB
   MnXj9KjBhBJvXa8Z490AaB9BixZ9f0fStoEmMTteSpvy2l113EXS39NxZ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="26947283"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Oct 2022 08:29:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Oct 2022 08:29:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Oct 2022 08:29:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666679376; x=1698215376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxPv8+AqtsgkWZihcoCOXdlEQHenVCMwLlZCTTaWJUs=;
  b=YMmy3GYHvPA65AZyTCGjkOeF7qbHlt2nCvJR8mZ4uG0ECIi6NGxhCkjw
   E3oCEmpBj0j6YWAIBkZ3wjGuh8kU8skBz4CxTFMdwAMuxuEl83mapJhKW
   iTC+bB/HgmNSIivhPDm+7cUNACM9SrA37q12aU7gVgTPXFuT7d8flFeDI
   nakMOf12e+mFnzO53c6V3JAWUEIMJ1B8Ha9Og+6FzjrPdj2VqGhr5tjl5
   4eo+TLoD7nCCKugAI8YObLTZI0qTrc8kToPkF7zbqny3aEghKyYiA73QC
   naFHWe6FTQ9YCtdVxOS1qu7CrQfxNH6sdyu5sIyyW4hNJ4j5q3d10ZwTs
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="26947282"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Oct 2022 08:29:36 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DFB49280056;
        Tue, 25 Oct 2022 08:29:35 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add entry for TQ-Systems device trees and drivers
Date:   Tue, 25 Oct 2022 08:29:31 +0200
Message-ID: <2258166.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220826120413.712896-1-alexander.stein@ew.tq-group.com>
References: <20220826120413.712896-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping

Thanks
Alexander

Am Freitag, 26. August 2022, 14:04:13 CEST schrieb Alexander Stein:
> This includes the arm & arm64 module + board DT files as well as x86
> platform GPIO drivers.
> 
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
> Q:	https://patchwork.kernel.org/project/linux-integrity/list/ T:	
git
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




