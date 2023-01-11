Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A346658A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjAKKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjAKKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:10:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B674F14D23;
        Wed, 11 Jan 2023 02:07:01 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BA6j7Q022534;
        Wed, 11 Jan 2023 10:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jSrbyWKTxQJvubilskDUEr8AmjkYmvL7wSfFTwfp/WQ=;
 b=xi1/vkDLwjJqt8TK/BAvwokHFJ8qpb3xDDWI6MtpqM6C7EyH2q1x/jHrzedamJhl5sV7
 nXR7vFe6j/VFoCpCIi99RjSS+pZF7GkO0Bsqq5Qka0Xw3tsOh8ZCFUIb9UvxJZIqlE7L
 xGuTM4hIYEKkDujERvKTPgdO4XWIJFiFue9EcH/zQHM0Yfk25QbJ7CAfwAAoBIKeaPwy
 KcCauapp622jSc6e42T4AbO+HYd3QWyt9D79EUBtqbiSIObJwud3gGeBXCxLDH2sZHI3
 IsAv/Q/0QO0FUFVYgcguubBcShXlsdJyizqX59gZf4a1wMApoOJZ6vAgU6FaoaZ+zyma 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bjg9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:06:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8cQ8a018174;
        Wed, 11 Jan 2023 10:06:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ngc4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr0NlyEeI+cBQ1bOyazA+fHKp8KTCgPBIvEKCe2YCykTmT419TyQNbX9UEfgLf4VgAQJLAzXKAHWLYcGD6zDTEd8ygYAo649SjzqtxTEJ8zibNthW1SQVmSkwhDmDtUyboRUEs2nAKIPknKa8g8Zem8Gta+iqR/4+DYLDv1KAVn8kw+NFwdre4WRMk6UwAibVPsaSKr5DBWlpEMgfjeNIuRI02H8Ndwj2HS2Q47Qmxx9OKMdkajges3bTODRJzac4dED1cMf/90k3zXvcn8FcFOmXWPKcg59aKBnWDTEW1K0+OL03I842pHyljxI0jHmjJGAqZs6bXCR8z3ELGwT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSrbyWKTxQJvubilskDUEr8AmjkYmvL7wSfFTwfp/WQ=;
 b=OaYRBzZLq7sRlJe2VbR7GBDW8/7BlpBeKqoEAGzHFnhrD7hmGuuhA2jKn/TyP/9WDTXcDCVvB54IEwi5ucLJJz+/kIGp+xRcsg+9bRCJnukw0zcvIo7ejvFQBHKeII4m5r3vIbjBMQWeNBAeqhmHhePVAZl0PvrcxZrR+qhr3xiT3v3oNnOyoGWLPnI+rDltQECsXu0WR4YA25lNo/IqUWP0KciHm+cwSg3WBCNXtOPy3DKz0YvUsAiBW5MaCF9gSVo99COgUAW17lOYfOj3ELhxhNH4DH6PE24lRK9wh9kE0sBnETlSgYxedE0GDwAQqYa4z3Yh03JAsaygwY0tOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSrbyWKTxQJvubilskDUEr8AmjkYmvL7wSfFTwfp/WQ=;
 b=TwwPAZ+v747JDbj4rX3rVLKuJwlX0zIAAs5bQMHbRzEgkEamFQtl4Se7VwAwczTunXr4U2yhtvGMjGeQMdhrlRbgG28rIr9FhrsyMBmoW8iB3BIyV+OHpLKwMB7PeoVvgWdB4G39K/N4s0gnxFNjhcwBG4qKz0XUvDHgy844+nw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5604.namprd10.prod.outlook.com (2603:10b6:303:14b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Wed, 11 Jan
 2023 10:06:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 10:06:35 +0000
Message-ID: <cd833e18-a33c-02bc-5b74-1462ebf74f5a@oracle.com>
Date:   Wed, 11 Jan 2023 10:06:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20221227022905.352674-1-ming.lei@redhat.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: af102b1d-9236-4593-37c0-08daf3bb858f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2y4bbjrHqDc8R7GxNgfpMSILq7uQ1a4YsNgEIz6rUW607HHl8QWNMpaV1QPHs4/Vc32JcxbnRJEK7vBUD1VLn+2eZG1fEYG2ur1um/9289v21kGiKuNcNW3sO2CaHF1ON3RyKjQn2YWCLRTN5x0hYYRTU+2Lg0IeybbhLFY1PlEzaWnaBBRnHjpFEGN1WYygUj3MuDXqBBpUkDUPdU5XpJ+QEHm3L6FEb4TgiNZpQ0PVCy80V817nIgoXAqM6GbFqbJF8Ir8tSp2FNN8HGLjuARgjbUo08eUFsTupoUdi4GNWj+3Z15MKQCLRhK4e10CMfWJ21Jzq3mEaOinlrsLGG08P32azDWT7gCyKwuNoUv3mdCNCWisrdOV3YbbQlyU6D5wvt46mhRzX/gzypynVtpynrADlM0HHZJcTgBD+krboQnb+Y5tt0Py5BSjMUKNse++jnOrZ+lb88jEIcdCzokzM4odg1Gb8mQ8QOKtEI5ufNxN38Ds/FIN1yIbBtULdSxWEbrV6FM/UlYKVvlb3QrmN1p83FFshFDW7uC+J4p76D/3lx6Yx/Djcc5w++elDpNotiVoK2AqO5NTTvIWAYTm+0leKkJGP6npC1brQyWe4dTNRAoLBViS9HwsvSBvtN8/FAMYOmWj4WPth2Zk1OQN5xQ/pez68EhJX6Ly6GMrZZYqu08nVsj+ZWSCdP6D4R+koEZ6+th62RHJxcIrRfNbjNuf+Od75ui9zRmZgBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(31686004)(38100700002)(6486002)(31696002)(478600001)(110136005)(316002)(6512007)(86362001)(36756003)(53546011)(2616005)(26005)(6506007)(4744005)(36916002)(5660300002)(186003)(2906002)(66476007)(8936002)(41300700001)(4326008)(6666004)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhpRmMwMzRyRVRCbUF0T1VIZEFQcDhmTmMrbmg2VWU2VDVaREV4dVFZRnZm?=
 =?utf-8?B?ZGlmdXgwaVdEWFFyOE1KaG95NHBhRksySENaYzZLcFVQaUhuZlArUjVwN0sv?=
 =?utf-8?B?dTR3RDJteU1DWFZucDNVUmduZ1UrSVM1RnpoRnNRajl3U2hjMXZvRDJDa05H?=
 =?utf-8?B?TjVZYVMrYkptREUyRXd3b1Fja2NOdjVoTGZPcXg1MEhjLzRjM2tuUHIvdG9V?=
 =?utf-8?B?SkkvVGZJakhMSVdqa2VsL3lHQU12d0VhN3VMbmp4STJSNllPRm1hZlljSHhj?=
 =?utf-8?B?T3pMdHIyY01zaSs5MVFFUU9zckJkNVIrM0JYL3FGdUhCWXBLUEszUTZkaHY2?=
 =?utf-8?B?d2V6aU5GT1VQSDR4UnU2NVJmbGxrREtyYTB5emZKcWw0NWxIZjB3Z0cyY2FI?=
 =?utf-8?B?VWVuWFN3WEw2dElCZ2w1NEtaQ05LM1ZsUGpCWFpVb3NmeDl6NVlJTHI3S05I?=
 =?utf-8?B?d3hhcENkU1diYjBIVlcxWDhmUndmbnNKMlhqd0RNT3llU1NvQUhxbWZDdzZi?=
 =?utf-8?B?TzNWRDRhMHpDR3pGSWR5cUtaT0MyYno5UzhhMThKZDgxblhtTnJydXB6YXRq?=
 =?utf-8?B?RDVQc28vZXpPN1hrS3N1WXVWcGh0U0ZDYlJ3Ly9yYWtsNkdpQ09OZkIrV3Ev?=
 =?utf-8?B?MFdvUzZOQmg1aS9ScWhFb1FJSjlQd3VleHJwVWIzK21HYmN6R1JxMG9qTFh4?=
 =?utf-8?B?Nm50OGU0ZnhGVWJHTXdNa3piSEJ6d0dFTnM0ZEs3WHlpWEpMR01YdjljVzBy?=
 =?utf-8?B?WnJIWE5Ha2xqU2J1OFdpMWI5WFFlcEdyUUxJejUzdFc3am9QbUJiREUwODF0?=
 =?utf-8?B?UTFGWFNsVkdaV05WTmlYdkxjL0RBeGVsWWdZaWpQME5HYnN0UkkxdlpkeGxo?=
 =?utf-8?B?azMvRW5WbUdseXF0YjdWSnR6ZWh0Q3dTY2dFME5RSnVSdEZucDRTOXJSUGtV?=
 =?utf-8?B?L3BjTVFkOSt6MDllQmh4MUNiU21yZ3J2ZzFHQjRYZURpdW5Pc3Vwb3hDc2Nn?=
 =?utf-8?B?US9FeTNkTXN6N3U5cWh1elR3UkpvWHRXU0hEVnlNeTQxVGNZcVN3TlNvUWVp?=
 =?utf-8?B?QUJVOTkwNTNDaG85MEJMV1lsQlFEYTFEajlUQjUzVDR5QTF3L2FYYVA5akpN?=
 =?utf-8?B?Nkl0a1JhUlgvNDBtVUxhbEE4SGRNQkgzajJWWFBuRzZWZEJ6b0VDeHRKUDRT?=
 =?utf-8?B?RUtQZHRxUjU5RU43eXJzencwb0tHaGl4Snp1a2lXbzN4TUVGQjZGTXFRUHQ4?=
 =?utf-8?B?U2FrVFA2T2p1a0ttZEpLb2FFRWJKcWVDU1JGVlM5UkpCNWVrLzVGdXAzWFNz?=
 =?utf-8?B?MEhPZnB1SXFzd3JJbXJTbEUzZ1dmeDBCMWtMK2xmaXI2cDJEbVRMdU1JMk9n?=
 =?utf-8?B?cHBsenhzK0VZQW03UDZKMkQ5WENxbCt0R25CVkl4eW0xcTQ3VWZjdHNubnFh?=
 =?utf-8?B?bVBZemVZYytPa3ZsTjFvR2c5L1haMStkaW1zMGRKUFh4OUJMaURmbUxTeWo1?=
 =?utf-8?B?YWhCYjNPMUE5ak1wZGNQTzNzcXByNGVyU2RHTzV5aVFwandDK0RyUWRZcjhE?=
 =?utf-8?B?WHpKRHJjTWZTem52OWxHZDlTcmYyVC9SVWFRZENQNW13STJsS091SVNhaVZG?=
 =?utf-8?B?MkpZNkVnMlI5WTdRZ29LUEdwUnlPMFlYL2hxTUZNWXF6VjhvdG04TFRzQUNt?=
 =?utf-8?B?b3U0Y0VQYTNZcEdSMTVodVZKQkliSXNQN1ppYXBxUm04M3ppRHpTdzQ0NzQr?=
 =?utf-8?B?M3BZaXZiaXhMKytPM2FVcitYQVRXTmtiVUxKK2lMUDNxL3lkUEE2Y29rVStD?=
 =?utf-8?B?ejRKdWpQRVEyTE1aS0JMT1NKQXg0YjU1U1FoR0ZoK3h4Z3FYVk9TRzdMUGFk?=
 =?utf-8?B?QTFZckJrZlpGMVp2NEphby90MThqdjBZVVlPc3NPdExtOHNFWWxRcTF4SFZo?=
 =?utf-8?B?VEgyM2ZQMThLbnJmcFV5eHNKQXRqSTlEbUxoNXRud2cyaDh2M01WZHp4UVNu?=
 =?utf-8?B?N1hYeVN5NTF5K0phc3MrdUx1b2NYbGlLbWU3dk4wUDNTYUwrRjVDSXBmNUt3?=
 =?utf-8?B?Q2M5cndkQU5ySWFmM241K2pQZ3ZPZ0RUZlhRMVF3dXVLdUw1UG01UWpIbGU5?=
 =?utf-8?B?SmN6WHgwSnUzV3JPdXROTjNYSDNMWVlGdjYwaTZaVWxBbDZmMDFuK3J1ZThm?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lDpkROjUK0+2bYBVqY3A59rKQIjXt97gtjhjUX1M9bo8E0XIQm9OwYUTuJQ4X8umIVmxcdw9k4Am+GqUhsIql9ov6bbu1VTRKzfJz99EdX2Fu4nS40xUqycrRwSYYwtzfIML2BFw0ELNk4zs0fM3uRDzmQGeIORccLHzeY0/fXatS6A32D4jEchVhlg8xirzTEoMG1GyIkHGTchOEhBlXRznhD9TPvfdGR6pFiMNgAH+2xTB4xW8HTP/T2qIzA86WoTKrc/5/AX8LBx5xdDEDtaq+lPUNLsqDEKRXgflsUsAjUjhwZsjChZ3Yv9XCQIoO5ozpp5ePRplLh5Wn6Eb0VDJr+Lm6kxIu9yPsLBGKs4pPUZ11/qf3leUnasuWit5fp7bjz4kxtc8Ms5VH/Yk841CNWw8NoM94QLHt/S0Oi3nQmisJtVvtXwsDfkPAC+Uj6SNb1MejtICgoz664mKpSrY38Adt3pYad8EPJcD/IgB4SN7C70nXe4MfDbG3Eot/BSw3qqFKQuLVJDLH++fbEeyt+y/P5ov1jqUbonVs7sw2/1uQFLRBpmsKaoX8HF60xn5nxwPgoL6ArD2H4xRFHghqx0jNZknjS8IhKe365e7eximoTZnvKeQDbgz188aXWcVMa2UVspAM5/loBpx7lFvrjNFkBgpLhc3UUoJj8S7hiqFshW7TBTBB1ELVWQyhSTLOcRMpMTEW8IkEzunH5yy6VHwSJ7lj7uzey8GLKJ/dmQLTqIroju5smmj70EhvcxM5qWDbanE8vnnLe//C//FyvRmqHx3Y8Hdawi+r26MfNaiXw4rmiKQno31baVEfmczXLQe2t49UxO4NTOP9kvKded2tt9v+v184chlAzDOj9V6cnv6+PKo/voB1djT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af102b1d-9236-4593-37c0-08daf3bb858f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:06:35.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFkbqWsPGBmTdvesBpl53oifGkfKFubNnL3q5vOB0albWvclO9ywLQiEQFdERDf/ZIGJw8yIO/CGJNGI1RjkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=948 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110077
X-Proofpoint-GUID: j25_u9ttDf4fwK11bGihgiGATykogvZw
X-Proofpoint-ORIG-GUID: j25_u9ttDf4fwK11bGihgiGATykogvZw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 02:28, Ming Lei wrote:
> irq_build_affinity_masks() actually grouping CPUs evenly into each managed
> irq vector according to NUMA and CPU locality, and it is reasonable to abstract
> one generic API for grouping CPUs evenly, the idea is suggested by Thomas
> Gleixner.
> 
> group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
> it to build default queue mapping.
> 
> blk-mq IO perf data is observed as more stable, meantime with big
> improvement, see detailed data in the last patch.
> 
> Please consider it for v6.3!

Just wondering could this be a better alternative for some drivers than 
using cpumask_local_spread()?

Thanks,
John
