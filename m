Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E746A6C77
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCAMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCAMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:38:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFABB19B;
        Wed,  1 Mar 2023 04:37:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321A0gCc025472;
        Wed, 1 Mar 2023 12:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QoGvMHXX38XnI75b0QLFgKE5XwHrliZirwMsuxjRTz8=;
 b=Y8/v4glY8/mwZTU+aISn4uu9dO7KkcxWEi91UkOy+t+HYSNJg89c+9X5wgjpU7fT074N
 chdWihcB03nP0kwQrrfHYr6Wo59LVQ3frWdwcHOIpkkk1K0P2zhcZJ115xeBCNlzzaEt
 yBOEn0uEQEuLkvUi4TcgCqyPMGsmXRi1mjPCO1s0HYBz7Y4K+R9tc2hW2s4nm2fMHe7N
 kmWFETYnngISDS74Z+nanLkaPI6e7HkBtJYKLESCakECDEDwqEnW55xPvNN0ovfEdjTi
 dYw0Z1rxNPB2Jo6CfQIeBXPMXWVxDqWSuosyQ4zHWDgbOebqoC3Q5w4NWlJxq8svJe7T lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72gs9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 12:37:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321B5vtG015883;
        Wed, 1 Mar 2023 12:37:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s8pahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 12:37:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGb6rFjlqoCogeeRMEtP/bH9UNlPozlf4qvPSINTuikC5lJzstjaF8J99Eg2qAH2+b8dFaqOnrupF2LzEGxzPvQQ5pTE/DFNr5cN2BJi9wRSTkEpRxyY71XXgjf2jujH3PEIFZ72wfpt4ZFSq3Qyrowcm15OJs3kWNdZtnTI4kEagN8PSBNr2WnSrC9Bku9Qz4pxRa7kWFKPMf/BCsX3gG2wdtc/08CxgGkY4BLO//AMxkt7zOq4tE66jQNVOS1+QRkYGdISn3y4fxelSp1W+5oHtepa275yM8zfr0tmUAOuArG1zQw3HzJKfKKL9FTdlIZ33SIDLRRhYn8rz35Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoGvMHXX38XnI75b0QLFgKE5XwHrliZirwMsuxjRTz8=;
 b=cRjJ8WuoT4+qeN22P7tboIzzCOM4UuKQO4Soi2luZB578l98gJmPUE0gc0oLgoVgVgFGCmiiz2PsU1rRFjtnPVsOWdqp2uLeMtG+aRunbbbF+BbQ/DPQq53VycG9a5tjw7BQZHTNM8cvFj51WLX5SAcWf6cfTQ490o9of7Z5mPxvH+M0BT9+XFCscGOlB1TBO7tEu/l0Z/LrJ79LJQ3jh2ltjTbnBdbn96G3bkIW9AmztySSWAN99Wev8l29gi41+EO/dDPfUckeeQNeSLIhCK0u+Nfr1FZCdZi4qcQ7+R776nHy1Oxp4OvSAO4jf3ERuQiXCyrDmsJKsI4u1lW8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 12:37:36 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43%5]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 12:37:36 +0000
Message-ID: <9bd1f286-15c0-0fe7-a566-802584fc629d@oracle.com>
Date:   Wed, 1 Mar 2023 13:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] kmod: harden user namespaces with new
 kernel.ns_modules_allowed sysctl
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20230112131911.7684-1-vegard.nossum@oracle.com>
 <20230112180045.GA18314@mail.hallyn.com>
 <8b0cfd73-d22c-2000-d4c6-41cf75531cdf@oracle.com>
