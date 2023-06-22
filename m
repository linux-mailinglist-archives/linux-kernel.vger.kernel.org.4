Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4963973A624
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFVQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:33:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629D1BD9;
        Thu, 22 Jun 2023 09:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu5gSiN4QXkf6dai0UOR3rS/5mk5IPL8jkt+G5VM1E4QUaCUSYZU+pXttjj0eNXFxXdKxpo8QfPSbFI0NdJ4//x+94uINGWlp5i013c+TSGtcgtpEVFFwVEcdEKy30pYlyzP+gPc4AINXf/K+bGil9BCcRUOQiFCK8vdojqgCcCDFxyxIT3Ob92+OB9WasTXRcTRd/ln66BJ6L8q0qWhOkIIVvzEsa3KeYGKSeC99F4l1XBf5EuzOAWJk271nblcX+sMf22HhrZkdM1V/gIf63zwdiqJi2f4kPjOZ8RFTPXIk5gvfZnDkvyZNt+Mx89hYG4m5vhg/QdvIWUceWFA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBGRfS2nosjhf2Ap5cgALUDykFntsRi6zHaU+lQKCKw=;
 b=oF3HxA4YK+GIpERc4niKnhG/0mAwdrsUSnAT6cWX5vDG4EHEalJqCDT/zpLjyLuaFZ7e/mEUy91nOZyFdSn0aRqcKR5bosW8BFDtFJ80Es+QkrqmxHFohH9KBW5iobMlRu2RQS3kdsKIucqD6w1Jm61JxWXUzIlcdLMMrEtZiAZppd3bWFZFabpq6synjTDE5bx11FhNSS1aG2JW0CdKf7I2y+Xqs++mNQtY9ksqcrsUGcQR5cgGvYK6KZVJG5fwgCdoxGALRfiX4HhrYbqtYC+6lP7DjW+LA+EVmxzOJyIFollzi9mnfsq7NuQhdme2QhLVQlUgXuCFZ2FeT2dTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBGRfS2nosjhf2Ap5cgALUDykFntsRi6zHaU+lQKCKw=;
 b=Sotu0ixvkwg5xmXbQVYjkLrIqB6MXq2ip7ed4dJnJJ771drw8GNpm6HO3rgvqjk2VZT8NTA9Kqbmyr/ZmF824sv7i+lJ8mBpHnwHMyuQ7CFqnACpCz36Z9MoxE0cynY46+dZJElRPAv3+5TAyQeolwLSly+T9PROweaWdcpvDS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 16:33:35 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38%6]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 16:33:35 +0000
