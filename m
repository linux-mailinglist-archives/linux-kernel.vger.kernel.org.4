Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC516071FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJUIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJUIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:20:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC4FE5EED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:20:19 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221021082013epoutp04059944810436b3db2b2d77c2ebea2111~gB8ccvYKV2531425314epoutp04C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:20:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221021082013epoutp04059944810436b3db2b2d77c2ebea2111~gB8ccvYKV2531425314epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666340413;
        bh=ru6zW0Cyu0xyCHYR0n15ZAPsUBVG3/SWEGyF7XfVzmY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=PZtJ81f152g1MgiRuM3ZcUs6eOhRLTjR1X/txP7uyxh6n0AMFC2GjNBOL6D9OyHJk
         vt9Iy5g1rrIP3sh7EpvVup6cSVPSNDT9PY/t6dy6BRDXXNWlJZYaR8iHpmfHRX415d
         TCprHp1PV+m4yPUGCvYV8tw76ih3ZtlMHsDxgPYo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221021082013epcas5p40247fb3e528b9dd306f0da3434a995ee~gB8b7uuij2083520835epcas5p4i;
        Fri, 21 Oct 2022 08:20:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mty7v53qQz4x9Pw; Fri, 21 Oct
        2022 08:20:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.44.10166.B3652536; Fri, 21 Oct 2022 17:20:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221021080909epcas5p29565927a3ac956e307448b8b566a8b30~gByxVFD_j1934519345epcas5p2a;
        Fri, 21 Oct 2022 08:09:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221021080909epsmtrp1dbafd3e1c0f017b035a5e3b538d7cc48~gByxUNSOg0171601716epsmtrp1P;
        Fri, 21 Oct 2022 08:09:09 +0000 (GMT)
X-AuditID: b6c32a49-dd627700000227b6-7d-6352563b0b01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.30.18644.4A352536; Fri, 21 Oct 2022 17:09:09 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021080906epsmtip1c4af9e4aea69ef1737d2240579644c50~gByuujzWc0681606816epsmtip17;
        Fri, 21 Oct 2022 08:09:05 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <Y0lUuK0V8qVnr+LW@sirena.org.uk>
Subject: RE: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
Date:   Fri, 21 Oct 2022 13:39:04 +0530
Message-ID: <04a801d8e524$65416ec0$2fc44c40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwG1dkA8AWCzSJ4DCj0/vKyO+8BA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmhq51WFCywexH0hYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCwWbf3CbtG5q5/VYtaFHawW
        rXuPsFscftPOarHh+1pGB36PDZ+b2Dx2zrrL7rFpVSebx51re9g89r1dxubRt2UVo8f6LVdZ
        PD5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhg
        YGQKVJiQnbGn9QNrwTWRinfHtBsYjwl0MXJySAiYSFzYu5AJxBYS2M0osXa1XxcjF5D9iVGi
        /X8PI4TzmVHi/caPzDAdn67+YYJI7GKU+PKilRnCecEo0TH9ENgsNgFziUV7lzKC2CIC6hJH
        N21kBSliFuhilthw5B0LSIJTQFfi4qOp7CC2sICrxKxvn1lBbBYBVYmPb7eAreMVsJS4/XMr
        C4QtKHFy5hMwm1lAXmL72zlQJylI/Hy6jBVimZvEvisPmSBqxCWO/uwBu05C4A2HxPb594Ac
        DiDHReLUekuIXmGJV8e3sEPYUhIv+9ug7HyJaR+b2SDsCom2jxuYIGx7iQNX5rCAjGEW0JRY
        v0sfIiwrMfXUOqi1fBK9v59AlfNK7JgHY6tKrF++iRHClpbYd30v4wRGpVlIPpuF5LNZSD6Y
        hbBtASPLKkbJ1ILi3PTUYtMCw7zUcnh8J+fnbmIEp20tzx2Mdx980DvEyMTBeIhRgoNZSYS3
        4F1AshBvSmJlVWpRfnxRaU5q8SFGU2BwT2SWEk3OB2aOvJJ4QxNLAxMzMzMTS2MzQyVx3sUz
        tJKFBNITS1KzU1MLUotg+pg4OKUamBSYRJdmx+7SCtQzXyee4/Uu/YCBLeN2BqnZ3D/leBa8
        Sfv/Wursiz6G2xLNViyTD4d7fWF1f+Fwfc7+goi0j9s8Esw6J+wMWfHgeoTECke9r/qKprbM
        J2QvB/Mon357yNMs46rAUt6AmTUG2zJFpHs/nJvHocnEbtWt3vbvjH8d12y10yH7Cldcb3ks
        mScR66P4/oTBwdf7X5uunLN/ppemgb7hw3tiExe9l2y+YyGbdmPPwoDfDSxBMjfKbj2a/y1r
        XlFuYpvW3+KXe92zLd5zqOVlObi95xapUVy8V7Ryxa8jvlazBNx/iVQHNU2arffZ7elf1cN3
        b6VsktHdzGq/LLI75fMDtTKF5g3NSizFGYmGWsxFxYkALZGBa2QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO7S4KBkg/mrmCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        WvceYbc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEcVlk5Kak1mWWqRvl8CVsaf1A2vBNZGKd8e0GxiPCXQxcnJICJhIfLr6h6mLkYtD
        SGAHo8TFKx0sEAlpien9e9ggbGGJlf+es0MUPWOUuLH6AjtIgk3AXGLR3qWMILaIgLrE0U0b
        WUGKmAVmMEscunWJFSQhJPCIUWLFlSgQm1NAV+Lio6lgzcICrhKzvn0Gq2ERUJX4+HYLM4jN
        K2ApcfvnVhYIW1Di5MwnQDYH0FA9ibaNYLuYBeQltr+dwwxxnILEz6fLWCFucJPYd+UhE0SN
        uMTRnz3MExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4crW0djDuWfVB7xAjEwfjIUYJDmYlEd6CdwHJQrwpiZVVqUX58UWlOanFhxilOViUxHkv
        dJ2MFxJITyxJzU5NLUgtgskycXBKNTCdvrjo0qruKZwbazunSjg+Vtfh5ZhxxOjF20faqS9W
        GR5IWRwv3bhxDlfEoYzfH+7ffVhbVfTsTOeuAO29Fa0/DfsN/2RnHZn+1u5h2jqZ9bFb/bd6
        ecmFibUaezluWlZ571iJwvc7lSyzM+79DZesc/h7o/Xkn9ZJ057KfNXfV8dt9ripYuK8Nr5b
        P/Y7u9/Playp9p0jct1za9ffL7a/779b8vklx1YO9e6wiwcuCDIuePXU3d98f9NOAXMpbxGx
        tOLn32e915Jx1wiweHdu738uXfmPWXNfOYR3e6/LcXtXxL7xrcOjEoPe44t+3JvzZ4Hvpp6D
        yx54tE1aXyrz99MLq7O2cVsf8M52512jr8RSnJFoqMVcVJwIAOGdMRNLAwAA
