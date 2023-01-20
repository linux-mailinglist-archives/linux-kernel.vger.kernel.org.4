Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39C675ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjATRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjATRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:13:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF328D1C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:13:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEC4E006224;
        Fri, 20 Jan 2023 16:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=afTZvLcrzM1nMWgYmbzfQmJi+EabrJS9q29fsvtBzPc=;
 b=V36+YIqiMUs+jQZGhSGqJo/iVtHCVhOdqrKd401yq2J0ECw35EbhWY1fjWCMDfZ7Mm6v
 wWLDFR5+FfIlqD0VSjL6kfGJeZ4Q5K6+If0hQ1W6Mfe1TQPzY3TPdlzM7O32BE/aVf6g
 XAnL2v5VHDy5X7sihR8Yk5CZDuvobU3rpkJ7zFiPyXZxbUE+X8KslYcaeToLNttprXdb
 cq1dPyxn+ZX9yLzsmYX0Hm9qMXWQJmnztML3iv0kAX1Lzc2HB7quTF+IZuxCPa8Yvhtt
 6sk4EkR5m3cSOmLV0x4ncBi9XeAnYDzmj23Ufy/+ARPdUbGQAnq+udd4t5L41be9Vsgj RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFZfIg027915;
        Fri, 20 Jan 2023 16:28:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud92vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WESzSHacVq9PYfi6EnIBtg+kxvin1r13pJxGX/pxQQwspt4DVjb/28z4tzc47uozI5j1uSvRjKJdEMuWuwoYijfGYugaHbhz0C/QzoQI+vhkmd3oT4MNr/NYtWtPKTDDaj300q0r+56KKRFbUuoWKxrGGICE5qoahTb1r3+oWWbMSZpsxmhsmZGJoH38uWYts+PcK2gaik5kx2CHsaRxpiBzNYYYkBZ8tA9U0kGOGokKUC3z5gaQs0ovFsJ0+EXkodEwKE2FOPBzw6bA3mf8mH++TH41w0GNfNxVYc+UaCKNQiOMoTgbfhBleYo9OAZ3R+RAIovg8EtuVUxgvudt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afTZvLcrzM1nMWgYmbzfQmJi+EabrJS9q29fsvtBzPc=;
 b=BMEPZFIYvMBQQVWBujJIbbqmryhao+0DoEqgcJqu5qhe8CqgcsckTKZIkehmYhnJ+8O7n/7ZP+p3+YNiX1c9n3/JnKdC8HPJUTIW0u4g4tlDNlMhTU7CdizP5eVnloJ3pxyIuVp4V8OefVaDTxvDnm5pny5nYQQG/RTW1DmOfpoTy5AgDYfgcu/nmHBJGf9NkiYJg+vbHASDeJL/gbaf+m0yppvCG0XRZayk5cEZZHU+wW3EZh0qEHwjo5TFX2WiTQ8Wxn40NbzeLafo6qJUZ0rpjL4HmXvCxo389PwVinUlEW8eWAvDQW7Z3excaEtZBnRN5oqU+9W77Q8R0jadqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afTZvLcrzM1nMWgYmbzfQmJi+EabrJS9q29fsvtBzPc=;
 b=vHHugysnhA26qv19Iu09ZZwOjYyOS+KQsRLyBiByXFLvXtiJ7puqsBkYGrPoZIHXNkAFtaQ5wkIAEb9sLYtKuiQTOhuovfX3Nd486yT0I2KKqcfrKeCM7/r3p9hcJKHBLYl3Xd9khlTMBbRqIoZFZamX2QF8NpLYWB9Aee1WgpA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 38/49] mm: Change munmap splitting order and move_vma()
