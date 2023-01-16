Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F866D066
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjAPUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAPUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:47:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DD29E09
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:47:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GJhnMW003869;
        Mon, 16 Jan 2023 20:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pKfc940SQRf+NNw/ySjxJUeflDB4HQRpjsNKoUevMVQ=;
 b=EosGz5v3ptjwBQsIhfKy5zEzOS+ugfr3qWGCCcTygClY0Qwbx0se9DEB2cWMxftk99f0
 pkUZB8qiv1e/FVSC3XlCm9brsCvP4sfC5BlBS12MVdxbNRqM7hjqFIBEo2GTLz+4ALtD
 64BSHl/SXJZiAaOICNQFCg6rlJ1jIGRNjFd8Xj9/1ZCUAMGv9rlEkkoIeCyxXsrz5/pA
 RJCAKkx6YEqcoTNLjyTQqDYtB/4idwP/XMgr4IwqkLsgaKjYo1qctlrRj4CpxF11zmdI
 93zUU9LHE6aWpxsQqUXb70vUNmxwVIvwmg8+HmqYlJVuIXy0Tg0uGCBIw6AxorUtCbSQ wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 20:46:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GJBwht004887;
        Mon, 16 Jan 2023 20:46:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyxtt23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 20:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4icHxhBrG4gkB4RMHwVC88GZ+kN3TG5lCfOaT1YjgePIgO83Dlm75d9MxPQW2XtJeRATT6KM4UegmOmzb77VxNrQDJRH+f27M5ZgQEA00VLrauT1wuocK5euiCaz+Zy7GZJCJ2dUAUa4/zrwnsmdNMTJliqOya4/wTXlf2per0xnDn8/oafhIw9pqAXky527lz8iHXHL3Z1tZ+5bxKWLESoKRF46RTeNqocjU/oYjcDh+GzhjZwswWy/AnhUsoJ3ToZJZQQeXbw52pEiiD9R4RH0YMWTdTUgeftiANgeCGLoFP0/ATvCmGsG3Lw6zRoMxcZHSBDPoijHGlqInnE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKfc940SQRf+NNw/ySjxJUeflDB4HQRpjsNKoUevMVQ=;
 b=mn0awvLMUUol7Usvc/+eCKMAH5FbtLK8Tz+buy8AJgiQkPEEkocLRf4czpVdW36BhqdrnkvVgYKTNpI6HEIjYm46jqTnwo+pQPFqW9nNUIzb4HvLi44Tqqe30ZQYSlIMMSeGIQU+sOvhe8F7Tm4pbLw+LJSC7+lD/s0CJqOPnbE4GLgZ7Wb747hraDI2vBDz7ldmUYmplYoVwGfKZBe38vMMynpBpbJMDssfXDQEX+QF5vLgeiTAtPpeNbunsC3gVD1RSkQ8pkg6DywZ0W8Hf9U6ejG2cFm/K7I+17O9cwiewwGCBzt3W+9LMrkFNdYrdOAT1Msc9ROq64EbFQcsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKfc940SQRf+NNw/ySjxJUeflDB4HQRpjsNKoUevMVQ=;
 b=suPLTflhoE+M/0L/5V6IykEqqJ4P7TqS84RjRrMziivQIYocudf1xiBHd1o9dLofusrMUWXolohPsOvy6yZa1O/23QDDcJjHS6AFh6atwZZy55TY5s8hYtoQfWdV4xiXhiZp+yh/8/4xISajnYO2Pb6NgwEwP7EuqJNhpB8YG3Y=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 20:46:43 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%7]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 20:46:43 +0000
