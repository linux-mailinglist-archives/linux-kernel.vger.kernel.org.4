Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D063420E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiKVQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiKVQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:59:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B71F2C8;
        Tue, 22 Nov 2022 08:59:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMGq4m1007899;
        Tue, 22 Nov 2022 16:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SCX2i+rWLGfNHrt0W6fhXSOuKwt+YhNS5y/DBCGblbc=;
 b=oDe3N7Ocv/i/IIlqg/d08QFdi9L3RjlbllPXlvU3LW8xHdfe9Bx8b1AzUuB2XCT0Mxb4
 DiI76X5CA3p6gtKeGAVkKRH79b4Sef0j3o+VzH0/Astkrb9a20UO7L+hhwRV7d+QXc+0
 JSrJcky603vUGvGfxRtiHGjt/FGnXmi/6+UbfzYwNQmSUNooapcTta5Nlxmo5k/izqjU
 PoHD2nxI6lZcphv9lZVLhJgKWO55l56IPRU+iuEXI/zLFWn88x6mV+y45Po+BrNID5dC
 o19wIOHgI6EI3A5BAZhklAxKnHVVpISdUZhPK4nF8Ly9QBt8mOgaC0Sshy3u4JihWRvN wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0afr489d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:59:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMG2sq0039490;
        Tue, 22 Nov 2022 16:58:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkby3fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 16:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDOrBRhobM4EIA8sHZfQkKPQCyhyDJJX2Q7zeVZr6fwWX7PJnZdeIEltIwybZ6OfpDnUWmRPIGFPq1tqq0qhvrPKN6W/xMnA7yhflMCNKQv1OkKa04ZgkHznsUAtp3v39hJm9KN3+H//Unq2kcNESirwU86UkTB2LNm+TzrClY7A4D9Mm2zKb4bTNM6KdK4Cl2nqoaBAmLoPgbc6U9NeleX7KD7OtmrKY0dtyYQQIgSu55e9umzfIszemF77k45iCL1/XyKE/8kjqNfWQbpgsOlorTZ9qGcTp2HKgC6LeCOehZYCz10ziuuTgwgeVg9sU9+AjV3D3ejM17xEODbk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCX2i+rWLGfNHrt0W6fhXSOuKwt+YhNS5y/DBCGblbc=;
 b=KUm/HVJYZrKbjqAF+bWDIRe1+gqBU6swEEdBZYtCZcTYt+R+s7HLj1UTXqvYWolaBwRwCLCMjQKTXYcP700CAyUyqIS/XQcKyidk4VkHmCZC3j3PSATJdiYTpcT40+H2UBCCrvU3XFeFgoSuFcmwuo+frAKB5eJscjNBC1P/8ZjWxgntmVGQuUlTllM0hKny63U4mOe/U6HhIP31IEYhKxSKVBzsXXGvw2VRx+0CUL9PD1XI+7pyFP983xHCCA+zvsHcobw2WgZimzbiLV9a/u6nfge32je+6kz8wkLz3qCUlQhmTTavNBoJgKAqXAh+xUqVkqTPxNiIay2SDLKyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCX2i+rWLGfNHrt0W6fhXSOuKwt+YhNS5y/DBCGblbc=;
 b=gnFoRpqYtyI/DV+BK2Vk95GonL6T01iwGrxzgb8A83E6yRdb/qRPp4Ta75HWeGS0sX59p2upPOq9o9ki6P6qUYjZ8hHh1qYF1lj4oNKPGV3i/bkQtrgSBDl9rGE30rRXCpH74FNEmyRR6mErf5M8yCXl4BwZes3OV58byhnWe/I=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA1PR10MB6343.namprd10.prod.outlook.com (2603:10b6:806:256::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 16:58:50 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:58:49 +0000
Message-ID: <11003745-2b2d-30cf-bf87-798f5175ae09@oracle.com>
Date:   Tue, 22 Nov 2022 10:58:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221122213040.4128105-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221122213040.4128105-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:610:51::30) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SA1PR10MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: f65de51f-d6f9-4676-a4a3-08daccaad3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GsveVFjfiRXpI78nNyDyW2ZRN1sZbGCej8A4sHUoKObuMHHT6vnHWraGFS9tMoNzekjaJnYhZgzMy5ln1iDf/WOPehpyCjZoEZZS4tbLmBbcTdrXpSZ6rPpoczCkaWJQLVfsohsTnJJLtX4y/SY1gghPae9gLhAzbr6u8qNb9E03PHaAazJIhglVhlMEa0y4isSNmfOq5Om9FOV1khuZm4n/wTf7wBnFUBtNsg7RNmPdMKc052bBuX6CGXlce+Wy3QcxMcw8DMl7mF4x2Ln1Aq4SrrTaQZA8IZbForQi8MZCB/3vXXT32vYTRZI/Uy1K/k3THLdOYP9/jAdccNRQkhe9wjCABISssJiUBWTQNPH2nM+IsG5NGYqWZw6g4ADBh81M7DRNv2/Iz4CLHnwOOQ09lXsvgKzHQQC6j/75IaMa2GITlZfBqnoGmTKj25tzzFSMKOZ5Zsw9XsWUFcv++OR/XFZbM9pbH7H7iA90uHJkwzVICSMX++5sGV2GQIzL1QeLVwPWcN0xsVWSJBAsiYEUo8HCkEsnSlR1o6OuXJQY43IdqkwZVeNbTWq58glIhSDnWSbow2TWG9jAFK+GdQshSalZ/HyUg5Xz2tNa6Tuw/AQVx3rHl/TemZS0uUlzbmxGWIeusUxEMhkuQHftns0UtMYAWFPYNBq9kf4FMhz+yojv8owuCINRHm7QQoaifL83KnXaWnQiFSRnXMCkRRBAI8Vr8M9D83+UEjbslM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(2906002)(36756003)(83380400001)(4744005)(186003)(31686004)(38100700002)(2616005)(4326008)(6512007)(6506007)(26005)(53546011)(478600001)(6486002)(66476007)(110136005)(8936002)(41300700001)(8676002)(66556008)(5660300002)(316002)(66946007)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdFYWhwUFd3QTFmdExSaGpFbVVHS3hTTGduZUhGNGlUeXB3SHZPVjFGOEsw?=
 =?utf-8?B?cmczMGZMM2JBYUJVOHAxUkZ2b0Z3UlEvWUxsVlBseFJhem1Rd0paTVNpWVZG?=
 =?utf-8?B?cWxtcUQyRXRucEdCWU9yRllQT0s5b2ExNTArL1pwRVF0ZWlkZ1NkTjgvUDBT?=
 =?utf-8?B?aTJCVnczWHpySSttSUVFdkJaOHprRWpaSWFXWUx5WXFvbm9SNGJEWmlqL3A0?=
 =?utf-8?B?dXY4SU8vd1N4dVBHTUwrNnUyaTVDRkJQR2NiSDlOUDM0azN2RVRoMVFHbDMx?=
 =?utf-8?B?dVJjZmtVeXN2ZGNBNG4xRkZKWDQrWHVoTUoxa0VmdU1PRkcwNzJJVzhJMmIw?=
 =?utf-8?B?SmNzMEFCNFQ3R3pqS3VZdGlNQ2MweWVTcExEWDJ4aWVmcEtTWTZHbXlpUllH?=
 =?utf-8?B?V3ZuUlY2dnN2elJSem1EMzJXSGhqdjFGT1Y4RndQRmt1a0c0a1ZDdXhRNWU3?=
 =?utf-8?B?UjBSSWZ3RTRsalVYVG9aREdKNVZ3eGc5TWNBdTdocVVTNk4zSFpqeGZpNjdk?=
 =?utf-8?B?dkVsdCtEZGpwM1VzRUMvdE8wQUE3bW9Xc3dnU0RZSGNJVUJBRkIzemxNY0FU?=
 =?utf-8?B?cElKQXJ3TG5HZWpKK1k1ZG9rd2h4SlFtVG5SNnBHNVZPOTFMbTUxZmoyQ28v?=
 =?utf-8?B?bnd3MlJnYnIwUEVGWThHSHVmNlVzKy9aQUx6M29DaXlrVGRleUVpQ3B3TVgv?=
 =?utf-8?B?SHJuTXJWaXZzWkRCTFpxdmxRWFVjdXJTVW5OSXhPNVdjRkpTdWwyaXVwazlt?=
 =?utf-8?B?Z1pRZ2t0aHd6Q01FV1dWdlhPUmhCTG12UzJHSS9vQ2l1eFBQRFVGeGxXM2Yz?=
 =?utf-8?B?UFd0b0JXWllCNkZ0dmwreGpybkNTS0wreTg2ZjV2WjhUczJSK1ZsYy8xMG4w?=
 =?utf-8?B?a2p2NW9NSlBsdy9QOEJqRjhHdGszZVd6ZVU4L3FGck1LQm9PZjEwNW0rekFh?=
 =?utf-8?B?d2xLWllBdk5USVM3YUpaa3FqRFV3VE83L0RlQnpYRTJHT0dkRExSeVNtb2Vp?=
 =?utf-8?B?OWs4bUpJRGtUanQ2MjFOY01HNVlKQzJCc0hFajh1akNsMFpNQVRSdGJLY1NR?=
 =?utf-8?B?TDdJd3BVZXM0RnBvMnpETE9Zb0FtNHJ2WU9KR1VlVWMrY1JkM3YybEJXRm5y?=
 =?utf-8?B?VEtRUDRuTzZDVFZrTmRGTDdzcWNaMG9JbVpyQStYaFVJTS9hL1BoUDZLTitF?=
 =?utf-8?B?YjRsYjNLNWlqU280ajBJRlJBdnlDb25pYlp6RzFONVovWTN1RE82a0pXUE9S?=
 =?utf-8?B?VFlXNXVMVHhHMjNDTnhLRlZmVkdndDF4V0FlcmRKWExYN2l6cWIydFJ2ejFl?=
 =?utf-8?B?WXp3dmo3M2hMcTlMU2l5OGc2c0tZRjZXS1hMYUhrVU5ad3cxWmFNUmZMQUN5?=
 =?utf-8?B?M0g1aTBzZXhjOVYrR3RVeUxOeGd3cTh1RjhJcmJTUjhqTjQ2Qmk4cHZ4TVhE?=
 =?utf-8?B?T3YxQkxteTRNaWU4T0hBdCt5ZE0yekJYaEZ6UFB0VzF2dU9EWURQbld2Sk8y?=
 =?utf-8?B?TGJqOFN1YTdHOHlHM1J0dG1tMjNtamZBcEVYZm1RU2wwUUp4WGFhbUpGUW16?=
 =?utf-8?B?d2VUYXBNaEo2N0dRN3J2WEp0TmpSM2Nwa3JHSklncnVCQ3Q5Y2RUS2NzN3hu?=
 =?utf-8?B?QTR1ekxkK2tQbWJDMzkzZFZRZ2xDSHZZcDB6M1ExM0FtVWRyUUdYZEkzWW1s?=
 =?utf-8?B?KzQyTFJueWgvZEVEZVZVRkdJaWN0ZmJmSHBUMUE0OENsdW9OVUFlNk5LMGtw?=
 =?utf-8?B?OWZMRWthTE9PM2lvaEpKR3lkempVaWQvaG1YNy9PZG9XNEpsRElOcVdGVkdH?=
 =?utf-8?B?M2U4dzRvYVorRXpTNUNsRVNwTGRWMmlxSzZDMVU3dDFVc0RBY055WmJ4YUZm?=
 =?utf-8?B?T29iQ1E0MVFZZTl6NU53VnBTalMyWEFUMXJURzc0WnFtd0oyNkdqVzFmTnhy?=
 =?utf-8?B?eU01R2NMaG9HQktBY09qTGx5KzRGSVUyc09VbjdwWXRsOVg5VUkxYTF6OFhG?=
 =?utf-8?B?cjZzYldEWFBpaG1mQUd1RWRsVGxmK1h5UnhEeCt4MDFpU3JnOGlkaSt0bGZL?=
 =?utf-8?B?MlZycEx1MCtuU0tZZ2VxR2hHejYzS3Rra1lhV2lXbnVFYTd0NmhjRWdQay9W?=
 =?utf-8?B?bGIyek1yS2RsVnBTaHVzVkJ6Z2ZvWUtoWG9CRzVjVm9JYnNtTGwvV2t1UDYz?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlJBZmUwWmhqdUl6dUxyNFpHMWFFc0xmamx5SENvL3J0a2F2NWZBRE5CN3kw?=
 =?utf-8?B?b013YXZQVWtLbFJBWGc3c1gzdFNQMDdsNjdpOUlpWnk1M1g3S3VvenF0b0tk?=
 =?utf-8?B?cDdOMWlaODk3emcxZWZ0Zy9vaVExU1IzK3VLNHNvOXY5UUNWZ3JzaWNrUDlZ?=
 =?utf-8?B?UFVsTnU1aWs2bHJXZE4rYjFnZHlPVnYxS1RhQ2JaZndSNk92ZXMzZG5Cdjhm?=
 =?utf-8?B?d0VKRnlOWjVoaHVTSTJBRjFudW80N3BxK2JubkkwUlYzWnQ2aWQ4ZzgvUkZ6?=
 =?utf-8?B?RU5nZi9iL00wcDZSWFUySmFrQnFOaWJDc0tnS2FCQytHMEx3REpJVnhmVCtB?=
 =?utf-8?B?Y010VHVXNTdicGFGSFkrRlVkdjZXSkRKQ1JFOTFWTDZPOHhJRzh4VFVrWTFz?=
 =?utf-8?B?OGpTWXBzNG5rM09VcGszQUNRSHpWTTZaY04xY1ZUQUU2Rk80ajQ5bDlnaWlO?=
 =?utf-8?B?KzZEQzhQVE1UUzJWZVk0b0paU3pXT0VmVTUxb3YySUtIalB4OFdhV3cxSFZQ?=
 =?utf-8?B?a1V6eFJLR2RLb1pTcHlYektGMFpTZGk3YXg5NS9TbXRrUnZBT2kyamRCdDZa?=
 =?utf-8?B?RGlJeVNXZkZkQUcycWNWQVQ0RG9kTUlSQVUxQWI0VjJJTk5vMk1hLzYvRlRC?=
 =?utf-8?B?eXgrcGkvakxLc2dvbkFnWDdxK2VsY2x1NmZjdmd6SDJ3R2c2eW5iN1gvcTFi?=
 =?utf-8?B?azV0Mkk2Z3FyM00yazZYazNtTE5RQXJTSy8vbjFjZlAzZWwxcTg5dkd0NmtF?=
 =?utf-8?B?cXdGdzBMNnZJT1JWQ0hSMWRUYmUrKzV0OVErVll6R1g1U3ZpSlQ5ZVp3Z3hu?=
 =?utf-8?B?ZHhOVEFPWmNoSDJsaStOcWJJSlRocDdjb1hqQnIvcVJiNHg3SWdKMkc4TnU1?=
 =?utf-8?B?MTM1ckJmTUlGcjh5WWp1Qmd1ZUVadEgrK2JrUGxNVHdmZW5PSUphTEF2S0Jm?=
 =?utf-8?B?eWtrTHd4QlliU1NpcHVuVmJDRThnSUNhMTVWeERHSHl1TEJvZXlDZGNmSGdY?=
 =?utf-8?B?Ris4Z21uOGJGSmQ3WHBtRW10c3dZQlF2N0h4cmx4TlRoSGFLODdkbFVRRnFN?=
 =?utf-8?B?REViYmhsN3RoNXhHelBobU45VEVORHFZbW1FQSswekNVQkhCUHVzMFJQR1Fk?=
 =?utf-8?B?dnNjR25RendCUHJqV3FWaWU4ZFAxZ3Z0R1F3RHAwYWtiTnBaZ3JmYXd5UVdm?=
 =?utf-8?B?N2luVjdUZDRxa2pWcENobWg0UmVValZ0eXl2NFFnSHF1eDFhVEx4Wlp0SGhP?=
 =?utf-8?B?WHdBcjdqbHdwbXRmSS9LQ29XM1RSM3AzN1pNVXluSHdDUHVQeTliVXhzUTFr?=
 =?utf-8?B?OElaQjZYbEg0eDMrNW84L2RnL0tLUFdtSU5CaUlxZUdlRzVEZXp3UkhYb0tv?=
 =?utf-8?B?Q3d0Q0M3VG93d2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65de51f-d6f9-4676-a4a3-08daccaad3de
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:58:49.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/NTluLSaxkJqsmzzjYACP57lHrAaTnQLXACoj3uilBQ7on8zwcMzMW+yPRIYH+Yl2kz9qB6DvjMYQcRIRHYqwIo+c/CsCQ9BR1FVxoonNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220130
X-Proofpoint-GUID: NaFbGHmtkhaP6pGMW6DtbUszVChYDSXd
X-Proofpoint-ORIG-GUID: NaFbGHmtkhaP6pGMW6DtbUszVChYDSXd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 3:30 PM, Wenchao Hao wrote:
> There are 3 iscsi session's startup mode which are onboot, manual and
> automatic. We can boot from iSCSI disks with help of dracut's service
> in initrd, which would set node's startup mode to onboot, then create
> iSCSI sessions.
> 
> While the configure of onboot mode is recorded in file of initrd stage
> and would be lost when switch to rootfs. Even if we update the startup
> mode to onboot by hand after switch to rootfs, it is possible that the
> configure would be covered by another discovery command.
> 
> root would be mounted on iSCSI disks when boot from iSCSI disks, if the
> sessions is logged out, the related disks would be removed, which would
> cause the whole system halt.

The userspace tools check for this already don't they? Running iscsiadm
on the root disk returns a failure and message about it being in use.

Userspace can check the session's disks and see if they are mounted and
what they are being used for.
