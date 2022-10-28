Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBB611491
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJ1O3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJ1O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:29:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B313CD2;
        Fri, 28 Oct 2022 07:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeefPSOjpg8zBqhNSoDkOWhYu7WEG8bsG1xuq6qUtcBz5dBUkzhUWeaHZUrZzoAzRIwXUXoKpj4GrlYmQ1Ok3CJLOW6Gj7qyIV1l62s5CWXuq0gBVRekA55iiwhKjnK5O3N667TurQLfEX4xAIvxOXu0nMZp3tQiEFpNxbbWcmjLrZA3hAjckrLiJhR5ry+AkWSYFDjPhxAlcRuFrbDnNWkAVf58KWS9Nup8TVBuznN5a+ttHfm3EsLksR6BZegAVlzMKeqOYHdi7kyV4Chl5Sg8lKkFTu4WDsHRwUZyeQZF4AxWz25M4ikxfQj8dBR1PH8IXl8Vd1GxLmehzeG2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2leZTCdYtbhntgUt47nAengMBHLoqMgeyrx4jB6eaE=;
 b=SjvNw4xy531Kn8tK4GhR42/IslP90sNzSREzyU6qPlEc7z+zUg31giHKPryVhPYfCdJ0c0P50bShWOq/kC0CuHp6E/UWU6DLvTSpzGBzgOeq5934QOCkWZjCoAiag/P7reCsfk4/GQBlUD+aLZIEFh/6OgGLoaObYtOUmSPsS1JObiJdddoxbPS1UmXS97dzv5+zqV6LSgHL/BNglaroEiSnYXOUxGhB1Vfi3tqMFuTitm890fBo7dbbl9rE/AxtSMuiNG6BBUag/chIeMP12qOIhKA3dbo2545IZq1xB6f6kH1psWWB/TS19QKwJV9tHtLAd/R53NsIVPAYuehITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2leZTCdYtbhntgUt47nAengMBHLoqMgeyrx4jB6eaE=;
 b=nEJiv+yVsTyKjV0czDDfB/giueMCqZ638COKR2koOg0sUOluaYYqIzm5zEodPCnLaeihPQlwCpuRkdRrC1mpLrp+Oq0kWcSw+Q3yzNCLg8t8VCSQMmbjzO0FnpWkI+5w68LCy61u3pZs88dDRZP3L5sRRwiWztT5jwj7gWiiZZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Fri, 28 Oct 2022 14:29:40 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89%5]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:29:40 +0000
