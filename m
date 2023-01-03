Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CFF65BAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjACGiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjACGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:38:06 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CF1088
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:38:02 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230103063758epoutp0455a2dbcae7c8d312576167752796185f~2uSSZYQ8P3097830978epoutp04X
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:37:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230103063758epoutp0455a2dbcae7c8d312576167752796185f~2uSSZYQ8P3097830978epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672727878;
        bh=XZvYlXgpWFcytY0b+WO4ljcktt6LBn91faP7lLVRS0g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ETaGzmWo6V/HN+r9W7LDnqPC9fmq+jeWXBs3LLJjeqdY9Twa5yJbsZJKhk6HbuvWR
         alJG1uJjESh1R85NcGTMPqnzDY6wXktTybbEzcYS1PTZYv3zyKoKYR05ydGwis85i2
         GlhXrAamoYFSb4CrsICiwEXLYtvJOtNvbuiIc9aA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230103063757epcas5p49588c838606addcd87eef2d793f0250c~2uSR4khOf2944229442epcas5p49;
        Tue,  3 Jan 2023 06:37:57 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NmNMm28zGz4x9Pq; Tue,  3 Jan
        2023 06:37:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.38.03362.44DC3B36; Tue,  3 Jan 2023 15:37:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230103045506epcas5p4dae882d7ac7627f37f17572c3bf70760~2s4d3Y-XZ1872118721epcas5p4Q;
        Tue,  3 Jan 2023 04:55:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230103045506epsmtrp2984e59cd9032a225c69b4608b4597947~2s4d2f5FQ0604406044epsmtrp2r;
        Tue,  3 Jan 2023 04:55:06 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-ca-63b3cd441131
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.D4.10542.925B3B36; Tue,  3 Jan 2023 13:55:05 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230103045503epsmtip141b657b6f85830aeca46b749e4eea160~2s4boh1T71253712537epsmtip1A;
        Tue,  3 Jan 2023 04:55:03 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <Y2vlqatX7dfPJ3Zi@sirena.org.uk>
Subject: RE: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Date:   Tue, 3 Jan 2023 10:25:02 +0530
Message-ID: <025401d91f2f$8bf78a00$a3e69e00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwJEXTuNARMAzQMCgN8f5gMWNkuwArAClEQCgEQWDwHlvOpzrLPsmiA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmuq7L2c3JBgv6+SwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        WvceYbc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDA
        wMgUqDAhO+PXn/eMBceVKi5/PcvYwHhKsouRk0NCwETiw9bljF2MXBxCArsZJRq/n2eGcD4x
        SnxfMJEFwvnMKNE/cyczTMuixUvYIBK7GCX+L3oEVfWCUWLnzmY2kCo2AXOJRXuXMoLYIgLq
        Ekc3bWQFKWIW6GKW2HDkHQtIglNAV+LMqV1MILawgJfEmZ51YCtYBFQkTm/+ABbnFbCUuPl8
        DjOELShxcuYTsF5mAXmJ7W/nQJ2kIPHz6TJWiGVJEm1Hn7JB1IhLHP3ZA/aQhMAbDonOR3dY
        IBpcJJ7MvMMKYQtLvDq+hR3ClpL4/G4vG4SdLzHtYzOUXSHR9nEDE4RtL3HgyhygORxACzQl
        1u/ShwjLSkw9tY4JYi+fRO/vJ1DlvBI75sHYqhLrl29ihLClJfZd38s4gVFpFpLXZiF5bRaS
        F2YhbFvAyLKKUTK1oDg3PbXYtMA4L7UcHuXJ+bmbGMHJW8t7B+OjBx/0DjEycTAeYpTgYFYS
        4Z30YlOyEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H5o+8knhDE0sDEzMzMxNLYzNDJXHe
        1K3zk4UE0hNLUrNTUwtSi2D6mDg4pRqYUtqnFJUomZQuerLCT2jb1WNMfnYl3V2MqWYZfnW7
        r3+3dXxeWeCnu/OJilx9VMLe9rC2Nwq70s//uPf7nFjd5SArtsdnTWVuNcycu+qkSmS0g47+
        XsaAv3O8P+dxKTZlvT7/6vWcPLXn5lFLe37KzJQ9eujw5msnVDUP1F7wLsk984hJ0WL/9PO2
        yqwfLk9X0FPonBT0aK36aW0h6xtP5nxbn/CjdXvY3JZ1De8jrL/1lTPt2O1kfFdp7aauXlHm
        LzucbBjOLWh8zvxwtoRzwTW5D+cjFu44c2/mrOraLtbSVX8Fcw4u2iBbtkjvXeet/ec/S9/6
        m1/gK1GzlKOA7ctE3gnVDRpLQxadUzmmrMRSnJFoqMVcVJwIAE7otvJnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnK7m1s3JBj1LTSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        WvceYbc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEcVlk5Kak1mWWqRvl8CV8evPe8aC40oVl7+eZWxgPCXZxcjJISFgIrFo8RK2LkYu
        DiGBHYwS31o2MEMkpCWm9+9hg7CFJVb+e84OUfSMUWLZis1gCTYBc4lFe5cygtgiAuoSRzdt
        ZAUpYhaYwSxx6NYlVoiOBmaJ7d8XgHVwCuhKnDm1iwnEFhbwkjjTsw5sHYuAisTpzR/A4rwC
        lhI3n89hhrAFJU7OfMLSxcgBNFVPom0j2DJmAXmJ7W/nQF2qIPHz6TJWiCOSJNqOPmWDqBGX
        OPqzh3kCo/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BEevltYOxj2rPugdYmTiYDzEKMHBrCTCO+nFpmQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6
        TsYLCaQnlqRmp6YWpBbBZJk4OKUamFT/7nz3xGNdldu9M4mujrNfnZGQOPA07comp8bbbT53
        Hhy/7LnYU2nSsy5nk3l/ywsONi3ktghnYF9WfOdrkfgeUYmuyTN39Tns+3/u0MUn55csOO/Q
        s/7Y/Oj4KSoBV2a1PM7WPbO9IcEu/DQfwyu+t60MOg2N8pX8zyTfv9i+PeQQe/i564udZufN
        XxM46ZrmlVaR+fWra++2Hd5Q6iX6QMvP8p9v9GltnlgDfrXmF/PnuV7OF3m6pa/ybH9zQmyM
        0vU8lZij4redJd12zdf5dyzvmz3HZqu+dRseMC1KfLPivVtM5u2b2crWi/WrpV4efDZBr7F3
        kdWxPzM6zW6Zm5cwaOkIzg/i4lv7MUKJpTgj0VCLuag4EQDN3wZCTQMAAA==
