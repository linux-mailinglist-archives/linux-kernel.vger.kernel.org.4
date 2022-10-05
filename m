Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33015F4D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJEBSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJEBRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:17:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAF6E882
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:17:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294LO9t0028545;
        Wed, 5 Oct 2022 01:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sSdnMNf8RMgoglcDvLHleN/fJJI1quWUHBajDUzj5eA=;
 b=Avm90mSxS3ylNU0ZOpD3uF6D0rSn5UCMn5KYcSqhhTSfBqChgQBT7/FO8OdgNJKLzeiz
 aV8i93HGnV5gcIgpJhun+mXi+1DogPcH3AnJ/uHVy6VhLnHO4L8bjdM//JimgqjBk4g4
 x/0GF2pbvvvaC9AjYnWbIoVdk1Qph+ayUgDz5BMcrrPIGFYgr2RQ8gM4Hkrgk9rFe34/
 LQ7jkSVn0XqsnqDOT4GwB+DLCrEg52ADwz4V/bJy7TfKkryLwhfvg8Sc+hKMHNeGYRZb
 oQCL5pbFTKHXc8MfAq5jqxQYuAZGTak2FSV8MitJ5QE3UUviyv24X4NFwrzFM8V0UfxQ 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea856p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2950Aixp019871;
        Wed, 5 Oct 2022 01:17:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0b15n9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPeKqM6/esk8s1j29qirAA+heTzeSmD0hgMMXU2cRxkl53cNuTtxq8swm/3Kv88ZMlgJk9BknJyxoNy6He01eIAIK7dS0aeU4Mrj2dXeWHg3/wZGWT+KgcIYLEhx6nv/Yq8sdqKgJ5RsPfmZ9vS0+3MS5aAyPN+Iclpsh6I+3yWxWVixyfjPe7TtNW7D1/mJho8anP4sFqmDZnFAB74pdCfPz85cK0+areBbENpkCiq3k4Xv+aZ2lDBE3vkJU3cVQ4+9i4S4C+q9HmpZjs9P5cX/xVrGSRvyTP44l2zUcCnsAxisrnrBexg560CIyyO0a3vYX2R2TobqYxvqpB+6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSdnMNf8RMgoglcDvLHleN/fJJI1quWUHBajDUzj5eA=;
 b=buPsqG40CU0ZMRkaZZkLJwjHoMRIMgJjzawN9nTRCVOt6d3renrMrufsnSaxvtSTa4KwPJsAsHzjldslyh3KWqQaPIV/tz8oHeAK36mwI7fK/zObMBa4RbeVGKdqGIYL/iPaHo2O9uX3u1nOoBILb6YYXTj+rOgke18rikeRBgREhFetL//kSL9jTy7U1WThVbLGyEegWRGHnECJ8IbFo+9eq1D+izFBjLqNBbtB0V6YZLqe9sr4TcDuOPRYyBFEu2+IlNGIY2yvwToVgOkNc+z9cv2IQmudjf1iKNiOX0TfUvKTGn8Bh4NhTcC86+nqR6p80ej/Vla412G83sZzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSdnMNf8RMgoglcDvLHleN/fJJI1quWUHBajDUzj5eA=;
 b=z0ztOhMmFO+D0XzN3Got95fwOkN+mstiRTCbRjjm8GGh1fAuwY26PC7lr0jlDkQ3dPzulAqUBjMtnX5RwezXJYYpK0zpvUqg9QHoDUAIlL/q8tyN4qlvHwPZ/0nemmty5z88DW159g/5Ay/UcGxB78EaUmeZhr1i7V6i1tDF+GQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6286.namprd10.prod.outlook.com (2603:10b6:806:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 01:17:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 01:17:14 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/3] hugetlb: fix vma lock handling during split vma and range unmapping
