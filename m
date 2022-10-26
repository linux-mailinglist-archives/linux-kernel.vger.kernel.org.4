Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0560E902
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiJZTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiJZTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:31:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE98FD77;
        Wed, 26 Oct 2022 12:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCo3easKm6Gno/CYfgc/5/4fA92Wbx9+z6WM/ngeAIqN4YFeuIKkM5caXk5AHRgmUwmKtfVm9aH+WqjrQPdHnnNsfsW/tUH1GNV7+9IEVdD/FMyKRfS8ZNE217mR53AzxxOXIOEJ0Kmnz9dcLijbf5hwXrQYKo9zPsuEQ2bRrH2PHTLyixIlU22tnnRFAh+mdo1SBQMzDrwmUS+3cMYBa1c/pmSwfhvjvL6ZdKUjYkEYWn7kTc3FH6Wrjogs+cdpd3eyMyXIXC+1N6XWxaAf+4eX08I6xTzZ/jd+k2oVRIJyha5hZTFkk1b9NsaNqRt4uAad1qbRUTO0F8vcUPiphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uh7Scx1OuJnsRG7Y4afvj5MzAHgaVBniivMfbHD46o=;
 b=DuTFmVGPvmdHGslXGy5sI1eB8YUSPmIJ0bhNsVepm3iQtMfKf1WHoxFhAbsrstc9i3sOQPlbb6l6engFUOxaKZ2501odbZFqXuQkVbbA2TM/d1WXFBiAzL/x7dfzHaVRXxEc6lleWblay2GHynScIMDoqVdQkMU6ZqPnukeKrpW9g5GfmmlnObGU6pttVABeOyMJns2j3I3q92EmXWJM9MHjhG+eSQbEKfhHmbWlZmTbuvygZZ/gQAyq+v1BW0/lkFjplDSavcNPmaIde7cVlyyDc6dR1iulV/0IIXc6wdli9sQKMP0x3wKiSUxPbsl8Q+RxoTEaUvkNjdOzBnhPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uh7Scx1OuJnsRG7Y4afvj5MzAHgaVBniivMfbHD46o=;
 b=By5sN3x6p8XU9uarMikSTJrY/knQ8qTjJfq3+UZ/tvwX88YGmacIdJKjJnpzVxiHItufj9hkmLdfUFh+CQvx8ZNUsNJiF0tZFrYgH9lR0o5cUMZsaxQxP9+cATqG7M10yveYIumNTy32hnp/sl6mAccQVGc7P1ZGr6L2j2txOuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 26 Oct
 2022 19:31:34 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:31:34 +0000
