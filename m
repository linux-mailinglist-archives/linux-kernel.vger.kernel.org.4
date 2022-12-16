Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4464F28E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiLPUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiLPUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:47:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D82DF3A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:47:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGGhT8E020026;
        Fri, 16 Dec 2022 20:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7ThGQxFtmjTfNMEhEi6BApNTvplXRcZuQPXcEVV3+4A=;
 b=JAfOsWOHNk1gp/8rvhWiON2VyoaBkY5t5TMPzWkApn2hGLRqJJOwDRUidPy96ZE92k8s
 y39HMzFilMe9VrlNxLYZI9H5zM/e7ZKn/3qBMTnouwE98eUva3Bc3v4XSH5/OvIufhMF
 1qfVCWVHnMZOgxROAACN3Wk2okRavquthqRQxTy/OckprmrSSmdgNcIKWxW+jWuc43LD
 E71YXwobXMIATuGrDj8a5fWXc+8e3UiQ9OFQAtZb5zEp8mTO5l4us6wne3GtDSqwu3K1
 16PMTQlq4N6sPMTakmmix+I5TpoaqIlSqR0q96KlYM/JxzxQS/sGC4Z18XVFr/q51p8I Kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeuge1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 20:47:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGJU6CQ027683;
        Fri, 16 Dec 2022 20:47:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyest27g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 20:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXBAqHs/1aiux/CxGVDciX+NsLCqZhdZA+3MsDwnn38SqCofEfbI11DIlFK3IWh0Wb42JTiHpPR8bcHt9n4WClo4WEDqw5iOk21i5XqCLr9b0xnE/0otqp1zTB+taS0UPEnh8w87n0MjM7shT728NEbBm9BfRBi7kSdK3/VbAaouVvhPVBwcgG30Bf+m7AnZKXPFbdiqQ3Lkan7Hoc4bGu2KGUocAlZbKUAOAyPo+FPZ18C3KpkwLV8l6hZ5aOOb+rXna5jPeeRDem/fpbzqOXVOa6mcBvYRiHNux3AxP9OyDCjdHEewAIuVX15iUyeCyNdxvYO2mS2uzx29YICIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ThGQxFtmjTfNMEhEi6BApNTvplXRcZuQPXcEVV3+4A=;
 b=m7OhD5AFURn94LmoUeKMqXXEfs2mUADCIR1FRcQZIs6imOiV6/jWks7TP/Kp5d2/SdEtOlObCCqdFEkihhp4Q9GR3Qrr1WlHjfmdSmXejCqv1cGyn/3gRM56SbvkSl4N2DPZ5DHs3x8WIMWAEPwELFyl7HW8woKTLEnKSsy4WyYFUWzj8pJS1MFeey0lo+g+lys72Rr4JuKOafl8+9aIPe+Z1w/ouTd5qJl3o1sdHBvIzSysANHXIO8f4zQr+/6WT5heIGr7Ug11m8DkpeVN6nA61hDR4QVlI/jOGQQwuNmlBQx/W2REuA3cw47OyTBRbPUAitwkuj+363JfDfNoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ThGQxFtmjTfNMEhEi6BApNTvplXRcZuQPXcEVV3+4A=;
 b=l+5waBrCS+2WUkVW+DMlpzF6ea2Hu4nGpCkAwz4g1TRIJ1QV1KU4oZy0++1LKqGFJvBa9CGkBR4mjIaQO3iYquJuVvvTcSdgStCUFoW7zg/fRKXi+giYT+qDQ5ZccH5bYXSbIVloMuppmU1CpUmHjLxuZTE63CISDCYewE4jnpM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BN0PR10MB5045.namprd10.prod.outlook.com (2603:10b6:408:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 20:47:27 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::4747:eca9:4a3d:a1e5]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::4747:eca9:4a3d:a1e5%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 20:47:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        "usama.anjum@collabora.com" <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] maple_tree: Fix mas_spanning_rebalance() on insufficient
 data
Thread-Topic: [PATCH] maple_tree: Fix mas_spanning_rebalance() on insufficient
 data
Thread-Index: AQHZEX+nAbpIKZyMBUWjTfJJigFqH65w3qiAgAAdhwA=
Date:   Fri, 16 Dec 2022 20:47:27 +0000
Message-ID: <20221216204720.of5vectluqg6nd4k@revolver>
References: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
 <20221216110139.fe9b0cc2951014e1856d0042@linux-foundation.org>
