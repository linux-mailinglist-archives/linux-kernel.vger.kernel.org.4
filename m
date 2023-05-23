Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384770E6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEWUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:55:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B68E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:55:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NJEW44032499;
        Tue, 23 May 2023 20:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rH9bEubFxQMVnd24o4GL/ukWFay1AK9Lqru0pNx/Gx0=;
 b=TC65ZqQzJHkgT0yVUxydIi7eB/xqh8/Z6pxgMVfjjcY5kZM2ozvaqwbMxsQE0vigThQl
 Sm2udPNo2LXcti4QTc8Kpj0DgOEa/KgDovN+KWYBWRxuAH/zAbRcHaVgUCMNWL7wfMIj
 R898JCFUt3HlLXR1qVUtZ576vIM9F/BNSHU1qtstOA6o7fgnyk0A8jPRT18d3jtXNBgO
 d29XlK5sXc/bYTZvZYIxsodiXcFUtIg9zNIBRAJAXCILpbmev0dXEWSjgbncoHrpM1kx
 TcT9a0559XhJLK3EQPYv6HqhOOyksN6ZTpVG34+9+GrjJNQew13PpsiP4ZrIiR1yHVcU ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qp83e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 20:54:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NJULAA028906;
        Tue, 23 May 2023 20:54:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2bcjk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 20:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN/Fuk+aoDzbEuSUiwD4+vHe5ATGfH1P3JoJuFbZ9jpzOM2TjNEHzO4GWBJCE3ByLlS6ybmnIxdWB4N9PR2JDwreJ0WC1KTR2N2DDCuojRHShzP3Vl/cxAjKJRIh45QEkCtq6XBxtalbDAqvhuHBpO3BPOayc5TfuJdNfme3V5h49Qavw5gqXKMoDggJFrdjvTK4F9suczYbuEWP3DiqqNfteBFy9avgCEPf+yOxcMTv2LNx8LD/CF/DO4vJ0uvppy1hIWwVbdbrQz6LJ1U+tde0KIRD9XZX+l0IgMsHpBXhJn2qp+NbqeAVObgX0AFECKGIq+e5ibeVL3pSRu0C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH9bEubFxQMVnd24o4GL/ukWFay1AK9Lqru0pNx/Gx0=;
 b=A73zWifwOmhoCZCrGyzV5aGq7oSuP+b1ypTCFWLe3Zv04XXZptxZ/5AEUZPSNgbs7RtR95Jwmrgs7etRUmA7kD62lzSRRxAzRu0Sn3ktF1yJbZ/NMsYAJhpzzCTQ7auLkEDBA28sMoqHsD9sdxHkhow0rzlLT7Voeu6bHDqnWXPGio6wEdHk/bLpg1hnOF98P6QBIiHRsBFxMZrvdANgJqaEHc9Djss9yUQ7RUr0ILjVNnjJQEtR4QxdMsMSODp3mHVOZx7fbi+ZN3lTXu9oHk/CGGW4f5qn7ZGkyRoI+VF1UKDNnY8XaRw9vPOnPv7dRWivZ3aC7ke9WobvVZKQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH9bEubFxQMVnd24o4GL/ukWFay1AK9Lqru0pNx/Gx0=;
 b=aFDPgzCnN+GSKTf3L/FTM5GUntCgIWnV6vjnwWyhX7k6Pt/kmtvzbga4Rkutj+6DnUByiq68BH3V/j8m/9hg2EahZO0Z7h+JSwZw4augZ5jXFcWyCXETrcjzziI50UdQb5Ql+FOMr9lq7QK3cKxWK1+d6Tt17Tzqk0p33iCdQBg=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 20:54:33 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 20:54:32 +0000
