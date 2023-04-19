Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601466E7175
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDSDNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSDNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:13:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66936591;
        Tue, 18 Apr 2023 20:13:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ILdkCi023627;
        Wed, 19 Apr 2023 03:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2l1Izds4ZgszilNR51au1fEHdMdRNjuF4XJrLBMtdYk=;
 b=Fyv/3n4akq8Kw3APD7OVaypjiLy8Mbi07d47DtGgJbY/ugsWsKz6w4rHHrMg2pRBdLv7
 TrUxpo5gF2sqX6cCdpe/99LHr7qZ6r/VxlNVk8KDdc+IH4v1Qwm21gJlgt8Ms9g+6NHv
 tJqsdPxAaaPF9UY/BltoxLvWwB0ojI1/a/tGumyyjcWD27xZrvBcVwJBj/VC17Fd8rYO
 pOwNOxqdv3MFgKaqpRItChbHWCe7xzdCMCCqRJLYXQmtdiGd84hi9xATraWv3vwagPeg
 FcLeZ+spPr3JLcxMBmSllYkIYPbRtCC2FWSuIz44Vg5aCVFRB3Cs3JEuffjdvA2WrcGC nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc7akx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:13:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J1tVYW037214;
        Wed, 19 Apr 2023 03:13:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcccr3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHrMpIPTdOXU63cPO/z9VUY3CEYTsBysxzjuRCRUgF+v9hqxkIT2yzB41ZRdz701Wsf9bcT3mBXJXSBA3KF6FSzQl0cLh4E0dHERfNGwpSaA1FwtFoOU1fOPEICOzKh4sy/ueF8416u2EG9fB68NIWxcXasC8Hg67cTc2SHC/xled6DmZSdQzn926yIswYGMuXAqMXnxFCIFeY/uVhke6bV35MkrxuTIWkERjtUNAGsf0Zt8JnOOjZI39pgWNf1ZZ8E2PD2zT6KYlJr8cds/FxvcwNt6L+MxMEJ9s/A+z7OJrBa/7jI+qE2NivOoUCqHCVYj5K/B8JPu+ANYpyZQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l1Izds4ZgszilNR51au1fEHdMdRNjuF4XJrLBMtdYk=;
 b=lr7+rRYE4k88WxDyfz/AxOMiIe4fFZbiRZlcIrGQ1/srt3eoynTCCEjsHP4/wE/jxDKowADspEB1QN4HKY7ENxiK9PwjE6kZBswJxJUVjIuNJum8hbhyiDbVa1c21sRFlrT5EknWcdrOJZRJVmenWbTywYwtB3kOslWfbP+Qfkg05/0x6jQ+LrKaYxWGUSDy2I7qZkMo0qAn9OP5uRAYGGOnkHI0itNofcBp8x0sJSq2lX+pjUl24ZesGcPXjgrhlzNitc/OiI5fpl6Znt3EwuH8LjcjHI73eknM5Ym/Es+a4pTMAvuUTLONA0b+6g5OwaLb/AStvTzrtFCFc7Cdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l1Izds4ZgszilNR51au1fEHdMdRNjuF4XJrLBMtdYk=;
 b=OFJh8t5MAi1TIwnejcGvqlvBP4I7IKsgBcLWxwu7tMiq7dHrwuL6RU9owCUddVzicI1klMbKDUUJ55sA1yKFdJd32hAT5YSfN/o4ojI+mAET1T9W3GQ1zdWUrPdoRkVC+05io2jQtcOvAWALKG4lf9pyPjOI72XFTkiwe0ClpGo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 03:12:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 03:12:57 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: advansys: disallow ISA-only build
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm80pntd.fsf@ca-mkp.ca.oracle.com>
References: <20230417205207.1592134-1-arnd@kernel.org>
Date:   Tue, 18 Apr 2023 23:12:54 -0400
In-Reply-To: <20230417205207.1592134-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 17 Apr 2023 22:51:53 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 455c15fe-1af1-4238-0a04-08db4083f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+HZWdSpBSWfqiT06I3sdrMex4Q7K5ghAe8mmiwgRjVfMaSPnnk/zG4zhhobPUWFA/h60DzMPnJjJF1X5iP5D+ykQjlfa3jyhoQ1cGVu2Y9/v+n2fBykgORS6Tq3tr0wgyVu2s+yThBkRA8DKS13xvXf/JlLOpNX/qiOBf7McBt0LPiwFq9zlLGwEC0K8rbCq9CN1CDiLkpeq7DdhLluBErYcnaGCcS6xiDoMeNjGUHJfKA0cESf/y2BUR0beoqeoad7LnO80jg44VtoL9Af4VndXTV13LBlYu26xAtY4iJqq9ril3O5IRqySGHSSmAFz2qiFFudwycJfMgXk1Y88uZtIfssY59wEqJp/4Mbi9sJ/X+LGQpdGSK0+LQLSQsYXbwcWP03fkFCuD8E72fQth4kHXU9wWw87JBk66DVGOpRf09AD4ep7jtfIubcTprQpR7s3aeVeMbFvPKXhEN92LLXYNvoBm7FZycKd1SMZlYROpfUmwDeikac1mwtg22IGl1BRm57WbqeyeU9rsfO1JI7uk0zLLQ72Wyj/DdBVMces/2O3qCY4YHXbJfznNu3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(2906002)(478600001)(6666004)(86362001)(26005)(6512007)(6506007)(558084003)(6486002)(36916002)(186003)(41300700001)(54906003)(38100700002)(8676002)(8936002)(4326008)(66556008)(66476007)(83380400001)(66946007)(316002)(6916009)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1gC5IhOPghFCGan6GrJoD6CMxO+ZBk+Xmhref7nI7QHmABKqMG1lF5GOKfq?=
 =?us-ascii?Q?e294i+GxP/NyGTNvPbNFeVgA3mup25LM/dbh+a9uDlPS2NQHi1/7yDDkV0OH?=
 =?us-ascii?Q?JIEbXJX9wDPXP5J6t3f/JVoIfqCzjbasqlFyWy6rLKUgaaLSQWoL8c0a7Fb0?=
 =?us-ascii?Q?Rx72xKASkzv8TiY+pIdHzH/NBrnbwU+8zX6cW+MoS3Bd8nIkgClIUh4Ssvul?=
 =?us-ascii?Q?JFMCkvXLGARLIAnaZslZgrRn61YGsvE6ExJzMhkSOC3hxwieSl/V5Mm26oWj?=
 =?us-ascii?Q?bYYGLbvWS/i6KTRG6j1xOdMUPnOE+VVgT5cXjpvzTU1Pqh8X7L/qbN3yqBqC?=
 =?us-ascii?Q?aDjk2tkOybipni5YN7l9WyGTKcvxDXwQVReAhN8VjnD9RuBw/2lZz5ph0ZQd?=
 =?us-ascii?Q?Hi4KfN2PDCoEKwfCM49jz481fVHPMXEmFYVt4n1L70y1RV3MJMDB3ND7M9Wp?=
 =?us-ascii?Q?+VM00FGzcqfs471jiS/BAc0AfmCcPsNRddwQOkPOnCeczGVcUVxLXaI+Bi9N?=
 =?us-ascii?Q?Luu/n29Q2ArdBO5MRI7P0hkoikQ18LAAOT6N6rwtcJosF/TjlkvXGpCuc9P7?=
 =?us-ascii?Q?phc6PFWFFx1wpUyR0/7Qrch8y/hBPALzC7ptZiMLFX78vuJzW747rlLygOXd?=
 =?us-ascii?Q?kziFfGbGAGxAS84dtT8fcDjP52brf7tIYkH3NviR9Yq7OOpOW1vDZeQ10cDQ?=
 =?us-ascii?Q?BAwsiqD8AF1U8YWxSuWQrFBw13cBNUYbCojfJPQd1ktZF5x0UAjAnWpSa5tr?=
 =?us-ascii?Q?DdXyAmlmY/w+EStT5UDdjhyXyboTso02NDYL3SLgwgi9SQHAWrP5ZOz8w4RA?=
 =?us-ascii?Q?jGiniUBiFrmHyGjdtdbnbNfpDTTVamHWBsUbzucYueKI1Anju6CoQKY+rP9I?=
 =?us-ascii?Q?MVkkUNly7uaKiMBqqCpiSyNtu686BEkAOWSeBgV+/Wr3YfRgglL+9YDIyqOj?=
 =?us-ascii?Q?lJGVJ+jMvIzDqlTmFQqqOeAKYKmrTxX8zqQNVUef1QVYHAZ7wJZ7T8OdbzeV?=
 =?us-ascii?Q?HALJkO5Q7AbHySXcrHPAB5CYJNq1tn9/X106qeF1VkReppSzsPja13tdbtjD?=
 =?us-ascii?Q?kwTNab4hyqJ2k5AffXUZYdZ0HUR1uPYy79wwMu2pkSOnLSZr25QqVVFrUJ7+?=
 =?us-ascii?Q?cxh0KFucV7LgCj/H4E7PHV4Ddt4ZlvRhgQrNAqb9sx4zK3WgNefOoce9PDfa?=
 =?us-ascii?Q?x05sAiqCGVBYi92n3ydQSxKwaH4ahJsbJaD8eFSmvyGUK9BeNvQZcyBx2uj/?=
 =?us-ascii?Q?wkBUnUI2XroJhrQCMaoaEmjlPVRb1PDmTekqzshgiHx/TE4epl8C2CxtMlzM?=
 =?us-ascii?Q?eKecirpr5PKmjauzNfggPmXn4oxzcRdZUsPm24qnwwBb+B47sxGnJwc8DWZZ?=
 =?us-ascii?Q?xOqzgJ838dLqZ9eAnhU5k/mOo6ApGQOG19xv83Izo0Vgqvl14Ll4tIGRxySx?=
 =?us-ascii?Q?f5fj5EbZLWIchOo+PKPafKxTS5dUdu0zbIuEy/54LxWzpLbkQAtDVTzWRbDu?=
 =?us-ascii?Q?+XqQ5USrVNiJV4ONuJvU2a+dVERML/G91dBju2x7l+UXQOVtOgDNnZlQp74W?=
 =?us-ascii?Q?IAPEVC8+R2nuzdf12kdz2KzR0XmkHZauzHxginZi+nZflAg9cMH0iAk8N1qZ?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aobg+mztl8P+Guxr/MNTAk4Xep9FAHuDlUwpmLlIXQp0Edk/HMwwdfsQqTK1?=
 =?us-ascii?Q?ssc2eAhjW8ayt8O58hM5QgmSX5OrpDFtrTW7zJlowQCgzTiz2NS0H1zwcdUm?=
 =?us-ascii?Q?XR8oJCS0o5qcB8DIJuzuaES60jN9E1iRrUuPjJ1qlJNFrB96kTpcwxZd5rdM?=
 =?us-ascii?Q?AWOBEmJjxU6/I0HZBJ1yfCdTvex6DtZnoD84BZPfHILLVZPE/ImUBAsg4aPB?=
 =?us-ascii?Q?vZreS/0wVvu0Q/h2Hr07NnoXwBGliTSEotlLIbnfVIrF6dQJNWefwmLfWSiO?=
 =?us-ascii?Q?diUff7bnDWu12eLhK6fC41OC1PSNcF8WCSKpVXEIpzmX+rNOUnHBrs5CRATt?=
 =?us-ascii?Q?4uhUowhoR+8qvC4eNgeRQma5pOeF1lMq1EcYZYGwz302dZeqiMZh8nEdSliE?=
 =?us-ascii?Q?yiCUnS5Amzq0jPa8Ew25ehBzOvEjHhOcG+yqk2mbagYoW3GE8HPeiBUzRWXh?=
 =?us-ascii?Q?1Re3JSQR3hEhqjVybW0/P77VIgB4UI42B/nQH2fVxbsICBF8zEKVXI3sd7wJ?=
 =?us-ascii?Q?PFD1LJ3yu+ShWfYhKNYIdjLNSva9FklAhJb2Q9xqmxFYzLLuZ6vx2N4YN3Sj?=
 =?us-ascii?Q?a+tQVo/j/USeR6TlMH+Ga9ElHb8IhqKp2qj87qB02FOU9ORTzPBivS8l6bTQ?=
 =?us-ascii?Q?tP5jLpsdrl6u0j5mquD4fKCUHn0AcPSodQUQmGNtr76uTt8zEsY4dXgyka6e?=
 =?us-ascii?Q?BCaThct4DeGMQBfpe0AuiV5eBSR3VGgPwyaCtGJS48CRNGJlibRV6DY2xVp3?=
 =?us-ascii?Q?dz5BPNd0/6MoaseIVc2pcfjlJzb9yFhHM/XILIIfnZNEgyb0zKfBxRpgeWya?=
 =?us-ascii?Q?HrB30m+rbEQlRu00JaGCC+ZYldiuR+Sixl2r+XyOa3jDgOf0uGfehv6cwhPB?=
 =?us-ascii?Q?O5keDOXdEKYRTjVBptaeE9jOQgruBkII4j0cAu2AOsxSjWiWOD5Aj139GPk7?=
 =?us-ascii?Q?7VmFObIjlxEUYAPMM00y3HjWym1qowMTnys+8NKcaBo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455c15fe-1af1-4238-0a04-08db4083f986
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:12:57.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyuy6k+7JBNNDGFjf8O0BXreQK3SNDm14hYPMHhXXpdNBSziqZZEPWvbAYp41SMBEAtWKByebJH8iiD2oaYoWlRAqy+s+en5PG2NZNJeaqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=785 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190028
X-Proofpoint-GUID: hRfepRqbtn-D9TbroB8J3-CrldMG4yF3
X-Proofpoint-ORIG-GUID: hRfepRqbtn-D9TbroB8J3-CrldMG4yF3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The ISA support for this driver was removed a while ago, but the
> Kconfig dependencies still need an update to require EISA or PCI.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
