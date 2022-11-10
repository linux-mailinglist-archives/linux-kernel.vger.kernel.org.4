Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A00624D92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiKJWU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKJWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:20:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F51759D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:20:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAM5NBL003330;
        Thu, 10 Nov 2022 22:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=wF3Nxw3UI4VeDWx+CfuIWt75oW2HtfDuEpjTad1vnA8=;
 b=NHr3//kL0FN2XohxuXLPbYLj1znkcAAZzBFBT19g8T2LMrKu3/KccaW/8MEtt7B9DxvM
 YQTXFl996KqJBOtgcP2ZoziZqMjbezonBLXZRu38DSK96Bve+cPuyhYoPkYpmA62z4Da
 DRfy2gzrgq8DJa7EBgJQygmiDpWWmRGCU9LCXWz3kf3AwE4nSaP4E29JD9LfIkzW8iBm
 VxZo7a9jzsXil25RhX9kBVR3rBiTPdpZxpeIyPJvoNZKOs+hTtvPcvmGMSChPEWg6jJ9
 OPMqOO+/ER6T7g11V8HtavPNINhfafB8Y0vpnvXAsb4iwdJGkROQ4J1BcIuYTilG40v6 Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks9sb02fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 22:18:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAMHmtl038077;
        Thu, 10 Nov 2022 22:17:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsh6ymu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 22:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr22KnhSndcbrJ5PJeWVG1ydmxH0T71ZQIYhnDk7HglJTaNrk1OF39d6qCCc+WplH1FtC/4bigmlM7QRP0euqPVO455xdyyg0SQhtqhQKZEIrH9RF0N5utU5xAniy5NUqcW3ocbSFDBDF3W1NCXqZ5xKLK1KKdRJ8k4pVravFD7EqZjt0wrBScx0lURBSXZ41WYYOrooIMgyi9yfF+St2Bo/SfWDzv53hnJBFt8C7T0bTUCJs4cOLvs6W1p/KCgpj97g4A/9bbo1DpZ0Uj+zCHefI0XUg1g1XRqihnH+9nI+ZIAC6yNwXVSlSO7YvJ6kyX3tdp6J1jo2wFxy7oB+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF3Nxw3UI4VeDWx+CfuIWt75oW2HtfDuEpjTad1vnA8=;
 b=NXm575mVzjcbw+1Kt/MNp0CA2RP7myWchhnLWyFYOvVpNOnXvkqn0OGvSfBY5+TJ4zcs2jlqeZ9cl2LVrGMZDnUX3Ps4VoNVVYsQrs8vDhsANdtKQ+00GfGYfINkIfKx/1anHln+0qXOm+MmCm+6M1zK3cSgqBxatqix/5bqtOMFG0JryA3DF3uuyUqeBCnAnGtwl9KgYTrQy3B+C5qWIF+a54zzdqrwGbHmf0PsXsz+pN/djnQ4L2lxF0tgS+9woVakY4teWlN4Rtt3AYaiCgtGn0b+1FORDXrjGf+TrNhLguKkmxZGfbTHFkWo6+a9yZQ5PgJhG/hE4yif2erC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF3Nxw3UI4VeDWx+CfuIWt75oW2HtfDuEpjTad1vnA8=;
 b=z4aB2FRMjHzebMbLw38jwoT8ZVOhhNzdZViPMvo4e8OkkQNhwlVTIIOtqNP7L8XOXKralEKUA+jvT/hoHjfpwkWrubDtQlqW2blJtzqXkL4TRtgh7MXiQjyct+9CMdm0s5HeuuGSlncbejiketaSdcq6takU+pyvK2fqHkrcbNo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6734.namprd10.prod.outlook.com (2603:10b6:208:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 22:17:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 22:17:53 +0000
Date:   Thu, 10 Nov 2022 14:17:39 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 2/2] mm: remove zap_page_range and change callers to
 use zap_vma_range
