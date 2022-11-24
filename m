Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9E6377D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKXLnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:43:21 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFC9A5F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:43:14 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221124114311epoutp01d539a14400c6d36bc7f44c0fb345f56c~qgpWuGpsh2152621526epoutp01J
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:43:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221124114311epoutp01d539a14400c6d36bc7f44c0fb345f56c~qgpWuGpsh2152621526epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669290191;
        bh=5mXRFoLs3Ave53OP/+bbEVKjYKpNERHuQLCi5BHRMd8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CAcvDPdHlWIsg3YsuFnXfW3eGZiAn8X93pdiAWz8Q8J8SxEaxU4kwoTE+FP9mf9QT
         y30DAqXg+RmJ2uwmaAKO2wadoimSgagqHMUjCWKUloJJdaMsFYYzgOEW3vDeARvYQ2
         BZP1E/ASn/bW6DFcZxcWe2ZYWhqc1FT7XESdPaAs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221124114309epcas5p36ae834149560fa37d5bd3574c58818cd~qgpVBDiXN2117821178epcas5p3C;
        Thu, 24 Nov 2022 11:43:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NHx2M6jbzz4x9Pq; Thu, 24 Nov
        2022 11:43:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.CD.56352.BC85F736; Thu, 24 Nov 2022 20:43:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221124114307epcas5p1be354f71746681c4e8e163330653b4f4~qgpTOD8Gd0680406804epcas5p1J;
        Thu, 24 Nov 2022 11:43:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221124114307epsmtrp14b1d52f8a31ad3b1fd27de394525f384~qgpTNDsnP0501805018epsmtrp1r;
        Thu, 24 Nov 2022 11:43:07 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-8a-637f58cb0a5d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.F2.14392.BC85F736; Thu, 24 Nov 2022 20:43:07 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221124114304epsmtip1585cd92c62d26d39ce9df8cc539c1a05~qgpQMuQWx1886718867epsmtip1S;
        Thu, 24 Nov 2022 11:43:04 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Aakarsh Jain'" <aakarsh.jain@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <smitha.t@samsung.com>
In-Reply-To: <20221114115024.69591-3-aakarsh.jain@samsung.com>
Subject: RE: [Patch v5 2/3] media: s5p-mfc: Add variant data for MFC v7
 hardware for Exynos 3250 SoC
