Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4548C5F6375
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJFJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiJFJQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:16:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4EC90809;
        Thu,  6 Oct 2022 02:16:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2968YTOJ011438;
        Thu, 6 Oct 2022 09:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zV6jcIVame4444P+C2k8LXZgwlwrXbwLvIxMagFWtbc=;
 b=U0VNV8rlRHZXyvsL5P8IFr69CnlmXOYw8zhec1pLCFIxCPP96n5z1goeVi2foQY9/Lvc
 WvDcay2LTe+JLd5RepGb8FUOYKeJPQG8pAJDBfH4LGKGHU29nExdzFeuGxC+QA3k/+P1
 Z6IJVmdMVMLSP6gr5D+JQU8SrHGhlSJFqY8n/vMT7l7DhiT/rgFXoNHGZHd/9AVJ2RDK
 gZ2g1qpmJIRBiccHu86d13OGH204gHksSd0hDceymouTcsSdC0VVrlDuYW2QRIK4Nksm
 PrSiBiT0p7MPs0f2tvsZGa8+syoIs6D8IXaavp8D0ZniZxwwTk+iTbs/Z6Da1LswyB6H OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdeabpfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 09:16:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2969ATwT010204;
        Thu, 6 Oct 2022 09:16:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0c5j60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 09:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDv306rT/rJLaYcSo8JyBTY6RWtCkbcW9RGUy0Em6xo7h20rI3/nFAqW331WaTir7RbEK7ME7HKbyug7MpRj7PztkcotmNi5VsZrMd/Ik0ZuZZet2qEOd2jmXStEpicl3COW/qbV55dTRi4P2iGj532pxkKJ/E/PgXvzRfLvELCnWgMUK75phL2JwBl2GTFOAPSLrkRNjNAGOiWwFkyPDr9GmawpkU0tbP5PnM8iTb26q/Ecuy1tZjCcP+vw97640lPAC6M7hhp5/B2c+UvfF6BMeZt/IG7m/i42rGnfflXIuN8NCcbhfPfuVhy8MB2cYCLxrQWYkjw6a2rliph3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV6jcIVame4444P+C2k8LXZgwlwrXbwLvIxMagFWtbc=;
 b=UhKbLzUR5uar5rG8gC2qsBA4v30JEj8Qf+UAgWNG9Q3aFJqX3ZtdpMvU6KcKFjXH7IeujrtuvDsS05RS5RLUO//jlRqgitlo8wuAzMjHhukk1taoHflyOzc8zkHCZIbhGNjGUkWGoaW6eNvN0KlSxZic0Q/+SUWFQvE+UKMK3f2Zg/ZITv+XM55FT5sdWy64USeZEjDvsdpzMr1tLNEdORqUeSVXATF8A9ahMBUq88GqNfuhsf/rRbey459jvMp71x4f5V4+ir0nCYlsoJIR3roXkMcqLk4TXzw9vWxs/fTEFeYjZzVWAXsTrVTloYDpQP/1rXNsB6PWb6CLSDe46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV6jcIVame4444P+C2k8LXZgwlwrXbwLvIxMagFWtbc=;
 b=sf2lB0VXAR/QSdE6YAzWG1kWyGnNHSv1pB/CyhAXHjPN9C7DCFD2uMSZ2dqHN+LdfckPipDpgoq7+gLWF/OM1cOYi9YSkrgLwGLHG2s+BCKVAUYf741XR87vaP3AMIVLM3YqDFNOS9fxHcJKMLk4vk45fTrnRydrqjTdJN5D5sk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 09:16:19 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::4c04:3c29:4a50:d882]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::4c04:3c29:4a50:d882%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 09:16:19 +0000
