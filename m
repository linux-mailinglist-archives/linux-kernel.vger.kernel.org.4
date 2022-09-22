Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812A5E6208
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIVMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIVMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:12:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE89FAB5;
        Thu, 22 Sep 2022 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663848766; x=1695384766;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dV896P9KsrY/FhIaPaqfWulS1JdnBEHjNbRfyVsbuCw=;
  b=k8/O8OBywCMNj0z9q8uFOC91qFtZeIBZPwXmSfJSXmEcIMrlyYnKMcV8
   8xgBSekzeZQ9bc40gk1JKNTr4h7DmEdP3WsxGg32UjwiWjJJePeOBoC5K
   lJ3GE0IBbykdCdLH3XyR8lptVFefQPvkqhDK7iEOKeyBqzVPfPjW9Ibmv
   Lvz3CSBhzKK8WGHDT+JmYY+j+9ZFg3hIsRLVIKqHQZgA8t1cDX2M+CH67
   VzSuXj7VXehTLKUc6rq4dHVAaPsfhlEUKXDSLToQAdIHAIRyAeL1prcBy
   aLGtAQ6uwiHfWdf7BcX5R7hYcv4h9h1rzhwalVYTwrGSiPIMoiX4j79lI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287359950"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287359950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 05:12:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="650497637"
Received: from lsundin-mobl.ger.corp.intel.com ([10.252.58.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 05:12:41 -0700
Date:   Thu, 22 Sep 2022 15:12:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] tty: serial: atmel: Use FIELD_PREP/FIELD_GET
In-Reply-To: <20220922113347.144383-10-sergiu.moga@microchip.com>
Message-ID: <a894518-4112-b99a-c2b7-657c23ee4974@linux.intel.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com> <20220922113347.144383-10-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-152948573-1663848765=:1702"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-152948573-1663848765=:1702
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 22 Sep 2022, Sergiu Moga wrote:

> Convert all open-coded instances of bitfields retrieval/setting
> to FIELD_PREP/FIELD_GET where possible.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With one caveat below which I leave up to you to decide as it might be
more a matter of taste thing.

> @@ -82,7 +84,7 @@
>  #define	ATMEL_US_INACK		BIT(20)	/* Inhibit Non Acknowledge */
>  #define	ATMEL_US_DSNACK		BIT(21)	/* Disable Successive NACK */
>  #define	ATMEL_US_MAX_ITER_MASK	GENMASK(26, 24)	/* Max Iterations */
> -#define	ATMEL_US_MAX_ITER(n)	(((n) << 24) & ATMEL_US_MAX_ITER_MASK)
> +#define	ATMEL_US_MAX_ITER(n)	FIELD_PREP(ATMEL_US_MAX_ITER_MASK, (n))
>  #define	ATMEL_US_FILTER		BIT(28)	/* Infrared Receive Line Filter */
>  
>  #define ATMEL_US_IER		0x08	/* Interrupt Enable Register */
> @@ -134,19 +136,19 @@
>  
>  #define ATMEL_US_CMPR		0x90	/* Comparaison Register */
>  #define ATMEL_US_FMR		0xa0	/* FIFO Mode Register */
> -#define	ATMEL_US_TXRDYM(data)	(((data) & 0x3) << 0)	/* TX Ready Mode */
> -#define	ATMEL_US_RXRDYM(data)	(((data) & 0x3) << 4)	/* RX Ready Mode */
> +#define	ATMEL_US_TXRDYM(data)	FIELD_PREP(GENMASK(1, 0), (data))	/* TX Ready Mode */
> +#define	ATMEL_US_RXRDYM(data)	FIELD_PREP(GENMASK(5, 4), (data))	/* RX Ready Mode */
>  #define		ATMEL_US_ONE_DATA	0x0
>  #define		ATMEL_US_TWO_DATA	0x1
>  #define		ATMEL_US_FOUR_DATA	0x2
>  #define	ATMEL_US_FRTSC		BIT(7)	/* FIFO RTS pin Control */
> -#define	ATMEL_US_TXFTHRES(thr)	(((thr) & 0x3f) << 8)	/* TX FIFO Threshold */
> -#define	ATMEL_US_RXFTHRES(thr)	(((thr) & 0x3f) << 16)	/* RX FIFO Threshold */
> -#define	ATMEL_US_RXFTHRES2(thr)	(((thr) & 0x3f) << 24)	/* RX FIFO Threshold2 */
> +#define	ATMEL_US_TXFTHRES(thr)	FIELD_PREP(GENMASK(13, 8), (thr))	/* TX FIFO Threshold */
> +#define	ATMEL_US_RXFTHRES(thr)	FIELD_PREP(GENMASK(21, 16), (thr))	/* RX FIFO Threshold */
> +#define	ATMEL_US_RXFTHRES2(thr)	FIELD_PREP(GENMASK(29, 24), (thr))	/* RX FIFO Threshold2 */
>  
>  #define ATMEL_US_FLR		0xa4	/* FIFO Level Register */
> -#define	ATMEL_US_TXFL(reg)	(((reg) >> 0) & 0x3f)	/* TX FIFO Level */
> -#define	ATMEL_US_RXFL(reg)	(((reg) >> 16) & 0x3f)	/* RX FIFO Level */
> +#define	ATMEL_US_TXFL(reg)	FIELD_GET(GENMASK(5, 0), (reg))		/* TX FIFO Level */
> +#define	ATMEL_US_RXFL(reg)	FIELD_GET(GENMASK(21, 16), (reg))	/* RX FIFO Level */

I don't particularly like this kind of constructs. IMHO, all these would 
be nice after removing the macro argument and moving the FIELD_PREP() to 
.c file. That is,

.h:
#define ATMEL_US_RXFL	GENMASK(21, 16)

.c:
	... FIELD_PREP(ATMEL_US_RXFL, arg) ...

But I guess there might be differing opinions on it (and both are 
correct from purely technical perspective).

-- 
 i.

--8323329-152948573-1663848765=:1702--
