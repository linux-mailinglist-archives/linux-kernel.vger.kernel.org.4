Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8266983A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjAMNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbjAMNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:16:02 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B095CFA3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:06:34 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230113130631epoutp01a3aed02cbdf6b6c3671b26dff6f82252~54CZMKTbZ0369703697epoutp01c
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:06:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230113130631epoutp01a3aed02cbdf6b6c3671b26dff6f82252~54CZMKTbZ0369703697epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673615191;
        bh=p+iv+wwnc6wVGcBLnlj21uh8n0GkONB1Oip8n9aIk2A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dHEoZkqleghhBIQ26MCbmQkBZky2XlxDKwZIusbMgdU04ZwPDT3MiKpQ7PFZXNz6c
         1QuO2CQCzJvH4Ir5jfuKnXRnZdQdu0SryxNU93bRKCBem6rohugUNEnGbewmIkpfGM
         jz3lm81uVtn1xE7nRWGtIT9HZyhSRC0qsUtx2Kwg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230113130631epcas5p1d1a1ee427a80787c8a95b1073b038ad6~54CYtR3zy0460204602epcas5p1u;
        Fri, 13 Jan 2023 13:06:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NthWT2c3sz4x9Pw; Fri, 13 Jan
        2023 13:06:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.94.62806.55751C36; Fri, 13 Jan 2023 22:06:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121805epcas5p2b92071fad91b22aecf6b777226440938~53YGpQXL62800028000epcas5p2T;
        Fri, 13 Jan 2023 12:18:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230113121805epsmtrp2e62e750b04f22b5fef42bc85a69d6bd5~53YGoV37d1419914199epsmtrp2u;
        Fri, 13 Jan 2023 12:18:05 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-9a-63c157554bc1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.19.02211.DFB41C36; Fri, 13 Jan 2023 21:18:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121803epsmtip29d37c13c6c93515bc7aa3d8b78299f3d~53YEf0-M81182411824epsmtip2w;
        Fri, 13 Jan 2023 12:18:03 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 0/5] ASoC: samsung: fsd: audio support for FSD SoC
