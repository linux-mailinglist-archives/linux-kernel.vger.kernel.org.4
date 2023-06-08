Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CBE728A68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbjFHVuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFHVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:50:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741032D7C;
        Thu,  8 Jun 2023 14:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozl50wGufGenkhDYjkX3fIIMsJWpuAqo0KW6K2V2RDuRctjzLVP/FBP5CxDl+7zPOcr8K/K1ubls4zJNeFEBuIhcyU6mznrphnYMVpyAXnFN5Rni6cEW6CutOm7UEbHm4kyCMx4TOCZ5fiwrwHME0civ2NlPgJrGOlafTvmnum1CjcB5p+5l51wQSn2n8g1F16X1dOGDClsasbA0H5jgOUuns7GADNquKoL/4VRTAZRHEtXW9SKZCB5dvEtUWVgWJEF3MBteY80Jt3Sm8HjXE1pbOfh4D/U01nUxZ7M37BXNmx/UQx5+FHIdVbUCPU0li7sASBPu53sWhQDLc79WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM/Bma/BKWxvy6vX/sVJUSHVTaipMvmLbY8eITM9a6k=;
 b=l59E5ecordrP/iw7+oPGBdr8pr0m5CN/sCY45ZT9NyledHkp/jTGv55E8XUiK4XigLyLkFITgB+loFswfVMhbUP27C1DRqxstZsXki5prPk9A/t+KpVwKczTH5DWa74s2wWvCxvJAHAYEvM6BQLKYnl9lxJdO1PMdCQhhSIfpA+j62780MXpEcd836vg3u77W+cE2cPvXrAvOJ1FNHhWKSJR2ywQJDmUeLyRF37NhTnP0hvCfEnCpl2Lq/4fQAeMQQB1BB0YsOIIY8Dj6KkOGi9xmH7/rAdx3badU3BTGWhmWxjPF+/fJuLF9sWv5DeZPDGg8V4kcfek5VmMwEU7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/Bma/BKWxvy6vX/sVJUSHVTaipMvmLbY8eITM9a6k=;
 b=2a3WzlnIk4a1gpxvRZ4SNBpyUI8NMTyBZ2oEAWx78drQ3nWVC/mFXz6xeTsM+y3PHkW6wv1Yhu9uxYgos9ffeRI1NnyBOfribzpVFrzzmuiEUEU9UquLvVu7Kh43Q8Jm6wVbnQn74LWlMggmobxro7gITDX+p/n6Z0YeRX0usLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 21:50:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 21:50:14 +0000
