Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F3703E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbjEOU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjEOU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:27:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FDE86B6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:27:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJrwEe019159;
        Mon, 15 May 2023 20:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7vERknd3U+fEAvOHgHn+1YmTLNxU46V3PDX7DvirEos=;
 b=IYStVIpSgh33sqmkOPcfC9T5/i6AkuKiHborCm2S8ZI/4qY0M/QK6CgYUyf5+iti29yH
 +gs2/Mim+gF3/wA+99GbwgoT7ns82Q29C1TgPwpABCyZcvy8EttVN1ni8a3OrvfpWtb/
 SM8uqy6IVactS0IwHIBHVnKXGQ6DAgPdRf/28AN++RmncOKy7+CzfWkV7irNwzULMUJz
 x8Abj2Jm3UX/kuWb6GbCXbPdA7d4Bm5MWWg9oqwf/fRAgVIVpac0aCPO4fDbKPDr6h1j
 Ae3vCD2eOSpIHLpqH9y3zwS13fUw2kd10PPQcZ/ye54+3gSZn+UT4+IicabNMyGUYv72 oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u12kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:26:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FKHoG6022015;
        Mon, 15 May 2023 20:26:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109e4n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFWG1i/2+PAE1YqCH7SIBY+E89gm3lwd5K44CILwdqidEn1sxCHFbf/887GzXceEL75M1dx1DsfgLx0BMinWpZvBqg9nyzXgacIbj8vQ/Q/2fp891J38o4X4vVkek3CNH6ywL77d0NdJR06q5HrhFh+n8j5tW90tJ8p6FoBb5DTNr2mJ3HOai8G8nPsIQLjZBNtxWsStwwkmaTsE4EODcYNUm0VTtDgkzYzznd40LgCtHbaiCKreWSvJGYfGKzsMKmsHC0lJopdLWA+ZpKWJUCqx+CBhTnHqsESsMPjYylidAaew0FXNXbLNor4igCRe0NRWY3yA9UrBX/G71R1U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vERknd3U+fEAvOHgHn+1YmTLNxU46V3PDX7DvirEos=;
 b=QLwK8QMf05tIr1G9LK3VMJmeD6oeQycN1D0GKoMGsUDASMpijs2p7iKXgQjxEpeWUqLVl/MJwJx+XGyHu4SupMueyx9n9d4LC1lukGdQQ+tuqJSCVNpxnwrIUuGm2977/QFwoEA/F8mrJ6jKXnb5Nw/smMMgSHhzjQSd5xpcR/oiI0lK45dwKD1E354o+MUSzNE0z31RTJ/xenaN0M8syY8O8/2eDswYoRqXnTlmAH1zxeDy7mLJxchO3HAXS701zAQNQBxJqOk4tLAUskmKnUX7gEkq/vvc6zSi8qPYxx6+t4cs0UQ9uvv2fh7TI3oV8jpqgiHJW6IMxXe+FzWEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vERknd3U+fEAvOHgHn+1YmTLNxU46V3PDX7DvirEos=;
 b=WRlbSKP180ozMftqHqC6pWchnP/W2YvwKRcsbIsD2AqTd3nQSz24eNRrGqZtW8vkLLonj1GQAJ4pnFkjvm2k1v6QAEFX5cqFwdTRl94nGquXO+FpCanffCNLJZTPZBseMZsLLSCxdM4ChFTjaNHsnqBpX9m1swJSuA1D+A0uEO0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:26:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:26:52 +0000
Date:   Mon, 15 May 2023 16:26:50 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/35] maple_tree: Add mas_next_range() and
 mas_find_range() interfaces
