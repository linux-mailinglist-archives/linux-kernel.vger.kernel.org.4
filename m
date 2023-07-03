Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C84746368
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGCThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGCThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:37:42 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37412B;
        Mon,  3 Jul 2023 12:37:38 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C0950120029;
        Mon,  3 Jul 2023 22:37:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C0950120029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688413056;
        bh=zfziv4Gt8zQ1NCScCv5V2gMF12e7nV9xy2Odg3hRLEI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=Cm5PmCgRDHZm/jtio2BYObyt1f+YofEeO0AWmvdumQdIPEBGrxumw+nVEA2lV4WEB
         JOST9H6fAhU+ob5a5z4A1YwXmxyLU27dfJs4aZeG2xQewnfn+i30DstY03tL1/ACEc
         c3Uw85nwmCElwwQn2GOabnXFQAVjsuxxHX8fXtT7RSB0PaWLf+EIspt2nkcXmdQ3Bq
         SJuOfKIjtBX3sKKkYFU51c3Rg/YPjaWz6WjeqbXIxeEc6tQBXv6Sybw4kzVwyl4sMa
         4eK7iAn9GzApSu92yZt5aCTS43u1cSIkDFCLKeY6DD6wcRgsWXMh4Zm2K3u97aUJqV
         fAXgUSyXtf51Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  3 Jul 2023 22:37:36 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 3 Jul
 2023 22:37:32 +0300
Date:   Mon, 3 Jul 2023 22:37:36 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        =Xianwei Zhao <xianwei.zhao@amlogic.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/3] soc: c3: Add support for power domains controller
Message-ID: <20230703193736.7teaaovalia3g3ml@CAB-WSD-L081021>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-3-xianwei.zhao@amlogic.com>
 <e85f6dee-d62c-9f2f-b1de-8c38bb5aeb14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e85f6dee-d62c-9f2f-b1de-8c38bb5aeb14@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178409 [Jul 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/03 16:02:00 #21557037
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 03:29:31PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 03/07/2023 11:31, =Xianwei Zhao wrote:
> > From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > 
> > Add support for C3 Power controller. C3 power control
> > registers are in secure domain, and should be accessed by SMC.
> > 
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > ---
> >   drivers/soc/amlogic/meson-secure-pwrc.c | 28 ++++++++++++++++++++++++-
> >   1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> > index 25b4b71df9b8..39ccc8f2e630 100644
> > --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> > +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/pm_domain.h>
> >   #include <dt-bindings/power/meson-a1-power.h>
> >   #include <dt-bindings/power/meson-s4-power.h>
> > +#include <dt-bindings/power/amlogic-c3-power.h>
> >   #include <linux/arm-smccc.h>
> >   #include <linux/firmware/meson/meson_sm.h>
> >   #include <linux/module.h>
> > @@ -132,6 +133,22 @@ static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
> >   	SEC_PD(S4_AUDIO,	0),
> >   };
> > +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> > +	SEC_PD(C3_NNA,	0),
> > +	SEC_PD(C3_AUDIO,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_SDIOA,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_EMMC,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_SDCARD,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_ETH,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_GE2D,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_CVE,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_GDC_WRAP,	GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_ISP_TOP,		GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
> > +	SEC_PD(C3_VCODEC,	0),
> > +};
> 
> Please move this struct before _s4_
> 
> > +
> >   static int meson_secure_pwrc_probe(struct platform_device *pdev)
> >   {
> >   	int i;
> > @@ -179,7 +196,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
> >   	for (i = 0 ; i < match->count ; ++i) {
> >   		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
> > -		if (!match->domains[i].index)
> > +		if (!match->domains[i].name)
> 
> Is this change necessary ? If yes please move it to another patch
> and explain it's purpose. If it fixes something, add a Fixes tag so
> it can be backported.
> 
> Thanks,
> Neil
> 

I suppose, this change fixes the situation with SEC_PD(C3_NNA, 0)
domain, because it has index == 0.
May be it's better to introduce the separate struct member for that? For
example, 'present' (true or false).
I think code would be more readable and clean.

[...]

-- 
Thank you,
Dmitry