Message-ID: <42b050da-38b1-2244-6a9a-0320d5e7d2c4@oracle.com>
Date:   Tue, 23 May 2023 14:54:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     willy@infradead.org, steven.sistare@oracle.com,
        ying.huang@intel.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
 <4453e142-f2c5-7016-acc0-3c861b8d0a0d@linux.alibaba.com>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <4453e142-f2c5-7016-acc0-3c861b8d0a0d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DM6PR10MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: b7124b2b-b0f3-4ee8-4dfe-08db5bcfe8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg2//jZGoZgkpv9KmIjwBBohVJhPM1cRAVqhEcFUvynZ+XOv1KSk0EUtzICcPPPcRs8t9oPxPORQEE8nTrhZbEt7FrEQ6SHbE8CNcLgLJqPHYL2YCv0CqMZuSSdyU7v9Xro9YuPxFbeGLqcW3aFeqLK/g1ilMQikeFAxhsFpf+Aeg2cWce4BJPN0p6sfM5hz9bEVzXKiV+YtjYZUcr+eZ0Lxnttz7CAryIBCAl32TQC0We3Y2dHcTO/GklbYzTJ0fcYSQdFONVghBFVjSTkrzNwl4TOY5wz5ZY+HmDPIAnNGPm0XyEoqju71u5OxNPQggj7o2MSOy295upD0C3dUyFzaLuSq/F2nkLTqUwyHggOgzjWxRTR7lENDyccRk4J7K4aXKVFM9epTLBEbCTKX45+zY3/5Tm/qbYUjDREpZpQGE3fEcHZVmZQX/FubJeac231zKGTrgar0eVN9rv39d9QjGn3K+SzFYfDeDbGp/vxTJkKNyv1kRD7Jcu+P+mECT02RPhUgeseyOit43BLnB7YUR+3cp5PA3k5rN5mz0TjLQwTDZOLE7aLRZFIiQuD/Ha2my2s2UQE4HJLpVSZT55YVmcO2Uw45q07NI9Zgn+RVXUEzQtTWU127zomv97pRgcpRkhmY36TMGB6MtY4VMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8676002)(8936002)(86362001)(31696002)(44832011)(53546011)(6506007)(26005)(6512007)(83380400001)(36756003)(2906002)(2616005)(186003)(5660300002)(66946007)(66556008)(66476007)(31686004)(4326008)(316002)(478600001)(38100700002)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZvSmtoeDJOQ0s2L3Y2ZGNUeDJuSDVVTmRWYjFJTzNDZVNLYklzenI2ZGtP?=
 =?utf-8?B?alJvRVNyMDFXUnNVV051WGwyK2MxcUZCeVJ6Ylg3RVluM0pSb0FWNmY5YXM2?=
 =?utf-8?B?K1o0YzFNM3JTZmhKN0pxSmhJS2lTclpWZ1BEdGxIVE5adWdRL0FuNVlXQWdO?=
 =?utf-8?B?UDIvQitZSnRRNXIrNThwRG5tQmJGaDluMjc5cEQ1RFJXbVdUeGRuakI0ZGEw?=
 =?utf-8?B?RG5rMjJGZTBNcXlJL0xLV1Ewc1lYdUs2ZGxmS0Q1aU84bmpmU0pGN2grVkVp?=
 =?utf-8?B?b3ZGaXV6ZmVBQTU1S0twZW5uMzJxKzA0R2FlZGNoRmQrM2RpendEK3luWW1U?=
 =?utf-8?B?aDAxakJCSUdYK0FyQnlVWmJ1WGdtQVBOTnlSZkZkQjJocG1lbEVPRmFyWUg2?=
 =?utf-8?B?bHBvVzJqby9BdHlYdHFXdk9sN0Y1dzF5QlppMER4Mm5UQ0k3R3pLaDJNODB5?=
 =?utf-8?B?SVg5UHdKdUJQL0RCV2d6N0phNzBhcGp3WVl3SG50ZGRxYkd1ZGxRWnR6MzBE?=
 =?utf-8?B?TmxHODdHYXJXVHZqcE1XVHl3UjRMN0pibTFycVhqVHN1WnMydi9BVmRpSk56?=
 =?utf-8?B?ZU1Sa1MrOHhteUxucUx3NUJld1pCMjV4aWlkQjNnaWdPazBSSEtjYkkvd0VJ?=
 =?utf-8?B?dVNrYTR0aFZYZDd1L2lhYk16Yml5Zml6TkpJOENHUklNb3NSYnBhTnJlRENG?=
 =?utf-8?B?MVJRQXpTRVUwWk8yYjRvTWd5aWFRRGp6aUEremR4WFAzVlkrUXMzRXkybE40?=
 =?utf-8?B?WDlOYW9USzRBZnArdUdWa1pSNk1CUW9lWFlYb2dwZEdKZnp1WG9sWndWTkZa?=
 =?utf-8?B?cVRPeFViQ1MvNmpBMXdIT0Njd3FUZ0FQUG8yS0N2Lzhxem1OY3Jrbjc2Yzli?=
 =?utf-8?B?UHcrakhBRXdVQUQ2Zi82WXY5OG14MGNaVGtZS1EzOG8rZDJtNkUzSndGMjly?=
 =?utf-8?B?ZitWVnRUNEZMWDd4RHhtamV4TjhtS21aQ3NPSnF0d2Y2bTRZMnJ1am9vdWdJ?=
 =?utf-8?B?OENvQU9hbU1GdTZMRUZLQkYrMFhHSVdGZm55NkFHTGVtTnhoaTI1SzI3a3hI?=
 =?utf-8?B?REpIUGFyMXhRRTl0K245aTF4bUxacVhIaitoRjhYamZycEdZUDAvQmN5dHQy?=
 =?utf-8?B?dzZiRHoyNVJtby9yNlRDeGgxSGYxUHAzMHpiN000NW5JbFJwT2Zid1ZYQ3dl?=
 =?utf-8?B?QTduVDZhdkdIcCttcWtuSGp4QVRIN3NxbEVxRHQ3TFZKcDFZaFBla0NiTnBx?=
 =?utf-8?B?YlFEb3RNQzh1d2QxWkFlR2tzSUxWODFFN2FjNjNlWEprL21wM1huS2RUUzRS?=
 =?utf-8?B?T2t2NXMrMmljL2ZxWVBXQmNPb2xCajBkc094eUtkQWxXNHZveFBCeDY4RzV1?=
 =?utf-8?B?U2k2L2R5WDJaZWROMDRDWnE2ejhha0QydWQ4VTg1Vnc4aFdYM2IwY29LeTZx?=
 =?utf-8?B?dzFDanNvYkw2QXRrbzhJVmsyUmUyTzA5Mkw0N2JYT1dmY3dYS01yZUxDMG1j?=
 =?utf-8?B?WnRMcUZPOTBya1VxZVJHT3ozZ2RJV3ZmY1hKanFqQ1R0a3NTNnN2NlZNeWJ1?=
 =?utf-8?B?c0xmU2htVnBIZlo4b3pnTFNDd1ZwZzBaMS9hNjIvQVVlYnhOSzlQQTF4bW9n?=
 =?utf-8?B?RlFRV0VndmVkbGlvLzczUnlqQWxEVCtvaDZ2QzFFby9FSTFVREw2SThVU2F4?=
 =?utf-8?B?YUpGemhQM05nTUFQK2YxY0VKekRUSVRFdU02b0JOVVZwOVVXdDRBZkVudm1q?=
 =?utf-8?B?d21vbVgrMDhkbmRaQUFJQXkvdlI1YmRPV3JjT1h2MjIxcDFkeDZJR0ZhcUZa?=
 =?utf-8?B?M2lkUldsbW52eTBFMVluZnd0eUtCT0dRRVJiRXl5dkxjVkJ1eHF2b3Rha3Bz?=
 =?utf-8?B?TXZmbEQyNEM1cmRpQUJaWmdId25YeStZWU1xcXorM0wrYW8zdUVIM2syRFEv?=
 =?utf-8?B?NklxZmp5UHo4VTBhaCtWQ295a2Q3WFB5cHVLbmt6a2hBRnIrQ3BLanhQTExh?=
 =?utf-8?B?U012ZC90MW1aK0RlRTBadU4rNWlTUS9abGZuODdYdXJZNFFMZUMzVzA2WTNr?=
 =?utf-8?B?ZGhPNlFyamRUNitPYTY0TGxJNmpLVlN2M1FOc0s5RWR2TG04M1lzVlBVMFpR?=
 =?utf-8?Q?TObGuAPXcudxbYk2yHnt9MhRS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUVJSEd1UFZ1WkFLRjdwVlhyM215bjMvUGVwREFMWDlYT3RFRTVJNmdDdjEw?=
 =?utf-8?B?MVRQQm82U3llWVVUSlpJUy8wUDIwV2x2cEYwZWN5MllwcmQyY0NsY01sYnQ3?=
 =?utf-8?B?Q0lnQW96Q2hvMk5VWXo2anhOMmtpNUY1cndQZ1JxT29ZYlA0ZWUyblZsdDRC?=
 =?utf-8?B?bTJwTDJGNTFyZzZueWRQYzFCdWY1REc1aThGdDdJSlJHdHNXVndoUzVDOU5P?=
 =?utf-8?B?WGRxOS9GVmgwbHZ6SGFTRktFMU80R0RtMHhlZmxEa0h0UEk4UGE1VWRNcUgr?=
 =?utf-8?B?RXVmeFEvQ1llblN6aWpVejdqQlN6bGlnem9XTXBTVCtRY1B2b2JZalRxMUpw?=
 =?utf-8?B?b0h2YWNsRSthQmtjOXJ1YUlyZ2M1M0czVjVYbHZwb2dzdnF4dDcrSkJjYnZF?=
 =?utf-8?B?QjRHNlJiM3FrN2ZaWmlGQWUwZ3BuU2ZPVVRLVkVGbUtHZVpacitHeDd3YnVu?=
 =?utf-8?B?V0JlSWdVTllob0JIeE5jYThNYW1Kd0pvKzZLUW84S1ZrVTBwRzliMnp6ZlNL?=
 =?utf-8?B?M0xtWWRoNUc1c241SUQ0U01jNzdOeFBmNzVKV3ZmZTFva1B5bUJtdHMrM0lV?=
 =?utf-8?B?SkZIb2ZvQVlRNFlYazhGUmRpZXB1WnV5SWdidlhnRjJ6aGtRTE5adDlyZ0Jy?=
 =?utf-8?B?NTdxT1hmbVdkOUJ2VTNESDkwemZWMCtxeTA5VDVURFp3WFd2dU8wSDI4N3Y3?=
 =?utf-8?B?eVdzUkUxOWw4bzk5a0lVU1NBb0czbm05QTh0MHEwM1lDR3d3NS9KWkNUb0VO?=
 =?utf-8?B?dC9GTENySmNlLzE1WDJlV2NwYzlESHZOSEk3aWN3R2FTejBVdHhEbFZiMTdm?=
 =?utf-8?B?b0tLdDFnM2psR0VNTmZISklmK2RFNFZQR21CL1ZYQkZscDFSMmJmMVRVMUN3?=
 =?utf-8?B?THNTd1ppZDRJcnA1dlFQL0wwVjJqY1Y4aGRrQ3RaMWNLVFBDOHpFR0llZVNH?=
 =?utf-8?B?YnVLQmcvQ1E5QnJ6WWl4c3dJUWt1ckpKTkUxeGlKZ3E2amNJWEJCUFpTV2xJ?=
 =?utf-8?B?ZUVlQ1ZzMEdFUDF2Ym9JS05sYVJsc1BUbFp5UmR3MklLR0VSQUwyamNWQ25Z?=
 =?utf-8?B?ZkZtN2MxQTdXU29vbHhSTEVUVmNFMUxKVzU5Vm5TY0MxUXZMQTZwR0RVbHZJ?=
 =?utf-8?B?Z2FuWS9EZDQxMnJ4QkVVQUhBV2pwWGJWVS9tTVpZeFZWTDhTdGZGVThETnh4?=
 =?utf-8?B?bUJaNlpEOW9NNTBBSFVXckVSQlozaGVOajNScmMzRW9FeXlzSUU4NGtmMmNS?=
 =?utf-8?B?Q0lvbDIrdUxOSWhxWmJTU1A5MVRUdm04L3pPL0VCZld6dndaeENjZXVUczMr?=
 =?utf-8?B?NFV0WTJ5YTgwbzdtU0lxOXF0ODdnR1hQUklscDhKSjZFdncwMUhRMGRkWkFO?=
 =?utf-8?Q?eDk0x2ZlErlhF41IdxMvTQlvOaKGXhQk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7124b2b-b0f3-4ee8-4dfe-08db5bcfe8bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:54:32.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTCqkwZ1MGVN9O29w6t9ByU7hccBJ6olP1Gs3bEcZ0F8qSXrg0dw7q0ebQgyREiGYkE0QFyKZDfxXDO9Hn18Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230167
