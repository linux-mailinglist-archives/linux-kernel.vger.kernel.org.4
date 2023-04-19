Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609126E8406
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDSV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:58:10 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736846AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:58:06 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419215803epoutp0434767fd28790c597c2d065563c837b13~XdN4gI35z1392013920epoutp04S
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:58:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419215803epoutp0434767fd28790c597c2d065563c837b13~XdN4gI35z1392013920epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681941483;
        bh=yt++lBPYxJZl/2m/djRlrQi/agI4oNkeYuJ5gJkK4iM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FWoTxLOENEB0dvTi1OsJHyaBPYjD58H8O7lwaJeBGG91A6nn2hkSDBBcnJxTkoxCH
         Vvr3pUrjvmOpN4xCHZgPss9pBPFm/r9ir2M+dypJxQVPtKiiOQBifGEb8wKiaVs6PX
         tydf+QNqB32cm94Bh3LcVdvSXAyi4jF7O7emUb5o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230419215802epcas2p43dddf00a54d2920d38adbfaebec795bf~XdN3hKGPA0563005630epcas2p4y;
        Wed, 19 Apr 2023 21:58:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4Q1vmV0mkkz4x9Pt; Wed, 19 Apr 2023 21:58:02 +0000
        (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419111500epcas2p1ec2140d9a51198d4d30d159df39afd40~XUcbxas0u1846818468epcas2p1V;
        Wed, 19 Apr 2023 11:15:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419111500epsmtrp141be6b82106055c9bb7ec30dee488385~XUcbwbr5H3108331083epsmtrp1s;
        Wed, 19 Apr 2023 11:15:00 +0000 (GMT)
X-AuditID: b6c32a29-a95fd70000002057-06-643fcd3439cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.B5.08279.43DCF346; Wed, 19 Apr 2023 20:15:00 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230419111500epsmtip26af345214300035772e0ead3b49fb413~XUcbfvBOx1334313343epsmtip2I;
        Wed, 19 Apr 2023 11:15:00 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Stanley Chu'" <chu.stanley@gmail.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>,
        <bhoon95.kim@samsung.com>, <kwmad.kim@samsung.com>,
        <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
        "'Po-Wen Kao'" <powen.kao@mediatek.com>, <peter.wang@mediatek.com>,
        <cpgs@samsung.com>
In-Reply-To: <CAGaU9a-k9iDUNeT0s85o0GEeXSWsi98_QC+nK=jT9Yb1V=-SZA@mail.gmail.com>
Subject: RE: [PATCH v1] scsi: ufs: mcq: add 1 to the max Queues value
Date:   Wed, 19 Apr 2023 20:15:00 +0900
Message-ID: <664457955.21681941482096.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJsRHWp5BydKzgtb0jjt1yJbuiCjwJWOIV5AeRP6Zmt6wLh0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSvK7JWfsUg/l/lC0ezNvGZvHy51U2
        i4MPO1ksvi59xmox7cNPZosvF/czW7w8pGmx6MY2JoubW46yWFzeNYfNovv6DjaL5cf/MVls
        /fSb1eLt3f8sFlNfHGe36Lp7g9FBwOPyFW+PnbPusntMWHSA0aPl5H4Wj+/rO9g8Pj69xeIx
        cU+dR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3St0vgymg9tJK14IxIxeu5D1gaGM8KdDFy
        ckgImEg82vGXsYuRi0NIYDejxJLHe9kgEhIS/xc3MUHYwhL3W46wQhQ9Z5T4c+AaM0iCTUBL
        ov/tFrAGEQFtiSXbJoEVMQusYZa4+fQHO0THRUaJq9MfsYJUcQoESpz7fh3MFhZwlTi8G6SI
        k4NFQFXi1vnDYFN5BSwl+r7vgLIFJU7OfMICYjMDbeh92MoIYy9b+JoZ4jwFiZ9Pl7FCXOEk
        8fX2TKh6EYnZnW3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwZGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrzuNnYpQrwpiZVVqUX58UWlOanFhxil
        OViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTD57HDpqI0ocd4bFxzj/NU2oJfhoMxE5kib
        IzcXdTZoh75NPr/t/evFy+zMjm/ea8F7r6Ho97zF9rZTN9u2P/3BsFx04fvPTinCT624Lxfc
        urpNttKg+oc4z+J/STwbFhs/zV/A82bJZ4dil75r90Wd1l+zV1OZo2ym45zq9Onuys+LhLuD
        5IwXT5Su/fVOcob3i+mKKbvFZRelT9rfXbv9MsvuDQ1vTqc1hdxW3/NeutIuUilE5+Ikt1Ui
        9iLtUn92vrJZ63qIycLl5ZSLZdaBr9/wLFS/O3vp1X47UYvPvC4H3z7gemU1U1TVajpfsXWa
        ktZie968jvuXTmyT2Vbpvd88u8FtQ8ux6ysunL2uxFKckWioxVxUnAgAxIOoX1sDAAA=
X-CMS-MailID: 20230419111500epcas2p1ec2140d9a51198d4d30d159df39afd40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad
References: <CGME20230419094754epcas2p3901ad6f3171a2be1a144d957c2e0d8ad@epcas2p3.samsung.com>
        <20230419094838.136349-1-hy50.seo@samsung.com>
        <CAGaU9a-k9iDUNeT0s85o0GEeXSWsi98_QC+nK=jT9Yb1V=-SZA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stanley Chu <chu.stanley@gmail.com>
> Sent: Wednesday, April 19, 2023 7:33 PM
> To: SEO HOYOUNG <hy50.seo@samsung.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com; beanhuo@micron.com; bvanassche@acm.org;
> bhoon95.kim@samsung.com; kwmad.kim@samsung.com; sc.suh@samsung.com;
> quic_nguyenb@quicinc.com; Po-Wen Kao <powen.kao@mediatek.com>;
> peter.wang@mediatek.com
> Subject: Re: [PATCH v1] scsi: ufs: mcq: add 1 to the max Queues value
>=20
> Hi,
>=20
> SEO HOYOUNG <hy50.seo@samsung.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:56=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > If read the MAXQ field value verbatim, can use a value that is one
> > less than the supported Queue.
> > So read the MAXQ field value and incremented it by one
> >
> > below is the specification
> > Maximum number of Queues (MAXQ):
> > Maximum number of Queues this controller can support.
> > In this version of specification, maximum value is 31.
> >
> > NOTE To support 1:1 topology, the Host HW controller must support HW
> > resources for MAXQ number of Completion Queues too.
> > Host SW may use less number of completion queues for N:1 topology..:1
> > Queue
> > 0: 1 Queue
> > 1: 2 Queues
> > =E2=80=A6
> > 31: 32 Queues
> > 32-255 : reserved
> >
> > Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> > ---
> >  drivers/ufs/core/ufs-mcq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> > index 31df052fbc41..a1ee3318c605 100644
> > --- a/drivers/ufs/core/ufs-mcq.c
> > +++ b/drivers/ufs/core/ufs-mcq.c
> > @@ -150,7 +150,7 @@ static int ufshcd_mcq_config_nr_queues(struct
> ufs_hba *hba)
> >         u32 hba_maxq, rem, tot_queues;
> >         struct Scsi_Host *host =3D hba->host;
> >
> > -       hba_maxq =3D FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
> > +       hba_maxq =3D FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) +
> > + 1;
> >
> >         tot_queues =3D UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues +
> poll_queues +
> >                         rw_queues;
> > --
> > 2.26.0
> >
>=20
> This seems to be the same patch uploaded by Powen:
> https://patchwork.kernel.org/project/linux-
> scsi/patch/20230307065448.15279-4-powen.kao@mediatek.com/

Hi,
Thanks for checking patch.
I didn't realize there was already a patch.
So I have to wait for that patchset to be merged?


