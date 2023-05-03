Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711CE6F6166
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjECWnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87A901F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HoZ8N024252;
        Wed, 3 May 2023 22:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iZA542S+AX/9nADOINVgca1jAHuZ63qloYIKhy4+3U0=;
 b=Ou0V384eMAKDk7+YetVGMGI+vybS2Sdq9Ggq98GIglPJA44oMNdHNnlYScFuQxT0cfpo
 NK6W0OtDYh1apsvYMyljscVDzkauMlK/0lEreMxo9G8u3CpidRtSARP9rH7xteMGplcc
 nXBAD45wt3SJTUzZ+xEZqMcHbyYnz0gUxVf7N5CFDK6iJmuKZ9ZBZixayEYQ4Jy0Uebz
 UhCoxDHgL+z+2gwRAYLPMJ5IL/Ksgj15jCPXdl/B2EKUw6xF7XBvTF1oV7K8Rdqa1PRr
 MGygpaFxyCo4gTy1BSKJzRcTowTFCS+4KC1NACZbsYlNu1x9NBv1Z3b/OPg+cLo7I7Mv lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1rj0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343L4mCm040517;
        Wed, 3 May 2023 22:42:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7rsc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsPd6D7JMdrMUHZLMpvsNGp/xP+eoUUEVmdLXfUM8UDEDVXiIMV8P53f2Ui9AHdO82UWoVbYlgfBc0H9bas+V40qC75Gar74PXv802APd4MuCds5sUrT0Et/a4deN6e3rR4T+RIMfPQYgAkpBq5PW3oyd7ENMn2Ux+q39bELIvV5/u07BXKTHdmNCWH0E4T/t8I12JfUA09tHuYaSqr7bk026F72QfbIwKCz3+WOfoYEpNljVPbvdAAenQYIdBLNCHsPGKANJQkBtWokOIOG9ekuNUGgK6oRF/nvpKiLht7bGaFfToD83euKtS5I07fSxIzwJd31E6TS2WJ3EoOltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZA542S+AX/9nADOINVgca1jAHuZ63qloYIKhy4+3U0=;
 b=nSnFgiAHEmUR8IxDMmzAkoviW9YH4nbojqOpkSFpH+yNOlIDRBYwyoA6xBCZZTmP8FQsJiL1E/sXonIeytkPE+yANXgCpz/3D900gOwCeenyMy3SRaWhcrI4dnBvPCGxZnnj6T1czeLiE5+tQsgt+aktbpzAnTRCjHi0nqpq3Z3B2a5sE6CX0ND+sh5Kwo/3q4IDLUzWVFNmWZrAsWjXCAJxrAZdVc8LMri7KuQqwyn2gggG+gLcd6oV5g7c6MU1T1CxVMuR0entgpawwD3CoPNqoPN/ggXvp/t4x58uY0QzqpMRZeUZO7nzaGBi5haZTJDr/EwkLSt67asMd/qj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZA542S+AX/9nADOINVgca1jAHuZ63qloYIKhy4+3U0=;
 b=Mq4yFNltsGA/qKoKZeuHS2P2HCz2DihoKYvV5BiKV5cwLp+4CgT8K8TQo/ZmSywVSNS56ojOS4v1SDUph5rPWQCEYvqcJBOj7+jCn6NpRQm/cUYkAH/mJ9Diz3AY00/G5qWRDp8/RlJFcxWRzSMMn/eoTCQW7fZjLwJAXvXjEoY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:42:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:00 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v22 3/8] kexec: exclude elfcorehdr from the segment digest
