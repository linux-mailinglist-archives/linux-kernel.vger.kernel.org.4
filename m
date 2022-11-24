Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE78637A88
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKXNx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKXNx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:53:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC69E0DC0;
        Thu, 24 Nov 2022 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669298004; x=1700834004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iJYwQQbsEFPUK7ZmqDMRO9t/URWDUHZSWtb8FdSzfbk=;
  b=HTTIR1XKt9pHUe/rJ3cb2RBtBXKfnBjA/kXAOepJ/0W232AEzso50Df4
   oHn/ozMSXt9tWPLFGfG2DiLbnzjZcKZU6ostqqPUA3H+Bus7Ej3d9Di6R
   wJBs/ZThv1wckfVls1VONTSOM1/YxvVvlS4xcuRJQlm+evoswluJRO2E0
   UFjmRjjNtTjhGXvkjkqsw366kDPeyhWEfdcFuCyuSij1H7P97/SobTfks
   ArXOZ02fZGe3kORTBctissysJ/CZESXl4n1ElcRhd2nhGkO0t58g+TmDf
   Om44iujHFOAn/selPhZnuTHQkyWcRY8hqIsHcUIxEizwG3B/hfH43ISOp
   w==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="188521747"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 06:53:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 06:53:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 06:53:16 -0700
Date:   Thu, 24 Nov 2022 13:52:58 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
CC:     <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
Message-ID: <Y393OvlAa+h8Dyek@wendy>
References: <20221124130440.306771-1-conor.dooley@microchip.com>
 <20221124130440.306771-3-conor.dooley@microchip.com>
 <7034611.lOV4Wx5bFT@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7034611.lOV4Wx5bFT@diego>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:42:20PM +0100, Heiko Stübner wrote:
> Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
> > I used the wikipedia table for ordering extensions when updating the
> > pattern here in foo.
> 
> 	    ^ foo? :-)

God damn it! I wrote foo, left nvim to check what the fixes tag would
be, came back and added it below but did not update this part of the
commit log...

> > Unfortunately that table did not match canonical order, as defined by
> > the RISC-V ISA Manual, which defines extension ordering in (what is
> > currently) Table 41, "Standard ISA extension names". Fix things up by
> > re-sorting v (vector) and adding p (packed-simd) & j (dynamic
> > languages). The e (reduced integer) and g (general) extensions are still
> > intentionally left out.
> > 
> > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> So I have compared the new pattern to the isa manual,
> and it looks like the order checks out, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks!

