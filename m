Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745026033E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJRU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJRU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:26:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20958DC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:26:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IJTBED017145;
        Tue, 18 Oct 2022 20:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1CqZYHi0dDFyOnoUl7YlavG1UOXfjhMHBYZTWwHRpKM=;
 b=TCjTWKStKkoFF5duX496cwD6+dKO101OC/aXeDp/ACCJO5SGHQlmKqrIF89zpjdX1wRM
 f+CddGhr/8pRdSd/amWcWih4g37/tX4wp7wSkz9YV9iNjJGbRnnuFjKRsqYNLWp/upJ/
 bA4XJzLxcxYDIhjOwAebv9s000as+a5idFLneasvoWTIJwx2cH4PbuAZfrI17wu7ERlr
 LtzMTcX0OCqkE9UpJbx/le4iaiweCQ072xWbK2K1UKF6C/jKXKGoLwOtqhE12EHyNtD0
 FBmibtD0MEMvsvvs6h7tSvZIFhdX+9DQ16Jgpd4quXiVWDK0XYuJTSvG6zFrKc8JvgIw kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7skhvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 20:25:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IK12Xh033213;
        Tue, 18 Oct 2022 20:25:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hratd25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 20:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8zxjw5yRGZS1wZzzCJBNF11Giq13Lo6fZwhJHRjw7Fk5UFGYFXlQvJ14gP33IzlnwSvpS75sxFfUsEKzi3pV6sGifkTKdBr9HjYQGf52ZAssVtV13IsPWB+L5+unEViNLdeW1TNLYC+/DBTban6jY7vvyd43KBvX/uSbO8swk8s6JuVLQ3/MkRtnaxklSi8iuTlR4kZ/ovx0WEr5O8Yo0Em5VyCaEmaMWW/IRfLMnJXBjfJA0gr7CWZ+AD/I9Cd8TM6U6W37d6o5JUtcQQxp+FVCAC3DtcR+NCYj4pySEobyiTedph6JRRYS4qmMqfh4l73vi+80mnDmEaFEW3x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CqZYHi0dDFyOnoUl7YlavG1UOXfjhMHBYZTWwHRpKM=;
 b=KVqPRGD+uXrbpHn3R8ujIPXd9PWsoFMFUzZ4X12009a43uy5o8nmP/G/ofUxbc/YxIhRIzxgn4cj29k5WD8yWiRRlpL3w5m4yBnB5fc51Z3lnsktZSkydPUkgLif0ewVP3cu/9JO2A51gdArvVKNpBqE9KUXQuuAyaKDq/Z32IMl2jOEM1pnp8MmeP4se262GkrhTfm8D2OMJ6BGY68e1LmycfwLV3FZBv/cWu0RXwj/LqTXZYHn6REN2J4eqBnauxOwoeY0i+41i8VrcMmsZGHvmLt+vP2cfpbSsYtyzTQC7XTbwxV1H1n9jTfYV4Ri/TIPy8yB8TY0r6qOMmUwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CqZYHi0dDFyOnoUl7YlavG1UOXfjhMHBYZTWwHRpKM=;
 b=HwaQ3iVH0/A/PRsfkYCLwqrjjeIxo+/o35uth0o43DtVqB3WVF0k5D4zXmeuVDrdbiGv+DjeB8u/czDtu+rn6yUeRBe1uJaUllh1LAyNLFwjNioG4uZ7v/E7nk6Td9OhjkF3RTeshDs6+U/wk2nabY76vgRZ0/A1FU4BQqYP2Z4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 20:25:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 20:25:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liu Zixian <liuzixian4@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Thread-Topic: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Thread-Index: AQHY4yY6wKFTDfH980mQOidqey86d64UiPCAgAAQPQA=
Date:   Tue, 18 Oct 2022 20:25:37 +0000
Message-ID: <20221018202518.zrnoe6ho4lcfuptm@revolver>
References: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
 <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
