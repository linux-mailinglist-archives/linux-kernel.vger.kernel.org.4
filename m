Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D991F708323
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjERNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjERNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:47:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377AAE5C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:47:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDIc018335;
        Thu, 18 May 2023 13:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=QFORs2U+/eH0oRvdR9e9xik5pZ5iMAZKN8FXBqbRt+c=;
 b=3wMt5JHGaFWX4epxVJS+yVYQiu18UrXqwhuPfBkPUpeTZWZB1peftP2s0s6W93ut06Ay
 PJGe2+fT1PqsmDN2JRIMbzfBkl3mz5zCm/POPdySL3BYdRqa7LMQ03A070tCIZhT7pLo
 lWBGp3CcatAqyOxg19Y7Spx1COOcjqWTdupFLmuOMkBi9RVAuV+NvrvpS+fQ6Eg+kAg4
 z/uz+bjqJ9A3G2BkDc3X1AtJ+HmXjFJzdwo1F58vw1AIgzuBlfF3saBvXdzg7oRtdmav
 JOtOEa46AfQ8P++/QMTBDqYBnarorq75JUOzQbpJzl7Nq9dE5fl1/HejvpXVntTsM8O+ bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2q69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:47:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICF7dk034011;
        Thu, 18 May 2023 13:47:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1079g8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJninrE4iNHS+u8TqGpyLy12Nybuyq6Z07z3WBHx0jwcfUZqmSZhxAK0l+dLvxPEyKPlCAjCmIDAq0Yak5gVVaeO7LggPDcdWlgljFXhn1pFgqQeUyBu6ELfV02gB5toOSK/wJlQJ3whYuq9bjm8uzvRvjs8qVX5q49oIbFVC+vaFbMu1oKlBfootj2TW1DhMY9Bc/xuX0lc4f7ivEZSR+Lnms2NnY0bAzi0gvVgnJ22d558SO6Q/sfaBlI7RdkvlwpZHn/1lKER2ZvdbWA/r+m/Bd5jyX5qRmBHUD3/Uq5Yj3qtMIEjXc5NxnfdCXtsruOLkUPb28B4XqGJldxHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFORs2U+/eH0oRvdR9e9xik5pZ5iMAZKN8FXBqbRt+c=;
 b=Wh+ucR8QIsbfypgZYeaxpBUqZF2S6/qlzPIJAJ2kOw3GGTlxhpPPNCdCwVsUu1n6gKWXSlSLe61LRmxxKB7Y15s9FHGFg9qYZlLPQIPk8AdEEW3JtahF/9PPG03w4CEVfksM7aiV7wpxLTOlbDvLqsYMN81DNssm8a4ZKlg5iqrp7bS0w1iFIilHKOvWsY85/plq72FOOU1Kn9aAWeLWd9PK1l0SGk8k2dIzG3z68h2e6909dCOWNGUsJcgirng+TwkQIZuUjwU6Od7hsJ2rbWWm/MhKT1sGwh/iJFIyL0eHCTi1fJXf2Yjy//y7VXoDJ2Xa99Dq+AG07VVza9B0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFORs2U+/eH0oRvdR9e9xik5pZ5iMAZKN8FXBqbRt+c=;
 b=pWP6GEts5ObjwhplB/47Dlic2YbOc2weIzZOOY0jTphQn055n7dK58oEFj+I7HdHr5kOrBfTqusE+8AJpCbhZqbZ54eavuXsf1AKAvSLYR1Vc9YXmNyx1fXOKc9TTxHm22Pv3lrT2OJEQxsFfthDLvj+kbKAPKI1OhSwVhe/MnE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 13:47:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 13:47:07 +0000
