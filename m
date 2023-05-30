Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39C7154CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjE3FRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjE3FRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:17:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8913AD;
        Mon, 29 May 2023 22:16:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TLO5wH016233;
        Tue, 30 May 2023 05:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jFYNhLU7mSl6uULfvG50Zk3bo+s1v7ejXKnMu1UNWLY=;
 b=bEvRMSBkhfQtp1hYNDIZu1QVMIgHewgRMSUSrnDQbRM+d23voNEA1iHm6H21kgvCMMIJ
 B4YjnkzP1xguALNWxzEOlM7chJgrkHVikKDkc0H0wCT/a060JJdw54M0FmttJHsMloT3
 CVzTvMebuX03Bkks+6ALJw2RAEKB/SqeefCTYFntmVOdGiEdhbihgr6Z3XVLyHJwk0gz
 Ubg1QTmG+2FWJHdNPXSyRnw/lD/j9fVo8JCpOPT1+1FfMGHz9HwWTxitoC+gMN7S65u4
 LO081DTxuC7nef9KW4iFmpvF295z9IdDYjDfLG7/qATif1kLyBBIbx+5aFgUcKjiFd8q lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhww9sx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 05:16:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34U4MFpA030150;
        Tue, 30 May 2023 05:16:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a40263-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 05:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ats1+uoqs9lpZ/j/jA09egwN8I0LesoGXfLqmncw72xMvwOnqXVObUgrwzvepcHSMJ//rHXNeNBCSEmSznhaMIOgAYv7vzJAxpO9Q9jIoHi70K2IZjgCfq3NndTa8k91MyulaNVhCOmkVOFhN4E+ESupqT3dVZMaUeejrH2nHyr+VMWJjNRUPtw/DV6Wz8r/8BFdw2wYp22F+oTNRcFH6vJvBpGQv5lWd8SAEH/28JMnZDPGqMXFFunBnij2eSQ666+E2v68Zka04iBZNLIyec6HK17HnkfEcIyebKyUOcLtIUdmL8zIsrzVIXjK8s6O390Q9eXQDkR7JKZ0ABKHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFYNhLU7mSl6uULfvG50Zk3bo+s1v7ejXKnMu1UNWLY=;
 b=GOxsn6XP2arCNuUw3BKeC4ghsNWCDOonNkRLgQXlMWS4al5JG/kz7pzrb/Zy2btuxwQmXOkpKU9lurilGh0Rxb8usS+U9HJbZ2jpFonWYRYeIHJ8OP2X8WiWB8lHJX2CaBCgIRi7PmME83bKB3HwCfm5783uO0WpGdE0bq8ghauuU2X6ycTW6trpYGVPdJWbdJp1U1zp9Q2kkKutt/mDgy7SNgSRoikpy6bthowEJeIFbtIKH1bnEpQIub0T4jE9GhN4Rur5tr7oW7gkyJb18JHxmByZnTeVd4wsS9aZFNn54JYaS3IE/gl40cus6lGn/66IXeq5nU0eNGpS28OEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFYNhLU7mSl6uULfvG50Zk3bo+s1v7ejXKnMu1UNWLY=;
 b=T+HNPuE8sSE0nJn84eMLnjYGy7fXTEm6CaIbBASGWrZ8D9wI5PDps7PAxUMUZPM7YVpSaexzy4g0unRZOd9eKOBnsBFBUVeOR73d/HtZ9j2DGsup1ttroi98TqsHDCFuOWdVGm3HDrjYUwVmMqWc4ZgEZyTlYaRUWwPKXoK8jpw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 05:16:09 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 05:16:09 +0000
