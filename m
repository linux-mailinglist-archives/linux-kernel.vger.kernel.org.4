Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E141073B919
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFWNtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFWNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:48:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9852697
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:48:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NCcD7A012620;
        Fri, 23 Jun 2023 13:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HJENYjy8gQ6JNU69cp+F64L85qRrIeKPYmYEmN57+Dk=;
 b=wNcd3SLk/ccYw5lVN+DcKOfivl6cmMlhFXsuSb85U4AU3d799S+zK3IRCuhKQ0D+DgIL
 PBTIz1JPm2ywMmmkhNXELPam4d3T+Sp4kgmKPakAE+MWMlZPfPL+3+pIGl5o5OETssp/
 YWMcL0UxZ/uBik5nIjsJSz0JLaIj+TOmWqaVFbQvrvgyOfKsIh9mNBQ8Tv3TjnpFVWwR
 3PtQ3xwMKnCiJlyi5Au2zS5OSXC+a0RP8hP269sL5IsIIxaz7EZql9J8E4+96ZizYxdw
 T4aqSPPnlrV2WJ71AFMSzzysKCX5mhItS8yzny/VrB6EHgqIqpO95sKawKQqPELjRn3j VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938duyb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:48:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ND1pmC005891;
        Fri, 23 Jun 2023 13:48:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9398vttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WilAyWqRUycCL4MUsCvTz4hf8ZINwBnjrXdEO/mar0lBMyvs3iLOVTtf1Dskl08W9tzhPHF8sG2tZ4zYmsfTt2xy+MRRXJN7uPnL8rj9ki4JijQggRX7YkFiJ7oeJjRqvI1m6FibNyJ2Jkq+qUWFdA86Lqt8KR4W1cRF8csgkiaO9tYsO/m7hnGSaIaz2ZYfDSh5QxM8kuoSBYB979l5KfDPe7VyBGeAmnSda5P9K59Xicn7waWJWlSsFqLakxJF1S+F0Xd/j5Sw7WJJMwRvH59zaQZacJZBwZlfyeHwhu1ux4GXcfMrR900ifBb2szMS2pTZtEN8bV5DwhG9HPOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJENYjy8gQ6JNU69cp+F64L85qRrIeKPYmYEmN57+Dk=;
 b=iZ428MNna14zl9yDHYNh9ToKjOCgWjSaN6pW3v1tGer3bGUqb4oNYc5WkBlsT91iWtkJMqAfOOU75tkXrtmjtakLTt31nTbMqzY5GjEi+ybdcdqIdSxMbbC5P4VfGXtVFrSBVMsHXTEat8iBTQGJ73r6mLhNJLgAuAOJYH+WJ/WVPeNkbZ8P/EWY1wNeDWS1GzchhSuxFCzNUgPPUBXICJ19gQd99jeEH5OKdFwCcD+LHjI+iqsbA+hFJsFuvDtEABtOjsl9mIROCh4O48rOfQywe6E7ZA1Zyo+tm9SErscbiLbFJnBFqlW6Uw/SDhJ3GV5cOcW5mkpb6r0d361ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJENYjy8gQ6JNU69cp+F64L85qRrIeKPYmYEmN57+Dk=;
 b=nvof3l8DWhrVCjWKW+q4EI52sPwLambZ6rrn5FrAuctuonoLij+Sr6nznmC5vrcOMqHrnIZYNJLqf/DGVkjgOu7BH0wpsOzYyP7ugN5vX+0bOCWa43GliN2ygdbaASe4EHzXKOv+5pTeHeXRq/pRs0bPuflM0DwJnAGkrCP5neQ=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 13:48:08 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 13:48:08 +0000
