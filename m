Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B466984D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjAMNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbjAMNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:19:28 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451B63F74
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:09:14 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230113130912epoutp0457465ee45ddad7b9130818a0daefd06c~54EvXP1Yl1468514685epoutp04g
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:09:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230113130912epoutp0457465ee45ddad7b9130818a0daefd06c~54EvXP1Yl1468514685epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673615352;
        bh=FF4fIradTxWfdCmmweL+K/bOvGnz0k6lWTffD4axmFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPAC8a+3XfU+fX1WA1CYl3RoJ6B4Wwng6Cg47Vj0FYaK7qlBdQtzqQObMXjsjXCb6
         tnnva66LDpPMlE6hxr7edQgYBoRfZLgkirVSgxPnI46qBvCfVVHEr/Zu83g50rR4QS
         MukmpbpeM4M5eU4k80NNJ9EQOPDGq4ZT0F2WwAIo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230113130912epcas5p3bef3464f9aa152852f7e620acd681f26~54Eu3bJx72349123491epcas5p3S;
        Fri, 13 Jan 2023 13:09:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NthZZ5djBz4x9Pp; Fri, 13 Jan
        2023 13:09:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.7D.03362.6F751C36; Fri, 13 Jan 2023 22:09:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230113121834epcas5p490aba088dce64f880c95e4f9b9a220d4~53Yh9pqRw0803308033epcas5p4a;
        Fri, 13 Jan 2023 12:18:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230113121834epsmtrp15410bfac6edacf2a93f76e34cd0ba95f~53Yh7xaSA1537415374epsmtrp1x;
        Fri, 13 Jan 2023 12:18:34 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-4d-63c157f6c717
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.19.02211.A1C41C36; Fri, 13 Jan 2023 21:18:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121832epsmtip27c49184191c84baed4bca7865123fdfc~53Yfh_67h0850708507epsmtip2a;
        Fri, 13 Jan 2023 12:18:32 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
Date:   Fri, 13 Jan 2023 17:47:49 +0530
Message-Id: <20230113121749.4657-6-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113121749.4657-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu638IPJBj23NC0ezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMrgs72QpOclV0bT/K3MA4maOLkZNDQsBE4smpaUxdjFwcQgK7GSV29h1g
        g3A+MUps/72WHcL5xiix8e9ONpiWjlOXGSESexklzi5YCdXfyiSxcdsbFpAqNgFTiVVzGllB
        EiICTUwSbW8msoA4zAIbGSVOH3vIBFIlLOAlsWjHFaBZHBwsAqoS+5/qg4R5BawlLv49B7VO
        XmL1hgPMICWcAjYSS4/ngoyREJjLIXFs3iFWiBoXiRtr37FA2MISr45vYYewpSRe9rdB2fkS
        0z42Q82skGj7uIEJwraXOHBlDgvIfGYBTYn1u/QhwrISU0+tAythFuCT6P39BKqcV2LHPBhb
        VWL98k2MELa0xL7re6FsD4nzP1ewQgKln1Fi9fJPLBMY5WYhrFjAyLiKUTK1oDg3PbXYtMA4
        L7UcHm3J+bmbGMHJVMt7B+OjBx/0DjEycTAeYpTgYFYS4d1zdH+yEG9KYmVValF+fFFpTmrx
        IUZTYPBNZJYSTc4HpvO8knhDE0sDEzMzMxNLYzNDJXHe1K3zk4UE0hNLUrNTUwtSi2D6mDg4
        pRqYLm25LXyMOTNtkf7BWbWFiQpeSakbn3rt4A9ocXh1yrKJj3PFZf+mtynuj3beOOuXvnhP
        JEv7Evl1ph2b6rq1py98/pE56V213g2fq2sSHQS2yLoJdU29rOnrtFdaIHmKzcZ9hmt4gn5u
        W3blpP3lrra9DtyFz/N9OJg9u0567GY8MGlXbCnDx+ZwIb0DGjWHtvblX4ow89WZ3aX2eMlj
        hTnV9effRhm8jzUVPC/7u65mtd6FuSIhbxUPbFvDzp5uE1B49dUyHw4faZaS/N9xYUVCLeyR
        P6t+G62z9hT9nOSUoXX/SEd3G09f/v7go18W6ljNu5W6yzHF49PxK5cfrz704caZ5oW6x+Yr
        L/VQYinOSDTUYi4qTgQAMZeTpS8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvK6Uz8Fkg6Vd2hYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK6Prwk62gpNcFV3bjzI3ME7m6GLk5JAQMJHoOHWZ
        sYuRi0NIYDejxNZjT5ggEtIS0/v3sEHYwhIr/z1nB7GFBJqZJLb1eYPYbAKmEqvmNLKCNIsI
        TGCSOPnuGAtIgllgK6PE1M9GILawgJfEoh1XgDZwcLAIqErsf6oPEuYVsJa4+Pcc1Hx5idUb
        DjCDlHAK2EgsPZ4LscpaYu/Lx0wTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIDnQtzR2M21d90DvEyMTBeIhRgoNZSYR3z9H9yUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw5fnML1iXPV+HIeLpip2S56NP8PgxWE9a2C13oX11
        67b4goamhRHBLlGthes9q8XWyXSs3mCo9el34cJVb3d0HZ5SaqktZ+nibHmT23KP05+S/9NZ
        /UsEYmpnzG08rRL05nEGy9srqakfCybUHKrwZ956yz5mv2lLd9/Knm/flB51NLLZuYgW31jB
        dLGU89PpbVKmKdZW7u5VwChuuvBm+/Rlc8w7ZkpUXM++0O/CkSTWxN4SMFdwleLvK3f7sgxa
        2LvVppcuEss9ufnyyfr28+t0W/0nJTTvbGQo3a+vqyCi+VrnT82/k48aZ37/Yt/5fonU9dSY
        F05pxsbhexJtCxReiuqa/WcNU14crcRSnJFoqMVcVJwIAF4d02/jAgAA
X-CMS-MailID: 20230113121834epcas5p490aba088dce64f880c95e4f9b9a220d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121834epcas5p490aba088dce64f880c95e4f9b9a220d4
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121834epcas5p490aba088dce64f880c95e4f9b9a220d4@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node support for sound card on Tesla FSD platform

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 2f211a1ad50d..83281e305f20 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -29,6 +29,39 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,name = "FSD Audio Card";
+		simple-audio-card,widgets = "Line", "Line Out",
+					    "Line", "Line In";
+		simple-audio-card,routing = "Line Out", "LLOUT",
+					    "Line Out", "RLOUT",
+					    "MIC2L", "Line In",
+					    "MIC2R", "Line In";
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "i2s";
+			bitclock-master = <&tlv320aic3x>;
+			frame-master = <&tlv320aic3x>;
+
+			cpu-0 {
+				sound-dai = <&i2s_0 0>;
+			};
+			cpu-1 {
+				sound-dai = <&i2s_0 1>;
+			};
+			codec {
+				sound-dai = <&tlv320aic3x>;
+				system-clock-frequency = <33000000>;
+			};
+		};
+	};
 };
 
 &fin_pll {
-- 
2.17.1