Date:   Tue,  4 Oct 2022 18:17:05 -0700
Message-Id: <20221005011707.514612-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005011707.514612-1-mike.kravetz@oracle.com>
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d77006-0151-4d51-c31a-08daa66f5601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dP7X6j6VEclVFXBeuhKUeitEDqEb+KskrxIJ01CS3tBWXhpNkXkruTiBZ0ZvNgQRQCFXJHDX7v2PcFBhQVV36YIZs1g/ZEZE+kGsLWyK9BSky/+PboP42PSnyqfQx3vmwWhCqz/LlgvKVzXVi72pZQX0xobybSfgf9gh04GYToh/zqvbKpY+PG0vQ8jf7K48vLfdFEOevlKT+TvIWNwIe1+yF7/OmnN+kSbeR7lm+a0EZMSA0Oqp6RzUNmht1zSYQ6Tc76EMKHFZV/G1KVMpBBZB7F62+6X3DH9sSJHtk08hERv5V2wGiDuhdFk0YGLC7+B0Jl7fMlrcq1QKO6WKZFYOhx0+KNCFHsB21FuFc1fBJSsYfIFbs8Q44E7Ap+E6+Y4Db0Fh7hkJAKq+oz7fvi5E3Vr+Hko/Xu5tEqQfj/b7ZM4n7LiQ2lRRC0ICjw1pmeZrOEKSNMUmHQbsk/XU1U+btMnp1BllWd7P6uAVR2DcNXUQTr9my4em8Rlg84QlttI/r+2Y5QcNEp/IdE69F8V/n6q5yTnlsMEwv6CDnQmNg+tw2HrNp+yZqOcrSPjvj4wXUSr5DVtcpENHaThfebCDogpQBKZpyu3L1Zor5RprLJ6VezgCIG2SdwDPDBGCjP9TQNkXaibNKHj7YEopdwCu2T8oGsts4SiEFHEM6ZQMt2s+nnHW14lW0MfuVAItaz6Zsn+W6mJsWXMPIGq48Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(107886003)(6506007)(6666004)(6486002)(478600001)(66946007)(4326008)(66556008)(66476007)(8676002)(36756003)(316002)(54906003)(38100700002)(186003)(1076003)(2616005)(86362001)(26005)(6512007)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DxDzyBLTvOMHUszeJUF3SjFstE5pneyuSiH1D1QMjLm95uHbQdJUCZNyw8s?=
 =?us-ascii?Q?5DClH8JVa/ov94X3yIi2nmP9s+0yqLW5GDYDlv1zf4QA3gNKz3rsxwVWlLYn?=
 =?us-ascii?Q?uL3iG6h258DCI/dbpKo030QeRa+h9SNNYjARsHhBlZ7CzyRDafREliIEFEaE?=
 =?us-ascii?Q?+fxqJcP10U71li36mOAr/SKjtjEn/9SHmXJ/crT/XhA/gcoGo1g+/u5+Qy72?=
 =?us-ascii?Q?vGN8w2+78FV4CnyWAl2QawEEbZaYUdSZO9e04lTwfxim2VOER1yRHNHY+4Yd?=
 =?us-ascii?Q?F/L8LFoFJfJkqoF8dEFdA2ZpcZrzt+zJD02IARWaDSsHxUC6IchzyPeOMUT9?=
 =?us-ascii?Q?HJP5izKQB937VidultmjKvalhicevWhjucR/UwxQcIdwtFHJInMn5emRlpwh?=
 =?us-ascii?Q?uP6FCrDrvKLU4B4fsdhG2zTi+EjFQr0j2hTEIVVkfIJYHtTXCToVGSh+oMgE?=
 =?us-ascii?Q?naQzBwVfE1hc3IL3bMhd5ck5xlwhSCnf2DQ28ASD9+G3XwTkWgwu2GOJtJRT?=
 =?us-ascii?Q?U3Ukn813XWy1KR3+vyxjuEqgq17VdDzTFn/SkQVWPpozZBcqI7l3FrbujKiR?=
 =?us-ascii?Q?11HFOF+53z4wlwsP3eD5UO5idzpuUt5ronn4yNEKUktT6xBbC+S3jkREj6ro?=
 =?us-ascii?Q?+RKaQh5p2Kk9+VWEyct5zCjvZoYHiP6DQytw7aFoeuyKLV1kRVWyJyVYCNti?=
 =?us-ascii?Q?qteDV34mrkfsTBuVYkx6LSL6V/PEUSFL1Pa+/jQS3r5E1LPntW2r2DEOEUtQ?=
 =?us-ascii?Q?HJ9fLVNM6ampzON698o6DznmaJx/NDDIxH5x6QhMASXFjoDJCv1okAT56SGV?=
 =?us-ascii?Q?fyLSfzpSKsp4wvdSRxY+8bqkao4UBAbgV+B3udXTgjA9jZiwEPrlab70Tr4I?=
 =?us-ascii?Q?U3Dty9yGG70fI/t1GvBpxBTVqvMMl9bWoC5FvBjKz9sjuuZVYS4kw1Dq5LPD?=
 =?us-ascii?Q?AVX/mRZNwKnGXBzaYNvZZNl9aGA3FfCxkVsRtp8+PaTqQobCdnchaA42CSRe?=
 =?us-ascii?Q?5L1De0DtccYPs8kaKs5jIDik1zh4QxgPW66c/InfekxzSRNcm/39NKCZPBYr?=
 =?us-ascii?Q?D+Osqv07nVssl57H+qduSYHYU0L2J7Nbet/F26MRwjQjKUErwZjy1/mPpMli?=
 =?us-ascii?Q?1+KNamkb+3B5IgxGqaU1imzn+TFamQVNgf3k8W2g3jdtMtmq8O5W5eVfIe52?=
 =?us-ascii?Q?YL/i2TFXzfaKmlAql1kWPT8ybJEWrMY3DCc5nYpE1wWIV2VxA8zstdBLEhoi?=
 =?us-ascii?Q?VSAxUB/j/SnFRvf8jysjKCykjsawPwvFjy/KhkCeyse1H6bCqz7Lmw58IU/a?=
 =?us-ascii?Q?/LY9xduJqyQbLrlXxaRcjI/CsRdmF31I7IexGrLaDSUR9T7IQOkEEAraRNCY?=
 =?us-ascii?Q?ANeQuUj2Z8DyEYb9FCwzaEcKSrl2nAtdmRiW14VTqDdijAGL2+5oTQxRLt+J?=
 =?us-ascii?Q?nDDEay5WbLa0K2Sh1DXnmLysa77PoaBcOQQX1i3lWWZNvI9EY0mWHQxG2Fiq?=
 =?us-ascii?Q?FNx7DhUONZLMCuFiZSAry601yBKoRp8E2gkQhdgzGf2sua1sWNb8uKIYZiq0?=
 =?us-ascii?Q?UdbdEBd9kq7ZM7N+8Ud+QSCPOWs8biCBKPVmGntVjLv6omYY5iJMLdSwYY44?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YH4VHAm9nmRQ7Mx8HxvqZ5y7K6O5kT/3KrkiQYLg7ZXA6JO9GpUhMu9M5HXq?=
 =?us-ascii?Q?AOgDN3GoTl4deEoDXPFT9/oe0H55akLw79okPRS7ugyqf+msWwPVM4mDKa0j?=
 =?us-ascii?Q?JVT5CWCA9aoj81bTQ21tmwwY/6auBKRIvz52hoG+VS1unSngYkS9D55qfB0P?=
 =?us-ascii?Q?K97d4OueVlZ4EMzdlAUrqYFLGC/TbptdbfN5I6VX8J0Y48gjX5VHf6DjfjR+?=
 =?us-ascii?Q?HxxjZxQS2XRy0G9WWbD+cPQBmrTVs39llOdPemIuRgctDUaVKvE4ugdsfEKE?=
 =?us-ascii?Q?JkZeRrl8gvkTw2gWXNPxKaKlMLomCRFF+u6qnWnKbnV4ufkGAvcJYZJ4yaDZ?=
 =?us-ascii?Q?aUQK1WSyKjf1fcLXO+b+iOCv1pXz+rQvOPPXqZQR/K+GKjS6qyU6MP+16IIW?=
 =?us-ascii?Q?bE6wGZHqWost9mSkMbbfY4huxdb9CsOTr71ldkIK11stXljdm4hxsg4PaP6M?=
 =?us-ascii?Q?9/iOWsScGqQrUsHeg8kZ6aXUAFdIdaX1BmZcoCpLKclAJ7QfMYUTRVx9Ujzu?=
 =?us-ascii?Q?F6PAT0Gcr0rZjm3FMgCoMq066C/23Krc7eYkmWGRK4exOTe+OTEGEm4TO9YI?=
 =?us-ascii?Q?CEjA+IN0zfne0nUfh3jKGqOJN+3Cu/2w12yV1hn2iM3BJ1bYYXS670w17QIP?=
 =?us-ascii?Q?BO84n6llIObJNB3O3myDoied9b4Ic6eGtdE6Pmh5vcm+ci6Wevg8QtxQZpPP?=
 =?us-ascii?Q?zPqpKZh4++EMw7OQqZ06b7wsEsRWs5V1ycY12hV+av8n6Bfj6IVTRS87FDS3?=
 =?us-ascii?Q?LlEqWAGHyq17i5MtY1YkElXnmm1/5Qg+cakFYD90yXv759n0Dy+5tQDYNy2C?=
 =?us-ascii?Q?A4Niq6uru4r8xrey1Jl6ZSrwbsWNLzdrDUZRRXwJcEL5K56sVWFNDjtYpqfH?=
 =?us-ascii?Q?YuVFWEaE0K5CbrRCfnXS7EGIptQJR9LwE7CvnjoNi2+l7yOjSz0iWunfeISN?=
 =?us-ascii?Q?ooTFJTK1n+ThmcMWH/zyHw4N2Blcv6gNhDPxiTnSb0TbdRHRimdZnfnZIoxr?=
 =?us-ascii?Q?CX+4In2zt5EInci+IeC3TJYY2cbJXLEX99Ukk3QiqeEDtL2lgXsumLR4/PvK?=
 =?us-ascii?Q?+ZOA7MEFZVNP0G/yX++O93qNGuhqkmqzSTr2th8G/VniU4rTc1noACsDyZZ0?=
 =?us-ascii?Q?bisJ6c9h3YXnNum3ksSUOp3SZD/uDD2FLrEmEUXgsezoKKSQPOeMGuz393WZ?=
 =?us-ascii?Q?8nUhWzrf1wE0IhA8pzjL71IO2jIipyqduqvxlDTLGZV8oUXxP3VG3yMMOHYl?=
 =?us-ascii?Q?NuLczoiYRqRIiwqOJ8+CHbb3gIgHaoZjZA/1C9Bh5G+Qp6PKfWRr0j91WJS+?=
 =?us-ascii?Q?G+m+y7m6HJ+F0/foQepp0FrXm79AAmY1IsPnspCwud77ej77kx4MUpmgVgX3?=
 =?us-ascii?Q?Bm49mP5Ri9MC+e+VdVY/IFhOkdRU9Q0cqgBUxrCMv6Ddl6zfPQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d77006-0151-4d51-c31a-08daa66f5601
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 01:17:14.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIacByGbtjrPNpXBCc0V2SyrvNSohXauWZtcqje1Dq153IniD62/GG+PYOjrTIACBIe2lRIFGK2GKXOAp9jAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050007
X-Proofpoint-GUID: vk7LKm-eZ3HVIWbCoj_LOMiCiSOXH9TM
X-Proofpoint-ORIG-GUID: vk7LKm-eZ3HVIWbCoj_LOMiCiSOXH9TM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb vma lock hangs off the vm_private_data field and is specific
to the vma.  When vm_area_dup() is called as part of vma splitting,  the
vma lock pointer is copied to the new vma.  This will result in issues
such as double freeing of the structure.  Update the hugetlb open vm_ops
to allocate a new vma lock for the new vma.