Message-ID: <8deb3ffd-bdca-e85b-433a-9aeb93c00ec4@oracle.com>
Date:   Fri, 23 Jun 2023 08:48:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] FS: JFS: Fix null-ptr-deref Read in txBegin
Content-Language: en-US
To:     Immad Mir <mirimmad17@gmail.com>
Cc:     Immad Mir <mirimmad@outlook.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com" 
        <syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CY4PR1801MB1910F3DE3B29710C1D7A9226C68A9@CY4PR1801MB1910.namprd18.prod.outlook.com>
 <CY5PR12MB64551AB18AB4DB2D3F1CA5A9C65DA@CY5PR12MB6455.namprd12.prod.outlook.com>
 <a0493c88-358a-9d77-110a-18449314193b@oracle.com>
 <CAJfv2=A-b7yVtNA_T2kYyk_xK_suWrVX=gC3b+Am4LmNmvq02A@mail.gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CAJfv2=A-b7yVtNA_T2kYyk_xK_suWrVX=gC3b+Am4LmNmvq02A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:610:b1::24) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f68019-a828-4011-d721-08db73f07a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39Al/om86eIYYf4zi1M4/DYUEs2c5Pli3EgLu93aSHvuCUNOWhCEdh1UbVy+ScVtfn8LV/2E/8Mkd/OZhg6liZdtCYFuj7+tgtj0X9lvXR+sJFxBm7QbdjsCGr1Ua6aVERQ2jFEm54YPn821BuKizWosWB63i5R2h4vLsIcieOuDoF9DFCtsmUrKcIq7xxlejDu5zRhKUvEnn0R9hkA/S+8Q6biTCkfcQJSdRDk1Vkg/jblzGvgbXY86ab6hcsttUydcUm1k10mi8bl5eBGCVDO+1sXa9h0DJ6T7KwHLAx//1BbAEA5t3HcrcFfNjC87RIH3da4zCNLFhLa6AabEjTKdiAApFcuDumG/c9dEeWLhiLoL1glo46ECf5awcb9CeYf1gtf3r5aOiut3IWwwX1kZfTVP1Z6Z5dex1e8wBDIz1HYgxSJeGjydd/jol39aytLmWWx1jqx8M2st/7xOo50c1pkXA906NtGUBewWd/KIbBppiT0mwTk1egBEaxDjRcsm5ABQg5ZhEoQzF215Tt/yH06McJjNoi32xl6MdCNh3/H/SiDhEwNjQdPG2/fhTotvNLh+PzqYi58NkSI6fF1BaWYg9hOkkbAkWXr4hRAKVMTsRGgvVtoaKDSyXMGJV19OAVAiXIUz1Fsmj5dvQCCPf9CjIWShfE7u1at8NvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(66556008)(2906002)(54906003)(4326008)(316002)(44832011)(41300700001)(31686004)(66476007)(6916009)(66946007)(6666004)(478600001)(45080400002)(26005)(6486002)(5660300002)(8936002)(6506007)(186003)(6512007)(8676002)(2616005)(83380400001)(38100700002)(966005)(31696002)(86362001)(36756003)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERXUEhYN0FTaVcxa09yaUdPRE1WdU1MTGJkb0Y2cy9mdWJKc0Z6dWovTHdj?=
 =?utf-8?B?dDYxa1BoM2tyTFZHbThDN3RCTjhrOWNlVEF2U2tNZ3FMMnFERk4zbFlQS2Nl?=
 =?utf-8?B?VnpsQlVHNEdtRTBoSDJoQmdlK2dxL2R3cTl4TkNKWjdYQmRRY0VWZUNVYnl2?=
 =?utf-8?B?MjRtWkVLai8zYkxmKzdQeFdiV1pPczN3S29Ucno4d3VvV3Fsd1FNb24xMGIx?=
 =?utf-8?B?eFdaSTYwUTRFK0NJOGd1K2ltWjZvM01GN0RWVUZjVDFCcDZwa0NRczZ4RDJz?=
 =?utf-8?B?Y1AxZ3BXY3poVzZSZXR6UkFjVjQvSU9wUXNzN2cySFVBeFUycGkzVC82MllC?=
 =?utf-8?B?cHlqSnprcnpPNmJOeDFZRGpLUWlRZEx2dENZeVFLUkFVdGFTVUVHS3Qwdy82?=
 =?utf-8?B?amZ1YWwyQ2M0SmxQVnBCaXUveUh2QjcyTVRQN0J1S1lpVVFGUEpZeFQyNHFz?=
 =?utf-8?B?S1I5QXErYVF4THB2RTlGcmlKN21hbk5Ma2N2cnJway91U3BwSGxlMGhtWmRF?=
 =?utf-8?B?K3kvRTE1eUxDY1ZYTDlDZnVERHh3anozOXNtUmJ5VnJFUUxQQXdkZlR1OUQ0?=
 =?utf-8?B?V0RLVWdwTlRuTzZ5anRBdWtjV1IrTDA3RzVGYWxGd09KcExwM0pMRHZZZnds?=
 =?utf-8?B?b1F3bDBlT3BVQ2FPN2Q1NlNLdlBIczJpOXNjdnlHS0EzN2hGb1hCWFFaMGc4?=
 =?utf-8?B?N1F1bVBEMS8ya0RCT0RBbnFzajY0b2p1TDBCSkZIVEllZ1V0Mnl5bjNHNDRD?=
 =?utf-8?B?dDZLWVRvMGJpaDQ4TDRTU0RQY3FVbzZoR0J5cU1ZNWxHWnVpMDFpUXVlY1BR?=
 =?utf-8?B?b2hPU25qclgzdzRHTS9oLytJbjhxZlUyN2RKdkhkeVplK1h4V2tUaG5YYk53?=
 =?utf-8?B?QTNBTk9UcFMyQU81RDRINWJxcldjWU9MMUttRS9rYytmNGlaRTRqMjczaERS?=
 =?utf-8?B?MEFSWlpNNWwwQ3orOEF6djlRU3B1c0dpRnB4ZTdiZU5MOTJIUUtUL0F3ZVRE?=
 =?utf-8?B?Z3lYRm5ZckpOamNVQU5xa3oyRmVxRElYRTBML1djbFgxOGRpbDNuQmVXcHVw?=
 =?utf-8?B?VzErS0l2d3VCOEFOVUVFcEdVNUN5ZTlwZEljaDREQlBDSTVZcDhTaXpudUFI?=
 =?utf-8?B?eWpBRzh0bzg4ZkRPYmhWSThmMyt2bE05SGZjbE5qa2pTd1d3aXVUUzlyZ1VN?=
 =?utf-8?B?aEdIdVNxakM5N3l6OUNHZlFZa1ZPMVMyN2lUbnNzWXhIai9iSVNMVXU1Y1VU?=
 =?utf-8?B?djhHVWFramhneVdYVHM0RmxDc3hodkhDZ011QUVWRFdqT1UvTVlKTm8rcUwr?=
 =?utf-8?B?UFBtaUZPVU5JVWNGa0htSXNmYXlGRVVHNEtvUnowOWRKQVZJZEk1cnBYeVc5?=
 =?utf-8?B?V2d5d0NSeDdGTmxHOEhpdTYydGRvRk5zYjFqWGhlTHhjYXVUOXVBVytxNFFu?=
 =?utf-8?B?bEc4VUVvc0Nsd3hvenFWQUFsYWUyK2piVWlqU3NOSGN0NHNzLzUrcjB1TkVL?=
 =?utf-8?B?TlI1R01pSzQrTjl4eHluS1dMT2o1NWxJQlh0UHAyU1BQQTMyYjhZbkJQMVVK?=
 =?utf-8?B?TktYUElXME1FbEpTSTN6MFdpeDJRck5vYzZFZS9XTFNOS3FSMVppSVdDVHZZ?=
 =?utf-8?B?UU1DTmRIVnlkK0NuSTBKMC9wTnJVc1pwcVUxVGFRaUd0NUV6VWxHSFRyNTM1?=
 =?utf-8?B?dVdIeDFhQWxhVVJVYTFURVZ6UmNrRG5wY2Y0VHltb1Fydkk1TVhDYkJIOVYx?=
 =?utf-8?B?MWFlZ0NVdWZZaGZIeC9ETzVabVE4R1hTbzZvOGh1TlBISVB3UGJPRWN0ZjdD?=
 =?utf-8?B?ekJ0clphY0Q2Wi9nd2FRVEFubmxrUXZCWHROSzh1OHVCQkFhMUxWb0tIcGRR?=
 =?utf-8?B?WFkxMmxqeUcrVFFWNmZDV2JNY2RnZkkyRmdoMHdSM2NHaklOc2hLR3VBSWhF?=
 =?utf-8?B?VzNkUmdoTFZwcEhpejl3N3VaS3ZjWGpLcTNML3V6NDVBKzNkY0pEVlVVelN5?=
 =?utf-8?B?MEZEZ0lOQnZVb3NYMHhvejk2K3VPaVhVS2luUHNDbHQvdjROVVZJL0NOZEJG?=
 =?utf-8?B?YWZXUUxQMVhFQ2FsTHRnQllLTDBuRlhxSHRHMmFLc0lSVjhUS3dSZjNlbUMy?=
 =?utf-8?B?ZlQyaTJrcG44eHhGOFNBSE5yVzVwbmJBcFJiQkpLZGxnQXhKZWRSaCtJbG9M?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkIzQ0tyYWxJRFdRbXM2VEhLVGhiQnllcVZPeWlKOG15RkpySHRBaGNyNWs3?=
 =?utf-8?B?ZGFzVzRFSkYvaVpyYlNkK2NLSnVkcnovdVovOElPYituWW5UbittZk5pRGhh?=
 =?utf-8?B?bjRZYmpkMVBUY2NVZURZOWFwRkFHQzFhbjdhZTkvYWZ0cTM3YkVwK2g0elpU?=
 =?utf-8?B?cEF5Sm9yT254N043VE8zZ3E2Vk1xQldwamc2VzVSMHZPdG1TK1pqL1hBTDVL?=
 =?utf-8?B?dytyVC82RThGT1ZLTGJMVTB5TmhqMTFUVER3ZDZnNG5sTmc0TkxQTVYvU1Ft?=
 =?utf-8?B?ZjkvQ2dPNnZHVHhDOUY5UGFIMk1SYXUwZlJDcmlUYWNMTzYyWmhTL0FXSDVP?=
 =?utf-8?B?SXprSTQyRGE2eFMySjJCOUJTNlQ3cXpuUytmeTVEVElrZk44VTUzQTBuOTZ5?=
 =?utf-8?B?bCtnaDVHR1J3MkdDaXZSa05LRDAvd0w2Y25YMmwxYkZzSUNPbjl5aktoOVlP?=
 =?utf-8?B?NzVGdU0vQlN6bU9tV25LSlhzSTJsSkUwcU1jam5sSVdXS216aE0yYzJhVVJx?=
 =?utf-8?B?VHJZRXBiRW5MUXIzdDRNYVZpeWhpL1hDWk55WkorT00rNGhMVEFXZ29SMEFJ?=
 =?utf-8?B?M1hmUDBhV0o5UEs1Q05Eb0RtV2IvZk9NUXFTNGVwTitTVEFtODF0bW5PQk1m?=
 =?utf-8?B?SzlaRngzTmpEVWJ4ZUh3ZmJwWll5WVhycWwzajBDQ3FGWERBZDlxY1N2c0w0?=
 =?utf-8?B?ckltNldaNjF1RUU0ek9OdzEwejM0cyt1a01iMWpWeU9YVFEwaTR3OVZ1dFVs?=
 =?utf-8?B?cy8xT1FBQmt6RHBvOCsxTjBMQ1V2bU5nbXhaWUNrZTVjcWJRNjlnSkhHL3R6?=
 =?utf-8?B?N2c2TlpjRjEwbjVDcFpnREZMSFdyVWdWTFhRbGRlSDI3WUNkWHkxMFVHQ3l4?=
 =?utf-8?B?KzNkMkIyZFdDTXFGdThzUVU0SDhadndFQkZvSHNZc0xXQ0E2UzRKNERicHpJ?=
 =?utf-8?B?RCtVMGR2bWZCN1cwVHppd29MbWp1MHF4bHNtYmN4OVlxbGFLOVd5VXIvbjlq?=
 =?utf-8?B?Q3BBRnIzbFJXODRMWEkzcTV3MFZFRXU1SjV5VkNWU3RLcm45cUxITnRMUy9X?=
 =?utf-8?B?b2Nld0U2YURnQmViMGRrUlpRMGw4UFFvYVpDNkZ1L2xmVU9zUit4ak55L1l1?=
 =?utf-8?B?Q2h1MU9zZyt2S1NENWlxTElXdTJ3NGtya2pmcm9ldEtHWTFCQk1FcWJTWkNM?=
 =?utf-8?B?WWxHTzVoNWx4ZkJ5SkFVbEZQTGRtODF0MmJLaFFabzZQaUFhRlUrYytYVGQ1?=
 =?utf-8?B?cmE2WHI3ZzY5WUY4cy8vaTlOU0ZhM3VWZ3BkdWU2TWxaYnJPYUpRQ2g5eGZt?=
 =?utf-8?Q?QoUaGAAV6R/i7epCGYAqZo0TEwDjh0OJl7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f68019-a828-4011-d721-08db73f07a28
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:48:08.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M7Y/ONsKcMhXEprxXYujNfzGVPOZJgVs1K6ivGFpuegMiVZQUFP1U5Qdm62z+qh0qTIXYaK1OnQLQEgsaizhwTjQxXDKAeC/2vjzVGFeME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_07,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230126
X-Proofpoint-GUID: 8F0wKyi1a-WWGUCpW6VPSP6WFo9N1cHm
X-Proofpoint-ORIG-GUID: 8F0wKyi1a-WWGUCpW6VPSP6WFo9N1cHm
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

