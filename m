Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFE6631E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAIUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjAIUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:53:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4546950B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:53:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309KjJlK005579;
        Mon, 9 Jan 2023 20:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=Y0f09GLQ+5pNWx7talJAlIDtVF7MNWDDbbIeYCASFLQ=;
 b=wrmTdQ9WgZuKT0MyRuFzJGcfOlHf/su5or/gyD1efgrRlovt3HvT+32QEpGoUStUKTf9
 deRzMwGmhw3lHOmvOUe/R4tQuzjZHzqgd6QQQ95Jp30OLzv9Dp1VK+dieU5xPbhyky+f
 Qwz8vwhv4yi+ML/gMFb8KeDA+J7HrAG6q40HSmAcGdQIwBkmj56ttl/Kq4cxDen4lsQK
 7QJmkDfdIaoRUZCyEoVoVphBm0fmgTO6lqr8ykSMw5D4B8MIpK6Z3QrLSojtrpEYwusu
 Sctxvg2p5uVftMMfLHeEdtNLOngAlaskhCDeHLEJJx/i4mvICx/Kr928EVHXDMG+DMH6 iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mycxbb6h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:53:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309JkbWV033032;
        Mon, 9 Jan 2023 20:53:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy64h6xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0X5/ZrnIDqmhMVcYr7FVnq4E2uAUXJUVjPaNLH5Y8wLZdaRlYm3I+ZYsXCUbpT2He+1EaTFjKdB22WywSML214E6cuWHuwmix+dU4Resit28Rzv1acw6ZO46vswUIYhdRuTsmlrRng3d0CAiwH+/YBaPIgeWokJbPOLTXqg9axwcAH4kakP4BVJ6Cg2NhbwOjYgNSeRloPA4Ur6FHFXNQEq5gF7abbvm7bbqyOq3A38c7fdjM18GISQAzRSCJahPSqr9aeJ243c3AoUyPB6ti0+SMNHDmYAnis2YHGlBa9R1HiCa/2Ky6a5Nlr3oatZP7IrFYVCAj11DxrfSVao/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0f09GLQ+5pNWx7talJAlIDtVF7MNWDDbbIeYCASFLQ=;
 b=h+8GcoRuo9e8iO1KHDhB2WtyYotDpCavdxzwXhZbv4D5hmh/Cfder5A3aL58f444qko/yKhLqVEwZIKtoEkvdsXCUQCBj8cT6CldKpqxKUcW7TMHrM+nxWEyE5AdTep+qtGCW4KXn6QZnVmZLIFOSws6s0/NWy0pf4JPR52quB00ZPJi4UzoJ7QGb1XoaduoVTmUZoemqu1Uhmzg6d/Y/MGQkhjVY7z6vKBjW8waXoCmedk4fnWJl0vM7gIiHx1hih0E8J+GRjgKeh3odf4OAGBRJ05y0+JvzBKHlq0bCeXuc90xxNh57GBq5AWJupbsPeVCpoC1sN48nLaBEbVGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0f09GLQ+5pNWx7talJAlIDtVF7MNWDDbbIeYCASFLQ=;
 b=aPQxcwTTwmDlJPNadmPh7pluPZ49r2xvYW+8/RVpUt3f77swpEIgYvFiKnPSDpOtiW8n2iT/SBk2zSvgE940b1k1PLVRz2NEg0XzmzwZSkPEn+XQhE9uy/59ZCB974IKCy9pGooaDU87XQ2k3Nix+h6CBylljSFlxHqCM3VhGEg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 20:53:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 20:53:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm.h: Fix "mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Topic: [PATCH] mm.h: Fix "mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Index: AQHZJGxp0qp5kEp0gkiaLsryS6zA0w==
