Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C766327CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiKUPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKUPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:23:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790FFAE4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:22:56 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALFAUgX018316;
        Mon, 21 Nov 2022 15:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m7Rhod51spY/kezN0wnD4PdBTfpJWhE6LbpyBa6Y50Q=;
 b=b5SoO4oRKILs1bdOogmMmSWTgUghsnVOrW/2PoMlzHaoZ0KurS7KeOuNG4SMbCBsAdL0
 ktDpEIRiehn0E/VUNc9VhkxglPmefVZbN35E3IorBY7Q+TBYlX0rK0NTJONbtKyNzPyu
 3CcagR7AuAN/8ak/0fc24q6r1wgcXRlNROJhrxMXgvSkz0tMigV4M2wAvW6+WwGQ5P7z
 8x9PQ2m4LOL/n9BdAA+C42brfumDS3QEvwY273SaAH/PS1hHktsW0xCBbjffS8DmV9wi
 A3at85J0eZ8mzP58hdd4WA4Ljq8H8q/IkDPcXUgV5P+gA3UQZTGeCHZ0t2pHDKNXfu66 eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfavn8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:22:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALDusee038810;
        Mon, 21 Nov 2022 15:22:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3ujja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 15:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2fLWZ+DsqSeCEv4nDwbDv64O76J2wMWDCCNkBvUZ+j8FEh5FJ+a2cVjdYNogU1zlIrjiZ0TV/9UJhMdYMlNP+tyHbjeFzk624uptkR5O5HCiUu8CdQXR+bag2SyUEGsqlkmMT6R9yseOz+yakbnsreS1WP8VkX9himCL5wYp/U5/Db1ljbEPJfdvZbwmNVGnBJ+z9P8xr3tnOsmR3ilQU2GCI9xPe7vWrmyI2XNDZDDSfRxAqiCSGNsZCWHI0N3WyY/mMmd4fWJq7Ayl3j909qMb5/s6tffdpdhQuUE6lZJWaz3JWhIayL3woDvLEIW89ix2qdc+2qJFsndcUnuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7Rhod51spY/kezN0wnD4PdBTfpJWhE6LbpyBa6Y50Q=;
 b=VuxMVjjgCJy3zp0KskSUrMZhSzpWS6+p4K9/Q2eVNyJeiPeOrFjti8RhXntR5fGHpxzJpthD0wIRBR0AqvBkvXoUa3TLkOMEwvR1ATrYJSChP9XTJ83UJfiRrfqKsLHua8gZQwnRKmU+pfkUgo4J5qr8JLA7HsUzzbK6PYbZXguAJ6RrfTFszjqsRr6/NjRDxqvxYsq3PeGu0mHfkjRs7cfzjoNslH2R/7OmwbkXPuusgsAxxxRPSntvOtSZRB+3acNiNFzRjzgcvAUUqnyoSM38TfJYqWC5SQYv4gwjAhWDDna7o1wVTA4/QFHXm2qwKSCl0SJxc/+00MNyOx5CoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7Rhod51spY/kezN0wnD4PdBTfpJWhE6LbpyBa6Y50Q=;
 b=DmZUUUTgLfwqG4oT0rUyneqJqCiB57RLQ+5zrkYb9NnLkuJt9rI8HgT577Xkcx/Q5mG6DnJ4q4EWU5mirYobQERxHC7FN/G8gxWnwke/mmThLW9KN0jc5Z/d5k0FJRiI8ssBbhbnTLybmqzzy70uCkPPxUSCAz5XX3bAkJXUcJ8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 15:22:32 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%6]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 15:22:32 +0000
