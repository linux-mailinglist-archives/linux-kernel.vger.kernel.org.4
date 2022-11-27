Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3F639934
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 03:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiK0Cqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 21:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0Cqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 21:46:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BD1572B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 18:46:50 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AR2eRJC017081;
        Sun, 27 Nov 2022 02:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R+ycThoef1rzeJF3jL9ytFNaSmzX6HSh5TmUbvJmrrI=;
 b=2U1i5izB7zkXq5EjjtaKKzxlsuvRqWVxPDsdhoP8Zc+7Zv1OxYy+QOfqPfGpGfTOJLeG
 OX5S/Y7KWZHH0BCm6MhEf2nus6Zq94NdxW9++jOIE/ZEgbyrjJUM3Ny/jEF7jyCCg+EY
 Dpcs0g0WwrJioAuc0USPw+C2G9NuP0EY8e4mfr3atsBONSukKnI6B1zZsAQIqlS82tYN
 qEEkIqTEwWnHaP24mF8KpKWrjHBe9YmgkdfwnS2d36VhJ6hEkOqjG1lurEXTIfqsho+h
 EAOrkTlmt2hi9CT6ZCIdgguFet0XGYR/5JYPE6C8new1d1aqb5GFsy0hh4ZvfkRebkWK Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3y3w809b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Nov 2022 02:46:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQM6cYN007581;
        Sun, 27 Nov 2022 02:46:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3989fyjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Nov 2022 02:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Epi7vM7+ZfFrqDsX2eBYRs0qU4jCcp0t/5gBAX5eu74uhK/u3kqjm1WomXtfR2IX3qCIsuHmRd0RnMneansaAapBDHkIPXuH1nrdp9eV+Y/WS31xU0B7P7B7b3KyKBDBEStw4aD2fuJUr7nOmqw2yNjtHSH8Wi5mU6ax0a/hEHMYBFJ3tyI1vtuFwIfyLiE1ADDv9uMUfgNBNYZgCYSuTbrMh2E5mGNydxg9qxa9cReh649eDL8h2iZDosmtlXepzpiILOdCNZ7BVBZsmLCrEWQlpau6ea/+lYHvBMKnDHym6RlVQ8hTsRDoIceEAaqwPxFZs/z08UGJuGnas08FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+ycThoef1rzeJF3jL9ytFNaSmzX6HSh5TmUbvJmrrI=;
 b=Lru+joPxMFxlZiqXfGTa1JD3UFE/D/pKQEJrxCqtCDXBETWLcFjM7uDDr4SPFAYi7gFbvos6sGq6qBr3SAnpodp+AlTGW/xhcNI7pnfJFYp/tjCiHvCV91/NlT7UVASBHVHjrlIxCsFD29O5Pr8br6936DhiUp0KKtiL8sPoKDhTACjEQ1sy5K84oz5/Wrwkg8CSHOhroWreq0sjrI0jVsyoEi0T+msMPknE/Efsa/v2zVeNU/ye1CbguM32bLINl1JexHkh0r/G61axSP/4SUcwQ4gbgSYIXY60ngBk818085KTYo7EvIYpnivRWxtUByqZkUKbXBVweAtNzm+XiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+ycThoef1rzeJF3jL9ytFNaSmzX6HSh5TmUbvJmrrI=;
 b=OSg2jauaFfDyZLYtEKSSH9EwiXZ9WA0P0YH8Ec1LKauu+c0bEnaH30lR4U3FoAu14Tm8soSqKzOjHD4s+HASP+xi/vIOOjj7Nkp2Zqk/OigOBsOMpeucMPrmqjSUzzz9wCg6xLbWFkaZMn1ms+pV1eFFutvy6kKYzRyIGzAs2LU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 02:46:35 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab%9]) with mapi id 15.20.5857.021; Sun, 27 Nov 2022
 02:46:35 +0000
