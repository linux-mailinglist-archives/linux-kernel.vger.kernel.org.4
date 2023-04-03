Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBCA6D419C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjDCKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDCKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:11:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F7213A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:11:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33361uZC014808;
        Mon, 3 Apr 2023 10:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+nEkTT9nHzCmwlLipPS1crnzykujjJPLhU4J7v/VeZY=;
 b=tMcfLzzvxwTbA/Zzq0sWAGEcLiIVJoSWp8TgkRRwBo9ZrZLDajAvGBgjkNzPcPxyBPWz
 OvyBP2SHkBQTx6Micm2IhKNgemtyKaomMMZp4pmQVBz951oznXNzVBB0fTwYfvqGZo0L
 tpZM8+rseyl8IFOMKOqceTdUHGkRi37d/TY2AwYteFDJo20s2fNuKfC4qOZXnlDnauTj
 HEoENP3CQfThTyERUlVpHe1xJrHJuwap2S1U6oD0HXSlXrTH5wLSp5LDnrBT6ESvRNSi
 VUZadWUfmeWdFHnnSyrspH8iSjE1MuaCGtuuOiciwup+3kE9pauAUgFmS3D7xFwk2kCQ bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5uaqkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 10:11:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333A0afh028272;
        Mon, 3 Apr 2023 10:11:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt24evhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 10:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyF6AGJlLK7fZ7B9e8FwejTlpcxwE4Ic9uVykgR0oYl8IegUpvRjMkdll6SkJ6X90qitU4LXnOLWePSPlyh6kAnc76ycyIH0HgSwPJ0lh9jugQkEPsV3WfQPqcz2cl8T9ARU2bC0bbxEQcOW9RqKb7B2hJGhuVOYsxJcVUDEHszptW7rAor6eRZxe5gSWZxM9Qa7ziAmmw4pJl5rZkEtrS5EBGqNeR09S+505Dqk6Ewhwq5HqikNnI3zo1RZBlGeeeDQ7BgVopACx+5OyM3zcxFn8p5cez8YMXlXzOfXlLQh/eEZWdUDCgev4aFU88wqPCRrpDcXY/j2tKaVvtBqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nEkTT9nHzCmwlLipPS1crnzykujjJPLhU4J7v/VeZY=;
 b=LdJwvAF6TV3xFQIahUf2FLgfxYmayoOTAy8008UUArjda71cGX9slVQwRh5qwKtWZvFAj+DO47kectIunhjH67bLUkkfI/8XOlr0cfBmmxV7PcJHde0YYI6uXearIqshEL0CBcT4zGUaLhiyAst18S2ynC/rbUHCz2Q2G8rF63Lvglj4lJwPA+iYbKK5gpO1ey1c86Y+7Xtw53QYa6EwPelYPAFGfpy9bERu2+o0eaN9WSXtO3hVC79bl3ANsHZTRPWufusG/Don4qpN5zCG1ZSOgWGLGvVP7uYq1FyYK/fUpIuyIDxTj12oCBzh3i8vmbzQWmOhY/hHKF+MniTr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nEkTT9nHzCmwlLipPS1crnzykujjJPLhU4J7v/VeZY=;
 b=RM+pGydB0aW8cyJq6vclaVHezzCcx1KnC8zuwLL1wcx22At95Yb7TNSzJutho7ohUtHw7zY7koq4u3mjNeRqjvdQndyYeRvTeXfLMejeKw4mVQJyQxLEjKAJAjP5EohCziVnqHd91bBqfTW2eQzW+fusUHtN6Nit/lNlbarsZp8=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 10:11:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd4:d27c:94b5:e2da]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::cd4:d27c:94b5:e2da%5]) with mapi id 15.20.6254.034; Mon, 3 Apr 2023
 10:11:37 +0000
Message-ID: <12621587-41f2-7d62-a332-78ed3d3a5569@oracle.com>
Date:   Mon, 3 Apr 2023 11:11:30 +0100
Subject: Re: [PATCH] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer"
 configuration in IRTE
