Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A76FF364
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbjEKNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjEKNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:50:31 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DEED9;
        Thu, 11 May 2023 06:50:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3C47B5FD5F;
        Thu, 11 May 2023 16:50:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683813028;
        bh=RMxJjEHJX0J6cuwdy2YgFZf1Gg52m0VezrZJvqOMaY8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=M6GU5ISY3Mv0QEnjh2NKb5xTVGYQYoSeIcRu0VuGPTsEejBDDGUhrGA4rfspJa+T0
         7oAa8lBpV8UvH3cVvDuf8xotDuykXPT2tDeBgRoz39z+VfTw3Rmkm529NaJ4PZGoG0
         DUrolTUhKLGN2K5PxUXEkRObkrlvz8zj5U8L7Wu0KQ4p8wTZnH8ES4C3ueCqwFHeZO
         H1akRIjfHBOaU/8hUfm6NYd12hz56Ate8iIcttopxSTuesYN0aJpW9hrL+TDx7QlTq
         svJrAC89qTH3UYczt3km/iLdj9cPL3/3TQAGnVlzsXIxrIQEZ18MUDjxmpfXR92dyt
         EMYvw7TteVwkg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 16:50:28 +0300 (MSK)
Date:   Thu, 11 May 2023 16:50:22 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
Message-ID: <20230511135022.jzkv4un4bbm375aw@CAB-WSD-L081021>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-6-ddrokosov@sberdevices.ru>
 <CAFBinCCdoaNuQymcjp5j9MHn2jpPWMqXe-+EgBo=5Ot8Bwaofw@mail.gmail.com>
 <2F9DDB93-5EE7-4B5D-AFB5-052968081E0A@gmail.com>
 <e29a7911-065a-04e2-f04f-027a0646362c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e29a7911-065a-04e2-f04f-027a0646362c@linaro.org>
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

Hello Krzysztof,

Thank you for the review!

On Tue, May 02, 2023 at 09:39:12AM +0200, Krzysztof Kozlowski wrote:
> On 02/05/2023 03:38, Christian Hewitt wrote:
> >> On 1 May 2023, at 7:51 pm, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On Wed, Apr 26, 2023 at 11:58 AM Dmitry Rokosov
> >> <ddrokosov@sberdevices.ru> wrote:
> >>>
> >>> Add the documentation for Amlogic A1 Peripherals clock driver,
> >>> and A1 Peripherals clock controller bindings.
> >> Maybe a native English speaker can comment on whether it's
> >> "peripheral" or "peripherals".
> > 
> > I’m not a grammar specialist, but I would write:
> > 
> > “Add documentation and bindings for the Amlogic A1 SoC peripherals
> > clock driver”
> > 
> > Peripherals is the correct plural but reads better when you add
> > context on the type of peripherals.
> 
> Drop the "driver" references - from the binding itself and from commit
> msg. The bindings are for hardware, not for the driver, so: "for the
> Amlogic A1 SoC peripherals clock controller.".

Okay, thank you for the suggestion! I will remove it in the next
version.

-- 
Thank you,
Dmitry
