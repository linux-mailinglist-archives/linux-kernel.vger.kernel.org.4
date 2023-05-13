Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137887017ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjEMOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:50:44 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A8172C
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 07:50:39 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230513145036epoutp01b1ce95c2802537f4206ff2cee3fbdaff~eu3h6gaR30196901969epoutp01P
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 14:50:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230513145036epoutp01b1ce95c2802537f4206ff2cee3fbdaff~eu3h6gaR30196901969epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683989436;
        bh=jt71to26b/0AmlkHEXon0HZXZJQ0jOkRj280OLP/xAo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iV2iikfh2r2fYdlGc2BQn9FFUG87aRXsKqbQDs8KRI/getWmvIQ4ufXFza6/fxk8m
         jioCJBe5hAkJcUAzLyPU8zLy+1M7M8EPPgJWFnRQJ6O+cW7o7qTH/vAvqtgJsmZKIi
         TH/M9mCHNbBznMaAzDRYzTkuXuHwpgFxdQ4t4uJc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230513145035epcas5p3df45b7eb7a7f082f0fca30bc1325ce5a~eu3g-FFAL0082600826epcas5p3R;
        Sat, 13 May 2023 14:50:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QJT8B1x3lz4x9Q1; Sat, 13 May
        2023 14:50:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.21.55646.AB3AF546; Sat, 13 May 2023 23:50:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230513144532epcas5p447cfa22fffc672a5654038a5fa33f0d0~euzG8RRLo2705127051epcas5p4T;
        Sat, 13 May 2023 14:45:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230513144512epsmtrp1b12f9adb69c9d262c7b01e12c1da00dc~euy0SQlFd1771517715epsmtrp1c;
        Sat, 13 May 2023 14:45:12 +0000 (GMT)
X-AuditID: b6c32a4b-913ff7000001d95e-3f-645fa3ba5aa9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.F7.27706.462AF546; Sat, 13 May 2023 23:44:52 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230513144449epsmtip28ae8378714b84c053cf870999fa0d9fa~euyelhaRX2951629516epsmtip2N;
        Sat, 13 May 2023 14:44:49 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Aakarsh Jain'" <aakarsh.jain@samsung.com>,
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
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <525d7b15-ffbd-22d9-7ad5-0a0ff7290620@linaro.org>
Subject: RE: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Sat, 13 May 2023 20:14:28 +0530
Message-ID: <000101d985a9$79de0160$6d9a0420$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2qCSoqzmQPtjJ4D91uRJfLAIcDAIowXKcAjqO7m0BbM7kWQJcr1nmrtyakIA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTPd28ft2w1V4TwjW2ENWELYqEVqJdJEQIzdz5IzTJdFrfa0BvK
        6Gt94HBsg6iMUVEhTtPKQyiPlPEsTxEi1CLKEglMHhvrHAKD0rgZHs4p2dZyceO/3/nO73fO
        +Z0vB0P9i9nBWIbaQOnUMiWP5cfovBUezu+xSuWCxicsYr7bzCSsTxcQ4oF1hUE42jrYRPv9
        qyhRN9TPJCqc95hE18BDBtG66M2Oml0MYqGiCRBuyy8s4vziDEr0ebwK++wEk/ihp5RFnGvp
        YBKNThebqJkcRYha+zpCVHWssomzfU42cSbfiSQGkQ3lDYDsdlUDcrJ6GSWvW1xs0trrRkh7
        /Tcs8ueJXhbZVv0VeXbwGYM8314PyELnJItcsYeQw2srbAn3w8x4BSWTU7pQSp2mkWeo08W8
        g+9Jk6WxIoGQL4wj9vBC1TIVJealHJLw92cove55oVkypdH7JJHp9byohHidxmigQhUavUHM
        o7RypTZGG6mXqfRGdXqkmjK8LRQIdsd6iScyFSVruUxtdchnXTM2di6YDi4EHAziMfDCpUZW
        IfDD/PEbALaaTm8GywCO1PQidPAEwOHuceSFpKClBtCJPgCdHc5NlhvAKds/qI/Fwvmw25q/
        USsAXwWwp3+Q7QtQfAmFVS1zzEKAYRw8AXaOAp9gB34UrpaVbIgZeBhcm3m2gbl4HHzUN8Wm
        8XZ41zzH8GEUj4C1lR6UHikU/jVfy/ThADwVPu5tZtKcIOgedLJpzi0OdFzdReMUOFZdt2ln
        B1waat/kBEP3hXy2bzSIk7BqfXNJCviorhnQeB/sv1/K8FFQPBw290TRnbbBoudzCK3kwoJ8
        f5odBk//Ps6g8auw2GRi0thbfKyNeRG8Ydniy7LFl2XL/Jb/m10DjHrwCqXVq9Ipfaw2Wk2d
        /O+/0zQqO9i4jZ0Hu8HDXx9HOgCCAQeAGMoL4H5tlsr9uXJZ9ilKp5HqjEpK7wCx3mUXo8GB
        aRrvcakNUmFMnCBGJBLFxEWLhLwg7lviu2n+eLrMQGVSlJbSvdAhGCc4F1G+ppo+YtN6Gu+8
        lJx0ouLy8dZlxsepeVr+2p9nRpXT7WVDew7UJ6aUdxakTR/zfBEykv3Jj5k8l+nm3vnI58PH
        iyjb085DN9+cysk5oDy83DSznMuPIpslH7weN4aU62Y/6nOU5t8uivu+zBWgFWlOfXpy7YHb
        WflT0H5b0/UjSeJd33Iw19/3FrMHLpJ5g7BrN0eS0PDb/ssjZYnmKBO2HpEqFt2O/rKqon3O
        Nvu5Ma+k0mrytGw/1qh62Rl0ZZ/R7Jq4c6n1O7vE6TeOWgPfV2QZ6m68i4sqrihG98rekS5g
        hUdrrjmypgQ5S/F/bBvrHT4cVuNJjkg6lyjyZAVmDPAYeoVMuBPV6WX/AuuN4MakBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSvG7KovgUg90/dS2e7pjJarH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7Po
        e/GQ2WLva6COTY+vsVpc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4TdoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYweXUeus3l83iTncerrZ/YA3igum5TUnMyy1CJ9uwSujFkXpjMXvJKu2H7uPmsD4xXxLkZO
        DgkBE4mODUsZuxi5OIQEdjNKNM3/zQqRkJa4vnECO4QtLLHy33N2iKLnjBIdL74xgiTYBHQl
        dixuYwOxRQR+MEr0PjIGKWIW+MMs8Wbqa6iOhUwSB4/cYepi5ODgFLCT2HYRrFlYIETi+sxT
        LCA2i4CqxNeHv5hBbF4BS4m3e2+wQ9iCEidnPgGrYRbQlnh68ymcvWzha2aI6xQkfj5dxgpx
        hJ/Ehz3rWSFqxCVeHj3CPoFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIEpw8tzR2M21d90DvEyMTBeIhRgoNZSYS3fWZ8ihBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Mju4z0h9pNah0XL9f0Vm6QCbCaB33
        spO5EreXBlj631X1iZt++Itm2YPnq7rrZpVwSfy+cmQNo+abNfu+H9a3f6EqdGXxnb7H03U/
        tzcYnLR75Ktb5Onk9H2KXC7PSbE3x+a/nZTU9PLF2Zh98Xw8GpM15Ka+Xpzn+mhZZ0+kpuSH
        T8ffr5bfvu1QwuWmI/MuPmffJZFxMaqbKSXm+KzdJ/5M6mG5Fnu8/vD9rc+9T3zX1riztNFZ
        +hf7o9pig5XuahqdM6RafzR9+jrzeC7T3EktOryqEf8Wxa3Kl+t48+CAxuO2UysP/t6ky85i
        98bySAQfQ0DIiYS28lMzVdd1hGo2KZz8Up258aNQZYlXpxJLcUaioRZzUXEiALChEUmOAwAA
