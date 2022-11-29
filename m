Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DA63C599
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiK2QtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiK2Qrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7896CA38
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP28A031378;
        Tue, 29 Nov 2022 16:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GKlTMQFbAnnigcLyW4Swh+pYK3cP9w2B6Tyc6cEN7o4=;
 b=v7VFOf6zk0IAGwvkK1voiEwmcZvG+kivh1Tlqe8RZWuIP94YU6d/FDhOtluv5tKbKJan
 ozdD8EqzAL9oQtawjuMgLf84068gdmunErvZZod+Ej9CRM0/v+i46tyJ2tGa6QMNmM5c
 6I2gX6ivg8fhXl7mauOO5rckMId/AzQUti3l5L/2kTMHO9yovvLNgtBHK7wyyZaUzjB1
 eJlOqzH2JSp3XS/85E0mJsjv5f15VwKljP5EHgKxWkfBSS5Ug3PaNf8IAkbYJnrMh6y7
 kKDGVae8CTF6vSf+tr4C5QkigOhEunpbaadLgR9rcFl1gDapGFNbChagObmHSxHixjlA tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xavf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFn6v3028010;
        Tue, 29 Nov 2022 16:45:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f3xj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTG9QGYPZx3I/9bt1sotgYiH+RBYbQ8dlgdVQ3QXNgTKEF6s/Q8egRTBkYSh26+Cy4nU+2ZwnMiA37WNmVmwWT1uuk7Pgq1wY/CDl6yPriMcLdS0/M2S9O7NBjD+f2A5caxMqE5udGRBMtblIMlIXVbGif2h1x6UjFfpVOKkPkxro62k15FdwcmM2PDzxafOTMS1OyALm4rU53gFHo2bGMlvYYB7Nn/2q4DqjBhY+hTox4LXupai8uqHZdi+ZlK4jkiNCbmejVNzJKe1cjr6rnFxIO/VsJwLfgDkBZutGBssnBNy8tUxndLSxtAvl1CBHV0YOsjuQVm5H10gDL0DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKlTMQFbAnnigcLyW4Swh+pYK3cP9w2B6Tyc6cEN7o4=;
 b=fV1tbfMgznnIkQGbiRuBy96RDy4rjZwGCFobb8K4Knj6pXa/yUP0dzBUEayK5eI2w5XcSJWF6pa1aPyEMysRsLpAaAV7+yegMe5eDdskoJjDW3oRMueftsuMciLTlR5KbUY4k8PHU8kzTF7iNgOZvv+AURYI7ogTVSsi68RsYlmIwszHWAHmzZ3kV93ZW2oTwPn4C1yHZyB5ENhChSq4k5iinsnOAbIPrDdFC3Q3jGEH3/i7AQj0xk5qBCHTTD1kpXL1iLg2BZZfeDLohj/NVdHLrvQ58yZBQgErkrgQUEV53Xz+uPypwwUO2VrwjQ1kumA3+YpWzCTxExQkk4IM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKlTMQFbAnnigcLyW4Swh+pYK3cP9w2B6Tyc6cEN7o4=;
 b=jcY/lbEVohLgGiDzVW1Jy3iQuVtifYR/RaC9i8ZT/BO0OE4Dzm3mSjv/DqmqbX8qJA35uvekyEy1LNTIPy5UNkOo3Fj/xuPHTUcKu7R/iHMbr5+6H0uY3eYAosYXGhNTkqU8nDdG0/3TK0dJT7ZZ8FNMZ14w/IwEtshf7A13bEs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 41/43] mm/mmap: Convert do_brk_flags() to use vma_prepare()
 and vma_complete()
Thread-Topic: [PATCH 41/43] mm/mmap: Convert do_brk_flags() to use
 vma_prepare() and vma_complete()
