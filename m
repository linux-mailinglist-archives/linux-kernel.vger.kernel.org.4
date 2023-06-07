Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE417251ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbjFGCE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjFGCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:04:52 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27AD3;
        Tue,  6 Jun 2023 19:04:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6610C24E254;
        Wed,  7 Jun 2023 10:04:38 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Jun
 2023 10:04:38 +0800
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Jun
 2023 10:04:37 +0800
Received: from EXMBX067.cuchost.com ([fe80::a825:bd30:18ff:b2f8]) by
 EXMBX067.cuchost.com ([fe80::a825:bd30:18ff:b2f8%16]) with mapi id
 15.00.1497.044; Wed, 7 Jun 2023 10:04:37 +0800
From:   Mason Huo <mason.huo@starfivetech.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Thread-Topic: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Thread-Index: AdmY3zKiK3gdrfFbSMGgpG/WG54SYA==
Date:   Wed, 7 Jun 2023 02:04:37 +0000
Message-ID: <f29a14dad3d744bba54e561a050bdfaa@EXMBX067.cuchost.com>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-3-mason.huo@starfivetech.com>
 <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
 <20230606-unsmooth-slip-c80fab59c9b4@wendy>
In-Reply-To: <20230606-unsmooth-slip-c80fab59c9b4@wendy>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [183.27.98.122]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh & Conor,

Sorry for the confusion. 
Should I re-send the patch series and remove this patch?
Or you can just ignore it?

Thanks
Mason

> On Tue, Jun 06, 2023 at 04:38:04PM +0530, Viresh Kumar wrote:
> > On 06-06-23, 18:56, Mason Huo wrote:
> > > Add the compatible strings for supporting the generic cpufreq driver 
> > > on the StarFive JH7110 SoC.
> > > 
> > > Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c 
> > > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > index 338cf6cc6596..14aa8281c7f4 100644
> > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > @@ -85,6 +85,8 @@ static const struct of_device_id allowlist[] __initconst = {
> > >  	{ .compatible = "st-ericsson,u9500", },
> > >  	{ .compatible = "st-ericsson,u9540", },
> > >  
> > > +	{ .compatible = "starfive,jh7110", },
> > > +
> > >  	{ .compatible = "ti,omap2", },
> > >  	{ .compatible = "ti,omap4", },
> > >  	{ .compatible = "ti,omap5", },
> > 
> > I thought I already merged it ?
> 
> You did, 4b4c0d37164c ("cpufreq: dt-platdev: Add JH7110 SOC to the allowlist").
