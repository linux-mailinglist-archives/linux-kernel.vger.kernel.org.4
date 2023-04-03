Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851C56D5189
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDCTpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjDCTpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:45:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70BF35A8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:45:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333JbYFk012287;
        Mon, 3 Apr 2023 19:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=43wXC/+21ij+bsGae3NEn7qNSUDwueRBAErYaSE0fXs=;
 b=Ma/E9Tk7mQnMyERrlu5u+/1owFAXqjU+5ohvjs1E07j5UZzXVc8oMTVeto+z0HepeWHY
 qYU1WGxTWG2tn1jj+iqKRfiuStH0e0nxUp9vjY3vrMQ3bmDG5Dvikz7tND5G2Cl+rFAB
 AMicefQ+N8qbErN44xybeH7lQR8t6CxAr6su8bAfWsbpfGX0KOBAKQPkUZnFd+blaSEd
 aOik/TcfhJTZBnsRpVJubkSRNLO5MgpwQGvIWWkJBlp3a5A7k8GwF9vFAIQ/P6AdCkRI
 1NdEuIfTIDksGJCB2BN/lWlhpzOOlLv6HJnQaInvdTiw79J8Oz+T5sNT+34NPXzqitos rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71m4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 19:44:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333Ionhu017709;
        Mon, 3 Apr 2023 19:44:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp60q3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 19:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSzq7vunO9FIHctE5RnHMZj8QA2XtjaMUPp07xSkeB29OiQODGJ16v8NTH28cnvAWf3O/Tjzgjq58J+lYRAlHWsrUi1vPWiUvb5/UyzRd50v50MKfmbTWUl/Ze9ouNpEyP3Cg3vw4O4V9EN7L6xMFKRFrN0Njb7cA9KRyZX+8OHLIvjIaMHi7OEChI7wnGtqXzD2C+dWmMgQJ1Ul9woTrFIh7qdDWxWhm9YKY3G2HO+UchZcvq9s/t5E65Nfv6KFL1a71OuvV5OpjuKhZnlRHnRANBQtefyhfOwkn7tA17H9mw98WeheWAj60yJvpTexZ+h3pL/C70jdJxmcrgiVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43wXC/+21ij+bsGae3NEn7qNSUDwueRBAErYaSE0fXs=;
 b=BY50icMrkYkRf5otj5G+IcmaQSIlUqnVMsWiabG23p+KGT1K1TE6+0LRL0ocCabE4zpk7PkvUThyx1q2t+r29yEmGl1/nAr5oe4FFg7BP3vzww4Mo7Sk+/iJbHEJ+OyOrVxJJAz7ZeRp7n+gzjAvRcJk9GTOm1iCQN4FGDFKaQym3+L0zjzycg98NxviThhgHZM86UDzfoi/dt849MSAHEeFxTh/F4y7DstudMIJfJ/E/RxP6CHgds63CaF9Pq6mQ8VbqnBgRzXaff6F0hz2+srVGTZz0Q2m5PYSuFjUH2+nxfvQunI2Roh5Sx+JC8OUrXv14SCjwKjpTbg5ndYplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43wXC/+21ij+bsGae3NEn7qNSUDwueRBAErYaSE0fXs=;
 b=Nz6Idb7nYYPy1x1mZnDDJderN6sDVEVXfjmCvXzLVwxKkTic7InHbdKvyHJE8rhJL8A934Abk/w1DwOd633uZHrt7/AtjBPnUnkYNnAwLOM+zAQ1DZ3i+vgGOepCIKMAusygqwj7Ik48K1t3gtGTtzMB8DSDcZ6StT0DWr76aQw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:44:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:44:46 +0000
