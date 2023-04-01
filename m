Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317666D2BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjDAADl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 20:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjDAADg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:03:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF83A276
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 17:03:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VKsERs018095;
        Sat, 1 Apr 2023 00:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sxzmXbhMkgjtxRI2k/AtA/EU/I0RlQTqwUgEvFEIiho=;
 b=FFr2oKRHXOhW8DW2N5cRyDWhypt+NkVLX9YaSzLRT80N+PjAZHWlwBZpkvLvBCuhJiv0
 899QsdMRfDtkMCQ8R3FOEMuRzE6jGw5cOunHGjpgfP65Ffbypfhel9ul+M11omTU29U8
 1sLC2ZmHhec3vXQuk5Y6OcMMOMWuRgmMyurV6wYSJR7uzKGK5OqNf+dZ73kTEa47Fewj
 jhGQ+IbFdwcrOwZG2SLNBd3gGrrF7UW18Fv77dcFv7E2IYM5C+Jcd3d6x69HL3XcwlEy
 HlgFuDt7Zn24MaePYdKL6cjzwBT/dUKRhWEj1rHcdB8VsFNfV1wmU/TBYqEe41Ay37BO Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpmpf8jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 00:03:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VLxMfT023401;
        Sat, 1 Apr 2023 00:03:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdkmbuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 00:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPZTo5zJylI7m8NCZ0aC3ydx7NdT5H7d/LXRI8RcUFVKdzH9NTB4j3NMucQ1daQ0yJ0UUj8JowSCMJZQFBFNrJLbGZa2Ge8/diUS/8IJcXGwVedVvqmQsijboxY4OFYZuME8SQXyY8lIn77gfpaCq5cTSIFKmnUeselVhB2s/YTM26kmYCo3l3g+92eUU1eyWO/iCCKh+bjaYFZesDZnziDsc99mWzbuj7eYif2/dbN6uKKdQ575jvEzChjPj4f3UYbdIKLtSkyvqhP8f3PHYLSdz82YdvzqETJmW9gdtqwUqECA5IoT3HVjYhQQUNFbsmnqMkEIe/rT/NcZjYobsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxzmXbhMkgjtxRI2k/AtA/EU/I0RlQTqwUgEvFEIiho=;
 b=P2PQ9XnlktaUZYgtsBQ7bC/cvKKFO1kzFb5eWvGnpo7miJY5astPkrcWoe0ZXQN0bi/cwgHU3VCAt6jhyVbMrGg/I82Jl2ehZLTSdiUQeGOxijBQm4Wwg8VIixON8oFdnkW4H4C523O1a07dnglPl+HFb+UsuXBWFrZ1vi3R6z8EOXmBH2Efw2xXFDt1hGMXe48L2L6+9T7uwWho8WurfAiljVnNOYmylam7+cHh6jmU4Pk+/9T2itwJocqaX3QJtmd149tJSKXhqrWtq2xT9mM28G/1mXFACCAMOqWlqlzxwZSn+nYcDGxKKUqDVyVs2+Omm7jh3HVhyjDthKSXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxzmXbhMkgjtxRI2k/AtA/EU/I0RlQTqwUgEvFEIiho=;
 b=dNxjILCKd/boXLQJ4okKjPMuTk3KQ1bLOelEMAsZuEhdo73d+R1yPiin9QyJvj8AJK7xjetspXsm7RMcTXPS1NKsV13acL7ZTiqddfOIkVzA6EMoh7Ck14e7FTebW4ncNuY5LBsOTJC0QuEIr965anQ/n7I1JMyuxC7ftvezavU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Sat, 1 Apr
 2023 00:03:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%9]) with mapi id 15.20.6254.023; Sat, 1 Apr 2023
 00:03:21 +0000
