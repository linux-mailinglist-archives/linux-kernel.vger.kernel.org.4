Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA260D126
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiJYP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiJYP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:57:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1E7EACB4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:57:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFSjSd016474;
        Tue, 25 Oct 2022 15:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9eNzA8fYdNeEhHLCvl7ONmHZvZqb6dGmVeKwk6obSGo=;
 b=FYU8Nj2ZHMbPbopcfdzkcySTYqE7QM7UeOztdOQZlBFEzrVOaGCcIU50z8NpEOZI8N0u
 B3VGHM24NrIRQQYz6EFpRNT9pbZWdVDdfr4SPF0HMgcywoX/RAZ1oDsUnWf83RyedCj4
 /EUlUmdSn8CO4CPa/7ZwZ8X+LOZs6wflAWrhAPIgB8nPfqH2ekseM03S8MJw77scwkpp
 i9aFdkWVvJQJSs8WSIh6gSSkfMZ/qtLMjm0GcjKPwqJl3dYCdZqmIfVGS3keupXaibLh
 g64N3bR5LNpOib7AArmUoAQy9VU78RVujK1FzbNr75c1o4Qt4MgN+N7GKRHRQTv5w/d6 rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a343ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:57:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFrcNm014375;
        Tue, 25 Oct 2022 15:57:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4gwmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnQJG/b9FkB/mVYogbeWncS1E2yFSHmQzXheYiuhxeEnvIUVrpJ75JdKIkU8eJZc0Rn1iSAf5bnqkq7am3nAn1pTkvF9ixvO8PO8CN8bVz5Vp+J3dmbodyFqZ7t5BaLNu6V1VdbhKzVhNNZI8zGLUROpa2LAUj7tkaQK3zryF7eUZP3Je7nO8A8okrALWZUDKYQsnh+OwQJQn4Qi7/RQ+cpa00SyMC5JtxqgDbtRfH9HzPgPAIf3MVQCQ0rZnmbCTLSE7602dKMzkQK4LEbl70Ck3v2yBc+UHuHXyi43g52GIF/3r6Av4MJYB+uCEEM2CSXM+D/o711jjL4JxK6YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eNzA8fYdNeEhHLCvl7ONmHZvZqb6dGmVeKwk6obSGo=;
 b=BL0kj8HFv8EYHazEKHWEOrsNoYH4nORhFala+FoLSssF4sJtSez408PjmeJBl66h8hwNo1vJn7lmJK4JJavV8uaGoU9aWYZt+mqX0cUP8779Vgd6VSgmp8moOTaQ/mCyJPu5jcB+AOHIbOh0HRabYZAnh/O2kqimt5X73/nZEfcdMgmrK7ri8sfdklm95pS8CUSWUqbymdRKhbludm6UWbu1dc2FBoy7HSExtGlRw+3ARK/CSuVhIYDQQJzckudAzleha1FkKswXTzrj6MnwIN5vXpazCIRBKGm1yKKiQtvzJwbaxiI8y4Fbl+t+QC2AFZAUqRa+x/jHjlP+GV+0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eNzA8fYdNeEhHLCvl7ONmHZvZqb6dGmVeKwk6obSGo=;
 b=Mm5Tozzq0A0tEgcYHhdauaOmqIuFk9c3R/x2QQs94Fh6HMBdimoDc+KEN58ydzm7j4PpttCXSACFUP+kMiXuZVjIdQ5B8o8pJoXY0MGvQJhZDnZk/hb7c+TYSOd6GtCLSIr8aRZi+doIDJL6HjIVWFfSQvTmsDCyC5Etfkdn3Nk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 15:57:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 15:57:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
