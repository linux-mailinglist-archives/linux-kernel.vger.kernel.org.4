Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7385E730200
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbjFNObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbjFNObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:31:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026B26BC;
        Wed, 14 Jun 2023 07:30:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDDqZN011686;
        Wed, 14 Jun 2023 14:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XKfpjj9325wc7Idp8DByKJ4RKzFx4GYMUK9ZJPTZXeY=;
 b=f/4FwFhBIim0mb20UrZXggc2VB+gj2iibUbfhVDxLJ8obIKREPYwDJw0YogkfD0gV1/W
 83zmZ5YC1A64ARPp61iBlg9aZGJB5JBlUJB2U0U+fpsB5W4TdmMZszTLpTCY6BgigN21
 485wFhg7Nh485vK1rpDr5A1asVJlt9Z+jbTHSGUKgRfw4ZbCj8Zs8xH6tAyFD+TdQnXl
 v4DMDFJ9po4efDqAs49H5Q/tc0jaKrMb44mYOK1WvDDhGl+FtnTGlDD77yuaxnPlpmmZ
 cjKt2tACBnUZjtn71uPw1LVbMiu7b+6b7FdEaz/hEoQ28j+dGzW7MeLRZBmU4huBnYan XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstynbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 14:30:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EESLoP016206;
        Wed, 14 Jun 2023 14:30:14 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm5nmne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 14:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF9Fo6GrX8Ed0Vlva2lNgZa6D/6WlgDvDJLZjJSs5Wxx/eD3M0Qix2silsdAS6si1YJhFqE+eNLtsw4Y5CzWI2tyxf3+ls38rupZ0IMoMzf2d0cmoIPheZCC1dpCh+Gd/43fiUN8HkXTip8y6ABVoqoeVqMuyrjl/wvV1Ix3IBoMhmZKz6LrTmZIYVlTGlam98GrxVCK8KVlCQQ3tiVnfFAGou7QS747HvlJuLM+OWRiXc3xQLJn+fqEsQkb++W6TxNH2/Pmz4G85jvoyH8q404dhGWU3JQK23thcJXkCcLTySzD4FEAEx1EeEBu48w6BNvyJoThU5E1xKHLeLdRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKfpjj9325wc7Idp8DByKJ4RKzFx4GYMUK9ZJPTZXeY=;
 b=ksuCl+8hNWynmmBsZ6YOrJ4GUhf0dJJJs04L5DlLmuNRz4E40lGnI10aexjLiE00PXO5xLWIlTWwwy2pslUf+UA6AqCERyatDkteeGLPqWshVoEbpa8VlxYLQDA04C1AcGrlqahO81ams71BtPL9tUbhj5MkiMMySFdYNKAxvmrm/Wq2EMekM0CCvDWxTCilD9LdsPipUPg+5Ksjy8ZH3Bx4ro7aG4OMBRYvw4sb1A4IafWkfeTpdI/V9LubGVNZD5ACr4w08/7rVNWhKj0p50hahDnQgvd5aoOMFp3S0Xenb9TZC/32xq5Z1EpNQrr36rJ07JUp0hQ7r7huJTOGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKfpjj9325wc7Idp8DByKJ4RKzFx4GYMUK9ZJPTZXeY=;
 b=hcG38u+bO1Z6m3pywXcQ+GsN8rQ3v8TZSOC5acDbacEzMg8or84PiZgqtpGaCTgfVLqLrNeJm0BcCKm55VTekjEb4DTumqmS3AvyA/j+8iVM6ZwCaeOKxYsg/yhqeu81kdC58pLvKvxFh52ayBywJaS0ymrF/G4pthXgvotH8FI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 14 Jun
 2023 14:30:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 14:30:12 +0000
Message-ID: <adc68c05-3631-be63-3069-09bebf4956ef@oracle.com>
Date:   Wed, 14 Jun 2023 15:30:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/8] perf vendor events arm64: Add default tags into
 topdown L1 metrics