Date:   Fri, 31 Mar 2023 17:03:17 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 11/29] selftests/mm: Drop test_uffdio_zeropage_eexist
Message-ID: <20230401000317.GF12460@monkey>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160717.3107010-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160717.3107010-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d18ae3-ee20-407c-a856-08db32448110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X68CSfSenrwwJL5vdlSm5E0AMKxxGlML2x+e8L0FefwYdy3TewbyfCiscuPqAYb3hTqitSdxnq+nYi3h9zWcBXsWWr6TXURO+Zj4mrBjhDIjPYS9RKZNGKauKJ2WjPuHWj91jlSCNP32u7mDzVXzhFEWrzAl2NsywI2p0Ad9kWIbAcw/j8DqkxPeD4iRqD79sO4IGvIqMwP80FSw/piyzhEJsVTpgbY3BuGDG/1Ef799uuddPq6McPd4B+p+ZNBRZoG++OVfJEK7Ru3E0LRqoRMhAXgzWjDm5SXQ06WaFpmoqW8nqzvlpqx2nJXWTzhpg0xK4rFwtWnIwfo5r3ZVtD/A8iouZL8vs7DZ6MAzNJmHpMWRvRGA81g+dwxNN0/qDBgi1VFxg9Fmwq8O4ihmqkvCVxrzLrk3BjHGtEi9qz8ei6hfnNGVFnOf1hqI5+3A2R+vG1hzEeZqYlQs5KVpDg/F/YwbjdS4j7kAA+p1HD40I9uOvMD7L7Oq5LmT+9kiN2n31MMKa+z5ZVcFMFnyU01gjX6Kev0FZ8SEwtgsjctA8cJxVn6IUjJKiRlpIE9K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(86362001)(2906002)(38100700002)(8936002)(41300700001)(5660300002)(7416002)(44832011)(33656002)(33716001)(6666004)(6486002)(478600001)(54906003)(186003)(1076003)(53546011)(6506007)(6512007)(9686003)(26005)(66476007)(66946007)(66556008)(83380400001)(8676002)(6916009)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?anQOlNvc6aQwFPbMpsCTmROpCRcL/DqwXx/r8Cb7HhrWPQbO7oZSRHc5w3Jn?=
 =?us-ascii?Q?hALYAL5HWTS4UuIMcd/OvtqED7PYLLzKvSFfA2d82nCJDsbI2KNXBZ9gCENF?=
 =?us-ascii?Q?qNf8htPRES5QpYaYQ053Re4LWU3Mcewc6vIGrTtnNJy/6tV+Uq1qjW7QAWBr?=
 =?us-ascii?Q?iJviwbnxL11d98NxR5GQruy/eS5zgGINYpS3K7OaMbvQU51skdzgp0y4JyzG?=
 =?us-ascii?Q?Jp/vOk+dKeZ3adg5OYGs2kgSfujTzNcv0kQRy0uk4lXeNHvI44h2O1GtOVPS?=
 =?us-ascii?Q?2xxCiZz7HgqCbYj+xLR0CO2yBqOgiiR3wGb5qAL6zKt3f5T7lezzPpa0dmlc?=
 =?us-ascii?Q?e2yVpTeZFyCm97Zdm4dykNuawdyonK6RPkDaGb46fHvx4jAgpv8nKVNL+7q9?=
 =?us-ascii?Q?pf0oMKCeHpe7ZK9HMcmwcVrX/n4PlVTHkRtSubFokE+uUnGFJrQ2BiSvlAnT?=
 =?us-ascii?Q?G0NLpCfSA1hEVf2EmPWILwFQ3r3YbLB6c/2L4frb1nmZcukIYOb1UUfEMZmr?=
 =?us-ascii?Q?cquCEVNukuHx5fc0zyT0JpMYOzX0ql04AbMTKEiwtvh6EhIzMqYQtGSDHAzC?=
 =?us-ascii?Q?u51z3o8ZFgJ1LMUk4TEevQYUOuARRbYQJGm/ovA+hXZ29rIN6Vwa4Rqcrgw2?=
 =?us-ascii?Q?O0uuyGYXivO/MBG+KY7vmu2H3BpSvZpJ3YB7EojZFhqPDiZvuxMgToMfpGQT?=
 =?us-ascii?Q?rjlJnofuCbv5HzUEMNLDZ4D5ZUo5bMTz/dcSwLLc2yEN/PUfhb+4VhNmZlhj?=
 =?us-ascii?Q?QBGrhbJbF4zOI4UXxkHOWGeIr4rt5X1wHfDD3xFtEyRPnckq4A5XSyE8CPTU?=
 =?us-ascii?Q?+I5JDMpqRHyryRArEMTrXM9k0GQ05xO+R4wc7TPJF6Qcjbjsn4GDeXkIPgqX?=
 =?us-ascii?Q?WRk+oARsMGCXaZ4ZcjCUDxzOF6rtIPaWEU6qN/ZpobdPvzm1bHrDFRGHzwOR?=
 =?us-ascii?Q?nFHASej5VPG6b2iSNqifr9+z3zputLVlX4WHt6WE1QCZIs6lNbcyhjz0R2St?=
 =?us-ascii?Q?0cEPolPQ3vsYcq7tIj9yZ6l2XVG7QWol6+xQ5rG4/sGdSzEGbwQUopbE4So9?=
 =?us-ascii?Q?0vrqjWpyiqt5DTtEI7GWMoAaeG5nthfYdT5FEyVwHPVCDz6+sMXIDgrsoRkG?=
 =?us-ascii?Q?PNyrhOs75/codA21WZ33QX0ROe9Z6WWJ4JG/TYklZG8RtUNdUDc7Ux+ALY8N?=
 =?us-ascii?Q?kwNu4iF3vjti4WJwKyLasbet7QG5ZWJIoYBwjh4YG8TXFLZizR7T9f8O1+w1?=
 =?us-ascii?Q?giBZ8rS6aVajywYs54qwtIks/tsgNeOM107H/aqeMA5gwh3bajIJksnifExV?=
 =?us-ascii?Q?aUHqSUvjxnIujPb/mt148O7JGyS8cZm06L1CmRzIkbiWIeWidxIdhxl8RdTi?=
 =?us-ascii?Q?Vr4UaSiFOpqKVNuELftEOV7A6Da69wAP0WxB9RLV/s0xufDHuEO9jTk1ibVu?=
 =?us-ascii?Q?mAw1aJnjFrW7D/6sg85jcpifXxZqaZj+kMlKLuLX420z9hrQmcJocEdMQYRP?=
 =?us-ascii?Q?UdG78fi/Wk1YZOkUD8/WUNWvhpJPwHioaTnhxL7v9MKNZfmCsFzovD+iaYRL?=
 =?us-ascii?Q?LjZTnGHrSRn42UTYEceWlCt6pBck2ZSErHh0CI1wQM/TvhEt19Vtd81cRImq?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mk7jxgx7r9oNzoGw7pj5QdB9rcMuS15fU/MV3tcjx7rwNOBNMNsoKAUaEs62?=
 =?us-ascii?Q?aoRgQblAhWCVtRbu34DujmO6sWCLlsHcIWx9CpBAcNrYC1AipkVgwtHEsJEW?=
 =?us-ascii?Q?TVom4qyueUDnh8skD3q3k26l1UEqsQyFt+TXVSk5+GzGHSU/yRltUo3KfPkz?=
 =?us-ascii?Q?aMMIrdFAcZ0IHqqkftjouyAu2EHy/Veye/+oy68mcgPNjqDoVvNUdG9PHmGw?=
 =?us-ascii?Q?ZdKygFjn7GmqhJQBdylYRvsoiF5MbBkHOQKJHHdzPOOCudNVe2miv3aVquZJ?=
 =?us-ascii?Q?dI10EDspSzYON/XKKSfYIZWfVwRyIcXD4d1Q1Jgg8Uk7wGS4r1N4VKgQYUXC?=
 =?us-ascii?Q?J2IZjrVT73WZgN+hCHSENDvlWefXTZyxIn1Srs4cTchOWnVsVLT8eVDeMmFQ?=
 =?us-ascii?Q?VQkUXdG1qHXwBUGyuQ685Eeip5c96l1h2wlaczo03LBbCZa5z+EdXT+G3BNj?=
 =?us-ascii?Q?beKoY7g9WlmyCFb08jfwfKqd/a39pIW/I8eALGZ+E4IKva46uLoP+cwQu5gI?=
 =?us-ascii?Q?Ki6vvvGM2IJ/DLRD8NQ+BeFqOkbT8oKoi/mSo1XUaU4PTbH2pAwcnzpGvUL/?=
 =?us-ascii?Q?bGtPR20ENdZJgfs0eHeubJ4W9wvw0xqG9+Li/P5GWV1oGhxSqDS8+9fo495w?=
 =?us-ascii?Q?AMKDtPnJvcmKZUNuU+DDR/Q/0vOAB9On/l3Jc4DLMG8OzXxAIZr90ZoAJ/br?=
 =?us-ascii?Q?uXRCkkQ3mVgbqwIcOiEU+ErMBfc8TzsTkEEBSDU+QTvlomffNCa1bqG6g7M+?=
 =?us-ascii?Q?vwtGD1GyCSL/ochP5TK/FzjxeFaRT2yYTA0yeZ7X/MBFABPXpXeoCeKt3tYO?=
 =?us-ascii?Q?aW4+BwgH6cNQr/WWBgbBiIoQz6eeXp5C5p/BDapnKf4Oci9KERX9wrsR1KT2?=
 =?us-ascii?Q?bIkycs0VId1QTGbejuWkma0OWUXUF8VJLN1WcDW8SkDbjZjN3nzASxtRUhM1?=
 =?us-ascii?Q?KQjRSPL72BT21iulSsp+5KGfU+Mlnkj5J6+mPq54bBY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d18ae3-ee20-407c-a856-08db32448110
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 00:03:20.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+HG+0Z1qVnTuksvNXhRj/nfXuxCe9rx8S2EpD8bS++Calr7/yodAnBTGCymiCudV6l7/g3hmoaB5nznNJ6EwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310197
X-Proofpoint-GUID: RjlmMFc_09-MiageWtfHXFTU66pOpRoR
X-Proofpoint-ORIG-GUID: RjlmMFc_09-MiageWtfHXFTU66pOpRoR
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 12:07, Peter Xu wrote:
> The idea was trying to flip this var in the alarm handler from time to time
> to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
> zeropage test so probably only used once, meanwhile we passed
> "retry==false" so it'll never got tested anyway.
> 
> Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
> is set (!hugetlb).
> 
> One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
> because otherwise the test won't even pass!  We were just lucky that this
> test never really got ran at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/userfaultfd.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Thanks!  With only passing "retry==false", that code is indeed dead.  I had
to read the code again to understand area_dst_alias.  Thanks for taking this
on as the code is difficult to understand.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
