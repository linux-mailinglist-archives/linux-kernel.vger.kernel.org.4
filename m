Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375F65F42C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjAETQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjAETQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98DC7E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:04 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITxBH029125;
        Thu, 5 Jan 2023 19:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+7lb3T9LpYIF6+7aVeQjtMBFxEGRNgAAXhAWR5tPalk=;
 b=RyLxX5L466s4dDfqEaTsCMJiOHA4z4YLZ7B2PwG6UInejebP5G7p/EqLHGXu/LbAseYh
 kLNHbVVcQ0U9mctWiQXaNi01/4Ls7hRLlUrRPJziH9ebzAYIB1hl5Dv2SiuU4rKhAXEF
 dHNmgEG3exYdSx7eqANw6McbmUbBItuELx2F3pMYUyMYd6LPy7BlMnIdNR4KSgzvtHWP
 yngigmBXj23k5cXor4ooCv6MZRjZVhQTRByKPThQ19lHWvuRxVMT4hq//Pq5gGXfsZwl
 qiK2nSCu1vJn+WfSn/otmN9ISXQtC540mJgifvfpM2vNfZwSpAonXdnsqKU1dT2jWwV0 IQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPE023380;
        Thu, 5 Jan 2023 19:15:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elAqGtikCt10XY8Yv0Qy5uZSt0dSYMy2bJP+Yt8uap9AuzBJ5JZVcCkJWNrOtv3QLrQ+jCurMYmMZSf8ZW1EHZQvHiKeRKxSN7AGE0zwtQm8Y8YDZ1YZy85baOtjFTbfLd6WuffV6mT4aNXiAAXLYEfq0ByttACHgR8lZEYwM02IUlHQPHmYd85j3J4olS+kSvhaLF5Q21w9xMJyXqfwgpQnx4kB7U+5/eoeiixME4pIj6CwZY2M7xOhfjzqG8om3oiWOOf5BOwJ2sSTLAQ1i69TvL5yMYClPHkrbuT2x35txYBljZrZ6V+xcXhQri8ku08DKFX6zK9oOtvwLZ0Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7lb3T9LpYIF6+7aVeQjtMBFxEGRNgAAXhAWR5tPalk=;
 b=iI6aQNTxa4nbbtvh0bvA9ktOcTsCt3a5+iPvgBMmTPbid6VVzoibhWMPr3/S/QApbHrXRRL0EI/CrIzkkNIdbQMAqWDK4UhwQbSRBrOBuRjbQ5U+uFGY7UcBtgoLAR+xnqjaY4x8QN/uDfrby/jmZ19wlI2FsJSUT2X9ueueNFsZCa9q4C2fSDoSPkRUoxFmIu0JKSC86iJeFyblM+XfdMxADSi2N7XtYbgE8PTUcvkcRQuLKbUr2+BBBQWbrPKIDqZgg+mDJ19YGjYTYPpZi4x/wKpfZ/h1Y8lqzExvDaqspJwkLjMafnEvQnW3dsf3GvX157dKOqj+qI1dmwYSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7lb3T9LpYIF6+7aVeQjtMBFxEGRNgAAXhAWR5tPalk=;
 b=KVBn2ygjACpRNE+WRLWyURGBDSjNdW/kKDOKGNKgAxYeHTXgJVUf2MY//l0gnWQd/wQqWh/pUWOWS01rHT1FoFz7MRuRuxrXBrgVgZ2SSblCeEe4bvo7UwbMinDpBkKJl7759GC2pigWT2Kudhd+TgUL5XcCzITy8474uDBUCJ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 02/44] maple_tree: Fix potential rcu issue
