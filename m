Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40BD72D0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjFLUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFLUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:45:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28E1BCD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:45:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNjL3020923;
        Mon, 12 Jun 2023 20:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MX18sISFlapIZZcQGNSpy0g0OZlAtBmglsSyFRBbTX0=;
 b=TgUPH8Fnf76Hu0bZOie4ve/D2k+k8he2kM1hkj3vvlZ44FkQo5FzxpXC3zykueUd6XoC
 jiZbZO//JVyFnCZONYeIOv0K46BaZpKl9sH2GJ8+Z1BQ0+8cUxSgoxek+LUUPmwQINfR
 IAF341WgmAhIZ6TVB6FbQznTX6Tv9cLOeuJJf8RBrE2LKO4KI1yEikR3jUaeG87nWZAw
 Hk8pkFI8BHtt6xGKk2y54CcFKQBeE0LlpMtGP+oVanYR0joLaLFCYFExLYlK6Bnxa5et
 KjTniSnRUCPEQ8iQ6KG6z6p3aDJN0RiZ+uUpL3GRbxFd1/FQkMKk1L72VhR33yzq5CKR AQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d3ukf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:44:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CK1k9Q016209;
        Mon, 12 Jun 2023 20:44:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39dtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO5fvVGEtXbrmEsq6ql7HTg7fEWlG7zt9JSG5OsSNyYvleFAFbS2xKEi5he5ciPSjmZyTpUgjtrsz7RdphP/ebXLnoBYJAn4z1bA6eYT06xkCaUPA/VyhdL/9lXveNS6pKLrcF8ApYpkXj11lG+oCcqjF29v5MS0yfb0UtIRm9o7WbNUL/uRbp+3+ijlS6KWekCyRkFg2/GRVHV5WfESxLZ3th1mrliBo27/cO35VRiMmGnvDAYaBI2HBXXdZAIBhdz3NkYVYHuvIWxO24jkglHKGqtsDkJJa/mRG6wBGDkLgD4gr/zmLWSeXew1/rq9hk+lncSWiPdAOSABgaoGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX18sISFlapIZZcQGNSpy0g0OZlAtBmglsSyFRBbTX0=;
 b=H2hEB7V8zxeJrBW/9PHJX3T7meoEfqPXhCnkKWnKUYO8IJRj/STLtFWkJJHsndCKAufUsBTLyP3EnxMvRsPLCac8wBraVqZG/34zJOpof2HMwHU0NSg6BwGC1LPsThu/vYiwA7pG20hrK/hX9BC58I5xEnP6lN04xhg5GoyogtQkGiguCiQ3TWlMJI+zpIcdNQWgEULJdygnLkU6BK08MQ6Sou0e4Y0RjX+a6VmrF1ck+BtreLR8PT8oMSA3BuXCD+DQ6NjwMVtrjjddx0a4H6F2ZY0TwCSuR8iJG6LQr0MpIzBrxtd72EqYYHvik3MwuUONNmDteZ5USQg35mHKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX18sISFlapIZZcQGNSpy0g0OZlAtBmglsSyFRBbTX0=;
 b=K0aiGWvMXWCcfE0xhvYkOVAeAMvPStpKBs5YXALOl1BDh1WBwUOBt4wMgegc5U+n0fr0w+ocsTT/dLAngGdIsLWUWMPLgLJICf2jYZEH+jsBW7ehImKahrBnB+z8BF6SlP4tzpqByXZKJOk6m2OGrfWoOYienS1XNE1mSbNTVyg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 20:44:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 20:44:21 +0000