Message-ID: <b49d8871-d127-a296-4d0c-c89bb1ad7e1b@amd.com>
Date:   Fri, 28 Oct 2022 09:29:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Content-Language: en-US
To:     Ariel.Sibley@microchip.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <MN2PR11MB3645681EA68D746AD5455DBF88329@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <MN2PR11MB3645681EA68D746AD5455DBF88329@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4e0ba9-0924-47c8-3075-08dab8f0d8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WXs5IJGb/YvV/gXfmkWyXcJ4E8z65VaI/Y6ThJHaRYlwIc66yhofHYw4JTknT0EC8g60NUdB+xmmDRHr7UEpv9VebO4UkeOhMd2SM4UEDbG/j7bwx90HaaJB2cFIkTquiGBarFUa2kIYY6pCYsPWsuZL7fgt5z1NEEuF6xUWdm0mHPOtE+7Hwf6kZciHX/ZOlLJP90lRWbpxnO4qq5vffYSr7SUcsuM4Lh2E/YE3MybalX1CFNslOkc+hlRyhFsmaTrhhP/LEBiiZ1tr7g7zGj07uT1gu6+/0yJY2rGwakUuYCd/LnIuU6BTrdvU/1HFOjpDcqaMOmYtrYDxQfckQqDkH6e9hc3tl4pOLC+s1CaZknt7t7aChS7rG43FuV8v3Y1KxOyAY8MntaM/ilz1drPk6O43OZ1D3DRsVcGrxgmQqrQigRlnQMYzUIf2dS1mei97+z56j0F0tB1mIjb/daaY2jMOntZIpOV8tdzu+uPi/b0vlE+so+XGMKdc7IgmrDo/ULdcK9zEa/ccM6QgI7JV+K53kC0BYKdKmoj02VI6JwZQGWbG58KGSGVWcT7ibgIX2gQ+3qp6Ugg3t3+ZU5E7eluLe/2wOoJOB6PJhBEXhcSQQOVo9HTfxCgdkR+1jFLOEmaEjqA92ymmhhHwslRW2G2uv5SE7jpkEmfVNtxmCgoIaOvnDIN3+512CcdhJ46GG98KHBh26gGN8C/+1QGvFzcf94CGyDXwkRreSQB7SvUF6gF9KBKEUdkmPWSTJiDv7xlKJm8sxhuixETOk87pUBr97WpYCinYBmK1PAxB0zHl5d8cr2TKzjEPmXjaUFVV3RahEP2GhFd5QY3A+4wJOH3s2i9LAJBKI8csZkFbYW8D8JbboIgVZE4bX31
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(45080400002)(966005)(31686004)(6486002)(478600001)(5660300002)(7416002)(41300700001)(2906002)(316002)(53546011)(6666004)(4326008)(6512007)(66476007)(8676002)(66946007)(6506007)(8936002)(36756003)(186003)(31696002)(2616005)(38100700002)(83380400001)(66556008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBTWGc3Uk1yenZKN3BaMkEydEc3VVptOFFVanlMR0NjaTM1dmE2MUdLRXZn?=
 =?utf-8?B?TFlhZGlKL2NMMkxYMHAvc2t4Nko3RllhNUZ1R3ZrQVVGRm1RbnVUZW1qS0tG?=
 =?utf-8?B?WEZMK3RQL1J0R3Y5S0ZNR3RlZ0Q3cHNmampWdThGWWt3b2lYTnkzVTJsUStI?=
 =?utf-8?B?bUtyQVpPL1BoZy9GOWY2ZVlOa2pNQnlyR1dnYXk4b1NsTCtWQzN1MlYyVkFz?=
 =?utf-8?B?UkRIbEUrUUROU093U2VnM2RHQ3ptYkpyZ245blEzczNNYnF5U1lvQmYvaHAy?=
 =?utf-8?B?Vmc0QitsUGZSTlluMzI3TnYyVGZyNnUxUks2TWtrT29WWEw5QzJjTmt0bmNE?=
 =?utf-8?B?STNmdjBacVJZQWY3dTM3VmY0cVRVQzlVeHJPcnFzNHNmL0pvYU13TTZ1U2hT?=
 =?utf-8?B?aHh5NTJYdi80N2xSckV6UzIzVlRkNjgxWEliS2hCN05OZ0RzZ0NUZWZWU3ox?=
 =?utf-8?B?Q0dJdVhMZkllVTZaZ0JUMzdpbzVibkI3QnhXZEFHT3ZyMlBXWDJMa2lDV2VN?=
 =?utf-8?B?TldsTHRCWUVldzBNWURIZUp1UzVsRnVHM01LbWxrVFdnYjY2Yy9ST2dldEhU?=
 =?utf-8?B?Kzk4eDZTdTBwUXZHQjl0RkdqaTZ2Q0MrU1BpYUdKTVRHaGFIQlJRQkZRS0Qr?=
 =?utf-8?B?UFZwWmlva2tlZ1RJRWhHY0tQdmRxZ216WWh3a25pcy9scU0yYVhKVGx3N281?=
 =?utf-8?B?U3gxOXVFV05EamdRRFRCck4zdFZ0UG9nY3dMNVNDOU1WeTd6ZFRnOEJSKzJa?=
 =?utf-8?B?K0Zzbzc1cXZ1T0tCSUE4a0FBVk5TOFNWczVHcGVEeFJ6aGIrcGRzeVRpbkRk?=
 =?utf-8?B?M2JmdjRkbWJJVnB5Y29MdFJtTjNyRFFEQjRzbWZVMDY0SVlIQnRRNng5ZDhB?=
 =?utf-8?B?dmt1WkFOZ3pFUy9OeGU2UFk0b0lzUDZ4VXZ2SHoyS0JubkZ5MURZNTdKOHdm?=
 =?utf-8?B?c1IyRi9DOEdhd0orOGE3Z2g1WnEvSS9hazdjRWtIUEkzT0o3K0FjMFY0NHFD?=
 =?utf-8?B?UVFzNUpabnVqcFhWdHRpbkYwdFdSTVVvMldHZjkwd0o5bXUvalVVSWdpRk13?=
 =?utf-8?B?WHgzUVZUQUZLTnRYZE1KZlBReWJabEFwSGRQOWZ5R3hpZEJRWXRjTmY0YXdh?=
 =?utf-8?B?WjlPclhQNHFNQWw2S2NrODIyQTk5bng4WitSWVVRVCt3WURCM2h2Z2UzTU9u?=
 =?utf-8?B?MXJRbnhNOVh5ZktWMUJUd1NMUDZEMDFndnM2aTJrQnp5Z2VZNjNmakE4THZ2?=
 =?utf-8?B?aHdQSS83eER2c2g0V2RYQ2p1K2M0dDZBSE5EOFk3ZWxJVWtPZitSNm9INWNy?=
 =?utf-8?B?L1Urajh5RzRuTzAwR1huK2hjSE11a2p4eG5LVTBtQU9pQnJGSjNCUThkOEZP?=
 =?utf-8?B?bUs5M3B5b0lRbXRKMGRsUzMvem5Yc1IxSGszM2ZYZVJJMHJHZ05nUW9DNkxX?=
 =?utf-8?B?QlByZFE5NXA1RXBPN1FWcWVVaTJQNkhuMStPVTB3ZzBEaDZUbFkzOUxkRTN2?=
 =?utf-8?B?ZVpWQmtVVEtDcDl0MWpaQUwxOU1DNFZSWXZ6V1dJWjBPZHFXL2RuOGxSV1lW?=
 =?utf-8?B?c2VBOUJDK2h5N0ZLUUtGNGVyQ1kxQ3pFb2l1a2pwSnJ4Skc3TEJIdEtmZFox?=
 =?utf-8?B?dS84L0FEb2wvOVRyM1pZRXhnUVhSQ0VwVTBMczBwc3pWZUVEMTFOOU96Q2lP?=
 =?utf-8?B?UGJHd09veWM4aFlmNThvcXJOcERTazh6aXpoUVpDYVk0dTdtWFpGQU4wWVEr?=
 =?utf-8?B?QmlrSitkU0ZKdEswZVl2dHRNVWtJRVRleitOQkRFM1NpOFFBTGF0amFGTkZh?=
 =?utf-8?B?Z1Q4bFlYNEtvbDJZWXBCNUFacjVTQ3FHNVcySFFOTzNnT2lLMk41TTNqZDls?=
 =?utf-8?B?WVlHc0ozQk1kVHJMTk1kb0RmenJKaXJrNTg4ZFhRbGlRTERJZFNCOVA5U2U5?=
 =?utf-8?B?YTB4TUx1KzRNaXNFaWJxYytxSTU2N3U5dlpqTHg5SHhPbUxOY3djVWNldFNk?=
 =?utf-8?B?QnhHU09lTHl4Tk03c1E4VkMrNU02ZlppMFlWdXVRNUpPUjNDdWxiNEJKOHBp?=
 =?utf-8?B?eXFxK0VHOXcvVzc3SHJJWnhWL2xSRXlxSTE2UU9iVmFxZGpxVnc2S2RUMEw5?=
 =?utf-8?B?UWtSOFlYeUNzbEdHekJxZkplaEpTMnVDMkVLMFZlZDZnZTgvWGRGQzVDOEpC?=
 =?utf-8?Q?QAs/MGlgWG/iZc+UdPWMwBVZcJcC7Oy/lk1zTg0jXvAC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4e0ba9-0924-47c8-3075-08dab8f0d8fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:29:39.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjzOIMPlIGzQEknUO5lNeWo04aEQFPiMPN6IHc/C/eIaA6aNDcmk0xK48R4P5KYnS0YcjKDkkXus31dC92ypUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

On 10/28/22 07:30, Ariel.Sibley@microchip.com wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: Friday, October 21, 2022 3:56 PM
>> To: alison.schofield@intel.com; vishal.l.verma@intel.com; dave.jiang@intel.com; ira.weiny@intel.com;
>> bwidawsk@kernel.org; dan.j.williams@intel.com
>> Cc: terry.bowman@amd.com; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; bhelgaas@google.com;
>> rafael@kernel.org; lenb@kernel.org; Jonathan.Cameron@huawei.com; dave@stgolabs.net; rrichter@amd.com
>> Subject: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error information
>>
>> This patchset adds CXL downport PCI AER and CXL RAS logging to the CXL
>> error handling. This is necessary for communicating CXL HW issues to users.
>> The included patches find and cache pointers to the AER and CXL RAS PCIe
>> capability structures. The cached pointers are then used to display the
>> error information in a later patch. These changes follow the CXL
>> specification, Chapter 8 'Control and Status Registers'.[1]
>>
>> The first patch enables CXL1.1 RCD support through the ACPI _OSC support
>> method.
>>
>> The 2nd and 3rd patches find and map PCIe AER and CXL RAS capabilities.
>>
>> The 4th patch enables AER error reporting.
>>
>> The 5th patch adds functionality to log the PCIe AER and RAS capabilities.
>>
>> TODO work remains to consolidate the HDM and CXL RAS register mapping
>> (patch#3). The current CXL RAS register mapping will be replaced to reuse
>> cxl_probe_component_regs() function as David Jiang and Alison Schofield
>> upstreamed. Should the same be done for the AER registers (patch#2)? The
>> AER registers are not in the component register block but are instead in
>> the downport and upport (RCRB).
> 
> The RCD's AER registers are not in either the component register block or
> RCRB. They are in the RCiEP config space.
> 
> Per CXL 3.0 Section 12.2.1.2 RCD Upstream Port-detected Errors:
> "2. Upstream Port RCRB shall not implement the AER Extended Capability."
> ...
> "4. CXL.io Functions log the received message in their respective AER Extended
> Capability."
> 

I based this comment on CXL3.0 8.2.1.1 "RCH Downstream Port RCRB":

"The RCH Downstream Port RCRB is a 4-KB memory region that contains
registers based upon the PCIe-defined registers for a root port... The
RCH Downstream Port supported PCIe capabilities and extended
capabilities are listed in Table 8-18"

And Table 8-18 includes 'Advanced Error Reporting
Extended Capability' with no exceptions.

The RCD upstream port needs to be removed from my comment. Thank you for
pointing that out. My understanding is the RCH downstream port does
include the AER registers.

Regards,
Terry

>>
>> TODO work remains to add support for upports in some cases here where
>> downport is addressed. For instance, will need another aer_map to support
>> upport AER ?
>>
>> TODO work to support CXL2.0. Should be trivial since aer_cap and aer_stats
>> is member of 'struct pci_dev'.
>>
>> Base is from: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Fcxl%2Flist%2F%3Fseries%3D686272&amp;data=05%7C01%7Cterry.bowman%40amd.com%7C121bfa9df0c44b311aef08dab8e03663%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638025570444835378%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ckPk6RyL61lsX%2BNYKLQ%2FzRgA2424ccLj%2B6FLG9K6Sdc%3D&amp;reserved=0
>>
>> [1] - https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.computeexpresslink.org%2Fspec-landing&amp;data=05%7C01%7Cterry.bowman%40amd.com%7C121bfa9df0c44b311aef08dab8e03663%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638025570444835378%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2For6BQCHX616kZL%2BFbSqOqT7hQYntiJYD%2BnpWTKkDXE%3D&amp;reserved=0
>>
>> Terry Bowman (5):
>>   cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
>>   cxl/pci: Discover and cache pointer to RCD dport's PCIe AER capability
>>   cxl/pci: Discover and cache pointer to RCD dport's CXL RAS registers
>>   cxl/pci: Enable RCD dport AER reporting
>>   cxl/pci: Log CXL device's PCIe AER and CXL RAS error information
>>
>>  drivers/acpi/pci_root.c |   1 +
>>  drivers/cxl/acpi.c      |  56 +++++++
>>  drivers/cxl/core/regs.c |   1 +
>>  drivers/cxl/cxl.h       |  13 ++
>>  drivers/cxl/cxlmem.h    |   3 +
>>  drivers/cxl/mem.c       |   2 +
>>  drivers/cxl/pci.c       | 319 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/aer.c  |  45 +++++-
>>  include/linux/pci.h     |   4 +
>>  9 files changed, 443 insertions(+), 1 deletion(-)
>>
>> --
>> 2.34.1
> 