Date:   Thu, 18 May 2023 09:47:04 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Message-ID: <20230518134704.rve5v7jvpbuko5me@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-2-zhangpeng.00@bytedance.com>
 <20230517181705.rdfffvfhqzlsjjlm@revolver>
 <d3e03ee2-284e-1e32-6273-cf21b4afcf99@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3e03ee2-284e-1e32-6273-cf21b4afcf99@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0010.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: efec00f9-505f-4731-d9b3-08db57a65eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiF6Waa4BKZEEP+1gNo5y0Z5FZRI8ohmk7e7WUFTWqMHGEWDrADR9wg450ss15pD//sHIjYQw56gQsOeLTz3PGWHm1WaQmJykgCiLhw3FVaktspytTEes2ai37HnrmjtGAPtLVX5cuFwpeNOtS6agdxnSbQ795nkxMCAdeHa0d4UsYk3VRIp+KR0p5x+dquuizZYHDuuZP6EZaRbeZ4HledGwwPwUaqwsQfCJFtZG8pnTq6jHaRL6hR9WrdExT3wS8BdyN5FpT7eyvPaZ7D0yC7Gq1RdtLH7gKI5/o1R5PjMgTLDRXWfWy/zJB2fvznj2UY/nGNTVRYVUuiaksd+zH32aprNqNYletoR5dQw/CKzfZrErWkL378S7QcUmHWVjXANSYbZtVIeqCikx/ZmSl/WFPKwtTLZsAL2QKbwy28JqRg/VodTTmvnZbVOrTW1El7hB8sDnyHt7RUGw1oUEAuBLNpxUqwLSnrOLi8rtU1cxV7ptZRhuNNRnmPTH68bH5wPI3OYpAVs4r7An7XHhdgfKiuWlMnB/DO3sLfx73ryp1rYMPdIiCz2UWNO2btL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(2906002)(478600001)(316002)(8676002)(4326008)(8936002)(41300700001)(6916009)(6486002)(66556008)(66476007)(66946007)(5660300002)(6666004)(6506007)(26005)(1076003)(9686003)(6512007)(186003)(83380400001)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1J4ckhwR1RzN3hlQ2UwK2QzdmpoSXVmYTZLQS96cXhlMFhrWTAreFRhZm1G?=
 =?utf-8?B?N0d5dHJPUVlRejNlNGZPUEJoK1d0TzNsYkdoVUp3TXZuUVBmb05MYlB3ZHJk?=
 =?utf-8?B?RVkrZmpORXpwRWViZm50WDZIbHh4OTI4OGcxVnFHVGt4ZGY0a0pPNXlYNFZP?=
 =?utf-8?B?d2xUUWZ0OHdoM0NaNDdNL0pudy8zVFllSVlIRUVEM2lEbXNQZHU3Qm1NakFu?=
 =?utf-8?B?MjFCTlBEMm5rM1NKcWZCdVljVHNFbzIxMmo2amVUUDAvazlkRkh0Z1NtZmZh?=
 =?utf-8?B?bHRPT21Xb1hiNDlscEVOUDFJYTZXTU4xWnpZcXdBSjl6YnFCMWd5ay9ZRzV4?=
 =?utf-8?B?djZXSnVTb2lML2lEbFk2WGxxK21JU2t0Z1pEUDZzWGxFN0p1NzkydmJjSzVl?=
 =?utf-8?B?cW9BRjZkLzlTUzRhemlaYS9JMEpVUkQzVTM3RDA4UHk1TVlSUXI0U2RMbXFV?=
 =?utf-8?B?M2dJRC83UTlpYjNTeVI0RjVXODdTVU9YN1FQc0xpdmtTQTQ5anFPYjhpV1Uy?=
 =?utf-8?B?cWlNK2FkMHJ3Rkl2cWxzWUtCYkY4dXNkcFBRRXMvUEp6cmhJNFo4dFRRMStB?=
 =?utf-8?B?OHFzUGJRQTZSN2ZOSjM1ZnczUnZDZDNTTktLM0psMUJsemFHSDlidWR0cmRk?=
 =?utf-8?B?T3VXcVNqODZYOHF1bTFXbHpaV20xM3JVZFErQjlGTEF4dFYrbUlQR3ZzOVBF?=
 =?utf-8?B?Smw5Rk9JWDhldnZzdU9KRmhycG1qcTZSR0YvdDlVQ2lyS0w0a0lMaGxkYjRZ?=
 =?utf-8?B?U29mcHNyZmE5eHJ2aWx1Tm96c0JQU1d3c2JKMi9NbVF1ek84dUxDQmJQZ1F0?=
 =?utf-8?B?aEp3aExKbzZnbTgyKzh6d0ZQNVdBUEpkd1dUM2RvUkNaMjVpRFlWa1NkMzlN?=
 =?utf-8?B?K0pocUNtbmlUQUhhM0Y2YWhDZFBpNkJ2UmJjMWlwS1F3VW9uUGhqa01OakE0?=
 =?utf-8?B?M1V5N0luV1NoL3JGekhteitHMmhFRkdseXhrSW1OaFhVT0xxQ090RGF2NmRU?=
 =?utf-8?B?L2pBV1EwK1A2ZmRwMjhlcVUvazhScXBwTjhOa1BBNXFHWGdYUlhjWFNIUDRG?=
 =?utf-8?B?WkYwbStLSG11MmZWcjN3VXhvVFVEZ3pNb1FxcWVJdmlmUGoxTi8wUGxqVjJD?=
 =?utf-8?B?YndrV2lKT3FZdENlcTc3eHk0T3lESHltSStVMlZ5RGxIbU1Oa1pzZWNRY2F1?=
 =?utf-8?B?bDBxc1c1YW4xNFUreDE4dWszOXRvMW4xSVhvUDBDTVBFRU95dThUS0wvcTZr?=
 =?utf-8?B?MFhqcy9LQnZpN0pRc1lDSXNxdWxDTVhYaFplenJhY1YyTUthUUxPYjFFWnF3?=
 =?utf-8?B?c3ZJNmJGZ1lEaktBcm5RM0RNZHJJUGZmR2hBUHprU1dVUkNXOEJ3T0JrVHlW?=
 =?utf-8?B?QzJuMGpMbUlKL09wMVRyejVzUGE2WHY1aTNqa2ZGTTZhQW1LZGNENEdpNGti?=
 =?utf-8?B?WXFDUTRwNi9VYkEwQlU5b0ZCeDR6aGZCcjI4amhiSXgyTEpjOXJxbnpSTldW?=
 =?utf-8?B?TUJXR3hrNitXV1B5UFdHTFcxQVFwd09FQTFiTnpXNWpaNk00eDNJK3Z6VExs?=
 =?utf-8?B?VWtaaGUyb1RwZVZhcTNXUTh5MGRoS25mQ29iOGFIOTB6VUMraTlONTBMN1RC?=
 =?utf-8?B?SzlwcUdiZ1FBWlFhUjZVTGtnbit6ZEFiajJnZ2pNL0VBWWNTMnR6R0V1VHBk?=
 =?utf-8?B?QWF2Ukt3UHBiaUFMUC9sQ1ZRODdhdGdwUG50cU1DeWNSMUZxaExXUC92MTdq?=
 =?utf-8?B?MzFvMys5UWxxQ1B5L1NJdkhDUTh0MDgzcXNBT2U2cGlmbXJ4Zmljc0dUYVNW?=
 =?utf-8?B?dllTc3ZsQWtFMFl3b29aN1ZKNTU3bktjeWtZeGRVZDBvY3dETzVHSHM1dkh2?=
 =?utf-8?B?ZHZ2Rm5GZjZ5ZGVlU0tpcUF1QXpuZ0NHNWN6dHI5aG15NWJNeFJjekJWV3lE?=
 =?utf-8?B?Z0N2aWdRa2hXVFdCNnZvM1RtTkRoUnlRbVVUSEtOQlg5YjhobmVwcy9YaGdP?=
 =?utf-8?B?b3k2dEdGYmVYK1RCbStnSEYrUVgxWmVSblJMVEFwZEl3Y2w5SG9yL0hoc2E1?=
 =?utf-8?B?ek1lV3BseVJrRm9sWGJoYi8rRUQ0bjM5VGFZeFUvM2hadWNqRUxyUUljaEh4?=
 =?utf-8?B?aDZQZEFvZ0U2VUl3MnRJQTQySDBGQ2dQeEVySVF6QmNSRlhLdFpSVUU4bWtq?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RjUxcTQrMy80MUFIaWIxSytJWmRaQlQ4Sjd3WUg3Ri9aVVl1UGo5YjBpQm9V?=
 =?utf-8?B?MGxkRjd2WDlLQ1l4a2FZTTkrUExBU2lyV1dpK0VpMmFKcitZczFaSWR4Q0hM?=
 =?utf-8?B?Yi9iQ0R5UFhzZWoxbmRadnhKTEx2cjdsNGF3aHNucXhIOEV3Qkg4Tlg5U2hL?=
 =?utf-8?B?TEpVWWQvKy90cVpZK3gzT1AzcmppV1hJZzhIZFRpMHhlN1YzTXlGaS80TWxt?=
 =?utf-8?B?Z28wRktEY09WRktDenVxczR5Tyt2MjNIa0RTRHF5THpPNmNtVDFWNDlFSDFO?=
 =?utf-8?B?N3ZjQ2pjc2NlLzRncEF4UnA5cDI1cWtXWXltbHlDKzlqbnIzYnE0N2tPMUxo?=
 =?utf-8?B?YkJSTEc4cHFFZ0p1KzhrK2RpeTlRUEQ1Z3A5b1Fab2tzQVRlbnZhSWV2Wmkz?=
 =?utf-8?B?cisxWXNkYVhGZ28wdEJzUHU3cVBxOVBkRnVQWWNxZVE4QjNCOHk2emhSTGdu?=
 =?utf-8?B?L0dwNERRcjBzZEViWi9qTGI1WGs0Y0kzMzByb0hzemg0blN1eTR5QnB0T2dt?=
 =?utf-8?B?QlZaM3FIS2lEMld0Z3FXdjFxTFZORTExRVpiajJsclpzQS9uUnovb29KZVNO?=
 =?utf-8?B?TXBNZkhvWWlxaVkzcVJUY2l6RWpQamdMVzU1Qmh4c09iWGptQjgvdE5yYmtN?=
 =?utf-8?B?ZzZ1dXg0ZmRsNHI3L3lBblNtVlFibjdEakdvdlBYNE9vWEVlejIxbWgxcS9m?=
 =?utf-8?B?STUvV3ZFeW9iNVJiMXIvQk9kM0o5RFI5Y0hacXBVSW1XYzFhR3Z5bFFuK2ha?=
 =?utf-8?B?YkxoMVVHUjVybHZ1VVVyWWJxeVJxb3pyaHNKVkdLa29MRmdSRGYwTklqMEY5?=
 =?utf-8?B?VEFpNmxRS0RzTTBsdU5kTWF6WkJOdGdOU1BhRFYrYmxNUUY0eXE5bzlMTWo2?=
 =?utf-8?B?VkVVNWJFYW0zbHQrdWxWdE5kUlpBMm9vMjRIVUxoa2FuNHU2OW1sUHJybkZN?=
 =?utf-8?B?amxCQ2RYZWVyd2piTHJ4OWw5WDlLYktyMXZYVVhHTDNuREcvUlE5K0RXQ2Yv?=
 =?utf-8?B?aDhsZ2wwT00rTVl1V1lKejBtdEdqcGJ0a0ZuUFFnWWxWeUdpK216WEdIKzV1?=
 =?utf-8?B?NUU4NXVSRE1TNW95TUpsMS9FRlBVdnBHWjB2ZjFmK0lGYllTV1prQlRwcGlk?=
 =?utf-8?B?U3QzWFJvc0lISndDbmQzWW40WExNQkxPMFR5US9INFo5T2dLazNERHJaYVBH?=
 =?utf-8?B?aTZJSFMwdmVoVzk1WDZqc0V1QlpKcFphVE9QRjRvV0Q2Rk5qMTNCbGZGVWow?=
 =?utf-8?Q?wxOtmp+ugb8ycCu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efec00f9-505f-4731-d9b3-08db57a65eb0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 13:47:07.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +at0gxyOcQ/V/3oboC5gfv3RuIVBTVZzGaZs38/iKbg//HIshlDTwp/FG8dq0zP1797EGIg4bqgGi0cnF7Maww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180109