Message-ID: <7856c4c7-2055-1288-049c-043055c6d2c2@oracle.com>
Date:   Thu, 6 Oct 2022 11:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] capabilities: new kernel.ns_modules_allowed sysctl
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
References: <20220815082753.6088-1-vegard.nossum@oracle.com>
 <20220815155034.GB20944@mail.hallyn.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20220815155034.GB20944@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::29)
 To PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA1PR10MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 822d80b9-ed42-4402-bd67-08daa77b6de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXA4Zk5/9ubgNXTFC5Q2JkGn0L2ITrSPdw5yF9hzh/7CmBVmTdG6GbB0pu/VZuyy4kb46hZMN3oOduPLXpSNsjYZpuEFxFjAM0MpAvhrEakkVUNSN2iig/uoucAMJpVDWMgOtOt5zHtjaUT0SZ/Gaw/2/Srom+AdqPrAzg6YhW91J9/OvQX/C01lkoTg8pPahJ7uUPfP7pAn6qScvZD5GTnhz4xF6dq0+CMTsgmZBVg6DpAj3Xsi5fI7ECTzp4k9tDriB9/vQQFpof5XrFakcz9yduRTj5OJJtO6aigvMYJZoch1QNvD7JulcY7sHRMi1gd21aUV7I1PFMxP6EYsZVNptl/gl2RTZEGWRmV2r35K9VBovmRynM+ledol8haS//sqqFV/ZQfFsXVRTWAaI39TLuRDEyMY83x0Jn88P/Xn3CJJBhVU01U5YSB2wcO4uzWOrJwLxL90kgaGGKqQ70GZMZLYCQWtCzwanmEvq1jDjvSlu+TSjZTKaPGiftfLklxt0Wie1mL+/8H0Lzy/mktyUTrEkl5K5dCa6FtDjypuTwqKEfaBLJ3HGpATglOjKJ9PHYUFKKn2JLkHVg7wUocOT5En6d1qe8zp3KMt5W5l5aFS6Tq6VkfSseEv7u8ocQliuEprFZuK1CruDWOPPdC0E1UB3Ryne6wXFfdR+Pm2Mxh1M57QLtQgcoNfLCHvwe5Vz1LYh9SHQiesCsDjotaIy5k5pQSRqMcWubeuIr4AvmpKzVxX0JQJ6JELtjGxB2OXzcC1FiytudAFtO/ekEEsvBFHCEp00oVmSVtmP0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(107886003)(36756003)(2906002)(6486002)(26005)(6666004)(6512007)(6506007)(8936002)(478600001)(53546011)(38100700002)(86362001)(31696002)(83380400001)(186003)(2616005)(316002)(6916009)(54906003)(41300700001)(8676002)(66946007)(66556008)(66476007)(4326008)(5660300002)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VISHJ6dTNNUStpeHFtZ2huOW44aGd6Y0dXTmZNUzUxbDJkVHVVSnVtNy9l?=
 =?utf-8?B?ZXFzWVJPNVJXZVBBVkhjb29BdlpSZS82TTBqK1JCaExKNGJrS2ZETWdnSGlw?=
 =?utf-8?B?bXduR1l1ZFEzeW5CeEFmeGpYNW01QXBta2gxVllrRWkxQ1lva1BUT2wrM2lE?=
 =?utf-8?B?WlNaV29nWitmVC9vYVY0WHBBU01OYzdWd1pwTytxREd5cTY3dkN6bUNCc1hC?=
 =?utf-8?B?RXZENVY4SHFPZWl0b0d4VkhTdWlDVHlyWmJOMkN4K3BmeFhnS2xobGZqRVJU?=
 =?utf-8?B?U0hQalVpWVpVS0dWd2ZpUGNubXc4dlc5TkxwV0d6VlZEVmFIN3h2WlAvbHZH?=
 =?utf-8?B?NFpYOXBBZVB1bU56OFJLenRhUTlOYUIwU1hyQjhZcVdHb1pRRGZnQUVadjQ1?=
 =?utf-8?B?eEdyUWp0QmJuT0tPZDcwdXduOW1ZSnJWRkJXdVdGRnRlUkRtS2R0ZWYxVkYw?=
 =?utf-8?B?bkxHUnF2eWRzdFZobit5eE5STDBnQzF3MS9ncnBNTWlNY2J6ZjZndjEyNzBh?=
 =?utf-8?B?cjk0bVZmOXRGemNjL1h0MHYranFXQWRCMWU4dGx2TTl5Y2xkcmV4VS9qV0o0?=
 =?utf-8?B?ZDByM3NuT25raFN0L24xNkd0ZzEwZWl2MkI0b2RaTC9PdGFRY3ZCSFFvWThO?=
 =?utf-8?B?UEpMbDNkd0RSZ0ZLeUFDOWdxKzQxTkJJbWJpU1puTEY1NncvU3RiQll1T1Bz?=
 =?utf-8?B?SGtPR3JNRFRvUEJjT0w5WjQ4YzEyYk9uVWlhUFA4NFF2d21XTWJETjEvQ0N4?=
 =?utf-8?B?dHdTaklNWFMvZFhmSGozZGJEL2toY1NIN1RicjhWeVZucG1Ob05xR3pNa0pl?=
 =?utf-8?B?cFltUnRBZ1ljaXVMQmVOKzBpbk95UldjVEgzK0hmcEpsOUl4LzVpWWlCVTlD?=
 =?utf-8?B?b1Zlc29la2JUUUJIYW9hbWxJNnNXd0QyQVJpY0FkelFRU1hKY0cwbnBzeTlu?=
 =?utf-8?B?RHRkbFMxKzBuRnBFaXpKcEpzL3FVUnpab3lVRkM2T2MzdjhXUHNSVlExalRU?=
 =?utf-8?B?aWUwVFNJTTV1K1pBWmNac0FQYXBQS2o1YTVvUkEwOEJkcnZsU3pCYjJPNm1U?=
 =?utf-8?B?ZXdkaVpwTldLV2I0ME9Ib09FWVZTdFhPZ0R2RlZZMGY2MGNyenkrMFkvNkZl?=
 =?utf-8?B?eE9mOUt5VURmUU9BVTI5Ym16VWFqenNjNVUrYkN2RkFyeHVNTm5ndHBLVkkr?=
 =?utf-8?B?amgybmlhVWt6VCtEMURFV3U5S1BPcDRNalE4enRaR2VkYjVJcEl4ckVTRnh3?=
 =?utf-8?B?OWJzbjNLQ1A3UEt5UWpTajV4QTFzV1ZrTGFMbjJCRUc2elkrbi9SL00zSHVO?=
 =?utf-8?B?cVVic043MEpFMlZVZVhyUmxtTnpJQkdrTW5mV2g4SU5EV2N6aTNpdGx0aGx0?=
 =?utf-8?B?KzJRVG53RVBqYi9aN3B2RW1ublhjVXZqZGQzVTlCSFB3QWU0YjEwV3VnOXhQ?=
 =?utf-8?B?Qk9VWW11ZWxPTFVDeDhqVXBma0hXU0NBTUp5STJkT3FjbzRLd2d4Mm9acEpa?=
 =?utf-8?B?MGtRV0s2QTVkd09wNFdzOWZicU4rQjVxKzAwR212S2F4V0ZnQ0VZeFk0cE80?=
 =?utf-8?B?WmZuWE9ocUViY2xQSWg3bDE2UU5vcDlpaC94VXZ4c3Qxbys2OFhFQ2x2SUkw?=
 =?utf-8?B?QVdacFJ1L1FET0p4UXU0MDFQM01mUDc3bjNQSTljVFhvVVl2T0g1MU5NV3ht?=
 =?utf-8?B?NVhjSUZKRGNDSzdyOEUxNlI0VXJqKzRGR0NwcitGU0ZTclBGcWUvWFVUVnUw?=
 =?utf-8?B?Z2w0a3E4eWh5VGJTWllyL3ZwQ0E4WERCZzhKOHZweWZVeTBtV1VCamVxK3Aw?=
 =?utf-8?B?WnJBbFVwMzFJV2RoQStsQXhCZmx1cFJlcUpldUcwOEx2VnpyaGVLbWVTQksr?=
 =?utf-8?B?Y1dJL2hoaS90TnMzamVNS2lNbHhMUk12ZFM1Z2wrejBLS051ejYrSG5aWk9v?=
 =?utf-8?B?N04wUVFLdCs0OWdQRnZjZVpVbmZEaXBDZUx2bDN1L1F2SExOWWtBOGFkQjIy?=
 =?utf-8?B?WkZFcnpueUMxbFVJRGVCc3pRVHJWblRPd25sVHljVlhZM2F1SXFXZ2I0V1k5?=
 =?utf-8?B?OEwyWlRraDVwcm44dHpwRnR2ck5uUWZ0VzBwa2FLVmF2MXdaSEt6emJtV3lh?=
 =?utf-8?B?V2JUTkhSTmx1NlNoS2M3eHpZbkxwbUdZQndiS0VGSmJ3ZkRETkU1YmdPM3FK?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OHkwK0RZU0hQdDFkd2VEaGV3dVhoT3JobjAybVBNWTFSOWZIa0t4dmZGK2lR?=
 =?utf-8?B?NS9MMW9qWUwzVEdLaENBWk5uZDl6dEZoNEZvNU0yOFNzaFFWZHRWNENyS1Fh?=
 =?utf-8?B?ZDN6RHNKbWJzQVNyWC91bnQ3bE1YV09QaVh6UFJzbUtYTHNFVHZrMjdyd2ZT?=
 =?utf-8?B?aTExeiswRENjQkc1RVp4Z2Fqd3AwRHZxVGV3NERSVXlsQXdPUTFNRUw3NE5k?=
 =?utf-8?B?ZnZZT1dwQ043SFg1aFVUSWxzMzh5QmhwbG5BWFZpU0VQNC9wcUFqai9BNjVG?=
 =?utf-8?B?TUc5VUlPNmoxTWU3M0h5cUxPakpXZ29ReTEray9mQ0Y1NVdMdXJ6RGdha01O?=
 =?utf-8?B?emNvL3VWbjU0QzBENDkvb1k1YkRqNFNjOGlMSDdCdEI0MVEzZFJySHRsVTh1?=
 =?utf-8?B?SGtUemZ4dGU5Yy9SckZ5ejRHeG9tRWxVOXg1WVNwUUZrdVNscndTdmZIWVNp?=
 =?utf-8?B?V1d0NHk3d0tYRU53Q25SYVg0QmhXZUk0eVBMR1Y4enV6YkoyODJMejBDY2pZ?=
 =?utf-8?B?UlBYWkt2LzgzWFMrcWpYL3krWnVBQmRvTGE3WE5WeUIzREVKZjRaa0dObDRW?=
 =?utf-8?B?aFRxcjhnSTJmYnVRYkdyVFZhRjZyTll3cUgwNWlrTCtBa0tTKzdJZXArYzc1?=
 =?utf-8?B?U3NWT2FDZnIxTEVMNnRBN1hlY0ZsalV3R21HRmFnSmw3bzhBZkJPNkhrTDF2?=
 =?utf-8?B?RnVmQ3ZoMkRXN0lqdXFjeTZMakhLSFgyYktqTGtzRThkTzBFcnVpb0YrNit1?=
 =?utf-8?B?cE9qanZLTVZmaVdsNlFZcDF4MjQ2amhzRVJNTGpvckg4U2lmWklwYzFoTjN1?=
 =?utf-8?B?cURGd1lZTk5vWVFmc3JRUWpWT3FCeGpSTE9vUmVBdmwrdm53OXhhRnpIc012?=
 =?utf-8?B?RGlNS3BHbm9GOEtxbnVpT2R0eCtvS2U3S3EyeklQY3l0UCtRcnQ0S2xyN2xU?=
 =?utf-8?B?cm5xbEkrZmdNN0tRTWgwb0JJZnlMbW4wNUU2SEwwQ0dza28wR3ZoSkZkNEpq?=
 =?utf-8?B?c1RWVlhiVE5iU0JPcmc2N0g4QWNrV0tWMFQxUVdxcjY0YnFKcGZ2U2hJSlFF?=
 =?utf-8?B?dnFhRVlLaExaL3gzZjhuTThpT2Evbmh1MHUrZnJzU3NvS3czaXoxSkMvMk55?=
 =?utf-8?B?VXlPOFc3WVlReHZPUFhTcGh6Ni9FSTRtazRzYlVMRFdRdWo1dkppV2Uyb29w?=
 =?utf-8?B?VXZhcktrV2xLaXRWbGx2M0NKVUZQbG94YmpsQ01MallMZ3MzMkx4RnkzbUo0?=
 =?utf-8?Q?8LgcwMF19zcbt48?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822d80b9-ed42-4402-bd67-08daa77b6de2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 09:16:19.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQ6uigBPsuhsPKFIw1h9hGqOFEARm8FHW5PUaoupGdDUjFmvcXL/dSXvQKegCXacsp6vZL0oPn0F2r7/jUNdtLMxZErGbk578DGjQdQv0l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060055