Message-ID: <20230515202650.3psyybdg64ptmx6i@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
 <20230512182036.359030-29-Liam.Howlett@oracle.com>
 <20230512160857.820fc7a14256c1031c586113@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512160857.820fc7a14256c1031c586113@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 854a4876-11d6-4e81-79a1-08db5582b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFJuCgawyqcEUSVJFGSqs01nybYSqBEO9LaDX6xFky3c7wq+lWxo9Fek1yP+T9/a9NR+0EukYd8Dhs5E09fAUnaWDWGZ4iawogcM5iIOWLtundo+i4Khjv6LjThyGrVWm9zvK+nilwQKuLc2sCLDIFxXi18WzvJVQBI5W+DvmdFSDgQ0BlGdOIea0YZMumZE7QGhHi30Pns6kUdGMP/a1v5k64DPCmuCe4D//u9gZpKY+eCg2KRKXxDuz7Kl6qWFjpalBWWkFIet3kvXCkvpjfOfPzi6tlUdsn1DulMpEXyhlE5sX01SwpBIaeCrJSc68Uc/Fpn9/SkFvFmQiYyGkjKYa6th/ds/L+Z/hAAdoqlco8nOgnr4p77LOzSDrrsVdptz4QmtuOvuCZAlXEFBUX3ujs/ZreZv/RvMb/E5bfCI8GKem5M34ABNZ8rntzEfSDuYXUE/vWluTQyGGhp9hx+lnUN+6P4ObakWdzkD7K1Yrcz0kiJZlIzM+IOoabn9tChelaFHlAF+MF58z/caBd45gA8wc44+jZmTQUSXnRijn4OH7nIHk9V+tgoVCk6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(66946007)(66476007)(66556008)(41300700001)(6916009)(4326008)(6512007)(26005)(6486002)(6506007)(1076003)(38100700002)(316002)(5660300002)(8676002)(8936002)(2906002)(478600001)(86362001)(186003)(9686003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qA71a63fmVu49qARW8dN/skKVL1LTCPR+1EyEWVILCxYgq6lILdtFfBfP1uA?=
 =?us-ascii?Q?0TRQRmCXApTJTerWu+WlroUUoiijzukN0fMPjLUYjoQFt3VUxmSxnopFMLmC?=
 =?us-ascii?Q?OxNJmze65YNkS7qvcSGt0Ei0RAh3uhT2adEUBfLFybNpb9DOLC6Lm0M0km0m?=
 =?us-ascii?Q?EM8kEJ/2k3PzLCEotOHxcjj1lpncceL8hLnMjUgSKpoKeh01MfnbM78D4hMk?=
 =?us-ascii?Q?RNWWETtFaU/KSj7BN/oD2nv0EjIGFFV88crCqJfpIqpf9m9rO5RQj4fCrdeA?=
 =?us-ascii?Q?PmruerWfYZDGMNLyIZUvo4zGQRR/2cOixYfXGGKRrkc/OgOG07vPtiw0JvUB?=
 =?us-ascii?Q?lNsqynsP5LV5zXdc6oo130oZTXW/Fh+Hfc4r3CJBoJEJeY+OUrhPv7XFthQv?=
 =?us-ascii?Q?VNxJplF7TaLvCac9LImUj6VrnwrQh1pI4GC6EnU5yZWzIaIIDFa9tfSoGo+g?=
 =?us-ascii?Q?auc+5Do7EhxM4MKUk22gL4v4vxgj7UexJ1dXz8hHkJElh6DSm0iXnRoqjdAi?=
 =?us-ascii?Q?lBsMHy4BpW627e6AbKf0BKb7sVIL5a3RUjq6lqCSWagHeY4xl4MYSthV4gN6?=
 =?us-ascii?Q?HMLEKTM+9yckT6iE3EcFCCpY+PvB9kB74ILfdA1/Oayaeo/zO9wLm1l+ekI+?=
 =?us-ascii?Q?udbYDR3BlIEa50J+ANDuhOo75Ad9r/bFAlgZLDzIzLfARyLj4SfUMiW9XxFy?=
 =?us-ascii?Q?KUjFxf2G/G5jUYhdT05sEHoeAVFmlLeDrYBZZs/C8qAOXi0UmtFO0vfa0Lzn?=
 =?us-ascii?Q?UzwtDkBhU6A/NF/XS015mslQERmZDYxHV1iD/nMHJ9ACxZQvtN0/jpLZL0fW?=
 =?us-ascii?Q?A6YNTcNPo3ReMA0MY47V5DWFyos/1mQuBVvFteOzGmnzovy6sczqOus+eeA1?=
 =?us-ascii?Q?DlvCQUeUJXaioS3SdRkEkDDyYjULIqbU6PJgRrEKEHlDBlraJB4G7VYlfQXn?=
 =?us-ascii?Q?X+/Lfnos4IxPzDzh4kUvQXD0TMl7wRJKktWsrG9B++VaoisiNSwO1HqwvxfY?=
 =?us-ascii?Q?VsxW2N2PSQ+q/4rKPYkWkN0eC4SfzG8zt6XD+DfM54f66iGfKH4eXUWaFY7B?=
 =?us-ascii?Q?3usL2FCvEbbdr9VxV0RR9kxlf+5BE4OJC+j0BUed8DkInoIP8utOIXfo+Ssj?=
 =?us-ascii?Q?t+fRo8UG69oF+Sxb5+NflqPJ4bcpa0deuoAIdbPUY4/yCBeaEzeccr5Zr4kj?=
 =?us-ascii?Q?uwudG/pkyYtjPTbGdjvCwqgJVgDXSXcPFviF9QGOPytgIIOvz4HUaYRsJ3Zv?=
 =?us-ascii?Q?MNlRMRpFEq/pGNK3eMGDrFqQCICfFysucS+9+HnG74CIjQnl15rLsARndc3P?=
 =?us-ascii?Q?3ybmem0kfjyA0JwooQjzBR5SOZQXQd+iyYhMpOMC7lgXbdFb2F/hTto4FdA3?=
 =?us-ascii?Q?TH1WuxIRHyp7/UT3pSB3D3RckT+dIzaJtM0jhPlF3wRZDmmKTxxPyRmz3LBL?=
 =?us-ascii?Q?iD+Xz1AGeXiKSvkQqwDVV+ht1IckmqU1Q3DlkL2YW1J+j9OxnTf6JTX0bIJD?=
 =?us-ascii?Q?aCKkbxorj4MEQ67qvCHZlfTtL+DLfgS0T3pjSPstLKCeIYRv87ZwHDeUL/6P?=
 =?us-ascii?Q?IbEls3xkSpvDWRqRnx9ILQ9kn6e+v3YpRtdSkh6bJnSR8jGiuqf3QIh9StY5?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vo8SSJ1zAA9fZYEZL15ly4Tsr/Eh85EY9wpNLUdMY69sOBRpP5Jd0YJ+pTJVAvuxifghHOqAPwUkhFM0dWwmiy2dyvhjCOdEvpPbaJ0tig4+JnmMQqWVVxdVJL6YWHlo1geqCL+uKH3000EQy37MZymEGDgqg3Flsu67MIJXbE7fVmCPBExlc0evqlPoAFyhLvqF/0uPOPEe9DWuLTD2Lw0ormnK2y6wN0JAASRK9MrfBs0F8viywexjwTzZGpyG/xxgCUIa/GrbYPcaGtmkxsoGM7CeSk1gALhvyW0n7nEgmUN4jeXgO7rvzyj36MvxmHiO4I/vdg5p/qrxE6yOvpJHNIUPPD9+hcD1kWmmqT1rpwt+dI+AwkwYeuMPrSlmW8VrQ8pppqFCc+k3lQL4L+SeOiOYG6y2i6ku3CWotG4+tiofKGhW6Wi+NvAt1NM9pxO/prKsvEasCVFfUMT/K4bh82/WdKeA8Snje8/g2mmDvxBuhigQ2VCvxGtJWfTs4Kj785cHDsCO3pOSHcleebPJS7vP2+aPDuUT4ZBwQWjHHiF26d3XWGYOaUqkcFUJKj9yefhGwsZKFDVphRjO6cmwegTwIRSqmT2GjdBNSWiKMA9EqhllesxOTqDsmxFKAi3eCuNncfI4Vnd89vNBNx0iqBqPZcSEBkcmn/vTsKH1JHSWzvXaNwNu6624LhX7xzsUcW5/sxey0ANJex37NtXCcoUJUmRetdkYDk9R3H/SAaMr6dx/c8Kp43qOa3vjXNuCgX8dLbHsVd90yLQrx5hwOwWYGgj+aH/6e0h2cndxd4VeWdB0ICesxpEQ0V5V5O8eqTB0P7UFQaJ3KC8hdaMR3cZaqC2Mgr777BKtuRZJ/cC6Q2y5Uo7osKKkp50/RnPuFY4L5Lc+3eReXUlApg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854a4876-11d6-4e81-79a1-08db5582b7ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:26:52.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W10c3CBkWT00R1fbQddB+UgvoqA4Gfu/ZNmjkQkLZCQxWE1ig9Gsx8taDibIYSC8RVYcueqkGxCbTg1X9lVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150169