CC:     "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "sj@kernel.org" <sj@kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v6.1-rc1, remap_file_pages() and vma linked list?
Thread-Topic: v6.1-rc1, remap_file_pages() and vma linked list?
Thread-Index: AQHY6EC3+kW2ams80kmc671XRMN+Sa4fRFYA
Date:   Tue, 25 Oct 2022 15:57:16 +0000
Message-ID: <20221025155702.i55ndltxvu3pvnnp@revolver>
References: <29344.1666681759@jrobl>
In-Reply-To: <29344.1666681759@jrobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4542:EE_
x-ms-office365-filtering-correlation-id: 07fe706a-df23-4683-0ab4-08dab6a196ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rpTBCNG7w2US1jnWUh15oDCuoFPeNl3HiDoQEeApOhJ9eOg1SxsCGJyfudNbqshIVLBWybRwYnJU63LJmJkhRHdWZPcc75U/+W1K+5MGDNfRyTfhnDcUzZxI4sc3dQJlznLyO3K+REGAvD4BJ3CtKlWLzCZpKmXGrfNc3GouMZ6amKfFP7aR+/x0/Mh16haaPQ7qGILbl+GovVY7LzA+xCC5brDYiYnfRWL9zycvqriMNWtKytc3RDvpRLAFRGxqPS1Z/5dXoAY9ZVcyxbHZ1Ar+JXJ7pvmdiCnGDXtTPzMdR7sOwOqRBymL/PYvwxJhREHAhIJNNV4Nm2f0dxivRQ+y5KzYkWg8hwLHiAyqhPSMbdSaidmZjUgIjMDdhRX9fnWHDdlWZEXTRjapengobqpBFPFxfx/ITovRnOJ2L2kVpPseQL0bPl//7NHuCE32K5JqSqYrSSylzvdAXF7KJ2PWltEyOtvKr9hcwxARiq9HLr95JDvK0IG0EsGRaWoKCZG7vJhNzuEdZhxHsywDdJtoIVVmFK7Vd2ckyf9q3vHWdf+vrrsxbHrWhfvBVc7FWhXga4ar8huPykl81+j4enXpqiGGIDL+GBYS5yOhmTT5T7R2K4+Gc6LIK0Yy9KdXzpAedbIGCb6IXqpWBVMvrpQE24jnwcijkO+Wm9rvnp7XB+6xPNzb8nGWNAxXoFDDIima4tB++gXj0mnHLs8mX5nExd/hz8sR2nq6RveZ3RrgLTswJyw/P/SwjSWwlbH4kpn7L/uzGkhZy6Sxd6t/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(122000001)(38100700002)(38070700005)(66556008)(33716001)(54906003)(71200400001)(4326008)(66476007)(64756008)(66946007)(66446008)(316002)(6916009)(91956017)(8676002)(2906002)(5660300002)(4744005)(6506007)(6486002)(1076003)(9686003)(186003)(6512007)(41300700001)(26005)(478600001)(86362001)(44832011)(8936002)(76116006)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Juot4sts20jKzqsKInQtFwoAYwwUrjVthWDgyjgds3JDqx6n2SNcc3dO4oBd?=
 =?us-ascii?Q?7AIFj54V4zNPG/IXTh7ZNLLrgH/qfXnJWeKShFQb7ewQqYKJSs90rqo3pCnx?=
 =?us-ascii?Q?UfOg/1zSm43mMWgzZkU+htL5iWW1KOgCHlB40vBKUoAZkn81c6GYH1wunS1m?=
 =?us-ascii?Q?V2j/cmaDOuK5sc4J0VG0A61qK4YnXb5UGBxh7XHwRTkycmqZ4oXJj4OalxrA?=
 =?us-ascii?Q?i3N+86jrechi9RF0dYbcy7jt9q0g9mkf48F+4lcKRfGgcEd+GreSRNIsSCnM?=
 =?us-ascii?Q?ZVjgG+XTlUQ0hzbyFpHOxs+LnVuCFwgeDp7+y8ujLVW3EjeIVaKmu9dux3+7?=
 =?us-ascii?Q?bmVkQsdvNc71IZBEw8np7XjoA29bNhF2+dJVj/JC0bJXWBIeONYxQdn4G9nS?=
 =?us-ascii?Q?XiUMJ3hFR/gZUEioQLRcL6xEGS8Vmw/tLMthnRh3/gNl2HDJZ/8ptaorNUMs?=
 =?us-ascii?Q?eTYHgZj6QEt/0Q/aeFWA04Am0k5ZZSz6AZP4bCTAENcx7bvyJoE61Yr759EU?=
 =?us-ascii?Q?VrqxzeXIPQZQsRU7yWknM4cdNgVRxkR3Hu0KA1gxktf0YPiQWEyU1Pk+crEY?=
 =?us-ascii?Q?AOoIifhxcWlszPwG3sSucbj3pCynMH46H3xyurLpnki7QQgl8g0sneK9YUQd?=
 =?us-ascii?Q?WEBGYUA3ZDdIyTqM5tOnrU/JrVBUC7a265Nv0nYEfqUpG8AAC0TflYqKozT5?=
 =?us-ascii?Q?TQYb1I4B9ICweGV5t8aMwA31rI69ulaUoT5YWArHQ6eWAkmpY1Y8qk4ILP1a?=
 =?us-ascii?Q?2ZqGQtRjF9M+6pCV/S4X6hSo5Z//W5ZB46wNMQ0YYcsv4CIwRxpZ4Cqn9/Zo?=
 =?us-ascii?Q?yisxF7N7AaQis4rKGQdRIy9ckOQZLpe7Gwh3AizPiHylRQTNlOY7+5Psn3VX?=
 =?us-ascii?Q?N2cQq6jnMVPsoQO1rBwbld+BJIrp0omur+XEI9xKEv+RAlftVIBxxStN8lBh?=
 =?us-ascii?Q?zzd9yk+HIfaLW+iQv0E6IiEEV8sKBgsMBgY/Q/4MjbZ46RMa+UkzxXFLNrCr?=
 =?us-ascii?Q?+SUaYPFljGyauj1UEtqcyQ0qCb8FTQTA7xzx2F03Xy46xm0XH0ccmcouLljt?=
 =?us-ascii?Q?/uemxpCbtOlR9TJ27bsnyIBug1DWL1Odn6XAAWQAzjieC3HwFppg58qgYbbM?=
 =?us-ascii?Q?d5FqI3mzCPs+8JwSP1E08mugqc9xo8AXVLKZa4fwPyFpDKRKl6JXuLKeWDCN?=
 =?us-ascii?Q?+NmRICAIfsJ7W5d33sMp/M0zQey63OZXRYKxri5yD3IFoBMb2l2Vex0SPTw2?=
 =?us-ascii?Q?eIK9A+ioYPJSlCyykNNJUaPdJnXBSvCJgGuL3vsZFykvCTt+i5HyJVUDMUaf?=
 =?us-ascii?Q?jScmyXIjiBNsxfFoOOJfXV7Mp3CkoC5l4N2dimUoN2In9aLeVfMrTchj3D+D?=
 =?us-ascii?Q?V6VJEZ59X1zJFrcAhfN2Ob7yqAK9y0QaSCyFo00iOXUIxcAEvkdVtj6/z2/E?=
 =?us-ascii?Q?uTgRvHtvgzmhVlLMj5gqhNKf8lGVC2/okRlcmHYfaFyBjiAR7CuGEfkKX1XQ?=
 =?us-ascii?Q?oAL2dniishqXA9nBhCL6LKvQ1Rk+zYc6J0s3L0jmwmi5A/0l1EGTbjDFk6o1?=
 =?us-ascii?Q?dPNoOzEpdUG6L97C7ozC2SmsDLXoav4wCSnHVBzawnXYiUfEC86554bgRAxi?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79B93FB0A99D314781349A518F023E77@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe706a-df23-4683-0ab4-08dab6a196ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 15:57:16.3828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibNiL6Jz7zEtgf712PSI5WH3FB5nMSqZBe5rwm139EvEtCKc7cVSi0CXxAYz3BOe6kH3I/uv2rwi1iQL0y+A/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250090
X-Proofpoint-GUID: s292yY8L2g65u_XcbhCz_HNqIMr9RqD3
X-Proofpoint-ORIG-GUID: s292yY8L2g65u_XcbhCz_HNqIMr9RqD3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* J. R. Okajima <hooanon05g@gmail.com> [221025 03:09]:
> Hello,
>=20
> Linux-v4.10 has a commit
> 	48f7df329474 2016-02-18 mm: fix regression in remap_file_pages() emulati=
on
> and it contains a small test program where remap_file_pages() will split
> a region into two VMAs.
>=20
> Linux-v6.1-rc1 remap_file_pages() doesn't pass that old test.

I broke this in the commit you reference below.

> I tried investigation, but I am not good in this tech field. I could
> only find there may be related to the commit
> 	763ecb035029 2022-09-26 mm: remove the vma linked list
> but I am not sure.
> How can we make the old test pass?
> "Don't use remap_file_pages()" or "Ignore such old test" is not an
> option.

Thanks for reporting this issue.  I have a fix that will be sent out
shortly.

Regards,
Liam=
