Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466165F452
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAETVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjAETUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FC6E400
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:50 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IU1Y4029393;
        Thu, 5 Jan 2023 19:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6hunqgoWf3+7qbnIUEV4yqvkvvDOOGXUrMH8nrK719E=;
 b=Xv0oiZ6cMLGkMdsfeeKb0z+lIr5ep1l6BAtNJX4r3w5XhCJvr9bLfozC7R3zfShxLKDU
 QxmayKYRyyUReQYudKsTDh+c7PES6nQhh8Qkw6iEMQucn1lki+LgNHpBrCqAuRsv4e07
 g4n31uEbi0cG8S1Bvie8eVfJPIpSfQzV8W1oH2NCbX4t9P098+vFj3bWObSPXkgkc8D+
 87CelgY3I3U0Uf/0RKL1ECkC5S19eJgVO8I4pohqrkscYuvnmghMPVhMFGsvNj4Smno2
 cdm5DsYbqJ9xlydFZNcOoKlUjTq9x/eWcbXPNRrDSClr3imhnTJfNdOWnMx5lGQOtMoT 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPk033688;
        Thu, 5 Jan 2023 19:16:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn4HoRLogHK62PI9FwH/ZEVLdYnh9wKjKK4JqQjiMLw9nQG0KU/DcaNP1Tj2d0D7of+57n1uwh/bbsN2TfbRfoyeSlqJXQsexTDgvFRa3rFdXkKUt1eeCWIPefGWFAodbm6syopRiA1u1PKIl24l5SMVKpYJvD4OclNRXDO3KTbaHFJouuAe+4eI/MZtRM5Z7Q2Bm+IWlabD1kYq9h71rYyPxrG73aq2ksuzU5lfPBC5i+YnoUjBCmYgXRj2rZmkyE7s5Y2V3q0U9JJQHN1oI66a5wOpGXhacjUyn0IQmCLa4OfqkuJrBVFrRlXKQKCxJxmTynERe+7j3W0LKzc7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hunqgoWf3+7qbnIUEV4yqvkvvDOOGXUrMH8nrK719E=;
 b=PSxBYzqjU6CtKLOtd2dXgDwiDD/ZiRU5V4vDvhuHE6Fa2scvT9YZGGnVSJ4MOckQWrXh3z3N6/8orKR1aQSKnaY+BqItxvzeuZp9HYW8c4c2+kBn2Lwpyq+KR80hEgbdiZsbenRisMlGW8L2bGsIBeEKv5I0hvVIOYlJjqU6VReyN8kxWnogfJ1Nlv3FRpo3PcYCcMJqZrRyUFLo77TiJVTicjV+aMp31OV8wMhT584DiTfGQBo3jyCRgZD1owjE8I3GlW2OkidVLwOZ5ZeMSBuUZI4v9VOC8iJXLsx7nYeSpq7+k4ToSAbaUgPM9g65/kjoBYws5KL78ahPeSSJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hunqgoWf3+7qbnIUEV4yqvkvvDOOGXUrMH8nrK719E=;
 b=Nj7YFai0sYyRzvY5JZ7JuGTy+AkuaNHQ7n5sh+Xp0nBhYN9IX1JmxToJGUxZbjLXkA1KrITiKDSUpskvkLN3KTrygqXXz82lDejHlgli+d9q8Dl9KDJgP6hP1z44fc46dnPQ6+BEL5t4aK1yvCjWXBTn64ldSAfQ260VXdniCrc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 34/44] mm: Change munmap splitting order and move_vma()
Thread-Topic: [PATCH v2 34/44] mm: Change munmap splitting order and
 move_vma()