In-Reply-To: <8b0cfd73-d22c-2000-d4c6-41cf75531cdf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::21) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b247f33-f0d8-4bb3-7d0a-08db1a51bc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfiCWsLZbZmI3rFuGbhaI4U7QdRiJjBO2JYJ/RU2B4pvaeikylmaT5ERShIzldCozAc00g2rMFznMhS9GpCBOQHcPFjb1BXJMTAdob1Su6ja1GitvBcC7O7p05IfGp71L/C16hT9GqiWKKslTM2RG4lrak4NMEQlQHkrFf8u4F/a3O9KDHpRpR6Mx9MyTEc4RTGmYWbGZF/KiHO3HO3RRpnKn93ZaXu8JNBa7dbLn4QWlKPtGAiQyRA9xgsIPF5/fW77GFFLBQsX0HUdE17o8zL+21LchIicM0iIBL7FW0HE3+JCkOP0Q/MrmbKyhHE2s8VT31wQtHDj9QLKmvS4OwjGDIfDl0b1Bix1BH3UI3jgyiGX6c7w/oJwGOITB0AzGcda3u5Th1pbMEdGjYawneo++dESoiS6qcQfULsdeXGEmS4WT7xy2abDQZTjUlD5u+tAxUqSgwKbeEyMK+IGUB5Ulgm1ALKmENeEJ5nRaarCvpvPgSooukj7JTC2zm1b9gEsb6oMtP/oIC8IbyCAJNz/O5Tm/HVbiJbdSVgNHuA6S2OSh/PfljulePkulP7c0GczCLRKYbpu0/zqEYHmy/0eW+Ujt6AwoMRO5SVVm9rYsDE03B3r1XIi6np4IvVr3yEnPuTSr94hGO2iQ5fmeG8fNN3hFJ/g1RmXuwV3uCi6MOyVdYd9e4VV1kWStNd8Fb4R48yAlrNHdrp/wqdIaLQxBlbaVrQI35WBqBB5YGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(36756003)(54906003)(316002)(478600001)(83380400001)(66476007)(6666004)(6486002)(2616005)(6506007)(53546011)(6512007)(186003)(26005)(8936002)(41300700001)(86362001)(2906002)(7416002)(5660300002)(31696002)(44832011)(66946007)(66556008)(38100700002)(6916009)(4326008)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjR6Y3lNanUxZkFUOSs1U1d2Wld3UmgvV05OaDMzeFlGdFVRV2pPVVRoOGp1?=
 =?utf-8?B?STZ6aitnd3IxSXVxanoydDk1ZmZKL2x1RVJYYXZobnNOZENoa1FvZU5TTmtT?=
 =?utf-8?B?S0l1aWQ2aVo4NFJ0SUgyY0FDM1llOFNpS1lhZXVkcFBjb01pNncwZms0dTBq?=
 =?utf-8?B?b012QnVCYUE0YmhGQTFNenpTd0R5My9sYTJzbnJlemF2MVFMQW1TVkk4T3kv?=
 =?utf-8?B?c0lZVUhxSkhHV2V4bW1NZTg1NGNQZFVlNXlRNkRFaUd4RHduYlpHNFhTdzQy?=
 =?utf-8?B?Yk9UNTI0eEtnL0t4dThSZ1JmTVUvZDRNdTFNeGFrWGpsT2FTVU9SUlo3R1l4?=
 =?utf-8?B?YXhDcGdDYlN6YWR3QlZWbTNQdVFGclBnSVlCVnExYzZxa05UaVQyeFlHSllk?=
 =?utf-8?B?WXZNWGhKOGVRMDdmL0ErSktuelUrYThXcy9TVitnWlV6RFltc0s0SjhWYVZL?=
 =?utf-8?B?VVZMMzhEM0NSeDFSUDdtTGdSZmpsYnNKcmpyMGV3cjVIQVJmaHpUMG80RzRa?=
 =?utf-8?B?Q3dVV2ZKd3NCbWdIOWhWc0N5R1hyekFsMTFyWUtxR2pPeHJxaVQveFl1cmJQ?=
 =?utf-8?B?bHZaaGlpSHRZaExSb3pveVBzNzdHblVjOGIzc2E5NUtMaVF5RmNVY29udDMr?=
 =?utf-8?B?UnlWUHFxSFZTOHpsR1BFNThpd2xzZk9vYmVPNmRkbk5peVpFN3Qxcm9zazhH?=
 =?utf-8?B?QmZGN044MHFILzJCZjJ5RFJXaWV4YWxqNVNseHNaRllaVk9sUEt6QmVjVkVw?=
 =?utf-8?B?ZWtZcmVyTW1OTTNoOGlVenNFQVdRMmNaVW1kbGduNFFyMzU2Q3NVWXhQdjBi?=
 =?utf-8?B?aEF3T3M0UUhHVGlZWmV0TG5NVEx5VllXRmloakJBQkhUbk5rVUZ0V0YrdXkw?=
 =?utf-8?B?Z1FrYTk5aXhPa1RlSnpremVkTlVnQ3ZHd2JEWkw1RFduRjJWMmV3Wi90bVVO?=
 =?utf-8?B?N3ZUNWVYbTJXVUViMzR6VnRxR25LYXdBUm5ZaWFJL1BveDNTV2xaUWtESE5Q?=
 =?utf-8?B?TEJZdmpZaGQyNHpKN1o3NmxJV0w3Qy9zN2xiUkxzQkgxUzNVNm1KTHRoMXpN?=
 =?utf-8?B?T0xxVXg4ZnFFaWlSNnVJQ2JadlppaU5zU2ZBNnQ0NU9ZcTJBbkRzNGlnWGtN?=
 =?utf-8?B?RDFGOGJ1aVVvbU9WV1cwWjZBUE1BbFBWODFaS244dHptUStubDBmNktSU3JM?=
 =?utf-8?B?a3JyTmRUZy84ZFA1R2xXTTc4a3llQ2J0TDRSSXdIM3NWUDY0K3RId05iNUZj?=
 =?utf-8?B?M0tkNXJmNjlaNUEzVjkyd2FmWmZsYyt0ZzIwZUF2c1pzSFNBaHZSVS82SUdJ?=
 =?utf-8?B?ZmRQdkNHQlRNckNpM05HVGRIc0Q5dEhEUEJGZUZuem5ZVVNXOGtYbHJXYTlq?=
 =?utf-8?B?UU5odHlVTkRpbkFZaS9vSFhwdjV4Q2hiUHZ6R2ZlL3VsTFllU1ZBOHg1S09r?=
 =?utf-8?B?VFl5UXVYTE82QnJXK0NyUUVrcG9qaE9pVVROZ3FKSnZXbGpQazlLZG5ObE1M?=
 =?utf-8?B?V3E5SVJkSk1QTmFuQThCRkhmYVZCcjl0OFgwby9QOXpJb201WHpQSGZ4Wmww?=
 =?utf-8?B?TW44eXo1aVpyanlOM2I4MS9nSzlhUWwvQmYxQy9kam1DTDNEdG9VOHN0Zmhw?=
 =?utf-8?B?NHBHRDA2NTUzNUxWY29xaGw2UFF1czE5SmR5UWxpM3ZCVkJjVjgwZWs5aDZq?=
 =?utf-8?B?VkNLR1ErcVFVRkhERDZHUkJrZkI2UDhBd0NKbzViZGNkbXlMNW1iM0c1T25i?=
 =?utf-8?B?R0VNNUtJR1ZyZCtRdlg2NFVsNGJWdE1qNW15enlGWDdobzV3MDZuVllpVzFm?=
 =?utf-8?B?allZTk83OUV3dWtpcGZtbFFBbmFtOENCaThMMFZRNWdBRDBPdDRYcXNiY1Rx?=
 =?utf-8?B?YmNZbW93RDZ0WXFYbmpqNi9JbWFVRFpna2Z5TlVFNHFIakJIMklzRHdoWGFs?=
 =?utf-8?B?b1hGRkNUVTY0alg5RHZMcmkrZGVSOW9BU1NUT3oyb0VKVVNLa0RKNEJHLzVN?=
 =?utf-8?B?ZHdjc0hkUjNVUTMrMHUyNVQyMXFwbFppRGhNOHZQb2xBQldnOHJoaVovcWZJ?=
 =?utf-8?B?M1p0a3dnL01VR29Fb1VVa21QQjU2cWFUNGhtTFNKc3JTclg5K1gxbCtoUlox?=
 =?utf-8?B?SzdFaEJEM09WdG8xV1lHVkRoT0VJdE1STlF2dnBMdkJXN3Nla2pTMjBITmto?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eFozbVIyKzRaQnFNZWZpKzBFTEw1Ulo1QTQ3N3pZdEFWaW4wMjJWOHRVTVdV?=
 =?utf-8?B?ZWtkZVFmOGxjTDlua0JsRU50OEVGNnBlTFF0QjBaRSs2THY4dmZxRTdCckw3?=
 =?utf-8?B?bDV0NVI4UXV3RWtzK3VOS1JHTGNDWHFsZGZrcWhkaUFEckhMTWlyaEdLTEZL?=
 =?utf-8?B?YlBaNGFLTWtFYmw4VlBocWN4S0doZXdOa2JuWDVHNHAwRjN1MmxEWGU4Rmxz?=
 =?utf-8?B?OEhlbWZRcjdKN3VCR3JDc1FWTzBqdWE0dEgyQmxrTHpiZVVuK2YzajJ5N3BM?=
 =?utf-8?B?RWFLVzJDd1dPZXltY3laOTFTSlBNRlMybDFraC90YjVHSk1abEhlKzh1T1cv?=
 =?utf-8?B?VUdBUjNxZjU4QmVDeFZNZnFLU2p0SGJiSWhqb2Q5a1AxRGo1WmNPdXE2cXFr?=
 =?utf-8?B?Y2dVNnd5NjMxY1EyMEpIbmJwc3lqNURMWjVhSTJveHdNNVdTRGVDbEtPMDVD?=
 =?utf-8?B?UmJWbXNKZ1BRdHh2UVAxa1g4aU5iMnJQM0RBd0tUbDZsTEQ3RWhTNXJtcEho?=
 =?utf-8?B?SEhIdXZRVkJjMXVYWDg4NmRqTzNLRjE2cDVPSHFGTk1JQjFibWJDSVJENndm?=
 =?utf-8?B?OC8wOGlmZGxkNjhiYXdoRVBhYUVRSWVsK0dFVVRqN0pjdzdnRGlGSnBkcllr?=
 =?utf-8?B?amtSY1RCT3kxYXZhaFp5K2pJcEl2R3BLaHAyblVpelB4NHBiMisxRmZoOXJa?=
 =?utf-8?B?ZDFIVHdyVkN4UUw0dW5WTjZzemhwbnVFY1VPcWV6bXJNNEQyTTFqSHNxOUV2?=
 =?utf-8?B?d0kxandFKy9HSllWZkQ2c0R4RHoycmd1bDhpZG5vbDFNeGlNZm1EMEdiOXAz?=
 =?utf-8?B?eVpweDJTY09zN2M1QXFUNk95M245NFdlbjcwYVdydk0ybEJwblhuNzMrdVEw?=
 =?utf-8?B?enIzMDAxdW5UcUV5ZkNJSVFUUnBZK2RrcDhtQkY0K1Z1SHBob1BOS0J6TjRD?=
 =?utf-8?B?bk8rK1JtR21wanVjY2ZKSnJac2xXRnljYWlxNWpqVyswRXBYSUxwcUJ1cEVE?=
 =?utf-8?B?UWJabHQxYmsraTFQRWRJWDlzak1UdnQvcVhBVEdDWmZXZnZwaFVEL3ltSlNX?=
 =?utf-8?B?N05HdFlSSU9sbWFZcS9RWUkzd0FsMnVLY0RrYkIyUmtsT3pLQmUwa1o5UGxL?=
 =?utf-8?B?T3hiM3pOTVYyN0NUZ0hLMzArUjM2dWgrTWphdmFhbzlTbHlCUUI5cUVVSmpD?=
 =?utf-8?B?NGxySHZnTU1ZeEpDWjNsODZXNXZhcDEyTGhzWnR0dU1UM3ZGSXVuM2tzYjhi?=
 =?utf-8?B?K3g3dVJtdnduQmdSWFFIOWVpY2J5bVVFWDBaVG1NbzlTTWVoNk9ZNldKSDFS?=
 =?utf-8?Q?gEsXM4u/A+jyc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b247f33-f0d8-4bb3-7d0a-08db1a51bc87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:37:36.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzClZjcnSrNcEhN2lCFYG7EP0GNLPIbSwQJJq2iabU3VuZr1JbpQEQAo9lbCjF5hXDqU5HXwpgCZqET3FTJ7N7CPnu02nwBhE/8ygeyA7FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_08,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010106
