Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D16D0CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjC3R3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjC3R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:29:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8ECDF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:29:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHOFY8027133;
        Thu, 30 Mar 2023 17:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mcw9fiFebqgzhR2O5H8id/Qxvq4/vFXDFCEIiDPl3Ik=;
 b=XyYFbqr2aKKxU8DPNkCC6RDiPFfn7evYJecG5Qa6g5ai0MqMwMC2l1oUOY3bh0/O+NBX
 qfRs13LRKRJ0foLaXH56cOkDN4haZ1nT0A107YCCEoCeG3LWZ54lyHw+nf8goCCnoBU0
 n0/+6d8F/xW20gt+cPp/n94bx1Y/XQBOugY5vJIPj03z3zK4IhwpWvB3gG7xK4/vKxiC
 ya5MaWlHtEcX32BBkynMZY4ar+ozo/YwoEvJX0Dctt2ZyzmZy51WK3TxeG+qzai953Ci
 Sx03D2mAdwuQ4Sdo4x7PI8etOoQqQ9CztBfyKfJ+PvuUMm35M/XegeqcpfHf5BDTx5Vo bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq53bahd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:29:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UGmvjU010833;
        Thu, 30 Mar 2023 17:29:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdga87d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB0AklvPAf1d7w/do8eJ07LNw7jgaB2ZSuuXMWblmGWkSaO0Lnw7kg6GzfSzUaZ0vYBWcT9/dTIhkqUjl98cFh/Q+ws9Evx51uz6oCdkFMl9W/1c95vxLbbKI0W50HVfivTVOl1a4K12FAHkSBMmYHusosItPhCPxsN4R6Eoozk7sOApNGse4Mdd7KwbhMFfiKyhOz2eV66gbwHcMm65Tj+L3h+CAj25b8bOmjjTIbj2ZB6XNlA5GypMU6mDCk+LHey0II5e+B8Ok9OT9tXd3pqlMy0ay3KhuoPv/rYyt4uHj7XsBDxMVKVYrsSLNwcgYv5/LZvWk3/Q3BlRPQ5srA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcw9fiFebqgzhR2O5H8id/Qxvq4/vFXDFCEIiDPl3Ik=;
 b=WllcCJYgLZbGe5ryOyQbBFx8WyHBpnAtqKdiMt7tQCUrezAuHiljRXp0DQZoWmuZmqfqgOCfPayVBVSIyXOczXrjwlByoMRgOwkHMsb6HcSW+Lto5k19i12rHq2zvEi0sxwZGicUOmNKLvL+FNWw92gYle0vdCxuS7SaFZAVP082rDpS2LFsAJyjEY4YSieOsnCPYWc3itRQP7grltiRz7xw9GMjWizXqvpkY7+oXvwoCw0urxw/l0SZdBatmJQwrEBYNQy1TL6fRvzBcYkUIFbRl3uCDGbvBRtBwEsoRQ6VzBKrw/6msVyas8WqvRDgnQugOntkY++TTPOkItf9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcw9fiFebqgzhR2O5H8id/Qxvq4/vFXDFCEIiDPl3Ik=;
 b=uL1E1gar2CyYxvqIn67pGLut3y1m9KJ36NRTKGQS2m85gjR8Ww9qKTF8YCMYCb2MDutomU+tLR4aUDljFpq7D3yUYknY7V8HJyvgq8581OHNJSfHxu+54j4g0opnFo1Bgv5qnuGJ873wZuZMd04wmWAOo0Nzg1/XMTrVHYPzq84=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 17:29:15 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 17:29:15 +0000
