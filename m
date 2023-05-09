Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091616FD2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEIWfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjEIWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:35:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7572AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:35:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KlXE5005685;
        Tue, 9 May 2023 22:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=g1fuJnORaJfItXxC0amrlgJN4LZyg0WsDp+2mMa9viY=;
 b=FWTlI7kflQwg2nXcV81A8vPMjRkiS+RsZd62N/tuTnuP0St5fxqwnnpNU4ZqGR99yxIm
 GoaKWCGA9fES3Iu+Ll4o8nsthZuGOlRliTZGboO/SK6T2OPWKrJLlCNAcyao/1xOqqF+
 d9WPaI2d2V7ukVphLjuW1xPG7uhTEsiricfpDTBeE+MOcnYV2fFCa7+7ExjwH23W22nd
 cMEXINShakm3kDTt3jcuirG+vmzMcMEg6fwBTD66kB/1Pkyd13nxpoeeGg2xfqjQgXpb
 MJ6I/Lu7VncPLswM6/pKM1b56EchEGCR9sLpYNK16+T9J11G27b0DoFfzMnxRL9A5oMM 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77532e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 22:34:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349MIFmL002020;
        Tue, 9 May 2023 22:34:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7phu11n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 22:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHnaz2QsGoCXcxaYoRlFO9GBymZrk4+qNioJGIR2Shg5W/k8l/2j3WtrXX2F5B6XVQXcwM/Ls2WnhqSGl76l+NSHwFOkBJWtP6t/l0QaimwO/LsMDFeWKOzmMQt05q8fYB3XJcU663t6u7aHvSgZNPVYOLBjDZ0kKYbgeUC9j1rOVtY4JTdjguPQuh5GX+Ac/Rh8qfEy1aYjrmzEyyzFbVw4vSnAcie6ynaQ1CYdm76qXpX5UgfXhlNUIK+PsL0F5Q6WBhPNC1+wSHOQXzRJEczLAsEC4fmv2sipLzJyRPTdRBkCXHcmJ0e/ivi7fY9XPxFS4CNpVLn3L7+Iiud0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1fuJnORaJfItXxC0amrlgJN4LZyg0WsDp+2mMa9viY=;
 b=gwzsxOyso1tJlt/BZUSZb77yarTYmEXUsVuqfPGIef2Od0ZwzBI5Ykd1XfMzBHCX8aVmQTbmozn/kTuq/DkdV2OaWzdFUZbmHjDXB2PX5o8nuL10f+IKDw50x181HYMQ/TauH6j8DiY1r+qkbL64jeUFy9CSi2Qh//klHPKHPyjL8UEx8V5Ckh5sZPoDnOuEuK8JeHQJYSFLSDmL/MJoOg8dm/yR8Ovu9ToVW208O2L/QOEwpU3hQLEX4EyGaxr0MHB5BeQHoRsYELsug1lRIeF2EZGnol1jGXQUXuY44Hasdd0c2OG9M7IbRpUf00xhv/yTrP8JfrFqVreM9Oqmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1fuJnORaJfItXxC0amrlgJN4LZyg0WsDp+2mMa9viY=;
 b=grM8hOOfPI5Heot2rIaFSyU4gvwO/rkipR48jYU2SuMq/kyLvpTEui2F+D44P1uXbOUvo1Z+n4Gm6eXJOdqDA+TaA/qKNy440TJsBXDyddBUCPBzrum0cfuJuRd2ovOmO8lRTcrcMRuUZp2DjdJZmgrhHIlFfPStRcAI0dmbrMY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:34:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 22:34:39 +0000
Date:   Tue, 9 May 2023 18:34:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com
Subject: Re: [linus:master] [mm/mmap] 28c5609fb2: aim9.page_test.ops_per_sec
 -10.8% regression
