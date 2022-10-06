Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B185F5FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJFDcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:31:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0F31DC5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:31:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29603mY8012817;
        Thu, 6 Oct 2022 03:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/Es0BetY8f/8nSRuG/IKpchBWW5hW4+no7v7+VxYa0k=;
 b=Bd0TrqCxuPQ8OdZit2WtZPLiZknNXb6r7s7hO6xu4kTJs+jio9BKxIdK8Bsu6pxgyA6w
 r39o89icAp+m5cXSyS5hvfIVnzOvMXT07kmNzhxuJi9hpnd3JYkvnVh6rTQyBtshTJQU
 U9xfGN9T5bS8yx+d/htm3q/4/vZf1VfKDwmC2EqKG/yY6U3/nEQUcgBJjmRfdDNHcuQO
 gBWt3gKFLLSeivUwfyEZQ/qYMxPBaEgjrguWguhoOSzXkg9n4z6o3AOq+AQ39s+JETeQ
 p6Zf2NW1HdorpeP9ChXRwVn838Fri9qK67cQLk+rJ5Qf6orMksAqtbDAu0tBAkInv//b fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc5237eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 03:31:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2960Rgi8005050;
        Thu, 6 Oct 2022 03:31:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0bppx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Oct 2022 03:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntKWqgs//fySk9zZOGI1LQJQ6Az+votfWG+Gw4mlrtBrpPf6bEIZ2pqF6dBqk5WsoOrSznafL8iHZGwJ2GQTjOTraNevBOZuCvlBmc0mI5KXv/jmWZKEoOnqjRCXWoXCaX2S9rIHOwUFhlbkWiOWQbDiRC+a8GqUVUBhLoumsHfcA/Lj0TdWSrHAQgzSl8IFaaRnsnOPmuAlJbw6YZNs9Oq0mwoxCxR5M2I/6zrPTXeBFaxhUoJieqG6IlvJBuLA4+v4s3ytuQNr/KMNSCgIqtd6v+y71rZT446cS32mSaOa1oyUONAAKmcExpOAvcFLeJFdSr/90l1XIjr4lbYBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Es0BetY8f/8nSRuG/IKpchBWW5hW4+no7v7+VxYa0k=;
 b=GrCPsFuvi008y707zfHqQ96jS7Av8V9jM5A053fg4xaOC6ENJeL0/N3Fm4UrR3Omp50Wk7z1cLKo03m7HFcxb6b4Jh9TN+Qd8Vjnd9Ji72xqIG3fJamZJnfE5pq3KY01fCZ+dN8ZvLK7x6nrMPvHZge2b548G/KEyWbmOjPC7lf8LHLjbuqNc1RGVioCBCbx2FjmKTrNIingpa3vqHayCwmCwuB9ORf2plDnzCMtP8N7LjKqVGZtE9lfIFK+vA2loj4cO3XKbdnJ7u7iSEgi/oxpaEQQs/K0nahVMGfbGGHioWhBEN9zHR9Y1sxI6Gqu45gq3Y3T1wMB9mjxnhHA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Es0BetY8f/8nSRuG/IKpchBWW5hW4+no7v7+VxYa0k=;
 b=RVBwTjGrDcpGYxaltoyWUi8dUregMwUBIb+gbHxm4/U2IiA5oMhZE/zqlpG49zPoK689UJnv8qOcbsFewdmcpuAB2NoiDgOSd9QgDJSbenkySX6r2WLcQDPjXXhxEYokjJNrbI2AU2EBHISrMbYYPt55zV7kZH5pyBrLugDQ4rA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 03:30:59 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::7dd3:9e44:abb5:c679]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::7dd3:9e44:abb5:c679%6]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 03:30:59 +0000
Date:   Wed, 5 Oct 2022 20:30:30 -0700
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] hugetlb: take hugetlb vma_lock when clearing
 vma_lock->vma pointer
