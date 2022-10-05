Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1775F4D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJEBRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJEBRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:17:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220C6DFBD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:17:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294Mm572005121;
        Wed, 5 Oct 2022 01:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FlgweVLRRE+b8pR1J5LwCXBCQexfEBGQWCGM+XjTR3U=;
 b=yA51cRhnRHajdJhxDWscQ0NLJ+0DUgeBeXcOZZCMAvYmcLk3sp4g4psBgs0GrVEaajv6
 9ver0uILPGbmlp97MjKriY2IjYtOV52ggdKGu7UdcPCUMTydj6R2Sult5eur8NO3nzBR
 yXvAwaBVbFkERGdDdOXpnv4DOqwnRYPyrK6uUuF6v8oYh1fsXwFXyw7AgrPYOLAZmn/d
 y3SWnRKJ9+GCpD4+UZwYSjJAL1Jcn7GGAnwNv0Ktg9JgFFoLUq6/jpFyEmFE9FmFrO3O
 JjBwhCkQGH/wC39lZNn+SWeLV8SoRF9+AQMfVLx4TM0ms4JgM3dSvl+DCMh9AMnALL0+ oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2r2ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2950Aixn019871;
        Wed, 5 Oct 2022 01:17:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0b15n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaPic9aoLILKUciA+AfLHJFbqrrDq0B3b/qay1wZTA7FW44eB7/2/dOPIaf3EtRNySPK6qnzkX488r1bZQES7Acux+tkpJI9knp2VWn9O+oG7L5lOk0VCtx/hCbeWsD5YPeP4hMmcwKRZIaMM6BchAtO9bbBszdAzObg+l2WMGorh7yUBeyouPCerq5k4HmD4296xpqbq+iF0zKwW1x6YfBCgjESfb7RaGuzIHb2O0W1qZtlQzqrXn66Uk/SNKfqytF7MT43+YtOHKa6ukEe/pzl728pMtQfMSpvm5GtcGgYH33Y9Dr1XmFHMQhjfAJf/0Ghaiz9mb8aKwxO5DM2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlgweVLRRE+b8pR1J5LwCXBCQexfEBGQWCGM+XjTR3U=;
 b=IGJMqbkcunN8N5CSur4btk/SunUwSO4+9E8qWRLkbffTOIG3kwvu3QL0AE1DP4wAE83NS7LROJZVT3JMoNV0IvfOjj/An/gu2eYInsDD0rSPt73TBfTkXYvCOiCq1FtGuzyENxzaEMChrlBpvRVhxUfClUsCICgFbKl/vHSw9XVFjzAohBLYdcPTXQlFXW0rs7/oI8ljRTux8vdAjzN6sYOAknRlOUUDhbV7FwpVEddF2R/UetDmiCTVy4JBrZurt8NjK1ztjw3XDB/zJZ8Pj0tV+h+vvoysv8lt2cgsRlhU4w4TnIIfLC4b0PzC9z2H1f97zGR0wpiLsmzWwJZs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlgweVLRRE+b8pR1J5LwCXBCQexfEBGQWCGM+XjTR3U=;
 b=BCrpGaOYA09TVPW3BE17a141vDjYoNRAAY9GqRqiLrbTN7f5s5Ue4fTudk7OXVm6aVUBDo9BhLcj+xnaZhrtV8EayKsAz2PCWIVFKx98oGeN8YtFdL4iSe+gbqIZuWhcQQj8G5tqrtdUIxs9p7KhP47MjEioVMZg8SsZaqW1ytc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6286.namprd10.prod.outlook.com (2603:10b6:806:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 01:17:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 01:17:11 +0000
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
Subject: [PATCH 0/3] hugetlb: fixes for new vma lock series
Date:   Tue,  4 Oct 2022 18:17:04 -0700
Message-Id: <20221005011707.514612-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3f0ab3-f817-4cbe-452e-08daa66f5471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDYt3ayXuSc7/zJ11aDqoZI5hASogDfMYMyN/PKQZe0vtb76g5nldcv5WpIKKv30wY32XmXrF9BRrUnMLENuMONmoXVbes+Ga+EEOgzgJESXr/9AZNT7XaPe6v1/iw22kNoXOX5/9PTbT5u4yBmVY8+aC2wh6KifP4E0cUl2zn2QV5T/YRQUz21omaw4UntvQO7b26za6qofkNQ3mX7PHLO2gVb+ih2F/DsxLfLQHfVmUIUXs2zKxwALi4CftMLiPkibbTMb/6RGTE2S0rGkFMy/1xpI3ZG4JR+uNeokFvBmhklCkzNmAlbUK7dKNDQAj+6YjGHR7o3gOhSom85coTWLgFgcHPqflxSbxp3a3bu7z3ilvhnySEbsbmSPW3uqhW4eDKcKoveaEafezsAtgFqT7e4pRiyCyxSvzzJW3m6/Vz7DwEsmKTxga63q3O9u90+nKRMiGtCJCW3CpNSNj3fOVNjEROyGgrxqmAOM1dDPNb0vSK+Y2TuwP2Exbq7n9kzgdpPjDlIGam72bqLZqa+hpxsmqQIqS0lnwSBRtas64Ty6rFjc5eLZL4tciSNisXW5CZ+gHtYG3kI7kszBSAToJKc1NNs9s3N4SmPdAE0GscMwxHDZwIfon6z2FIZUwbLUGfWs8zhorStiuLEJyGOMkUoIsiaAWvWsrXNJFFPLKUTMpC6gDZBcT4DVi2U5jQKvxRW1kESi7G5W1+SN8x3Y+0G27Ffle2dgFsHpqG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(107886003)(6506007)(6666004)(966005)(6486002)(478600001)(66946007)(4326008)(66556008)(66476007)(8676002)(36756003)(316002)(54906003)(38100700002)(186003)(1076003)(2616005)(86362001)(26005)(6512007)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYwwiUpo1p1iTzKL7UTIdGFnR6a3xyJAJXOoILK03ew9BYMN0XBToxpluJzY?=
 =?us-ascii?Q?5+gcdAevSAgVkVs2PsUEPqQ5jT5CwY/jYdvvNQohVrXKBGr9Sv0k7CHK4vGl?=
 =?us-ascii?Q?QDwFbi5ffyZ5xjHV/j082oi8B+wJ0LOBJVGJb3vHtXRCNS6sGxgEFKyatw+i?=
 =?us-ascii?Q?KrE0s0NmoFscJzvxr1sFGNRoUAJLH8wgxH4juSysEAjiufX/yANHtinhJy0i?=
 =?us-ascii?Q?W2njmhl++hdygR2xKMBxv0zp2S996Isbqm+JJkCCO+ZcheodMYQBZ0oqBvtM?=
 =?us-ascii?Q?sqNNwqhqOighTgmRjqP7zAoEhgzTS5i8G6YKpnpFPccBvF/ddVw0sTPbpFpB?=
 =?us-ascii?Q?215oK9ADUoiCTDcTWwH0whUkYl2TIiqFgXrrVGFmYIfWQi4ZvkMLtvqn9rCw?=
 =?us-ascii?Q?SAIgV4v4Hah7lGSe167QJJ3mmYR7K26ecjy+HKQFM+aPTTB4VY02iWn4VDWT?=
 =?us-ascii?Q?TDA9hMRoYag+XGU+V5LQ5+5Zpgk1HafPXqAfPCUF9y7fAENUvdbx2LadmaRb?=
 =?us-ascii?Q?j/Q0H9TU2UD42wQy04qep3bopnnLWlU+q043olEQdqsssOgmmJNZEvtIHOdK?=
 =?us-ascii?Q?xVb/kvF7iWn7x7/uBTHH1vQWzgRMSwZFFxClgup/NH+0NlWpk6RRbmhrAN/R?=
 =?us-ascii?Q?1aQs/YIo0W1v0MTtQoTXUupmsYBiZqO/pEbf0OUysh/EoS0bEXuvikrIyqvE?=
 =?us-ascii?Q?a+laaeTtw7PcqGMCfpOIfBCAkUuzlm6NNa4PSVW3exPJrb3BA/0UFbW+rbgC?=
 =?us-ascii?Q?tkjtkEDd6UFJVh4ZbTHew68Ws4ghQx/fOY1SDgNj4uM8JIxAtvZqmRGigOmS?=
 =?us-ascii?Q?N9IfW4dVLHdUuPQIUREQ3ZmHPUIM1ljkBgIcSC1yr3bPqVpRrxLIORvgCyhY?=
 =?us-ascii?Q?rRv8T+ipSYXRGgUENoaltMrrhkBR1nCztt8iANv18LUjoBE8xuoRfdsSqlm4?=
 =?us-ascii?Q?b8ICZa54J7PyVps2zaQptktpsnfajXRCxXLYhQJvynOPsGDxx2lPBUXFfIMo?=
 =?us-ascii?Q?69ygN0TXi3FG6Cdw7cpjy2tkqyc/DXRw3ES1EMfTTl7AYDrffYipKr+Zi9wd?=
 =?us-ascii?Q?f4h6rM2Xp56lboGWyhG6iYj5RCjE/7g7eAkA7M02hhf9pznh1NsYCWxnHIKt?=
 =?us-ascii?Q?taojFfEEtoDWk5IMBIUbrPSoxQop+/4h8TW41r9A6i2SdvSj3UqivGJ4tPpC?=
 =?us-ascii?Q?tbPoh4a0fQvqSFmzQ2ZO0qJp54gW45Y5oddQAx4QeCHXyqoZkDtRQ6ZVxO9a?=
 =?us-ascii?Q?Kp0OVKIknJ56x7m5B/VocS/Yi6Zmnk0ba8TlIkqihBnbEeWYXam/jkr4phVt?=
 =?us-ascii?Q?HnnACQqNuhjrFOvp0Nm3FLcDixUBnf2u3dtIh/hiHDXadqJF39yXvDEydV0A?=
 =?us-ascii?Q?7xq40feimVGRAWx1ncqTCISBd0Q0/hGIoEWR3QORbgk2VxatI7Vq0JTtYiLu?=
 =?us-ascii?Q?j9h8r82jATl2t2X4ieAjebWqq2qL9OP+K6VGXnu0oPtIZ6a/GLWkesRjsCCA?=
 =?us-ascii?Q?rkvxOXj0aAYgzu7j7k+zcT6VguRHTrmiq0HapyJN2IL+Fu4SyMEQq5oRXEj2?=
 =?us-ascii?Q?qlpaxBjBXh+/U6NnDvip6ZBEMgMF+G7cS9CgY+spkSt2NntDcLEf5xqBA6Ak?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AqCpCPngnyvz1/9XYVEby5jUtTEbZv4Piu2T+TZ1UnZZBNE4QMqCSOfZbAAL?=
 =?us-ascii?Q?ecipuVi8uSWWFaeNrLfZQNBRY8XzylBDqx2FrRhXgIs+BetU85wWndE0RBIm?=
 =?us-ascii?Q?S4Ny7J5rttH+GapyLwygxRiUYSnkBdSM0Fkg5iNB8S9OIYD1rBt0H4QUJf8L?=
 =?us-ascii?Q?imhu0oF5c7/2CCGEQM3dPBM18FOJryMVdoc7uTo0ryH3BEfqXJKmaDfHI4LL?=
 =?us-ascii?Q?PfrlsicDhhWJNSCJ5KZ0FT3f85J2cV5xmnyDHj3WCCifaNPilqS4Zd9ZFcB/?=
 =?us-ascii?Q?F3yTBp+VX0gJOonCMaT4AhAp4oYYbGh+kxY2OBStoqmA2VODTYm9564c7St/?=
 =?us-ascii?Q?VejrMMu9CQ/UfxEIv+iZ2YaeCphMF+qbLUp+i5CarbhPTGNfDreUm2ZW8exf?=
 =?us-ascii?Q?2mRwWse2sdak/h8EwvFDfnBFA/80lKrjMfzd2fBNfW7pg+9E7p8GUWfHjS5K?=
 =?us-ascii?Q?vfz4r1lmYcH8meM3EZeT18pt5/t9eXeqndru+gWiuopFaGhRtzr4qRMFsNpS?=
 =?us-ascii?Q?lVEwd6x9ECa+Hbji7x0tVLgh4qZ6CermgMu3ICM415+9YkXlUey7NjZtsWUE?=
 =?us-ascii?Q?1iFhNN57BLcGoEOUTQINQ/6C9TQz4kb39eZG5kWWTDoXXK9drLtM7l+KcO08?=
 =?us-ascii?Q?3xQwJ7LDN0gypgmsXemn3Pxz+hsvkaATts/3vxVoefAAHiRsdJVOitS1QHUc?=
 =?us-ascii?Q?vVptIJBmRA+4TFEu3MujNvhhlFC2trFOAtUhzBsMf2ie74vlKZuJjHYmQfI3?=
 =?us-ascii?Q?JdEuwCKJYETPIzqixPAbvH9OqrFwtak1TmiJQjTIGOj4DjXUXvRJsF32a9xj?=
 =?us-ascii?Q?U91pSRHSKcLuDBFRELl0/MJehB4mYuDo5sc3PavSAcwojMKbHrpa0djdCNuc?=
 =?us-ascii?Q?/cfVaHZZehoDS/7g9Qcxc9pNGNxsKm5DbThxTFircQX1aRtIH8TQLUijMLmE?=
 =?us-ascii?Q?Tpuh1zV3zoUV0e84kmkCH32IzGumn1Isxlu2L5RYoH+2aBDoao59sMdIlQqE?=
 =?us-ascii?Q?CeE7zAbNicGAhr4Yu4WcAAl2VB6c8DXOLEbYakz5jZO28BdayrFs0hH4tWDB?=
 =?us-ascii?Q?0jBVJCHb4yNxnGMsTxbh7loGO9prnUhMZJY+uTBPV4c+6nsCJ50gnZrB0zjC?=
 =?us-ascii?Q?lg12/zLjx4LkKHn1lh6FBpO04v/SWjY3ZBwfmhyHCx/LEbMGdTz/WAbsRJxT?=
 =?us-ascii?Q?LZTG2yDfK1Uld94W8x1KGi9YfYHW7zicqqVRCfHW3szwgWCeyk2T1QxLlRhG?=
 =?us-ascii?Q?T0EB13BIHReHgvHAqoI1dGp8O5lz3bNW2B8z9wFkNqMXOMi13oHrz3vBY/0/?=
 =?us-ascii?Q?dw1kCEaETjT3j5S8z2ErY91ILOTPX7lapiGp9Jv+j6FE9WFvFrG8C1b6EitR?=
 =?us-ascii?Q?mz9G5x761P+WOQHT/UyWReSCQ+TqSK3FLK9ZFc8Bu1S4BeVzGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3f0ab3-f817-4cbe-452e-08daa66f5471
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 01:17:11.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6qOjPeQajx2I/BIuCl0ieiDVVM2c3z8zwLBhRJNmws5sR/s2K6+oKXZ9iQC30jBd5eWW6ae8uSnTN2HqtoYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050007
X-Proofpoint-GUID: cahoazbePDiGsCo-HnaYtaXd_HHvmTvz
X-Proofpoint-ORIG-GUID: cahoazbePDiGsCo-HnaYtaXd_HHvmTvz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In review of the series "hugetlb: Use new vma lock for huge pmd sharing
synchronization", Miaohe Lin pointed out two key issues:
1) There is a race in the routine hugetlb_unmap_file_folio when locks
   are dropped and reacquired in the correct order [1].
2) With the switch to using vma lock for fault/truncate synchronization,
   we need to make sure lock exists for all VM_MAYSHARE vmas, not just
   vmas capable of pmd sharing.

These two issues are addressed here.  In addition, having a vma lock
present in all VM_MAYSHARE vmas, uncovered some issues around vma
splitting.  Those are also addressed.

The series "hugetlb: Use new vma lock for huge pmd sharing synchronization"
is currently in mm-stable and may soon be merged???  This is why I am
sending 'fixes' to that series instead of a new version.  If a new
version of the series is preferred, I can do that.  Just wanted to get
these changes out for review.

[1] https://lore.kernel.org/linux-mm/01f10195-7088-4462-6def-909549c75ef4@huawei.com/

Mike Kravetz (3):
  hugetlb: fix vma lock handling during split vma and range unmapping
  hugetlb: take hugetlb vma_lock when clearing vma_lock->vma pointer
  hugetlb: allocate vma lock for all sharable vmas

 mm/hugetlb.c | 127 +++++++++++++++++++++++++++------------------------
 mm/memory.c  |   4 --
 2 files changed, 68 insertions(+), 63 deletions(-)

-- 
2.37.3

