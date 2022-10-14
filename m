Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032385FF0C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJNPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJNPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:05:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76260696;
        Fri, 14 Oct 2022 08:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN8SVKRg5MmK0SE1ETLeV30OMpwSx5RQZlfqZsjAEbjhM5nTslNvDgkVjd55dmqVc8qYJHiMsFqPAnN8WFkKcHsDBKAystIR/5f0Pj033/ZAXJAtA0vJExLoOIIVcMSJwUfk/hHZzY6969aU0QNFtbM/wZHbxOI8b52V9DTFllbhBRNU41vHCeipnyQeuS1OPH6SlmdkkEgiSNd9gAzaf9LSz9jNVztuzsJWhJ0Eyu/UVcpW9qhFRRDDZalzRzDsFtRyTKXg6Gw9wGSpn7a1dKlfRhKiYuHurpjRYyeOTZ1Ic1zQOpjD/+x3m4AR5iEaHdFmNjBgTGJjtjBJFk2n2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNcinTRj1xPVwp8BBE4LEcytaSEFhrmY9lOJZMW8Qss=;
 b=nVX3Ib20CK7xYysfnoAAm/R08YhoaB588yK+xhYinzg0y0XdQRcUXmR4CfuW3MWQFKaK/lvJeguuTt0POJVfyXFTMLW628tvT4N8i24xCcQaQ02g2JrtraIwwdB+0LS9fv6MQnJLZMU0gBXZxezSjrsxoIPi258RmR2tNAyGSLevK/6QBeHD/nduf+W0zlg219eysGksCTfLD+FAdzMcjtcvNF7HWFgZ/XK2BAm/Z0kA2zP+QMMFQZyyZ4KDMOFBKfFb9rg2M40hbiS6cnQgRTtUXxHqL1pr/iWCz4BQqjnn6aDA8eRVLc8L2H7F8xLzHWwxgj8u5nEmYXlxtCiEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNcinTRj1xPVwp8BBE4LEcytaSEFhrmY9lOJZMW8Qss=;
 b=bOsqInKJqX2hATexRpAH8emdsKcAUkd7N94R+1pvZeas57Uae/jouuTk1NYADIaGwJHkwc16mQaC6a78gNms2MexItKNIaeEjYb7w/3hYINjfeFtJBTpvfPfXrJZYffvo8KN/jTMh5zX7j8oklMXk7vUnw8gpS8HPyHKM3+jQ38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:05:18 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 15:05:18 +0000
