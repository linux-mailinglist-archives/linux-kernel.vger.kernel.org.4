Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47F5632338
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKUNN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKUNNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:13:55 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D418B24;
        Mon, 21 Nov 2022 05:13:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C4E9624E2BA;
        Mon, 21 Nov 2022 21:13:41 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 21:13:41 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 21:13:41 +0800
Message-ID: <dc09d673-906c-0cd2-2f16-5ee0af3691e2@starfivetech.com>
Date:   Mon, 21 Nov 2022 21:13:27 +0800
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
 <13578755-ab98-7567-258d-bc6c4164ee6c@starfivetech.com>
 <CAJM55Z-a1Pg2q7ZyvhwU2sp9YpsJZmE8y161UM-Ap7egCdgYVw@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z-a1Pg2q7ZyvhwU2sp9YpsJZmE8y161UM-Ap7egCdgYVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 12:32:24 +0100, Emil Renner Berthing wrote:
> On Mon, 21 Nov 2022 at 08:16, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > On Sat, 19 Nov 2022 00:26:27 +0800, Emil Renner Berthing wrote:
> > > On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
> > > >
> > > > Rename "clk-starfive-jh7100.h" to "clk-starfive-jh71x0.h" and rename
> > > > some variables from "jh7100" or "JH7100" to "jh71x0" or "JH71X0".
> > > >
> > > > Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> > >
> > > The patch is fine, but I'm a little unsure about this Co-developed-by.
> > > This patch is taken directly from my jh7110 branch so does Hal sending
> > > it count as co-developed-by?
> >
> > Your original patch merged patch 1 and patch 2. Suggested by Stephen, I
> > split the patch into two patches, and I need to add a new commit. My
> > previous thinking was that the Co-developed-by tag should not be added
> > to the commit author, so I added it to you.
> 
> Even if you didn't just copy it[1] I still don't think splitting
> patches counts as "developed by". You can set the author of new
> commits or copy them from a previous commit with git commit -c.

Okay, I will remove my Co-developed-by tag in patch 1, 2, 4, 5 and set the
commit author as you.

> 
> [1]: https://github.com/esmil/linux/commit/df4bcbc307e97cb6a0e7b8ed5ecc66487395176d

Oh, I don't even know you still work on JH7110 and update on github.. All
your patches were cherry-picked from your gitlab branch. There is no doubt
that we did the same thing for this patch.

Best regards,
Hal