Date:   Mon, 12 Jun 2023 13:44:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hugetlb: Fix pgtable lock on pmd sharing
Message-ID: <20230612204418.GD3704@monkey>
References: <20230612160420.809818-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612160420.809818-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: c34782d8-4d00-4faf-14f7-08db6b85cca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zToDAeW81eGE6sEv+oAKuU5ClFhp3Xz70nV0kzK5Mt+AfSq8JNku5oqnrHMLNVO1lUOzpITYFl6XiYccSGls6v7hcdRrXwFyqLv9bfqjALE1g0ArrFxiYOc+wYx2C8SW7dUkaZxP42migQN9zVMIgdLnqTI+sTxw5MEvOvaD/hqx0DtSQu8W/JHxYAfHkyvR3fMk7s1LeXKTYXQMKUKF/bQLFiHrPMD6Fe70FFCbvXjx16lmnQyVHzHVdNC1w1/fMekvoj4MEEEgS18P2KDcYHtAv26gZLXnEQjZPH/Wx0s6yeWdiwH+sCNV2w/aP/k3UwZzFC3US8i+wuV1dzmnRWb/l67ifXKUIobx7HybGtaCfmdAb6uhKCJ0IXyUSTiQQAIBYZSOnh0Z2tBTnrjoUfeIYOEaWbi1VEcwz3dS+hc7MdBvklFMEAxMZmfF11O5NBd/rhWVVnJi5qgWiLca7LuziNHffTSpklqMUjZoQ6p/1iOdgbs6XAb0944OaFgXfjBp0pw9yRImGHDXvWKxTWAk4ll0dPFidYC3QFVvpARMk5TL1KlZ9ySb15N23eDh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(66556008)(66476007)(66946007)(54906003)(8676002)(5660300002)(6916009)(4326008)(6666004)(478600001)(8936002)(316002)(6486002)(41300700001)(38100700002)(83380400001)(53546011)(44832011)(33716001)(26005)(6506007)(186003)(9686003)(1076003)(86362001)(6512007)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HDTtapIXs9sNj02UKRpwuxjcl3r0y/breElpK1L7dM3MUzMSDhQqjpEcyet?=
 =?us-ascii?Q?ibtiXpgt0EilZxGkK0egS1IR2Kmj6068Xo0xfNqI+scELVmtfBGLoUYnpQDi?=
 =?us-ascii?Q?8+ytLrlzVO1NyimtrMGqcr+7gmDrvARsZWeEKRqoIGFvtJXpS3zKt5DQeDqO?=
 =?us-ascii?Q?JrWvXGQMmmEzZcixdBslvOWmnpcg0YSw5ecQVqLD07MkpvYRPMi7WdaKA/lq?=
 =?us-ascii?Q?tyvp4Qkfc4oLoBQnsH0ZQZ4eqr+ytlZvUidAAJtpHyyYiQkqfvUAWSkbYo9u?=
 =?us-ascii?Q?n9jTSYN/KukQeOOCPC/nKdPrPUcgnPKJsEWuWFHDt2Yivwfkfjq6A2jt8wl5?=
 =?us-ascii?Q?NuG+yUWfRDRxF1SOLe/WpFdd4BaAnXP5wnGo5zE3sPxDUUTQf6PeaqJxTVK9?=
 =?us-ascii?Q?/ev/7XTHnSWirkmtO7Dxvt4SGpjQFeXyImRGCgRqKauaQKp+JvJ/lBKRPyyx?=
 =?us-ascii?Q?RvxAH8d7oH8yuulOi5ntTBZ5lPlghlFPqkZq9Fvz/Lo3KLMGkVMMny9GQf+a?=
 =?us-ascii?Q?jdYokBpMfbskRtWVL+dmzSFsRusaeKNh/xhs2FnyTn3I6rOZWdj7iVB93rxc?=
 =?us-ascii?Q?gXPObZLZk1Knz8FTAn8eCF46wMCdIl1bTZP3AxmU/WsPNXg/UEyRxe2DjO0r?=
 =?us-ascii?Q?891gi0nDbni4HufV//TflXMBYOGt59CHFiHcc6lK5AwJLpG3GWJ9xFMK4yMS?=
 =?us-ascii?Q?Un+qZ2f3GJgKDp2GgzgGfwVXDCONRHXn6/oO6v8Ch5USCEEs7w0b4eoyLYkC?=
 =?us-ascii?Q?2D+gPtXchaPuerPamhKZSP6Awi8LnBhzq14tBxRh3KHJkgEDogA8vv9ySP4N?=
 =?us-ascii?Q?m7sHznL/XmqJ+04N8uML3L2cT00bRSficidIVimIO0/yQTUlLtb9r00ESVbP?=
 =?us-ascii?Q?LvqKMmP1eax9iLEhp3Ytbmu8MQUhR0O1OlyQX+0wAQh/mkTil/4Vrp9z/TYx?=
 =?us-ascii?Q?APf+neZuLg4Oj4oP5sDmLNIzAWfsyg4jhzo5UuU0eHYhXrlTNQqoFBhWvOdM?=
 =?us-ascii?Q?CixSFybfQiJWFWYG6ZjszS/1P2D6HGsH+dcoJpbvegQ8u6YeAqrPzlR1wXM+?=
 =?us-ascii?Q?Sx7D5qp/w+YDhdqEUAh6p3H7m1TSAJkFajmyOACN8eNwFcVAUICgWBRo+OhJ?=
 =?us-ascii?Q?63XcdIgL5J+RHQDxJrJOtaDuiPFXBUMQAGJxw9RAPcB78loqbt6XLZ5KPpSW?=
 =?us-ascii?Q?d9+QF70EeC2VKfRsO6GSmD4Ko7TwyM2idJTb0sBBZJ2xOI4ByazRE/5W0aLS?=
 =?us-ascii?Q?kytbhcFxH1Uxv4vB8sOO6xhdkGY3LfPmMjhi3aLVEuQU6BAgfPNoEIouDx54?=
 =?us-ascii?Q?v4BlIkC7Q4OgVM5975s8AR8sOAb2spbZF47qJ1ApnIhcUo+M/HNDybUmyA0V?=
 =?us-ascii?Q?Wl7enYDKDZYBXpt7fPX7qHHbMsG5tE4+U6vNq1Otkev1MlTRykimUZo6NM4w?=
 =?us-ascii?Q?xut8tv9aEqKQ3/8srSsSfIQaa5gqGZwevhE+RMN5X+aLqUJIWVTeb2Jqba/s?=
 =?us-ascii?Q?RGc2TsYNnjQQAWsgmR8UuOqfA7LJquSjRYKPWGCbugPpI50N10TB+h+JHGMf?=
 =?us-ascii?Q?+N3VeXk8IghtHufBSVdlJe2x6igq+i4cx5Hn5j/k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?le1d21L1xMKdu5rdv4sFwm2QyJrhOhetGXA0XMNrwa6s2EopLqY4x5adpgO8?=
 =?us-ascii?Q?nP5BLcBz1nVzOduGc3LMjGDyQ3inuQv9kHHiMyolPt4+UZ5EHSF53tl8WSQa?=
 =?us-ascii?Q?RXBOhWcrYSF3Wep0zFzMrBm5IiFbxga8i9eCRIl3XMqAfbsqW1xFwRY1208f?=
 =?us-ascii?Q?AFCsmQaaXiY+Dg3UuWOUCoZMjkJdgh9opEsJ91nImCx3djt31DKY5Ylrgo8P?=
 =?us-ascii?Q?j9iu7pp0u+CJSdvHRM5NpvKpZjcSG1U7fujCpAs0cQ1jHQj4cUmdaixeoQj/?=
 =?us-ascii?Q?6FsYbyrb+UtdVthmQ034W/jpVj/h+w0FxXcHHZrXvO/H+6EK2/FXm8gJInJx?=
 =?us-ascii?Q?Z312xvSGtybzQcBNofvnSmAPRvVFVH+IU1QHpNveE8Kg70dA9G7cZBEYG/o3?=
 =?us-ascii?Q?c+bTIPXQzfi5uIzQbIKfzJzmxPscJ+B6ZtvydTb94LXJq1ecwdhJ65aCCutg?=
 =?us-ascii?Q?1Jx2k9spH8RJ2ki4YJrer/xuqDX9ML5m1/eIRXt3RHQHpg72AylLrDLssl3p?=
 =?us-ascii?Q?0bCmi8WbWzcmceC4V8J4kqnJcu8p54nwuZx26jVrhlUBLpemKqoUS3prD8Jm?=
 =?us-ascii?Q?IiBHGnTymMQM6xw0ofkYcSMUH8ciEKzDj1+pWwcr6lm+2m2MklbvcWsBnkai?=
 =?us-ascii?Q?oJN9NDr8xPjjK+L1l+ABOYOpkA4b9FB5tvfnFEs7BRxDF3F0Xn1U1F5Y02rz?=
 =?us-ascii?Q?NUcULTO7TXhsrMBhAIcncI57GORz51/iHM5JLmeQROdNNBJ0yhYs9VyJYmBU?=
 =?us-ascii?Q?6MA6Njy8ScQJAoaYOpp1OV9a3gfvVuXTYgZEmqMnlz1JLBxUnh2NElpU7aB/?=
 =?us-ascii?Q?jNErVmxopcWZxrOkyKwx6XeIFzoBuDB+e0KRIRx1YH2LNf+E7bYdpowpqqDb?=
 =?us-ascii?Q?adJ19WeXeyeBr5zRu2Tcg/nhBvKReAYuQFbKWXc74vkZFTEW4F/3+nJcu5Kv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34782d8-4d00-4faf-14f7-08db6b85cca8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:44:21.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjKj0Rm3myXKzZ3FM57s839z0mIkZHrG1T0H+NJbJee38XRsN7a8GK5wobz73Ljm6gN4HX61wGsTzLJ/7nw05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120177
