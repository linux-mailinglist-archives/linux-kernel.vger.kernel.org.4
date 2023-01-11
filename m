Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F00566587C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjAKKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbjAKKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:02:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF70DF58;
        Wed, 11 Jan 2023 01:58:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B8lsYS023695;
        Wed, 11 Jan 2023 09:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Pgj/rUOBcK+gP9Gox90T2FDnMWhoBQJzT3daqtgrfjA=;
 b=t0r0t2VJEueyp+muqiaMCMysA/mXaQxT84TsvIakshVla3dC7sBi6RnZxNs8OIGx1JTw
 4HClILdJ8NeE32qYvKG5t936wVdnqb2VcbZpvYUk7QRP9vXI1Ovdg3on7SbsfOdSqzr/
 FGueu6vZiZHGG4SglfvxCSk4khBWm1vuIvhf3rpQqSxtHih3W2FBIMDyXsTNBPEfmjzH
 cyVrGz5E2rfjkpj14wTu8jggTVFRUIPqGp+Us7+WcDUv9fySwMi7zkq5x1XmVvC7LUpZ
 qw+rd+729jC8g/MFMuj99cYaZ542xfkIdCXCQj9SYou9HpSn2dNSMKgTYCVjymNIvt0W jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1shbg6j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:58:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8QDNl029834;
        Wed, 11 Jan 2023 09:58:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k49g0vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkR33KheNnqYXtPwbku2zMo1FZ9DxkUjp7IAfqEVaQ57sm0w9FWvKYcd6dp5+Iisvfm19hTVdDUcla0Vl4Nzrff4ZeHBKyyAt8uXLTS6WXG16CURp6H4pu0DowfBMoY4GelmnaSnvp5oLzwEVU6tT83HpgVx5JC8ADw9JFFeCU9tqKgeqfpCpWWaSac6zSvD/PuqgVcJaZhxlXe9prLHsyLxp3iyYB612aW6zD7V/GLLSDY9cef/7sDfw/ptlD64TGbYyCtuF3jjqhiTUHAgyVrdKD0atOgqfC9RETB4E9yWP1IlJH7ELoxavsozvMumN2CWRhzGf5smk+GNHkUuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgj/rUOBcK+gP9Gox90T2FDnMWhoBQJzT3daqtgrfjA=;
 b=LRzHdmrKL2HiizV1kQ9D9PZV1bJpUbkk08LP1zTgYdgGgtF9eN40jp1zodcrhEff9F3TUFy6jNHG5o8xo0xNdKMM9o9EEEJ+sXmG/A+wwPllP8PeB1UT9xL4yI9aKPkjXiHbUWz43Gt1xxjviqRSCtNga2jPVdesc6Hax0x6hM/EJ9I0s6GK/zzeA9rKcI2+FIB4ONofIgg5B+ZG6jJjk6Iy9KaXoIVGRnqeUfV7HVQ6KQ2iqmEOwMA4tEPEohYq+iTOaCALlnV3NjtZDLMLrjlCmYRpDEJdeUvzDxhokVq6C41tMV5qMBYwX9njUdorR0VTsHeS30JD3T50VNtKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgj/rUOBcK+gP9Gox90T2FDnMWhoBQJzT3daqtgrfjA=;
 b=VXRB5FXAfFt8QSv0gYWqM9PzwOQiaRw1G7l5oUUcaJxODEEg+6WBBtmZM2HQbAW51JYtzmRqsEF6FYGuPu/okUhIYw1TEa8qiPk8mXGOku1YzhcnBQAlz0KnWb2qH6VI6tKhD9WbNHHDiMjkuaqtftQ7DampqAwRBnSojwNqkcs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 09:58:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%8]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 09:58:50 +0000
