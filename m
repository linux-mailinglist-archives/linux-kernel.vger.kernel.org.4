Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4266065F445
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjAETSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjAETQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B211447
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUNv6002764;
        Thu, 5 Jan 2023 19:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AFwaB2DSHd9hyJwJhLeWD9VEJD+3datyV3oyw6c4BwE=;
 b=k+0NX6ugktCL4uKizfmj9dpaCRXMhm0PMbX/FYEdrZLODpqQCETJqb69CiXqcAVQi77e
 Ii/r1xEyfNPBKhV4PwGn1AbsKm7Sehv4b0LAteSe+esJePk5G/lJtEPZRovUCLLAy5Ez
 zpnVqjoMaMIwq7z2lRJbCw6LV0Gs5OJ3x2vwuQbpgmcvpwBg3ObZO34OUM6gtEavdHIi
 I1wshfPVlB7w9z/T5Fhws7gX/KIFzJ5hol7E8kM8q/PyetHzqaNLzTtAzj2mY9FT2NIH
 xTeIZJIgUlblzt0V+hj52xhVIQKgzFX0cRQSOaEqWcnPGsic4EQTFICZeGZB830NUa2N Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11q0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKb033879;
        Thu, 5 Jan 2023 19:16:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPSdj7faeXZC9NyMSwJVvlqk6MBye3mQoXb7psCcjmYMf/o34wGBuiwgAg/AqOsob791JV0nqBkO9KKd3aPvYh9kuY3iA7meQezy8Y7TBAAMvo/UnpQTrZk32B1mUyhimRXfPWXLXfHxFbx6CZ83xSGqx+eMqpSa9bVWd1mxYmXbHfgCT2CmsB6kRzCPL9+YHMqZnJr7iJzDwNV0OrGtkVilSaZOBvyupP3STLL9RqTc+pqTbe6Jtq8LyUwFGlcjjIEumvpmrNd/bA8UWBAOvkzGdBGGoSVDpWpf2ngrbqDk/iuPRYZ0KDVK/uVv250MIuRjzpigLO8FI2nSvZQNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFwaB2DSHd9hyJwJhLeWD9VEJD+3datyV3oyw6c4BwE=;
 b=NUObs1RCAJ3RcdUKG2YqoWsmAT8HVLVjsVU0zIy/O+gWOVmfKfyWAfrML1HwpL3VUEPJrLo3DqrwGNNlGuxyXLdpdwALnENcfghApfFmT0Iu/1VNSC1JFzwMFtSJ8KnCX/qxuhWW8nS+muO6H6EdnXqn7vTmvJKWtfDrrbGW87+rOB0gQleyVbe4Toh8EbOKvQtLa5xGOg2ohQIvl961OvVmkq/I/cKSbb95CB40aUkyc1oG1fSMauk/C8CUG8byPwviLkv1vuyLa025UWCiFOnpAbmFY9KEiHQqpo+tBwJ6ReoQF8JAxVpZovg1n0jelF+Bmu6OCJW9DLLgrDvFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFwaB2DSHd9hyJwJhLeWD9VEJD+3datyV3oyw6c4BwE=;
 b=io1Q/4J7KMpqaFQ9fspn0OEObYTdtr7ujRwBHW26ZGEGDVsj3gt7XLUTFJqJsB43LZqjUwR0PIrNzwtXumbqxS1yQccyL7WmDTZeTre3drHCHuBGnIx7WAqSJMHeUTUUXrdtAnPiAUziAovejgJhN8JX9Sz6AGjE76H28vdHdbY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 27/44] mmap: Convert __vma_adjust() to use vma iterator
Thread-Topic: [PATCH v2 27/44] mmap: Convert __vma_adjust() to use vma
 iterator