X-CMS-MailID: 20230103045506epcas5p4dae882d7ac7627f37f17572c3bf70760
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
        <01ba01d8f332$44eb3810$cec1a830$@samsung.com>
        <Y2vlqatX7dfPJ3Zi@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 09 November 2022 11:09 PM
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
> On Tue, Nov 08, 2022 at 10:53:40AM +0530, Padmanabhan Rajanbabu wrote:
> 
> > > > We can overcome this scenario to an extent if we can get a
> > > > flexibility to Configure both PSR as well as RFS.
> 
> > > Why does it make sense for the machine driver to worry about this
> > > rather than having the I2S controller driver configure the clock tree?
> 
> > _____           |                  __
> > |
> > |         |	        |	             |   \
> > |
> > |CMU|	        |	             |     \
> > |
> > |FSD  |-  |---|-|--------->|       \        _________    _________
> > |
> > |___  |    |    | |op_clk0|         |      |               |     |
> > |             |
> > 	  |    | |	             |MUX|----|  PSR       |----|  RFS
> > |--cdclk  |
> > 	  |    | |              |         |      |_______|     |_______|
> > |
> > 	  |    | |--------->|        /
> > |
> > 	  |    |  op_clk1 |      /
> > |
> > 	  |    | 	             |_ /
> > |
> > 	  |    |___________________________________________|
> > 	  |
> > 	  |-----> To other FSD SoC Peripherals
> 
> > In FSD I2S, the clock source is not an independent source but a common
> > clock source being shared by many IPs in the same domain.
> 
> > Changing the clock tree will impact other IPs in the domain as they
> > are dependent on the same source for functionality.
> 
> I'm not sure I follow.  Perhaps your diagram is unclear but it looks like
PSR and
> RFS are both after a mux which appears to select which clock is going to
be
> used by the I2S controller?  The usage by other clocks appears to be
> upstream of the mux and dividers.
> 
> > We can understand your point to bring the PSR changes under the I2S
> > CPU DAI driver by adding a separate compatible and data for the FSD
> > SoC. But If we take the example of existing sound cards such as
> > sound/soc/samsung/tm2_wm5110.c, the op_clk is supplied via external
> > audio pll to the controller and PLL configuration is taken care by the
> > sound card. Since the configuration of PLL is more specific to the tm2
> > platform, it makes use of the flexibility of changing the RFS and BFS
> > using the sysclk and clkdiv hooks provided by exynos7-i2s CPU DAI
> > along with PLL tuning for precise sampling frequency.
> 
> The big reason for the clocking control (and indeed having a custom
machine
> driver) with the WM5110 is that it has multiple clocks to control and a
good
> deal of flexibility with placing them in clock domains and so on which
have
> power and performance impacts.  It's frankly a bit unclear to me if the
CPU
> I2S controller even needs the bitclock configuring given that the clocks
are
> being driven by the CODEC there, but regardless it's not clear to me why
the
> I2S controller would need anything other than the input clock to the block
> configuring?
> 
> > Similar to the above example, the choice of clock source under
> > discussion is not a limitation of exynos7-i2s controller, but instead
> > is a limitation on the FSD SoC.
> > By using the proposed change, we can ensure that the exynos CPU DAI
> > driver is giving additional hooks similar to existing hooks for BFS,
> > RFS and CDCLK direction so that sound cards can use
> > snd_soc_dai_set_sysclk and snd_soc_dai_set_clkdiv to customize the
> > same.
> 
> I'm still not seeing anything that articulates why pushing the
configuration of
> the dividers within the block into the machine driver solves a problem
here.
> Again, what's the upside to configuring clocks that are purely within the
> block?

Okay, I can understand the reason for de-linking these changes from the
machine
Driver. I'll post the v2 patches integrating the PSR changes into cpu dai
driver.

Thanks,
Padmanabhan R.