Message-ID: <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
Date:   Sun, 27 Nov 2022 08:16:24 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Guanjun <guanjun@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20221126181822-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::30) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 792283de-44a3-47ee-6ee1-08dad021996c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+Jh+bEk4bVMjDywIrBvnCqOfmk3WQ1+5MSD5w2Pv+Dc1vw6JKAR82FPzZ1rIzbz7Rt1xkEUasFLJA4FS3LHHi7w1p1OESKv77JojT1lQjSdEoI/FsTSHx2yttrsYiQqjOmkP4p0L2idppxQxfmlBuavKDJGSvz9zIUCUQ1tV/oBh7wO5qYlD/O+OCSqTIZT6AB8kL6/YOQscCJ66u57Vcxxpuzw6BTKpojuNPihTMYVQ3iapUIwkDBcirUcVWbWHAFG1whrSBHM8t51XDZ2K1nU+gArDKI3jjrDddhKLci8R4zGJYZKsrT1Y+QyBAFusG6NSrmQAg42/arOnnxtv6XS3GgoJvEQDVyHhiP0CEPvZRNvYs6aOBzToaREYF60LC3Jf7IQxDmPu7+jdRyeJSP8wWl3JUczcDG7XLMIyO8y5yxsqYzTXzgIxx5QYRrdX+b7uAg0LnK/WwvHS6WsRnK7Dy7PVL0atvyeXllJYpssztQXlLLqs1H2+i66j/b8jSXtzP2VcbUFq7vtyHOejj9HKYv9gFuF3AEnKeG4dVOieFr7/3PqX4gSBcCnd1+5NFkWtRkVBb8XFwr1EAwd/6rDUT+mxaoWPf7kKB0D9GAVDljuakP1gBDAEouLFzCaDlCahRkaMfusRwVKQFrb6HLy5YoIhd69UmjgkI+SUA/YdMSqH5v/GouZEKC5NvSRZhrUxLkj6dJ+vZeZRO8dS2oHp9PErbn1BF98lQYjH2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(41300700001)(31696002)(8936002)(5660300002)(7416002)(36756003)(86362001)(8676002)(4326008)(66556008)(66476007)(66946007)(83380400001)(6512007)(6666004)(6506007)(26005)(53546011)(107886003)(186003)(2616005)(54906003)(316002)(6916009)(6486002)(478600001)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dCNnh5b2ZCSFJVeU1ZR3loMm9SN0tYZ2hQRGtpbERKL0h2eUZqV1U2WGs3?=
 =?utf-8?B?cW40S2hOSXFPZzRHcUN0dkRnRnkxbWxROW9UejgxcW4vWEpsSG1qWmUvQ3hh?=
 =?utf-8?B?N3NucElmSjJkcVZSVXIvaWJDOERGTDBYYjRHdG1SUHQzVzczTzhnRXFva2Y1?=
 =?utf-8?B?bEQ1WkVzaTRVdTIwb3pvdXN6cCtYVzNDMjBPTSsyVWtYbjZtNk4waFZ6WlI0?=
 =?utf-8?B?c1NQb3MxMU00eGVXc0xMTWk4SUliYzlJN1ZoMWxXMmNXTVpHUVdnN2JPTmdU?=
 =?utf-8?B?eWJuY2Nla0VyMXpUWW5Xdy9LaStTdXNqSlJEQW1pdklZdS81Qk1kcmcrQkpx?=
 =?utf-8?B?TGlaVFQzaTAzb1FIM1dSUjBaS2d0bVlWai9ud0NMSTdMdlJQUkhaTjhTZ2tM?=
 =?utf-8?B?K2F0SkhzSHEvRHBkbTd1M05kQmtIOHVRSzRNNlg1S28rSUJaVFBRWUlNT3U3?=
 =?utf-8?B?UTFLVDdGa1FKdXNxdHl3TGtLSDdOVnJjREdENWpGN3Yxa1pLb3ErK2pGb2lW?=
 =?utf-8?B?WVdKVmxGd0E1bnBMN2ZJbEE4b3F0SnR1R3dVd2JlUXcyenl3b0FjaUs1NFh0?=
 =?utf-8?B?N3d4aGY3L0x2aVVWclBVcnFvVXlyOGVOcWRGSEZOYWtaNVA2amhVbERoZ0tI?=
 =?utf-8?B?b3htVjk3V29hcXVzRHpjVWQzVzdMQjhlUkkzUEtBci9CeWpsVS9RUldDVlEx?=
 =?utf-8?B?eXI5YkE0TGIwVkUvUmFYKzg2ajRyKzQ1V3NWSTU4c1U3eGZmME1JalhhRnRT?=
 =?utf-8?B?QTBpb1RobVJ3VS9Bd0EvK3EzNVhtQm9tNmN2Y2NHSzlWdUk2V3ZaUXc2cmVB?=
 =?utf-8?B?eHFieTArRW5BK3ZFQUNMT2RiS0NyakpRTlo4V2lHYnNRMk40OFJtYko5ZTNh?=
 =?utf-8?B?QTlLSXNIdmxUc1RpQVRBTlAvVHhES3hXRTN0aUZjVnhpZk0xRmNyRzRDU3NS?=
 =?utf-8?B?OXZjL3YySVRnZHlLQVZPdy9mcmR4YXowQmNvcSs3dEF4M2JYcjgwSjRmMmEy?=
 =?utf-8?B?c1dEQi8vTXQ4ajlrU2hGZEpJemx2VVlPMHBNRys2cDFNYlJkODZNdFh0WUlz?=
 =?utf-8?B?MUdMSGF1MXJwWXUyRHNoOHYwRll3SkpNK1l2WkNjanhwZnNUK1pDbmExYUhi?=
 =?utf-8?B?UTlIRFBDdkdRdy8zajBmdWJDTWVpMFFGMnFLeEx0Q2ZMYjdVbjhKT2tJclVj?=
 =?utf-8?B?WFZpWWF4K0FZejI3anR4eTVrOElQQ3BGR1kxL1ZRbnRlOUVYd285ckYyQ0Np?=
 =?utf-8?B?aVRSMFgwWVNLUktXeWE2cGxtMXJ2MFNJcHJHSWcyeWhuRGZNNjNpN0tvRldm?=
 =?utf-8?B?NUZyKzN4ZmdRakhwZmgvaTl2a1VUY0VSeW9ZbjA5UzNiVlN2bTd5QWVYbWxq?=
 =?utf-8?B?MFNuaHhZLzVFMTgrNmEyR2YxdGJ4UHU2QXhZRW9JWm51ZUF4MndPRFN3SnRS?=
 =?utf-8?B?WTNtcGpvMHoyZnAvRDNiWUpLdVFlaWlkTk9nR0hMQ2dWeG9TbVdWa21RdENU?=
 =?utf-8?B?VXhmT0tiaXJJTmpvNW1vMWE0eHJZYnQ4TTB1ZXZqK2pXdS9BWWZFcGg3MzZ5?=
 =?utf-8?B?d20xdE1KUitwZG55cGtLRlRDNE5KU0QvY2xoZ0FJbjRjMHJzYXc1K0pxOEVE?=
 =?utf-8?B?WDE4RzVkKysxOHpzOHVWdkozOTBUNmkrYURZYzEvSDlnYUJ4WkxVOFRrTitJ?=
 =?utf-8?B?YzFhN2tiM0VQSktwSTBZbG00S0pReDdiNjdJQU1QVDhDQWRWWjdnanVNaVJO?=
 =?utf-8?B?OUZDZWdNUXI5bEwzanVqRldZWWJLMCtaYTFjR0o4V1dHTDY5L2swZUlQZU9W?=
 =?utf-8?B?anMwZUo3T3lSV29qRklXS0RUT2ZBK2VKUEZqMTBjWHh4YWYvTEhYY2tNMUVX?=
 =?utf-8?B?Y2ZCM2U3ZG8wNENaWDdqZlIwdWZOYk01amRyM0Q2b2R0Y2tJZnRlbUthczVN?=
 =?utf-8?B?NTdkV2pOK3ZKS2lGdCtxZXlFeGxFek4vUzhCODZtUjVZNnJGTy9NamxJMFJt?=
 =?utf-8?B?YjBENzlYQXRZWVBqLy9oUUM2NWRkcUxkVk9XdHdHQlVzaUFYVjRVRHQvT1Vx?=
 =?utf-8?B?dkI1aXQ4SUVlVVR3QTlvWngvQnQzQTAvUk52OHdYcmRucEhuNER3MmZUQnNS?=
 =?utf-8?B?aDhOS0JGUmRPM05kRVMrcFVzc2FqTFJ4SWdDcWFvMzZtazloTDdHS1hTckJ4?=
 =?utf-8?Q?zYzuS3JzOurWv5dfkcUyWWw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RGhKMnRScmV3Q3hPMXUrSWlCT01yQi9GOTdXNFE3VFZSUFQwc3hsNUJiSVRT?=
 =?utf-8?B?OTFhNFB1OGpzd0M0S3ovd1FiRWxFWTlyYzk4OTZMbzkvSnNnZmU3SHZBN256?=
 =?utf-8?B?cHVRanY2Umd5TFNwRHhNOHFkQ2UrV1YzYzBHQThxRTQvS0t3TzA5VnFXYzdp?=
 =?utf-8?B?ZFgrY0VFWk84OHNxbkxwdVBqMWhTNUNyWDArV3h0M200UkMxVjFMSVhldFVE?=
 =?utf-8?B?emJaM1BRWFF3c2YxZ1M3OWJTdHg3RFY1V3lTL2dVUW1KcmNZam1KWHVWdVI0?=
 =?utf-8?B?cVlzcGt4N3hhdXFOWHNRaXpSejZLQWR1WGdLU0lzc0FOWEN5d2cyN3pCSnh3?=
 =?utf-8?B?Z0tRMmFKaDduOXpFa2VsSU1oZHAvTm8rYThyTGZsd0g0dElaWnRJUjlIRmxH?=
 =?utf-8?B?ZC9VVk9uWXVFTU9MNjlNWUFNcHhjTEJEMTVERnlhUlJ0N0lvODVJbThISjhm?=
 =?utf-8?B?aEVQWXRXL3FpN2Yyc3RBOEJTdnMydkhsMDlad3NVVjh4L0ZkVHJndkh5NTJW?=
 =?utf-8?B?cVpsdnNWc2dHQkZyZEpwVm9RZlBNeFdnQWZzVk5hTXhtTS9MQjlobHovcVVD?=
 =?utf-8?B?THNYVHN0UGhuTEFaalZFUTg1WXBweFUrL240OWNIenEvSmxQeFIwcGViSVhF?=
 =?utf-8?B?OG9kTWthQ25vOHltMkZIa3hGSWZBUmJ1dTRuSGhxdzZWSG1aTFFLLzJDZW1B?=
 =?utf-8?B?dXh0N25jZjNwZFBiVzBLN3d3ZU53NTE1MnZkeEpVVGd1b0xxNjRGdHNjcWhG?=
 =?utf-8?B?WnZsTm10MHJOMkNGTWwrUUZNQVI4RW9jR1FZcUxjclFMWlZ4OENMcS9OUTFO?=
 =?utf-8?B?MGREZDdLUElrYmticEF3cjhoQnMyWDhUWnRyMVdkWWc1N2xMbU1PdGJXY21k?=
 =?utf-8?B?QjBsYWQ5R1pwVi9LWEpSLzZxWi80QldrakoyNVJaVUw3cW5TWmI5MUdGbVpS?=
 =?utf-8?B?bytETThTcHpST2JBSHZFckl5WEExZ2dSU1NsZXJQUTBHL3h3L1AxWFRpejM2?=
 =?utf-8?B?YmduTHZqRG9sWmR3a0pjd2RuY2lUZGNlb3JJWVFTdENpVEg1VVRRbXhucWpm?=
 =?utf-8?B?YWUzanV0ZG5ydEdFaVpOWFpOdDYvdzFMV2hyb1BPMUFIdTFyeGhiQ3JhMFYz?=
 =?utf-8?B?RGsvNHVwN3QrOFFsbHRINHhtRVlraEpHMUdyYkN6Nk80ZG0vb1ljSDFrcTRq?=
 =?utf-8?B?bGlvRUo3NkN0UlJ6aW5rOEpYYVJmMlo2M3ZhZGVQVnVKWFpZSjB5TDdRbUsr?=
 =?utf-8?B?L2FQQzR2TVo4aXM5QjFEUWJDem9yNmk0NmJ1SzhwSmcvZ2xrL2dINzI1TEMw?=
 =?utf-8?B?SnZqMWE5VkE1cCtFK1QvckpHQitrZ1p5VUxvT3ozNTBaKzlIMnVQSnhoZkox?=
 =?utf-8?B?QW8rNVYrRXgzWGpLd3A0dG9rd2VXek1mVnZhUTZUb0FncUNBc3MrS1BKU0Rh?=
 =?utf-8?B?aUFVb3Q3VWpCd3A3YThuWDlVNHY2dWhndG9sZzU3MU83YzJFTDVjbjJPdElD?=
 =?utf-8?B?RG9PL3g5WjdKWnNHek50cnZLOC9OL1p4MkpOT3o0UXF2K2pIaDEzemN6UHZn?=
 =?utf-8?B?WnpjUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792283de-44a3-47ee-6ee1-08dad021996c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 02:46:35.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIe318GPRQtXcJItBjOBsU6/RjpFTD9W7O46EE981D3GgIJBjp+bUun+0oPDDzR5mugJwKkix32dlgfzHhuwebl35n07m3ZXDNH0ueZ7Y9LNjDbhZthH+aJNWQUmkQGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_16,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211270019
