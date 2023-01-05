Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CB65F451
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjAETV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjAETUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B46D53F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:49 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITxhn029133;
        Thu, 5 Jan 2023 19:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=243tS/T1F9l6g47RsLtVG7etDV8WRpTgO/rf9piXa7I=;
 b=kUTv2DV03TBZ3Tp7/xuZ4Bhflu0MqP68pN7rs2aJ3z1zFJkeNMLc7+miKzUOifWDF8Lm
 /VzE0mRpW8cr4DZuROj5gGq+n8CF5PKtPpjeZzXeJXYd9TEilcYnqIdRub7KEog3mIwP
 revppMlKY+Eh3funiEN9XnMC5jFoQAX783X6DFg0NRXKE71WftZV/L56AdOwrox/xrtd
 ESIjW0i8BgvhHnx8q4iqEzWrlnQRpk0u25tdCaZjeUJaZUSv227NF7m3WmZ7CkBULCng
 PAmSZjN50/NovpEEb74BmSA5sw4T224StHKC3UieERPtj/OwFbyDQyiE167yyXN6qeJG Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPl033688;
        Thu, 5 Jan 2023 19:16:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJprloBZ7kEzqBpDVKYAWqdA1hylrszm8EYgjm3IV0+m0owRhSNr6o+ge3RThY3ML5UBGyQTV0KR/E3KQ4eLwUpRz1eqC8i66JXX4JoBrxKm3ch01t3yWOZ2Lg8jf+NOIAm/HmASdBWuGmzfyq3n7yMiJPKkZvDevs5W8Lpfrw6ZZECCllNWGlO5m4UGamf+0Kx9TMTyxJEUANjKcRA/M05qU7K5yZuKeWfgWzFa+/eWJ4OSsrWour2fKyb84B6AI3xnhGuClllEneiZ1ezQXlbZ33RGlYRozc/X4kdLvRfjULCiUd4w4VHyADxUeGtwTqshur/v8fF5n+95XMehyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=243tS/T1F9l6g47RsLtVG7etDV8WRpTgO/rf9piXa7I=;
 b=eljM28I1TUoUBhGbxOX5J9c1kRFJUSRU7F2O/rW5V5vY4JwH6GIrPcaXwFZkxHlK9CRBb8OJF5uVjh4zfkZYgYCtzBM3RGEMuvLKTF3yqfs/vnP2/Z1HShVJjZplKgj+k5F36TTrPNts5dKQPu65Oke2rGj7/JvYMyN4RSEFxJDBvhR1cI4GMLLqox3uaQ0CnFb7I6hSOBUwfZzA8QM57LypJOY4EIUV34j1O6SR4Ka/ogaRpFK6wcO0GSLZnXpkW2VFImoZ6m62BZkHTTyYHYhmCPj8N8q/6Ebfiz9iH3Xv/pmReUGJ48KSUYoC9/9p2bgMglSLbcSL3PrPSShArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=243tS/T1F9l6g47RsLtVG7etDV8WRpTgO/rf9piXa7I=;
 b=DVctm0WJuBzyVRzN5877nIT9J0PFw/X2akLQmIt76Uk4x3DuYUYPMPxIqW97poyeYr+m1dv2aR1XYK/QIg7z+pDLiP4xBhRSjw0dE7PeXUNgnKoTp0VoALRtTFyk+ipiqC/A96vC2iX/JuNkcobhcBJOXnakdJmZjLBgN6tYmOk=
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
Subject: [PATCH v2 35/44] mm/mmap: move anon_vma setting in __vma_adjust()
Thread-Topic: [PATCH v2 35/44] mm/mmap: move anon_vma setting in
 __vma_adjust()