Thread-Index: AQHZITomplNj3iLyTEejKFxfL0mibg==
Date:   Thu, 5 Jan 2023 19:16:02 +0000
Message-ID: <20230105191517.3099082-35-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 1e31cfa3-eaae-4dd1-d848-08daef515eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANnfsmW1KXWJieY3o6UU+VkhVxiaIqxpcOTzGX6SrIXSBsloNppW4CAkCj3Cz06I1thSvzKHYXdjlgJyUNXu0CQa2WSacsns7tAvPj8qKlCnx/96g3yEMU+ePnH2tnj9KKXUBvYLuZKgr8j3HNYUmc+XZH788C94gHHSNsbS7zOhMDtoUNISlvHKGrAl+ZFpuH6TFaSKXtxu+ZROeeJeS3XwpWVPx0A77mULtP+x92yQQSW1AXn7ylXosEVWSKKX9ov8DLDQRlnLU3CYsSTn4E8Bg1v9Xg0rOGAi2c6JehmRmB4GnGSkcWtRfqEa26tXzarL5rX/53Nc1hCRfdUmBS2hmCLx+7P6Usdpw0DXmfQipQBtGmIDHR1Nh+utsKIIk0JPSbpiOV2cV0MvLnMhDLZGC6WyQCcaWre9zwEBy9wfDoKru2rAHnLjklNJl8wgNX2dcff5UBaLFHoqCDBV2NLCUDyr7uQM7oq57DEAEuMf6GehWzoQmHL41waUI1YOA3cGlprt3TYS/ewQc2N1/fR/VXfpGdyaIIC8GPx4UdydUMHOWk7Klv9sO3lUkZXO6zzVhTAuaQi3hUhEBAH5uFJdv2ds99H+z8vRfj47PwZHG/UPotC8WHqq2uxaubr30TZ6BUsPQyi89mN/D0zNfwi8vkft2/eNGSMoO9O1KHNb4QeWVmI5+sKTR+8lAT3MIVrW5yjN/GPsG4Idt0ZdbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mvFtErP5Na8f+EOJ1wdvtzAkxbaGdz+c0AmlwmM30c+pMHuXgwA5+3nmdc?=
 =?iso-8859-1?Q?kBS6RN0tm+VvhirKq+YTbqNc2V3nXXkntr+1uWD1LLCEqFgJfBqUpkw55E?=
 =?iso-8859-1?Q?ekpRQwQ9J8eBZiCIE4hz9yjyPhL2bRf4vbJFil/faISn8yzoVgWbGOCrm8?=
 =?iso-8859-1?Q?pVjJSc6MCFYPi4tTq7bSRMday7e2+Cr5iIiIL7AxA4rwh58/0Dvn56iMu7?=
 =?iso-8859-1?Q?2A4i5VCXk5Rd/zS+r+R4QTnZ9lUOYJvkhJ/WTrMpt7d/qzdX0bCRohSIGu?=
 =?iso-8859-1?Q?WpHvR6NdgQ7+Rq4GokAhOhlSHLB5xbigXUNlrQDJ7brITOeSCMZiLAypjt?=
 =?iso-8859-1?Q?4c3zdUj6UgTOAKvf8ta5Usng1vkvcWLaHk2UA4WQ0NrCoCclrkFqaY5TYu?=
 =?iso-8859-1?Q?tY4tI9jURTyr6mWDRg2SNNp9fozRqdbaxDL8kTo2nnFWXQR51TusRktywg?=
 =?iso-8859-1?Q?tCtVBNe1lL7KXXJt42uIVKZAWyxMKQLl7VekQ3YDkLr/qXkKRLDn8ZxLyg?=
 =?iso-8859-1?Q?2B4qc2pUlx3c4Mk93JLCpaCUXacq/10JCqbTpmXMfpeae98zZ6XnusvwOi?=
 =?iso-8859-1?Q?de9e+5A2IVB5KwluMpNZBzpsP/A0MyPD/5upQzhg7C3gUkjCZikcRuu6WT?=
 =?iso-8859-1?Q?P+Qb3qaQI6BBMGIwGE/IxPzmOBeX/kJpQhDX/5NKEY2P01q0ihMJZ5O2Wx?=
 =?iso-8859-1?Q?WEn9FED19FoIo3cq99FywwCgmAC6UeGj0Zfd3IGNAMeCyTUPV2UhN9HXPq?=
 =?iso-8859-1?Q?bh3ylLQsk0wMDU4o5BD75MQKXJjrMg9Nwvs6hMNWta/WtKWNWjcIlNOlwD?=
 =?iso-8859-1?Q?YMtutvFYnYzqdtc266aptJW6X1/2M9Vlo0n6yTPlETbDx6/HRJa4uRViiZ?=
 =?iso-8859-1?Q?vu7tltZD/AT4M6Y1BpwXYR5GGu+Jsq/DD8+EYJ4IqlGmnWI8l8psAvv2Od?=
 =?iso-8859-1?Q?Ou+EQj/uOTdazUT1U+7CQ5qLktK6TQq4jQeXpbPlD1JlHspy4LP1DXzxeR?=
 =?iso-8859-1?Q?mPel82CV8Wl8BNiE7I5h6wOia6s6IzVYK2ideMfyIKCjJflygp2wr/Xoeb?=
 =?iso-8859-1?Q?hw4L1HwAI9G1gMLskE+/Yz7GWGYRbuWipBwG8Qwj48Uz9VuHKxnBwT8ksI?=
 =?iso-8859-1?Q?yNZN+4rSwsKeVKKLtsPfMVrbde5w+bgOLTU0ti0yIhtHRwS64m6K670A5l?=
 =?iso-8859-1?Q?cs4V2N4Xpai0RbM0dciUCHNmzI+EDITNPELJZ7hEszhvogEuck8Xyz9EBO?=
 =?iso-8859-1?Q?FUfTeIw0khVCwF302HpKemgQXapXJNZX44jIFFXKYCGTa0RqfNpfhsZ7EV?=
 =?iso-8859-1?Q?N3qxiL4Q3lUGv8ZSVzEsywg9jJEGejEbuJ9ojyjDTjbv+GCEQ54fV8QFGQ?=
 =?iso-8859-1?Q?4Hl3niDMUHKmDgAduV1tvLGhf1dB1xsXNcB1wXtA3G9pN2ZmeSE0I97ycg?=
 =?iso-8859-1?Q?ED9l7zJV7nN/R0Ys6llnpUC6E+tHZ8jS1dE/J0J1ruQLHsOPw/fxlvgmeq?=
 =?iso-8859-1?Q?G49r9A9qNeVIxIFRqQaAbt4xtQQZWOeIBbHhbpnzuw9BRFQgDiWql7TxBp?=
 =?iso-8859-1?Q?x40q23ixX+dQwemuJtOvovxsBvBXogHB9s8ZGX30zNZXlOeaLsSwv1liBb?=
 =?iso-8859-1?Q?ToEdjr7NoGwokJzbcYrB19VMLEAu0mD0jklUqRVD3DiKfPg/NkRr0k6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ehBDhUStFMIDs1zTZHkMuP1nQStL4ELr/e9N3n5vsJMltvMrWFA+n7p+fpLyIhuGMlkEWrslKCmQ020GAoNGl2Y7ADyLyAIB/BswHuLMiubFk8e/pVu4FwWItFiQ7oqay/HmyOcifolnT31JRYizBuTrou8PBLovuZkvv1MwgUjLVFnSwcHw3UiiDsD5Lt+Ew01pXVQwPib31r1xhalbl06+H28JCWfmYNoqDWu0rDVQ5MZnNuhyOpREFV/BFiZ7AseFYo/l+nfm7NvccmBTIrJ0ujrvbCG4mOrp/QrTgFMqHi1ZMe3Kw5Og2g+dXCPmCGaEUltlZy0VXkzpG5U6zbPE2zYzOMKAIHxA8URonLkrk4jCpjOOrCHrQ+3GepbmhasR0KJpWwWsnDt+Ju4vMLR9JkdHNMUZSDmD98vdMN6Fk5pehXNT2oeQ70o1xItm4T0mCaX0ZiBX0hTHZgdcMCQEfUFkXuZ1AQyMveFEpyVHufW9PV2GbSYrVfXIvXsedLR3rmQ9K8nu7Rbm1QDedncd7Uzevaz3EiXV7WrgyWe8DdM5FYJDmjCiBkS/4Gn3iwTaAS4WLuRjpOJSYeJHWWuDYR1QvBbZi7Vtn/JJdzyoLvcdDq7HcgX9bj7S0JpqmRMOxuPhOvBLtMT59wQswlKaxplQWpaFXIeMEJklGX3m54ClxEQKR+PvTbRrXqUzKIpNXpcdqDE3ynYpDTk/9S1zoEyguaNTX035XkB20ImyfLgSxZyE94ITmerA6Bw++T9ay/bk15Z6683X86Bcxu5RSZdwVom+YUX1nrSPPWfJ9kzN/1xFuwuKmztT0ZoaK/wqDvuhMCfRFu5g0kxwfiIpW2u9Kh5CZ03GoK8rSHyrbC9xdunZ90F+abonFM8OoYhCNXC4Rpv9wL/33fHtIg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31cfa3-eaae-4dd1-d848-08daef515eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:02.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRBXJg56Aa+f/giUwqUwNXtF5OjUBPObQWKMhQoCoxQpAA8rQvIjAu2DJqUv8fbg1TKk34/ZvBgJteQ0DvxTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: rBfeTAkRHqV57rChOTjXUv4jWFR-D5WI
