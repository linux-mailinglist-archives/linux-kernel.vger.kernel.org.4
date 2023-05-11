Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE46FF35A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjEKNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEKNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:46:29 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE1199E;
        Thu, 11 May 2023 06:46:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 409955FD5F;
        Thu, 11 May 2023 16:46:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683812781;
        bh=WC0yahayL00lp9RjVX6ifkwESNGz2I60jc5UqW7rtAw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=aaLh5SlwmrxUGQy4Nt1nFHJEK4zhWwytNo8Ovia/U9RHOOvB8RT67woDb+Sc9RVC9
         6495ZqGXUwvDbJnctimR8g6Qc10Pv0yz0eJqlJQu7A9wHhKy/0YYWvn2OFuF+VgS3M
         X+Id6qi0RyRHpTh0gN4smLrJ2py0xWX8mKLkPDDoOmgDdkZeLtYn0tKSrQEjIE57u+
         WbOwdiPaUL2MqLA4YGnOSCOdva7ywE6dTH00wQkFaqvVYc25yKiQef8UdS9ncKP0FD
         9LcQM3bN534yyvG4g3ek5lYNgohsEKWzPfiSChn7rzRAvxtyYERfiUN72EwT+t63hE
         Wk0wKAWC/fspg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 16:46:21 +0300 (MSK)
Date:   Thu, 11 May 2023 16:46:20 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Christian Hewitt <christianshewitt@gmail.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        AML <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <20230511134620.iukkxnbotcjyfcyx@CAB-WSD-L081021>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-6-ddrokosov@sberdevices.ru>
 <CAFBinCCdoaNuQymcjp5j9MHn2jpPWMqXe-+EgBo=5Ot8Bwaofw@mail.gmail.com>
 <2F9DDB93-5EE7-4B5D-AFB5-052968081E0A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F9DDB93-5EE7-4B5D-AFB5-052968081E0A@gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On Tue, May 02, 2023 at 02:38:20AM +0100, Christian Hewitt wrote:
> > On 1 May 2023, at 7:51 pm, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> > 
> > Hi Dmitry,
> > 
> > On Wed, Apr 26, 2023 at 11:58 AM Dmitry Rokosov
> > <ddrokosov@sberdevices.ru> wrote:
> >> 
> >> Add the documentation for Amlogic A1 Peripherals clock driver,
> >> and A1 Peripherals clock controller bindings.
> > Maybe a native English speaker can comment on whether it's
> > "peripheral" or "peripherals".
> 
> I’m not a grammar specialist, but I would write:
> 
> “Add documentation and bindings for the Amlogic A1 SoC peripherals
> clock driver”
> 
> Peripherals is the correct plural but reads better when you add
> context on the type of peripherals.

Thank you for your suggestion! I will make the change in the v15.

[...]

-- 
Thank you,
Dmitry
