Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3965366D451
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjAQCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjAQCeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0D24130
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09bnF005673;
        Tue, 17 Jan 2023 02:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XLKqo2ELigudJIql+JZj9hF8T3NaXHJ9soB6HeLIglA=;
 b=NH78StYWWtDgOSNczksP8k5Oq4/gJQFlrLQQP73CfyqBj56uCnlAwqSxjWOkD2CAXXRv
 byE51RLys783CcXCurTI+54d5D1yWOhDGRduW3v2RK3uSKCQ+2rVKvKLtoU0QmxB3v7M
 4c24j/7jpEYOceH4c+k657/CI7AIB7QazjxeLmBZq8vftN1KODVR0kud8UE+hBVIo4Qb
 DyK7THyxmQnht/k34dCfs4r11xEpoF+wyKp1ixJtDupusA3FgiA/TEceTC+RAq8csTA+
 mK2sQveGY16Xk1Wl2+fCtmT8lLqlm09iHff+CWfYbLA2GTOYvl9Wy1B2qGMyqhpU8a4X jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rZ028480;
        Tue, 17 Jan 2023 02:34:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et9LdcJaZaQY4SVLq/kE+Zb4SihJHOx0XW+JunlPTFO97M9/l9snjzhi51yaB+BZfyvMi1ZQ1wy1TDVKTfKNIxteoCBboPVHsSjqr4tbt5VedAZxhc63KupD7yfIdv/JTCnn+DXgx+4d3Y9jKYCe36LJxw+DdGClxPKZJAteDtEqbHtNfoXZ6iDJFhBN9o3rii70EusgO0jd6Rq/lYkpPn/BFAnEJS2OFo5tmCOTpWb7vCQuVPi3zVRqbvPYfxjr34A4QAQPcdGfU23WO4ooOTCPeGnbZ1K/BC89WFt561PU/WCeNeewpK7wx80t3uR+gtSOaMZ3bsJljcsjOkFJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLKqo2ELigudJIql+JZj9hF8T3NaXHJ9soB6HeLIglA=;
 b=l8AY7YUxBxplCeWma08zDUURp2cWuw4pnqISHsCVHToDm2wC+Gz4BJ5FUUIK9pH2tbyIf/PbMjFMxz2/wuGSLKBL50crp16XioVuht47oHoetuxbZNYC0bgwo1xcuurxSuLrsYJh4VzOarH8SSHSssR6keIobLYKe4UvCM2oG/C9rU9n7yv/BSAomrwwJbzMLpxhIiPWDITiihQ8yct8Blvk3UQwsfJpwXp4IxhrQT/FfOBKICt7jnRZRXOiE1At6aUXozWI3vrMB8pvPArto8oCG7LcaMtQ5mygsQkErx89UbQTB+I5VK4Yd0CsuzWFPX1es6+idqcM1FG3939ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLKqo2ELigudJIql+JZj9hF8T3NaXHJ9soB6HeLIglA=;
 b=zv5BAttgs7COz+k26KEJ3Je+0HDoPbtmyz5o/zJVj0W86w7fpPgr3pamQnbUTAsWOVHtR548Qw+3RYuBysCNKvxnhWmteO9wW5nZMVfUEwvIJE01mEMK8/wzVliEsEOpsG3JUvsDIa4x/j2YKDFsaEvv3Ukw0v6IvXgrrPCv8R8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 03/48] maple_tree: Reduce user error potential
