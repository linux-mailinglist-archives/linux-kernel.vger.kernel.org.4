Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825535F4D50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJEBSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJEBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:18:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA736E883
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:17:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294LO2RH014900;
        Wed, 5 Oct 2022 01:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Wk7W81Wrvr7gKeTOV5ZL5doCE7rJAPEEjcDcBTrrTR4=;
 b=qeB1TJ9vdkhmgyTpMKdy5Shv9kh/rLI9vzZqWLfYwWf3qPKVP2pdEo3XFgbUkK6zUScG
 hb8+JArqPtbbD0p4tGQqMc01o5u5xIdlWzxwu5pOuEMmahapAI4SQbcc9z4UjRYSXUv3
 ccdh8aUs4pbBrld1sdbEKwGJBedhEtrJM//MtzsbmZkXvvnLqqOTQ02yw2Jr2bDmrgFq
 uVRy+SD1RC1m57TIKgs+r/sSONHl9c4M3ovgu5ZzTdYpueneK5otJJ5XG0jKaIljIDZ0
 aHlyRql781MhL8VATaB1d0zYXDv4MLxHZRvhLuHnBA/Znqot7Da2fyV4scKMxpcD1SPT VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc520bur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29515l2B001159;
        Wed, 5 Oct 2022 01:17:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc04y7q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STGxV/LqBnAIUcsXosFA864CrfN8clwDmoktYhFXlLlVw46t/IYTLeJItRPAmNVV4rm+63irKVngONnm4fRBdVYjz6VkyxHNelo32YBAF+ds1f8hEhJHQR0QHdkeiBohlKX/qpFvFO1vY3NPQWqzzMoSyOp/rj0duG8Nbf/6agMVIidXP1yA1PyGbSsjk20LpNiZfxtIHO0RMw4k5bLUFiOxihlY4u1JkH5VcHqWeb3dQNsjfwOl+CMa+0xo9fd4x6PvLcBGvymuBjvZ/UirvGfs5lZTH+Ut2r0VOsH6Dn3THU85wpyE8wG2LTwRbu+7lvJXudXsErxmqz9v/Rlj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk7W81Wrvr7gKeTOV5ZL5doCE7rJAPEEjcDcBTrrTR4=;
 b=IU1rMBF1JEe9aW3wdjPcdYFogaCCevQa4M97t6EPl4pK/QG5Dygv56IFiWx/zyGdy/usX6Id84Jlx80f3COhnF85XmRF4jk53dZyElsJLz5M9sct8If0NCVU+Tfo0wAPQ8CRGTR5lOVZFCWqwOtZT6+vJtw+FMyutQttJxBiCkzQtrQBhL3YdDBN0yp9RwXltncH89e+B0detBBvDoJ2xMs3IV1k2XPwfaJ4EEL2lt/exoJ4yWoFEFheNBXATV/RTLwzRuIe7hz4fVmv+pZUhMXER7FVNeFg/b+/aHEWTG0suwK3Nz8tc95Zxl+IB1OavX4U6XiogH89XpIvpeot8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk7W81Wrvr7gKeTOV5ZL5doCE7rJAPEEjcDcBTrrTR4=;
 b=eqoJixGWfVjA5og7e3LOOsYlF9D/N42tzQCINUIl/HKfhCmUIvNdItE+gp/WAidVFSLs/sPWi+xK+fHpdm4CcmVMn7slnQpjUf4jx3e4s2boI1w09WG/D3M2yHGOKpRRf/00OyD/lTb5bV9FILH9o40tbQ/fyl389VT5OQVMB8k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6286.namprd10.prod.outlook.com (2603:10b6:806:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 01:17:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 01:17:19 +0000
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
Subject: [PATCH 3/3] hugetlb: allocate vma lock for all sharable vmas
Date:   Tue,  4 Oct 2022 18:17:07 -0700
Message-Id: <20221005011707.514612-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005011707.514612-1-mike.kravetz@oracle.com>
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad8d9e5-4f49-4be5-3736-08daa66f5925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HjAIdXD7A/LOBGJMFzwWE9z5WgKuhN8BRPwlve0iHDJ1p8av+I8BdtqGtzEHtTla7VPqKkqSKAo6vEI/EgT54npW3QapfXRlo1rTellaG32fM2y+bUysqNAuloNLTirmGB1vfgB4Sjf6yTu6mzu+t60S0T7m7FcXdRWBKJ0kdNMR9WHANOkqsB43s2BpnBQhdXemXK1X3ut7mPi1rOFfv+DHvKuyOTBsyGorSNHwFcAQgUsh0xJJz8CHhtF0hi86rGw/cvG/7QDhPOvvxQ69QAos4zkF9kdrD8lsLqLDw8PpEtePV4G/uuNzQGAD5pMcJfTxpDBZZiRr5tng4Rce8JgJ4vBlS2IsRLWinKlfiidqQfLPMGElSZ6XIHvfAalhPFX65hQmgCiu6clkF9xcm+teJz7FeKW1kUl+RmOgsLhr/d1ZWPiRf2bdYvBs35BdQUuju/c7+GLpTC/qZwVzddS7wZyChBWtk/F6pwa1drZQLfvSx6dOvpNRg2g5wfEZ8+Eh/fkCQMFWYVQ3QU0qvAkhSK2Zo6RNg0+ynPA+oddVJ0q6mkZ4mE8Y2jWGD757bHCTuubAa36A5g1SY8MU3F9hKSP7xBJmcNJExMjaC5zYqID7yofS1E22tVe+fTYN0UNWA5gnpPDyKB4wSWsXnPCOZZY0GPq8Udy/CzYBW+qOVWcLAqXKhNOBHt2IxHp5I1wdDLtBfAisG/1YD35uI03D5bsG1jJUPj7Yti8/NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(107886003)(6506007)(6666004)(966005)(6486002)(478600001)(66946007)(4326008)(66556008)(66476007)(8676002)(36756003)(316002)(54906003)(38100700002)(186003)(1076003)(2616005)(86362001)(26005)(6512007)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1bhxN+h/RIE35e3u2spfex5P1znBY7yHu7Sq0y7wcGxzUzc0t7OJ9YFXwGU?=
 =?us-ascii?Q?u81vqsvdj5NohIy+445wRB8dVefDyFjNoZla1FROjvip2Ajg+MxenFiut6Yp?=
 =?us-ascii?Q?D22wXn3A876UrQzu6/Ya0rRuIKrmvDDHikfMBlOwt0sx0vpwiBws5QtKiGWw?=
 =?us-ascii?Q?LaMJn5svIjp9TDK42u7xvijs2qI4cMql2MC+MgdcBeAP9/VVPx1Vq2YUGEc4?=
 =?us-ascii?Q?T/Muy0JeVHnsi8w2Q8IkDtfYffmOme5vjJPzQOofARoepLYp9VmYfudfwlTd?=
 =?us-ascii?Q?VSHfWAjN4Vr8aTSZk/F1AYrWZrFWkFz/NPtNeOVJog4J1A8AWwUV6zSIBHpY?=
 =?us-ascii?Q?DK/ke3z0B3063XQVnrFRA8bmnC2vx45LdHDjQ14kLf2Rk1sTwG+vjHOQbdyl?=
 =?us-ascii?Q?VL97sEEjHfzHPbVCIxtCj3z8wUZdKbPrl1Mju2KrwliZT5yvgh8NP7hOwx8C?=
 =?us-ascii?Q?EPn2lwCeuF6qtbwPeaK8tIcj3+OC+FQ1/qp2x+VGHCozgQKq5dKiy6YRQhBa?=
 =?us-ascii?Q?2Fk9TPJMHvpR8fsxEBJSz32F0z+J8vgqfwOP4i8yFWrz7scllB0oZ7eerboD?=
 =?us-ascii?Q?fqqz7NzGTng4diUoG0lPCTbjpBsh1GICjCcnlOYw4TDRd8zGtSzycfP9XtbC?=
 =?us-ascii?Q?61Pz7BCcj7vYSaE/JQsshjTUd+HdC5LpjhvytHF0oWpBRB3yslDN8u1ZmvfK?=
 =?us-ascii?Q?Ie6A+hy6fS/0fTLghRsp1hVjUKHJ+fb9OOnvv47cWjKN1ag5eqnH5IxMGgTb?=
 =?us-ascii?Q?VCfUvvrk0l687A3aMYgdvq1cpQ18Ugce1Fj6jhne9V1ZIIZplIijzcTmm4VE?=
 =?us-ascii?Q?SbGiHcpq3+ECK3Tt5RpeifWkevRGCNtk6ziAAgMSBbnlrSWf01IKQjGmG7ws?=
 =?us-ascii?Q?iYYzWPMgM5HxzOfCyw9I4N2lhcX3gyXfUExBxI85XWzQMDbTS4E/MeirMMpQ?=
 =?us-ascii?Q?i8LdsqmoA8PNpNFAqNEgm1SHQNdU5v59ZWA0t9Vo17BW/SwXjKnYrPwFUL2k?=
 =?us-ascii?Q?mbxUiulU5XXsfzzcPEZ7JYdvUK3uDusTVlpVdTQB/yS7R1Hfp7K757VJJx55?=
 =?us-ascii?Q?ue+EGqwfnrB5cPCBm3scizfinJ9uSPFtMkLtlUa8ZhIdspqZP1knHyQulSuH?=
 =?us-ascii?Q?aJZfsbNb9I2b6kFm3lCXQbKYuP1A4ocOKufJJ90v69ym/LgsCoGU1J21gH6K?=
 =?us-ascii?Q?qZ+eKx1GdixvgCbahaBYqXWx4YdwJQoo07rX74jqo6w/JZnGOZBRTGGtQTnL?=
 =?us-ascii?Q?qCERkWoHfL7I4RhfLRjVE8XmBh0iWMuowrCvEE/rttt8KVqIZZMyNBnZdg0L?=
 =?us-ascii?Q?uRyM+jIHR+1JUChFWaimpZ+D6LypEc0zsfTL/SM7wcAB0oNsJOIxWG6quY++?=
 =?us-ascii?Q?x64+eIV1TtEH6wSKWkphdv0zXOAwR4mcXTxhpq2QJaWlLHnsYW4DCXIIC1gF?=
 =?us-ascii?Q?SAb+iW5SUumTRAEHoOuIceOIfFcxK9YloAqBWxY38Ahe1c/j31oHdV+hZlb3?=
 =?us-ascii?Q?mLVXMxALH72UaqxN9rEEU0/MDGpUyL+SxE7gXR7/TDMFJUKFBto0/3mFwCMQ?=
 =?us-ascii?Q?kTqkKx6CjoeP+TnE0bY/5MJc0BqWgxPamMr+HV6cldEFkeafKX65RFx+hdKK?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C8THy8pUHXdTymYEXh7R8jBp1BMOTBXUMLmjDDpNbF0owdQ0AHZJzl28RlFa?=
 =?us-ascii?Q?kHU8Y6olIrZ3UbVH/joa0e6FTBhQKVffkjb9XSBnwkiMRW/nC3SQvyrPoxWG?=
 =?us-ascii?Q?vllmKHTqBG5n6rAgM2U3fkyfub/EJkZWBEMd/Uk7I1ikAJI8RPM1qCDiuiBY?=
 =?us-ascii?Q?xTGBGquLQhxBJP2A1OKjpdqcFgmVL+OS0DPWPVWu5gQ80TRk3zRJQ1VrA2AJ?=
 =?us-ascii?Q?LjowA+b6QhhvViBNtdgKFGMWCFlRrSeABwaVVtVPuieGu2W9QgsMZZLZPlso?=
 =?us-ascii?Q?9vMxZ1s7UZDcyDs5PSu1b+IA7VK9IvbJmT8KdCu21RQKKLdlDSY4V6nHQ0mR?=
 =?us-ascii?Q?fFEiRDGBw5GbgIPnAAX+l5XFJUm/naOY2/Kr8yXgMlAis/O2RMnvqc+RcoQg?=
 =?us-ascii?Q?lKhIC7L2h9bB7nYCmeDDLUEujWPpYPuTUPmvJWkwDBLyq6v0RankWtH0HtuJ?=
 =?us-ascii?Q?a5kzkdPC4fYC2Tu6KH5sYLadTfK1iSkBkPv/tnYQmksefpmU/CzBvsu9CmIi?=
 =?us-ascii?Q?03PUwkJ09f53p8LTOAI6wbjhvrH5vagG3/TU8vrDDnfWyVD81i+KLJ5lbnCW?=
 =?us-ascii?Q?MX/i4QGFlqcAcYidridkpCDVBSroYj8Tfem6RdpG59tJf1NnsCI3BS3R+qqB?=
 =?us-ascii?Q?yIaQvmjIKq0zY93HPKrRi6cUuEVbSjyn4o28JhlSUZpXWn+apgLjDbLJn9vE?=
 =?us-ascii?Q?8lM6QtCmKyWv7MDnuXxET4v/4uxJxs7fA7qqnUAwYOFFCcMdD1xLcQR9M2vM?=
 =?us-ascii?Q?TLAv3BV04oCLws4E/OSsy3uiPa0Ym5ujqtD45KQag7PciDItKPkorrBY0hGl?=
 =?us-ascii?Q?X9cjQ5rd9von1Yku2GbrxKEGDQZ1MNuvSzRV7PLIZ4VMCLd7F1VGm0wDsLf5?=
 =?us-ascii?Q?rnZVuJmdF2xhNCNitfbb1t/GQeFCsrr+uSryfzUM7Esugu6G30LmktxLPk+b?=
 =?us-ascii?Q?/1eS+EzCKLUAbqLc9AsBDUpTvV+kHpEfprXIbHXbyhvIKDEpcFRUDceiInvX?=
 =?us-ascii?Q?+VrD8x7cz9RNgiWlDELVRpLyR6WssyZp0P/uIz+cYoYKCITHLnsUdqpaPyxC?=
 =?us-ascii?Q?n8jhCvm54CNgr+TxzQsszhN5WH/du7v0OkZfX/hr85m41iMea24uEj4uT5SN?=
 =?us-ascii?Q?jnivIEmpgePIPcoI2aaRjyzpBBFGyu4jcNmvACDsk6jtY8EpfAz2V5RdvV1R?=
 =?us-ascii?Q?zLmoRNi/DOD5i54g4yMwq6N9t5icym2Ct9sTIWnuSGu1ZBGTffNECpcG1nWs?=
 =?us-ascii?Q?HVxakn/nM+7jv7hgp6Mv3AkCCp60UO3HRd+N0k8Z1BYeTDgUhMIamR3j8mtL?=
 =?us-ascii?Q?CKXIg3Ml1qae848h5u/G2ZKjFK/4V1I+xjhmHUQ7GCeOqIe6wuazewJvXJvs?=
 =?us-ascii?Q?rlrkKTNidT5mITDFMJ/omyUugPdYzF1cE3DGPXM4wLahxMSQaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad8d9e5-4f49-4be5-3736-08daa66f5925
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 01:17:19.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju5CXR1iykr+WlePR9fJwYpYW6+9CjaALzaPxgB5dN6Ha4KDzQ71HjpYT4RvkdEHOu9DadLLBkDR3DwaYE5KuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050007
X-Proofpoint-GUID: 84aux9AHc8WNe3uvZo_5ET9QKmPjKjyT
X-Proofpoint-ORIG-GUID: 84aux9AHc8WNe3uvZo_5ET9QKmPjKjyT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb vma lock was originally designed to synchronize pmd sharing.
As such, it was only necessary to allocate the lock for vmas that were
capable of pmd sharing.  Later in the development cycle, it was discovered
that it could also be used to simplify fault/truncation races as described
in [1].  However, a subsequent change to allocate the lock for all vmas
that use the page cache was never made.  A fault/truncation race could
leave pages in a file past i_size until the file is removed.

Remove the previous restriction and allocate lock for all VM_MAYSHARE
vmas.  Warn in the unlikely event of allocation failure.

Fixes: "hugetlb: clean up code checking for fault/truncation races"
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
[1] https://lore.kernel.org/lkml/Yxiv0SkMkZ0JWGGp@monkey/#t
---
 mm/hugetlb.c | 50 +++++++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 388a32b089bd..593aac995911 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6753,10 +6753,11 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
-				unsigned long start, unsigned long end,
-				bool check_vma_lock)
+bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
@@ -6766,38 +6767,13 @@ static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
 	 */
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return false;
-	if (check_vma_lock && !vma->vm_private_data)
+	if (!vma->vm_private_data)	/* vma lock required for sharing */
 		return false;
 	if (!range_in_vma(vma, start, end))
 		return false;
 	return true;
 }
 
