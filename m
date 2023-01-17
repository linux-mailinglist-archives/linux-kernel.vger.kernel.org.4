Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7602A66D44F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjAQCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjAQCeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E009F24107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09WlJ006385;
        Tue, 17 Jan 2023 02:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=pc6yy82DfIgzgKbvRw4GBfsOiu2kWthxUNPEprqD+pE=;
 b=wDDDcH2TNXlnJS5Qh6l8oYZ6MCo557Pu7mglfvt+TLeWNMcefIzEv+Od9aQcvx5Hmoz+
 0RSYYrD/r2n7nS5qPy3jnn5yNd4JH6+/0EGJmiDZS9lVWYh20ppHjreI2ifXZiCFAWTg
 MDLJwgAHKasoaVoz1/+8IAgg2WrfL1GBlVpm9sJOT8RnZh07LZAYybYzQviEli5O7cSG
 H91Ud15ANwlRc0mwDdqhsCzNqMQyckH+t+HNoZjSksxlTFtfypLhBe/elg4/baW/VRWq
 7HEv7wT3daS4HHEmtBT/67/oyD4Ftan9RmO7DIXHUe1gpCo5BxRCVEDoSssLg99rDxpD Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNtirb015412;
        Tue, 17 Jan 2023 02:34:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq3qhs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2fQBfQ5h/vpw71e7s17OAPDuyDAHW1sTV6I0qYX2hAHL47RkYNJC83+vpm1KOH38h3zvudQy0UOl1E++zFh/UIuxwV4oObN77nlNMNnDNIofx05rfjDc4zZKn+yQWSZt3yP+ryeDcV0XJBBOacz0owF0ogqKMTANR3lD8fXUlakcqhyAJFwnjX8ANAz/+wxh6Lem0xOIJTl7EFz1dvB3IMuhyWGf1ObwIueo8V+N5XNPsJcqrmJfrsanInMAoODyBiBiBoS0vI/unNBHjqNohtLtdbe/OyZJrv88qZrSUqJpcU9qe2nhro3rhgDjQ4+gtKws228evgCcuk55nnyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc6yy82DfIgzgKbvRw4GBfsOiu2kWthxUNPEprqD+pE=;
 b=Lae6G4w6ffK6kErT5bcsfG4s+S8daDZOf1pWhsmKo4+PrsBGSbW2Wr0vaCOhTEwgMxL40MQGWlktDwXHhlE849m/uvMS2QHAy4O/y9EI/EdoBCVuKSLT4n1gFSHdnTlnABpTNy+eQMNkppve6r+MjwT2aWoOFmYkybNi/Yrt6+wt0Nfzq4BMhAH1eAm3U55hI31C9uVMuZ20h3Ut3bBCeaizsQUPMgvZnI77qfzjhAl4LoHt5O3z3ox2EXJVePjDMfH5Rbso6TRhQ4/pJv5piwxyod2pJNn/3GwkYQa/B9oV/f7WPKm8s1EhGwIiOPgkC0K2k2rbeEYeM62L64HfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc6yy82DfIgzgKbvRw4GBfsOiu2kWthxUNPEprqD+pE=;
 b=MxmiytCiTu7O5IIVOsFOrkofHnO9G6RoyMgpWMf7eahi0L7RTzsUSSUEKpl5dX6X4t94gdKuFmXdgIQbMfb9aCJvqWvVWgCPucqthGP8igT9LaqROcQ7QKYuXvpbKU51AIPSp6DSza53FeRl8rsOuqWpH/Jw3UXxcrcYV9BEKFU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 00/48] VMA tree type safety and remove __vma_adjust()
