Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA534682F34
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjAaO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjAaO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:26:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17838B52;
        Tue, 31 Jan 2023 06:25:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEDrl1014135;
        Tue, 31 Jan 2023 14:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jky++AjcIuE9IKZt7KfM6SVDxlBpDn2st7U7D6lAE6A=;
 b=R5yEK1uRKayi7smmCVP8RE+M2eFXs3wXh8+rLLPPV6MCuhqNluxHd27zmddwW5HSl9PY
 H2P8WdyLw3X4vzcbq2bIITvn0fQcCNzgWs7lgaPK5Qd/JP9lciGgd0Dpqo4NqGsow9//
 nUBz/y/B6QlnmFyUCbyCQlVLo3AWABJYssCvCd3J0SjRjFmrgTLG4mhGPqOU/zbgU+xh
 1u2PerTvuZzC1KO1OtSuLgxZoTfd1TTIMRe8qFsq1zi6fq5pLRzf/jjNGj196WyJW9pB
 d2yYTBffIw4v4ad99PVDTc/D2/LR1N6WnFH3INSbdSIq5geogW4AEvQ51P5UVh2RNWzW yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8npme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 14:24:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VDpg8V005367;
        Tue, 31 Jan 2023 14:24:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct55yj4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 14:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEdHK+jNsHNGSRyQhGt06WKFz9xGvdZOs7ZXj/Z3c7n4hc1J7SWDR0igTpgT5lsGju4Mxh9kl2jAsbToUiNDjMe4n/2myGmVo8C8zQJeNI+ngDaCb+3kp6KDK0LRG5Nl3VcL6igy62LpSGbgjok4DQugQjwfWwycw093QEfBUKzGAPnL2Zffz/5msgyquoTiAI3J8cQuHtM62qAPZVPo9SDxQ0vCP4nuQTWUHShCpiPGVUZSLAD4FEqfbNQY6xTlqPJRuh5QukvAXYaU4t0Ezhoty2I3vJdMiToPfjb5905B62q7cV7BY4TyyRI7swKAzZpCLg2lVRpaFYSpFAPb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jky++AjcIuE9IKZt7KfM6SVDxlBpDn2st7U7D6lAE6A=;
 b=aRVV6UydmbMCQMpB5eev8ugJV2xNQCWObm6Oyo5B9zdFp5svHdBkbNQhnpQ+F8gFOoLiHUx9C8ZC+Q1jKdoEYlOe0xXZd9gKhmqAk5sZmcRrfzXLgzKvkcTncqgxt3j+7giW4AM4/nRkhyh3IhLW7EvZ6qE00eZRkXRMnRpNE2VsdcPoNuJ+9PZ9tNQz/on5sQt1n7+E8/1ICMMofmIctXDcuw39396eaicO5gHEqVPVmVIQdTsi4DYx7oXru4dEN4X0EtQNF6p5aWV46WkUtznnAj9iT+Xc0jQAFRQU+VwF11zEwyVzWmwYB3Xfpy9L5EtnCwF2aa9rXQHkAjTiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jky++AjcIuE9IKZt7KfM6SVDxlBpDn2st7U7D6lAE6A=;
 b=MYJrEbNI+mwsVCvTH1n9BuePCRfMbCUgivTvl+Mq1WtufRSRkcYf1EF+W/jEasSz/G3w0d2UKFiVtV3NY1t/yJUVwCyi8XMIKbycJq3X/6b2pSggG+X2lGydIwj7BE1NaNo9yqFaN4GY0l2CWz1lzeMlpwoQyhaJTTtD4uiVLyA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 14:24:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 14:24:55 +0000
Date:   Tue, 31 Jan 2023 09:24:52 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/mmap: Fix vma_merge() offset when expanding the next
 vma
