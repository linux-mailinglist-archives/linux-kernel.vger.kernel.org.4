Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD05EF08C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiI2IdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiI2IdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:33:20 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFC109106;
        Thu, 29 Sep 2022 01:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eraQOd1LVF30XVmn53cryelzWH7PbtxUKcqz4tGE/QV1NsM2La7bXAmYZVSQ9FYl2hfA7bZye4BclDfLP4eVnSnRmETnRm1LIFW/eWa9iakzrEBTYzJaTcvbXTwEiUypdotedwZ7xdqld15EWrOZTMyITe2HQ+4oaNHcRc59v5+ehVqDiIU+1r9O6r4bfBjj3XE0JM2BuXjp/ubJicHiWGgIy5m6BDSzOSHbnOObHFzf2c1Dm9vCB+KSMGCHiTrt02JrJ6DxOK7NH34OICJVd00gRYl0CGNMPej5MCgRu6sBbY7IbF3schVpTWcQ1cwAwXDdCWGPHGPfIEBvy2YQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NoHUfsNihzN/lLqlVByBj8hS5oIIq8xdibgrBdErX0=;
 b=EfCppvZApak3O+RrdgAm+IJi84t1jjewgCsAYQd6ew8jysdIpoK99ZHzgqI8j49YAvenBNRdybqYrVhZYxbuSHHQBbZL+F01wjeMSyf3eb2UbrvJdUIF1e7vFoZeyzsbza+Q9stTdt/TCQYwJEiAB0M/v7gbt+ROdUf1hseUMziKEsYnO4OyRLvGreEmSlGCxlB97K1UkPF+tiJCvNwXpIm3coDBiXU563Y3QWqqG4Ss7z5cka3stZajPX/DEJO55/9jH4918Rm30tsUEIE0Bya+QhlJpDP8R8uXvum5w0xlnGlr42MLC7vw0125Tl3nKIfGcb+k9vIG4zbF9+m/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NoHUfsNihzN/lLqlVByBj8hS5oIIq8xdibgrBdErX0=;
 b=NcCOpwiAkctnPlZccMvhlrLiEcR/bq3W1pUSpktsORObGe8AdhcEaLCCERW98VAwGTwtw2yoH6IrgDPwc5KN7W1krllUw84qivnkVz5JolPuuQdWSaepuedzHFjibbJT5/GqEedfkRrjxnTn7ewSiUS9811w1gfohHwzwOUNbL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8283.eurprd04.prod.outlook.com (2603:10a6:10:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 08:33:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 08:33:10 +0000
Message-ID: <d708cc20-b575-e007-0ff2-106f7e585cdc@oss.nxp.com>
Date:   Thu, 29 Sep 2022 16:33:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V8 0/2] remoteproc: support self recovery
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
 <08a9285e-4a4f-ff7f-0ec2-8958d0c11a08@amd.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <08a9285e-4a4f-ff7f-0ec2-8958d0c11a08@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 50649d0f-ac54-41ff-e5fa-08daa1f53da8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KM9viBrs5d289tMw7zzNzRWFu6BTj2QQ910X0m1WU7f0lmF54NiTbm8r7zMyJGglUDXHzQKAKUfP3yqSwcaAuLXhKTHotzEbOX/RDlrOMYtCkHCdyoUmiehewAXOiLNnjMcwkPFYsUgdqlQW4/89nKh03H6Mks2x6BniKY9nF4k5etKEeG6j1Yw+q++2Aa1g2oAvK2DbLaTp858e/g9i2IBhfyMS5e2diDBHibS+rfRZaRAAjSQNoEOsn+aMMhfzz9zqpz1clnqqT+YM/cLx+dYOX4neFT5x0qr/JDLXE/OjIocYfEonkGcLHbZKAQBKqK/oz+Kb83PIgvvpmV3IJLL9l9sCiCABzaM8Xd2jCltWyMH9zuMcsWL0jBT0HQRxP5go5tckVv4x/qoUc4kVJRJLpt0F02tfYXRfTE+KmcrLhrVRNcvcSKYd82BRxaqsalHw3/LAZmprm48OJCSiQ3QMX3IoiPnlbjuCFCMXF5qdTfKQEiwW/gFJ12Z7r25ByaiROHej8QKLntauDAXIZ1uRfncsBt8FfKHcBgR4Kd9kom1MJjK3avi8CyVKRgG77QHrhTHyeZ9Yc2pUt2++AhpsRQiqkKWhSo9iQBgVL3o69FupwkzErBfHQ+jo9b3VJTDGD9hU/OFXlS/wK2YDsdJKy4Nj1LBdPf4zkp6TLAbATkp1A9VeoWB7jJRRnpAsMe1hQbuL/nIUJE3vml6hQxWMEz2M8ybbm9tz9h5bF+H+dzGIqPHLnaq1OaIRDrGrMbiiyrdeKUEY58espLM3GT54A44Wfgr7u4OgxbMOZzPrkTp1ZXIcjatlmb++3Ce5H0IuR9d0GEntOlJScVqnPwXlF7CT3aYY2FBan2d2T8g1lxfZ/0/GeCBsPXWA2+AXZelREXK3Ow7zHlkIeJUyQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(31686004)(44832011)(5660300002)(8676002)(6666004)(6506007)(41300700001)(4326008)(26005)(38100700002)(6512007)(38350700002)(31696002)(86362001)(83380400001)(186003)(2616005)(2906002)(478600001)(966005)(6486002)(52116002)(53546011)(66476007)(8936002)(316002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFaRVlsbkljWXNEcEptSmxUL3FlbDRTbUg4NXZNODRXekZmaWtmbWxSbVFt?=
 =?utf-8?B?NkdtejRzbGtGcFJjUXBlaE56WGkveE5wdU1oR1V6QkpCVTZPQTVuOGl1anh5?=
 =?utf-8?B?L3Z4ZUpmL2FRTVg3Vnd5N1Z4QndxMHNWWVJzT1M4cVdybXBic3dRSWdXSm5i?=
 =?utf-8?B?TFpqZkFNalEvK203aXVDbVB1VUpZdmdNK1ZmZzRwbFNMem56ZFZTZzNFL01u?=
 =?utf-8?B?TUhMaGNwR3BUeUtReUVXdW1MTCtYcmp1YUg0NUhFMFZhYUFiUzAzTmtzQ253?=
 =?utf-8?B?bXdhWFA2cU1uTmFuTm9XUVBtdmpSUCtsa3c0ZnhtRTlSZGhyS0JlQTFPRVJq?=
 =?utf-8?B?eDhsd0Fxb1dHUHp2WnNxeTdEaUJGWG1UU25IUk53bjFsN1FQYlREMXpFR3BB?=
 =?utf-8?B?OWtRUnNaZk1rWEtuMThFZ2NDQjNqVE4rcitkQXIrb2NjeTlkOWQvdlhPKzlx?=
 =?utf-8?B?OVQ1K291WEk0QSsreGhRb2FPTXNpVE9TVFdzUUVNR2NVZGpIbWFKSkdkVkpY?=
 =?utf-8?B?WThwRExUa3JLamVKQ3V5ZTREV1ZOSE9waEJUL0NGMWF6TnJkRmIxa1hZbndO?=
 =?utf-8?B?bGZCVHJzTXQyRURabmRkSmxJMTFzQ0RCUmNRUWp1aE0rZG80bDk5R1c4TXBv?=
 =?utf-8?B?d2dNWnZBa2p1QWxMNTBtblRseXNlNHBoOWsrdTJqNFRBdVR2S1A5bzgxUzkr?=
 =?utf-8?B?SE1rM3VhamZtNjh6RG80SmdseXFZOFBMc1B0Q0hCVmtWTzFvcXhieUNlNFNI?=
 =?utf-8?B?SWFYOVR6VWhqYTJEY2dtV1FJdGxVSE9ucS9LREd2ODZhcStZRjdLWU5veGsw?=
 =?utf-8?B?bU0xUFQ0VFJxODBqVTdFTnRWR3FXN2VUdGZ5VWsyWEp5a3BwWlp5OU00WDZz?=
 =?utf-8?B?WHAxaW8xTXdFamhQUlI3Z2V6bG4zS2tKUkV2VFphNjMxYm5EV1o5bjg2QzJm?=
 =?utf-8?B?SkZPUHpsMndYbWhBVnhCM2VEVGtjNlYzdnR2SnVJZDZJVmV1Uis2Y0llN0pE?=
 =?utf-8?B?M0ExN29kTFNQNzlFMGJ0SkpWb1k4VWtId09zQnVtUk9ybWYxRlpoWC9TMDY3?=
 =?utf-8?B?RzVGUHIzaURVcURWM0ptY3N6eXZDVGcrNnNGUHl5STE1RjlUanVsWndJZnhj?=
 =?utf-8?B?Wm9EVlZWRWs1QUlSVXhTRmhsNmttWlVrbGlzMzY4RVNSQWJyVFFNMmlFN2lr?=
 =?utf-8?B?bStwSFozaGxFRk5Ib1FPT0Fxa1NPa1hQVzQvZXpQTDIvRHJZUVpKT0MydGhT?=
 =?utf-8?B?ZnNjeUZjNUE2NmJLem1jbG81UlpMUjViVWp4Ym5pa3I5Yy9XejVWeEZKUmJB?=
 =?utf-8?B?LzlUSjcyT2N5UXNuQ2ZFVjNBR2l5SlhYV1NwZncwZmErMy90QTdHbXMvcnNi?=
 =?utf-8?B?VGRoRjBhUTdwdlJMV01BWG53MVZOSXArcUxpWTRsRmZlRlNXb0RUZFExSS8w?=
 =?utf-8?B?bi90K0VIS0dnbElxYXVRQTNiRGpZQTFiMUQxZm9EKzdSNStHcnlabmZ2NFAy?=
 =?utf-8?B?L3ZhTnorTC9USXk1aE45bStSeGdNdTJtSXNrUmJqbGlPMU1tNUZ5QklLN000?=
 =?utf-8?B?Z2dUMGRsNUQzWEdoSWN4Y1UvQUJ2aXVQOVdBdnZadnpESHJMZm40N0cwbW56?=
 =?utf-8?B?YXJxdm9HU3ZKTnRSTENWTWpYZjM3a1hTem13dlE4cmx5Sk1VbXlLV3Z3bnZ5?=
 =?utf-8?B?NUpTZ1FFbWE5RUxiK0hKVlllU2pUSUxpZXJmVDJXQzBRd2s0MUIrQjhwNTVa?=
 =?utf-8?B?amZZSm1IVGJlZnFXY29sMERqV2FRR1UvK3JwaUxYUGd2T05maGhqZ2tYNndr?=
 =?utf-8?B?c29GQ0pUZHdKSTdFYm5mUXVDZ0V1cWVUWU5vNGpxOUkyekpndjljbjFVanpU?=
 =?utf-8?B?UUxBb2o0YnhPMWN0bDJFdFhNUC9nUzE2UjlNdlM3Y2cvNkF1NGhxQXdjOTNO?=
 =?utf-8?B?L2Z5YnlLNyt2aENEb21GamJOY29Pd0hxRyt0T0hnUWlDU2loRENTaEJ6Zng1?=
 =?utf-8?B?SjE3aVVrQ1ZIL0VDMXRuM2x2ZkpYY0h4SmV2aFI0eS9RUkZQMWpiNTFMVVd4?=
 =?utf-8?B?aHJpRkpFd3pGeDRLY0Zrdnh0WTJPNCtGQ0w0NjdGQ3A5QmtxZWhJbnBVMG5L?=
 =?utf-8?Q?t1K1AHfOJyBtHK1bWgl2N9LJG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50649d0f-ac54-41ff-e5fa-08daa1f53da8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 08:33:10.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: df9hvZlVQXZgsQ1vrwxchWyG/EDLgnzdeDSeamKmQeuiv9hJw7cilI9OQZ0o4tzvv4YZt/jVeVbP9qzYz/1dEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8283
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 11:42 PM, Tanmay Shah wrote:
> 
> On 9/27/22 11:47 PM, Peng Fan (OSS) wrote:
>> CAUTION: This message has originated from an External Source. Please 
>> use proper judgment and caution when opening attachments, clicking 
>> links, or responding to this email.
>>
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V8:
>>   Rebased on linux-next/master tag: next-20220927
> 
> Hi Peng,
> 
> Thanks for your patch.
> 
> Tags are useful, but more accurate method is to use --base option of git 
> format-patch.
> 
> This can inform others what base-commit was used. It is also useful when 
> you have prerequisite patches.

Yes, I see. linux-next/master would force update every day, so I am not
sure base-commit would work for linux-next/master branch.

Thanks,
Peng.

> 
> Hope this helps.
> 
> Thanks,
> 
> Tanmay
> 
>>
>> V7:
>>   Per comments from Arnaud Pouliquen:
>>     Typo fixes
>>     Added A-b tag
>>
>> V6:
>>   Rename rproc_firmware_recovery to rproc_boot_recovery
>>   Drop the unlock/lock when do reproc_attach_recovery
>>
>> V5:
>>   Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
>>   Add kerneldoc for rproc features
>>   Change rproc_set_feature to return int type and add a max feature check
>>   Use __rproc_detach and __rproc_attach when do attach recovery
>>   
>> https://patchwork.kernel.org/project/linux-remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/
>>
>> V4:
>>    Based on Bjorn's comments on V2-2
>>    Move the rproc_has_feature/rproc_set_feature to 
>> remoteproc_internal.h and
>>   Keep rproc_features still in remoteproc.h, because we use
>>   RPROC_MAX_FEATURES to declare bitmap.
>>    Update commit log for patch 2/2, and add comments
>>
>>    
>> https://patchwork.kernel.org/project/linux-remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/
>>
>> V3:
>>   Resend the wrong labeled patchset
>>   
>> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>>
>>   Write a cover-letter
>>   To i.MX8QM/QXP, they have a M4 core self-recovery capability without
>>   Linux loading firmware. The self recovery is done by
>>   SCU(System Control Unit). Current remoteproc framework only support 
>> Linux
>>   help recovery remote processor(stop, loading firmware, start). This
>>   patchset is support remote processor self recovery(attach recovery).
>>
>>   In order to avoid introducing a new variable(bool 
>> support_self_recovery),
>>   patch 1 introduce a new function, rproc_has_feature to make code 
>> easy to
>>   extend, cleaner, such as we could move "bool has_iommu" to
>>   rproc_has_feature(rproc, RPROC_FEAT_IOMMU).
>>
>>   Patch 2 is introduce a new function rproc_attach_recovery for
>>   self recovery, the original logic move to rproc_firmware_recovery 
>> meaning
>>   needs linux to help recovery.
>>
>>   V2-version 2:
>>   
>> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>>   Introduce rproc_has_feature
>>
>>   V2-version 1:
>>   
>> https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
>>   Nothing change in V2.
>>   Only move this patch out from
>>   
>> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
>>
>> Peng Fan (2):
>>    remoteproc: introduce rproc features
>>    remoteproc: support attach recovery after rproc crash
>>
>>   drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
>>   drivers/remoteproc/remoteproc_internal.h | 15 ++++++
>>   include/linux/remoteproc.h               | 16 ++++++
>>   3 files changed, 74 insertions(+), 19 deletions(-)
>>
>> -- 
>> 2.37.1
>>