Message-ID: <Y214g5vrDqOi6Tmw@monkey>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
 <20221108011910.350887-3-mike.kravetz@oracle.com>
 <7140E1D7-B1B9-4462-ADDA-E313A7A90A68@gmail.com>
 <Y21s1uzkey6u4nyK@x1n>
 <C16276B9-F40A-4767-AB3A-8566FA61A8DF@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C16276B9-F40A-4767-AB3A-8566FA61A8DF@gmail.com>
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: ae057289-f95b-43c6-9f03-08dac3696965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFavmpj+53xUqSb7kXKHG2xmrdn8ztafM9iMdBRFTWcZUSWkGt2zrbtkvzY8OUpbhCpgi7iquhyM8TuS1RDbkROkPedoLqFSKZSKIilpWrTwlBEBboBt2m5SGfqCLgViFtOQCZmniGNWTacDWo5xdWz8d8UAREp/ZPk4wXDl/sgzSxy6/BMpuJS5Pg9pnYFMptX51IKQGSscUhT9ZdLCC1wxcTuYTWhdK7dEQfNdfd9O6R5z4NPwsSnrgGbdu6dAxZzfA6eWkr44qAxgHhWbXRw8IQG1mjfCsZdli/dbfATbF4/FC+XANL5OKj+TZou1wyBSyZExX8STWBslm2g3V24B66JMc2Bsh/obmKRQ2aalZ78ZatPNa9KKf3IZ+NmyiXMC2XkGM2meBRy2R84M0Eomqqsy+8anB60GB88qf41J4wiZ3TiHoTYyV5enA2cpp4z8X6Dq/6N1j56aanVEf+DzW2SLumsbf43sFMaGhLHs96KVz03PPQ8djMIZ0uY1X/1Kv9y/pXn7b1j4DAswu5Pp5oOKgOukUd9UNZWP7bv4FeHpKf/X8Qo5NGdlh61DGdmRMwMrkSZL3DtWFjmP6kuku9bzkU1/2oZ/hW7yVXQyxVksjpLRF0MrX15DdsXFPhndQNWc1CvnCdCghVwqZtgP5AtjmyF2Ol2mAJ7adiUr/noulCCQTcsJPWSYEV/L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(66946007)(186003)(2906002)(5660300002)(44832011)(7416002)(316002)(83380400001)(8676002)(66476007)(6666004)(8936002)(41300700001)(6916009)(6486002)(4326008)(478600001)(54906003)(66556008)(86362001)(33716001)(53546011)(9686003)(38100700002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzlpc3RzQ2Z5VmlQczBGVmlYeDB6dXE4T0NoSW83V0lkRGl1THJXWlJIOTRv?=
 =?utf-8?B?RktFd2VwV2Z0OEwrakZ1MWVXSmV4OFU0cDdvYXE1MXFoM2piaUJkOGJ0R1Bu?=
 =?utf-8?B?WG5ud0k5dElFOXhFL1NDamhnRjhCVWduUnpjNWNMTUtsUURWWTR3QjhERDZG?=
 =?utf-8?B?M0lPQWNmUVkyTWVqS3JWMTVaN3IzNUtDNXhPSkdFVC9ESHhTZndKdFZjbnVm?=
 =?utf-8?B?OTBLSGxFZEltSWx2dkZhRXVQK0QvZ292V3MzanVnOU5SNXMzT1JxWk9VMy9h?=
 =?utf-8?B?S09nZmsrektMcU5FSlhLczFNMmVZRWVWTFBQZlZtRDdTWDZZZHhBblhSOFdp?=
 =?utf-8?B?cS9wTDFRb2dDN0FnSnkyOFRtOFZzYkhKZm43bzlJTnhHOGRteFFUaHYyMzZT?=
 =?utf-8?B?NXZGOXRCZkxLdnBDTDNWcDhhT2tsUWk4RTV0cFJMWjZ6Nlpza1h1eDVraVIx?=
 =?utf-8?B?eUZZRzBnSFVtaTROOTlUMWptbDJBN0JaN3ZTTGIrc083RkI1dEs4SHNXVTE3?=
 =?utf-8?B?OVhmUFJPd3FXS1Y2NC9wdTVkT1JsbUpxRGJHcjhNM3ZVMGFEM3ZVQTMxY0c5?=
 =?utf-8?B?OEdCc2tMMUVURzJWOGxPL0MxaGZwSU13M1ZGVWM2RThCVE8rV004am1xdktO?=
 =?utf-8?B?T1hmSWZIRmZXWU1SUUdTckM2WE1QMFBOQlJhbmtwRzRNelZpaWhkaWU5cnV3?=
 =?utf-8?B?bG9jbnIzZGxSWFJnbmVUWEhkSm5GRGhGU0NvdW9aanUwNGt0cHVnOWgvMkp3?=
 =?utf-8?B?U0VRRUpldnNXdlZ2M3ZONVVpSkI5RGt2dTNPdE5idmlNNDlQM0l5WGNqQk1s?=
 =?utf-8?B?OCtrbnYrUDIrSTNGanhRS1VRZTZJRTV2a0JtVWxPY3pTNkJzdGd0cmFMVDVr?=
 =?utf-8?B?WkdhL2M2MjlRK1k5QVY3QnU4Vmk5U3JPR0ZKQVVLZGdIc2EreW1DaU5ISGZN?=
 =?utf-8?B?Z2lac3UwTE5RdGNLMnhSTjFwb3BPNnJTVWp4VC9UL2ZWZXlTWU94aUJ0RVJt?=
 =?utf-8?B?MlhDZGRqZFdtRHhPOHVxQXJsSDROdTNlSDJDR3NvRVUzRnc2dDhuVFFQTXlI?=
 =?utf-8?B?OTFCWTVZaFNkVCttd1ZNWC8vaXIrOXhrTDd6THN0QU1SRzA4S01uVTlvcTBP?=
 =?utf-8?B?bFlrdEcvb2taZ2k4VjZ3SzBFT3ErN2I1UDlrZ04xakQvdWJKZm5sYWp0WEpZ?=
 =?utf-8?B?S1A3WDFDTm5mck9UcXZ6ejM2eW5ucUdOaWFrdXFHZzFsME9BcVpxUllNOUpX?=
 =?utf-8?B?dm5ZcGRJTkRPR1MyUU1jYjEyaHowd0U4US9BWmFTL1F6ZE1sMWxmcjJuSzhJ?=
 =?utf-8?B?aXdxbC92MWthZk8raGxZa1YxS0plWVg1R1BHRGlJOFBBejJrU0FlWCsxL1ky?=
 =?utf-8?B?VnNUdnNYRTFKazVtZ3lqUVpDeXJKU1dhWEZEa2JJQ3A1M3lKZUV4dytQaTVi?=
 =?utf-8?B?MDkxUzBPNExJbXpHajZjdkVxWHhKbitlK1hGS0V6MzF6ZWNnU0xpWWRYVmhq?=
 =?utf-8?B?N0xFemNsdVdiak4zQWVkYWM3am9CaEJrY1dLQThQU00rbGdNanpCT3hkYzJU?=
 =?utf-8?B?UW1hTnNhNjhoZTcxRUlkc0wzeDF1U2NQazlFM0xHUTZzMXRubndqVW12bWRW?=
 =?utf-8?B?SmRJUkdEbkkvbG91c29xYnZPWGZYNWtHek80TS9BTUFFdCtOZWg1dVN3blh5?=
 =?utf-8?B?M3Jla0d0YXlSNTRHNTg3SUxjZUJlRC90UWJtQkdkOG5NTGlmOHQzMHF6Y3V5?=
 =?utf-8?B?aHRCWVFoaDZkUno0UHRHRGlvQW9BN0ZCR2gvV0lOdkpETWlxR1VvZXkraEFM?=
 =?utf-8?B?ZWMyVTBUWkVPNFV2d1p2ZHFxbnZTMmxLNjJkTVpvcmdVbDBvb1pqY0VZTVhZ?=
 =?utf-8?B?V1JXQlE4WktlY0tDdm9sMTBpNS9hSnJXYWFsOFhNblFDUVlQd3ZqMGJ3cFJu?=
 =?utf-8?B?dXErdWdJMHh3Rml0ZVpWTm5wRnVXM3NFTXNpWXhLYThBQndVUDYrLzM3aGJq?=
 =?utf-8?B?YVRJUmJsRkRqMCthL2wralFRMWFZVStqckVuVk9mRTF0aVJ5QU5TbnBKYThH?=
 =?utf-8?B?ODdHWUtXWWdWLzlrN2hlS3BuaHNpNnd6Z2p5My9iVGU5VmtUMW16dkVtQVVs?=
 =?utf-8?B?STQzVUhybjVsMGxVdE9kbzIwbEtFbDBvWlZVek02VCtqYzBwR0FxazhlMTE2?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae057289-f95b-43c6-9f03-08dac3696965
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 22:17:53.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NVM/d0++sib1hE3ki8J8Wk9rdEsYqvyU3+Q8tnAdkwY115ePzdJGz4rFzt29RI215vcVsbEBAKAMiEky176Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100157
X-Proofpoint-GUID: 7QQSR5DjKjQkMKP3Nt1XlzYQ0z6MCtzL
X-Proofpoint-ORIG-GUID: 7QQSR5DjKjQkMKP3Nt1XlzYQ0z6MCtzL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 14:02, Nadav Amit wrote:
> On Nov 10, 2022, at 1:27 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > Hi, Nadav,
> > 
> > On Thu, Nov 10, 2022 at 01:09:43PM -0800, Nadav Amit wrote:
> >> But, are the callers really able to guarantee that the ranges are all in a
> >> single VMA? I am not familiar with the users, but how for instance
> >> tcp_zerocopy_receive() can guarantee that no one did some mprotect() of some
> >> sorts that caused the original VMA to be split?
> > 
> > Let me try to answer this one for Mike..  We have two callers in tcp
> > zerocopy code for this function:
> > 
> > tcp_zerocopy_vm_insert_batch_error[2095] zap_page_range(vma, *address, maybe_zap_len);
> > tcp_zerocopy_receive[2237]     zap_page_range(vma, address, total_bytes_to_map);
> > 
> > Both of them take the mmap lock for read, so firstly mprotect is not
> > possible.
> > 
> > The 1st call has:
> > 
> > 	mmap_read_lock(current->mm);
> > 
> > 	vma = vma_lookup(current->mm, address);
> > 	if (!vma || vma->vm_ops != &tcp_vm_ops) {
> > 		mmap_read_unlock(current->mm);
> > 		return -EINVAL;
> > 	}
> > 	vma_len = min_t(unsigned long, zc->length, vma->vm_end - address);
> > 	avail_len = min_t(u32, vma_len, inq);
> > 	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
> > 	if (total_bytes_to_map) {
> > 		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
> > 			zap_page_range(vma, address, total_bytes_to_map);
> > 
> > Here total_bytes_to_map comes from avail_len <--- vma_len, which is a min()
> > of the rest vma range.  So total_bytes_to_map will never go beyond the vma.
> > 
> > The 2nd call uses maybe_zap_len as len, we need to look two layers of the
> > callers, but ultimately it's something smaller than total_bytes_to_map we
> > discussed.  Hopefully it proves 100% safety on tcp zerocopy.
> 
> Thanks Peter for the detailed explanation.
> 
> I had another look at the code and indeed it should not break. I am not sure
> whether users who zero-copy receive and mprotect() part of the memory would
> not be surprised, but I guess that’s a different story, which I should
> further study at some point.

I did audit all calling sites and am fairly certain passed ranges are within
a single vma.  Because of this, Peter suggested removing zap_page_range.  If
there is concern, we can just fix up the mmu notifiers in zap_page_range and
leave it.  This is what is done in the patch which is currently in
mm-hotfixes-unstable.

-- 
Mike Kravetz