Message-ID: <20230131142452.sfrmubta4ojejct2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        David Hildenbrand <david@redhat.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
References: <20230130195713.2881766-1-Liam.Howlett@oracle.com>
 <97ea66a4-54a0-68a3-c42b-f3c36c69768e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ea66a4-54a0-68a3-c42b-f3c36c69768e@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: a4528505-aa87-4102-a06d-08db0396ecd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivBStgM3T6lLrw+LD8qBd43IzXIDB21nxtoWAWuoW2BlJPewfP8CKdh1mj/q0zYvXaTmLgFYU4ejuNDBphczlo1l/KT7G3hGWbhMFc01jqUpmIkjnalASEoIQR0+cZrf+P7OZYaTQn7U9ouehXSwF2IMV196g21xUJWPWnFcTiftSptJLceklQZrTq5v/89i1hSuojeQYXHxHZrNjSQjSlwB4QTTR2fPQhlMFDRDx6SE20w/HXJ9anZJeZdKsmreD6paCc/3Z+R2X4NvBc1dREaXyb32+JYfLo2KjsKBw0AgumdcdMyIBeH7PgLPspT1m0eey4AILH/JxTZqQlPwpN8ZO6kupxUIbGvz5RBaN6AZccmd9q8+5rPND2uwMGCD/4oT7zX1gYJjxjhFobl2jWSc/IcsfvUPgXWZWsLHh+g4EiiM8KXiFq6FxRfGDkBl8yy1IJkU9IFymepCQnf0+TXJuEIf7xrYwQctBXD+7a8aylyglhaRHNyEEqzprK0ZQ2OcbgSWIwDIs6m6ZXKNHSLARc4ZDARE41oqrbJoRhmUHvNq8dH5Yh3SeeawD2gpAYttzEdBcTkseuupgnZFjURrNryahINr+r8Y8aynLqHNsk8Dl6Ky0RymCm5jrkMhr26cxd09uYGzg3DAqrR1Ak9pTlTtQqhOwjlyImktskY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199018)(4326008)(2906002)(5660300002)(54906003)(1076003)(6506007)(53546011)(6666004)(8936002)(186003)(33716001)(9686003)(6512007)(26005)(41300700001)(66946007)(83380400001)(66556008)(66476007)(478600001)(86362001)(6916009)(8676002)(45080400002)(6486002)(316002)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bW/A7zo5CAKdkszJ2EdfJWRssh68PjFR3Oj6mHkQ91HTZwzBikJg5C9R0dvW?=
 =?us-ascii?Q?Hm53XwFF00HQnCboyg3vrvq7hq0x6lT1y9jUZWmuQqFO2rxk2XqRs8Mwp8uP?=
 =?us-ascii?Q?+PGojuLr5aUH72AXO6jbFfHgjuoGdUXcNCod5MOKvIzrj1YNH8gqD/7GOCph?=
 =?us-ascii?Q?T0d/xrjJ55LRzTqE0W4X+wY0AFiwfHvHzdtrFqh1UyegZtTuTrwVcoLbsDSz?=
 =?us-ascii?Q?AWaeReXdVHNamQtg5/p1wWbgxp7vg0b2GSoxQ1qvi5vSOQLD6ymCMVJsDZdG?=
 =?us-ascii?Q?4QOhgY/PfU6SNfcqbCJ+JJIr9FnHsWIoa1Jd5BTlhlbG/UCkWA97OTKlQxsH?=
 =?us-ascii?Q?q87WWUCpQg0aBHi+V3GeSGKwAnMH6GeWUAp0GRgz3lYdK81ufU0xAPpHEFe6?=
 =?us-ascii?Q?FJq/XQ3Ffv7ZbeHn6DvLRb6v/vFcbmBKN2WYusk4nloxsyR7e5iLIdlQ7JO+?=
 =?us-ascii?Q?axxO8OFtPD41Di6t8TdB3oi6i95B+xWO/L2WqIvaYKh0K/0KY47g0PAcb4kb?=
 =?us-ascii?Q?alsIvQpeozQnRT10al6nEW5aSdDviDOX57zKBwCZSeOM+59odkk/QgDUSxoB?=
 =?us-ascii?Q?MFnF5V89o3e5iEtZru/b6ZxFWkC8UpOiqpeqoopUxucuY2gIAA2ocKKr4rti?=
 =?us-ascii?Q?IaFEEtBMEW7eDU0IIJGt/6UittYcjD2XkCjIgTcRoe7Suf46nhPt7KODg5+M?=
 =?us-ascii?Q?7ob48LpxOWhEwikyRS8AaRGWJuDgPoVJbzfYDotmAuRNZJCvHO85p2XDFRxy?=
 =?us-ascii?Q?RuuKNlIwbS75kvHsmnahiR3xRYt7i0v3853nLkl+mPK1Vl7elA1KwJQyJ9s1?=
 =?us-ascii?Q?iVMqY2bRMLUXcxAyDym21TefWv5V+PNVexzQxNcOI6MyozeNrvK7uQ3LDiSW?=
 =?us-ascii?Q?BJr5MeMUjdxbmJWeoMSKtm+vhP+XjOFn9oGy/VN/iitL5mgo5dRnHJmSzvjA?=
 =?us-ascii?Q?HdfshJ50rsQngZ7aUMueyy6SAOq/QbbFJZI1JLzb3xYxd+X/2uJ7GQzdlfow?=
 =?us-ascii?Q?Wd5WzqyOcDHMZRP4CSVGAsTGQ//Apx8TgcDFBE69OvBidee7+86s8hDDys3s?=
 =?us-ascii?Q?j6VsTsyYSj5f8QOlUT/hBAzKGg0zUF3ZYAzcke8QPvKh6bTIRZERIg8QQBqk?=
 =?us-ascii?Q?ZysCF+x21Na0jYOtPUYHbwdrQCHnxFMjlt4WkczMgnfxYJoEfYgkRlme/7a3?=
 =?us-ascii?Q?3xjDcaC0cMm0vV+a98HUcVYRj3ljhhJxW5O6pJ5Uo1OaRsjFgoXAvdrP6aW/?=
 =?us-ascii?Q?wm7EmrW0QFjda28STNywTFlqJnMGay0mQ3DYRy33+LwLirhERlGJiyCD5D/8?=
 =?us-ascii?Q?PdCJRq/FP3jg+bgK8UGTaSNWjEEqrMliBaSbJqnBopPzyA0klF3JTbVFyi6h?=
 =?us-ascii?Q?cNKpwW0jnMbZoKOjXdo0Ebu6rBBsFD3rpzWSFlrTm6XMCMP85dyo6zibzbyc?=
 =?us-ascii?Q?SiF1+r+1En/UQAb0tcpCEsPteh0zqgLcONqxbVBcChL6DZ1nGuY2kOtJWIFw?=
 =?us-ascii?Q?ya2sjp8UjXMQ+ic2kHYj6ZZQJUFsd+paGiwcLEXRPgefieP1xKcXoKZPqTv7?=
 =?us-ascii?Q?CJ7KtshPpH9lH08GB/qOsUD8kMJOBZ3qwu7cmL846/u4aAyXEpHQFVfKqdxL?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?m+CvoPw/7eFOyXAZDvBIo/yQ5bXh++wtuRWRThHUtA3wueB1Tj9WXLM9MJHM?=
 =?us-ascii?Q?AUEDF8GWg3rzhu5pL443FjwP3MyaR9ODb1qI1w7deM60kcRLaUsTh/dCwxw8?=
 =?us-ascii?Q?urTN9RHKpVQhWLzpnbyCN8w6795Hq+Se8fOEdZHtA8uJ7Uyr2l0dGf1Uw4gF?=
 =?us-ascii?Q?TW7tkhuHtwq+KvB94q2hzguqq/78hI2sZDopDh2m4MMtOaoEUrE7giGVqLlZ?=
 =?us-ascii?Q?lILO9jFXMT+CxAbC50imQHoP4qeRIsplhnptlXznmV9Ahy7HmDtKA0nmsp6L?=
 =?us-ascii?Q?86aPkK5CQLf+/ZonBP9m5qF7n4Gg5fPE0tfwATRxS0LvcPIc+ZQoLPAm0YHU?=
 =?us-ascii?Q?V8eEovDH4uF4uMk7/KSD6jkQ6czhGAqxB/0Nx8WjwlL+dpYX08WXZZoA/IPl?=
 =?us-ascii?Q?bl8cNw7j75HihBXSczJn4rW9jw0TOooAh1dwdgUX2BT7iF9qrnJkBrjuR5dy?=
 =?us-ascii?Q?kYzuzVjlhq4CPkmycQatPsy0IjGDNh86hvVrzXsmFwPyiS35DsnjiOhNdrC/?=
 =?us-ascii?Q?TP5rIqBAEpXueRA8/mNiLJvVR7PvayiqOOFj/kjaPAv2ce8HjCKAhiBZnLpf?=
 =?us-ascii?Q?LB/EIFktESJwawoppZ35IIgpdTO8302IfY4TgROQHN4l7uKt1+7ES0wLEBu9?=
 =?us-ascii?Q?RQh6YHrXvmY+uMInOIPdjFfkBThtuqlNZk9MwWxUzeUOR3TaRLFT+e7BsP4r?=
 =?us-ascii?Q?44UnaPzur5sd3sYGC0Ontz7qyfP91BMHdG5cSQ4sS3zIjw1hInxWBfFKVoUR?=
 =?us-ascii?Q?zQtXHMQ8iKkFkZTBBtK4DDHbk3HxmncAdO+ubgc650zpMA+7ZoH29Wb3zM2v?=
 =?us-ascii?Q?yxm5mBHep4ToQJVIo1KPdUB6XaBtkACQE+KFbx58xUEh2oOkvx75pTFswawJ?=
 =?us-ascii?Q?quZHtRFjJfniFOMqo4G1qPv/Bc1adsMmXUn/M7hnZQNSRDFF1i4meKiRUgkl?=
 =?us-ascii?Q?SwLBycHDhE3dh9v/Km0nr7z8uYKtH8p1LVmSzus7snLkfe+volkunNPk/IdO?=
 =?us-ascii?Q?4pWAhvutnLxcs628g1oViSJ3bA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4528505-aa87-4102-a06d-08db0396ecd1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:24:55.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpYLa3OKf+JSo7D0vAc3At2LvU1B1nc8sd3VgfGE/EizjfqN6SCYLsxEHff+7XRuvO4n3gM5ISMpp7kDdgGmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=887 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310129
X-Proofpoint-GUID: O872OX4aO9cbb88NXuA74XSlgU2UN9n6
X-Proofpoint-ORIG-GUID: O872OX4aO9cbb88NXuA74XSlgU2UN9n6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [230131 03:35]:
> On 30.01.23 20:57, Liam R. Howlett wrote:
> > The vm_pgoff was being set incorrectly when expanding the next VMA to a
> > lower address.  Fix the issue by using the mid->vm_pgoff value for this
> > merge case (aka case 8).  Note that this does not change case 3's
> > vm_pgoff as next and mid are the same VMA.
> > 
> > Reported-by: Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
> > Link: https://lore.kernel.org/linux-mm/IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com/
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> 
> Fixes: ?

Fixes: (soon to be invalid git id :) ("mm/mmap: remove __vma_adjust()")

> 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   mm/mmap.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 00d90bbc250e..614ea2d93b0a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >   			vma = next;			/* case 3 */
> >   			vma_start = addr;
> >   			vma_end = next->vm_end;
> > -			vma_pgoff = next->vm_pgoff;
> > +			vma_pgoff = mid->vm_pgoff;
> >   			err = 0;
> >   			if (mid != next) {		/* case 8 */
> >   				remove = mid;
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
