Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEF607206
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJUIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJUIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:20:56 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032B17A025
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:20:46 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221021082044epoutp03f7c5d6312b684d3192ff8a96c5a1b95c~gB85KMAnM1756917569epoutp03A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:20:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221021082044epoutp03f7c5d6312b684d3192ff8a96c5a1b95c~gB85KMAnM1756917569epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666340444;
        bh=XkLqJsvxmyjmrT/dosjtsL9ahuijtWIA6s0NLm0HkVQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KyDlOlsJQgj99RlqYjbzdUznOn3uDafcGjQ/BSPlkXR8reCRgi0ZZa2mLuHzrbWMl
         uKoqSTK6gCGoeWsaqpnH4N9wIDCxsstX5oN6rTaMS21GLhCnJqA7U2Pxsdmjsw3Gb+
         wzQu2TqXZo1S4d98wiA+IdPEzPtLdYGhokA8sUxk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221021082044epcas5p19e41c6d815e82e4de2ab4b772368cc18~gB84mndoB1232512325epcas5p1e;
        Fri, 21 Oct 2022 08:20:44 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mty8T5PlNz4x9Q1; Fri, 21 Oct
        2022 08:20:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.84.10166.95652536; Fri, 21 Oct 2022 17:20:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221021081212epcas5p3d8eda74ed0b22ca3e0ff27ee45f6ed30~gB1bxH12E1159711597epcas5p31;
        Fri, 21 Oct 2022 08:12:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221021081212epsmtrp2fecd6865d2e6fe553946e023b7d07bd9~gB1bwBOw22604326043epsmtrp2O;
        Fri, 21 Oct 2022 08:12:12 +0000 (GMT)
X-AuditID: b6c32a49-dd627700000227b6-0e-63525659d865
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.37.14392.B5452536; Fri, 21 Oct 2022 17:12:12 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021081208epsmtip11fdf876dc338f4a465da78a97ae1ac1a~gB1YyhW3Y0838308383epsmtip1C;
        Fri, 21 Oct 2022 08:12:08 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <rcsekar@samsung.com>, <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <00c301d8dfd0$f55ca230$e015e690$@samsung.com>
Subject: RE: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
Date:   Fri, 21 Oct 2022 13:42:07 +0530
Message-ID: <04aa01d8e524$d253f2d0$76fbd870$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwItme6KAWz5sEgBhUP0cayXApsw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmlm5kWFCywZpnahYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCwWbf3CbtG5q5/VYtaFHawW
        rXuPsFscftPOarHh+1pGB36PDZ+b2Dx2zrrL7rFpVSebx51re9g89r1dxubRt2UVo8f6LVdZ
        PD5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhg
        YGQKVJiQnfHq1Um2gi1yFVt+P2ZqYPwg0cXIySEhYCLR9uAnYxcjF4eQwG5GiePz97GCJIQE
        PjFKPFqYD2F/Y5RYsVoSpqHxxhY2iIa9jBLTVjWyQzgvGCUO3jgB1s0mYC6xaO9SsLEiAquY
        JOb1rWEBcZgF2hgl9l5cywhSxSlgJTHhXCsbiC0s4C3RtPQhWJxFQFWi5/5VdhCbV8BSYtXN
        D0wQtqDEyZlPWEBsZgF5ie1v5zBD3KQg8fPpMrDNIgJuEkfvTmWGqBGXOPqzhxlksYTAGw6J
        7a09LBANLhJLF59mh7CFJV4d3wJlS0l8freXDcLOl5j2sRnKrpBo+7iBCcK2lzhwZQ7QHA6g
        BZoS63fpQ4RlJaaeWscEsZdPovf3E6hyXokd82BsVYn1yzcxQtjSEvuu72WcwKg0C8lrs5C8
        NgvJC7MQti1gZFnFKJlaUJybnlpsWmCYl1oOj/Hk/NxNjODUreW5g/Hugw96hxiZOBgPMUpw
        MCuJ8Ba8C0gW4k1JrKxKLcqPLyrNSS0+xGgKDO+JzFKiyfnA7JFXEm9oYmlgYmZmZmJpbGao
        JM67eIZWspBAemJJanZqakFqEUwfEwenVAMTR/5c1+PT/f6eSFPZ42ZRJ3HPrazl2OKSvile
        0/cK/TjR+Ypztqap/KPP/xq3XZ1qt4v59PNzN4PqQyQ8FDfk8Rl1LjnHq7N1i6Kw2b7OTfe7
        vv3z4PKv8NndtO/1zVl7Ft49kt2U5G9twn015I/wEpOT8m8qtx6buOLqA15/wdaW+M97/k3N
        tpoXevRpXyivz/3Mue5Hc0Rc9x1Zb69tVRA4VfPKuukRSR2fJY8G6Ww6mfD29JJ1Gy7O35oa
        o+w2uaGFfVrf0o6dXFPC9jq8nZTF81Vt6hGdqt2LVHeqxcR3lByvLE9ZYrExaYHTj2OJ1n1d
        16Z97VDbfOLViT714+eL8qpqLhT9Ne099FjunxJLcUaioRZzUXEiAH40JfVmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnG5MSFCywcxGJosH87axWVy5eIjJ
        4tDmrewWUx8+YbOYf+Qcq0Xfi4fMFt+udDBZXN41h81ixvl9TBaLtn5ht+jc1c9qMevCDlaL
        1r1H2C0Ov2lntdjwfS2jA7/Hhs9NbB47Z91l99i0qpPN4861PWwe+94uY/Po27KK0WP9lqss
        Hp83yQVwRHHZpKTmZJalFunbJXBlvHp1kq1gi1zFlt+PmRoYP0h0MXJySAiYSDTe2MLWxcjF
        ISSwm1Hi249VzBAJaYnp/XvYIGxhiZX/nrOD2EICzxglJlyVA7HZBMwlFu1dygjSLCKwjUni
        14Ed7CAOs0AXo8TxvyuZITreM0pcWigMYnMKWElMONcKNlVYwFuiaelDRhCbRUBVouf+VbAN
        vAKWEqtufmCCsAUlTs58wgJiMwtoS/Q+bGWEsOUltr+dA3WpgsTPp8tYQWwRATeJo3enMkPU
        iEsc/dnDPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEx6+W5g7G7as+6B1iZOJgPMQowcGsJMJb8C4gWYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQamrhOLSySc5p0809u/4cDNNPWPi9cZLP3rkqB9SSFp
        ydvYRVs7lEJFX+u+n1b3linAylyosSl/UdLB13d8/1QYBC1/qLpbe7eZywnlCPatOyYkKMv1
        X1yn+v/cer6X868ujKl222MUoaH7zv3Y6befb6TfrbBUm6ZVur25Xv836zOG+aqfLs8/lso5
        kzFActEyKYVI2YUKZut9z3ttnzEzd7q21zUzvrCWazlvzi7TrJ2pdX7qFds9RqYHDK72Tt2W
        JG+kmrw0+IicYSH3NvGok5yM6a3MjxwfO9wMtPLpuLxuapqxkprz309cypNkjNZN7zr803nX
        wWmxm3aVMp+qflX2zPLWX9e0Ju6bal6OSizFGYmGWsxFxYkA8FlQZ04DAAA=