Date:   Mon, 9 Jan 2023 20:53:22 +0000
Message-ID: <20230109205300.955019-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SN7PR10MB6668:EE_
x-ms-office365-filtering-correlation-id: 6686d003-d24e-40c2-07b5-08daf2838b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkJfqy5AvCjDXfB76AGi/ikgdDQP4U1Zk5Rr6LBqTkkNQ8n/Tnd2/V/qqpAfeZ6yfyqRX09XQ1v/pyVitbuTfvbxWWjO+jmsPkHHiVr+JsK8BDGWrNwZLwVM5f+pJYky+Swpzfe/1yL2K3M1cAB46BnZIk58GKW2fAkI1ExX1oMGsSWvjcEpUwIWMgiI9zgH5Wif2Hkc9k2AKRSBWsIt/VDyA8cwz8Fp++KA3AnH4Rl5zC/G0Z2IDQkzyhRYpJtXZfRRRDNbmcF8JWFVZXc3gesDlHfuMpq6bEchiZLkRzV6dXLwrJn0steMWc/TfrJHLWexkCLxXt5/gKJNj/PdbFBRLkZXK/B65dKWJlMn9LT25Ce4kMOsUsVzDMfEJQdEQLl9sqQ3uB9p50uHDido2Df79Mxs6h65wib3zP330/qUA4Ol5BVDMpm5RKKTNQpmMoYaPxiDnewz/SerFFXRG6XqhFEzY+UjTefrrQ39JvyOpYX/DNkl2bQiNCbHrTgZyYcloEIjkfatGJnd1ALQC9bxrzIQogg4izOWcRlKogkgi1Z+3bCXV5FJnI/Hs6Hx6sOOPv7WG829a9qj7majElZtwrTqbKAMRaXZGU5UyjObMyvIzdtJL/KCsBoO+DrVZhR3ERdlATqYfX/ACtXYUDq8XDof5BLBfD6hofyv3w4x/12Y/h+4dVhsKVVkFKBIItRYpU6kcBPoAgGuYCrq0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(38100700002)(36756003)(41300700001)(2906002)(44832011)(4744005)(66476007)(86362001)(8936002)(5660300002)(66946007)(76116006)(8676002)(4326008)(64756008)(66556008)(91956017)(66446008)(54906003)(38070700005)(122000001)(110136005)(71200400001)(316002)(6486002)(2616005)(1076003)(478600001)(6506007)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QuNrCv+gJBkbwsj1yjbW035W0a6PIJ167uh2QToS0Q9OxYzoi7BdBoTF/z?=
 =?iso-8859-1?Q?7yc4huw5wtdddiYqx44CYQAgvgqauq08BK+16LwYHztcLTKRlAlEY5wSte?=
 =?iso-8859-1?Q?fOAINLgy6N0t//olgRZ8lMJHs0ZIBN6pkVdeyWye0xrYw4X8LL/NaTSBRJ?=
 =?iso-8859-1?Q?OYYRPWfqYqgAZ50YIPHvaX611Tce9GVb6htdEVET8mgdQI0KbFMDmzZjwm?=
 =?iso-8859-1?Q?6tYlmSGXJOU2fDvpH6/sgZnOIBSSKqO0hXow8ARKfijYy0EXDNEZr6Vapl?=
 =?iso-8859-1?Q?Edj6hobBIzXdMHm/LttxtpGlnIl43l6Tl0InA4pEMRmNeKt1MtqCQEpRSY?=
 =?iso-8859-1?Q?9WHLVbbckkrgwmGOGvm3rSoZC8bB8clng3SkLUWkuRE5fD8K1ySLfaqXZb?=
 =?iso-8859-1?Q?ePK2StmxfwzlNQEzOP5rLSROauU45W5dUNAs3B8AN1oBEpCrw8WEIUL2XR?=
 =?iso-8859-1?Q?eppLI8xtQVmxrkgpmXAThxkp4o6Nxanf/9xrDQm2v5tEjc/QSTBeCmyRxG?=
 =?iso-8859-1?Q?+BY2FMwAShuUZtonAEENXWGYUTLeNU+2BPmH5SaEkQT3qIUQZboRny/lfZ?=
 =?iso-8859-1?Q?WiGVKotqHSy7yktiyogxP6BENdoXvouV9zG1zH1LL5gMuss9pJaHDZ2cQ1?=
 =?iso-8859-1?Q?LTsqlHr0+6gr/+IinfDU+IFdU5L3uPqaS2PRi/ryaVBnh0J9Pt9mpxJ/MQ?=
 =?iso-8859-1?Q?xIW9Dw6Zqh2jMavGKB9DoWn6+c3cvp+VBBG/2NlRAc/6tIxHWknB7buiCH?=
 =?iso-8859-1?Q?XT4oIpvcbMIB5Y2tluBmKzRHp4aRUaf1vdtgO196rSILKrn+83dOCvnMBY?=
 =?iso-8859-1?Q?VUsVBDbDr/jH4pCnLpXPMXgUiaLAz/uFBtIgGZtnapVnAKyMJipsuAxZ2D?=
 =?iso-8859-1?Q?7qxexPrfge4zfh/9ZOOKcmYsKbRBzRaB9DBMZAlGe+PWH3jJS0g/nL15Ux?=
 =?iso-8859-1?Q?YVKcSaItuTPrr7MidTtK3okPDddjsT3vI9M4JMSYJ+sC7elcqCEmcxKEFt?=
 =?iso-8859-1?Q?HsVFW9AoBN+cbR2U6zdphJ7yDNGfKask92zVPKm2iro5Jkq0JeMLUg9HRz?=
 =?iso-8859-1?Q?vR+1/Fs1PS/cB4MqFDy2uvjtlfE21Pq3jqcNB4jSszQxGSeWbGgDRav+mT?=
 =?iso-8859-1?Q?66VD77ZwbpJVlU+jnUADWe9GkPxBkFpkEXfpEH3hOhMcc0mjyFaRBMlk/+?=
 =?iso-8859-1?Q?9F+fVd5bBkcCWd3Fc7M8bB0cE4UJkNwMqeg3Kd0VMDM5PhQcjXH5rZxtnr?=
 =?iso-8859-1?Q?9aLjSDZJl4Y7UzG23btUh6wdSIbp/MI7nqv0Fvc30RRaVM9WytOZr82VU0?=
 =?iso-8859-1?Q?q1RxJWgcBXQS897km69RDc6CxNOA+Q+qsaRqf4hGhZyGr2gb5I8oKUS4xt?=
 =?iso-8859-1?Q?bHKAW77ot9stBOzldoAROzg4JUkjy60OaG+AWK6UN3R+3dyypVcfHnhuxW?=
 =?iso-8859-1?Q?MLS92bh90m/gfqMr5Gn8pogOvifuBSd7TG1NDRe7ioGbPweXKMJewYur7Z?=
 =?iso-8859-1?Q?qbF3RCtvtMmCMWWQLqPttrAgFpLdOOYWjFcv7td9oN51Ofr1snlg3V1qsp?=
 =?iso-8859-1?Q?1hp7LG0keco6E9TFaE/j8Cquk35lzbUwwnrPG6140kYWAdxGttFwDdUL4S?=
 =?iso-8859-1?Q?EYETBTQo+rz6+Jjch1Z9JOxZiVIwJ1axccnmpw41AW/soznuhnMrjKFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AvDLaRjsv7gaRRRGr2rHbFE5g3bL2YUT4BWTW0C6fCA7aRzoPBHp6nnHcxUDIjbmQ2/mvBcIAjHHJJIu9Xoi35gYritDTnD3Mi1+SQQlCTgKa2kZY8G6R0R9J7eU9L6brtN99PmTpr/rjx0lCgVov8B1C2TSVIL2GzbC+DHfgmQTwUiIIvGqOm3hViOf/ct5Yq5dF4+FvLQ08YeRy/qCGOfXRv2WK3DleiTpbh2Zc+CMJhwVc6ulenMoQIAEsTMEsbbiK/BLVuaK4IN7bY64Rh26HHOIlY0K4hWW+1CMhRq4USlxMdyN5QJEegKDP0RRn9aLJUA5hxulz9hGnxtaMem/bm+Vr8ygwBpvcSTEvPOu7D716SRHU8Pcs/ZRdPx4SUKm9983aivl1R6lOuxi2l9UasgKyKkCuY8mo14Kdnvfdigv63C0/mLbWVT4RSDgkFhGWxluVbPRtPdFzMAXGnlLWyAWN7VqDgRg5QbWQRTNHqMUWAVrVe/oCMfzgVsstgOuAFyrQgZTbriTtx0L3N4OFX5TyICtGmpeoSZ0VrnMERxLYLei7KVSRQ4tJoW8/Kh2JOFSqRuJtGA3n2Gpi2CpYKkFZ4sgbISO6M1cxOgIuMNOlHbhexqWSoCGWyvgY5hhygR7l5Ei3uYzpkUHXeHlH+pQL93PxADhsVZuC76/MUk91UsYU0wSMovq7N6OAw638RaeHNO8eLbmytUivuX1YlPuoJCwULNYy8JoAqPrnOEw4OoyPV/ktFO18xd4DqvwQ9pWLckBlIE2Ri8dvctU6q1ood6GY/SRyywQqXm+wKWK+BYRLBWPUdP3P+oCM7O5zlyXGJRqVnZwmlm3/A+6gwchho2oJRyvzFiVftKRxELbvFkXxGaAXHpuHsaTfpIDbPx4qkI7BFyvoxb1DRfEGn77YoOufpK88P1hX+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6686d003-d24e-40c2-07b5-08daf2838b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 20:53:22.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHIG6snxQJK6Gb1ELFhwyjac1MIyV+C4sY03PuMl7NENIWgRI59QEwi/tpWLonYCvRTbNlEoM5CS9zEn1fypkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=973 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090146
X-Proofpoint-GUID: MtlstrXATW2uXLQv_gLKOXgb7-3N2ayT
X-Proofpoint-ORIG-GUID: MtlstrXATW2uXLQv_gLKOXgb7-3N2ayT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extern definition of __split_vma() was removed too early.  Re-add it
and remove it once the users are all converted.

Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9c790c88f691..14e3698fcbe7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2840,6 +2840,8 @@ extern struct vm_area_struct *vmi_vma_merge(struct vm=
a_iterator *vmi,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
 	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
+extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
+			       unsigned long addr, int new_below);
 extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
 	struct vm_area_struct *, unsigned long addr, int new_below);
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
--=20
2.35.1
