Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A86A255C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBYAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBYAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:10:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B7D658D0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:10:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OMx8uH003589;
        Sat, 25 Feb 2023 00:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8jee+nZpHfN84oObiOcRq31HDc+00cjTjpWh+hDMDYo=;
 b=BRjXFarqryd6TtO4UUKo02mbbdJ1Tb4LlrhnrpL41Waal8moT2l3TkoHxw9iw9pN/jFb
 tPAjg0e4whMV08h5azJy732llpzagf/opksmB4dru4J6757i0Cb9bR4tJRtiQkxCptht
 Mxip2l06iJc7J/OJW0JLuxeCsM9FFR0CIMwEG7Ou+MDTWGyBoMk1qtUUIl3pyWDzCTUR
 DUNBr330leaH5RydSR1bp91pvbHZXJfvI8FaCjpPQ0vSwNrJaorL2iHaIjuv1BMe2qfe
 kPuv1lt5Rx+eTRU4vy6hCK9CgG1umirW/cAWHC+A+m4Z/5MpFi1rbGIzldJ5CNP4HYDx Tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dxe7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Feb 2023 00:09:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OLeCBs025943;
        Sat, 25 Feb 2023 00:09:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4a5p22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Feb 2023 00:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIudaJZVWkPvzloIpVz33lGPMTi7mxY7Iw5S7mVtBEQ0jkYnDQ6LhYGZIDsCNYLgx2QPymcBTWKYi19khvn7VM3TYe5ccmY/fktL5M27PcXfjXm4TJKrFtrU9EFhAE7iBwtJRCI5bxu8InGCm9Sw1s9qtcLT7l2zq/ddkZatZxyI4LkDbiSfIkmLvMKnksi2w1fMsutwzROdrsVj7fHrEeR+UF+vWVti5b1uus1fPJO8d664UlirKY0XqqyJIpY2IS8lh0Ov9XHhkdNHaZamhRlTnQT9M7h5tMy7+sZfgoSo1oMSRZd5sHU28+LA+ueMty7faiRu6bJbVebWKCxmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jee+nZpHfN84oObiOcRq31HDc+00cjTjpWh+hDMDYo=;
 b=gM1SYHuPLQB8Bi2nqQmgLjctZ7YvGR1MI4vrOfWo7mzfyOhKe3odzpUHP/XCsKOuzdSMZVYoSSDV4DQEyQNGT6kM3Wo8ohLpXHLkvX0UAMuW1xBFtNOGPHeva8E4Mq+GwnDIDlXfRtA8U2V0+82nW5rx9a6WMpuiRKJYVW08Dapcb7ejcWqGJOz8arP4Qz6srCRVAU+vqNihlAEL2GUi/J+Z+38oCM8EEL8gPg0kB6Ct/cpnHtBBWlDPGiv1fYB9TCfzsAIRHhPKuCW19Y0kVDisco+nkZPfCLuhKTts3mN4800urHmlXss6i8KfMpHL1X/2efxUF1kZzdQVCWG7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jee+nZpHfN84oObiOcRq31HDc+00cjTjpWh+hDMDYo=;
 b=sp5oGHC/tlD5XSwtd5O2FxjkTHR+1TpJ7vpQSs9Aql/+ao+SKadz7vXJ/q97jN8hxYm/3K94NQWyNi7wOEJNBajJjbYi/dtPX0N8YU1hf8NWzigyuPxSByw9gamgcuQ//Mx072K885IMTs7ZDlalQPJmXLMunKHoeDzklzf+SpQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL3PR10MB6185.namprd10.prod.outlook.com (2603:10b6:208:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Sat, 25 Feb
 2023 00:09:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Sat, 25 Feb 2023
 00:09:21 +0000
