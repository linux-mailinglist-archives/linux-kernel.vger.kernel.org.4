Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEB7367E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjFTJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFTJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:36:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491CF4;
        Tue, 20 Jun 2023 02:36:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K0ZRZ9002241;
        Tue, 20 Jun 2023 09:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wL0ioaBAHGiLFJY1lCjEsNtMj+30h5IhyETqZyj6od8=;
 b=zLmiME2TSgGLqhq7SrF8zkbFsuJcLEmfPIJsb+dkx73YwUU2ULge1DEntsUOfpI2JQZb
 t9SGK/CmBymJJcOKMxTV3JBk1PLy1vkP/87b7k3VusAFYysxUkY5wKSgRrAOp6zaITBE
 stPEm5jsB9phSvmUKLOXJ+rvDHKOx2Nyj9kzU2a11YDiWFcOAx7KpOBr2z+rWCHxLXS2
 Lo3m0zeBV3eBTx3GlwJsk7gVR9r+pasEcvsxBSqoiZ/WX6MYA3xEXy8EX1rCCF5HpYAn
 vj5R+Cx2oWhqddngsoYLNEChHyeplcGDoDI+5sFInAPtikjuCw65d15To/aND1hsCuch 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1c9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:35:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8B8Si005840;
        Tue, 20 Jun 2023 09:35:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939441m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 09:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs2SronSmhOKZDdepeCV/4e+F50O0HWJGXsIAuE2NNel5/sMHlaxE38ftoTFI9BKra6BClzvM6zWiMQL3jUpfC4kTu/k+RIT4ErAs+LDXskaqfV9lJ8hwZdOgcvCTCbnRLqW0ZY6hwCpS+UKUvSu8U4CXrynlXuxVfX2hY0sKIrUMhA1B5058qJztG+yiiFXlwRsNV+zCIDokqXZJ8HA1zUnYZLv7K0zii0EKTn3Z9Lbfs9PR4sMWPAQa67aXeQ3jfuNbYYEhiCIQ/Aq/sUJysXJsMhunIIf8yby+P1bSEigOpfeN4yRI3ry+bLtxcKvst8bcEXUJ+8ED0yzctWkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL0ioaBAHGiLFJY1lCjEsNtMj+30h5IhyETqZyj6od8=;
 b=mDh/hQ8nN8fghu/+O4AFch2ew//s64ZEpCQuqdjTSYKjla0XcbmDIXful87r6yEfsCK1cHgNP1RUIHZfYHspO5fkp4I7B+HfQjA6aCTNklel8zzslVTM7KMyR2ioTdW+Nr6AjKZGtIbB/oBWt28cY59T0PaZegXeNE/dT9Oi9U8VxswfmHlTGMafKfez4gbogI/TOIoTHkO3crioRXo9YseOCpwUIQ0NOfyCi3hhZutPM8pMiqmmRD1Nv3aVJM133J9weDWyGG0IKELCASo3SgkOxD65gxK/dyyByjjwJ1vpcH/NYw6nU+WESOZvBwRsBcWu3v0Z3OQqUoHTS7V7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL0ioaBAHGiLFJY1lCjEsNtMj+30h5IhyETqZyj6od8=;
 b=rLqwlwH16xQUOoG/8ILnwEXPiPlblqASsTPbKZ0IhGKeEMxKkj2wNXEHHib7IT+1mkpo/XPF3c8wdcJAabxpyniV9edLaZUVNFG3/aqhHUtAsPmnsPBk5SfsRfXcNIsjRNrS5NypQi7suvyUPvVJd7XJuLWh5cHHs3ebhLrKFLQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:35:51 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:35:51 +0000
