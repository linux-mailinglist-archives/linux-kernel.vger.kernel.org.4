Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859A62389A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKJBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiKJBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:07:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349E20BFD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:07:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA152IW001900;
        Thu, 10 Nov 2022 01:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uyobfB/By24m6EGTzXn5V1walTkAVhBN5QvMjJOHOxM=;
 b=Fih8AbwszKInawh6WG4aTE2IHqGgeQNfxC9Dm4ZVLDs0odKcTUxvLozNWq/Ndblgso2u
 8PpuobvTR6sbS8zpCDz+/xQPK/9AggWeky3QaLIi/CA6iDvDju+djqd8Ke70uXGnUb+z
 593HCPZ1sbAf8UmtTsSrXBxr8qI8k0ubcCMZrP3QufEWsDbS175EaQeitlgwir05K3ZK
 20YqmBEx+lnnFeSBHZU9HQ27fps/HgN2DOYjs3ATv0o1CO784cmk8tDVgobzsdhZR1G6
 zcrNYd2V2Pp4f1luagBAbQnQOgCkwAiiIGjS0Wr5zOguCIwdR+p9rzfPimWVBT1bDc9F Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krqat0017-25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 01:06:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9N2Viu004301;
        Thu, 10 Nov 2022 00:59:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq46sd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTuJDMY/YGDdFYTQlC3PVxap9/lO6a9A/UkSbte7F+2VQeOhdZKrkazagV8g+H0b1hfeRekvxCjQahub1nWWX1E93jJatxQt2aeIYiVBNRRLDszcp/WlrswWdkc8YRbzgKYhKXB3Kq1Zv5KVDgsMVd+jYQwZ2G7CaS8Mk1WRjAT9AYD3y3Y3ZlNkfWu0u88gQFEa09XveoPMZbkcP/QbW62kYV8OpJh8p0g+NV1NiQtAFZe44WTj4YEMj8vbNrmVATlZMllm8oOHXmtVA3Z8Nem3jWRMwjCtB1Si3iR2xOx7TRgNsGDsWtHkU6y1XnDHaEKWgmHmqehGkFLGWi0T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyobfB/By24m6EGTzXn5V1walTkAVhBN5QvMjJOHOxM=;
 b=gb9VK9wL6KPRPxyZZvzKvhG8pUhSlEG/PW4x5Q6C2lXK5J+GFbWIyTE/EoHBQmr6VGVG1YGuYqNGun0durmFwp94Ytwk6hN/xHi45Xv72nkU9BHDYc2qqfTfQMANPORyD1Xq1SwYzDSH5hzA2+0MLTAc7gP/R9yK7AAfoTyDwoPZuuoFy0UqT4zGLQdlZ90bk6oIvLIe+9C88YP1V2RhADy84jFoSOnllxAeeUeQxNek+I44dv+cAfBozNKMVpWe0cunV+3VWBihNhTXwmWk6mlejGDFOgA9XxO0BB6tP6BPw5ilGN6AFKawFQRsXvYbWuBQjnOe2eWGKrW5nXjcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyobfB/By24m6EGTzXn5V1walTkAVhBN5QvMjJOHOxM=;
 b=dNybfQ0m+GkiDukF8K2m3ttzVGZ5dvTbQgcUtokPuqZYn1LtaFC1sSBOAGF+7yKQ91wscApVQP7q8Qxblmm7E4V9BGJc/wLRFy4KUDCPAQu0+1nddgW9RVDhUlr6qcdmL2bbiqevWZkMijWAv9stLfYMyTT5eAfhuJxLwNLXRb8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 00:59:40 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:59:40 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, urezki@gmail.com,
        hch@infradead.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 3/3] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
In-Reply-To: <20221109033535.269229-4-bhe@redhat.com>
References: <20221109033535.269229-1-bhe@redhat.com>
 <20221109033535.269229-4-bhe@redhat.com>
