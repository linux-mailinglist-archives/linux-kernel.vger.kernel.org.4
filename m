Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2A661DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjAIEdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjAIEcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:32:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7122E022
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 20:17:01 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230109041700epoutp0148924ec0ef08029c1d24814936feaf90~4iO6159540205302053epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:17:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230109041700epoutp0148924ec0ef08029c1d24814936feaf90~4iO6159540205302053epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673237820;
        bh=lVjBdfqJDEubnHvztlohX+42xCVlx5x3lwMnZuFO/vE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ehLGPIeWHyiTkQCDJZ2uy9xnx4JMH9ahQnDEnj4ctEyPMaux4F9Qt/I5iRFiJe+Tl
         iV7puL1iusByJM0+FMNSq3Kha1c/56mU6gTmKFDDB7X6p4TL0wozBUMB1nnXeq408T
         S/SJIiINQXERqlz5Hdv377A5CDiYLJISISHMNE4U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230109041659epcas5p227ce53c450aac69ab1390b7f65330a39~4iO6UYi642289722897epcas5p29;
        Mon,  9 Jan 2023 04:16:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nr0yL0x5cz4x9Q3; Mon,  9 Jan
        2023 04:16:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.3C.03362.9359BB36; Mon,  9 Jan 2023 13:16:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230109040601epcas5p208cf4a6f79173a5b0c7b193ceb39691d~4iFVM9pVn2100421004epcas5p2k;
        Mon,  9 Jan 2023 04:06:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230109040601epsmtrp1cb2479356f57330f7da101cff4c05ffb~4iFVMIZa71945819458epsmtrp1N;
        Mon,  9 Jan 2023 04:06:01 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-e8-63bb9539527c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.A9.02211.9A29BB36; Mon,  9 Jan 2023 13:06:01 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230109040559epsmtip1805a9824fb73cb1017524e3d3f327c2a~4iFTJo6vr0548405484epsmtip1c;
        Mon,  9 Jan 2023 04:05:59 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <Y7RvUlIuXQLUHEna@sirena.org.uk>
