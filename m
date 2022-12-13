Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6D64C0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiLMXsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiLMXsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:48:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EDB80
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:48:17 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNqSV028163;
        Tue, 13 Dec 2022 23:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xHHLbmv/wZlVIbmn64OOTbVIoE9tnF7VzobVLdSbrf4=;
 b=TyPBYN6z9LYXrJzCbkaKmraJUEeI3e2EF8dIBUT0relXzzJ8iC7ceP8CHhCqSzvrQZOF
 mfHx5AwwfxfCfPUeNHshosTBjHyfiL3/6IYpxIJHgvv7vOA23d+qnr1TOck1conktMJx
 pQXoH4f9MigFja6atEbjHQul5q3e0urNLhAkORkmY9Hf+JoWpCs2T9g0MY6ZRxm91D9x
 X+tPB3miiR2xvS+FX0bDxhGZDPWmTVHEvVBaaQt4zKr/j2DrKmIkgr8fqQgzvpauVQpC
 r2UImqezZqPwHfCW8PxRiZN99U+TJZP06ckljN2cymiqdIGjJuYanxj85I811ixXxNif hA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu0m48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 23:48:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNiGw1031071;
        Tue, 13 Dec 2022 23:47:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyet34dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 23:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izk9hgUfFYUj1gdbXTraXXNaJZn1S33AxFhb0X97JV/qkDLVEMCPlLpGsl6Sr9fcHUedBve3UIUWZeFefMTGXmvS/yTO8YPccooUs4stbmf2kuMKHxPdqhbANqtasQjf4pvlmcPmcWGlXhEWQ1cN8YeHQ1hFJwbhVVYsC1RSGa12uJ7bOMyEfovtiOGCSAtuq6zlU+5y5Laq2Xzi3zUGCCtRjPDKfFv9Xl+U1At3XHCmIXve8wOHwEt3NnorKH776yenBE9q4h5FKsBY+nIEVCcDITTLNwG7TW6L8w1U9ZjIAf/xSp5tmuMFx0Q8C9EIdlub5lSREAbLTX9xgXvzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHHLbmv/wZlVIbmn64OOTbVIoE9tnF7VzobVLdSbrf4=;
 b=iA9MOPyC8X2Xl8EfTIfWDT2JPZ26Tqp+yo9ZiSsPYZj0FmvHZUETr7T4RcSuGYD9aT9uqazfI8hpjXK92WX5YIvFSma5pkkWvQBzVS/f45TAVoU2QnlyQhZFjhQwaN1/nllO/jF2Mn/AnNIhRAEYSFTVdW5Uh2o+vd4LMm8cOqzlpHRrQMDEhZ3Anu8hS2ORaA7TuQqtxaN127q947/nYwAUO+NNzPgf8D8G8ESrNIOt6AdoLiFZani3Fkkujo5x6lMGpxgoN6pAHvH/ivloWcrFt7oi8pBrkn9ZD3Rl9zu3lhecljFqJ99WBa7QMucf8JrQ6mLLAMtyysCq53EJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHHLbmv/wZlVIbmn64OOTbVIoE9tnF7VzobVLdSbrf4=;
 b=sjDHM/z3bfsXSFEN7pbc8Sh6Licg1254rYVtBhdqtApv5iEGAAs46M7JBgrMou5mnQlcsE5+JnqB29iABP7npxdbU9dhEZS+yrBk55vRF79DDA99y8p/VVyudP8Mzp0lhl/tVoEBISFmNEmiOzrRSc+WI5Xjr4jwIpEOd0m1yiM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5956.namprd10.prod.outlook.com (2603:10b6:a03:489::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 23:47:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 23:47:57 +0000
Date:   Tue, 13 Dec 2022 15:47:54 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in
 set_compound_order
Message-ID: <Y5kPKpNp5qCnZEWy@monkey>
References: <20221213234505.173468-1-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213234505.173468-1-npache@redhat.com>
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ1PR10MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 50450db2-7d52-4a32-76de-08dadd647604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3srPf2VqYVnPmfjEV7GX/JesL2ueFYXOIqQMV38zvbs85NkU4bVHlALa0HGuyRvufOROyXfeIeJw/o8/ZxSC4g9ANi3Av2BLdFfylGV1d6wEhz50s1nxiZztsGyDJpqQWrB/EIXW0xjszeQzuhsNBCcQ8VKkkfydRzHyPVH6gc+9O/9Lfpd2+M/EEiSbHOxSminT0QA1XxnT2+zEknaGDzT0hnQCkylz/JtUlcJYdM26SKrC11xcS4ENZmirbEpxNr0p2e3UN6phH8p9ZQJJFUxdP++FJKshZ6HnrMEypfiGD9riWVB1u5Xx7ypqB3Pj3jh9NIY3F+uKsk9ylipAf7gFb/04SCe2cfgqjkNaq+pVKQu5vvDI8f1zaBP/hHbMjbpUd2wODrXuYdD1O6b4gN5fdiU82kvmamS8s3se1VCOfRQT8VcI5MB5K35gBZ5ghT/cmF/MeFHM6/gpPidAWFZ/kY2kz5+Ok6wbSKZO3nPEITDAWfrrIBb1XCmP1v+mWqk9rBoqKvcZBAMZKL2/yDN0AQ9+kEhdH2p3Pd08jXYkWrZlKIHCqq8CVNGL298JW6QoM6qPbcTwk0ItOibPhdEaJCyuzVcqKW79ZDUrr/W/uqtI4OjsHy9iZUo7mGmEmlBLMR4Wf1x+Se03wwKfKloPUg7YRIZTPVI18EfJJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(2906002)(66946007)(66556008)(33716001)(38100700002)(6916009)(316002)(83380400001)(86362001)(8676002)(66476007)(26005)(966005)(53546011)(6666004)(6506007)(4326008)(8936002)(5660300002)(44832011)(4744005)(6486002)(6512007)(478600001)(9686003)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?590Y7c5Ka+axCOC/t63OczmTg4zzDsxPvXKTJNRaFOpLdSXaygSjqrt2E58K?=
 =?us-ascii?Q?T4UmH+EU+E3AcI17BVgjtVo4zMNFbklvOPDxH6hjEkxCb6ogwhHXXyS53zHZ?=
 =?us-ascii?Q?M7uyv1fl+6j3UxU84kkXDXqTydy6dy9lB71bwUs1wqHaOnYqKxsXcWWD6lxo?=
 =?us-ascii?Q?FL3lvHG0I3KB31J2Yv+DYMQY7XclgRaWS+z04ErKKYOrIIv1oZzy6VbXskZR?=
 =?us-ascii?Q?J6qAnsuMwbGRa/22HteFk1qKjoUR5QORgyFaizk1AN5IB3D8WHmT67o2KuzF?=
 =?us-ascii?Q?lCqXtvyArwZhPFGkb5EHxx9GVnbZTcZuN4vYnF6l1kmlmc9MeJJXwkI6a+Bw?=
 =?us-ascii?Q?/GSwHABYI9k5UF2C2i5GRAr5TweVR7ko/puABQjROcoaObIai6Co410ubw2N?=
 =?us-ascii?Q?om/FozBkzx4hkt6dWikEtUQ+dGWe7/xAxM37A764J4LFNd9KkpkOe6PCUZdu?=
 =?us-ascii?Q?mzNfDddzR1UCOoSEaRgSLQjXIhvvwkvtMN2THfk18ufmsdvri4uSF2YCTfaW?=
 =?us-ascii?Q?lS+4jShXv0ryAuXW2lNGvmblGQFVSzzmNe1990FvFMgOkD2LYH56PxRsRL/U?=
 =?us-ascii?Q?+BUPsyesBjf0aEodo+ipRKoxKloNLhb4S1DdcOw7XIsz2QGVU89paGPdiL6/?=
 =?us-ascii?Q?9qzY+F+vqsZ5XNc5tM5t+iNrwdowuqdjeZ7LW3GNS/MrwBUEBuvHdiUwl+Xm?=
 =?us-ascii?Q?xx4Mzw9xBb0bYcPHBccstd9cg3CdzyDPKHEVS1cLC99CoqQKEKc3kFeiZurO?=
 =?us-ascii?Q?gwamnJ/yUEPT1CUmYYLGUvA5l4Y0lhjhctM3Zdii5X7KTbvub0yhOiM/F0Oi?=
 =?us-ascii?Q?wcAETT8oVX0bLlD+VZGwqhmJ+714FhP9il2mt7UxdO7MwSjamlDZuxFsk94r?=
 =?us-ascii?Q?t+Q41mu4lEg0qh5SwuiXMMJC2SNFxmZx3okrinNTwkEpwfi09PUwTya8S32E?=
 =?us-ascii?Q?CRlhFmue7VuP8sfmcu00elQAFBJDn/A9Uz9Nyc3WCHk+bqAjPVDnUcTgI1Cm?=
 =?us-ascii?Q?lBpv1U7g5mwHRNLzj/QfgZTq+pq8pM26XH0D2omXFb1+AKVTIab+91b1cZn9?=
 =?us-ascii?Q?XkCFBJ8ZaydVY8040dtRInZbkz5vj+DS1764aHqFIZOYoKiN/0zGMnlI5Ayj?=
 =?us-ascii?Q?/FXf0Jkk/sY6RNp7Nohp2W4p8FWMi1T96Kn/IlDE2ty46HTMDh6l8DSZZhNG?=
 =?us-ascii?Q?fja5N9wU/db1DbujeNsrvhlK+3mUBIIkdXvWkZHi5iCvCXzvdMCc5sClK6m+?=
 =?us-ascii?Q?WoMrvuOtSi+LqcWZD4AJug/xNAPpXTI3gSF0NK3cM9cU1H/2MD56KjrAyMVE?=
 =?us-ascii?Q?H7iznJLnkUbLHBKLs2sTnkbFia6wTKziFBQqMZ3pUEfwvLlsqkD6l4WEE5Dg?=
 =?us-ascii?Q?q+hgg6PtDebhdJLjA1lQwE9idOuCDRShjl8KcSiUvw+h5FzG7jbEe4rMxO7/?=
 =?us-ascii?Q?qxkC5u7F70Vkn73qO11AHQmqAABL5Ftq0ukoYI1l8MB8u3NbHnhrM2DMH/bj?=
 =?us-ascii?Q?ODrClnC9X7gmEzy5lHYSxYJBVJbEPsmBM07V2achOnWh4pIYAmCHT0ge95wi?=
 =?us-ascii?Q?75mF8FndnYlbiSEeLkVJEIJTiV63cRImcyqGyXRgCAbCpljC0HxQco5/Ia9C?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50450db2-7d52-4a32-76de-08dadd647604
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 23:47:57.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4atI/NSIvv17uke+kYjEPCcTT2c7i6XDPaK1fO3BtPi8lZrfViWc0IhHKNSFuPSOw6eckv0gehA/ttvnL2230Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130202
X-Proofpoint-ORIG-GUID: aQGNajFhRDiceuLUgqLNJa_OSnDNAIYl
X-Proofpoint-GUID: aQGNajFhRDiceuLUgqLNJa_OSnDNAIYl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 16:45, Nico Pache wrote:
> Since commit 1378a5ee451a ("mm: store compound_nr as well as
> compound_order") the page[1].compound_nr must be explicitly set to 0 if
> calling set_compound_order(page, 0).
> 
> This can lead to bugs if the caller of set_compound_order(page, 0) forgets
> to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
> ("mm/hugetlb: clear compound_nr before freeing gigantic pages")

There has been some recent work in this area.  The latest patch being,          
https://lore.kernel.org/linux-mm/20221213212053.106058-1-sidhartha.kumar@oracle.com/

-- 
Mike Kravetz