Message-ID: <8fb8d32d-cdda-b0c9-d863-a5e63ab56285@amd.com>
Date:   Fri, 14 Oct 2022 20:34:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, kajoljain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
 <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
 <d428b526-a592-2ea5-dad8-d6eae72eb118@linux.intel.com>
 <585535bf-47d0-178c-706a-3d71bfc31f68@amd.com> <Y0lpylA86mEnmefg@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y0lpylA86mEnmefg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d202d1-b8a9-459f-5b09-08daadf58171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRLx9X+7bRDuf0RkceYoqixNeIbyzGBTFuE7bzwue9W9GQTGTu11PYacZHcY/DKYVTnShOF8V8/69Mbl/zZZFa17/ufvJEyAhxjFbQ5MtsBhj6t0iTHDLB847ohhCO2Iqv3K5g+HoSfi+R7BQ7X2OlBoW8BW97E9CA4nug1gL+mYf2qqa4PufUT8MxVSiebIrAZFWK7ltGVOxMTdXbN9Dujdz5x3l4tuB2SdYk5d4yevlCZAb7TnAUXQTCfS4GtEltK75hRkrXzBmgDY/JBQHE0sfF9Ueq+0Lkgw+80Jpq6VbhiymB+lMkeNWhE+Xdhu7TbxdchAkeyveEmjAzdUVW/J/QjSAl5nycxLIIO1jp3Nrj+QEXgS1yJ+CdihhbHi6bv0yLMUkkZRV8zUSGRvcOv/8gCiaWmRqsVLxtjUAq74ILx258NlMRmdwl8CtLLTDOpxfKkhzfaFvEkkq5Jprce1Gr0ZiegZrRaI61orGZOaU+Kv9hL/TT488kTEBsc6RNc8gWVm4J6G6ECz03VLmvpIbABC1L0MfkLJqg1TCwKG8tq9O+INlNzV64K8qT43Z6eQY/jWWJYaEDV57KLdXvQoDj2m7I/+CIImBfQc2MFg8jzMehG+1pXuJ4pOLNJO+63HXONJS+UXSuUfnFntd8+9K8nZL0RCKMCRAnDOuB5oCQj+fqnO06PxTo9RIA7Paum6Ru3oS+qr8H1VoQqean8gUhWiToSWAaoujzdQc4amt2jNffEkQ5Ks+ZqUuJYEyTvHylnBeFYgOQfFatFSDBIQhnlgYO9/9gYDCH8tgZGO+9DdKvUeACcSGozwEdd8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(31696002)(86362001)(558084003)(38100700002)(36756003)(6506007)(26005)(55236004)(4326008)(8676002)(41300700001)(7416002)(6512007)(5660300002)(8936002)(66476007)(66556008)(54906003)(6486002)(478600001)(66946007)(6916009)(44832011)(316002)(6666004)(2616005)(2906002)(186003)(31686004)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZLbXJyZEswbExwMjNiaXBoWFFpaHJEYXh0ME1ySnNRNFNJazlQaWtVWHFm?=
 =?utf-8?B?UEcrd2JQb1h4TFdjRHZqVGpWL2FxdlJ6dmJlb3RmYVpkM2tBL3c2L0VYeXNR?=
 =?utf-8?B?a05sUDkyUEVOOE9XMkx4VHZucDFjd3FJYnFyTUdseXRheG9ZZXRORTVMbDR6?=
 =?utf-8?B?VnVXdzZBT1duOHBFdDgvclVaTnFFSFhBTTBESGNUZWdUSEh5V0NPWGt3QTlG?=
 =?utf-8?B?R0oyMVRma3FJV1FXSlZsaFhyc3hCbk1ZM3NLcFo3aGdSbGU0Tm5RZXFDeGY4?=
 =?utf-8?B?dnBUZmxES0JXUEMwZjc4MjRBN2xnK2VhSEp4NWNyM3RhTkRobUlSbGloeVNq?=
 =?utf-8?B?UlFpMGwwVEVOUnduZFJxYVduNDZBZmlBYU1nSUg2T0gwTTdDcmVMeEZoMUxp?=
 =?utf-8?B?V25JZFk2bG5WbHh3Y21CcGNPVkt4WHJ5a2RCblVhZFBCcWJORWo2UU1kWW9X?=
 =?utf-8?B?eTZhN0tIT3hIcnladFdvY1cwK3AxTWxBVzI5aG13enBWZU9ON3h2dkVlalNP?=
 =?utf-8?B?YVphdG5CdVpELy8ralRQYWZxci9aSnhlUzVyKzNXT09kQnQ4T21sUndtZUs4?=
 =?utf-8?B?OFM2V00wYk16dStFelA1Q1JpVzN3QWNoUnlyakZnc3hHWjh6a25CMjJYZ1Fi?=
 =?utf-8?B?ZitlSWhLd3R2L0xRTkNVZXdLWXJxMnd5WC9YK3VpK3NTelFQeGI1MFFGNjlU?=
 =?utf-8?B?bCsvblM4VmVhNGE5OStlNjZEYVIxbjJ4Zm15ZG5vbnRNUzVsWUlidVlDMVB5?=
 =?utf-8?B?RUorUFhhSHB0aUZ3UzRHK2hCVlArRFBMaitvNnZ0WEpaOVp1ZHZDUHcycTRh?=
 =?utf-8?B?K1RrRXpDeXhaNnViTGVETFkxTG90ZzNXZmJDRGxPYVRRQXlSVzVaNHhjK2tV?=
 =?utf-8?B?SlhrbzRlNmc5a3JPNm9VWjJDSGszdzVYQ1c5a0s2MDhJY1VtRTUrek9uK0VT?=
 =?utf-8?B?VUswMWNSTEFFSGhwZGl4K0RDb3FYQW82Q0V4ZFJaU0tVYjVEVVJIK3IxYzdK?=
 =?utf-8?B?N3YxcU4xYUNUSTFtQ0FscitPN0RVL0lidWxxcTY2ejRjb2tlYnVnRERUVUxv?=
 =?utf-8?B?dXF2aVVDTXBFdlN4UXhrdmxiZTNCNkF3WWhmOHhCNEpLT29yR3d2VVF1ZGpH?=
 =?utf-8?B?eWN2aWNzYW5GdHZhMDR4TWo2NW1Uc0x6YlRzVjlPbkNrSXNZaUExWldRaUNv?=
 =?utf-8?B?TUo0a1pSOGQvazUwOG5pdVUrUCs4aGVaMHRUYlBCTHdYa1hQcWI0R0pxWERR?=
 =?utf-8?B?ZDRObTFsdUZUNVd0Y2Jwc0VzOGZyVVg4alBMeWNPNUVaZUNaa2hIREU5TEt0?=
 =?utf-8?B?WlJ3bXlkRXFLWHlEdVBLR2dxZmNuZzRPS0JvTE1vN3VBNWZEVUFRZ3JnQ0pX?=
 =?utf-8?B?bzVGaFpXNnllaHdSUlBXdnlScnc4b0JXZWdMK3Qzem1IN1E2VEpiZW5YNjV6?=
 =?utf-8?B?ZDV2N0xmVUpraTlubWttOFBLWUwrSFBSUCttajdOSXg2V25maUYrZklGbzdM?=
 =?utf-8?B?SnB1M2s0ZHlpSWJSMGFMZEo0RmNZM0NmNVhWWkluTjVhNmVUeFVRS0RDQk9U?=
 =?utf-8?B?cTFRamFVZnpzZjAzektvMXA4bnphUXZwZ1pkRlRoSUZQeGJJaHlYMFpXUU81?=
 =?utf-8?B?SGlmYjdpNXFXZ3paUzNycDVJaHV5ZWlXODA3V0FoK1FFQU9mYWN1WVloc000?=
 =?utf-8?B?VXJwSlQveHl2dWJzTWgxazhmOHo2WkI0UmJ5UFJ2eWdiR0tLV1VaRXEwVzNw?=
 =?utf-8?B?ejFpUUxvYkFpempTcDRwVTY4cUk5aDVueTJmN29INzZLSVRLRVNMWFhGbWZk?=
 =?utf-8?B?bU9mK0xPRmFYMGU2Y21FOVgyNjN1SXlQR25QNDBEcERWd2pxV0pFZ3R1MndR?=
 =?utf-8?B?RFRqQmxDeWI5dFlPWndoTUtyZFgrcGZaaHBxaUptenMzRlBySklEMmFZbnQx?=
 =?utf-8?B?elhFQzI5a2tLOWJNMDJ4WHBkUldFNjBNYzU2THltRzN2aVFURjBnUWJoNGNK?=
 =?utf-8?B?UzlGa2R3aUN4MkFGaU4zL093VWwwdXg5alE1OVJZMllncUcrKzFSQlJ1N0Vl?=
 =?utf-8?B?K0lCZjNxSVdSL3lPZVgxOG9qZllub252aGJnRTVraGhKNm93UGpvaWhneUd0?=
 =?utf-8?Q?F6djOYR1QZAd1S8xSDK6M706U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d202d1-b8a9-459f-5b09-08daadf58171
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 15:05:18.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF7IgFkfSUHDvMbwbSvVBSvCBAApbKlCyOYL6GlvOUIqlB9foVx+PaaGcciP1OUCLtLuriZtJEWAgsDW1ogdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Its already upstream, so please go on from there, ok?

Right. Only PERF_MEM_LVLNUM_EXTN_MEM -> PERF_MEM_LVLNUM_CXL kernel side
patch is pending. Tool side already uses PERF_MEM_LVLNUM_CXL macro.

Peter, let me know if you want me to resend.

Thanks,
Ravi