Message-ID: <7c11f087-72ee-eb18-cdcb-774d7848dcef@amd.com>
Date:   Thu, 22 Jun 2023 11:33:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 25/27] cxl/pci: Disable root port interrupts in RCH
 mode
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-26-terry.bowman@amd.com>
 <20230622141255.00006d13@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230622141255.00006d13@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:3b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: a47e0c99-bb0c-4ba6-72bd-08db733e6b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJzcRgxhwpSUfWWMwv8eBh/1iJ53zBe9/xZmJgDhzw8/sXLwuBseeeP+NOuZlX+vzKiAkGBpXj1CrlQ0e/JlD4FN/EzjyoqTP+PMjMC9PxUFkMYBRWBWYS5UoUMI45yb5uWLgoCtkYL9xWMm3/KWiCozhn5bSyP8p+y9L577b02ICi3Dh0DlE2DM6AsbZH+v2A18F4cjmw9Dx++7m5q/IIfhEl+yYzQt0kRQ05NLCbWvIuLHI6vvpNTJiuRM2EIj4ga2oeiv5oXURBM2xwaNVYmUA44Nz9mjHwj/vF/znxGj6TphRs1hyZ0eyUPCSax6wxUerUktRtNi0l+gBuUo6UXBFP4WBURDZuGC0J9NGOOBhACar+lUWE4NuBsX8t2XliE0LuIqp5yC5mSsX4BI398XWe0I/l+4g7XvV+ly14KmYGyYps+s4riYw9j0cyGRZ1P/H32VxedsCwr3DbI8VZrxRjZ05X9k/s2WciCJWBPsyimOte7nW7e/qU2cJoLbCUNlHw4LZI3yMxhodI1JNizAYW1Gw/oZls3pQs2NFq3WwdscFHq9vQ7/rqYgec7PyH4pp1ZVRMnyz4PVEzE3EQlu3hFK0wuQm5tGFxPP52v+GzrglZkvnZDBm9We7yNhBzMtR/TrDqcwy0NPyD9XOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(6512007)(2906002)(6486002)(6666004)(478600001)(83380400001)(53546011)(6506007)(186003)(4744005)(2616005)(5660300002)(7416002)(36756003)(66476007)(86362001)(38100700002)(4326008)(66946007)(316002)(6916009)(8676002)(31696002)(66556008)(8936002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNhcDNLVWkvYzV0N3loZDYrUGhHR2JNS1pNTndDRjROc2QvR3dJQ0xvWlpx?=
 =?utf-8?B?NG5HZHlWT0ZpdGVrOXZleXI3QjUwNnpxQU9RQnIrcHkrZ3VBUXZ2UUhQbnhR?=
 =?utf-8?B?TE41ektqZENNOXNXa1JPY1pML0ZBZU9hZ2laVmpERldScEsvdm43NE1GY3Ft?=
 =?utf-8?B?OTZpWUk3K1NDS2p1T21zTGltR1dRMkJaNGlHWkZxeHpLem9tODdLYk9udmJW?=
 =?utf-8?B?T1JBOGYwN2dpQXNOOGVKb2dqNjNGRmMzUStmMTVlRkhXVHppTjZnL21QWmlE?=
 =?utf-8?B?UVZHWnFqQllrRUVCQmRMKzRwM0lrbWs2QWt2cEE0bTR5YVhWZnhtOThZbEpa?=
 =?utf-8?B?UmVNRXhxekp6MFhtSFFoMk96YTRtTUtPaDNLSktSR01jaHY3b0pNN2Y0V2ZX?=
 =?utf-8?B?MkpsSjBuMGY0TWFUN2xvSUdBSEE4dVJOQm9qSmdEZWxVS0ZJMVhpNURVMjNu?=
 =?utf-8?B?RG9sM0syRVF4NkxKZXdqT0tZeStxcEZMZXJmb0pRRkZIR0M1RDN2VksyQWw3?=
 =?utf-8?B?d21zbWZFd0E1cEdVNStMUkExZWEwVmhuMWV6RGdLZzQxSkh3NWJza0xPSS9a?=
 =?utf-8?B?WDgrbXdEMkl0QlJIYzNERUpKUGdOamF4WFV5dVA0Vlp1UzNzcWZCOUNDTmp4?=
 =?utf-8?B?STBEcWgxYlZYeDA3VEIyTUp3ck1BR1Q2WjFneWYwNEZUek5UeFgxemJQNXBk?=
 =?utf-8?B?ZzAyWi9vbDFPeVBPTVZjQlg3a2JRVVVyYTNpTlJGMEh3WWl2NkV2U2VwcWNZ?=
 =?utf-8?B?QVRBQUUxZndNVk5QY092V2dFUlB5QU9RUzVwdkZQL2Zzbk56MVEwMXdINWh3?=
 =?utf-8?B?RWdNNDFYczh4NnBUMWZUQWFMNnBvQ2JpbStCQ2grTEdncm5rZ2JmZXBhVFRh?=
 =?utf-8?B?UkorUk96TTE5ek9VTVJ2L2NSTmszVDUrRjBDRzNZSlhSZmNsQitlSlVGc0ZR?=
 =?utf-8?B?ZXFJK2IwY3kzQktDQXBCSDJUa0NxdHRzVFVXZzBETGJmT2grWCtrY1dWUWh5?=
 =?utf-8?B?Q0FWSHlvaExUVFBkTmcvQW1uZkxEUENsMzhMVnFkLzNwK29teXVOdkN6S2pI?=
 =?utf-8?B?Sk90c3VZSFd3NEFSYWNCaXQ0bFhxbldmeURlTHBpZVFNZmVvbVhlVGxMRC9W?=
 =?utf-8?B?STF3dDNyam1NS0w4anR3cFlwdWsyTCtkL1pqSC9saCthMkhZOWJOckw4dTE5?=
 =?utf-8?B?alU4SkxWR29Ha1puOUlBZnlvU2U2d3JlNTFYZVRMTUlDSlM3dm1vcUpiVktC?=
 =?utf-8?B?NVBkTWZ2VHYvU0lXQTYwUkRoeEZ6OUZ4ZVZsYWlHMGUwQWYrTHBTRzRDS283?=
 =?utf-8?B?Ym9tU2RrUEQxeVpMYnBVcElGZGhWK0RCa0lKaTVWWUxXWnlaeXdEcStrZmhy?=
 =?utf-8?B?WlhwdGFndmJNb0R4eThtVW9xd2JYaS95NWZuN3JDVSt6Wm41aThWWFFYU0Fh?=
 =?utf-8?B?cnRPVnhLQnBNcWNTMzkrUlE3R2V0a2NkWTZBR1VkS0VCRXRRS0RZdFJrcHpo?=
 =?utf-8?B?aWFjMkZ3MjYwbGNEZG42MUIvM05BOXVsd2YrbEI5eUJ6NTZqQkdpcjI1dDJK?=
 =?utf-8?B?NGUrMUFZNDVBaW9uSlRSRmEwaWpoVytLd2xwVmJldUY1VUtDM0ZaV3ArVUcv?=
 =?utf-8?B?cWJGbFVWTXBrVTVDMkNySG42QTZPdWF4NDVrV3RMb1cxb01xQi9nL0Y3MytJ?=
 =?utf-8?B?VHh0WTB3SVdOMlBzOFFhT1ZmdzdLS1JPMWhEQkozKzYyS0hoalo4QXVqdkxq?=
 =?utf-8?B?TFo4SUV0c0FkakhZMUs5dUtoL0JwZ2pJZGRlbWFRMzUyd0FJRGFPMVd0Njhu?=
 =?utf-8?B?MXZIWVVzZklLUnMxcEtlamRwd0JOZk5oUUxwa0VNN2N3WHNVUVJuS2lJWkNY?=
 =?utf-8?B?TktqTVNhd1Y0VmZKK1plbFYvR2ptbXc2dXlJZjlUbHpFVCtOQ3RoVlhGVXlH?=
 =?utf-8?B?WGJTaHU0U0JTRUFJYkp3Qi9rNVZ6bERPZkpwK1BKRjE4aGZIamlJY3g2NHZv?=
 =?utf-8?B?N1Y0MG9vb3cxYnlJT1VTWVlkLzlrT29DS0dOa3I5WjY5K0Z1a1c5c0JMMUZq?=
 =?utf-8?B?SkRwZUF4enZ4OWdjRVNYekNCZjVVQUUrRVQ1UURWUUtscVAxNGtLZW9PTDl2?=
 =?utf-8?B?eExaMWwxZ1kreGhuMWZqb2cvSXlqcFFSdlZaQ1hlZHY1VlYzUTFqZjFrYnlo?=
 =?utf-8?Q?PTCmd70VktZaG/D5j0DksCly/IcMBd049dKM4yQXidcN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47e0c99-bb0c-4ba6-72bd-08db733e6b1a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:33:35.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhLfifE8YUxt+wTohXQMk6z/rD1U14pcpoVCScfcP20aWUcXQgIgtzU2LfFJVto3Yog9pwgVPe/kuKslHFT9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 6/22/23 08:12, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 22:51:24 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The RCH root port contains root command AER registers that should not be
>> enabled.[1] Disable these to prevent root port interrupts.
> 
> I'm a little dubious about a 'because the spec says' so argument.
> If we can describe the path by which spurious interrupts turn up then
> great - if not then fair enough.
> 

This was added to follow the spec. The RCH downstream port contains
root port control pci express capability for enabling and disabling root
port interrupts. The interrupts are (should be) disabled by default at
powerup according to the PCI spec. We know SW does not enable because
the RCH downstream port is not enumerated or managed by a port driver. I
cant say this patch is absolutely necessary but was not comfortable with
removing it either and want to avoid undefined behavior.

Regards,
Terry
