Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D16CAF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjC0TsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC0TsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:48:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C09E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:48:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RJYcAU014854;
        Mon, 27 Mar 2023 19:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=q2lRqeXcM02lNAi6IXfHuGF8Y5GyVfmfFiOMZ0qDulo=;
 b=jE2icYKi8CL/hxIrRV+TDqF2AzPd9gVvrxjzop/EJIV8pOELwCjHS0TlvK6k4BNkA87N
 /t91eKg4ewcIqkcnh4wJz8l4Q6x/Jj0ZS9UlPme9DcFeSTMzZtRR3PXr1hLKpRsLKUdI
 AGe22uz52HarHYZ/JDIo19YdrRZLN7IiBYBVjyjmyUTE+hc2SA+rRW4gH4A9gQMiYk3T
 da2RCCGWv1ahjjqC5AozM/FBQSHgTvy5smJH+iLyNHBGILiOhPfNIDQCXE2NqFraBybT
 qcRSAHRQvNPzdYHHm/5kxOe0wfjwVStRORn48EiIZaNjjUiX+XwtG2EK7lp+8Wor0zK1 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkhdsg127-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:48:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RIYNpG005473;
        Mon, 27 Mar 2023 19:48:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5ehtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYYLpTOqq9vAIVaD8UaRCQmIgJIKmgzEDO6pF4eec5ha9PZ6p9X4UbhW5g0y+hp4EToJIPRBItcQPGVNNMnUlHwED7yhwK5bNTb5UIINuKtsquxs82l61dZ7iAmxRLGhNFDGdHJ6wjlvsMgWuYbYxy8XwBAxrmIsqJoMyE1qKcWA9r1xlIHjeGm/nJp78TVZCoDjOducZD3smtIIyWDWTfXhQ9hkLuNtD+lpFvDDAm8Rc55h24btxR+t1B5BIvz0EK5iPMPInpX31GrpwZYHKFaDdcqQkWvflLNa9L7TFG1uL7540rTP4U3Chpl/X/7w9kHYvlHa+vil9Z1yquW/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2lRqeXcM02lNAi6IXfHuGF8Y5GyVfmfFiOMZ0qDulo=;
 b=MW2eXrpn4K1aX+Gxg5Q/B/FLonU8pnZTqIsWvstexPXlkwQw4hTmOGIoC8o8wdWTa8sTSGlYgD6AlVoldZQtvhZMdQOocXHT8prMCGTR4qGS34nY85ViWKcIK71GcK4HpmodIYhy2clDEMcpEQCODW9LUsHu/a3xwtaLK+qmyhFmj63I792mHGKESDv4N1zQoguW04NX+QZGq7DYOU6h6mF0rjXch8trNdWyKPw5P05fLVF84O7h1OHVWI4Wao+vGjiXncy8JLhQjhzYx/ubmxpjN3Lmq4mmtDt19i92vR791By2jSCCIUm3S4p/bLiJuCku+CYPKINxeMPv60B9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2lRqeXcM02lNAi6IXfHuGF8Y5GyVfmfFiOMZ0qDulo=;
 b=kQk4fLkPTQkGJtTDH8MpmJOlne4K7LE6loB/90rghzrXVtt4f4YZMejY4R3SBx5PyM+7SLyfjFvLi3r7bP5DPY8Pr+vQ2Y0iGYwk6PVop/byIcHpd4zYqe4BTEWMcjidzk3lJj3BW4R2TGTFb1BzstNVbF2vbgGnekhJIk+eies=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:48:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::9fc8:73bb:cc29:9060%5]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 19:48:03 +0000