X-Proofpoint-GUID: T21hEky8ynlrjwdWzQkM6zithMqCLurs
X-Proofpoint-ORIG-GUID: T21hEky8ynlrjwdWzQkM6zithMqCLurs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micheal,

On 27/11/22 4:52 am, Michael S. Tsirkin wrote:
> On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
>> As 'dev->vq_num' is user-controlled data, if user tries to allocate
>> memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
>> creates a stack trace and messes up dmesg with a warning.
>>
>> Call trace:
>> -> vduse_ioctl
>> --> vduse_create_dev
>> 'config->vq_num' is user data as it comes from ioctl, which is
>> assigned to 'dev->vq_num'.
>>
>> Add __GFP_NOWARN in order to avoid too large allocation warning.
>> This is detected by static analysis using smatch.
>>
>> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 35dceee3ed56..5e9546b16165 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>   	dev->config_size = config->config_size;
>>   	dev->vq_align = config->vq_align;
>>   	dev->vq_num = config->vq_num;
>> -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
>> +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
>> +			   GFP_KERNEL | __GFP_NOWARN);
>>   	if (!dev->vqs)
>>   		goto err_vqs;
> 

Thanks for checking the patch.

> This is insufficient - the real source of the problem is that
> vq_num is not validated.
> The thing to do is to validate config and limit vq_num to 0xffff;
> 