Date:   Fri, 24 Feb 2023 16:09:17 -0800
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
Subject: Re: [PATCH v2 11/46] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <Y/lRrSd6e3pKuATr@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-12-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-12-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BL3PR10MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 49130bcc-6c86-4c0a-3a17-08db16c48afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1d5oobCZG/wMQqklavgI8UjSHuBXACBRCYg5kKCHBnMwx+7HxKW7sXDxpz9V3zDNij+vcR5DQIV3CBbh2B+dUxDCcKIvoUE74c/jtRK4XiBFKTpzXqyNnWSMcL4tBv3vcud5bJy67d7GetDUi9XquF6Wh4DbtIQgyh6ElmnhDAV4347yxkB2UYWFl4YREG3MXqJL5s9ERw6fk687+cPrWUhRcPikyCl7vQ4xJf67DRJHuGZVzKiOhOnAPhpli63caOl2PwUgj9oTf5alo4nys0wli2SXqjP7e4U+uLCZhyA/P6iUWOmDMSRGj9djC1h4wNpGLbUrjZBIsdSsC84Hho/eINOh8BVrooRD2KEIBhaEihFKB+NHDVsLYaH0J6MHJoIlYDWrt5ItjqmK7ofDl4NDJRjRh9SWxeOrTUYoQIUUsCf+urUX7cc/SKrkeAr1oae+QvhjSpZAON5+f4zQrxfzLgrkiK53b+orctDh3aX/ptAiOqn7VOZHlKmJOkGkyBYEy8WgQyxKAP+luMloBJe9kX2IaX373APA3BOkqoGgP3hzsphJaBaLCp4n06Us/UC9OjK3ikY8CpUiqVKpTvkgttK1bgYqWTBivgZsePDLooV/htm8MZYSxjhZe9D5MYzdL8tricV2VThqXdHZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199018)(316002)(2906002)(41300700001)(33716001)(86362001)(44832011)(83380400001)(186003)(26005)(53546011)(5660300002)(9686003)(6512007)(66946007)(54906003)(6506007)(6666004)(7416002)(6486002)(66476007)(66556008)(478600001)(6916009)(8676002)(4326008)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+VfRrVNQjkB4HQ8yVCmRpLo/H8BAaK16OUOsPDzEZMUsLeN+VtTz41r7jHpd?=
 =?us-ascii?Q?GZ2AgVVgJfeSYUes2brHOlygs/rwI9blpdmPr1QXmTVazDGr8ptPr5lJEPXJ?=
 =?us-ascii?Q?nAOSQFpQXiapmnKupTRXsSOXuhRCTShaCHJFnkCH5wZm2o5B/gHA0Bqx5z+9?=
 =?us-ascii?Q?AhO05ih9tgdoy9jJNLRPHenOkg1MuaoVRPx8sk3FCY+3g26vaKxQOZYTVFt9?=
 =?us-ascii?Q?jIMYmXlHUlXhc8wC1cMnt+kuzIU1C69Y8L5gY/vhOohRD/s+AMVpC6jlr4tI?=
 =?us-ascii?Q?QJdS85tW+O5Po1pTOUazJux2cVpTcfsHo0qhxGSQSjomimSEhe5SSCClqfSP?=
 =?us-ascii?Q?79QNfUh9gI1yCJQJ4uJgxWunkCZpyzjUSIFcqUjhRR9PbAEtEGzhiqt4TztJ?=
 =?us-ascii?Q?vINeSJzRnRm7zldhbRTv8nVCWR77mEkqOPxjw20qqPXCubFdQNa4SHh6wul1?=
 =?us-ascii?Q?qdu7Fb/mx3uB+H0zf0KzeDYxvymknKA0FBNwaFjal9v+Z3SrVSHcJS5GzU1H?=
 =?us-ascii?Q?Jx2ZQgRUE5kH5MUUb2GnDHjLhNgRR3n1L9p4U5MhhQX3o4U5HgPNMEeegLH2?=
 =?us-ascii?Q?AiIKyd7jBQ/GJPUaWuBl99KwTryV2XmDFXXPiB/CNrPdOz2hfEvp0/j8RfP1?=
 =?us-ascii?Q?9JjxpA//xzU50rhgciYfaERPbw//E2zEJ6+eGNookzHd0LhK6kZz5t1meETS?=
 =?us-ascii?Q?3WUKVMgzwOzjxJM83Z7d7WhpNVRyWfWkziIerPu8j5jaqg6Gskqgtv3rGxBb?=
 =?us-ascii?Q?1ZQ5CVUH89jU8MzVj1ubvPN5TJaQYvdy0zKG82hQw97c4hktdDxckSMQUx+y?=
 =?us-ascii?Q?V4+VaNXZWYcSvdEsVivyVT+kZJtsqgAJLCJAWSHj6RO3ncCPnuqFY4k5pmg6?=
 =?us-ascii?Q?erjU2s/sA/y3vNBYSAP148lqVOs0cRp9UH5llxGxfUq0UOd3JEJU1g6fLhNV?=
 =?us-ascii?Q?vQYPAYBZF/wF/tMIbdPd2scXW7ieiOsCuCAnVSXqSPmjSr1kgtjNb3Q6k8Lp?=
 =?us-ascii?Q?K67byljoS3OI+OC7HBBeI/TeJ+axY6o9crGh7emu+ab9EVv4ttuyDEjzCVrZ?=
 =?us-ascii?Q?CTNVHtJSjczzyeVKLtRBj8KMS2EfFXOIiKj50t1tKR79uWgIFWPb8mbRLem/?=
 =?us-ascii?Q?CfXE9CY2QwdhKSTPECSxJj1D9ghv+OXR9ACtWH+YjqhF5UjoMwwgjr4YsxDs?=
 =?us-ascii?Q?946x1SlKCkR1usZoymaRq+aARmxiAbme3Nzpc1JmmOCkWUIWf7zOe2NlpFq7?=
 =?us-ascii?Q?3Wscb9a+svUXffVmOVjJF91VDoYq5QCIZpbKOsDeagvXPFZrR2oKDSPobJNw?=
 =?us-ascii?Q?rs0st3AZrzYjFfBGofBQz6T1VnJEKVADJ/MeMFLa4lr7tY9vJcpM+hvWpK30?=
 =?us-ascii?Q?uN1qEgh0TF5BJGsvYulaMJsLqrkugJerAgwAkaoGYnh0vFMebtNWD+qeOWRs?=
 =?us-ascii?Q?eu8sLczBOLUqtMKQKCDwOFWSuiLUVWbmKzZ2yhL5TVvq0ACGx80eVhMVCd2F?=
 =?us-ascii?Q?mzOEvkgpp9bZjMjFirS1889U6lKrsGsPRMieMgEPd9eMGDM+Qhr43sTDJifM?=
 =?us-ascii?Q?UiWQzF5dRmaxN2ySGGzq0RSQY/vNKsX7Y3otdcutntU0hfCiq9eONfkwrPTE?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tLuI3kts07LW20iCT70oRM65VyrgOoOuYOR1tw8iT3UsQwavYmDexw463bId?=
 =?us-ascii?Q?DvgZmXNyjuE7hQd11yrm68zt0c5fPGgH1BFEXfI26t39QEuDwu2vexUBSgU0?=
 =?us-ascii?Q?T3U9qrNZh13WAk55J2JM8XIpIxQ5dJ/iBB6QAp6voJMCDGnMcZlMUspGvZwW?=
 =?us-ascii?Q?CJ0H3UrM5jOo9x7VJ7HeEY5xk01Iw4G/64CEUEboJG0GaUq3MubfksxfD8Ho?=
 =?us-ascii?Q?9eSomLyQM4LBPpGWTSSzr6+YC8aIV2y26BRbXDngAGiW3/eFA9Jdsgu7xNO9?=
 =?us-ascii?Q?Kh70Mpkne1Q9Tt8rJU8kKiY9Q8cJ5lKvS+9qOAiRoGAp24MHu5XVhMf20rY4?=
 =?us-ascii?Q?Z/bw4kiBnMopOC9Fg7oeMX1x9aU4fH0kTiZf2O4jIN4+RtI48ufvB1S7PsiE?=
 =?us-ascii?Q?xAkg2lmu2bmh4WYdhqFTuMWK+DvbuhBwaaJOb4KyjhXt7fpdjVUp9IRTDQDm?=
 =?us-ascii?Q?XDQfSvlc/L++V4oyXnQJU0W+1BjP9w5xkOil4gtLEjK3OmY+kklFuQvvEDQj?=
 =?us-ascii?Q?kDeRkfjw0kpZrOjWNAkVlR22oX9nCnP/5CBS8+GaFtHuAgv0E26Xa/HvuK5g?=
 =?us-ascii?Q?uNY6j3RgdUT6aOZPWUUUQ7vyo1GAqI0yRx9+1W97gfWwUH36YTySH5b8tNnd?=
 =?us-ascii?Q?sDoIR9sm5163KiPMxEQcI7bynJfRwo/HgJJhBD1MIOFRc4/Zh7iv5ySz8YPV?=
 =?us-ascii?Q?9kDcobFKvwXVjvH9OMF+1ti+kEFGAEkeA+J/rosajlOc8VMrsUX5/HlyUe4j?=
 =?us-ascii?Q?fnTkIpAVA5pdBrD5Z0UQPpeE+BwPz72rKPAUbmwDiIHi1w7yOuOYmpqwpfxy?=
 =?us-ascii?Q?eb8CF758W8IByd7lrF+xq1TP1P7kqC5eQ0oWWW/i4iT5zKPIx2fv54RXmVjx?=
 =?us-ascii?Q?qWEvbhej60wDXRyorAnIGfArybxFixCyM7ApMI1fKe+ef+LiV5NdrRZ9UlF9?=
 =?us-ascii?Q?l4bRXFnvK4Sqty5jnwo3LGjuEqwGs7cxoelx6rThOu69EgJvHr+sTBqSiAs0?=
 =?us-ascii?Q?sey6ZFUZm1gdQv+9bFM2QxiUETef8NoikytQpmIoiOXflE11KLFMFlOOVbcE?=
 =?us-ascii?Q?BsrgJ0fL/yQfakxQA4kAUxViD24xppPgtPUIUxQeaPkH29Q0YFnkK1fdHif7?=
 =?us-ascii?Q?bAv3t40Qeb4PppwGc1Nz4AfM5bOqQVyBJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49130bcc-6c86-4c0a-3a17-08db16c48afc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:09:21.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCZsd8OgOaM+Hv41itsaxBeNf+Zh+E3WJ89dvz06HVwOVWK225QoPGDMA5TbMCSZ4UkphwqkvaZ/MHrdshiGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_17,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240195
