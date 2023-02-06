Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1968BB81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBFL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBFL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:28:45 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0653C03;
        Mon,  6 Feb 2023 03:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675682895; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RY6R5BOppnWZR3jpmEhe40gafeLLD0Ldm9ihovKmn3SUsznINGz7ftWJHvp/ZRTiPm6K3IYSlGO51pjvcK+59kvhv0Gf5QkJjJRk9SUZkKp6Sv0Q5n5YgbL+Tn3Yx/Tw51BP9wLYAIdhp6TO5ltV6LqD4G9EZK1cy5jFKTNpUAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675682895; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=o/sww2PbahsgG/SAcgenvXBIa7XT0lp/YW4WEWaKfcw=; 
        b=ShCBsALaMyzTbOnM6w0h7Rggp/wn6XAX10bXm4eiV39e7WN/nBqP5iXTYJa1F3fou3ZA1LtQ6yFzFEATGDFAGzF66Ub6dHnSqPbdfpydU13oMEeqcTEQXSHEP5m++ggyfv2X2NJq6XT5y0lPQ179EH11FccFcv23WFCCUu2fm6I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675682895;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=o/sww2PbahsgG/SAcgenvXBIa7XT0lp/YW4WEWaKfcw=;
        b=TtPu6En2UvuBluR94/4iW4wnlOrYmezEsG29p4rtk4BOW7tyCm/8cj2yylszWtRK
        6Wck6C0nDLjyN0jIxqU/t1IeKwvFIn7r6XUe3BqWJtuMWPdE1QkK5r59nQuq94lbXmH
        ut5NfyzmpMQNzOYH/mTYe2SSFvV1CxilNRQLCwOI=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1675682895015699.3058709392761; Mon, 6 Feb 2023 03:28:15 -0800 (PST)
Date:   Mon, 06 Feb 2023 19:28:14 +0800
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
Message-ID: <186267bd495.c0d336602542450.72693939722996463@linux.beauty>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof ,

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

If the only hardware resource the clock node can take is its parent clock(clocks = <&osc>;),
then can I have this clock node?

Regards,
Li