X-Proofpoint-ORIG-GUID: fkjE5htNfMB8kAa7ZlJ6z340sLfyyA63
X-Proofpoint-GUID: fkjE5htNfMB8kAa7ZlJ6z340sLfyyA63
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/23 12:09, Vegard Nossum wrote:
> 
> On 1/12/23 19:00, Serge E. Hallyn wrote:
>> On Thu, Jan 12, 2023 at 02:19:11PM +0100, Vegard Nossum wrote:
>>> Creating a new user namespace grants you the ability to reach a lot 
>>> of code
>>> (including loading certain kernel modules) that would otherwise be 
>>> out of
>>> reach of an attacker. We can reduce the attack surface and block 
>>> exploits
>>> by ensuring that user namespaces cannot trigger module (auto-)loading.
>>>
>>> A cursory search of exploits found online yields the following
>>> non-exhaustive list of vulnerabilities, and shows that the technique is
>>> both old and still in use:
>>>
>>> - CVE-2016-8655
>>> - CVE-2017-1000112
>>> - CVE-2021-32606
>>> - CVE-2022-2588
>>> - CVE-2022-27666
>>> - CVE-2022-34918
>>> - CVE-2023-0179
>>
>> I think it would be worth pointing out how many of the above would
>> actually be aided by this patch.  The first two would not, but certainly
>> at least the can module one counts.  So I support this at least in
>> principle.  I'll take a closer look at the code hopefully tonight.
> 
> The intention was to list _only_ CVEs with exploits that would be
> mitigated by this patch. Let me go through them one by one, just using
> public exploits found with Google:
> 
> CVE-2016-8655: this uses AF_PACKET. I guess your objection is that
> AF_PACKET is rarely built as a module and even then would most certainly
> already be loaded as part of regular operations? I see at least one
> distro kernel having used CONFIG_PACKET=m in the past, so I wouldn't
> write this off completely. You need CAP_NET_RAW to create this socket
> type AFAICT, which is why the exploit uses user/network namespaces.
> 
> CVE-2017-1000112: uses AF_INET. Agreed that this would certainly be
> compiled in or already loaded, so we can drop this.

[...]

> All the exploits seem to be using user namespaces, for CVE-2017-1000112
> I think it needs it to set the MTU of a dummy interface. I'm happy to
> drop this CVE from the list (I probably looked too fast when looking at
> it), but I think the rest are legitimate. Added Andrey Konovalov to Cc
> as he wrote the exploit I looked at and can maybe confirm (and in
> general has more experience with exploits).

Oh, I see -- the request_module() call in socket() happens before the
CAP_NET_RAW check in e.g. packet_create(), which means you don't need
user namespaces to _load_ these protocols, you can just do the socket()
call in the init user namespace, which will load the module but fail
creating the socket, then call socket() again inside the user namespace,
which now succeeds because the module has been loaded...

I haven't looked at the other CVEs from this angle, I'll look over them
again and see what I can find.


Vegard
