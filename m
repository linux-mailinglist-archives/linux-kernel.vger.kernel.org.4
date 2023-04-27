Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873936EFED5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbjD0BRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjD0BRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:17:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41BC9F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:17:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwulb017205;
        Thu, 27 Apr 2023 01:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bdBgydh/C6N3URbbYjNdWaSCv65cZJnqzuq1adE1Tak=;
 b=n2utyXmA4Ih4GM5iiWeUx6o2k45Er1O4m9ApHJPSHNrJQMUJeP3eiAe99uxXARBhx5KW
 WtX8piiatD/6pXYgRt3Z37G1cyQVv4lLOALo08Q28yNsV72hUfOa1a/NE89ctWtT7JDP
 pd1Bi43qCYPaEMDq/NKJ28do3haHf1YBPea1sB9G/ik6JQeKxn7Bpz7RE9D7o8WfZ3ED
 9H4t1KOIu/1PzrhnnB+TElGZ+ZPqrVRBzhHRrpvB1WdVeSuo3qcHzn+5cljGMHaLGAer
 0xZz8X070jcJoGF1OqZGKh2LjehBaq53L7dLcXomFqLXk4qwTp7qxjfPm8qpBiErotqN sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c4au3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 01:17:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33R0xvcb025363;
        Thu, 27 Apr 2023 01:17:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ey0ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 01:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHyYAQ+LvXaZVt2kJRiWZMNJp0byaHVwhVis4Pqvq5UrQFEH4d7jzwZ8mr5uSVkRDFk0e9pZFBnzQr/JwEcE/RSqdik8i5RLSPnkIZIQbKAY08LzZ+o6M5ezPnsLrNwJlnRBUKEuQx4OMZA6THvcnJ/qxGOWohuEPwIYi6SVRa/H3i8wjXjTfqPnXwp1PJanZaB8ivG3ZFsWK1GUpN1HLYB8GQPxrUJ+Vim3BK46F8HMfm/knXqJmH/JdaoUPYrla6/DE69isSyTayIQI9XZGT5fszP8TnIolWznLk7YGXRktToWfZnREksP1I7KukhUoWnwPs843+ptUY3HS3dDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdBgydh/C6N3URbbYjNdWaSCv65cZJnqzuq1adE1Tak=;
 b=ThCujs6leYccEb/eG/Z0lEENk3UBQiZ4cy/Dvhtayo2RscinORpnWVluu8LsG2IYhnQaIWGkKOM4sZQJn/uFv1yfK5DQzRSFSRy/FLwAA+RwKLAWCZUCueR7qz9R5meCbjWHFoJwi9nTQKQDki5ZxdFwu4la+q1rdKkGuJqa8XrCVqZUPUeoXN0Qxt6favI67eoi035odOZSBR3n4DBud+9v8aQmfxnmcIJ/+vEEMKmb1+1sn5gAqMhPJ2WlXHLW5fRNdAoLt1IIAkQQloJnKl9DK4u0WyVB0C/sXL+df6SOigqQQC/dQtKoQzqSjRPE8vHjwUohfYJsU3Fr4tRxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdBgydh/C6N3URbbYjNdWaSCv65cZJnqzuq1adE1Tak=;
 b=CohobZ4K8wZWEi0p/wJGtXh6Vye9j3h+7wAvwDYnFKOc94RwgvvMuo5nL6MqUY3F65515swwRYmjT5nzfaxIoG0rHU/C651wzuAGQRWBo+y2IvFeQwVzdduzBylvpablKcfXqtrO+g82Es4c5bi2I29Mg7Kmmf6yRMOU4Ggk/RU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 01:17:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Thu, 27 Apr 2023
 01:17:20 +0000
