Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D256389DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKYMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:34:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEAC2A268;
        Fri, 25 Nov 2022 04:34:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APBsAx3003810;
        Fri, 25 Nov 2022 12:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qj6q9TmonqasG6ob/ZRWb4NtPkWP7fZjZXcpAMtZqz8=;
 b=RTpEL9DcDB1e/eFxB5+8a/ICb8JVJP4S0OByDMtUitN9Co4aCpOqVbpmd6QyFZDNR6NZ
 TheJDuwIAh5klYNYtKEKqws8BYx/feE8Dv92OO86SVXMrLpFYyUipVEc1oFTseMkiv+x
 mrTvokdHUO2gKQ/KPTbpZCdUJshRo928mpRQPfQL5x+3YHBTQR1UHXpDrDOO45QKuwrl
 6kc9DkhHhk1/syxMhaflTv0fC1yO2u8ZwsiBjdchaGDTjtsHbiNybrb9LC4amozggQCu
 B3EayqP5UBAfu3Pt03PvtKybDTGJ7HZIQicEEQuVJkYeiJiCHa+mY5uLA3yD6b2E3ojv CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fmkkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 12:34:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APAlLgb001614;
        Fri, 25 Nov 2022 12:34:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk8u6st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 12:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWWwmJiAhEJc4n1gquVIJ0ggpG/pv2wUsEVp+d6ZuBZ6xjTZiPAgateQsZ9HgGJi/vCE2/4575YhWHbhzcxbXQ+K1QqZhuo+V+GC+dqB7O2hi8HpE4pPN6lT+yqxBNVTk+iTe4P2ZPeIRf4RmTUzse6dZo0v6l/JpPXDryuFqbji2wFufYy9tWlhfwjcmK52iFcgmYUD0HVKDH03il7Dpt+0P+vKymDaMc4h0tvA7R2t45ebJJ9iTwTrYOPoHisAYwXWbO0qziKyyzCFt3fFXV1t8rYBA7hNT4FNPT03K/Y7j3CWaFRLcYIjTXry6nRgDpnBYi94QjtxuhOC66YeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj6q9TmonqasG6ob/ZRWb4NtPkWP7fZjZXcpAMtZqz8=;
 b=MX0kH7u0jddvrbwfH1etgCdZ31iId3qpvHHVTEH2HKu/hOf0/b7O6gMKfOZxiJqizEQMBTyuuVO4NrybiSTZtJhH2sXN89EOngTn3eIIIccrn68UkK56FPMA0cU3RHGV5qR6cJJ9OK9q4Qx6spGTQrNGXiz5MwmMisuWt/Ibai/c+rJFd0KUmA33tDLaK9gTQhJr16i7M4ahZXuxKUZcUSDTf6clljCOEdTkjFlw1o5dqeH/mC6tdID2OCko2k8fJE690emCUA8ESmaeQR29bWDDtPFaTO/Bw/nJFWq/X3kjV9YBF0T2Q9vmqO8LqvsEPA5dyECf0iHlEvQ9u7crcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj6q9TmonqasG6ob/ZRWb4NtPkWP7fZjZXcpAMtZqz8=;
 b=HbDggDVEce5MKh2D+b4YSY+f/ut+8QqO3bCcsnFiSU1iFIKFLc98qICtqSIy1f61O9QCcqybuZuHCDeNaSHzHSPDjbg0ALUPobyAcV2nbWG1siNrCatTV6iojkvjy8h5+YothLJ2o+ryhum4T/+iy1aE7i5dSQMLDIjWjhq2P4o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6673.namprd10.prod.outlook.com (2603:10b6:510:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 12:33:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%8]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 12:33:58 +0000