X-Proofpoint-ORIG-GUID: rBfeTAkRHqV57rChOTjXUv4jWFR-D5WI
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

Splitting can be more efficient when the order is not of concern.
Change do_vmi_align_munmap() to reduce walking of the tree during split
operations.

move_vma() must also be altered to remove the dependency of keeping the
original VMA as the active part of the split.  Transition to using vma
iterator to look up the prev and/or next vma after munmap.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c   | 18 ++----------------
 mm/mremap.c | 27 ++++++++++++++++-----------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 99c94d49640b..c1796f9261e4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2387,21 +2387,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
-			struct vm_area_struct *split;
-
-			error =3D __split_vma(vmi, next, end, 1);
+			error =3D __split_vma(vmi, next, end, 0);
 			if (error)
 				goto end_split_failed;
-
-			split =3D vma_prev(vmi);
-			error =3D munmap_sidetree(split, &mas_detach);
-			if (error)
-				goto munmap_sidetree_failed;
-
-			count++;
-			if (vma =3D=3D next)
-				vma =3D split;
-			break;
 		}
 		error =3D munmap_sidetree(next, &mas_detach);
 		if (error)
@@ -2414,9 +2402,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 #endif
 	}
=20
-	if (!next)
-		next =3D vma_next(vmi);
-
+	next =3D vma_next(vmi);
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
diff --git a/mm/mremap.c b/mm/mremap.c
index 00845aec5441..98f27d466265 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -580,11 +580,12 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	unsigned long vm_flags =3D vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long excess =3D 0;
+	unsigned long account_start =3D 0;
+	unsigned long account_end =3D 0;
 	unsigned long hiwater_vm;
