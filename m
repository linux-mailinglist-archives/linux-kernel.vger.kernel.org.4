Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6B652398
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiLTPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:19:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4FB1B1E0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:19:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDIxAG029577;
        Tue, 20 Dec 2022 15:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z87kKHtiLGGkcYA8to7oAvBXXhY5AT3gSrE3YF/iERc=;
 b=y+atE5LHckS3sgI56tBZdW2gSvjHgwP5Yzv54QQplc0ZqR+s6KsTJmqfY92hAiLHXxlf
 UUY3AYzu/+K5HMToqimcJLTxTk+xxi6BgkMG7C4SfICP8xQeljwp0pLMY0KDgCy/CP96
 olIDNpImQjUGC9R9ZGnMnhHmb3unNHznxRJ5DYIkRihHcaSnXmPAoXPIpx2Z+IsQQAKr
 xAcIh7/XJB/N8+TGDTFEu96D5xAAydlglMOHpzKqWfCr5BwrjyrWHNghj5aygW0+htJA
 6pUJEx7PulHrJTVLt6QKoWzbqzsDwk3TCShCkaAr+tzH3hQ78o8Rc9III/4WD370fimI mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tqx4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:19:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKEOJoY003403;
        Tue, 20 Dec 2022 15:19:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh4757cax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWBdrL6dEw6luYwt0fpCtTFueLmCCkbMdxCOn9oNm3NJaAMHwJxus+p2jlNtz6z7kxx+Q6cvCrNsZs38najUXl6UwglMl8AjaX2Gq6LnFJjNJybr7nKnM/gkavLVrFMb1Vl/r3eRP7PCOoAbqgJgxb/CLnDccXoRBWCrNZMhvl5NYgzsQ77qXsizUOOx2/N+l+1IN/I3qjHhmutCN27CLUiB/TET2CT3ZtULpSANntOy4bvnGOztLAacs49NiTVJB/7jJom08H4b9+7ukwpdDSPKk1KelTDPNS2uAZZC5FBLHMC0zxrVs9jeqLUnxhAifMsxLgBhz8VtRJAFQIC5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z87kKHtiLGGkcYA8to7oAvBXXhY5AT3gSrE3YF/iERc=;
 b=XSI4eFej8qZIsicQ3Kjw8V5Wi5lhVZSXkLxm2pr0kDiQ9rkj1f7/SpCtHERquzjNsf12BlAcsbH5OlqTtI7R8dLdnlrSCM1MHbu5+kixFSxRwc6y4IfE8V/clhUTpdSZrtwmBXVe4MYW6B1gYWVNEmEYBs2pk+YPNi7N7WPlRMVwSWi6DDXUdbwubaE9flcVi1RzWfxF4TZN4i+tnGIokLgAP6qPjjOaB79zJd6n7JLGP6ChXJKyGe211KKfcH6B9qx1refkKECFx8mVGrkd4vxeq3m390YWOyjF/BL7eRZvkpowe/uuV6Clac8IhYV1unNZKjm6XFqc056gsvPDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z87kKHtiLGGkcYA8to7oAvBXXhY5AT3gSrE3YF/iERc=;
 b=O9snbvWCUXRC9beY85qNolXCXab5U3Qegqmr1q2j21dfreP5N1rObi+kQFV2TqlX0sKnAwKDWH7J4NxlKgA3Drk7eTHzks0sKBsYequKpaRj7qgQeRkFcXayoC4duHeUcjckrWVHFs500VoB3TIbK+nnUN5b+7EnZys3vXlv+kM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 15:19:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 15:19:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH 0/8] Clean up and refinement for maple tree
