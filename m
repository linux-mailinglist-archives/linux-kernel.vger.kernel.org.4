Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2287568B510
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBFEyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBFExu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:53:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985D26B1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 20:53:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315NFDB0006662;
        Mon, 6 Feb 2023 04:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=Usj+7OIk0eVnGiMVG6KtlxfbWMTVhg2l0W5Hm22v7I3hBfhezyKxbCW1NGRCRPKPjwbg
 SxYwhLUYI1z+s+iapVJWno5Y0Te/stU9cBGEaCUaVXwvX2PyQKnT/1qNLnVQZGkyxgBW
 2vD87z8fkFPalr+YseYZOkEM15n7l1vxGYoi9yE30wnx6K6exmFTwkOEPZFx8j34Wd/t
 f9jPvstYOcHPiMH7W014g1h/8Xkfd9F0L65vMuQmKSXaAOWPzvz7AOCi3rh1cYdaDycl
 8UwI1F6rMaPFmy5WNkJAv1B8tlt96y8J/WVUu1aVzqxSWypnhSR7xMM0U1cQvkJuP8VO 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytt092-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 04:53:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3161v1fC016767;
        Mon, 6 Feb 2023 04:53:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrb837jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 04:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO5re6EfSgzrggfF6wmh3PrJLb/+Wg9FKF7TMO2Ytx57FY0tWpaDDoTqZo5kKWuBp6aG60VL7QBKD6ALRft3A3F4HNoIFMGc69M1JWzZzAYVFhl5uMEdYie23lV6YMjISxZBKteusWl51rOgLfqDIW3xvfEUqdLHepdW4V8M7/AtrJcnDMjoYYDlWYv/4cIv+9sHSvM4Wc+MAOKpPRJvgc2+7efk1t4U/1D6JXkOwYFoLZeL9qrX7nhd8z1Un53Gx/0PlTDDouSUJo0sTmUOG8CNjt3dlCaB6/T7zY2l+YiZtGpbYrLov6H8Cej4lB0wG8gFvcTV40Q8wACs07pAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=CMvUmxcAef+vt70BnHhhUvetPUvTcLrhHuiJxJV4xUubcaOHkq10Rvty+Qj3IpXWEhzDEyUSA3YwkaZgqBgJcrXf91Ztf3ilTTwSHQGqiwCathF/cs1Cl+m5gXmUKornQDNM4sRxuBGFQ5x4K8zAwsEUBtu529Lv771zKSlL5k6K8pmxSHdd6bFqzIUTIMp19y3kmyBd8ZmJGWmpfmU8Cx/zyrsQPefhzxbvt7UG9rBD4xjEf9Z9oFmO3V4Uz+5OSJXxHKsvPXsIxFkHITf/+Gu1ylAVCXkrRtEpNSid4gbp2yrAwUzrysOMvnvABH6CL1nuyQVwyAM7GpQFt2X8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=xNKDBLt0dvmwwmXisvUoltwgorffWDFAEZZQ3j5WAc71nfm5oEuRQI6zVfr8ywGV/BmJD6DXMbd98Ve64shLjOaBw09El53gptyHhMq04W5dSehLX3AwoMtz09IX+cfRnYFehwGPbjf3aMvHPAoQxhpxdxD9MsgRETGPHw1oins=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 04:53:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Mon, 6 Feb 2023
 04:53:33 +0000