X-Proofpoint-ORIG-GUID: 9vYXap7uQtlKgg5skpJsMtf1cBXYh_R6
X-Proofpoint-GUID: 9vYXap7uQtlKgg5skpJsMtf1cBXYh_R6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 12:04, Peter Xu wrote:
> Huge pmd sharing operates on PUD not PMD, huge_pte_lock() is not suitable
> in this case because it should only work for last level pte changes, while
> pmd sharing is always one level higher.

Right!  That lock does not prevent someone else from concurrently modifying
the PUD.

> Meanwhile, here we're locking over the spte pgtable lock which is even not
> a lock for current mm but someone else's.
> 
> It seems even racy on operating on the lock, as after put_page() of the
> spte pgtable page logically the page can be released, so at least the
> spin_unlock() needs to be done after the put_page().

Agree.

> No report I am aware, I'm not even sure whether it'll just work on taking
> the spte pmd lock, because while we're holding i_mmap read lock it probably
> means the vma interval tree is frozen, all pte allocators over this pud
> entry could always find the specific svma and spte page, so maybe they'll
> serialize on this spte page lock?

It seems they would serialize IF they were trying to instantiate the same
shared page.  However, I suppose another thread could be trying to
instantiate something totally different in the VA range represented by that
PUD.  In this case, it seems like there would be no synchronization.