Message-ID: <e37b3007-a9eb-ff07-2efd-467a5eb8114c@oracle.com>
Date:   Wed, 11 Jan 2023 09:58:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 6/6] blk-mq: Build default queue map via
 group_cpus_evenly()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <20221227022905.352674-7-ming.lei@redhat.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221227022905.352674-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d3ece6-b4c0-4d6b-23b4-08daf3ba7076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIkgvehwkoNaXg4cQFh3XqO+mp2Uq9IkHGR4Su/MHE8k/YTVhtIv2iHilRs2E8i/cmLfakIJWKevBNrgL1t+ffpdBpDniXi/dr77Xm/DBjapr6fCgl0jIzVI/lcCMX3kznKXBoZY1E9830WE45V+0DJMZrrfyOtdNvO/5LYRXBKzwvseamvJco+us2HJx5oKxj8rhxHCZ4yZlaze7A4PRljSeQT1Gq0i+Qd8HkcoNurCFDVdAfIxrRoS32EA69ZlsurkE4wsPrzr/q3VwPYy6MhUuTlPw/kjUkp3tAwHP2OkmWuhqghANdWACRiNHuRQKoi6LkSIdgyMgf2IQeEIlz6TxKHkeEcGop6tdFelZolMgp4UmG9AdyIPnv68LtMkMIX5L4aoPq8G5L1+QLOqfQIc64kwr02zxX1X1Pld8FIBbgldxbabEP/NkqufTvxnnY/fp4kIlVV1Ling4nNBrV6sh+KBbqphSAvVN2OF0hqzRQZ0DriBpRojbrfEfyH0HJcoomrX8uDJgdg++ApQOrp0apqAzCtzieksu7gd1S2BEc6t4y4jjvE/h7G58YSWuT/VxX052BBJBuVXBiTzBYz/LQlPLEMljPI2gG7gGqApLqUNFWHZ3w99wF0VRvCVqeF83LRc6jO2JWmGLO8ZWiI3FrT1mDxT3qYnAeDoSSdLb+iOlEkhfCibO8UrKgDnIoYcagnoy6Pzp57cMfNUPkuan/cjnugishdpqVF35zE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(478600001)(6486002)(41300700001)(38100700002)(6512007)(86362001)(110136005)(316002)(31696002)(2616005)(186003)(26005)(36916002)(66556008)(66476007)(66946007)(8676002)(4326008)(36756003)(66899015)(5660300002)(53546011)(6666004)(6506007)(2906002)(31686004)(83380400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk55SG9vMTNKaWNPWFhWTzNScU4vNnVFQ2hNM3N2TFJvWXVINlQ1aDZEQUpG?=
 =?utf-8?B?b2pkMURqVFdNZUJudWlPVjRZQjN0Zy9oMHJkWStsUEZWaHJEMjlRYTRpU1VM?=
 =?utf-8?B?eFZaNzdmdzhCWGpyVlZpOG9naW1CV3VVMFZwYVBScU9FZHRXaXA0MFY4MjBP?=
 =?utf-8?B?ZXFIWVg4U1RjZnZheklFenZWanMvMHVpdmFVeFZhRjBSRGFUaElXd0pjcXQz?=
 =?utf-8?B?dElKcTZrNk1BYzhTS1IyMm5GTW5PMjFDL0VFZ3NQS3lXd0Z3UUxRV0MwWWF1?=
 =?utf-8?B?T1VuYUk2Yndvb2V0VkRTaFZ0K0RHUG5BVHUrbklzelpIQjdRNVh5OHhBaHhZ?=
 =?utf-8?B?MmVFQ01ORkk2L1RuR1d2QUJFMjl5U0R3RmR5cW5kNlg2anJDelNHRHM0Z2or?=
 =?utf-8?B?WENLcHpPVklMQWE5cjI0ejE3YWhPbnk0b09QNGUvYzM2MUxSUGZyL0M3aktK?=
 =?utf-8?B?VE9zeGdUY3d4UU5SR2lGS1FoM05vVU1DQSt5dzdYaUQyaXB4a0pqdlZ6Qm9R?=
 =?utf-8?B?bmlWM2dwQ2tJWkN1MXQrQm5aK05PVlBmN0NpSHA3ZlQ2eTRheTQvN1FyOEYy?=
 =?utf-8?B?OCtZeEhLTUF2T2NoNGlSV01OdTljaDNlQXVybGRBWktndFhHdDJleGFmQ2lS?=
 =?utf-8?B?ZG1ndUcwVWQvSEJCWVU0UlBvV0d1Zi9lYldOTG5jUkd2VFRXTXdabXMzSjNK?=
 =?utf-8?B?czcydGRmOTVFRzZDWThkYk5KcjVQWkFIKzBBSTdtVE5COUN4djFuVk5rZHZE?=
 =?utf-8?B?SWF4Z3B1dkFUa3k1Q29KL1BLQVh0WFpUcjNqdUJyNEpGTUwvMzZkSm9zSGhK?=
 =?utf-8?B?QXRBRG5oSUtiMDFYOGxKb29ueHROUTFpWFo3YnFRdmhIcWFVYWlsSmRBcHlr?=
 =?utf-8?B?K3h0d0hrUVZQRWRQSDlqWGhSbSs4U0FyT1BaRy9BeENiMjdDKzRTRnEwQ2Q3?=
 =?utf-8?B?dTA5aXpNQ1U5eHpPQXBiSTdQZ3puTkZsMnAzd0RVRGV2dXR6eFYyMFB4bmIx?=
 =?utf-8?B?RmJYcklUSjZBUnpETFMxYktJb2l6TzRsNTNySWdCZDljalJnUW8zeW9PUnk4?=
 =?utf-8?B?UU02MjNOeFZ5MTV3R2VhZ3doQWpFVldyMTVZREdXV2d5dXorVFFGSFZ0b3Jq?=
 =?utf-8?B?UGRtcjlvNnRSaVNLYnpXZkdWeGhPNDlQRG50Z3JmV1lhUy9INHJMNGNodzB1?=
 =?utf-8?B?OUdFdXUyRkpFbk1Ncm1QSTlUSGRYVGcwaXcxUjZjTW9qUHFYODZmLzdqaHE2?=
 =?utf-8?B?S1RLSVJpNjVaNVdrM0VUWVV0Yys2K2dEOGc3UDZsUzFzSXFBaWlIa0FPeHlQ?=
 =?utf-8?B?MmUrM2tJaGFpbzhhN2ZhNjRUSFdjdmh2bHpqZ1NMbTNBS1lVYjJXWFcxeXhF?=
 =?utf-8?B?MmU2d2N2NlljeXR4ZXNseWl1VitkLzh0eFd1eHRDU0ZmNlFDa01ySHFReXRX?=
 =?utf-8?B?bDhocFBiZTBLcmt1d2RjSmppSC9wYXU5TkZGanBWcC9pdm1jT1lDZ0R3ZmlQ?=
 =?utf-8?B?Mk5RTDZIcDhmRFRrM3pvQ1E2N2VFUURsYXlVSTJJVGUxK0dHZDZoQlBzSlND?=
 =?utf-8?B?YlYzYVVXbGR5SGkrRGxmcFVLOHVCZ3BJZU9zYXRvVFY0VE5NYWZ0RWFkZmFq?=
 =?utf-8?B?WVB4L0lOMzJIK0I0dW92WHhSdURvOEZyYWpFYktjZ1NGbE1TcjBENm1ObzNw?=
 =?utf-8?B?a1FMYW1kb2l4QmYyaktxaTl2Mmkwblk0OGwzb3JGSkUrUG9aRDlTL1djM1k0?=
 =?utf-8?B?WnpwSG9iVU1lMHB5THB1NTFkcXF4RDRBOHJvZW9ka25PMWN3VFpuVlFCMFdS?=
 =?utf-8?B?Vk15MnFHRHEzMlRKSDRXRXZWUldzK3l2clR2T0ZGczU5UW5ZL2lsSWFmclpo?=
 =?utf-8?B?cWpWc0VJdGgwc3doV1NINTFSOThTZ3lCU0xVMkt2Unk2MDZNQVdsVTZ1d2hR?=
 =?utf-8?B?L2FSaXhkWHNiZ2VjbkN0TmZ1MGY0OFI4QXF0QXF1ZXduTnR1MDFyTFZkOWlF?=
 =?utf-8?B?WlNmSVRBMDA0MG1ScGcwcUdVZmEvQzkwZldJNlNadi9DVExBOU9QMFFUcTl3?=
 =?utf-8?B?UlpzWTV3ZlNvTGZpSHBuWm5mR1NmNjdFRjNhYW1ESnhrOWU3N3VMTTg4ZXhK?=
 =?utf-8?B?VjdRT0FCbGxoZ0M1SEJWbDh1SUNUMW15V0J3RDc5S2oyd1EwTG0ydjRsVmlq?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dYgwlmDAg3bHYWCUWWvPG0zxQKX2Togb/i4dZdNmzJd8375Iwz+4dk3cfbOA2yFlOZcC3zTwCdXZzXLG99ASBbmOvXlMkWZ29ttGTzdUaygHVhlba9j1BtuqAQqZdu3tzttd1cF6PTVtLd84LrSGprBDcc0A47CfMQnHboJxKFZkp0n03XyR7kEKpqfCedfsiUuWcx5hKLTuFAjmAQisv0iEV68QV7mmN729juKGJ7+urgTd5a9O6oK7bdm71fphw+MGxAUvSXxGd7GM0S/KXEMb1dPUhcBO7kxIdOH2BM/6ao2p/lJbUUkqCY6C8xTa2n87oWWmHfAOZ8Jb/plPOplbN8O6eOYZ276dO3et4/K2xv9oo4lXhO/EWpgMwr1Re/13qhTkEzfeiBll1wcQrmNnr0CogsMo5fKu67+yJbhimbdu1MMJAxzs/RBwhYPb69wF41Eec66jebnRTDOSpYOOpiUUY6W9zCNcDs9iaZBglZdnREgZGSdg7+gbeStIKH9XVK+Rzvg+UI/59WYDM8A/KUptAekqSVI+nDw69nEda8J5qKgdzEayoUv/TWmBs+CAswbsOlFcv4J/OtmuWJXTecWqhr3Ydu5rvag1dwtKQ9dVjl/GMCl9SuhG9ewbY5jmAPSF9C5JkKDjla86nGb8pvfY/glkdlyZfEGPRLRwWMz/R0/U6gX71ELYVcL8HGi8scm0/otnEZrl6thEbwTP+ELgfIdKMqpNa6ImJ0MGBMF26oeYR3gM+EuZoW7+geAE1J7R4h2s6tRhwVRJP5GAWfalrzNJG+7ZZR5jTxtWAnBfUSHOzNhlmSD/VlUMm3Wi6Su0dUuJn6v7sbzDoK+vuThsYIsieuJv4ZaA3OSHeXEvcvzMH2iqMulbCaGA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d3ece6-b4c0-4d6b-23b4-08daf3ba7076
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:58:50.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zte6NA1CCZxKBPz83nQIgr0Eha687VqybSSlo/cNtgIDdNwMpY6zh0/oOz+Z6xakxr8v7rUU76Sifz9hJEuzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110076
X-Proofpoint-GUID: ejmeN_HCCsfot47Zkg-OzU4Er5-tcYCM
X-Proofpoint-ORIG-GUID: ejmeN_HCCsfot47Zkg-OzU4Er5-tcYCM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 02:29, Ming Lei wrote:
> The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
> topo into account, so the built mapping is pretty bad, since CPUs
> belonging to different NUMA node are assigned to same queue. It is
> observed that IOPS drops by ~30% when running two jobs on same hctx
> of null_blk from two CPUs belonging to two NUMA nodes compared with
> from same NUMA node.
> 
> Address the issue by reusing group_cpus_evenly() for building queue
> mapping since group_cpus_evenly() does group cpus according to CPU/NUMA
> locality.
> 
> Also performance data becomes more stable with this patchset given
> correct queue mapping is applied wrt. numa locality viewpoint, for
> example, on one two nodes arm64 machine with 160 cpus, node 0(cpu 0~79),
> node 1(cpu 80~159):
> 
> 1) modprobe null_blk nr_devices=1 submit_queues=2
> 
> 2) run 'fio(t/io_uring -p 0 -n 4 -r 20 /dev/nullb0)', and observe that
> IOPS becomes much stable on multiple tests:
> 
> - without patched: IOPS is 2.5M ~ 4.5M
> - patched: IOPS is 4.3 ~ 5M
> 
> Lots of drivers may benefit from the change, such as nvme pci poll,
> nvme tcp, ...
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

