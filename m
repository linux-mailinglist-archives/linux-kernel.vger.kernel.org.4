Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34B7413D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjF1O2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:28:21 -0400
Received: from mx2.sberdevices.ru ([45.89.224.132]:25117 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbjF1O2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:28:18 -0400
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8EB3A12001A;
        Wed, 28 Jun 2023 17:28:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8EB3A12001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687962481;
        bh=vHb1I+eeL4dIRqb6WnplQbJGzMM2hmPjqcCXHrotSL0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=X/CQhSzZLbvh8bKAIbnoL0Jfp+x2KCoQ1aGYHm6EcuwgBQgBOJgX5U6fUGKqwQsq3
         ZdXzx0oQFniBSGdBLEThM74VD0xytBszrSIDOgSrsiK8v4dmV+9BbFyb3WEKUY3Iw9
         ykeTLXI+SZdg0k6+ZTh6430l0UIueDHTC+NvD7wK7cyuwBoeu/k3TkTG/UjwZz8kqO
         OknfRu/c1GnEdvDc9Dmlk818TCkTFEHsaYesHTvGVtHRPwbVkYEy86/QDhpTJP0rmg
         bTJfia6aNn+gGweP5zhdf2+q5Gs/bjKfqR9b20sTy7+JYr2kA+IxluDpIMT4zY0n+U
         gJhHacMQXJuvw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 17:28:00 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 17:27:02 +0300
Date:   Wed, 28 Jun 2023 17:28:00 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <jbrunet@baylibre.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <conor+dt@kernel.org>, <kernel@sberdevices.ru>,
        <sdfw_system_team@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>
Subject: Re: [PATCH v1 6/6] arm64: dts: meson: a1: add eMMC controller and
 its pins
Message-ID: <20230628142800.thhexjvk7ekhdb3m@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-7-ddrokosov@sberdevices.ru>
 <CAFBinCC_g6FhzR=PNDsYwT4OZb4uAXAWYGKSe7vSX7_pWM8pNA@mail.gmail.com>
 <41e6d93a-8899-e792-0859-d26360ef5dab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41e6d93a-8899-e792-0859-d26360ef5dab@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178314 [Jun 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

Thank you for the review!

On Mon, Jun 26, 2023 at 03:36:23PM +0200, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 25/06/2023 23:11, Martin Blumenstingl wrote:
> > On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> > > 
> > > From: Jan Dakinevich <yvdakinevich@sberdevices.ru>
> > > 
> > > The definition is inspired by a similar one for AXG SoC family.
> > > 'sdio_pins' and 'sdio_clk_gate_pins' pinctrls are supposed to be used as
> > > "default" and "clk-gate" in board-specific device trees.
> > Let's wait for Neil's response on the other patch for the question
> > about pin mux settings
> > 
> > > 'meson-gx' driver during initialization sets clock to safe low-frequency
> > > value (400kHz). However, both source clocks ("clkin0" and "clkin1") are
> > > high-frequency by default, and using of eMMC's internal divider is not
> > > enough to achieve so low values. To provide low-frequency source,
> > > reparent "sd_emmc_sel2" clock using 'assigned-clocks' property.
> > Even if the pinctrl part should be postponed then I think it's worth
> > adding &sd_emmc
> 
> Yeah it's weird to add HW definition and to not enable them,
> so please enable them in the board if you add them in the DTSI.

Unfortunately, I'm unable to provide our internal board DTS. However, I
have an AD401 reference board on hand, so it's possible to test
everything there. I'll include these changes in the next version.

-- 
Thank you,
Dmitry
