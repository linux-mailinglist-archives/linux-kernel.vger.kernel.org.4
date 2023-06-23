Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAED73B923
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFWNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjFWNwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:52:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA082688
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:52:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ND6Qvh031306;
        Fri, 23 Jun 2023 13:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SHhfGuDgRruAnoJht4BuUY6q9qNEGHKsRhw4r+ty19k=;
 b=upgddBwaOzvI/qRxta383/EUZt7E4A/2d4IpK4/27ZvUnLkbVld8eFCjKpnuOIgxkGlF
 +6c+sW9uAPifVJCxyJrURRPsuTXdbLxuo5VGbqAsjw6XlEokRqjWR4o708EK/mx//p10
 8J0mMkm8O11wOUXhjSP4q/1d4ikKHyT9u+ULKuXsynIJqeGKlyKIGxlbFSLOZzEYuKKN
 lALQGHwd4vzXQ8MNhSeyHLqDz4E3ZFwtTurn33IAxR+BfWmabZzuIxGXddus+dZGrlsF
 UgGvQZwWDq0tXPrL990LlGzYHBoASLutDmYBeKUEQOAHCAgHMs8kZMzbVY1oXAhJK09U uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etv62a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:51:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NC5S6S033034;
        Fri, 23 Jun 2023 13:51:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r939a2fmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbMJtBg1k2ksd4A0JyyAVfVkY6hiVk0LtGVaSBs64s6h4BgQUp8OYz6uhgKFXXCeSaa6YXWu1/H7XH9oitbLles8CGIfhrGqj3uz9E5kkGOgBOHsSEM8CoOoxgH1NafJg6J3ae/8+PkHLXZ74Qbjr5Nx37EPI8z0sHpX5jOdBDHF9EVm0AySNNwB9B9D55DMvji5ZKShIprNPWbYRoVaHoLG1TsVov3ZKRopY+Lp1L/dKLAqjG1JmhUaRT7YyGdreCjM5GLkdkYiLWNrHWgHdsIpleTX/LsUa5qDb9QW1NxxGsZZgltXyGkBavNRQSRkJfGvutAWcVXoHPO36UGdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHhfGuDgRruAnoJht4BuUY6q9qNEGHKsRhw4r+ty19k=;
 b=Ue+jb/tQCCZSIswnHpVHoAbw+sjzZ6U5xAuz8yZqBWRP3qikH/9ClU7irrds3LvzkHbVfCWIg7bD5CYuIu7fI/YJtiNUhz+ZdZPYGcDuX4rmAosAi0TzqAb4vJzT6GYekvSZZ/FQXs6Lftw1naMw4Nbzv2IvwDQk1hbNcirGGGKzsc1ik9cgvdA8bXM/CZDFqqYDg/oke9qJSdPCsrGpib6O3HzqKGZqh8u2qE1fgaG5j28zw2wgbYGjUotzbxgbpBmw5z3jrLRBL+XV4qsEe6k7w9rasQlH/AqnL9qr0PApGYeTr10R+PLfS1FdrDk2DQcryIEVXY0JJdRbXVbQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHhfGuDgRruAnoJht4BuUY6q9qNEGHKsRhw4r+ty19k=;
 b=Jr0rDGcTnG9knRyqKuPMgWZftmjgD9fH2RTzleogTyubc1+/X0YGK0OaErE3TY/M7d+RwpzwghHZKYIhXIv84EmeuDFTRXMcYW4ekUpwMT3zd3mqbZ3+xedLKdc7g4khk82DkgmssMPIV02XWMEcnSAJ7Ed0cXC4JN3f1t3ivHI=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 13:51:42 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 13:51:42 +0000