Content-Language: en-US
To:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        peterz@infradead.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-5-kan.liang@linux.intel.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230607162700.3234712-5-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae64c87-48e7-4dcc-6d43-08db6ce3dcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxbNIcDLm8VHWbq4NFrxaYaxfCbY/UcY+/b4Gt+AVFmaUXXnHX56pBCkP9lJLn+xSffo8jrcd2gKR4dpIBYo6uL6HhCotc+kcSfLQcLIfSv8MWl66hd0O2tF+dlBn5dFJisOVUiFUgpaLhssrTYhFQkC87h59LyhyXUjuUVHig4mXqgNnbnrQ1vMctlE7lvzZKLzwe6vLRV5snp2VjF0On6hTCG3GXzVbhRK7kS8DNI2cnJTL4yonjUQFfBaftnUmphaQTb8kJhHr9JJejAzGljEZyDaqwGrMnUtgZjkOMNlOA/0GjsD9CbqRh2WBfjeJCWiwNq3qLA4DTjrTBqs3755/jgKS8tYBmGjEPXx1Y88y4qi6GSHxNgwj3z6Q+gpLC/jFCf9tAc19fx7DY4gYMMZ2v/Loq/hP7674Hf7DrPZ5YxVDc2Wwr4YkPT3nKtc7ztvDry9TCHpO/eLGmFQNJXjKAL6l37JLqVn4zS83qhRqaJaU1b5FQyyuqXeVrKFHwpc8hE7tE8GjxldmJVabySUJL/oCEdLWocwImfqGU/gHZKsxQ9n0ujz/vbruQ81fht+lPhUFXgrGHP/+Sbu/Vv3sJPW9TgvOP6+EN8NhL3F4gWIukjotaBULK3WdrpySRXXa53pJnH1gWs1u/6PhRMqT4WLILc1PunftWT/tAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(6666004)(478600001)(7416002)(5660300002)(8676002)(8936002)(36756003)(2906002)(4744005)(86362001)(31696002)(66476007)(66556008)(66946007)(4326008)(38100700002)(316002)(921005)(41300700001)(53546011)(26005)(6506007)(6512007)(31686004)(2616005)(186003)(6486002)(36916002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REY0Z2g1L1FuYVE1RFMwd2p4M2tjS2RHVW5qV3FUQ2k2YzVrMUw4L0VPdnJ0?=
 =?utf-8?B?Y0dQZ1RIM1N5THh1Uk5Za3FYeldzdHhaSXlmQ0RSa25VZWdSZUxTelBzWmU4?=
 =?utf-8?B?R2RLVUs5Z3NaMCtENXpqejZ3aWx2amU3VldDdGRRcEp5VmRVODdpYTE0TzI1?=
 =?utf-8?B?c3lXOTAwbFpoSXc2d2RTTlpjazVrWHZxRVJJeCtqVGI5NS85b25McCtUNi9n?=
 =?utf-8?B?cEw5VDBtT05uQmh4aWRaNTFTbUpZQjVjZEZqbUc5Y1h1eVZtaW1VMVM2TERi?=
 =?utf-8?B?WS9hQyt6OFJOTkxnaVMrU1lTRzVhQWY3YjJMVmp3cFRuQmYzNmRscGtIY1Zk?=
 =?utf-8?B?VytKcHl1QmdmRzR2SW9VZlpyUjFvalBPMEdETXNLcGE5TGxqZk5sd3pJNmhB?=
 =?utf-8?B?WVlER3liUEVUenB1WndFUnlKK2N3ekdwMXVoaWlxTlFFVnd6QzlnVWRFQmRJ?=
 =?utf-8?B?VmcxUWJuVEZKWmZWazhGbnFBemdDa3dkcXErL1JQKytvYXU0Y1RyeUJxbGV1?=
 =?utf-8?B?d3dTVmNrc2NGdlQ2OUgybHN3NFNtZm5BVW1tM2ZCNmgzZTVYZVhwdUNXUC9t?=
 =?utf-8?B?VmhvSkkzNFBMK0hUOEFHUy9OTnh3WHB3djdldzF2VTdhTUNRRXBOZUlNR2xK?=
 =?utf-8?B?ZVVIeThkNmQ3d2NaakNJTGFRME9rdXNxcGZhdkw5aHNnSUdRN1ZVWG1qd1J2?=
 =?utf-8?B?Q3J4ckRkY0tyeGhrWVQrSk5xaDdkYzBvUHBCMmtjMDVYeFpVQkFualV4aGx1?=
 =?utf-8?B?RGRMOGpPWFdSdWJNdXJ6RS9UOFdqZFdRd1g0allBNk9JQURad2ZqMGZ1QTRM?=
 =?utf-8?B?MlpBcWxIRVhncjAzT1VUbnlxS0VzcnpkK3ZqV1I5ZHRTVWhDMkYvQXpLc1hD?=
 =?utf-8?B?ZnkrM2FNeWFmTmJJUFBVMFdWRjJzK3U0WDJ3T2NPSllXdVdiSURpU0VmY3FV?=
 =?utf-8?B?bXM1Qjg2ZXhQK20xQUNLNjJkNWNsdkFZbTlFaUhwd2pvUklibm10VUc4dnJ1?=
 =?utf-8?B?cGg0c1ZRSWxnU05jQ2t2aWtYVXpjVnBMdGNHK2M4VTAwTEpIbXBQeFY2aWVr?=
 =?utf-8?B?bVJGeTRYdU1xSUUydzhpRDVsVHNVY3Y0YThxM25yZ2EwVElRSGxoc3UvNk9i?=
 =?utf-8?B?R0VGV2M3M3JTVXpEakRhU25DNjVTN040c3Bsb3pqKytnZ1d5QnNTK2NXRGZ1?=
 =?utf-8?B?ZHQ2SElhRjJBWkNuUERUTytUNlJ1aVU5d1dJVjU3ZlNSOFRyY3hPTVpITDdD?=
 =?utf-8?B?U1U5MHNmQWNrOGJTZEJJTkpTUDBuV0JhTm1wbVBkNkpSRnlrSVd3ZXhSdWRy?=
 =?utf-8?B?cjlUZVVvRWtQMHFmRExScGRIK0RTdDJQeENjMC9RMi8yMkJqcVB2VTlCRGhk?=
 =?utf-8?B?aWNKNW5rZEZLVGU0MUgrSzVpeStHb0FocWJqd1grSlVQTktOS0laeEpXZlBk?=
 =?utf-8?B?SFBwNCtCNHlXR1NONGIrUzVQWjVKTnREYWYwdllGNHR5MXladWxEM2wwd2kw?=
 =?utf-8?B?TDZmWGRXVXR0VUFMVkFnUlcvbm1PRytJWWFLdzN3dW5SamJjekVqeDBmS1A5?=
 =?utf-8?B?aUZwZHBqS1JERlNrUWRDWFZJNUFwZURuNm91cnJLalhSOTVLUlB5UURMekxE?=
 =?utf-8?B?T3dZd3Y1ZFpzWTdEczFDcmlUTkhaMVJjd2NZeU1OTWhZRkhOb0NTTzB1dXdS?=
 =?utf-8?B?algyVzZyMVVDVlltZTBDMVFzeXU0S0ZTWFgyMndpN3hMZlBuVzl3T0F6Yjh2?=
 =?utf-8?B?N0pFZ1dMbUNtdFJnck1SYWVKVlVGR1B3WStwWTFqYTFpZUVxdFpKUStYSFNx?=
 =?utf-8?B?K21oQzZJRnp6dWhpUEpFeGJzSG9VRlB6bnVFcEl5TXZYeDB6MXU0L0hLM2Nk?=
 =?utf-8?B?dnJrTVVFQTVBbVI3UmkranZYeHFYU0IveTBJKzIrMjBVL2o2bG45YTJwby9k?=
 =?utf-8?B?akNRdVFyL2tNNW5Fb0JxK1hySE5LVHNyaUpVa3dCT2JRSWhIaVNqSUhUWDVm?=
 =?utf-8?B?ZXFUS1F0bFJQM3hhZ280aTBDaHcrS2FxZmlkL2dhMzFGc0FtWEZWTk1vcXNj?=
 =?utf-8?B?RVNURExHUS8wZTRZWXUxMUlFeXYvWE42QXVjWmtDZHl6ZW1LTGZ3eWttMGtn?=
 =?utf-8?Q?fIJC+jfe8x8BgYsp40mjJFnFZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3dmLzZsUVFHWS81MUJPU1ZMNElhZWdjd3phNlNBL01MY1VuK28zKzV2aWtJ?=
 =?utf-8?B?OGFxaDVDTDc3UzlQb2pXeXNpTC9TRzArOEw1TGEyc2R3R2t0c281VUNLK0JY?=
 =?utf-8?B?aDkzM1ppcnl0MWNtTE9VclBidkVZSnprN3RWYzc3bWRFNHk4Uk10YVQyUDZB?=
 =?utf-8?B?YWtobVFnUXU5VXVHWWxZSnNJeGljZGp6M3J4L3RTV0dQcGlidVZwNHU1TWJX?=
 =?utf-8?B?bzhzR2NDa0dKNlQwQS8rNmVsQXBZWDFUOE8xV2dqNGVuN202SURuM2pNL0Zl?=
 =?utf-8?B?Q25GalgvNG81bTFSV2htbjRFbmtNTitRRjZLaEs5SElTYnhnZ3JMQU4xL0Q1?=
 =?utf-8?B?OFdhTHRUMDh1emtHY0dGSzQ2dnFMWGtaVTFkc2lhdFB3N090Qk5COXptMXRJ?=
 =?utf-8?B?ZFg4VGVUUTAwZUFPVE1pRGxKUy9UcVh5dUpYRFZZRzhHb0M2bEprMHNFQlpR?=
 =?utf-8?B?MklSL3dFajJiQU5rd0l5WEFKakYwbmpUZU0vRGkxZWw4R2JZOTBCL1ZPeHpu?=
 =?utf-8?B?RW5UaTN0R2ptaU5kaDQxOUppUXRqcElSRUNTemNzQjNTMklueUU4N21ZZkls?=
 =?utf-8?B?RmdXb2lqbU90UkRZTGNrNndXeGczYlYzQ1dNOHJZSUNrZWtKNzAxWkFpOFdo?=
 =?utf-8?B?VHVXaTM4Qi9tM0RjbWNBS0s2d2k1dWRWZXJrUXhwWDJGUm9YMkFja3NOaVNZ?=
 =?utf-8?B?ZGtOVmkxS3hENHJ4LzV2WllRc2ppSmRBOEliRmZmaU5iUkxOM0loZlgxb3dx?=
 =?utf-8?B?TlVhWkxNemdlcFNXZzNOeXF2OHpjNWtjVTAxSzJLdDlBM3M1aGNDQ3VlamxJ?=
 =?utf-8?B?SVhOTk9zdUNmUmc5ZCt4MTdPZCtmRVdBSTZBc0k0YVA5VmQxcGpqQ2k5RXhw?=
 =?utf-8?B?M2xISlBqcHhDU1hBTWlkZTQ4eDRHM25XNnVub3RBd2pIOUF1eFdhdzhrK0JB?=
 =?utf-8?B?VWdaeFUrSXhpb0ZRbXJMYTkzK3hVVmdKZjZuQ2NWSkw3YkkvRDFLU2U1eHph?=
 =?utf-8?B?bkFnUlIyWEVwN0RnVzl2UURMQWVua2xkdGVWemFtK25TNGtMcnlkenVxUm1q?=
 =?utf-8?B?OFRPRkNHUWE5WmFWejF3V1RLSnN3MzRoN25pQk42allyL2tJb25QY093N1hK?=
 =?utf-8?B?Mmk2Z1lieHFOaFRFOTBQZm1BSkp1S3lxS3doYTJvOE4rUXFDbnZYK1EzWUNN?=
 =?utf-8?B?dTR0eC9zdDhIdE1GM09kR1ZpajExSk1jSTBrM21RM2pqejFUQzdXcXJGYzR6?=
 =?utf-8?B?akpxMXlZdVpKZGpvTzgzekZHc21JaE9pNVBUelExbCtFbGtPNFYvS1E5ZkxW?=
 =?utf-8?Q?fnoNnkw/WtV5mMYivPLWN2rFaeP9skKRB1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae64c87-48e7-4dcc-6d43-08db6ce3dcc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 14:30:12.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5khO65XW1X4dTlUN9K/jslsoi9cwyoNzFIopET7DBzIHIXb4ID83quCGayup9wDEZ8iyc00LrP2BzZcLd1VNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140126
X-Proofpoint-GUID: 3WmiqMR0_-yTdDposOTnO3mp3sqn-ZGB
X-Proofpoint-ORIG-GUID: 3WmiqMR0_-yTdDposOTnO3mp3sqn-ZGB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 17:26, kan.liang@linux.intel.com wrote:
> From: Kan Liang<kan.liang@linux.intel.com>
> 
> Add the default tags for ARM as well.
> 
> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
> Cc: Jing Zhang<renyu.zj@linux.alibaba.com>
> Cc: John Garry<john.g.garry@oracle.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

But does pmu-events/arch/arm64/hisilicon/hip08/metrics.json need to be 
fixed up as well?
