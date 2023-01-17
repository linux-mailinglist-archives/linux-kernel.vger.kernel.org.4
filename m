Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A666D455
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjAQCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjAQCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2EB29E33
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H0924L023158;
        Tue, 17 Jan 2023 02:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=iEDQyoedJs31w1dP92SUo7aQpiRfAOLdd+WoAAmJKZ4fEZMMLCq/qe4TdWQIMJkiLYeL
 7w2/YpiX9tcedsLIi5cK9q1sirpdaR9TMLhTVUcFbcSe/iCWSVrgdTD+hYx9wcNoxRA6
 ZM/VuOUsXdeAnoGfXGPTpcs+fzAV75oIhS4ad/W6nS830tmDN0+R4/I0VwJlHrbZFo3l
 PjfFQ3/aJv3uEV8+BA7LqawBMSEHHjPa2NRmQweL1pC9/B5Qk17nQokMpDCzEODnsnSb
 M0Qkhv9Sfj8Li0D7iMkICEvITMY70XIkw1K8LIv8JwR5xaBUSHzokikoPkRwtCxGAzcW 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rf028480;
        Tue, 17 Jan 2023 02:34:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku/dyQigxC6vFFKptx4imBZGbgfoJqxmVWSlYmmsfJgT1QoXIyVciqo4bUusk0p9MmAzL49vcdDXURn80yh1NKUH/OKw3URMxetsufYC0oeb/aLJA+C5FHaC+mF+J1/CVR/HtS5Ow0/zVUdbDc+4xG2R4ND0wnGOgGuvtY8sp3hu+PGFMdQ4JT2OHFFRqt+JYU9lz7NzQC0h9yZ2TvB6989W1pGJtMYebFxCeyS9tUyz93KZOaN8/HCQHBJoTghlKo2qDRx6tEMxY6Nbq2miD/8fbRyYGGfeLYAGS9PjTlDkpKTfIVCqu6coUkF7aRzy1eDdlVimOIt79avufNvRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=D1W8i9DYNEExODEEtz9lcUxB9LxrDv6jkjTVJF6SQ2QkspSaazQciRhaUNVCxAO9uePrZ5o/ln6sjy4ugduc4D66CVuWxpV6Jt53pkekFfRpm4jD/L3kROCeRiP0Wdzswj072MzlaoQV+kZhQ00cdYmHhSY4njvPvUsXJwRQ8Qk4lASjoVX/yY+cqNOxH/eR2TisastOW8Vn0QHwszh1PNNmPDHGGYV46cD43juTzcM0piLAl1XSPfvYzrB/LTKcYo4AW3tk8JaNKURxykAsrZAeDgERWuahaQOYIwCUL3zQtbh3D6fJ/1mjJEIq8HAFGyo57zDLitHX+yI6e0G/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFpRUc5Oex1lM3Q+9B7MFquPWyR86idsNW2D3KmMUJs=;
 b=cNJo5bHS5Kjx+x9svquaq+cXdPUvHBcdYqLHO7BJR3BiYTghbB5g+dmPI2qIGPl+Anv0VBFUWhU7lpolrmCt+qveNuxm5Xv9rohIo+9gP+STtnyCcNDooYIdK4noaOzyoncJxxlwh00ODyRzfgIZu1UP9NLjs45nqj4LCpDbvn0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 09/48] kernel/fork: Convert forking to using the vmi
 iterator
Thread-Topic: [PATCH v3 09/48] kernel/fork: Convert forking to using the vmi
 iterator
