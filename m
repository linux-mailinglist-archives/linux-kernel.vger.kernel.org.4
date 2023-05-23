Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4A70E9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbjEWXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEWXdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:33:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850ACE5B;
        Tue, 23 May 2023 16:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a047AaJjKxEO2RKjJ1hiH0vGCuaYQGbQ54KkXjBm4vF4N5bDANSRxhenRYSFgytXAOjTM7jNF7BPat745nzsnWUloUojOB8hRxtquSfzTXdVtT0WColPjZK3SMXwPkltetfq2Wrnl8FSHRTzHHwnjeZezyACt32MiJ6jRP1gjBuBxFreqRWb3BEfQ7mLUqRKjNEbAHGOGLrvffQ4B8sWV8bop8QiV1MCvviYAYuAoYtZVeASGbnEbGbovZO7rM9LgAxYSlA8xM5znQH+OjAMRKOXtvnXmt3LdMIpObB5+TIPfKCP6UhTOpZsfUwl36sugenb5oRP5qR5qqF69LkyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVPa8LGGAYGQn8w6Ov2velr+r0juqoqnO8wSmu9A+R8=;
 b=DBDDVfvVLHHCNJxUhrAvIaEbLAWsgDnkst/TRrJ6F7CtUrXPNFOQDVOZmI1NH1Iz6iWDa3GB7vIz/CCqBpm3PToJ8m5suu/2TeiuT7bsI+OYfedUq+IxpRU9dD4N9kJr4mBpZx0cZVvLQAEHOUjG12aUoNa9YEDdLlZi19V4ppstM2AkHQPz+jMLuBjaX92YYt5hhbO0w9G2+WgL2w7kVSj+qE/O7N97xPNhR0ZTgRAF8pioM6DsntLFpdasOAw4BQSHxia77K36wbHs36b/49b97vIEDznWsOjHzN+M79NZecrVz79KH3XmBusTskfG01FZQz5NBlR4mYP0VpgUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVPa8LGGAYGQn8w6Ov2velr+r0juqoqnO8wSmu9A+R8=;
 b=Yjr39MOAxfCXSYFJN68wox30ng+ozt46BMe+vILheiorLybR/SADDnV4lo2CliKyZT8dYvp1+JVnKM8jNoGmP08BRJaQnOenoiyFzRdGilxj2EyZC8pb+sNpeWIRpWE51jRvnvsjJSdyCU1/BLEnuMQ7AbzrsUk3bpyNf/xFiv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:29:32 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 23:29:32 +0000
Message-ID: <40627cf3-ba79-9644-b24e-6fe5058edaaa@amd.com>
Date:   Tue, 23 May 2023 18:29:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/23] cxl/pci: Add support for RCH RAS error handling
 - CHANGELOG