-static bool vma_pmd_shareable(struct vm_area_struct *vma)
-{
-	unsigned long start = ALIGN(vma->vm_start, PUD_SIZE),
-		      end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
-
-	if (start >= end)
-		return false;
-
-	return __vma_aligned_range_pmd_shareable(vma, start, end, false);
-}
-
-static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
-						unsigned long addr)
-{
-	unsigned long start = addr & PUD_MASK;
-	unsigned long end = start + PUD_SIZE;
-
-	return __vma_aligned_range_pmd_shareable(vma, start, end, true);
-}
-
-bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
-{
-	return vma_addr_pmd_shareable(vma, addr);
-}
-
 /*
  * Determine if start,end range within vma could be mapped by shared pmd.
  * If yes, adjust start and end to cover range associated with possible
@@ -6946,17 +6922,21 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 	if (vma->vm_private_data)
 		return;
 
-	/* Check size/alignment for pmd sharing possible */
-	if (!vma_pmd_shareable(vma))
-		return;
-
 	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
-	if (!vma_lock)
+	if (!vma_lock) {
 		/*
 		 * If we can not allocate structure, then vma can not
-		 * participate in pmd sharing.
+		 * participate in pmd sharing.  This is only a possible
+		 * performance enhancement and memory saving issue.
+		 * However, the lock is also used to synchronize page
+		 * faults with truncation.  If the lock is not present,
+		 * unlikely races could leave pages in a file past i_size
+		 * until the file is removed.  Warn in the unlikely case of
+		 * allocation failure.
 		 */
+		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
 		return;
+	}
 
 	kref_init(&vma_lock->refs);
 	init_rwsem(&vma_lock->rw_sema);
-- 
2.37.3

