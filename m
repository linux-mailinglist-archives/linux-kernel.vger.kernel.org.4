Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094760747D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJUJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJUJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:53:41 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E124FEEC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:53:39 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221021095336epoutp01b340fd2c41ebf9dfcb3ec464dbcb3179~gDN_IqM8x0774007740epoutp01L
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221021095336epoutp01b340fd2c41ebf9dfcb3ec464dbcb3179~gDN_IqM8x0774007740epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666346016;
        bh=9aPB06MF+/YHgJus+BbRjRYNXreCQbXjjMGXk/zIOa8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aiBx2MlyJ1WEvTpC9dygCFDADRX8BMBSlJlkLuOF8vQEH/WkviYnokQgpoa5ULsAC
         p0lTKpY47UTOxqwVTDz2BwiF4cZLGL5z93XieSMkOVN4QKwBVJ7eFwxY4yWFdYHXg0
         VPeq6V6CIySlBOjbsylu2vWardjioR3f3v5lR710=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221021095335epcas5p1369d6d802bfd2e61234602b697fb4dc1~gDN9LVy5N2499724997epcas5p1R;
        Fri, 21 Oct 2022 09:53:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mv0Cd1hzfz4x9Pv; Fri, 21 Oct
        2022 09:53:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.54.56352.C1C62536; Fri, 21 Oct 2022 18:53:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221021090406epcas5p269f531aa7b70c59670111c041a1f9cf3~gCiwCw05r1863018630epcas5p2J;
        Fri, 21 Oct 2022 09:04:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221021090406epsmtrp1c9f0e2fc305937d55c4bb01f19a50daf~gCiwBphlh0168401684epsmtrp1C;
        Fri, 21 Oct 2022 09:04:06 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-ab-63526c1cf702
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.26.18644.68062536; Fri, 21 Oct 2022 18:04:06 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021090403epsmtip2308674d4050632b8728e0e22b455eed6~gCitgPmAa2229022290epsmtip2T;
        Fri, 21 Oct 2022 09:04:03 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <60620ca9-80cd-9b13-800b-130a3f75442a@linaro.org>
