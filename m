Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8720D74148B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjF1PG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:06:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39408 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbjF1PG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:06:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTOvG011292;
        Wed, 28 Jun 2023 15:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type : date :
 message-id : cc : subject : from : to : references : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=GzGuQTF4dQNSA1Nzkm9HE+F0rs9iqRBDEa0OLTT90VE=;
 b=N6lhOK5YevU/r0artkgHLatSjiIGlEQKeYbSxe466ILChXRE7D/KTphPjXD6ZGC27sga
 scwcS3a+IKUW3dLlVZ2QIZwDNIjxcjv8+OGgk10uxtYCGS6QsJQlvK0OyOag3/LHT8rO
 qMk0Fq8lXZFcWpZNCFvkhwWztLKzUMMS26rR0qhcb0my4wJpOflsL1xN6+0vIy/vWPjl
 Zqha3BjQBGjfh74PdDDVZqUXQ9Wt3j5600fW0zb9V+Bh1h3iiPczFskHHt34XxiAzahb
 y6Df/gcZJnqhV48BsgSznIo041J8xAH1Tm6/3YwZJW4dWu1wOhzfn+EkwfqaqOxlcTn6 eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u7mwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 15:05:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SEU6rb013083;
        Wed, 28 Jun 2023 15:05:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6bx3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 15:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejmGWMiI0qVNYIdhFF2CX0qhsvLzp3XfUFz5e2qMtRUlUynACugvL94cd9tZKMkKVBYuodcnDAIo74NU7gZFYMy6z+ThGAzugdTKS3MIEeoCCBXe+wSGQ3hDRnGrRN3d2ln2otuBWUdD3/8cOvmvAl20R5wJrmD0x19REVcI5o2VYPAIBEQZ0G7sJM2aKHp6DUk1vSVunU4xERVQ0j4H9HTFCF8ZlMc4PfDXTVSTTWRJyNzJQm7O8YouJXvtohHnmfdxCMbBUjgBiqWqLnrOXMaTXqmgBq8XsLILAsGCRY7tZOJ6bTUzy03gZt58BvN8r/nCHXXna1xMiSopIWxEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzGuQTF4dQNSA1Nzkm9HE+F0rs9iqRBDEa0OLTT90VE=;
 b=Xim+Nx9lDZM9rpm9JcFfGcwQi5d//1R00eLny1z20ONSMD5ettNdhAGxGAUoBh3DW3GJxKXGMzc2XW16EUj2t1gcpM6tfl7aHy3VbbzqPKsfc99uYKL94GeT2geiUOdbmN0h7KmZRdW8iU9dXyaoBxhV82AnOOvwCeG5KuMkZttc/ezRfrKReJkrigM99dDJ037zoOWwMTAdVI/h5bjxaXJiFH9dK4XAcF6OrYZeBjb5bPF3ZlQ0EXoAgfAN5Gu22aGb5ppymGBxLe8DvjRJWmsFLEgcIpY6JX00lQsN8aceSrFP+n7s9dap/HNxa4ljtD/QcP0k3EYNsq5L23cjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzGuQTF4dQNSA1Nzkm9HE+F0rs9iqRBDEa0OLTT90VE=;
 b=ATO46r2XLe77fqVaQWAwKmwp8l3C/8t6rEMZBrsvvzWXF8hlwAOUHGPXLUqaVye7rdfUEmhLQMUp2POuhlXtF+nT0iuW4U9xvWr8uX8d6vhEHf5Y8qELG61ultO7Yx/6+sodRD2mIKSI/Z3YFlQ+tA/Nue9vD11jXLyKOU/P4jI=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.45; Wed, 28 Jun
 2023 15:05:12 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 15:05:11 +0000
Content-Type: multipart/signed;
 boundary=8090e66db7e30980d4e7ec6477b8ce05ba2136fb45d0958c46bd4cd69e74;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Wed, 28 Jun 2023 17:05:08 +0200