Thread-Topic: [PATCH v3 03/48] maple_tree: Reduce user error potential
Thread-Index: AQHZKhwuoNeNmxQIvkKL0cCs+o9Zvw==
Date:   Tue, 17 Jan 2023 02:34:10 +0000
Message-ID: <20230117023335.1690727-4-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 918def09-4825-4de9-ca8d-08daf83350a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B537zKD7lnYKNXWMZZ74Hk1JksD1cEtAKTKaLjYP9jYR3yVNb2XwOpAxLBcBmap+Bj5TbL9bBwSYs3FuQnx86pujwJjjiGrFRGNL4pO4Ro1R82hsiQSrqko8ImNRthqmHZiX1Brw1/fw9pR67k+HRnpArRU/gHgmTJUfkfhxQU2M/w7konmafQv24W6hLgXBqJhNQLMj4tZwKL4B1sv4kFZoVaKKvRGTirlcLvOW9jSd8vS6UttNc2q6+m7zMwVGUJwNgoF3BUtZO0euVDJ6vSY4zjqN3XH0iU9GWi6MkkkjCzaGKko9QbqWKMO+B1OjP/ZchDmawXqNTsDSmqCLslEPxBhvaLsM7FcNDkHik6D9cHxDAC0clsoOYtw2kzH8jkQjzwHQrSWRae6NIrCfF5BveJdAEmsu0ffU+UKzTIRfhuQEYhY5IDHQVn1eESjvz4JLPRs/3WNRBMKDscKstO2AkntnG1NEgdhMLYnZ+03Uu4sRixoRThmyCG/F+yfoR8iATG/msFy0MgV+lavUONnvl737UVTHco8OAN9kCvfXdmETCR2bKMbH2Zl7b0NFg1pt2Cwl6O0R6/pIcSnRujKPkR/C7P1eVH/6fELhfP9gF4X/bYkX8Y9a0SbVNvfguWBeJjIpADbBohTkKMH7IBbvezH9MN6uo/2fXIRb1Cz24ZjYRdSJix23kayJMKdxHFxcSYPU6BMDZFEXR3UjZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?InE2mS89g4CVJWVVeVl51MLJ97VJp96ofYguZY0uN0ar9LZLtO1hqpVmOj?=
 =?iso-8859-1?Q?ukHN1vdZI6toWOwJjOBBuJW+XILM+ifXEGNJllluCLrlG/28qMwwsY5eCz?=
 =?iso-8859-1?Q?3RBAhdmupbHJkwwWHAs8YFyGv5ZKt1dRBozdV5czhpdQ9DZEpx5cJogUda?=
 =?iso-8859-1?Q?FhEHlJveIkx9AdJOcAOdj1hnYI//Fz5GYfV6IjhkVPhLbS69n6xckbU96a?=
 =?iso-8859-1?Q?EpwrxPt+mBLRKTy9bHXnLmcfIqVUKOf1EB0rD5dO+noLYawaK8M7ovjYh2?=
 =?iso-8859-1?Q?GswIc65luFRiNbr59xfI/WMLiCbqMDSc/iY+MD+4QDGWlGZwZ/yIeeA31m?=
 =?iso-8859-1?Q?yCTfE5AYTEM6AVmAhEeCJV0tNc2FuJJwXyxfL/RQRODPvYwQfZ7wLBRmzm?=
 =?iso-8859-1?Q?fbzPnZxeiOPd5ULlQQqEdda0XgFrllPPfsVgSDGMoznUNxgvTAZiZGD3zt?=
 =?iso-8859-1?Q?kEFusIC+7X/kvCWVXcRRg8aolyt72ah6YgxHkgIYy8e7WDc0VYTXiyuzMJ?=
 =?iso-8859-1?Q?hVSbtOQAynL45nHjj2LLSlWDDbftFEDURLt5rdr2DIDoyW+M8Ruc4tbXxH?=
 =?iso-8859-1?Q?FdxftCy6LPemHlHl0svRsjUpze42ecM5Be5kUoQWqiDuJ51nVfT7T1w7bN?=
 =?iso-8859-1?Q?A6OxDmOb/IRDFfqWtUWTWV7zU0Jh51Tseh1eULHX0Uuu/Z+GmR0uJ4gt6J?=
 =?iso-8859-1?Q?iuy3Hj7m8DsHyOQc6T2XS4oik6O4LNrE/Oo0X68QH7vjHUv4J1VB+eJhu6?=
 =?iso-8859-1?Q?6d7opI87QEW8phPI+OIWD22M6S2uCi1+xQPYJSEJuQgAjfjF6T4PWFZEB5?=
 =?iso-8859-1?Q?bue+aceWrchHyNTLFXmzY0pVt7VUMhZQ3sE1nlr5SDACRCB84a3FHP1HZ/?=
 =?iso-8859-1?Q?+8jM/qLL6ZJ3SY6oPMZNwmyYlr3YMEMsRQBhWAm21lSLrrcFSnG78h6Tno?=
 =?iso-8859-1?Q?WTooUQHX5zmik6IY37N+J2xDPUWQ2VPbO3abJCjqus6aweetzlQ+l0Ww6R?=
 =?iso-8859-1?Q?fROzpJoriNsG/q6FWw1owvy7NWYcOHcxiM9SQfXitpkOdacfsgxRwRGm+c?=
 =?iso-8859-1?Q?tCLTe3SMZIIWPZjNsBYTEBCOR2at9XhdCLPiWcxCKZUCCWUIxKGebUTe3v?=
 =?iso-8859-1?Q?VUfQ1CSHQ5xXcDyv9JdgCW9KycSWunnVuqS9FIeEhzDyzWRE6Cp1ONZRMh?=
 =?iso-8859-1?Q?sPrk3VHOKhiwc6IIRPIIFB/GIdoZZ8CO20aUXGOUNz+EJtur7YqCXIiFKi?=
 =?iso-8859-1?Q?mLQvshH1Jw8JDQ5eCeQMd/RHARzUFU0h9rvcl/nQwguWIqWQafkeW3ZU38?=
 =?iso-8859-1?Q?AU3Pjfnq0qGjgORs41Vfj3ScP94KtxX7E+1CvjF+djAaB3oFHsZ04HHHH5?=
 =?iso-8859-1?Q?6Fl62Ld72Td7V1FsTPlmN7qFk58+dRaCV9QADP7C6PjxCw9UJUk7GBqVZA?=
 =?iso-8859-1?Q?OZCqbcxXHkSvFjsHJStgLMmnA+TGX1KCuq1t/ljFXlEtTlIpvGqRJpqIU2?=
 =?iso-8859-1?Q?R8Ea3YO6c/8gf59eUSo9QgLR7zZEBM96KxjNfrym2EGu0TP6Eg5hKKi6ER?=
 =?iso-8859-1?Q?Sr3tJl2Tzvy536LRwf3iC5bKYyPHc9W9/pyZpCyztZqOKEZ5P2hag1Jwby?=
 =?iso-8859-1?Q?V97X6R3hLqxtnlBDBFuat2nQZK66uAoyC3GiSpcck3i1hcVPXv6+hr8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SZxlPseR8ebWrlhHDPxCdfPJb7AccnNPlvj1jqtp3wibL4AONxHtf+i/62SHAvkS8+NofIJQAGN/2e0zkhIM9LxwWK7kmKCFkasMztutQh8xFl4VJraNOh80vn+8Kk1YkL/RKvfWXixLHhSUfMD0fIW0IK1mW+Cu3aSwPtmr2e7DjrdFKIkbAW4r9fLVnX5uS6VKAC1Fvf70+iHS2+B9lb67otJzOJyi4Q5HVwFnQ0FavzmaPmUdUZhfibweVbaA3IxRvUDQaoNK4NpSCem4KO3ZNb3LqdZkYTG70x3ziLXCK1OUygqmni9139sbWvkqUSOhBEnNVhNQVyCwdZpenodnY/BbN8K/m0SwDL7DohkZ6BHWzIbfe8+g0U8K/dFvJHTFn8R7nyIJqpbRyLz5i3pknI+O9wVY5BU3O+VWyP/GUW2+lJSxk2w+Zva3sbZNa6jleGZ0sCyhB1BJisxHj8f+16X8SdTzZYtMF5qE6sOf8wVV9rFkjZ7Diytm5VehRKvX6OBQ0Xv9KBhoavCs6EPM7t6GL0QCN0hgCvf5t2bt8lQYRdklADG4lJ0Kd6wZ0z5r+3BHJrdmGnsgUeXpuWQ7I4gwQHrWTh3kbVK4lYnhB1NrcYZhVOUjX6t1OhE7TmrYLCq+EhExVnHRxD3dZICOQRrISpPySPT8mrqw77tPRdgu6SSL9V6icrsC/9QTfUI7ztLLsk1Cj6nANzPDYgfoxwYnjs3+JvICQaUj4l1/z8OUS94hACYKoc+BRnIvPVX3qKutRgTcRVmTDLK660XUBEEdBLTAByNPCYu9+Er2rgrCwUrhzkNyEr8X+cJfcsm+hUYUP3mXDmRQ9tvhIG8/OYUNXeabaS7AAnG735YNarzYY5dEnHm0JKC3U2RRGnmvazedhVhEH+b4kDGFbg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918def09-4825-4de9-ca8d-08daf83350a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:10.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3P5h2YJ/pj8s20cWkjYnWdk2IHuAmkrhFXRz7bL1ge3qHKyfRvfmWd5M0mciILYL98uqJkpyf28E39tlufCNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: c7Ws5lg8HSpiTILSMCmxdirCNFuBVkwj
X-Proofpoint-GUID: c7Ws5lg8HSpiTILSMCmxdirCNFuBVkwj
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

When iterating, a user may operate on the tree and cause the maple state
to be altered and left in an unintuitive state.  Detect this scenario
and correct it by setting to the limit and invalidating the state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c15e63ac6e93..9af88726d88a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4742,6 +4742,11 @@ static inline void *mas_next_entry(struct ma_state *=
mas, unsigned long limit)
 	unsigned long last;
 	enum maple_type mt;
=20
+	if (mas->index > limit) {
+		mas->index =3D mas->last =3D limit;
+		mas_pause(mas);
+		return NULL;
+	}
 	last =3D mas->last;
 retry:
 	offset =3D mas->offset;
@@ -4848,6 +4853,11 @@ static inline void *mas_prev_entry(struct ma_state *=
mas, unsigned long min)
 {
 	void *entry;
=20
+	if (mas->index < min) {
+		mas->index =3D mas->last =3D min;
+		mas_pause(mas);
+		return NULL;
+	}
 retry:
 	while (likely(!mas_is_none(mas))) {
 		entry =3D mas_prev_nentry(mas, min, mas->index);
--=20
2.35.1