Date:   Mon, 3 Apr 2023 15:44:43 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Message-ID: <20230403194443.af3kbawab3d4r5pr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
 <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
 <20230327194800.fzqfrxfh3nfmqwgk@revolver>
 <a017acde-7520-743c-963b-94a23c0f30c8@suse.cz>
 <20230328130230.gdmychfid3aggikd@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328130230.gdmychfid3aggikd@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c146907-7a79-4922-cf03-08db347be121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7wnkK4tOVwiffOahKK6AIwf6enJqvCkhiOIywbcYI1t0BTIxJAhFY+Sk6wiCmz49fTk4wippjT7bJ0Ic6xecc/mSyzeBZRdWzduKbjYQSAfyetG2m4dLfgqbvMOOTPW4BgF3QgJO7ho8u3tVpx6QGuwFniGNJK1lBP6ELRvAEXcV1jZImXec7PfRwNDeOaDNDn19a0W4ljJwBoOUdQzoiISdBjN3e/M2BVSrfNJLa0V3KIX0YbDXOFLY9TTXk9PNoiaV0c5RJIpmN8iqWEK693tPaC1mFF6ivtDt+L7ncUKfgJEs6o9camtsBgu5Hik55Uw2EZoWYbbNkUKrc6AKmsYhPvTcXtyOHyeiXOKFghO3a3ueOk8llAhTofHB73QnQXqyEFhiUTQsOlFRIYibV8ThvXbEoAQNUA6LwMt3p6t4TPOn5akpbCZU3ZwdHVKkkAdyZ34m8QHOr50v3id5H0rXvkZLM8ei3P0l89nEGL//Kplu3tIdob/uXaO/Bo2qXbqLFNnMS0JYSClUxodPiw/B4g3iwhRdE/ulHpPIiJru7CJOYnWXc10zSbbwqQp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(86362001)(33716001)(2906002)(53546011)(186003)(83380400001)(6512007)(1076003)(9686003)(6506007)(26005)(6666004)(6486002)(8676002)(66946007)(66556008)(66476007)(110136005)(41300700001)(5660300002)(38100700002)(316002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nB/qVLCtXGaZ3IUivBrGstxKFqbySEZ7vtQPSaY8oD5wrAdkTmsJNIUAlNe3?=
 =?us-ascii?Q?qkkOIi4AY6zmIwi6IM8TUTCdYOMEGwAmP/hI2oEsMpYQUEl0c7ZeSmQI5dgE?=
 =?us-ascii?Q?faGf/bqcsY0FDmuKYKD/SK4k5DXoXZYXTd0yvqDOHrCKzLv3s6jT9qrE6oAY?=
 =?us-ascii?Q?k/JdMHa8uKjOYkgG9TBzkjTE7STqtlJ6ly7kQa8wUeK6z3TSA9BtOnDGW9gG?=
 =?us-ascii?Q?9G9UsN/FVRSjrvwkMQ9GOHBi/lwE1dXbpwg6kRs04Mxl9qLyDc4RdDvjv0vB?=
 =?us-ascii?Q?vLChYpzM5Gzh7CRV6XNpbtZq1pAqAA9Gbv6qXo+bmXbLXdAsDrdLDE4sMW5N?=
 =?us-ascii?Q?Vwrfc9tzKzJwZ4JD6+4xVN4hToBQ6ZEa7U3us0T43JCTo7/0h7EsGaC6X1Iy?=
 =?us-ascii?Q?x11Rc2fp33xClfKTPjzVnMMm5GsP2WCK5WXJSOMeg99lXgWoE0CmrHfRMADN?=
 =?us-ascii?Q?U2VNRwEt92VfzYBqVXr0l8LFVnhDQGlfo3Op6Dz9wanX1D1y8LMMcIVqznlm?=
 =?us-ascii?Q?/1aLRwFShFjS+7gUZOmg4bm2lnMo4K7QiEINcSvIMjCKnCxwy34VJrrFEVNA?=
 =?us-ascii?Q?LAXKo7YVMrc8VUDhGeEFnv3+H10fBdltk8ob1U8cUajzcFyratHK8b8zTZOV?=
 =?us-ascii?Q?8/TK2BGB8B4g+f5RBvPdWBBTWeD824c0kXzPOS03YjvSFRQ3oNVNqUywk7eG?=
 =?us-ascii?Q?2/Z3t54FAAZE9/zyI3i8jFWe0kTKbPJTZrC4qYIyYDHrAcblXPVVVb7sXd2N?=
 =?us-ascii?Q?KpY8roEm5REUsee6OajHovAQK4l+BefS7OLeBsXuiIpyEfSjzSNn3+3wMqMa?=
 =?us-ascii?Q?VbM1tvMah4oLfMBAQCW1ycyDV/o4JfxqwA+LOzYvNiiFWQiQgONVOEllL6PQ?=
 =?us-ascii?Q?wnwzuZcjoCGxgGoePMGZxLpt+qpNVx0p0Jbj3Tg5xEr9hzJmdI83IlKoxUmr?=
 =?us-ascii?Q?Cql/e3U3WOLS3q0jqe0xEmNdjDEZLR9iqujidQ95+O0JiyUyhR8/I62RRv/N?=
 =?us-ascii?Q?FyXqs/O60Sq+Bd/iaKMFhnE94bpfW/O0JGj0/V6FNQHlbHolR4tgbxSGNPCJ?=
 =?us-ascii?Q?/6PGMx+dLrTtGYoJO4zx+QTTBjWi19cAUInsZuTUjTSuDG0sNBo1qPq+vKIl?=
 =?us-ascii?Q?6xtBp7fkpGIc8FKCdz6i+SPMdml2/kCv+Fg/XuqEDeeDj+YVRxYNxSDW9gvG?=
 =?us-ascii?Q?7IPMVBFP3vovljnjCpMQDMoDF5IJZoUHJPfdxJFENHtcXNRzaBUHK98e5TAN?=
 =?us-ascii?Q?7Jfm5jSmFUEKp2qbAXdJCl0Oar6lkSZce/FjmiG6EjxBLNbAJh6H0cLcleJL?=
 =?us-ascii?Q?t6Q+OuL4ONIorfOoQBB+A93mXjfb0ZIDVB6gNB+5veItlP+DNDPZiSI70Zag?=
 =?us-ascii?Q?rjBTyd904KmrVBeXQ1Y2sGZU4L+awDKIbfYKazOBK+zMbMEkkoo8EWni68oN?=
 =?us-ascii?Q?gU6rZarYV7NRSb6Dqqr/d6O73YyVkR8OBImzNcg4az7qBbvluqRJGobV7O8+?=
 =?us-ascii?Q?gBJLa21nytuWxUwc7lbH5EisyJejXCkQjpazXrrHS8P8y4CGb2Vsq5+0WOse?=
 =?us-ascii?Q?LXTEwBIEI0SVn10g5bDZDg/sz6b7e9sUyTFz4KlpzfoHEWfMfrXL6JL06kec?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?URV83Z1ZBXk39epO6VyspwAiGwj88c5AyAtQhUKZ64FpyrtmF04bx9JaeDeK?=
 =?us-ascii?Q?90mPBu/lfP6hSkb+seKSkWYt5blecajYgdenQ7ekcJJ7/Q6su2AtJha1cKTG?=
 =?us-ascii?Q?mtRurbKQTu3tDht8n4JzWa8Guqcib47TO9HkRYL/MdyyS3DOEFHNRi4AQRR8?=
 =?us-ascii?Q?Wo2Kijt9k86/mNifzNKcRj9zrRAzpk0tUO1BipI97HdFNY/5o+evu4VMWuBD?=
 =?us-ascii?Q?xaByoZgxZ9bCS2gCx+dfRqtaUyxOe2UxqbtC+X4iCLk/cpuEYLW05wtH9Tu7?=
 =?us-ascii?Q?pE5B8q19PS3jPedX3HxbVrT/Dq7/Gb/4ox0aVwCBt3E4oYr/JDwzxzkmV2sH?=
 =?us-ascii?Q?SbFdIbeFBS0WBUREZOKu10YOmsbaHGjspAgcmE/AMDyO1xfR4UKDm/W7wiqY?=
 =?us-ascii?Q?euEH6FmaZ6wo/Cb8J14SWrehqZsRaz+ZgzYhpo2TCO1/j7XAIT//AAoZJlxA?=
 =?us-ascii?Q?NnSghlvrCVIi4r2l26P1C1+N9f6ASU+/TSa6ZVAjQZWizm14G3ZEa90p/9kb?=
 =?us-ascii?Q?WwOq0dEd4i1NyJsShLko+LV5VvC2XOEt7VvhgixEBfaFj5qDsXzksDSk4XSh?=
 =?us-ascii?Q?nyGmPxNqczv+y4qfOxRBrwoeFHd+1YuIMGRl5LnsoZ0r2/YBZQX9511Kcu4o?=
 =?us-ascii?Q?EVemCaR0ulvpNOeRpjEUQtpbvAqwVORLPm7IwOpgFlVgPcWHV2C1+Ab87ump?=
 =?us-ascii?Q?CnREBstxVH81siZthKCgVP4ACE/vgvCK4jDVffw5Yg1JW86KLEcuvzFiDoM+?=
 =?us-ascii?Q?zJ490K0q77d60av7+pFxWnzskPGTpa03VEtXBGUN1S5G9sZbaIgzz0TNeBNx?=
 =?us-ascii?Q?kaUw2yZOVWScxxgFBJg0dVSLMaHVbcuixtydOVgteNYEXUxXEtMBmTKfMdsP?=
 =?us-ascii?Q?GXHyxFMNL918Xw5pCssORRRkzcvDVjKOJC9BRcLtELQhuoDojN7mYo39jlfZ?=
 =?us-ascii?Q?m+slyeJIGpj9+gxDWTjd+bwUiguhFxPqb344qkxVgyg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c146907-7a79-4922-cf03-08db347be121
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:44:46.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/yXQddPpIOWoO+1OQWfxJCtyb9v9oD3ka3VOdkHa27lejG/8hJ6pfAi28V8Yr6BR07F2Dmf0B10gHqqCgHJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030152
X-Proofpoint-ORIG-GUID: BIY57OlIA5FOEn9oeV4LD_APZs9LeE2-
X-Proofpoint-GUID: BIY57OlIA5FOEn9oeV4LD_APZs9LeE2-
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230328 09:02]:
> * Vlastimil Babka <vbabka@suse.cz> [230328 05:11]:
> > On 3/27/23 21:48, Liam R. Howlett wrote:
> > > * Andrew Morton <akpm@linux-foundation.org> [230327 15:35]:
> > >> On Mon, 27 Mar 2023 14:55:24 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > >> 
> > >> > These patches have been in -next since next-20230301, and have received
> > >> > intensive testing in Android as part of the RCU page fault patchset.
> > >> > They were also sent as part of the "Per-VMA locks" v4 patch series.
> > >> > Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
> > >> > RCU mode for the tree.
> > >> 
> > >> What's happening here?  I assume you've decided that the first 8
> > >> patches of the "Per-VMA locks v4" series should be fast-tracked into
> > >> 6.3-rcX and backported?  And we retain the rest of that series for
> > >> 6.4-rc1?
> > > 
> > > Yes, they need to be backported and fast tracked to fix the issue syzbot
> > > found.
> > 
> > Stable usually wants the "mainline first" which means fast tracking first,
> > then once it's in mainline, they pick it and annotate with mainline commit id.
> 
> Right.  I meant these patches won't cleanly apply to 6.1/6.2 and will
> need more than just a cherry-pick due to the vma iterator changes.  I
> have those modified patches ready to go as well.
> 
> > 
> > One question is how Linus would feel about this now for rc5.
> > 
> > Another question is if we should really deviate in the patch 8/8 backport
> > just because it's not necessary for stable. Generally they would also prefer
> > not to deviate, unless there's a strong reason.
> 
> Just to clarify, the change is to remove something that isn't necessary
> at all.
> 

Andrew,

I just wanted to know where we stand with these patches?

I understand that it's late in the cycle, but this is a bug that affects
6.1, 6.2, 6.3-rc5 and can be triggered from userspace.

I'm asking because the LTS 6.1 is starting to be picked up by
distributions, although I don't know the scale of the install, and
getting these upstream will allow for the backported fixes to be picked
up by stable quicker.

Thanks,
Liam
