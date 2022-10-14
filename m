Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25AF5FEE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJNN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJNN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:29:25 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F91CC74E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:29:22 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221014132920epoutp02a588ce6459d0a63693c4a440d8019e61~d8pVuMe8B3255832558epoutp021
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:29:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221014132920epoutp02a588ce6459d0a63693c4a440d8019e61~d8pVuMe8B3255832558epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665754160;
        bh=gau0Rx4qcOQ3rT4lWYHFMjK50XkjZ2agqBB2/aIEa7g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lj24/r0pv+Dn5A/rR8qtssTEY7AsnxYAStLDQthEVjnNaQNGWtc+phLnptwmNWtDC
         W2djPwyXz+T9xeXFbNpieqSw8ubwG5+30PcZtBeU8Sg7TdWXacWEMuRXPo9JmN2BYL
         uYLmQuhAAb7BCinhKhd64jnv7HLG2TDU5tXPtU1s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221014132920epcas5p1b7f564450bb2a8f7fac9b51fa98d5fc6~d8pVPEri22913429134epcas5p1O;
        Fri, 14 Oct 2022 13:29:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MpnKn5GJ0z4x9Pr; Fri, 14 Oct
        2022 13:29:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.8C.39477.D2469436; Fri, 14 Oct 2022 22:29:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221014132917epcas5p112f73a2fd3ff12a4c440a72bea3acafc~d8pScyjkr3159431594epcas5p1x;
        Fri, 14 Oct 2022 13:29:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014132917epsmtrp11e97d83823ec431b6ec2fe51c32028ee~d8pSauLD_2934329343epsmtrp1M;
        Fri, 14 Oct 2022 13:29:17 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-ec-6349642d279d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.FC.14392.D2469436; Fri, 14 Oct 2022 22:29:17 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014132915epsmtip25d9d1732a8aeb0ebf9513feabe10abb8~d8pQXvVR01566515665epsmtip2f;
        Fri, 14 Oct 2022 13:29:14 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <rcsekar@samsung.com>, <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221014102151.108539-7-p.rajanbabu@samsung.com>
Subject: RE: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
Date:   Fri, 14 Oct 2022 18:59:13 +0530
Message-ID: <00c301d8dfd0$f55ca230$e015e690$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwItme6KAWz5sEismIUOIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc/teX4ux41lhXtgP27cYA6HQMqivRnSZZGuFLBgTdWhgb+UF
        CO1r11cm858xt5UfOkHC0BaQX5M1bPxYKcrAdoZfDrehncAwwwgbslbEKSwwp6Rrebjx3+ee
        8z0553vuvUJE7MEihbmMmTYxlI7ANqAX+6OiZLIsjVbeVrSdHPX08ci+zi4B+fn0DEbWDYzw
        ydPeaYRcGi3mkTd7ajDy3HU3jxz85gDZ2PWXgCzpKeOTthvdfPJT14CA7L9fxCc7llvBa6Hq
        jsUTmPpb222B2tFSgqknxy9javd8M6Y+7WwB6nbnGKpedLycJkzP25VDU1m0SUIzWkNWLpOd
        RKQcyNybmaiUK2QKFbmDkDCUnk4iklPTZG/k6gLDE5L3KV1+IJRGsSwRt3uXyZBvpiU5Btac
        RNDGLJ0xwRjLUno2n8mOZWjzToVcHp8YEL6Tl+Ot/RkxPgwv+GpoBC0EleJSECKEeAK8sdgo
        KAUbhGK8F8CWOgfGHRYALL7uWsssAegZtPGelSxPOtdULgDLbzUA7uAD8N5vbiSownAZ7G6y
        YEEOw5086HIcDYoQ3AKgy9MKgokQfDf0D1jRIG/GU+CJC9OrcRTfBlfKGgRBFuEq6O9YQTne
        BIetM6uM4FvhpfkahBtJAh/fbeZzzV6H18aHME6zBfoGB1Y9QNwrhJ1NfgFXkAyt3nGU483w
        3lXnWjwS+sosARYGWA0bn0Zy4Rw4/2U74HgPvDJagwYlCB4F23viuFbPwc+ezPC4ShEstqzt
        dxv8+MHYWqMX4JmTJ/kcq+HCqSK0HEht64zZ1hmzrTNg+79ZPUBbQARtZPXZNJtojGfoY/9d
        uNagd4DVtx29rxtMTz2M7QM8IegDUIgQYaI5QqMVi7KoD47TJkOmKV9Hs30gMbDtM0hkuNYQ
        +ByMOVORoJInKJXKBNWrSgWxRdR0LlorxrMpM51H00ba9KyOJwyJLOTZzxbY29JFjjzvaL2k
        QR/T8GCn55X2v/f48R+PfbIk7XokSZy9qndpnBnmjYYUccwRv2/o+Owh3cRLVSGVC2fLVXNT
        s1XJnqoV44LlV2nnPx12w0F7akTqvitGoPwp7ODTQV2KI66yP74+5etH0nf3h4/pTjFWtg5s
        t8/Q0uo/fTfp9OFQZDg07IuSykuXqxZUGZvenC6YKmz7IyL3fGpvCM9a6z58tOGuXd/61saJ
        J79rjKUW2YfLymt11Na3DxMZkr3uudtzt5wFIzHy96p0sUee91XUa76b+IgGGNlsqyAfN9/v
        bV1u3vFixR1v9RRzB6u5+Muh2u9/qD4fviSYJFA2h1JEIyaW+he9pIstZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSvK5uimeywcJLnBZXLh5isji0eSu7
        xdSHT9gs5h85x2rR9+Ihs8W3Kx1MFpd3zWGzmHF+H5PF0Y3BFou2fmG36NzVz2ox68IOVovW
        vUfYLQ6/aWe12PB9LaMDv8eGz01sHjtn3WX32LSqk83jzrU9bB773i5j8+jbsorRY/2Wqywe
        nzfJBXBEcdmkpOZklqUW6dslcGW8mHuJueCDaMXqY+dYGhinCHUxcnJICJhIfL+zha2LkYtD
        SGA3o8T8/z/ZIRLSEtc3ToCyhSVW/nvODlH0nFGi++k7ZpAEm4CuxI7FbWDdIgIHmCQ6fm9g
        BXGYBboYJY7/XckM0XKQUeLM6fWsIC2cAnYS/4/MZAGxhQW8JZqWPmQEsVkEVCX+9i8E28cr
        YCnxf8NfFghbUOLkzCdgNrOAtkTvw1ZGCFteYvvbOcwQ9ylI/Hy6DGy+iICTxKlrx9ggasQl
        Xh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
        BEewluYOxu2rPugdYmTiYDzEKMHBrCTC+1rJM1mINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGpm0zJHg0l8h1/D/VcXW68ObAdiGJzIY78h/3nL72i1Xu
        tdqCY3MXz9O96c847XnWrM9xR20dyley57yb+3Jbvsajf4/exq54qF6lfucbZ7q6rAHz6x3L
        XeYv4n3w6+9rt8cMb+zdWsz212bMXtLz4diijBAz6YOX9FYEbL/XWBf6VHPaW/nF/3SVq3a0
        Vpb0f50gEeOxX/3FX/NK16sO8aHRbS8djNaJhESfPdWt8C7YVv2VmFth8x4Db8VFLQ4S24Rk
        Xk7RP7AgdlFWyqx7DddbbfnLOzsOXHcwlTqWzTlPkU1hbcO+fVLLz9yTc75SznHWdT7rpZzp
        gezVd0tlLHx2MppdENq9v2dyTMfu3UosxRmJhlrMRcWJAIuuKKtPAwAA
