Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95B688970
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBBWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjBBWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:00:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFC589A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:00:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDrAV001865;
        Thu, 2 Feb 2023 21:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VxHyGLk/iHJP74L5nySdqUTEBRjRlyAZ8xmojOGB7ik=;
 b=ELj3dEtAFsSDaDjX46BJT9a73gJAMYT+SwWrAtW51cdKSjctp2oRk8rQVoxG0BvcnEWD
 n9/0aYPOFNxjK6enVbSFTXG1hXHav8WzOQUKDBcSnkCKudV9RZ9gNOjNts9zBvejLor0
 upEE9n0QjCHxCyenWfiPkatl2f6n1WEEg3ZNx2XHSgSt2SAj4MOU2gxTOUt11Xx8PxWk
 mmuHuQvIi7tXFzQQxekEwh8YZQtVTkLEemVVP5hGJ7y6dFv9Mom7NK2SgtGG4l8/D954
 XXyxnLsC0FJky4AehRXEc4DYY4iQMN1xSpKxeQhl1SIw1Zxd0iQC95aT6q+P4mpmh9eC Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64chvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 21:58:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LPQdT030006;
        Thu, 2 Feb 2023 21:58:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59emgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 21:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2FtVbm8HqLUOUNofqayiuJgqNDTLck0nsjN75CAmShuBFNFyrrHdUWyiwvCmrwjhSNMGFl4GpPDAMC8oMSmkoGGMWDhCyqUXdgi0qij2YChNnaGFJWPVNIJqLHlSjXZlu7pdM8fd9LAE0JIpPSpeUza3KVoEgloXR2filR6kfrAQXCTnh+nGDQ2CseSyv6co+cWzPsKnS8KKTG9qkeCNA1k7pxSGD99vNW21a4tzXZXysb8jiGORxuysgIvIAb+Nyg7pFSQ6ytaYASaRIqJNy6LslMiV3qIGx9mz6KcV6hyLQg/lYoc+4GEBa8ogNJaEPVN25IOHaZioDuWdDe+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxHyGLk/iHJP74L5nySdqUTEBRjRlyAZ8xmojOGB7ik=;
 b=X4uHdaMkgD4s8aSddH/QSXOCTitcACWmSZNWk7sLiOgWB0mkcmUsuv+wgjAkoFku+p3hsLiTC8adIP592dvW5fPTHXgfQhp4BqqwCs5fktE34JN3y0Zyee9p4QmBNuGtOJnYzmT4XWQ0YWUJ4Ohm5h3OwFxPS35mddLdUd7HpmMG1Ru5sAwdCWB9L2ivGlXH1zjc1CDggsT3TL/gANg2KKbHdKT/nDDCoqsf6O8JaisbWL9NW9MTm5AjXFD+yN+60+amLisrj88H9RGf3lVSCecXnvk5ghGStSLCZjJJPXp+MlBqxz7H0ojvu1AyBZQmnp1nsjyLXZroO2ScErQq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxHyGLk/iHJP74L5nySdqUTEBRjRlyAZ8xmojOGB7ik=;
 b=mVI3LERS+lshqs+w4MSE4/XuH6jKwikJRBYw/NVMdP+pFI3jlW3trnuggAkSD+rn8RQI5AvWi4gv15dWZHyYoztWV03mA/IsgFwVHA+sNldp1cIMxUgfgol2WLXzXXvaAK052bdhrnyAHYKmZrOaxAf1A/R01ln1UVCNd5upRoo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22; Thu, 2 Feb 2023 21:58:45 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 21:58:45 +0000
