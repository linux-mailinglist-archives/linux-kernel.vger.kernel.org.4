Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94286022AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiJRDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJRDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:31:11 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C4A5980
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:22:38 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221018031352epoutp036372835a831be5a16d28a69abd4345bd~fC1GR8jjf2032320323epoutp03I
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221018031352epoutp036372835a831be5a16d28a69abd4345bd~fC1GR8jjf2032320323epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666062832;
        bh=c/a+95d+SSTk7rbIdpxKMCAMcfv3X4Pw1T9RxrAwG1M=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JYz9auHiXYhzLOB3gf1mSWUct2JTHoCP6DSPMd/6kVQfRecTLfRDIqnmaPLQgzqHm
         JXHXq26ajAESVmOiBpXX4k7jdcHz6XFeHUZx6qAdxX4gxO0vRH6DW4g6o+a+F2uqsk
         dGVFSefsc0LuVonAJxS8z0jMrApMqc6+knqJirw0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221018031351epcas5p3273be2a9ab89617cb2ed7a14ab4c026f~fC1FrGjim1357913579epcas5p3d;
        Tue, 18 Oct 2022 03:13:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MrzTm1h7vz4x9Q9; Tue, 18 Oct
        2022 03:13:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.A7.56352.CE91E436; Tue, 18 Oct 2022 12:13:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221017141616epcas5p4c2b5406e266beb45d2f80155364c9b45~e4OK1pZhH1394913949epcas5p4W;
        Mon, 17 Oct 2022 14:16:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221017141616epsmtrp1671cfdcd278e61f2c859abeb95ddbc23~e4OK0Yft13032930329epsmtrp1T;
        Mon, 17 Oct 2022 14:16:16 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-89-634e19ec3f6e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.EC.14392.0B36D436; Mon, 17 Oct 2022 23:16:16 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221017141613epsmtip1c028052d20d25d4b07cc20bd48240698~e4OHmNS7O2783727837epsmtip1X;
        Mon, 17 Oct 2022 14:16:12 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <smitha.t@samsung.com>
