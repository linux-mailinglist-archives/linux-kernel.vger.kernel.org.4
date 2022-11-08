Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC262097D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiKHGTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiKHGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:19:29 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A934092C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:19:18 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221108061916epoutp02f010da55407787364b54002856acc293~lh5_b7g-30291502915epoutp02d
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:19:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221108061916epoutp02f010da55407787364b54002856acc293~lh5_b7g-30291502915epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667888356;
        bh=pCyICg+T2pU44yGLH3yU7sufLwS47i+fgjYOGPfGVZY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A1wt6cf8kRFOEN/M+xPVBGqbZtOVRjudZCVw97qLoiZYl83/iAFYbXPRPMJTpoWR8
         QkaPC8ZpEDXzoYkzQokdvJ/xi4WDNn085peu/oD//1RZG2FFAP5Wi+zhQLG+clvorG
         E/tDiEizo5T25GLK4UVaMzUV9pK46uqeWothQgxE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221108061916epcas5p16bfd1d4ba40803e01de667e2f6d37707~lh5_LMn7J1630416304epcas5p1C;
        Tue,  8 Nov 2022 06:19:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N5yc25MwCz4x9Q8; Tue,  8 Nov
        2022 06:19:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.8C.01710.2E4F9636; Tue,  8 Nov 2022 15:19:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221108052344epcas5p17cbce08314e6eb1cf045a8e92f1892d3~lhJe_UvsQ0477904779epcas5p1T;
        Tue,  8 Nov 2022 05:23:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221108052344epsmtrp212d88900e39ee4ae43cb5a4428ee5002~lhJe8FYzG0254502545epsmtrp2I;
        Tue,  8 Nov 2022 05:23:44 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-67-6369f4e21b90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.78.14392.0E7E9636; Tue,  8 Nov 2022 14:23:44 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221108052341epsmtip2a11f325717c4ea22e53306b232a80b3b~lhJcoiYhu1722017220epsmtip2i;
        Tue,  8 Nov 2022 05:23:41 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <Y1KIT4nk7C8SQ45x@sirena.org.uk>
Subject: RE: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Date:   Tue, 8 Nov 2022 10:53:40 +0530
Message-ID: <01ba01d8f332$44eb3810$cec1a830$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwJEXTuNARMAzQMCgN8f5gMWNkuwArAClESsfye50A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmhu6jL5nJBifeqVo8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7JYtPULu0Xnrn5Wi1kXdrBa
        tO49wm5x+E07q8WG72sZHfg9NnxuYvPYOesuu8emVZ1sHneu7WHz2Pd2GZtH35ZVjB7rt1xl
        8fi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNct
        MwfoeiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGB
        gZEpUGFCdkb/+6tMBeclKza+/cbcwPheqIuRk0NCwESi9eB3ti5GLg4hgd2MEhcvvmCBcD4x
        Smw+uBkq841R4tiGT2wwLdfezmUCsYUE9jJKHJoVCFH0glHi19kedpAEm4C5xKK9SxlBbBEB
        dYmjmzayghQxC3QxS2w48g5oBwcHp4CuxOv1sSA1wgJeEmd61jGD2CwCKhI7PsxhAbF5BSwl
        LvW8ZIOwBSVOznwCFmcWkJfY/nYOM8RBChI/ny5jhdgVJvH0+XOoGnGJoz97mEH2Sgh84JA4
        /eU2O0SDi8Sk1e+gmoUlXh3fAhWXkvj8bi/Ul/kS0z42Q9kVEm0fNzBB2PYSB67MAbufWUBT
        Yv0ufYiwrMTUU+uYIPbySfT+fgJVziuxYx6MrSqxfvkmRghbWmLf9b2MExiVZiF5bRaS12Yh
        eWEWwrYFjCyrGCVTC4pz01OLTQsM81LL4RGenJ+7iRGcuLU8dzDeffBB7xAjEwfjIUYJDmYl
        EV6RmsxkId6UxMqq1KL8+KLSnNTiQ4ymwPCeyCwlmpwPzB15JfGGJpYGJmZmZiaWxmaGSuK8
        i2doJQsJpCeWpGanphakFsH0MXFwSjUwaRVlFIqKGi/Zf/61ylxnrfKkfdwC2w/7/l4jLOQS
        PmH5O1Mh2f17g5MNPzxbuuXOih3ti0Itzwumyfp8P2jGVHg17McPtp1LXs7SMa17wDIhs8B7
        Tla7A0/mhIs6ikwWUw6xiB8pSXoyqcL7YiOnc1cHA3cQ+4RvMYeupy0K0T2tNKfh3f9+EcaE
        d0nKbM+KTpez7JwpVf5j2a0VtrpPFRluWB9e6xGZZc3LuvKsarvwUqNJE7d9uHP3t+HJm1sC
        T1a/OvznbI/ipxcdPwQ2vJulv2f5pv1foqoj3QRF/28rLv/vf01AVKfiXZhD3YeXa/fcNLrn
        Hrhuac/tpl+8W1hlbml9sf6VUG3R1b8tQomlOCPRUIu5qDgRANEN9dxlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvO6D55nJBtc+slo8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7JYtPULu0Xnrn5Wi1kXdrBa
        tO49wm5x+E07q8WG72sZHfg9NnxuYvPYOesuu8emVZ1sHneu7WHz2Pd2GZtH35ZVjB7rt1xl
        8fi8SS6AI4rLJiU1J7MstUjfLoEro//9VaaC85IVG99+Y25gfC/UxcjJISFgInHt7VymLkYu
        DiGB3YwSj5bdY4JISEtM79/DBmELS6z895wdougZo8Tyt48YQRJsAuYSi/YuBbNFBNQljm7a
        yApSxCwwg1ni0K1LrCAJIYGNTBINK8q6GDk4OAV0JV6vjwUJCwt4SZzpWccMYrMIqEjs+DCH
        BcTmFbCUuNTzkg3CFpQ4OfMJC0grs4CeRNtGsFXMAvIS29/OYYa4TUHi59NlrBAnhEk8ff6c
        BaJGXOLozx7mCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66X
        nJ+7iREcuVqaOxi3r/qgd4iRiYPxEKMEB7OSCK9ITWayEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzic211tdZpyl3avrJt7cz5naEi71n2JxVwTXT/
        uHn5utNzlpv7fSt3NovvdbB/E26SLZv7tiiiZla2VaVmlvd/icWZ+6NvfptituRPIsMf3X0a
        TY1frfSFL2l/nyi+WvbKwfO7pS25o+3bcgve2fuUG/ivPHpmvm2k96tT7kX6KUmFnZ4HPjNf
        3lAj7DRDVVkv7svpDa+zd8trTzT6e2nP5uhfZ38oXdPrnVRz6c1TsYWea9YmbvM497Ltn73P
        70nf5NM0Zdk+cXz23bT6IJN6X/3Sg6/Dvk47UrRu3/c3LlHdv5Rbzl5r8Ge8YTRbwltn64vt
        L58+39zUGLB3A2PNwtD8E8k2qrbL2LMc1RSVWIozEg21mIuKEwFlzP+kSwMAAA==