X-Proofpoint-ORIG-GUID: Pn2wekHvDkCrufhQdk9Iv46qSGw-OE_P
X-Proofpoint-GUID: Pn2wekHvDkCrufhQdk9Iv46qSGw-OE_P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230512 19:09]:
> On Fri, 12 May 2023 14:20:29 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > Some users of the maple tree may want to move to the next range in the
> > tree, even if it stores a NULL.  This family of function provides that
> > functionality by advancing one slot at a time and returning the result,
> > while mas_contiguous() will iterate over the range and stop on
> > encountering the first NULL.
> > 
> > ...
> >  
> > +/**
> > + * mas_contiguous() - Iterate over a contiguous range of the maple tree.
> > + * @__mas: Maple Tree operation state (maple_state)
> > + * @__entry: Entry retrieved from the tree
> > + * @__max: maximum index to retrieve from the tree
> > + *
> > + * When returned, mas->index and mas->last will hold the entire range of the
> > + * entry.  The loop will terminate on the first NULL encountered.
> > + *
> > + * Note: may return the zero entry.
> > + */
> > +#define mas_contiguous(__mas, __entry, __max) \
> > +	while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
> >  
> 
> I can's say I'm a fan of this.  The name doesn't imply that this is a
> looping construct.  I can't say much more because mas_contiguous() has
> no users..

I got a little ahead of myself with that.  I will drop it.

My hope is to introduce it to simplify the cases where users are
iterating over VMAs and want them contiguous.

I'll come up with a better name when I re-introduce it.