Thread-Topic: [PATCH 0/8] Clean up and refinement for maple tree
Thread-Index: AQHZFHymZLd/2q9w10GGkrv5FXDz1K5248kA
Date:   Tue, 20 Dec 2022 15:19:08 +0000
Message-ID: <20221220151858.c3bj33jzwjxa3wct@revolver>
References: <20221220140829.1665432-1-vernon2gm@gmail.com>
In-Reply-To: <20221220140829.1665432-1-vernon2gm@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB7483:EE_
x-ms-office365-filtering-correlation-id: cf633bf7-eab8-4529-cc71-08dae29d8a9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZR/U+n1jFBj/vJmR9GMja6eDrAs+1x03vXEM+QWCWJRPS7XpkeVGA8qwln2TXTFoZW+UzIG2OG3sx3HNvjfjaNOvQt9C8GlqSOSMDF/LuyFbTEHCCNTkHb0HumvZEjHdbtSOFJ1EMbrcJ+5Mp8qUJjSUudbCvb8vInSn2bJo/iFknTcfMvZYzH4PP+nqAO4fYV2hK4Fj5u+0LSG391/ZIwGwH0TVqMcjNgsztWNjQ6vWe0vesvxB6O13H1ucf8nSC37J2k3DptmPHd298f5EojOWSf9ObU9hjjP+g/Bj3hW5QCyjmOYk9pYNCIhXfqO0bMsAfbN22xv11cc6Zew4tgkFDhEP4Zaoq4Xeb4pxMEV/q101l4XHUDm0oEsY+RrWoqs4h8by1CQc/02lF854K397QKfUvBrT/eBmxXba2UxeJiWq5Bdb16SE6vPshFxtkYpSkoakxLmHZ7Kin1KQWlNzAKDIayQX/JgZbNsizilZ5jtUW/etTjAiJnPDuwrj8wWU/oFSEJ0vReq1e3pLnSPHblrBsv/ol730/6qDUrgJspzFvaqy+vJwfCgdtOISX9nn2fMmpZN9TEJqaecwVGF3KE5/mpXrWRW0nWEfFMkw8TbbVCoNS382vwlEhdUXFEjfVuyeI0sJSjG+dLiakr3xmNftkUdSVcmBBX5IoH+OTkjLrF2hC5Ib3MA0mEC4ho7h0KVjU9H0HvqdIYNki6XauwvrLAoYBtKLT06iPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(8936002)(83380400001)(26005)(6512007)(44832011)(41300700001)(186003)(5660300002)(9686003)(2906002)(478600001)(6486002)(33716001)(966005)(1076003)(76116006)(66476007)(91956017)(71200400001)(66946007)(38070700005)(6916009)(122000001)(4326008)(54906003)(8676002)(316002)(38100700002)(64756008)(66446008)(86362001)(66556008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ag+aZqzG41ULQuEW6iwAWUQOCdypHvxj4Vp7u2pUW/A3vnjN/RjRrQMeJtSH?=
 =?us-ascii?Q?jSDVIau1cyDYMhCGKzlSNVpI2RxljhF+U1LCHPJ1BwevAQOJvpzxRqxEdyjP?=
 =?us-ascii?Q?7Mng3yKUimgXBn7jE7FUFYwIqw314hwRKYW2xEL6wUn+yv5/mrL/skTTD790?=
 =?us-ascii?Q?wN6HtSyZKMuHhIQV1Ufke1QWBTgXRT8jqv2q/uf9iVmC2WTHkwNglAiuy+P/?=
 =?us-ascii?Q?WShAZ3lgLwu0+zxyYr3bwtijXxZoaSL9AWv5HA0q+xMxCJmswPZjCI70saR/?=
 =?us-ascii?Q?J1ukyBZMu0n0lzaW4nSZnkOoQCIey6AQhxbhcDPltRnGEX+uPDP8VA+kXP/a?=
 =?us-ascii?Q?yRfDNwjTy9Kg71VUXz6w9e3oDU1a/WvqSa6hTJ83tw83AfiZAtDCN7TOnDf9?=
 =?us-ascii?Q?CC4FAi2vfV9OLwjK9MAYBu7SEhAKLS+643PLV5PlaVoqMlWlyEc1astGnLBj?=
 =?us-ascii?Q?8Ek/cfBXq+fbGlfYfbVwtuG+shLsg5pYo68aHSM7LJHKSS/JRiUXX1y8szgZ?=
 =?us-ascii?Q?bM4/eRH/Py+CW7BtBTzXH1/PdJmpkre2uoqtrnFjpS0/wCPOa6Gy9hN8PuCc?=
 =?us-ascii?Q?9zebSnnQF/i3knesEJW9Wjib8CKjQV91KvpBbuV+1nmighz1v6ZcRx1Hq3xS?=
 =?us-ascii?Q?NqXdrAlgxBjGTZUdfaIFUi6g9gJYRQ3pkJ5hmgxt415R1koTXMG+Ola0ayv7?=
 =?us-ascii?Q?K47USuCUC/MSkoqk97IaivQXb6bYqhR4d/PsLQWk332IaiCJTKbKjGWmt2Qj?=
 =?us-ascii?Q?uUTLHdFb1UTUatViSR2Zj0NzcMR9RNAME0o5I2BVuNfHMJbMrXk/Ef+tsWST?=
 =?us-ascii?Q?mnKmkJ7KrqSLLLz+Qk/8X1vxMt66DVNMYRIXSvBbYyTLHmRP/V3fhsAKTCFM?=
 =?us-ascii?Q?t6Xa/IWjm2uC9hQ2G/8PZxJ44BO25/wYgiR6HZPi7nn+Tk6xNSRFadAF+fhE?=
 =?us-ascii?Q?6htZBq4vAkDwn88xC3/UBeUVYlSIVHM1QFCv6nI+ueC7bGxQC3wlP+sEOyop?=
 =?us-ascii?Q?pryjn25MEoMQBDQ9N/rulPVzNg43/uIDUvvx71yuNIgz9YJ0YRGR2dPI+9m/?=
 =?us-ascii?Q?bvB83v0zFwOwmGSKGq3ksbVCELv2pf1r00pXPtKzIWpWe0DfRGqAm3bfbOp4?=
 =?us-ascii?Q?IaRtbB0bcTIvkUJ2pxBR/YwMuUPa8SBJe9m4VJmOcfitJf95hwq/lmLUos4b?=
 =?us-ascii?Q?ilpGs0YNIAeVHFaSRPeh6kfNrTmZ50sW/GXpICdbV6angB1yVnriENnixggn?=
 =?us-ascii?Q?OOAHViJfLGMlgcEHHlA6DVcH8pVW2LNDuusrskn0Oe8GU8euChtSLSCXNRdQ?=
 =?us-ascii?Q?uEgYfG+m2nxNRrBCsSHo2jrl5Qpp369mBHqh1r0TfOdzc3u5ehQX7aXvVhym?=
 =?us-ascii?Q?5w43vQyXOc+5VJ3/XNPp/jlLJ36UhNpyZCGhX8/iiNLi8qaFhzZxkbrogMER?=
 =?us-ascii?Q?PHHG8ZDWN8Y71Ltd9mTorPlCZ5cqcTw80UG2uTLr+fhtnkRw+Q3tz2jpw8a8?=
 =?us-ascii?Q?M4YQiesel9+aQ+qvcPu9RAEQnVahZr9ERUIDStgA4ok07wkcvJsdU6/0VfNv?=
 =?us-ascii?Q?Bk3Xgmpa1RhYf33ffOznpRjJBCX6Iy3WrldFat82Dyft6npTZnRMlWYgim8T?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27B852504A6DC549BC02053421620ABA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf633bf7-eab8-4529-cc71-08dae29d8a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 15:19:08.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0oWV0bZ1t3TtMiw4uQke6xhiP2WAWSHQ+OkcDIyjI0EAhJuVi064G9mhTslqgEH/daovmHH/7d8DzVazRmGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200126
X-Proofpoint-GUID: 2lYEO1qOdxKm0_fhn287076s6GxMQ708
X-Proofpoint-ORIG-GUID: 2lYEO1qOdxKm0_fhn287076s6GxMQ708
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [221220 09:09]:
> Hello,
>=20
> This patchset clean up and refinement some maple tree code, a few small
> changes make the code easier to understand and for better readability.

Thanks for looking at the maple tree.  It seems somehow this cover
letter is detached from the series found here [1].

All of these look good except 6 and 8, which I have responded to the
actual patch.  I've indicated below which is 6/8 and 8/8.


1. https://lore.kernel.org/linux-mm/20221220142606.1698836-2-vernon2gm@gmai=
l.com/

Please add my reviewed-by to all patches besides 6 & 8.
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>=20
> Vernon Yang (8):
>   maple_tree: remove extra space and blank line
>   maple_tree: remove extra return statement
>   maple_tree: use mt_node_max() instead of direct operations mt_max[]
>   maple_tree: use macro MA_ROOT_PARENT instead of number
>   maple_tree: remove the redundant code
    ^--- 6

>   maple_tree: change return type of mas_commit_b_node()
>   maple_tree: refine ma_state init from mas_start()
>   maple_tree: refine mab_calc_split function
    ^--- 8
>=20
>  include/linux/maple_tree.h |  6 ------
>  lib/maple_tree.c           | 41 ++++++++++++++------------------------
>  2 files changed, 15 insertions(+), 32 deletions(-)
>=20
> --
> 2.34.1
> =