Message-ID: <01c463e2-707f-0ba8-e50c-8dd8641c15d1@oracle.com>
Date:   Mon, 21 Nov 2022 07:22:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v3 06/10] mm/hugetlb: convert
 add_hugetlb_page() to folios and add hugetlb_cma_folio()
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com
References: <20221117211501.17150-1-sidhartha.kumar@oracle.com>
 <20221117211501.17150-7-sidhartha.kumar@oracle.com>
 <20221119185950.nko3aki3gvh4zu64@tarunpc>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20221119185950.nko3aki3gvh4zu64@tarunpc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: b16a8a95-f6a3-4fd0-a819-08dacbd435ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txQLgbi3jR4lS2hEQYYkh3jQIvwkIPOU4p3DWJ9erefcbuy7apPOmZt4X3cTmWaLUGOBO4sj+Wc0pZg69JZrzI0yJF9E7I7THJXIh73c+M3z381Z7z13GKHyLpP7e8787a0AVz7yZKURrxwLzwJJqnhzL0Kp/kthNG60W+zpnm2ROR+Cp9s9eRlkgkjzs+7fdhGwYqbilg3aQqkxwrKv4JEDY/37gJoOVMeU09UFOKzdQ9slGXjd8FeC9RpycAhTPfgElTswyIoiXXsJpiAjnAvCsBZR/XyJ3uotpSO7SS0ryTvQMEqClxphLhQiNf4m+UrOv5oaFmBlplh4dnYuDYVMwfdFPhtTrHOlTJtq54NRq1p+eAUuHSTi1f0tehMsOmV88ZLTCqafliaOoe6xvuS1sz5CQEv69RUi7FLbynOuz9qOn1RM4RlDZ8h/CE7LLLKHeelZrwgf7ZP8tKeCHQh5W4nV1rybY9pNJYX9UlhtZNwcOo33rh1zYl1hpyBg+Pwyf7cK/UjiJK+lgzP+/Tl6oUZGnNRgs1LrfPkNg4dlt2x/CLmPcgmVX5Lm1GuGX/y8eJeAZbflYfJ2C3zbX2cWJXBC7e+JC8iO7cc6iXAK5eQZgpUgbGtBxesODNutUy3btQCN3MoaJzIK7EyLkUUksHwCzlflu7ZFfoloYePk/EK8l97LdVP63vx9cJO2IQXFsgpnY+K6VkutoUmc1+J6b6ptS9yKcC54f53/hcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(478600001)(5660300002)(44832011)(6512007)(66946007)(6506007)(4326008)(8676002)(66556008)(6916009)(26005)(316002)(66476007)(2616005)(53546011)(8936002)(41300700001)(38100700002)(186003)(83380400001)(2906002)(86362001)(6666004)(31696002)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRDM1BLUWlIRTVxUFp4dXNTWVFBYUFMZGhUY3RDYkFnQjdhTXBtUWxyVUJI?=
 =?utf-8?B?QkZlRFlMclhyYzdWWnNIQks3U3BHaTdVVk0vM3ViS2c1SGdGc1Y2V240cE5M?=
 =?utf-8?B?T0laenVJdEdjcEFVU0lRb1MvYjZWM0NteUdONDRGbVlhZG8xZmJJTnl4ZDNV?=
 =?utf-8?B?L3pPaEQzSmlSaHVNM0NDVUJYM2VxZzkyZzNpcUFubWwrOTZsbjNEV3RobktC?=
 =?utf-8?B?R1dDK2JKcWx0bTN0NHBZQlk5aFJ0clNIeitlN1owbDNrNkJvazFWVjNFaHcv?=
 =?utf-8?B?djlPL3BIQVg3MXhrck5aUWt2RFlDVDcvKytTQjZacllVS1dmZmY4YXRXSWhn?=
 =?utf-8?B?WHV2dUcvNmlMazI2aUxUMnYyS0dxOHd1S3NsazVUb1JVQld2bDV3eUFtK09j?=
 =?utf-8?B?aHREY1VxYm0yNE1IV3dheFNCdkpYaDBmWlBRQzFqK2RMQXZrUFpPakpBQzZq?=
 =?utf-8?B?VHRjRkNhVXB4UkFKbkF0cFBURllRUGcybTJDUnRERkJjUWRaeTM3UTlnekhB?=
 =?utf-8?B?cDVmRTBsOUVCY3lmczFPUitXZjkrNG03ZDNsRFY0L093QUpGMVNzSzFPcnRN?=
 =?utf-8?B?ZVpoTVFQVTUyU0loSkFNMWFLTmlTZmU0OTRZWFA3bkJsR2lyYUU2UCtwR3RG?=
 =?utf-8?B?WVZjNnBZV21ObStUQmh6Z2Q4QlRyVnRuUnFya2hqSGUyc2ZHT2hETjNUUTVF?=
 =?utf-8?B?OG5OY05aWUZJb1Rnd3ZjdkwxMTRkUkNWMndyU2psSUcwR2c2eEtReU9uTEVa?=
 =?utf-8?B?M0pHcnhTWmlQTkNYWmlNN0lpK29wS0NBZW1USkJrb1Uyalk1YjdjS0F3eHFr?=
 =?utf-8?B?aSt6aGVrU0hmZm5DcjRGdUdFWnNQV0orZ2xNelZXVGJkQ3FVamVVNU5jbFJD?=
 =?utf-8?B?WUhETDR2dXJUWVMyZVVERFF6UGpLZDZrdmJGUXYvazB5UFdzWE56WjZaNitC?=
 =?utf-8?B?M2lNdlMwMFhYdnVhRlFRYmtBWkQxbGNNdVJlUUpONkNNQ3puclJ5T3RpZU5m?=
 =?utf-8?B?YzZMQng4TS9xNVhHZTFLUkVVREJmWmVZZk9NemFVNEhRUE8xUndzMm9Gb05u?=
 =?utf-8?B?SFlvWkpZcnVCMjVHWTRNRlNWbk5ZOENpeHdIMDMrcU9WR3dGL3c1dnIwVTJn?=
 =?utf-8?B?QWw2U0dvZlR3MlZvL29OMW5tTWRPQnh4Tzc0b2MxSENmMnFCKzRtZmJ4Slg0?=
 =?utf-8?B?TTBiYTlUTkUzZWVZZzZxMXRXTXhFU0lSa20vQkg5SFFSeWRyd2sxWC9sUzcw?=
 =?utf-8?B?Q1JtdTZSQ09aODc3cm90UmFtU1hUWlVTbHlyczIxUnZvbEtUN0g4TzRBd25I?=
 =?utf-8?B?ams4RmFYaFBSNUlkY0NoQmNsYUdVdEo1TW9ydlpKZDU2ZXJQSk1KMzl1eWQ4?=
 =?utf-8?B?V2N1dU1oU1Z1VFhGTFEzTW9mM3lxemxhRU1IUUdXbm5nWXhOUjJMaVZNMkZm?=
 =?utf-8?B?NGozNTA4Rmt4N2kva2hjcWVrZHNmZWlORzVLellkdGZaZ0FzTHYzS1lxYUlQ?=
 =?utf-8?B?L2JtVE1Oa2NwcDBnYWV0UXJWTUtHYkM0Nk9wYXNSM1BYUHh5SkxGWlBYd3ZJ?=
 =?utf-8?B?eExRTHp5d3NVTnhzcXpYa3NzZmtnQ09sU1Z2SmZYMzZtaHBhUmpVeUhQMHp6?=
 =?utf-8?B?UjhEVkVMVy9ja0s0UU1UY1Z3UFA1b1g0d0FiSlVVck13eHF1Q01wcC9adUZF?=
 =?utf-8?B?VkdHWVQvaW5NVXJGUURGaUpUOXIzd20xemF4aVc4aFdZRy9LWmVzKzArY0pC?=
 =?utf-8?B?V0IveVFuZGdVNW1SOUVrR3FRV2RpcWsrL05yUUJsTklzK1pxV2RUVHlWZkZP?=
 =?utf-8?B?TjZPTlI5M2x2QkZlN3kyd3JndDJkdHgxQTZMa0FiS05FeWY0Wk85cThWWUdS?=
 =?utf-8?B?T3o3Y20xdWZNWlloN0RLTnRLeTcrTk5MTW1TeVhiRmNrSUx0eS95TXA0VGtV?=
 =?utf-8?B?dDNLdkFpc045aXZ2SlVHajF5U2d0VHNMVmFFMEF4a3dPWTBWb1N1V244azdE?=
 =?utf-8?B?STVxM3NxZndYN095STV0RVliczl1d3JNMDlEY01LWG4xbmN4bDNzcW1wcDEw?=
 =?utf-8?B?eVRuUnJONytaaWsrZUtIYkRlSUZkUHJWb3daaHBTaWhwTTArTVhSTEZSOGJq?=
 =?utf-8?B?amY5a3dIRUgwcmk1YVloQ255Q1NEUFhYMUxzRSszUnRRVlFJTGpxckxEQk1W?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlpuR2pXZEtPVzVHbk5OVGtwa0FQNWg0ZStiU21QNy9PSEJKY0RjTHJMYVoy?=
 =?utf-8?B?OEhrSDJ5c2pEL2tNT1FFb2xjVmNjbDJGZjhNK05JOTRxRlF6ZkMwSGxaVDdv?=
 =?utf-8?B?Z1hBamRuc2JJNmwxZnlUcWJvOW1NNStIOFFwakZSVkY0dERJY1U3eUd2RSsr?=
 =?utf-8?B?MlM2V2JyTGh5dktuODV1U1QxWWpVT0hIYVFVN0h2cEh0cHRtL0hsM0VwWVNN?=
 =?utf-8?B?a29JMGpxMVd0K2VqcWpPUHlKT2F4Yys1OG0wMDVmZVpLVjgzMmY3Mk8yUGdH?=
 =?utf-8?B?ZWNjOWY3bElyY3NEOTRLbkkvR1R6K1M1VWU2VmM5QVl3czJ0WWE3TXlJU0dD?=
 =?utf-8?B?R3M2ZVQ4amFpVlB5T0xBNEpwak1EbWVqenI5U3I4eWc0MkJldFNNVmF4UmRV?=
 =?utf-8?B?eDBaMGR1VnBnZGtPaXpnc2hQQTlzTUU5MVJUVkxRbU9IWXlodWkyRmI5bnQw?=
 =?utf-8?B?ZS9Pajd5ZndrNG9BSWZ4NFlRU0dZUEZBdWt3NGxKczFWOTlPblN3YVdQckdQ?=
 =?utf-8?B?RFdadjYyMlo3MzdZbW91aDM5dmpGZmNPNEZ3WFVkQkZMTjE4MHF2dVpsbTJl?=
 =?utf-8?B?NE8vdzF1OG1aVXhkNnB5WXZ4cUZqN3lwNDEzczhDaW44V2k1L0Fta0xRQ3JB?=
 =?utf-8?B?VksxTTdlZkZ1ZkdiVmx3WlRZYm9JRjJKWjRLMjBYdnJHVEZRQmhaTlgrd2Zm?=
 =?utf-8?B?M1oyZHVVU2taYjhVUS9CYVhoV0l0V1FTeStuaUJTUDlUUXZRSjU2V2hIM0RE?=
 =?utf-8?B?M1dGdVA4Skt1Ym90Z0drNUM2SVFmM3R4SnVCSUt4eGpHMDd3bTR0b214WVV4?=
 =?utf-8?B?aUxubWtmL0VHVG52dzdCOENFbTF1N25kbUgrdlR2ekxrbE50S3BUQzRVb1Vw?=
 =?utf-8?B?WHdUN2RHVlBmcXlOVTdQUVFOZ1E1eUJBeTlKME1lb1J6UmpDWkZVSCtvQUlE?=
 =?utf-8?B?SnhpejZkSk4vdGhZTXFjenEwcTFMN2djVlVkM1FKZUtKdFNXNkpUOG1mMjdi?=
 =?utf-8?B?RGpkeUhpVEVEVzd5bmJvOTFiVUlwKzJ2MTBNOWgyRkpvR2hnUEE0SklWYnA1?=
 =?utf-8?B?TG5yVkZraEpXdHJsL2UvMGN3RmFxaEpiZkNYa3lKeUZxdzNxckVZQUR5MkRq?=
 =?utf-8?B?RXQ3SDNrS3RZQnJ0TkFpK1FFQzljT3NRYzZ6UFVBcVhqa1pZY3B3UVkwQ2p4?=
 =?utf-8?B?R2dyZFk4YkpYOFFweGYwMmNXbnBBamFYNldtSmlUZ2FYYTQ3ZTJLUFp6L0xW?=
 =?utf-8?B?TURDR3dPWWg4RFcwWkh1MUZObEFab2NYQ29jRXMzMXY4THZtNkVlaW9wdHk1?=
 =?utf-8?B?c3IzNXBNS1VHcGRDWnBpSjU1b1NqLytBUmYvaGdlZXVTcFlrSlh4cWQ0YlJs?=
 =?utf-8?Q?kzKqSBxpe4uQWjLQ7asKsNx5WYx/cKhs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16a8a95-f6a3-4fd0-a819-08dacbd435ae
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:22:32.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES6EfOzrhx0uRxPx8m3Jo1WW2bGXurhcn1p2WwrnGMG9wMoL04OLWtTQrrPt75+xCGaUTEwpI1oL+RKr4QXfldH4BQlA3H33NgXwGxZHv4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210119
X-Proofpoint-GUID: HF86dizlLscEby6VDmwa0vW299zFfMgC
X-Proofpoint-ORIG-GUID: HF86dizlLscEby6VDmwa0vW299zFfMgC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/19/22 10:59 AM, Tarun Sahu wrote:
> Hi,
> Though it is already merged, it is just comment thing.