Date:   Fri, 20 Jan 2023 11:26:39 -0500
Message-Id: <20230120162650.984577-39-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bd4fbb-242e-4705-96af-08dafb036999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAizxDaDQxHQHZ+P6O6LrF9pehwtHdM1mUqprdUFzeFVMAR61ugPZMZhEusYpHTaCbGX4r5MG0wFaZsc71u6mrIHZCBsjQ2eeIKxXfMLmUZHYfTy2jCYHqm6RbpiDJzP9HI97bO5e/BEas7CfqrGXGiEmIXsqFqXFJPxsotFn90AQod24kC5LzfY69yTCcy5OgeyNGoM0PIEaZKd/t2pQWVglTmR1j5fkW9ovf8gl4wRv9oeOqQ32WrXWpM968AEgdD4VXG7Z8GfKJTQM4xc8qyWvR9FECLCqOltsdBnNmSQJavBJrzFnA02jTmw/X8Y7d1o1gA6CDD4jLz/2Noz76uGj5hWSPVpZFkp/ccSjvJH6UA90uBpCPl+z5kpIao89aInW9+DoJTrjCOv+Sk8d4JDq8vHoXkRFT561dtQQO4vhCZKRX5zJFuO4x9HfL3qIofWOpAOg82BVOwm0gGOtk5in4oeKlhCzWgas2da5NGmQG/4wVd6t2eXSGQVuzeexJ0//ueNHypYdTyBvAfgYiW0lQP09nJvsd2QQBBi2c4ai5dGD87vb1F19pbgGt9VUa9qmuvC7cSSI1TjDkOl3lA2fzg6CFkuLN1crLlpKTlqUJv8qZR6QVR4uwDEq59laRX02pzpIF0akBP2iUJl5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Up73kKERLGU4VDItCtF6JSaxTtyQazPORUJmKbup53o+cU1JAwSwkiz0ymf?=
 =?us-ascii?Q?QsvZFlDdXdvdhkpiAUVnVDGNH8xza45q5+07FlO2y8K0xcnWq+GgH3aSEK4P?=
 =?us-ascii?Q?gUvzmIwzn4kVWyX723Zvn3mDUu17LEz1MKBizk/+1h/y9RkVB5DGG3wLBIb4?=
 =?us-ascii?Q?St20EjYrqu5Cvoy55Vcf5SYd46aWw/wV4Ie5b7Esn0r1ngM1KFn7BEiapfBu?=
 =?us-ascii?Q?wBocXYo9+2UWNKfeoG3zP1qZXtr6DnXxxK3iwFdafuqbcR/Z0Qd2Vmcxmy7J?=
 =?us-ascii?Q?FcxJM5heJiGBNTo4BLFxuJqboqabzUfSvSOXvnHZ91YO7ODLCgVumpSl4jIt?=
 =?us-ascii?Q?cgtZXWNJkmtgpRBralC5wwq2CnRWdhXOfKaKhrm4s3vfkfCgn+ixz8VlDhcl?=
 =?us-ascii?Q?BcUtFwXWawN/8n63iSJxyD6zBU1OTFM26/YjPQmrlvyNET/gArQxeOF3kF+5?=
 =?us-ascii?Q?QHUeT8xuInIP+X65nz2BUABb5RXj9q0XKu0qhfXgL1io6qWGYHv6buneJdlR?=
 =?us-ascii?Q?qjU5OBXHkujPXOtIpldLqhgrgYtfqeZbWF6xxvrsAMAvBmOig5hiiolSVd3o?=
 =?us-ascii?Q?KB1Svxq4209nV2OUvjwd+CM3i2hlMQHG9mD/WPlOGybb3zHmYtc0361E9P3f?=
 =?us-ascii?Q?8dpSn13Ov9zQ0tTJ5ptImFTlep0mC5IMrvi7FP1Z3qsx4+6JVVb2erNS2NJN?=
 =?us-ascii?Q?w1zoIipLcehF2VSCq4RhU8pM+YpgnEpbi2zM4QwamCwtRIj3gcNeZ671wOxq?=
 =?us-ascii?Q?AFY2uFzF1opeRvBKFHCAwImEBh6HzDV/dyFxv2hknVbwaVU3/F5rJEKcySQO?=
 =?us-ascii?Q?xdlrDODSAoDFZX32mM4WVW6byJYnhQpd8FFc91g0GWG2cN1MgLlLJd8l/5Qi?=
 =?us-ascii?Q?0aitedLT0cwcLfgAgApabTn3DPqThZXRRV3nTIv0rOUpffmQO5eRNBHj5Bjd?=
 =?us-ascii?Q?Z5BoPHLTl5APBIlRJ97+eO1aYaN1HLx7caM0raK8ZcnXyC0IJb5MZcd9ENTt?=
 =?us-ascii?Q?NZR2KvSi52Ii4K1gYRf0iiK1HMhVQ+QM1fWYbHorbnK14WEuz6JR8ldPBZTg?=
 =?us-ascii?Q?7wa30y8Qgscv/C5s+LbdBjNLzZhL+NYhnLUReKXiLNqjtl6zgaETL9lgKoEb?=
 =?us-ascii?Q?lGovFOela6TDQJwIR6dyQZTwAThMoSilPw9ou2yCFml1RYhtxZZg4rsRUlN+?=
 =?us-ascii?Q?dcqz0Uspe+ll/NSZP4+OiwvB9SYe/WgiwgEghfWceQRZgnNrpXA7Y8oKHXLo?=
 =?us-ascii?Q?P81ZABJT95HPb9xFb4XbFC9PlLxOORm6x3OXwlfL1SSZAcVgLHz7QZGbWOcI?=
 =?us-ascii?Q?A42RIvoIjuZoD5g6jFauOuAU6V8ll8ppIjgdHAunYqtPJ4pemPZXtFwZ2Vq6?=
 =?us-ascii?Q?/9/Lo7C8kCtfAtP87SLeSxOcBBTy8iAxBGW1noKdS+eV59CcqZ5wEPLHVy86?=
 =?us-ascii?Q?NYLFGHT/BBhvGmppCuh4RSE4n46nzBonn1RGeFF+Sw1/EubRd5zPGBVW3gvt?=
 =?us-ascii?Q?a46vB4lBjm6mgMXOClgB63VoINZgS6IKRqFOPK9hkKf0IxNRmv4O/SHIeD5b?=
 =?us-ascii?Q?6F+J0iEIV7A9d72TCGq18SQAWzBiLikrrSFxpBZdVG0e0QQeeb5e8OatPWYE?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6SLxHXNxshIRDq1wEbTj/XS794usrsM4ddsUQ9CUBRmDDmrd5UzX4tMCVp4uITwpBIcl+FtTyhzZmV0I1kQdi/OP+GrcNrTNMTM4spcsHMftJPqAJJywPL7IUgLhVvFwDYo9jIfAofGWqmB6a6vnUxRf7uycgoEK4zGvl43vlQfB51U8ih/3GEva7Ve9uKQHfG8NcNxKckJhLZFtNmg1tMqC9Vp4qceKmnjDcw9VhkCO/oUsGsy1RvMm7aR1Cq3Y+EMFPMYITemfG7irm95CAEgsiu23/jehmlrtPvTQrhbuc7xav92xVo+i4zBR4pmvpD0/+rKawKU4EyiyVSpASe3bay1or7HEpHzgg7bXgTImSj6JxkMsbLu4o+Wv4OQJLb0TvbwpQGMTSqra4zYhkCwUStVqlPp8LrTJI9ilJe0N73MX464S/vQuhE7gVfpcDsCJ7XAQ212PJrmSBrizJ/u1xrK4kvQZK/ndYWtkp5Cyx1ZQDxkE/+GC6YgWgg/KBNipNxl8NQE+MgF5gUa28LsNTcqZ4/BI7k7IhIWbdumNhIDoyPGsBZxvIVKS2i3/ng/4xVmfTdxI4IInVV+jCVSCPCVMvh+L0Kz4ZaP9/b4QPhyO8HiEnj+P4QMyObORtvRfEY3wVNEOAd2++2ifAK+C+ZXVDubmeA2FTusNeppVjMlQJ0iCc2tC/Hnl03y/CUdOK4GkusnK0U7zRriwM8jESJMkVnTCfSpECktR3cT4hnZZuzW1V4tSeM2E9Ej8aOF6RTInpiBjMImecb9G+AJ19mAsefjEJoMomY7VjZ+vgiozTyWlRUHdnbUoeR0xGqvscOeZuVOg6XI37Z0wPN1c3DypZnr1Lq2z5ytLRvSZlMagpa6puUxIctw/vbIVCirFrVqbd248/5riiyUlmg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bd4fbb-242e-4705-96af-08dafb036999
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:50.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p342+IWD/SlpP+SZhckOgfYIqWORkL3DXnvOovLrAQDyDbiHZK3VjRQygk4hi4qW/ZO+njj7xZBXD54R9ZAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: mhlEbVvYkrK6ZYOgHG4emZejH5qslIi7
X-Proofpoint-GUID: mhlEbVvYkrK6ZYOgHG4emZejH5qslIi7
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
index d9e2666d8059..56483b837ef9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2332,21 +2332,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
-			struct vm_area_struct *split;
-
-			error = __split_vma(vmi, next, end, 1);
+			error = __split_vma(vmi, next, end, 0);
 			if (error)
 				goto end_split_failed;