Date:   Thu, 24 Nov 2022 17:13:02 +0530
Message-ID: <001401d8fff9$eb9c53a0$c2d4fae0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEWRgxeWB9GQv2mDJaVZC8m4WNgiwKNLU9SAqiIKIGvqbmjcA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH/W7PfmmzpwnyZXTdfMI6yMGG23owwDLiHkNOlD8sqWBuTxtu
        bLs9m0RHQoqcQA49u25MBXWIyaHY+OGA0QGNPOjSkJ9FQ0HJDY8wwMrkqo1h8d/r+/m839/P
        5/P93odN51lYfHaOzkQadXItxlyNtHwTFS387p1ChejwbxJ8ylnJwO1/3qfht+3zCN7d2MzC
        mwZP0fGL1zsZeLX7BgO/1jWJ4F95/dn+Sg+C36++AnCfbZyJW7wTdNxxd5iBD7SdZuKfXW1m
        4JfdHhZ+YaSfhtc6Fmn4+eYFFn6kw83CPa4WgBeXuGmvhxH1VfWAcHpqADFSM0cnWm0eFmF3
        +WiEo66USfw87GISjTWFxJGevxDC0lQHiDL3CJOYd7xA9D2aZ6Vz92oS1KRcSRoFpE6hV+bo
        VIlYakbWm1lSmUgsFMfjr2ICnTyXTMSSd6QLU3K0/ukxwQG51uwPpcspCotNSjDqzSZSoNZT
        pkSMNCi1BokhhpLnUmadKkZHmraIRaI4qV+YrVG3VOwzeOBHdouXVQTsoWWAw4aoBFqnWpll
        YDWbh7YDOHbmKAge5gC82+igB1Q89HcAra0RTx0jXdZlUQeAs5bZZbsPwJmH/YyAiokKodNe
        spQIQZ0ADtbbkUCCjhYj0PZEWAbYbA6aBHs7CwK4Dv0Q3hx6K6BA0I3wUNM0CDAXjYfltR5a
        kJ+DvZX3lm95Bdaee0APNiSAj6dqGcF4GPT1uFkBDkG3wbFr7UuNQrSPA9vmFpCgIRn+4WpY
        5nVw+noTK8h86KsoYQX6gSgBzy/yg2E1nLnYAIK8FXYOnkYCEjoaBRvaYoNl18JjT+7Rgk4u
        PFrCC6o3wsO/Di0XioAnyssZQSZg+aidfhxssK0YzLZiMNuKYWz/FzsLkDoQThqoXBVJSQ2b
        dWTef5+t0Oc6wNJiRKc6weSdhzHdgMYG3QCy6VgIt3B7gYLHVcrzPyaN+iyjWUtS3UDqf+0T
        dH6oQu/fLJ0pSyyJF0lkMpkkfrNMjIVx7dZoBQ9VyU2khiQNpPGpj8bm8Ito6Pw/q7TS8IED
        6pRIxlDP5fFULC3aXNC+PmKm6NLnmq1y9deju25jzw/1TGdKsiRezcC7f1eFVdQnh++6qp0o
        zd9p6djve6+rwvX2WXN2TneaIs9tfvTJAOW6YqLy3riUeeFcafseQ3ZxdZLeNi7PSO9J+OlL
        fOEXu0jZedxwh3/yU44sITM/bMvug/vdqn2SGynbNkU6kb4Pzrz27A8OjaixpIbvmp3IP7Vp
        b82D1tH1Ly/GhqqnovrcDV6O89CYijp57P3B7+eH1yhlwjUHv02ryrgpTX+xN9wbb35p1W7N
        3Pa1k3vaMh9bRTu7BIYNZbeMz1hz4m4ZdlgIYVyE9IvIHzGEUsvF0XQjJf8Xiyaqm6EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUxTWRjHPXfrhUnHK0V7xBmijTyIiiAajorOxPX6IAhGJWqiTbkWZLUt
        OiqxDAEntEqYB025qGiLNRZcKKWtCKTUW0lVVJRQt6rgwjI6QYtrzDiWxoS33/f9zv+f7+HQ
        eMRXIorOztdwqnx5rowKJ+xXZdFzb2RoFfG956TopbOaRKZPAxh6agoQyN3ULEK2nhocne10
        kahWuEUiR0c/gRoHv9vuaj+BBmovADTEP6FQ5WAfjqzPe0l0r+U4hQ5faibRecEvQmd83Rgy
        W79iyNg8KkLlbYII+VvtAJUdErDfpWzDyQbAOv11gPXVvcPZy7xfxJpahzDWaqmg2Me9rRTb
        VKdlyz1fCLbSZgGsTvBRbMAazV5/HxCtF28JT87kcrP3cKp5y3aEZxnu9oFCXvqH01FPlIB+
        iQ6E0ZBZAH0dBqAD4XQEcwVAc2ULFRLToK+xShRiCTz334Ao9GgAwIpGNxkUFDMXOk2HqKCI
        ZFoB1B/tJoMDzhwjoNP6AAtFOgC0t7//bmg6jFkGva7iYFrCZEL+xIexJoKJgaW2YRBkMbMI
        6s1+LMSToLf6BRFknJkNj/SVgx9sPv0PHjpvOvz80kyG9lI45BHGzo5klsNHjiugCkj4cVX8
        uCp+XBU/Ln4KEBYwlStU5ynz1AmFCfnc3ji1PE9dlK+MUxTkWcHYB4md5QQOy0icG2A0cANI
        47JIsXZtsSJCnCnft59TFWxXFeVyajeYRhMyqfiOzrs9glHKNVwOxxVyqh8Wo8OiSjDX0MGK
        noNzXi2ija6b+tHdS2JN/W86X8/3ZahVGb/WL0xe43mU/nzpaO7HrI97JhpAYvUqhX7bL1G1
        YktzTtpPhsmpKbVlbI7tarvKcn8mSkw1l03Y9VfM8KqRJMP+jBcFvyGbi9q5kdZ0rTaOGB+X
        btVFJ0sW//0mfsYRh33BuofaksOpnMmduPhZcVWKZ7RG40rypNX70/sWbvoW5W34dqwpW3vW
        VWAkn81YrvHumlMkLvMMr1BsbVl5c61+xdvYd+Yau/L2z11Pw3zTA1hPT+qJJwdeZbNdygOE
        sPFPPf/v+h3pKeCisHLTbWZWgpDEtLd1DuZMib+2IbOtNLB5koxQZ8kTYnGVWv4/tpDJi48D
        AAA=