Thread-Index: AQHZITolffX29a8LPka4e9WWOTvLyg==
Date:   Thu, 5 Jan 2023 19:16:00 +0000
Message-ID: <20230105191517.3099082-28-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: ed52e312-66cb-4257-64e8-08daef514b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOVfiD7n+dFzowCKpXk9mpKTOMSOfQp7VytZg2NRmv46uuxMCbtmjBQ15TyfFaCEHctfKPja1/hXSgKdeiDBdKKzWsRURQDZ7szqcAA7Das4ltHfZ2Ir1UP5R1YE9AUTmJF7WHK+cXULa72jDlkcWfT/SyUvViMtEgziPZg5biOCRdF6O/5TVgCoNokC9kSXAVHltYCLMj5kgtgK0lTST3ivxPnfvYVTMQaWFPhr0VYMa7MWRYDI35F1DthgQdZAp/Ch0KZrYU9IPG9M5nYVgTyic0t2azApD5tr12kGGuEXMSaOi+xLxzzqsV1KuKD01vX0ucHa2yGnL9rLfQZtoDs348zDAxPMYvref0HwOuM4SEw4eGb8lz0c68c0CLoxWz5HL/ggUPN7N7APq0+WVOM8OXfo6cS97NBO8rSHw304gzoTVgsf5iqbB6DR9bz9qgm01uHRjIHukI9iwdvV8L2CW6SzgZQb5wF/b0sG7M5A1Jd95oaX1XVy2ClQSn4aXM1Qjo5OcCIjlv304aaJhdUTJgSP9CAWwGDlM09O/HzewrMBGQDrIpm4+dWhZhkr9w3aHCQVJjY1tyfxHqFLjz24/Mt9QLnGC4hcUSTCCVsO7SfpdYIszq4AyY3hUsTl/NkpUglWSifqhzFBZWYq4EdHFMibpLjhlh8gUaFCZD31gYBgxfHWHeVVnANG+s05YwLeLcvAFSxYq7hKTC1gqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?68d3yzl9PpQgeC2Z8tLDqrU0M2+xFuzSwsc/xwbeBm2h7MHHV/dmtBiAq3?=
 =?iso-8859-1?Q?1olYaYreeAqvCdT3TMZz6bM4QsIXirwYVWDWBBl5zFuvJI2OD8yWXMAt9X?=
 =?iso-8859-1?Q?5OuSfChPQeIcKBc908KyRlRHLSuAn3bmwKlyjUv6MVCwr+s5EtcLwaJLXK?=
 =?iso-8859-1?Q?wntAQMCdfg92UlFDQa2iOUM/X3YWWJjIhkpNIEgDGKeR5Ml2SVVuHRN3im?=
 =?iso-8859-1?Q?jznjYLhDyOA0w0HJ9eiX5JUdEPrlBFX+MCdDm4v2YbKQkePffWcpsVSaCT?=
 =?iso-8859-1?Q?YtyfIEw0E5Z+0Npp6TyByjb5B6uoo35cSdRjKjoro8Fge4PcxCUiXt7ObH?=
 =?iso-8859-1?Q?R9WCIno29F2AeYnxU0MacsHKwcOtW4TYq+MCW96GqG2W2IygI2Fw7R0RJ4?=
 =?iso-8859-1?Q?a6njIQuon6YT9xMkaQi/C+hpJ7lRe2oFLLdSwzmsr35Jb4IlKc5h1O05yP?=
 =?iso-8859-1?Q?5PkY7ZEO/GNKmrz0/9Hmb5pvSTzvC8xDmONd+uRT0zzKCla20W+EfTOjqA?=
 =?iso-8859-1?Q?T7RPz+qB9lCkYLeJ1v8pipXE110V8URPa/Cs7hhACUNCVZg6+5PRi2my0Q?=
 =?iso-8859-1?Q?Culrm5NLOGp7JkM/rywCzToOJLE5wV+/A9avrAl0TMGe/0q7WDxiZ7eCqB?=
 =?iso-8859-1?Q?jdJVSZbsIXRu2s85hWfsvE55/tYQAUc1c1VCsBN11ywvxZ29Lon4hMbNoE?=
 =?iso-8859-1?Q?Mzz/F31IXrv7HBXMfvxeoeLpeOHDwNsW51lvF1LBDcCbdyCJ+/FEK8xmmF?=
 =?iso-8859-1?Q?Cg9ff5nx+EI1W/Av4VWNycE7tgX3VkoTM5xlrzJjXJ5CA0IogQObmhH2aF?=
 =?iso-8859-1?Q?JXP7GPDX+mtj/sdIpc5mkp06IMTb7ZLT9qVbqbR0hBGdRsvOVtbLLX4bj5?=
 =?iso-8859-1?Q?+PHJSN/hX6NlXal9q1ZwTZEE7Fc2sx8PedWo2hOZXwj6EoNXFoRIW6HvnZ?=
 =?iso-8859-1?Q?hZ4BC8S4Li1RH/mmIFOSQmoyI6qJgBXP0boCUOfPkKL0JtXJhLlo6lFiDW?=
 =?iso-8859-1?Q?7Uuk6a5TR8/EYOQ1tCgUHC89fRWH/qABe5f1EnLERMUXyYFqTwdDChmo8J?=
 =?iso-8859-1?Q?3tuiIatSRwWMSJFhi53ZalfyVvo3wZ7RPpmBkXshOz1jVGEr9GSEWUivgh?=
 =?iso-8859-1?Q?j5kGtor82qqyb2mTwA+rn4+00Bd7IIjysYMNBaaWqJ9BYslk1RDmN3GkTI?=
 =?iso-8859-1?Q?Tzz9GQ3lhT2TCt+j2DCyTM5n39spUHkaM+2+cWfvVtScDu4trBb6Vn3VLY?=
 =?iso-8859-1?Q?SSY/k1VnI2ojskludpgQCR5KBuOdIIrYgIkLrfRRkVzvz6rlw4ERnzN3Ut?=
 =?iso-8859-1?Q?3ULZ59aRb/I2dhVBD82YnC0MFmRwFxtOuDurVKmlaHpqyHK+A3qlircBbj?=
 =?iso-8859-1?Q?pKeNqe8yxzmUMhYVA3yGc+pYCjKgUnyDzBSzNkwbpFmUva+/BLALcNg5tI?=
 =?iso-8859-1?Q?8LuRxmbJvm8z+1tPI+01ECOQvNwg6ldF6v1+NbW5R9NtVAMnH4lr/UeDQh?=
 =?iso-8859-1?Q?2sKNz59YaW0jkZDw6dCUsn2WL541y6jqJLUf0Zwjn5vni3taz3d1mqVDQ8?=
 =?iso-8859-1?Q?khBBqN3jnHCZNmGSlFguNH7OEQFIMVxaA1C4K7e/FHMpjc1YreOB3YkbGP?=
 =?iso-8859-1?Q?i+ooLeuZis6xCRnc6/cqocoQcBBWS+o3EQ7lQHy3WWLmxwGQ5p9BZe1g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L7e6JTEeHlMt8Al6ycnhZgrSimrttCUwnbRvkqqr4+qXiNF0C4IaDdP1kAKjuPSeA0aRqk6nVro8A4scqXS9V6Xh1TqrVQ58JNUD0xgm0D4TKSP4Ez7asaIkYQy0psLVIhZB2+XdLuxzQ90AJ+9dPcwLjZ65Q+eb+wDgl+Y8Bq5ZpjMC7ojTYEjsYz3h3jWhnUHJQdv5XMLdn348MyD4kAEHZUjV+3VMo54JFIRtGkQeswa/mT55PSj0yMOutf9Q3jd5Qu6wdyjLJMo5BSV+ROCxq8BPAcn78vdl/eg6b4sEPTK8iDrryweIqfuw3iI0+UbvRIJsEixvEno3xSX2W8ORuKNubn+Vu1scQJgn8iQ0lX9aftzf62XniWJRNOzuYXpzVb/TQrmioXiK6YChfsZSQ7uWHq+Vrl5M/mQGrjf9Te1BMJ6pxWUojDZ4evN3GzNrDtDeBQMEN5vmq3vElxgq6pZbMhfluI9vbHaoFF81NDmI3wts42kcm/mVV55P39hr0J9gxt6CHFGIdhhZYTsx/rDkcgw/s/vX+F63ksPEVMiRpwyx35GDctOqSSzEhfAddpdO9j7dneNOEKCynpTLKb3BZIYAqnrepJWEQZm/VLUiVJfK1vSMUPl+TL0nwNkP2gSLfwn5Vf6h6b46yXsh4PaJjespaen0p85WFSYOy9JyNHPkc5a8LVQN0WzErp2Qg315hxUg3KmWkms7d3X1WQxg1v2bWABviicG/s7g0C1E263DWA7ZnD8oFDQOahOP32h0DiygTptROrmMFe13exTGUU/s95qw+Gk3KZEGGfvwCBwovq4ZvZ7z5v/k5RhhAiAetcxvmSqPlZdEoAejQTXRmDUcXc+vEnBbSMgJR7AxrqGyCwPSs0S0WivjBZzdlrqSJHSqP8a+FoKTTw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52e312-66cb-4257-64e8-08daef514b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:01.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oa2JidCMWZIrsDpevGFOOHv7RG605WgbRBvnYaW8juVJ2v4JM+r0y+X5pSln6ixsw9yRj5o5Jj881ZQV4Njw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: G5dIbouGRn5U-RuP35IOm6lqqCvkakxk
