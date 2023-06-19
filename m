Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE397353E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjFSKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFSKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:48:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BD10CF;
        Mon, 19 Jun 2023 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687171705; x=1718707705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIUqjU+9sWui+M1P0a6/KkrhLGUghRBFd77P7yxBipc=;
  b=JITr5u4/zZ7bIHq99JmoCPXR0K/mdkNHQWTszwOtNOnB1AHziYXYZA2F
   C18BTT+eUAP1+aOMxbvRfXRfpClw9THx9j5fRT6OObEo4uyS4cH+9zdji
   k3LPszg2AntnG8vv9FpTxwfWJwTYVdG62Yr7KbVL8lVnxGpxxasHsMgnK
   TVxSh+p3a/+A1bAPjImA6HgEJAmxBUzBQ7calQGqI3YOJBLU7q6JbRypj
   58jLC0SHG63+Uef2sHB5FxSIL5pa6woEiXAXYhvX+eS4jr66d42ksVUMc
   MX7E9F4QCZjc8KorjIaNzquflD4eEa4kNtlTmK/gCTu2J1YXq3vONY2g7
   g==;
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="220892977"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2023 03:48:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 19 Jun 2023 03:48:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 19 Jun 2023 03:48:14 -0700
Date:   Mon, 19 Jun 2023 12:48:13 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sebastian.tobuschat@nxp.com>
Subject: Re: [PATCH net-next v1 12/14] net: phy: nxp-c45-tja11xx: read ext
 trig ts TJA1120
Message-ID: <20230619104813.tiodielj7faw557s@soft-dev3-1>
References: <20230616135323.98215-1-radu-nicolae.pirea@oss.nxp.com>
 <20230616135323.98215-13-radu-nicolae.pirea@oss.nxp.com>
 <20230619084941.q6c26zhf4ssnseiu@soft-dev3-1>
 <1052d020-6866-f1a2-2b59-bec88ff00271@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1052d020-6866-f1a2-2b59-bec88ff00271@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/19/2023 13:07, Radu Pirea (OSS) wrote:
> 
> On 19.06.2023 11:49, Horatiu Vultur wrote:
> > The data->get_extts can't be null. So I don't think you need this check.
> 
> I kinda agree with this because _I wrote the driver and I know what it
> does_, but on the other hand don't want to fight with any static analyzer.

Yes, but then wouldn't be an issue with the static analyzer tools that
can't detect this kind of code?

> 
> > 
> > --
> > /Horatiu
> 
> --
> Radu P.

-- 
/Horatiu