Thread-Topic: [PATCH v2 02/44] maple_tree: Fix potential rcu issue
Thread-Index: AQHZITogJrlnYJCl9E+hGSmbaSft6Q==
Date:   Thu, 5 Jan 2023 19:15:52 +0000
Message-ID: <20230105191517.3099082-3-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 216d829d-47f0-4f61-5991-08daef514397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttbDbQXRfOGiAHlR0bSQqFEN3T0S/tRJJ8dS2X/O67rTcwyDn/jPEMH0AQyO45mqCMY49ZuUVWycY/UU0fORM8dN5hBAbZndc23/tEALAd4bAzjb7dZwuW0aJG/O57TRLFPaQv+I1950MWOl1dBuwruR+eTprPOKFBncV93Za10z/w0P/MX/+L1jL1wL83HQs+hQ7/s2hEyhf4LR9MtrgoOQSklkJic1oMmrirGLu76bbdfSNABouQRbOu8FTpKOvBRo6zn3zv7BIog4VxEceFzzSs94qjJvzpZY6uAcV8b7RX8gFyA5lJSn89c/s7IuDRq6A3vGowgCmbyUoV0QvrY60NK0pRXKg2PzIX5VRSgUVQqqtFa6QynCS3ba0HLr4gEbC5KsXcAU5PBQZ7cNgMhrEhdUKkaZWz7zwGbGkP5RBHMqdGJugktMDu95f+EA5tUpiZr7GbMv1HgPVNdleoEj7yU100Niu5PGOIeUjspMrSr9zRRATVZSFg9c9vCFvQW8xNpU7hsUdmrm4NUXHvMkr3UG7V5oH/i5vd81v7Y5orPkTToAC0/eIvxJzcR4Eb/4WIo8/cP4RSnq41kU719RdQJNUxlsosXxq4l3Skprq0A+Y6NaV53EIqbHqaVz4RVF8KKs7fuNT1kUkHOixAm6WlMnnEjW8ocvoKOVacCOMZJns/mns21jY0Sy6XwMBgIqMUxfJviJKlFEpHWLoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(4744005)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9UtCuNq72vsdCbxB5MXttY09lA7hh0mO9Hex7J/iVOnwVkW5jHmj61hfbj?=
 =?iso-8859-1?Q?orctbcGgcrqlxtS4WYmDXuB+xmS2DDvuwRK0iniPyLyvTMQJgCzOKgZePg?=
 =?iso-8859-1?Q?cMD9gq25oUV5u/1H4g7fyDPbGdlAyaHY0NJRsjtSjaxPckSwvyVvXchduz?=
 =?iso-8859-1?Q?22EobG+ubUicEY4mmBfqMnvsDRpbgxRU8NW7sVj52YbOhCELiPGdyYn9Eb?=
 =?iso-8859-1?Q?8uy2FJt+Ix4E/U/w+I8CNn6ExOQmTmWsuMVGAZ8w9q96PzaXAegxsfpeKf?=
 =?iso-8859-1?Q?wNemDa1OYs9Cj1nuAOO2wFkr3VRWqmKAaJr3LP0X9G+PMWKIntYWGOnliC?=
 =?iso-8859-1?Q?gC6dS8MBr08hA/W6l1rVI7vM96tfsEgtCjsd14hdlmaNEHaYZMxaKNJHJ/?=
 =?iso-8859-1?Q?xGU+vZctFVd7B7F+NcPkPCNf0qfGmO6dlydVH7jUzB0mdpCRpMsNhG2k+r?=
 =?iso-8859-1?Q?TxcZkI8GUnCOLl5LJRwvu2I4FkjX8+AcPURfgu4I8amKjL0qClYUpLm/Q/?=
 =?iso-8859-1?Q?MJlcDDSusL3Y/QfybBx1ZYjbA5zV5Ll7E/0gFAaEUiort8TRtVHMHb3QTK?=
 =?iso-8859-1?Q?pwiThtumymEAIRBBUWBgWZCLSp6kn9x4Av3N0k1hAfHsdySdZwbVKH3l5P?=
 =?iso-8859-1?Q?BbcyncfKOw1bNZrS8UUuLNlYaACcFoXl8srGty2Zq7KDn7vDL5H2Tez7Yo?=
 =?iso-8859-1?Q?dBmlWJqhvz0rudRws3FnYFflw5z6/JIbolxQVeJViaVIE9DymW5zP0xOAb?=
 =?iso-8859-1?Q?+U1u/lsrqeNc/3hSGRMjmApmLzOmsQ92R2ZoA1/sdan5jOOoaleo4CrPgg?=
 =?iso-8859-1?Q?mzibNIOlqffFRtNuq8xsag2/+YHMdP4u8ZuxVyyORzZh/z9xemlJ89aFUl?=
 =?iso-8859-1?Q?k1zdshvjKLO/d022MfCBgEoiv6HedqEr/nzToaDW6brMeMTmZrziAvNtGA?=
 =?iso-8859-1?Q?coZiqZX4LjCY1Nm/zzCPr/UpIjRQdqA3bCCpeLeaYzv0AFIYC414AbW1+3?=
 =?iso-8859-1?Q?SwCTaM/1XkqzrdexmBfv9VzN3Ah28zIY2ztlSA5mSEkp22Ve8kF8y6xSih?=
 =?iso-8859-1?Q?Sv5uVpkRjjEZEsmTpCw4UcWcTVp0bsBEDLXZBSB55dCma5KNoEYCMaxnwl?=
 =?iso-8859-1?Q?Be2dMQA/gRsVndlbHYtsYG/jtxoFNEm/lRQnREcA0xTLReTMpzSjX9ae0z?=
 =?iso-8859-1?Q?x4M1UGFcbrhb/iwiWm5+EME9W+JcTZDcXWbj5EkzGbnwtDG7cAugCBlmcC?=
 =?iso-8859-1?Q?hA4nGqo8x1kBe69i17uflwwFsGTHefxiqu8XocHh3VfwqFWL2fPVOAPF0E?=
 =?iso-8859-1?Q?ijC4cxBhuk87uPiNSfCMP5cMxbBKUWOcMThDWU4cKxs26hSOLu7LSUhQhr?=
 =?iso-8859-1?Q?QslZ2ERmrfjdAUX3tHKpJuU49nl2g3/CdYoYfdynGKY6h2mFF0YVQf2bN4?=
 =?iso-8859-1?Q?2NqCXuOi6BtXsuTUcyXJAlLPVhfkOL65jQMDHqpr9iJnStWFgwkBeq4+TU?=
 =?iso-8859-1?Q?BIiwoF17wdLIUq3JAhg8cg9OXoec/ACG6kYh8+9tm32ZFGX9EZSlSy+WP0?=
 =?iso-8859-1?Q?naofQT8M17zeAhcqkNPf9uXeeiDZ5m6WJqEwD9QyocyM1gpWZ3SlK9aExv?=
 =?iso-8859-1?Q?6TYVD4NbvTfbvqqwSLPqhuMCXdWhrt5c+1hsQqZZL7sXlv5VfULlmRow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9gn2q/3AHCtt/5ZAMv5pw6Xmc0sQ32bQhnb0G8u88wSZkrcrOHt3Fk6f+v7vR3akmEfDUzIcO7sPIRX7Hhg53qviscHGROMT8Af7M5gRLWL7PapzXUQr/NFAjbEcsNzA3cUzKW7DLml3pTvS3PfnwT5ll/gPFxjrGuXVKUkSg307KKTbHAMBLxQswHur7KK2pJzQzkAzJfG2TpPMVjzFX+GCW7hFJQfctz7y0imHLt11uEYKZsCrvFH7K6YZWTDX57onOBeMBI6XO9Ey4CoLWIkFoLmaS+4Ne+R+qFlJmeOhFpGXYXAMt70a3gUsXxEgU8cxyGU2UYOuFktFqp9CaFRKcr8I0KfoFaPkix6vYLipOynr2Pwi8kdk0XpHtw9S61G1aEMO8uE/VqSOvnAyWF5JtjBgFbDUnJ8lOgjv3Kb08DcR25kDV7CMjO/JXXBKjBF5RmyuBP7ifkolL7J57kCp1FmEYFBNTwprd1whQgYDUjA2m0aVakxFK2Ftxj+E5z+5owPwwGNnuUAVuqkzUWfmYi8UYOLrBJuTm+pmmNPBMnxrJFPd67UIgsifIORIoEx438RJTK6+433yG4p4n/x2xiI67MJhcu0mUfzabcDj+neus11uOP3K+GfMwREEWscJrQ3Fj/JxSrGHnkQWnZL28iJlp2PkcNUgIQJfUihCh79YAxhabayycjUwwhSQ/oh83doPs72guWvhbB0h8Ai+D5VMfaDsUjekmKBtOuRDvqST14mQ0i9IrJGBP71qZLXZZxIKra1ZH/zm2cW/DRIn8O6jXPIiGGepLs3Wu+OMDlG01MNxMVCR6pnu6bX6ZxZlDkxXcwSXTQf0gsE3fpeUhdszpWRAp2SdbpsFv/nUy433vC+2yZgiP9aJurlBVf8o/lriKFLIvUlphV2Ijw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216d829d-47f0-4f61-5991-08daef514397
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:52.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+VAza03Y5ahoohs8rpkQT5lcne5+pkWoBEPpOBSLl12EyChZz6LQM5B3AGnlzeHHDHyth6TLX+zvTOFYWQziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: 8vpSfveJPIij3DMtR9d45aulU74LCaht
X-Proofpoint-ORIG-GUID: 8vpSfveJPIij3DMtR9d45aulU74LCaht
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

Ensure the node isn't dead after reading the node end.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 26e2045d3cda..f3c5ad9ff57f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4661,13 +4661,13 @@ static inline void *mas_next_nentry(struct ma_state=
 *mas,
 	pivots =3D ma_pivots(node, type);
 	slots =3D ma_slots(node, type);
 	mas->index =3D mas_safe_min(mas, pivots, mas->offset);
+	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (ma_dead_node(node))
 		return NULL;
=20
 	if (mas->index > max)
 		return NULL;
=20
-	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (mas->offset > count)
 		return NULL;
=20
--=20
2.35.1