X-Proofpoint-GUID: tiPn1BVjhB_N-YVu9hQjSfV4rWx39dSf
X-Proofpoint-ORIG-GUID: tiPn1BVjhB_N-YVu9hQjSfV4rWx39dSf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 21:42, Baolin Wang wrote:
> 
> 
> On 5/18/2023 12:15 AM, Khalid Aziz wrote:
>> Pages pinned in memory through extra refcounts can not be migrated.
>> Currently as isolate_migratepages_block() scans pages for
>> compaction, it skips any pinned anonymous pages. All non-migratable
>> pages should be skipped and not just the anonymous pinned pages.
>> This patch adds a check for extra refcounts on a page to determine
>> if the page can be migrated.  This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompactd scanning vfio pinned pages over and over again that can
>> not be migrated.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> v3:
>>     - Account for extra ref added by get_page_unless_zero() earlier
>>       in isolate_migratepages_block() (Suggested by Huang, Ying)
>>     - Clean up computation of extra refs to be consistent
>>       (Suggested by Huang, Ying)
>>
>> v2:
>>     - Update comments in the code (Suggested by Andrew)
>>     - Use PagePrivate() instead of page_has_private() (Suggested
>>       by Matthew)
>>     - Pass mapping to page_has_extrarefs() (Suggested by Matthew)
>>     - Use page_ref_count() (Suggested by Matthew)
>>     - Rename is_pinned_page() to reflect its function more
>>       accurately (Suggested by Matthew)
>>
>>   mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..f04c00981172 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>       return too_many;
>>   }
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it has extra refcounts that will prevent it from being migrated.
>> + * This function is called for regular pages only, and not
>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>> + * in migrate_vma_check_page(), can_split_folio() and
>> + * folio_migrate_mapping()
>> + */
>> +static inline bool page_has_extra_refs(struct page *page)
>> +{
>> +    /* caller holds a ref already from get_page_unless_zero() */
>> +    unsigned long extra_refs = 1;
>> +
>> +    /* anonymous page can have extra ref from swap cache */
>> +    if (PageAnon(page))
>> +        extra_refs += PageSwapCache(page) ? 1 : 0;
>> +    else
>> +        extra_refs += 1 + PagePrivate(page);
>> +
>> +    /*
>> +     * This is an admittedly racy check but good enough to determine
>> +     * if a page is pinned and can not be migrated
>> +     */
>> +    if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
> 
> Could you explain why changing total_mapcount() to page_mapcount()? The original commit 829ae0f81ce0 ("mm: migrate: fix 
> THP's mapcount on isolation") did fix a THP's mapcount issue with converting to total_mapcount().

I had based this code on migrate_vma_check_page() which uses page_mapcount() but you are right. In the code for 
page_has_extra_refs(), this should stay total_mapcount(). I will fix it.

Thanks,
Khalid

> 
>> +        return true;
>> +    return false;
>> +}
>> +
>>   /**
>>    * isolate_migratepages_block() - isolate all migrate-able pages within
>>    *                  a single pageblock
>> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>               goto isolate_fail;
>>           /*
>> -         * Migration will fail if an anonymous page is pinned in memory,
>> -         * so avoid taking lru_lock and isolating it unnecessarily in an
>> -         * admittedly racy check.
>> +         * Migration will fail if a page has extra refcounts
>> +         * preventing it from migrating, so avoid taking
>> +         * lru_lock and isolating it unnecessarily
>>            */
>>           mapping = page_mapping(page);
>> -        if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>> +        if (page_has_extra_refs(page))
>>               goto isolate_fail_put;
>>           /*

