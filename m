Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B66AD143
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCFWPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCFWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:15:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCB474C6;
        Mon,  6 Mar 2023 14:15:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326L9gac024314;
        Mon, 6 Mar 2023 22:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oLK1XUJG8271ECbM/Eb//bThchRM5K0NVOgCMW73G+c=;
 b=3ZlNedCxZ1/yDYh9oO+z7SVa7PwuNqJIg8/uFcumKw5bvJvju+laey8JMEIfIAaoVs8D
 g6o/kLbBYtOEY37SE1q+69vJdmPEcBbqeQo5Q7ScRDt1S3Xn9BFWwFbMC2AnZCeT4O4B
 3VaLcYUmA77naFGKFw1P6VGMX2y6iVKNJpwazBhN4iJ47voOTNulSc8b9hS+Dss5hS1J
 jYjezUufGmgFMPVYL/rIuJExfjjnTaH+s9fr9RjNlcVXg8K6DwTgy3isz/4aJy45dDzp
 KKczEb87A8bO2rIKl20P0dmo3Q3Hgu6hAOEYwIonvWlhx/A97KLFWPTKMfgtHws2whs2 BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180v47c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 22:14:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326LOks5037875;
        Mon, 6 Mar 2023 22:14:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txdmeek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 22:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llqUDjpYEwPX/n+DtROdyLIhRb/oPKjqkmCPuvBonL1xZkzTX3P3k8ugNQbdYzptfYGbmihjMvx1NLJkylR6YDavwYME2ZstJreX95sqaMlL5MBMsDk4TnzeNSIhoqf/7TR8GFWLW2R47d6AmWcX9ROK8EseqSpVaYGdJPuA6H7lFPOdLAftuZpkAr2INRSMf9KMyppHjfE/cCTDbH+28IiE6yJTHklOctseLlKy2qYz0CwW0e2UEew5BFho9NAOfZCLWVWKtSBlypAh8PbPfYaXGyGZx6PDcJsW1p6ERs1t+1RpXNr+0c4tJcn8JEA/f3povxNZAAEa/BUNQLKCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLK1XUJG8271ECbM/Eb//bThchRM5K0NVOgCMW73G+c=;
 b=Jp/hYG++8SJ5xB+mtykgZ/jyb3J+obg8oWYjTCl9p1P23et5mRoXWs5lEssRD8NEFUcQ2Jsr5v6eHXM85sD43jIxv1Oum7Ulxmitnubg69OcNXdnsj5ZgK1Evp2lWzWWL+Xyqnw92F8LkwCvDaxXLh1xvV0lLpagGAKkZrguaZ9OHz+Ik9GX/s5SW4uoaJuhREm6kSwjKuetAk9/TCg6ul9VvsMt0wczrMPxbdXpMv/cm87eoADjvYWXqpoySVCONKfyXpxRTAO5SXQnysKE0urpR1xrbECAFs1jVMk6qSLP9eo8dlzmCN/sW1cbeuLqhmWRfX7YNPiXRMEf9IGc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLK1XUJG8271ECbM/Eb//bThchRM5K0NVOgCMW73G+c=;
 b=Tsd/A/b9fxo8uHxVKICFJgMcaNL12P04mB3KuR0PsmtKS8UnBBFBQNsT0t2PShVqXTPVBI2Krgiw1sZBjZzpMImT5lHfkGQgW8eNkJ7XHPhLOhG+E4bfDcxocrMRCtoidX5uPRuv5vpl/X6Yoqr68krSVV0JJhOYTNDS1oA4hZc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7119.namprd10.prod.outlook.com (2603:10b6:610:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 22:14:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 22:14:48 +0000
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edq1o7dw.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
        <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
        <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
Date:   Mon, 06 Mar 2023 17:14:45 -0500
In-Reply-To: <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com> (Lee Duncan's
        message of "Fri, 3 Mar 2023 10:54:21 -0800")
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: b29cd8e4-821b-4d68-ed55-08db1e9032cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mf6q98yTbwEZpaFjXfLRuAq0ml4whc2P5BbhgM38p706No0RxWTg5pOwFxBUAms0dJgaq/Op+nZUhDe50oUDGF2F/bLwCI9iiLAqekeBFwjyYUXMi3EXtePwNTrWa0/6vBsLURAHkX32F//rlwQXYshhz1pxXeiFjo9Fbvik5qpWDqrjUGlIluLHDwg4w20yaQ/oPaiDHZbufewrpQvQNC1pLmG9YKjaJeWSdnUtPupFt6ecuA6gJEEo1Tc4c2hTuyu8fOGsbbl6Sb26rqyy0zR+fkwJHyKfHbUIB8W53bFPkq7/XgKVo6r6xS2gjBiAqIs21zyoZzmqsxW37h8WF6ICpwLtSlpQnxQZhZ9K2BLn37MH6ccFFZ/gGm9ZXfRDc/dlyDTzJcBVplsm3if8elQFFfEXJ/CbuAD7oX9R9q+sber2+j69Mgwvs7T47YxE5El4ErtyEb2Ocro7bubMEQ7Q0g5/PIyhWseSLe04lfseLuSadklianzwqmfFNOSNtZyH3eQ0aPCJvn4czNH6b2mpIqlr0ODwLGEEjs6go43dGTcBEU/Z4gdCfisZcFzI0uQ+2datvG6rGzxbwkFli9k8FNHuAWmfLVFNAnCPzn5ch1HaiN+0/aiLHL+7CVsfO0Bx2tXI20DcytEymBbIgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(66946007)(5660300002)(6916009)(4326008)(66476007)(8676002)(478600001)(316002)(36916002)(66556008)(41300700001)(4744005)(6486002)(8936002)(26005)(186003)(6666004)(6512007)(6506007)(54906003)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEtFeFIyNnRhRWlhd1FFOW0xMVJzZEJhNVpzYzN5WndwSDkxektEL3NrYnQr?=
 =?utf-8?B?cXRGKytjYUpoMkdGTTdGekdLZ0c5dVJSUzhhRU43d2o3TjJoUFFPOWc3Wlh3?=
 =?utf-8?B?eGxOQkZ5ajdaZ3pQMTNyc0ZWVEJZK0ZqdlppTzl1OXl3UGhCU1BGUEtNSlVa?=
 =?utf-8?B?aUUyOXpiU1RtMFJaTG9SOGJYY2tvZXRrZFFFWGJGRExydSszK2NWMXFhdjRK?=
 =?utf-8?B?L3cyYVRmOFBsV2xLOTlseDlMYi93LzFMWUtXSFhmQkdybGJiNUFGYnpiazh2?=
 =?utf-8?B?RExjb21heHlwcWRHT1ZVZlVBWmR4RFE4aXlRQ09Va3czOGdFek9aVWxVZjZk?=
 =?utf-8?B?LzB4U0dWeUMvZUtSNzREOWNlNUp3cmhiUyt5K0YrZ1VMRm1rcXV5aExpUlVD?=
 =?utf-8?B?R1NaUmhSWklqSU9MSER3V3EzOFJzSUFkS25MclpCVlh3bkpScmVBdEdBWU8x?=
 =?utf-8?B?WkZ3MTdycmQzYWZkei90OFB3bXMzbXVmVGhFK0x2WExzNWFPZlIzakxkQ1ZN?=
 =?utf-8?B?L05TV2xueXV6VTlOVmJJRHMveWJmdWVzUTFsYlJ3UHhRY2RJdStkbkZKOC9Y?=
 =?utf-8?B?bTh0TFg4YTNjakEvT2hzcXM4d3BTd0xUcGZSM2pHMTlEQ1pPTmVBeEU5bnVt?=
 =?utf-8?B?Sy9CL0R1enN4cTlYdU5BTjNKNTZzbmtoelFnc2Z1MmFtcyttWC9vLzRiZ3Jh?=
 =?utf-8?B?dHlyamtwdng0WHh6V29iQkFnZVM5YUFobFZ0RDhjd0dpdjBMS3lCQ0FNWWFu?=
 =?utf-8?B?U3JibmRzRm9tbFVZT01Rd0F6SU1sa2o0UUgxSHRMcm5Va2U1ZVk1N29kWllG?=
 =?utf-8?B?TU1rbjAzQUIyZTVwWDRqQWtYN29UbUdUMWFGOE14ZGwzZGgweXJ5cGl6Y05j?=
 =?utf-8?B?KzkwSWNBc1VVOExlbE1BTkZ0SHMvTGMyQVJrYUJUMUdqTFVKaENDNFZSNG5J?=
 =?utf-8?B?SHhzV1dGUCsrdUxtcHRFSm9UWE8rUmpleS81N0ZBdGlSOE5iaWRScE9DQ0xh?=
 =?utf-8?B?cjJ1TDJQaFY1bEVvd1QxUnUzN3pOUks4UVYwSTQ1Y1JWU2l3bDVMcU1QSXkx?=
 =?utf-8?B?NHFPMEhLN3d1a0hYWlhvN2t4a25Jd3ZlNElrZ3lvUVVUdkpWOS96bjQrSlVV?=
 =?utf-8?B?V0plVmFkSFhxd25mMndsYXZscURwSTJTZGFsVS9QZnhldXY1b0czOUVQTk82?=
 =?utf-8?B?MVB1NU1Vd0Fib2ZkeHQ4U0tXQlNNdkhtb2hhM1RzU3h2cFkyNmd6QzVaUkNj?=
 =?utf-8?B?Tk4vK0kwSGtzRkxyYXJGTG5VamdZL1ZpV2s5K0pFcEwxNGpzV3g2bHZiWFdn?=
 =?utf-8?B?NmlSVGNQVllOb1lOWk9lT1BVc3BpSXNhQ0ZOZFo1OUpBL21Vb2ZCcTQvTC93?=
 =?utf-8?B?ZkMxQXEzaXhqUVFxcE1IT1Y0Q1hkMEx6QWRmMlZyMUliYjd2b3h3ZVFBWUZv?=
 =?utf-8?B?Y0FUQ29FQ0RDYm5objkzK0NiNW5IT2ZlSTh4dVE1dzFkZ3RzOWp5R2pXZ0pY?=
 =?utf-8?B?cERwMVpFNzNFRW1yVURLNkpaamkxWXc4SVYxTzlURHBUalU5ZTVxcGd1aE9a?=
 =?utf-8?B?NGNNS09yVEhEZ0ZZd0VIems1cm9LTTJ5WUxhNk1MWVNhRVZzMkZoUXdNaDZX?=
 =?utf-8?B?VmpLOW9FU09yRkhvNnBWR3pDZTVsdzRqZ0phWDlsZ3N4aFlyQTdVTFZSNEtm?=
 =?utf-8?B?NFZmUFc1Tm8wR2hNamlQcTloUFZJNURMaVdSalp6VjY4b3FueXA5K3hmakF6?=
 =?utf-8?B?ME10VllDR2hpd2hQczcwQndpblFGVHg5MmFFd1BTQ1VyTm1nTXlxcDZqK0RG?=
 =?utf-8?B?K2xkbFNiUDdlVUM5Wi95a0F2UXIwNXBHVUhLZUd1eFFIdUxYczNVWG5IOFR6?=
 =?utf-8?B?Z3o3S0FhUGx3bmVqU2VTem9ReUkvaXR5dFpjeU9ncUVBRkh4UlhKcGtkdHpr?=
 =?utf-8?B?aWdnU3lteXVYMGUyMmdkc3o4dnROZWdPOHZKU0c0TlJnRGM5UFJTMEk4ZHEx?=
 =?utf-8?B?NGZpVFN6SjdIS1ozWmlyZ0FsU1NEWmpKdkZQMmo2bnpTS3BPSmVMczVsNk9j?=
 =?utf-8?B?ZTAyb0FOL2RYN1JJdGNrY3RyMzVRdUlsV3J6NXFIbi94ZWtvVjZQSDQrcjcw?=
 =?utf-8?B?aG85L0VtSkJDdHMrOEU5NzVBR25LcjEydG1ZcXE3VkxXNlg1bklZdnBMVlpV?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eTRBMXhCTHE3ZHlKd2JleTF5MnFsZ25ZRjdGRFNYdGZKRFZTUkRyalhhYWd1?=
 =?utf-8?B?QUtnbUhaaHArcUxCcjB1MXF2TklmN1FLNGpJeERWaitMUWUxYlJvaXJ5clJU?=
 =?utf-8?B?Q0s2enlkNWQycld6RnZtWFp1MnlkZ1ZkTnJ6alkzMmZhZzU2WWZPUjRqTExS?=
 =?utf-8?B?bFQveG1JUENRcEt3QVBYTFNTOXVEQmNkbE1uNHdLV0l0dnJlT3k2RTBQT2ZC?=
 =?utf-8?B?S2QzdWxCYlA5ZVRUMzFJcm5DS3ppM2ZSZWNIU3BLUm93eVBEcW95T0IrUXpm?=
 =?utf-8?B?d08vUXZjMzVvMWF4RlBBTFYrRXB0ZzhPbStZbmxHS3owaDRxMlRwbVVRUEF5?=
 =?utf-8?B?cVBkeG15SmlyODJ0VFhKRWw4UEVHdkVIZ3Jxam1BSWFpVXlUY0dnQ1RwOFRu?=
 =?utf-8?B?QXF1ZUZtdlhkSnpQSitKSDVqNGx4U2tyUHJtc1l5OFJmVGJQNmp2MFQ1dEVH?=
 =?utf-8?B?STNlZ1pHd1RJOGZSWGZwZUpJOUFSemU0NEF3YU9LN05pYTJZTGJhRnFvcnda?=
 =?utf-8?B?eUpqekNsQXF0LzRZU3l4ZDdmb0JoeExaNElFWE44UW5pa3hmK1NaQjJSeVdC?=
 =?utf-8?B?MUdHMUY1cEViM2hrNkk2M0tSZGplRnhmajBnaC9rSTlOdm1wcFMyUjdhUzFO?=
 =?utf-8?B?RFdobkhmYmZOc0tuV3NTU1kwODBtMFFOaFBJL3U5RU15ZFpGY1pxN1RSRlRZ?=
 =?utf-8?B?d0puOFBvUFpHOG16b05zYVdkaTZLb25wZGc5NmVNR2w4TGpBMmJmVEFPeW5U?=
 =?utf-8?B?blBZMzdBcGI0UlIwMzlSSUU2NlpFci9uQmY4RnJqYnZMNm4xUmYwc2ZZV2sy?=
 =?utf-8?B?OVg1NzZHVTlldVpwMEo1Y1MrSWFXODNkVS8rV0w3OVRVUXhGdWV4Y21xUVFy?=
 =?utf-8?B?djJxbkVSZDFYdVJzU1ZLMGlObjQ2KzdwOGk3bUtPalU2S0hlSk5id21aT0JY?=
 =?utf-8?B?UWJNZXlUUUZYQ3hVdU90WTlCQmZBNmdvVEdVb1IvTlI3RGFDYU1ldkovc1di?=
 =?utf-8?B?d25xNFExR2k1V0w5Z3Q5Uk9MTkxkaXVTbUg2dmJuSjhVODlWRGhBdWtxL1Nl?=
 =?utf-8?B?VkFkdGRhUDdLTlBXUVZMKzBQZHhZWEZYNmNkUmFORC92TkNXQkZnUHNHRUJP?=
 =?utf-8?B?YXY1WGFnSnVyUG1YSkU0aU1qRmU5bXJxb0ZkV3gyeEdXckNkVkpCb0NtM1Q3?=
 =?utf-8?B?Zm56aTYwb0xId0J5M09yaThGcXg4alA0Smx4K1B1ci9oaHBHR1BvSWpNMnlr?=
 =?utf-8?B?d0NJc29PdWFqbXY4SnViYjJGYTVvNzgrUTgxUUVGNXBwUnNEZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29cd8e4-821b-4d68-ed55-08db1e9032cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 22:14:48.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwBWPLMl8nP1IVcAFhpvuu4i6CmPj2RrwDlVKmpJcqzl8kWRUtEQQXPkPcmvXaDLBx/oczCBi2eg6NJEenldan9bR7oM4IeT4bZhHEi8y0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=729 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060194
X-Proofpoint-ORIG-GUID: 5GQm7Ojfv0mTl5yCbetCypr2aLdyJ0yS
X-Proofpoint-GUID: 5GQm7Ojfv0mTl5yCbetCypr2aLdyJ0yS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee,

> I know you had reservations about this approach, but the fact that
> another case has shown up where this patch helps means this isn=E2=80=99t=
 just
> a one-off problem.
>
> I know the alternative was to have the code that reads mode pages just
> automatically handle all cases where the size was returned to zero,
> but I really prefer specifically listing =E2=80=9Coffending=E2=80=9D hard=
ware, rather
> than automatically covering for it.

I'm not particularly keen on either approach. But I'll take another look
today...

--=20
Martin K. Petersen	Oracle Linux Engineering
