Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36768631A12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKUHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:16:41 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3913DFA;
        Sun, 20 Nov 2022 23:16:38 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5CA6024E199;
        Mon, 21 Nov 2022 15:16:37 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 15:16:37 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 15:16:36 +0800
Message-ID: <13578755-ab98-7567-258d-bc6c4164ee6c@starfivetech.com>
Date:   Mon, 21 Nov 2022 15:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 02/14] clk: starfive: Rename "jh7100" to "jh71x0" for
 the common code
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-3-hal.feng@starfivetech.com>
 <CAJM55Z-Zftr29oGzeBFzOKuGixABSJEzPF-R2c0U9Pg5qDcRCQ@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z-Zftr29oGzeBFzOKuGixABSJEzPF-R2c0U9Pg5qDcRCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 00:26:27 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > Rename "clk-starfive-jh7100.h" to "clk-starfive-jh71x0.h" and rename
> > some variables from "jh7100" or "JH7100" to "jh71x0" or "JH71X0".
> >
> > Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> 
> The patch is fine, but I'm a little unsure about this Co-developed-by.
> This patch is taken directly from my jh7110 branch so does Hal sending
> it count as co-developed-by?

Your original patch merged patch 1 and patch 2. Suggested by Stephen, I
split the patch into two patches, and I need to add a new commit. My
previous thinking was that the Co-developed-by tag should not be added
to the commit author, so I added it to you.

Best regards,
Hal

> 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