In-Reply-To: <87380fdb-4053-e8dc-e997-b7c42be025ca@kernel.org>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Mon, 17 Oct 2022 19:46:11 +0530
Message-ID: <000001d8e233$04db73d0$0e925b70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3kCFgW7f61XjFLw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVBUVRjG59y9u3ehdr0hDIfNkrlNFjgLbMB6STFKZG5BSUPqZDl0270D
        DPvVfoAxmUyBKQJSasFKYCyQEIIuH4J8SLCMQiWjICyjC4gkLpWUgAMLAy17ofjvd973ec57
        nnPm8DkeRZiIn6TSM1oVrSB47mhDp9/L4j993pEFVSxi5GhRA480zU0g5IhpGiU7ausxsq7/
        LIf88Vo7lyy23OCSl38eQ8lLD53dmwU2lJworgak3TjMI3t7L2Kk+f4Al7w3uZ/su1LII7Mv
        1nPJCxYbRpYN3kTIcvMiQpbUz2BkZqsFI20tDYDMOGpBIiBVVVQFqEZbKaAGSx9zqCajDaNM
        LXaEMlce51F3B1p4VG3pESqzy4FSuXWVgFr64nuMyrIM8qhp8/NUz+w0Fis8kLwjkaHljNaX
        UcnU8iRVQjgRHRe/Kz5UGiQRS8LIbYSvilYy4URkTKw4KknhvAbCN4VWGJylWFqnIwJ37tCq
        DXrGN1Gt04cTjEau0IRoAnS0UmdQJQSoGP2rkqCgV0Kdwo+SE5dPWRHNgNehkSETmg4ueWQB
        Nz7EQ6B9eZGTBdz5HngzgFUdpTx28RjAIWP+aucJgH3XKzhrlts5tYBttAJ4yzKMsIsJAM9/
        5+CuqHh4IBzpyeauNDzxBgCnlyZcG3PwkyhcGPoWW1G54Tvho2Ntrn034vtghmXO5UbxF2F6
        YxZvhQV4GBwqdwCWn4HdBePoCnPwrbD8hz9Wz+QL538vd3k98Sh4taCBx2q8Ydd8tisExG+5
        wYoZ06ohEt6pOQNY3ggnr9VhLIug/eTRVZbB+yX2Vb0C1rScRll+Dbb3FzqZ7xzgB2uuBLLl
        5+CZnmqEnSuEOQvjCFsXwMaiNd4CC++yGSG+CXb+VAbyAGFcF824LppxXQTj/9POAbQS+DAa
        nTKB0YVqglVM6n9vLlMrzcD1UfyjG8HY6N8BHQDhgw4A+RzCUxA1EyPzEMjpT9MYrTpea1Aw
        ug4Q6rzvrzkiL5na+dNU+nhJSFhQiFQqDQkLlkoIb4Ep31/mgSfQeiaZYTSMds2H8N1E6ciD
        r2rHmg9b50Wp32x+49fuX07MRDim+g2ih+nWE0bNwu3Tw+dTbJ8HxLVF0Ht3zT3553j8lDDt
        pbemj4yMPp1f1/juUpNDU1T++gFeq+CUVSga8H1w0CgetVRV5BDVb28/PDnbWXXMYd+XWpbb
        5dM92d4r/+Dsbmz3zH775QslX75gbc7tFW9QZ/j1ZYq3KgPUvz21PbVYfO4E6Ckdn92rePSZ
        0bxtc15Bb4zXh/yo4JbIO4ZP3oNx7hvE/YcSU9QRtUPLCiXt8B+QSyUf22nvvIqDmlHhjaWr
        EUybPVqeVvz+9fApTB2zkASsb1ZWisT4Yv4W9z1Nf0Vu2rN4j4AW4bMEqkukJf4crY7+Fx4y
        yGixBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhJTndDsm+ywdoPIhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVmc
        P7+B3WLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXxaflf1oIJohX/
        Ht9kbGB8LdjFyMkhIWAicbV3M2MXIxeHkMBuRonmS1fZIRIyEv/bjkHZwhIr/z1nhyh6yiix
        7VYPWIJNQF/i/qkeVhBbRGAXo8SSl+YgRcwCS1kkriy/zgrR8ZlRou3zXLAOTgE7iXcd+5i7
        GDk4hAVCJHZ/qwMJswioSjTs6GIDsXkFLCVuLvvFCGELSpyc+YQFxGYW0JZ4evMpnL1s4Wtm
        iOsUJH4+XQZ1hJvE/pnb2CBqxCWO/uxhnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCE4qW5g7G7as+6B1iZOJgPMQowcGsJMLr9sUnWYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamtOYwXfZ4vVrP6Vc/
        Sk2aqH3NgvW4f8nP8KfWlzYLZguFMU2tey1zevfevPzdmq5TvZleqs79vvDovpn8ukUVe6dF
        Vzx8ZP1O+t2bG7qm0axTVSKtlvlNVbhm8vleF0/6P+6FzI9yF/nIJalp5gidOq/Vr6FT/LZ0
        Q9HjNTIeXyacYryQ8rYrM/mLxIyAVXllXZvuJdsdWxQ5ZdIps7fTEsTYWpW3G+uE9c2Lib2U
        KL92bdW3nlbpSuUnXcvd7Z7vbgzTSv63yvT7/lkneQ68mvQ6s7X82JnIm2dDXjZ+v8/0+r69
        rdX9tztnhUmk/2B4c8Iwt/zsAZMoX+eiQ5MKTK47qTjukJh4bafkjfYNSizFGYmGWsxFxYkA
        8R0G75cDAAA=
X-CMS-MailID: 20221017141616epcas5p4c2b5406e266beb45d2f80155364c9b45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
        <20221011122516.32135-2-aakarsh.jain@samsung.com>
        <87380fdb-4053-e8dc-e997-b7c42be025ca@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: 12 October 2022 18:27
> To: aakarsh jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v3 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
>=20
> On 11/10/2022 08:25, aakarsh jain wrote:
> > From: Smitha T Murthy <smitha.t=40samsung.com>
> >
> > Convert DT schema for s5p-mfc in yaml format
>=20
> Convert S5P-MFC bindings to DT schema.
>=20
> You also missed full-stop.
>=20
Ok will address it in next series.

> My second comment was ignored here.
>=20
I missed one review comment which was related to change in commit message. =
Will address it in next series.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     =7C  75 --------
> >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 163
> ++++++++++++++++++
> >  2 files changed, 163 insertions(+), 75 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > index aa54c8159d9f..8b137891791f 100644
> > --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
>=20
> This is a friendly reminder during the review process.
>=20
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all reques=
ted
> changes or keep discussing them.
>=20
> Thank you.
>=20
Apart from your second review comment  I guess we have addressed all your r=
eview comments in the current patch.
Please review other changes as well and let us know if any changes required=
.

Thanks for the review.

> Best regards,
> Krzysztof