Subject: RE: [PATCH v2 2/5] ASoC: samsung: i2s: add support for FSD I2S
Date:   Mon, 9 Jan 2023 09:35:58 +0530
Message-ID: <051e01d923df$af7156a0$0e5403e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH5OglsonJNs2LrkABkwml8apZdSgJ8yZQdARjupoEBbRtbk64tMMdg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmlq7l1N3JBic6bCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        WvceYbc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDA
        wMgUqDAhO2P3oROsBV8EKl4dm8jSwPiPt4uRk0NCwERiX+sD5i5GLg4hgd2MEvNXHWGEcD4x
        Smy995AFpEpI4BujRFufE0zHyQOdLBBFexklXs84BNX+glFi3def7CBVbALmEov2LmUEsUUE
        1CWObtrIClLELNDFLLHhyDuwsZwCuhJTPvUzg9jCAu4S/6ZfAYuzCKhItN26CzaIV8BSYsfD
        HUwQtqDEyZlPwGqYBeQltr+dwwxxkoLEz6fLWCGWuUnsXnqAGaJGXOLozx6w6yQE3nBIHN84
        G6rBRaLnwns2CFtY4tXxLewQtpTEy/42KDtfYtrHZqiaCom2jxuYIGx7iQNX5gAdwQG0QFNi
        /S59iLCsxNRT65gg9vJJ9P5+AlXOK7FjHoytKrF++SZGCFtaYt/1vYwTGJVmIXltFpLXZiF5
        YRbCtgWMLKsYJVMLinPTU4tNC4zzUsvhMZ6cn7uJEZy6tbx3MD568EHvECMTB+MhRgkOZiUR
        3tJNu5KFeFMSK6tSi/Lji0pzUosPMZoCw3sis5Rocj4we+SVxBuaWBqYmJmZmVgamxkqifOm
        bp2fLCSQnliSmp2aWpBaBNPHxMEp1cBUuTzuLAfnX4M9LWKmn34t2Kj4+d+SyrzN6T+bVyvW
        RMxTa7x85MT0o+Ebp9248XSd9fYbvdGaz4LOnXKLl/54rPlnn2N3/q7qj6JRV70mCf83b+Ha
        Gak53Wn/QZf5mmpuyyadF2pvS3XeuIe34JdwjPb3xFN39c20w9te7umMjb8XH8wcb9D8S66p
        yD/OIEexj6HCcdGkkkdBpgVa2QnS8gdvWihsfcfIv0bwf8PzwC/2Tx4Wlf6zf/vbVDFf0i36
        T/G7JSdFrz4o+LD5fKdTtL+N+v4nk1vfZjc0P7FawN60SfbhvfC2kwZ95lmzz6zYuGjxh/fL
        D20qPDCBe5v+9dypJ+TZ+Nwnbw2dzjRNiaU4I9FQi7moOBEAQyfYd2YEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO7KSbuTDVYckrB4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2SxaOsXdovOXf2sFrMu7GC1
        aN17hN3i8Jt2VosN39cyOvB7bPjcxOaxc9Zddo9NqzrZPO5c28Pmse/tMjaPvi2rGD3Wb7nK
        4vF5k1wARxSXTUpqTmZZapG+XQJXxu5DJ1gLvghUvDo2kaWB8R9vFyMnh4SAicTJA50sILaQ
        wG5Gie8zlCHi0hLT+/ewQdjCEiv/PWfvYuQCqnnGKPGn5QQrSIJNwFxi0d6ljCC2iIC6xNFN
        G1lBipgFZjBLHLp1iRVi6iNGidvXxEBsTgFdiSmf+plBbGEBd4l/06+AbWYRUJFou3WXHcTm
        FbCU2PFwBxOELShxcuYToBoOoKF6Em0bwXYxC8hLbH87hxniOAWJn0+XsULc4Caxe+kBZoga
        cYmjP3uYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZw5Gpp7mDcvuqD3iFGJg7GQ4wSHMxKIrylm3YlC/GmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cA0S8c7dFm3QP5V1Uxe/k18vxW9A8snW+RNX/xqj3Vk
        SY87xym9p/7NfxaZMjZw9M1YfWfG+ccvpGr2HUybcIxrjwH/tu25ZReevTHdv+7jn6LA3KWz
        t2+pEHJhDVhSkfgz2TS7MEMzekWpEO9SuxceCT8blJtzXOzU1afPfcxw0bfs9MQd6qGfZ59f
        K70j/zzbnZeTXeep7pCrfOI2z8fStitzxbW57nu8/A8uZeh9+NLvzmp25fnB17g/RznIr3m3
        +qLDhTcTT4bkNU7PfLX/sfdv+Wa1azKGYVx/nqat1r1UXLRQNbnx3+KyGc4/S0zFjEVyXzy+
        l/I0uPHK2cXb86do3fnepVN/5MIFq6ylSizFGYmGWsxFxYkA8peNEksDAAA=
X-CMS-MailID: 20230109040601epcas5p208cf4a6f79173a5b0c7b193ceb39691d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3@epcas5p1.samsung.com>
        <20230103045613.100309-3-p.rajanbabu@samsung.com>
        <Y7RvUlIuXQLUHEna@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 03 January 2023 11:39 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Cc: lgirdwood@gmail.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH v2 2/5] ASoC: samsung: i2s: add support for FSD I2S
> 
> On Tue, Jan 03, 2023 at 10:26:10AM +0530, Padmanabhan Rajanbabu wrote:
> 
> > +void fsd_i2s_fixup_early(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =
> asoc_substream_to_rtd(substream);
> > +	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
> > +	struct i2s_dai *other = get_other_dai(i2s);
> > +
> > +	if (!is_opened(other)) {
> > +		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK, 192,
> SND_SOC_CLOCK_OUT);
> > +		i2s_set_sysclk(dai, SAMSUNG_I2S_OPCLK, 0,
> MOD_OPCLK_PCLK);
> > +	}
> > +}
> 
> This looks like we're just hard coding to 192kHz?

Not actually. The value 192 being passed is for the RFS divider
based on which the Root clock source is divided to generate bit-clock
and frame-clock in master mode.

But, FSD SoC is utilizing the Exynos7-I2S controller in slave
mode, where bit-clock and frame-clock is sourced by the codec.
Therefore the sampling of data happens with codec clock source and
not based on the clock source from RCLK. However, we still need RFS and
BFS configured to default value for the proper operation of the controller.

The current operation being performed above is to change the Codec
clock direction to "out", so that codec will use this clock source to
generate bit clock and frame clock from its own PLL.

I'll make the changes in the next patch set to pass 0 instead of 192 here,
so that RFS and BFS will be configured to default value in config_setup
function.

Thanks,
Padmanabhan R.