Message-ID: <b61bcd10-df14-ff01-bae1-f4b99a8b97e2@oracle.com>
Date:   Thu, 30 Mar 2023 10:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/6] userfaultfd: convert mfill_atomic_hugetlb() to use
 a folio
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com
Cc:     vishal.moola@gmail.com, muchun.song@linux.dev,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-5-zhangpeng362@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230330134045.375163-5-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0635277c-76b4-4f5e-7cc5-08db3144489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XN3Q8xk+mZzHR5HGi3R1osVVqgwoOt/+DgCQiBb+o+g8k1ne3ueabftqIPqgmq0bJIT9j74R8EwAiaPuaEwb7b3DuOLbx/eUXZf4zKNsFPpDa/w7lzh3ZNA7JYGMhFyb+OsD18xcDActYenShKv8jCAdB6U+2fnojzsT7XMhvU2i19EMzBctIxGPXJDEXiouzzADHIbHpVVAKfms4KArmZ00imvdf0RXyvd5RqDtXPHJ3AN0qTLeE2uhQUTc9GidCfHGjSksio0u3pHM04V0RD6jDR8rgi0rQg5KIKTomzSwAVIFXkr2NvQrQO4GZqo6kGxwJi5Sd467legxdFGI5TREBZdFHrYhePq379cLz3ZENjUOLTiS03S3mVXkQ+ZfgI41MoIY39/XJL41qJAsuCQ6hT2QcRojBWXSi3HXxe6QkBt+QhoiwDMb4hcvDjJS2et/96IovQm4QNTx30u2OUO3z5V/NkGCwUesDRkt+eHwmHJQbNjg/pVawxM1BbucRlTtu5muXp3GzVkRRGS4pFJ6AfCiCAGzeLZIB49Sj14DM4dXDio3L1XZneEx6AiU7/FLizg7zM77BoGapZlt+Ky2RCrkdury54BKqPX4ayyE89DhcOCNhWiPn0vWRckIZtOHT2qMePWh/2g7o3TqLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(2906002)(41300700001)(8936002)(8676002)(38100700002)(44832011)(5660300002)(86362001)(31696002)(36756003)(26005)(6666004)(83380400001)(6486002)(6636002)(478600001)(186003)(53546011)(6506007)(2616005)(31686004)(6512007)(66476007)(66556008)(4326008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEpDcWE4akVRRDhFT2FtdmFUeEpOR2ozSHJ2N1hOZVBrWE1NU0w3VklxV1pK?=
 =?utf-8?B?S05zVWhBRXBHeUl4WTNKU3hwdnBzUmJyZnM4OWpqNlgvNXBhK0hiVHZKSkNI?=
 =?utf-8?B?aUJMTHZLVjdzSG45b2tvZ2RXR0M0T05TQXp6bkVSdU9KRUhHeW1wektsS0Ju?=
 =?utf-8?B?S3VMZjVtQUlSMi9XL0pKOVFrMXhjQ1Y1MFRRS0MrT0x0OHg1ZjNPamNhZGxK?=
 =?utf-8?B?UmNnM0tVY1ZXZVdsREt1a1EyTHl5Q1U1Zm1qaitvbHFKcGxtMitSbXlZRjdM?=
 =?utf-8?B?eVpqYm1ONVpHcExXZkF4SittZ1J1V1JaNzU2Tkpuako4emdlTlZnZzVZVk9F?=
 =?utf-8?B?d2Z3L0JZV1ZrS0h4bHpYQUg5eVdJdTRNbHN5bGd0T28zNUFXNkwyMjFrZ3Nt?=
 =?utf-8?B?VUoxZERKS09lN25PcEo0MnV6MWhNeXk2MlJOams1aDFhektSei9uUW1DWVF5?=
 =?utf-8?B?TGNMZUF0YktzZlk4R2pEdkQxeklzK25HeDJzQW1jdkV1eTNTT1ovbmNJNHZ6?=
 =?utf-8?B?TXdXeEtEa2tWemZ5UWR0NWxUOWlnVnUrUWszdEJrdjhwRGZ6UlFkRWMrU3ll?=
 =?utf-8?B?QSs4YTBxRExaTFFSNFl2ZW5NTy9QMklOemtqQ2F5alB5cVZDY1Rid0NrUjJ2?=
 =?utf-8?B?TU8wRjBsVHdWS01wczY4bkw2c2ozbEFMT29jb1ZwaGExVlpISnBXMHJzYnYx?=
 =?utf-8?B?elRVRUNLTUROSVpHM1p6NnErM3BTZUluY0huRlRaU09lS2ZYL2d3dEJiS3Vr?=
 =?utf-8?B?MXRzU1poWVBISXBRSllZYXFBMEhmOWNGbVpLTHJlOExUZ1hZUTVNRlpwWFlD?=
 =?utf-8?B?bnFlM2ZlM0dpMGszVFEySC9mb0xHWmJhZTlTY3ZyL1hoaU9LNm9xeFppUjRN?=
 =?utf-8?B?MUFMY2daTEQxTTlVaW4xQkJmUldyQ0d3VG94KzcrWnNmcGoxUm9xL0ltSG9w?=
 =?utf-8?B?MUUxRDFReEF5aU8zY29nY3dBMTloM1NnVzRiR2VrRk5yV0QwZEtBeElmWXFQ?=
 =?utf-8?B?RlVvYTkvU2dSaEFQUmNrVUtVR1FOSVFLWVVRVVZZSTU3UHBpWjhpV2JCOGda?=
 =?utf-8?B?L3lqUGdaUU5lb0dpNUdCZnptYk9OTnhqZ09ieEN2ZDNkVnNYS2pGV3Mrempr?=
 =?utf-8?B?Nms0NG15bVB4ZjkvV1VnMDR3VVAwM0NWVjNUaUdQUWxuVFNVY1VTY29QdVFH?=
 =?utf-8?B?U2RXTmVnSnZqQ1poM1V5WGN1SjVwbXJ3S2dVQ0tCM21nSENFMlphMVVZczcy?=
 =?utf-8?B?aW9DWkZ1RGRqSG1ON0RrZXp1Wm1RZHVSd24wVW9CM0ZtZS8yZ204MlZ5MVBo?=
 =?utf-8?B?WEFwc2NoSkhGaVB5cGFGMDB1ekZCMVR2eVRvY0ZXK1NWS25uUDhFaFBUWWVQ?=
 =?utf-8?B?WXlUcWpja3ZhUHc1SWtIVXgzRVowMXhSRUUrMm00TVNYV3hVOEEzc3B0Ymg2?=
 =?utf-8?B?U2t0LzdIQmZNUWFGOFplZnQxODY1R2J3S0tWSWJrSm1LT2laZXdWT2FWanB1?=
 =?utf-8?B?aU1VbTg3cXhkR21md0FqS2lqdnBLYSt4Qko2TkV4bzRGd1Z2dGx4VFFBT3p6?=
 =?utf-8?B?b01pRitXTVFsSkJqV3F1Wkh4QVJWTndYR0tQNG5oYXZIYUdabFRXY2t6bFBG?=
 =?utf-8?B?V1hvZjlkdTcxV3BSTGZvUDh1dnJkRzJ2dEcrTXMyZDVZK2dSTXlqVEF3dUg5?=
 =?utf-8?B?ckhxYnQwb1h3QWNrQnVSZXc1dmlON2tnUDNTdTZ4ZHpXQlhrcW05cDFXREx6?=
 =?utf-8?B?MnBoTkZDbjhJcldRcHBScERZQTByRTFVN3FLVGNBMGw2T2lydVhQQU4yWGNL?=
 =?utf-8?B?bUFDZTZIWTl2R3NkWllHcXNlRnlPQWRTNzNEdndCZSsrLzIrdTFXakgyVC9t?=
 =?utf-8?B?UVc1cnJQblVoMzRWa1l0R3Y0V2t3N01LV3B6NjJBODhBS1RvRnh1Q3F1aFVy?=
 =?utf-8?B?ZEVIWkdyaVp6MVNLZDNqaWIzYzVvTXZRUEZFdk5NcEdLMm1HMlNQZERJS3dS?=
 =?utf-8?B?ejFYZUNxL1F5VDdNRCtUSTVGOXVUZzZINnlNSVpTYzYwRnB2MG5VMkE5VDVv?=
 =?utf-8?B?bEd6WGVCc2wzcy9tWXRYSjU0SWJxRjgxaHlLZkVHSXRnck5zNW9kTUZGMWtt?=
 =?utf-8?B?Vk9KbXg3QlZESWJoQ2hQUUxQeWZzL3hESHNTL3d6ajJEclNMREpDK3c2enJs?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eXZ3N1lNNEZ6blVzOERNRk9xTzhUTGp4U3VPWEVsWEdzZWNmc2FQSTB1amRh?=
 =?utf-8?B?WFRqTXUrckdod3ZLTmtYOHRIV3k0WkFhZzZnWWo1aFVkdE9iRzYrRVFQMTRW?=
 =?utf-8?B?N1V0YjdhTW5zbTkzaVpnK0UveEZxV3MzTXZVb21GcnQrMFpOeU9LckZCOE4x?=
 =?utf-8?B?Z2VSUmhMajdHMWVhQ0tLWGw4Y3BtbjRJdVNMNTk0WHZ1VkZBcmZTOElobnJk?=
 =?utf-8?B?a04rbkpHby8weUJrRkEvQ2gwYklMS2MyTXdUdHRqdzZ1a2lkSjNBV3hKaFN6?=
 =?utf-8?B?OVU2TnJ1eUNSSHlBUDMvVlpwU05sb2NTWTNhNGJteVJXUm9tVTVzQTJpc0xQ?=
 =?utf-8?B?R3VaZ0NhTDBqN1UxZk94a1F3TnJRa1lQOGxtVUlxYzd3cVdxdjd4ZCs2SS93?=
 =?utf-8?B?MkN3cTVtNEhkbXFkTnZlNHJnQlRWUmo5alJETGQvdnM0dVlPbW9YRVFsRGgz?=
 =?utf-8?B?V0ZycS9XQkhOb3hUd0oyRm50blVTd2ZxcU1sOXRrT1ZUOVk0Rm5jNlIzRHJh?=
 =?utf-8?B?aEdCVm1ISlRDRnI2U0VCSUZWLzlRajhQZWU5Q2FrYndJenM1WjloZkhjTDhs?=
 =?utf-8?B?SlFOSFBTZy8xRFZpdXhJQ2pFS3FnTEJLMVpsTzNMSEdiTzNPZDRCbDlIbzNU?=
 =?utf-8?B?OEZnMmp2QjZlNVJaNHpFWXo4OVJYY3hEUjJnMzhkelNCb1JNK2F0cUJtdnMy?=
 =?utf-8?B?Nm52SnIzSzg3U1YrbndQQy9KakJWMFZKcDd6bmhsaXRxRlExV3VWTXpkM2VB?=
 =?utf-8?B?eEo4ZC9vUm1KOFBwT3ltVy9iQkM2Wnc4U0Zua1QydndCbkZIVWQ0T3Vla1Zs?=
 =?utf-8?B?NUdpTEhpZ3FyUXRVZUhLMEFrZEE4blFwZFFnZXlNOEZyZGZFYy8rVGRlaG1J?=
 =?utf-8?B?cmNWaDBMMUFmWklXdnZkcVRGTzI1Z0c0V3VnUDNNUEpFK09nUjc5SFRTUlA0?=
 =?utf-8?B?djY0VURRYm9mRkVuQXM2ZnIxd2ZPS29sNko2UzRzbnRweEZUZXBVUEk4YjBI?=
 =?utf-8?B?SUJSc2ZMZnpEVEtNSXBKY003NVFoc3NvS3NBQjRTa1RPMk0vUDZCaDlsTmp3?=
 =?utf-8?B?TmczcmxLZW9wSlVOeWtSaU1hL29KeGQ1ZGNKS0lHbFdEUUwwZlZteVN4TkFG?=
 =?utf-8?B?MWhyQ0pQWXMzVXlKWEF3K2xFMEx6ZjZGei9qZnJyRTZYcFI4SFh3MlVBU3Vq?=
 =?utf-8?B?bnNzOWp0OXNsR1l4djhDUENqeS9RZFg1N0w5c1R1TWF5T21YMEFrQ2lPRDE3?=
 =?utf-8?B?VmJST2l2M3RqL1REZ3pjWTErVk1uOTVJc2xTRlZrZWFVdURTUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0635277c-76b4-4f5e-7cc5-08db3144489a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:29:15.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOEpYcO01BsU3C7e4qvabLAx2g2RpRzCcZi9F8fbmm4W1BxxgEJNO4tFFQ3Y41nQVvvm2o2M2b5+P/5038X2xBt9U+9t1skl6S3BjQ5zTpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300138
X-Proofpoint-GUID: JKXe_E5OWS0TbePK2XbiD0Fr4YlDY95n
X-Proofpoint-ORIG-GUID: JKXe_E5OWS0TbePK2XbiD0Fr4YlDY95n
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 6:40 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Convert hugetlb_mfill_atomic_pte() to take in a folio pointer instead of
> a page pointer. Convert mfill_atomic_hugetlb() to use a folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   include/linux/hugetlb.h |  4 ++--
>   mm/hugetlb.c            | 26 +++++++++++++-------------
>   mm/userfaultfd.c        | 16 ++++++++--------
>   3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2a758bcd6719..28703fe22386 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -163,7 +163,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   			     unsigned long dst_addr,
>   			     unsigned long src_addr,
>   			     uffd_flags_t flags,
> -			     struct page **pagep);
> +			     struct folio **foliop);
>   #endif /* CONFIG_USERFAULTFD */
>   bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>   						struct vm_area_struct *vma,
> @@ -397,7 +397,7 @@ static inline int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   					   unsigned long dst_addr,
>   					   unsigned long src_addr,
>   					   uffd_flags_t flags,
> -					   struct page **pagep)
> +					   struct folio **foliop)
>   {
>   	BUG();
>   	return 0;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index aade1b513474..c88f856ec2e2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6178,7 +6178,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   			     unsigned long dst_addr,
>   			     unsigned long src_addr,
>   			     uffd_flags_t flags,
> -			     struct page **pagep)
> +			     struct folio **foliop)
>   {
>   	struct mm_struct *dst_mm = dst_vma->vm_mm;
>   	bool is_continue = uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE);
> @@ -6201,8 +6201,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   		if (IS_ERR(folio))
>   			goto out;
>   		folio_in_pagecache = true;
> -	} else if (!*pagep) {
> -		/* If a page already exists, then it's UFFDIO_COPY for
> +	} else if (!*foliop) {
> +		/* If a folio already exists, then it's UFFDIO_COPY for
>   		 * a non-missing case. Return -EEXIST.
>   		 */
>   		if (vm_shared &&
> @@ -6237,33 +6237,33 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   				ret = -ENOMEM;
>   				goto out;
>   			}
> -			*pagep = &folio->page;
> -			/* Set the outparam pagep and return to the caller to
> +			*foliop = folio;
> +			/* Set the outparam foliop and return to the caller to
>   			 * copy the contents outside the lock. Don't free the
> -			 * page.
> +			 * folio.
>   			 */
>   			goto out;
>   		}
>   	} else {
>   		if (vm_shared &&
>   		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> -			put_page(*pagep);
> +			folio_put(*foliop);
>   			ret = -EEXIST;
> -			*pagep = NULL;
> +			*foliop = NULL;
>   			goto out;
>   		}
>   
>   		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
>   		if (IS_ERR(folio)) {
> -			put_page(*pagep);
> +			folio_put(*foliop);
>   			ret = -ENOMEM;
> -			*pagep = NULL;
> +			*foliop = NULL;
>   			goto out;
>   		}
> -		copy_user_huge_page(&folio->page, *pagep, dst_addr, dst_vma,
> +		copy_user_huge_page(&folio->page, &(*foliop)->page, dst_addr, dst_vma,
>   				    pages_per_huge_page(h));
> -		put_page(*pagep);
> -		*pagep = NULL;
> +		folio_put(*foliop);
> +		*foliop = NULL;
>   	}
>   
>   	/*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index b453a4d2a0d3..9e95af5ce2dd 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -322,7 +322,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   	pte_t *dst_pte;
>   	unsigned long src_addr, dst_addr;
>   	long copied;
> -	struct page *page;
> +	struct folio *folio;
>   	unsigned long vma_hpagesize;
>   	pgoff_t idx;
>   	u32 hash;
> @@ -342,7 +342,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   	src_addr = src_start;
>   	dst_addr = dst_start;
>   	copied = 0;
> -	page = NULL;
> +	folio = NULL;
>   	vma_hpagesize = vma_kernel_pagesize(dst_vma);
>   
>   	/*
> @@ -411,7 +411,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   		}
>   
>   		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
> -					       src_addr, flags, &page);
> +					       src_addr, flags, &folio);
>   
>   		hugetlb_vma_unlock_read(dst_vma);
>   		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> @@ -420,9 +420,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   
>   		if (unlikely(err == -ENOENT)) {
>   			mmap_read_unlock(dst_mm);
> -			BUG_ON(!page);
> +			BUG_ON(!folio);
>   
> -			err = copy_folio_from_user(page_folio(page),
> +			err = copy_folio_from_user(folio,
>   						   (const void __user *)src_addr, true);
>   			if (unlikely(err)) {
>   				err = -EFAULT;
> @@ -433,7 +433,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   			dst_vma = NULL;
>   			goto retry;
>   		} else
> -			BUG_ON(page);
> +			BUG_ON(folio);
>   
>   		if (!err) {
>   			dst_addr += vma_hpagesize;
> @@ -450,8 +450,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>   out_unlock:
>   	mmap_read_unlock(dst_mm);
>   out:
> -	if (page)
> -		put_page(page);
> +	if (folio)
> +		folio_put(folio);
>   	BUG_ON(copied < 0);
>   	BUG_ON(err > 0);
>   	BUG_ON(!copied && !err);
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

