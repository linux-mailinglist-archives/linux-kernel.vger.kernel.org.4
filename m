Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFE63D15D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiK3JEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiK3JEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:04:51 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85312098;
        Wed, 30 Nov 2022 01:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jasq9PrlOBr3YKqoEL8fxj1NxsrEJCFLoEHuQa8Env25lNLhysr8n8Nxz9qzI8UFfG4WoZHbrd7cJXctJ6EEPp0XwXM93YT/oriQx5vtTn8ygbYxZYp7xzw8BKTpKsfKBBocUd7MZodcxuCkTrFGjc35Jywpo85KfwCdt+Cga9TOmuXK+zorymdt8gXd5HqEsVtfPtfHUKcw/Rwen6KPH+7DBqnwbsK97MI9SJpV6SS3OJvETUXiy8xBQI1bABcabSo/ilpfVrKQZfYKdXR/Aez96u2snlaUamFz+vj8iMJxqGODM+JEbOZ1SkwFVtXNA6CpoGbrleK9N1zycfwFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxRyvm5ka5Jp9ZAZw0jVyiMjlDGMjQUuhqtsFS4umgA=;
 b=QXKscTEnwM7F4Wt+IUFiWmonj8DTqYlfJql1muU3BWC4frPc/28SBKlHSS176D+1vlqifmDkrhHxMUscBk4YBFTbwXPOxIrgb+2fAuMxeQ8niwKZJk/jcnZAlOyjmf3++GAO6BbGBmKhcWbWRqe7SFlaPSNVxWAt2qpkyEs2TwWWKxPs+1Pw+Trwa7ZOUC90b61TsgxhhQfp1MOsaDEbPNILta3YyMaC2GzcZjRBs6L4lr1OIJvx8d6m6oZaJwMdMrAZAOk723HKLpjiH9Rp7zT38xpCkWKCgioNTVXBYkvIiOps4RJkY4Xe4auF0D5lBRrav6wPRAuUEGHsXnkL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxRyvm5ka5Jp9ZAZw0jVyiMjlDGMjQUuhqtsFS4umgA=;
 b=wssuz8dsd97oIqR+pIvfznirIMozrsn9wdFm55+hjSmN5LqOOwANTuAvq5G3+Iljo7QBJ5MsaZaMKvmmrP5vx1FsEbStXFwX13O1YBbKT0JaWWkef6+p6I3STyuWBBt+9ADG8ajTBOIgqvraP1VcqZPuKzEUre7cMfHWUe1bvLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by GV2PR08MB7953.eurprd08.prod.outlook.com (2603:10a6:150:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 09:04:46 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 09:04:45 +0000
Message-ID: <b2d8b5a6-15a6-9cca-9f87-fbbe1acfa4f3@wolfvision.net>
Date:   Wed, 30 Nov 2022 10:04:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/3] iio: magnetometer: add ti tmag5273 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
 <20221129064540.3218982-4-gerald.loacker@wolfvision.net>
 <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|GV2PR08MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 0397f3bb-8761-46b6-06c5-08dad2b1ed2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnTaTzwKRmOwo+UMayFU/+mf0ZpXjfWYac6w1J4AwfzwZzsqRWWE4BjyhwKW0QyruvQN9wNIwNkgdopWLlYtvSwMpBitoTGdAO0FCdvwcR8jSjoXGnnu84UpD8A4XItQyIft4aZKgPTY1Yb9Wr6emfWyt7NOvlYeDPb3m84BN+8NX7oRHw8HtpjHXyouSv238xOD1DXSsiGEFBxibL1WngsBdb6YCdQIBUMsWdO1eOD5BghgKGTncRMbbs8DJus1c4TlizYyFtuXwF0KD6Arh8aRDj7c5q8LKsairCOPlHqMpP1ZSN2R/mnpzy9Ta8xYG9YlBQ9056p6/sMoGK71t7+dxCBK/+71V1LZqG9nYIIcqI2ztqp/3hbKPKt9l7OKGWaVjXKtQNb1m+rLy9h3ioWYm17TzZ7lC9WMVTn4kGSHfz3wh9PNt+swBhMO4i/cFLvYFq5CuTezsp+yBuvvWrcQiR1omTp5j7qzNdeVpKr83LQ+Zx6SbsGD5yBc9rnz24YjmzCBpM2QzUOHaM6vb9tH8wZBDIi4/73XqfzW2orAZYq/KS+2TdP1l+DoFu63EynkpVIUWV6pq6r+6Rr1dI8mf0u6yDT+Z9nLcqQ1pgT1gIOP/C4F8wSDyIqtaVLDXJTylpGYOvzGYD4hl7E5fO10g7rlAfMz5sTpQt0ep3ychXV5HpH5mZYBtKvhZMOm8Vp2c/ULiijjX+ZvDrgqnwLyyshqQY8jTVD2bwa6O5gEGlp26nWI7afDjwjpq2iG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39850400004)(366004)(451199015)(6916009)(6506007)(2616005)(316002)(54906003)(186003)(6512007)(478600001)(6486002)(36916002)(36756003)(26005)(52116002)(38100700002)(38350700002)(31696002)(86362001)(6666004)(83380400001)(107886003)(4326008)(66946007)(8676002)(44832011)(5660300002)(66556008)(8936002)(66476007)(31686004)(41300700001)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZXajEvOW5SZitJN0gxVFNoODI5cXR2Vm5KUTh6ZmJTSmZhMlZTNzZoOWoz?=
 =?utf-8?B?QnZJeG1tYktJMmhFSDYxbjlTaWlxb3VXMXRyMHlxdmdYR3RUVjMwSlUyMHB4?=
 =?utf-8?B?R0xoUTBHdHJ2MW56a0tGWk00RVdVdXkzdUZET3N2WjZQMVdtTHNjNUtDRFNr?=
 =?utf-8?B?VmhodkEwVXUrMDNpZ0JkbWNoeDlBb01ucjErVlZiL0FqY1RrTVp4VGNtdncx?=
 =?utf-8?B?Q3V3T2FxRHVyM2JpT0M3b1JvMG9hYWU1LysrSzZndmN2dHR0eVphcElwTy9t?=
 =?utf-8?B?MU94YjhBT0lka25PN0dxb1JDMDg4aHhyOHNuUkpmQURsVVFLblljMWpxM2l5?=
 =?utf-8?B?QUdFSVU0a0xEZzR2VWFCSXFCclZkUG05TVIxWnFBYnBLRVhBWk85Qjczazli?=
 =?utf-8?B?RGozRzcrS1BabTNOZTVVV0lkUFVRTkZneEcyU1pzS0NHS2VqWFI2VTdnYTYy?=
 =?utf-8?B?SkNwMlZ5UHBKVzYyOURkSWJWS1VKWVpmQzArMGZxTkhMWEVqVFgxQWowTWs0?=
 =?utf-8?B?MHBET0JHa3FGTWJvdjA3OE01aktZcXBzYW9wa3kzWFIwQVZSNUlFMitPeFd0?=
 =?utf-8?B?MHJuSnRCdmlodzBIcVgxTDZ3am1hYUdNMVpqU3ZnSDViTi83NTFWWU1lZ2ZT?=
 =?utf-8?B?Z3A3YXlYQ2VBVzF1cFVMZnd5ZXBlZkw4cUI5YjQ4d1V5bnFwdnlJUHVBVmIz?=
 =?utf-8?B?NzBYZHdBQUFvdkszai93N2hXdkU3aC9OYkEwZHhuU0RQT2M5dnh1Qy9PV3pn?=
 =?utf-8?B?SFBXYW5sNXh4Z3pCMEtibElIL0VDVWxiUi9FV2RHdE16ZG5RcXF5OEtzMTVQ?=
 =?utf-8?B?SHFMSjdBNkc3ZDZya1dZdGVsQnB4TU51VlBOemJZVzBPUWNoNWtuRmIrNnhn?=
 =?utf-8?B?SUhYSXptR09DNFIvVmpiT1JIek1oSUVXaGg2M1J4eURQdEVzMWUwQy83L251?=
 =?utf-8?B?bndDT1RVeU95T0xKYXhrR0ZaWjA1VlNzdEtjMC9Kc3RvL1VtekdQMWRFVWdK?=
 =?utf-8?B?Q0hTZlA3cW9uRXFUNU1ZalM5WEVzS04vU3dkWGU4MmJpZmRRbVZqRXlUQjgr?=
 =?utf-8?B?WTVuRGp5eWV4VERUMU54bHlGaDVFYWdDZ09heTBXaUQzajYxU3pheVJ5dzJr?=
 =?utf-8?B?MCt0MXJyL3crNE1JZG54TkZOcjUzZm1uTXpTcnJ2VEFZV0Q5QlZ2Q01KU1ZJ?=
 =?utf-8?B?Q1E2V0pHR0c1NWVTRlpVd0lEbFVDNlF3czRVTnZQMWZjbWhpMzBzN0N0cHBX?=
 =?utf-8?B?WXBoWGx4M0huYmJqa3dzYlMzb094S0FQNWNCQmdNNlhQQ1pWNTV1SEZMSWZ6?=
 =?utf-8?B?OUNqQVRQT3pNZXRHSGVDeldJdjVlSG1jTmx6Tlk0Q2prcElvUW1ES2ZrcTFB?=
 =?utf-8?B?TDRrQU1ZYTNRTHZMdkk3a0JVazErazBRaGMxZVRwMGZJWThSZTVDK3NOM2FC?=
 =?utf-8?B?aUpQd3V1WjVWc0VSZTJoSkF3K21BSDBJS0NKYW4zR05IbGxTa1M4NVJCUENi?=
 =?utf-8?B?QUg0dmdiSUVoVXBPZ2hMd05ldGpPUXpadXBjWHluZVVSQUdrRG1WMHdKcHdw?=
 =?utf-8?B?K2gwRkRPdmhwckhVV2pzUEZJNGRwZ3oyVGR3dXhKLzJsZllQVnJhUzRLVVI1?=
 =?utf-8?B?OFo5M1RiTmg4OXJRN202TTR4aVlhNklJemNCUTlCN1JHamVFNVl4RGZRRDJu?=
 =?utf-8?B?cXJzeHcxellKZUhjZE5rNVgrajJhWjJDNmFZdC9mUEx0SmNwMVFtQXVNNnVr?=
 =?utf-8?B?UnN6em5obUZrSzlBRkx2aC9qYVRQUUkzTi9JVVFOUlJHSFA0dS9YTjRQL3gx?=
 =?utf-8?B?cjB5SjBJT21zV0pTdGFIeVgzRGZPVVJqNVpYL0dpdHp4aDdwb1IrNFV3cFFZ?=
 =?utf-8?B?eHVpR2RXa09uSFJCZytVZ1dxN1pKVVhIVFpDbkxIekhuaGNOOXd6QkRqelNV?=
 =?utf-8?B?NnZBY2tKSGJ6MGx0MnZYeEU2TnBWSWIwMXBWMTliRk1IMzNLUkhQYTBQRk5C?=
 =?utf-8?B?WTJnLzFRWkxDeGltM3FqakwwRWZuZ1pEay8rQ2h6bkpSZ3M4OXAwZC9yNHE3?=
 =?utf-8?B?NkV4YWJMOG1taGhTa29JZGhLTEo5dGNuYnJKT2o2TStzNlBsNFNNQUxLb0N6?=
 =?utf-8?B?eDlmOEVVSFhTSUFCUTFmOGQzN1lUV0ZXZi9OK2lWKzhBRDZ0ejllOFFkOEp1?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0397f3bb-8761-46b6-06c5-08dad2b1ed2d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 09:04:45.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkT9ta/8lQPH2+C1s9eBARjChuVrb8Sx8ze69TDxJuCeqnsoRHfUi+belYFvddKOTZ4lDdqi51jOdl3W/6kOaglNbgpTXWnVD+9dH3h+VY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7953
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 29.11.2022 um 17:37 schrieb Andy Shevchenko:
> On Tue, Nov 29, 2022 at 07:45:40AM +0100, Gerald Loacker wrote:
>> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
>> Additionally to temperature and magnetic X, Y and Z-axes the angle and
>> magnitude are reported.
>> The sensor is operating in continuous measurement mode and changes to sleep
>> mode if not used for 5 seconds.
> 
> ...
> 
>> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);
> 
> Thinking more about this format, perhaps
> 
> 		snprintf(data->name, sizeof(data->name), "tmag5273x-v%1u", data->version);
> 
> ?

I'd prefer to keep this as it's related to the orderable part number,
e.g. TMAG5273A1 / TMAG5273A2.

> 
> ...
> 
>> +static int tmag5273_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct tmag5273_data *data = iio_priv(indio_dev);
>> +	int ret;
> 
>> +	/*
>> +	 * Time to go to stand-by mode from sleep mode is 50us
>> +	 * typically. During this time no I2C access is possible.
>> +	 */
> 
> Shouldn't be this comment closer to usleep_range()?
> 

Ok, I'll clarify this and also introduce a wake-up function, as this is
used two times in a similar way.

>> +	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
>> +	usleep_range(80, 200);
>> +	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
>> +	if (ret)
>> +		dev_err(dev, "failed to power on device (%pe)\n", ERR_PTR(ret));
>> +
>> +	return ret;
>> +}

Regards,
Gerald