This series will need another version based on other feedback that I 
got. I'll be sure to change the comment in the next version.

Thanks,

Sidhartha Kumar

> On Nov 17 2022, Sidhartha Kumar wrote:
>> Convert add_hugetlb_page() to take in a folio, also convert
>> hugetlb_cma_page() to take in a folio.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/hugetlb.c | 40 ++++++++++++++++++++--------------------
>>   1 file changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 80301fab56d8..bf36aa8e6072 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -54,13 +54,13 @@ struct hstate hstates[HUGE_MAX_HSTATE];
>>   #ifdef CONFIG_CMA
>>   static struct cma *hugetlb_cma[MAX_NUMNODES];
>>   static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
>> -static bool hugetlb_cma_page(struct page *page, unsigned int order)
>> +static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
>>   {
>> -	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
>> +	return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->page,
>>   				1 << order);
>>   }
>>   #else
>> -static bool hugetlb_cma_page(struct page *page, unsigned int order)
>> +static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
>>   {
>>   	return false;
>>   }
>> @@ -1506,17 +1506,17 @@ static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *foli
>>   	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
>>   }
>>   
>> -static void add_hugetlb_page(struct hstate *h, struct page *page,
>> +static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
>>   			     bool adjust_surplus)
>>   {
>>   	int zeroed;
>> -	int nid = page_to_nid(page);
>> +	int nid = folio_nid(folio);
>>   
>> -	VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page);
>> +	VM_BUG_ON_FOLIO(!folio_test_hugetlb_vmemmap_optimized(folio), folio);
>>   
>>   	lockdep_assert_held(&hugetlb_lock);
>>   
>> -	INIT_LIST_HEAD(&page->lru);
>> +	INIT_LIST_HEAD(&folio->lru);
>>   	h->nr_huge_pages++;
>>   	h->nr_huge_pages_node[nid]++;
>>   
>> @@ -1525,21 +1525,21 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
>>   		h->surplus_huge_pages_node[nid]++;
>>   	}
>>   
>> -	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>> -	set_page_private(page, 0);
>> +	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
>> +	folio_change_private(folio, 0);
>>   	/*
>>   	 * We have to set HPageVmemmapOptimized again as above
>                             ^
> This can be changed to folio version of itself.
>
>> -	 * set_page_private(page, 0) cleared it.
>> +	 * folio_change_private(folio, 0) cleared it.
>>   	 */
>> -	SetHPageVmemmapOptimized(page);
>> +	folio_set_hugetlb_vmemmap_optimized(folio);
>>   
>>   	/*
>> -	 * This page is about to be managed by the hugetlb allocator and
>> +	 * This folio is about to be managed by the hugetlb allocator and
>>   	 * should have no users.  Drop our reference, and check for others
>>   	 * just in case.
>>   	 */
>> -	zeroed = put_page_testzero(page);
>> -	if (!zeroed)
>> +	zeroed = folio_put_testzero(folio);
>> +	if (unlikely(!zeroed))
>>   		/*
>>   		 * It is VERY unlikely soneone else has taken a ref on
>>   		 * the page.  In this case, we simply return as the
>> @@ -1548,8 +1548,8 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
>>   		 */
>>   		return;
>>   
>> -	arch_clear_hugepage_flags(page);
>> -	enqueue_huge_page(h, page);
>> +	arch_clear_hugepage_flags(&folio->page);
>> +	enqueue_huge_page(h, &folio->page);
>>   }
>>   
>>   static void __update_and_free_page(struct hstate *h, struct page *page)
>> @@ -1575,7 +1575,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>   		 * page and put the page back on the hugetlb free list and treat
>>   		 * as a surplus page.
>>   		 */
>> -		add_hugetlb_page(h, page, true);
>> +		add_hugetlb_folio(h, page_folio(page), true);
>>   		spin_unlock_irq(&hugetlb_lock);
>>   		return;
>>   	}
>> @@ -1600,7 +1600,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>   	 * need to be given back to CMA in free_gigantic_page.
>>   	 */
>>   	if (hstate_is_gigantic(h) ||
>> -	    hugetlb_cma_page(page, huge_page_order(h))) {
>> +	    hugetlb_cma_folio(folio, huge_page_order(h))) {
>>   		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>>   		free_gigantic_page(page, huge_page_order(h));
>>   	} else {
>> @@ -2184,7 +2184,7 @@ int dissolve_free_huge_page(struct page *page)
>>   			update_and_free_hugetlb_folio(h, folio, false);
>>   		} else {
>>   			spin_lock_irq(&hugetlb_lock);
>> -			add_hugetlb_page(h, &folio->page, false);
>> +			add_hugetlb_folio(h, folio, false);
>>   			h->max_huge_pages++;
>>   			spin_unlock_irq(&hugetlb_lock);
>>   		}
>> @@ -3451,7 +3451,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>>   		/* Allocation of vmemmmap failed, we can not demote page */
>>   		spin_lock_irq(&hugetlb_lock);
>>   		set_page_refcounted(page);
>> -		add_hugetlb_page(h, page, false);
>> +		add_hugetlb_folio(h, page_folio(page), false);
>>   		return rc;
>>   	}
>>   
>> -- 
>> 2.38.1
>>