1557 static long vduse_ioctl(struct file *file, unsigned int cmd,
1558                         unsigned long arg)
1559 {
1560         int ret;
1561         void __user *argp = (void __user *)arg;
1564         mutex_lock(&vduse_lock);
1565         switch (cmd) {
              ....
1584         case VDUSE_CREATE_DEV: {
1585                 struct vduse_dev_config config;
1587                 void *buf;
1588
1589                 ret = -EFAULT;
1590                 if (copy_from_user(&config, argp, size))
1591                         break;
1592
1593                 ret = -EINVAL;
1594                 if (vduse_validate_config(&config) == false)
1595                         break;
1596
1597                 buf = vmemdup_user(argp + size, config.config_size);
1598                 if (IS_ERR(buf)) {
1599                         ret = PTR_ERR(buf);
1600                         break;
1601                 }
1602                 config.name[VDUSE_NAME_MAX - 1] = '\0';
1603                 ret = vduse_create_dev(&config, buf, 
control->api_version);
1604                 if (ret)
1605                         kvfree(buf);
1606                 break;
1607         }

we have vduse_validate_config() being called in vduse_ioctl() which is 
the caller of vduse_create_dev(), so validate_config() is not necessary 
in vduse_create_dev() ?

Thanks,
Harshit

> 
>> -- 
>> 2.38.1
> 
