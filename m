Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A75FC6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJLOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJLOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:05:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA25C358;
        Wed, 12 Oct 2022 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665583531; x=1697119531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YqIauvraatao1KA8yPWOhmJyrNRczVNaBMKcZve1xvY=;
  b=rLmO+DY7voSQrTTm4p1gN6rZyTFvTtAlJudbpLKAl/MXgfyJyY9HBIs0
   xy7ARH2+grR5cDYSMRoLsBiMstYxB/SQtm2NIPEBa24rPqZntKMeohEHm
   YTj8MU6sL3BWFfzcZxL/OzHt2P+wAJR0TJqlNoLa0EtZsfNJhnA6rjibc
   uC6Sd6//9ygAk/AYWmXIZzNmLVl9ZiSFEuZo0CAMx68bcv2ZMvW/V0CLV
   kYJiaVeQW6Mb5oE9Y2Z/XFBM8cXveL3Xfrys39hQAwG1clWIghpifHzMH
   J04QifrfGT4fDgSEd/0knTRXx1+dVBqFzlOsV+9ez5luO03niJGhNHiGh
   A==;
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="195051104"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2022 07:05:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 12 Oct 2022 07:05:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 12 Oct 2022 07:05:26 -0700
Date:   Wed, 12 Oct 2022 15:05:04 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hal Feng <hal.feng@linux.starfivetech.com>
CC:     Hal Feng <hal.feng@linux.starfivetech.com>,
        Rob Herring <robh@kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset
 bindings
Message-ID: <Y0bJkGQklX+eOGyW@wendy>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
 <20220929184349.GA2551443-robh@kernel.org>
 <8BEAFAD2C4CE6E4A+0a00376c-1e3e-f597-bcf6-106ff294859a@linux.starfivetech.com>
 <2f1d1afd-3c97-6ce0-8247-6e1c4a24e548@linaro.org>
 <4769BE3503398017+b1699221-ccc9-a0c1-0b11-141ce9644d74@linux.starfivetech.com>
 <9f04267d-2592-b303-9b79-9cef672c970a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f04267d-2592-b303-9b79-9cef672c970a@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hal Feng,

On Wed, Oct 12, 2022 at 09:33:42AM -0400, Krzysztof Kozlowski wrote:
> >>> These two properties are the key differences among different reset controllers.
> >>
> >> Different as in different compatibles? Please answer the questions..> 
> >>> There are five memory regions for clock and reset in StarFive JH7110 SoC. They
> >>> are "syscrg", "aoncrg", "stgcrg", "ispcrg" and "voutcrg". Each memory region
> >>> has different reset ASSERT/STATUS register offset and different number of reset
> >>> signals. 
> >>
> >> Then these are not exactly the same devices, so using one compatible for
> >> them does not look correct.
> > 
> > One compatible can just be matched by one device? I think this is what
> > confuses me.
> 
> I don't understand the question.

If two SoCs have exactly the same device/peripheral then they _can_ use
the same compatible. If they share some common, viable feature-set then
one can "fall back" to the other depending on what your Venn diagram of
common features looks like. I've not been following this too closely,
but I think what Krzysztof is suggesting is that you have a jh7100 and
a jh7110 compatible. Then in your driver you just "know" that if you
match against jh7110 which values to use for register offsets & vice
versa for a match against the jh7100. There's many examples over the
tree for how to handle this sort of thing rather than including it in
the devicetree.

Maybe Rob and Krzysztof will scream at me for this description, but
devicetree is about how periperhals etc are connected together in the
system not about the internals of a given peripheral.

Following that logic, the devicetree should not contain register offsets
etc that are a known quanitity once you've determined that you are running
on vendor,soc-foo.

Hopefully that helps with your confusion somewhat?
Conor.

