Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA98C6D8993
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDEVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDEVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:31:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38B1FD2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:31:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335IukNc013958;
        Wed, 5 Apr 2023 21:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=gNFpESzxwQ0xIAsBUK/YQyPtkZUoLHhyPOSq4gWC9QM=;
 b=t4tZ/iJwTaGcuDIU91GVrpYNpsdVA8gXDRYyLCzawiZz9cssE8lRfiIAXYxkuzMUxWM+
 64O4Asm7mJcMaZpQ3zAZz267oijzRwLd7A/vndc2Zl3HAYFbexZjVqIKXt8BIzM0K8vJ
 /FLpm/f2xap3orOlmQ5fC7zqwqSEiIVlb8EEQCMFldU7u8IfP+Ul0dK9+OBrTGWHKcvH
 xsYZ6AQrorlKQnAiVlbw+EuXezJhIZigPgsCfaaXZfiFr22g+To/LER1scVvIDY6JhLD
 bl4nHiGCSuG42DYMGbCvvgf5Qe/6DXPj7EkC6Vwwe9RIPiKtkFCatJ+vA2A7j/gXBHgA yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd1hb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 21:31:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 335LQnmM039465;
        Wed, 5 Apr 2023 21:31:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt28fwgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 21:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcB9kKUJsv8aOAun5IrycH1+xf2zGkkxgKr9biK62nNLsyCngNdyZ4V5sPdpGZrPmDG/le5eiv9kdUZ5oU8v16KNUs3VONETy3R0jPfrr0Xu95lR0L+k1NJjjG6PWGnOdx0lZ3gdxUjecaoUOsPQq8Hv/wo7Ic6AeFNyXvQlFrYflOjpHZ8Od8eOn1QEkXtLS4u+S2NUQ9NbXOzCbvLMKyojJdhPwHume2zsQbwxjdx5dBXT9WNyYuAp/Zc/zxft/tPIQoqxtPyToxV4w0oTytFhP60YqtyztoTCHpoAa/mkT8snTow3j8bt/2axMYsWK+as7lNFFKXmq5jxfyazEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNFpESzxwQ0xIAsBUK/YQyPtkZUoLHhyPOSq4gWC9QM=;
 b=jJA6YJHQx+d2QeWqGc22febBq8BACFmts5CVwyPQMRc34pKfCiwk6vEIS9rImesHN1NjZfWsYc76PecXuTeV68T7xfwo0PhJhAF/zlUCb2Svsv2VE/Nf5U4jIa4L/7SJfR1WHB+ksc/vvBQdFP/NK+G//ebUU44D0vEmVPXygP3tUpu55GSbWwo5PTtH7lo+GQ2beFxTfNsdnX4ROE83NWNgEqYD61Cw+8RaBEe1uZyBrsPKzBQBFTWxqIMi8x5O30+7Kx0L0j2hq5GfwH0LjA5fX7Rf2TV3lWSQBNWizNxLzda+R6D/SMs3H7F535fY9eihKN+tW0+Bfz1H7B/1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNFpESzxwQ0xIAsBUK/YQyPtkZUoLHhyPOSq4gWC9QM=;
 b=no3QzGZ6OodDIh3JfC0YNnuT1LS/oEoCIafR/5+X3bJPYLOYxno4XSjXZdOibHNuCxj1roHIr4z3efG4i8iKYEWBf6nK/m6GhuEZdMRZKyT9EMtE8GXJgFQiocMg2iUfjTE8Nr2j9PlP10ENtlZJKcMO1C6tDwl4Sk2r42K4lcw=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 21:31:20 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392%6]) with mapi id 15.20.6277.029; Wed, 5 Apr 2023
 21:31:20 +0000