Message-ID: <69a14ac2-510e-fd8f-0854-60805a150663@amd.com>
Date:   Wed, 26 Oct 2022 12:31:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
 <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
 <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: a3588597-3df2-4d5e-cfc8-08dab788b167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jnzaHdyXD/ARndlcjy9enndjl2mXikWT1BY7UfopL99mO++s7ZIKNA6VQJiBhtv3YQ3mVitM4fSGnHQbuBdLhSKOx3ui+dcedCysAfiYCzw5Jx8WDZlquoWqnVOLbprkslM9uDLhoSMHJ6IAwP3dhSwvps2cGNCC6YuyQswhYOoU6T9avzMWZ288QKKasUflJsCy/EZVGYWGlTWXmo4//tbTw5JARyhyPPYVvMVa2wamGUltkDu6StJ/AuuNH4CCJBnArUbKfcR5IntPxfhcjYv5YVglK2usPhi7Y+Qv8e7D+lE4ZDdm1uIX6/ik5f/pIdhzqSfTSKViE5deFA0GjPs1zntGAbP7Ckg5JGKoPAFfOCP2FZWCbHX3Fb1Uil3PHwctRVXX+twOzZtojbWJjHfCEPBlI3nI4n6nFrFHIPZ9VlF/M2DmyCIKTub9+fkf+pv6jfDU8hjW76syTrNCs1hQcFMd/+zZ7eQqY5nzHtmNjCiF8KVXd+OogloKhSG6Hoqxr17qA8HW5IW+FIl5Y8WACb4NXuNvBLWdfNztQaGz+RJHigdRkAlZrAumTv4DrFUuoehzw9QrHWUiA4EmOTHYfepmg1/jHEc9b6VYBSTs/xBzqpIcWcXl5UssbxKv77UTvhoBNfx3XGZYtj6WygvHPV1EhLDIzMXUzSulP3qWdrIdxtL7K/PPVkoVNk7xywywSkjp0Jz9pYLC9u453jamlHaR9j/e741fmlLl0wK6XnnORLF8i4c8ftaB9GtV1twCAMXln02QGJ5Lqo5WBHWupMFmCk/kY4gOnia5qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(36756003)(2616005)(31686004)(38100700002)(8936002)(5660300002)(31696002)(4326008)(186003)(83380400001)(6512007)(316002)(41300700001)(26005)(66946007)(6506007)(54906003)(2906002)(6486002)(86362001)(66556008)(8676002)(478600001)(66476007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEpzVGU5SUVqVkxqMXFmaEdZaXJzYllEdDF6MitIZWVMOGkzZm5iM240TXdT?=
 =?utf-8?B?aUtJT0dPajAyMzRMcEtodGVETEhWUWc5d1lxbWZSQU8rVW1uaUNkMVN1b09l?=
 =?utf-8?B?amljbjY0WitzUDNvVkRwTXZBMXdvbTdaaHRHR2ZXdXFNS3JUVExqbVExVk1m?=
 =?utf-8?B?clRGVE9WSG5iWE13d05qVGxWSStmelVGRkVJRlU3RGQ0aHNpa3FUUUhhRGh1?=
 =?utf-8?B?N2JUek5qdHlHVU5UZDNsOEU3Z3VrZ2g0dlhWdGFCWGVTbk1WclVGVkN5d2Fp?=
 =?utf-8?B?WHBZSXZhMjBIdmVYalFsTCtUdWFXN2dldGFqNGNwblN6eTc3QjdhTzBRenVq?=
 =?utf-8?B?WGJCY3RQMExsOWhLUEpqQitobC80b0VsZVEvblhUaU9jV29YWStUaTViUHY1?=
 =?utf-8?B?YmxHOS9GWWQ1L1JjRkhsWTA0bHdtZ2xaL2wwWHF3U3FsRWEwRWUvelNsdmRW?=
 =?utf-8?B?L3dNalcwVWpGdEtQdk0yS1UwMXlPUnluUUhvT2dtM205WmM2WTh5U2NuR0lv?=
 =?utf-8?B?T2RDZys4RkdwRDB1djE0Y3FjeHRjTitwWThMUFBMQXhBcER6cnh2NXh2RUsv?=
 =?utf-8?B?R3Rvejc0THAxZ092blNtSUxtcVN5Q1VscVhZb3NjS0NRS2NiWDhMTXVZb2I1?=
 =?utf-8?B?ekRIZytnRzlQUU1wZGN4R0tqY2MrQXcxTlRMN1JUNUF4S294MkNwTnA2OE1L?=
 =?utf-8?B?MldjZjh0RGhDOCtVeFVSTUJObEgxa1V0aGJuU2p6Si83WE5pVVZRMjFtV3Zq?=
 =?utf-8?B?WHVJZkhMVUs0cjNkUlNHcVR2SW4yd215aTFDRUc4ekFWb0FIYnl1aXk1Q2Rh?=
 =?utf-8?B?VEdDc2Nzb0UwNnR1T1h2ZUpoTTBSdnVTZm4vQVMxRG1tbytIU3NYaS9UU2Vh?=
 =?utf-8?B?Z25IdW43OCsvaXF1VnJlTWhKWklOTUl6QUtoczM2RXYzL3YxOUxEV1hpMEhu?=
 =?utf-8?B?THd1MGRVd2owTnR4RmljVU13NWZldlEyY0dRc0JiSkpvUDFXbTVJdEhGTjFy?=
 =?utf-8?B?T2wvNjA2c1RQUXlLalFKS3R4dWordmQxOUpOanBpeThuSUdjZG8zeXVlVlFY?=
 =?utf-8?B?amx5WEJHTVhXRTFMRGFTbDQ1ZU9QNngrejBDQTZ5cnFJRjJwV05PSFRpM0ll?=
 =?utf-8?B?V1dHRitOSjhVbitVaVlGRG9Ob1VUbEh0R05EdTBaZ2IxeUFCT0I4K1pIdUhK?=
 =?utf-8?B?QXB6cEtsVzhjT3NVcWJ1RGZaYVNMSC9GSjIzK2VSSWRNQlJKN0lsdmRvUkJH?=
 =?utf-8?B?QnpudThoNGo3WnplOVhUMC9ZcUdtaVplSE11YjBONUNmYnBsUjB6dFEyR1ox?=
 =?utf-8?B?d2xDdjB3eGpDNXdLdXd4QmdsZEhaVFhlNFYwck1rT0pMVmk1bHE1cENteWJF?=
 =?utf-8?B?aVFqYlp6VE9JWDJrTWpWVEc3a0NKLzhWWFlxaWFBUmZidXU2N0U2YXltL212?=
 =?utf-8?B?SXlUMzZwMWYrY2RHY0Y5Qlp1d3pXVWRwVEI4TW50M2xxaVFqbXROSXBMOTdX?=
 =?utf-8?B?S1BZeE5CMTlHWTQvZGVGWkgvcExPM0JxYU95bFhkUERqcVdMdHMxUVJYeVlQ?=
 =?utf-8?B?SEcxWXoyTkViYUJ6bWRHSnhJMHJiWGdvaHJLcFlqQ0xXcVhrTDZlNGVlUHZ0?=
 =?utf-8?B?cnk1YzM0ZG1md3V2b0cwclQyb3UvN2RLU1VoUW9OdXZndjFvZjFIb3ZvL1Nr?=
 =?utf-8?B?RFdMQkNqd3ZYY3FTQ1NsdlhiZnVISHdmcG96dE1JM0oxZk9PZUdzdnBjQm9q?=
 =?utf-8?B?ZlNKQjV6dmJTVWhmNk1weWo1dnhCTkVXSnFpNWNsTzAyUXgyL3M3N1pyRmFK?=
 =?utf-8?B?R1dRZnJSU1pTN3hVVzJKWk9ycmpxNUhIOEdyMXAyL2tCNmQ4RVkwOE9SeGMz?=
 =?utf-8?B?NjFVNzJmV3M4YmpoMDRhS3pONGxqLzZaZ1RvR1lxKzg1NDNZSHBxbVJPVjdJ?=
 =?utf-8?B?VzJRUmFxaktnWTlLMjlNVmF6Tk9Vdkp6b0ZYdE1tOHQ0WWVnNllIWHNnd1Fh?=
 =?utf-8?B?bHZMbC95d3ZEZERGdFhTanRSb3lXVzhqUmRoei9CWGVlandZd3p3azRhSjdQ?=
 =?utf-8?B?WUU0a2xXbGVTSFlCTytpMzdwak5JbVplU3BXM01aMS9tQXNDejNLckhzclV2?=
 =?utf-8?Q?jLmjVh720rKND1Lbxc4ESiU4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3588597-3df2-4d5e-cfc8-08dab788b167
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:31:34.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3qRj3MZf/AWAo4kUOmpvXgW5nruHn0XFMHDZYWX32P7edSYT1gdSfBmoCMpjTPdNa1vjIYU3gpuiR2HBZRjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2022 5:11 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> Hi Dan,
>>
>> On 10/21/2022 3:18 PM, Dan Williams wrote:
>>> Hi Smita,
>>>
>>> Smita Koralahalli wrote:
>>>> This series adds decoding for the CXL Protocol Errors Common Platform
>>>> Error Record.
>>> Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
>>> drivers/firmware/efi/ patches.
>>>
>>> Along those lines, drivers/cxl/ developers have an idea of what is
>>> contained in the new CXL protocol error records and why Linux might want
>>> to decode them, others from outside drivers/cxl/ might not. It always
>>> helps to have a small summary of the benefit to end users of the
>>> motivation to apply a patch set.
>> Sure, will include in my v2.
>>
>>>> Smita Koralahalli (2):
>>>>     efi/cper, cxl: Decode CXL Protocol Error Section
>>>>     efi/cper, cxl: Decode CXL Error Log
>>>>
>>>>    drivers/firmware/efi/Makefile   |   2 +-
>>>>    drivers/firmware/efi/cper.c     |   9 +++
>>>>    drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
>>>>    drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
>>>>    include/linux/cxl_err.h         |  21 +++++++
>>>>    5 files changed, 197 insertions(+), 1 deletion(-)
>>> I notice no updates for the trace events in ghes_do_proc(), is that next
>>> in your queue? That's ok to be a follow-on after v2.
>> Sorry, if I haven't understood this right. Are you implying about the
>> "handling"
>> of cxl memory errors in ghes_do_proc() or is it just copying of CPER
>> entries to
>> tracepoints?
> Right now ghes_do_proc() will let the CXL CPER records fall through to
> log_non_standard_event(). Are you planning to add trace event decode
> there for CPER_SEC_CXL_PROT_ERR records?

Thanks! Yeah its a good idea to add. I did not think about this before.
I will send this as a separate patchset after v2.

I think with this cxl cper trace event support and Ira's patchset which 
traces
specific event record types via Get Event Record, we can start the userspace
handling probably in rasdaemon?

>
> I am not sure if the CXL CPER to trace record conversion belongs there,
> or somewhere closer to trace_aer_event() invocations since the CXL
> protocol errors are effectively an extenstion of PCI AER events.

Right, I will keep it simple in v1 and get the comments about the 
placement..

Thanks,
Smita


