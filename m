Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF865E25A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAEBNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjAEBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:13:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C841CFD1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:13:41 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304MEVHO007265;
        Thu, 5 Jan 2023 01:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z+3cWr7FUmTYrPWI8rttb9/xkE28us8oHU92fAimrhA=;
 b=vag7rdzZ+MPsJR0KJupR/bGxj7RO2Twso1sY8voLnMViqJJBpzcru2P+EzRGZe7N9OJk
 kTsnM3jnLBRtEUJGEobS+etXm13RStn7lNcnxJk6L/xoOJOVxJWb5LlEGpXvBm/L/v16
 kQ8pSuZjHmC++wdkDnp43eJCImm72dpLXL56iXOU79TPgWIu3K934miAWN/71FqR71gm
 Qp4QZDswx0OaD3+rHSqeyJxlk3G8asSVYiJxE/o3gujOM1CDh/heU+63kefKGyKgjRcM
 ilLb7DrxAUyrJJUzbTb0/cKwoskBoFAIG4udgJNtsU0oH2yRyUVQjqQhYsH9jqyaRCEr /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0aqx3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 01:12:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304NrLUE031439;
        Thu, 5 Jan 2023 01:12:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtrf1h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 01:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB33Fu/fzJCwEemMRZTNQHfYMUpWRjZR674YnyOxyF/7bUu8JPdi+gIuK44RtgAgwhfqZHKOuIRC5mByhCdFUVTIrHLJSNAQv7e082G1SD4nX6/TgkIVuxgbaLvU5twDCmk8vlCyEl1bUDLfIZc3aIZRXljNXQFAWkOYb5smBh4Q+wc+o8QICqbUHTw3GyAw/RfBY/nFFRgE3vDuSCVhtD2TcArpgHpCiGcrBdsXOV0SwkXF935Gi7oAYyqD7j6GRj0oqs9ibKRD2bauAp9h+Zywrrnm7G1v9lwCm2RjGSaaEe7OoZef7KsABUO+ydNDtuw1QSbFbACaueIvsQhpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+3cWr7FUmTYrPWI8rttb9/xkE28us8oHU92fAimrhA=;
 b=oH0ych7oKzkO5Sb3vAMwr0yX/uOQ90cZrborDYSZGwuyLIvG7si1eOeVK8rt60nI36P8wMj0EkrQd/ZK8IVBWFQY2Q5/MPOea3LJNjK9N8se/D/h6XWwI5eWUF0rvy2A1UZ0vcHSYpeN3DXYFvHXsAXHdSLSSCN7M4nRm9HspegsOwbW8rKiSTNhkL0SoDp/+0Kzy5hiAesEunrpmSx9mOHlf8FAur9O3+NELVLRkcMpe7LZon7l5TTcnhB/mfJmZ9KMFze40AZ99EAIjM88dUpqvLBuZGHgwO7/RnVZmWpM+TMyQywQW0RJDWLmI/7eaPw//6rAhGz0lf/O7xGGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+3cWr7FUmTYrPWI8rttb9/xkE28us8oHU92fAimrhA=;
 b=UmZeDmU76kvkHUHGW6rlWCaJR+LbGKvCi9kDb2qqbCsowzqukfxe8BVlpnDC174tEDpwhUZK49G0CRM1Df09CftAsasEnL/yZbCyzcwtOd+1x7DFXi2SE9enJ5hNa8vKOzBEO0cyJShQ7T4WfsPEWm5Kt5TOXyqz6+12JFsOO00=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH3PR10MB7306.namprd10.prod.outlook.com (2603:10b6:610:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:12:37 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a560:b9e2:c8f6:b074]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a560:b9e2:c8f6:b074%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:12:37 +0000
Message-ID: <f9f271b6-9888-7e92-8054-f48a9ca3e233@oracle.com>
Date:   Wed, 4 Jan 2023 17:12:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com>
 <d5760f7f-5985-1962-1c89-f32eb743985c@oracle.com>
