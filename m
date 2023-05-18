Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27121707DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjERKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjERKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:25:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D161BCA;
        Thu, 18 May 2023 03:25:06 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IAEK8L002605;
        Thu, 18 May 2023 05:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=lrR7AD4kdjzP/JrB+dgSF3zDq0ke3uwqNOkUksFHFwU=;
 b=oBZlbnrqQlqdIB+O3RTCGVGq23p1KhBI9v53NycD0xCHz64u7RjuTQZgIVNx3SHF8aFG
 5ma8TA4JQurVe8TwSfNc5689ek/gmvwmi7YlIUglV3RNm5iJ6dJo1vIKjanhdK0kPzD0
 nKuYmIwnJ0QQQH41yMprOr9aEmra7BL4waoE32GFy25n2m2t8s6ByfNe6oqCdz5GZbfP
 DodBgJuZumac6e8K5bqHxA2S3jtGll3J5X8k2lhXkEqSGAM4L9YJVp9FwUX98/ea1hc+
 5myL1TRvf5dR+Ab2tWoMYeROPAqXxMaXCqlf4HJpJn69UaRkTNDlyDgIA3tqG9oDakQb MA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y16rye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 05:24:45 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 05:24:42 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 05:24:42 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D11411AA;
        Thu, 18 May 2023 10:24:42 +0000 (UTC)
Date:   Thu, 18 May 2023 10:24:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: HL2reE85ez4JiS5HLok3m55m27gUTNMJ
X-Proofpoint-ORIG-GUID: HL2reE85ez4JiS5HLok3m55m27gUTNMJ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:16:42PM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:28, Charles Keepax wrote:
> > +static int cs42l43_soft_reset(struct cs42l43 *cs42l43)
> > +{
> > +	static const struct reg_sequence reset[] = {
> > +		{ CS42L43_SFT_RESET, 0x5A000000 },
> > +	};
> > +	unsigned long time;
> > +
> > +	dev_dbg(cs42l43->dev, "Soft resetting\n");
> 
> Drop simple debug statements for function entry/exit. There are other
> tools in kernel to do such debugging.

I mean I guess I can begrudingly drop them, there sure are other
tools but often just firing on debug is nice/simple/easy and
they are not really marking function entry/exit as much as they
are marking important events.

> > +struct cs42l43_patch_header {
> > +	__le16 version;
> > +	__le16 size;
> > +	u8 reserved;
> > +	u8 secure;
> > +	__le16 bss_size;
> > +	__le32 apply_addr;
> > +	__le32 checksum;
> > +	__le32 sha;
> > +	__le16 swrev;
> > +	__le16 patchid;
> > +	__le16 ipxid;
> > +	__le16 romver;
> > +	__le32 load_addr;
> > +} __packed;
> 
> Put all structs together at the top.

Can do.

> > +	hdr = (void *)&firmware->data[0];
> 
> Aren't you dropping here const? Why? That's not recommended programming.

Yeah that is fair will fix that up.

> > +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
> > +				    ARRAY_SIZE(cs42l43_reva_patch));
> > +	if (ret) {
> > +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(cs42l43->dev);
> > +	pm_runtime_put_autosuspend(cs42l43->dev);
> > +
> > +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
> > +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
> 
> I don't why adding devices is not in probe. They use the same regmap
> right? So there will be no problem in probing them from MFD probe.

Well except SoundWire is a bit of a special boy, the hardware is
not necessarily available in probe, the hardware is only available
at some point later when the device attaches. Doing it this way all
of the attaching (and various detach/attach cycles the device needs
during configuration) are over by the time the child drivers bind, so
they don't all need special code to handle that.

> > +	cs42l43->reset = devm_gpiod_get_optional(cs42l43->dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(cs42l43->reset)) {
> > +		ret = PTR_ERR(cs42l43->reset);
> > +		dev_err(cs42l43->dev, "Failed to get reset: %d\n", ret);
> 
> return dev_err_probe

Yeah will put those in.

> > +	cs42l43->vdd_p = devm_regulator_get(cs42l43->dev, "VDD_P");
> 
> Why these are not part of bulk get?

The comment right above explains this, VDD_P needs to be on for at
least 50uS before any other supply.

Thanks,
Charles