Message-ID: <4f7189ca-afd6-25cf-38a0-80b53526c2fe@oracle.com>
Date:   Mon, 16 Jan 2023 15:46:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] x86/xen: don't return from xen_pv_play_dead()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221125063248.30256-1-jgross@suse.com>
 <d0c6363f-d5c9-a53b-5275-e5134b54f09a@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <d0c6363f-d5c9-a53b-5275-e5134b54f09a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 281a061b-9b48-4396-eb91-08daf802c670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbUlitxIpE/0jklkT0Is+I/cAuDD9kaupddhbqtBW43OoOOmXdG/OuQRw1wjO7ffGiXfswyh7otRtM1ZiBOSGeWwIuqZVkUsLv2LRkcSjf72P9kc07sHsCUAP7ubCrBD8TgpxSBf5IockgKIbQUMSgi02bPsvv+vYvgLHrC66nXTVPWavvQA/+s4z71lj4Q4FiHQlRM9KjigRnToIWLmaBuVnpwM/SUmUqAhzOyFA1jlzI7SUhGQM1V4UovD9UkhJ7tUi2o3qh7OviuNUkW117xSLcIRABlSwtlURYhwp+39x1HBccXE/HL2JhE+NnkTZnAegRseV4CfWudgtVpIyWvt/iFIcji9XhQEvgBbOrn6ZjCRI5aVxtg2zO0zL24plnoKXHqNN26u/Dm3Dxyh0VdptTBY4eahzZNH5S1HClJjfa5760m/K/B6+R8vt8Fb5accCVwoIbyR8c/LUOClwqlLfWFQuhUXj1zzVz1xvT9VbOXqJpL2vwdD5M+EVfCA6xRdupRO90O3KugbUmT+hE+y1GVOS1WK9HIQZRBkv9n19kT8yxR3qwCib0l1KUEZJBRf0x6vuv0tpQXuEPflVu4lxbyO5HyE1kyhl47mDMruLeN7Go5orwsy3/+Mll9qHeQZ91/t7V89++mKPdeLKU/+No1A9rVN1uqSlDSC19ZcAJk1ZbzYbECOakI2Zp/VNJKOpZC6L/vs8CRy+Ey2JNTe23vOIrRSMP+JOcGwAjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(83380400001)(38100700002)(86362001)(41300700001)(8936002)(31696002)(7416002)(5660300002)(4744005)(2906002)(44832011)(8676002)(4326008)(66476007)(66946007)(66556008)(478600001)(26005)(6506007)(186003)(53546011)(2616005)(6512007)(6666004)(54906003)(316002)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG11WFg2N2NpcHhTY2N0RWlIaG4za243MGJTZEo3aE40UDk4SmRBS1Y3TjAz?=
 =?utf-8?B?UURHUDZVcmkwSGNoY1R3RVpralBia2Q4c042aXlOUGdqTE5lczZoR2lWSno5?=
 =?utf-8?B?U1psZTk5NTBXOWNlNVlrOWNEbVBINnJnSEVDMzBJM1FOMDEvUlVFK1pzekFK?=
 =?utf-8?B?aEdKdW1yWFVoM3hhTndZL2ZyaUxKMm1tYWUyaDVRU2xTR01SZXNBN3VQVWZ1?=
 =?utf-8?B?eGFFQ2xRVFlBRGlwVkhpS0s0cFc3MGhQSjJqMWNJSFRSblQ1bW1tblVWTTYz?=
 =?utf-8?B?c21IelM1ZjAvc0lsMEJyUmlNK0NJU2JPbzdLMzVZS2lIdkJxNWJDOTBKa0tw?=
 =?utf-8?B?UElUTU1TTDY0bWZWb1FGdk9mNTh5M3ZGWHV4MnRyNWw4OExOWXVScm02UTl4?=
 =?utf-8?B?TWJCSGhHQzZoWGhpZ29hRjhYdEgzcyt2M2s0U1BkUXhBYlI2U0EvazFnSm9O?=
 =?utf-8?B?NHVTSXFNVmEvVGt2a0I1OWRsMGErZm1xbms5R29TVm1ZaTc5NFArbmp1UHJz?=
 =?utf-8?B?dmxxRFU2dHZhSytXcDJpcWh5Y2JCdFFOeUFlR3czMzdsTjVLT0dDY1VXak9u?=
 =?utf-8?B?UHlYcTgrak85eWlHQnRZZndIZUg0RnB4YzJ4enFjTjlvSjRoV1NxVkVScHJW?=
 =?utf-8?B?d25WMjl2SmNVZjFaNE54WEoxaCtyaWk1dFBRdDlneXp1YjhRZFpMZVh0Sk94?=
 =?utf-8?B?b3Q2VUJrOWUvUGhxTUJFc01YeTRZTFJrSm9tZjR6cS91MENhMWZKcllsUzBl?=
 =?utf-8?B?Vm9mcjhGblc2UmRGSWNMRzNwYlpxamlmdlhSM3QxRnFjS2N4cjUrUFRLTzJO?=
 =?utf-8?B?ZHNoL0cxN0kxemt3Y1JTY2V2RGE0aHVTNFBTeWU4SzZQTHE0VnUvNFZtaDRq?=
 =?utf-8?B?UUxoMEMyZUhqZ2dKZHRKL3pZN2RES0poZHQ0VEFYL0JYNWFHdUxWNjhxb2tK?=
 =?utf-8?B?dU5oeDV6dGNjV2p4Q3VnM1hnZWsyTWEwV0NDQkdLNVliOHVkdktIRWxaS1VU?=
 =?utf-8?B?TjhUUEVySU1qVGNJNVMxdGU3M3U0S3hPd1JoY2NiaVBzQXBSZWQ1YmdtVmNp?=
 =?utf-8?B?RlBNdmZpYi9raDlLN0VWZ0RJdmNiWERTNE9rYVJoN08wZ2VzVUpORS9WZk12?=
 =?utf-8?B?MVhVRmN0SmZETC93cjZqZ1pRTGVCRnpmRS96ajNDRGlGWGk5c3ZVSFQ1ZGM5?=
 =?utf-8?B?MndhandqcnBjSmlaUE5lMk1LMkV6MzROVVp6SzFRcmNOcU1KR2pVWC9nbHpL?=
 =?utf-8?B?N0ZBc3FiMlE2bEpEY1dWN2NNaGp2dFY5YzhhS2ViTWY3TFZ5eUFTUlVYRDRN?=
 =?utf-8?B?MWo0ZkxUWUJpaXc0WEkreXk0TDJTcnRJT0x3UmE1YzRLY3hiVUlDYXJFS2l1?=
 =?utf-8?B?S1RFUlo4M1ErYklZMHBSa1pld1dNanQ2elJORWROUGZDRkZXbWo1elhlWlVi?=
 =?utf-8?B?d3BoRWxSWW1MczE5bHVLWFYzenZxODlGbjUzeEwxdjgzMGt6RFNYYkRZa3FM?=
 =?utf-8?B?Ri9GR0tJU0lqS2hVQ1RIL01Kc0psVndIaEkxMFRBMzBWTHFNckxUYVRqTUNa?=
 =?utf-8?B?UUhyOHY1b3hDa0RXYUUzRkQwU0FWT05JOUhYdDZ3YzJsUWNtK2N3d0JLQW1O?=
 =?utf-8?B?RHMzbzBudkpFMTg4MXd1cER5TVZNcHVvKzNsSFJmZTRpZXJPajZxZUNpNEpv?=
 =?utf-8?B?RGZmWFNGMExkcmlNUEpTcGUwQXJJUUpKNWNMYnVScVFIN2JVUzFQS2ZkR210?=
 =?utf-8?B?K0dIdjhCTktPejBMVWg4TmFhVzhxQ1B3YjlzeG9PQnN1S0pyWlUxUmpQZWpZ?=
 =?utf-8?B?ZWJ3c01TRmlhM2wyTHdHTklQdlFXQjFVT0dDb0VnbWtaUWFiVE9IZGVyc3NR?=
 =?utf-8?B?RDBadjVETTV2OWRpc1BBQk5uZEEyZFBRYUdQT2pnNXBpS083bWpyemdYMkZP?=
 =?utf-8?B?anpXYm9PZklQRlcydFltY2hFUEhURlpFWUsrNDN2UWNpcUxGVWVSeGVGSEJS?=
 =?utf-8?B?YVZ1Y1BJUzMySWtKTm9Kb3lqT2R4bDZ1UUxWWWNKVVVjTmtqSnFFNTY5bGV0?=
 =?utf-8?B?Q3EzNE9ibmEyOHo0dmhtSkpqMmxMRjc1VGNxRGJSK3Jrc1ZOVlVleHo3Rm5K?=
 =?utf-8?B?UlFQWEg1NE5qVm1qVmlkTFVlWDRDUHIrVUE3S0xGd0xXdnpUc0ZZNXNmNHNE?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WVpXMW5aaDZDL1RqbEg5anRWcEhkZ3ZXSUhaZm9CT0Z3T0Z3dDFCUEw2VGZy?=
 =?utf-8?B?L1BQRm1VUFBwZUVFM1Y4SHY2MGpjT0o1K3VoZHZENmZ5QllqMEhmSW9FSS9S?=
 =?utf-8?B?WURQT2N3dWkvUGYzTHBYNTN4ODlaV2FFT002RG5tMmRoamg5NXhZSkdCZUxk?=
 =?utf-8?B?a2phUDFoK25NZWxYd1dMbkoxZXpTL0tFNTlZVStkbGV5OUV5YTRGcG8vREp6?=
 =?utf-8?B?cXJYMEkybEZWQTRkTmZqd1hoaWVnZHdpd1pOYjIwbnVuTVB0SE9RaWh1c3Fs?=
 =?utf-8?B?TTF2QU1QK2F0NWo2bktGT1hUL2J0Tm94amJWcUVzYmhQQ0U0ZFNMTkFiNkhw?=
 =?utf-8?B?bG52Z25ONTVibmRudEtXMVM3ZTJWQ0V1MmNJd2RlQ3pvUUR4VDVjaWxwSFI4?=
 =?utf-8?B?NXV4RkZodnhURmtxZzlwUG5CZG5KT2IzNmlkSEFKQ1d6ZzBKV3RwQVFWNzF3?=
 =?utf-8?B?VktlTEFNVnlYd0RNR2tma1BvdFdKbE5zWVBTU3V5aUtUWlBTVzBQUGQ5Z014?=
 =?utf-8?B?ZVJzZ1RNOGFya1EwWXRYeFRjM0ZuWlZaa01wclRjdWNMMktrWFE5Z3M5a3Rx?=
 =?utf-8?B?UHEzeGRUdEZlVEtnZmx0V0hNTDNlUEhENjVBV2JGZm1ybXY1bmJkTXBLNmJU?=
 =?utf-8?B?K09DWjI3bE9lYUxTTEorUHZXOHZFaEE3VGg4NGVOZGxBdGVPZkFHc0hlUFpR?=
 =?utf-8?B?QktDYXlZd3R4bDFEVWFjZzNrOW5Ya1BQd2wxMVhaWTRGYlpSQnFmOGlzWm5r?=
 =?utf-8?B?cXdHcllDbzhmak1UNldYbVVVRit3STl1cWk3bUltaUZpS3R4RnA1M05KcUNV?=
 =?utf-8?B?K1h2aHhXTFZoSmNXVWR2MmpxeThieVcvTk1uYXRhMVFVV3ppampIRGhObSt6?=
 =?utf-8?B?djNQNzF6ZE5sRWlXSUtNUDdXaDcvUmZEdVFaaUZacVJzTE1ublJUK2hab1M0?=
 =?utf-8?B?QzZ0T3FqV0cyNXNvQ3RqTlRCMmVlU2crMHNUVERNN2NDbTltdndTd0l1ZHJM?=
 =?utf-8?B?UnFKcmdKVng1Q2ZCQUMydERDWi9pTXdyVzcyV3FoeHVXTUc0eUhadERLcUor?=
 =?utf-8?B?YmliTGxycDd6UjhEUUZWNmhaRFJiUyt0ZGpKeUdFUFZnVEJDcWJIN2g3a0FM?=
 =?utf-8?B?eHYrYkpqcHMyckRHWEdKbHpsd2hzZkNMMlVibHBGODVKNVZYTHY1OVZueWFy?=
 =?utf-8?B?RFE0YzdLZ1U5VUdHbExzdDVsb01wTGZzZWpjT25zb2pFM2pvUSt5T21qNWhF?=
 =?utf-8?B?MlJFVlEzaUR5dTVNSWZVRFJzNmNzc3NCU2RPMDNDZ1IyWkJ4c3VHcUNtSjZn?=
 =?utf-8?B?M1VlVU1vSEZmdGJCWG9NdDNHUEtsaWxYNTZLMVk5NjZHZmJjRmVoOGZiOUJt?=
 =?utf-8?B?eEpiRjJLSmxPQjN2bWI5bGFJb25vbmFyRDJrZjdyUmN0R0hYaDFhNjE5cWRy?=
 =?utf-8?Q?Iw5vAlsE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281a061b-9b48-4396-eb91-08daf802c670
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 20:46:43.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh+zWXRjnN8XnU/dXvrD9oucnVt5mZMsvYWam4qejdEHw43dAM3qD8InEsdD++Lg008EaVyVlVBk2yI6uRPSaaep89kTSo7VKebVFL8SR7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_16,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160152
X-Proofpoint-ORIG-GUID: JeEdyMrcvD2DTVv8_5PvbLdEmKMc4q9w
X-Proofpoint-GUID: JeEdyMrcvD2DTVv8_5PvbLdEmKMc4q9w
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/23 2:49 AM, Juergen Gross wrote:
> On 25.11.22 07:32, Juergen Gross wrote:
>> All play_dead() functions but xen_pv_play_dead() don't return to the
>> caller.
>>
>> Adapt xen_pv_play_dead() to behave like the other play_dead() variants.
>>
>> Juergen Gross (2):
>>    x86/xen: don't let xen_pv_play_dead() return
>>    x86/xen: mark xen_pv_play_dead() as __noreturn
>>
>>   arch/x86/xen/smp.h      |  2 ++
>>   arch/x86/xen/smp_pv.c   | 17 ++++-------------
>>   arch/x86/xen/xen-head.S |  7 +++++++
>>   tools/objtool/check.c   |  1 +
>>   4 files changed, 14 insertions(+), 13 deletions(-)
>>
>
> Ping?
>
>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

