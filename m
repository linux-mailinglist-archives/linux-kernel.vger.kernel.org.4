Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B67642EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLER2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiLER2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:28:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F611DF20
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:27:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5HDlfG030750;
        Mon, 5 Dec 2022 17:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1XktlNIHEQ1VvrvfNKRHftn5TM96qdzELTzcZth4yJQ=;
 b=CLOB5+bNRVveYc8DcsWz72u3DN10ocxY1rWhLdyae6fVxQyO8wIdbSikme9qi+BV4T6D
 7u49oIQlrnZYKvI085zJChUEFKPCpUWZ45sL/aHcV4M1Wx8+dW57NiNzUzFPhnqGf8C2
 rpC7qJJv7G/cQsPruOEtGlr2eZLr73X+CEtP5pVRYIWvdpfuZXhE+yDV5MXDcuNIOeTv
 +slOYnZvoEqNBXFxr0f0EIlfa4AF+rpxOddRvAbUlm3keB3Re4TVQrwIUv2f9NCoQ+xj
 s0vMJSBFZAT/W5Wkn4oMevWiKUWYH/A3YszJhvEZ1IrP4avGeRz9XlcsFl56lVLauiZO 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ya44qxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 17:27:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvsw027879;
        Mon, 5 Dec 2022 17:27:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9ghrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 17:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbUez/hvCRiEF8yfGBcRphJNd0anpzouztTeRNZcZpX/o3Qn0im91PXcEKPAspMjsjStht3zLt3gqdnO/Wh2tKuD8L61Wpb97aW93zc/WNw7MiyZHRF+x7w7Qn11cx8kv4p2Rg1pQ4ZcxDvyNmrgnk6XWeLsYq74KWczLbWnbJD/Tom82cHqfuSDMXVeftkTI1tnvWldfxSB/gqOD7RRR7ogUojh2l6C+ESxSC8b60rNiB+Rej5xOjZr4h0QE/HLMPuhEfd1WG/Nl1MqQ1brc3H92+WmIngLovoTslc0Moosx4d6ct0akaFbjs2zTQqz5qSkE2n/OfviuoIP2QoJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XktlNIHEQ1VvrvfNKRHftn5TM96qdzELTzcZth4yJQ=;
 b=Lk8FEWOAl+AL77K7oQqqZ9V6Uwabju0wBbY+Z/JqlStdFd+IlAcMroYfmNdjtpWOpIwpHjWlbWC4JcxtYGq3v9UgoKxxHklFLgjg5pQDAFpWRvgk3aouqiFDWMESPrxzbzFUDPmN+ZOuHm7G5aGqQQhiNgligXQ0SHPwoYZPJi0A+u+tNBlbnXkZHJhuP6AKwRwnj+Ndcda0K88PYafym9fQS2y/HxNWdBYmq8Ld2Mf31Hp9BlhuCeyPcdRv7Id+frUnRi5IupyxZSxLoZhuS3NgLSK7O1Z7Y8W9TYyE20r0sVj9KwKqto6M0XOMpl9Ok7lWzBpxNh8tRIBLBmwMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XktlNIHEQ1VvrvfNKRHftn5TM96qdzELTzcZth4yJQ=;
 b=wa+VX0dtsg9YBqEIu8TB8VD4Mj6YUkMeasKKfTOBPx2fV+Pp3l5cKxqRDvb1SQmESGz1Ni+UGXUl4/k8xnTp+6Dv3Wg7ZjiWybl8zQPbbz+DEAWjmSM1GxvqRbKVY8qZCBdMkdVedMMPnUAAwYx6yLvp17Z43IK2kbI2KxjpkJ4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4253.namprd10.prod.outlook.com (2603:10b6:208:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 17:27:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 17:27:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Jann Horn <jannh@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
Thread-Topic: [PATCH] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
Thread-Index: AQHZCMoToe2yhFWKEkKYie+ZWh2pHK5fiNqAgAADNwA=
Date:   Mon, 5 Dec 2022 17:27:35 +0000
Message-ID: <20221205172718.vewypps6pe2qev4c@revolver>
References: <20221205165311.1799457-1-Liam.Howlett@oracle.com>
 <CAG48ez2XrTRqvLBdfXuU=V9xbRxA4jiJgGvMb2xFy2tcjnhr_A@mail.gmail.com>
In-Reply-To: <CAG48ez2XrTRqvLBdfXuU=V9xbRxA4jiJgGvMb2xFy2tcjnhr_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN2PR10MB4253:EE_
x-ms-office365-filtering-correlation-id: 44c51d69-7e52-4e2d-6941-08dad6e5fffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aucNiBNm+vUzkLFVbPvh9SIiZGzTMiPVzlWPXbVFFUXCju61cVe0jBf1fF9qKmW1E1amqn19Sr2yD+lj6tRpaRzdchl/wuPPg4cgW5N7jMevOur3KGGUNmGBvfcF2h01JvlC2v/RtC8QDNm6iPkY8eqirxjfJ83JGJ1xAyL5hXYCYTXOHPKtkX8NohDOTuldEP6L4uSS2EkY/rqOZWcBir2AgzM3aCyW/FDlW8v8B8ngO6J/oozPm6dqtZsnNkWcJptAvEOsfcoGF2eca9wasPkflb0kyFSux/0SOib5NxqVcPjnqNYwyA6atww42swmgRUIbL1w0DOLaWS6DpxSIwzXRPT0cz8ybcp5KXhBBITigF5qouoJq9sA/K4tLCDOD1KVpA7pLL7KtfR7fQ9ubn9a/ifVzntIa6UgG4K092nm/TI/flxj9qKnZeafb7JVTwYyen2/h5IoVEFJEytQKMurbJa09LDE0TR4irdq68VP75Ij4QUKOgVciHqEWMtTgkndENxO8Bih96/7ksUteGqk9uirqXTdVfwY9Ke72bNFsS4OPz3m0ApDv39fb7pqx7/b3bNJJqTQuWtKyEABFOT/TjuEguk5xDLPfuYu9pGVypdNZX30bVrqZiaSTM0hR4VkYKABRZRK4ctDtGVwqyBWnButv3EIIZhvodu6ifgqUJJpgVQmu6hDPeIJrOXyDvIOjMZsg+YOEZ2imhIPoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(38070700005)(86362001)(71200400001)(6486002)(478600001)(53546011)(6506007)(9686003)(26005)(6512007)(5660300002)(44832011)(4326008)(8676002)(41300700001)(8936002)(66446008)(316002)(2906002)(6916009)(64756008)(54906003)(66946007)(66556008)(91956017)(66476007)(76116006)(122000001)(186003)(83380400001)(38100700002)(33716001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p4T5TpC/5jkjAU7vWfDr/yD+WGVSBkgVmRZngP1wbtzNeuN27Ugz16njVdfl?=
 =?us-ascii?Q?DdJcUBlXg41d6YiM72xDoTRGP5WTBO94ZAPPe3DKsdVQVx1nMOjXzCZLrYd+?=
 =?us-ascii?Q?sPIqvv+ZqlpDEOVxZhalzRxo3BuV5v67mCRFxwruatYLhZyllqR+NQNjFsMF?=
 =?us-ascii?Q?WtEdpCm+EbTXbmf3H/MzvjEc6kzCeT9wYDKPffzQWnZLfhbM7m7UBmB8kPkU?=
 =?us-ascii?Q?gxidsxBLq6w3BYi5j7SJAeyGw0UZ0V4/AZpJfJmhSxZf09z0STGSmTzjy//J?=
 =?us-ascii?Q?uwUjo20qvaXttEN58hxpUZxOHqJM7iOBwYYuqos71lCRaFW4D7+7XNyKQyPS?=
 =?us-ascii?Q?qpGkTVA5CsZ0X3DLu70u+X0UuOrHWnYV+TbpqiNNf88+kaaH1pZbo4HeQXHy?=
 =?us-ascii?Q?oQKF6r0DLBuQG7O+GuDvIohZYQit6MDdjDOuSC/aVMEBu4BF5r1WFi7SGpip?=
 =?us-ascii?Q?DZyp0cKOvMQgMBOosYSxNLtWOJoUb/Be8ebl16bm1T2eC7KrWXQjfXErZxyg?=
 =?us-ascii?Q?k0QnQ5fWBBiIaV/QQIcGU0eWJjeUBiYOdN4Zdb/jHdW7F1DdBq3BBRrmZx/e?=
 =?us-ascii?Q?H8TYkgOMbTaDGOYXbtauZSnIVgqaIGI9iqWlHHI7Z7jE66nZc3alLIHRN0e2?=
 =?us-ascii?Q?ldLeRUxGZbSH6b6mJKnNROpVptPh53y34drxY+qDoEXfLHJkcC13r2svo8Yi?=
 =?us-ascii?Q?Tox1QZgsrP4BzGDEMFMbNq+QnZK9fUP+LQs90I95ef6HY1GxgexM23oeGR8D?=
 =?us-ascii?Q?mqJTfC53G37O0/u2Ibeqx/UhF0YPFa0zvrlTw5/riDKzlUU8xAPmjgOcTrWK?=
 =?us-ascii?Q?lrwzGUS8nOjAPuDXYr9Mm75fVF3gl2EcnIdihBa4aS0NLfI5YtzoWJj/L6MY?=
 =?us-ascii?Q?2LOgr/FiYMJQTPJd+D0x32TNJy1HFLdz2Yrn1O8AOr+lbXOQIUTwERTzM5iN?=
 =?us-ascii?Q?uMAw8/fd9wjkkAjVVphX8CAkNKJ7FYfisCXqtg9IhK2hJ2VmI4ZwIA1fbWgW?=
 =?us-ascii?Q?Tv9RidpuzJXEGMnxmPaI2ahgx7gqjdWpYSS9y85nUAXgP0Wdp0sgcCW0FKpk?=
 =?us-ascii?Q?60y/q6LHDBAdtIxS2Hik05gM8/GZsvQ1+Ut29yOfFblyCxc7SdgmSX+iO+mh?=
 =?us-ascii?Q?EkiT/jlq/pmIbXnjR+6FhmgF42CBcKtbSWJGixDoPGDd1YH8uqbGvVsMDN5Q?=
 =?us-ascii?Q?7SaxAInzKIT+TsJwhMVTDhXOPE27LvqZKnihJgll8LdiW3CTumsjZbRNUmLu?=
 =?us-ascii?Q?WSWSsGGVcKasSTJVECvvz6EjL1FMNLOed0mDTxjq6/ENNhejBVuUrh+H3rrX?=
 =?us-ascii?Q?kMrJHV2VBSkFZAtm/4eIOwcp8G/ZSBUReZ2bf40j47JkSDIhrqtis8ex1xnU?=
 =?us-ascii?Q?SmF8auxoKqInUAyCNp4dxYzKiHKy/79t08toF1ayEjuQb3RZtVAnT6fHGApZ?=
 =?us-ascii?Q?dEYTL/rKlSuNGjJgWOM4WpbDxGgK6HWdFnJjq0e2l26IkISv89AeBe6RYyTT?=
 =?us-ascii?Q?RfgLMCJSgxiL7u+RdP7E4SIpctE1G3y+rYkNgmM9M7n8ZeZ9IeXynj7PvMyL?=
 =?us-ascii?Q?eIPgnjV6Yhdnm3FWh60nsfzjsMwi3jGYmVVNtiH6zhHpg64ATXa/1nDFpQJv?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79D62E44C581EB4891C7CE062822713E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2nueJt4v/vOHLg5MDObp98wcQy5L6hO0g/yvir9xvHqQ7zC3vBUP0mRawLj+?=
 =?us-ascii?Q?0KQzGrz3hFjBNLuObT4tWOIPyLU8aeDgNo975rroIUCHJEpEQIcseqbTp1WH?=
 =?us-ascii?Q?oOOFYjgsskt5cRJz7NiULSknRe3asHwWrCpugWJmtdHdfAH5IdS3PbcQmQFK?=
 =?us-ascii?Q?XFIHGCMSNPLD4tv4Z4ihzgxh0y4TRG6pGzvlOxNJYv4irMkzqYpd7rIAj8kD?=
 =?us-ascii?Q?qIlLa9L45B7942hDNaPT4bm2Fdr5NckQA/TX6HDDWu1s+F/1yrPDuCWNWvcr?=
 =?us-ascii?Q?Feg9f0a+DFpuEz1Rm4TpNqGlBFkx1FhH104qZtK5IQL8eOjDLsp2FScT9kMJ?=
 =?us-ascii?Q?4rwqH/JGDfYGno/GPhw+IpAaC8n0DHT1LH0NLpMoK9CH54IPQ+nwflrg4Zod?=
 =?us-ascii?Q?ueadKfLe3q6IeOuwz9L39fiv1Di6cCJIqRROALxfc63L8KNHLj1CaVRBC1yq?=
 =?us-ascii?Q?Ru9KP9Dz+lS8VXauAZ68MMjwWfNA/Prv5fwWtpQMWkn2OA2IY9pp6PHJRJfZ?=
 =?us-ascii?Q?EQqaeMz8MZK3SVUnTwvs+QdpSiZ7EXRHUprDW75zI4UXXyjSrjcfwESEgXgN?=
 =?us-ascii?Q?tW/BMvwhn3yvoVdHdvRHQeb4q9DVdqME9O8kT1RDGbFaKia4A8tjUf2RaXpc?=
 =?us-ascii?Q?C4gvttl/efryTZ1j3sK0kBFRRZngkfwKrqq8GZJPDHuW0HytZuKco2BMk7+Q?=
 =?us-ascii?Q?vMzZjCp8mIPa5yOvoT+L6kfbDDD41yrSyGPiuJQmz7h3iIWX9UQ80wZdem9E?=
 =?us-ascii?Q?brxryxy3KduBa65ShZxkOFcX+T7WcxbYOT8IWJAWSlaMdrUwrAyTd+fpPBTd?=
 =?us-ascii?Q?/LeOILUOvq/krSWSsfDe3SNHvRSKjOW690jIA6RCOMoxvY5wKMOOk5Cmi0sb?=
 =?us-ascii?Q?PVfP4SyCGra/Rvk6FF+FN1XTIKSBIBZpq9QL1zr4Wnbi0D9svFvlh6mnRnLy?=
 =?us-ascii?Q?pnv46Y794ucLIOGTyufSaNtjSGIw3nUqRS7Ck6MZn2LFWfSNKKzg9TFfwAVp?=
 =?us-ascii?Q?8zRmNrbTYprRZ7QB9S9dFKr14A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c51d69-7e52-4e2d-6941-08dad6e5fffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 17:27:35.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpWThf9gEFO6Q/zHxQs30hsWGVvERg6a2ErJ0G19n+ppeU6MTUIzGXYWaMrwOnAYkNBAYUAi647sBnTCTE1lTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=904 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050145
X-Proofpoint-GUID: QYjw1__GkeFyQWj_idNiG8oYbnEEXIw3
X-Proofpoint-ORIG-GUID: QYjw1__GkeFyQWj_idNiG8oYbnEEXIw3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [221205 12:16]:
> On Mon, Dec 5, 2022 at 5:53 PM Liam Howlett <liam.howlett@oracle.com> wro=
te:
> > Add more sanity checks to the VMA that do_brk_flags() will expand.
> > Ensure the VMA matches basic merge requirements within the function
> > before calling can_vma_merge_after().
> >
> > Drop the duplicate checks from vm_brk_flags() since they will be
> > enforced later.
>=20
> Looks good to me, with one note:
>=20
> > Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing=
 VMA and add do_brk_munmap()")
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index a5eb2f175da0..41a2c42593e8 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2946,9 +2946,9 @@ static int do_brk_flags(struct ma_state *mas, str=
uct vm_area_struct *vma,
> >          * Expand the existing vma if possible; Note that singular list=
s do not
> >          * occur after forking, so the expand will only happen on new V=
MAs.
> >          */
> > -       if (vma &&
> > -           (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) =
&&
> > -           ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
> > +       if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) && vma->=
anon_vma &&
>=20
> Why the "vma->anon_vma" check here? The old code was checking that the
> existing VMA is not attached to more than one anon_vma; but the new
> code instead checks that the existing VMA is attached to at least one
> anon_vma, and then is_mergeable_anon_vma() checks that the VMA is not
> attached to more than one anon_vma, so in effect the VMA has to be
> attached to exactly one anon_vma. Is that intentional?

That was not intentional.

>=20
> If not, maybe delete the "vma->anon_vma &&" - can_vma_merge_after()
> already does the equivalent check of the old "(!vma->anon_vma ||
> list_is_singular(&vma->anon_vma_chain))".

Yes, I will do that and send a v2.

>=20
> > +           can_vma_merge_after(vma, flags, NULL, NULL,
> > +                               addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, N=
ULL)) {
> >                 mas_set_range(mas, vma->vm_start, addr + len - 1);
> >                 if (mas_preallocate(mas, vma, GFP_KERNEL))
> >                         return -ENOMEM;
> > @@ -3035,11 +3035,6 @@ int vm_brk_flags(unsigned long addr, unsigned lo=
ng request, unsigned long flags)
> >                 goto munmap_failed;
> >
> >         vma =3D mas_prev(&mas, 0);
> > -       if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
> > -           !can_vma_merge_after(vma, flags, NULL, NULL,
> > -                                addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, =
NULL))
> > -               vma =3D NULL;
> > -
> >         ret =3D do_brk_flags(&mas, vma, addr, len, flags);
> >         populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
> >         mmap_write_unlock(mm);
> > --
> > 2.35.1=
