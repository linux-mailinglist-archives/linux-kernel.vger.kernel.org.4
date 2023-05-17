Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5067060E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjEQHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:13:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA021AD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGDX+RGp3/T8Ugljr6Y7UhcbP9pAde3+vJF2UNMWFkhUsyJjNjStyEIlt/CIBQe147LnxwhNp7EZCtmILJoYodNpkq0SDxB/FF8LZZQRpSynn0g+uiegS8GFRc6otgxs+HIpOSaW6IJp1WH/45VtYNLgyhgf0KxVnvq+KTiiGjiwO5wluxpSGtWHiWeCkAmT5NA0iMEl0TIjZ+dg7ez79cxni3UsO3p31JvfQOoUZD1Zsj/Gv337yZrAxucdeBRucLHYlfOztXfc1DCEtKLe3s0oEA1JbkLRVBtCvUpGb+nF0qn7INswVv6Owrv1MR63YN41lBjWP2RpjvVVZtJYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drVEDmtdlO1dJ+excufrnv1J3IN2NtE2KnZJ0uccWs8=;
 b=Co+UgtDk0+Lh7sLJ6L3l+I5nKQT4vFzu4CunZQm4c0tufInNdqi4iDe/bAJHXlyqPiMst84yfA1q/9enPuzDePcv/CQYRQj9fUyMsGg8UekAxvtIgMyRwmGiODR8qfPonMJp/XiOkzThR7qo6vntebwki5um7F1XxgfgUnUjhroCK4nvU4LznWzmXkNY564pg4ooxN87ikJrwnYKezRI/SHqarMQPuvRxIPyJFZtYPjN/7hURFMbplbdOnH6CBypMVWeBxPuptdYs8irZt3QWQW/+9iKcg5NSIagfOUJ3PHXvSfWSPNVtH4D9sDrFuxLc8m5Z3K9k4XXP6A2Sso2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drVEDmtdlO1dJ+excufrnv1J3IN2NtE2KnZJ0uccWs8=;
 b=N7x3UEO/nZARTn1aYjrGxY5dh342hg/IW2y+tHZh2zBMGEEswLcZyTPjiA240LrwYdQKfZpbes0m3u8TdNcD4+eG+whUe9G78p8bv/7Gzr6HeesaQPmFhotMRzn7iyLJ5DdtA5Kn0cuvxDvUFgTPYojcMGLXLbcd+RWwQ9y3pl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:13:11 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 07:13:11 +0000