Message-Id: <CTODJTSTD9WR.82GVFKOIDIUK@imme>
Cc:     "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Rafael Aquini" <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
From:   "Julian Pidancet" <julian.pidancet@oracle.com>
To:     "David Rientjes" <rientjes@google.com>
X-Mailer: aerc 0.15.2-52-g8e0cc222e2c9
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
 <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
In-Reply-To: <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
X-ClientProxiedBy: LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::11) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 37162af4-329a-4eb9-f88b-08db77e9118d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv0EutgIzWjezePl9fwVfJDUwpQGbtYMERztquF6OOny7+7hytCa2iExjQv2/RspfZKtIKsJ8xR5qiQDiQnpZfInWhDpyp0z+i9mJLuAwMuLVM495tOo0RnRdENPLSrS0+vo+ouOFmME/LCIYoswk0o32dyAlXPReXT8ldjq63bFAhYBQZv0o4mYFPelOuq29dITXO9b29vCC8IV9FHfQS9NrYULnfqfxt8/+iqgI9KBEGdOyce0TYn0MIKm5I2PwvgQvZKFGS1rBjvc1qTJ0dZ9YcIvV21teraefcXjCNQ4bEGKQ2kkhrIra74CQvsPaNhv+39DT8JJevPPpOF81S+Fq2+YLPhbZVTiLBFn4oOTzKWOQMeo2IWMrLwQ8FezTDprunqmiWeUYUkbUqt4xp//5RthFFhkzsdJ5AolHQvm2vWV5uGYKwlK7x6pb/rm8HP6O7856lqI4IbHjzhx2PkhOao3QlXvgWveERU/7/yMQNqmj7oC1AILXMzyvnuMOyxBgWtKG9Q5fNe9KCPyquDuMMwxJa+XsZyfkuXp27F9U7G3x19Jh1GNYt8z9R9M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(6506007)(7416002)(4326008)(316002)(66476007)(66556008)(6916009)(33656002)(478600001)(2906002)(66946007)(8676002)(8936002)(5660300002)(6512007)(54906003)(41300700001)(86362001)(6486002)(38100700002)(186003)(33716001)(33964004)(6666004)(9686003)(83380400001)(21480400003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVPWDhYUUcxZkpHaUhScXhCMzhSM2tFOXV2eTBCbnhXSThqUE1wejVIaGMv?=
 =?utf-8?B?cEdudDVpemUxMjNSQTEzVUE5VytvVXJBUEp2bTZxVUJmM0ozSVd6UFZINmFt?=
 =?utf-8?B?NlBKZ21iS2VWeUR1SWxpcS9lZ29uV2lVZHltZTFvTFR6YXpwVzBsTzZTREsv?=
 =?utf-8?B?aHk3SU44MzZmYy91akJPT003RGYyN3JkMkRqWWd5eHJSK3Y0OW5SWkN1R0pQ?=
 =?utf-8?B?NkszREhPL3dzTG1RZHc3cGpnSHNYM0ZwTG9CMVRkL2VaK0tOdlp3dnU4aldS?=
 =?utf-8?B?bFZDQ1dpdDhNZlNrT0JFNU9Kd2ZZczJ2elM5M25kZGhuN0IzaENPOEt1ZHNh?=
 =?utf-8?B?MEdLSmpCOGx6VXJ1UGM0VG9jRUdmN2NIU1J2Rjlyc1lLaHI4MXhrQi9wRnpG?=
 =?utf-8?B?R21ScU9rRjY0NVNhZkVvMnFKa1pjV1RQRTJBM3ROQkpKZjNOdmJLZU1RSDRG?=
 =?utf-8?B?UXNwVjVvY2JHTncvcEVLU3pwazBVZEFnQ2FBQkJ0bjBMaFc3Wm5zd2tzUkI3?=
 =?utf-8?B?N1ZVOFgzN0pIRlVkNk5EdC9pNFVNTlJGMUFQUVloeU5yd0QvNXFpUXpjTXNK?=
 =?utf-8?B?U1U0cGpOSTFsdGNpaDh3T1dyd0RielR0NGovVFJrQy8ySWFtK0NUZFhzdElp?=
 =?utf-8?B?d3JWN3owNThPc0pkTnEzK3FIenFrWEVtQmN5Nm94RG5KOTdDaDhPTFRlVTJ0?=
 =?utf-8?B?SllKQW9pdTRuR1FPcUVRVjI1YzQ1ODdCZDVTNHRjV1RmaUVnbC9xLzBpRFI3?=
 =?utf-8?B?TWIvQmUwZS9jUUljb1VaSXpqdTdwZWpUaXpTOWw5TjNhbVNjY0ZLbEpjbUdT?=
 =?utf-8?B?dlpzeUVpRUJOVWtoMnZjbkhVc2tCNmFIcGRqT00xa24yVWM5T25ldXMvejZv?=
 =?utf-8?B?Uk1FdE9vR2lKSXltaWRrakdTQ0RJUnhXUnVvcU5DWnZmS256TE5Ka09LRENq?=
 =?utf-8?B?MnlMU2w2Y2ROenJNRG5UamlzYzIrWFg1OExhN0xnNWx4STMxcG1ZRHYrVlVa?=
 =?utf-8?B?T2p6MkRxd1hFd1UvU3ZtVmZna0ZFZ2pESWpmbmZlcG9TS3IwbzcyUDFtb1Ry?=
 =?utf-8?B?a29PMlFCdGJHWXJhWHF3cHRHR1A2Wmt2cm1SZXZUdG1udjRNUDFoaFE1QW41?=
 =?utf-8?B?RmtPc1RBRjBsWmRJeGVJRThpdGwrcGdNMHV4RXJVbld0M0dCaDVsSm9IUnF4?=
 =?utf-8?B?c2NHVUJ1ZTBvV00zemFvem05SHluNFhpVlpYd3VmZ2Z6bHVNekt4K2czM0RR?=
 =?utf-8?B?SlFORjgzZDRVQkxHSE1YaFVIWHM3eERJOE9NNXBjNURtYXpORjdRc2xwTXRN?=
 =?utf-8?B?Q1V5MWtYcFJRY25vNmRVVWZzWjg4bDJ0VU1KSlRJWVZGTWRFTnJZOFdCaFJQ?=
 =?utf-8?B?M3BxdzY2bHZpUWxDL2hNU1NpbDZxODlpMXoxdHhQZzNFZDExTHhlQTJPYytn?=
 =?utf-8?B?bytwRndOeU5vR29oUENzQXJjNkxzZTJDR0NOdU9zY3Q5M0plZHZTREZJdEZI?=
 =?utf-8?B?OG9DckRRWXlIU0NGWmhaWkhPbmx0c0MrS3phZEJUYzh1VU9XdU5CcDZCUFVm?=
 =?utf-8?B?YSs0VlBWbldMVlRVQ2Z4ei8rQUpJRTNTczA1YThVSHZlL054SzhRRUtOcjFK?=
 =?utf-8?B?a2YwOVphTVVqZjdERVNURFlLKzIraVJVbTJ4LzArT3ZFYWFUZEQvNzdIQWhz?=
 =?utf-8?B?TlVNTnl3UWlWS0lQTzFuWUhxL0EwOTkwL3BPTDRBeitHWjFSZWZGNlRvazFO?=
 =?utf-8?B?VlRSOTZvYXZoNTQwdkRkTjBrbmtIeE1reHpjKzBwMVIrME12QngzVWtKbTEx?=
 =?utf-8?B?QmhNYU53d2hTbXBpTmVaa0NVK0dFc1gvZjAydUNEMUJRY3lnRnY0SjJXRWZV?=
 =?utf-8?B?b081MmFBZm9GdlZXcVJxdjl5VmhKa3dxYy9uc0Z5dVd6eFdlY2ZvNjdrMEtY?=
 =?utf-8?B?WWZkTDdXQXphT3lDQmg5Y0VPV081bjhmbzAvUHNKdWV0ZVZGejdjNFNGLzdN?=
 =?utf-8?B?OTdyVXFpc2JoWEpSTklrUlVjRWRoU3FhRDVNRHplMGV0bEZrMnBlYVI2blJv?=
 =?utf-8?B?YmJaL1JmMzl2NDV1OGdFU05mMS9rT05RSDBOVzBoKzZlblA1TnhWYW92WTN6?=
 =?utf-8?B?K01BRHZ3NzZnV1Nnc3plWmU4QXNNbGJ1MFFQRzZXNitBcGpTS0J6aEo1RVJ4?=
 =?utf-8?Q?9pYeRInrGINltHIsXPBcMO4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dUVPWElZTDJGYVRqMVpvTEJ1YnAvWE1WY3AxaFBmV2JYMERsV0hJbDZRRFpO?=
 =?utf-8?B?NkhZTUUwUHVjSlViVVVSblo0cThjTDZlcWNsenhRNVVlZGpZYmkrOHYzUndK?=
 =?utf-8?B?cFF0OWg4NkMvWjFsMVczd0xrbWx0enVEUlJlazF2K1ljV2l2dy9rMzhhdEhG?=
 =?utf-8?B?bit1Yno3dFF1SHRzd3NjWUxxUXVjc3Y2aTR5ZGduM2szRzdnYVJnL205dzgx?=
 =?utf-8?B?WHJqaXhkdlo1RXczZGVndW94T2QwcHQ3ajVUZzdxWHdKaURuTHREdnBzMTls?=
 =?utf-8?B?SSt5Qk5iTXhzV214N3RwTWxiQk0vM2lCb1dWQmNlYkhMU2w3bHdVbWVlUUxa?=
 =?utf-8?B?dHlKTUpaNjVhUTVDcG1vS25peVJ3ZDlCeVFIWHhSOTA1bER6TjMyMzhNYUJC?=
 =?utf-8?B?S2V6WCtMeUdsSWkvOVE4Ukp5NkEvb20yNnUrR0Nsd2V0S3hFRUhLZ1BPUXVJ?=
 =?utf-8?B?UkNocW9zWUxSYlBOWit2MExTTVUveWhnTVJPUGc3YmVDNlY2bjJHRDljUnov?=
 =?utf-8?B?THBmbEJnQnRkVjg3Mm5aQkNneGVOM1N3bEs2eEJ5amN1alJkSCtYQi9oMDcx?=
 =?utf-8?B?WTF6ZVN4a3N1TndYaC9JS3FMUEorTndZREpXeGtqLzY4MTIvenlqeGFzeTAx?=
 =?utf-8?B?VlYrTlBNaFhzYlNCSHRabVhUZFlYNlNOckpPTVdFV1A5cHV5QXozeXlFTXJQ?=
 =?utf-8?B?b0c2QW05NlR4Yk5WV3gyN0toUWh4cFQzc1QySDNnNEc2MTM2VUpIaW5UaWhm?=
 =?utf-8?B?dmlrSWxWamg3ZHFxZmEvK2ZEcGtkdzB1dmhmNHljRXdDUnFDQmUvNG5xRzBh?=
 =?utf-8?B?dm9DcDNpT2NzNW9nQlpvVTBJdlNVcVR6c0NFNWZzQWNGcjBVWEtGakFORzdT?=
 =?utf-8?B?Zzh4L1FrK28zSEpFTFduL01jY1laMTFlemRRVTE2WjFvbklWaXB6Q2JweFNi?=
 =?utf-8?B?WGJDWGpnUVh2akk3bWR1QkhUUGtGaWxXb2JlSVcxN1IycnVuaEdjQytnMHo1?=
 =?utf-8?B?d3RFTmphL3FsMmhYdGhPSXFPaUYzekNhS084dTdlMG1jazNJT2tabnZETVY2?=
 =?utf-8?B?N3huNTBZaUFWcXAzc1U3Nzd1bnBYQTBNbDVta3RiRFY4WjhzdUorUXp0dDIy?=
 =?utf-8?B?amhwUm9NUHVXZmhKcHpoZnlLbE1nLzJURDhHS3JUd1dRQlB6dEVGL2loYmxy?=
 =?utf-8?B?TG9lZ3doYVJ0U0d0SHRRcE9tR0dIaWlVcTNaeUY3WnJNUDVVTjZXeXlKZGZ6?=
 =?utf-8?B?L3pvMG5ySVZCU1JXWkhCbExyK1JxTmNCOTRQWDVUSWFyVkMvdksxT0ZZZzRp?=
 =?utf-8?B?K1VLNkl4WWlBbXJ3aTZpQ2hGenBFSU9keFZIaGh1TUltd2dEdE9kR1hEMVVy?=
 =?utf-8?B?QnJ2cmsvUFhWZy9JM3RSTDdYNWJSVUVFODZ4ditZTGJuNXFyZzBXZnhpYzNO?=
 =?utf-8?B?bkMreVhWVHJXQXd1RWhhN3dlRHRNNm9UUmYvTFpaSXI5SnZxZ1JjV1dmTy9Q?=
 =?utf-8?B?WVdaK1F0diswVVdFdDIwZDVEYTM2SzY1blRBQmhZcC9aTk1jdGVUK0hoWCs0?=
 =?utf-8?B?SWRyQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37162af4-329a-4eb9-f88b-08db77e9118d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:05:11.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R1FYVd3w46q+Hp8IUMNCFuwEmekaDbVTw19v89OHpYflAISjZCVKC9aELGNkDvlqMnpNn3nsUGCIbWFNcx/3eQPcgX/h5nKDvUHFBLCwGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=897
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280134
X-Proofpoint-GUID: Uc2SgQLhOcQeLsQRLBi08vLMSn5JZEFH
X-Proofpoint-ORIG-GUID: Uc2SgQLhOcQeLsQRLBi08vLMSn5JZEFH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8090e66db7e30980d4e7ec6477b8ce05ba2136fb45d0958c46bd4cd69e74
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jun 27, 2023 at 21:32, David Rientjes wrote:
> On Tue, 27 Jun 2023, Julian Pidancet wrote:
>
> > Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> > enabled. Benefits of slab merging is limited on systems that are not
> > memory constrained: the overhead is negligible and evidence of its
> > effect on cache hotness is hard to come by.
> >=20
>
> I don't have an objection to this, I think it makes sense.
>
> When you say overhead here, I assume you're referring to memory footprint=
? =20
> Did you happen to have some system-wide numbers for what that looks like=
=20
> when running some benchmarks, or even what the slab usage looks like afte=
r=20
> a fresh boot?
>

Thank you David for the quick review. I'll re-run the benchmark and
measure slab usage when the system is under pressure.

Regards,

--=20
Julian

--8090e66db7e30980d4e7ec6477b8ce05ba2136fb45d0958c46bd4cd69e74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQTd3Z6iZzTygRNy7F4XFh3U+bgUcgUCZJxMJBscanVsaWFuLnBp
ZGFuY2V0QG9yYWNsZS5jb20ACgkQFxYd1Pm4FHIWnQD9F0tzSCq9lVJTGJEs19as
FGvzcVHNOaULKR9u2b0E1TABAN0T53eZZyzROe/er0yBlyy4ia8gqq+8ujS8u81+
rPcF
=DIku
-----END PGP SIGNATURE-----

--8090e66db7e30980d4e7ec6477b8ce05ba2136fb45d0958c46bd4cd69e74--