Message-ID: <e11cdb17-053c-390c-9c48-36790eb70cc5@oracle.com>
Date:   Fri, 25 Nov 2022 12:33:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Why is MEGASAS_SAS_QD set to 256?
To:     Yu Kuai <yukuai1@huaweicloud.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <1c4d66ca-fe1a-3d1a-d7f9-4981d2fc9eb1@huaweicloud.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1c4d66ca-fe1a-3d1a-d7f9-4981d2fc9eb1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: d7df8916-e2b2-4ba7-ca55-08dacee152da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fRsLyqEi56h5tADhHIikdTPfCM597NJ+AvZSe7dtX4V/irE+Mb6soOhsbtMs031rQLphqKtBrj35ETG1iXWEhlHNYJEoTfVuDReoCUc3H0ueBbHah8E1I+9+crMamomTrZA5Td2+3kgu9Dp9fuBa/CCIF/A+Zd21sqMcym7UxA4vzlklGui/BPyrdk3lSH+ZrPsBxzlWY9qQLCxUOvo9NQSigdYEb4Sz6N+A4SQp7JzZSM2i4nCly8r+AAFldSl3FUtBbgYzmtF2+1oNszFSa++z/N1J5X7pWf1M9nqY+oC8tmejEDIjn3MTCgUtOe33i6Y1J4m8kW/Qa3+b4p8gz8HkaBYINHXYnSaBfY3UJi/5eUcdy8z8Vv0Uw1xTuqdUD4noU8HtPiHaB6vu0u606hYGuCAwccbZuI/dHphOLjbeZpdY7wckp9FKeScWZCWkdhGdod1myd1Tt/4jTsjiFYivsULpnu15AkjRFhQ/EUc/HBkjc6yGDmR66T4EBZZYeF1r0YRW252OQLaM/6oCjYvQZSuJt2Un7HcMTFCOVxQC6/gyIMJPlg5+q/nWmIqC8f4YD6gg7y6PMdpNlqlvrMO+yRk2s3C+yGERGB+yKla9uODF7a7JBjk3ca2nt0Tk7TbCjj5hk5HsuLm4rs96s/R1K7llU7ZDHbGWZp1Xv52kj8kwlhVsPdkGcYQPwePRd1YoIfcGBH3pLWQBZzNEgaKQnVX/m9OGfZkKqtT257Quczg7+WwBL1UW4cHFafvmAYsCLHN2f7ZTi7PmGJsug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(2616005)(41300700001)(186003)(31696002)(86362001)(8936002)(7416002)(36756003)(83380400001)(5660300002)(110136005)(36916002)(6486002)(966005)(316002)(38100700002)(6512007)(921005)(8676002)(66556008)(66946007)(478600001)(53546011)(6666004)(6506007)(66476007)(26005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZ3R2kxazJma1M1UDhnNVpLMW83N01WN0UwK0FYOVdkRjk5dld0WDNNb3FC?=
 =?utf-8?B?THd2OExxZ0IxY3lQQkRhRXJuZHVBRjU4YVY2N0VmWWVpYkJwQ2tCWFR6RmZ5?=
 =?utf-8?B?QzZONW9WOGdrTTAzcEVTQlZqUlFvMWduTWdUQ2R1YTBvNFlZcVZFZWlON3Rt?=
 =?utf-8?B?TUo2VGRuZWVPc3loaVRDNy8wMVcvaXNPVnFBUVVvYkVvWHZyUFZ1K3lRWGxM?=
 =?utf-8?B?UFZiWEl5VXJHQzU0a2p4RnQ5K2FhQlJmMEI1M0RMWjFDTFFCOUtEOVRLZWly?=
 =?utf-8?B?OUJvakE5RkRuODRTV0FaSFBZSzczbDB3NFZSVEUxanBJcXJ4aGRRekt3eUpH?=
 =?utf-8?B?SDdTL2Rwb1ZZUGQ2U1dPWS80bzVOSWd6R09kQkRJV2pkRTNxZ0Z0aFJDMlRy?=
 =?utf-8?B?WkJJY0d2VnQvVW5wN3ZRME9nTW5OL283b0N3VTAySGtGdXhSWDA3c2JRVHhz?=
 =?utf-8?B?RzhMT2hwYXkvZEpLeXEvYmNuRm10WVZUL1BibXQ2Nlc5ZTJkSlVIUUNCYVRq?=
 =?utf-8?B?Q3hJRWNaOStqa3FndlJoVWVyYStSMk5zdzFNTzNDOUx0L2FxODBOd0xZZnQy?=
 =?utf-8?B?SEg5YkplNzR1SklsSXo1MEFhYVY5VWtrTW9EZmdwcEQvdmRSWFlWUXBrSDlI?=
 =?utf-8?B?V0cxZW8wU2d4U2hqZjV6dmlCMnpNMGZ5UVVvTzZpWSs3c0FCOCtIc0pDempi?=
 =?utf-8?B?MTBPSldNMGhMOHRQSkUrOXFud2MwRllpaHZ3VTlNc3Y4a3FBeE1hdnFIVUFW?=
 =?utf-8?B?c3dkWGYwRk5UZ1hGS01BRFpiL2haa05LZUtuUzM0elBFeG5Na2N3NFA2eUdo?=
 =?utf-8?B?dmJYTXl5TlR1bmhPM3M2dDQ4SkxoQjdOaEkrZGYzSlNYRFB2bVRlTVdxYVNy?=
 =?utf-8?B?OGxycXp4VEh0ZVcwYVJXWjBpQ0s1di9uVVJpS3M4eDlXOFRYWTNrcGZjd2FZ?=
 =?utf-8?B?ZVh5SEd1QlNlS3ZpZGRZdVpXVmxUM0t4S3JZN3g1WUZSbStZSE9MWlFxam5h?=
 =?utf-8?B?UWhBeVl0bVFwZXU1OW0vTHJZVVY5ckhwOXBuSEVvSHRXZVZidXptM0JtZjNZ?=
 =?utf-8?B?TWNJNnpkV2s0QjAyS3RIeVVSNWNpSTNVWndGUW5ZQVBEcUViRURmU3phZjJt?=
 =?utf-8?B?RXpBSHN2a1JJMDRoQVdOOGxJRm0xMjVOTlI0NUxoYmVkRW1Ea2F5dmRVQjhk?=
 =?utf-8?B?MUYrZUJhTHZnVkJyTnFQNkpTMzV0TmpBTCtVRDJOdE53YWh4MUxEcjA3QXJR?=
 =?utf-8?B?S3c4dVd1NEhINTRYa2hjU090Qkg5aE9UeW9QNUFZMWxBaWZTeVhIazVwQU5G?=
 =?utf-8?B?RXJVUm5OK3E2a1dxcmJmeE82UVVmUnQzREtveG8zb2xxc2JsRkZVU3NSS2tL?=
 =?utf-8?B?TkVvUG81RHJmcW56WTVya1piOXRsZ2xXR1dleEsxWHZDclRaWHFyblJLVTYw?=
 =?utf-8?B?MGJReGFjYlFINm9IOW1GVFNMUDkrQlVpeFRZN2VTeVVFbStTTm5aYUlwQ0sy?=
 =?utf-8?B?azZLUmZEWnI1SjBnbjIzbGlmbythQTdhbjdQM3QzUWtSbzZLZXUzSU1zZFJv?=
 =?utf-8?B?TGpLU1MwakFUQTMzcVNPOXpwVDhLeFQzRlM2SStOeGdlNEkyY2JpbmlGMURH?=
 =?utf-8?B?Sndwc2Fzc0xySUx2RWZya0RxN0tEM0paZXIrMjdtZmcxZUFsQWk4WDdHVDI4?=
 =?utf-8?B?Q0xaQllXTXBqa0hyRytrQTFtYitlSklaMnBnUys2dVhsZDJaVFVEUHU2NU9n?=
 =?utf-8?B?dUw1RW5JRTBxa2RTK0pXcUZ5Z3ZsWFZWeDdOZHd3d3dieWJzZmwxK0V5ZVI1?=
 =?utf-8?B?MkNjeXNSZFpNNHVXZjMyUnl6WU4xeUJiN2pFdzFkV05GeW9pSTlOZ0JYcnVL?=
 =?utf-8?B?T1NiUjR4b1g1QW1rMkxNUHBoSnRUU1phQTBuK3MxaGdpNUZVbXZhN3hjZDha?=
 =?utf-8?B?L3FiN1NGNmNBWkF2L01iZEZUai9MRmhFTW91UVlpaHNxTFVCSDBTSU1KMkZo?=
 =?utf-8?B?NDRFbTJJQk44NDhndDdKbFYzdnA2MHpUcURTTGRWb1dJNmxFT2prVUs3RGlM?=
 =?utf-8?B?akZlQThvMkhGbDQ3MEtFYy9WYnVrWWlXNWJvWlI0bXJDR0RzaWdlVVg4RWl5?=
 =?utf-8?Q?yLrEJuDPmH+Qr3o0qhZjEnyK9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eWVkdTlsTXNnTGFvalZwbzdRdGpISHFuNnRxbWRNc244Q05oMEdYd05Yb2Vw?=
 =?utf-8?B?ZXFoT3hjby9uYlY2bHczazJuTFpnVGhQeGtHV3Z4MzlwNHptWVhKdVJiMWNM?=
 =?utf-8?B?WU9RTm1GeUF3WkVPSHJ2ZkFzOGxsZ3ZLejJkQU80cnFtV0t2ZWJKWGdZRGlJ?=
 =?utf-8?B?a29Yb1pSYkpsVzJOU3AvbzdvRWlBeWRJQngwU0lHbFk1QmtQTStxUnNrSldK?=
 =?utf-8?B?WFlBS21TVysrZ2FrWVhLMjR0UzNrT3o4a1BRT2phVWQ3Wm0vQVlkWjFROHh5?=
 =?utf-8?B?OXZWM3FUakhlOFYvL0MyT3ZDaHFLU2dnY2lPUUVBWjNETzJvK3FGOHorZjQ1?=
 =?utf-8?B?c3hnNUd0Y3Y0NkZTYlkyRk51SVBWWERFRGlRWHAzTTkwejZkclp2NjNuaUJK?=
 =?utf-8?B?UWhNblFwdUMxZitJUCtpUUR5cjNVNEZBTTcwWGRzWWtTaUpINVpaREVvVGV5?=
 =?utf-8?B?NVN1K09NRVZOQ1JBZmRjbjlPcXlNRkgyWk1QeTM3eFFYTDRSK3c5RDRYdU9o?=
 =?utf-8?B?WnJ3S2FKd1hrcTI1UW82QUphczBKZ3lTK0xyZWJGTTFlNDlwVXhJcElqaEt2?=
 =?utf-8?B?UUpMSHpFaWNLaUFNWndSMEJ4OGZvS0hlQUtvSEJ1WFR4OGJVenFMUS90VUZG?=
 =?utf-8?B?RE0wZGppT0hnaUdXcXNjSEJIVyt3OGFScUhIT3ZxYkZoeG5uZFVZczJ2eHJh?=
 =?utf-8?B?WUpjOHRWRDNDZ0JpcmdJVGVuckswNFhOYVM3N0ZRd0NMWkljZWVWV3J2RHFY?=
 =?utf-8?B?Z0RDMVZ6Ui95NXpzN1JMSEFSWDB6c3IvdmNlc2d2clZXR2NIdjRGelA4VG5M?=
 =?utf-8?B?MUdwUkcvU1ZwOGJZcE5hRlRuNDJNVzF6anJRdXR1K3BEVW1hUi82eDhpTGxq?=
 =?utf-8?B?NzZmelNxekR0ZGhqajN2K3ZHdi91ZnRTbHd6YVc5ZDlEVWt3eUVjNlA1aWZ2?=
 =?utf-8?B?MjhrUk15bWhkTVdISmU4UkZKUWREdnZCK0MrdG1xenV3QTAxNTg2OUFxUXdW?=
 =?utf-8?B?SXltWWQwZk9nMUpmVklqTHJqSWU1OVZXMjNkQkxRY2p2ZEZWNFFiN2xOa24w?=
 =?utf-8?B?NHBMTGMwWndkVUtTOVhnaG51eElwTElVcys4MzZOM2ZGbXlFNFZLSStyKzFr?=
 =?utf-8?B?a3kzQnM3WFcwMWpYWG9ZUW1MbWlZK2FubWlNMzgrUU5YSzZSbW1ncUF2VHBL?=
 =?utf-8?B?MXRGQTZaK3c3bmRvMmd2SWlUTHViQll4aXQxYTdxMXRralpsbnVmenltVk04?=
 =?utf-8?B?TmcrZ3Ria0NGWGFMUG5nN3B5V2NsbHNIdkNWeW9aZGxtWEdRNGN1d3BYeW0y?=
 =?utf-8?B?L2ZRQVZ0aVptOEY1dktWdzl6dGVQaUowK1hwK1JWMEdqQzYwVm9MU2RZV084?=
 =?utf-8?B?WHJyTWNXQVZCZE9oVFRnVnc1OXIzdURoS0tzZVRYMUNYM3dpM1lDZVFnY0Vt?=
 =?utf-8?B?TGtoRTQ2M0c4YXFlVWZGUCtKOStsZ09GclN6c3pwcXZLOWtZczNpb1ZhYlFE?=
 =?utf-8?Q?BDJl2rh36mNvDd1EZWqTxC5jZ58?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7df8916-e2b2-4ba7-ca55-08dacee152da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 12:33:58.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SVU/JweD1uzcINl8y5hZjGyYbh5xejNKf9a9IrqWCe26MH949d1cRDfDmi6baTfK4ZS//ftJnx3FoOXyHr5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_04,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250098
X-Proofpoint-ORIG-GUID: _aY8PmhiNV1bfdMhVLsPxnhwgPJti1pz
X-Proofpoint-GUID: _aY8PmhiNV1bfdMhVLsPxnhwgPJti1pz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 03:45, Yu Kuai wrote:
> Hi,
> 
> While upgrading kernel from 4.19 to 5.10, I found that fio 1 thread 4k
> sequential io performance is dropped(160Mib -> 100 Mib), root cause is
> that queue_depth is changed from 64 to 256.
> 
> commit 6e73550670ed1c07779706bb6cf61b99c871fc42
> scsi: megaraid_sas: Update optimal queue depth for SAS and NVMe devices
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas.h 
> b/drivers/scsi/megaraid/megaraid_sas.h
> index bd8184072bed..ddfbe6f6667a 100644
> --- a/drivers/scsi/megaraid/megaraid_sas.h
> +++ b/drivers/scsi/megaraid/megaraid_sas.h
> @@ -2233,9 +2233,9 @@ enum MR_PD_TYPE {
> 
>   /* JBOD Queue depth definitions */
>   #define MEGASAS_SATA_QD        32
> -#define MEGASAS_SAS_QD 64
> +#define MEGASAS_SAS_QD 256
>   #define MEGASAS_DEFAULT_PD_QD  64
> -#define MEGASAS_NVME_QD                32
> +#define MEGASAS_NVME_QD        64
> 
> 
> And with the default nr_requests 256, 256 queue_depth will make the
> elevator has no effect, specifically io can't be merged in this test
> case. Hence it doesn't make sense to me to set default queue_depth to
> 256.
> 
> Is there any reason why MEGASAS_SAS_QD is changed to 64?
> 
> Thanks,
> Kuai
> 

Which type of drive do you use?

JFYI, in case missed, there was this discussion on SCSI queue depth a 
while ago:
https://lore.kernel.org/linux-scsi/4b50f067-a368-2197-c331-a8c981f5cd02@huawei.com/

Thanks,
John

