Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7466C2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjAPOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAPOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:49:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D02331D;
        Mon, 16 Jan 2023 06:33:21 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G8Dvn5007534;
        Mon, 16 Jan 2023 14:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=542D+k7tqkRcUVXgjRN705UX/uUeF7c5CQZCKxR6fRU=;
 b=Yfa2lT/d9/bciJ8Tda7nJKi0FuJynEuwodb7RHld8Ru4xNyMIy3BH5g7yO525mocSEWk
 aX3bM1kv4kJ9jYDLPMq3+WLj789DV+8Rfqh+74WiBV5npAnnMx0MXuLJb5WfrWiKT0Xl
 FOESQXvGCsZyhP83QDACBvZ5hAmIa+bjO2Lw7dIF4SWYs7F9kfzO71lkd//tCIvP/95H
 fzKHAewtzvPBn3GxZRLiORJHZ1237GG5b77KZKS/SsqDsYElhYtUF1/7ANhiTA/+DZgT
 OjAQ/0xVAF/n9f1/yMi9ASGzTqXMz1UJpRz0kqVX88UBvsapRhVJf6aQjHNrKTykv+DJ tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medav2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 14:33:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GEK4nY028503;
        Mon, 16 Jan 2023 14:33:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2qyrnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 14:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adnrpZgWVOwz/DI8w4U2nYieT+/R7ySbfLhWDqfu76QJ7lE6qQHDQz/R3YRNJOyTf3KQXvJ2c4CrBqv1ZasKFOZlmIy3cl0DlVQwwdlIzCh/mWVvn4htqjph8cwuQ7Wmq+g5GRua7Ytbhzw9HIcHnBzZJvkcR6KyQ6TJnDlQq8iMnYt2/xx0ZFcA0xS6OKvNnwUnb450RC+9wO5ZVD68m0y77FZr5/nhUK7O8LUC9ulzdfO9VuAwq70865jLHcRvss4vVW53VczZSHPmsndPWAM7QcHVPMVJMu6ERn+0cNk7WAk3qUc3D4sOPx5fWJioFenL48h5lmI6uposOOIAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=542D+k7tqkRcUVXgjRN705UX/uUeF7c5CQZCKxR6fRU=;
 b=f1oG15osmIb8TJQ4uDnMG/mHWUcyF1TgOyWcQMTVTcz0FHfZMVLVvykeOhIT/62I9d7ULCWM8Jq4ueXJew0520FxPEAu27ckrcotvgJMxl7bsaDf82LQ9fWpzHTnwmktJ/yh9T5WzhIBRqXO/RACSdbraKCm5oSVwWQtnbNzRD0+aW3RyhYE0fuYOOodWE+9eyy3mlK14VG+HK5SCkTQ7utHwbpXMV2osUWbPcAzie1LmFVuOdS/J8pezOB6pVC4Pzdo4q/T9a6/A0NphB5EeF2rv26HuYaLNYzlYipZDMhOu8BEL/Xd3nqPPV9FdPycljyjN1QAad2rDleLFJ1ZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=542D+k7tqkRcUVXgjRN705UX/uUeF7c5CQZCKxR6fRU=;
 b=ketdzqcbhHF3oyqvPipAZ4FRzmq/S1ECBFf5ykwGjMUtgY4FT0q+bMRf6xChzWIlT5cX0rxoaEqi2+SonhbQ/0fjwzC/HsTtX+SVWo65ycBm1lJoFteYaqS8tH+oV21MEL/N2NIFUWWV1EC/g4L38CT3iyTiLGWu+T2uElPCug4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4952.namprd10.prod.outlook.com (2603:10b6:408:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 14:33:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 14:33:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHZJtuHjKaXgt/yjkWRrCUo/8ISo66bbLAAgAW0fIA=
Date:   Mon, 16 Jan 2023 14:33:06 +0000
Message-ID: <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
 <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
In-Reply-To: <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4952:EE_
x-ms-office365-filtering-correlation-id: eac93f79-66aa-4d69-0448-08daf7ce9551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v49q0KfVuhVgpi9dL1BjRtJ0crbOLzmzoJzJN+zpmpUx4bAUX7J940lkiNMWbq8EYSgM8xF6sT7UESHzzqYZocniu1r1FboNJdvTuNsxXwVjX6R7CLyrWeVmceHdGWjCAMaoI4GaGYu7BDDau3DMwLr2odPsnTB+IAWtR0ji1/8lwHEL9SKvKUF8CPrHM078M9lySIc7kfcXGm+gb1WVWlY4P+b87rc6ajrrTlYzqd0RTGII+qLBF7Or15UDbOcclOtNAA8Jgny8KLT/k0NiW3CmG7FTwrPMfU/oIg6SywgYBweoiSZKlMPiRYifo5DFn98z5jtCplrnNfqlBIY5hv9E/DyxcDX3AvGHwVrRV5FGPUXTQFw9aoAAQF22NMYnNmVShdHEa2B+rH04QcEGlOZLs3CjnDUA8swqIGJ/k8YXDtI8R2WhwkqlgN5NZkZnZG573klhLymkOoLq9QYNSVUPQe1Avz8lBkxVs+6/p85tzqWygUV671Y9TdE+JZZ+GexYvxcfl2uxaAkf6Aw1HoEKQ5iIKulB9Do7A6RHq2t1T5PMK5l2q4fg6Z9vyYi9Nye+R5UdyAhwJ6f4lo1oDjz1klC8EJMG6m3OOqew98Nl9WctorBnndCoWdqwfhXJvhF3yZTj2qcH3GW1EiGz6cicGZnIsa4Y6J7VK0JO5Cg1VHRV5dYoleFMiu2S8rfyWV2z1DKkJikKVPMpZFnJI6Cq9+9oQhao7mznhoIxzHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(86362001)(33656002)(53546011)(26005)(6512007)(4326008)(6916009)(64756008)(91956017)(8676002)(36756003)(186003)(66556008)(76116006)(66476007)(66946007)(41300700001)(66446008)(2616005)(316002)(71200400001)(6506007)(54906003)(478600001)(122000001)(6486002)(38100700002)(4744005)(2906002)(38070700005)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vINGG0kbgtmhyqHI0On7SZAPHQ8wKVSNxmD8Cd21odbboZMHABmncnin2OhY?=
 =?us-ascii?Q?58EdDTxwrhv0uKtEGdBQ5I/JwYT5zbEkimNosQwE3N2O++o3bdcRRBfwi935?=
 =?us-ascii?Q?sbKBiKrkaCmv8kp7OBNZ7KQ4VWpE31J/6JJFMMZEe7UfXT0UjX3OqbV2BhQz?=
 =?us-ascii?Q?ryPh5+w8nmmMsnyvyooVsp4mRf/w7tA1xORIHhY6k6/e3YwusRlGXqJq4Vu7?=
 =?us-ascii?Q?HoB9wlowzw/G4XoGM6EjZO1hVb3FDtAPVKwrdUYNJWlLFpyjncUH62udW5XE?=
 =?us-ascii?Q?dh4mK4/vjwOC4/SMlwd3i4mllZvq+lqqSHcPHNQYSuOoS5YOVeZSOSyGAU3x?=
 =?us-ascii?Q?6NvERfbraMN0N6a2nWBlX/RYwf6eg6UVm8v2U7w1FK1xHJ8tcRn8KkG7hzNq?=
 =?us-ascii?Q?1hY/KrubJY7f/9Devf8GnSeLX3TcU/6YIXoZvahPJBI4t19nxZPxa6krZzgp?=
 =?us-ascii?Q?Ws7IpaxCYX69G7rQpFni86PFRuiotNc6miFUD+kIhF9RpebNrBcUsEc5J1l3?=
 =?us-ascii?Q?herMJotod7wSHqc8SgvJD6aM+5iAFuxk9P/zSQjuIv1U+r2Jdldov5JJJX9H?=
 =?us-ascii?Q?On3xxa/zHOBKzoCZFBB412VgbqMFnNy05SSGhfhex9ag41thTvK0QFTJcXcJ?=
 =?us-ascii?Q?sQ3PdLkjsIF8kJSCajn3R6SMMVISfTjjK6bfdaH8c6peMzUnI6CZQiUYcANh?=
 =?us-ascii?Q?UAi5SKM0jPpVAYQ7f+U/JHfhN+awLJQ0hPBKKNLM5StoN0lTID2rECxc8cH4?=
 =?us-ascii?Q?f4q7pKeur0l7maoY3X54hHYqseT35D6SwuPXu26Fphifhbj7HQsak73P8jP+?=
 =?us-ascii?Q?n/k1nGFnczTmn7puG93tD28Wu8B9izcKo02x68Pmj3V37gEVIvp/W9SCuwlN?=
 =?us-ascii?Q?o069AN33uJG9zz7zpGPbkXePQSYuk43a5e4pB3P/Hyl/8NtGNopzypEWneGX?=
 =?us-ascii?Q?gPdyIlJm77oF6n35o1wvIP78UdFCVmmzLdaiOk8vhD+WhZ+Fo4FbUnEP3VU8?=
 =?us-ascii?Q?QJFntIOktFjr6D2wmn33O2ynB1SVe7T5u5tof5G7zTBz/EKGKklbU3QY/oot?=
 =?us-ascii?Q?3jznee0zsqfeRsM2wrB0cXm4VVyb5xLq9B9AE4JJxorkXI+RPAYORsGKtQVz?=
 =?us-ascii?Q?U5HL50uIHvWRZBHlQ65GsHyVlOyUci7TbuJbg3isE0s4tzVbpfUvlGFyhmXY?=
 =?us-ascii?Q?zYUeW1qcCCSYvXA3rSCznPQ4pWGjSb6Ti3UqJeleTlKvlVAFDZYLtzGo8L2Z?=
 =?us-ascii?Q?oHMEsFPGZDFcuF/W8KgBxma/K15GB1xNtTbL8P4BdYvmdIKbfVE5U1VzQW6x?=
 =?us-ascii?Q?3pEMTOQPWKWJsMDfLzQnW3xs4lGi50BSm1if0JSKA7cyzzgcX5+NvR8N/dYR?=
 =?us-ascii?Q?na6ohsGdRno6+wzPRqXb7QJHikuEmilH4a7JdQ0gUomOFnUpKdeU1LLN5i49?=
 =?us-ascii?Q?TsYs2kcoIcpEoilcXb4thqDXSvlOpBqqGknZxJ8t9VI06igjehTWEjAyExj0?=
 =?us-ascii?Q?uwgvGWZpOZXK8T2Gmq/rdVgkiexq9iNAfC0OPsnuKFIZzT4GsySSsJeFVSEx?=
 =?us-ascii?Q?FT2Ybq9MOlYLkv1/GjDMVPTifYcZa9KKg2we5X5u6Aw91rUyhv2lPJ9UodEJ?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7E24C773C6AF8479C6F34C88685460E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nKtr3gURlOf/zcYQSNxxhTmDxEc7HiVQ1DioiNE+xtGB9c4hJnw7Wi6yk1lJ4YOoIBsOLKxXquMCCd0crA3mrU3t+v1x8ZgRwYRlbZuTEq3+miSkJH03OQuRup3jkSUZz/H8b41/uO6W7oaQ+tiCzopG/ADF22dMd6c7zz/McGJm7QFEiiRQAH+UAd9IAUB/YxjA3DdIIxmEO7zMOzAIrLoV6e+apAVn4paPvZ7wWLR8ZX/ZEZvqxyrggnCU9yj+qzLEx1ZDOoDKw39fR2yFNoyw6VvzB1AAgBRWmiHQ9F8ivb7TiY/vKscEww3/KHYqQEs2GQgQ+6qGBEzSwiApC4/HQYXSE5RE7RyPdm9mUTpQTiRenL+tR4IaGdyH38Rgw1UoqMZ0sEsiXQYUbosKlTfJ/HfaDGRCTI3GTN/i66OZR3drH0aLOBRjY5uZmqpaQzl4rnuULmmRy/fPUl9CJzUJP7KVPFky3AwaARpugGhjDoaooeyRaP5nXCvronJApvvjQKDkSH/3CNGvRgDP8R+/SqEKt2iTEvu/SG+LguKCX8ymfhvo45qasMeJP7IuRnW4ccPjjDAV6pVXrYcbGTjAjNvMFZ9wQr3yVue8x5eNFx7MryMQWi/jjyBD56XHtEH6jaSX913BZM+WKyO742M+Wk6w2H/axOkebvR9wUzvfSW/cduJksp5do1YZbBTox9uMarGGmg52qpdH3AObAWAWsLXM+t1IJuBCe7z3px+xTcA1G681EOz1iXY0chO9kqj8PNB4UjSFLLBQoWoLWBSZkYcjOulJCzohmdSF2k0xglfD1c82J9oXH5yjlGJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac93f79-66aa-4d69-0448-08daf7ce9551
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 14:33:06.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pomXjBx6xu3qwPunZPWt5b63Xq8c9WhR0wUZrHgFKSAactXCxx3tZccrvezueniQBKeqEvNaP2TpG+lslEekgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_11,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301160108
X-Proofpoint-ORIG-GUID: O3mWGtL-xjy2DUAcQoOo0arEqR-Xuia1
X-Proofpoint-GUID: O3mWGtL-xjy2DUAcQoOo0arEqR-Xuia1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 12, 2023, at 6:25 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jan 12, 2023, at 6:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>>=20
>> Hi all,
>>=20
>> The following commit is also in cel-fixes tree as a different
>> commit (but the same patch):
>>=20
>> 3927ac397479 ("NFSD: register/unregister of nfsd-client shrinker at nfsd=
 startup/shutdown time")
>>=20
>> (commit f385f7d24413 in the cel-fixes tree).
>=20
> Once nfsd's for-rc is merged into upstream, I will rebase
> nfsd's for-next and remove 3927ac397479. I intend to send
> a PR for for-rc after it's been in linux-next for a few
> days.
>=20
> Unfortunately there is a later patch in for-next that
> depends on 3927ac397479, so I can't remove it right at
> the moment.

Sorry, I wasn't clear. I need nfsd's for-rc to be picked
up and merged into linux-next before I send a PR.

I've trimmed for-next to temporarily remove the duplicate
commit, so you should now be able to continue merging both
into linux-next without an issue.


--
Chuck Lever



