Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4A66D471
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjAQCjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjAQCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3933301A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZNR011743;
        Tue, 17 Jan 2023 02:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=J9LyBwxkkqzt4tmaXLntDWKi0l/2cOkfc3bLS+7zKb4=;
 b=Im59WIo5gnnasEeM+bu9YpacvUKLYf7h+GgBrSlOadBNUXCZXDWOynnsNlGm+jG9Irpa
 ow38G2ynrauyVYZhJpcQokaeOGuRMqfNDt6CGn3dPf+R2FIU73mmqC52LiHA/RwK/gZr
 PqkPkezz6YbSTRPFCTb0dgq+LBTS3cpka1rSXcQZs5MVn9C4SB8dDq1zTuC788CVz1rf
 Z/LjlQHhFeutNvdxiy6doGboGslvjPYuykn+VWIGxhfDoBwLEW8zKzDAJiQ4YGKgnwTa
 v6zXpZzOlgki6McmQ40wkY69WlDeRahYKPiILUoWDerTQtykiJ1x8Z5QxoyQmlR1Sswp fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00urd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCQ004918;
        Tue, 17 Jan 2023 02:34:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH2WUy6t2wwcJWH1NgCppryc9/hqqhLNgZ2uqAuWR5gNmEt9r3BHx1gox3i6ZJWDG1XVGlgPQS8SI8SLyJfVeTPg8zbtSGlYCbp9kySVN/9rX3Opfqi1Y3DFD3S0w+wgbIk+1TtUXGm2FSRarBluJR6EWAPQx5yVw3ojud+p0+s/HNJBq2eZKQMN/+ZPKlbv7zUKRf+V+5aLD2mQSYwy1dB98tMX08mHxty5wAvc6o1zTJ+oc+AhhdKcYU2A+hl4Lwd+nlUSlWMRUPFsPTA+HSJCPC44NKAGn6NgOmU0SXWvlXujiv6XAn51zZ1npRNOMI468X8eDnpYXrdzStlBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9LyBwxkkqzt4tmaXLntDWKi0l/2cOkfc3bLS+7zKb4=;
 b=Na+LPML1+fZb8JRCamYy5Phmo13jAS31H+7wbLXFOYDqkb4+phdWTjmAp4skDROhrAQNpQRrrYXidDELrqgMhWZz5/8dGSBOhb/RWH3QuALbDSpyRH7QRkbAbvGXQu/fy4C2x6ErvRUETqON9/75mu/pJGynBTbTxXxlaPdVovDFvILp4awpVIVotMB7z118H4QuKLw/Ck+lgulTJ3JljpBhy9P+v6O5EXbiTGZM5dgfjNLjtB6xa17udhmBP2nnDaAyB3GE47OGFVGiZwfbO5a6n+N3+hpaKx8gL1mivlVGI7NPaQbvw0C2Uv5plKXqRpd7JSry4McVltSxeSyNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9LyBwxkkqzt4tmaXLntDWKi0l/2cOkfc3bLS+7zKb4=;
 b=q7OsfUPl4HXcNLzs6mmPw13Jpjtag9Z1wbec4FVrE7a3/kdL3jiNV98UgqKPRX15tBeYWg2J37dYHpfriVnvCvl10AG8hQD/i76JpQdnB788Sadp551hbRxgvTI6glV3WEL8enr10nO2izH3OAdwKD4w9hCmRxw15Qk62mvUF9U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 32/48] mm: Pass through vma iterator to __vma_adjust()
