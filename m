Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00D705CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjEQBs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEQBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:48:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910FA0;
        Tue, 16 May 2023 18:48:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxVrh007553;
        Wed, 17 May 2023 01:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rsbz5aotO/68yUc23u/T2RpBVdE6MOYVlG8C4vRRmys=;
 b=ydXZ/HAJ+ndgWCup46NdU3tCaw5PLvcIQAhyDCAaNCkyaLvGysI9dopypV25X2XCDEJb
 YzKImHg7ZoE7rQz3zW6dJIsXnmCf1Xk/Cdz8oLZG9yM5D6SF2pf8wapF63Bvu4wdREtk
 p1ZqVnwyhEM2sxxP+cvOeOj6SJqC1/yro9FViz35C6uwLrKZyIl5dDJ5JW7SFl4EyXa/
 ZDocuI+uT0Lvm2SjziOKoBpspCUuIUghf/VV1LNZtVMuKR/neMJcG7FATKUXRGOyjox8
 V5nMHM10pE8h/e/H4pW0OrgYmPMQ91JZk5f69X/fZ6EW/fAwL/RL7F+e3PEThje9PpQH Sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uvc0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:48:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GMqB5u040128;
        Wed, 17 May 2023 01:48:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104jqwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbguI+FI5rxNbhHXIDEloPD8l5E100LHAGroUEwcZlLh+ImbNWj3l5jy8Anut8y3L1hwpYUK7SrFlL9b0GhKZ6TI//p5yKrWnSM1ERoPxrkI20qus5icFd9l5IH53xlZeLeQE40jTgfqnoLplv+fNff12KFNUWb0oVqLYRFRAqOdWMJZ0Z3r6ABpPQ9gCKRQqLSilQKCcSDYK0nECJj9E0kbN2qjwsk36h95Oww0XTGQpKe55Ui/FLyrnAD+xs0TsFRo5weO+672r+UPQgVgICFNiOXm5PCCdVHhZnzR4iFBaUBx7Fo0ooLzfYS6x9vzCyok0CRGelbN02ZHeEcKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsbz5aotO/68yUc23u/T2RpBVdE6MOYVlG8C4vRRmys=;
 b=ecEnBOYLHDcX1Fww+pDw4TXRv1sLh8rD/bq46xWYig7D2gVH59SY//nMuupY+4UR3xrQ4Ddgc3GErNQ0nCDwVxV2uI1xEJR7KmsLPVKwiG8vGRo2OKqqqqFu6HL7NE94GPQmrWEKjFOHVl1Atu9Hlj3RRveiGXmAkLaLX4jxD1T0YBDXFUL14MJHwJK98ovcFG7ad3tE25kYKPBnogtNqFgl1lAeHaynH6TLz+Ox2rP9U4OJewmL++SVoFvz+ENR8NZrpoYxEqdsmvaVmaJ2yhj+27Ftbo7hTcg2q8SS6FqySyE/wCiknuBaA4GIFgL/HrnGDaYrx4pJ/L51WHTq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsbz5aotO/68yUc23u/T2RpBVdE6MOYVlG8C4vRRmys=;
 b=fsgaTZUu6HXxB0ZwATPuDa8Yg3NwqekaeoAoYSi4vhX2+k2URbiGxg20wzWQzBiyOv9D6hhWLk9cHEMEVuCxIqMn3URCO8K5Lbpj1ZU+50Nelpdm3OLWJquEFWKoPP/3+wfEdSKT/4CoHWT8qYE4OsQNXX7KEv3IN734JCwdNZQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5644.namprd10.prod.outlook.com (2603:10b6:510:fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 01:47:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:47:52 +0000
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/3] dc395x stale reference cleanup
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qjfu3t3.fsf@ca-mkp.ca.oracle.com>
References: <20230510093933.19985-1-bagasdotme@gmail.com>
Date:   Tue, 16 May 2023 21:47:46 -0400
In-Reply-To: <20230510093933.19985-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 10 May 2023 16:39:30 +0700")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0230.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9f26ee-8f18-4612-6e66-08db5678ba51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h45lJsLpNuEvYywLqyr4bEsSvI4hLJxl0CxrHghOkcChHGzttnf9o79of2tssyVkFkZeggo739p9Psjc9maSvjMMqa4W95FklQ5rXb5CwjDcrCH5OsPo7R1KLm9tyuFwOK+8Fy+5BFUJvhkQMyh5hIo/taWh4feIt2zHVd2ri5BGkygQNlRJUVSP+iLZbpFLBSRHKp81RXWg2DangHcm6irYsor84oGme6c4jgj/u7gTOAgDj8M7ZISDmiURMFvTjQOdIS6geaSU5WhczAiXC+nBZIZHFk5W5b8bnufKAcqFCuR/ueyJ9FrEPVVqYl7Fl98Nfb9awSxvmfu/6j4c1bgbrc3KTDc8+d4OFPua1jFaFhVRR31bnB4tgenRQSFjZCGoA1AI9tnUWPOy6U0T7NVYFw84UkgNW3kj8EQU3CYrhZkAnKWTc+YntroyZfsVc7A64yt0Q0o11XSyPT/55Y/M6rMrxmFp7zOUaREGXCzIqQ83olt06KRMmSYHFpFCY/4WfPWudhOIxIGXHtE4n5MO3Q348yDjg5BMk0/QrNTsrult90OAtxcGJTD9+lPO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(6506007)(6512007)(26005)(36916002)(38100700002)(86362001)(558084003)(186003)(2906002)(478600001)(54906003)(8676002)(5660300002)(4326008)(6916009)(8936002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBBzlFha6t8PP/3hIZ8ixMxN5njEAg3uY/l5ttV7NynU5lDtjchsvjlgWP1h?=
 =?us-ascii?Q?qa6bKOFesxr+kB3tNoCkCFEbTbgXzQReKmvhcCL1i8wGr/ocS+1qrb9LyUX1?=
 =?us-ascii?Q?WLQ2zAgezE0w4CeaQ4PkaY+v5kabe2amHcgP99ezLTtqBT3jsMjzYmRXgNKh?=
 =?us-ascii?Q?Lvhus9ZCUiwpRTsLgk44e2ID9G5yBu6LM6c7vl47zmSbcocybtawdVDxEe/i?=
 =?us-ascii?Q?pjR0VcRDqQj9bKfMqeipnxpXNfCXPOl4GzHVa1MASNvXR/ZDxLl8cUF4UMfR?=
 =?us-ascii?Q?73/4+x+P3uB8kIaSLzwtbN1aMBoljirqm9QWUktLdqYWL52mFRqupfhYarL0?=
 =?us-ascii?Q?CpvjcIv47zNjq4ipKsy42yjnrc2jT30/u4pU2uAkIENdCq9j3pwdpJghvmM8?=
 =?us-ascii?Q?87o3Afx7BufjYgMcVgger4+JfVMad0WNLHff2pZdZvY7pyQoPmdPRu6GHi2F?=
 =?us-ascii?Q?QfUMo4GefrP32+9L78cOX00LS9QAXbh3UxzNc+s0Bkc9dDA/KOHEkTs2r6j3?=
 =?us-ascii?Q?CUnuAsLGkfg236DpdHNdRbYh6KS+eSdlAJaxWuaNqMYT7PpCfgBL0fqZYUD+?=
 =?us-ascii?Q?TUWpaeHw6GNlccu2+EFS/OYEosMfNhe3xC1xPQd6e3ZwIt3//++1ND5q+x5l?=
 =?us-ascii?Q?sM2fWTneag0og3RtUF88Ecyo7rxZJBKsCp9jd74NgYPM5C6Jbwn23ZbU04H3?=
 =?us-ascii?Q?V/ZylWT9TaxD97GHZ+O6JbLBZ6uIWImgWraUUkebQfUXQVCp/IqLNF9tIjxL?=
 =?us-ascii?Q?LYr4bgXI8zlTKHmJxc1BI38GKOfUDKp+Qt8ACWi/Nk1hVRR5wJuY9SRIcL6j?=
 =?us-ascii?Q?ClI8QwuRPMPGZXG7ZSdgh/qKD3RgiLNH/J+jVS75QwK6q6a0FJG7xWS9LbL3?=
 =?us-ascii?Q?RM7T/FgK0az85lp3+lgTN9XMFd5HGzThV4t/9sHVQGpU1hS+1oSt0zGmJEvM?=
 =?us-ascii?Q?tvH0AMkj5AV1EVKYxdktvqXzONQlo9qdzp9jtgyp56biq59GL0ZyV2hbQ1SI?=
 =?us-ascii?Q?0chzC6SkYxy+k4BVVxsuny5PorsWg0brUYWTuCn4d+Go5hcgPF9yMhme6lzO?=
 =?us-ascii?Q?vSFtBoQ71jc3yvVJyFaIr1lH1zqdTYgkuGJS+jRD9dwULsVEZa4L3k6uT3SF?=
 =?us-ascii?Q?LpD1HEjzlFhyYQ0HiAc8la34pmADSnJkJAb88xZaeMblAUGEPuA34LM4tovd?=
 =?us-ascii?Q?OPQJhifW5JeC3g2BQb60EQ3UD34L5uENyDzpY8YpWPiTgl0yyYDJ/TI2FiPw?=
 =?us-ascii?Q?BRGaAn9eALzHApt1wSajHCBlg71Z7dr8uGa5XsfJn0GFYwD+eWJDQVNDu2LW?=
 =?us-ascii?Q?ZHwRosoDHu064pORqucFOMAPHf8uRzhvYqtGdkUQz6SljlIQ8kgymS7eTtQL?=
 =?us-ascii?Q?vvcATgfKkDnY3U7ecOvKaPOqImfQ5bHc5iEMl+l5olOz4ys0QemapBdbzUd8?=
 =?us-ascii?Q?0JTJS9kv+iiMEkNkldl5EXSuPzhW/T1q059ujMmDB8gY169lKpM04VkX0roM?=
 =?us-ascii?Q?rrmrjhPdr3OVq0KtTADz8wus5fBbZ7p6uZIGV4xY1JWrQNWVSXMzh/Cnk/vA?=
 =?us-ascii?Q?pfj4L5XZZokG8EX/i1TTXj7UkkINt7+BayTp1JUGe2dK0bhzDzhsi1Kld1K+?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0g5qvyCBKmm9INmTcn3nWwArlSB+1kRuf6dCQGnbVn7st5ZiPyOjU9J32MNjOS8Pgupp+e6nMTolw78dnyhOy6iN6COE1sSZKUx0c4gWhsypcJOnhvDcjnrrMa++/jd2/L09F+SUUA24wGbybK/S1nYA2rLNvw4Y5jrScgSGllzTuphPJKhbZxaw4MqD87exui7NX+kMvWDmlHeN4sK4QkvQcFCqECuj7uRhLz+TgGc6qFs67jBAHRZRBfLKo0Ir1PQPIDM7/eouu4DZhm4wyoVPcZWIYF5NlwDmi2w4IAMTGuBn1WYQV4YGMFYL2riyVkI/YUolSJEaFstsdP83Yj0wVjlUFdyq5dmiaqwx6u/A7OAHfnSKrSsnRbJRryiYm0DKivmbDk4IxnF2asdK3xFBcghfVwCvrV3IWSDDd6XjJJ5fj2rvu3xE993qEubp+8m1lsPpNRFMGODChnnivEkenOnJNVTbXTxAzTQRvRMttVMq4dC8wfH7ydlw+b9URlJ4CDZV61LG2q3YTuvq8X/4Sn/g1ZLude8R8exhORSo62abPdfw6ZHzzJHvJZ7kIGf4hmP363FQB/Vm609XnsNjKMyzVGo1UwusVCy4YkqDG10ioieMV7u6a/aLjEO8okIt+pf+FJlDym0G/lHho1N25lY4sE9iEq24YI68XGPxPCmObCFjPmRpDU82cZ69RuH8UqRi+puSLS0zDAK+OI0u97QSQmOh3mRiw4ROovjCs54I4t1Dd5jyqIfzGMh2L4OrGPdB073LvJWawtZHpGrZkfp15yEfKJc2Yt23+XAv1C1Ql/sFg1XlFWq5vOF5BiaGaXMuN8mhBDt/omfBkqF1mrrLE5A/KHk7DiThv+z1oCC+S23GJYf2DRPbHfC/5M09g8cAX4/IdnC4R428yQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9f26ee-8f18-4612-6e66-08db5678ba51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:47:52.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pedf3CYpc3zGk2Nao0pcufeDtUpMTIppj7+/+pgX6ppbTBdMQYoTpTukUIjqxjWLMaagNvOM7RmsxucFge6VV5PAi8xX9VL0sCmLQzBUprw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=518
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170013
X-Proofpoint-GUID: iq0mqI8RQuM4nWcggy8RdtUgmHtwRRAk
X-Proofpoint-ORIG-GUID: iq0mqI8RQuM4nWcggy8RdtUgmHtwRRAk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bagas,

> A small stale reference cleanup series for DC395x driver. The shortlog
> below should be self-explanatory.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