Date:   Wed, 5 Apr 2023 17:31:17 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230405213117.jx2t5z3liowbr5su@parnassus.localdomain>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <20230404151540.GA51499@ziqianlu-desk2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404151540.GA51499@ziqianlu-desk2>
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BY5PR10MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0d3514-c3c9-4c42-628d-08db361d1924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EPG7WuErGtHKPKOpjZawp5Q2zVQg+vBQVndGYcxs+5qkJnxtI6J+jDdKSqmW+uuIznJ2Ng4J/u3pwp1bJpQyw8MbE8h3X8zgFhyjVOiZT8HhYqAAsIWCvPbfEWY4W3AuvxCcHVQVKB9SOudEJsURW9/ErEVJbbLSoT6qdmOeNalffyulbOyx5+lS5yXv9xxTWr0yUpeyBeTFU1wzvziFLhzf97+fqggaydvsMnw7LY124yHZ6EDKia9UseXWv5/HdEB1+qUHZlIQgxDgqk+oLcUE287cKG4xDz9GqlBwAxBHUGSkH+6wLYOm7hoFUZ/c+cNTQc1hWsT1pe3hmY0qPKvo/UdY5hvMu7CqYu2W6y0Wy7CcvktQxJwK7ndNb4rZGem6wyP9jVsvWnD6MMe7PGD5KWIaM3U1o2faSXDaRbK0MmAXdt6lG+QQpFbDuLCgPS2FLZsJi8KjQrm0L8N6EBhzigTRDrefMHhD3UYhLMaEB3REaqbCWnNFpS92sydroa6GGlP4oaiBznKPuSaaVQPxbLc0kr4rJPGUdyuFJzC+wh9IIIv5pUo8Dck5KwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(7416002)(5660300002)(316002)(54906003)(41300700001)(8936002)(2906002)(186003)(478600001)(66946007)(66556008)(6916009)(8676002)(4326008)(66476007)(6486002)(6666004)(6506007)(26005)(9686003)(1076003)(6512007)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvH1eJWtnMOk2StgO7QvqPXMCzSMlr+l+g+nA5M/DJz1jrpQdIxrYizIaXL+?=
 =?us-ascii?Q?ldnn2h5SSUko71873Hgt1CbCTRVmAmos8cZZG2o7z2/aQ2zf29jhjU3Nm40+?=
 =?us-ascii?Q?VHu68Y6nlODizUtXGkPGDOeYcSXjxvgOe/qJsR42Np9TesquuZmtVGMkthEh?=
 =?us-ascii?Q?e3+81pwEkunqOOBZTm611nMI5uUIumQ0dFbFLt9IHkK2VQQjVkyu+Pu9POJb?=
 =?us-ascii?Q?bdFrBrCRBKE3nCSl5RasnCQbTcITpA5bRjP65REkrCG7wyqkdgzQ1c1pD+Wa?=
 =?us-ascii?Q?AKNbJ3iR9ERziSAf7rDLiN5A80FJgYH3q7dafHY1uWzsFj3JPvgxtsUukQAe?=
 =?us-ascii?Q?puM7zrZtzpM7B59KodRcNYwXoMQAbcCuXQc9bUa70w/pEK7Pe2ETO3by/g9Y?=
 =?us-ascii?Q?F77iQV34y29Y/Z3dGXyU5ZUeNYjXQSmY4j9z/qEjAkLE6mOP194xzbczSMXQ?=
 =?us-ascii?Q?7VJvO+hBPog2VYAc/6bFuHp033xEdNELpkoTV1ylI6L2o5ULokGzsSIx1Yu5?=
 =?us-ascii?Q?Jrd9CAisigdpDiXelaeHH82Sz/t9cVsBXyswM/4MYbIGBfwrGLL8lblGthtT?=
 =?us-ascii?Q?Rg3axpiZUUO86ZCAAip+x4eXf9ZNvWU095d10U/As8nyk35842gTxUhzhM8/?=
 =?us-ascii?Q?2ruUdn30A/DVkQehxiYH8iyq6LuKJqHxSABT46qA4R3ETURwP229seB56jeo?=
 =?us-ascii?Q?Vx+h67S9xOFdXCGrvOjoFb80esYeFbwbOj4zUE4J0P7J4ZgTf49T13y8lUSB?=
 =?us-ascii?Q?cBJQwT5R4PlshZPhVgNzIPe4LQi1ENYdTyXKoSBuZuW1jOsKwrpgw+/xhgXp?=
 =?us-ascii?Q?3WnNVLOo/DRwpDTLiEToe1gYbuoAqmHEwfREh6TrSlXZ8/AYA2a5wD0qUrm9?=
 =?us-ascii?Q?SgX2EjvWHm2y0wBg2YVgw6Nrr0leqarDZFszZOOOliZRqVMMqlKkMYyh2bCA?=
 =?us-ascii?Q?BsA+Bn4myy5Y36mKTz75UGnvilhh/RfVllcWZ+HG2eB7S+u0vRlh0zy72bgA?=
 =?us-ascii?Q?G981dzKLWqnuZ7XKWOHFLadWYFgciC1IXYO6wtSzGLwcOkBXiKlVKAeKLcNg?=
 =?us-ascii?Q?Wz2ZRYuKXOwZYjHYCLuyqf/m6WwWWEFLz/AyU8BEGPI+VYJqUeFaJ1SJS81E?=
 =?us-ascii?Q?O0xYBaI6lPYtM4DNFypfpxl6XqLDTgbPKPoh2qwahCjwx+xLWiR6Pk0ts290?=
 =?us-ascii?Q?TBLSkx+xAtziR3N19o6Yv8fkW4ozT61lXCwd8orcPy9U6VA2JmoPKrxDEzEj?=
 =?us-ascii?Q?gQDNtTeiBrvsgQW9NlTP0G+tH+uA0gH/S1h89K7qN5hAvVLWZ2pWsyS2NmPU?=
 =?us-ascii?Q?jtcozADpPIKrg2C3aayc1ukwvd3OQF0tlYg0fDPjIpMrpGsLsrjhkwnP4f5q?=
 =?us-ascii?Q?sc+LPIuwk5bo81pTNDgajGLCtUbF8ZDWqf6bMTBWmoqsC7DxT1P0aYJEsvuD?=
 =?us-ascii?Q?EM9HkWYuuoByXOfXtUwAarDJk8CcANT5hVLVOfaXOp0F7QJCC8vPZx3wnpTP?=
 =?us-ascii?Q?FLsUroCAgbpQLKDGsuuFyYYhTPFQ/ukPwWruETt1ZfbbqwJAYxUyanTVQHkT?=
 =?us-ascii?Q?HzvtMe11NIBu0iThcsEQ1n/atbzfzmCajXlUo3ljL3wRKMYfv1T4rKXpMMYI?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RNfMdzSKhjZmFgXabJ966QFINHjg0agzOxppVq8KJoOI2mPR8AIS/ElRxHxV?=
 =?us-ascii?Q?O0bghPgnBr21dgm5WMlMkXC8qlRCVCBenacD3KOZ+zECKTG0TLbv3s9srK/y?=
 =?us-ascii?Q?MxSTxW0chBrxO0V8k0EQdeoY8C0knncXRd0NljVfKV8DpO/Gm7d4DDt2F2HR?=
 =?us-ascii?Q?XAsjp+46iinJe2oBZHmUgSZj1EZqFEgufaY/lpYzd6ecv0bEOq6FTufe5rd2?=
 =?us-ascii?Q?PLggJ++/uJhKV/h+mhzspj9EcE7/h8anWtgP7y/hC0EK8iWpIG7ctqx6jxCm?=
 =?us-ascii?Q?E3+G5BDzHdA0NLzKbZaMJcMJNAp1ynqV+lkuvh6O6SPf+sl95Mx/KYLIqO9A?=
 =?us-ascii?Q?KRXuuzt1TKqKc5AqBjKhJGjPtHB92omUOERCL6VCjqLtOSkAvv7OtHDOa+ON?=
 =?us-ascii?Q?WHxJ3IvniEemyWY+RKBp2MSWkg0MH5LHl0wAH2MMj+1QqwBVbVHtyfUNakTu?=
 =?us-ascii?Q?7vPOniKUUvBJrPilhJh8lZTXFK0qQtvTKOmOqAM+janbQR4iPpgCup+JMT8N?=
 =?us-ascii?Q?Y0pcyIX7jSIDVbuV1mqlyfC/B8A4XWxlNbe4PuYrsxa74iJxhtgAcqg66UQT?=
 =?us-ascii?Q?KyWrxZSzMebDuF9IYAY44yXJI3A6TIL9dFLHPUHrN7V1DvPLiH2RZdJAaYsS?=
 =?us-ascii?Q?wRLNysKh9xD3p0fs5+XkT3sXDpIgXBGtmXqVrYHJVuz2DA9oS28fCk61GpaT?=
 =?us-ascii?Q?sQ61bLnejiaOKnnZISn5hXF6yjyE738NmRYiNIEXVdlTbmAl6bFYWUoQgke6?=
 =?us-ascii?Q?1ftIbbuP2OqsK2zmwEjZ+kdq+FfH2Jxf+ZcrqviQ94Y+piHxxyhNaEIbt/63?=
 =?us-ascii?Q?l8lHeKhSvTvLY9kjYU31mdnJoa8PzHPS85FqXsSK3GCjBF7FtjHUw8X+o0nK?=
 =?us-ascii?Q?e6K517RW1M29MUo1Srl6e56GIviXSVHaQwLZCzcwaSANpRRDXmeNKqv8uP1c?=
 =?us-ascii?Q?tjc9v8gfcNMkdZDTWy+/jPgdo8zqaCBanHjxQU/hQoQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0d3514-c3c9-4c42-628d-08db361d1924
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 21:31:20.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjXrywW7lieN5uF1jOjV/OjWuM+wWekVoJeewWMAe0vVp38FjOUUk9Ww6qZYHEzmGLBkPtkU8spckkvkIy1UWocrEQTegycgDOTvQQEsm4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050191
X-Proofpoint-GUID: DfinsrF48rEPgtIln7DhNg9fEKNMMVUg
X-Proofpoint-ORIG-GUID: DfinsrF48rEPgtIln7DhNg9fEKNMMVUg
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:15:40PM +0800, Aaron Lu wrote:
> On Mon, Mar 27, 2023 at 01:39:55PM +0800, Aaron Lu wrote:
> [...]
> > Another observation of this workload is: it has a lot of wakeup time
> > task migrations and that is the reason why update_load_avg() and
> > update_cfs_group() shows noticeable cost. Running this workload in N
> > instances setup where N >= 2 with sysbench's nr_threads set to 1/N nr_cpu,
> > task migrations on wake up time are greatly reduced and the overhead from
> > the two above mentioned functions also dropped a lot. It's not clear to
> > me why running in multiple instances can reduce task migrations on
> > wakeup path yet.
> 
> Regarding this observation, I've some finding. The TLDR is: 1 instance
> setup's overall CPU util is lower than N >= 2 instances setup and as a
> result, under 1 instance setup, sis() is more likely to find idle cpus
> than N >= 2 instances setup and that is the reason why 1 instance setup
> has more migrations.
> 
> More details:
> 
> For 1 instance with nr_thread=nr_cpu=224 setup, during a 5s window,
> there are 10 million calls of select_idle_sibling() and 6.1 million
> migrations. Of these migrations, 4.6 million comes from select_idle_cpu(),
> 1.3 million comes from recent_cpu.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   45.15    0.00   18.59    0.00    0.00   17.29    0.00 0.00    0.00   18.98
> Average:       0   38.14    0.00   17.29    0.00    0.00   14.77    0.00 0.00    0.00   29.80
> Average:       1   52.07    0.00   19.88    0.00    0.00   19.78    0.00 0.00    0.00    8.28