Date:   Wed,  3 May 2023 18:41:40 -0400
Message-Id: <20230503224145.7405-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0164.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6237b4e8-b2c1-4995-acae-08db4c279b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EeOgHDMOehFnyoJjrnzHgSqQi7RvTK+QkjhCp2gRApbPw+OOAvCPN4VmzRqkIHpepyjB0AgGiNCUJB54bs15JQ76GYifTwaLDUusf8qlvXKAnLlEWqyVznBicCzOrB7QWPoRzJIuKaBr1iHeAXHp5Ij3PFMjDql9H9w8xnU/l/RSrRJtYseQ2OdFR6EG1HR75k8WMgK8HQ2we3PXHnPsK3FNPX8JMvayOdCwQyEgfoSo7cVqfR8doR5QuaYUXlVIX9ZzboKt/icUC2D192RSxmL6AfrxKo4YiMQsQR3R5OPcePGD0IJWzhr8tYvAVNHqQS0JKllD7EspqMfoGDYA831MyZSAUKblfRVopPRI5ZG8oj44FMQIhk/zHjd+28vm4w0J0tNuA3+t0StCnG5YjHDUmXNtJm7r6zzL4wvYeju8Oj6J16w73uAZsk+rY6709gZk0eaDWtKw/Khh0JgfceIE/wugyJusn99Lqq2cc7BvnlhtliQhEy0sImDgdpdFm6uGWLnieMWIGEmc8dHz79aI7vkjcqDCmfK4t9Bto15Dko2SJW4R6iNxCMS/zWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(1076003)(6512007)(316002)(6506007)(26005)(186003)(4326008)(66556008)(66476007)(66946007)(86362001)(5660300002)(478600001)(7416002)(107886003)(36756003)(6486002)(6666004)(38100700002)(8936002)(8676002)(83380400001)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PomH+9eBxLMn/VuOs02VBDDSeEOaqw7GROntP0n1ecI5w5lU1/EVBAw76hPN?=
 =?us-ascii?Q?iHec1obBT3BxYj1vMs0lcV8OJOi2dbWCFvUcRcqPNCZEM9rBSVfL+RaS0HEj?=
 =?us-ascii?Q?iQlCrqx0JA4UgbDWo1gBojDMuu5V7gvrKfhsqMt0Gu/vAL1+CRAT8rrXqhgT?=
 =?us-ascii?Q?DDF5RYYsUVql7SnaOaMtxxIqpvl9mQquF8K62i+LIY+KVv+s+0q+EepSkzRO?=
 =?us-ascii?Q?Gj98o6uw/IwbmeSFtsUX5YtMUZXnhiVM6Qfe24fN9PJ2xSsBDDRwwSM86CI9?=
 =?us-ascii?Q?1La9m8eXlJ3I1fojqKCpl1icPd+7luQwnwj3b0pP7a4lRL5UDTE5SHO5ATuL?=
 =?us-ascii?Q?PthPgX+zGIpUa2KW6q3QzsXXBcm3oWnKCW2djVUbTOM5TYCe/U4JJjACRmFX?=
 =?us-ascii?Q?CcJdQtRjwnosZUG2PRuZPBUPbXfcNNag4PxqRlSlRn/xpzgnYemFqwziaOeI?=
 =?us-ascii?Q?o57niON+ISfEVjUjOyQnZTr79T46c08axUeh2UV4sd32CmF7KZRZGu2TQ05/?=
 =?us-ascii?Q?LZ4eDj4wukW+atzuNsxwN1TlXwsP0kRULFkKuAJWlLfEeQQiaFwICsXCM6RW?=
 =?us-ascii?Q?h3MB8ZWbDYN3IptLw3WXslGiYK3Psnu3lbbB4XXsPIgc9+AZ7CV8RzpJUDmg?=
 =?us-ascii?Q?kBCXaP6AWM7FsILxR8GP8mDDhqfG9dSgpr1bPT/CI7iZ2/PNUjC9ggo8dUgr?=
 =?us-ascii?Q?OdsV64aYTLRzY530esMlNyVQSOIP4XdiKWMB2eVVWwHCcCxN3TpkhcgPmsyz?=
 =?us-ascii?Q?kjYIKdnsl3+T9+mG93yLoowrThO19T6Ianr6xPDRv5QnmIdWcz56CEHsOqIH?=
 =?us-ascii?Q?RnpnQ1+A/bmGFN5nrxGWqE/JMKM2SOFRHuWPf6Dn1iSCQGcJoli1UucFtgat?=
 =?us-ascii?Q?s8By9SAKACOsvSTwNS1iWiZGpilL4FL/WN7C2fZ0dpKkVKdVkfkboXrGrNqR?=
 =?us-ascii?Q?jVC1jIhmv8DWFbaBptQuXAUulX4ngW/+9oylPexy0ZgTnDz3KUp+yknQsPSO?=
 =?us-ascii?Q?f6edoNOl/qQB0z+mSgb03jBK8StfDUPsXYC1hKpnWwTHMT7uTDhnKdP8j9fn?=
 =?us-ascii?Q?gMMn3zq01EbboPxJ+8dub17TRPYra9V1adir0RmpCBmXWA5D2XvSSp1wlO46?=
 =?us-ascii?Q?V3cDjwz6E4cHaJzDjYNRenzUxeSjplIgluhpx0nFip56M9XXYulzpYEfT4I/?=
 =?us-ascii?Q?0altcmsNTeQffQMPoJVXuXpZ/+t7EAPAFSurQFtOBZ51UfeTx4qNKj35om/L?=
 =?us-ascii?Q?J/SGvmPPDKSlazuPnhr43qxf11Zy1BASipeMG1SuHW5aMuuXLOdHy9NJX+da?=
 =?us-ascii?Q?uSwl3suNesAk88TNn7FB/OWg9s5uXjncs6bIgDu+zKqL+GzI6KUOhVQYqfp3?=
 =?us-ascii?Q?vJXXpvnyiVSEZ+UJ/tNmC4yX1kub8yKPYzkp0ER6pJM6H12JzLF5RFthB8q8?=
 =?us-ascii?Q?g9gN6Jdvu/t8AZH2dbNaaM7p7zXpDhmqSqOQi0c/D/SVL9+W6Ay/5jq/Hu22?=
 =?us-ascii?Q?0IzayrFsDolZ7b+bA0nHMqtDoYciK+cHiNZ8Y0eP85UZFXHRF5j7Bsbagbzq?=
 =?us-ascii?Q?8i5y6P1WshYGENkhtHJfLE2MsuOAgFtjVQcda4pK22MhANEaGMU3wcLb3HrJ?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LXZg3LX9phN91aOiktQpU+ImE7a+2QKWVNd8VsGvNKHB3mXieYls3GiIzxA5?=
 =?us-ascii?Q?15fcV9JwGwyecuNZ93+wst7E8aeOdaA9fjSYq0sZqxzofHfA/J4llwOb/U6T?=
 =?us-ascii?Q?c7FfYFSQj3p1lI33hEVJ79mcZyIT9zZgngqY7Qs6oxV6FZA4v8d65+IY8AkC?=
 =?us-ascii?Q?oZyfRCPD7v2icEdw9eKHFBgLzUkOPbobUs9Ib8LDpf4KI/uQQLpyPiML171i?=
 =?us-ascii?Q?MhtdsBlba6yb/LysqCxAjFUvkaxPMchsm1lXK8NeMw95mgZ9xKSUboQJVUex?=
 =?us-ascii?Q?Qzp1geJ4vA+pHkMl3I8GyWEDph13ysXQRxtSMB0DkbkRoDrSqpMpOwNWVSLX?=
 =?us-ascii?Q?AiHvl+C4gjnnXh/gUxKeT6z2l4kcoaTxPKm+VSDhMubP/Cbtddey9LCZjHVt?=
 =?us-ascii?Q?Oxb5sSpEz2GPUElDK8e+6vlSXgdtUPe49ZRIP6yuBGuz2nfjSmrkY+JbMt8V?=
 =?us-ascii?Q?LA24y4e0teIHFXA05u1ocy+ykhnYOK8YtBU1uWbFTrkpLPr6CnkCGZzoDas9?=
 =?us-ascii?Q?MvGhxi9yj30mgqfvZ0d5pR7hr5Jiqr5GFlduxc9zIMQ8mHtT1dmPcelsOqpf?=
 =?us-ascii?Q?FRjhCMmNSzN2t7S8giTzWfo1dWrCJUmZPky57aLEns4R3dkyucUt8ECrNLY/?=
 =?us-ascii?Q?pR+647irrBdqA724SQrEuM+mK374lXQA/DjtAafU0RPueQHG2eSzmjIQLHxl?=
 =?us-ascii?Q?n7IRhg1u+Y1PLrarlGhBVERd4J7gMMbOLp5GV51bgIgfhautpGMgDklADL9N?=
 =?us-ascii?Q?sMUWti9nLLjWJI/0Pra/jcdNFOOzVh5gfPGJZIIiCXOgNRQMFU4Y8LdKZwU3?=
 =?us-ascii?Q?t9q16XZyHpzleDS3iryjBdOeuuwwxFRbmWnFQM50xjlLpSwUNd41cpyHL5e2?=
 =?us-ascii?Q?8HiBFt2B2iNtn41sPK9iyuXHPRFtWvBx/PUUUeFYxUbwrjaXW5gtl0rPUofr?=
 =?us-ascii?Q?VFJTUzrifIxmAdMd7SKankmeBS3Fu2vhy9jJ/NGSb106rBv4FrqVw8lngNyJ?=
 =?us-ascii?Q?WD2XmDBq2X2mVn7J0gk39h7TTvD/KdTzfIi0p2CSl/7r8zmTelki0H6+YMiM?=
 =?us-ascii?Q?/uO5tuuiPg1vmcL/pfDPwAvKzKliOPXJndK7S5kYyfilYlpZzb0O2VDDcaoZ?=
 =?us-ascii?Q?gEOkvawx9C05mgL6ASHHSey7a12Hy1/C4c8waoy2IKefJUQsg91IC5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6237b4e8-b2c1-4995-acae-08db4c279b87
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:00.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9a/mh41fiteFPhV4nnSjLhgWe3Ym5iKIJCkNT41vSeoSJsDBYpC5nFCNjwmFZoAnYvTA3MqmOqvsmPO3r4YA4V1yE750JIDXKOXIB6VQZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030195
X-Proofpoint-GUID: wbSM3OJjngqUbsQKSlk6MzeHxoosZ0uc
X-Proofpoint-ORIG-GUID: wbSM3OJjngqUbsQKSlk6MzeHxoosZ0uc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

This patchset updates the elfcorehdr on CPU or memory changes.
However, changes to the elfcorehdr in turn cause purgatory
integrity checking to fail (at crash time, and no vmcore created).
Therefore, this patch explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits updates to the elfcorehdr in response to CPU or memory
changes, and avoids the need to also recompute the hash digest and
reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f8b1797b3ec9..1d2cfc869a75 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

