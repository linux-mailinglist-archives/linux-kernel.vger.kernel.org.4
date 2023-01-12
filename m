Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332F966757E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjALOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjALOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:21:35 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8EC5E668;
        Thu, 12 Jan 2023 06:12:45 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C9dqXG021075;
        Thu, 12 Jan 2023 06:12:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=o99ykTzML7zFN4dw9PwlFyBeheG3xAQZAUBYrVKdw+Q=;
 b=QGtfQloFjJ6FiR9nNL3gNjjZdNToltFUiCNX2UaNIHcvCY905Uy9HNqP3aSFcf1gMVX4
 X6nn77aq8Sqn45rp0tmp6+D1T4/ib+Kkajc3u9TzpnhH6hUjZbK5UDVw+PXMHF0L7I2y
 lftzcQgMn8zXx5GcoAi6cIUxgciXumwP1uyH202nkqcS5+4iOMVkE5bV1Oslen4wccoT
 hSHuYWMQs8+prhWwPlLRVlJUdkWI2Gy2BPbul8yFkUsHVMn7dOG9CCQ08XWCEtALGX/V
 ZfLfiqObRUlH3sr+Ffui3w/bLv2KQ3LayZsLrB6U6lFHru+Ydo047enyjFjxvVGq2ACp /g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n1k570dqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 06:12:33 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 12 Jan
 2023 06:12:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 12 Jan 2023 06:12:31 -0800
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id BCE3C3F7051;
        Thu, 12 Jan 2023 06:12:30 -0800 (PST)
Date:   Thu, 12 Jan 2023 06:12:30 -0800
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH 2/5] drivers: mmc: sdhci-cadence: enable
 MMC_SDHCI_IO_ACCESSORS
Message-ID: <20230112141230.GB6335@Dell2s-9>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-3-pmalgujar@marvell.com>
 <35ea0a7a-3d63-26b7-4dc3-69f6ca41909a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35ea0a7a-3d63-26b7-4dc3-69f6ca41909a@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: mGrgC6KPVjgpf9ISHeeX3wrUQ79TflSH
X-Proofpoint-GUID: mGrgC6KPVjgpf9ISHeeX3wrUQ79TflSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, 

Thank you for the review comments.

On Wed, Jan 11, 2023 at 10:23:43AM +0200, Adrian Hunter wrote:
> On 19/12/22 16:24, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> > Add support for CONFIG_MMC_SDHCI_IO_ACCESSORS for controller
> > specific register read and write APIs.
> > 
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  drivers/mmc/host/Kconfig         | 12 ++++++
> >  drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5e19a961c34d7b5664ab2fd43cfba82dc90913ac..b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -262,6 +262,18 @@ config MMC_SDHCI_CADENCE
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_CN10K
> > +	tristate "SDHCI Cadence support for Marvell CN10K platforms"
> > +	select MMC_SDHCI_CADENCE
> > +	select MMC_SDHCI_IO_ACCESSORS
> 
> Probably better to just add MMC_SDHCI_IO_ACCESSORS to 
> config MMC_SDHCI_CADENCE and drop MMC_SDHCI_CN10K
> 

This reason behind this was to not force SDHCI_IO_ACCESSORS upon cadence users as some may not
require it owing to how cadence ip is integrated to soc.

> > +	help
> > +	  This selects the SDHCI cadence driver and IO Accessors
> > +	  for Marvell CN10K platforms
> > +
> > +	  If you have Marvell CN10K platform, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_CNS3XXX
> >  	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
> >  	depends on ARCH_CNS3XXX || COMPILE_TEST
> > diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> > index 5332d19e489be936d6814feba4f0fc046f5e130e..6bf703f15bc5be7e3be4cb1144b78ec3585ec540 100644
> > --- a/drivers/mmc/host/sdhci-cadence.c
> > +++ b/drivers/mmc/host/sdhci-cadence.c
> > @@ -449,6 +449,61 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
> >  
> >  static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
> >  
> > +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> > +static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
> > +{
> > +	return readl(host->ioaddr + reg);
> > +}
> > +
> > +static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +	writel(val, host->ioaddr + reg);
> > +}
> > +
> > +static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
> > +{
> > +	u32 val, regoff;
> > +
> > +	regoff = reg & ~3;
> > +
> > +	val = readl(host->ioaddr + regoff);
> > +	if ((reg & 0x3) == 0)
> > +		return (val & 0xFFFF);
> > +	else
> > +		return ((val >> 16) & 0xFFFF);
> > +}
> > +
> > +static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
> > +{
> > +	writew(val, host->ioaddr + reg);
> > +}
> > +
> > +static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
> > +{
> > +	u32 val, regoff;
> > +
> > +	regoff = reg & ~3;
> > +
> > +	val = readl(host->ioaddr + regoff);
> > +	switch (reg & 3) {
> > +	case 0:
> > +		return (val & 0xFF);
> > +	case 1:
> > +		return ((val >> 8) & 0xFF);
> > +	case 2:
> > +		return ((val >> 16) & 0xFF);
> > +	case 3:
> > +		return ((val >> 24) & 0xFF);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
> > +{
> > +	writeb(val, host->ioaddr + reg);
> > +}
> > +#endif
> > +
> >  static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
> >  {
> >  	u32 delay_element = phy->d.delay_element_org;
> > @@ -1576,6 +1631,14 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
> >  };
> >  
> >  static const struct sdhci_ops sdhci_cdns_sd6_ops = {
> > +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> > +	.read_l = sdhci_cdns_sd6_readl,
> > +	.write_l = sdhci_cdns_sd6_writel,
> > +	.read_w = sdhci_cdns_sd6_readw,
> > +	.write_w = sdhci_cdns_sd6_writew,
> > +	.read_b = sdhci_cdns_sd6_readb,
> > +	.write_b = sdhci_cdns_sd6_writeb,
> > +#endif
> >  	.get_max_clock = sdhci_cdns_get_max_clock,
> >  	.set_clock = sdhci_cdns_sd6_set_clock,
> >  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> 

Rest of the comments will be taken care in v2.

Thanks,
Piyush