X-CMS-MailID: 20230513144532epcas5p447cfa22fffc672a5654038a5fa33f0d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com>
        <20230328114729.61436-1-aakarsh.jain@samsung.com>
        <ad96f28a-7b2d-a58b-50fb-648063ed0b18@linaro.org>
        <000001d983eb$e0692280$a13b6780$@samsung.com>
        <525d7b15-ffbd-22d9-7ad5-0a0ff7290620@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Saturday, May 13, 2023 3:03 PM
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com
> Subject: Re: =5BPatch v7=5D dt-bindings: media: s5p-mfc: convert bindings=
 to json-
> schema
>=20
> On 11/05/2023 11:34, Aakarsh Jain wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=
=5D
> >> Sent: 28 March 2023 20:06
> >> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> >> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> >> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> >> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> >> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> >> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org=
;
> >> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> >> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> >> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> >> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> >> pankaj.dubey=40samsung.com
> >> Subject: Re: =5BPatch v7=5D dt-bindings: media: s5p-mfc: convert bindi=
ngs
> >> to json- schema
> >>
> >> On 28/03/2023 13:47, Aakarsh Jain wrote:
> >>> Convert s5p-mfc bindings to DT schema format using json-schema.
> >>>
> >>> Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> >>> ---
> >>> changes since v6:
> >>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions. However, there's no need to repost patches *only* to add
> >> the tags. The upstream maintainer will do that for acks received on
> >> the version they apply.
> >>
> >> https://protect2.fireeye.com/v1/url?k=3D03601d03-62eb0848-0361964c-
> >> 74fe485fb305-ca0023b5279dd925&q=3D1&e=3D9490b51d-9547-4566-bb76-
> >>
> 8c1401745ae1&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17%2Fs
> >> ource%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L540
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> >>
> >> Best regards,
> >> Krzysztof
> >
> >
> > Hi Krzysztof,
> >
> > I don=E2=80=99t=20see=20this=20patch=20in=20linux-next.=20It's=20been=
=20more=20than=20a=20month=20now.=0D=0A>=20>=20Please=20let=20me=20know=20i=
f=20any=20other=20changes=20required.=0D=0A>=20=0D=0A>=20I=20already=20prov=
ided=20you=20review=20tag.=0D=0AThanks=20for=20your=20review.=0D=0AThe=20qu=
estion=20was=20more=20on,=20if=20you=20will=20pick=20up=20this=20patch=20vi=
a=20your=20tree=20or=20this=20will=20go=20via=20Rob's=20or=20Media=20tree.=
=0D=0AI=20will=20prefer=20if=20this=20goes=20via=20your=20tree.=0D=0A=0D=0A=
>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0A=0D=0A
