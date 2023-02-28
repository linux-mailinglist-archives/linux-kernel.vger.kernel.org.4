Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA16A639A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB1XDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjB1XDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:03:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8EF37B53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:03:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SMu66p026548;
        Tue, 28 Feb 2023 23:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=YrTlFYl59kR+70GOeIUwk1+RAacP+qoVhV/AH0VMB+A=;
 b=3Bw8GXNh1sF/xbEeB7zTeCqMmV9X16AdPTCSqJ1cD3uKBMVLPZyFqG2LtyPX+/OQr8+a
 9gu1UE73gwefGx5h3JYsEdI5Sk84oGXkmD77JAHXMPtCTGT+skvFkgEWq1y44sbY03MT
 vWqMI2P+BdP2k163/YiSPtaacIBUOU+iYfClEqn4oDI2+bgKol8JYdkfJB+Tyw8BMSAW
 NVT+eK7fKOfgq76wWEEBsZ/OQlPQwUzyd5xmgF7s04fbtzrNNzNGq4NXaWRnarpak5Vx
 xBZDAmRynzKyjljUmGpLgMMJf2UAP0GK/tCOqPGcx0oRUBr2F3tDWDC0wDeHtySbZuYb 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7fk45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 23:02:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SLWB9P013035;
        Tue, 28 Feb 2023 23:02:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7hn0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 23:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGTKK9P181couEYnHcz66cXn5nQlYZIWd3a8wWKtBQqsmQ3B+QZjVHkhR5yb0/QlGP/Co65HZtzCEOdTg8BNCUanC44539D1oyyZdF9fZptT2T+6iLyNpF/aFUj1NYgDpuihMRwEMc3Bdo5lhwX7kT2lnX5dXykq2W6WpiGuq07pakw9yYMaqlBG92PBNntO3VU96UwbqdMyhFDPSoQ5IefkOUEwDXuwJRnzP6seJ9Gj0qLCUwvt7iR32M058zqDY8uF4EFNHq1BDjpdalccnbzKhix5vT3pCe8nIUbkV7IPSWoxjRkiDZf/rK13lGiBJhVavq8zPiclvhHt2OYcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrTlFYl59kR+70GOeIUwk1+RAacP+qoVhV/AH0VMB+A=;
 b=NFSMzR8GhKnxOYXqeHJFL1ZMFdt6p0fIEtWtnuSLP0aAPBqtqCSd708PKUjiNRo6B0u5DkmCHhfm5i4QBCXozaLR4IIaalH9rNQ8hm+MBXq9xbBzIPq8WG0aVGbHiLeJYhO3PA0qItfZulzMsJvJexe6j4fOGnKbodUBNn8Hyi7ZB9zK0ctYcQQIewT5VdTV9BEf6DY3NK1Kn9oU+JpOMChmpwPFnNmUXO23kW0Sj6/4aZ072wPfwI55POkYV9miPAzmXz2gI/DqKF0o+Nb1o3IOlaw0k70plCCwwyKIEhy2Ea9zMJ1Eb5Bpy9lzHyVYtwfUgQ+rGSUsCoTgC6cuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrTlFYl59kR+70GOeIUwk1+RAacP+qoVhV/AH0VMB+A=;
 b=mqikcJx+XVVTdNWnJI8T3voptcwESl+CNz70quemHzGOmQeRcGVwmgW4hkkfRrn2JxCRrBLU6iYmXwiaFyzPeDAW0au6LsSl2NUv0aE5106uw8rPugsjnDvYfJTgH69yo0rChQi8zYvA+HqNnKhXO1cv2i50yl7kVRV4GELlbiM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7510.namprd10.prod.outlook.com (2603:10b6:8:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 23:02:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.016; Tue, 28 Feb 2023
 23:02:06 +0000
Date:   Tue, 28 Feb 2023 15:02:03 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/46] hugetlb: make default arch_make_huge_pte
 understand small mappings