On 6/23/23 8:40AM, Immad Mir wrote:
> Thanks for the feedback. I've prepared two patches to fix the bug.
> 
>  >Does this test case attempt to remount a read-only file system as 
> read-write? I see a potential bug there.
> I'm not really sure about this.
> 
>  > Should be setting rc to an error here. I suggest -EROFS, but anything 
> is better than returning zero. Calling jfs_error() might also be in 
> order, as that would explicitly mark the file system to read-only. (The 
> default behavior at least.)
> 
> I've incorporated your suggested changes.
> 
>  > It'd be nice if we could move the check to txBegin(), but it is 
> assumed to always succeed, so there's no good error recovery there 
> without changing all of the callers. Maybe we can call jfs_error() there 
> in case we get there from another syscall.
> 
> I am not sure what to do here. I am calling jfs_error and returning 0 
> which is not what the caller would expect.

jfs_error returns void. What it does is mark the superblock dirty and 
either panics, marks sets the filesystem read-only, or does nothing 
else, depending on a mount flag which I doubt anyone uses, so the 
default action is to set it read-only. You still have to set a return 
code, etc. after calling it.

I'm sorry I wasn't more specific the first time.

> 
> Thanks,
> Immad.
> 
> 
> On Thu, Jun 22, 2023 at 8:38 PM Dave Kleikamp <dave.kleikamp@oracle.com 
> <mailto:dave.kleikamp@oracle.com>> wrote:
> 
>     On 6/20/23 10:53PM, Immad Mir wrote:
> 
>>
>>
>>     Hi. May I please request a review on this patch.
> 
>     Sorry for the delay. See below.
> 
>>
>>     Thanks,
>>     Immad
>>
>>     ------------------------------------------------------------------------
>>     *From:* mirimmad@outlook.com <mailto:mirimmad@outlook.com>
>>     <mirimmad@outlook.com> <mailto:mirimmad@outlook.com>
>>     *Sent:* Sunday, March 26, 2023 9:51:15 PM
>>     *Cc:* mirimmad@outlook.com <mailto:mirimmad@outlook.com>
>>     <mirimmad@outlook.com> <mailto:mirimmad@outlook.com>;
>>     skhan@linuxfoundation.org <mailto:skhan@linuxfoundation.org>
>>     <skhan@linuxfoundation.org> <mailto:skhan@linuxfoundation.org>;
>>     Immad Mir <mirimmad17@gmail.com> <mailto:mirimmad17@gmail.com>;
>>     syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
>>     <mailto:syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>
>>     <syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>
>>     <mailto:syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>;
>>     Dave Kleikamp <shaggy@kernel.org> <mailto:shaggy@kernel.org>;
>>     jfs-discussion@lists.sourceforge.net
>>     <mailto:jfs-discussion@lists.sourceforge.net>
>>     <jfs-discussion@lists.sourceforge.net>
>>     <mailto:jfs-discussion@lists.sourceforge.net>;
>>     linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>
>>     <linux-kernel@vger.kernel.org> <mailto:linux-kernel@vger.kernel.org>
>>     *Subject:* [PATCH] FS: JFS: Fix null-ptr-deref Read in txBegin
>>
>>     From: Immad Mir <mirimmad17@gmail.com> <mailto:mirimmad17@gmail.com>
>>
>>     syzkaller reported the following issue:
>>
>>     BUG: KASAN: null-ptr-deref in instrument_atomic_read
>>     include/linux/instrumented.h:72 [inline]
>>     BUG: KASAN: null-ptr-deref in _test_bit
>>     include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>>     BUG: KASAN: null-ptr-deref in txBegin+0x131/0x6c0
>>     fs/jfs/jfs_txnmgr.c:366
>>     Read of size 8 at addr 0000000000000040 by task syz-executor.0/5098
>>
>>     CPU: 0 PID: 5098 Comm: syz-executor.0 Not tainted
>>     6.3.0-rc3-syzkaller-00005-g7d31677bb7b1 #0
>>     Hardware name: Google Compute Engine/Google Compute Engine, BIOS
>>     Google 03/02/2023
>>     Call Trace:
>>      <TASK>
>>      __dump_stack lib/dump_stack.c:88 [inline]
>>      dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>>      print_report+0xe6/0x540 mm/kasan/report.c:433
>>      kasan_report+0x176/0x1b0 mm/kasan/report.c:536
>>      kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
>>      instrument_atomic_read include/linux/instrumented.h:72 [inline]
>>      _test_bit
>>     include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>>      txBegin+0x131/0x6c0 fs/jfs/jfs_txnmgr.c:366
>>      jfs_link+0x1ac/0x5e0 fs/jfs/namei.c:802
>>      vfs_link+0x4ed/0x680 fs/namei.c:4522
>>      do_linkat+0x5cc/0x9e0 fs/namei.c:4593
>>      __do_sys_linkat fs/namei.c:4621 [inline]
>>      __se_sys_linkat fs/namei.c:4618 [inline]
>>      __x64_sys_linkat+0xdd/0xf0 fs/namei.c:4618
>>      do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>      do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>      entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>>     The issue can be resolved by checking whethere "log"
>>     for a given superblock exists in the jfs_link function
>>     before beginning a transaction.
> 
>     I'm not sure how we got here. log should only be null if the file
>     system is mounted read-only. Does this test case attempt to remount
>     a read-only file system as read-write? I see a potential bug there.
> 
>>
>>     Tested with syzbot.
>>     Reported-by: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
>>     <mailto:syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com>
>>     Link:
>>     https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3 <https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3>
>>
>>     Signed-off-by: Immad Mir <mirimmad17@gmail.com>
>>     <mailto:mirimmad17@gmail.com>
>>     ---
>>      fs/jfs/namei.c | 2 ++
>>      1 file changed, 2 insertions(+)
>>
>>     diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
>>     index b29d68b5e..cd43b68e2 100644
>>     --- a/fs/jfs/namei.c
>>     +++ b/fs/jfs/namei.c
>>     @@ -799,6 +799,8 @@ static int jfs_link(struct dentry *old_dentry,
>>              if (rc)
>>                      goto out;
>>
>>     +       if (!(JFS_SBI(ip->i_sb)->log))
>>     +               goto out;
> 
>     Should be setting rc to an error here. I suggest -EROFS, but
>     anything is better than returning zero. Calling jfs_error() might
>     also be in order, as that would explicitly mark the file system to
>     read-only. (The default behavior at least.)
> 
>>              tid = txBegin(ip->i_sb, 0);
>     It'd be nice if we could move the check to txBegin(), but it is
>     assumed to always succeed, so there's no good error recovery there
>     without changing all of the callers. Maybe we can call jfs_error()
>     there in case we get there from another syscall.
>>
>>     mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
>>     --
>>     2.40.0
>>
>>