Subject: RE: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
Date:   Fri, 21 Oct 2022 14:34:01 +0530
Message-ID: <04bf01d8e52c$125d0f40$37172dc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwG1dkA8AWCzSJ4C+Pd42KyPk1+A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmlq5MTlCywdSvJhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLfa+Bop9u9LBZHF51xw2ixnn9zFZLNr6hd2ic1c/q8Ws
        CztYLVr3HmG3OPymndViw/e1jA4CHhs+N7F57Jx1l91j06pONo871/aweex7u4zNo2/LKkaP
        9Vuusnh83iQXwBGVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IKSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvjy/KXzAUTgytufJzP3MD4yr6LkZNDQsBE4uXnbexdjFwcQgK7GSX+777P
        BOF8YpT48ngOC4TzmVHi4KzTLDAtKy+egErsYpTY/aoTqv8Fo8T1+4+ZQarYBMwlFu1dygiS
        EBG4wiTxc3U7WAuzQBujxN6LaxlBqjgF7CTa974E6xAWcJWY9e0zK4jNIqAqseTAdLAaXgFL
        iSOT7rFC2IISJ2c+AbuDWUBeYvvbOcwQNylI/Hy6DKxGRMBN4sfNecwQNeISR3/2QNV84ZD4
        vwjqBxeJbV0roWxhiVfHt7BD2FISL/vboOx8iWkfm9kg7AqJto8bmCBse4kDV0ABwwE0X1Ni
        /S59iLCsxNRT65gg1vJJ9P5+AlXOK7FjHoytKrF++SZGCFtaYt/1vYwTGJVmIflsFpLPZiH5
        YBbCtgWMLKsYJVMLinPTU4tNC4zzUsvhUZ6cn7uJEZzGtbx3MD568EHvECMTB+MhRgkOZiUR
        3oJ3AclCvCmJlVWpRfnxRaU5qcWHGE2BwT2RWUo0OR+YSfJK4g1NLA1MzMzMTCyNzQyVxHkX
        z9BKFhJITyxJzU5NLUgtgulj4uCUamBaJr3kyan++HNr3COyS/aLBhRs6f27UTP+gu6zS0IN
        NiYee77YqfC2Ttsj88ho/4/9G7g368XJXb/04urSolbFQxPW52t66X/Yd9MoXVL9gEB41J6k
        rkshX9g8Ay/fPnN200kpW/Ymm7jplQf+R9+dHJT2ulOhQHYKy+PcRCkxy9yvth/7931ZkDP3
        rfbEry7mDrP+iQXdD+uvPH37nWdfm2b4K3/H7ispKgWpgrffbap/fXHS88cLo7LSZwm93xd0
        o6zCdMebB9+LH3J4OsXdjtrzbEebs985Melc+ceBjo+/+rzYl7VPcc6W1aKNc1IWVSiZ6oSs
        rJf9amhwbeYMlQMf9JQ2WHQdOnR8aqqvEktxRqKhFnNRcSIAwubwXWwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvG5bQlCywc9WdosH87axWVy5eIjJ
        4tDmrewWUx8+YbOYf+Qcq0Xfi4fMFntfA8W+Xelgsri8aw6bxYzz+5gsFm39wm7Ruauf1WLW
        hR2sFq17j7BbHH7Tzmqx4ftaRgcBjw2fm9g8ds66y+6xaVUnm8eda3vYPPa9Xcbm0bdlFaPH
        +i1XWTw+b5IL4IjisklJzcksSy3St0vgyviy/CVzwcTgihsf5zM3ML6y72Lk5JAQMJFYefEE
        SxcjF4eQwA5GidlX2lkgEtIS0/v3sEHYwhIr/z1nhyh6xijx//RHRpAEm4C5xKK9SxlBEiIC
        j5gk5s5/xAbiMAt0MUoc/7uSGaLlM6PEmj8vmUBaOAXsJNr3vmQGsYUFXCVmffvMCmKzCKhK
        LDkwHWwsr4ClxJFJ91ghbEGJkzOfgN3ELKAt0fuwlRHClpfY/nYOM8R9ChI/ny4DqxcRcJP4
        cXMeM0SNuMTRnz3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFp
        Xrpecn7uJkZwNGtp7WDcs+qD3iFGJg7GQ4wSHMxKIrwF7wKShXhTEiurUovy44tKc1KLDzFK
        c7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDKefPx9u8Ljp8rFvbO3WnSGC398z6rhVi/
        sF5QZ4TRl/ApBl9S318sTPw4mb/4Q6XK/rnrin7fnJWve8LKTk33gX3duYAjsyx9xR5f+Lp9
        9pznU458nrfn0Kw9N3MXnL6idMWF5+mWyTn9tTfF1xzQ+WT7QzpbbYKaSP51u951VlsqVvZt
        m/HZ4OiB6unm0lKaASWJr792fRPQ0+CMXjpJdZX6W+3w2ffyDUSXisy/Y1klLm2sprZn99+E
        /FnLY5dflbZueRbid3LBpHed3nt2vfxs6yzqyLfa10J0wzP3O396b/T33Dk1beMO0+3/dZxb
        24T7nvBdrG389lpbbeez+FeebzNbz5hcY9u7S/qMmRJLcUaioRZzUXEiACXapWdVAwAA
X-CMS-MailID: 20221021090406epcas5p269f531aa7b70c59670111c041a1f9cf3
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
        <60620ca9-80cd-9b13-800b-130a3f75442a@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 16 October 2022 08:48 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH 4/6] ASoC: samsung: fsd: Add FSD soundcard driver