X-CMS-MailID: 20221021081212epcas5p3d8eda74ed0b22ca3e0ff27ee45f6ed30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104915epcas5p12414b87ea127b2d5bf521556bf841b00
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104915epcas5p12414b87ea127b2d5bf521556bf841b00@epcas5p1.samsung.com>
        <20221014102151.108539-7-p.rajanbabu@samsung.com>
        <00c301d8dfd0$f55ca230$e015e690$@samsung.com>
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
> From: Alim Akhtar [mailto:alim.akhtar@samsung.com]
> Sent: 14 October 2022 06:59 PM
> To: 'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> rcsekar@samsung.com; aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: RE: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
> 
> 
> 
> >-----Original Message-----
> >From: Padmanabhan Rajanbabu [mailto:p.rajanbabu@samsung.com]
> >Sent: Friday, October 14, 2022 3:52 PM
> >To: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> >krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> >perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> >alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> >Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> >kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> Padmanabhan
> >Rajanbabu <p.rajanbabu@samsung.com>
> >Subject: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
> >
> >Add device tree node support for sound card on Tesla FSD board
> >
> >Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> >---
> > arch/arm64/boot/dts/tesla/fsd-evb.dts | 49
> >+++++++++++++++++++++++++++
> > arch/arm64/boot/dts/tesla/fsd.dtsi    |  3 ++
> > 2 files changed, 52 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >index c0a4509499ab..ecaa3c2e3045 100644
> >--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >@@ -49,3 +49,52 @@
> > &tdm_1 {
> > 	status = "okay";
> > };
> >+
> >+&sound {
> >+	compatible = "tesla,fsd-sndcard";
> >+	status = "okay";
> >+	model = "fsd-i2s";
> >+	widgets =
> >+		"Speaker", "MAIN SPK",
> >+		"Microphone", "MAIN MIC";
> >+
> >+	primary-dai-link-0 {
> >+		link-name = "fsd-primary-0";
> >+		dai-format = "i2s";
> >+		tesla,bitclock-master = <&tdm_0>;
> >+		tesla,frame-master = <&tdm_0>;
> >+		cpu {
> >+			sound-dai = <&tdm_0 0>;
> >+		};
> >+	};
> >+
> >+	secondary-dai-link-0 {
> >+		link-name = "fsd-secondary-0";
> >+		dai-format = "i2s";
> >+		tesla,bitclock-master = <&tdm_0>;
> >+		tesla,frame-master = <&tdm_0>;
> >+		cpu {
> >+			sound-dai = <&tdm_0 1>;
> >+		};
> >+	};
> >+
> >+	primary-dai-link-1 {
> >+		link-name = "fsd-primary-1";
> >+		dai-format = "i2s";
> >+		tesla,bitclock-master = <&tdm_1>;
> >+		tesla,frame-master = <&tdm_1>;
> >+		cpu {
> >+			sound-dai = <&tdm_1 0>;
> >+		};
> >+	};
> >+
> >+	secondary-dai-link-1 {
> >+		link-name = "fsd-secondary-1";
> >+		dai-format = "i2s";
> >+		tesla,bitclock-master = <&tdm_1>;
> >+		tesla,frame-master = <&tdm_1>;
> >+		cpu {
> >+			sound-dai = <&tdm_1 1>;
> >+		};
> >+	};
> >+};
> >diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >index 5decad45a1b6..fc8931f830a7 100644
> >--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >@@ -847,6 +847,9 @@
> > 			status = "disabled";
> > 		};
> >
> >+		sound: sound {
> >+		};
> >+
> Why to have an empty node in dtsi?
This is required as every node we use in dts should have the same declared in
dtsi. Sound nodes in most of the platform is only declared (dummy node) in
dtsi and defining only in dts. Thus we are following the same.
> 
> > 		timer@10040000 {
> > 			compatible = "tesla,fsd-mct", "samsung,exynos4210-
> mct";
> > 			reg = <0x0 0x10040000 0x0 0x800>;
> >--
> >2.17.1
> 
Thank you for reviewing the patch