Message-ID: <fea77516-72ab-afa1-2336-ae9174e7bd7f@amd.com>
Date:   Wed, 17 May 2023 12:48:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/9] ASoC: amd: ps: handle soundwire interrupts in acp pci
 driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-3-Vijendar.Mukunda@amd.com>
 <bc58e1b1-8bce-3894-f840-57dd2d802932@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <bc58e1b1-8bce-3894-f840-57dd2d802932@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: aae5182d-3cff-45d7-1d48-08db56a62c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anbMGR3u8VGyHXYWiq2UNXHoDqPY4QuEHFNOClgIK+LIe9avmY8HmhR2zTMa/S+jmIyo+vHfC+VhkCWSq6QAYXjO1cPdyuVVducJ/I4rHjh6tL7GKPIn4Ch5tuscISxf0KWcJ9YkO129psOb+b6u0R5qJtYCLPAXnis2Umb4pczrUcS7HxwUNoeQ7KgRm8gnTQoCteB1ppHq08j9mZuMYW3ANvdbXVXLH/OC2BlDUP/7X9qEBrok956H8QzqMIcxCilttEejKie2masQHOKpwG5kjKlhVmvX9shKxaLwXPgQzDc9b9KlfaHu2u8uU+6P8zPbDWgx/E3vvZ45fBfIN3olBsnHvIZqnZsdzsWG+Rsgau/3qNX52IRyPHMRirMz6766eQVUDlIkk/5sHQ+/PvwOgKpixplxOMsJf0NS5Vor/zTCNXI8PUy0ANfFW3iWg+9z+chCOe5kzwtYhVuxwDkKF+S2gGeY3Sa+jEpZtp6CnJX8cAj7H6841kBD7iS91dQPnHv+GiPnrTL/OR0KUWmMlzJx7HtPeTQRkh+sMV8Mlt+HIHZk4+FEtkc4h2Rn1tqs6A2xhjF7YIwKJx5Yw6vJcC51kqtAdNili/gsqOeJ9HO1bEfNSBXRw8stEP5fb0uEe+RJX5cry5X/wC8Gew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(5660300002)(38100700002)(86362001)(2616005)(31696002)(66476007)(66556008)(66946007)(83380400001)(6506007)(478600001)(6486002)(53546011)(26005)(186003)(6512007)(54906003)(110136005)(8676002)(8936002)(4326008)(316002)(36756003)(41300700001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZlYlFabklKd2NRU2ZkelVSV1hMMDlpUDJ2aTdLRVVyK0Nwd2xhM3hvOU1x?=
 =?utf-8?B?anlqd3VvdW9laUV4WDU4UnJTbHpKcXh2UEpHN0xsd1RlSzlhUkUwR25OVHNX?=
 =?utf-8?B?MkJ3eEs1V2ZsL3hCUjcvVEVQZjFnc01RV0VCLzR0STZGOCs2NEpDNUFZZzBr?=
 =?utf-8?B?b1ozdnZ3WCtaaE4wQzZJMWVKZ0RWc05pcStyZzhPeXNBRVVYdjErMFNGOXUr?=
 =?utf-8?B?a2RYMlNRNi9UUU53cFRVRzRISjZDOVc0Q3hKTERyOGY4MldhVTkwU3BycExz?=
 =?utf-8?B?QWZGVWlNaENXOWt3cTNuc0d2MWpYemRPV2RaUGdmK29zNnhyQ1pVblEveGNP?=
 =?utf-8?B?QnNGSXNHeUUvUkFCb0owWExuVzFjbmVMa3JZcUZ3akkrcmczbDcxdzNJNjNK?=
 =?utf-8?B?ajBWQjBHdVN1SFZtVFhmSGxSenVnMVp1TkVsVityMDVsODU1ZmZhaVM3MlBx?=
 =?utf-8?B?SitsZEdWVkh0d0IzNzhONVB5blFYdE5ucDgraWRmSmpGaHhWUkxqUGI0enpH?=
 =?utf-8?B?ZXVuYnJYNTAxVFZBMUhLYmIzbk9DVmZGQWh4MjVFYWlDRERGejFFWFV3bmNQ?=
 =?utf-8?B?RS9wUjBWSU1IeFZRSERDRTlaRXUvUnlzamR5MXJXNENWZnZicEtYQ3hOTGZY?=
 =?utf-8?B?N1hQTUFYclljNmVoM3JQZVJCanh4bnpVLzAxQzZhZExHSVltOXhia3Z6MUMr?=
 =?utf-8?B?cUF1WE5uWTBNbGZOa3g2L05KQ0FBdzVBMUwvREs2bzFneHIvWjRNYzI4Tmpn?=
 =?utf-8?B?NlRHVkt4RkFIM2xwV09pVzZYWGsvYTNHUGZSSkwwS29sdUF4dG91cWVtYzQz?=
 =?utf-8?B?SjhnUXl1SEpCcUNHMWVsNFBPd0hDZEU1OWV5OUVDaUF6bTluZE9MUHVEM0J1?=
 =?utf-8?B?d08zMEJnaW5PQXpEck5NaFFKY2dZZmVoUzNUSDRKTkE5SW5yK2lxeHFxQU4y?=
 =?utf-8?B?Qk5iaWROVGRFSlRGdjNuZVFTcmcvTy9jWXRPMWJGSUNmTGdiaVBjSFI3SjUw?=
 =?utf-8?B?K3R4N09oZFhwdW1pd2Vja3lGeHNkbHkxblIxUW5RTE1ENU9WUmFoZmc5aU9n?=
 =?utf-8?B?a2NQK3RNQkRYNnRTMEFMKzVkbFljOFNqRUNZYm5na1JiSW9rTWJHTk56VGVj?=
 =?utf-8?B?WWVwNzRraXVhTmh5TXZiN1NEbCs4QTdYNlpjU0lSMmJsbXZrMjYxZnBwV3RP?=
 =?utf-8?B?dm9KQ0hYWmNQRUNWU0JtMGVrQzZhUW5aMm1vSTFzODJNZ3FPWUxHbHJoVEc4?=
 =?utf-8?B?eFVQdUFkeFhGSS9sZGk0TmhLKzlrRjhpc3BwdEFEMGJYL1djSUF4a0s2MXJS?=
 =?utf-8?B?d2ZLTjdRR0QrUGl0QzNnMlhRYkJEckVYRXJJVk9DdU1oK3RsamROdjNmT0xz?=
 =?utf-8?B?dXhHV01VQ0FtbWNJNmR6NEYxWlVoek5qdThONmlJTE9odWxudnEyYzVHcERr?=
 =?utf-8?B?eGVhcGZxazlNUDBKc09uUnlKdHFURm5DdklJVWhjVm9KY21vY2dFTXRkTDF4?=
 =?utf-8?B?T2loTStEVmFJdVZrQlVhdkpwQXF6WGtPUW4rMmUyc29tN1kxMGhERkw4SDFK?=
 =?utf-8?B?U1UyS0Zlc0orZlFsOC9sbkhTS2hWZDVjSEpqT3diTXE4YTBoVjFFVkwzYSty?=
 =?utf-8?B?S3p0T0Fkd3prek9aRjIxSE95b3hhZmhZMDAweTNKa24zUWdPMlVEZG4xSTVP?=
 =?utf-8?B?MW12SDAzb2lVSEg0eHJnTmp0YkRjUlBWb2dpUnZ4WE92bDFHVEJZZjVMRWFv?=
 =?utf-8?B?TTVUc0V5ckxheWpZN1JqK2lIOG1mN1hYWkZRRENvSFc1WnBZOThPZ2VxMXpG?=
 =?utf-8?B?NjVqSnlSWGwvZjFTeDExMjJ4Uk10N0NHbEc2N3QzLy9oY1R4VWdSaytoUFBm?=
 =?utf-8?B?akhUZUtKc0xySWgrVThHcmx0anZXbVRVKy9ucC9xZWtFYVY4cm8wM2lOcEcy?=
 =?utf-8?B?MEorUmVScEs1MDJlSDdPVWp4ZWcycGxwK2l3N1F5OHFQV0N2d0dlVnYzVU0z?=
 =?utf-8?B?UUt2RzBMbENuN1J0akhsTkY4Sy9wNUlOVklSKzUzY3U0ZTJtRnNQM0RiY1V0?=
 =?utf-8?B?WXR6TlRMWmR3NU5xQnBVdnNnZVg5bGs2dVdKR1V4ZGkrRnJPOUdMU0w0VUtt?=
 =?utf-8?Q?YC/zsojNuAZ5p1JIfGGAoXIL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae5182d-3cff-45d7-1d48-08db56a62c09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:13:10.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw/g6Jej1bEbh6ZkA/1NhQ1pU8gMgh8Vg6YBGz3BZzvDCjTvLzfBulHAQ8DHOPOl1InVKj1CIqOP8ie522oDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/23 20:09, Pierre-Louis Bossart wrote:
>
> On 5/16/23 05:35, Vijendar Mukunda wrote:
>> Handle soundwire manager related interrupts in ACP PCI driver
>> interrupt handler and schedule soundwire manager work queue for
>> further processing.
> "SoundWire" please
Will fix it.
>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h  |  4 ++++
>>  sound/soc/amd/ps/pci-ps.c | 42 ++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index f27f71116598..faf7be4d77c2 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -67,6 +67,10 @@
>>  /* time in ms for acp timeout */
>>  #define ACP_TIMEOUT		500
>>  
>> +#define ACP_SDW0_IRQ_MASK		21
>> +#define ACP_SDW1_IRQ_MASK		2
>> +#define ACP_ERROR_IRQ_MASK		29
> Shouldn't this be in 0x representation or BIT/GENMASK?
All above IRQ mask fields are bit positions in the register.
Will change the name and representation in Hex.
>
>> +
>>  enum acp_config {
>>  	ACP_CONFIG_0 = 0,
>>  	ACP_CONFIG_1,
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index f3aa08dc05b2..6566ee14d300 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
>>  static void acp63_enable_interrupts(void __iomem *acp_base)
>>  {
>>  	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
>> +	writel(BIT(ACP_ERROR_IRQ_MASK), acp_base + ACP_EXTERNAL_INTR_CNTL);
> BIT(FOO_MASK) is very odd.
>
> BIT(ACP_ERROR_IRQ) or ACP_ERROR_IRQ_MASK?
We followed register field description name as it is. It denotes a bit position only.
We will change it.
>
>>  }
>>  
>>  static void acp63_disable_interrupts(void __iomem *acp_base)
>> @@ -102,23 +103,54 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  {
>>  	struct acp63_dev_data *adata;
>>  	struct pdm_dev_data *ps_pdm_data;
>> -	u32 val;
>> +	struct amd_sdw_manager *amd_manager;
>> +	u32 ext_intr_stat, ext_intr_stat1;
>> +	u16 irq_flag = 0;
>>  	u16 pdev_index;
>>  
>>  	adata = dev_id;
>>  	if (!adata)
>>  		return IRQ_NONE;
>> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +	if (ext_intr_stat & BIT(ACP_SDW0_IRQ_MASK)) {
>> +		writel(BIT(ACP_SDW0_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +		pdev_index = adata->sdw0_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>>  
>> -	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> -	if (val & BIT(PDM_DMA_STAT)) {
>> +	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +	if (ext_intr_stat1 & BIT(ACP_SDW1_IRQ_MASK)) {
>> +		writel(BIT(ACP_SDW1_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +		pdev_index = adata->sdw1_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if (ext_intr_stat & BIT(ACP_ERROR_IRQ_MASK)) {
>> +		writel(BIT(ACP_ERROR_IRQ_MASK), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
>> +		irq_flag = 1;
> it's not clear what this does? Looks like just filtering out interrupts
> without doing anything about the interrupt source?
When ACP error interrupt is raised, As per our design, ACP IRQ handler will clear
the error interrupt by clearing ACP_ERROR_IRQ bit in ACP_EXTERNAL_INTR_STAT.

To know the error source reason, we need to read the ACP_ERROR_STATUS,
ACP_SW0_I2S_ERROR_REASON, ACP_SW1_I2S_ERROR_REASON registers.
After reading the Error registers, we need to clear these registers.
Currently, we haven't added read register operations for error reason registers.
This is for debugging purpose only.

In Current context, we refer ACP_SW0_I2S_ERROR_REASON  register to know errors like
Sound Wire Bus clash detections, Command and Response Errors, BRA mode errors,
FIFO underflow/overflow errors detected for SoundWire Manager -0 instance.
Similarly, ACP_SW1_I2S_ERROR_REASON register referred to know errors detected for
SoundWire Manager instance - 1.





>
>> +	}
>> +
>> +	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
>>  		pdev_index = adata->pdm_dev_index;
>>  		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>  		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>  		if (ps_pdm_data->capture_stream)
>>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>> -		return IRQ_HANDLED;
>> +		irq_flag = 1;
>>  	}
>> -	return IRQ_NONE;
>> +	if (irq_flag)
>> +		return IRQ_HANDLED;
>> +	else
>> +		return IRQ_NONE;
>>  }
>>  
>>  static int sdw_amd_scan_controller(struct device *dev)