Date:   Wed, 26 Apr 2023 21:17:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 18/34] mm: Update vma_iter_store() to use MAS_WARN_ON()
Message-ID: <20230427011717.3vakguhb3lprg5cy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, Petr Mladek <pmladek@suse.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-19-Liam.Howlett@oracle.com>
 <20230427010707.GG1496740@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427010707.GG1496740@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 4962ed6b-5ad7-4928-934d-08db46bd25d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wyFUHwh1XP8h+gd2bQgNAp9qEG/EojRxsZ8uTgqihvYFYHGeanjiOKFKF4790c4YjVH6VJv2rqwMpeyupuaygZV5ooyimRFHXJsSLfJ2Ox9689JehVN6HEsFaWNecT7fV7KFlVLvHaWiRqilmjrLvTCJfBElJf/noqCrHv0YJoRkFtZmsxJPWon/XAHdTNKNDwuyXtK2W719z+1uWnUKhiKrBt2h7Kv9NnAZ+NuInASwJBLPuBif/TDZpbQpZ87EMqIObo3x4tpXd7aMRnPH6foHMDqe1OrXO+hhhnhxScuCO/N/01AX0OO7A3xCpqk/dvc/KR4cffCvWnIPnb0j4CIXN1baUiNI2+zWsDcPcAaHdK4/rTafuB5b6+ulPW4Iy8WChmq8WX8hU9rn6TJr+/pebovE041UisGT7SEgVsXb79EQTmO0Wqk/e1qPk3al7XDugavPw3MYmps8NoN/qTf8jbAvoT2ZB/UbfaP5R8TY/tlkcg878k890ir8NMTxdbYO2A6I95k8LL1H6d+XRDwIDQOWkntgB4xvfZWIJVEHfwnkS1taovvxQ+ULix/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(86362001)(33716001)(54906003)(478600001)(6666004)(6486002)(38100700002)(8936002)(8676002)(41300700001)(66556008)(66946007)(6916009)(316002)(4326008)(83380400001)(186003)(66476007)(26005)(9686003)(1076003)(2906002)(6506007)(6512007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BineEfrsBnOlE9kOeAQ5mQExQM33PUKCojb6hZTH8KonW2KZb5IvdgT15nFB?=
 =?us-ascii?Q?N+OecPQgLX6XvvjFs83AdESoOsWokEtJBcuyodCAwR2yyuNmR9YSAakVwfFV?=
 =?us-ascii?Q?dYL4MJ3++xsFuabPANzmxjpEg0gM0qB+wxgc3wTKuwZhr8FKE2dNcXtBwIsP?=
 =?us-ascii?Q?pFEzYVSwT+NPojr/UOn7hsXzFul9aYCEIGRiOOrsj3aZEwcr5tW6ezP8A1G9?=
 =?us-ascii?Q?0C4nv4/fd3Kze6FR9C2j7xKO0wkITN58qLeyX7doMo/4bvnzt8llPnjb3c5l?=
 =?us-ascii?Q?Url+fB19aPl5ygtIA87mdQulRHMjE7UarXQGt84RnjsE7onqO2yoE+HC/AOO?=
 =?us-ascii?Q?0sqsDgfFzTO2d0AVLmjDPTomq4FlVP4Twz9baIcH0TLX2Wka0GyuQ3XrFWjh?=
 =?us-ascii?Q?Jiq4U2HTdeg58ylDTsBE+yF+eXiiEGBzx5KIZ/9CbRU2iVPXdW2zromRhocT?=
 =?us-ascii?Q?i5viPHbwy8eoiZ/YOYiGOD+QgIz2PJekZ774JoDc/222OHvjNd/ThN8CwtMD?=
 =?us-ascii?Q?YXJdQ1j950zN8cLo+Eyh4YDApAXbaWrlnQtN6i1gi+lCzn9UD9F7LIEuPxnY?=
 =?us-ascii?Q?9W1pz0sdQnYgrbq39vTfi+JEzh9wGfnzfpq0uVcmfvrMoYwGI+Aa996NYLzy?=
 =?us-ascii?Q?Fy0H7EXESSBM0BoUZrU+5QlkfJRCEAm+o+aLhWICfivQ2v+s1XIaH5VL82jA?=
 =?us-ascii?Q?91Hd43h5IW4v/UP6xGmqpufmQw0Y9SZDpNKHp7B0hg5A+C7qL83QvYo0+gTR?=
 =?us-ascii?Q?unOhh7f+xhspU2ezgf5TCDn0EoqY4NZalgvGSW9KPPUFqRv4rVon3uVb/ilL?=
 =?us-ascii?Q?0s6i33yW2oJY2YNeokXS/RwiHSPw6AAn/q95q+vaQHy3cfTjfIu77ilTLvVI?=
 =?us-ascii?Q?ULdyMhIMqpeIQBA7qWg8Kj0Osex+eISOtbMToAhatS/H4ZOHlu3idykSua2C?=
 =?us-ascii?Q?2/I/aTifVScslaRsq4unZs3Z56mY7DcD7Iz7NrtdjxZdADt0De7D94lGOBMt?=
 =?us-ascii?Q?CWjyEPd6UylNJoq2NBSj97dtV7OTTzLlT74QuHYrc1ZOaO2N2lD1mMPhwmDF?=
 =?us-ascii?Q?IlfxZE0cPd+YZxPUVFj9iZMKJ3egkJQZnDk73zaRw+S564kIJyAwwwTo/eVF?=
 =?us-ascii?Q?3HFj2QtXh8jIdr6IifOfWBpYL6GoAEFM/a91cepupYCVRSXB+2XVwaxs3qoj?=
 =?us-ascii?Q?nUH2I7HyBHFG/KNJ0MdDUHNn9BVg7GPTQc1a+mDayHrLtVBw/RWiCoTum1/x?=
 =?us-ascii?Q?Su5rJYME+jVDv8UbWJCEaZc4DucjRvk7bAzvCveecF6Hjt1rlrNjt+lHmBTE?=
 =?us-ascii?Q?5l1cLC1icWIvnTI77UyzL974JUvS22UzHa/RUlwGDakcv0kYxw33GDFK5ZUc?=
 =?us-ascii?Q?U+F0M4a/xlEjLAlonsp5ar4xd+lE5nbYAm2zImd06rc6ZoSb1XLTDH3FceM5?=
 =?us-ascii?Q?cnzmcnWFXo6Q6zRHESMaTQD7XJAYvB1VBOzB4S5CspmhcoKQ9DBHoLItLqI4?=
 =?us-ascii?Q?6RNu/7rocDvONSJhFWPFbwZ/kl97UanpzWfHtzUrprLHHtMbtUhRPDQMMj1l?=
 =?us-ascii?Q?AoDTEiHQGm6WGNdtgzvLYH5QyWX69QiWd182afycn2qtMofFhAVh0KKN+tfq?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d2hJjvrakxYnn9194XOSwFcOUhUJw7s57pmG/51hhFSEP1vi0stWN7QbfMS1?=
 =?us-ascii?Q?tFnKRq6HvLs9nE2Yb5bPh1fD0VJjw8MwjvGP+zXfbPRx515amnk6mmU0PTqh?=
 =?us-ascii?Q?PT0l17xmJ6nHHhVL0ntWN5AYN/x5w7rF9HV00lZbRe/dRwNqXSbcZ0ZiHyBB?=
 =?us-ascii?Q?+VIHj4JsseJjXb3F3zCHvcp54GFoisPWt+mISLTdVdhMtli4wWaKBUp0QF9i?=
 =?us-ascii?Q?oIUyyHX2/86Jhhl+OlJPzZGPZZhgZw9GE/F79FaB8fRB9/KhoPyHak2+FKpD?=
 =?us-ascii?Q?RUPn/r4AVH51nk70DXA9IDTl2e0nzNHUJkL0n4y4wORdSdsX/Cwa7WVfj+hX?=
 =?us-ascii?Q?7kJQp1O4n9nBbAV+522pFhjCDC6rXPwF0NzUNuLQpliPj4D/IZsTsGfRf3ak?=
 =?us-ascii?Q?nptExG3YHxHFVeB+nzYedYSG707P+mobKGlBdJzw+W5umqc2HPoyXIO7N2z+?=
 =?us-ascii?Q?GG57AUaLCLjk/mM+cML4VSxJ1M5B9pl7d7+ZHRRgnaJYmEk5E6i0CFFfudIb?=
 =?us-ascii?Q?Q1fubzyzwSOOju44eKl8pktVrfq5May0XDWlbzfkBksL2e9dq+pa43TZxvMr?=
 =?us-ascii?Q?Zv7ubgD2gwgMCT7saDkPD9ptdVbiYp9il4dbXLAiwHTN32TBVg7/rWDT3FDs?=
 =?us-ascii?Q?H6x9Aa7kF2qiMi19AELLUY4eRSMnhLpB9qPfhzFJYI76aAmU3Hz9fmoJ1Znx?=
 =?us-ascii?Q?Ky26Vyvh+/fVX4sK1akm/mS4c+kyUFasT4GpQsgpyS6rRZDGXl8EmNWosID3?=
 =?us-ascii?Q?eZfuf1m0qj6sQx6acUuww8smEmLJlSmze0YekJkmaJNdJw/9lW6qDanBNbL5?=
 =?us-ascii?Q?OJPZ2A5FlXfBPZzyvL4XqeL6i9lRe6i1CQcy0VeoRSC5Z66WTHRJ5UX8/1O0?=
 =?us-ascii?Q?OHJA7tCJ4+BbBoPsndItYkLNGuL5+wATiwMGrM7lfUmAPaEtReFnOBkiD+EZ?=
 =?us-ascii?Q?wxOr9OZj7n/d/G/B4HJ5QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4962ed6b-5ad7-4928-934d-08db46bd25d5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:17:20.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUxHWVKqmnM7/1sPaTisVU5KcCOJO+gwj4BbkH751nHFyRqT0p85HD/1iRvXSf94DxXG9uw0PLcew+KFMX14wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_11,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=557 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270009
X-Proofpoint-GUID: Xkxs2JdoGziaqweg5OTg5QoNEbCv6yK3
X-Proofpoint-ORIG-GUID: Xkxs2JdoGziaqweg5OTg5QoNEbCv6yK3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergey Senozhatsky <senozhatsky@chromium.org> [230426 21:07]:
> Cc-ing Petr
> 
> On (23/04/25 10:09), Liam R. Howlett wrote:
> > +	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
> > +			vmi->mas.index > vma->vm_start)) {
> > +		printk("%lx > %lx\n", vmi->mas.index, vma->vm_start);
> > +		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
> > +		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
> >  	}
> 
> [..]
> 
> > +	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
> > +			vmi->mas.last <  vma->vm_start)) {
> > +		printk("%lx < %lx\n", vmi->mas.last, vma->vm_start);
> > +		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
> > +		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
> >  	}
> 
> Any reason for "store of vma" and "into slot" to be two separate
> printk()-s? It's not guaranteed that these will be printed as a
> continuous line. A single printk should work fine:
> 
> 	pr_foo("store of vma %lx-%lx into slot    %lx-%lx", ...);
> 

Really, just for readability.  I'll split the string literal instead.

> The line probably needs to be terminated with \n unless you expect
> more pr_cont() printks after this, which doesn't look like a case.
> Additionally, do you want to pass a specific loglevel? E.g. pr_debug()?

Yes, I should do both of these, thanks.