Thread-Topic: [PATCH v3 32/48] mm: Pass through vma iterator to __vma_adjust()
Thread-Index: AQHZKhwzSFQ1dm5OBkatwyWkQUBhcg==
Date:   Tue, 17 Jan 2023 02:34:20 +0000
Message-ID: <20230117023335.1690727-33-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 226435c1-e196-47e5-7a12-08daf8336b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVxCgYPNnl9dMpuz88KXuFrFx7tORymp1MxqCLrkcK7rnqF5eRi92xKGOtEhqADaMd0crq2Q+r3RuRykkMfkIe06zd8/DijImIWwXif1SVyIF+hi99DXF9Cc6ykGWgLvEcHuu6QCgPBSKAgpOxq/V0++OQOgMfTnDfLNWxcdpebY2HMbab81xSwFHSTl1cQvuQokQPpXUB92Poj11wvg1Ek+FvcIiJaNxtGjG4rnRfjNI5slhMVL1pGV1i74gtIb+E4r8nNHHVteF7F8nN/o+fJYAqyXEM58QkbDhTcTICr9Bcoxjb0y7qF6ZG6aPaBf7LgexN8JvPu5eYYdkatXWY6Hs45O4HKamALuItNRy6UWUcwe+HO30M5ccZ7AC94f1XH5/z/rINdjQspndXbfDUoqiJOwE49MtXm7dQf76gWe9QUJzAk4wDR7/NESstZje0eJJEVh5xo9/r4UsfJSvbcNtjNkINzAAJlgWrJ7pyJTITiElIvOt6REKkedpJYoUYUfOn4Kc8kQzRg01yxzX2sVXExnEapxekKZsVRvDmXeUnch/QQ9eTvREqHUmoSWRxYLs0IMO5EFiMVyI+Dj/r7o6xgSFt3IFkytPhKRf6knYIUDYfRZZgZaioX5JA4+qvAZQxsKDs7p9bxluJGRDYkw+Fi+bTdDZ44fTgBPVsZqWfSPmn/aK1JtjBdF/mY7xSItFvV+68eBYlp5ZWtMpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/aggLtcVgPZ2DDhE8jQns/Th3l2oQgMejy9k68nhC65l0NROna3QEu6hLZ?=
 =?iso-8859-1?Q?F7sPLTedpmestu5o4qPx537gYrx8p8I5G7S3mOToUujtrzuqGon2ynPAFc?=
 =?iso-8859-1?Q?b4LAvI92B+pCME7YT00+OcAMGo7BTMpy5/ZCRe+oa+adbr/a2I7iUztVrA?=
 =?iso-8859-1?Q?L+QXZiRyHEq6Ms0eN1n9FkjsGF5mlSsMm0lPZYs7A+gU/ZdjUW5/bAGMKu?=
 =?iso-8859-1?Q?uyKyb/WnxafCIkeH7nSVS+1Q3jHRwNeQFGdzTpiHRgTmp4r7qFL7lC1j+S?=
 =?iso-8859-1?Q?LSndVmYllzPIoIk1aEuXS2UeTo2hBkpXhlRcljBK82qrdPo5k5NcZKnVXL?=
 =?iso-8859-1?Q?iJVAsYs6yyvuTD468hKMs8zfprMebcStp7c4KS4vAGYwT6O6LMwbUdDCLp?=
 =?iso-8859-1?Q?26RzqJGR1p3p3DJUqQ/iZX1Vvym6M6l/pfJFt4Ghkj/Uz7pykgOJv5dKSm?=
 =?iso-8859-1?Q?ki07oICZmWZKIcre/ibwgVlBlJsKm4mdmvNIgQC5f66NGESrFVsQtm6RY1?=
 =?iso-8859-1?Q?jmcH5DzTZZaYXFZ3K35CzsNQRWntJnFO5q9GlQr81ibuVrSXHt4FnyzswJ?=
 =?iso-8859-1?Q?uDrlbcIMKMnHgbmM7tt3+KnyVQAkZCTcsZHGUU2a+jt41I9MUDTX8uycAF?=
 =?iso-8859-1?Q?mfaXNC4eygCdS1Z0sJ7+0zLSaB4pSVoDSHh53TLObWgFqBS6JOCMl896j7?=
 =?iso-8859-1?Q?+X93/Tdt0fbYj/ImaaRSgOU7KPni0Eh/f3mtKYVBSwmzHcOTCgF/NycnuV?=
 =?iso-8859-1?Q?tCWdjfGR9wIEkqAlm5N2+y/M8ssHoFkdD60zfA+BA5pyFoD7Kg9tHhNbM5?=
 =?iso-8859-1?Q?vWSpeARTJ19/dCh8SBxvu0FgFB2p32nF+SetNTKgjUN3CiOIDwOMqv1LTi?=
 =?iso-8859-1?Q?tSMmpFL9pRfBWTtx2tAPg/6NS7h1tYMW2fD/GAqT/R8yYS1b2DDqSQ82yZ?=
 =?iso-8859-1?Q?jY6kWWSsfGxfoJFtj+ZWqAj8qnmkdO18C71g9vfDcRtYQ5xUz77k2I4RUq?=
 =?iso-8859-1?Q?MYxD5ZPGBJ3XCKHVjwnjNyzlJO5698TpaizUpEEnDc7/ppBQeoq+Bj4Wv1?=
 =?iso-8859-1?Q?tmjjWKX5/I9RUr41eIzaHOsHto1IwSjRGn+2V1ex8Bm5kPEXNE/hwOJ+iG?=
 =?iso-8859-1?Q?oVVsDdwOPSDNwpACI9SesU+dFJNl4n1xEOa4BZUiFmdeRQx64X4h6LO+Be?=
 =?iso-8859-1?Q?wQkafLc0OA0ukDEU/576eth83cF5fm9LlA9amwhDuBkb8cDOzvgbbZXZ4F?=
 =?iso-8859-1?Q?W2q6gwQBaSr6g2wJV1GdiHskjO7HOvMvQD6t3wMavIsZEI7rt9GaeJ5BDt?=
 =?iso-8859-1?Q?/5LU5s0IA3Cbz07Wk4Py7O2Hx8pNuqtthXwbS59JiV91ZjUdyQdw07sGCa?=
 =?iso-8859-1?Q?ZRjnw/Z0Ftm6WZsw516XR+6fBTwM/GAqFh79LRiyZW3ZMm/PqhTlFLQevI?=
 =?iso-8859-1?Q?TK5+Gp5bcPtObqVZVlpVjkzzF9AugH7fCmYbtg2slPfbL2/33H8nKBDwWM?=
 =?iso-8859-1?Q?/4bZ+QAQPiXK3agd9F4wpcRQG7tbOUJVRULPTQZJuBmlQLRwARNNhYoe+q?=
 =?iso-8859-1?Q?q4uguMtCls+C0H9785kquNE6LsDgKRc2yQRsiuzOqnMPJIhuZy+nNsaeXa?=
 =?iso-8859-1?Q?Cz9NNKjYkC+fdLqwiV7KW6oHZra36/eNy4u3FjlTIS5nDtHCFGKoXEIw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v2C0Ks2eZMlnXyn5UVgFdRSPv66hQbRIQdAnItkuVPYQo4adcEQoPdL9pSbrqqhNm4GctGPOaTD9E1gFjNvnmi/UxG/XWzPWme/BRTcUFIZbeMZZM6FpflNBpsTMWkv8825I3WL8qjeziQ0YFDyex8UytlPBVK/fPVrV4o/te6K7frsfq3aEs2N1MMM4P4K8olx7YARqVHs23WJzASQrOT7VmUTn2heLx3IiGZD0ejYTYgf8wV8OgHiID7hkDIgpqPrY1Tc122b6pOVTHw9JEyI2CA2b1vmtmU0yDnd7dgdUK81C045B/OmBe9jB2iKbakdvAFC0UfbARSr54Z48S0VW0fuByy5493GWXUp60ABDkMSsUwysBh5BBw0JgeYzfHrzl4yTJLVeZcWy/pBlWFVHZlefvaEFjFe2iHTbeUe+2vV3ygc/sa51aKgS9B/ClOMBwmyW+TdO5QCNNNnoqzyrP9HKBo8w5mgNFLgP6ZwH2Tx7Bej/L9PizakvoQFJIRIk9RBom6GUiXpkoJX95OKwErdwm7wNAXW7qkm7OkmY+iCM5BMY/uWtvS3BMR+hVuixPAe5i5S2hfrzfT9t+Ovt2LCQHO4onz9JxOQJHM4kYMZ4Xo0v9LJceCQDSXhYh4VKhXey2bTPxvHpcLxXizrf79W3x3h7CcQZfBgfuaWXRA8QvSxGiZG8BrD8Qwp6D6Vtv2/HvHCaNx21yrYBQw69AVPjbjtxN/Gf/Fll0BIOQRsIRUlDb2Wul8+MsNGoyBCk77GCoUMB2ArWR+SmwYVNbNHVmNn6wl2V97AUSVSjfbbC/JQvsfKiOuxcjg4jPv26ne844XUJSxTtSb6UohOqPdL81LCuNEnDtwJfr0VKNLpW2rNqjjz4l4WMy2H9d8zrnf3ixvX/zX6/vsi2Rg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226435c1-e196-47e5-7a12-08daf8336b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:20.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9t3X1bWgSXK8pP5vSqgJgYt1czJejihf3OCGQFx/IchlfLpqA+OLQj+UQ4jPnFg7Py6AxtbRGmSgn17LYhpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: dNJcL46CRIgUqF85QEqjVfvUfCW0nPmL