X-Proofpoint-GUID: FX1COqXVaycgEc1k8sqKbdEaC0Qn3i2e
X-Proofpoint-ORIG-GUID: FX1COqXVaycgEc1k8sqKbdEaC0Qn3i2e
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/22 17:50, Serge E. Hallyn wrote:
> On Mon, Aug 15, 2022 at 10:27:53AM +0200, Vegard Nossum wrote:
>> Creating a new user namespace grants you the ability to reach a lot of code
>> (including loading certain kernel modules) that would otherwise be out of
>> reach of an attacker. We can reduce the attack surface and block exploits
>> by ensuring that user namespaces cannot trigger module (auto-)loading.

[...]

>> +	/*
>> +	 * Disallow if we're in a user namespace and we don't have
>> +	 * CAP_SYS_MODULE in the init namespace.
>> +	 */
>> +	if (current_user_ns() != &init_user_ns &&
>> +	    !capable(CAP_SYS_MODULE) &&
> 
> It's monday, so maybe I'm thinking wrongly - but I don't believe that you can
> possible pass capable(CAP_SYS_MODULE) if current_user_ns() != &init_user_ns.
> So I think you can drop the second check.

Hm, I think I see what you're saying -- cap_capable() will not even
search for caps outside the current_cred() namespace and return -EPERM?

     /*
      * If we're already at a lower level than we're looking for,
      * we're done searching.
      */
     if (ns->level <= cred->user_ns->level)
         return -EPERM;

I'll submit a v3 -- this sysctl is still useful even with the security
hook for userns creation that just got merged.

Thanks,


Vegard