X-CMS-MailID: 20221021080909epcas5p29565927a3ac956e307448b8b566a8b30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104904epcas5p4f458182cc9ac9c223d9a25566f3dd300@epcas5p4.samsung.com>
        <20221014102151.108539-5-p.rajanbabu@samsung.com>
        <Y0lUuK0V8qVnr+LW@sirena.org.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 14 October 2022 05:53 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Cc: lgirdwood@gmail.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
> 
> On Fri, Oct 14, 2022 at 03:51:49PM +0530, Padmanabhan Rajanbabu wrote:
> 
> > +++ b/sound/soc/samsung/fsd-card.c
> > @@ -0,0 +1,349 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ALSA SoC Audio Layer - FSD Soundcard driver
> > + *
> > + * Copyright (c) 2022 Samsung Electronics Co. Ltd.
> > + *	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> 
> Please make the entire comment a C++ one so things look more intentional.
okay
> 
> > +	if (link->dai_fmt & SND_SOC_DAIFMT_CBC_CFC) {
> > +		cdclk_dir = SND_SOC_CLOCK_OUT;
> > +	} else if (link->dai_fmt & SND_SOC_DAIFMT_CBP_CFP) {
> > +		cdclk_dir = SND_SOC_CLOCK_IN;
> > +	} else {
> > +		dev_err(card->dev, "Missing Clock Master information\n");
> > +		goto err;
> > +	}
> 
> We're trying to modernise the langauge around clock providers, please use
> that term rather than the outdated terminology here.
Okay, I'll make the necessary change for the clock terminologies in the next
patch set
> 
> > +	if (priv->tdm_slots) {
> > +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, false, false,
> > +				priv->tdm_slots, priv->tdm_slot_width);
> > +		if (ret < 0) {
> > +			dev_err(card->dev,
> > +				"Failed to configure in TDM mode:%d\n",
> ret);
> > +			goto err;
> > +		}
> > +	}
> 
> Just set things once on probe if they don't depend on the configuration,
it's
> neater and marginally faster if nothing else.
Okay
> 
> > +	if (of_property_read_bool(dev->of_node, "widgets")) {
> > +		ret = snd_soc_of_parse_audio_simple_widgets(card,
> "widgets");
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	}
> > +
> > +	/* Add DAPM routes to the card */
> > +	if (of_property_read_bool(node, "audio-routing")) {
> > +		ret = snd_soc_of_parse_audio_routing(card, "audio-
> routing");
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	}
> 
> Just fix the library functions to handle missing properties gracefully,
every
> card is going to need the same code here.
Okay

Thank you for reviewing the patch