In-Reply-To: <20221216110139.fe9b0cc2951014e1856d0042@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB3011:EE_|BN0PR10MB5045:EE_
x-ms-office365-filtering-correlation-id: a96e3265-76fb-4548-00a3-08dadfa6be04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQRMYxI+p21tpT3mI9GY1mdICBrojU31BvSAmbC/CzXDYfN/U6J+j0N/QfC9bxD/nS6fK8WgMhU3mZ2S/pyw/1gLxwDD3l1x3wOdb6020cPrs7JDiy4cviT2fPpqUNCVcSjSrfqECgcclc/aZtO/hh8C0murQ+2QQ4almUmlA/8oxe2OPcJKVGW0vKAb1RL3us2Dkp3u/lbJDSx5v6bPTTWN7jVUuETgPqFZcJDrXufCJERrKnyOb7Ld4wSwp+2qnNKxcc2q2yGwW+0VDuTUuIpDmj7DL8QkzhHarG4eNV+GWJ3DIqYjVFB6eD9Ro7PrgIX72C01KYJCKxms5vhNPYRj1udLnftsZY3kaJUPBNsgz7Yu8FyeybZi2ZDjVMxNeUkAOpHMOuGcSWZfFurT5Om5q2KrRDc2hqCtYhwGPLglIainzYZbQAk9JC91bPlqRK6Y6CAW7+qHDPoFrZF//OxIzZYAsk4vedzccsCGX4mEBB6frjjueNpL1fBcsG3oYOp6tAxsxmswJr3/pTcdXaCGquOvWBV8v2DmtMizRKxZUq/6E0IgwpPWAcRrSRC/uHNFmMvTLL5ejBL+ymIJwpnZ7GRUOYJoFWExjQb+N2C+4I0HsLOXB4uFe868c+S4aoUOKk9XffcLYY2LJGW4Yr4Gjwf3nsLmB1HDkrtf7qTuh1qUYAXnT/M8v7tn3U8lq/FoFfm4MfqQ9WkFYynhjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(122000001)(38100700002)(2906002)(41300700001)(91956017)(33716001)(6512007)(9686003)(26005)(186003)(38070700005)(86362001)(83380400001)(44832011)(8936002)(5660300002)(76116006)(4326008)(66946007)(64756008)(8676002)(1076003)(66556008)(66446008)(66476007)(54906003)(316002)(478600001)(71200400001)(6916009)(6506007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bQtvfZ1pl3W3zkcy4bFR2nxvpvM0EVOQQZMYDexNULuTKFr6VzAGfvRO5LxC?=
 =?us-ascii?Q?x84laSbSsg9hv/r75+nXPM5MDJ9YX31IGGA9CDXoLv4J27MbCyiLQQc+LlTL?=
 =?us-ascii?Q?J2mOpM0dcK1TDwbf5i6k739FbWZeVcOHfi3aHHIJHY8X/0JrQrasKuHOKNXy?=
 =?us-ascii?Q?Wzr4bQxVKrJb+8iY3Gca9kr9OOLWbqvmwqVxz4yftHfFL9FEuTSqonZhwMoo?=
 =?us-ascii?Q?ZWmPAn7jLd4Rv02cWyQDu6bLaz9j28pa9EjZTrCVM602LoBwiJuCpz9suAbX?=
 =?us-ascii?Q?DuUz0+tuz1H4cz+KMveB9q06QJ4aSS8PxyzDH/00aYnXCylz5oG2S6UdnGcZ?=
 =?us-ascii?Q?R99Vaq+1nXDj+0opvF9AaEo5O6q5PoSlgraUW1K2ovqSJdbMz7CvsubEmaTL?=
 =?us-ascii?Q?LNhJ3NRVFWQGeCip8mHS44gePF/+BiwmAMKe079Bq3F+hSu+Yem7Gf+qvdMu?=
 =?us-ascii?Q?HyJ0nSfX7WP5tok4fzran71Bg6blB6slmZuoS5B+Jy9UZu13ux7ImIioIYWa?=
 =?us-ascii?Q?bNutE68v7AyiFhOsRN90Ew8UWU0n7J+rIKL48ecNRynpejKaZz3Shj9BV9ok?=
 =?us-ascii?Q?PL8duhsn1dSH4aT4x34XRYSjZ/ry0DrdaKfflmRTcAWRbpF3dp0wBEQCzoq/?=
 =?us-ascii?Q?mNmIH8BPk1Np4zv4CkXQqg90IqMxEwrxoFb1yGDmFt8slYzaYVO7WbRk0uR9?=
 =?us-ascii?Q?SAz6w/1n9TqZgkomPv5t2kOPmbt55Tgr/9C62BIQzJopyQTGTt8meG9TmMA7?=
 =?us-ascii?Q?uaE7SLqzGLeeJoWXXgPhTCCCG2j9hUNPjLCJrD9OXMw/um09tx08n0BmfQ59?=
 =?us-ascii?Q?+VcTSUfIvB+CIu/e63akmdCh/l7TA1zc4UaS6sv6e1PqZ4elZanHL4RF0raC?=
 =?us-ascii?Q?PwN/dpTB+f7rFJ29a2A6xPFXp7d6PJLnyRH3GpAjfRWFmTrwWALz+d6ENFY/?=
 =?us-ascii?Q?8UWSR9VP3rwfWBKiLmYXrOCSej57s8/buZUISY53XdlqjYAaJKmIyzlLYHiC?=
 =?us-ascii?Q?ZJ1g/rk8PxOsjIxItjLZLlxW5in1EyIloz1ka3U12U/5FtSt3h9o/7TG7rz/?=
 =?us-ascii?Q?8Kb3If/wTdZ82X7bmpVCE/QF/eGlIk52AExOV1vwTTqJiAd5FCg3slRS2gn3?=
 =?us-ascii?Q?4K6N7wtUSG6hgeRK0WtxXm7hCqG80CZOMY/H2hZRBg8IfR5b8BVSKeTmcf9O?=
 =?us-ascii?Q?DmpvPzxWmgzWvpylGOBlc4B/dKtT1lZjg0fc3q7u65FwyIVQaRdtl6aRi0Ji?=
 =?us-ascii?Q?S9iHABEvGc4d+nyPYOdeP8MFldABWEtL2/Gu/mvk0HAx6uukva83lzm0/BdW?=
 =?us-ascii?Q?4zjfoWPSnWTwZT9EOi7K1Xmnniscb7m2z4c+KDjAegPyGYn5uVWmQFtEqKEF?=
 =?us-ascii?Q?jvsZqcHvaYM7w/SYrWFrnrnXANorrAZYffrCSxV/4k22s6Lb10/ptvl8W1nN?=
 =?us-ascii?Q?tXgKMkTcyaGtg9EgP5J9DBo7PskLfnzt9lwJwmpwun/o4s+FhmQ9T5RQZm3h?=
 =?us-ascii?Q?aoA+mw7AioYIr6ckdPCRa/2tdBMLGFdm+Uj1IFfeoI6jvlwxzk3Fk+Ke0l+3?=
 =?us-ascii?Q?USKi10KhdXNpjuMaI/1Y/nCH2eTL6Gth/FbQKAUqC2WvGTKKWcW04xwhQG4M?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAA48676A513FD4BB6BF117B09E525A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96e3265-76fb-4548-00a3-08dadfa6be04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 20:47:27.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBWM20RDyeQQKlEoshJOjProCAffEi/0b2AmVpuplH0Vx5BdDNvpxH9wI5VT+EAsdYwqmYMXd/GDFCpyxynnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160184
