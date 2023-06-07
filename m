Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4E725490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbjFGGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjFGGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:43:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD30196
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH/vgFioftziXR8lvoYI/eb4To3kFuGY8fxV6MzYlil5CnRvMIgdvz//GecujNgSfvXIxVSvuZYeavsle8T+6SW3mri6ZZ6GYc7MvLEQjvKFhjiI+b5CVyOWYaV3IqoaDqqCK5xaXLUaoEaQyj8qU2v9F4zkIgCSmPkMQba5771sPQzK0rFeZR87CafAF6CqYHcplAJjw3QjsggTrd8l8y6o2T/RTeo8mwOdhr33EixNOGXpGbJAqwoRmEcVSx/I5yySi9IpfbihSqyMBTtHoSW+q5aSdJlnj7G5Jk7/soYZDYyx82dZQeLPX94eRKXo4lr9hACASKCn8wowxfhycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzOLwDmJ6fx8ONd7/8CksYbnNb1UfdJEYCQ/DOqDduc=;
 b=jmdxIYLz8NCZQjwTzJ/s+C43RqSPcf0xp3tkJw9n3ZsS122dxnq2tkyCIAEd/As+70h+f87J7oq0EzAYQcuAmscLqTthnJC0YHFE461epC2GUCt9aTiaPtKXQJwYOY5mFsRFxihazLlT70AJIQP4a/s0sExOokDyNCoxj2W7RlMlrnDYLI5hlOeWa4GSOn01DLvONRjGkeFP41GvB/qSnza6iVr2lfttnGq1CR9tBPwY8mQ5Tz03E/VT645RQ8BNy3h//sxklVxlA9MZybXfptdguo8dbIxxgf2l87OCrbZRZeG0PBkMYamHrLIAMxrKXmDJQfCX05qaTm6FvzN4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzOLwDmJ6fx8ONd7/8CksYbnNb1UfdJEYCQ/DOqDduc=;
 b=GnWkTRq7lxjltlOETjiZ9DQ5kfGA13JKYZjozcanJxmeDp+qZEH7SZ+h7dzlA7YVhHgYJvmtq6c8W0NLxn0HA9emqoTQafH8eo5XTljzr/5EYH+hFmI2YRUtgG81h7lyA3GgG2R1CpVhVr9/VDsz5VdfBg8EiGJkQoJ4qjqjEO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:43:37 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:43:37 +0000