Aha.  It takes one instance of nr_thread=(3/4)*nr_cpu to get this
overall utilization on my aforementioned Xeon, but then I see 3-4% on
both functions in the profile.  I'll poke at it some more, see how bad
it hurts over more loads, might take a bit though.

> For 4 instance with nr_thread=56 setup, during a 5s window, there are 15
> million calls of select_idle_sibling() and only 30k migrations.
> select_idle_cpu() is called 15 million times but only 23k of them passed
> the sd_share->nr_idle_scan != 0 test.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   68.54    0.00   21.54    0.00    0.00    8.35    0.00 0.00    0.00    1.58
> Average:       0   70.05    0.00   20.92    0.00    0.00    8.17    0.00 0.00    0.00    0.87
> Average:       1   67.03    0.00   22.16    0.00    0.00    8.53    0.00 0.00    0.00    2.29
> 
> For 8 instance with nr_thread=28 setup, during a 5s window, there are
> 16 million calls of select_idle_sibling() and 9.6k migrations.
> select_idle_cpu() is called 16 million times but none of them passed the
> sd_share->nr_idle_scan != 0 test.
> mpstat of this time window:
> Average:    NODE    %usr   %nice    %sys %iowait    %irq   %soft  %steal %guest  %gnice   %idle
> Average:     all   70.29    0.00   20.99    0.00    0.00    8.28    0.00 0.00    0.00    0.43
> Average:       0   71.58    0.00   19.98    0.00    0.00    8.04    0.00 0.00    0.00    0.40
> Average:       1   69.00    0.00   22.01    0.00    0.00    8.52    0.00 0.00    0.00    0.47
> 
> On a side note: when sd_share->nr_idle_scan > 0 and has_idle_core is true,
> then sd_share->nr_idle_scan is not actually respected. Is this intended?
> It seems to say: if there is idle core, then let's try hard and ignore
> SIS_UTIL to find that idle core, right?