Content-Language: en-US
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        alejandro.j.jimenez@oracle.com, Joerg Roedel <joro@8bytes.org>
References: <20230331061723.10337-1-kvijayab@amd.com>
 <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c97f77-d22f-4ec5-8f2e-08db342bcf57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spzhOzxtnnuDafiW/yM5jkZDDl7qMeUOYlKdPlyYADej4EOr3epkOE3icTsSNsEomZxxT3GbBddFmcMm9Zo+mZ5G9H27oie/Je2Wu3Hcrdqki8JGmEJczbVJzvTLXikeYjAp56khloc/w2Q5P5WPwIKzblNSoSEU7IX1ZdN1HxtJOwbv4I1M4o8fY+NAoo+rPzAyGM2A3oB3f5E3yMIG+40lvJg0N6zPBLZ58i3O5fgPJ4uLDw8Lp5GRTElRbKKZVbGsvtth2HpkkUPLbgTIk42P5LF9soH/nlVm9PK6hmRCE882DnViiZF7EW7sVfBGfJorkBq8E17nxEBNJQ4G8VSRd4M9c+yy9dzPrV6Q1Wpbj9DsdO3MIHKEXp3oo6izHALVyYGgrjHtmo0o4tyWML9Qs1o6gd5WQOtfMldi07VBHJB+IZUzzQj8yRSzQUVeVCPBUgCYRaL9GItpfa+kpbWhbqjLaceMv+oYIb5FzBJFzARQo4WinOZLs94k2+5J0oddhOdBvDjNRFtZEqSsEcUS/mIx1SpyI3Ig7otB5jsUQ84eoh9ykIyuwb02QniymSg0FEBLioI0RWFXhz+05fuoS6LiL/Y4gGECmns7afHnI2kF2eI23ohw3286MznP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(8676002)(478600001)(66476007)(66556008)(5660300002)(66946007)(8936002)(41300700001)(54906003)(7416002)(110136005)(316002)(31686004)(4326008)(186003)(2906002)(6512007)(6486002)(26005)(6506007)(83380400001)(2616005)(53546011)(38100700002)(31696002)(86362001)(36756003)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnh2a2NOYzkyMGRIQ0tGMGN2d1NtSFhEc05yMkFpWnRaTmVyOXUzTHhHK0hE?=
 =?utf-8?B?NFVBSEhxYmIrMmhNYktSenRoM3VQWi9lVXpWQWFqRGtWZll4L2xmanNhK05h?=
 =?utf-8?B?ZFlXcHRISHlKSXYzL0lwbklLejBUdURmMjJVRUJjS1Y2MDB5UGpaRjdNRzB0?=
 =?utf-8?B?cEFPZ1FRVGllcnQ3Ti9tNmZiM21EQmxKUkpoT2RGVjd6OWl3S0l3VFVaMlly?=
 =?utf-8?B?REhDVnBOSER0emxBYzlNUlc0QzBnVC9PdHhZTHZ2Rlg5S1hJbHpTd256RTVD?=
 =?utf-8?B?b3FLUi9sSHpMbmRzejVkMldYYjRORjMwcy81dmNOc3NaWVFQYjd2Q0h1UmtC?=
 =?utf-8?B?aFREMTJDT25ad2hsNlVHYTZNd3l1bmpsRnk4eFkzQ1BjbFZDdEd0YUpucEt1?=
 =?utf-8?B?dWo3UHg2c1FPc3pGMGxadHpTRHRIUHR1aVY0enJQVHIrdDNrTTVXS280RUg5?=
 =?utf-8?B?US9PYmJEWjFYT0xDRVQ0RlUvTlo5Q0kzVWdKUjFHVTlqaUdoRW5nWGlHcVp0?=
 =?utf-8?B?NExINTNpMHRVYzNTckRBb0lOR2FUUzFqL3V5M3kvVkdQcVkyb3lzenpENDN5?=
 =?utf-8?B?UENhdXNoNXVFWFhvUVZEcWp1NU16eVVsKzdMOW5wQkcxcjE4TGd6ZE55UTZ5?=
 =?utf-8?B?WTA1T1NDenhpK1BlbEZZUmdscnQyS3BNYTNSM3F3amdtVlpFZ1YwOUNxYU1p?=
 =?utf-8?B?QWJKdkJJT0tSbDIzT1RoZzkxVWN1ejVITDNkWW00UnNOVnlQRDJyMDBhVCs1?=
 =?utf-8?B?UkFVdHdXY0pxYTllN3V1U3YzY00xRklnbE9BUzlXekZQUmIrYktxSEJhTDZ3?=
 =?utf-8?B?cFZsWGJSOHV1bi9peHVuaXpjOTh6bStOYlZRQUdjbHc1YXhZMXVXTE02aExv?=
 =?utf-8?B?eHliK1U1SnkxdUpJcjRucUdYRFc5c1Fzbll1Sm54WGV0cTZHdkpBNDh5RWUw?=
 =?utf-8?B?M29PUVFWbXRWK2dKVkVOOHlrVWtTS3FaUlpwNUp4TmVkRVpyQXBWTDJlRm4x?=
 =?utf-8?B?MUcrR056RXhiWmZLeHptYllSNDNsZ20wV1JzS2JKOFNwWkdUWklrQW14bUpI?=
 =?utf-8?B?ZmsrU2RheUZIM3YzUDYzcnczcU8yN0EvNitrT0xYRUNtaGV4eGw5WkljSDRw?=
 =?utf-8?B?dzFmaEtnaEdOVkRHeTV4bmZqeDZYa0J4c3QxNWUvUUorME0xRkkrbzI0eUVR?=
 =?utf-8?B?MmhBbEM0Lyt6TDU1Uk1pU0dOdks3d1EvRzVCZU1GMzFzQWxsSGFUaXd0NG90?=
 =?utf-8?B?YzRJMi9heHNyaEtIdldYOWlMa2JaZm1KcklRQTVKdTZaMnp0ZlUzUWt3RmF6?=
 =?utf-8?B?cGtEVXpyOXRISWEvdDliakJydURHVnpVc0lLcEU1RjU5Q3JNejFHREc0TGNs?=
 =?utf-8?B?QllEaEkxcmc4V1crdEI2b1FQQVBWWlBuak5KR0gxWkg3NW1QVnJJZ3R0S3Y0?=
 =?utf-8?B?ZU9ySGtKZ2VISEQrZHczRzc5NzdxSWlUK05mYmU2VXZJbU5DY0RDc0w4Wndp?=
 =?utf-8?B?bnc1QXYxaXpwZFZ6cDlDU2VNbXVNR1k3T2ZxUVhETzJHTkE2ZVVjTDhpT2Fh?=
 =?utf-8?B?dlAzRFI5VHpsNXRzdVBGYmZkcEdrdUxZTTUyN2RDT1VlNmNUUHhpQWtMV1dS?=
 =?utf-8?B?Qy9SUjdzRXF5WDhPeCtyS3hqM3BPdWd0bWFqbkROWDVINTdFVjFQL3RINGFl?=
 =?utf-8?B?THlRMFo3WjBDNlBzeDRxT1ZFVXJXUGRYSFFsbTJZYXlvS0t6Y1F4TENtcGdy?=
 =?utf-8?B?KzFLYjlxU0hsMmh4NVBpbEUzcGthWHVKMUUwbjBLZ3dlcTYzVmN5L2RhRWFH?=
 =?utf-8?B?U1NXTzArbGJNQjBPQi9iZVR4TDMrdzJLZ085YTgzM1JIdHJheEF3YjB2ek8v?=
 =?utf-8?B?UDFCQWVKYzMyUkg1RW5hNFNVelNRbXA2TlJLVnhqM2RVYjROQ3VZWGlsUlNG?=
 =?utf-8?B?bXl2TE9tOWtIZDlicWswVithc3ErOXVYNkszL0JwQlI2UWgvQjJUVzhNUi9M?=
 =?utf-8?B?dlhGVHZxV3hjdDZsMjBDYm5vRlIrZTRRRk5uTUNvdGlVV1VDbng2RGhaelpV?=
 =?utf-8?B?dUZiWlpLTWw3dU12RjMwZkVjVnR4cUlneXJPaG5OdnZtR21zOXBuNXJVSFZk?=
 =?utf-8?B?b212UldXM3I4ZVpxL1h5ay92WkFhck9hbTVBQThRTkRmM2R6QVVZMmRraFZU?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aIaRSgsXcuDVhsD46rREvYMrYCWcYmQxcg3P+YUhrQL/JQ7oRi785sqHByAHv0oSAyqqqXbTw6NWj/qy4Nn8T5U4mNNer9oQPxSJT57KLbYGKY8dTNkMa5ekYCf59N4bx+WKkRvzoXl2GPFjWk+/umgf5WT7BFFw0e0VEZjE6EAdt740rjbmSpO9h+QWz0Do+7LP/smWnnqrGUDH/acapPraGt3r6UyzwIz8l810EwRIeN5HvO52HLQDmFRkJlYXBUqO+DeMouWBfF/j+jncMXnjoNtXs15feeO0gqSM8XG+PBy/7Slc71zpIy6Sn2BxS13pCTrA7s202QQfpRQ5lP0c2p35R0Mi1lfNn9YRFZdL9tNUCjVJdrA7tcaLK7nWwd+HM/AKGLm0cX6XcvFFTZK1/3U7v7xprq/nfi1whevazs+faZpn4dmdRIiklAyI8CEqC52pTAT+Kh3GI/V23X0Otl5Lh8+/8Qr6bbBF3BTbGSiOmLxVXn2SfbwkyNhlmEdDaXxG7KdFQTj4lqnJ+LMUPLWQCD9VJAII53a93dlcMGjXI+Rn2rpMTW2K1ru1s8d/y8mT6xffvqD1kMbdO3NIRv2mEkZHZvNY0kH4exET/Otrv5UnMk7e2atWkkaaKrRi7i5C2qBpq9IoNMKj5UyPwX2+vj73z/wte1fyhTTiATDVL7xFGYUIusLohZkVYe0R5SSwI4w4orpEi+FOOaoT4R7UBPIWOprvl1EPwph2whfA1qiBrEXi7GUI5wC+5IS7cO980CCE8hM9LKWiNpGxIb64FAeuyOkYRnBeYap73I9Tp9OvSquJxjKYMGUmG4tAxjnmjtU1XgWX/yiN4kO7W4rHjgbRn0apjFP6CC8ST3o+NT58IjAY+diWm7taB1f7t0/1IiW6lY1PT2CWTQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c97f77-d22f-4ec5-8f2e-08db342bcf57
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:11:37.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSRIJpRDuQbx8QpLviHqn/jr4YOGXZsLj6SuS70KJvzTi7CARPn+r9fu4XRp+0I0+nuVnUJD+txLvchByazlp5VwspW4sOHPDfiWeZg9jZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030078
X-Proofpoint-ORIG-GUID: aX6W2v422l1CP44bUZLmjaZsjdg2y_Nh
X-Proofpoint-GUID: aX6W2v422l1CP44bUZLmjaZsjdg2y_Nh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 05:29, Suthikulpanit, Suravee wrote:
> Kishon,
> 
> On 3/31/2023 1:17 PM, Kishon Vijay Abraham I wrote:
>> commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
>> (de-)activation code") while refactoring guest virtual APIC
>> activation/de-activation code, stored information for activate/de-activate
>> in "struct amd_ir_data". It used 32-bit integer data type for storing the
>> "Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
>> "ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
>> Table Entry).
>>
>> This causes interrupts from PCIe devices to not reach the guest in the case
>> of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
>> bit in the "ga_root_ptr" is lost before writing it to the IRTE.
>>
>> Fix it by using 64-bit data type for storing the "ga_root_ptr".
>>
>> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation
>> code")
>> Cc: stable@vger.kernel.org # v5.4+
>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> 
> Please also add
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3d684190b4d5..990614b8a1fe 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -1001,7 +1001,7 @@ struct amd_ir_data {
>  	 */
>  	struct irq_cfg *cfg;
>  	int ga_vector;
> -	int ga_root_ptr;
> +	u64 ga_root_ptr;
>  	int ga_tag;
>  };

Nice catch. While at it I noticed the following:

* ga_tag: The conversion of uint (in kvm as they use proper u32 for gatag) to
int will miss a bit thus at least VM IDs with the msb set will be stripped from
vCPU wake ups? Fortunately the 24 bits for VCPU ID wouldn't be affected. But
ga_tag should probably be a u32.

* ga_vector: this in principle should be u8 per spec, maybe it is OK to stay as
is to prevent compiler warnings as IOMMU intremap struct vcpu_data is using a u32.

	Joao
