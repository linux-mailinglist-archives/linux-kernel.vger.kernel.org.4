Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783A70766B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEQXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEQXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:30:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80E3A8D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:30:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGwf2009765;
        Wed, 17 May 2023 23:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Dtwy2rDjGVoz4GaYQbQdRDDelZDZY3pZp/o0nBOU9hw=;
 b=GCkX0Kpbm58eZ8JQ43pE+K1++Hr1m57kKKIZntS40hdVUJpD/xFTMlSNSW02vWeeC7Mg
 dr5Jft/SKKE/21o/+5gnhmANEZIrGtlAg/4rLdiLhscpP53xDXZePn1tv3V0geVJqHHN
 oRyjOqVksIS2kNHFwVa57K79dvDqwGVfS6JHJRFrxJAtxIoe3zMCtS1OxfwCkUnOUfx2
 nCHuJyRQub2fc6wP230XT9jhNlkskNHVFG75BS708FlbbgVQKsPG5vDyrn9qw9PDbLhp
 JEaPzW6PwAXzgnMhQIQXJqJtcCdE/LNfSSxe+84mcvFnybkFeHre0xMDAV1dmCcA6Uvx 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j1gh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:30:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMtKtS040286;
        Wed, 17 May 2023 23:30:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj105ty2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjiQ9EUQ9ncXYj90MiyToHEsQRNaxNRZc8GJx8s4y8sBKBEAIQ84Q3LVDTgspid/Z11mVJlIMAPAa6jEEuwvEO+Vc5sJaYDNQKrFUSKBiLrbvM8XccCA9MRVeqFZgJAJlB+veDFemJmhL30WddL6YztLWXn7r+LXGMWBNSX0vMyH8HK4OkMAPUEuZtZ6L5AMMCmW1LV52s8OYMNcTUGsLzmmRabVsspYOE5Wso2uhPeWYPyXB2eV3NUjErtchFIrAducYK/mYNkOJsdjjalDJYzqGr1DCKM4I92s9uJfvtpl3oUX70qAAiZ7oSGUYAhaoyo8pvGtAxqZ6yCJDm49iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtwy2rDjGVoz4GaYQbQdRDDelZDZY3pZp/o0nBOU9hw=;
 b=YyY8/pqvOIg6JGq0yFFbpGbkSgy5SmJNQM1vsSvJJ0MTrZExPnM+tF/6s/5au7ANzkO0mbXdCIo8FSRKKWaIMO1ob34J3lXErI3Ace4ZLlmbvmuknnMzJMxctnpgzPzq/8j/rIZL4pJHfr8tVmTgdeCQOuu05MMrFHlJ1ULsAWuuqn0viVfXREfckdLvHbROvgywsQMhoQ/pvU0TRZuC0AHWY03ZH6Bx+SEYC1FI8hxgP68FLFUXLnJJxdelZ/E3d/4LVRrL3E88OKl637Y3A99+ZIlhgu6P/PZM/AHO135WQW1SUKIK6bAZFzE3mZUJJQkQKPoJxWVKYfU7bmT5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtwy2rDjGVoz4GaYQbQdRDDelZDZY3pZp/o0nBOU9hw=;
 b=JkfodOBNVQ2/xsRMAxSDZnmHol+oTH5hGtujO29/PNTb94HTgvb7KTl5D0lVDiZ5ZjUPVJdPCRryQykt0vO8Kd0fpy59Z6IJ8FYI/33WQATLwqSJKP7fvf51QDPOxxMEIIILooB361t8UaoEigXuMUQ2fS/jN+bc72YX3CR+H80=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4663.namprd10.prod.outlook.com (2603:10b6:510:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 23:30:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 23:30:23 +0000
Date:   Wed, 17 May 2023 16:30:20 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v1 0/3] Improve hugetlbfs read on HWPOISON hugepages
Message-ID: <20230517233020.GA10757@monkey>
References: <20230517160948.811355-1-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517160948.811355-1-jiaqiyan@google.com>
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: ed57781c-d634-4d4c-2da3-08db572eaff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+7BfA8wFrer/WgkOc4ZTDZ7TNIJSaPvY+CPS8DGQqI6cO6Kdc0yiqkF3hwjLxUgLseKEQhuPwzcnNT/VLQi8FlpKrpiuWY2YxWaldblfRXy7hOBbx38bzFjMROgUtAqndUZksP2IMJggE8VazMnvmWe62WElAggahlvkrcHz0pCJyT9eK8F8NxAx6cChKOAxZqQ6m/Lt+ZOi+0FESAqb3u9CV7VUDKdpZZ3jutzhMFlH/Wu3Y/BNlhSxmajAyvTzKoE/W2kITL9eBeuXKHRQr9rT5wFj2snX/oO9W3z5LH21oDAyFrE8KTnGBeK1LSWGhfTlFcmcq3RsOYVAfpAY08R/0BJN8kZO6aos+/CoM84tXg2e+u+ctya/Yo6wyVOCXx/H65DoqGGT/pB6lMg1drs1O4dEYA7I/Q38ggaNXR9mvfQNENk1vxpD1Mxu4PX97ejBcRXZmabCN1ZaAjTiTB23jqntVqVNJeYwcNueaZYsu9PVphq7dnl1FLyjJis+3awzxSLvGshJetlKb4qyQH3nTBF9C+j73HmXaXgtoKxy1ZxPl1by+ardD+s0ihh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199021)(6916009)(2906002)(4326008)(7416002)(44832011)(5660300002)(8936002)(8676002)(86362001)(66556008)(66946007)(41300700001)(66476007)(316002)(33656002)(6486002)(478600001)(53546011)(33716001)(6506007)(83380400001)(1076003)(9686003)(6512007)(26005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUWHy2CCZRipBtwQUAK60xZbgkEpdkLY0bqneAHkpHMmcNiOtROg2Z4iPYgZ?=
 =?us-ascii?Q?fQIAKVmt0dplNhimOupicqaI3eNTm3VgNT7TZwyE/zbJ4quA6iTVj0l/fzlC?=
 =?us-ascii?Q?xSGNxFekwQntdUnJCpjg1WX81Qcx7mck0eIsyJjYLAKdaLPVaWWfgcBrZmg2?=
 =?us-ascii?Q?D7SBTYzYgHuD8FCmX9u9bn3ElrJBBhVG6/lYWGqGTOK3qatsx0pK2eZdkg2u?=
 =?us-ascii?Q?ev5NDzYCIYiu0dYwH+bloimvPHauFhh9R7fEj61fSPK6k4xk2xdzYfSPWaOg?=
 =?us-ascii?Q?J6ayfDSkpEMoXDN/argmkr8lTEC/om7CmCvT8dD0faWyyVXVSXrbEGuLp3YO?=
 =?us-ascii?Q?6u2ohyKwv/Ufk8lWlcmNVKILuoJS2eFzkOc+Ya8JO49lb5uk4pfq1mlvk0dn?=
 =?us-ascii?Q?OQv48hFWkhM+dPzihkGwwayrGHBCR4PJvBoJZbsFhuLJdqpoMY7Zrz9nauXP?=
 =?us-ascii?Q?/1Fi8byp3HMTd6J4j6p9PdRP41I2BiY3UN81K4TnlL40LOgzEDTAZ6ibLlmH?=
 =?us-ascii?Q?XwrQ4nPAtVi53TpBxwlwXhRDiXzZvfMxthsw2qApHjn6Nx6txc57kR/IYjLz?=
 =?us-ascii?Q?T/WVua5dHG8qneGD2JlT2KB2cBDsUpUyeoRAAXjo0kTLT4RBAkhsHhQyf6Ry?=
 =?us-ascii?Q?s/V+XMAnuHCslPolheqaewNam9HelOxCcKw0ElfKYl0dxSoQGgVgbgIeHU2v?=
 =?us-ascii?Q?k/QOVTjfL4AoSBGqLKVHSyXvQGlJKEeHN21DctlSRowVl4HqudYXSlEBVsAP?=
 =?us-ascii?Q?oIthQa2fFEU8/kO9jpqmVjKKdlS1Gg2joYWDIG5wjkym5NX6ADSzpoOJYCu8?=
 =?us-ascii?Q?5k+sY7ukbxGoHTXasWsLYnF5AiZSpu76U/ADsr9pE8p1N6VC2IfIK2HRGFYW?=
 =?us-ascii?Q?98nIf3MYN60LTxkaOPiBnUtu5AmWprxcG7zKlbJ1tvCwHuM98IFCS+2rva5V?=
 =?us-ascii?Q?uVlImwUGe/SXPLRcd7Lrht3tGXYlidBxMx5nHHsKAerPd1eFUwE4HPZrVfPt?=
 =?us-ascii?Q?aCGmzt0H1BNKbbdI5T2A+adhgJSQgmhonMhj37/xfUc+G8+HpptC9gZDzurL?=
 =?us-ascii?Q?DFFY0/zs4VHMEUFW0Vt5iUpYL4NL/ZkVr+9dekfIInSRuzI+RJkuMyM3e8el?=
 =?us-ascii?Q?sOQ66iaIFWbk6nbjlcFXjN2nk3eOMlLodvs9b7SS4AN0quf6DaxzPi9tvjRQ?=
 =?us-ascii?Q?q/595+66jzxmgQ4qcW48sLU4k6zEFFeH4cKzXNA1HmZMFpHE286uEgm3ZiUb?=
 =?us-ascii?Q?YBi2iRDMWRTIeXzKyseRYFNcfPNKPPdPzgNLO13W5tFLKk+ooO9HBaa9Z48p?=
 =?us-ascii?Q?iy5yNP9SuSrHSJSj5iAQB5LEH7qHYIQrcp3Vf4jc+0f5u+90SiiDHsmcJCBX?=
 =?us-ascii?Q?q4oEtqd79aNa4AcdB2l9faWlDDK4eNc3/k8/uzgAZ4MCQC/5E5ehPFTK610Z?=
 =?us-ascii?Q?7K3V4mlfQciZ41dwV88/5jym5R6CbIh4N+m4PoY12dD/v6frmFL7FCIkP63a?=
 =?us-ascii?Q?Zx9E1J/Ex/4qetJCXMtRyPepo6ICT5y0oelfZsoflRR/MEHX3haGa6rllmkT?=
 =?us-ascii?Q?c4X3JLgUpNvckDhYJqdInAxVgLn0/ZtFi6L9Nov7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zpFvsNjncFzQiKjd7RdnqIOhv0LNtSE/QN72pnzbOqJwCHxYv55eYTmSpuu5?=
 =?us-ascii?Q?24Xdm/ovHI49XCd0ghnbqmY7gQR955+ASfgJSuqMYa+URnyCa/yToqt+b/uH?=
 =?us-ascii?Q?ZOLUQ2atr2OdToaxIBr87s6v7Vr1j1hve0irOF/A4eJkr+QHpqdJHaGU+nwL?=
 =?us-ascii?Q?ukoLtEniej56PbM8A97dOfnKVOKvzV75VedkCq1dwcMJIRNKgn5TNHKJyTFe?=
 =?us-ascii?Q?eARQlF7gMH77Pzpb8oAya3sXVSWklG9yQ/AWFA+Jpp3jgeEwG9MQ/UxAto9c?=
 =?us-ascii?Q?zSeHEEVZPMa5IM3KIaKadRxr+CzClpOsvgSWcheCB5WsetwhQM8F27wP1W84?=
 =?us-ascii?Q?pHkBKM5Wr31ugSResnaIHuUxplaQXhxjQdqsdQAqnfehGl9Fjsw9W61Z64Td?=
 =?us-ascii?Q?qAsF+ZaD6lO9skYP/uiijdpnN4LRiVBgp5pJ1sGFVbQQivjdDlQWTAFUQNWD?=
 =?us-ascii?Q?yBFAF92BBXn3JTCL0x1gRY7Z2zTn5w9mE6lHkkOuYq+8dtVPVgVZNJw6uMs0?=
 =?us-ascii?Q?FmQvbQkAqwfw9/GUOH5qbWed6yH3uie//NeRNAEhTANL/fDISQku1HV7AD/l?=
 =?us-ascii?Q?8Ea5H2StGWM1y2xKbZmOrRK/6DTWohzLoY++KRMI4LwKYRjssHJc9boTVCf9?=
 =?us-ascii?Q?ib2Y1QtO3mGG2cyCT5O6IWr6XbJEBqM6zTuR0KMzdWrVsvmJnaffBXKrU2RM?=
 =?us-ascii?Q?9Mw8HgM/gyd8HZo+w+PO+ReTG25QosfEIwhzCyD0g2z45so/SJR1NkuTNYiV?=
 =?us-ascii?Q?S3dS11HGRURlnJ5Iv71ZcyeGxZpxRFgbP/HuuvhGiEYsRsZlzbKWFztCgfQq?=
 =?us-ascii?Q?T+95jk+l3KCu+zbOCDO5FwTRRLEm0p0vIlWQrw8LIU0rJTtdRysHMx2bFuCV?=
 =?us-ascii?Q?3ZLvuJdyUlqlbBnRWjo4m+HNO4/AFYkJexftRLOEJsGpUh80nZ7rvlly5yoI?=
 =?us-ascii?Q?gR6OgXU1d1m8wOD7nNNn3Xu/+qWSv1hMcamuEfoiUiE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed57781c-d634-4d4c-2da3-08db572eaff6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 23:30:23.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkR06dWD9z47EhjJBB8ZzuFGCraj8kTwWRMgkUNi7upkB2KKLvPjhfYlrqhVYNz+F+Cx1Alrnt1YaFESy2XI5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170193
X-Proofpoint-GUID: 3hPtL8p-ix7COoCRN42TlA-rUFDExxkZ
X-Proofpoint-ORIG-GUID: 3hPtL8p-ix7COoCRN42TlA-rUFDExxkZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/23 16:09, Jiaqi Yan wrote:
> Today when hardware memory is corrupted in a hugetlb hugepage,
> kernel leaves the hugepage in pagecache [1]; otherwise future mmap or
> read will suject to silent data corruption. This is implemented by
> returning -EIO from hugetlb_read_iter immediately if the hugepage has
> HWPOISON flag set.
> 
> Since memory_failure already tracks the raw HWPOISON subpages in a
> hugepage, a natural improvement is possible: if userspace only asks for
> healthy subpages in the pagecache, kernel can return these data.

Thanks for putting this together.

I recall discussing this some time back, and deciding to wait and see
how HGM would progress.  Since it may be some time before HGM goes
upstream, it would be reasonable to consider this again.

One quick question.
Do you have an actual use case for this?  It certainly is an improvement
over existing functionality.  However, I am not aware of too many (?any?)
users actually doing read() calls on hugetlb files.
-- 
Mike Kravetz

> This patchset implements this improvement. It consist of three parts.
> The 1st commit exports the functionality to tell if a subpage inside a
> hugetlb hugepage is a raw HWPOISON page. The 2nd commit teaches
> hugetlbfs_read_iter to return as many healthy bytes as possible.
> The 3rd commit properly tests this new feature.
> 
> [1] commit 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")
> 
> Jiaqi Yan (3):
>   mm/hwpoison: find subpage in hugetlb HWPOISON list
>   hugetlbfs: improve read HWPOISON hugepage
>   selftests/mm: add tests for HWPOISON hugetlbfs read
> 
>  fs/hugetlbfs/inode.c                          |  62 +++-
>  include/linux/mm.h                            |  23 ++
>  mm/memory-failure.c                           |  26 +-
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
>  6 files changed, 419 insertions(+), 16 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> 
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
