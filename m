Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4147117F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjEYUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjEYUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:15:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0209B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:15:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PJmuFm022017;
        Thu, 25 May 2023 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GIIyLrYzYHjBDAd9Fq3BY8uTGDf8OS2rdvmqn2xHuJE=;
 b=W4Jevnv0tqsoMw6CrQ5KthNaR2eG/0cP952zQKnmQdusyhzvpbDazhADKBH1P875wMlx
 qyqAvu9fJqARf6HuSPFxCUwR5PX0h6/ZcP9YtOJTjzkvjIu51Gj7mGe+avkF3r4SFKMB
 169Meg63Bd+VTILu0y7uVPh0aAC+akiJ6ZBEM8KaoZfauJPXbqLfHV0fVdun/hqmRzHp
 7w9Sor7kvYyeKmbGsTh6ZKxeR16AAGhGGWFcwZEBzP+SPC1DHnX0jTnLgiwVuCFyIXio
 W3qIWZvI++30mnGR9ZsZ8d7/3e8tFLLTcUn4zLu96PQh/Lkn18O7aJ18c2q72gya4rmz Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtdta02rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 20:15:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34PJ5QW9013502;
        Thu, 25 May 2023 20:15:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7j4s0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 20:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNIxzCH50reJ5VAiemRPUdrGYo+DQYraQbtgBwK/PxnbqTJL2sFVVLzUxbzJQO0ZWrZIdUmXU37xhiUxZ7ny+iNNkTiZIpxgwjkI6ZZfqUXRjpLRSyzdSsM84qveDc3s9F0sWsvwIws7GEC4HpWoIJLU6CLGwSXUvd27So6/wpV7kAlLkoAkay6DBvoQfwq1zB0avfHztjeP0LUb4M9CsUp8+Tz1M7MyDAPmjLO78vkd5nnI6E5xyfWfsccIlY7wFSzXCKMYX+IFgR89e74VCEA5w49LOmyi8m4Jsvg63uVFnSifuwlfc12zHc+Weo+uBuzkgoQNBVC2kvI4lzPrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIIyLrYzYHjBDAd9Fq3BY8uTGDf8OS2rdvmqn2xHuJE=;
 b=N75oAHbyFFBg8qPJGolTMy+9B2zyDjwPt3XW8yJavyk2b7MixNQ9Dod7gqVkkxZY41oyxu9TvbCJewVcS2ZhS0LldZP+9Ps4oWbj7vusGuKUCipUO/x1QrHVAkfiFegEfKj1a6b5qFSphA44U2OgOSy7dRp5fEmC155s5zPfROXJpfnCwhviEjW94V9LmgQVo1WL9xaKfjS5w6xO8WOI9byXBXgT9NTSumwwvlcHo+dHjWs4CPNNIZkmojugrM/lMI9j11LQd+l++gty/mZ9jh8SIMs3NNPauWz3xGCDtR/SbtsOTfLk3tR6oGOmdsbVskMPsqL4wAi08aa/pt5mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIIyLrYzYHjBDAd9Fq3BY8uTGDf8OS2rdvmqn2xHuJE=;
 b=GjEAv13x3KgM0xxkQcSbInMHLofup+nEpYrs8jUjk1RVrSxPyY9mLHA7jSbyi9MrtfIZKU582DgapDPCYXRdpccITOuWTP/DdS2NVou4tff3W1AjPYhas06XgO/XpX3r7pKIctbl6JQrlXdM8CwQkAA8Oe2Wp8rMxMTllk9PDr4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 20:15:12 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::7361:8416:8d4c:7733]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::7361:8416:8d4c:7733%3]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 20:15:12 +0000