>                                    Even so, doesn't seem to be expected.
> It just seems to be an accident of cb900f412154.
> 
> Fix it with the proper pud lock (which is the mm's page_table_lock).
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Fixes: cb900f412154 ("mm, hugetlb: convert hugetlbfs to use split pmd lock")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Agree with this change.  But, it does make one wonder if the pud_clear()
in huge_pmd_unshare is safe.  Like here, we really should be holding the
higher level lock but are holding the PMD lock.
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfa412d8cb30..270ec0ecd5a1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7133,7 +7133,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	unsigned long saddr;
>  	pte_t *spte = NULL;
>  	pte_t *pte;
> -	spinlock_t *ptl;
>  
>  	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> @@ -7154,7 +7153,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	if (!spte)
>  		goto out;
>  
> -	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
> +	spin_lock(&mm->page_table_lock);
>  	if (pud_none(*pud)) {
>  		pud_populate(mm, pud,
>  				(pmd_t *)((unsigned long)spte & PAGE_MASK));
> @@ -7162,7 +7161,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  	} else {
>  		put_page(virt_to_page(spte));
>  	}
> -	spin_unlock(ptl);
> +	spin_unlock(&mm->page_table_lock);
>  out:
>  	pte = (pte_t *)pmd_alloc(mm, pud, addr);
>  	i_mmap_unlock_read(mapping);
> -- 
> 2.40.1
> 