Date:   Wed, 09 Nov 2022 16:59:38 -0800
Message-ID: <87v8nnfwud.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: c94c6e90-e414-4962-0424-08dac2b6d8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNqVXILSWh8yqB5hIHQy8aR5LRcQ+kRjAOqpot1IYXIsqoJFt38WeMEh0lT3+QUaW+YX1Nn9YxvFy3CdV172w5Xw9zYyP9Fj3MZhVStEBx9f8XmNA3uZBNNFx8DSSvPPlNNj+Xfi0YIG9aKs1A3TgGJAHHdVNnRzvAAnNpq/H+Ju/QtncDvR3hgniGmN1YTLw8SnWmiSopBUlh1pK5dJDgxEpBZtTvTPvOObwTOGRMk2zMhIK1k3y+Ip8ly+kT0/L5iuB6zW56r7rE/hczw5BsFTjWdgfmzVA0ZgDdA+vZ6protUpcWCB1IveCu60ssaU2ppCH0XuRdU1ayUEnACN5aRXP702Y7zNnmfvzhodh7YBVVWuSfY7PFZz2JJTP1hNMSZHW7GRBcXoBF0U998lk57kHbLg+1r9tXfzmNAzJ76cEWssXSynahG0kZhF940SqvMt5+7J0hRUV3I9G6Ooxc04yb8BT+DZYTFA5JABBVJMi2SfmHAvmSNppEslKRuVVX2rpC1AT8LkeR5R+u+6t6L/rxCGyIFPH31JnhtP+uc8PP6+l3qRedlXWhhAInLXRiYgMgKmygtOGqOkNFEnnJLlOr4Kx7oFBnqLulKDgl+Bnh9htf3lrGxdMfw1ao/OZ2oPtb5bX/Mzwb6e73NZ3y/6+iUWXYudzcmmma14v9jLE9sHVsH2mElKx4U+A8SCKKEKK7vlJ2ALPHYqEAzM8tpH9hC+fNuFy8CSRX+ScQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(36756003)(86362001)(83380400001)(2906002)(6512007)(38100700002)(26005)(2616005)(6506007)(186003)(316002)(66556008)(66476007)(478600001)(6486002)(66946007)(8676002)(41300700001)(966005)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVdZ+Ly0zzX72ppayBXG/nJOenkp4ZIbx0O91tceAq64UXESQ9FlucBRgyHl?=
 =?us-ascii?Q?i3N0J0E3DSD4XGaoEXL7gEMP2kWJeTI+qq7odtBkZp5JjIL/JqRua6KzaDaO?=
 =?us-ascii?Q?UREpr6mAvkNFcSKn01PgmgM9EXjft1PS+B6RQtxmOhDMqDWmE3xvVn+ny4Zj?=
 =?us-ascii?Q?UNLxlf3HcWu4FRmMvQxSs8SH0E/c1zlGLfPGF1/5QlILZiXpSFL4jqmtx6Bw?=
 =?us-ascii?Q?I/DCcAnrLZbho4+Ym0a3+n+l39PpJ+nl6sn5W0i3f0OWc942bXZwYQCSYGC3?=
 =?us-ascii?Q?56Fa5JzVYC+IItjlYO7Qk+H2TMwBg2K46PXyHoC3eYAiILmcQETmU1UW43G3?=
 =?us-ascii?Q?RXND5ctpYUiV3r4imqH3chU9XZCF2l65cQ8tobyRgVbD0OCI2S1Yw6axF3u4?=
 =?us-ascii?Q?yD6jUpYLbVmr742qrJbhJUU9T0l78/ddZDX7k7Gr/QxMKHAmiZstOSSBrgyd?=
 =?us-ascii?Q?YAT/oOJZWidkepTXF4eIBU5gri4rA1GA2IXf/bKtPuDuFtUBpe7PE2XhUpXn?=
 =?us-ascii?Q?AvnZOzL6Xh19iDzo8WbfUXKPbcfZuUzoZhZ4AVOyjfRtvkOyawDwmPAxtp7t?=
 =?us-ascii?Q?yeKFCdcAt4cjUA5Dfu0wSz4Y0+xnCCnkMvxabV2wjtK6V/wz+PJ3QqJ1/2s1?=
 =?us-ascii?Q?IM9UiXWMWxdpaFEXbXMj7YpQFVuw+WX8gMFN4eh6M/w4RhgdSdMWbpqVH+DP?=
 =?us-ascii?Q?leVbdmAsRPvN1JEspq4McI1gZAbmULIs2hdvlnc///wk9gGrNDbTomS4EErd?=
 =?us-ascii?Q?Cjak4X3ZssB/wWAiQjtxyz3WX+xH12BmzxIo3acjfqg9iH5+17NuI1QWnwiJ?=
 =?us-ascii?Q?95bF6Wye/7/0ZTSdP5i+ru8j1u8j4Mhzb8RlRCGzYs7u0N5kpVQxv6opm4wh?=
 =?us-ascii?Q?BRPD78ijJ/fO7X8JOuYNAyNoKxjOLnZ4OnQG1W5FbOzpwZyowZqIDD4021Ob?=
 =?us-ascii?Q?C6QPnI6ZLYkptm/2+aSipr/xHz60jI5K+xs8UMI4s/YM+NOHdbBVYjMuRjVU?=
 =?us-ascii?Q?FyGJ0a8xsCO7+OLeaPAxtUAvTi9AGSOqsOyIEYtJBxZQ5ay/J3Q55073znxr?=
 =?us-ascii?Q?Bsn35FrAn8MQzqGJIenuQeOEMP6Lk9gLACFpR7lFcQ+S/N0ASoIcyOXfmuVj?=
 =?us-ascii?Q?aWEakDxWjHLV4/q9hc3GPZhaw9RbsmfUVelE5qv8FCKhcGkq9XXywQZW/B92?=
 =?us-ascii?Q?MdXghOrJ7aqrZp12TiYvYSAkdBildWhXaJaQjzt09+XISbSWC3lnpOJiGNk9?=
 =?us-ascii?Q?wBwCgZl2nW5PG3G/qHViScRbEUaudAi3ZjT5CqYhk0SvyrCJkW9cnCYcNP2e?=
 =?us-ascii?Q?IQH9KHpfWHOgCR+9sn1HpmKgCMeR+gJhUKQOWh4hLhbuRiiFf1mFpW67RKNH?=
 =?us-ascii?Q?z5XWIW80xOZ4PsA5WuGV0jAh43c+mNdQaW5QLv/mY2ofj9LDTvKJmncZjHdb?=
 =?us-ascii?Q?v3s2fwkdwE9r1YC1thZXDMUh5xkKYyXZDjVlTF5P3CIaDpTa3ftwk96sdaia?=
 =?us-ascii?Q?wJ+JkoI6U24XWwpQ9noKGGB16Zc5zbgKzNOuG8fuWkR0UQQ6ZbfvYhPN0Do0?=
 =?us-ascii?Q?QG9CtZFp0XeqZiZ50zsMW71NKti6V6Dv2W4ppNKc3tpJv9VlofU+A1x6OTf6?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94c6e90-e414-4962-0424-08dac2b6d8a1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 00:59:40.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvKQz8VwUSaieWHBAXuNGe/5p0feO1Rc9DHHiZU4A6+NsoMqFecQMRsuKkTGUp9eg2v80yrPHjM+4zUhQBL7kcf+16GE6+IGfnoNQD/hwhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100005
