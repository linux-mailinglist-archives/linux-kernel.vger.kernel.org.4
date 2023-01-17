Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E966D460
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjAQCfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjAQCfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D852B0A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:30 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H091bm000974;
        Tue, 17 Jan 2023 02:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=EQEq4J+xxka1oSunts7Qe47R0g1R89cebZvFbF8UCX+XVl9zi7LPBM8/KIID/OMxJ2dW
 hqFzWVIeNBEcdADqQM9PDUYWILKAmdufsLPL0UghUnXauW3fgmcuwp4IhNyZKiY+SUoJ
 fS4dbqV6X1bRxBDAJmOSLpo/pzbzfYaK4qD+iOV9TO7TTWi2pQ3Wuw8No9DTvAFwzKWj
 yckzqdSx9FFSg6z9DdRRI/bRVKVM1WWC0iOSGilBJXamV7vZtXx39Y75DgB7MjDxA4d1
 YPDiaanPwgiJXZw/LH8zVco8ZHYza+1VblPy2TqAHq9MpInNdCRTVGL+w8qjEmh0prXs Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUV020577;
        Tue, 17 Jan 2023 02:34:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1jEulEsnCuJhBuDTLtTN3qqhfxMbT7pWn9gnd6/rpWw8D7Ylgf9VN3uj0nGaNM2R3b7hHV4Ww7knwr7JWSAvtRwwjmfbyD4Z+7iduAQWwW8B+SlrUsJzQmKVK++iI6OIycu/uttsAKT1+/51lxVeZXXrBj4q4JNczdUs0msODAolcLp/1s25eKj/4Iuaf+ernM8pYK18LTyGUKiWFb050JojyEJQFb8k4LtwpEctJPxCrAj7xCo2p1kwKHOgJgvg4RbeDeoQJ7N6W7JgmRB0JznSGhBoCm4+u5L8+k+vmuL7R0sRxg3xgSlAfTuu1mo1VrlaUht5GUh77dh0Wo75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=gKs/M1v9Ul1PxIyYBoerGCT8qmmMA9p7SFK1RVPcLr5+rYEsRkWbTyZLr8R/JflvXkPOpCUYI0Ci9nCU7MfenVPJQagvOB+QrR8NJiFwzCaO8G7nPWy3bAdTzr0u1RUiC6MlqjTa/UxyNHniDLfhypmFmVZcXA8QT4/SZRDR0VWl9Zp5gwkCNPfy/tZcZI2ce7xDOQ/bd+eu13/Qmliwjb+2ENgVmOnYtvmUqhwXpdTrPusQsPmXgc7aKlX0FBPPMB9cbxGM0oYKJtot5il3aYE589qeF7PaRjuO7xDD8kz0L+Jt2pRf2uyMvalHBIMWg3nyQAGhph80QBmXlSgTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jgMvChxkwjpmNBsSLPkBEf800VrOzeU4TR5euk2NpY=;
 b=fhFcvHWLLwL/HEHvOJ/O9eV1y/W11nYJdRK9F40/d3z2g7m7OYgZfHzyY/NWl/Sk5ItYJRkaNb8tKqDSH1qomO08Sl1GZwFfFQE8fesvBSVlBdidssnACPgVeFdsRpAIJO4OeuVjr/lW4h+zKnuVqjOwePyfPvQWnxjbhRfqP7s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 19/48] coredump: Convert to vma iterator