Date:   Fri, 13 Jan 2023 17:47:44 +0530
Message-Id: <20230113121749.4657-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQzc0/GCywafXQhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGuYmPWQrecVdMfTyZtYFxCmcXIyeHhICJxNHpa1i6GLk4hAR2M0o0H21g
        AUkICXxilHh6iRki8Y1R4sGxn6wwHT8erWeHKNrLKHHhoixEUSuTxN4LWxhBEmwCphKr5jSy
        giREBJqYJNreTATbwSywkVHi9LGHTCBVwgKuEqu+9oHZLAKqEjcmzwdbwStgLfFnRQcbxDp5
        idUbDoDdISHQyiHx/vxmqDtcJPZNmwlVJCzx6vgWdghbSuLzu71Q8XyJaR+boewKibaPG5gg
        bHuJA1fmAF3EAXSRpsT6XfoQYVmJqafWgZUwC/BJ9P5+AlXOK7FjHoytKrF++SZGCFtaYt/1
        vVC2h0TH8X3MkGCJlXi75DfbBEbZWQgbFjAyrmKUTC0ozk1PLTYtMMpLLYfHVHJ+7iZGcMrU
        8trB+PDBB71DjEwcjIcYJTiYlUR49xzdnyzEm5JYWZValB9fVJqTWnyI0RQYZhOZpUST84FJ
        O68k3tDE0sDEzMzMxNLYzFBJnDd16/xkIYH0xJLU7NTUgtQimD4mDk6pBiaTCW06kf++lbV+
        sGdhufpr3b2rEUvfzwyMz71UHLf9+E4eV0mRyqxWrv48Fq2mGy9YJp57usdvYsTx6p184rcL
        JyRP/XLyf80KsStNku7L7rfuO7Xq5lRDBW8B1W9NT9yfvmy6+3s/X9r3x7POcRyP+Gfg7Osh
        JSAT3v+t3HaTS97hNx3H47ewmhvsVMi8Ul4aLrR0jvlN5wDxLIveC29E34bLh0xc+cQno6D8
        c8i+/Y8muzHvqjgwyzZx8ROmvmfPFh4PKlk0/ez6Hf83NUqLpXE2vJHfK5D085uxU0zWNr38
        p7yTnZmPfhVbYHXmwdl/p/d03DNiK/n9JtlBxFx/e1Q7g9rd7W9/mbyI5pygxFKckWioxVxU
        nAgAfRrGmiIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvO5f74PJBs8/ils8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI4oLpuU1JzMstQifbsEroxzEx+zFLzjrpj6eDJrA+MUzi5GTg4JAROJH4/W
        s4PYQgK7GSVeTNOGiEtLTO/fwwZhC0us/PccqIYLqKaZSaJh70wmkASbgKnEqjmNrCAJEYEJ
        TBIn3x1jAUkwC2xllJj62QjEFhZwlVj1tQ+sgUVAVeLG5PmsIDavgLXEnxUdUBvkJVZvOMA8
        gZFnASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4ODV0tzBuH3VB71DjEwcjIcY
        JTiYlUR49xzdnyzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMH
        p1QDU11Yufv268k2L8zuB7wyfKnMal3muv3Q0sxtqxzk476bcPqwh0i/iTl8L2lFwd7Us8+f
        Fnyc3687e/PPQ99jd6bfNL+9qf5fgZvDvNLc824e7NwtE7P+/NIuqbZR6e/Vuf0ylZ0lunbT
        XUVz1jlfWlc7Cuzb3Bg7Q+W94eLg8uQ1KU+/vTy/+4KJ3kmeDSl2VcfOWies1VtV7z57S3Bm
        q92zEHuvf0k2ySWGkwoMhXccCF6pVfLU8HzvDc7bJvWJ/EEtO8I+LujfJvb3Rk2Pp4Yjz8f3
        vrJVNfosRtUykquu7WUJ1uMQeiFw2ED13jbr22vidX1jrHdML3nnsixMLTNbcWWBPjtL0NGX
        6YFKLMUZiYZazEXFiQB6Ew0+zQIAAA==
X-CMS-MailID: 20230113121805epcas5p2b92071fad91b22aecf6b777226440938
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121805epcas5p2b92071fad91b22aecf6b777226440938
References: <CGME20230113121805epcas5p2b92071fad91b22aecf6b777226440938@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables audio support on FSD SoC.

Changes in v3:
1. Addressed all the review comments provided for v2 patch.
2. Fixed compilation warnings reported by kernel test robot.

Changes in v2:
1. New compatible added in Exynos I2S driver for FSD platform.
2. Added Fixup support for Exynos I2S CPU DAI.
3. Migration of manual PSR, OPCLK configuration to Exynos CPU DAI driver as
fixup.
4. Migrated from dedicated sound card to simple audio card.
5. Support added for tlv320aic3x-i2c codec on FSD platform.

Changes in v1:
1. Add TDM support on samsung I2S interface.
2. Allow sound card to directly configure I2S prescaler divider instead of
calculating it from frame clock.
3. The sound card support for FSD SoC which utilizes samsung I2S interface
as CPU DAI.

Padmanabhan Rajanbabu (5):
  ASoC: dt-bindings: Add FSD I2S controller bindings
  ASoC: samsung: i2s: add support for FSD I2S
  arm64: dts: fsd: Add I2S DAI node for Tesla FSD
  arm64: dts: fsd: Add codec node for Tesla FSD
  arm64: dts: fsd: Add sound card node for Tesla FSD

 .../bindings/sound/samsung-i2s.yaml           |  8 +++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         | 53 +++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    | 14 +++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 34 ++++++++++++
 sound/soc/samsung/i2s-regs.h                  |  1 +
 sound/soc/samsung/i2s.c                       | 53 +++++++++++++++++++
 6 files changed, 163 insertions(+)

-- 
2.17.1