The routine __unmap_hugepage_range_final unconditionally unset
VM_MAYSHARE to prevent subsequent pmd sharing.  hugetlb_vma_lock_free
attempted to anticipate this by checking both VM_MAYSHARE and VM_SHARED.
However, if only VM_MAYSHARE was set we would miss the free.  With the
introduction of the vma lock, a vma can not participate in pmd sharing
if vm_private_data is NULL.  Instead of clearing VM_MAYSHARE in
__unmap_hugepage_range_final, free the vma lock to prevent sharing.  Also,
update the sharing code to make sure vma lock is indeed a condition for
pmd sharing.  hugetlb_vma_lock_free can then key off VM_MAYSHARE and not
miss any vmas.

Fixes: "hugetlb: add vma based lock for pmd sharing"
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 43 +++++++++++++++++++++++++++----------------
 mm/memory.c  |  4 ----
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4443e87e814b..0129d371800c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4612,7 +4612,14 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		kref_get(&resv->refs);
 	}
 
-	hugetlb_vma_lock_alloc(vma);
+	/*
+	 * vma_lock structure for sharable mappings is vma specific.
+	 * Clear old pointer (if copied via vm_area_dup) and create new.
+	 */
+	if (vma->vm_flags & VM_MAYSHARE) {
+		vma->vm_private_data = NULL;
+		hugetlb_vma_lock_alloc(vma);
+	}
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
@@ -5168,19 +5175,23 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  unsigned long end, struct page *ref_page,
 			  zap_flags_t zap_flags)
 {
+	hugetlb_vma_lock_write(vma);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+
 	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
 
 	/*
-	 * Clear this flag so that x86's huge_pmd_share page_table_shareable
-	 * test will fail on a vma being torn down, and not grab a page table
-	 * on its way out.  We're lucky that the flag has such an appropriate
-	 * name, and can in fact be safely cleared here. We could clear it
-	 * before the __unmap_hugepage_range above, but all that's necessary
-	 * is to clear it before releasing the i_mmap_rwsem. This works
-	 * because in the context this is called, the VMA is about to be
-	 * destroyed and the i_mmap_rwsem is held.
+	 * Unlock and free the vma lock before releasing i_mmap_rwsem.  When
+	 * the vma_lock is freed, this makes the vma ineligible for pmd
+	 * sharing.  And, i_mmap_rwsem is required to set up pmd sharing.
+	 * This is important as page tables for this unmapped range will
+	 * be asynchrously deleted.  If the page tables are shared, there
+	 * will be issues when accessed by someone else.
 	 */
-	vma->vm_flags &= ~VM_MAYSHARE;
+	hugetlb_vma_unlock_write(vma);
+	hugetlb_vma_lock_free(vma);
+
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
@@ -6730,10 +6741,13 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	/*
 	 * match the virtual addresses, permission and the alignment of the
 	 * page table page.
+	 *
+	 * Also, vma_lock (vm_private_data) is required for sharing.
 	 */
 	if (pmd_index(addr) != pmd_index(saddr) ||
 	    vm_flags != svm_flags ||
-	    !range_in_vma(svma, sbase, s_end))
+	    !range_in_vma(svma, sbase, s_end) ||
+	    !svma->vm_private_data)
 		return 0;
 
 	return saddr;
@@ -6883,12 +6897,9 @@ void hugetlb_vma_lock_release(struct kref *kref)
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 	/*
-	 * Only present in sharable vmas.  See comment in
-	 * __unmap_hugepage_range_final about how VM_SHARED could
-	 * be set without VM_MAYSHARE.  As a result, we need to
-	 * check if either is set in the free path.
+	 * Only present in sharable vmas.
 	 */
-	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+	if (!vma || !__vma_shareable_flags_pmd(vma))
 		return;
 
 	if (vma->vm_private_data) {
diff --git a/mm/memory.c b/mm/memory.c
index 1b994a55f176..81cc75e71888 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1685,12 +1685,8 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
-				hugetlb_vma_lock_write(vma);
-				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end,
 							     NULL, zap_flags);
-				i_mmap_unlock_write(vma->vm_file->f_mapping);
-				hugetlb_vma_unlock_write(vma);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
-- 
2.37.3