Message-ID: <cd2a2139-58f2-d863-ce60-2da09948e825@amd.com>
Date:   Thu, 8 Jun 2023 16:50:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 05/26] cxl/core/regs: Add @dev to cxl_register_map
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-6-terry.bowman@amd.com>
 <64822c1c56568_1433ac294db@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <64822c1c56568_1433ac294db@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0981.namprd03.prod.outlook.com
 (2603:10b6:408:109::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1345d1-704f-4c36-84cd-08db686a5719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEKIUCPpaTkhveDzpNJA7qvP0j5vh6Mfz5f+e/D7HbKrX3NH36+bQUKDeqqRLzSXFhHEdCbwNJAa5ZgDcZyLtrpbexhTccyvBTEa/VGjriLwmT6bouwAtpxIwG9pO6D39zHelOfJo5W/9bWWEzr153G/SpjEAX6kaLJQv/EO6Lzd7rHMpSTZaZGnp7Llrxr56rABHKeEGhTeUS2xK1q0ZskP2Xvu8ckiB9X6fHZVFV38a2vBEM3LlsVBWlAo9nS9VVw90srgquWM4N3N+YiYCaR+a1qANYEK6TTYDbSFLqVqYkQdLNmUUObua7stlRdOZr297M/MfRU3az5sBEiZAOukCMJFJeQqhGd8igRb54/aI9W4TAtbqzT0+Sr+BCXje3iaJOudlYGnouw92Oe4Tr2DEbrTnAOErunb7m6wDKAcOCDi31Cb8NNJiWRxRdWgsrpnvo1MdoWf/41PpmCeHJWL/Zps87DHGQ2VqZbQTHz6F6UeNmeUwq+zcKDlCB0MqMP3IOzW+2L+oEJP1zgs93PPFXtMBhGQDi/ZaGISCcLkH2oF7tdSEZfufh6R/ZuP38PKq6uDJjJIQZrj+93LsWhzkMetXyNBKcnkcd0wX4dJPaPCYZRLx7yfkuUCLAaWCfI8EfXhESr/Z0xk1v3qVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(478600001)(2906002)(6486002)(6512007)(36756003)(2616005)(6666004)(53546011)(31696002)(86362001)(38100700002)(6506007)(186003)(5660300002)(316002)(31686004)(8936002)(8676002)(83380400001)(66946007)(7416002)(66476007)(4326008)(66556008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkF2OERtZ1dCeHFFbHpwWWpDNlJyMTlTVTgzQkZXdEpHVlNQT1U1Tm16aGFp?=
 =?utf-8?B?R09pSit2VlJLMUlkaHhEWDNIdWFzbllNdjltTnhKQVROLzQyNUtnNnlJOTdM?=
 =?utf-8?B?VndqcmR4dVp4YmdCYkdyTkF0NURjOWU1WWhNVUJvU2RNcFQwT0RPRTI4SHlM?=
 =?utf-8?B?aWdndU8xcFZvbWRwNnVEM3FSRUVZK1l4eWtjN2VXVDV3Y25CRkpGNm9XOStu?=
 =?utf-8?B?TjBON2RKRzFHcWFZSkhGQTl1SFIyRXovOFZkN1JqelYybE9xOExxYkF4cWVX?=
 =?utf-8?B?SmJuZFNkcTNSQ3N1SlVUMnNwVHZvVWZpRXJtSDRveFROSWl0TG1mMWFVUHVh?=
 =?utf-8?B?ZFhjOEZZODNSTzlZRmhLZnp1bmRIYkowdnpjMzVmS3ZJWkNLWFFUTG5TajJV?=
 =?utf-8?B?bWltSDQrUkU0WGZjME9WWlNnR0FuWloyRG01c1NManhYenRHTHVvY2V0Ulc4?=
 =?utf-8?B?QXpTdHJTYWk2Nkt6cndxL2JHR1hqTG5Kd1M2UnA2bXBKNC9IOE9palREdmxQ?=
 =?utf-8?B?NndEbmNJTWNMQklOWnNITlQvaDlPeDFCTk1XeFpXdWxDMnJnaFBjYnAyQy9P?=
 =?utf-8?B?OXVrc3ozWG1SSEtLTWxLSWdRRllid0FKekNoeGorZEJTME9IdnJKWUhQMXFI?=
 =?utf-8?B?ZkNNUy95ZmpTeDFnRlFzZ201dWZMUUx4d01HcENhR1FjTjljbEI1aEcrK1ZB?=
 =?utf-8?B?YVNkWkdydXppc05rY045NncyOXBEYXhOT2VkeWIyeGh2VXhPdVQrc2FLL0o2?=
 =?utf-8?B?blVuclRRcTBFVWVTY3AycENDUkNyTmJHcXhKNE14UWRUL29abEFXemduT1Vq?=
 =?utf-8?B?NVBubWdKM3NDUkdHU3kvU0lRMUJyMEI0aGFocHNRSDRDRUJCcHZYWjRxblQ1?=
 =?utf-8?B?Z3Uyb2tIWWZkMk15aHVoaG95dm8zbEVzengza2Q4eEtoU2o2dkRNSmNrZzVi?=
 =?utf-8?B?SFZKaFdBdGRZdUZYZ09tTlJTdnkzd0ZFdW03cWc3MnoxSHBFamV1bGhnM3hS?=
 =?utf-8?B?b0pmWThDcWNXSU9kVk1oTlg2ZUtqYW1yUEh1VVJqVEJQRG5TcWVDemsrSmFU?=
 =?utf-8?B?bXN0TEJtWVhtTHFhT1lEMVZBaEdDQ3BlajhOcktZb1JaNHl6WEdueGVLSjZR?=
 =?utf-8?B?b0JTV0dqWWpVRWVkcDBmMmx0U2tnNEpZWUx4aEtBTFJLRUFKd21qZzcxVHFh?=
 =?utf-8?B?OG5kRHlTdklvWlpEK2dabzVBUUtGSDQyLy9Gcm5SdU0wSVZsTjFSU24relVO?=
 =?utf-8?B?RHNxa0FjVzdqdldjcys4R1dUcHBFdkp4M2lWK1N0OWkxaWtlQllNZUdqOW9U?=
 =?utf-8?B?RVorV2FBaUZncXVIbVp4aFBLTXhuS1k2VlFibitBb3A4Q2R1bExXa3k4eWlw?=
 =?utf-8?B?dEsxQU4zZ0l4SXFTQ1hjNzdLRkNtdVY4cnl2aUxxdlYreFFHTlFMNW9iclRT?=
 =?utf-8?B?cy9vVHFabjYyYzkybG15VDJMQ2FndnZPdXg1WG96bGFvWmhiZUR3S0pSZDgr?=
 =?utf-8?B?b01mVmhqNS83RFNwMTRBcnVVYzB2NEVDMGlrK1NPWEx2Y2hCRVpqZjhJdmtm?=
 =?utf-8?B?ZFpiTmVodVpRYU54Z2twZUxabDY5YVF3SERFMFFkRmo1VFRVd0ZPeGpBc2Vr?=
 =?utf-8?B?RnBpd1FsZlU3U2xRdWN6VmF3eitjUFh1YnBOZUxzSkpEdTRYcUZCN1lSOWYz?=
 =?utf-8?B?Qms1T0hjK2xjNnVPY2J2SzhUREF6S054NkhPMVNqL0t1RVpnWmowRG5iZGFQ?=
 =?utf-8?B?V01rUFhXelVxWE5BTFJJL2ptNFNseUQzbnl1bDJLM0oySDdZNnltVjREcEpl?=
 =?utf-8?B?c1AyNW1JcE9hUHVEaTdrWDZ1TFBzcEJYelRRUnc3RmZQcnlnZ0hQZE5pbWdh?=
 =?utf-8?B?RE5oL205cUNPVHRqTnBOWUFVNDJ3bUZuMFlHOFcvcEh6aEIyUi9hOUsxWTBS?=
 =?utf-8?B?Y3NRWjRzRlVWWDd6bVppUk5ocUM3YVU4LzRmTzViSlZQbWV4ZjVzWS91ZEhl?=
 =?utf-8?B?R0RhM0cyM0VmQXVReVZVNjF1MVV6Z1hTS01TUzR4cjZ3bzBUV2FJQVFFUmRB?=
 =?utf-8?B?TnVmNUFlVzRLcUhncjVyK3FJS2pNQXIvcU5nR1BkeHJTNFAyVUFyN0Rzbzhm?=
 =?utf-8?B?SUJ4UG5pUUdTZDMzaDdzTEU2QzZCK3c1OTJBR3g1NjdYalFZOFlVWE84eGgr?=
 =?utf-8?Q?iAAMgOOvBP3dTmPDwrqTYCt4U+KueITGPwpQ6VYW4oq+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1345d1-704f-4c36-84cd-08db686a5719
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:50:14.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC8X3Yk0hU7xRu7FnPPHuk7mhw4Np81zSYroCz5iRLmSoKY/t9jQXOJjriS3oz5ZAo126v66ItOuQOtHSrKzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan. I'll make the changes you mention below.

Regards,
Terry

On 6/8/23 14:29, Dan Williams wrote:
> Terry Bowman wrote:
>> From: Robert Richter <rrichter@amd.com>
>>
>> The corresponding device of a register mapping is used for devm
>> operations and logging. For operations with struct cxl_register_map
>> the device needs to be kept track separately. To simpify the involved
>> function interfaces, add @dev to cxl_register_map.
>>
>> While at it also reorder function arguments of cxl_map_device_regs()
>> and cxl_map_component_regs() to have the object @cxl_register_map
>> first.
>>
>> In a result a bunch of functions are available to be used with a
>> @cxl_register_map object.
>>
>> This patch is in preparation of reworking the component register setup
>> code.
> 
> Looks good to me some small formatting requests below:
> 
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/hdm.c  |  4 ++--
>>  drivers/cxl/core/regs.c | 16 +++++++++++-----
>>  drivers/cxl/cxl.h       | 10 ++++++----
>>  drivers/cxl/pci.c       | 24 ++++++++++++------------
>>  4 files changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 7889ff203a34..5abfa9276dac 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>>  				struct cxl_component_regs *regs)
>>  {
>>  	struct cxl_register_map map = {
>> +		.dev = &port->dev,
>>  		.resource = port->component_reg_phys,
>>  		.base = crb,
>>  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
>> @@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>>  		return -ENODEV;
>>  	}
>>  
>> -	return cxl_map_component_regs(&port->dev, regs, &map,
>> -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>> +	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
>>  }
>>  
>>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index c2e6ec6e716d..3b4e56fb36a8 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -199,9 +199,11 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  	return ret_val;
>>  }
>>  
>> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>> -			   struct cxl_register_map *map, unsigned long map_mask)
>> +int cxl_map_component_regs(struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask)
>>  {
>> +	struct device *dev = map->dev;
>>  	struct mapinfo {
>>  		struct cxl_reg_map *rmap;
>>  		void __iomem **addr;
>> @@ -231,10 +233,10 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>>  
>> -int cxl_map_device_regs(struct device *dev,
>> -			struct cxl_device_regs *regs,
>> -			struct cxl_register_map *map)
>> +int cxl_map_device_regs(struct cxl_register_map *map,
>> +			struct cxl_device_regs *regs)
>>  {
>> +	struct device *dev = map->dev;
>>  	resource_size_t phys_addr = map->resource;
>>  	struct mapinfo {
>>  		struct cxl_reg_map *rmap;
>> @@ -302,7 +304,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  	u32 regloc_size, regblocks;
>>  	int regloc, i;
>>  
>> +	memset(map, 0, sizeof(*map));
>> +	map->dev = &pdev->dev;
>>  	map->resource = CXL_RESOURCE_NONE;
> 
> Use a designated initializer here like other locations:
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 9230b419988e..bd955fae65cd 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -304,9 +304,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>         u32 regloc_size, regblocks;
>         int regloc, i;
>  
> -       memset(map, 0, sizeof(*map));
> -       map->dev = &pdev->dev;
> -       map->resource = CXL_RESOURCE_NONE;
> +       *map = (struct cxl_register_map) {
> +               .dev = &pdev->dev,
> +               .resource = CXL_RESOURCE_NONE,
> +       };
>  
>         regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>                                            CXL_DVSEC_REG_LOCATOR);
> 
>> +
> 
> Remove this unrelated whitespace change.
> 
>>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>>  					   CXL_DVSEC_REG_LOCATOR);
>>  	if (!regloc)
>> @@ -328,6 +333,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  	}
>>  
>>  	map->resource = CXL_RESOURCE_NONE;
>> +
> 
> ...and this one too, before Jonathan notices.
> 
>>  	return -ENODEV;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a8bda2c74a85..095b767c21e9 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -231,6 +231,7 @@ struct cxl_device_reg_map {
>>  
>>  /**
>>   * struct cxl_register_map - DVSEC harvested register block mapping parameters
>> + * @dev: device for devm operations and logging
>>   * @base: virtual base of the register-block-BAR + @block_offset
>>   * @resource: physical resource base of the register block
>>   * @max_size: maximum mapping size to perform register search
>> @@ -239,6 +240,7 @@ struct cxl_device_reg_map {
>>   * @device_map: cxl_reg_maps for device registers
>>   */
>>  struct cxl_register_map {
>> +	struct device *dev;
>>  	void __iomem *base;
>>  	resource_size_t resource;
>>  	resource_size_t max_size;
>> @@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>  			      struct cxl_component_reg_map *map);
>>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>  			   struct cxl_device_reg_map *map);
>> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>> -			   struct cxl_register_map *map,
>> +int cxl_map_component_regs(struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>>  			   unsigned long map_mask);
>> -int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
>> -			struct cxl_register_map *map);
>> +int cxl_map_device_regs(struct cxl_register_map *map,
>> +			struct cxl_device_regs *regs);
>>  
>>  enum cxl_regloc_type;
>>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 0872f2233ed0..9c1b44f42e49 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -274,9 +274,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>>  	return 0;
>>  }
>>  
>> -static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>> +static int cxl_map_regblock(struct cxl_register_map *map)
>>  {
>> -	struct device *dev = &pdev->dev;
>> +	struct device *dev = map->dev;
>>  
>>  	map->base = ioremap(map->resource, map->max_size);
>>  	if (!map->base) {
>> @@ -285,21 +285,21 @@ static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>>  	}
>>  
>>  	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
>> +
> 
> Ditto.
> 
>>  	return 0;
>>  }
>>  
>> -static void cxl_unmap_regblock(struct pci_dev *pdev,
>> -			       struct cxl_register_map *map)
>> +static void cxl_unmap_regblock(struct cxl_register_map *map)
>>  {
>>  	iounmap(map->base);
>>  	map->base = NULL;
>>  }
>>  
>> -static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map)
>>  {
>>  	struct cxl_component_reg_map *comp_map;
>>  	struct cxl_device_reg_map *dev_map;
>> -	struct device *dev = &pdev->dev;
>> +	struct device *dev = map->dev;
>>  	void __iomem *base = map->base;
>>  
>>  	switch (map->reg_type) {
>> @@ -346,12 +346,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = cxl_map_regblock(pdev, map);
>> +	rc = cxl_map_regblock(map);
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = cxl_probe_regs(pdev, map);
>> -	cxl_unmap_regblock(pdev, map);
>> +	rc = cxl_probe_regs(map);
>> +	cxl_unmap_regblock(map);
>>  
>>  	return rc;
>>  }
>> @@ -688,7 +688,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
>> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>>  	if (rc)
>>  		return rc;
>>  
>> @@ -703,8 +703,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  
>>  	cxlds->component_reg_phys = map.resource;
>>  
>> -	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
>> -				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>>  	if (rc)
>>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>  
>> -- 
>> 2.34.1
>>
> 
> 
> 