Thread-Index: AQHZKhwv+rRLG2GBJ0aYrHdykImF1Q==
Date:   Tue, 17 Jan 2023 02:34:12 +0000
Message-ID: <20230117023335.1690727-10-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 20151e19-604b-4c68-acf0-08daf8335276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BORx8JgDeEmr+d12ZHDtVa0ZEexU3ytYSQIj973hadToEhPl9oJyXNxUqJlLY0VeBB6eNU/VP8h9NdjwK8OUqQD3g5H9Tb0r/WIjnW/eGd3adVLBcySR86DfZ9A0/fwcgg3YcOIPi6fcnTM+f+lp8JtIyw/cy8nL1FtU+rRpA1QQp9+PbBRIIpoz6lyAHHT4ohPai/DwsZULLOXjjmUfZkRhqdlCYAeh7Bif+j298dyb9E1dF68Vu/gRFzQn1lhNHjnXlM0PNlUZSS6RNTE790vqwOzAWjcybWvmrITZPpY9xyYw46XeQlAV052MY5leZvw1MnPqf0Gn7omGJULhhsGCJHHNUdpzC+2Xlxl5xl66khAcUAXwysbJZTnzQURkxSIPtdVB5EwOUyAoxAmES/v00203zP+X1v5jooVQ0YD2I7USSdtvSbIJX/RZMSSi1xM3As213PBAZVF20+cFNUvr+uwFmIh3JTCmwfv5GV2opHdKNnosXdlO6D0RHRofr2orArVUUuWeQhm3HZJDiUI1RLr/FRvUChOrzXzWK4lmWtNGVzZFiTX9U7a5t2oy9V8in1yN6u1UsY/wdYrp5yPU820+lb51127efYLGtQYY+AwoEYbjW42I8SDOZ7HnwEI6KEKeKMPNyUS+9zIMuD8bAJYBMPdV6v4WF75lXaUe/FdyO7jFX19fjTeyedh6wrepMNToqmnGEGaCjFTQCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TROUze5cZ/wMKCen+7IR7QttmkiHHFNziUv1QwNAgN1Gn4gEray1bcoBGI?=
 =?iso-8859-1?Q?09jjp5iED94HD0Id8OJPyNe2+zSJTh30QWKJmyrlXgYoQ/ubf8gYpmzufG?=
 =?iso-8859-1?Q?WSlEkzqY4+eILm6tkNAseLeOGu+lxwOnI5TPQcU+BunSkzHs0mvLWGai4V?=
 =?iso-8859-1?Q?Erj7Tyu5Q+UA4+zFvvy3VQWjgE7/TZTZ6OhgJhmF+EThFBIt/+wWjFAs5Z?=
 =?iso-8859-1?Q?MYTXMhHxvHcIY9X0Jc9WIMCMsnXwXNW9xm5LejF4WucQdaP8KdcMidTbae?=
 =?iso-8859-1?Q?SumMHUR5wPs7HQZ6Ao4F4+I3K5MW/tFhXnvJ0buGFCmOwnY2w3+6U2R7aC?=
 =?iso-8859-1?Q?eT72NOwKMxPBCUJkETCp0SG2CRZb8bjN3UnkqaRQiHwSCIJH8qQkGF/jFV?=
 =?iso-8859-1?Q?kBHnFYR8cUPgoiE2fcmdCGHROVpLFk7I7J2eTi24GzCoMIM3rm2cjjamsN?=
 =?iso-8859-1?Q?UUacNh5P9n2vCbLVPQxcVmk0nOFOALYolCeIs+dQjQ1QoEZlAqkRJyxHMM?=
 =?iso-8859-1?Q?FvC5jE58soxfFLlk3jjFymBhQIlMJiEZaoUvUq568nNvNDU2OUDklIZCmY?=
 =?iso-8859-1?Q?4HRxMkmIdTlMA9GPtSsSM0Kpd2vIq3kvbP3XF7ynqFCD8GIQqT8SbcZ97U?=
 =?iso-8859-1?Q?8qmRyhDTKvqC54OVEkCfC/Ok5UNTV4x9jIuxNPdKGrw7Ikkd4vH1OTLjIb?=
 =?iso-8859-1?Q?srCVo0qiPOq/dBBGc/5kMWD1RlqAFY17O9cGj4HV49/pvR/pTQupN5U4bn?=
 =?iso-8859-1?Q?zWWPKXdQsnqTn1MxXcKtuhcCmxgnaoX+F340HWTA6JOvgeXxctaeHl2c+W?=
 =?iso-8859-1?Q?a2ho+EX0PQcdmzhtJekC4OH4j684+uu0erdOMWQp8UEm+MiXYmJQJD0D0F?=
 =?iso-8859-1?Q?i+sIU4FA5tdhCyOcx4WiDySIYexxop7lsr507fs2zEWktfQYZIxxOWE1cf?=
 =?iso-8859-1?Q?vSJ7H9cCmlf6fbd3hDUfVQ6U6FvbJyuicGBtPJOncM021ZlApLCdZnmFTf?=
 =?iso-8859-1?Q?m7Yg2DexCdtPSQBZhLkHHcJupwvHG34vgXAU1j9f+BYDRWKoHun7KMQNVz?=
 =?iso-8859-1?Q?n8RdEghi5btPJYRIodixDIxTyJQoa0J7I2VN6wQeazk4Z53E1Yav4q0LlT?=
 =?iso-8859-1?Q?fkp39xs9aACyXQUlq8unqA5BSdLoG5i8lHS94cwDiYROiewGaMlWkUPJHF?=
 =?iso-8859-1?Q?2n4B/XkJRzo4rYSJef7vzGrViiwBqMSwvF/raxIcdL5xLdP3u3cY6RK3li?=
 =?iso-8859-1?Q?oMNJqxPV9Eodehs/7wVYlMNLj6z3bh47R4VabJ8ylFTaOl7/6AJQx8FWPx?=
 =?iso-8859-1?Q?ehTKFVhVzHG4Kqk8parLSGGWlnVdRGln0+1L7kj771fjDJlpw3c2uMop7h?=
 =?iso-8859-1?Q?ObDtm/sgtEWMlz5WdoL8AZOBFk74IbelZuZA/dPNv3Tv+tPsIoaDzEwZMu?=
 =?iso-8859-1?Q?2p/4pyxyiN036hqwf2hV5XoanyRAZ0BDSl44bvECRzaqrhVjx4CSngQcE1?=
 =?iso-8859-1?Q?uNA/+2JZtdyX3aogaP7I10Tx6o8o4A+GRnBOasODR23JDIFWi3Kt1tmEFF?=
 =?iso-8859-1?Q?e4mDUR9y95yeLD6iUHNChqm1OxGio+DgN0Hq58/qmxHm794S4TDKOl3sh7?=
 =?iso-8859-1?Q?4CKOiYkpO++W+m727zQTKcd7Wf/OOrxwRp9gy0THy6O4qYXAahNjQV/g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v7GJjiVRenlfl2AzWjLxzVie1xh7SGyDz1uRTfrghe4r8nJr5+pduKTUcWS9AyPpSxfcF8Wrg19b7oVZzLc15qgtWaj/yciqNKa0Hu4yMFjYfs5FdW+KbLtsDD0MTfbR35Hf25cCySTu3YiMm/yo2QvxT73Gbl6JBW9GZxNh7BFoQd2EZjITZUVeFV7Z7owYNiz4/jwPi5WV2FyCbyhnf/udMBusyLo6KIe6vTXdRHr8/JYQYIPv28pofuEAmitl66fyrKZSneUEgfnPpO9pkBpGJUMjYYBHGvj8Jy7yq7VpSoMfPjuZWshR7HJTKkb6wwY3URGGg9wMpAdz9cEjA2yQVB7W0Kuvhi6vFtUV908F2G/ycu+ZP3dNCIC6eacOtusBtrUla6tQnDZzamQBlb/V3YXzAJ3JPHJ5YD9JQScl94MdwXjoaaVnjsg+v2/wbe7/3O9Iv6L1TjrqdVAYgAO+54YYe+3ukK6n4y4z5Evn81k9egclbo7NkkHuMwxJMj0BJeakUEPcOVFkTomADisxUdfHgrb/9xJFP2MPvWAgDGhP4F0WEz8bdU9XAeznqbssloKWAT9ojj1e3KR9F0Gj9V51cPXfkLTl1z2kFtVXCP9dkXTnrBLvSDryCNW9oKDD8LmpI6ZENhDF0DgcWE4KH/lkOT3x+eZHSKaH1/P03MjEVWjXnlBJTSJMc5eYRgryoyxYIqtqhe/fLGWl9Pv/uJljbGFHFYUdsiHmapohjkimkSUcYJmaZE3suBfAsunOPiXTQ5LmVPSbzajLUHdqg8KYLpxjMVJ9mWQsYtk/SKnbxQ67mkQDpiJ13wzv+XOHCYJF9v0Wa1zsj+d7NQjwdI8uFf0PAOfDNh93J84bzpTGfsHcR1DY8argr0ZY6cnXLIzBlcjYsETrv1Svwg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20151e19-604b-4c68-acf0-08daf8335276
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:12.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDqxRQFt9sD0b+BEM3dYmzdeaboi6kpNGI39WMuJa2wao6kjdB3NW3+N/Xhdx2ZByA9PXBHXzF3NsShrWwG0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: dAq5btFyAjlMfr9h7rMRKjosWns_DdiK
X-Proofpoint-ORIG-GUID: dAq5btFyAjlMfr9h7rMRKjosWns_DdiK
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

Avoid using the maple tree interface directly.  This gains type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/fork.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..441dcec60aae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -585,8 +585,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
-	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(old_vmi, oldmm, 0);
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -613,11 +613,11 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
-	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
 	if (retval)
 		goto out;
=20
-	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
+	for_each_vma(old_vmi, mpnt) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -683,11 +683,8 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 			hugetlb_dup_vma_private(tmp);
=20
 		/* Link the vma into the MT */
-		mas.index =3D tmp->vm_start;
-		mas.last =3D tmp->vm_end - 1;
-		mas_store(&mas, tmp);
-		if (mas_is_err(&mas))
-			goto fail_nomem_mas_store;
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -702,7 +699,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
 loop_out:
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -712,7 +709,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	uprobe_end_dup_mmap();
 	return retval;
=20
-fail_nomem_mas_store:
+fail_nomem_vmi_store:
 	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
--=20
2.35.1