FWIW, but just a comment below:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/blk-mq-cpumap.c | 63 +++++++++----------------------------------
>   1 file changed, 13 insertions(+), 50 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9c2fce1a7b50..0c612c19feb8 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -10,66 +10,29 @@
>   #include <linux/mm.h>
>   #include <linux/smp.h>
>   #include <linux/cpu.h>
> +#include <linux/group_cpus.h>
>   
>   #include <linux/blk-mq.h>
>   #include "blk.h"
>   #include "blk-mq.h"
>   
> -static int queue_index(struct blk_mq_queue_map *qmap,
> -		       unsigned int nr_queues, const int q)
> -{
> -	return qmap->queue_offset + (q % nr_queues);
> -}
> -
> -static int get_first_sibling(unsigned int cpu)
> -{
> -	unsigned int ret;
> -
> -	ret = cpumask_first(topology_sibling_cpumask(cpu));
> -	if (ret < nr_cpu_ids)
> -		return ret;
> -
> -	return cpu;
> -}
> -
>   void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>   {
> -	unsigned int *map = qmap->mq_map;
> -	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling, q = 0;
> -
> -	for_each_possible_cpu(cpu)
> -		map[cpu] = -1;
> -
> -	/*
> -	 * Spread queues among present CPUs first for minimizing
> -	 * count of dead queues which are mapped by all un-present CPUs
> -	 */
> -	for_each_present_cpu(cpu) {
> -		if (q >= nr_queues)
> -			break;
> -		map[cpu] = queue_index(qmap, nr_queues, q++);
> +	const struct cpumask *masks;
> +	unsigned int queue, cpu;
> +
> +	masks = group_cpus_evenly(qmap->nr_queues);
> +	if (!masks) {
> +		for_each_possible_cpu(cpu)
> +			qmap->mq_map[cpu] = qmap->queue_offset;

I'm not sure if we should try something better than just assigning all 
CPUs to a single queue (which we seem to be doing), but I suppose we 
don't expect masks alloc to fail and there are bigger issues to deal 
with if it does ....

> +		return;
>   	}
>   
> -	for_each_possible_cpu(cpu) {
> -		if (map[cpu] != -1)
> -			continue;
> -		/*
> -		 * First do sequential mapping between CPUs and queues.
> -		 * In case we still have CPUs to map, and we have some number of
> -		 * threads per cores then map sibling threads to the same queue
> -		 * for performance optimizations.
> -		 */
> -		if (q < nr_queues) {
> -			map[cpu] = queue_index(qmap, nr_queues, q++);
> -		} else {
> -			first_sibling = get_first_sibling(cpu);
> -			if (first_sibling == cpu)
> -				map[cpu] = queue_index(qmap, nr_queues, q++);
> -			else
> -				map[cpu] = map[first_sibling];
> -		}
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		for_each_cpu(cpu, &masks[queue])
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
>   	}
> +	kfree(masks);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_map_queues);
>   