Message-ID: <92e5a001-a17f-9d05-5412-355e1c436b30@oracle.com>
Date:   Sun, 5 Feb 2023 20:53:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-6-git-send-email-si-wei.liu@oracle.com>
 <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 34df053b-7bc8-4940-5fc5-08db07fe1989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt2LGDmr/5UPubUTsKqFVs5Y2GYDAUTymfdvTBSIMoXHlmCQ+V7e3RlLUsmUdVPKs4x5R8JewqlGtk638mrQH2bWXCfDhO1dJZQqAcB/GlVqhDe3txNi79o1leN441P9erNhXlQ6vvdW4x655uyzBrF41u7wUTKQSgx9zGQjru/laAGaTYUuaeb4tQ0w4+gq0mDjCkOpkI0Ra8eAx3lQfEGkjjTBc6PEQhFZ91V1GrESjr+lpMmkY7gI2KkgYSOJm9D3TxDWvg38JawbRgbvFmNHREgilUWaOTVDoLxaI0HWvvVivDcuNM1GJenS5hWI0dre8IEkOGQilPwL8GXdOksZka9TfL3hOFVL9bBZoImcf51Vu157m6AH2o5pYRffpBV5kH/U0vZVX0O3LiqsZD2ZjgoZIYSxhowvq23Q1mvzGKYwVWiOK51/LOVlEwFRcmkzecDXFsbEeoD277a3EyPXZtpqaKpiBTmIkOy0ItzjI6C1wc9jREYFoUxfNnoAWlui7pPhJarjczqQ31Q0MjzGcjWTSwwXpnpd7PKk8CPN6bbq9eGT2+fRIXbGfml7guul3J7f0vRD6nSjFIN3OtOosrq2R9tnaCNfNBX6S9OTA1zeHzMu4bx/kNLIX3JY+Ek1ss8IJPlC2o3PyqhnVNSTjNF2kAN4lUCRm7hjHuxpgGwdj0nRYt9OfVFBK437H+8Rzb3ncpgKvSNV6V8GPeF8r+UPdSsv59APqgCD/U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(2616005)(36916002)(83380400001)(41300700001)(4326008)(316002)(66476007)(8936002)(66946007)(8676002)(6512007)(86362001)(53546011)(6486002)(186003)(6506007)(31696002)(66556008)(26005)(5660300002)(36756003)(38100700002)(2906002)(478600001)(31686004)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjhka2Z4VGhNOEVBTXk4cnozNlpUdXVEZEVsbm9MYU96MTlCWUNtVjROV3o5?=
 =?utf-8?B?QjcxQ002Umc3YS95VlRTMG0wWkd0TFg1ZGFCR2FQTVJIZloyempBNmxXUmU1?=
 =?utf-8?B?U1dPdy8yWFBQL2RtWkthK1Z0eXZ0R2o2c3ZUTGpkdVF2cjFjWmhpZGZuQVJJ?=
 =?utf-8?B?MnkvdGdmUXJBL0NTbm9mNUgrYkhCcGppTGUvdXdsSzY0UWlTSy94YVUzTDVM?=
 =?utf-8?B?bTAyaVFXRVIwRUMyRDdxcXJQdDkvaWcxMXRhUkY2R2p5ejF6cFZ2ZGtBNzc2?=
 =?utf-8?B?SHdQRWRIcTlpOHNPdmNGdnIxdW9QWU4yVjZRelZ4dnc0czhHVWFEdEdsYUxH?=
 =?utf-8?B?TllGV2ZaakwxRlcwcDNHbXBzalBHQzJ3NW5idUljMGNhcTY3TStYaFU1M3cv?=
 =?utf-8?B?OTV0anRJZ2d5RWFYU0E0aWJJOWhJOE5zZzdiemJ5NlVSZ1hDU1pyT2x4RkxD?=
 =?utf-8?B?RFBGdlRKem5HRFJEVXhRUldFM0JpUE1qQ3ZnRjZNWVI2MEVVb3RrM2ZzYXBO?=
 =?utf-8?B?b0ZYZXM1aHJYR3JIZnpUbU5uc3c1SVp4TWhyMDNWQ1lMRXFzenhYbmVUVmd2?=
 =?utf-8?B?RFBlN3djbGVlOWxoSlFEK0NzUVlpU0pXWWtjQ0Q1UHl0cUh2UVUydVhlclAx?=
 =?utf-8?B?dXVUaG9oWFlsbHN3elQvZjVsaC9sLzJrNDRoNnFNRGV2MFp2NXJnbUt5dUx2?=
 =?utf-8?B?RGNHdDcrOVB4T1FEOXNxMUd5ZUQwUnFlQ280a0xlWUVOdGs2V3kvY3dmZDZE?=
 =?utf-8?B?bnRpbXg4ZmtqeTBrUHBsTW9xOUlVUldMMDhPajlySE5FVUNxUFVLNUhyMHZu?=
 =?utf-8?B?M0FWM1NjYkNWVGhpazRFL0xLS0RWUE84eCsranl6U2l3MjcrVDBmTFloUXVE?=
 =?utf-8?B?RlNCYmtSakduN1ZUUlBMVVdodXVna1hUb29Wa2p6bk41RXZ1cUQ2RElvQlVr?=
 =?utf-8?B?dXZrSXNUWU1kOW5Vekd5ZjlFUWNGNDJnT3lPVnVmWlgyYnlyOG5RVkZTS0dY?=
 =?utf-8?B?cEZ5UHpyaVlxZ25ROHNmVlByNzlVdmRHaVpUYkNQZDArcUJZSlB5bGpQRTZo?=
 =?utf-8?B?azVVQmowbXBLeVVyZVUwelEvaUZMeTFnVVpTU2grN0hRYVQzWGh1L3hVajFi?=
 =?utf-8?B?VGxrRWJDdmFjcVlzd0xsWjk1ajg2OXJNcktuN3pJWVJ5UU9saFhETU5MTkZa?=
 =?utf-8?B?QWZsbUNpTlB3ejNxV3NiQ29zdzloOHRNN3ltYWpSWXBidmgvcmtqUW8rU25n?=
 =?utf-8?B?SXk4RHRPaVVwbmVsVFBmNzAwNXRnZXRSUnpvaEFBYU56Z2pTZGdqYXNSQjBF?=
 =?utf-8?B?TWZQRmdFUFdleVNhTmJMcHErNU05R3d5TTJqeUtVdmFkU0VYWTB2OExxcDVp?=
 =?utf-8?B?b29rL2tjZ3I3M2NYd1hDNjk1NkllKzVPNzhweWk0VURvQjRXZG45bWZ6ZWdH?=
 =?utf-8?B?eHR4MlhYSnZWVHY0UVJGTVpnY1NCU09EekR6WjBLd1EwazhtbXp5b1FCZTRx?=
 =?utf-8?B?YzMwbU44U2IwMUM4Yit4Mzl6YUFvWjJaTkE1OHBYajZJa281NWhEVGFrV0da?=
 =?utf-8?B?M3hRdG4ycEZ2VzlWY0paaS9waUZrUk1aeUI4V09EcVoyWXhSUDJiT0p3MW1T?=
 =?utf-8?B?SzRMK2czRWNoeWFLSkJGM2g5VzdjZHBhbTdZTm5MK0xtWEV2elBGT3Q4d1hr?=
 =?utf-8?B?dGdUVzJ6MzRJM0c3dHJ6MG4vYUtPTU9VeG1YQ2FuUkswc3VKejBpVmNaL245?=
 =?utf-8?B?bEpqd1VrQWdWZmhsdmwrUTZWRWxKSkpjN01XUTlrMTAxYUlETTVKb3FiWFla?=
 =?utf-8?B?elVpTklXVEJPUnZHd1lOMnRIS1YyR2hqQVpxUHBPbHNUSzd2TUJacXNmZTl0?=
 =?utf-8?B?bDhIQmRZR1BaMmtGWTBxcjZ2c3VJTmVzUmc3K05XOENhRmR5WlhjcjloWnZ6?=
 =?utf-8?B?T0Z4NmVyWXFmeFEydmpiY1BsNTY3djZVWWwyb05USVMzbTlUalAzQjlIcmdV?=
 =?utf-8?B?aXRpazM2YStDNEVrMTZHRzgxTnVLNC9yRG5hOXRBQjY0WTgrWjR0UG9mbVd3?=
 =?utf-8?B?QzkwVWRPTXFKcGVOOHZwRWdzbEVQTmFxU0xRRHAxNnZYRFZJNFlzRjRYa1JJ?=
 =?utf-8?Q?wxlFzZJbGVc7tq+Y6uTJNcpVP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mosFwjzI8peUKJ/rJ9tExlx+BKvwjkQM99VlaWr3bYgHTg09CBPObpMK556fHlHdUxBBCDJAYhA9u4E6AVdvGX7NChznz/yJeWNEIKFk8E7JkiJjN6pXSNApfNPI6ovFUnoEiTy4As/HiOVoBXk97VddOANQqkkjsen0E3yHQVt8MgaQHtuhHePv5zJgkaKWs6ippa9lBU/kdb3XufTkrnK2ADX0JI9ATzVr/wWfpmmaylDjtHWorN4Zz4OK5yyeCUpzT4oJMkGoDm0J3fzIX+V596Gm+YBt14onsle0MKja30QZT5EkZrWrsm+xAz5k41bSwkJ8j1rGXpyvfnNoo+/UvN6FNKVS1EpdM3Sm9mtWEXxoCNQr59S9NRhOyi+h4bk7cbL4Ovb1JgU7HoZzQdWBPQRz4UY1ICFjpf9vMUdg6rHmUAbyS50D5a65KiNEmf2PYgqhaOMHd4hc4HM1dC9NXAnooM2u3yrfk/L6p18gPcr4Ejh2Q19GNNGYOq7MfU7037SuP24kp8QvgfArioGLITpycq+c/OtibjIPIv3IitKujrxnH9NcD1P2mz0v3wNPE3ZrhyViWTTaGU4R/8eY/lQJ430GxAWMoTryLyg0by4D7YoWiOm/mXAP5V0s59AIrztrnCXFUtMHIanzYwCU66ec4SjBR4yoT3hl8HKIveYtzsPu49QNlrC6/Wl0YJzhMzcUWy/II2pdI3dP2w6yAAZoZqjI7s/GZKqoG8+1mdpDxsJ4bPQKKUWJjND9IK2TX63fjyyQkSxi3up3WvjX5jtFf1iHawRwYb7Dn0DBtVnkPIBDNQjCaiknrXXs/R+uYUx3X7FqgYC5vMV6YVBz3Rd23+bTLg+JX6iPyrlfEbGOkFM9BsNTs7ta+9GinISBx0HiIfNuXWABu/gSvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34df053b-7bc8-4940-5fc5-08db07fe1989
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 04:53:33.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M292CBFVAfK+29VnKDHXbSu8cNcdbklYjCs0YTAYW7ZNAGu4kd8dbtyyfpHOKuysneyrTrdfn3Efa9Cmp8Ib1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060042
X-Proofpoint-GUID: EmNh2jID1gTdsgNxnl0GtEEf_zmFsyfT
X-Proofpoint-ORIG-GUID: EmNh2jID1gTdsgNxnl0GtEEf_zmFsyfT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2023 1:36 AM, Eli Cohen wrote:
>
> On 03/02/2023 7:02, Si-Wei Liu wrote:
>> The spec says:
>>      mtu only exists if VIRTIO_NET_F_MTU is set
>>      status only exists if VIRTIO_NET_F_STATUS is set
>>
>> We should only show MTU and STATUS conditionally depending on
>> the feature bits.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..867ac18 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block 
>> *nb, unsigned long event, void *p
>>       struct mlx5_vdpa_wq_ent *wqent;
>>         if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
>> +        if (!(ndev->mvdev.actual_features & 
>> BIT_ULL(VIRTIO_NET_F_STATUS)))
>> +            return NOTIFY_DONE;
>>           switch (eqe->sub_type) {
>>           case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>>           case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
>> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct 
>> vdpa_mgmt_dev *v_mdev, const char *name,
>>               goto err_alloc;
>>       }
>>   -    err = query_mtu(mdev, &mtu);
>> -    if (err)
>> -        goto err_alloc;
>> +    if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>
> VIRTIO_NET_F_MTU is offered by the device. So conditional is always true. 
With the next patch in series that selectively provisions device 
features to mlx5_vdpa, this conditional will not be always true. That 
was the reason why I made patch 5 and 6 in a single commit, as this 
conditional will only be needed until feature provisioning is supported. 
Basically patch 5 and 6 are logically connected and technically should 
be separated out. I'm now puzzled, what was your thought then the change 
in patch 5 shouldn't be part of patch 6?