Thread-Topic: [PATCH v3 00/48] VMA tree type safety and remove __vma_adjust()
Thread-Index: AQHZKhwpCIR2RMtUDU+Ysx2Ua0uZxQ==
Date:   Tue, 17 Jan 2023 02:34:02 +0000
Message-ID: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: dc16f461-9128-4543-4001-08daf8334bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MDUm7Ivz0XvBvStXPmn4hNLqedYZoqbuWYQSp5sGKWsg28nBBV3/iADzOTJWVwS/GezFZ3XDngbVO7UJaoOhU5dk2lPMCyLJUfnfh/HZIKX43Dp/6LcKp+yRdPyzbwoJUYQ0LRWq6FE/pxf2sQW41ajOmQD4XedPUJEuhHzShZjn7XWRRteRXs11qbv2q+8V9pBM1xEQwHTx4DugFCcS86B8f95c9cmpD3TZMX8szPTCv2i66pSLuZHMfEoNIcrd1FNwWclHgOhVTINaoYJ2CGGLRuTySX2t1I1iKCgiProrNqgiVfFeQj4f0qvvg48irxhTg7Lg/MrK0aGsmTSFHB5iUNwMhyRSDnX7XTJgSutU39krF2fZHOy+LdxLLapb1qovxmLeP8epTBe/1m03kGhK+PokYwf6Foy71U5zsjc1aY012LGc7el01nziBvpu8Juhc0xDT1wdGIcrqf7A2pMmEnNyVCrVux/NNpnQg2xykT96+O+2VrpchCAVM+/AEHLv2NlnSCNaqmG2sqFZTncRJI9rnT/4mHlFI34csmLsBZw1GFa7mZLUEgdDRhJXTtZkLMZxr77+FuPSj3wE5iDiBXzPQEnNrZ2MyahzyUgIQEJh1emQGyA8MUISgULciz9T0neCU1A6FshSZhXSoH5N7+heRLbi6Pe5UxW1CshJ4XDCIA43KEyj4b/YypntCSbSyqBI1yDEDl+l6zHEnyHtQBtMaOaOjsJwaOK22TxFJjzlGSifRKR7d6EddHrI8r/CRthDRGUxJKkGG1KYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(966005)(478600001)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gQQJnJFaXhbgpTwpjhdP2cbEtABS6i7VCwX54MgAl+QSftFrQ74ciT+/Pr?=
 =?iso-8859-1?Q?JcIiI0xcyRpcbch4yTyP0IfsweHB+JHjMCb0i3kDkAudFnt2+PG0z50OKI?=
 =?iso-8859-1?Q?SZXQhQ+KgFiTP3ka5Pp7Hn7H/uowVxxGJ8XrzV5kWVDSfaI4WAzkmhjwTi?=
 =?iso-8859-1?Q?MzOyXvyTT/O1hJo7JTqxk/nas4w9LyR68y5VrvpjLatiWLgZohgyclKpeP?=
 =?iso-8859-1?Q?iqBis6vri3AdoG21+DTU+ectngaTC/9Agx3onoHQEHCWYJWbACLTPG7Wut?=
 =?iso-8859-1?Q?KQe2TG6fgvxM9ftYi5KgyZx7wkDcb3iiHEnnZrM/0eX5ZuPARb73WoVzcZ?=
 =?iso-8859-1?Q?J/h2i3i9ddzgMAyJAKnp/LLJwqmJJcxcsLxm+HoOaX1+8JhHH/CjPdnTGx?=
 =?iso-8859-1?Q?YjOQK32tNOoZg5otmI+XtTvCvQ0a1kkjU39gYLe9cP7k9m0JVVitn+5Pln?=
 =?iso-8859-1?Q?ZIcoeKKF7mkkHXR7/YqqfGxGuQWyysIyTQqC0blHKI8S0KbDod8p4ngSE5?=
 =?iso-8859-1?Q?vWO7t9gu5trncR84H1N+pwb5lOJtavLHlbFuReLuA0zUaPZSaMFDswH73g?=
 =?iso-8859-1?Q?LX3hHs8xeYP08TNDMtwRu0WOM9QMxYEkbv+vHmS5vwqdYijc6Xr1Kk7ohv?=
 =?iso-8859-1?Q?bLJsn0Cnq6h7dB2FMFTcOfYEVaEH0LWpzB9SRfXUdsElLsyEROST5bYAa3?=
 =?iso-8859-1?Q?KDSCGn7ZUT3qglgsauR0pw8gQUDtj2qQxKxhG8Ds1YqJFpZ52xmbDjZLFk?=
 =?iso-8859-1?Q?f3szro8cPac1Wu8rD1/RRV8qHMV8llFvVq0p+ixYHRfFnsd91z6arRtY4w?=
 =?iso-8859-1?Q?/cJKvZld/q9vaOLWZBC30B/gID5zP0hoBZKLtJn7xEh/irarsWkn5/yZd7?=
 =?iso-8859-1?Q?q5XZruNgEijDama4b0UpSANgNNQHp7jn4oWEJq3QMy14N+5pOgt7Ni/UkR?=
 =?iso-8859-1?Q?kYHHKUzu7195zVUBUHnf0Jsi7H/adO1kFQxkhsgCpxyosPo/BlA7RZcxxS?=
 =?iso-8859-1?Q?ooCAH3hSkrP04RECQ+OeUx0qgxz7wwBni3HQsh7ghgHrdinqdzCxc3DC3O?=
 =?iso-8859-1?Q?SILChKxcIVLocB0JObnzb3ZXZSdFQo+T45o1u6M4u0eKZKTzimvLr4wtwq?=
 =?iso-8859-1?Q?IZWaxpEpfQL8wDfPlFoOrI557Qi5EIWNFj3dZGTS6afniT6w2TcNNN03WR?=
 =?iso-8859-1?Q?ad9aFiyhDQts3E+mpEGXSQsl4mxeGcj0jVPfVI4Aj/d9S4t2dXadG7Uk/j?=
 =?iso-8859-1?Q?1Hk41WGL+D4Czn8Kq1CJN4Ekwq2Ss6kL5pXM9EXVf85osuU4zVEGCsEHhp?=
 =?iso-8859-1?Q?OsTNtSOCHGCyeEq+ysB/rwUoVjigFSPlGJqP2joiuDrmuICUxKN1k5SdG0?=
 =?iso-8859-1?Q?28iXrrIjo45yydgx2eEumiDUr/2z2wtNk6BXAVjQwsEpjx5gure/oPtDtq?=
 =?iso-8859-1?Q?+2t/dNXAEMr2btVbIfMo8f02n6yC7XX3Jvooj/kStzoQtL2yEAOlm32/x4?=
 =?iso-8859-1?Q?m/HU3yscFr/ffrgx1uXFXD88hGV78S6nlnafNVlzC0vxomYgLfFdPnCuxy?=
 =?iso-8859-1?Q?zBMDuLZiigQo824t2SoYCWY9c/O4MIorMaJNVvihxxYPQCMkGGKQRGHTqg?=
 =?iso-8859-1?Q?aMhQjA2Yb1+qQJQhOihLWx5c0uJRTewKLXLyZjUAM3DEIfoykQD/ymmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JdmasYS7iGBVU97CLQnaAeuHTl8LxKSU4e6JIWvc6yRlus5+OlYqZv75st0MeuvvdIQshOvmdVgDBKPjRbDhnR9pbDQ5Y7y+ZDwSbT6U6HGuBwrhdK2qhRoweC8e2wnxgIksgsdoPoxhaT0YYSRxI27oWIra/Pb7X88cYCNVKRLxBxuMGPXLZlH8sFKhpmvGf0k51Bw3CZgFgydLirM2iuPLNkr8DwE1un95E3mOUJMMx2fk2FWDLlqhHTU2UIpNlyJnDjVPV2rtDQzjBZTNOg/tFTe9pjx7yQQink0JwWTXR8eKaQdzp8WTwGFz7Kti0BVwzxpJBQmoLELLS2YaMhtu/mRKix5uleY7/a8L7970VnzkpiipHNidFfOD+m9ZJ5FTqEzNsQbopHvNI+dg0EZ5SPd/Xq53veGS8wmiyIVNpF4ktq+q9BgItb1aWgtyFoABk6RAWM2pukKevfYItR4da2QAKnHxYlumDkp60vU9AgJa6MrScM6NNRI5lhBoy5yESFkBPSccRGe1qLi6XHUG7QFjHHAG/+3Kn6ZRvq8eDNdxaUnpVDYyrjgO1UC66Ipw/FRW8MzZdN5aoKja8wkjvJGy9aMoGXktx8IvWWAE0TQ27RU4kVLoQ80EIhRl9SCGQrmO2MRRbt/mun7EmTNxbWPla5Q063k2ZLnJr2tOCpjW6m/Npq8+zlmM4QrsD062QU/5b4t2FGJjCDAkzBlHr1gu7OI/7mbu96ypXR5eQAw23xg1CvZ3AaLlxet3mTfQtZ/C4bRS+G793ofTt/kwqALLqrWC7ofVG7XXSJeGVJg5s3slRaOav4dCbYeAjCsSq3CCn5Ao7T/anJ7Cx2wTWWpDprhxJf4JZrbQ03OQJ2hJsoB62qN5TJWK7rJ2JJU8w6XZ8aLAyqm/QyHwBg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc16f461-9128-4543-4001-08daf8334bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:02.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b5VnQuLxL6TZ4ExTADE1G3JYoV43c9Zl9iFxLeHEevsrB84HnIsqMwLG6G3XjBpjxYDTgjq6jEgcWsFjEMiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: J_IabvZ1YcMTCT5GkfSuJP7gX-Pwif6D