Content-Language: en-US
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230523232214.55282-1-terry.bowman@amd.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c599b9-8f6d-4cbd-ac8c-08db5be58f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLE3w5PTGqg2XDdnr+Z4sLTc1OE8mbgEvLLicoemAiqCYnVSQcpyZm6LHgDGgqioDRqFf/gncVqP7LD66O0s6SReRdP8DT79Dqb3gtzfaw78t/rKq62Fgtyz5UcXTj2NgReutWcHrzUhxJIo6dlv2aUSi8Fue6aHp+/VWS2nv+Zb7k2WtSTMvaIZPSyQjVc9tWDUI+xhJvs4ddilMojIkS4lDUG5Nx3IJg0k+Ya/dFmFSofUjW/n3NU8tVZS+AKk2zjAjdijHs2d/7uj3W3DLro4JSAKgBtXyXu0+6kqb5n19Trl6S6sLhzEQDvGBMxFjirlZJbMd4Z8SzWONSZnRBo4aPCLjMVEbLk1b/l48UyvmFtllaFOr4qTUvWJYWhFs85ePO5iCc0GAAuUjo4ay2j0LWmSikmbFMkIMLLZx8LMZtDl0Hv8fXdsxq+/FG1VwHo5nuPis/8W5SiuA2p03LMtrJN8uy30doBX0aojW9cEZvvKKd1zaE/3CHpxBZ4NT2slKiayHtsPqQlad1QLp/97oOXhWr2eJzB9JvqC3Eo8VWw/oKr1uterDNi7uFaJAeAvrLMhoVYHb9ZHTlcfLJQKJeZ+JhOHJ0BS+FDbSuKBP1hK9sXiJ7ChCJ1nGlo4qZ+pUBtNMrdm9OLOYo4xJStwoGN6QYlpgZsr63obYXg2MHJzvoVMMN0APv69s5zaGbRUCl4EGj9OK4mg+hZTQfZXgdwdpnX3Ncik0UHhKdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(26005)(53546011)(186003)(6512007)(6506007)(7416002)(2616005)(36756003)(83380400001)(2906002)(41300700001)(6486002)(316002)(6666004)(31686004)(38100700002)(478600001)(31696002)(66476007)(66946007)(66556008)(4326008)(86362001)(8936002)(8676002)(5660300002)(59356011)(207903002)(219803003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VWQVZSQmFvKzNtdXcwSk91cFdsQWhXVUl5eEoxVStvZGx6UHVLZWJncWtk?=
 =?utf-8?B?WGQ1R25Ua0YrT0dqUHpJL3JDeml1R29WQzZWS2REQkE0T2hiM0c5Q0VhYUZn?=
 =?utf-8?B?QTNSNVc4M1lxY2ZYWngydDdVcmE3azd1M0xIU1lEYS9RYVNBb3BTTHJtNjB5?=
 =?utf-8?B?Z043YTdiN0FBQ1NvWVo3M1AzWmswWVROblZ3TDdqZTMvSGFlWGFxdjd5WUZ6?=
 =?utf-8?B?UVFwV0ZtV2R1a0VWT0twWDg0emkwRVpVYjIxN2ZRVXBQZXNMalNKSVU4WlRI?=
 =?utf-8?B?OVRPcHZVWSs2VFZEVWE1ZmYxWFM1OXhXdWwrR0dZbldsYzN6RkIzVjVIMjVR?=
 =?utf-8?B?SkE2N1VuN1JPYWdiQVkraWtFLzNUbkZ0NGQ3bkhkTFgzbkdxZnpROGVDSC9s?=
 =?utf-8?B?QmRuL2laUGZJTmwxMWJHY1lEY3NndVhHTkdMcDd4RnUvQzI0ZHo5QjZJb0Zt?=
 =?utf-8?B?QXdWd0NUcUttT3FFQnhOMEtNZnJsWFFpa0VibEVxSjRHU2lrQms3S0tJMElt?=
 =?utf-8?B?WGs3cUgvc2Ywd1V3WDI5RGhSQzFMa2NCMnVGQjJUTU9mdVJWYU9ZSEYxbEho?=
 =?utf-8?B?QnZwSkxHMWpBZE1xS3RQeWRYVHRwS3JGS29ndFlhZVJZZ21iY0VPSGdQeWJC?=
 =?utf-8?B?a1Iydlk1MzVzZnhPVnNFNks0ZE5oVlc5bVJ1NzBvcUVKajF1NmVlK0Zod3Rm?=
 =?utf-8?B?SjhVcGZpWDNUVWM0bXBJcUV4eGU1UWtsUVNlcjI5L21VaGtCeEYvZTVCK0xr?=
 =?utf-8?B?TXh2cXVtWktaU0hlS0ZGNU0yMGs0ejA3V3BaSHlFOVVwL1k3YUZlRXIxclVq?=
 =?utf-8?B?Zm11UlFQYStTclRHN28xSXkrZnpodWNsa0p0T3B1RmFqM1hBU0R1VnBHbkt4?=
 =?utf-8?B?MW9FeTFsNkU0azNoQlZqZ25odXJXNEhFN2lTK0p6UlVFcDFKMjFERFZrcThE?=
 =?utf-8?B?YjdLcGdGdEY4NTFNVG4xWXIrZ2dUTytpMThSQXBJdGw1T2lQcGZOdERjL0ZH?=
 =?utf-8?B?alc2WXNnNHdqbWhRZ1VObG0wbXIyR282WlZUeU13Z3FsWTlCcjloT2twWTlG?=
 =?utf-8?B?V09pcjI1QWlFZlUycnV1c05XdGU3ZFk2c2hIMk95d0J5d1gvbWZaSmdYK2tP?=
 =?utf-8?B?Rk1oc0l4dXNUQVA0VDRpb1ZsOHJkTGt3RFlrL3UwdXNhaVZLMjNFZXRNREtx?=
 =?utf-8?B?QjF4di8yUjZNZlJFZDFrOGxtdWcwZlpRYUYxRFdsK2ZSaCtJeGt5QzdaSHZY?=
 =?utf-8?B?TCtMVkptN0ZpWG5pKytkU1pMTXVRTjB3Zkx2QTRkTEdjbzJTaUhRT2licUJw?=
 =?utf-8?B?QjRnTHRhVHpINW5VTGtlVU41aVRDRnR0cmphbUk0R1BFQ3poUVBmVk1aeEhK?=
 =?utf-8?B?dk5hZUE5cHgvT3FQNDlaWmlmZFlRckxUUG96cFcvUzltVmpOcnRyYmJCOC9m?=
 =?utf-8?B?ckVqVTYrRTgzMVd0elZCQmplSU9mZmZoaytmUThWQWx1dVNmeDFBQkNTYkx2?=
 =?utf-8?B?ZTg5b0RCNGREaXIyNmxTdjRxenc5c2F1Z1BGUU91SVVyNFRtcE9jdWhYTDBy?=
 =?utf-8?B?L0xQMUNzVUc2WlpUNlc2VEtiM08reFhIbXNxN1MzM2FYeHVIekc2RkZoM2pj?=
 =?utf-8?B?dEdSYXl6NEpkbW9BZStXaCtaUTF2anpQY0MzUWx0eFdiWHlHdXBTL1lYVlor?=
 =?utf-8?B?NFMwUWVyeUx3emowd2tkS2N0SXM5Nk9vR3F0M0lkZWdpZU1Kd2hPV2NJVDlY?=
 =?utf-8?B?L3BNNmdvTDE5cTdpNzNpUXpBTURKelhCNVhoeWw5MTZYSUR3cjNhdHFGdStj?=
 =?utf-8?B?QjFpWjRnbEh4SzJ3eXEvWVV2M1hNV0RmeXo4MlV4NEJvMWZTWm1jNjllREpi?=
 =?utf-8?B?eCtmWHVuOW5sOVpORm9nRDBqOFpydVpPdVZ5ei9nc0hWczUxMmNBTXlaeCtW?=
 =?utf-8?B?ck9uUUN0b3BuSkEwQUFwYzJtTUd5VWUrVXJobWN0bHJ5Nk5mQjI3alE1Ykt3?=
 =?utf-8?B?cTJmNVVTb3dpNU44MjVQTkZEUTgwVU51R2NhTnloczdGcGpNNFFwbWRtek4z?=
 =?utf-8?B?N2h1OHRvaWFHcHFYeDBXNElwV25VeU1xbllRT0pvVlcxazE5MUNmNUI0QUlk?=
 =?utf-8?Q?+zsojCSe/m3PyKTMFSHBFzlGO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c599b9-8f6d-4cbd-ac8c-08db5be58f8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:29:31.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YHKhxfy0iKFogEArm9i625ro6vT5sDM4V9LZUz260oQIbVfDxlrHDdtLzLyUGmB1HMtYCKsBiEUDX64B1ggNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropped the change log somehow, Adding here.

Changes in V4:
 - Made port RAS register discovery common and called from
   __devm_cxl_add_dport().
 - Changed RCH AER register discovery to be called from
   __devm_cxl_add_dport().
 - Changed RAS and RCH AER register mapping to be called from
   __devm_cxl_add_dport().
 - Changed component register mapping to use common mapping,
   cxl_map_component_regs().
 - Added cxl_regs to 'struct cxl_dport' for providing RCH downstream port
   mapped registers used in error handler.
 - Refactored cxl_map_reg() to be like devm_cxl_iomap_block().
 - PCI/AER:
      - Removed patch for cper_mem_err_unpack().
      - Renamed cper_print_aer() to pci_print_aer().
      - Changed pci_print_aer() export to use
        EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL).
      - Improved description of PCIEAER_CXL option in Kconfig.
      - Renamed function to pci_aer_unmask_internal_errors(), added
        pcie_aer_is_native() check.
      - Improved comments and added spec refs.
      - Renamed functions to cxl_rch_handle_error*().
      - Modified cxl_rch_handle_error_iter() to only call the handler
        callbacks, this also simplifies refcounting of the pdev.
      - Refactored handle_error_source(), created pci_aer_handle_error().
      - Changed printk messages to pci_*() variants.
      - Added check for pcie_aer_is_native() to the RCEC.
      - Introduced function cxl_rch_enable_rcec().
      - Updated patch description ("PCI/AER: Forward RCH downstream
      port-detected errors to the CXL.mem dev handler").

Changes in V3:
 - Correct base commit in cover sheet.
 - Change hardcoded return 0 to NULL in regs.c.
 - Remove calls to pci_disable_pcie_error_reporting(pdev) and
   pci_enable_pcie_error_reporting(pdev) in mem.c;
 - Move RCEC interrupt unmask to PCIe port AER driver's probe.
   - Fixes missing PCIEAER and PCIEPORTBUS config option error.
 - Rename cxl_rcrb_setup() to cxl_setup_rcrb() in mem.c.
 - Update cper_mem_err_unpack() patch subject and description.

Changes in V2:
 - Refactor RCH initialization into cxl_mem driver.
   - Includes RCH RAS and AER register discovery and mapping.
 - Add RCEC protocol error interrupt forwarding to CXL endpoint
   handler.
 - Change AER and RAS logging to use existing trace routines.
 - Enable RCEC AER internal errors.
 
Regards,
Terry

On 5/23/23 18:21, Terry Bowman wrote:
> Patches #1 to #16 are a rework of the Component Register setup. This
> is needed to share multiple CXL capabilities (HDM and RAS) for the
> same component, also there can be different components implementing
> the same capability, finally RCH mode should be supported too. The
> general approach to solve this is to:
> 
>    * Unify code for components and capabilities in VH and RCH modes.
> 
>    * Early setup of the Component Register base address.
> 
>    * Create and store the register mappings to later use it for mapping
>      the capability I/O ranges.
> 
> Patches #17 to #23 enable CXL RCH error handling. These are needed because
> RCH downstream port protocol error handling is implemented uniquely and not
> currently supported. These patches address the following:
> 
>    * Discovery and mapping of RCH downstream port AER registers.
> 
>    * AER portdrv changes to support CXL RCH protocol errors. 
> 
>    * Interrupt setup specific to RCH mode: enabling RCEC internal
>      errors and disabling root port interrupts.
> 
> Dan Williams (1):
>   cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
> 
> Robert Richter (16):
>   cxl/acpi: Probe RCRB later during RCH downstream port creation
>   cxl: Rename member @dport of struct cxl_dport to @dev
>   cxl/core/regs: Add @dev to cxl_register_map
>   cxl/acpi: Moving add_host_bridge_uport() around
>   cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's
>     port
>   cxl/regs: Remove early capability checks in Component Register setup
>   cxl/pci: Early setup RCH dport component registers from RCRB
>   cxl/port: Store the port's Component Register mappings in struct
>     cxl_port
>   cxl/port: Store the downstream port's Component Register mappings in
>     struct cxl_dport
>   cxl/pci: Store the endpoint's Component Register mappings in struct
>     cxl_dev_state
>   cxl/hdm: Use stored Component Register mappings to map HDM decoder
>     capability
>   cxl/port: Remove Component Register base address from struct cxl_port
>   cxl/port: Remove Component Register base address from struct cxl_dport
>   cxl/pci: Remove Component Register base address from struct
>     cxl_dev_state
>   PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
>     dev handler
>   PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
>     error handling
> 
> Terry Bowman (6):
>   cxl/pci: Refactor component register discovery for reuse
>   cxl/pci: Add RCH downstream port AER register discovery
>   PCI/AER: Refactor cper_print_aer() for use by CXL driver module
>   cxl/pci: Update CXL error logging to use RAS register address
>   cxl/pci: Prepare for logging RCH downstream port protocol errors
>   cxl/pci: Add RCH downstream port error logging
> 
> base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b
> 
>  drivers/cxl/acpi.c            | 191 +++++++++++++++++++---------------
>  drivers/cxl/core/hdm.c        |  59 +++++------
>  drivers/cxl/core/pci.c        | 140 ++++++++++++++++++++++---
>  drivers/cxl/core/port.c       | 157 ++++++++++++++++++++++++----
>  drivers/cxl/core/region.c     |   4 +-
>  drivers/cxl/core/regs.c       | 152 ++++++++++++++++++++++++---
>  drivers/cxl/cxl.h             |  56 ++++++----
>  drivers/cxl/cxlmem.h          |   5 +-
>  drivers/cxl/mem.c             |  16 +--
>  drivers/cxl/pci.c             | 109 +++++++------------
>  drivers/cxl/port.c            |   5 +-
>  drivers/pci/pcie/Kconfig      |  12 +++
>  drivers/pci/pcie/aer.c        | 173 ++++++++++++++++++++++++++++--
>  include/linux/aer.h           |   2 +-
>  tools/testing/cxl/Kbuild      |   2 +-
>  tools/testing/cxl/test/cxl.c  |  10 +-
>  tools/testing/cxl/test/mock.c |  12 +--
>  tools/testing/cxl/test/mock.h |   7 +-
>  18 files changed, 824 insertions(+), 288 deletions(-)
> 