Message-ID: <Y/6H66M+lnUqsc4w@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-17-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-17-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: f27e282e-c914-4a38-6bf2-08db19dfd022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDBd1VB/mv0XduUjhINKjdpUQ1EcaUvNjqoZQDE3WGYKmH9fjZL1ucThsswPb0uIj/rjq8wYDaPrfbGaj4Xz0dL191zU1lDzT37Kc8KYfxtTxsDbFsFRKCdemWIVw+YRPoT2tOugefkcRIiiAc4T/EgqPSDU+x2MxFW/DyBSMP4pQVQzVrR3e+pzXbOSn9SieR8+mHXLaqbnhxSH7pcrTlvJ0G6kKOvE4lGQ9M7rQS0FKK1O8iEi25mGXSg8HdYCb7DUw8xLWDx68XQvpKqiwP+jGtnVzolcfdpGbi8c3KnuiZbHuoN1wImhNXl7o3Rr7/qXBkO7mKm+5fFW1nUworgPbUupK7CiQoHdgke2p1XG/h+ORmDCjBiUsAHUQxlkiYZsksnRZgnRpmZxHA1ZVPkdBMReEpjceqEMPAKLGYV42itvuqh3xkEt8OgEVRKpknE1+fkbMOTEJe6oGylN1EAbLJBVeTm3dp0HrpmHby5QIAaOV74Jz5hu/bS55Rq2HFDubLAtzAjfivbUuFDmIaOjgGOr7KSjMv0gDbO/uN765AcJpdQ8pmkoCZr+HdjDg/yrQDccdiS5pCu65i15CA7lANHg+dnqAp/uFJZ5LF3FCMYx0SBUl7PEERmVA+h1Kc9q5TSpuitXdYKqXO65lxWy7cK6TnnJue9NF+bt4DNWHWLCZnd4ZHub6JNEeQ57
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(316002)(54906003)(6666004)(7416002)(44832011)(4744005)(5660300002)(478600001)(8936002)(26005)(186003)(9686003)(6512007)(6506007)(6486002)(53546011)(86362001)(66476007)(4326008)(8676002)(6916009)(66556008)(2906002)(66946007)(41300700001)(38100700002)(33716001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lky8czuDgbpI+kbcjbxve82qFkFQxfc6jVLEM+pTimSz7u+2XStKmTLeTs24?=
 =?us-ascii?Q?pJRyAglBBt8Vf+xRMHK39nc6VJ5bwMMkuCAz8ElWsmj64Rpzf3dkhcgJsUdx?=
 =?us-ascii?Q?AOWPiWojHVWQXqytI+rWrrZ8nJSK+4OSg2DK/iNk7JtlMaaUfGblgvLvljtN?=
 =?us-ascii?Q?kKoP1gRSbJqkqyGwQrRze4915pkdneZOzg2wU7qkC3vN9UGHXQa2jnL0PnKg?=
 =?us-ascii?Q?UgzfrcIpyC+0VSqNwzRsYY4u0a1fiQp3UIrmG9f1OlT7NNqadR9JEEWMxOYR?=
 =?us-ascii?Q?72oyHzebyDAbTN+uWXrjWBZ/6Rt3Bu0sm8b5j2X6dHyPiMTids2NYdnv2l79?=
 =?us-ascii?Q?OT6XUzIcH+r8J0O/vDUcTDHN64OgHVsiFu00yaAGyoDVvCFCJXJ72YG9txSg?=
 =?us-ascii?Q?cxZQNI75PEFhyjNP14UOs2tz/a64MSHCsICup8KMDrom+J6ZxY1r2K23wCo1?=
 =?us-ascii?Q?9BceG8OJ+If4oiIsodtfc8Sid5N0goLZmcDlp6dFLqI5w8v9rmrlKKNqJ+Qo?=
 =?us-ascii?Q?Uhdu1tJ23STN3gY676i6PuZBsS5LUxw2T1AoXvluEOSTIQVXZbmbqv6UGpZF?=
 =?us-ascii?Q?qR0siSn1LiJ+0oBaX9Twq4AnQwR79VBmatZ5xoyyYUP8MdvwS4gtFsB61m12?=
 =?us-ascii?Q?dgxveCQrejL/lCSE4t6YJyKFeo4epY1craIAp7rimgSoE5D4+ZydtFFr/wq0?=
 =?us-ascii?Q?3FhMx7oOyGwazFXf50X7Me/8nOSqtsQW7/YllGD7dfab6c9Qkwcef0lP1lJb?=
 =?us-ascii?Q?ipWVWYD0M+SnbHo9fx0hixhl+DXjiZYj+sAZ6iiKyp8CfsSDrizq0RDxKWl0?=
 =?us-ascii?Q?9Vom5tOcGQez8GRp0E8rh6rfiBif3+A7zCsQre45hezbXsDkxE9DRstkUiJr?=
 =?us-ascii?Q?+M/403lqX9qNornTu5kNaSA0fiWKYOF23k9DEYayd01cr9GXU4eLZgP6YTem?=
 =?us-ascii?Q?7Q2KWa0tHeMiIFk/l40M+iaTrgDO6uvtPdA26B3oswSQUE1g0w1hSZyk9j+b?=
 =?us-ascii?Q?PjFjUXhqrWYglrVHiZuOG4TwMm3nqt0goq9zMV+D2CHO+nVW+p0bn36uw2IA?=
 =?us-ascii?Q?7aiTXuzpD/6OgY3VlAESLLH66awCgtSfTfscBQJh3f2fG7oztmMXut1RrLUI?=
 =?us-ascii?Q?bA+zbHewpcW2h/ZfhFLJzf7qGdNgRDD4RKvkXhz/JwxhMWobCGgCpLGh0jB8?=
 =?us-ascii?Q?4Qjk9k3/s+y1phMm835h3pSmoAXTFhymhbiklLmazcFVqRuCSPOooUrm/z8o?=
 =?us-ascii?Q?B8h8bilpEOJ9jWtBnpiSmWZN4QYBWknrmv1mwyNvQTCzU52gDts07yCxtLIE?=
 =?us-ascii?Q?SUGPY8DtRv/aPwqO6QXx/rGnlbrpEjWvZbzuyT3Xl2ES1y80JG/0SOux1ARy?=
 =?us-ascii?Q?VWEfnc8e1vQy91HEmNqtQXFj6RhbLTxWEnUOIhePnbci0pfL4RcK17+W+0Nk?=
 =?us-ascii?Q?USTVZ8+6uqs+Ut4cgbLT65m7WDOmsZgwbUF1+eB80pQZMzb0+rX336d12zk7?=
 =?us-ascii?Q?cEasi56q3gj8TVxazOgOUT+9nJsDKCD4y+1PbbUvTC2LDaxsDHsBYQu3auQa?=
 =?us-ascii?Q?c+u+GCO/8FzQt5ruAVyhMCJx6L+1TAW2PsV7zOXDlSXjzLyjwnG3O5ThnefU?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ABk/6+oN8s/+n5/v05wGtO+4mmuksME1KiIXzYLAeq1VZOlmJcvrkcvBP3/Z?=
 =?us-ascii?Q?8LhlC0OS25fhJqr53JCI6XvigrijpMoeslsPwMXZ35sfPB5imJCcUsoFsXAZ?=
 =?us-ascii?Q?R/cfFxJwnRM/YEeVQTl/SCquOuMIH2/RlCfRA5LhIaep/rLbm7YvBRQ3jvvr?=
 =?us-ascii?Q?NFSHelkUsSiwAxaWQL/hfyUAxUnrCXuqmQ6GMpY/p60jqN7CzlEQWt8enYy+?=
 =?us-ascii?Q?Y5W5wDTKDorB6uo5HoRwibsWpRdZs0T004/pdMyKXtOmqoZJwzYERqS0GJL6?=
 =?us-ascii?Q?2tJfoYcqHNZdQM1vkgPrNlZtHR6qaKxMEEdTU3DqEznFkuehWADlZQhwIm6R?=
 =?us-ascii?Q?9ao3fGJiYX4vKQoyp62TFcjJ7d9YRckmAVtj/GrYBzeiDIRUdEzQJYKX04fs?=
 =?us-ascii?Q?/nPWUTNg77YmAm4Tm4HvgxoGfkW5JyGgJWqmMFBMSFjCuhLQzL1Zh62Ou4uM?=
 =?us-ascii?Q?fm1OFRWMvlR9W4zy+Cx+W9Hy6D3lYW4yrIbS5Y5aDOL3xo7plw9W4MGb52RE?=
 =?us-ascii?Q?RsqTfay4VgLyrq9RlOHgzF4lnmUL9Di7gWmSd0B2mn8yhMfNBPuAf9gVvm7Q?=
 =?us-ascii?Q?HWGtdEzbkwoG7WxgYqlQhveBbP0HVW+eHzFb73vLQTudhKSAE2gpIVm3ifJY?=
 =?us-ascii?Q?POwVTD7PZF1oatG1stllInxl/5aGUF5OpDYv6fgsF0WSdaAdRpfBhZCsXOds?=
 =?us-ascii?Q?zhoEe8WV3YhIaIItYZAz7xrKGGjNSQwktYKaWUPT3RrSj9k/duMNQ8gHg3PD?=
 =?us-ascii?Q?7K6hfuxj9CUr1cNWrGyjqYbmOMSdBtuDC/J2nzP7faxAai7s1J4yQ/FmEZ+a?=
 =?us-ascii?Q?YegN9jpcWV9iyq5tcz+v9642IchgDMDPjrg63T2YJ8lQVoV0USN/euoX4p2F?=
 =?us-ascii?Q?0/wSAmQSA+2+XqQmRJb118gVbj2UQlj6/IwemNajCkZEmwcYFPC/3RsJs+KD?=
 =?us-ascii?Q?mwzfaLGJj+CKQK6YvITnGtfAIHNohViXkMFHAJvmoRScTBng9+H5+3sU/LTZ?=
 =?us-ascii?Q?VCdmz12GkKAv6mR4DKCmeQbd+rNkJi1LK12eLO8G+Z8+pdW/9Yq99rnxaCTL?=
 =?us-ascii?Q?WuZYjChaDvkdJR+eNTDOqxNvACKn716CVdZIxjQP3SqWnkZnMhweLjrtcoZE?=
 =?us-ascii?Q?voOjFKpB0Mbwl+PKSdcf9EhKAlxWvUzMmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e282e-c914-4a38-6bf2-08db19dfd022
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 23:02:06.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggldUkPnk0iBlq55U4CN5bQ1zbmkjwd1DNabUIv+nmFLdOuY8rSmMFljgUUuXBzdK+s2R0/MAmR1aH7CmzmDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=891 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280185
X-Proofpoint-ORIG-GUID: 2QDCHAIb5_4iPJWS_7jr1sclw47VONur
X-Proofpoint-GUID: 2QDCHAIb5_4iPJWS_7jr1sclw47VONur
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> This is a simple change: don't create a "huge" PTE if we are making a
> regular, PAGE_SIZE PTE. All architectures that want to implement HGM
> likely need to be changed in a similar way if they implement their own
> version of arch_make_huge_pte.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 726d581158b1..b767b6889dea 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> @@ -899,7 +899,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
>  static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
>  				       vm_flags_t flags)
>  {
> -	return pte_mkhuge(entry);
> +	return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
>  }
>  #endif
>  
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