Thread-Topic: [PATCH v3 19/48] coredump: Convert to vma iterator
Thread-Index: AQHZKhwx5K/ndsuvtUyB85QJDGkLfQ==
Date:   Tue, 17 Jan 2023 02:34:16 +0000
Message-ID: <20230117023335.1690727-20-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: af36f2f3-26cd-46eb-5ac1-08daf8335519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +N70+PjlhVDvU/9DWoPtrUSfs7F1BGJZQ4eLMty34Uz5T85eMcrT+SaknM/6Q9qsI9oFfN6bfMBtYYabVp41L6wXIZGMSn5stpMWAiu3Vn4knY6GTy/qgNHAYu5sRUt++4ei1MC7eTa1CDQ7Ax2AARG81ADz9a/4gN/W+mZtoGTTRaMmvsR/kEIn8h9PVams8Uj1HqTGDK2G4n6U0zB0ibPWyH68VVvXJ1EBn3kHmY9zMCcHYyGDbpl7Co50zi17czOIE7SPrp3bHZjFVyrPrcR1d2uJrPeoCR2uX3p/nt/IWyptyCy5/WpAFqrsRT+67yEmio4RjK6jOx3vxoeG4v8z0Texr2+QJafmpF24Cv701FrVYvKn7pCEX8KPx2yfGmDjBY9/kjss6r91fnLhQRQZyEdHbvmkJAe7iRY2MXtjDDcYSurHEVPi7JKfx5oHbqg1Rcra4FKDzc5ol4byccpBEEsurOON5Xqo3f+d+iH95QoBphjH+gL2c1i9lxAy3+XT5W+KpfyUTgAIy1JG7WuDIJQb1YkIdJvoZPZwB57ZKfnzFX62Q94px8jkQIK71e9o3Au8hKX8MyiKtPgxzmPMGPWiIf20RG+2FzcWoXTInHed425R1l7bpnz5VzqtPmlJjQfvdahwRv47CgwRf/TYas5WPRBDNhU/8XtbQa8owXfzC7l+og1KAGmwxV7GtWlBzomo+BxzE4KqNld0Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?as2fIsZFG7RMuWLqAHg+nVFLY1SDtgD9wcIltFtqxRohT90iqn8oo9nINt?=
 =?iso-8859-1?Q?ECHzjg97Bh+OMqPxkvZxlbjh374a7EloLP68sr19gequYaDXPpWbUu6yvY?=
 =?iso-8859-1?Q?w41xZQm9A4J/T7csk2i7wPWsXZHpZiQ/qE8HNK7L2fQEGU0sroPbhEHrnn?=
 =?iso-8859-1?Q?5C46UYCsK2AhnNbFnA0SifNU9HwxYrCPgrjo9bGFYUxGcyQu9k6M9iTUTB?=
 =?iso-8859-1?Q?KllYvaBbcSP04wc81GmIKyaCbDoW9XI9fhGzLcuY+ir/I/R+MR+BZz034r?=
 =?iso-8859-1?Q?7e3e7EWSghVI7RoCJ0GK4P7O5CmAiJMJQCowyL+lHQ2+FnlFF8KepeShv/?=
 =?iso-8859-1?Q?ZGKwAUph4BfVCu6QyzwEuuLxKSJBS3iJ5X/q5ylA+RiFBxReA5mvOrsuKq?=
 =?iso-8859-1?Q?U/XzkbjPGyTGHwzEGmFN67cO7I7I3UthnIV/ltpAzJLgiLZoLE2tyAiFsP?=
 =?iso-8859-1?Q?fTDvWAewlUTLlZdudjirZ9rBGtHoeXJ5wTnYYEHapS7E4IIh/N4Bdl/GDG?=
 =?iso-8859-1?Q?q3du+eSzY5cUjotOooYYdgVA3EXLwKnebrMPwwxPEMZbHQ9MSv4IFSmJsW?=
 =?iso-8859-1?Q?6RaxUc99RLam68ywCs2ht8FWvbhNwfbXiBnIAWVG9UgLsjXdoxB8Dhm1YX?=
 =?iso-8859-1?Q?87Vd1X5b8LNzlpepWVRAtt3NrmpINl0wLYqMYhh6VuElJpqpiuY0eFtQ84?=
 =?iso-8859-1?Q?U7wyi+4/BJEKygdLEW8CyfSmAaXMD6Pv4OwhfGB//4a1ZHq7N/LTSdkueF?=
 =?iso-8859-1?Q?yE22ywNkhk617bR769GUH+6h3EQXfLQrZTb8wlI3Vo69RaW0k/QHOTgmXN?=
 =?iso-8859-1?Q?YCwAkC1K3rkZdKkut7Mo7YmoroRlJXTesdAtPxBZiKKU4h6CAuCCVCg4dZ?=
 =?iso-8859-1?Q?10u+2ylO2WCA9JOJ1xRmD+bZ977cL8rnQI7SlpXc9gaj0+hq2CrpddDXPH?=
 =?iso-8859-1?Q?mzxkDXcy3Ibe2/YfuxDJIDs/RffCYRgWhuMQojI5YHnyrsTaDyNNQMetZW?=
 =?iso-8859-1?Q?Y611dyKBKTvYms59VxGAIeQ2vLtO3s0vaIK32w6A+RHYNMwS+h1g4TVh2T?=
 =?iso-8859-1?Q?l4Kz4N2dEAiGCSxZUiA/omGz8SGwrzVMlVlJuQPYWpnsz9Y8LW6H3DLFSJ?=
 =?iso-8859-1?Q?k+jDOiadt84Z+4E5D3fDxI1cXQvNdS56Yp0xwaTP/o4Qc6hQSOie6V/RZQ?=
 =?iso-8859-1?Q?nx+M5dzRXS4EIskG4S39SVy5EyhhNMjR1CSmY3r41f1SnEFzzFjPl67cWt?=
 =?iso-8859-1?Q?4FKI7jBnPuhZfyVvHTkX38EdYij8oKOb6rDtdvSN5sqI4WN1DSIe/+gDTf?=
 =?iso-8859-1?Q?J/t78vbehxkICeGbNVFGolGYi6E6uszdZixWXRe9ivh1SmXN9O4jnXUP0W?=
 =?iso-8859-1?Q?+qXrzR688MqUinmW188M8EKzHy8pf33JqWxTSy8xAdPFrP7HoEgmpGPNZK?=
 =?iso-8859-1?Q?EcYDOR3BH+uDOQR25C5JT2EK9dumzGK7IMIqQYyQiuT0eROml0ZEe3D0T4?=
 =?iso-8859-1?Q?vfCL0MVOI9XtX1YgcdduFMzf42ycweRqry5Uz2H8B3aUj3v5B6bzWjEUlI?=
 =?iso-8859-1?Q?hOG78g5XgHcvod69roNG+tsicipCm9UlWohWdWAcNXx7Muqrhx24MxmG6Q?=
 =?iso-8859-1?Q?L5HqzPhqoBTuo7FWNS2aLlDxA7mSMyvkWldeviura7TS2owx3f3Ud/dA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ojRBOWblCB4LRdN6r5foGbi7f4ksYLFkouWYuDg/yY+KwxRttdYuuXmrMsVbhvF3uicHwai6OackUJxdg0O9ajoHh9ezdAZgQ+AkGzxOxGQkHKNRISiqjwl6uKOL7bRsL40d0ufBJ1Mnc/WFmrO1xlnIqA70hMnruAaQdRZiVj1rVTJX8V76Yhn7wj6ftZMARbaXetWuE9NDBa3IsKIVYNb5SsIQTSZZfGYS0r+G848h9UlF3bEUwMQPXJOwKrikd93ZfVmFaLLDgfhMuVje6KRCaPY7npDCBoRJp6wtpv7YhasxcOpqqBwCh7Ck9sBKCkfJZKJModBH7oenSrBZyBOicqUIt0slvubKixi0pAyWDCGTujYo8fr67qQnZtuqhOvReVkKUbqcWBSJe+RtI0pueI+TdRwEogEFvYLNERP85Ww7siywjXTlVEP5A11BPnKcgWkfOalerbXTBuhJtQJt2eGbyd8OxXE9NX1qHoszDKHTn5JXW5CoPcThgZkfZbBREbMXc4hTRk42RvmuVp6wq+OjgxD97Lw9MhGjueUWx+hmD0L3daVooDAGP6MG0yJvI5b7JA/FyFbZwPC9tnExK5YPtUV1hDF0c67sLFQIZL8lcUSL/qt+Sbk5+8NHTm03jw1LojQmpHt3k/x0gUnjbNCt+d5xT0ZRM1mWEciLe1wv2/UnGebX7QMs1XgGq3QfcPoVzJeOhFdGu267I0G4bvsKLycqhbNyPzcdb0XZIZqwg4oNNANtlsA0y/6fKzSvVsmi1vkJUAy22RCQuORw8Mc/KjoJhxGpx2bFm0etMizKgtLDrXKwngLSzV3aWxHBEe2dfNKWXyiHtZ7/oW53CDPXE9b/dKhXAvWjVqDVXvhuGK5j4MfwXtYKWk+rbsJdmUzL/CeL1HT3RIWujg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af36f2f3-26cd-46eb-5ac1-08daf8335519
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:16.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PguJq81f9aRH/0cc7ZSvTnhd0t/Za2udR+6d6voGOuv1YDfFCGru8FOgKi7or2DyTrbJV/Xq1obLay2qjsNWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: 3o6rVk6iiPtRjsow9y0PYlusLDcxFYEC
X-Proofpoint-GUID: 3o6rVk6iiPtRjsow9y0PYlusLDcxFYEC
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/coredump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..f27d734f3102 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1111,14 +1111,14 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+static struct vm_area_struct *coredump_next_vma(struct vma_iterator *vmi,
 				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
 	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
=20
-	vma =3D mas_next(mas, ULONG_MAX);
+	vma =3D vma_next(vmi);
 	if (vma)
 		return vma;
 	return gate_vma;
@@ -1146,7 +1146,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 {
 	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	int i =3D 0;
=20
 	/*
@@ -1167,7 +1167,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
+	while ((vma =3D coredump_next_vma(&vmi, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.35.1