Message-ID: <7f571da4-ef68-ad00-341a-e02a5f62a06f@oracle.com>
Date:   Tue, 20 Jun 2023 15:05:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230619102141.541044823@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: be97adb5-63c5-4e54-450b-08db7171bc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/IAlJnapnRPcgHYWjubE6kXo9SgJqzJHunqs6mUXCrPxPgqkD7mBbhDG5yxrAOlidavgkKIUebZ3/0gwlMzHHAkeIii/ng6lU6cVudsXtGnH+upt1Q2v0AguNeK2j1EtRm5W8B2UDFovNCIJNad4lGgmelXDzYavAjuFc4MiVkLu8ViTCZkfw89FTbX6OEIYhsoM1rsc0ToHZriDF3VA8M94utRUkRDh2AvsLVnVacZva0srYRt3PEOtsxLgtjnrg6vCFwtRV2X67hKX4YwGLwU1GxiNy31BIlXsj27rWEImlKoZOx666g/wDxrzodlBo0hr6Oqvuk38ZJ9656/A8Ds/9pMf5q64D5TLbWC1erNU75smNNngs3jKPl87SEUWHrzn+9LHxVuLdzizBBVle+RHhOiEh7f1EbaW5Lru7xJXZT5qq7KqqQWgUzuSHd/vkCtEcDDTyNwWF17EsMiYLl5hujUBa4eRqvLqGpbZ5A55khDdJ2rChR/FA0HM2SbAk9EKP6WtPt5TuR45S6RinJg6AuZuen6bnR52o6HmIa7o1O/VkMHnn20llh89gXzBG8THQjyzwq6n6n7KrUuwLw2VVvjLUsW2d6p7AFOkDlt8zzVBFrnpTUps9KiKlAvPx14WlWVgUWWWHJMdRKyJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(5660300002)(31686004)(66946007)(4326008)(66476007)(66556008)(316002)(36756003)(4744005)(7416002)(2906002)(8676002)(8936002)(41300700001)(6486002)(86362001)(31696002)(478600001)(38100700002)(6506007)(53546011)(107886003)(6512007)(26005)(186003)(966005)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9wUUUyRjY2bXk0VzVmaFNoNGF4U2wzazNVOXRuZlZkWnAwY3pjSW1zY05L?=
 =?utf-8?B?Y2cvUEU0eiswb3BDN1dyQUQ3MDJ4UktHQWRpKysxRkJzdGZGeitwaC9iS21x?=
 =?utf-8?B?NVl4c25pa1c4ZGgvQUhiUWxudC9WSmtDME9RWm0ySlRyekQ4SHJBV2NxeWZn?=
 =?utf-8?B?L3lDSm1iWjlxYWxkZXUxS2xJd3J6UTVXRHFEQ0F5OFdWQnNra0xTZWxNampU?=
 =?utf-8?B?OFVtdERheHkzekpSNzJFWEtBSU5GaU8yWTdTVWpyRDBZRThNaC93SjZFVlF2?=
 =?utf-8?B?dFhNSUd6ZU1zL1R6ZGt4dlIraFVSTklZR0RLcE02dnVGc1NpYm0vY05SeHE0?=
 =?utf-8?B?VldheW5KUTFVTTViaEd3MkJuYklJVythdzMxOExPQnUrUE16bzlSVTA5eVNn?=
 =?utf-8?B?YjBLRHUrRE8zd3dJYnUvRVV6dzduRGdjK3lnZi9qckhHa0FiUnFwbzVZdUxo?=
 =?utf-8?B?aEtaOTdFQml1MjNNMitpQXVrVTNLaWxFdGJ4WTN1MWl3Nms5ZmlzMFhDNzAr?=
 =?utf-8?B?aU5Cb1lxWlh2OW5kVGpFL1NOSDZvVnRtMWw2UXl6Q3BvbzArS3Y5OU1ZVkZQ?=
 =?utf-8?B?WlhDTVFDVGNDWUFKQVJsRzYvWXhlTGtGNmMwMDR4SklUa284c05BQU9nLysr?=
 =?utf-8?B?bnFHNWYyeFUrdWNFWFFlQ1N0ZllqTzNETE1uSko5UDR6aG1MOHNMWldvaGpp?=
 =?utf-8?B?ZjR0N0RKNVZDVnRBZTVYSzRYVWdrcGZXYys3RFdTUTM4NFdpdmZmWVQxaEp5?=
 =?utf-8?B?TTVNbHRtVGZvQlVac3M5NldvU09hVVVOTUQ1QUVjd01tdWI5d2NoQmdLK3hP?=
 =?utf-8?B?VklURVVJMzJXcUxVQ1J2SUd3cjNEMUxQdDNZR0ZLcUF0RXpVQUtnTVU3Y05j?=
 =?utf-8?B?SWhTWFF4c2c0Z0JEaDhRY0RvNjlLb1l6ajE5RmxGMFBLb0JKWjhDbFVoZFE5?=
 =?utf-8?B?dndYMEpHZjhabDRFVjRQa25PNmpHYVNVbWluRy9vUjhHWTdEL1VQZUdBMGNI?=
 =?utf-8?B?OVc3YWdWZCtENmx4eUNQeS9pdEl1SGJTQ2ZjMk1lSklydjR1d2tDaTE4RVEr?=
 =?utf-8?B?STVnd2swZmNPclprZG13RGJJSmx3UUFQUjdrc2NGYzdacE44T25OK216cERj?=
 =?utf-8?B?WjF4SktoOXB0YlJOTi9LS0NBRmlXVVJaL2lERHR3RmlyaVJsMzNEVE1UeTBs?=
 =?utf-8?B?ZlVIYmdUOXdlNW83d05naWUzMVNPTUVYRU1vZEkwNFRtYmk5UkVRZm0vYzlI?=
 =?utf-8?B?V3pHZ3lpUnJMdjl1Z2RtZmVGU3k4dWZxTlQrK05sY0RlNnhXTEJvSWJUL1pF?=
 =?utf-8?B?Nk4rbGZ3a0c4VkVQV3hnWXRTYmtYR3I2c0lQOCtJU3l0RXpSQmg5NzMyRXZo?=
 =?utf-8?B?cElhNmw1N0haVTcwdmJOK051K2QzdnZ1eHhCNS9PMG1adG5VdHl4dzNQSlBZ?=
 =?utf-8?B?YnZEd2lGSjFYZ0lSNHBhQkxpeWsvcXV4U0JUVU9GS3dTa1l5dFFXYk9JZm92?=
 =?utf-8?B?MXFFK1F0WHBjMyt5enNPdG05ZUhYZnRUYlBLOFdRb1U1T3E0RWJSNEZkNS9M?=
 =?utf-8?B?M2s5SkZZVHcxck5IVFgrMmNrckMvcnhUY0hzZzA4cERuYlF4emp0SHZENHN3?=
 =?utf-8?B?OWk5M1RCSHpVU0pXTHJVM2xBb2lNZ1VzbHViYmdhT0VJYjJpSUdkenhibXgz?=
 =?utf-8?B?WTVrUlNESzd6aVEvcndubGhUT0FzM1Y5d2NscGQvODJOY2pOWWVibmZacWFL?=
 =?utf-8?B?SDJlT0R1Q25wVHRIV3NEbEJOT1BoMThSMm9RVitiZjZ4NisrYmEzeFl5Ulo5?=
 =?utf-8?B?d0RURkVWZzN2dVlYcTNQLzNZRmtRYWR4SVVrUFNqSVROcWRIV1YyeGhpQmhV?=
 =?utf-8?B?RXdiSTd1Mm4yNlNNQmQvTk9aQWRaNytaYVpxMU5FRU96cXlrRzQ0a3UzbDNp?=
 =?utf-8?B?bGhZOVYvTFRxTTdGaURGeUdJUTVpU1VJVXJaZGlQdHV5OUE4ZTVxdVg2bWRM?=
 =?utf-8?B?M3NOb0gyenoxeHpXakFBa0xhM3ZtMXlzZVphczVVMGFDVDRrM2p1TGlDTHhw?=
 =?utf-8?B?R09jU1lINkM5TnV4d0RuR01FVnhSdUIvL2MzcDJWZkhZa3lKK3RQYzlnbHAz?=
 =?utf-8?B?L0pTVjlGNjRqSTBjM0w5RE1wUTBScTBHN1lva3ZGVVdpRk5QTW1WckFYZDVv?=
 =?utf-8?Q?XirLzOj+G4uLSS2E6AkVfiY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDB4U0x4TDdIWmRHVVNpZ045M0NWMWRJR3lHbG9SeGdRMkFJWTlvSkVYeGta?=
 =?utf-8?B?ZUFNaDFhdEdwZVVoSzIwTUVGdEcxQzBVNXR4czVqNE9OeFBxc2FaeHhsbHk2?=
 =?utf-8?B?dGJkZk5GUXZ5cloyTkJ5NUQrS05sMzVXRG9acWJ4V0wxWndZZTJVTTZrRnBY?=
 =?utf-8?B?S3VqZ25OeXA4bkQrT1JUSjVKWjJYTkpCRGhPQ1VVeEI0c2lFQlpoSng4M2NR?=
 =?utf-8?B?YjVsd3BuTDd3R2swek8rZ2JiQklLNisvQVBKT1Q4TEtKVEN4cDRNY0JmanpK?=
 =?utf-8?B?elEyMEdQb0QwMzBjTUVKb0VkcEY5aDJmSUlmVS9Jc20wUU9MU3l1VlRVYUFu?=
 =?utf-8?B?YThlU1R0bTFKczJxZ2VLQUREaXZ2dUZITUh0em96RGUzMUwvSTRKRmRESnJH?=
 =?utf-8?B?OEdpbWt2dUlwdkN3ZUQrSkthYmcyMVZNcHJsMEZ6MzZOQnNtRy9OUXo2MVQy?=
 =?utf-8?B?QjQzZGowWjVUWTBINTlwUllVdVBlc0dsamJPREN1NDY0UDJMdVI1WkhaZ0Rh?=
 =?utf-8?B?Mk84Y3RwVmcwODV0cEsrcGhwQlg3K2xNTm1ZK2lMZVh6YkNDNkF3UXBJWFEr?=
 =?utf-8?B?blBFNW8xYjVWbmNXWHZxQ1UxSzd6ZVlvTlpJR28wd3N4NVM1ajJmNDMvcHRI?=
 =?utf-8?B?cjU2TThyY0VYY3M3TDlzc2FXM1o5cHI2M2Rsd1EzZjhwU2w0bk91aEhoM1Vl?=
 =?utf-8?B?WUJ2VFgvNzN3TnZWU1FlUFZ5YWJHQmwxU0FzWlJsSGdnV0Y0NjRpRk5EcmF4?=
 =?utf-8?B?T0dZcmFtOVBuSUtZMmRNeUNOWkhjRmVpSGJvWjFMOEVhRkN4aDRMNCtjaEFK?=
 =?utf-8?B?SExuSW9YaTI0KzUzMXdvQytzMHFqallwb3hMUk9sNkJ5MzZ3a2NWcHErT2p4?=
 =?utf-8?B?cFZXOEZybk1HQmhzUTRVcUVuZDB4RUNXUmVzYUVUbzRNblBPNHd3d21oNXR5?=
 =?utf-8?B?UU9OaU5OZGlYd1p4d1BCRzhiamY0c0FuSXVnSTZFaE0xZzQwclFhd3JMR1ps?=
 =?utf-8?B?UFd4L1V3MzNXTTB2Q3A1b3BoYlhPMGdERnV6MVRMU0N1R0IzaHJoSFBsdUVK?=
 =?utf-8?B?VmdXb2dWRk9TdlJoVmVpTkN2Q0IvNVE2K2x4NUJHMlhHZ0lyeERlczc3b1ht?=
 =?utf-8?B?ZGhZRnB2MzdYc2VwckRaY0VBNFFwTDFNR2hEbmlUVlNSaCtYWGFWOTNhbmVB?=
 =?utf-8?B?bWxEcmFxY1RlcjRCYkUwNm9XK0lRSUF6TmU2ZldBUFlPWGNPckFaSy9yOE9G?=
 =?utf-8?B?amM5cnVrSEJFMlhpTnJnVTVRb0U2S0hib3V2S0ZkcnJkUDZ4OHB0Si9WazhJ?=
 =?utf-8?B?dzc5bU9pbklkdHVjdkJiMjc3amZGWUZjTllmby8vVjhqTG91ZldXaGp4bS9o?=
 =?utf-8?B?VXZrMDluZmJVenQzbU5VdThoTGxIcmJZNGdwMVp5MzdIM1BkaXVGY0ROS1Jm?=
 =?utf-8?B?K2lpZmZSbnptSkVOL0xvWGMxODY2RWhwUjR4eUs4NUpVT1MraHg0MnRvb00r?=
 =?utf-8?B?UXkzTWJyL3NxRXE2cFB0QnlwbkFGYWFKY3d4cDI5dWVLVld6OXhOVWdFb29u?=
 =?utf-8?Q?vg29B69XhJJ04O6BoMoBKgzlo9xwMp91Wq1V29fbjNy4Fz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be97adb5-63c5-4e54-450b-08db7171bc90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:35:51.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMGJNEUZlpfywbIlxqcNFBSED8gbfgCynYhSv/hrLa1JcvYYGhU9NArbOWrOrG3rmIUpNn2EM3GjRtC2GfOAmQe+P7RzuW+WZa+uSdb/h02gFu8hh07IWcBpXNurPJZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200085
X-Proofpoint-GUID: 3Ho0dS60TTu-y6DBAOUitKSsnqrFq2OU
X-Proofpoint-ORIG-GUID: 3Ho0dS60TTu-y6DBAOUitKSsnqrFq2OU
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

On 19/06/23 3:59 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
