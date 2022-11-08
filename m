Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81772620703
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiKHC4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:56:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384012E68E;
        Mon,  7 Nov 2022 18:56:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80NwMR023029;
        Tue, 8 Nov 2022 02:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Pzy1fQMa4bfK+8ZN8cJBqEjNBCRx3Bkbkd5P8VK4mwA=;
 b=ajiEXsh65AhhE9b6DJ58YXLQXutW8ZDKbqqX4hCvMNw0Mw54AG3SYrc1tg7MwfYfy/No
 6fX5Eoim7bBP2buMscZLMniM1vLcZ24KUP4QIQcgEPtZFnKDXySVmTYaaszNz8HgHCMY
 osTouoIT6u2MpguTwCFFIsttVFN0s7yrtC6LdyWf6GtwSfNZ4cZWrov0Wi7+bB4VuYsr
 /6BXNyKpwthwk2RxYhqAUMETt8pi7fhnBhfCajXRGMXIUu+95/uWWMw+LAnVZeh1fx/s
 uluCCoDouYYj21r8eDLIltmX0xV0FOX5chcarun3+eB6RndsrFqYGFiuaKI+w0v7VBlJ Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkw5xep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:56:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7NC25F010742;
        Tue, 8 Nov 2022 02:56:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyn8aby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 02:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMLhNqho9oEAV/6xmoSFNXRlEC5GT+gddm+mQPvUfZ8BEn+fDTryaCbCWzLWuBeJroLi+4/GPw9CVZrByjT5dKghyp74zgVWSstCPkSyfLJrDcaJpELgnmcK3rZ2UEf+BgHRGDTlj5/8hMRwjDuBaVVvtwkFH4BtOxRyF6Ja4KMoNk8m5CW2rCLyGm5M+NdHdOApXpsKNcZVlMZQJwtUTOd0+umY8i14wUf5HyHDNvyiBfrvA3WnyVwhESGBA+iHult8qBctEXvMK7D39Ojh7DazmNnigGp/va0dRq8RqQELdlsSIUiw8jX1bp0VHpl4EjvLKtPAiOuFVc1pnI5Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzy1fQMa4bfK+8ZN8cJBqEjNBCRx3Bkbkd5P8VK4mwA=;
 b=E7wx9xqgME98OOlO6zLCWlbJpWt934gAMhGc7rgTQtMeDdjnJQCy2hxPVIpwXc+R7UO4qCFr8H/VIoZnvzuVfhswo3yRFdqcLp2xPNUfcolnaIujvFGJEBQz4UXuFyxgLQiI10tGrYSxkAZ2Hv41ckDp5t2nxnuLTGbD4msPqH4bFbqBPtX+1IZX63apx6xvt6Ud/iC7HyA+dWKUMAnhgYNfSWG6S1k7M7wU1sRDwfOFeg7qVPTK8ByBs/AnXXc8IaK7FvY4ohgtBmKSc0BkszQcreeAc0Rvrv2G8Zz4BV4TURfoOTQxvT3yjCfUS2sgbpLXqa8x0a0WhoK9/KSw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzy1fQMa4bfK+8ZN8cJBqEjNBCRx3Bkbkd5P8VK4mwA=;
 b=Dj1SU0CE9x2CQKXmP85eoojgUfMPjEL6vVGh5EW+YQNfjXu+EbhDZWiFweYsbf+rl7xSw1MHIBffEX31nwt8HnlAH+Rh6wHzNyNWNwkYM8yLvuJPSORbp3umM1pOYFHFOY3rC8SHPFjmDgg6A582X1jtmt3JiwGle0zadwOuITU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5856.namprd10.prod.outlook.com (2603:10b6:510:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 02:56:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:56:25 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Refactor ufshcd_hba_enable()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1eduekvcp.fsf@ca-mkp.ca.oracle.com>
References: <CGME20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
        <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
Date:   Mon, 07 Nov 2022 21:56:12 -0500
In-Reply-To: <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
        (Keoseong Park's message of "Fri, 28 Oct 2022 16:35:53 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f8aa2e-2bf4-43d0-8a02-08dac134d2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE0de5D2WPB3w+wDzeS4Q6uF9A9P/dvqDvZauZacD05l+B8UGpxiVE0DEW7zo5r1H5CHeZiSh8GwtGKwBQPDiMXzV7zCjdBUuX7p7hYHqqMnHDkGlQbLxH9NNuiz8Wj/HWiOsVwJpZC84DCh8GbReoTTDNT7IX6+xE3D0dis/joHSTBR1wJWJohTg+m2y4E4YMgNMdT6l8YY6E+BzkWyWLPzH37Eue6y0WrH2ReCKdQBig6J0xOEF4ms4JEP5IjEKIgb7Llg1B4o+ZLfFgxP+TAWQFgtZOpmWNTXxtopizxD8hI3qVDo6HC7is5//LpOrtWnkb8df7YwwmxxYAoNHpekgKGbr2PLcKYZiVvETOo8dRSxDQAJ/vZM99vlImIHJsZ91QRi+aEzobqywIzMHtbzv2cbwZ46VkoiOAp5IjhFbBhKGih8t2edHDwCbRi971NQXQzcHz8K7Owfusllr6bxuFtM9E6RAyqO0EW0slR27OmCGVY9oeVGfZwRfw4P56K7CzroYPRx6xJbc2cMeCdOSUbSBwmqsujuJqriwoPtbLoNq0Vj+M7yH1Agk5rcPWouasJnXI3IGPsl47w0w8RfcKefhASCB0Tc8HhX67Rjw3UP81MpkG9kj9v0ie1A4gQFscw/UEUghCc9wvujjF47j4zgwVgLrhS7eEztXyeJTvqnzvbyXH+70N7fwdItMSp2WgNuQxDFD4ZAmoDvgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(186003)(2906002)(558084003)(6666004)(38100700002)(6486002)(36916002)(26005)(478600001)(316002)(6916009)(54906003)(6512007)(6506007)(86362001)(66476007)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVEcPcuO9z0K/upcVTd2jFZGzI+Ztlk5ZBeQ5gwdCV5XwNogib6agCGNa/nS?=
 =?us-ascii?Q?pTVtL7ITSDpJpa9YLHDJOdMc0QOpLGKo/8Hay5k2L18jHbNMAudjMYzfmIPL?=
 =?us-ascii?Q?eMqnQi7hUK7ZLki5IWDOipqngXFlAQScwr3iKJEuE32Yjm2NO1E48I3Ka2PW?=
 =?us-ascii?Q?99TYSvs/o8rj4cuHLqrxltQNdBMUvzmRNRAXPlekjnHzOe470ccrR8xJhWOI?=
 =?us-ascii?Q?KhtfwBUjWrnRnCCUTUbHOMTwJ7yBpKd5SWjzdt/RsAdHq3HsluV5pRdIYPTc?=
 =?us-ascii?Q?YPPQUnP+7wcywS2+FQr0DqYGvA7DH606XdBPoZBxNka2CUqAkbRuv6isYuPI?=
 =?us-ascii?Q?FEKswBK0xV+uB0+ZVhEDpQ5cwrhh/aVr3ryZ/mzctCr7D2+cPucQuyeUFFyn?=
 =?us-ascii?Q?W2xpWq/o6yNrMcslIRejEJ07Yh8xne6a0mcbT55E/Kaa6+aGlF7UVMJJAeQn?=
 =?us-ascii?Q?8CDhvBlUEWsjbYVMm7WGFd7VtB1m32gh4m701Rz511nhpMiL4PSmTFNu9XZD?=
 =?us-ascii?Q?8O7jmJCUdrvYEf29SXemeP92fp53klrgfhZQrs+m5mvuUdTvSRSM2CFwrxSP?=
 =?us-ascii?Q?KkmqLOO/IaDJ2ctf01lOvGudplZK1lFZDYD//ugdlmTOOSsjJGZ4S2NlZl42?=
 =?us-ascii?Q?575vbgqT2IEUkxlF7VyqEeWI23LszIHW9IzOYzHIgkf9cn5xjzgOj6JD/GOf?=
 =?us-ascii?Q?E2QhMZ9Btq02auF1+4Wdxx8FrjgDUerxQeAtvE/CBkGLtICIh8wO3QEkIuz+?=
 =?us-ascii?Q?DQBebust5xlDwlhR52wffh0p/HyvWwHkczY9S4deWBX/mDF0v6Xd5GCs+RbX?=
 =?us-ascii?Q?+I0uq/OsbDJE4f23JU7ui4zTvE7RwU79VqOaUYmhmbJ7FNNjByYYO9Ri/1Zc?=
 =?us-ascii?Q?VHCTOQ8C/xAvpQhsSEliSe5FpJESbKvKO1Lu80mXgZ1EINnFgfxhSrL0cdDt?=
 =?us-ascii?Q?05+/ClP7xL8FUZl0gFqyAVacVn8TSBhMgWyjS2X1nCJz6R+V3rL/n0ZObkHO?=
 =?us-ascii?Q?yNraYOSIFIw+9JMYqhhXM3HeVpmA4fPe+rRj2Rvvs864BTycAUjNmfJbtiBW?=
 =?us-ascii?Q?fdtZKvV0uk0QP3QJlTk1LlBV9q/Fh8saYtvCs/5jepv9YVJSjKYWenFeF8yC?=
 =?us-ascii?Q?966gQmJFnbp5Gi+auLw2Vp0IK8Mr/qG3BUHUZnl6hgYVIxKhwjlSBSj6qRul?=
 =?us-ascii?Q?cUJPceKc950LLqNUnoCY2kG3V5R5w5SDSEa8wenNxi23JhdagrGJt9JSApeg?=
 =?us-ascii?Q?brAQo1XsAH5nmCCnfPCZpwXbT3u4Mre6Mh0oCHtcZ1QUq+RBZBQIX2a2/MgV?=
 =?us-ascii?Q?MnRBJSweKlLW1wFGnWqpBHbgQpLiz+W7hOYN7CnHvRTi0/cAczn82qcJq6N0?=
 =?us-ascii?Q?OTslB7EnX4lPIzH6bQlbbh17xZF32aisIOkrEnMjTrLBJrPf3il/fJYBqgC2?=
 =?us-ascii?Q?vFxhsZvl8MTqyUP8WYe8G2TLAcqwYcqlBwwZr1/JOoixI4EDLe2efMt9Q4ma?=
 =?us-ascii?Q?S+7yd0+NKOSk4NhbvoVyYJxfWCroBB+4Y1vcB+LVwc0g6Yk2ottdvnRF714H?=
 =?us-ascii?Q?5AQHD4Dkjt+slDoQsbbyhH44pswgTLmlsTlepp0a+oWXmsFNyL6XL4qWF5hA?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8aa2e-2bf4-43d0-8a02-08dac134d2f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:56:25.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG5PlANGCdTyWXDfSqaqI6mOFmNrTkNGwH4pA9uw2IDV9qDN2UKPfwsHxAk62poJPfk92N1K0Qod7mPTnEE7t5Z1ZKx7Z22lxBHhLJgmrW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=773 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080013
X-Proofpoint-GUID: 1vtnlH_rZbQCIA6aDLemN_QlWsnCSUhV
X-Proofpoint-ORIG-GUID: 1vtnlH_rZbQCIA6aDLemN_QlWsnCSUhV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Use "if error return" style in ufshcd_hba_enable().  No functional
> change.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