X-Proofpoint-ORIG-GUID: J_IabvZ1YcMTCT5GkfSuJP7gX-Pwif6D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Andrew,

This patch set does two things: 1. Clean up, including removal of
__vma_adjust() and 2. Extends the VMA iterator API to provide type
safety to the VMA operations using the maple tree, as requested by Linus
[1].

It also addresses another issue of usability brought up by Linus about
needing to modify the maple state within the loops.  The maple state has
been replaced by the VMA iterator and the iterator is now modified
within the MM code so the caller should not need to worry about doing
the work themselves when tree modifications occur.

This brought up a potential inconsistency of the iterator state and what
the user expects, so the inconsistency is addressed to keep the VMA
iterator safe for use after the looping over a VMA range.  This is
addressed in patch 3 ("maple_tree: Reduce user error potential") and 4
("test_maple_tree: Test modifications while iterating").

While cleaning up the state, the duplicate locking code in mm/mmap.c
introduced by the maple tree has been address by abstracting it to two
functions: vma_prepare() and vma_complete().  These abstractions allowed
for a much simpler __vma_adjust(), which eventually leads to the removal
of the __vma_adjust() function by placing the logic into the vma_merge()
function itself.

1. https://lore.kernel.org/linux-mm/CAHk-=3Dwg9WQXBGkNdKD2bqocnN73rDswuWsav=
BB7T-tekykEn_A@mail.gmail.com/