X-Proofpoint-ORIG-GUID: G5dIbouGRn5U-RuP35IOm6lqqCvkakxk
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

Use the vma iterator internally for __vma_adjust().  Avoid using the
maple tree interface directly for type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  3 --
 mm/mmap.c          | 75 ++++++++--------------------------------------
 2 files changed, 13 insertions(+), 65 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 71474615b4ab..28973a3941a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2847,9 +2847,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area=
_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
=20
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
-
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/mm/mmap.c b/mm/mmap.c
index 8e7f4fc36960..a898ae2a57d5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -494,56 +494,6 @@ static void __vma_link_file(struct vm_area_struct *vma=
,
 	flush_dcache_mmap_unlock(mapping);
 }
=20
-/*
- * vma_mas_store() - Store a VMA in the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
- * walked to the correct location.
- *
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_store(mas->tree, vma);
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-/*
- * vma_mas_remove() - Remove a VMA from the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
- * been established and points to the correct location.
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
-	mas->index =3D vma->vm_start;
-	mas->last =3D vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
-/*
- * vma_mas_szero() - Set a given range to zero.  Used when modifying a
- * vm_area_struct start or end.
- *
- * @mas: The maple tree ma_state
- * @start: The start address to zero
- * @end: The end address to zero.
- */
-static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
-				unsigned long end)
-{
-	trace_vma_mas_szero(mas->tree, start, end - 1);
-	mas_set_range(mas, start, end - 1);
-	mas_store_prealloc(mas, NULL);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
@@ -703,7 +653,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -788,7 +738,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -834,7 +784,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_mas_szero(&mas, vma->vm_start, start);
+			vma_iter_clear(&vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -844,8 +794,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_mas_szero(&mas, end, vma->vm_end);
-				mas_reset(&mas);
+				vma_iter_clear(&vmi, end, vma->vm_end);
+				vma_iter_set(&vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -856,13 +806,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_mas_store(vma, &mas);
+		vma_iter_store(&vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_mas_store(next, &mas);
+		vma_iter_store(&vmi, next);
 	}
=20
 	if (file) {
@@ -882,8 +832,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		mas_reset(&mas);
-		vma_mas_store(insert, &mas);
+		vma_iter_store(&vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -929,7 +878,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -2057,7 +2006,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, vma->vm_start, address - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2139,7 +2089,8 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, address, vma->vm_end - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
--=20
2.35.1
