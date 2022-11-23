Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62FD6366E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiKWRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiKWRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:22:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79C7A367;
        Wed, 23 Nov 2022 09:22:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANGsDgl025969;
        Wed, 23 Nov 2022 17:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MrtkaH+I68DBQhNwxzWxVQuJSh109ttdTaRDqL4CfH8=;
 b=MKiz8qGuAN33LAKI4hxEjPDVBn5F2HgbdWK4zFOqF5ahInaNP1N+3OVObkNNwQ2zawvH
 Pmpe3rQvarjah3Ck+DzhrQ+uSyeznUPlV+/qFIntnhyp+ZjQpGBSgzlozsDbugSxjY3u
 U81rH6PKGecZKREIxJnxcaM/+ThpDRAkKc7ef4RmjXe/KieYJ1I9gl2RIi6hqsQw2Zf7
 8wmXW4dI+ymh8EKf0J+TuWK9j6i+ScXoVT/t1JAeGSvy5I2MUtKvizlf5UqntE7RDaCG
 vD9oEy19akVc5IOUrcmknzpz1NGnIRtYZIuPY0zMb6A3PQrdmSMVNHxw+PqGFfAta0y4 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfb456x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:21:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANH40s2010749;
        Wed, 23 Nov 2022 17:21:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkde7gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfwFLb6rgr0WYKRUvA7qRY3TM5RnZ5WiWfK/y5wwbOn00gnytOWnLntVlOVM8gXakz6vLnQCQI+OETWIJNCEJOo3l5d+ZQPYPjTih/ChzponCVaSwBMgFv+H2ikkr+r6z7S+qSyC2Nve+vjqb2JvomFp/jFsJBCPZdKXJr2wbqcvZSBUhS7y/WI4EjUnJoArAO1SpsnKfiAvwaPb120GD6fhUQYIfFN6Xu5Mx/BUfinwiZkSCTZevuS/rdmuQng1thG02UNfK5P8/MUVbYgAJyd5jiyMwwPOFcnYlKBkQYulC35L/PYNGaKOkS/s/8ld7od5ZBamxrNGsjWiSV7RYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrtkaH+I68DBQhNwxzWxVQuJSh109ttdTaRDqL4CfH8=;
 b=JGRygWIbz1qd2SOuFsv9B3r4knB33IoQZhPqIVbLIoE9Fx6DYbxV5IQKUE4Q9ZSTW3/9U1wlANFKAPiUVADlQUpNPBNWr9VzuTzXYWvZ3W1ZcY/5L89kkgRLHgdAi+5V8wMTFOV5AkiUTjHOTTz5oHx42B3K9A1PVijGoxCsLoXxL1YavOXdPikhqgcmxfrtPbAR+jEp+APgZckBUJ/BHi8cZxPB5ge38U4LZ7sWrWVJLLeTVY/e9q2UKccAQgQyWTCI6fr8KkJWN0hQtszElePz3b4mCxcfDlIXLYS044HbhBTO4GngGa2nfjDjWuIAzuBERRKgN4/9nHnofkpWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrtkaH+I68DBQhNwxzWxVQuJSh109ttdTaRDqL4CfH8=;
 b=g4YcjoC34MbCqCVynMEfiSdcKnI3fZ/Iz/tIIoRjsl/vhcnJQub8N4TwPenfKoLOyAKAsBHDzIvzwHX4PfCKIepEFUHqIwgpRaTUAxKwdi5j8qUq1zrXBV4HiCglf7/SLyNI6Xq/SK5sz4t4k8kuJc+PA+WmpC2Hv5ljmAfN3Pk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 IA1PR10MB6195.namprd10.prod.outlook.com (2603:10b6:208:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:21:44 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 17:21:44 +0000
Message-ID: <717da158-5a7e-b478-61d3-3753b0b00e01@oracle.com>
Date:   Wed, 23 Nov 2022 11:21:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221122213040.4128105-1-haowenchao@huawei.com>
 <4d21f806-6653-5457-918c-563a3032d128@suse.com>
 <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:610:76::8) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|IA1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 911408c5-64bb-4f08-bc80-08dacd77318f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/wUVSIs89zm9uyoWfzgpmIbXDJQVhG7IIvHuzNrBWsStXt9W1CqATrzRa9H6UhHVnLqsRojXTQsUWrFfH+62gR6trA0yybOUkCXLsdBjPcL8tpOxMQQeOChTT6P3BmgJS41zz8H5+AqFuLAfBDLdjQR1AxWF/St2bmA3VoB9ULqt5bMH//zM7ugPBg/kb5eAJNggY1Vtw+3yxiHS43mhAE32k2LTiRdl8xrBOPQVpFVkDyC9HucriFoF9yGDycqBwDDLbJZ4BPpZVCz3+N2b81LUFDdY2PrXU48ZrWNTTYEDQYReUwaybjRfs1hGwdEj0HwhGes65ikJOzdCp3RhWja8uS571QxkfMGqhyoZnqRKt1XCLH0XlzXbj2A5CK1rulFBRUsH/2Mw9wGRBKj6VhgWa3KI305yUEFBvh1N289DhN/ei3VJtXL/wVbvtpKj9urcsYdmjZv89NwwN/dYsMADbSP/gcGabfIC5rTdK+m+bQrgake5Tyd5tAaiAtbG55xRQJYr457UDfhUgYaA1kbUh1uZxQH3M7Asp6aumlvJG1zCqtr3d+Vc2O5ZZDMlZcNnLkopm/mapxDAOktFE/GLeCzBk7dEJDcwq9l9Y1EeT8ttbXzPXDCB/X0pdt25ZumbFWqM5NEgDZGItgdIa84p4Aw/Dnstb5m8W/pqMOfjO2VzOJYjiQL4S86iWF4eQmAsu2FMWz0nQFyUhkVel48JF55PiYop9Mg2bBei3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(36756003)(6512007)(6486002)(6506007)(53546011)(26005)(478600001)(41300700001)(66476007)(4326008)(31696002)(86362001)(8676002)(66556008)(8936002)(110136005)(66946007)(5660300002)(316002)(2616005)(186003)(31686004)(83380400001)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dhMVc0WXFVWVpKRFluSGNIa2ppbmhDQ3B3bWhqMFJpUmFTR01la05nTWNu?=
 =?utf-8?B?N2N2WktuWlB4aFlqb25NNnA0M1V2aGtjaHVvcnJubjNqUG56bVgxTStocHk1?=
 =?utf-8?B?OVYwdFpHYkNzWHdVbUE3RDhBWThrUlIvTmd1UTRhUGd6SHhQT29YMjVlMDVH?=
 =?utf-8?B?U1FqWk8yc1NETUp2eDdZazRxUFYxdTJBRnZnbEp2MlFXTHV5ZWZhUHlwK1po?=
 =?utf-8?B?bFZrMEZYNTdNREVxU3MvOCtkUk92ODRNcHhxcEdiS25GOWRRY1hlVGxJaVo2?=
 =?utf-8?B?REpjNGF4b1YySU16cm54MDVPUTBxMEIyUU1EOUpiVDBFN2FJRm9uRDh0VEZL?=
 =?utf-8?B?aFNuN3dXaXNYWDZOKzhtUDhNcGpuU1BzbVBwUFFFRTIyY0NkWktPRXY2aU11?=
 =?utf-8?B?TFF4V3BrWmZkNUQ2bHJIRkppbHJHZEh2Y3p0enhST2ZtejBhMzgwbnpFT2FX?=
 =?utf-8?B?Z1dIOXMvMHV1QzVLZ1BYdUNORXN6ZGhXOUoxamhZeGNZTTVvNjh4TGpQdEtH?=
 =?utf-8?B?cVRoUnRVVm1XTjcxV21HYWVXNzhGSTlBdnF3OXJteE9Kb0NGTUJoQlh6bERi?=
 =?utf-8?B?Q3loeEMyODIwVDVyMllnbFUxT0hmTVJrWm9BN2xjQXRYTHRPV3E5WHBISkND?=
 =?utf-8?B?aGtNZDAyRHowWEY4dVBtQlpaUWlHbGxkUzYrQmVhdlg5WjdlWFN1SlRubENl?=
 =?utf-8?B?TzIrTWVHMlV3S3JkRE14eHowUEhpQ29FK2pTdUtGZnl1QjdOVTh6SXFvVEdm?=
 =?utf-8?B?WEkvMUU0ZEJGcWVzRGhnRjVDVzltUVZFc3lza203TmxoVVQyMkZvY24zTTNU?=
 =?utf-8?B?TDlkbWltUkdCeVFNT2xKWWpjSlJnZzcrR3pCYjQ2cGh3V21vV29vN1JvU1k0?=
 =?utf-8?B?V0Q5MUpxak9PcFBlbW5qcUJWU21JTEN5MVEvTmdSOUpnenRveTY5dzROVkFp?=
 =?utf-8?B?MGQzcGY0Ymg0VHdlcEZENUxoa05nSVNSOTdHOW5mRkIvS1ZWYnU3bFM4SzRa?=
 =?utf-8?B?QWY4UGR4aXRPdTgzdlJ0QktsOHFzaEQ1VWpwalBEb0ZXRG5XMDBqNVVzd1VY?=
 =?utf-8?B?SWkweWFtVGJQN3JNbU5lVkxhN1NyWU44ZVMvUWtGVkxVcjJCQjc2cHY4SEh6?=
 =?utf-8?B?UVJtMzZsc3VEeWREMTFTc2tKN09hWlVvbEdlYTkrcXdIdW9mTEx2RjVMaVRa?=
 =?utf-8?B?aFdxd3Yzc0JweklxYmdPcHpXTVg3RjliZEYxTUVJeTFuTitDNWs1SVpPVVJH?=
 =?utf-8?B?RkxHN0thVVdxNTZRaHp4ZCtpRndEZ21QakwzaDl4MEdOSVZVZFVuemp1dzI2?=
 =?utf-8?B?VXI1clJmLzlZYjIzTFVMQzd5bHg4NUtzTTZIV3M5RERKRVhjK0tEcWJTTzU4?=
 =?utf-8?B?WVd2eFM4ZjFHTGJtQlptL1JpdlRMVUlvZnhsSWNCSUZ0bEt3ZzVUcU5PdGFt?=
 =?utf-8?B?cnNycDdnRytzdDYyVDJDWUROczl6L0Y2RlQxNldBcTBQV1E0bUxPNEtWenhD?=
 =?utf-8?B?eC9QL1ZTVTFvT0ZsUHBKQzVhdnN5NkdMV2lNS0FNVEhOckp0b3N0OFBDL2FX?=
 =?utf-8?B?VXVFQ2RDZ2U1TmY1eHZyWC9peWhxUFdHd0FXWlVqWEFkWFRvQ2dETW0xSnlt?=
 =?utf-8?B?eW1YVllZWVhvS3UrT2tvWi9pZ3lXOUdmTVhyMlN1Z0Z3dy9zOEh6QUk3a211?=
 =?utf-8?B?UmxrenRCSnBZeUxNZzJubEFrdWE4djhaYnMxQlpiSDQ0S0lhbFpqVC9Lb1JD?=
 =?utf-8?B?Y1VPelZERWh6d1ZpamtOeVJKVjMvUlRkZUs1UCtOOGFKS2dtcFZETlFaQWdj?=
 =?utf-8?B?MG5OWEJ4YVdKdXFOU0FJRkZVT0RoWSthdXltbnJWazBPWVFRN1I2WG82OVJS?=
 =?utf-8?B?bEFTMFpRdFI4L2NHT3NIMUhQQTIwb3ZNbWJ2Kzk2N2pFZkNxMXJGRkZpNmFa?=
 =?utf-8?B?aU1uSEdHRUQ4bzNVbU5vN002NXhlUWgvR3FaV09sUzZoUkhvTVl0dFk2UFRU?=
 =?utf-8?B?RkdNZDVZVTRDQWdUeGNXakZuSGNDSkkrRHA1SnhvQkVBTlpmc2pGN0hXTlFX?=
 =?utf-8?B?RUsyUVRDbE40NDV4YjhPQit5Y05nM0l6MW4xN01kTkdzQ29sa0tGSXhVQmpM?=
 =?utf-8?B?aksxZ3BWNUJUbWpLRXd1R2trL3R4SkdTQzl4STg3TkxFeVFIVW9TTGhsL0I0?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YnNMZTlLMTRrSFJTMWZWcXdzVW9tT3oreVcxUEhrd2pRZ2daMWg0ZDBiZk9R?=
 =?utf-8?B?Y2JiYy90cWliQ1QzbUlVeHgxanl0c09ROWdXbm1OSkV1eTNtMkNidy80dENQ?=
 =?utf-8?B?eTZvbi84SWJKZmNvYWgzSFA3UjRXeE8vNVVFSU9zU2JuWXRZckptSTZRNDQ4?=
 =?utf-8?B?dXJVL29mS280MEQ3LzdqNmdZZnJtbmNKanU5dXlERm5SNFBrcDRzN3ZWRnd1?=
 =?utf-8?B?OHJ2RnI3OGFSaW82M0grVDhKeFlWdllaNDVkYmdoS3pVQ1RmdnVTeGZFUisr?=
 =?utf-8?B?Q3pybldIVWNMUG9CVGVOOWFsZ3VhR2l4OHBQMTVGbVVkMzVaNVJkcW04aHdK?=
 =?utf-8?B?a1dhNXBZd0dqdFgveUVMM3RLc1YrR0VPdit1T1dUVGp5QzhJR0x4eUM5TDR6?=
 =?utf-8?B?Zjc4by8zSGFZcHRvUHVPbFZNaDRGVjBkemwvSFo0NEdCZlpwK2dodm5XUlNC?=
 =?utf-8?B?bnJjRXNtdW5JTXA1RSswdmtXeHVZWTBPUzRqckVjZG51N3hXbnN0aVJaOG0v?=
 =?utf-8?B?TVNKaUpmcytNU1hCTjJqSjZDNW96eTlsY24xS1dJUDQ2cXJsdFpJK1l4VjRs?=
 =?utf-8?B?R3FCWDlTaUJCSCtMYzBSSDN1V2tkQ1czTGxjRkVhWmZQb3VjRnlXYXIwVmNZ?=
 =?utf-8?B?TkNsdFJQUU1jV0c2VXd2ZExNbzZwWDJPY21ISXMyR0FWVFdzcW52VGNneW5p?=
 =?utf-8?B?SExHZSs5d1JUdUJteUIwN2ZNTHQwSElqdS80eXRsa1lEWm94YTdsdWo5OVo0?=
 =?utf-8?B?WnYwdzVVbmgydStXZlY4elBHTi9OSW1Vb081ZVZsQmwzbFBXZFp2MmQ1NGVp?=
 =?utf-8?B?eVJVT2xGS21LOXJwanIyVlFFekZvanRYbU1wMHNOT1c3UjJGMkQ2WEo2UEhh?=
 =?utf-8?B?eTYxcFBrWHJyNXZpUU41YTNWSSsvZHRMYStMVkFzM21pTmN0M2FNM3ZkOEFN?=
 =?utf-8?B?NGlRaXM1djFWWG1VdnRJN1VtKzhUQ0JsbUl3NG5Jb29NNFU3L2FwMkdhdVZD?=
 =?utf-8?B?bW82RFl5dEEvMWJtbW9hSUpacUV4WmlwRE9iYUQxYldEbVdPNWFJVjZxNkJS?=
 =?utf-8?B?alc4R2hYaDd2bFRBV0RKS0NaOFMvbjRSTkI5eGxkUk5yL3BOeFJCVVd5V1Vn?=
 =?utf-8?B?TldWbWpTQjlya1lRRy85akk5d000VGh3NncxeHFjRGEyRGhCMTc0WWJNTFU2?=
 =?utf-8?B?aGJ3RUVwdTA2VWJjUGNnS2owZDQ0VVBVQStsNVB3dG9YTzUyWjlMTlFVaTdp?=
 =?utf-8?B?ZnpyMWNqUFFIampiT1d0VTF2VnlGOCtqTVNnQmlMa3JNY0U5V1NkSUpSK3hq?=
 =?utf-8?B?NnByYnRNZEpDMUpPZ0JDTUdaOFJPalRBdW4rUHovYmJXZThXbXo3aVpjejBE?=
 =?utf-8?B?UUwyVUVGaURIeHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911408c5-64bb-4f08-bc80-08dacd77318f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:21:44.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8GEeE6jjPVh4GMTZzllELB9OJWbQdWJN7XYSwy2dUD0T8l7PSMDoxg9R6HL9EBUDutTDtn/C8VuMa7poI0VIptd0fSk+3pPKbcr9wERXnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230128
X-Proofpoint-GUID: AwM4Aa-K3NFyPwh0RWBr84bw3pi37BF8
X-Proofpoint-ORIG-GUID: AwM4Aa-K3NFyPwh0RWBr84bw3pi37BF8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 10:41 PM, Wenchao Hao wrote:
> Sorry I did not highlight the key points. The root reason we need to record
> node_startup mode in kernel is userspace's node_startup mode is unreliable in
> some scenarios:
> 
> 1. iscsi node and session is created in initrd, the configure files of these
>    nodes would be lost after we switch to rootfs
> 2. someone do iscsiadm -m discovery but did not specify the operation mode,
>    the iscsi node's node_startup would be updated to which specified in iscsid.conf
> 3. someone do iscsiadm -m node -o update to update nodes' configure
> 
> What's more, it seems "iscsiadm/iscsid" only refuse to logout of an ONBOOT
> session when logout is specificed by "--logoutall". We still can logout an
> ONBOOT session with "iscsiadm -m node -u comamnd".

logout_by_startup does go by the startup setting, but I think you missed the
session_in_use related code. It checks the mounts and holders already. Just
change it for whatever you need. I think your lvm use case should be covered
by the holder check. If not, add it.