Thread-Index: AQHZITonxl3AVzZR6EC2H161WYt/yA==
Date:   Thu, 5 Jan 2023 19:16:03 +0000
Message-ID: <20230105191517.3099082-36-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 850ad9a0-8fd0-4638-0fb8-08daef515f28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71TpEkogUvzUXtK/IphAtECsWQMxuUnnM20qhIJvzhAsKlYMhPDTQULrXwEG4ykRyxlZVHmDb7oK5Vkk/VHp9mVlY+MrO+SXZIBY97YUdeAuXyPgHr1bcOZvf7YJAwebvKCoB9JT4T8Z7lkQkYrARrfiqpR6fxg3yVaEgA9DVr8qi5lWdcwkapoim506tE0YpYyWRoWaqsjZrW1brBWQB+DfI2YC/G8LRuecBEeEU38ZSajM4L7+DlHS/OwXfVwnlnP9MKUoNsvwcwdjzM91wznB3UKH+T5WrCbSCfZKDuw3ZUA8awW66HShrh/9Y2l+fMMAt+Pzo1YIsjV5DStG1tSsujRSai3a/LinCsacz7YUKEJXWS7Ttn1cfZYDx9Rw4XZTg62D3KfizBGkQ8LEUH17/xpEPZBOkoJ1zroClAaCXC87Stv4vjWcIzcOxu+/6fSBzT7d4kPGasyeqq2Yejs4r5axrHdG2ZDHPS8G5fMG5w1MeF9+SCPRM1IzO6hDhenyOiurf3CFmsX6ARGDlol62SCUVs7HVUrP94l78FLSl+xUtJK65HHd3F6XXDDoMTso8ClQ8elrLETUQeDdfpiekgwVmxsxfzj8Rdn3C62nWifGZj3eER0lnI6dLRsPvzc8AaiaEO1ADJmWONKJHJnGlWXO74Mr85wR627ziGQPLHiPHXTfjJ8VTTreXzPEfXbNkvv0SHcAtaAR6Tfx0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uEcC+vOVlB0a2LxhiI5zPOu+an4InSf5me/FtTpwMEdbCeMB8bQ1bdqumL?=
 =?iso-8859-1?Q?BzvFsygnmzcGr6K7ZNqDdZUit8JPFZJ0rEKo9mJL6u9YQOIJrFUZ+Ush+S?=
 =?iso-8859-1?Q?Koac9pDQIE136u/kVFaxf4/oqbFd5rrEP+Ilgi2/1urMufEUBPIRXPDwsm?=
 =?iso-8859-1?Q?E73eVi9+wIkd1ufp/4XFYDW3NQi3uUzctiiFqAWdwohtrC1Lk2Hx5ZAkS2?=
 =?iso-8859-1?Q?ZtjV/z0iZN2xgBUgBdA4KsG2LBXcbmBvS1f9Vcrgvn7UwJWpI/764eVyp5?=
 =?iso-8859-1?Q?k1TfxuiJC6VKcm7rKq52C6Z/xWbB6eMFS1ESnVOPCazRkDFj9Skxqmm3Zo?=
 =?iso-8859-1?Q?hS2or9503jiP+ly1ZW3GyP7p7mJhV/1kwglhjB9r9cFo4++w0mzD/kSta6?=
 =?iso-8859-1?Q?/yEQ8ZfgGMA1O+zLgKMaAKR7eDcBKBqpeB5TXsQzzIwZH6BBoqpeetmGgR?=
 =?iso-8859-1?Q?z5nYguOqhFJTBlZi7hjjlQH/xoCtH1Rat6b1i5yWROFVrxpQ59hfqklPtk?=
 =?iso-8859-1?Q?Dc8ftrXK8z2p/c5EQXiC+Vq1K41qZNY+/e3dbaDCb8gUyVCHV6yD7giyrK?=
 =?iso-8859-1?Q?4TvMO6ZEM1L5B+ap7EDiYRLEMyzNRn46XLkVhQFO+UKozLyf1waOKi9suj?=
 =?iso-8859-1?Q?ZwZhZ2RRXLUAnY0/NpGSm1SuN+42XQCkzbcRVHDNmfktwPCjX5t6vMyLU3?=
 =?iso-8859-1?Q?toaxMR9kRMlHPrvYhGJqCoMlzFH9ofOOfdD/DXmjzvfAFCgW3+5QMPj75T?=
 =?iso-8859-1?Q?JWRdpzpSlMb+o+vCXNBKkF8Oe4GI7xwFh/Lg25XJBoN+GTnjLathUWcFAd?=
 =?iso-8859-1?Q?BH9yCZZ9v5py4WPENBi4cGL/RzfO6ClQflVjBh500PVWOYS7Ick4t8IFp5?=
 =?iso-8859-1?Q?QkiQ6Evky3vleDBfDNu1TQDl9zIDlYoLPwYjIEA+eULRfLd8rKIU9HQMNQ?=
 =?iso-8859-1?Q?dmXhSIFGliN/IVUFzwjdU9PIwkjqQtyJlv6T5+4VWzIU+NgxcVmcX982Ve?=
 =?iso-8859-1?Q?lSaXk25qltYoM5yVxdOMVaMwjKFYHke3d3PoH7YcXMdnNPkfYGOfXoSZqs?=
 =?iso-8859-1?Q?fmfxJ68DdTzUvJCiApz3QrKLwTzA7+ODScAs7980zO472bMg3/bI1QO4aI?=
 =?iso-8859-1?Q?Cn8gYQPX5jilZVzMQ0dFP9r664kgITGUQ7iTFAD4SvHsyv6cr89FWgY1fX?=
 =?iso-8859-1?Q?ldEuSx6OQBxvCFDfoywBCU7yMZmRIFDq0CmDUXSVen8R0FKA9lr0Bs61CU?=
 =?iso-8859-1?Q?oTdx0QsKV8M5rWT2BZ5Q5k8qaKEG0loE8BhSoePNlWDehNL0PAPHCnr+zM?=
 =?iso-8859-1?Q?MIemnj61GL7Biz8J89mhNtqPn2c58WGjiAQYLqOkOISFu0+IunK11/NQ6y?=
 =?iso-8859-1?Q?lQt1aBqpfzgQ+E6wjKAWdcNUioFp46KxPlUffqikVXbaWKJzNhJmNT5pjy?=
 =?iso-8859-1?Q?+ZjuZPCghGlGhKd9im7kWSo886pEJ2uqdqbLNmUKvX76GepB63CHRZCD6v?=
 =?iso-8859-1?Q?t0DDOn4g4dB6/1GXo2HjbkxqE5qrJJwUa5M+Bxh8lrdABKTRynXrRZYYcU?=
 =?iso-8859-1?Q?7JzSxySSFTq9Cm7PXLElqkI+AhfD3xHLTSLCzi/tH2Vod+/FGgw1sLtkNC?=
 =?iso-8859-1?Q?jYGsqw6sv91lbuqaJ9esf8WStFpXyg9PJzSkrN6u4C/Fh6lHgslqdjTQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HwTGeRBL/aFng8OKLoavtT00qPixbHe8rBXo4Mn9YPyqt/+3TXo5Emc0XAEsSJsLq5uOEsdZQ/jSNCKOZ5Ca7ru+k35eTPoNlnrxZQcbgWCUZKPnENK6b3CvsaRxlqqx6noDa1xZ9fdFeT7kgGYT9CeXK8xM2CoNPtEAGZLhCRcFdTUKJSGCu3I2+PRdvnZsk4kdcuzhIPz4f/WUq4f5QT/oLpbm3RaFAZOqmyE+6/yomhssCkxxx3XyXxYxu3XZs2Sh0DkPvYNO9XLMOd40V5X1esKWvTiqMfabmxXLt+aGs14kYycVF6dinLZS23OL8kN94UBCoBm5bmbypxEVpOeE6l4mKm4jNAnw1dHGXz5F9/ACk6i2nCmcHr6qhOLcVU3wnRHvLKzIm8wy65MvSISf+jyaoDvqRugrLnmXK2stwpvb7g56HPl4ENuA+PgOkNiMHvuXqA8kHxgeEs+7wlwN4lMrBi2W4+3RNS7PRdW6Bn33XKss4YZXsdHBE0zr3/sVeeW9TwEEw1Mma0PkvfpJ83R8oKtsHfyRpux5J2JmTouL/RFkQmhXJogSP4nakqCCmywNiiKvQ1tOLzVPC9I4TViqJIlTB+qxUNLrWh79eMPtAePodWduBgDoov6E4pVDinIzytxLOnwsRldvQ6M5jNz5W9bcGY3VN6SnxbmIapAscAQZdrL9ptECtt2It6BWGbB6I9xP1eF5dv7fqnaXqFVGhaFmbztfVwXCDn3kZR8/VQVFKvFFLgMJosKv8uCMHz7l0acz8mWDzBInvh3UGxQ+aJzadR9i44xJh1YNnx6FPzEKCvu4lnD8j1r/fR3aBJoKA9IAYxiFFxv3gPpspW7dtYo0pglesZGNEBMDpuR5yCk63t/KJGUQzyVoo9u0ih8DOsHe9E1090ZGRg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850ad9a0-8fd0-4638-0fb8-08daef515f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:03.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0RZRcqKn1L3XTX+NyBz46yuw8iYvXcry6YUUAq3fDNte28oV6J2HGtsTRxujdmBUKyiiFmpcInVcT9c5lbjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: Z99v4kz7aAHsKq4szB2k2FXg7VogM_0S
X-Proofpoint-ORIG-GUID: Z99v4kz7aAHsKq4szB2k2FXg7VogM_0S
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

Move the anon_vma setting & warn_no up the function.  This is done to
clear up the locking later.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c1796f9261e4..c15a04bf3518 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -744,6 +744,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
+	anon_vma =3D vma->anon_vma;
+	if (!anon_vma && adjust_next)
+		anon_vma =3D next->anon_vma;
+
+	if (anon_vma)
+		VM_WARN_ON(adjust_next && next->anon_vma &&
+			   anon_vma !=3D next->anon_vma);
+
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping =3D file->f_mapping;
@@ -765,12 +773,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		}
 	}
=20
-	anon_vma =3D vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma =3D next->anon_vma;
 	if (anon_vma) {
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma !=3D next->anon_vma);
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 		if (adjust_next)
--=20
2.35.1
