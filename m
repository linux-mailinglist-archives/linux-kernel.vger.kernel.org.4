Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749FE67F6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjA1Jm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjA1Jmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:42:52 -0500
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6152279B;
        Sat, 28 Jan 2023 01:42:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674898952; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HYVcNmWxzAWZeMT5XfziNVM/1MoiIewErGlhjLUArC7GE5i1lvCbPiTZaieQsfAWmmFlKIhRDbAldFlTugkqKv2Uk/iUflS76bvB58xrkClq9fNE6deFtySbL5y8EPl1Mti4Obk36SiA58FTnX/okYLYuZo8rmMRjBDS8dMs2Tg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674898952; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/kf7BqInHV8jif+hXq9bvUo6mPkW2NmTdqR/jyrd+TQ=; 
        b=Uobedi556y8C0VLUiUgnbZb7YTztbKVdeDcSj0x2r7ozlOpWwKc28qg6I3i1K+qpTHL0jW25jw40cdRUVgVQOfvzx7roxW45Au+TNDD0iq5Pis+WLzagMpVOe6guytuScEG9YGDx5NjzuXob7mW3p4cKuhb6vXLkeZCS1e7EHZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674898952;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=/kf7BqInHV8jif+hXq9bvUo6mPkW2NmTdqR/jyrd+TQ=;
        b=nZRbX3hzzBhSHql+t+0fd0H6D/r3udvjRjEj2qoBH2gwZvudt8+mfVPoDBmDUcp1
        9EO53Dyuss7/Vb7UDYFy9EXr1RhOFLh2I8WbKFvR35WUMpH0vslglZeW3FU6XlA+IXu
        QYQFd/VELrR/UDVMU9mNRWc+VaKcrunV7cSARgSg=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674898949800917.1691993197181; Sat, 28 Jan 2023 01:42:29 -0800 (PST)
Date:   Sat, 28 Jan 2023 17:42:29 +0800
From:   Li Chen <me@linux.beauty>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "stephen boyd" <sboyd@kernel.org>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "arnd bergmann" <arnd@arndb.de>
Message-ID: <185f7c1c693.b1cad2b8487563.1022046142491625830@linux.beauty>
In-Reply-To: <33c2038b-5e06-4eb2-82b8-007bb735bfb1@linaro.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty> <33c2038b-5e06-4eb2-82b8-007bb735bfb1@linaro.org>
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

 ---- On Fri, 27 Jan 2023 23:08:09 +0800  Krzysztof Kozlowski  wrote --- 
 > On 27/01/2023 15:48, Li Chen wrote:
 > >  > 
 > >  > but what you are saying is that there is no separate clock controller
 > >  > device with its own IO address but these clocks are part of rct_syscon.
 > >  > Then model it that way in DTS. The rct_syscon is then your clock
 > >  > controller and all these fake gclk-core and gclk-ddr nodes should be gone.
 > > 
 > > Ok, I will remove these fake nodes, and model the hardware as:
 > > 
 > > rct_syscon node
 > > | clock node(pll, div, mux, composite  clocks live in the same driver)
 > > | other periphal nodes
 > 
 > You need clock node if it takes any resources. If it doesn't, you do not
 > need it.

Got it, I will model it as:

rct_syscon(compatible include "ambarella, <SoC>-clock"...)
| peripheral A
| peripheral B
| ...


One more question, two driver models:
a. compatible = "ambarella, <SoC>-clock", handle all clocks(pll, div, mux, composite) in single driver.
b. compatible = "ambarella, <SoC>-pll-clock", "ambarella, <SoC>-composite-clock", "ambarella, <SoC>-div-clock"...... 
    and implement a driver for each of them.

Which driver model is preferred?

Regards,
Li