X-Proofpoint-GUID: QtTBpm7GhqXIZNGwDAfjlgCKmsurMVRy
X-Proofpoint-ORIG-GUID: QtTBpm7GhqXIZNGwDAfjlgCKmsurMVRy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230518 02:10]:
>=20
>=20
> =E5=9C=A8 2023/5/18 02:17, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:58]:
> > > Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 63 ++++++++++++++++++++++++---------------------=
---
> > >   1 file changed, 32 insertions(+), 31 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 4eb220008f72..e1820e90f167 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6493,32 +6493,31 @@ int mtree_alloc_range(struct maple_tree *mt, =
unsigned long *startp,
> > >   {
> > >   	int ret =3D 0;
> > > -	MA_STATE(mas, mt, min, min);
> > > +	MA_STATE(mas, mt, 0, 0);
> > >   	if (!mt_is_alloc(mt))
> > >   		return -EINVAL;
> > >   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> > >   		return -EINVAL;
> > > -	if (min > max)
> > > -		return -EINVAL;
> > > -
> > > -	if (max < size)
> > > -		return -EINVAL;
> > > -
> > > -	if (!size)
> > > -		return -EINVAL;
> > > -
> > >   	mtree_lock(mt);
> > >   retry:
> > > -	mas.offset =3D 0;
> > > -	mas.index =3D min;
> > > -	mas.last =3D max - size + 1;
> > > -	ret =3D mas_alloc(&mas, entry, size, startp);
> > > -	if (mas_nomem(&mas, gfp))
> > > -		goto retry;
> > > -
> > > +	ret =3D mas_empty_area(&mas, min, max, size);
> > > +	if (!ret) {
> > > +		mas_insert(&mas, entry);
> > > +		/*
> > > +		 * mas_nomem() may release the lock, causing the allocated area
> > > +		 * to be unavailable, so try to allocate a free area again.
> > > +		 */
> > > +		if (mas_nomem(&mas, gfp))
> > > +			goto retry;
> > > +	}
> > >   	mtree_unlock(mt);
> > > +	if (!ret) {
> >=20
> > Checking for a mas_is_err() should probably be outside if (!ret)
> > statement.  If mas_insert() returns something besides ENOMEM, we will
> > not detect the error.  I'm not sure if this is possible today since thi=
s
> > should never return an -EEXISTS, but having it this way doesn't add muc=
h
> > to the overhead.
> I don't think there will be error that can't be detected here.
> In fact, there are two sources of errors:
>=20
> 1. mas_empty_area(), the error number is in the variable ret,
>    and may also be in mas->node, but ret must contain all errors.
>=20
> 2. mas_insert(), the error number is in mas->node
>=20
> When we check errors, we should first check errors from
> mas_empty_area(). If there is no error in mas_empty_area(), we
> will check errors from mas_insert().
> So, mas_is_err() is inside the if (!ret) statement, no problem here.
>=20
> Of course, even if mas_insert() returns -EEXISTS, it can be detected
> under the current encoding, because "if (!ret)" is true in this case.
> But I don't think this can happen, if it happens, it's a bug of maple
> tree.

Right, thanks.

>=20
> I don't think it's good to put mas_is_err() outside, because the error
> number stored in mas->node may come from mas_empty_area(). We should use
> the ret variable to detect the error from mas_empty_area() first.

Yeah, I would structure it as a 'goto' to undo the locking to avoid the
if (!ret) nesting, and move the unlock to just before the return:

if (ret)
	goto unlock;

...
	*startp =3D mas.index;

unlock:
	mtree_unlock(mt);
	return ret;

mas_empty_area() is an external interface and so already decodes the
error in the node using mas_is_err(), so this can be dropped completely.

I don't think holding the lock for the one extra assignment will make a
difference.

> >=20
> > > +		if (mas_is_err(&mas))
> > > +			return xa_err(mas.node);
> > > +		*startp =3D mas.index;
> > > +	}
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(mtree_alloc_range);
> > > @@ -6529,29 +6528,31 @@ int mtree_alloc_rrange(struct maple_tree *mt,=
 unsigned long *startp,
> > >   {
> > >   	int ret =3D 0;
> > > -	MA_STATE(mas, mt, min, max - size + 1);
> > > +	MA_STATE(mas, mt, 0, 0);
> > >   	if (!mt_is_alloc(mt))
> > >   		return -EINVAL;
> > >   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
> > >   		return -EINVAL;
> > > -	if (min > max)
> > > -		return -EINVAL;
> > > -
> > > -	if (max < size - 1)
> > > -		return -EINVAL;
> > > -
> > > -	if (!size)
> > > -		return -EINVAL;
> > > -
> > >   	mtree_lock(mt);
> > >   retry:
> > > -	ret =3D mas_rev_alloc(&mas, min, max, entry, size, startp);
> > > -	if (mas_nomem(&mas, gfp))
> > > -		goto retry;
> > > -
> > > +	ret =3D mas_empty_area_rev(&mas, min, max, size);
> > > +	if (!ret) {
> > > +		mas_insert(&mas, entry);
> > > +		/*
> > > +		 * mas_nomem() may release the lock, causing the allocated area
> > > +		 * to be unavailable, so try to allocate a free area again.
> > > +		 */
> > > +		if (mas_nomem(&mas, gfp))
> > > +			goto retry;
> > > +	}
> > >   	mtree_unlock(mt);
> > > +	if (!ret) {
> >=20
> > Same here.
> >=20
> > > +		if (mas_is_err(&mas))
> > > +			return xa_err(mas.node);
> > > +		*startp =3D mas.index;
> > > +	}
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(mtree_alloc_rrange);
> > > --=20
> > > 2.20.1
> > >=20