In-Reply-To: <d5760f7f-5985-1962-1c89-f32eb743985c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH3PR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b04d32-377f-4633-b00a-08daeeb9eec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dADabJ/ASXsWPApO/CbDxiywjFtc3uhdgbQTQ3FoG6GAbTXMfvSJrtFn+L5saWrUyg5Kbo1HEtPXcJhdgucO28SjzF2NYUzjPkL5vYKOxsWl1duHFvkHCib4rrcbyHt7FHbWggUGdt5ysA6YDQALo9FXIAqc1hJkNI3ygbgJwRYq2lPPUMGCMP3XotLyQIalkmiUi3uiz0+d8XVeu2yLduIcv/hDvTMnaP/F8h1J2tVEfKJrxgtQhyuzq4eg8xxM9rlNbEWdVlJ9JxPusn/9tvrFjuOy36YJY9tlCyUXG4NZnNm45Nhtl8zy6nHayPLHy2ThO9KkpCHS+fp+B4HM5FO3rS/+TW4K+RqmHVChD4Z/kx/8NRXL/TttGt7caM5nSNYM4i1qp/K0KI5cJmFMXEVUmAk1afnzvAxKSTR3dWjL6Da9NqHaThneUSwEXW1oPlzfUdyC9KFswEpYxctRTw9NIgnyvGFMXJfflfxOyfKEZESV6eykF40OaQM/B40kSJ0lTbLhaFdfV+m5iEzuMrlqcalyVPgQYLG7tg+GvCfn/XwbVjX4+g1QtXToX0GG/kB84s9tjvap6Q1VoBQBTqp8MyCuEXmtEd3DjaFjBcbiZuVGuAnWPJ7Eb0Bl5vP41o9OHMzPtI3p4N7+pZtX2F1TT+1KDA/Xq/IQfZVUYTL4qGeifbTwSeSXy6YV0Io76r2cb5LoZV8yjMULzZn1iQsTnlH3rYx8Jyn5kamjMq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(5660300002)(7416002)(4326008)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(8936002)(44832011)(110136005)(54906003)(2906002)(6666004)(6506007)(478600001)(6486002)(6512007)(26005)(186003)(53546011)(31686004)(31696002)(86362001)(2616005)(83380400001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlovcHpvZWR1SU9Xa3JrWVJDeVVlYjJZSUJ6SzhaM3RXUGtLSk4zanNsQnpX?=
 =?utf-8?B?eEFJdU1WZDlWMFRhNUtRb3crUWZrMlhpa25MalVIMXc2U1A2aDAwa3A2dXJL?=
 =?utf-8?B?dSt0YWU0Ym9FSS83Vk1McWxrd0NxR0czbmVHN2Y0UGM2SGZFSncyUFRlM1Mw?=
 =?utf-8?B?ZE5sMnhvSTEvRGU3K21tVmJRYjh2bXFtK0FScWhjeGZod2ZnNW45aGdhZjY3?=
 =?utf-8?B?MEV1K2ozVWcvSFdRWGpmZXhGL2k5UHN5bWU3QzZLRmZnNzJZTWE5QncrWmRJ?=
 =?utf-8?B?STZsYU5ZdWZnTHRCSm0xb3dSM0t6RlBwZHArV0dJZUQwS0ZES2pxcmxxQ3gz?=
 =?utf-8?B?S0xKWmJBcXJ4bVl3S0VibFJtTjc0S2U1NWpEaVpvQ2VGR2hudThIRmhwMjRS?=
 =?utf-8?B?UWVqMTVuOXBra1Nobk50Tkx2ZU8xWi9JOHQ2RC9HQ2ZPYkJENTBTSTVhNUFL?=
 =?utf-8?B?WHJHRUo2OUpnV1FpR1orN1hlUndWYkR2Y0VpNFk2SjhjQ3BwQ3hiOWxGQWMv?=
 =?utf-8?B?NjBUVmwyUHprSjhYUmlYNGkybHpoYTFzV1JUMnQvcGhkZURjMXRjUE5MdUFz?=
 =?utf-8?B?akE4Nk05NFFrbWRKRHVYSDEzaEZqUDZjMlNaOUR6WnBJNC9DeVBVVDlGTkRN?=
 =?utf-8?B?RERIR0xUamhyL3FXbk5YU3orZzg4bU1WeVp6MW9hWm51TzMrT2hmdkVESTc0?=
 =?utf-8?B?OXpBOGFuRmd2bEZESlJOQVgyVjZlZEZucHlXdEFyaGdRaWdmYldiS0orMGN1?=
 =?utf-8?B?KzVjT05ORFpwaTc5ZlVnbmw5R1htS0lrTWl4WXB3Tk1QVVNteEVQcUd6OHFH?=
 =?utf-8?B?b0RoOSt3UnFpT3VjSTlXV2UrUk84c3FkaVN5OUh4bnMrb0tIY0R0Yjh3MVhS?=
 =?utf-8?B?TzZIZTJ1Z3VKckdxOHNKSkZkdnVxR213ZURzNCsvRmJRdmV3YjRTU2pWVmFj?=
 =?utf-8?B?MEpwZmQ5aUgvVDdjaEhBamJTenRWOXBRL21LY3oyRnlmMlZEb1hVRGkrM0Zw?=
 =?utf-8?B?UmdiNG4zSW45VFk4UnM2amE5cFFMcFdmNmpTUElMWTl0TWNpREFqNHgweXJJ?=
 =?utf-8?B?RlRxL3dwdWNLQ2VGTFZyOENFcnFZTjRPLzkva1hET3l1WTByR1NZb1g1LzhL?=
 =?utf-8?B?cDE0dzQ2anZObkErNjgwZCtCWmhWSXZhamprY25qWjg5dHdlM0tEbVlTRm5t?=
 =?utf-8?B?WGI0aUYxQ09nME5wUnNBM0NNUXlvbnIzMDkvK0ZEdUE3RS95NWoydUZzb1pV?=
 =?utf-8?B?UkFNU0t0TUdvdy9BeDZpdmZwd2F5ZjF5allZMTFQUVdPRzlCUmMxOVNCZnJD?=
 =?utf-8?B?eTBEbHU5andXWHJzSlJNcjhGbjJZMjRxMFk4QUxYWituaDdtekZSTXBVRHEx?=
 =?utf-8?B?OWFyYTdHd3d5YUZNd0p1K3FIYUNDQnR2elNSb0tMRmJTQXFqQjNjZnM4ZTRo?=
 =?utf-8?B?RjNueFY2OGVoTVE0RkZHbFF6d0N5aitRT2d3cjBBSXlzY3h5Z3VpWUQ4cWtt?=
 =?utf-8?B?NmNUajgyNVBOSGVNZHdxM3pZWDFnSHZYVUc5QXZSUVVYMjlhb0Y4YzRxUFhU?=
 =?utf-8?B?dmdEQnM0NnlRZWwxVm1lVE05VloyZEIzejV2ZkdmdWJUV3d3OHVLM05ka1da?=
 =?utf-8?B?a1lLWjF2L1RaMXRMd0FpZHhuN011SnpzYnU1bVV0cG90dFI5WU9LclJydlNp?=
 =?utf-8?B?VkVKeFkyLzgvdGFJZkhyZ25tUktLSkdjRVlFNk9yY1UydXVhQVhBelAvNVVP?=
 =?utf-8?B?aXc4V05uckVwZVFMR2dEQjBjMG5Nb01vMGlnTWxoSlJZc3ZZbHNTNTJKaTZS?=
 =?utf-8?B?K2VuaEFsYXVlWlUrSmhxaHJRcng3YkpBOG1UalVDeHhCU0xrZlFmU3JBbXF6?=
 =?utf-8?B?bU5KZ0Z5V1dRQ3hhbVczSU5RMElFZWl5K3c1ZWtTTGxzL1VuSnlFZHhlQ3RM?=
 =?utf-8?B?OU5SRVZVcGNZbnBKa2V0cDl5ZjBlZm5FQ0pYTkdBMWtSNUFLSU5NVmU2WlA3?=
 =?utf-8?B?cHZzS2hmRnY3cjA2RXUvM3I1eTdxc0xEQ3VEbW5ucWhpbTZKcVNKbTRTTy9h?=
 =?utf-8?B?ZmQ4TUNGNFhWeHMvMUdEdnhVZC9tY0ZONVR2TDRaK250Y1B0LytHak9jL1NT?=
 =?utf-8?Q?3cyqadgh5Tb7NIOFrDC43/fs/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RlhGTjFmeWgvTzBMRUxRQnEzd1FZWVRMNlhkalhPS2cyd3JBT0hhcVcvUTQ5?=
 =?utf-8?B?emtkMkxnRWRnQlRtRmZhQnRQTVY5YWNSWkQrTFNjVnE5aVUzRWllWXRuRy9y?=
 =?utf-8?B?TG56Y2RNTHc2NkpIZHVVNlE5emZqSWpLOUxxeHcweERhc0Y5NWh5OElvZDZG?=
 =?utf-8?B?Z3RoQ2lKd1BQZXBYczByd2Q5bW5QTGJ0ckRWa1JFZjBKamswOWpCWkFTU3pV?=
 =?utf-8?B?a2Zva212WStETXgwSno2RUk5QUVrOWRKeEhLaFc5eUVqV1kvWlFvWnhFLzNT?=
 =?utf-8?B?TmhkaHkvQkQ3bnMvNXBuLzN1YUcxdFZtZk1tRFBSZjkzNUw0VXQ4bnJNTHR4?=
 =?utf-8?B?bitkRDNKSm9LaTg3ZWlKcVZ4ZE9jdWZHS3ZSS080bzNwd1Ivdy9XSTZFdHE4?=
 =?utf-8?B?U0JHSUlYTkJrc3BrU3B0Y1FtSlBLakNWYnpYNGhyQlhYWGg0SmlhVFdVaGpB?=
 =?utf-8?B?QnMxWFAvbEtUb1dhdjVEbldPdTU2RkNhWFhtN25HZ2kyZWtFa3VONFF1b2Vl?=
 =?utf-8?B?YWhQOE9FWndab1lJQ0dJWHNQdFQrQythTkN4SnJ6UHZ3OGMrZzVubDJLR09B?=
 =?utf-8?B?RFRodzBRSnZlYjRza3JLZy91L2V6Zk96Znc2MUlUdU9lNFZET1MxN01UUjRm?=
 =?utf-8?B?UkVNbDBwZjhVeXdDUFFaTFlvWXc1N2ltQVY0VENIM2JCekhDcCtqTDhtdUlt?=
 =?utf-8?B?b3d1UUtCNnMvVzRISTBvamwzZkNVSVhwK3gvLzBEZU9wbDZpT29BU3N4K0pL?=
 =?utf-8?B?RFIrZWlLSFlXcjFWcS9RenJiMmNER2JGTDRwck5XY2NheDNiZ2NpaFZOemxF?=
 =?utf-8?B?SnVxaHZsb3EwQXVLbDFtSWNZWkpiVnozQlAxU2xRME43dWN3b0RpRGVsb2Nv?=
 =?utf-8?B?Y1RCa3k0L3dUdS95TEg1K094T3lBWlBGdXdkN1VYRnV3a1J4QjRXaTVNZVk3?=
 =?utf-8?B?eVlKR2N6N2FISzFTUktZOFFUc0RBekl5dmF6M0djU2UzZVppU2JJaGpNak5y?=
 =?utf-8?B?bXIvV3FXbG44Y2prWnRJT3hjRnhlbHlzWEE1UFVpN2piaVNuWmtBdW5Qbmo2?=
 =?utf-8?B?S1p2N3daem1qU1RObXRpWHNtTUdLRU1RbE0zZENxckVOZG9aNVFkR3dSa3E0?=
 =?utf-8?B?VCtxNE9SWGRGMFErdW4yVHFqR1AvOFpOLzB3bGVicXA0bjhyMXNXUVZadXJn?=
 =?utf-8?B?YSs4VzJBME5DcStnNE9VR1oyWnhGQllxbXZ4R29SZ092U1VSWExOcVJ3UDNP?=
 =?utf-8?B?VjlJTG41RnZZZWlUSUVUL3dzRkdDMlZNcnVVeEZZdEQ3UG5SWitsdkRXL3dt?=
 =?utf-8?B?RUNvZWFuZlNLKzM5ZkZwOU4vdkFQMVJXNStJYnhSN1NoNDg4aFpkcDIvbVBG?=
 =?utf-8?B?NG1xdEN6SGZ6RjBIZmJHNW1pRFQxOWRuSHdzTnFJZXhaUnhLN3RHbzRQalJu?=
 =?utf-8?B?Q2M4ejVzOW43ZUJka3h2RVl5N0xvWXV5YmtRQWJiRVdMdmpQb0RmVEUxUWJa?=
 =?utf-8?B?aXg0UVdZLzFrd05MNndnbHFhNDRmT3BtVTVOUFdIVnFVTDNCVWNYR2VaaDhF?=
 =?utf-8?B?c3R1VW9vMVEvQVdCVnpJN0E5Ky80S2RqSnJ1YlNsMVl2bW9mNFlxdUllMmdQ?=
 =?utf-8?B?NGV2YWtpTXV2ZHhXLzg5M0k1TnNXcmptODFRTFAxdmQ0TlFaY05JMkdwOVhn?=
 =?utf-8?B?dldpTnI1Zlc5SGd1d2EvNzRzVkxGSk5acDRNZ3NMbS9vSGd1V1FBVzdiY3Vo?=
 =?utf-8?Q?N2oWf24ERZjATgpcaEzumVS22EP/AXwSeTHQjAy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b04d32-377f-4633-b00a-08daeeb9eec4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 01:12:37.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 030g65gIf4EqeIH8HPZKaxlMm+fzA76REokVG6JPisiJ/AsQw3DvxAjhRG35wOX9JhINo7I0VLLsEcU6wPkKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050007
X-Proofpoint-GUID: -3BrEx9vC5img15GuBxKzHD1S52dmmuZ
X-Proofpoint-ORIG-GUID: -3BrEx9vC5img15GuBxKzHD1S52dmmuZ
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2023 4:57 PM, Jane Chu wrote:
>> + * @stop_at_none determines what we do when we encounter an empty 
>> PTE. If true,
>> + * we return that PTE. If false and @sz is less than the current 
>> PTE's size,
>> + * we make that PTE point to the next level down, going until @sz is 
>> the same
>> + * as our current PTE.
> [..]
>> +int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
>> +             struct hugetlb_pte *hpte, unsigned long addr,
>> +             unsigned long sz, bool stop_at_none)
>> +{

Also here below, the way 'stop_at_none' is used when HGM isn't enabled
is puzzling.  Could you elaborate please?

+	if (!hugetlb_hgm_enabled(vma)) {
+		if (stop_at_none)
+			return 0;
+		return sz == huge_page_size(hstate_vma(vma)) ? 0 : -EINVAL;
+	}

> [..]
>> +    while (hugetlb_pte_size(hpte) > sz && !ret) {
>> +        pte = huge_ptep_get(hpte->ptep);
>> +        if (!pte_present(pte)) {
>> +            if (stop_at_none)
>> +                return 0;
>> +            if (unlikely(!huge_pte_none(pte)))
>> +                return -EEXIST;
> 
> If 'stop_at_none' means settling down on the just encountered empty PTE,
> should the above two "if" clauses switch order?  I thought Peter has
> raised this question too, but I'm not seeing a response.
> 
> Regards,
> -jane
> 
> 
>> +        } else if (hugetlb_pte_present_leaf(hpte, pte))
>> +            return 0;
>> +        ret = hugetlb_walk_step(mm, hpte, addr, sz);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
> 
> 

thanks,
-jane