Message-ID: <Yz5L1uxQYR1VqFtJ@monkey>
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
 <20221005011707.514612-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005011707.514612-3-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dde2fe-e892-4307-9f32-08daa74b2fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7mAQfA+lT5DWgPc0XdpvIZ5IFu7gemk79K12tSW54Lf+e9wQKKbFOk1pXFKyw8wjIpcdPi9S3lmat7chVW2TV7A1XwPS+zOWq2uZu1qTolSw6fgYRaAiFuWrN8aYNvO0VWCI6lGkJDf0qfRbJQ4cZkMIHPtrilQilz3MXoVCO9K8MyeMmwIkru/4rVXA77yLStAi2fER/zFEH0Wzrl5vV52OY9AEgv4jgptW/2wuruWDrIsFEOgzb2z510skkeONmd8k5HTYmZstGuxWx3E1AfniBNI+5d9iY5LqsACcP4q5Nda9kAccOD2rz/oyaNsBWUY7o8lIQzA7Lo3y351tVJTmlzZGLKsKH91IgPPKiHaVYRqi3pjJZddf4HCpnsWdYKlJxZhRUGyRZs/4LlnihCfPGwtcez/y1J18MzYxO9FtHFS5v5Fnd79QF546qvDn6V//Qb9693YW75K1v7LAR2k2mpjVwyzv0E/s4CoW/FkMIxfw4NiGbuUvoJ4iazGTtwuXFRsScmR2qGlY5s0RKUb5D2JosOKBsY5WWcZLdYk1j1nQpEjpniBCB7/vX/AS5ExS+RZSt9z7xPj0zbu1bZwev6DtMKpCQ8/97nWAZYVPnv7ZYWzu/b+a3djOfCCR9jQEgoOVeLmCmwNv5Io0lm3F60PW41K9Jv51Wc+M+Vkw+tY6HHHeCqt5fZytRpvLVbhCprsfDkSJqNjO9l+aDzoQdzdB6YzxqSKqnvmXIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(316002)(478600001)(6486002)(54906003)(2906002)(66476007)(8676002)(4326008)(6666004)(66556008)(66946007)(6512007)(26005)(44832011)(8936002)(6506007)(7416002)(53546011)(9686003)(5660300002)(41300700001)(33716001)(83380400001)(186003)(86362001)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5gNVwYF5hbkzJI5DKpyjZPjxSRKlzVTJw+l8xih+A+bJIr54g+rq2SitvMR?=
 =?us-ascii?Q?LtBXZIcF6i8gIvK2LDrzN1u6aJPyBMH2dliWL6Qzkpqfbri1o4FB1GNgJl8V?=
 =?us-ascii?Q?CLLoNE6oWWGWQVsc3F+wWTah9MsU8kIF2xMYtex66iIdISCGJt/55ys+Jg6f?=
 =?us-ascii?Q?tYg3YfpdQv4P9kmgAur01Nypmzu5WPp6fuyVMwhgEpz4dLanVglXcRFNvTfz?=
 =?us-ascii?Q?qWWd2lO0kIVezn3QPLhc+VvW9ULo0vVFSjJ+zRqy7xxYuqkyEPVoAKDiZ0HP?=
 =?us-ascii?Q?OfDlZUAo/Gmc91NbQKVT6UtrewiivC7mxU/iiTOd91Zxj5Jmr79WgQyI9WVv?=
 =?us-ascii?Q?dZW5/WsoMRS6BgLOzNoM/p9tsEDO2hVvb+hmNM0eY0ETDvNV+3h6nfL3Ruvm?=
 =?us-ascii?Q?BKOjZf4ov0uX6VxvbGUK+hZFPrCIZC7JhJO7ROTg3svw9CEm19QhGqI1flGq?=
 =?us-ascii?Q?1Jsf5Xc9p4zHyPPYuIh53u2p0JRprpUozoT3X75wx4JWMnFDVcnIt99rAObX?=
 =?us-ascii?Q?U141wcIkkKNJoDsE0tTZZa8O+bAOUZPZtr+0FSQqnX+MZfZ97qa5UZ1eb7EX?=
 =?us-ascii?Q?cT0RaSblmPsp1MW1Eqp0ImhiZkpxkMdq4LEMEnbmudoUyXgrmVjUazv51JQc?=
 =?us-ascii?Q?eGfgQVRC/+M+yx8FILnt65Ilt6oZ89eudHj9ke0QNeSpw4Ze82QimKCF5sDu?=
 =?us-ascii?Q?r26aBaTnDQw00rYIl5Nh6CPC0m/kjSra1A5Ime5YeYal2szm/ZR/HT7YwvKc?=
 =?us-ascii?Q?9WloDO0o1SCErtnjTt0o8d5A7pNBIgQW0LlkH6wr1aZ9c/5/WGPUYBKcjiZR?=
 =?us-ascii?Q?FAx0uxHuxeidKKsrJOhPYfS60Lbo3X4LMm0aUXXjgS9E9/MEOg20/d/1fAxn?=
 =?us-ascii?Q?kQXaWIHNYRVxj/mDrDJ4ZPTHBgEv1wZrMv2DC/ev5dIsiAgr4+ZTveOVDMPm?=
 =?us-ascii?Q?vTZAc0XDjRdosC9fmnBQEtLmqAaULn65NF7sj+F4XvpB4NK7yidzHWIV3WEH?=
 =?us-ascii?Q?fHjFH9Is4CN3lPDA9TyUu62VULSBKVtWvGpbAuDZZYoXpJoPLcmnNqJhXrgE?=
 =?us-ascii?Q?HcOX2ENdV+No7Azo5/WaXG9kVNXsco/vEEwvF3jqE4qZNYvQaGQpMTvCDcJS?=
 =?us-ascii?Q?QmqRhs7m+/ZZwTF0lM/Du6DBEVMVvbrFmqWPiDCX3pVLYXUGBYhJCeoenwb0?=
 =?us-ascii?Q?/hhJ9XIU4S7miNEeM6vZ4zdJzMgQcZtRDEgDEM9asTP41+wteb43qUYdpkwP?=
 =?us-ascii?Q?B8onIOouU22qKpO9bx1SHXHphWSrxl154Pjz+aQ1pUVxRmFncK0c0nXr5zN1?=
 =?us-ascii?Q?rfsribFWhvMKQiEcKzGkd8XU/5SrWXLI7XFmm1qCuVKU+JDNrTORoh8C3ecs?=
 =?us-ascii?Q?U9Du0J3pMeyzNhWCx7ClbD23scs6EDfsI0zOpE1MVlcu3hyvQ9yqCPaH8gor?=
 =?us-ascii?Q?jsbGV+gG82hZiVvnMZ24Yl4zHFelYFJwHavy7sUL1FCknCeK95j3tsj9r9Rs?=
 =?us-ascii?Q?vHmNGNFTRaTDsSANgJp8mpwSQBqw0Z36Yk0Oa2KC2JqF/qaHWHRJfcunK18f?=
 =?us-ascii?Q?HnPevtNWFk/txleFKekwt6Wuyisgfa29+7LoWbb/ufsKv4wBP7FP6H5VUtdY?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zR2cjMvuOjl6Y2bXnr8yC75tqB5YdQEe2Oqd5c5XR3qHM0FTmgOFgtgTQZ74?=
 =?us-ascii?Q?he1Iw4xDHJBHQxvUNdAGj0U3HwMjSM0Qx+lYGEUsj3nDmtqPwd9O8x38GzcJ?=
 =?us-ascii?Q?hluJIwXeqDVc76U25NN0m18sJkjNQNOHdafsM7zLKcCb8/OTSKuHu9xwXi2a?=
 =?us-ascii?Q?zX66tW5A53244T0TpGkwbnJDiJ/cuZ2/dIam7/Z9CTpbW3iNPCHA8+6tN3lu?=
 =?us-ascii?Q?G5ycB/lQIJBrcvdnsJDMV24+M+s7Urbx5eVJe5AmbLBXqI8iR+nZTto0IDR/?=
 =?us-ascii?Q?lSj/PwakXsRyOs8PTayeVPwCKz8iDbO04vsSvAWMIf4fi3HcTUMLAzYRfoIA?=
 =?us-ascii?Q?PiPDWFnaJouuwYdSOCS3vrcQZFIlQvquyYra9oeFw6aVZeX136KHHVQa0Fa0?=
 =?us-ascii?Q?QAbfLpjSyq1WBRXni2VkE8Re2PZeIrq6JdNFSKNn/Ysp5ZCp/gKqZXhbuF9L?=
 =?us-ascii?Q?yIlwT4EW8WYwGpayJtl3ByY+y6eQCTbG19cQ42Y7lWlQtrbsae4ePAQoC+k1?=
 =?us-ascii?Q?t8D4hOgYmxMZgLJ//758EdJ5YhwsWx9XlLLAi7cmAfo9Rc2b3rJhLwLND0x2?=
 =?us-ascii?Q?NDCpG1VPSd5gyuJ1J3Odw4/DxrIdVn29egJm3LUJhwnnpHN0upSxosow4NNB?=
 =?us-ascii?Q?WCOvipJGTKOdpzYdApCar5lOD24ePuT4ALtcFsidFSmoPItpe2XYEGRq+4Ry?=
 =?us-ascii?Q?aeYWK2XhBte8qITmF8XJmXw7sFMps5JcPFWTSlqZNoMNjxWKqN5BAEwaj6fO?=
 =?us-ascii?Q?0PVtgva8gFDv7Bni9NNICGpeJ/1h7mJUfOy6KHsTZEpQdpEbr13kXFwxSScP?=
 =?us-ascii?Q?60xEhaLoR9JjViZnddl5OeJINoGxxDsmWMlJAObjIaAtjmPg6Df8f1hI2wUT?=
 =?us-ascii?Q?dhFVOV7LBTkfAtHlMc4BNCGMnd/U/phu2coJdKzN2gBqzHv0ZBwfZ6KUkqHv?=
 =?us-ascii?Q?WbrtOaDoDhRgJOC0Izzb5hROmsFd6QUC7/T/x9iChI/lmNR8jaA4A1ypT0Gx?=
 =?us-ascii?Q?Bl0JSenzb6wIISLfPmSA/e+st3kLZroXV6TmaSJ2CSyOA2XYwi7FOQRD5xjA?=
 =?us-ascii?Q?Yoq9CnToaWmb/o15iBwku9O/2JTsWv5jChw/5aapEK1rIAUEQYdkXsGdLrbA?=
 =?us-ascii?Q?5MhyYEF663RL1iRXrvtbyVHnQoBoqrSb3r3CtTAVLuHil7HI3wTY3ZqUjgE5?=
 =?us-ascii?Q?nLssixNlrISHgq+vDPPL1bicFH4Pr5H9h+PmhmpEXNraQz8uVcmmysQxn3Be?=
 =?us-ascii?Q?j+oZhKqhhlbOYqyHg8Ft3y6z25VD2t9gL/5MSuxNLT/6ausipxGaFCwuPd2a?=
 =?us-ascii?Q?iNy9n6tqs0USH2uPaOd+qbX85eHjLczoRMUADP8xTZddoJiWzxepAOpoSRGt?=
 =?us-ascii?Q?zx+mJpBhZ0SN+TqirlUzvIg1WVR1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dde2fe-e892-4307-9f32-08daa74b2fcd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:30:59.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdceFgKzS0B0y2ZHv7/PS5/UPiO5oKIv83xlB3IaPR4u61vWXpCPsipcmRsBQdcN0OK3k3j1KXcued7f+4gomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060019