Message-ID: <6b27b653-1d36-0ec8-c3c7-caaf1b896381@oracle.com>
Date:   Thu, 2 Feb 2023 13:58:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/7] vdpa: validate provisioned device features against
 specified attribute
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-4-git-send-email-si-wei.liu@oracle.com>
 <PH0PR12MB5481759D5CA6EB5C9D63C517DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB5481759D5CA6EB5C9D63C517DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 404d8649-5962-4e06-3fbe-08db0568a784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5Kh2V+kozQ+9mF/teQ4wd4P+qKHiY1UGgjzhVyBSEuqbaDIDrJQ9ysWAyJ11h8BGicBvyj1cmXjmK4NdfLN/PSqwnDhPic2kR0kLQfzfM1DYZvg1zTmyZn8dlGaMKUh9zHrvRh5HHs4GXWCP/lFvMOHz2yi1vR2981YHj/rjZ7ZeikXoMIinYSe7O6o5wamika2UVv1oKRtDChlOZNUP3UlSBSFWpg9oAr3YCZiGA9A5yStlmWZ4/Pqh+5X+8zugv8mNMSBxYoOWiNdyRl2PcaYD3nlugM6j4k41pUHZY2y70lOG/DtMe6Q8RywHGVrU0/JoHCw427gw3HcXNWyLS3bJNObeUbJVz8rl291AJJYhm2zptowr5OYjEk/Gx0kR/F46IHC+Bw47dO8Jzu+iwMJTAtPePzIMP3YSC8S1yzlxCZosk9UvrCjpGXJLhbisToU5LMBahR2htNvfolA8FIPgt/eZJPF2nzu7Q76jfNiTtHZpn0Gf+q0uetXnjqFcgmbCAmUcgQaUqUCcoxbO9hatWdjX4yNcb3NBww6gX+wwtaBfwkIXXQAOVCcZRLy33C2Yu7tSIs8qKeLGN7MBxZM/j02CiE/mOrmz2LgeuwxOiGXOmyCMepPY94liozTHT07Eg8pYtNce41ariMWpfCFp+6W0U57dNHfVbsNBVnHnAFVqrzP0E4QvuVGSd7qqq7MPJHnR9cuuhjOaegUAGS3ND48FRBp0+fs4gJ4+r4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(2906002)(38100700002)(36756003)(54906003)(316002)(6666004)(36916002)(6506007)(186003)(6486002)(26005)(8676002)(478600001)(6512007)(66556008)(8936002)(4326008)(31696002)(41300700001)(5660300002)(86362001)(53546011)(110136005)(66476007)(66946007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxIZWdyWGtSRDc0Y0tNMjdRd2FubnlEOW82akdjVjdvbG1iU09GUWJLVCs0?=
 =?utf-8?B?bTVGeU9PUmlRa0FDdGNHVVUySnZiS3VuaGZPM1lvbXNoUHpPZFpiZzNQamdG?=
 =?utf-8?B?VXozM0lrbzZoYnIxQVlBNm4ra0RaeVUrdGNQdVJocDdiQTZnbzlCeENZSjF1?=
 =?utf-8?B?NHhEUGFLZk53d1N3MVpKMDJkMG9oZWU1WHZESHd0UnlwQlVMOXBHZUVHVW5X?=
 =?utf-8?B?MjhQWlJJMlY3V2Jka0tHNmg2bzdHdGJpOGVTZ29yMGJ0alBLRVBrc2F5aUZM?=
 =?utf-8?B?VS9LVml2NVp4cVhLQ2RmWGRBRVMxRUEwNUlaQnRiOTJoUS9nRVE1R3Nta2dH?=
 =?utf-8?B?VEJRTDBnb1g1dkpKYi80TWorTDNGZGViUThmWmMxL3R2TGFmaS8rM3Vjcm40?=
 =?utf-8?B?OVpPbVlhRG1HeWZaTG15d1Y0WjgvaVZKYm9LMGtvYnNYNlJwbFEzbDBKUXlW?=
 =?utf-8?B?UUhBWThCVENDbUsyc1dPWkpkaFpPTlREVUxTclhyYW5kZUwxaCszaEpRYjlY?=
 =?utf-8?B?dmpQTm8zUlNXQy9kQWlMS2orRVNnYTcrMnR3NEE5Y1pFMWhoTHdHUDduR1Z2?=
 =?utf-8?B?Rnc4VW1kMEhaMVFzbExHTERXMHJVdEpub2VZaTF3c0xSc3I0QnR5TTdNZU9P?=
 =?utf-8?B?dXlRQXFHUkZPTWxDdTAyd0lXZytBUWZYc2FodStXRjlkNVN3TURsV1liaEpH?=
 =?utf-8?B?UVRJVko0Y0VDdE42RXplR0RHN0xPU3RwZHRTVGM5TEFSMjNGUEpCZFRzTDFt?=
 =?utf-8?B?QjQwZDBkcUNHVnp3QlRKdmxLTmQwQURoNGN2eGxvSEtKY2hHUUFtbmV2R1NK?=
 =?utf-8?B?ZFRNMFAzbFpHQ1RsVXpvc1Rud0dnNjlCN1l5UTIwbUlMcWg2ajdTTTU3Skho?=
 =?utf-8?B?b2MyRXRHNXM4Q1NVeDdRM0pWM2piN3BEb0NyUFVQNk84cnNTZDA1T0hhdG1R?=
 =?utf-8?B?NE9NQU9yM0ZFVFgwbjd4U1ZFQjkwOVIyZ1pwMlZ5dmN4ZDJMN25RYVp5dGFX?=
 =?utf-8?B?MCthTlFZTkRVaGxZcGd5QXJGMEF5Q3BuTWNJUUN4UzhBT3ovZS92VHV2SDhN?=
 =?utf-8?B?U1JpM2xNaEdmSzdvMFJoemg0OUs5VzdGUzRYaHpnT2JpdVBoNG9GM1RtcFRJ?=
 =?utf-8?B?aW1ZMEpKaVFpQ3BtTWJlcEprMWM0eUJyRGlObktzUGthcnlSLzYvaE8vNDRZ?=
 =?utf-8?B?MkFVMWZrRkgvOGhDU0FGTEhFM2hHQWZsUllHY3psTTBoVWxGQmEwVVRkN2FY?=
 =?utf-8?B?YWRJSkJkcHNVcTQ2MkUreENJWHlqZWpOa1Q5bENvcSswcjZXdEVaVy83YVI2?=
 =?utf-8?B?ZXY4dlc2SFBIWDFrbm9ZSlFoRUVxREYyYkdpVklRTXFZTzhrdWNnTUdDa1cy?=
 =?utf-8?B?b0UrSFk1clVBTDJBUDhtdGU1RFJBa1AvTWxTWjQxajNwV29kZnYvclpqVWJu?=
 =?utf-8?B?a3JGOWNWVmR3TkkyL0RsWEZqU21PY3cxVlMwT2tsaWhFYlU4dDFLaWhrd1oz?=
 =?utf-8?B?d3ljdjhsT09kWWw4aERTcTRkbmx1WDlVbmRwZjgyRDdESFA3Ykx4OUxNYVla?=
 =?utf-8?B?Y0lBZGx4bVdaQmhVQVVLVVYzZGdoYjZTem5FK2NpZGdSZEVzUEpuSVhrL2I2?=
 =?utf-8?B?c1YwQVY1aGZsT01BWUUrU3hxekFMa2NaL0NzYmNnYUdZUHoyejNNZTE2MkNy?=
 =?utf-8?B?dzZFNTZOTnhoVGZPeUUyeDNoNGdsRVhmL0V6Y0owYjFWYm5IbUE5cFJ1bkJZ?=
 =?utf-8?B?YkZIMkh4Wnd6bWRJNis1enkzOWlxN05QNkNIbERiZnJnMGxWRDlSTmYyMDRa?=
 =?utf-8?B?b2ppQ3hmbEI2QTlwcU9KRjkvcUxTeFg2SjV1WXh3U1gycGx3a3QwT2d1Q1Zq?=
 =?utf-8?B?SitRQ3RtaU1INmZQbmIweFRWSEhTTTB0bHpLVWpxQmIwdUFDMGxsbldlc2k2?=
 =?utf-8?B?YVpPdmo0dDFiZHdsWmpVTkdVQWdRZ0t1T2tBSjQ5dXF3RWN2cS9LakhJbk5N?=
 =?utf-8?B?b1pPZUx3d09tcmFwazNEc09QVnd3YVZRUnZIdzlTUVphN1ZmREdVKzNaSTBj?=
 =?utf-8?B?RTJ4a2I1UklxNnM3SEdDVzRhSmpGRGFQTmpZVzlqYi9oZkxqRWFmdTRpYnFT?=
 =?utf-8?Q?11jh57U0oi3XQKpqkW00cLg1l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rQ0MRSdiBpzjQk/A9UFJ8xjNzewjPu8YoFaLPD2SUDX7Wng8OWNvh78IVYD/2VB1YXYgiJGPHSGSI6L4moO6SLXVCIQjJ2tXUjDXXLvrv1LES5o53X9ZEqb5MSicGQZpSafDKxOXERAAIu/bTFhIVu4xkopu1Wn2fSMnI4RuFATT+VmOYlSr1smDM93kflEX7DTJa2hoqd8ztN0FZUwTrz9Fy6pPdouCO0lMw1D7seA+sF9xnybaNDLKZp66hI6RaBQJ0RXB097K96sdO+ysJ9plKmhZYzXiJiN71+qXgE1qgDCMDYLYgPiNp0ivQid2jsiQT4aXUkKeICQJyX5A02gMngJZglk0BBsHoKiQ+1n3ogcay66XuAmUM83qWaKu1APNYpsIuUaUlrarXp6J3pcbDZ+zcNxFRPPsE6V6PmCh/l8PD9ulHOY7Cdo9ncpdkG2DYLClphSajCAgyEfwfU9bjESdFNThS4QMqrm8XWmN50oJzMkbv6LjPxt2VJ85xtZFhqeV0BeQy4qKOSZk43o4jiDgH1Wp4+x0/UT4pcKydgHpRLIA5txcJHKgU4LuYp/FORhD0e0uPv21ZOXI9X58i4C0LgesrHKFt8qqReP48fn88LXSqQ+Io9qM4k3bw4tlv/7OwBNs3zefEbfP1+Eo0qjfYFuqhkYtLt7z7fv6S5x+NlOP6naDBDpeRuMPcYX65QlhFCKR9pfP6ljoFP3TfnCI/zZ0OT9xAHiVJi+vVljvXB+Fs6c4aQN25cOWCgAtdRmMe+JWxCIRISbCe6ZkW2XR4lFbpq9zp0bjucrLUPClAnmXik5mUvjLK1r/SVbt1x79kBD00WVrl2VTmwS2cHTvkDMLVq0T1GUePMLjyeRUfzTNwoXrPSLAKZDKHEh4PdGX05MzUVir7cSn7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404d8649-5962-4e06-3fbe-08db0568a784
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:58:44.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orjVdFZm5cYDw5IPxVaXBFN+MAE6948zDfHbT7eb/qxxAEUNnG8P8CP5fDTPXQXIwsM7JGNIImY4/eq5IlURxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020195
X-Proofpoint-ORIG-GUID: H2XEFo13CLgDHe5a14wVsW86XL7dOgHf
X-Proofpoint-GUID: H2XEFo13CLgDHe5a14wVsW86XL7dOgHf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2023 9:05 PM, Parav Pandit wrote:
>
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, January 31, 2023 6:22 PM
>>
>> With device feature provisioning, there's a chance for misconfiguration that the
>> vdpa feature attribute supplied in 'vdpa dev add' command doesn't get
>> selected on the device_features to be provisioned. For instance, when a @mac
>> attribute is specified, the corresponding feature bit _F_MAC in device_features
>> should be set for consistency. If there's conflict on provisioned features against
>> the attribute, it should be treated as an error to fail the ambiguous command.
>> Noted the opposite is not necessarily true, for e.g. it's okay to have _F_MAC set
>> in device_features without providing a corresponding @mac attribute, in which
>> case the vdpa vendor driver could load certain default value for attribute that is
>> not explicitly specified.
>>
>> Generalize this check in vdpa core so that there's no duplicate code in each
>> vendor driver.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/vdpa.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index 21c8aa3..1eba978
>> 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -601,8 +601,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
>> sk_buff *skb, struct genl_info *i
>>   		config.mask |=
>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>   	}
>>   	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
>> +		u64 missing = 0x0ULL;
>> +
>>   		config.device_features =
>>   			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
>> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR] &&
>> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MAC)))
>> +			missing |= BIT_ULL(VIRTIO_NET_F_MAC);
>> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU] &&
>> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MTU)))
>> +			missing |= BIT_ULL(VIRTIO_NET_F_MTU);
>> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] &&
>> +		    config.net.max_vq_pairs > 1 &&
>> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> +			missing |= BIT_ULL(VIRTIO_NET_F_MQ);
>> +		if (missing) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "Missing features 0x%llx for
>> provided attributes",
>> +					       missing);
>> +			return -EINVAL;
>> +		}
>>   		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>>   	}
>>
>> --
>> 1.8.3.1
> Vdpa this layer can likely derive the feature bits for the supplied config fields so that user doesn't need to keep track of both.
> Only those feature bits which are unrelated to any config, is what user should be setting.
It's not I can't do this, but Jason wanted to have clear semantics 
around migration compatibility for the driver, and for that users have 
to explicitly provide device_features that we may define new driver 
behavior (rather that inheritance which is implicit and not uniformly 
define across drivers) for compatibility using the new uAPI.

Thanks,
-Siwei