X-Proofpoint-ORIG-GUID: dNJcL46CRIgUqF85QEqjVfvUfCW0nPmL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass the vma iterator through to __vma_adjust() so the state can be
updated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  6 ++++--
 mm/mmap.c          | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 28973a3941a4..294894969cd9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,13 +2822,15 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
+extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
 static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
+	VMA_ITERATOR(vmi, vma->vm_mm, start);
+
+	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index b8e8d5edb5ed..4b4d7b611c3e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -579,9 +579,9 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
  */
-int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand)
+int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	unsigned long start, unsigned long end, pgoff_t pgoff,
+	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
@@ -594,7 +594,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -679,7 +678,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -725,7 +724,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(&vmi, vma->vm_start, start);
+			vma_iter_clear(vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -735,8 +734,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_iter_clear(&vmi, end, vma->vm_end);
-				vma_iter_set(&vmi, vma->vm_end);
+				vma_iter_clear(vmi, end, vma->vm_end);
+				vma_iter_set(vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -747,13 +746,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_iter_store(&vmi, vma);
+		vma_iter_store(vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(&vmi, next);
+		vma_iter_store(vmi, next);
 	}
=20
 	if (file) {
@@ -773,7 +772,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(&vmi, insert);
+		vma_iter_store(vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -819,7 +818,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	vma_iter_free(&vmi);
+	vma_iter_free(vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -1013,20 +1012,20 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 	if (merge_prev && merge_next &&
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
 		res =3D prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					end, prev->vm_pgoff, NULL, prev);
 		res =3D prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
-			err =3D __vma_adjust(prev, prev->vm_start,
+			err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					addr, prev->vm_pgoff, NULL, next);
 		else					/* cases 3, 8 */
-			err =3D __vma_adjust(mid, addr, next->vm_end,
+			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
 					next->vm_pgoff - pglen, NULL, next);
 		res =3D next;
 	}
--=20
2.35.1