X-Proofpoint-GUID: qvfQuOoIA_YHSV_7PRuGf_kWinDCYQf7
X-Proofpoint-ORIG-GUID: qvfQuOoIA_YHSV_7PRuGf_kWinDCYQf7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address build issues:


From b6d359f77d32c7734fe4f00806a0ed1e99925534 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 5 Oct 2022 20:26:19 -0700
Subject: [PATCH 2/3] hugetlb: take hugetlb vma_lock when clearing
 vma_lock->vma pointer

hugetlb file truncation/hole punch code may need to back out and take
locks in order in the routine hugetlb_unmap_file_folio().  This code
could race with vma freeing as pointed out in [1] and result in
accessing a stale vma pointer.  To address this, take the vma_lock when
clearing the vma_lock->vma pointer.

[1] https://lore.kernel.org/linux-mm/01f10195-7088-4462-6def-909549c75ef4@huawei.com/

Fixes: "hugetlb: use new vma_lock for pmd sharing synchronization"
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 38c45aafe00f..e9194ca6d44b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,6 +93,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
+static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -5192,8 +5193,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	 * be asynchrously deleted.  If the page tables are shared, there
 	 * will be issues when accessed by someone else.
 	 */
-	hugetlb_vma_unlock_write(vma);
-	hugetlb_vma_lock_free(vma);
+	__hugetlb_vma_unlock_write_free(vma);
 
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
@@ -6942,6 +6942,30 @@ void hugetlb_vma_lock_release(struct kref *kref)
 	kfree(vma_lock);
 }
 
+void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
+{
+	struct vm_area_struct *vma = vma_lock->vma;
+
+	/*
+	 * vma_lock structure may or not be released as a result of put,
+	 * it certainly will no longer be attached to vma so clear pointer.
+	 * Semaphore synchronizes access to vma_lock->vma field.
+	 */
+	vma_lock->vma = NULL;
+	vma->vm_private_data = NULL;
+	up_write(&vma_lock->rw_sema);
+	kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+}
+
+static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		__hugetlb_vma_unlock_write_put(vma_lock);
+	}
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 	/*
@@ -6953,14 +6977,8 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	if (vma->vm_private_data) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-		/*
-		 * vma_lock structure may or not be released, but it
-		 * certainly will no longer be attached to vma so clear
-		 * pointer.
-		 */
-		vma_lock->vma = NULL;
-		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-		vma->vm_private_data = NULL;
+		down_write(&vma_lock->rw_sema);
+		__hugetlb_vma_unlock_write_put(vma_lock);
 	}
 }
 
@@ -7111,6 +7129,10 @@ void hugetlb_vma_lock_release(struct kref *kref)
 {
 }
 
+static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
+{
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
-- 
2.37.3