-
-			split = vma_prev(vmi);
-			error = munmap_sidetree(split, &mas_detach);
-			if (error)
-				goto munmap_sidetree_failed;
-
-			count++;
-			if (vma == next)
-				vma = split;
-			break;
 		}
 		error = munmap_sidetree(next, &mas_detach);
 		if (error)
@@ -2359,9 +2347,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #endif
 	}
 
-	if (!next)
-		next = vma_next(vmi);
-
+	next = vma_next(vmi);
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
diff --git a/mm/mremap.c b/mm/mremap.c
index 2176f0cc7f9a..1bc81afd90de 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -580,11 +580,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long excess = 0;
+	unsigned long account_start = 0;
+	unsigned long account_end = 0;
 	unsigned long hiwater_vm;
-	int split = 0;
 	int err = 0;
 	bool need_rmap_locks;
+	VMA_ITERATOR(vmi, mm, old_addr);
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -662,10 +663,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vma->vm_flags &= ~VM_ACCOUNT;
-		excess = vma->vm_end - vma->vm_start - old_len;
-		if (old_addr > vma->vm_start &&
-		    old_addr + old_len < vma->vm_end)
-			split = 1;
+		if (vma->vm_start < old_addr)
+			account_start = vma->vm_start;
+		if (vma->vm_end > old_addr + old_len)
+			account_end = vma->vm_end;
 	}
 
 	/*
@@ -700,11 +701,11 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		return new_addr;
 	}
 
-	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		excess = 0;
+		account_start = account_end = 0;
 	}
 
 	if (vm_flags & VM_LOCKED) {
@@ -715,10 +716,14 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	mm->hiwater_vm = hiwater_vm;
 
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (excess) {
+	if (account_start) {
+		vma = vma_prev(&vmi);
+		vma->vm_flags |= VM_ACCOUNT;
+	}
+
+	if (account_end) {
+		vma = vma_next(&vmi);
 		vma->vm_flags |= VM_ACCOUNT;
-		if (split)
-			find_vma(mm, vma->vm_end)->vm_flags |= VM_ACCOUNT;
 	}
 
 	return new_addr;
-- 
2.35.1

