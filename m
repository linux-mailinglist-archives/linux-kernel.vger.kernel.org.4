Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B162529C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKKEeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiKKEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5825C57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:05 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221111043400epoutp044b09e1b1c6244d10ee48528953770905~mbZ7Xncjv2429824298epoutp04p
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221111043400epoutp044b09e1b1c6244d10ee48528953770905~mbZ7Xncjv2429824298epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141241;
        bh=xfl7OAumI6zaduKKIznNUkuVlXfR6/lj+a+Nc8+pPzc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FebNaW9XoNBtI4YeRbWTrZvg1ZiHttNhZv+XGUeRHIjwrJTk/SvR2zev2pjyboLS4
         BRdGWAFIPiqvR0XDfbn/XMt9jWJz+9LKGY/ExaoItxgUzoX+jNwHqL6U7Q5VCrnkgr
         YYj9BRgz45gKhNYvfWW44cyHCWY8UIGrPb8sldI0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221111043400epcas5p2487ef84c4e2fbf7e609a7c6faa67a897~mbZ6p79y71812118121epcas5p2z;
        Fri, 11 Nov 2022 04:34:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N7m790Wkjz4x9Pt; Fri, 11 Nov
        2022 04:33:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.C8.56352.4B0DD636; Fri, 11 Nov 2022 13:33:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221111031707epcas5p29a5647f3617958bff3b4567e44195607~maWzAruwi0622006220epcas5p2V;
        Fri, 11 Nov 2022 03:17:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111031707epsmtrp27308bf630824e6bad70eb7769ba43d01~maWy-afO51692316923epsmtrp2C;
        Fri, 11 Nov 2022 03:17:07 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-15-636dd0b48023
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.2C.18644.3BEBD636; Fri, 11 Nov 2022 12:17:07 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221111031704epsmtip1a9d802ab1c21346b661e5e5811b03c39~maWv6OKRq2869928699epsmtip1e;
        Fri, 11 Nov 2022 03:17:04 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [Patch v3 0/3] Addition of new compatible for Exynos3250.