X-CMS-MailID: 20221108052344epcas5p17cbce08314e6eb1cf045a8e92f1892d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
        <20221014102151.108539-3-p.rajanbabu@samsung.com>
        <Y0lPz91gbovAub9D@sirena.org.uk>
        <04a101d8e523$30804b80$9180e280$@samsung.com>
        <Y1KIT4nk7C8SQ45x@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 21 October 2022 05:24 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Cc: lgirdwood@gmail.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
> 
> On Fri, Oct 21, 2022 at 01:30:25PM +0530, Padmanabhan Rajanbabu wrote:
> 
> > We can overcome this scenario to an extent if we can get a flexibility
> > to Configure both PSR as well as RFS.
> 
> Why does it make sense for the machine driver to worry about this rather
> than having the I2S controller driver configure the clock tree?


                       ____________________________________________
_____           |                  __
| 
|         |	        |	             |   \
|
|CMU|	        |	             |     \
|
|FSD  |-  |---|-|--------->|       \        _________    _________
|
|___  |    |    | |op_clk0|         |      |               |     |
|             |
	  |    | |	             |MUX|----|  PSR       |----|  RFS
|--cdclk  |
	  |    | |              |         |      |_______|     |_______|
|
	  |    | |--------->|        /
|
	  |    |  op_clk1 |      /
|
	  |    | 	             |_ /
|
	  |    |___________________________________________|
	  |
	  |-----> To other FSD SoC Peripherals
	 
In FSD I2S, the clock source is not an independent source but a common clock
source being shared by many IPs in the same domain.

Changing the clock tree will impact other IPs in the domain as they are
dependent on the same source for functionality.

We can understand your point to bring the PSR changes under the I2S CPU DAI
driver by adding a separate compatible and data for the FSD SoC. But If we
take
the example of existing sound cards such as sound/soc/samsung/tm2_wm5110.c,
the op_clk is supplied via external audio pll to the controller and PLL
configuration
is taken care by the sound card. Since the configuration of PLL is more
specific to
the tm2 platform, it makes use of the flexibility of changing the RFS and
BFS
using the sysclk and clkdiv hooks provided by exynos7-i2s CPU DAI along with
PLL tuning for precise sampling frequency.

Similar to the above example, the choice of clock source under discussion is
not a
limitation of exynos7-i2s controller, but instead is a limitation on the FSD
SoC.
By using the proposed change, we can ensure that the exynos CPU DAI driver
is
giving additional hooks similar to existing hooks for BFS, RFS and CDCLK
direction
so that sound cards can use snd_soc_dai_set_sysclk and
snd_soc_dai_set_clkdiv
to customize the same.

An alternative approach is to use the cpu dai as bit clock and frame clock
consumer (i.e. in slave mode) so that codec can supply the MCLK to FSD for
playback and capture. But this will deviate from the actual usecase for FSD
SoC, where the CPU DAI is intended to function as master.