Message-ID: <20230509223435.3leeba3uawzxfj7m@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com
References: <202305061457.ac15990c-yujie.liu@intel.com>
 <57453f01-ac47-b683-7296-2e6b7275edd1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57453f01-ac47-b683-7296-2e6b7275edd1@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MW4PR04CA0332.namprd04.prod.outlook.com
 (2603:10b6:303:8a::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7fb869-65cc-42e1-70a8-08db50dd9304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwYVwDIHuByVDydnlJYH1t53D/d/eKlsG45H+myNy05vDL7Ubix4xNcErZlfxskUGnvjzeTP4XKKQ7FYJDjOzxikOV8uhJVhxjIrtPfn0QSoY8qBluWywJCGsKpnSUrX9t80+bg79ER1+JgLzOjYhhUqg71qDxnOQbi2gIKhVFek/YPDHcQBcPTxIXW3qezTq6c6lZjYcinl37eqqCNqyKGb98KrLgfYREgwLoFyktkGWheXXL7P408AeoMgz5x5jhySmbBZ0lUgnKdHBBJwAWRXpc4cmhV4kCxeWHdBbNhF4LVvvEHiTookw0ohc51+fc7LSsIV0zhuWNirPJYRW136O/d+uih8T6OYYOEyVoFgiYm+XXjKFDQMn9LiuqTk5steVZHEZa23b1OgDSO+fHNS1GauWkRkt/Ywv26rsSIIxD5fhCE5fHwR8k/RxsWxFi3KbZtmwlX0MpSxpHRsxCWxv4va4ekUxWCdRIoNORCnp6vihrtvKDGaDwCt6yXVzVd+PtrodALXj9FcdnAkS2WJ0bEWZgsu9z1eD0IqjbHE96O8RgFhOR1bP5vbC6P/AL6QYcRQ1y3928prLieskw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(6512007)(9686003)(26005)(6506007)(1076003)(38100700002)(966005)(6486002)(6666004)(83380400001)(186003)(33716001)(7416002)(2906002)(86362001)(66556008)(66946007)(5660300002)(66476007)(54906003)(41300700001)(478600001)(8936002)(8676002)(4326008)(316002)(6916009)(53546011)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gOWHbt/xWpuUQdCUI+c8gpZXkJLlxBORCBJbX9bh8jiFc0olUQ+MQSPZrj7m?=
 =?us-ascii?Q?033UZA3uXm6HTsgeFe7wojMTulUumOzUX7TVHTdiXRL9bWDVK4W0itjBNBZy?=
 =?us-ascii?Q?iuRTuLhdSMJl/ujA5mzoy/A3ujsfBXA0ojwY7NxHJsKBynfis2O9LmMb4UDP?=
 =?us-ascii?Q?7WipjGVkx689thG/xkR+0r40GjihdyjzYPwYzn0qp+z107fDKysryazj8WSr?=
 =?us-ascii?Q?pi+nWrxSAu2tR065tBnlXwpZUdLTZIFKg/dPdcW8QO8r0sih+WyEfePadhrG?=
 =?us-ascii?Q?LG5fHhfnzXA3fML2uAVGx+u++AxuviMQSwdPfuFsvKX17y4VLW4aXNJtBlBu?=
 =?us-ascii?Q?LAUTKjSq65+Y9BkD8024Ev8J9RHyU+zFBLBMmPaHlfDJW6JHyYLgly4EedSH?=
 =?us-ascii?Q?Ce+cNvA9tliv7wm60PfcCAKAfKavMdB7GPlJNzqptdRS0SIuUK8lKgHGKonJ?=
 =?us-ascii?Q?JjDZ3ge5i3psppAZ2uu4mWB3tz9cadQKXSSKjtJW2Bs6sJVcTMl75RMncL0H?=
 =?us-ascii?Q?G/DzdINAyPMxVpJthMf6SmuA0+5ZAlnGb31HZYn7CoXCitfKAZ2bJpIvXmZc?=
 =?us-ascii?Q?9WZLhhOX07Kqx59RCPpqVc1yZScm2VwAK8LzobAkHEyQr/QjQ5SyOZhETSTQ?=
 =?us-ascii?Q?RQwtmoYrIH8Ll9ujGOwfasTeF/JSfd4Tb+AxTm6aFSHEzSQkFfHFcvtfiSKw?=
 =?us-ascii?Q?Vwfsf3XhEXy2gqlO9rIy83EXQ3UwjCba6eqcD+z7JQFIjORWLeJtyNsexUtJ?=
 =?us-ascii?Q?aYD7C5iXPFqGUC73stkJGPyLFBi/uCxHtJSRhRhjmvKEkMcGk/S+Q4vrPcqE?=
 =?us-ascii?Q?jkPEzdXT+15+pYmeW5FMXFyFD2Xp2xbRd+vjvAB4VuNnmb6Yti5kQNCWzFIa?=
 =?us-ascii?Q?0Qak6LU9VOcVKjeH40pX4D4zlQUpJH+CO3hUd6HMQ/mu3cEvZLgyUZSJk6j4?=
 =?us-ascii?Q?bWLDfFaPmunZ6EGw7y4kVofP5kWaFjpt4p6Zb0BgV3+2bGtsU4jkVe15igHb?=
 =?us-ascii?Q?xy0t+56r8CFRCPqrYwgqlmGLuQqNR9n+RpQSOkkIOgCL5vQaARPAqR1189Zv?=
 =?us-ascii?Q?5aAwy0zd8C9OWarDFSZ6tUZ/pFkvSwdrh532/1gCP65rFk/PI3qh6i5S+fHc?=
 =?us-ascii?Q?oE2wkHHjx5pCsE4045Sxtd+5+yAL+OzB1lEP0zOlv4GtVuYGk4u4doQNj2Tl?=
 =?us-ascii?Q?W2aSzHbNxuEjARgkeJWCmts4xkT4IFKmEhY934kandskZo6LubroVf7csDu4?=
 =?us-ascii?Q?a72jYfkaDl0XTGpv11aKZgUfEVKMkxxKrBvUypAWxhZcvXXTGl2I9dQFhfaQ?=
 =?us-ascii?Q?we0YFDQ3pOBsJFnFycesTySJmUvtm1Tpt2lvDRU8lnv6yONFy29EfKIa4E7i?=
 =?us-ascii?Q?S0s0APDyhp+adK7vBkY+r6jZ8wkkmKWTUtVFu5VeXOjoqpmhRGL5F1ZXvtU0?=
 =?us-ascii?Q?iFK9HhigV6Tq8K0VtnkMkvLZdDMurdw4deyUt4q5yv3JsGkXoSUynmTrr5vc?=
 =?us-ascii?Q?GLwzhGOTyky2kIyntn8RZs5Sh3nFx2WVasVNrS9jRnHlSiXuPN5ls7ttQ4rM?=
 =?us-ascii?Q?npcr2P6MOc8TkKKrpDWgFIe/rid0jtU0cfAYbIq0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lpZ6mxGB0Fty+MSrDmEhkn5vtAXIive7zG+3qWSyS4LTooEMR0DcdNEjwqUn?=
 =?us-ascii?Q?IumVgpC5P9wrqq51NrKCt306dKd8DFdM/Hbi695982KXRrsa/8GJKk+SVSYs?=
 =?us-ascii?Q?gqEJVKoWoqDgf3hglO99ot/D9oEQ9F0v/1TUlvVmSnmyf+Ukv6zDP6qVENpm?=
 =?us-ascii?Q?DvUVPVZZC0a35NxziiznSA4llfafeiHBQhOptTLGoNBAEA4xPyhvC3EPgBbb?=
 =?us-ascii?Q?zLb9xmHUBINn29+sNnOz50efxIUPvCJlZL/nztkvP6VCyY38BHSn5O3XLFEn?=
 =?us-ascii?Q?58ud98Bcjm6d9kHsw1V69XXDlnBw4YZklE79E30VrQ1AsEBwcW2ItvcjBaM8?=
 =?us-ascii?Q?urin8gJyl4e5OgNvmhtJOftwdIsLOZyxpxRXHCsQseP52kgC0Am1bLJjpTFR?=
 =?us-ascii?Q?ksOsK8ytqRygPfobmPxYQPnUmKR1fr+oU6frLhbgv1djbyKsLWQJ+kiNQ7Iw?=
 =?us-ascii?Q?lWfl9s+QRbIjOmlb1bxd9EetMDYBRcwUJ6vIeBuQo8H0JD9zytnF0W16fJLt?=
 =?us-ascii?Q?+ThCBvL0Pj/SJBu5hYS0dPjsOlGlXsi8Xknf5Rd2vFS7bhovsVL3vULcOM0w?=
 =?us-ascii?Q?IV6FTdCJ/VaZKD8Al4jRQYax9HKKrFGqdiF+qRrPTxWehdqFzjOqDzO9y+o0?=
 =?us-ascii?Q?UaHSsB6QuBwmIlSDToDZFl5Zsmfqna5JIl/RMpLFyRG0BvlUWtM5S4Lv91+g?=
 =?us-ascii?Q?qes2cohxrymDYG3vx9c836ujmfRhfsWrCw9nL71e994JZncpTbZdpv0WCjVk?=
 =?us-ascii?Q?1BhZqnrkkSV8KxzMNzK5rdbXuRf/Cen1RKGaOlJ0BGyh3+yIjtOSPE7wF5jZ?=
 =?us-ascii?Q?SuJx/GIt3KHQ1IBECLq/wJVRmflI2DWQSR1C/WrTw5944XAd/9jEcOas7EzI?=
 =?us-ascii?Q?/NkY0eyhnX1JQtlKqYLcSQF3AwhG8yAGxkxUudB9JNe6aaBdA+aGyhG4qd2K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fb869-65cc-42e1-70a8-08db50dd9304
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:34:39.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwRGM+nzGd8hjpaplm9RBM/3ySt6WUc4ZzgQALPNY7ZZyc3zRv2lpdCd9IXipEDYOHsjZwAta/cDLfm0clDq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=516 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090184
X-Proofpoint-GUID: Gwwg_v8XluptvggUaqO_BAST0echyDDu
X-Proofpoint-ORIG-GUID: Gwwg_v8XluptvggUaqO_BAST0echyDDu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yin Fengwei <fengwei.yin@intel.com> [230509 02:56]:
> Hi Liam,
> 
> On 5/6/23 14:20, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed a -10.8% regression of aim9.page_test.ops_per_sec on:
> > 
> > commit: 28c5609fb236807910ca347ad3e26c4567998526 ("mm/mmap: preallocate maple nodes for brk vma expansion")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: aim9
> > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
> > parameters:
> > 
> > 	testtime: 5s
> > 	test: all
> > 	cpufreq_governor: performance
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202305061457.ac15990c-yujie.liu@intel.com
> > 
> 
> Some finding related:
>    eBPF funclatency tool says the latency of function do_brk_flags() doubles
>    with the patch 28c5609fb2.
> 
>    With the patch 28c5609fb2, the mas_alloc_nodes() is called much more than
>    without the patch.

Thank you for the insight into this test.

Right, so this is patch adds the call to preallocate nodes for the worst
case possible.  That certainly explains why you see so many more calls
to allocate nodes - it was meant to do just that.

> 
>    In my local debugging env, I can see around 17009999 times call to 
>    mas_alloc_nodes(). The number is zero without the patch 28c5609fb2.
> So we are kind of sure the regression is connected to the patch.
> 
> 
> The page_test of AIM9 is doing following work with single thread:
>         newbrk = sbrk(1024 * 1024);     /* move up 1 megabyte */                
>         while (true) {                   /* while not done */                    
>                 newbrk = sbrk(-4096 * 16);      /* deallocate some space */     
>                 for (i = 0; i < 16; i++) {      /* now get it back in pieces */
>                         newbrk = sbrk(4096);    /* Get pointer to new space */ 
> 		}
> 	}
> 
> Is it possible that the sbrk pattern triggers the corner case? Thanks.

I appreciate the analysis and the pointer to the allocation code.  This
has shown up somewhere else and I'm working on reducing the
preallocations.  This regression seems to be hidden, sometimes at least,
by the kmem_cache.

Regards,
Liam