X-CMS-MailID: 20221124114307epcas5p1be354f71746681c4e8e163330653b4f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00
References: <20221114115024.69591-1-aakarsh.jain@samsung.com>
        <CGME20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00@epcas5p3.samsung.com>
        <20221114115024.69591-3-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Aakarsh Jain =5Bmailto:aakarsh.jain=40samsung.com=5D
>Sent: Monday, November 14, 2022 5:20 PM
>To: linux-arm-kernel=40lists.infradead.org; linux-media=40vger.kernel.org;=
 linux-
>kernel=40vger.kernel.org; devicetree=40vger.kernel.org
>Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
>mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
>ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
>benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
>stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
>david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
>robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
>alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
>pankaj.dubey=40samsung.com; smitha.t=40samsung.com;
>aakarsh.jain=40samsung.com
>Subject: =5BPatch v5 2/3=5D media: s5p-mfc: Add variant data for MFC v7 ha=
rdware
>for Exynos 3250 SoC
>
>Commit 5441e9dafdfc6dc40 (=22=5Bmedia=5D s5p-mfc: Core support for MFC v7=
=22)
>which adds mfc v7 support for Exynos3250 and use the same compatible strin=
g
>as used by Exynos5240 but both the IPs are a bit different in terms of IP =
clock.
>Add variant driver data based on the new compatible string
>=22samsung,exynos3250-mfc=22 for Exynos3250 SoC.
>
>Suggested-by: Alim Akhtar <alim.akhtar=40samsung.com>
>Fixes: 5441e9dafdfc (=22=5Bmedia=5D s5p-mfc: Core support for MFC v7=22)
>Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
>---
Thanks=21

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

> .../media/platform/samsung/s5p-mfc/s5p_mfc.c    =7C 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
>b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
>index fca5c6405eec..007c7dbee037 100644
>--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
>+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
>=40=40 -1576,8 +1576,18 =40=40 static struct s5p_mfc_variant mfc_drvdata_v=
7 =3D =7B
> 	.port_num	=3D MFC_NUM_PORTS_V7,
> 	.buf_size	=3D &buf_size_v7,
> 	.fw_name=5B0=5D     =3D =22s5p-mfc-v7.fw=22,
>-	.clk_names	=3D =7B=22mfc=22, =22sclk_mfc=22=7D,
>-	.num_clocks	=3D 2,
>+	.clk_names	=3D =7B=22mfc=22=7D,
>+	.num_clocks	=3D 1,
>+=7D;
>+
>+static struct s5p_mfc_variant mfc_drvdata_v7_3250 =3D =7B
>+	.version        =3D MFC_VERSION_V7,
>+	.version_bit    =3D MFC_V7_BIT,
>+	.port_num       =3D MFC_NUM_PORTS_V7,
>+	.buf_size       =3D &buf_size_v7,
>+	.fw_name=5B0=5D     =3D =22s5p-mfc-v7.fw=22,
>+	.clk_names      =3D =7B=22mfc=22, =22sclk_mfc=22=7D,
>+	.num_clocks     =3D 2,
> =7D;
>
> static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 =3D =7B =40=40 -1647,6 =
+1657,9
>=40=40 static const struct of_device_id exynos_mfc_match=5B=5D =3D =7B
> 	=7D, =7B
> 		.compatible =3D =22samsung,mfc-v7=22,
> 		.data =3D &mfc_drvdata_v7,
>+	=7D, =7B
>+		.compatible =3D =22samsung,exynos3250-mfc=22,
>+		.data =3D &mfc_drvdata_v7_3250,
> 	=7D, =7B
> 		.compatible =3D =22samsung,mfc-v8=22,
> 		.data =3D &mfc_drvdata_v8,
>--
>2.17.1


