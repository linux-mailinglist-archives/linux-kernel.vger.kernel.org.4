Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54A6EE196
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjDYMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjDYMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:05:12 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667C49F8;
        Tue, 25 Apr 2023 05:05:09 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 889195FD05;
        Tue, 25 Apr 2023 15:05:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682424306;
        bh=/7k2hmgzdS0RWThtX1QVPv33A+h1jqDTdyLWRVz4PtQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=rUHWN1H28wH6iCXoGWFuo0Owuh5UxXgiiUvT9oyGwOMOEYDF9gByjamwqDuIWOuXt
         PFRpBZGx1+BZ2xn4eMdt0SqXge2rJxNeT0x9tXzGu0XVPV0Hdp2hBsvPqDbNOc4xhL
         HAQWve0wxkYfvK9MJl6HSqSWQHGuNFMNXHXZqHP3gaumSc62gXiduIh8LvEJsbPIux
         m4y9fIin/257IMbKn4Hvu5dMU2kd4c71/ejzWTYrHGyBZ4JAtFsfuIR60QKya+AOW9
         aqnwRYUBFFa92VWgdYHCYhAhxIlI8GFovBlj1F0QArwb+0dIYT9P+H9t15CZr06HK3
         J1XB8AUGCaTGQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Apr 2023 15:05:05 +0300 (MSK)
Date:   Tue, 25 Apr 2023 15:05:05 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230425120505.xrgrjrxcxennrzct@CAB-WSD-L081021>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-7-ddrokosov@sberdevices.ru>
 <CAFBinCBGWOB2XLb6su=R3W684rKdK3pOgPFsCGx+Oyo_pgdeBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBGWOB2XLb6su=R3W684rKdK3pOgPFsCGx+Oyo_pgdeBg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/25 07:55:00 #21159618
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

On Sun, Apr 23, 2023 at 11:30:38PM +0200, Martin Blumenstingl wrote:
> On Wed, Apr 5, 2023 at 9:59 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +static const struct of_device_id a1_periphs_clkc_match_table[] = {
> > +       { .compatible = "amlogic,a1-clkc", },
> > +       {},
> nit-pick: please remove the comma after the sentinel
> 

Thank you for bringing up that point! There's no problem with removing
it in the next version of the product. I'll prepare it.

> > +MODULE_DEVICE_TABLE(of, a1_periphs_clkc_match_table);
> > +
> > +static struct platform_driver a1_periphs_clkc_driver = {
> > +       .probe = meson_a1_periphs_probe,
> > +       .driver = {
> > +               .name = "a1-clkc",
> > +               .of_match_table = of_match_ptr(a1_periphs_clkc_match_table),
> I wonder if we should drop of_match_ptr() here as no other meson clock
> driver uses it.
> Also there's commits like 00cb754ac622 ("clk: imx8mq: drop
> of_match_ptr from of_device_id table") which explicitly remove it from
> other drivers.

Exactly, all Meson clock drivers depend on the ARM64 config, which in
turn selects CONFIG_OF by default. So of_match_ptr can be dropped.

> 
> Apart form these two this patch looks great to me.
> 

-- 
Thank you,
Dmitry