-	int split =3D 0;
 	int err =3D 0;
 	bool need_rmap_locks;
+	VMA_ITERATOR(vmi, mm, old_addr);
=20
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -662,10 +663,10 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &=3D ~VM_ACCOUNT;
-		excess =3D vma->vm_end - vma->vm_start - old_len;
-		if (old_addr > vma->vm_start &&
-		    old_addr + old_len < vma->vm_end)
-			split =3D 1;
+		if (vma->vm_start < old_addr)
+			account_start =3D vma->vm_start;
+		if (vma->vm_end > old_addr + old_len)
+			account_end =3D vma->vm_end;
 	}
=20
 	/*
@@ -700,11 +701,11 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 		return new_addr;
 	}
=20
-	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		excess =3D 0;
+		account_start =3D account_end =3D 0;
 	}
=20
 	if (vm_flags & VM_LOCKED) {
@@ -715,10 +716,14 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	mm->hiwater_vm =3D hiwater_vm;
=20
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (excess) {
+	if (account_start) {
+		vma =3D vma_prev(&vmi);
+		vma->vm_flags |=3D VM_ACCOUNT;
+	}
+
+	if (account_end) {
+		vma =3D vma_next(&vmi);
 		vma->vm_flags |=3D VM_ACCOUNT;
-		if (split)
-			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
--=20
2.35.1