Message-ID: <56694c50-fa81-8950-7dd4-29101d2fbdcb@amd.com>
Date:   Wed, 7 Jun 2023 12:18:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
 pci driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-3-Vijendar.Mukunda@amd.com>
 <652a07e4-49be-7715-cc77-b05f1727a496@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <652a07e4-49be-7715-cc77-b05f1727a496@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 98102ac8-9943-4cce-6a40-08db6722858d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leogWcz3I1Ur5hyzXRxZ54Zw1Hj+LGpDFFgi4EUkdT0afP0CC0o4+0Q0AcSoS3t0FZJ7TNwTIEFndevauTNcYylRHP+t1XelqKiyLooYemSoQDSbGafUzCQo/CnsIowF4jvAy5JJi6+blmA1zIO0Akty06Wxp7hXzSNaH84s1dkVyoFebtf2/WRtuQtytzcXuKPMt9aSlNI/lQqhZZsqa17k8DbVSYS8M7RFGn3emZqanvhYk50N/Tyx9Wqi0OMZFBIwneWiW4yng4miWcfiR7ju/sZYLjrefVMNL1gspXcDKnb9iQ0k7H2kbBEFVFtp45okqsHrLu7QiZINWPc1peLcV/vqy9OavnbtYAhNkTdgbKWfLvgQRrRDsRMTnlC0/MzQTF0fd2/jR4SZ99xZ0Xyg35tqXzg+nNblsPVKKVW561332Bx778ZJyKye6aTajJuf16FrKickyzEKVyRoYiJiEMUvkdhk95rKEV6eh5wcedwYZNxLD7disko/1FqudOYqU0AjUh3V9650hoHjopAwpUYf8tdX5kNxyzVi/yz6EYyZZkhSQzG6wKBxQn0tftuoJsIn27UL0pkuTdutG7jrjwgIqBUD/ooFCd88ryVCkKqCOIo9+Sn/vsTbjjQLtRrHveMuC71aTsjswz3o5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(316002)(6486002)(41300700001)(2616005)(86362001)(31696002)(53546011)(6512007)(6506007)(186003)(26005)(2906002)(38100700002)(5660300002)(36756003)(8936002)(8676002)(66946007)(31686004)(54906003)(478600001)(6666004)(4326008)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xqTkhqc1JyRlpoSDNwMk1vYzBpUVBFa2JZT0VkVTB6aTZxbWluUlMvWi91?=
 =?utf-8?B?WERyTEIrZllrQ1F4TS9JYWsreDJIWEJmU2NkSXkwR01RYzc4QnptczlRdHZS?=
 =?utf-8?B?SUxaL1Z3eGFTZk9sc2diRVZUekE0T0VkQjVUczduQ3M2RldRQno1YXhlL1ZU?=
 =?utf-8?B?SU9pTEtTK3Z2aVgybkF1OGFVZXVGRWorYjA4TDNMZEhuMzZtVTZWTi9WK2Jz?=
 =?utf-8?B?RmxTbVhHcHNFbStCckszbjJhemh4blN4SThlTElEK0hGV2Yvc1IzNWZwbUNN?=
 =?utf-8?B?QWVXRkNDdE52V3E5UndWOU9wWGNDNzdPTUxDNmpVcytXdFdnSGtGaDYyQk1r?=
 =?utf-8?B?U1lQUkFQdzQzR0cxVzdJZWE4TlFrZ3hnVDVRZHBNVXlKUVU2QkRnRW4yZ0lz?=
 =?utf-8?B?cmdBT0VXdzd2SFF1YmphSHgrS0RHZ3F0QWhJMEYrMHhDMXh2UFhuZGNucWJv?=
 =?utf-8?B?dytTK0dod1VLa1RmYmV1YTFub3BQUkt1Lzl5R2JSTlFLMHNQM1k5Zk9XM2tl?=
 =?utf-8?B?VkJWbHZkL3lUb212MHNXbzNqRTd3SmZnVDNlcllzL1BHTjA4QmZMa3ROMjJx?=
 =?utf-8?B?RTZLM0xwS3laSzVUdkpaclZsRVhkL2FaZHIzdVFnOUNmbmFNYzFWM2RKVFhN?=
 =?utf-8?B?ZVdoZ3pURy85ZCtWcTVMdWJaS2hYUTVVdWtzb1daRnRJdDlQSlIxSVRXaEhT?=
 =?utf-8?B?NGt3eFB2SXpyNmtvcU9FZk45SmxBWHNXMW8vblFpTEtRTjFFV2phc2h3RzUy?=
 =?utf-8?B?V1FFY3hIMUdoSjIvVXg4dXRxNmhJTU56UHNNaUxRaDFtdnlLNytmNVd2N0Jp?=
 =?utf-8?B?U1o3VUFCMmFrblNtU3BwcFdVRXY5eVBFMHBSVTRpd2h4dzdqb0FneHBhUVdZ?=
 =?utf-8?B?ZGd4eUdyNER2Vmg5dGtXTnFrV1MxUVppWHltUG1CZGtXMHJXUFl1Y01INnVW?=
 =?utf-8?B?eFYrVkZ4Rk44TU5SOHFLajVQSTJROHVHNGJVKzVhZGQzQnJuczBSTlZFTDZr?=
 =?utf-8?B?aWZiMUg0b1IyVVQ5b29XenU0OVh4RThvcm83b0J0aXhHdUdSTWtQL25Na3Zo?=
 =?utf-8?B?N0hocmhtNHVCaFFvTEhmb0packIwZjljNG1sZmtBTmVxTE9yVU9lTzlOODE0?=
 =?utf-8?B?eXQxV2k3djhrVC90b2JOYmdONVV5T3ZaZldBTzlrb3huS0lVWGhkNFFzeGFB?=
 =?utf-8?B?dXBwb0RpYzFlZmh6cTZiRUlkbWYwR1VFUnV1VUc2dGFUWFlqY0xEMm5uTSt4?=
 =?utf-8?B?ZWozK05yRlpuY1hmQ0ZJU1NEajlDdXRkN1F1SFU2MENHYmJPMjFtaVFoWXpR?=
 =?utf-8?B?UlpXbHhsTWgrWER4Z2tuRTMyRno0M0NoRi9PRk5LOHhtNlR2RDBiakN3aVlr?=
 =?utf-8?B?MlB6ejFwc1JmS2Zva3pZeDlDVzk5YnA2aW8rem0ycm5oRWpnaDl0bHBVU0JZ?=
 =?utf-8?B?SGs1UFU5aS8wczE1MElWdi92OGJPb0N3RG4wbFZrdXl3ZXZrekdnTS82Z2Iy?=
 =?utf-8?B?SjBmSlRzL2UrWHphYkFEL0plNVptcG9hU3VkOEVRVkZtWGpNL1lVUSt3dzlL?=
 =?utf-8?B?QU9uU3dITXo1VEhDSU5vNWNqSVEzR1NMQlBjNGZXUm1KWCtKNkVmR1FLMGhP?=
 =?utf-8?B?b2pZV2dTQlMxbjlwTHUvRlBDZ2tlMlkrSVhxSVdvekp5c09ucGhhQW1mdWNX?=
 =?utf-8?B?NjFYejh5TDFEVXhNWlduQzdqZy80L3NDaHVIY2ptRlNZU00rNFFnN3RQSUJ6?=
 =?utf-8?B?L2IxQmxqUEJ5T050K0xUdUpxWEorS2FnQkk3NzNmVUlmZ1RtbXZybnAxWmM2?=
 =?utf-8?B?Vzg2WUtyZnh5Y3lFNHJwaVFkbm9XUXlLbXZabjJqVDFLMU9IeEp0alByRGZS?=
 =?utf-8?B?SzVEV042SjdKbG5ZUlNZS3dBTDRyandiNFppRTdFeE9IckViTHB2Mk5ielFG?=
 =?utf-8?B?bGJqb0RZLzNIeWxJZVBIcitONnQrY3NUV2Vma2J0RlRjeTFITGR5c1dvS1Rm?=
 =?utf-8?B?K05XVkdXblJzeUdsYzBTTmx3VnkvVE9jQW1IRVhFZ0daaCs4aTJLTlRGa2Iz?=
 =?utf-8?B?SHFHdGNWWE9SR25xRlM2Q2VHYXhaaFFicFpxYmFZQWQxWXd2Y2kxdUdDLzBJ?=
 =?utf-8?Q?yViCSq4AhILUpwmc6/uc2mcX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98102ac8-9943-4cce-6a40-08db6722858d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:43:37.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIrTxECxMwp6SLKB4+gOQfXU+H/dHG1RdyW7N2m1IhJfgqDyo6HSbaOGBgp5CktRazlbu3/SHJOmr+MifrLuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/23 20:19, Pierre-Louis Bossart wrote:
>>  static void acp63_disable_interrupts(void __iomem *acp_base)
>> @@ -102,23 +103,60 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
>> +	/* ACP interrupts will be cleared by reading particular bit and writing
>> +	 * same value to the status register. writing zero's doesn't have any
>> +	 * effect.
>> +	 * Bit by bit checking of IRQ field is implemented.
>> +	 */
>> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +	if (ext_intr_stat & ACP_SDW0_STAT) {
>> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +		pdev_index = adata->sdw0_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
> can this test be false?
No, this test won't be false.
It's only extra NULL check before scheduling work queue.


>
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>>  
>> -	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> -	if (val & BIT(PDM_DMA_STAT)) {
>> +	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +	if (ext_intr_stat1 & ACP_SDW1_STAT) {
>> +		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +		pdev_index = adata->sdw1_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
> can this be false?
No, this test won't be false.
It's only extra NULL check before scheduling work queue.
>
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if (ext_intr_stat & ACP_ERROR_IRQ) {
>> +		writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +		/* TODO: Report SoundWire Manager instance errors */
>> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
>> +		irq_flag = 1;
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

