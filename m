Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87D64529B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLGDmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLGDmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:42:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE72726
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:42:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B72JPHG029952;
        Wed, 7 Dec 2022 03:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=uIIh6dYzcuSXSy2VyFI1vsWQ3WbteS10gnTcqOwRJhI=;
 b=W92hGUVqjjrkuXbMxhmNCOso6PH2nIWI5fZo9XWQT8d+X8A01gCQJQCv5nBYcuPkvZnE
 Ysq5sxcWnN7YPX+bCD/7CbZLmAZGAgH+vW/OFAGCMRYD4Iw5Hw5DVTVjcZGL/Mc6TYF+
 rrl/DyHojKxPU48LjdHt4RoVWX6ORDD5aipnVl2Av1RMF7lWOgQr18vOKLTbg6tCPmXF
 /RVWSa6GSP+Yg6D8jl7dkA8wL5DYyBsCeDh63WpO2uMmcnQdQIq2R3slMYs7PQHOM1pd
 CrLtsHO/yk2Z1E6pg0qW+HhXwJ7t1HAfA3dv/akEQgsgdxk7NunmIwofpjlXxH+dqjpx gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgse3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 03:42:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B72HNAn030680;
        Wed, 7 Dec 2022 03:42:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa6859mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 03:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU5O9x45Cy2PNTno/KFbh7dpAIt6pMb++bdtCWTSTDHwjW884Y/eKgHq67ViwkUCX3rEt1Pn3p0ctXlpBrQ+Rjma9cs2Jao8R3T+2vLMM2+OG8KKaOiuh3yqpaYJ5K8hpnFQ2qutGsSDZkg3xiF8zGzRdZiuE2wAeJa3LyKGmFY3XaikGVkN32IByVUXVYIr9xgtLYuxyv/46gp2iPNsAGMHY7qQxAZKrB5RzXGe6SUzfp8t5ifMEsOjMiDbre4bdhXBcuW2Dzy60n8ALgdhAl9VQo3Gu8j1wVYbfXlkLM6HMqq0G3pmhti32cZ3p9S0110hNNvV/0EPhtpMmsGN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIIh6dYzcuSXSy2VyFI1vsWQ3WbteS10gnTcqOwRJhI=;
 b=aDMhlpV5SLlLPUfNIXc96RmazYh12F3Qw+oM2ZeQXKOGw2Y0kYkf+fvdlxrP44bWpma95DTfNo0mm5BP7icMzP4ywCbrXLpbeWdHUS9oez1LtkXGQ/BTRUkCDraj3GQYeTwpChba1ptE8umYwbiJZf/wuo5cDBm4GoRuOb6DsJiq7Jnzh2/42F8GVPWJcPVsl1IbD/9ye8FCT22X0xx4K1fzQlpWD4pXBdTS22s5lr9FFJMXjhffjVxr8o7oZEOSudoKZm41zwMBB6/D5qhIDryn1YaJt7tJTNWgqoCzmndHo/x29Ig5d4Xq8jLy0WCOJmhh5hIGNCgulvL4yZ/UTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIIh6dYzcuSXSy2VyFI1vsWQ3WbteS10gnTcqOwRJhI=;
 b=V49/hmXesC3jJviwb8JIR7FizXOn74f3Gu3V96OqXkoMtODmugXOVfnbRD8mUqzNCSHw0m9lYUN12O10KX5ubguHRbMw0ZN0F1fXW4+EPq78xmvJ613P5Et6EHnfBczXAMINP6T5ecPdzu/IiVMHJ1EZW96k8WS8tldFO5iXrTo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5002.namprd10.prod.outlook.com (2603:10b6:610:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 03:42:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 03:42:06 +0000
Date:   Tue, 6 Dec 2022 19:42:02 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Message-ID: <Y5ALigw0kUO/B3z2@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev>
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5e748f-de21-40d2-16ac-08dad8050254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhZrJZqnoZv8wBpT6LlTdczDLAn2R2/HvAaqSU8M5dtJaHTHwDqdBxL/cOJhS38dT9xHEjQ5gfNxWqdQHDyn5ExGkNY51mQsxHKhSqLkQUOPzLzNsEYnBD0uSSE1xwZMUWG7HJOVDbzUy8djjxYBu7f/xotAOyiGB2t05a0YDcnh5XwTBRd931EHSElR+gMi12ATRxt68/yFT58jNPe3677tygZ8btTpLizRmTUypEd0mKL0wlNtK1oj3FUPh5A0okYZjM9EBsMEQ0P7UKRbiScQBxgnfDAlVGZ3bvNwc8SMSI0qYwGQJUpw1vLSSt1OSGskuEItE2VrjXi5NXjzcyyqtT79Y2axVFOODSIMsIxbm6EHIOnW6ik+lFXwALvXlKfPjQkK2mIJP+fiQzvJ504s6O8+dE6shW/3w1yEzLzN6zASCXnzNV6hgn4PmLSkUVddMKwo9Ar4KWhT6mXumiLaehmOD29VixY/ZCkopdtcBV458biMuDVR0fqT06kaTmcs0hf7Os9dwl0RHVdTLDjKrr2IgObjJ9SReAupGszD0RNMeq74mvW8WIHvHUfoptNqsNszMtcet8FB9xYPIeTj9SfkXtKoLVBrZbmm5AUGakb0xXfl+sgw9lTIH0jBvnF3fu8ZGftj4Tqxg2oPOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(2906002)(83380400001)(66946007)(41300700001)(186003)(86362001)(66556008)(33716001)(38100700002)(26005)(9686003)(6512007)(4326008)(44832011)(66476007)(5660300002)(8936002)(8676002)(6486002)(6666004)(316002)(54906003)(6916009)(7416002)(478600001)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sU8szAHgf4mqS1fGGLRmixxmyKBbzNrKkVp458QMQuLsDLjTa6XiEtJFsXrx?=
 =?us-ascii?Q?BIZHhz3joTjx5EwHPwf0tBKTyR6UYyIRXV+wIK11FsiSF0ire6Air41ibh0E?=
 =?us-ascii?Q?QwONzorSRFdq8WxGEy2xJdi3uWe6Zp2eYTVdnVZ6k2mI5buJhCdf/XD0zyxg?=
 =?us-ascii?Q?bJQ1khUGoCsjzSYkHeEwKY4iIRn4J+8feNGFbKsJjbSw4mmSW+Lbz8PlldSK?=
 =?us-ascii?Q?7A77TU2bs5VxVMBxPKiTV0UMSnddQ5+v89dwF89Y0ovesl8hWfHgl6gIDWzr?=
 =?us-ascii?Q?/27QZHg8XJo80zgS6pSnhQyqqsdkLduj/tXFOYmPPWwLmalzPGVO1p/tJahz?=
 =?us-ascii?Q?tDfO8rCVTZ07gHoRib8MTEPqEMbaUIVyETa/h8l34nz3T8ssTMjAV1K1bfGp?=
 =?us-ascii?Q?X83llnP036S3m2ZRDBflBQ2kQAKxdHReSxngvFmn4A4+s2Mh0vIAvvjOAwt/?=
 =?us-ascii?Q?q95n1Fs7Vo//NKFvIU4cO5ioMelt6Wj9i+Ns1oQJqE4MOTR/ds8d97IElhbw?=
 =?us-ascii?Q?DbXaxnpxEFDTB1LzVamMk9HLH6B+72OJ1CDfx/wJ93RTOP+uB4i7HCOSNjtq?=
 =?us-ascii?Q?v3InWJDsBukzI+E45VUgEBnaLBdRBtGt7m/OfFjrR5y0Uh0d/2HCwPAb7zQO?=
 =?us-ascii?Q?OofGiIQfqqNZN4zE+9ll42OIYMvTARi05uTTgXeCWR/r2LV6t1RYc0xnqUXV?=
 =?us-ascii?Q?HI7jHUVjG0AnUuk98wIbExSHtE18bmSTErysEsP88aZmj9LPRqlX4I6G9Q7/?=
 =?us-ascii?Q?H8/48B6lWlTejjAgGp1FM76SMjbFHxAMCLESzKYr6/WNlgoqC/ShWlyNFO3u?=
 =?us-ascii?Q?9SIrME8zNNGLvXyvjzvC9DfL/vlwuN5NhLV94lByf1L6+5CKDi+qlMlvxcTu?=
 =?us-ascii?Q?wQ6r33vjZ0TtsrNBqdZ6QcEU5fAIj1rKM0EgKx8JJZxRH5sVVbZEzTJGCJnZ?=
 =?us-ascii?Q?HWleR0x8VmnsE13swZR0egckMC/vnPac1RdlvFDK5Y+5tvSqiUMcJzlchB7E?=
 =?us-ascii?Q?xtlPVKpLK25clzqXwydzi4Pp5/KzIxrnRu6HU6VrTNNh7vQyimqeFr4aedTu?=
 =?us-ascii?Q?4u1bIphee/rFTpJWOwNKEvf+f+60QNiaDhKPNtelC4E46gNqf2nUmn8+kbTN?=
 =?us-ascii?Q?9RD64ugFa58sgQ7gkkmQGMCIh1XbjteW4F0t5FMIrNHdqepV8RvLc191zgwm?=
 =?us-ascii?Q?wn5BxHgF7ge0uMr7gyhAnd7YKmCknr40l008lE6dHwHu8CwvZrKec0nQqSvx?=
 =?us-ascii?Q?QiBJNVQj/g4xJpfX8qYspIIU8lL47htJsZZ/iG5JWWDTArAu7/cT8GQ7otfm?=
 =?us-ascii?Q?EYYnCjaKLfo2AkBy6UehEG00htryGjxYeIg9MfS1Jp3+keTxfJ4lviThWRFl?=
 =?us-ascii?Q?9krDGSpYlhZcMNnXKoITpg0d0vUzkvpukri+2NDrx+vb466lZOCOAsW0ZLGK?=
 =?us-ascii?Q?zCcIRaEILqQzx+smNtMMPR07Mh3/doXoJBSVniziFxC7BCS1GglhpkoIq/l3?=
 =?us-ascii?Q?sjPo35Ieqq5Jpt7MPddFzCgDnmSuegjhzjmrrm3BvvcUeWtSuThprpt69YJH?=
 =?us-ascii?Q?zs1/YGLRggrx7AVsbw8riS3f5RYV1iyfK5fFvocTGVtiOX3uegLxDEP7Xs9G?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tllLrontud1FEhw/Ee6NNRq6PfcvasM/yEB1WOZJW7Qi7qGmWt46xCi5qyuQ?=
 =?us-ascii?Q?FuO/VPCuWkiRsVemfZFKe/u7NkAqOnUuAotQcAy7wWQQr+GW9UcRJKNglZLQ?=
 =?us-ascii?Q?wZyE+QSBz6FObTxpM1a+hpGvB1AYM9H4q+n8ffD/C2X/Gm2P3w0wiGMivFzY?=
 =?us-ascii?Q?hmu6roso1FgrmBok5tO/XQShdBd14Dx3dCw14eyhepi2pc5hBSIm5iYzoQ7j?=
 =?us-ascii?Q?J/yFuYJBrAmqG6xZSVIPbELm+vje8eHVOH86uMHzpQf42AdTTQBgRAl8Lz/H?=
 =?us-ascii?Q?aaTIuYHOehXNHr4iHm4y0Yr1aSb8dIIFvseZ7HO42DeTeKyZPOzi3Zj66XnN?=
 =?us-ascii?Q?aGj8DdwCsOPYmahzQXApRS55wyBFOqhX3+0WFhPYalrHVCmYiOeuVthiUe3C?=
 =?us-ascii?Q?bK13RywmtJZT+0n1UrTUtZhq5cnqCK6NKEiLgnOrP3kCwOByZj0L+KtB8MzR?=
 =?us-ascii?Q?LbziRowY9UFNLPvXBzRamWo80Nyo8aCojXdVCG3W7TrxsPX0HjV4NfUJEOR0?=
 =?us-ascii?Q?Rd4aShsVWra3u+BKldmcnpLEZyisneIivswZeod3OsN7yhU1yYs549Erxmg2?=
 =?us-ascii?Q?UV0wTYozxzlgeFFH5uEEan6BulpYC62/PjKW9o6bpNjecN1sYmh+wTFaCteh?=
 =?us-ascii?Q?yIIidwokKamUC5Dfc8nmOiT3cciPwBOGlmBlA0skpNqE/23uEc+hJEV0LvQm?=
 =?us-ascii?Q?LhRP88qR/0Q3BYRQhYn6PD2kaR5mpjOBn0OFJnolEKCR2JVRwBnwNBTZTi/N?=
 =?us-ascii?Q?nhnhyuiqfKZRswNKRZE0Pg9hpj7ZfMgvyb+AnSP2ggIzKeETbb0aGzyOyi6j?=
 =?us-ascii?Q?L21tif/UknH2Zxa/FBHrMnl4t9iQZ+b6zUz0uKqp1XKf5aEWB+bpyWStBfyI?=
 =?us-ascii?Q?TWOtGB/xdelUsAs9NPmgMiddBR8TJjG3EI+2bdFi0rlShgeNkRnTZEq5spAn?=
 =?us-ascii?Q?VNCAI3n7ZEGhG9UcoP/nKeZ8EhTcA5Dd7TqFAQuGLNNkILg8egNTcdSr67us?=
 =?us-ascii?Q?pKCF4hircJRKHkZzJzSjrzNMbAEXw8BElHlXQcT2iqr4gu1/J1EM/k4r0Olm?=
 =?us-ascii?Q?I1ikSZ8K7VBIFywkIefCpSNDtC6q+GeiGzUztgjKf7awLVReOPukHCP17G6i?=
 =?us-ascii?Q?SQVZ8RSGeDYd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5e748f-de21-40d2-16ac-08dad8050254
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 03:42:06.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03kLghgBWH/8CzHuFbOdLTfxws+MPsGm9kUUdjMbBaK3EGbXfs/dcjpAH4p8zfwgmQlRjgf9CwlMFRPehOEabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070025
X-Proofpoint-ORIG-GUID: sLkfrpwV3qQ2qzc08JHSSOVuPgn_d5aw
X-Proofpoint-GUID: sLkfrpwV3qQ2qzc08JHSSOVuPgn_d5aw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 11:34, Muchun Song wrote:
> 
> 
> > On Nov 30, 2022, at 06:50, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> > 
> > Add folio equivalents for set_compound_order() and set_compound_page_dtor().
> > 
> > Also remove extra new-lines introduced by mm/hugetlb: convert
> > move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
> > hugetlb_cgroup_uncharge_page() to folios.
> > 
> > Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Suggested-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > ---
> > include/linux/mm.h | 16 ++++++++++++++++
> > mm/hugetlb.c       |  4 +---
> > 2 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a48c5ad16a5e..2bdef8a5298a 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
> > page[1].compound_dtor = compound_dtor;
> > }
> > 
> > +static inline void folio_set_compound_dtor(struct folio *folio,
> > + enum compound_dtor_id compound_dtor)
> > +{
> > + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
> > + folio->_folio_dtor = compound_dtor;
> > +}
> > +
> > void destroy_large_folio(struct folio *folio);
> > 
> > static inline int head_compound_pincount(struct page *head)
> > @@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
> > #endif
> > }
> > 
> > +static inline void folio_set_compound_order(struct folio *folio,
> > + unsigned int order)
> > +{
> > + folio->_folio_order = order;
> > +#ifdef CONFIG_64BIT
> > + folio->_folio_nr_pages = order ? 1U << order : 0;
> 
> It seems that you think the user could pass 0 to order. However,
> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 pages.
> You should not touch it. So this should be:
> 
> static inline void folio_set_compound_order(struct folio *folio,
> 					    unsigned int order)
> {
> 	if (!folio_test_large(folio))
> 		return;
> 
> 	folio->_folio_order = order;
> #ifdef CONFIG_64BIT
> 	folio->_folio_nr_pages = 1U << order;
> #endif
> }

I believe this was changed to accommodate the code in
__destroy_compound_gigantic_page().  It is used in a subsequent patch.
Here is the v6.0 version of the routine.

static void __destroy_compound_gigantic_page(struct page *page,
					unsigned int order, bool demote)
{
	int i;
	int nr_pages = 1 << order;
	struct page *p = page + 1;

	atomic_set(compound_mapcount_ptr(page), 0);
	atomic_set(compound_pincount_ptr(page), 0);

	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
		p->mapping = NULL;
		clear_compound_head(p);
		if (!demote)
			set_page_refcounted(p);
	}

	set_compound_order(page, 0);
#ifdef CONFIG_64BIT
	page[1].compound_nr = 0;
#endif
	__ClearPageHead(page);
}


Might have been better to change this set_compound_order call to
folio_set_compound_order in this patch.
-- 
Mike Kravetz