> We are not done with feature negotiation at this stage so you
'You' are who? device, driver or guest user?

> may still set a value to device mtu if MTU won't be negotiated 
> eventually. But that is not a problem because the spec says:
>
>  VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported. If 
> offered by the device, device
> advises driver about the value of its maximum MTU. If negotiated, the 
> driver uses mtu as the maximum
>
> MTU value.
>
> So the driver will use whatever value is there only if negotiated.
My understanding is that 'vdpa dev config' now displays user provisioned 
config, or default config value advertised by the device, rather than 
what config driver will actually use.

>
>> +        err = query_mtu(mdev, &mtu);
>> +        if (err)
>> +            goto err_alloc;
>>   -    ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +        ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>> +    }
>>   -    if (get_link_state(mvdev))
>> -        ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> -    else
>> -        ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>> +        if (get_link_state(mvdev))
>> +            ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>> VIRTIO_NET_S_LINK_UP);
>> +        else
>> +            ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>> ~VIRTIO_NET_S_LINK_UP);
>> +    }
> Same thing here. Feature negotiation is not complete yet and if
>
> VIRTIO_NET_F_STATUS ends up not being negotiated, the driver will 
> ignore this value.
See above. With feature provisioning, whether the VIRTIO_NET_F_STATUS 
feature is advertised by device is subject to the device_features value 
provisioned by the host admin users.

-Siwei

>
>>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>           memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);