Changes since v2:
 - Squashed in __split_vma() definition fix, cause of build failures
 - Included fix for invalidating maple state (adds a patch)
 - Remove mas_set_range() from do_brk_flags() - Thanks Vernon Yang
 - Converted nommu to the vma iterator (adds 2 patches)
 - Boot tested on s390, arm64, m68k nommu, x86_64
 - Checked arm64 failing tests cases against new code - Thanks Mark Brown
 - Check for write errors to the tree in damon test code - Thanks
   SeongJae Park
 - Fix mas_prev() and mas_find() state handling (adds a patch)
 - Fix mlock() conversion bug reported by syzkaller - Thanks
   syzbot+ea4b1a683ce48cd567b1@syzkaller.appspotmail.com
 - Remove unnecessary vma_iter_set() from userfaultfd conversion


v2: https://lore.kernel.org/linux-mm/20230105191517.3099082-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20221129164352.3374638-1-Liam.Howlett@=
oracle.com/


Liam R. Howlett (48):
  maple_tree: Add mas_init() function
  maple_tree: Fix potential rcu issue
  maple_tree: Reduce user error potential
  test_maple_tree: Test modifications while iterating
  maple_tree: Fix handle of invalidated state in mas_wr_store_setup()
  maple_tree: Fix mas_prev() and mas_find() state handling
  mm: Expand vma iterator interface
  mm/mmap: convert brk to use vma iterator
  kernel/fork: Convert forking to using the vmi iterator
  mmap: Convert vma_link() vma iterator
  mm/mmap: Remove preallocation from do_mas_align_munmap()
  mmap: Change do_mas_munmap and do_mas_aligned_munmap() to use vma
    iterator
  mmap: Convert vma_expand() to use vma iterator
  mm: Add temporary vma iterator versions of vma_merge(), split_vma(),
    and __split_vma()
  ipc/shm: Use the vma iterator for munmap calls
  userfaultfd: Use vma iterator
  mm: Change mprotect_fixup to vma iterator
  mlock: Convert mlock to vma iterator
  coredump: Convert to vma iterator
  mempolicy: Convert to vma iterator
  task_mmu: Convert to vma iterator
  sched: Convert to vma iterator
  madvise: Use vmi iterator for __split_vma() and vma_merge()
  mmap: Pass through vmi iterator to __split_vma()
  mmap: Use vmi version of vma_merge()
  mm/mremap: Use vmi version of vma_merge()
  nommu: Convert nommu to using the vma iterator
  nommu: Pass through vma iterator to shrink_vma()
  mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
  mm/damon: Stop using vma_mas_store() for maple tree store
  mmap: Convert __vma_adjust() to use vma iterator
  mm: Pass through vma iterator to __vma_adjust()
  madvise: Use split_vma() instead of __split_vma()
  mm: Remove unnecessary write to vma iterator in __vma_adjust()
  mm: Pass vma iterator through to __vma_adjust()
  mm: Add vma iterator to vma_adjust() arguments
  mmap: Clean up mmap_region() unrolling
  mm: Change munmap splitting order and move_vma()
  mm/mmap: move anon_vma setting in __vma_adjust()
  mm/mmap: Refactor locking out of __vma_adjust()
  mm/mmap: Use vma_prepare() and vma_complete() in vma_expand()
  mm/mmap: Introduce init_vma_prep() and init_multi_vma_prep()
  mm: Don't use __vma_adjust() in __split_vma()
  mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
  mm/mmap: Introduce dup_vma_anon() helper
  mm/mmap: Convert do_brk_flags() to use vma_prepare() and
    vma_complete()
  mm/mmap: Remove __vma_adjust()
  vma_merge: Set vma iterator to correct position.

 fs/coredump.c              |    8 +-
 fs/exec.c                  |   16 +-
 fs/proc/task_mmu.c         |   27 +-
 fs/userfaultfd.c           |   87 ++-
 include/linux/maple_tree.h |   11 +
 include/linux/mm.h         |   87 ++-
 include/linux/mm_types.h   |    4 +-
 ipc/shm.c                  |   11 +-
 kernel/events/uprobes.c    |    2 +-
 kernel/fork.c              |   19 +-
 kernel/sched/fair.c        |   14 +-
 lib/maple_tree.c           |   19 +-
 lib/test_maple_tree.c      |   72 +++
 mm/damon/vaddr-test.h      |   19 +-
 mm/filemap.c               |    2 +-
 mm/internal.h              |   79 +++
 mm/madvise.c               |   13 +-
 mm/mempolicy.c             |   25 +-
 mm/mlock.c                 |   57 +-
 mm/mmap.c                  | 1020 +++++++++++++++++-------------------
 mm/mprotect.c              |   47 +-
 mm/mremap.c                |   42 +-
 mm/nommu.c                 |  124 ++---
 mm/rmap.c                  |   15 +-
 24 files changed, 947 insertions(+), 873 deletions(-)

--=20
2.35.1