> 
> On 14/10/2022 06:21, Padmanabhan Rajanbabu wrote:
> > Add a soundcard driver for FSD audio interface to bridge the CPU DAI
> > of samsung I2S with the codec and platform driver.
> >
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +
> > +#define FSD_PREFIX		"tesla,"
> > +#define FSD_DAI_SRC_PCLK	3
> > +#define FSD_DAI_RFS_192		192
> > +#define FSD_DAI_BFS_48		48
> > +#define FSD_DAI_BFS_96		96
> > +#define FSD_DAI_BFS_192		192
> > +
> > +struct fsd_card_priv {
> > +	struct snd_soc_card card;
> > +	struct snd_soc_dai_link *dai_link;
> > +	u32 tdm_slots;
> > +	u32 tdm_slot_width;
> > +};
> > +
> > +static unsigned int fsd_card_get_rfs(unsigned int rate) {
> > +	return FSD_DAI_RFS_192;
> 
> This wrapper is a bit silly...
okay, will remove the wrapper and assign the macro value directly
> 
> > +}
> > +
> > +static unsigned int fsd_card_get_bfs(unsigned int channels) {
> > +	switch (channels) {
> > +	case 1:
> > +	case 2:
> > +		return FSD_DAI_BFS_48;
> > +	case 3:
> > +	case 4:
> > +		return FSD_DAI_BFS_96;
> > +	case 5:
> > +	case 6:
> > +	case 7:
> > +	case 8:
> > +		return FSD_DAI_BFS_192;
> > +	default:
> > +		return FSD_DAI_BFS_48;
> > +	}
> > +}
> > +
> > +static unsigned int fsd_card_get_psr(unsigned int rate) {
> > +	switch (rate) {
> > +	case 8000:	return 43;
> > +	case 11025:	return 31;
> > +	case 16000:	return 21;
> > +	case 22050:	return 16;
> > +	case 32000:	return 11;
> > +	case 44100:	return 8;
> > +	case 48000:	return 7;
> > +	case 64000:	return 5;
> > +	case 88200:	return 4;
> > +	case 96000:	return 4;
> > +	case 192000:	return 2;
> > +	default:	return 1;
> > +	}
> > +}
> > +
> > +static int fsd_card_hw_params(struct snd_pcm_substream *substream,
> > +					struct snd_pcm_hw_params
> *params) {
> > +	struct snd_soc_pcm_runtime *rtd	= substream->private_data;
> > +	struct snd_soc_card *card	= rtd->card;
> > +	struct snd_soc_dai *cpu_dai	= asoc_rtd_to_cpu(rtd, 0);
> > +	struct snd_soc_dai_link *link	= rtd->dai_link;
> > +	struct fsd_card_priv *priv	= snd_soc_card_get_drvdata(card);
> > +	unsigned int rfs, bfs, psr;
> > +	int ret = 0, cdclk_dir;
> > +
> > +	rfs = fsd_card_get_rfs(params_rate(params));
> > +	bfs = fsd_card_get_bfs(params_channels(params));
> > +	psr = fsd_card_get_psr(params_rate(params));
> > +
> > +	/* Configure the Root Clock Source */
> > +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
> > +					false, FSD_DAI_SRC_PCLK);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set OPCLK: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
> > +					false, false);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set RCLKSRC: %d\n", ret);
> 
> Don't you need to cleanup on error paths?
we might not be needing, since the sound card neither configures any
clock sources directly nor involves in any memory allocation during
hw_params.
> 
> > +		goto err;
> > +	}
> > +
> > +	/* Set CPU DAI configuration */
> > +	ret = snd_soc_dai_set_fmt(cpu_dai, link->dai_fmt);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set DAIFMT: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	if (link->dai_fmt & SND_SOC_DAIFMT_CBC_CFC) {
> > +		cdclk_dir = SND_SOC_CLOCK_OUT;
> > +	} else if (link->dai_fmt & SND_SOC_DAIFMT_CBP_CFP) {
> > +		cdclk_dir = SND_SOC_CLOCK_IN;
> > +	} else {
> > +		dev_err(card->dev, "Missing Clock Master information\n");
> > +		goto err;
> > +	}
> > +
> > +	/* Set Clock Source for CDCLK */
> > +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
> > +					rfs, cdclk_dir);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set CDCLK: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_RCLK, psr);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set PSR: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "Failed to set BCLK: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	if (priv->tdm_slots) {
> > +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, false, false,
> > +				priv->tdm_slots, priv->tdm_slot_width);
> > +		if (ret < 0) {
> > +			dev_err(card->dev,
> > +				"Failed to configure in TDM mode:%d\n", ret);
> > +			goto err;
> > +		}
> > +	}
> > +
> > +err:
> > +	return ret;
> > +}
> > +
> > +static const struct snd_soc_ops fsd_card_ops = {
> > +	.hw_params	= fsd_card_hw_params,
> > +};
> > +
> > +static struct fsd_card_priv *fsd_card_parse_of(struct snd_soc_card
> > +*card) {
> > +	struct fsd_card_priv *priv;
> > +	struct snd_soc_dai_link *link;
> > +	struct device *dev = card->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct device_node *np, *cpu_node, *codec_node;
> > +	struct snd_soc_dai_link_component *dlc;
> > +	int ret, id = 0, num_links;
> > +
> > +	ret = snd_soc_of_parse_card_name(card, "model");
> > +	if (ret) {
> > +		dev_err(dev, "Error parsing card name: %d\n", ret);
> > +		return ERR_PTR(ret);
> 
> return dev_err_probe
Okay
> 
> > +	}
> > +
> > +	if (of_property_read_bool(dev->of_node, "widgets")) {
> > +		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	}
> > +
> > +	/* Add DAPM routes to the card */
> > +	if (of_property_read_bool(node, "audio-routing")) {
> > +		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	}
> > +
> > +	num_links = of_get_child_count(node);
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	priv->dai_link = devm_kzalloc(dev, num_links * sizeof(*priv-
> >dai_link),
> > + 	GFP_KERNEL);
> > +	if (!priv->dai_link)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	priv->tdm_slots = 0;
> > +	priv->tdm_slot_width = 0;
> > +
> > +	snd_soc_of_parse_tdm_slot(node, NULL, NULL, &priv->tdm_slots,
> > +			&priv->tdm_slot_width);
> > +
> > +	link = priv->dai_link;
> > +
> > +	for_each_child_of_node(node, np) {
> > +		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
> > +		if (!dlc)
> > +			return ERR_PTR(-ENOMEM);
> > +
> > +		link->id		= id;
> > +		link->cpus		= &dlc[0];
> > +		link->platforms		= &dlc[1];
> > +		link->num_cpus		= 1;
> > +		link->num_codecs	= 1;
> > +		link->num_platforms	= 1;
> > +
> > +		cpu_node = of_get_child_by_name(np, "cpu");
> > +		if (!cpu_node) {
> > +			dev_err(dev, "Missing CPU/Codec node\n");
> > +			ret = -EINVAL;
> > +			goto err_cpu_node;
> > +		}
> > +
> > +		ret = snd_soc_of_get_dai_link_cpus(dev, cpu_node, link);
> > +		if (ret < 0) {
> > +			dev_err(dev, "Error Parsing CPU DAI name\n");
> > +			goto err_cpu_name;
> > +		}
> > +
> > +		link->platforms->of_node = link->cpus->of_node;
> > +
> > +		codec_node = of_get_child_by_name(np, "codec");
> > +		if (codec_node) {
> > +			ret = snd_soc_of_get_dai_link_codecs(dev, codec_node,
> > +					link);
> > +			if (ret < 0) {
> > +				dev_err(dev, "Error Parsing Codec DAI name\n");
> > +				goto err_codec_name;
> > +			}
> > +		} else {
> > +			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
> > +			if (!dlc) {
> > +				ret = -ENOMEM;
> > +				goto err_cpu_name;
> > +			}
> > +
> > +			link->codecs = dlc;
> > +
> > +			link->codecs->dai_name = "snd-soc-dummy-dai";
> > +			link->codecs->name = "snd-soc-dummy";
> > +			link->dynamic = 1;
> > +
> > +			snd_soc_dai_link_set_capabilities(link);
> > +			link->ignore_suspend = 1;
> > +			link->nonatomic = 1;
> > +		}
> > +
> > +		ret = asoc_simple_parse_daifmt(dev, np, codec_node,
> > +					FSD_PREFIX, &link->dai_fmt);
> > +		if (ret)
> > +			link->dai_fmt = SND_SOC_DAIFMT_NB_NF |
> > +					SND_SOC_DAIFMT_CBC_CFC |
> > +					SND_SOC_DAIFMT_I2S;
> > +
> > +		ret = of_property_read_string(np, "link-name", &link-
> >name);
> > +		if (ret) {
> > +			dev_err(card->dev, "Error Parsing link name\n");
> > +			goto err_codec_name;
> > +		}
> > +
> > +		link->stream_name = link->name;
> > +		link->ops = &fsd_card_ops;
> > +
> > +		link++;
> > +		id++;
> > +
> > +		of_node_put(cpu_node);
> > +		of_node_put(codec_node);
> > +	}
> > +
> > +	card->dai_link = priv->dai_link;
> > +	card->num_links = num_links;
> > +
> > +	return priv;
> > +
> > +err_codec_name:
> > +	of_node_put(codec_node);
> > +err_cpu_name:
> > +	of_node_put(cpu_node);
> > +err_cpu_node:
> > +	of_node_put(np);
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +static int fsd_platform_probe(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct snd_soc_card *card;
> > +	struct fsd_card_priv *fsd_priv;
> > +
> > +	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
> > +	if (!card)
> > +		return -ENOMEM;
> > +
> > +	card->dev	= dev;
> > +	fsd_priv	= fsd_card_parse_of(card);
> 
> Drop the indentation before =
Okay
> 
> > +
> > +	if (IS_ERR(fsd_priv)) {
> > +		dev_err(&pdev->dev, "Error Parsing DAI Link: %ld\n",
> > +				PTR_ERR(fsd_priv));
> > +		return PTR_ERR(fsd_priv);
> 
> return dev_err_probe
Okay
> 
> > +	}
> > +
> > +	snd_soc_card_set_drvdata(card, fsd_priv);
> > +
> > +	return devm_snd_soc_register_card(&pdev->dev, card); }
> > +
> > +static const struct of_device_id fsd_device_id[] = {
> > +	{ .compatible = "tesla,fsd-card" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, fsd_device_id);
> > +
> > +static struct platform_driver fsd_platform_driver = {
> > +	.driver = {
> > +		.name = "fsd-card",
> > +		.of_match_table = of_match_ptr(fsd_device_id),
> 
> of_match_ptr comes with maybe_unused. Or drop it.
Okay
> 
> 
> 
> Best regards,
> Krzysztof
Thank you for reviewing the patch.