Message-ID: <3e3e6234-5c29-b3ca-c499-6fdbf611f62c@oracle.com>
Date:   Fri, 23 Jun 2023 08:51:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] FS: JFS: Fix null-ptr-deref Read in txBegin
Content-Language: en-US
To:     mirimmad@outlook.com
Cc:     Immad Mir <mirimmad17@gmail.com>,
        syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CY4PR1801MB1910F3DE3B29710C1D7A9226C68A9@CY4PR1801MB1910.namprd18.prod.outlook.com>
 <CY5PR12MB6455B012A589AE5A29C52146C623A@CY5PR12MB6455.namprd12.prod.outlook.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CY5PR12MB6455B012A589AE5A29C52146C623A@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:610:4d::16) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b02f48-f3e3-4b7f-84f9-08db73f0f996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baJDlg8Qr9PjMwK0dfpKSWUskK6yHmCdPXcVZpHOPfVkgXuSohR6HUfpI3ZdlM0thR1vrThOvKk20+R58wTgY7jxoPXFgk/c6vuYZTSw3UVQqDKlEi7u0mLjHXKhwSHLEWw6h6OqLQPvdPukBY1uZu9SnqlJT1nfYQNFl1LRgo0csEf/hXk++o9kKLBpjgxUdv42z9SrHyTpgrHSgvqS+Rya1CQp3eAue2iRF/Gq2krrRdfoF8Dp5WllN6uBpCcSlsvFDqkRMwSJEuCWoglPI0/VbM3hrlxwJkRBGWqReX4c4OSlvCd+0YSvyiU6osAvnO5jZGSAjY6gJqh+4kdMZ51XE0mrEmSTLgO0MYnQscNXemEpaw+EoorLPPOHWYbQ249BthCxlAlgsODthZEq0mks1/5T+FC2MZ0c1eYe2H0WuSCRjzmridi2U9dPUBzU+igbxMrHVh537KkKs5oWbhL09bqBChlqI9ym2hrwjkZrsVbYc0Zwb51V2XTdcctzTYthr8uXIrdyG2g8Gf3ZvIPLnElT3PW/tSrs9KrBlpN3ep0BQixPBLudgL3GKJagGm/sLxPf/sS4HTaeYlq3t1pAq33oJ+Yfx+72pTzI3szjUgzZQRLfUFkWtLTdC8RIjh1G/yv9WW0jQ1J2B8xCjthLhsQers439rpzWJnmhdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(54906003)(478600001)(45080400002)(6512007)(26005)(6506007)(6666004)(966005)(6486002)(44832011)(5660300002)(2906002)(36756003)(66476007)(66946007)(66556008)(6916009)(4326008)(31696002)(86362001)(8936002)(8676002)(41300700001)(316002)(83380400001)(31686004)(38100700002)(2616005)(186003)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpUczhDYjEzcHQxVjVtUXZPVHZMSHBRV2tHeUlTajM5SkVGMUdicUk2eWx1?=
 =?utf-8?B?eW5jZVlNd1pSRHNRb2p5emF0QjVWcDNuL0FPOWRYNHRhRGxsVnh5ZitwbnJX?=
 =?utf-8?B?VFY1N2FEUEt5OG5PVmtLUFNqdHRUcWl5OG9IMDZrTFJQb25vcFVyZ2U0Wk9E?=
 =?utf-8?B?MTN0VlU5K0h0WFFmMUtlUk1iRFN6ekw5Y1NQQzVjVy93d1NOODJQbXZ2dDNJ?=
 =?utf-8?B?b1VPbjJvVDJRbXNxdk9LMzZnbWR3OFBvTE1xcmJQV2JRdWNaNDR4YncyQW1H?=
 =?utf-8?B?NE5qVk50TGFRZ05CN0c5NGZQL2h3RkgwMWdxTmVaaWFOcWVWTGNEV01hVkla?=
 =?utf-8?B?RE1kNElad1RuUDVIOW02RzY1UklzQ2pvRk5VczVrSk4vck80WkxWRE5IcWU4?=
 =?utf-8?B?bW8zMjMzc3RBNlNEbmprcnhUazNwbnFpd1NoditzcHBIaGR1L09rOVNFNHI5?=
 =?utf-8?B?SFkxTDU5enBTUHVpWHIrejRBQ3RwWUlmQTdqcDY2Zk5DdEZBMldzRzhxcUJY?=
 =?utf-8?B?Y2JxcEFpamJna2I0NjQ0L1dvQk81MzdxQUxZRWdUNno0dG5wYVN5UzNUclBI?=
 =?utf-8?B?THFWZDJ1ZGo4MmREV3lQMEZqck1HNXpTVGw3YTJiejdlTXk0MlNMclZjZy80?=
 =?utf-8?B?MlR3eGtVYVJ0TkhTQnFkTlZ0U1ZVeDRteCtPdGpFVWl6Yk01L3hGRUljeFZD?=
 =?utf-8?B?b0ZlT2dwenkvVGtLWWpSL3QyWE9GRW5ibkRuaVI4MWVrYUV4RWllYUZkZ2Jn?=
 =?utf-8?B?OXVzRG9oTnhsTFFYdWsrL3puTEpZZHBncVFHaHMvQy92UHJlNHJPL1FGQVZt?=
 =?utf-8?B?MTZCaHJIeWgyVEROTVBLVjRBbFFPVUJGVEZqZlNsTlR3a005dWpzZWpvMnBi?=
 =?utf-8?B?SlJLZUxZOXo4UzRXRVNEZExDd0MxWFQzUHkyT0ZUWDdTYXFkYXlvL3cyMHcx?=
 =?utf-8?B?TTdnSWt1c2hsSGJFQnlITGE0QlgzTGFuOFRvQU4xNXphbnQ1dVVYS1psQVFT?=
 =?utf-8?B?bmR0cDZ2MzFsRUQ0ZndkMEpGNnQ4ZTNtQXpESXJwai9UbWRuSVprWGJNYkpK?=
 =?utf-8?B?UDNxbFZ2VGptbFJ0RTRRbmg3RUlsMlY5M3l1NjFZdTlEcmphSjh3Wk5xODB6?=
 =?utf-8?B?bHlIaDVHeFVZT240Q2RYaUEvSlRLaktKNi9SRUlFRnRQdWEyZlVOQVBRMlVo?=
 =?utf-8?B?Mjcya0hlWkZBSW5nQk9LNzFrc3dmeWdzc2wrOUd5N0Fobjd1OExwMzJzT3ly?=
 =?utf-8?B?ZVEyWDlWVENDeWlhV3VaL0RhZVFmeUZMUzMyenJqVlhtQVNzSTN2eG44UER5?=
 =?utf-8?B?c3JNMnNlR2ZvcFMxVGdiT1VrK3NmUWZSU0RPdnBxWENWYktLc2o1d1hDcUpX?=
 =?utf-8?B?ajhucnRpaUNEM1lsRkwrN0VzNUJHWE85MUhvT1BpbWpaSEUwb1lzaUYxeEI1?=
 =?utf-8?B?eGd3WmJwYTdESGZZQjFORjVCVVlrM21iZG44dFBwOVB2UE45TWtMOVptcWl6?=
 =?utf-8?B?VnhESW9JQ2VZUGdtZFAvU1ZmSU5tNDVCZWdZL1JzY1JNWmc1WGxnY1kwV2Fo?=
 =?utf-8?B?ZHMwZFhYUkZqZEhPT2pHa3FjbHl1a1Q3NmVWMVZiNHNIdVhvdTBOeEhhTkNv?=
 =?utf-8?B?cVAxbFJ4MkJJQmovUllUYkJ3dUdOSUFDVlM5NkY5L0RwMVlBUzVIdHRmd042?=
 =?utf-8?B?NTR5amhDUUgrWWU0VzNGbS9oOW9RTGxOY1pUQ0RiYTB1cHRQejFTVUFTY05P?=
 =?utf-8?B?alJzcEo4YytJQWJWZUNUQkRaenJJc0ZINFluVldlRHluaCtEZUFjNlhWQW5P?=
 =?utf-8?B?eDRsaG54dTFpQ1BZT0lXenVEWWxacnd5OGc3OHZJQ2hkRC9zeEJmR2tneHox?=
 =?utf-8?B?eHdZUTEwa3NOOW04eWVoMFFPOUhkbnpBUldlTWl4ZllXRzJESjZHZ3A2OXF6?=
 =?utf-8?B?azVadDVuRTBCRnljWVkxM202aXU0NVFOcUJDMlF0L21kbzl5OXIvbmxhYlFn?=
 =?utf-8?B?ZVI1MHRnREErcWNhdEg3T0cyWk5nOWVGMTdyblFlcTBpbHorS05taU56bkty?=
 =?utf-8?B?MXpFL3k1UWE4eTdmRzBDbXZRMVR3UmQwcjFzM213KzJHb0liK09XWnVnY3Fi?=
 =?utf-8?B?VkdXdnkrVVRlM2dMRE1raVpkd3hTRGdDaXAvMjJHWC9aSVorY3FScDY0L3d1?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c2RxU2E3S2p2K284bnM4YVduOHVjVDV4NDBKZ3pYRHBtZzNibTB6eld4RTZ6?=
 =?utf-8?B?L2JrZVBqcnRrVDZJN25VQlhmUThkUzcxeFFSRVhpalFQcXEwODlOekxBRDhr?=
 =?utf-8?B?K3hKQ2o5T3lvbkt4cnNETVRBZTI0U3dScnE2N3dUQ2lVVlBjUVY2UmJ2K2xv?=
 =?utf-8?B?MG0wV2YzejlBN1RHbE5CVU5NTWFnbnRjV1I1QVdyNnR5eDlmNHFvUW1jRURH?=
 =?utf-8?B?S0E2N0pGdW9YbzY4QjVtVjMxdkJYTng5bzUxUm9Vc2NTaUtxYjF5UHlDR3JV?=
 =?utf-8?B?NGJjWXRYeStmVVYwOUVtS0dWenh0K2ozbEpwa09ra2dVei9Pd1lsY3FFRHMw?=
 =?utf-8?B?Q0hybitkazg2SGY3Y3cwc0Rpcm5HQ3ZDMkdLWTl5a2c1WHJGMVZNL2ZPdkF3?=
 =?utf-8?B?T28rZXVPalAxTXpHZG1Ba1ZaMXlOVGxwSHJKOEh5elBMWmtPNkVEVkRua3VW?=
 =?utf-8?B?Qzg2WHdIYkVDc3hwZHM5RTd4bE1VODNwQ2RWQ1NialRrYmNuSjhMRUhkbTJY?=
 =?utf-8?B?NEZML2htRTFodkkxR1ZodWhNU1lCNWZua2VLc25LVzVDR3NlTFBlVUNHNkFO?=
 =?utf-8?B?eTYvaU9aSmcxR1IvRGV6Y2FRVVU2cGJhZU9xSWl2WU5SY2J2NlFhUU5ta3ZL?=
 =?utf-8?B?WjlkNHd5dkJ0NlhpWkVwL0VZT1pEbGZqWnMxWUpuRnlyd0x3WEtIZzl2V0c1?=
 =?utf-8?B?VUwrU2xHcmwvTU42Z0IxRlNkckRDUndNWjBXU1h2YXYrSlB3aG5sY00vT0Zz?=
 =?utf-8?B?K1E2WGQxcmE0RXBhZmpzQWtUUzlkN05RbXRBMEhLS3hINHNFQWk2RmY4Z3px?=
 =?utf-8?B?YTlyVjlReXo1eWNLbXRiN0hmQis5RHVaaUVEMzJmblptY21pNGxEakJrVFFK?=
 =?utf-8?B?STJVcm02WlJ2dTZZRWpITE1DNnVvUHQrSkdCNG55ZUJuMGRxWFBHMW1PcFRx?=
 =?utf-8?B?ZncyZjJWdC9CQ2lwUkJBT3BxZWFFM2tVUkZ3QW9TbU8yRncvTE1PN2ZCMGdk?=
 =?utf-8?B?Rmp6bi9MRERCNzVaM2xpNDZoQVJEbXNuK2xtUjZTMGRFUXJ1VSs5RExKRXVh?=
 =?utf-8?B?ODFhUTQzMUJLRWpkR05nTXdKSzBmRHJxOGxtcFcyc1QxQ0NtUUNKQXRuLzk2?=
 =?utf-8?B?OFNGQ1A5VEZmbDVnVUl5d09raE5yakRJTHlVNE1HTVg5REY3UkorZVN0VkJI?=
 =?utf-8?B?Q3IxOFJlVWFZNWZTVTMxN0RtTHB3Y1NDOE02OUhKUG9kN25jdlgzS3NES3Er?=
 =?utf-8?B?TGR2NmhvcEd5QU1FN25WamJlK3Y0LzRTektaWGhyYTJVRVd5Nit4TitsRE9G?=
 =?utf-8?Q?EgMhSPJKw2+ng=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b02f48-f3e3-4b7f-84f9-08db73f0f996
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:51:42.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roI2p+IitOKpC496ff0156rJX8rVJuizSdOOLZyBLZsyka20vJO5xdS4LmfWtO0BtT2fh+VAzR7/meK1aZJYxS0ztS//uZziUD/2NmYwDf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=989 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230126
X-Proofpoint-GUID: FBVUM7qPNJwbWuWQBUwOnnj9ioyWStAg
X-Proofpoint-ORIG-GUID: FBVUM7qPNJwbWuWQBUwOnnj9ioyWStAg
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 8:44AM, mirimmad@outlook.com wrote:
> From: Immad Mir <mirimmad17@gmail.com>
> 
>   Syzkaller reported an issue where txBegin may be called
>   on a superblock in a read-only mounted filesystem which leads
>   to NULL pointer deref. This could be solved by checking if
>   the filesystem is read-only before calling txBegin, and returning
>   with appropiate error code.

Looks good. I'm going to change it to just an if clause without the else 
and push it to jfs-next.

Thanks,
> 
> Reported-By: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3
> 
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>   fs/jfs/namei.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index b29d68b5e..12e95431c 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -798,8 +798,13 @@ static int jfs_link(struct dentry *old_dentry,
>   	rc = dquot_initialize(dir);
>   	if (rc)
>   		goto out;
> -
> -	tid = txBegin(ip->i_sb, 0);
> +	if (!isReadOnly(ip)) {
> +		tid = txBegin(ip->i_sb, 0);
> +	} else {
> +		jfs_error(ip->i_sb, "read-only filesystem\n");
> +		rc = -EROFS;
> +		goto out;
> +	}
> 
>   	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
>   	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
> --
> 2.40.0
> 