X-CMS-MailID: 20221014132917epcas5p112f73a2fd3ff12a4c440a72bea3acafc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104915epcas5p12414b87ea127b2d5bf521556bf841b00
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104915epcas5p12414b87ea127b2d5bf521556bf841b00@epcas5p1.samsung.com>
        <20221014102151.108539-7-p.rajanbabu@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Padmanabhan Rajanbabu [mailto:p.rajanbabu@samsung.com]
>Sent: Friday, October 14, 2022 3:52 PM
>To: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
>perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
>alim.akhtar@samsung.com; rcsekar@samsung.com;
>aswani.reddy@samsung.com
>Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; Padmanabhan
>Rajanbabu <p.rajanbabu@samsung.com>
>Subject: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
>
>Add device tree node support for sound card on Tesla FSD board
>
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>---
> arch/arm64/boot/dts/tesla/fsd-evb.dts | 49
>+++++++++++++++++++++++++++
> arch/arm64/boot/dts/tesla/fsd.dtsi    |  3 ++
> 2 files changed, 52 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>index c0a4509499ab..ecaa3c2e3045 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>@@ -49,3 +49,52 @@
> &tdm_1 {
> 	status = "okay";
> };
>+
>+&sound {
>+	compatible = "tesla,fsd-sndcard";
>+	status = "okay";
>+	model = "fsd-i2s";
>+	widgets =
>+		"Speaker", "MAIN SPK",
>+		"Microphone", "MAIN MIC";
>+
>+	primary-dai-link-0 {
>+		link-name = "fsd-primary-0";
>+		dai-format = "i2s";
>+		tesla,bitclock-master = <&tdm_0>;
>+		tesla,frame-master = <&tdm_0>;
>+		cpu {
>+			sound-dai = <&tdm_0 0>;
>+		};
>+	};
>+
>+	secondary-dai-link-0 {
>+		link-name = "fsd-secondary-0";
>+		dai-format = "i2s";
>+		tesla,bitclock-master = <&tdm_0>;
>+		tesla,frame-master = <&tdm_0>;
>+		cpu {
>+			sound-dai = <&tdm_0 1>;
>+		};
>+	};
>+
>+	primary-dai-link-1 {
>+		link-name = "fsd-primary-1";
>+		dai-format = "i2s";
>+		tesla,bitclock-master = <&tdm_1>;
>+		tesla,frame-master = <&tdm_1>;
>+		cpu {
>+			sound-dai = <&tdm_1 0>;
>+		};
>+	};
>+
>+	secondary-dai-link-1 {
>+		link-name = "fsd-secondary-1";
>+		dai-format = "i2s";
>+		tesla,bitclock-master = <&tdm_1>;
>+		tesla,frame-master = <&tdm_1>;
>+		cpu {
>+			sound-dai = <&tdm_1 1>;
>+		};
>+	};
>+};
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index 5decad45a1b6..fc8931f830a7 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>@@ -847,6 +847,9 @@
> 			status = "disabled";
> 		};
>
>+		sound: sound {
>+		};
>+
Why to have an empty node in dtsi?

> 		timer@10040000 {
> 			compatible = "tesla,fsd-mct", "samsung,exynos4210-
>mct";
> 			reg = <0x0 0x10040000 0x0 0x800>;
>--
>2.17.1


