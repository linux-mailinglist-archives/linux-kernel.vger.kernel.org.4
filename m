Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1912710DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbjEYOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbjEYOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:01:50 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403E186;
        Thu, 25 May 2023 07:01:12 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9CC4D5FD51;
        Thu, 25 May 2023 17:01:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685023262;
        bh=bpPitjV95L3ioVshJeARXDTfhB1q4NXomIjqNtoVQq0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=g542J5yIh9b82dadzQ8Wzl6DX57oGV8BuX0mh2ze4Lxm+6swAF021XvoO8GlwxhT6
         Pq7nf95oLmZnAL7nbuuLJrlbpPy+Ls62/SpbtMjJ1+zYrgZRm+mv6c9jEW7PG11L7K
         MWOZeU+48k2eWJJPd5jBSlocvi6aBbF883AvvL3TtR5N3LA9lLGt0Mgy6Vufx4y4v0
         UZeg7QdcWiUFvEEKDnq6/udXmN2PqmQeLhV2nI8+vkeOpEFcvawVE/FCbXyq4nxnEJ
         tTtWSfufJTfkg06kJ5qH2vEyV2UYNmOpwFKsXlspxbSAfqDIQtzzNyjs8AnRfB8Y2s
         AWQ3QJod3p4IA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 25 May 2023 17:01:01 +0300 (MSK)
Date:   Thu, 25 May 2023 17:01:00 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor@kernel.org>, <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v16 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <20230525140100.mdzuhyfhxxkf4mx7@CAB-WSD-L081021>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
 <20230523135351.19133-6-ddrokosov@sberdevices.ru>
 <20230525093736.naztwqlhvskujsoa@CAB-WSD-L081021>
 <20230525-connected-skipper-442c6d0b52c1@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230525-connected-skipper-442c6d0b52c1@wendy>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/25 11:25:00 #21349968
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor,

Thank you for quick reply!

On Thu, May 25, 2023 at 02:16:02PM +0100, Conor Dooley wrote:
> On Thu, May 25, 2023 at 12:37:36PM +0300, Dmitry Rokosov wrote:
> > Hello Rob, Krzysztof and Conor,
> > 
> > Could you please take a look at this patch version? Before Rob marked
> > this patchset with RvB at v13 -
> > https://lore.kernel.org/linux-amlogic/168130720431.2218249.7671061964988064525.robh@kernel.org/
> > 
> > However, due to several comments from other maintainers, unfortunately,
> > I had to rename the 'a1-clkc' controller to 'a1-peripherals-clkc' and
> > remove Rob's RvB.
> 
> I dunno if the compatible change is worth dropping the tag for tbh.
> That seems to be the only change, so I guess you can have my R-b instead
> of Rob's...
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.

I was unaware of the official policy regarding the removal of RvB during
renaming changes. I took a cautious approach to the situation :)

-- 
Thank you,
Dmitry