Message-ID: <11360a4f-381d-ab8b-e319-659c3ddb1d98@oracle.com>
Date:   Tue, 30 May 2023 10:45:58 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 000/161] 5.4.244-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230528190837.051205996@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0034.apcprd06.prod.outlook.com
 (2603:1096:404:2e::22) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 110f7d1c-0eda-41ae-4c85-08db60ccfa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i87Sn50vftogBRMspTcckFOaUULVAPAsY1NQ4fHfyTR75YuAxa7l0XL1/sqjmACm0FDOfb9ovRp9gpj3I8Nvgjo2de7oU5nBDro9UQwONbQUUDuUnoOtX2xgGCY98nOOiy7Sj53UjbZ3NTcvlk4nBE73j7Lj31ySvaTIcZ+GvHlul+EHgbPt/MyEoustFyZgihcbxKuZVitgWxdS400DRC+Ed+naUlNQuKv5l529zFd6QSwpWEpOPRfrWj0jcmO6oy7OdOX3IhHrh4f7KDe0kINoguqCiEXNa6HXNDi4r7GCQq3wQHBZJcYxMshavJmvyBw+JrNqbkWxzsgtb88v9IVqWCLma+qXVpkIzgKsxc3d6QSxyLcFriWYSGwsU8VB46iy5id0fEjnYhxKikHf0PYQeEDZrpLcIYRaPA3puwVyGsAsRaPG1o6lecSovsjDtGiHxXJn+LY1oZFjrrD1GEaIC/eqlNtTv7QJ9h2+0TXdWC0bLaAsqhgZ4J+PiTK63e5wQyJZ1wLUw1egoJMhrVlwjOwGmGGDuxBo7zW0gVERIXmQKXa+hs6IxYlhD/C67WvUt8FsFzxY0EKIbMhror/SjZ1GqmZ5VhbUz0+ywoCRkR2VlxQ8WoY7Ld0bY1ssAHVt12pk1lujdNgDlpWI+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(966005)(478600001)(5660300002)(186003)(4326008)(4744005)(86362001)(8676002)(8936002)(6486002)(2906002)(41300700001)(31686004)(38100700002)(31696002)(6512007)(316002)(6666004)(6506007)(26005)(66946007)(107886003)(2616005)(7416002)(54906003)(66476007)(66556008)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTgrdEc1R2xWTEhDbWFzMzk1NUU2K2pHMlNqTS9kWnd4THBzUHB2cE55QS96?=
 =?utf-8?B?STBpVHpEVmc0YWxka2M1K2xsMDY5ZUEvdUNSWWxxMmRUOXVVN1VFN2ExU0gv?=
 =?utf-8?B?bTFaZmRwYlBnRllhbGpZOXB1VEhGZnhvVXVncjY2RDdMYUJHR3BoNzZ3UTFQ?=
 =?utf-8?B?Wm1aYzAxbjZRNlJtaXZsZU52TjlQdlhaU3FaL0xFTmhnOVNnZ3RFWkdvcTJj?=
 =?utf-8?B?UXpnT2hMbWlvSThWaGw4VjZpbXRiVWZSaGZZci9qeXZBVnI0amVVd2JRb2xn?=
 =?utf-8?B?aDM3ak9KdDlubFpWQVJSdmRSaUg4dXcxdkQvSmpqZFQ4SXoxNGpON1AyTDZD?=
 =?utf-8?B?dmJvZTFZSEs3ZVpvaStRaFhVZVhVUzlhek1VdlVSREUxTmRLamQ2dUhMaExo?=
 =?utf-8?B?QUlVcWkvaExHNDdBVjFHak5OajB4VWI1OFRmdE1jajVNcVJZL3F2MS9zV0pr?=
 =?utf-8?B?NElxamw4T1ZNZnlnNC9ZSVkyWmtRZ0xPNzZFNWFZeXpaQ3NuSUVqMWxXUXBa?=
 =?utf-8?B?dVlpVWppeVBBeEgybFQrSUkxemF1Q0tDaUoxeU8rMG9yVWlqblNFNkxtMGVa?=
 =?utf-8?B?NGh0c2JrVkhwS2NOQjJjaGR0Tm1zTE03Z20yNmQ2ZEZLVTBUZEtza2EwYlk0?=
 =?utf-8?B?c20xMjQ0cms5Unh6SVp5M3RaWmF3Tll0Zkc3a2krMmUrMFZRVmRENGp5NldX?=
 =?utf-8?B?L1Bvcmk0M3JEZ0tEd2JiOEVWVlpGOENNZVZtb3Fjckg0dHlZd0JzdWp0RmE3?=
 =?utf-8?B?L3oxN29CVEVUK2h1UysrMldjdVU4NVRYczZwN1QzRkc1UTZxb0tCSUxEdE4z?=
 =?utf-8?B?V3lFZVNsZFRWbHZtWEJrSm1SMkkrL2E4S2FhMVNEWjZNSDNPN3E3Vjd0TC8v?=
 =?utf-8?B?YnpOblRtNmNkc0ZXY0QyWE5kcS9iaWNJcmJSNjVpNy9OeGJKWmhNYmdIQ25r?=
 =?utf-8?B?MnNXalpuL2V5blBuTUtUenR3eXk4Umh1bWcvcHdOT1NhUGtEbUZyV2xTbk9t?=
 =?utf-8?B?emd3ZGJWNHlYaEptZVFhaVlMbXFwU284cW40alZtWmszNzJydGp5VGYvMzYx?=
 =?utf-8?B?d0w2c2NNd1FQdERnMG1rc3F1b2tXclVZejY5dzU1ZXREc3pYOHV2WjlvN2hL?=
 =?utf-8?B?NVpqWnBGK2IwcFgyTW5Lay8vUG5NMTlORGNUbkx2OW5kdDlDOXNwb0piVm1Y?=
 =?utf-8?B?SDFUUWFGRGhoQklvK2NnamxkaERwZTBMQWw5Ky9HTzRjNzJ6b05tT0g3S2Yv?=
 =?utf-8?B?Mjg1YzlyM0s2WVdIcDFBMXlnSERNRlF4Q0dLOFpCdFR3cXRNaDVMY0N0Szdi?=
 =?utf-8?B?MC9uL0cyVGRBaGRDYTJuM3VPODIvZmtZNG1TM0wwMHlGcmd4WkdTTnJEeUtU?=
 =?utf-8?B?L1UvTUZWMndseGJiT2x2NXk1Y2hmcWZoNjhrNkNoZ1ZndFY4NjR5OVVBQkdj?=
 =?utf-8?B?SFdtcDZZTU5pY3pLWkd1S3FNK3ZWYnd2T21kUUsrdk5za21ZYUhCZkg3czBa?=
 =?utf-8?B?dWdzOXlMWVhzM1ZPY3FRR2lFOXgzcjRDRE9qem4wYkRXQmZPejVRQzhid1FJ?=
 =?utf-8?B?amxQTFBKdW1XQlFQNkhWektWQ0JOcklKOGtJQjZMb2N2azVzNGxTbFUrK1NL?=
 =?utf-8?B?SDYzcXlFRERwbnh1R3JWYWQyT3ZMWFdmc0ZEejQzRFZnMk5PYlBNVGduTTJQ?=
 =?utf-8?B?OHlTR1BlcndRRzlRMW92S1RCazV1QlFEcis5ekVVVVFNQ1dreWNiSFZnUitK?=
 =?utf-8?B?bjhkYUk4bE9uWjk3bUdKdlVhNkZqQ0lNdERZRmI3SldkSUNQRnZSODFjNVFx?=
 =?utf-8?B?eU9leEhBNDRuZ0tRREl6dTh1aU1pNDNxMGovdHhQRTltN1I3S3BLcUlIdkh1?=
 =?utf-8?B?eFRCMFRKUG5yMWRMenpqNXE5UUI2L1p0d0hheUJxRmJpUW4wbmxSQXB4RkJ3?=
 =?utf-8?B?UURaWHFnWW5tckQ1NER3M0NIdGlRdTZjNGp1bFVsbndPTXlZcGt6REJxR2FZ?=
 =?utf-8?B?ZDk5OGNWK0lCcWx6d3RscWNCaVZ2cHVaaCtDNS9JNTREbHp1YVdobXFoeVdJ?=
 =?utf-8?B?UGxCWkhObXFCSFNiMjVEblYyS2E5VXFoRmdLY1JBVmZBTzF4MnFWNlZVeldv?=
 =?utf-8?B?M2RXY3BPTzVXL2UwemtrdTVtZ3h4ZDBPM000Ykd3dTd1OVBndmJ1cUk5QkNO?=
 =?utf-8?Q?VnlTfCXu8sQik4RS7UaaqyA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?akw1UlFtQTdNMnlhNW9QWm1xbkhRRDF3UE82SFZFcFNWbExNTndjaFlMTEw4?=
 =?utf-8?B?OFBMeE01Z2FkWGVVWVNHSVQvZitmMVNrcXN6VS9pMjdNZ0w5MURVUGNoU1pl?=
 =?utf-8?B?d1dXS2txd3JaY1RPY2t6VDhIZTMvMTZUc1Rwc3U1eittL0J5K1RoM0paaWZi?=
 =?utf-8?B?MFdlZ216UEUwL2M4ZWZOeGVhQ2RvNVpiSjRKZ2piRktJY3BSS0VSVm1XRDZk?=
 =?utf-8?B?dzYwZHd5NFJYUTFVVWZNZkZJUDN4aXRnbnl3Ryt0d25XeGEvVDhGc3RaMGdx?=
 =?utf-8?B?WHVzMUdDMU1qSHUxYVhKRjZyejFHMTIwL21LUk5FYUtTMUFoaEtjWnpKOEov?=
 =?utf-8?B?YjlBaEFXT2xWbVVLOVZ3dExwWFFmUzJzZkJ5QVhLNTNnR3Q1U1Bzck5EWWFZ?=
 =?utf-8?B?bHV3OUIyVmxXTW9jVll3WGRtRnk3T1hFOVRPUHVGRHFoVFRzN2dYNTlBaUd3?=
 =?utf-8?B?Z3Y4Q3JSZm9kM0RrVVhxZGFBTzBBMTF0OWpKMXBaa1B1RVl5LzYxRE5uUTR3?=
 =?utf-8?B?ZXRLTGNSVHhpSmpNUUR4bEo3Z1JsbzUvUE9RZ3FWQmgvT280WUpOWTArT3ZI?=
 =?utf-8?B?aWtWSW9WM05URHZxZ3JiTU9GK3lxeEZCbGNTYXcwUkhMSU5uNndod2NHank2?=
 =?utf-8?B?QkZVSDBTVmhkV2FqREwrM3RrbnUvVGFHNTFRUW95dGltUzRud1EycWYvbXhM?=
 =?utf-8?B?Wm5DQmN0YkVBUk1xUHkybE5IUDFJd3pTN2xRWXExVlhpQUNiODJwdUlDeDFS?=
 =?utf-8?B?WDlCU1E0Y3ZJT0xQSGlySlYxOGt4TS81UGdjU2NSeTgyV2ZWNUYrU09UelpS?=
 =?utf-8?B?YkE4VVJhRy84TzBFVGtFWnJIeENBeFBvc1ZRWFN0TjNDN1BzakVEOXp6YXJG?=
 =?utf-8?B?a0FEZmU5WVJBVHduU2xQWjJKNmo4alpybnN2TDA3K2JrbFdPbnRkaEdwSlZQ?=
 =?utf-8?B?ZU5qdElZYTV5enREK2F1RllDdzBBd2JkZUpJY0tVbStyUWROSWpud3AyZS8y?=
 =?utf-8?B?dTFSN2pKYTJpbi92bWlPSVIyRm5JTzl4bnRjS1dGbTI2K2dSVS8ra3N1dFRr?=
 =?utf-8?B?T0N1WFIwVkp3dG8xejc0MzZrbHlIT0hpRUllZDFhN0I4RnlsSnQyVWFwZWkv?=
 =?utf-8?B?WTdmb2tDRFRsN2V2cnY5Tk5qUTRId3lhRlpiTkFxM0NHaVBjT21ndDY4MFVZ?=
 =?utf-8?B?cCtFZTlyaHBmQnJma1FrT25jd2hya0FnMS8yMHRRRTNKUU4xbnZkUFcyN013?=
 =?utf-8?B?S0JEUVRDWmtCc2JjT3ZIc01ZZC81dWtiQVp6MTBuWlBVK3pFYmNUeVBxcFRq?=
 =?utf-8?B?UDQ4ZlFlT2ZKeFphclkySkRZNEFoekZBVHV5c2djOVMzYS9USUdFclRKNzJs?=
 =?utf-8?B?L1d6ZzNTUGR1Y292M04zTnNsck1ybkYra1JCeG1Ka0JESGZCc3drOExPN01N?=
 =?utf-8?B?M0xMc2lLdHZkb3JBK3JXVkh5aENMTWlGNmlyOGlVaGYrMVNJeHVxelU5M1VH?=
 =?utf-8?B?d1NjS1dlZEswLzhmOTAzbi8zeHd0YjRMcjJXWEtIdzN0NjhrRm1mUTR3VFJH?=
 =?utf-8?Q?LZ8JXrruWysVNN7WGXjxvXxwwprstMyj0sL+6FjniuGyv/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f7d1c-0eda-41ae-4c85-08db60ccfa1a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 05:16:09.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XfuJ+5yPPmKZ8iIWqYreSJB2xfTj34JiNlspziLp2FRQ0MsFW0ef1mU9I5dKNe5mJbPl7WK2k0e8EeifatRok5kaTbwis2I10lER1wwDFozIpsOw9K35rWuj+8tA5oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_02,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300042
X-Proofpoint-ORIG-GUID: xt3ZMeI0F-9vQRvmxr3cx3dz43nKweFT
X-Proofpoint-GUID: xt3ZMeI0F-9vQRvmxr3cx3dz43nKweFT
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 29/05/23 12:38 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.244 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.244-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