X-Proofpoint-ORIG-GUID: _njVgPkq__DxKroYoEFqhjTXJax486wH
X-Proofpoint-GUID: _njVgPkq__DxKroYoEFqhjTXJax486wH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [221216 14:01]:
> On Fri, 16 Dec 2022 18:53:15 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > Mike Rapoport contacted me off-list with a regression in running criu.
> > Periodic tests fail with an RCU stall during execution.  Although rare,
> > it is possible to hit this with other uses so this patch should be
> > backported to fix the regression.
> >=20
> > An insufficient node was causing an out-of-bounds access on the node in
> > mas_leaf_max_gap().  The cause was the faulty detection of the new node
> > being a root node when overwriting many entries at the end of the tree.
> >=20
> > Fix the detection of a new root and ensure there is sufficient data
> > prior to entering the spanning rebalance loop.
> >=20
> > Add a testcase to the maple tree test suite for this issue.
>=20
> Shall do.
>=20
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: usama.anjum@collabora.com
> > Reported-by: Mike Rapoport <rppt@kernel.org>
> > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>=20
> I guess we want a cc:stable there?

Yes, please.  I'll be sure to do that in the future for backports.

>=20
> >  lib/test_maple_tree.c | 23 +++++++++++++++++++++++
>=20
> Belated review: all this code runs at __init time, so every dang
> function in there really should be marked __init, data marked
> __initdata, etc.  Like lib/test_bitmap.c.
>=20
> I wonder if there's some trick we can do external to the .c file to
> have the same effect.

This can be built as a module and also runs in userspace via
tools/testing/radix-tree.  I'm not sure about using __init in this
context but I'll look into it.

>=20
> Also, maple_tree_seed():set[] could be static ;).  So we don't have to
> initialize it at runtime.  Better would be static const.  Nitpick.

I'll have a look.  I'm sure there are more areas within my test code
that could be optimised like this.=
