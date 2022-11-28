Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B630163AB93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiK1OvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiK1OvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:51:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9D2253A;
        Mon, 28 Nov 2022 06:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669647061; x=1701183061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtpNKUl602erZp5JhGLEdS/fNX0dwgMjE2H5qtJYc2s=;
  b=DCSKmWV9qgqGX6IDlQRyTNSmgL/1VTxs6vLmQq88jLKJCiB0P6sVFqYz
   d226XBNMh3JDEilcQXOPGSSFhGXx7WnjQIKsvTpsTOLSVvcaSCYTErtbH
   e2BnFY7p6EUyHCr9t2DYA9vp7KajCuFJdwFVzr0mKDXPx/Qtx6bUewG+w
   dY5aQleaJ0Yg1l5Ln5ALNq1swj9JjwnEVRO891kgCwnWMFsKpxnWd1eRS
   dNywSSOSreKrYrs2EXf4akjNny8HWUv3eaYudtx/GqLnugDMxat0sVwfz
   /wIIcE2/idZsg5t+cSVG8RQr5P2xmDD8ENjqYnw4FBph91kliJxXCef32
   g==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="188967090"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 07:51:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 07:50:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 28 Nov 2022 07:50:57 -0700
Date:   Mon, 28 Nov 2022 14:50:39 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Message-ID: <Y4TKv5Ca6Zor7Y2Y@wendy>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-9-jszhang@kernel.org>
 <Y4Of7s6UGpD0/Iga@spud>
 <Y4OgNW6uOe60Pi09@spud>
 <Y4TF8FzX19puws37@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4TF8FzX19puws37@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jisheng,

On Mon, Nov 28, 2022 at 10:30:08PM +0800, Jisheng Zhang wrote:

> Per my past experience of synaptics/mrvl arm SoCs, I usually sent PRs to Arnd
> if there are two or more commits/patches; If there's only one patch, I
> asked Arnd for picking it up directly. So in bouffalolab SoC case, I
> want to do similar, but with one difference -- if there's only one
> patch, may I ask you for picking it up directly?

Works for me :) Unless I hear otherwise on a given patch, I'll assume
you've got it taken care of.

> > > git tree here. Otherwise, LMK and I'll bundle it with the other "misc
> 
> Hmm, is "git tree" necessary?

If you have one that you're sending PRs from, it's nice to know
what/where someone that may have a patch for your stuff can base
their changes on. You don't need to obviously.

Thanks!
Conor.