Thread-Index: AQHZBBHeAgMA4FrXDUujUVAxTJu42A==
Date:   Tue, 29 Nov 2022 16:44:37 +0000
Message-ID: <20221129164352.3374638-42-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: d8876939-662c-480d-7c35-08dad2291592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxrR3UF3ZRNsm1Jxeu4OnlPVDSsctej9ickXtjH9VEWZxnd+HfpUbTcHTWK3OdwWvDHLeBh0fweInoy88ATVVkHH1LkUsxIUyTLcur71h1IHQ/xXO7b0XAVvA8Wm+CVqWfmft7nKQ/bw7sDr5E4tdbhSGuSh3nLNyTCHhzBShxOe59nSwnoQ2m773/VMl01PxLj7ER0RzCoiMLeFBr2jLZqLZi1AoeXk8RlDhuvGzfEXh0DbkAl6Ma+3GCDiS+opd4/9cfzQz/WsDhN/PP6S0mcUcCVd9M8R6+gsTsTO3k7iqd3lexQHqEYDRgIykxv8ll0UgLFRqtJPjz9dRKLgRsg+0S6aFqeK/CbAcyubJXw0DOCqWhWWDb4qh0NF2Sph8XKm1b4APC3t8Y3L9h74yUeALr3rvPRdhz/nRbjShk3M9YE3Bl3m7oN1ZXIzVDzm0wpBrY45xsXSo61bkJO6Je+5IC/LMpVtW3+ohwdRP5kTkmAmlJYZhGN3NQhefTVjziobx1Kgy7EDiLtH2FhDY7v47YIwWt3mQI/Xh6zejSci/zXK8/jFNqkArqm87n8m6EnDrMfhpiU/kQPXLXcvHMc7yRrSLIlI5BF6ibHgGjP+DMwMS4lPrNkPQpUOTy7F/ccpYlFOX8umiHd9ReP/UG5Ln/dc2M0BFbaBcSHNotV5g/PY7SYDgQQitygv1ZFIXpGQNGWbLU+e0fINWDD2pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0yu43F6twGVghZAV5T7xdDptNglKVPF6koGPP058H9d8xPTW5wjZm6qXE4?=
 =?iso-8859-1?Q?jTnfCeqtTYbkS8d10UUDxLZukULRH8m2E+topmxN581rvSOb0mCnBL2WpJ?=
 =?iso-8859-1?Q?vwL21G6LODVFOoCYwqFlf8efccVC6qm7ksPxbHdiEmpBW2klNpYM9m9Dhx?=
 =?iso-8859-1?Q?vi6VH8lviXPDOyBjmaUuFRTrjHLOutAYd3HcOwjJcO3IQVq4ArZKYPAJFp?=
 =?iso-8859-1?Q?7Taxkypd/CkHj5J4d6NMWrEqFWrL5YyUr+g94LXrY3ejUS1j4gnKOMjzxy?=
 =?iso-8859-1?Q?4v8kq6zo1PgxSXOGqu0yFdvwwPl9spCfNGXwihbyIZ03Xf/w0yqKu84yRY?=
 =?iso-8859-1?Q?WopuzKmJ7rXLmgcSH2Cmymx1QPZFWFgBS/cPzexvro9cQ+PJZBpIlAbr8T?=
 =?iso-8859-1?Q?4QQNkv6MXhJJ9Mn6MeH9CIAgP2EvetKdGlzaDMJFG9KUtkiRn+V23VeWZP?=
 =?iso-8859-1?Q?M2VancQrB32rE4fFTzAdHWmopZGLBpcBSY8dnweI07w1xEltPGoXCZiWnV?=
 =?iso-8859-1?Q?JnlJzqG5JNGfTBI/V0rmaZxC7FJ3vUCdhqMnDXip/Df19Ztw8t/rZh7MV2?=
 =?iso-8859-1?Q?tyWQmaD/AjQSQEPU+yk79DoKMXSYImYv6AEMkU1tNAMaQAZ+7u/h8uC+9B?=
 =?iso-8859-1?Q?h3LTmQZtV34IpN0aD0owxSiUnFFNpNXjbT3Xtx9rCZU8uyMydNFNWyTxPj?=
 =?iso-8859-1?Q?W7agF8vz9fJhBkqIXWvoLHMEYKjglG4P293o8JPStPwbWOG6BR8FRvOcfS?=
 =?iso-8859-1?Q?cogNCyUFLNzhoUFbucLJeVtrWodWLxaEMiyjAQu+xGg+ZzRLBjAdxYXGSh?=
 =?iso-8859-1?Q?IFrugAkkRdRey+qypDmmmKjyXJSLX9DOz15jrJzrcT1Q42p+RKOdpHYVdD?=
 =?iso-8859-1?Q?g/p76hv9qce2OHjh02bCCoYBLMHewdPlHg2BuZ15IRlaC0azWkH5QHZVpG?=
 =?iso-8859-1?Q?dtmqCWJCELktlwM17RTPdRagt8xQTJHdmoIpFh23RqoNzRGErzvUqJEmIm?=
 =?iso-8859-1?Q?Ay6Vm1cOKUu62EcFonDkE6uelLZlJ2v83lk0dDxCHTTVWiKrGcM8Q+m+Oj?=
 =?iso-8859-1?Q?EIwhZSziRVPOsCMr6NjpZy6Ip+i5iVoPr75TrlSQlrthVW4jlxz4Oqs4x4?=
 =?iso-8859-1?Q?CwLitUlD1HPAuq/S+rIW0v8BSRYYASQdRvinrplQr4hFQKXbYaH0Ux9o2+?=
 =?iso-8859-1?Q?VpDUB2VRAgC4M2x5H15wpZFnI+nFxlkDAFuYb3lu5Eq86E/TMGmyknOmgo?=
 =?iso-8859-1?Q?X0h6mY/sEwoxOQ+YUwVwA90TyeWmM8jDgSFNPkwQCQevoaDLLha9Aqh5Yg?=
 =?iso-8859-1?Q?onV0eXrmmTXcaLwSzn3Rsqo0R+S5mOrVYfQ/QmyMauM/tj8hcW4a9gjpaq?=
 =?iso-8859-1?Q?CHsk7gATufLTPlayDDY9GGjpG/Lkmu3MIy/lWO/UEX19LkWACdfp8ksuCE?=
 =?iso-8859-1?Q?+ZIXw5L+c9uPOSbe+Rewy0s2/YOqigRU1pHiu8AT+dZjqwjqUiwf8Ih6MI?=
 =?iso-8859-1?Q?UBycp2O0Lxb/c+PBj05VGJRvZjgDd3lsmLcZ3mwCx7EQkQaaxV/tQdUGFQ?=
 =?iso-8859-1?Q?qQFqqMWE2ZKfgjzMXkVkG1arSrpXRSr8zgUmXJm3j/3f4+h9+nCNlXbxcx?=
 =?iso-8859-1?Q?qNZYmm+IgvCB50qhB3gPKErmjgANFQigC1w70HmqCiqEhiC0dy2jbI3A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JjMzIMGZLLN9nRj6J7PBp0N4gBtQ1LOUzpEkqJfeVVBp9IJWdPfy/ojjzX7/37xXk/Fu/TcZdDSvrKAmQgT0XVFNIIwvv+BN2rgj6D4jUAI84Cyqc0akfLWmoE2I45q4Mv9oeCBMgep9zFGs0QM2HJc8vY9m0SGh+NL0Baf7gRPIgu+lJLmNBI3+8j+BQLEyPGjzIHCJnm6jD1k4OgjCU3ItZRVgfGiq9OvO3fUsJzFX6rnuSCwRgPRXPzwn/yFx1AQ22sAh/U1lxIAEU2NsNppEjDMT1WqFqs0S7q54sSz/mEWShi6E7obSugoucNZglxXShU7vOfI4p3D3zbyyNRFZg5eSJjYWOO+QiA9U6e6HKjAG6fHS5IcDidCu7Rd3/abXuJdEb+ByPqpMvcKIl751G5ToVRqEdrSxk8wvl/ZqFhhTfVqEdxCBeNQ1qqxWoUi5uBasx5cEeoakbuMolrWmVkjskyYUHEtdBrnW3xQhS7bmmYounypYRrm5MWmbmqwEV9lp8jFQGcY4q24kT5g/OeQf6LtUiCaGdEVULcq11iONrwGw+aERQEeEv17lHVNvdbYiSUT6z5fBHvldUBGmfyxsZpFFsqht6Wi79E6rBrPLv7oC33ycGM2CvWVZvGPFnnUmzbqz3h17E1qJ0iOL5ifuA79mpMLZ+00lID8L5K/YPkk1LKykvJTRIjim9OCCBa56Ih0qBx97rX3WRAv9Gu13WZ/jXsBfdmBrvvXvsjRroIgxRYVmN3dTr2DfizzR+E+cXOKqhhkoHIzrWK/BO6rZaKsAm8u5Ii39+MGV+qmolB+qWft5v7uMmeBAAQMPv/iSyG8QIfWQ2jwybXM7cFs3Sv2/SGllf1Ll+nFFV+pMyjCNzAnSXit1T4bow6McZ2MTtcZMWZL/y1r9rg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8876939-662c-480d-7c35-08dad2291592
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:37.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9ne4OlIvCDc9NlWxAjuaa2ieKcTty/1PdMY5NCk8UMf6jmzkCStSqiGtq8sP0cCeUm90kiToezcq+lbqEqduA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: YqSWFchRogM7BMP83eNVdSTVsfhgsX1J
X-Proofpoint-ORIG-GUID: YqSWFchRogM7BMP83eNVdSTVsfhgsX1J
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

Use the abstracted vma locking for do_brk_flags()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2b41e7882639..8ca40efb82f9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2980,6 +2980,7 @@ static int do_brk_flags(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vma_prepare vp;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3007,18 +3008,13 @@ static int do_brk_flags(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
 			return -ENOMEM;
=20
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		if (vma->anon_vma) {
-			anon_vma_lock_write(vma->anon_vma);
-			anon_vma_interval_tree_pre_update_vma(vma);
-		}
+		init_vma_prep(&vp, vma);
+		vma_prepare(&vp);
 		vma->vm_end =3D addr + len;
 		vma->vm_flags |=3D VM_SOFTDIRTY;
 		vma_iter_store(vmi, vma);
=20
-		if (vma->anon_vma) {
-			anon_vma_interval_tree_post_update_vma(vma);
-			anon_vma_unlock_write(vma->anon_vma);
-		}
+		vma_complete(&vp, vmi, mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
--=20
2.35.1