In-Reply-To: <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BN0PR10MB4968:EE_
x-ms-office365-filtering-correlation-id: 71f83d90-fbca-4077-dbd0-08dab146eaeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDOyt+M76jX04all3PBy0ab7JxPZWAkYOZaeQlWzKcaUVDf9BhHt9JuAuUNwYqvI2mZW3ai7fganDtA9xnAJarJppt4kc9zeYllbLLrxSY+trG9fufKrHZH2MmM7r6s4QIvytqZa8qdODiJ5lPUwfTm2fc7i/i3B/LMqNgDHiAzO7yQzr8xLZ+XOQA53TnaE9F5ViCxxnMFMOspStyl0ug9Tr80oPNWDC9kyGHEyM2dLiPytDrqhBjD79VeM1sArZWd8efo4Mi5T7kGgI/6H2UAxLdNICGj9bOLjmzBK9uvGFJ6Zudfv3QemItCS0p8Yr4RIDKpGu3VCp3gPnu4xO/l5ERFrXIT8BXaNSpZGFY6v6ZjASd9IQ7K7XZR31a7BvPtZT5ELjmsJmvbxSpxymKhodz/5hAoie2lDP6BPEqlkw61ZBKjYVrUtsZ5G8uJ/XckbtjG/GOKCLPFQ+KgnP84AXkwjdIPde5ZZusKdQlQy0/rG8GCCn6YENUmcGHFdCCVV/Te01dy5ROw0zEYUQn9nVWFsYCh/OvqH23PX/+z+8sOavKAIrT4thku7XNXmLkSOU9//ExWHkgW8Yjx5Db+fQxjzZb7NwYcQADoAJPpG55RvPlp/nVSzxiDv1yFdyOA2+BzuLizK8f32m/nZQq7oul5X7NLeI1infV/0FpkctvXQ16WkPdWWrV6+jw8UE1tBsXxIpLLFALeF6SCmCZ4HFcJBy9gsO6L568eGGqFjTNW1c0244AlB1ba11Y4Sru9y2a9ReVSSI8dYPp5085nsqCfMVPGA5DHkUjMUvMOhSPf8p2ayAphPO7wVV9YT8Ss2ChXnkwvzUfQfxUV3+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(6506007)(41300700001)(6916009)(54906003)(316002)(8936002)(5660300002)(6512007)(64756008)(186003)(9686003)(26005)(83380400001)(1076003)(44832011)(86362001)(76116006)(66946007)(66556008)(2906002)(8676002)(4326008)(91956017)(53546011)(66446008)(66476007)(122000001)(33716001)(38100700002)(478600001)(6486002)(38070700005)(966005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7zan4uIbVreIWkZrNkKBAcC8TUxoWtnWYQswCLUWqsEAgEdDxgaquejeI99w?=
 =?us-ascii?Q?ZQEPlqM45LK6xOyxuhiNp9sDGUT/Nk9JO09nfnKIjmr91EFmVYrIajnDprU5?=
 =?us-ascii?Q?fA0TY63mGa1j7poKr11T0qj7Q9MgvsPZQ2SH4fcEqke8hbKfBz2DG8bC9NE1?=
 =?us-ascii?Q?GJwhdEpkLwbrWqxzc2vSnknHEfgeND3TCaM3ztja+ZOlu9q2wyG5FdjAHjAO?=
 =?us-ascii?Q?V7kxssHfeB5JipdkvA2tWHm6O0EvhmjOK3C8/Nv+L8Wpf2y7Li/bSAVXXw26?=
 =?us-ascii?Q?YRQOLj0g1MNgLEsEIGY+N0i78Ai5WKMwn7fR1aOsWB/VYQqAfCbeZwp5pL3t?=
 =?us-ascii?Q?hd0hhOOehe8SeGYJk2cCE922nqf7C+CZrV811wu4q1+ICqM6cxlJbYpwGjhL?=
 =?us-ascii?Q?ifEQdj+hGUtjbGay5L9UOjkarXMgznalLYmuU68IBBlHu9wPCv6VJ/8WXk9b?=
 =?us-ascii?Q?qZXMQSKiYT1Vck2QZMsfQH9oWBwJjOZk/CspjZa+hfmVb7fnojvVWD9LFDVS?=
 =?us-ascii?Q?2kJ3SDrk1bhih4rHfOPXIjI4/2AjqOgDhx3d06q/NMP2Ke8uqu5Oq/a5GGW4?=
 =?us-ascii?Q?JL/W7RAcobwDOV+rnFpkKtUGCpba+DkKS37nPYGMVMvwRo/20z/QCKKT9vVm?=
 =?us-ascii?Q?Ddk/u3O1mA5JXQ2SJbgJkwXe27wE+q+QdBc4fX7MTYYT+01LnnEIOLYvCEiV?=
 =?us-ascii?Q?m4YJGEeW2UOEUSXNVhT9McnC4cb6f9ZtJ/cZZx6MQBCHSKfPxbebMWrgul02?=
 =?us-ascii?Q?BaPwS6oRW8XYx9xWfN7vpMFM0lm4cgUJA9cVnT3CN61YcUt1gcbOI289BrK3?=
 =?us-ascii?Q?ZbYwaYM/4XzgF/JGrXwRWjbftcI5InNENl7rV13cJx+uPBr3s5pkvxH9TB5w?=
 =?us-ascii?Q?MCV4wRfK+sTHlierqO+eR8QLsVlwA0qKfhPWJXEbAaVbNULPp/xm20h1fNCv?=
 =?us-ascii?Q?0jpdJbe6ULmYZNTds2ryPIopQhGcxsQxR63lYnOyjGa8YlOf4+R5WvBkHsE1?=
 =?us-ascii?Q?J1csRwu/fA2RBsLZdgdhi9JbB+rdkJAdE8jX9XdOCagh5nv6d2+6KssXV2Zd?=
 =?us-ascii?Q?A19ZHV2lwAW/2JIvL/t2/w1af2/pZTAWzG3kRa8ddY8IcpfDHhXsv9Eajt3s?=
 =?us-ascii?Q?+dYnkerpCAciF9GzRgV+/TiDblRxdCIcUut5mPvvN1NCl04OAPt78qoyI3Iu?=
 =?us-ascii?Q?caAfWHlnXMq5HyQIsWBiNPXYtJiPXDQy8yadJ+6JnP7qBTK5oxQeEGucPkrt?=
 =?us-ascii?Q?fMPrYFC1wREBx9mo7XC6IPaGNbFban2ztVLxFxzTrrthQ806t+vUgbl47vYk?=
 =?us-ascii?Q?a+m4cZhZhuT7Ixk5PNQAorIhxnH00Inck4kdN9mo06EicHw6n0UEN6/tELXz?=
 =?us-ascii?Q?VDoTUraLyG3Hqvh2XRrSUyUeigNABMLQ1dc/nXUDHNS4uRAeq4F49YXA7Uwo?=
 =?us-ascii?Q?MEzcgfl7s59/caZC9DmG1OZig0iT9wmTeUNI4dwJRQZDXZqGMNaq7nk+5rcO?=
 =?us-ascii?Q?g0O8GJWDEd09Dqo6wYk4+dF6a/YhNneRiUWjaKF9UoVqzbgtxGqSzzJFkA2Q?=
 =?us-ascii?Q?p0EfqMzqGnjNUzVDLNNxQnUHT0GBlYYkrHZ2FQHggjqIoAIuirJ48XztWHmr?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85AB62439E8B9344B2D0B173F927B493@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f83d90-fbca-4077-dbd0-08dab146eaeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 20:25:37.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhuwNR1ETkxi/w47C/E/whvkqkExl52G8PCup01MY0Jnbmsnqk1LW4GhNu8ASeBr49lCsncBfuk3C+XGo43VvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180114