X-Proofpoint-GUID: jUGw3sJnyg2GpZBuQX-eDecthrxd6ovK
X-Proofpoint-ORIG-GUID: jUGw3sJnyg2GpZBuQX-eDecthrxd6ovK
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
> After high-granularity mapping, page table entries for HugeTLB pages can
> be of any size/type. (For example, we can have a 1G page mapped with a
> mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> PTE after we have done a page table walk.
> 
> Without this, we'd have to pass around the "size" of the PTE everywhere.
> We effectively did this before; it could be fetched from the hstate,
> which we pass around pretty much everywhere.

Agreed.  I can not think of a better way to handle the possibility of
having hugetlb page table entries at any level.  The somewhat unfortunate
part of this is that code outside hugetlbfs proper needs to know about this.
However, there is already 'special handling' with hugetlb assumptions
in those places today.

> hugetlb_pte_present_leaf is included here as a helper function that will
> be used frequently later on.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a1ceb9417f01..eeacadf3272b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> @@ -26,6 +26,25 @@ typedef struct { unsigned long pd; } hugepd_t;
>  #define __hugepd(x) ((hugepd_t) { (x) })
>  #endif
>  
> +enum hugetlb_level {
> +	HUGETLB_LEVEL_PTE = 1,
> +	/*
> +	 * We always include PMD, PUD, and P4D in this enum definition so that,
> +	 * when logged as an integer, we can easily tell which level it is.
> +	 */
> +	HUGETLB_LEVEL_PMD,
> +	HUGETLB_LEVEL_PUD,
> +	HUGETLB_LEVEL_P4D,
> +	HUGETLB_LEVEL_PGD,
> +};
> +
> +struct hugetlb_pte {
> +	pte_t *ptep;
> +	unsigned int shift;
> +	enum hugetlb_level level;
> +	spinlock_t *ptl;
> +};
> +
>  #ifdef CONFIG_HUGETLB_PAGE
>  
>  #include <linux/mempolicy.h>
> @@ -39,6 +58,20 @@ typedef struct { unsigned long pd; } hugepd_t;
>   */
>  #define __NR_USED_SUBPAGE 3
>  
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +	return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +	return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> @@ -1234,6 +1267,45 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  	return ptl;
>  }
>  
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
> +{
> +	return hpte->ptl;
> +}
> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct hugetlb_pte *hpte)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
> +
> +	spin_lock(ptl);
> +	return ptl;
> +}
> +
> +static inline
> +void __hugetlb_pte_init(struct hugetlb_pte *hpte, pte_t *ptep,
> +			unsigned int shift, enum hugetlb_level level,
> +			spinlock_t *ptl)
> +{
> +	/*
> +	 * If 'shift' indicates that this PTE is contiguous, then @ptep must
> +	 * be the first pte of the contiguous bunch.
> +	 */
> +	hpte->ptl = ptl;
> +	hpte->ptep = ptep;
> +	hpte->shift = shift;
> +	hpte->level = level;
> +}
> +
> +static inline
> +void hugetlb_pte_init(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      pte_t *ptep, unsigned int shift,
> +		      enum hugetlb_level level)
> +{
> +	__hugetlb_pte_init(hpte, ptep, shift, level,
> +			   huge_pte_lockptr(shift, mm, ptep));
> +}
> +
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>  extern void __init hugetlb_cma_reserve(int order);
>  #else
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ca9eae0ac42..6c74adff43b6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1269,6 +1269,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  	return false;
>  }
>  
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
> +{
> +	pgd_t pgd;
> +	p4d_t p4d;
> +	pud_t pud;
> +	pmd_t pmd;
> +
> +	switch (hpte->level) {
> +	case HUGETLB_LEVEL_PGD:
> +		pgd = __pgd(pte_val(pte));
> +		return pgd_present(pgd) && pgd_leaf(pgd);
> +	case HUGETLB_LEVEL_P4D:
> +		p4d = __p4d(pte_val(pte));
> +		return p4d_present(p4d) && p4d_leaf(p4d);
> +	case HUGETLB_LEVEL_PUD:
> +		pud = __pud(pte_val(pte));
> +		return pud_present(pud) && pud_leaf(pud);
> +	case HUGETLB_LEVEL_PMD:
> +		pmd = __pmd(pte_val(pte));
> +		return pmd_present(pmd) && pmd_leaf(pmd);
> +	case HUGETLB_LEVEL_PTE:
> +		return pte_present(pte);
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +}
> +
> +
>  static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
>  {
>  	int nid = folio_nid(folio);
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