X-Proofpoint-GUID: sE24rUr5ZMyvaEB_JldgHAocRlLfDR8v
X-Proofpoint-ORIG-GUID: sE24rUr5ZMyvaEB_JldgHAocRlLfDR8v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:
> Currently, vread() can read out vmalloc areas which is associated with
> a vm_struct. While this doesn't work for areas created by vm_map_ram()
> interface because it doesn't allocate a vm_struct. Then in vread(),
> these areas will be skipped.
>
> Here, add a new function vb_vread() to read out areas managed by
> vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> and handle  them respectively.
>
> Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Link: https://lore.kernel.org/all/87ilk6gos2.fsf@oracle.com/T/#u
> ---
>  mm/vmalloc.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 41d82dc07e13..5a8d5659bfb0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3518,6 +3518,46 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>  	return copied;
>  }
>  
> +static void vb_vread(char *buf, char *addr, int count)
> +{
> +	char *start;
> +	struct vmap_block *vb;
> +	unsigned long offset;
> +	unsigned int rs, re, n;
> +
> +	offset = ((unsigned long)addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> +
> +	spin_lock(&vb->lock);
> +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> +		spin_unlock(&vb->lock);
> +		memset(buf, 0, count);
> +		return;
> +	}
> +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> +		if (!count)
> +			break;
> +		start = vmap_block_vaddr(vb->va->va_start, rs);
> +		if (addr < start) {
> +			if (count == 0)
> +				break;
> +			*buf = '\0';
> +			buf++;
> +			addr++;
> +			count--;
> +		}
> +		n = (re - rs + 1) << PAGE_SHIFT;
> +		if (n > count)
> +			n = count;
> +		aligned_vread(buf, start, n);
> +
> +		buf += n;
> +		addr += n;
> +		count -= n;
> +	}
> +	spin_unlock(&vb->lock);
> +}
> +
>  /**
>   * vread() - read vmalloc area in a safe way.
>   * @buf:     buffer for reading data
> @@ -3548,7 +3588,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  	struct vm_struct *vm;
>  	char *vaddr, *buf_start = buf;
>  	unsigned long buflen = count;
> -	unsigned long n;
> +	unsigned long n, size;
>  
>  	addr = kasan_reset_tag(addr);
>  
> @@ -3569,12 +3609,14 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!count)
>  			break;
>  
> -		if (!va->vm)
> +		if (!(va->flags & VMAP_RAM) && !va->vm)
>  			continue;
>  
>  		vm = va->vm;
> -		vaddr = (char *) vm->addr;
> -		if (addr >= vaddr + get_vm_area_size(vm))
> +		vaddr = (char *) va->va_start;
> +		size = vm ? get_vm_area_size(vm) : va_size(va);

Hi Baoquan,

Thanks for working on this. I tested your patches out by using drgn to
debug /proc/kcore. I have a kernel module[1] to do a vm_map_ram() call
and print the virtual address to the kernel log so I can try to read
that memory address in drgn. When I did this test, I got a panic on the
above line of code.

[  167.101113] BUG: kernel NULL pointer dereference, address: 0000000000000013
[  167.104538] #PF: supervisor read access in kernel mode
[  167.106446] #PF: error_code(0x0000) - not-present page
[  167.108474] PGD 0 P4D 0
[  167.109311] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  167.111727] CPU: 3 PID: 7647 Comm: drgn Kdump: loaded Tainted: G           OE      6.1.0-rc4.bugvreadtest.el8.dev02.x86_64 #1
[  167.115076] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.5.1 06/16/2021
[  167.117348] RIP: 0010:vread+0xaf/0x210
[  167.118345] Code: 86 3e 01 00 00 48 85 db 0f 84 35 01 00 00 49 8d 47 28 48 3d 10 f8 a7 8f 0f 84 25 01 00 00 4d 89 f4 49 8b 57 38 48 85 d2 74 21 <48> 8b 42 10 f6 42 18 40 48 89 d6 49 8b 0f 48 8d b8 00 f0 ff ff 48
[  167.123776] RSP: 0018:ffffaeb380a1fb90 EFLAGS: 00010206
[  167.125669] RAX: ffff9853a1397b28 RBX: 0000000000000040 RCX: 0000000000000000
[  167.128401] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
[  167.130948] RBP: ffffaeb382400000 R08: 0000000000000000 R09: 0000000000000000
[  167.133372] R10: 0000000000000000 R11: 0000000000000000 R12: ffff985385877000
[  167.135397] R13: 0000000000000040 R14: ffff985385877000 R15: ffff9853a1397b00
[  167.137533] FS:  00007f71eae33b80(0000) GS:ffff9856afd80000(0000) knlGS:0000000000000000
[  167.140210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  167.142440] CR2: 0000000000000013 CR3: 000000012048a000 CR4: 00000000003506e0
[  167.144640] Call Trace:
[  167.145494]  <TASK>
[  167.146263]  read_kcore+0x33a/0xa30
[  167.147392]  ? remove_entity_load_avg+0x2e/0x70
[  167.148425]  ? _raw_spin_unlock_irqrestore+0x11/0x60
[  167.150657]  ? __wake_up_common_lock+0x8b/0xd0
[  167.152261]  ? tty_set_termios+0x211/0x280
[  167.153397]  ? set_termios+0x16b/0x1d0
[  167.154698]  ? _raw_spin_unlock+0xe/0x40
[  167.155737]  ? wp_page_reuse+0x60/0x80
[  167.157138]  ? do_wp_page+0x169/0x3a0
[  167.158752]  ? pmd_pfn+0x9/0x50
[  167.159645]  ? __handle_mm_fault+0x3b0/0x690
[  167.160837]  ? inode_security+0x22/0x60
[  167.161761]  proc_reg_read+0x5a/0xb0
[  167.162777]  vfs_read+0xa7/0x320
[  167.163512]  ? handle_mm_fault+0xb6/0x2c0
[  167.164400]  __x64_sys_pread64+0x9c/0xd0
[  167.165763]  do_syscall_64+0x3f/0xa0
[  167.167610]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  167.169951] RIP: 0033:0x7f71e9c123d7

I debugged the resulting core dump and found the reason:

>>> stack_trace = prog.crashed_thread().stack_trace()
>>> stack_trace
#0  crash_setup_regs (./arch/x86/include/asm/kexec.h:95:3)
#1  __crash_kexec (kernel/kexec_core.c:974:4)
#2  panic (kernel/panic.c:330:3)
#3  oops_end (arch/x86/kernel/dumpstack.c:379:3)
#4  page_fault_oops (arch/x86/mm/fault.c:729:2)
#5  handle_page_fault (arch/x86/mm/fault.c:1519:3)
#6  exc_page_fault (arch/x86/mm/fault.c:1575:2)
#7  asm_exc_page_fault+0x26/0x2b (./arch/x86/include/asm/idtentry.h:570)
#8  get_vm_area_size (./include/linux/vmalloc.h:203:14)
#9  vread (mm/vmalloc.c:3617:15)
#10 read_kcore (fs/proc/kcore.c:510:4)
#11 pde_read (fs/proc/inode.c:316:10)
#12 proc_reg_read (fs/proc/inode.c:328:8)
#13 vfs_read (fs/read_write.c:468:9)
#14 ksys_pread64 (fs/read_write.c:665:10)
#15 __do_sys_pread64 (fs/read_write.c:675:9)
#16 __se_sys_pread64 (fs/read_write.c:672:1)
#17 __x64_sys_pread64 (fs/read_write.c:672:1)
#18 do_syscall_x64 (arch/x86/entry/common.c:50:14)
#19 do_syscall_64 (arch/x86/entry/common.c:80:7)
#20 entry_SYSCALL_64+0x9f/0x19b (arch/x86/entry/entry_64.S:120)
#21 0x7f71e9c123d7
>>> stack_trace[9]["va"]
*(struct vmap_area *)0xffff9853a1397b00 = {
        .va_start = (unsigned long)18446654684740452352,
        .va_end = (unsigned long)18446654684741500928,
        .rb_node = (struct rb_node){
                .__rb_parent_color = (unsigned long)18446630083335569168,
                .rb_right = (struct rb_node *)0x0,
                .rb_left = (struct rb_node *)0x0,
        },
        .list = (struct list_head){
                .next = (struct list_head *)0xffff98538c403f28,
                .prev = (struct list_head *)0xffff98538c54e1e8,
        },
        .subtree_max_size = (unsigned long)3,
        .vm = (struct vm_struct *)0x3,
        .flags = (unsigned long)3,
}

Since flags is in a union, it shadows "vm" and causes the condition to
be true, and then get_vm_area_size() tries to follow the pointer defined
by flags. I'm not sure if the fix is to have flags be a separate field
inside vmap_area, or to have more careful handling in the vread path.

Thanks,
Stephen

> +
> +		if (addr >= vaddr + size)
>  			continue;
>  		while (addr < vaddr) {
>  			if (count == 0)
> @@ -3584,10 +3626,13 @@ long vread(char *buf, char *addr, unsigned long count)
>  			addr++;
>  			count--;
>  		}
> -		n = vaddr + get_vm_area_size(vm) - addr;
> +		n = vaddr + size - addr;
>  		if (n > count)
>  			n = count;
> -		if (!(vm->flags & VM_IOREMAP))
> +
> +		if ((va->flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
> +			vb_vread(buf, addr, n);
> +		else if ((va->flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
>  			aligned_vread(buf, addr, n);
>  		else /* IOREMAP area is treated as memory hole */
>  			memset(buf, 0, n);
> -- 
> 2.34.1