X-Proofpoint-GUID: ceM99Zjy22plYGaYGVNlfigtmqDBfuW0
X-Proofpoint-ORIG-GUID: ceM99Zjy22plYGaYGVNlfigtmqDBfuW0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [221018 15:27]:
> On 18.10.22 21:17, Liam Howlett wrote:
> > mmap should return the start address of newly mapped area when
> > successful.  On a successful merge of a VMA, the return address was
> > changed and thus was violating that expectation from userspace.
> >=20
>=20
> Just wondering, do we have a simple user space reproducer / test?

Not today, no.

>=20
> Do we want to add some more tests for such scenarios?

Yes, I will code something up for LTP.

>=20
> > This is a restoration of functionality provided by 309d08d9b3a3
> > (mm/mmap.c: fix mmap return value when vma is merged after call_mmap())=
.
> > For completeness of fixing MAP_FIXED, implement the comments from the
> > previous discussion to never update the address and fail if the address
> > changes.  Leaving the error as a WARN_ON() to avoid crashing the kernel=
.
> >=20
> > Cc: Liu Zixian <liuzixian4@huawei.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Link: https://lore.kernel.org/all/Y06yk66SKxlrwwfb@lakrids/
> > Link: https://lore.kernel.org/all/20201203085350.22624-1-liuzixian4@hua=
wei.com/
> > Fixes: 4dd1b84140c1 (mm/mmap: use advanced maple tree API for mmap_regi=
on())
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   mm/mmap.c | 15 +++++++--------
> >   1 file changed, 7 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 42cd2c260898..22010e13f1a1 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2625,14 +2625,14 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >   		if (error)
> >   			goto unmap_and_free_vma;
> > -		/* Can addr have changed??
> > -		 *
> > -		 * Answer: Yes, several device drivers can do it in their
> > -		 *         f_op->mmap method. -DaveM
> > +		/*
> > +		 * Expansion is handled above, merging is handled below.
> > +		 * Drivers should not alter the address of the VMA.
> >   		 */
> > -		WARN_ON_ONCE(addr !=3D vma->vm_start);
> > -
> > -		addr =3D vma->vm_start;
> > +		if (WARN_ON((addr !=3D vma->vm_start))) {
> > +			error =3D -EINVAL;
> > +			goto close_and_free_vma;
> > +		}
>=20
> If this is something that user space can trigger, WARN_* is the wrong
> choice. But what I understand from the comment change is that this must n=
ot
> happen at that point unless there is a real issue.

The VMA start address could be changed in call_mmap() which is a driver
call.  I guess someone could write a driver to mmap by a users action?
I don't think it can be reached other ways.  In any case, I'm changing a
WARN_ON_ONCE() to a WARN_ON() and undoing the badness instead of
marching forwards.

>=20
> Why not "if (WARN_ON_ONCE)" ?

I was thinking it was harder to ignore if it happen more frequently?
There isn't a driver that does this now, but I'm not picky over which
variant to call.

Thanks,
Liam=
