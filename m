Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE17413BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjF1OVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:21:31 -0400
Received: from mx1.sberdevices.ru ([37.18.73.165]:51108 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjF1OUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:20:06 -0400
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2A969100010;
        Wed, 28 Jun 2023 17:20:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2A969100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687962004;
        bh=Lk3qB4uYxKXyPUp5kolLvL3qgFw7FLaRDeOgiAkPfaY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=XKNMDmCfB+n/eT0axZCuc6oQTuSbQOU9CWCpZg3JV0ziwt+BBWjeCZAVJ9IC1uxrw
         sRE6kjI493+xNLexts6m1cYfL+uz3mOoeh1QecFzgqhXyVHd17g0nNcrCgfIFVRZ89
         nw33wnuz6sPUsdeB/Bq6ksjlCYvKk7yadqQzxMDHpBERTN3O8+tHYpveU4xWdc78Q6
         vKQ75c1iAE1f/KtfhXyw9SoQGiOeW3ek2OtKbpLxmilImnZB/nTG0Mn6uuA9DbYEXD
         OJBekE9eY4QqP2qx9lsbssaG6XzgPC2tYWc6cVe+X9YSjDmkUrRTiAO3jrI3tOCj6T
         zWDTRG4G9xbNA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 17:20:04 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 17:19:06 +0300
Date:   Wed, 28 Jun 2023 17:20:03 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: Re: [PATCH v1 3/6] arm64: dts: meson: a1: enable efuse controller
 and setup its clk
Message-ID: <20230628142003.ggqbxkvuzn6noupc@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-4-ddrokosov@sberdevices.ru>
 <CAFBinCC0F4gaW1eFkJvf=oSkmAMmjbJ-ZFbVhpnrcGZPOX2sYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCC0F4gaW1eFkJvf=oSkmAMmjbJ-ZFbVhpnrcGZPOX2sYg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:50:37PM +0200, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +       efuse: efuse {
> > +               compatible = "amlogic,meson-gxbb-efuse";
> > +               clocks = <&clkc_periphs CLKID_OTP>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               secure-monitor = <&sm>;
> > +               power-domains = <&pwrc PWRC_OTP_ID>;
> > +               status = "okay";
> If eFuse is always enabled then we can just drop status = "okay" as
> that's the default.

Ahh, okay. I wasn't aware of that behavior. Thank you for pointing it
out!

-- 
Thank you,
Dmitry