Date:   Fri, 11 Nov 2022 08:53:34 +0530
Message-Id: <20221111032337.79219-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfUxTVxzdfe+1fdjUPCubl04Eu0mEDWxH212mlUWJeaJbUDMxSxTe2rfS
        UNqmLU4WE1kCyogiKnOCrCCgji8/Kh8d1I1hGQsZiMiX1G5OZMCIIiJQHW5rLWz/nXvO7+R3
        cu69JC68yRWRWr2FNekZnZi7hGi4Eb42sq47TSX5fi4GjdgLOeietYGLyj2jGPqtfJpArdfq
        eaiu9yyOLra3cFCJs4uDGn+8T6CrY171VqGbQKMllwAaL/qVi/LGfseRbbifg243FXPR0Sv1
        HFTrdPPQ+YFbGLpgm8dQWf1THsq+7uQht6MBoKzDTux9SNdYawBtd1cAeqDiCU5/V+Tm0eWO
        cYy2VX3Jpe/2O7j0tYpDdHbbc4LOq6sCdK5zgEtP21bRHTPTvATBx6kbUlhGzZpCWb3KoNbq
        NUrxtl1Jm5PkCok0UhqD3hWH6pk0VimO254QuUWr81YgDt3P6NK9VAJjNovXbdxgMqRb2NAU
        g9miFLNGtc4oM0aZmTRzul4TpWct70klknfk3sHk1JRhWz5uHBEcGOrp4maCPn4uCCAhJYOP
        j8wQuWAJKaSaAWxpL+L4BCH1BMDah5RfmAZwfCKLt+hw2Ut5fqHJOzQ7hfkP2RjMrz8HcgFJ
        cqlI2Nmo8xkCqS8AHM6x+GZw6gQBXXljuE9YTm2Cjpq5l5ig1sDZ+r+BDwsoJXxhewj820Jg
        9ZUW3GeG1BgJTx+9zfELcdB10c714+Xwz/a6hXgiOP3o+gKvgsNl47gf6+BlRwHhx7GwpbeY
        8AXFqXB4uWmdnw6GX3VcwnwYp5bCY389wPy8ANqtizgMFt/1LERYCW9Un1/IScM7c89wf3V7
        4WSnE88HwUX/bygFoAoEsUZzmoY1y43Revaz/y5KZUizgZcvO2KbHdy/9ziqFWAkaAWQxMWB
        Av7aVJVQoGYyPmdNhiRTuo41twK5t7MTuOhVlcH7NfSWJKksRiJTKBSymGiFVLxCUH4mQiWk
        NIyFTWVZI2ta9GFkgCgTCxZlHu4Kels+FJ8Z9vNrg/Pda2ZdU8jwpkVSY+o7VZlzTHvHk9Iz
        2LjzDVf0mdUi/daJ9a7RR8dPsp6whL5QRVtb0Mbx+FWkFL615Wrq5gC+Jmnrpzt64xIdk6KC
        geYQD47vLy2UhyTXHdnniDurnc1+cVz9Q6xSOQIPvrL7A0GlsG0ovPrbn/aG7TGunPun76Pi
        7snmyk/6l+VXWz0xgQb+TtM+3Yod/KqlXxOzq2f2XFgv6XvWezKDnCh64DLhFdmbMl6P6mDL
        QE/YYIH2m4EsF9bvTv5j6imzuzR2kg+q8GpNrbXzl5LE+AbjstPWwsTOm4EHPgw+NC87uEsd
        +TxHTJhTGGkEbjIz/wIHnwk2YgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO7mfbnJBt/Pqls83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8Rdou7
        e7YxWrS0HWFykPBYM28No8eOu0sYPa4v+cTssXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j1a
        j/5i8ejbsorRo+vIdTaPz5vkPE59/cwewBvFZZOSmpNZllqkb5fAlfF40wTmgqe8FbcunWNr
        YLzK3cXIySEhYCJxe8cC9i5GLg4hgR2MEnMn3WKCSMhI/G87xg5hC0us/PccqqiZSeLdnHVA
        DgcHm4CuxNntOSBxEYFWRonrKzuZQBxmgZUsErc39oBNEhZwktiz5jsziM0ioCrxbes/RhCb
        V8BW4u+mt4wQG+QlVm84wDyBkWcBI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        CNLS2sG4Z9UHvUOMTByMhxglOJiVRHi5NbKThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamCKa+54I+Akyt87Rdz7XJ2l7TGLDJm97424n+8tVb7j9UJr
        6dc/f/oV36sfUDF04zikHFfGMtdivW34PO6CtSU7N3MKLOtkPWxx7fs5k171z0p3NRk3TbDJ
        t72kyjWf99nS3Arnbzu/B/64oaitXHdI3k+w/MzpX296D3LZ6Xu+PGJ1rezE9DeL/fWy7m1g
        luy9+OyhwI4q4dMmkfuswyZX3fKx5HmXsWHvcUEbxhlv1kZOub76373l+ecUzPkUeIIDl9z/
        5CIdOP2xUsbUIxtfMt6Y5FaxKcuHgWFtRhtv5eHlRg0M4nqPrn778LrxRiCnpKP/z7sN0rPM
        z5wNP1Ts3S+XxKGn+UhIbWXSrPdKLMUZiYZazEXFiQBC3gJjDwMAAA==
X-CMS-MailID: 20221111031707epcas5p29a5647f3617958bff3b4567e44195607
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111031707epcas5p29a5647f3617958bff3b4567e44195607
References: <CGME20221111031707epcas5p29a5647f3617958bff3b4567e44195607@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new compatible for Exynos3250 along with its
driver variant data for MFC v7 hardware.
Since,MFC v7 support was added for Exynos5420 and Exynos
3250 SoC with same compatible string "samsung,mfc-v7".As
both SoCs having different hardware properties and having
same compatible string for both SoCs doesn't seems to be correct.
So ,new compatible is added for Exynos3250 SOC which will
differentiate the node properties for both SoCs which
support MFC v7.

Changes since v2:
 - Addressed review comments from Krzysztof Kozlowski[1].

Changes since v1:
 - Addressed review comments from Marek Szyprowski[2].
 - Addressed review comments from Krzysztof Kozlowski[3].
 - Addressed review comments from Tommaso Merciai[4].

 1-https://patchwork.kernel.org/project/linux-media/patch/20221109035507.69086-1-aakarsh.jain@samsung.com/#25081990
 2-https://patchwork.kernel.org/project/linux-media/patch/20221102130602.48969-1-aakarsh.jain@samsung.com/#25072873
 3-https://patchwork.kernel.org/project/linux-media/patch/20221102130602.48969-1-aakarsh.jain@samsung.com/#25073109
 4-https://patchwork.kernel.org/project/linux-media/patch/20221102130602.48969-2-aakarsh.jain@samsung.com/#25072977

Aakarsh Jain (3):
  media: dt-bindings: s5p-mfc: Add new compatible string for Exynos3250
    SoC.
  media: s5p-mfc:Add variant data for MFC v7 hardware for Exynos 3250
    SoC
  ARM: dts: exynos: Rename compatible string property from version to
    SoC specific

 .../devicetree/bindings/media/s5p-mfc.txt       |  9 +++++----
 arch/arm/boot/dts/exynos3250.dtsi               |  2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.17.1