Date:   Mon, 27 Mar 2023 15:48:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Message-ID: <20230327194800.fzqfrxfh3nfmqwgk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
 <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: dc86de8b-e33d-47ae-65d5-08db2efc2d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxTuoZJM/jsvgprSHfiLmXlUc1vwMk9nU2Kq8Aa7OoSIlS3RGOGJK49aHCbjYt4S3Zx2UL2smaE1gEGdGXVh6rOAAwPNdtxISBJDYLsIW7U5V0uXdom2MAQG5aILi6xaq6b9mIyBmhJLqzNGdGbci1CKvmg70XuNwDl1pWIJLUStodbmyTr1y3wQhcXPDu0CGL6Tw8UhoIuLR+/peXEspobCKUKpXZk/GZq2N+HKJV4zg61WvFFGr1NxVkVodRRqkOX0/z63S9ep1ohnuOyh2d7qBCcIJgkw9hVIGK6rhvUZbyQ5otwRcPQ3Uzej/3kqii1PDbYnqNbj2h8lhy16MAVIH0dHppB8sUBnkYFwsCv2S64Aw+kGEPEKSGYSuIV540mW3UWf8v+r4UMfQ51YbEa1oof2JGPuR2290eE8vLSjuZqq7MtMdqi+2iPHE3f4LFPH5+tEfxdF/f5C6IYfplHhP124kOsbbnbjtz0q4VAsjda5IvTt6N/K0WKwFzV0djLnYyBO0i+QoociQJQQLOyBCRzjaaO4l+5cT4RYaiRDxos8ae9T0pmRk+VQ03At
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(1076003)(9686003)(6512007)(6506007)(83380400001)(26005)(8676002)(186003)(316002)(54906003)(41300700001)(66946007)(66476007)(6916009)(66556008)(4326008)(2906002)(8936002)(4744005)(38100700002)(6486002)(5660300002)(33716001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWdEB8ARIE6uDLM0CJpvPzI+pVtSio2TPLvvVnJTmszZ+1uy43Vk4cRovcM+?=
 =?us-ascii?Q?N21c/5OI5V6hla7KjgOdx7pmAa2OcV0FZURllZD4jVdUmg3e7vC77PYSsDAB?=
 =?us-ascii?Q?A56we3+4AB8gvPRHgs/lImDUpCc7rGdgEzqt9QGARF7pKTHepoO+ZbiFKWt/?=
 =?us-ascii?Q?rufh2ZSHN2bK6Uou+4x7hWYBAehpvHj7c7AzUj3gHM8xG3Eg/mzEFWNvDR4B?=
 =?us-ascii?Q?vSVK4B98mYI13hgLxV0Gsh2QucJ+ZBONcsB0Ziv3UXdhrDw2WjjQaLzkksRV?=
 =?us-ascii?Q?b6jWw64plPk3HvtQDWN9qcNln3ieHHVt/cqKf4hewl71jQ8C8EQcpBYXKiIO?=
 =?us-ascii?Q?7ktv8OiaaXF0biZU8PFrkWB3BjmhA7qmWBlBpufVUnpPx0mA+NQDm8RzmA9o?=
 =?us-ascii?Q?NVf0M35RYPmUhIqlHIz7IIKQ3umE4o90IgTfOLoQVennb9t7Vmp5o1HAfdvZ?=
 =?us-ascii?Q?hESv/DN1sGDvyL1w9VZP8f2S/uIG9cgMOmammueQrJRIEh0Y2lVYKG3lLOLT?=
 =?us-ascii?Q?NT5Mx3d7wpj8woPo6I0P4xUUUDIVlkeH/PzdfN4OwdgD2bnUTwj2MDqq7hbR?=
 =?us-ascii?Q?Xy+8CLorIY+yTfUJ+03U0FHLcJHDNkWOkfKx4ENBpSbEIit1pDLb7lrnynU2?=
 =?us-ascii?Q?9iCENMhTFp+xbLnRIDuf5VkwjMjQcUiLERrWTnICDn2HCXWv2SIDnyKAWcO9?=
 =?us-ascii?Q?5VFAnC3TZQrcWDrnpjqcrLNt1dPHEBNkYU2CDdxFy5VGezfATKEzH+rKHIhj?=
 =?us-ascii?Q?PB/BiyShiC+QVVl5l8u63GVgoaG+VIm1j4p2t4dvtjMowova5JW4N7zZctr6?=
 =?us-ascii?Q?iDOXwIdKJNr1h4sYCq06dZYUcGuyBfb3S+vsCyz4mi8Ti+FNnT2rfcsR9IjT?=
 =?us-ascii?Q?xeOFK5+2lytnm+4x6Fu5VOLuRvyQg4oU/BmzfTuuJTnm0tMF/cdrC+L0K4to?=
 =?us-ascii?Q?r59tTIANFa1NjSpcvLthvi4FMxTAcd2qm9U2ffGofk4B2QU6rSjxkFfSmTNC?=
 =?us-ascii?Q?Ko5m/cdMiSGV3YW4SbRE5tHluE88S77De5pr5tMs2uZFTceDXPDo4UBXpe7v?=
 =?us-ascii?Q?k3lw8hENwisRk5JoXrS5QLm7H7nq1sVKLBaCSOowcGV2mFRkfruIjcRDa4KK?=
 =?us-ascii?Q?vypu35jl0s2XwGN0Ks+KyEbvp6dsq0ID7yUoSFVPe3ZzcE2gJqCmgYBMCh3F?=
 =?us-ascii?Q?W2mIWhvmGN9ypVWbefxAd5TeLYpV9fsr7yBRiB2AMen5ruTQ+K8LuSBqWMvf?=
 =?us-ascii?Q?rfTEkzQSWpPPPBFNgrCvpsSZGTmGzU33yAPTObnMo24DdfYDg6aJJw02mQ2s?=
 =?us-ascii?Q?t03SF2v9DDoheUthw6OBgulO3lFo5THSCxb/nuqZVU16771wcUOX9JxkCAs4?=
 =?us-ascii?Q?RQOAcVVajhLxu+xCDyCTEBZr2luk7HxkamVvfsAID6qvYXjHHTTbqhMEaOsM?=
 =?us-ascii?Q?+rI3BzA2kBT1dPveCTDh8UBGjFcpzSNYH9f96ueR42I00Nc/QMXVgaBnbkqS?=
 =?us-ascii?Q?BLlkygykChZRAUxaDi+8Ao8rbo2C65xLOtZpHCB4NxE5CwufERh/o3UHmkue?=
 =?us-ascii?Q?+Ko3OEwhxywF/BgI9YQPDP20DgKT7tQBOHop9t5cGpw99HLXeSaYA8vKL3Tq?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?da3IE1nL97xYrPuYXqpD0vgg7lsytZXqkxaRzAaVe8hjGgqMfcwxBuUvOkg0?=
 =?us-ascii?Q?J0qqQGheO2TFnsg88ot41wVCKbgXVloKCyNTMzzdvDBMo+PsC9bGQTduPJkO?=
 =?us-ascii?Q?YkoByxUI6P6zClh2+Xon5BwJ8GmRK1EaUu2BEynL9xH1erveJmpgN9tpj/QP?=
 =?us-ascii?Q?At7p/D3srGy027Mz9FsZGNR4YIu6lMyuLNsA2kCYYZYnxKD8odFUwdUDKuB4?=
 =?us-ascii?Q?aeFmodlhDEVeYtcSpqnZP8Ztm3EEvL10HWwaqZ2N7H3Qsw5Bhv6MYMvBCNVN?=
 =?us-ascii?Q?UaN2wta1Ty9jYaUvwHsy0fpU12WUikZl1Lpy02xOzfPvpLFRFW88p7eJ0Hae?=
 =?us-ascii?Q?XM4KdOmVTDZF54RhEsndV5Qqq3C2g7WNDXQf4KqGxQLDXSPs8mKZ8Mb7QXRx?=
 =?us-ascii?Q?3evx2mr3AUkLz1wwoHl8IrLHav2+q6yc89QHPU7AhWN8xTDK9MXAP4BlOjWk?=
 =?us-ascii?Q?bL393CcNVodD/Q20r+Y0w1mL/A8ODd6s0aJX2Lxnee+f4BvJdP5PLwo4CI2u?=
 =?us-ascii?Q?i6Mu7hrblkSr1JuswLmo0n1oHxw+O71F3tGtutgq/81hGdc+yc/K/vklNugy?=
 =?us-ascii?Q?IY4seYbt/sKorMWW36MmLiJudcahfz2wNdqOFz/aZyxJjq4Hb/dBSGqznHT+?=
 =?us-ascii?Q?fPGIbHbRcysV3y3bODmhMzDbwmIKuSJwLhBQILt4QwsJ3psoVq5LhwBaZLlf?=
 =?us-ascii?Q?xO747is7/FMQdAKxcN7VYKiXtDjm/w9D1nCVK6xYlozdi6t/Uk0ZmxwypPyZ?=
 =?us-ascii?Q?1RdTIvlCNczArHJGw100e+EVgEVy/eaQn2i3nHooTG0V9qbHNnBjO95vWXyJ?=
 =?us-ascii?Q?RZPKNIETfWtWqpXOJ1u28fMc1HO2/lATcgW3697OiBra/n2MJYK0msk7pCZk?=
 =?us-ascii?Q?kq7CaVGhW90Hl3CadTbs5eBYxip/gMIpEujfYc8Wg/Jw6BY8ArMEHPzkzEWu?=
 =?us-ascii?Q?BeP5xOy5WVw7lNXI8N8hTg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc86de8b-e33d-47ae-65d5-08db2efc2d73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:48:03.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmzEM1FnGoes2m7v6gM2YxzH648YoZcnM1PKIazBNUeWEbR252IcKlR2f0H+YPAqFT57POsIFgklGPtF/tFG8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=743 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270161
X-Proofpoint-ORIG-GUID: twAXGF4kunHyRYimV4jBQ9XtPMiSeutj
X-Proofpoint-GUID: twAXGF4kunHyRYimV4jBQ9XtPMiSeutj
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230327 15:35]:
> On Mon, 27 Mar 2023 14:55:24 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > These patches have been in -next since next-20230301, and have received
> > intensive testing in Android as part of the RCU page fault patchset.
> > They were also sent as part of the "Per-VMA locks" v4 patch series.
> > Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
> > RCU mode for the tree.
> 
> What's happening here?  I assume you've decided that the first 8
> patches of the "Per-VMA locks v4" series should be fast-tracked into
> 6.3-rcX and backported?  And we retain the rest of that series for
> 6.4-rc1?

Yes, they need to be backported and fast tracked to fix the issue syzbot
found.

> 
> Patch [3/8] hasn't come through to me, to linux-mm or to linux-kernel.

Should arrive shortly, I received it from one of the ML.