Message-ID: <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
Date:   Thu, 25 May 2023 16:15:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZG+99h3zg7POIits@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c25658-6566-47b4-ffb2-08db5d5cbefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHaEtoKLyBVYArHvYV4HfFAF/ovZLuV4gFvxjxejgo+8YxtMHcLxfrxawfKFD9UQDCfWbTqNzCzoA/oTtah+x6RPR+KBsh8g459Ooqt1p8t2a1LReFZv5poTMX8Smf57M20iRGMPPfKIkmu42OrPiQRzLkPhPTNZGe8ywJ4e5noai5ynUd0YN5zBXHeZLJZMP/5qVqLQJ9WpEl4FHpIKaoa3yV6cznISJcc6E1ayrXuzcukEduTfQifaGsmWeAIrttBv8EeHka4VWVkEZoiZtX/42/C2iy4hHBbpXsNGxzh9FEcwliTde2rSeCGcjHdbyNAd8AsG1sUlyX8fZ4acOOHpPSlFcx7gYKi4EENvaSYNxHGSeiTZRPvIawYj45gzbp80zX4/hfPklqWVj6BIafqtvfMNMbCihXpvdv+d2rK0sOhy1QVH6lb9gOM9VpXLHEG/tdHgJOUgBggMHR3AplJN+QhFolSllzk5IWfMrHLjuZ7uW96JocZP6BFIxOxUJnX4LhK6lj/M3FV2H0qNjMTGcszM9AUdFSXP+jqJjKmIcWP1yZuBHr2mb0uWm+VCIXV45H+098WVWc8x82JndReM8ZutZ46pv/oyCfQaWRkERMEgb64sqyB5K9ocAkGKSYjrSSyvy4zKIvBa5j5sCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(2616005)(83380400001)(2906002)(186003)(36756003)(86362001)(31696002)(38100700002)(6666004)(316002)(36916002)(6486002)(8936002)(41300700001)(8676002)(5660300002)(31686004)(478600001)(110136005)(66946007)(66476007)(66556008)(6636002)(4326008)(6512007)(6506007)(53546011)(26005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdyZ215Uzc2OVBHN2xWNXlaQm5aNUgvSURaU3FzYjNkOGJPeDdoM3RoajVZ?=
 =?utf-8?B?bmJDV3p0Skh2Qm5PMzBPVlZZVE53M1J1ZGllT1dPMW81YTNVbGs4M3BjakFo?=
 =?utf-8?B?M1RWTmh0WGFuODZCYjlpOVdZYjZjd3Z3TXFsemc0L1ZHTnlBOEE4ZVM3WExU?=
 =?utf-8?B?MUx3a3RXQ2NRNzlWNmNDcDArMm1FbGtaYlh5eGp5eHd5d1M5Y3J6eTdMNWJ4?=
 =?utf-8?B?aU5GSFFLTmErWk9PeHNLT3BwQjRYc0E0dTQzUDRlQVRWckMzTnhLMyt5cjhl?=
 =?utf-8?B?UXpIWWVYVXdUQnA0RWhWWnNXZDFxN0I5Vm41c3RWVVVvOElzWmNUeEVYOTRF?=
 =?utf-8?B?eUlUQVV1SHZObFdxRVFlMXBaS1Jld0xPNDdObjBuUHZUWkpmYVN2L2pOcHUw?=
 =?utf-8?B?RTJOOHNHbThLME5HUVFuUTF2c1liTm9memNwY2lseXpXRGhBOG40eXpNQTIy?=
 =?utf-8?B?NWNyQXdQNkYxSHM1UjFYN3YzeGZBeUJCU2hjb3hTMS9tZVFGRVNpdXN5U1lE?=
 =?utf-8?B?dDhRSzF2VTNkei9pZHhteGFCbWpkV0duMHFYMVlxK3lsTWZuUW9UOFZycEJm?=
 =?utf-8?B?TE9lNDg0VW9QZWdyaDdmQlNSMXEvcnJkSWc1TnZ3L1NSQkgvcytJYmNsN01D?=
 =?utf-8?B?MTd6TndJVnFTYVRYeUJVazlad251KzRJOW9pLzg5aE94eXdRR0tDbTA0b042?=
 =?utf-8?B?UE1YQ2xlYXVaWFNyekRkNnNxSitLMlpJVW1QVHI4Qnozdmd6UDVYV090Q3Nm?=
 =?utf-8?B?MWVKVFZzMkdHdVIzMS8xQ2FtZFpLcTNFUlg0TzcwOVRuZStkZEt5MVpPMWkr?=
 =?utf-8?B?U0RGMUFqOTlnSlNreThuWTl0eVpMQ3luSGVTQk1JR1hJUnVmWnFRVU9ncHpY?=
 =?utf-8?B?Vi8rQXFtelJTeDFZL1k0QnB3ci93TkFYMldUa0U2UHNOVjBmKzZQZ1VUQU53?=
 =?utf-8?B?eDIxc2tWTE9IUjVpenE0eUNuYUJBTFlEYmhNSUdKWkY3dElkZGhyT0dYL25O?=
 =?utf-8?B?WmV6ODJIcHFTa0s1cjFsQlVkMklSMVVHYVZhVzRDK1VMbGY2YjViNDBMQ2Rw?=
 =?utf-8?B?U2k2RzZ0amZrcEVxeEhjZHNuclV1QXBiTXFQK1JRcWluejNuS1o3QTA2akdX?=
 =?utf-8?B?RlJPSkNxNjgybmU2TGpBV0h3VzU2blp4WEJWbGNnZkszUFdyTDFjNFM5eHFD?=
 =?utf-8?B?Mi9NakZvRHZxdDUwbENpTVFIZGNUNnl5UEJBbGxxTUU3bGt3Vml0UFl1YkEr?=
 =?utf-8?B?UVFHMnIvVGtPMjF4OHh4b3R2V21lRmpzd1dKNzFyMHRhY2ZsWkZINldsbXd6?=
 =?utf-8?B?T2xubk4xOUNXMzFjRmUza3VlT2Y4N3Z4Z2hwOU1lNm03MWxFaUlsN3VHS3Nh?=
 =?utf-8?B?eEJSWjJxZ2JuUHdWYThyRFI1MW5naW1iS2ZOME9XWms5dng0WncxSVk1RXNE?=
 =?utf-8?B?Ym1BQkgzaDdkcXl3dzBFZXpBbHgzWmkzamdQa0ozYWR3MnBTa1BoeDJtdGli?=
 =?utf-8?B?MEZwVWlQZTNrVm45WVR2cTY3bU1uZ093R29ZUGZqeW0wUm9CVXFQVE10d2lH?=
 =?utf-8?B?UjlEaUhSNHlaVWxvM3JiK0pjbnlXK0FXSHBROVRtMTF6eWs3eHEwUnlYQ2dC?=
 =?utf-8?B?Z3hwZWpwQkkxVmw2Yll5VitZbHVKYXR6L2RuZEZhV2dkZVJIV3lIYTdOa1U0?=
 =?utf-8?B?TjlSU1ZvTlQ5ZU1Sc2ZJT1IvOUZiQnI1aG1uNHZjS09oSlk2WWVHV2ZueHpC?=
 =?utf-8?B?YlVnZFJFNk1jUDZFMnNBbUZuTHhmdjFBWmNjN3VyU0Z4bjR3b1VpS1E5eWVp?=
 =?utf-8?B?Y2tiOU5jNURLL0VJb1FOSTdHM1daZnZxeURtMjdDVTFQb2tpWkNmQ0hjaG4v?=
 =?utf-8?B?VkY3ZzcvRkpidnNIMVh1aUJZWTlJbHNSSnU2UUlVZ1lhZ0pvZTR3eGZqZlRT?=
 =?utf-8?B?VENiSEFvbEVCSUJVdTF4OTZhU0NTRzNyczhNbldETllEeTNCWUhKSmwvVVdl?=
 =?utf-8?B?cThhT2hqeGJhQ1BHYlRKM0tYL2U0L2NmNDhad3JQUVljNHdHalgyVzltcjU0?=
 =?utf-8?B?N29WbFhUVkFETWdlSTllWmNwZ2ZhU0tmeFZyb3pFemI0aEtSb1VBQ2N6TTZM?=
 =?utf-8?B?eFo2RDJCN3VEUUlTMDlLc1BlMm9HQUsrZ284STBxRlErTmF5Q3BsS1E4d3ds?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TnUvanI5TGNuY2UySGhocUFjZmtyMVRrdmpRb1ZHOVZhVzFpZklCbEJzcDVX?=
 =?utf-8?B?c09oNjNnWWhzbGV4NS9PU2RkaVJKdWJIOXJEUCtoVnpGNC9xWXRZd2FTTTly?=
 =?utf-8?B?R0NwZzBqd1loRFl4djFMZzhSMnFkNE1UUHI5eXNJZUFYMzV0bnpYdzN6UDUv?=
 =?utf-8?B?S2dFRHhLSkdvNm1iWU12OHFMemkzWWdVZEVxYURQSkIrMVMrMlpBRGFERzNU?=
 =?utf-8?B?RWl0ZXMvS2g1czBMNU5WaVdrekNxNjIxMmlHT2U5a2tTOXduRldhTlN2ek9r?=
 =?utf-8?B?SWo2d2pLdFlEVGY2aFh6ZnBSN3owYmZUaFdHOEN2L05FbHJRSExBQjhzeEZh?=
 =?utf-8?B?RmYwTVp5Sk9jQ2tlaWJpRERJbkozSnI5cStrYTBqK1BWdEw0RWxhQ1ZsZzJs?=
 =?utf-8?B?QUplYzg5dWI3TENEVWhjdGNzZUZWdm5EZ210dThsWFp5eXJzRUZMdVViQjZ6?=
 =?utf-8?B?QlpTdTIwT1VpdmRCa1NoV0xkR2p0Si9TcHpiLyttcTMwRTU3VTZPK0tQY2Vr?=
 =?utf-8?B?d0xMTHRadG5Fb3VFaFFMWFA0MmhxWnQ1RDVzZGZHNjJMUS9GWkh6N1BZVFQx?=
 =?utf-8?B?d1hVMndXSGRmaTlaaHAxWUd4dm5BS2Z4Mlk2WnNBelBmMm1VN0RZREZTUmkw?=
 =?utf-8?B?TmVvbXMxY29nV1pkTjd0K3c4cEFKRjlOZUNORUQ4aFYxMFlrVEVtUnl4TFQz?=
 =?utf-8?B?bzNKcTQxL1ZCS3M2VzNzN29TWWl2TDdBY0s3ZWk0ZnROOEdSQzdvbThKWVpi?=
 =?utf-8?B?TkZJMU1OOHh1TjdBMlNhclRPK003MXE0WkFJVmRDOGVuWnY1QjJmTUdjRzBB?=
 =?utf-8?B?SW1VcmpQV0dHNlFGMWxpcU9OdWE1MjhJUDB3ZUFXb1RFQ0JPeWhmK3dZWmlt?=
 =?utf-8?B?WGduejJBMFgrZUJNRVlhTXVFelhhWm1VN3REc2VtaHR5NWpqN3cxWXMzNTRJ?=
 =?utf-8?B?cWlDS1FvY01PRmIvUDNycG85YVI2ZkY3dGNxVlByRlF0WEY1NXVReCtJT1Rs?=
 =?utf-8?B?VmhiUmJGVE1vc3RDK20ybjI2cFpNR1B5d1hZSUF4Y0J3VzUyRTdtMjZSSUZM?=
 =?utf-8?B?eHVXZmxuZWNJTHJBaHdoSmNFZEpuRUZxSnhsV0ZuamZwMTM4eUp3Ymt6c3hY?=
 =?utf-8?B?SDh0RVYwRmZ2azI2ZkE0TVdqWStXTlQ0YXpCMEk0WW5MUCtxU2Fjb01waDVy?=
 =?utf-8?B?ektYM3ZqSmIrWVhVN0xadWtYRVlZMXFNY2U5UjJaTFFUU0dDaE5GcG5RMlRL?=
 =?utf-8?B?QmZ4bmxDcEt6MHZINTBlNWMrQWFab1lySEhLUjFzOFNsVTlGYStQbDhRYXB1?=
 =?utf-8?B?dmlmcGxFL2gyUXlweGgrVjI3enh2YXYwS01DalJLMDFYbGxUcEpTK1IvMmNk?=
 =?utf-8?B?MThoTVFDekszekdMZUljRExXTDFCRHpKeExvR1NZbzJqSnorR0dpbHIyTG92?=
 =?utf-8?Q?sBWqNbQ2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c25658-6566-47b4-ffb2-08db5d5cbefb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:15:12.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCrJVDmEXUVP76r1EI/2z5Qy+KxSboCz9AUzCexfxAiyctQkjyHQkGrelmQ45DARVcNE9XuIlCRj3d8ykb5H0b5hQHR8GJ05Chydc3jBfZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=927 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250171
X-Proofpoint-ORIG-GUID: eD2U0SMkSR6UfKdUWcyVJ_2s6hszAsp9
X-Proofpoint-GUID: eD2U0SMkSR6UfKdUWcyVJ_2s6hszAsp9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2023 3:58 PM, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 01:15:07PM -0600, Khalid Aziz wrote:
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..b548e05f0349 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,42 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>  	return too_many;
>>  }
>>  
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it has extra refcounts that will prevent it from being migrated.
>> + * This code is inspired by similar code in migrate_vma_check_page(),
>> + * can_split_folio() and folio_migrate_mapping()
>> + */
>> +static inline bool page_has_extra_refs(struct page *page,
>> +					struct address_space *mapping)
>> +{
>> +	unsigned long extra_refs;
>> +	struct folio *folio;
>> +
>> +	/*
>> +	 * Skip this check for pages in ZONE_MOVABLE or MIGRATE_CMA
>> +	 * pages that can not be long term pinned
>> +	 */
>> +	if (is_zone_movable_page(page) || is_migrate_cma_page(page))
>> +		return false;
>> +
>> +	folio = page_folio(page);
>> +
>> +	/*
>> +	 * caller holds a ref already from get_page_unless_zero()
>> +	 * which is accounted for in folio_expected_refs()
>> +	 */
>> +	extra_refs = folio_expected_refs(mapping, folio);
>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page is pinned and can not be migrated
>> +	 */
>> +	if ((folio_ref_count(folio) - extra_refs) > folio_mapcount(folio))
>> +		return true;
>> +	return false;
>> +}
>> +
>>  /**
>>   * isolate_migratepages_block() - isolate all migrate-able pages within
>>   *				  a single pageblock
>> @@ -992,12 +1028,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>  			goto isolate_fail;
> 
> Just out of shot, we have ...
> 
>                 if (unlikely(!get_page_unless_zero(page)))
> 
> This is the perfect opportunity to use folio_get_nontail_page() instead.
> You get back the folio without having to cast the pointer yourself
> or call page_folio().  Now you can use a folio throughout your new
> function, saving a call to compound_head().
> 
> For a followup patch, everything in this loop below this point can use
> the folio ... that's quite a lot of change.
> 
>>  		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * Migration will fail if a page has extra refcounts
>> +		 * from long term pinning preventing it from migrating,
>> +		 * so avoid taking lru_lock and isolating it unnecessarily.
>>  		 */
> 
> Isn't "long term pinning" the wrong description of the problem?  Long term
> pins suggest to me FOLL_LONGTERM.  I think this is simple short term
> pins that we care about here.

vfio pins are held for a long time - Steve
