Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E363DAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiK3QcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiK3QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:32:19 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99B2ED40;
        Wed, 30 Nov 2022 08:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fupas9H2YeZkB2Xp5EdtSURzPR+LoN8kyXue7xATITlPKPX8+A9MP+N7VfFVunBWzaKY03DEtV7CcTdiQWGw2YO36FsCK/NWYlz0Vt4frfHyh2cyutOSN7eezPmIWwAUSVkuw5Hyfd4yYnI++FQ2ZTNDuSJMUYJrEUylxEZ1yBqYleo1n4jJeyxBg3122zOIuModCxfmGboMg9Zoy4NMXNqwj6IfxYjry+nd3tO13UhR9i0tNEdCGMyARcuFgzNJDpTN9ow6B5i1D9R7T4IN0ivkeALfxt6szVgyJA6n9RObfk+YpwlK32+KCgR/sfLUMNJShRQVgLJvtetKoZo5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvdSCvqmK3bF68TJVvhgriSr7mENb8psDk/4gWUi26Y=;
 b=OJe1DKui060UdREezMRpF4i0S7s8kyWQ4CEn8VshFm+fiXOnvOYg2PbbnoTnq5i9LS49WU/euI2RK9RPndtLwSuW1m5xkP3UiszCdQU3FP1/JEn2pNUwJCGRIeibdeI0VqbW5zJx8B4LKefkiCUKqK2WDn18DlDHXxtPv3CtGIksipoPL8bIxU+4PQcUGZWuawJd14HVSvrg0JBIQE95cykh1AbRp2TMXiUGQhKNVU29E/2WZcD0B0t3A1Tpn4SfbQ8i8vrxCePuwKvAhUuZVcd16M4+4Q3vYCFj4+ecr8eLkwqo50NLKwEOp523uKjSANHSHMBaQyDhiYD/juS6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvdSCvqmK3bF68TJVvhgriSr7mENb8psDk/4gWUi26Y=;
 b=zspiO5beWUCcONIKuqcwl2WeeZLiuSf522CcPxPU/MZyQlDR0ZU861Je8RNtEYNtsrzd/LOZwk5WXV50C5//j15vx7/oQe8Twrp7h5fwdxnmDi7VlIfZppFxYOt3VEC7eWL/tbGdVey5sCv4O6XHLmevLQHgsWHvXnkqIaZT3bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by PAWPR08MB8839.eurprd08.prod.outlook.com (2603:10a6:102:338::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 16:32:13 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 16:32:13 +0000
Message-ID: <ef3ec278-d9dd-4318-5b8a-d0ed363fbaab@wolfvision.net>
Date:   Wed, 30 Nov 2022 17:32:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 3/3] iio: magnetometer: add ti tmag5273 driver
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
References: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
 <20221130145356.1129901-4-gerald.loacker@wolfvision.net>
 <Y4d3NZkCdALLkwU7@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y4d3NZkCdALLkwU7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|PAWPR08MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: c86fb857-0edb-43dd-1c1c-08dad2f06f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4oZWxWySEshaFp0cM/ar3vr3K+yDFQy9jbSR61xd49zWAonuHomx0jvaSL/3+AQ5R4tsJmWtkaRA6126jwI2Z3FDugGX2iPPcRxNImnLMntrUuXImljdMC6CL7k9luOv3slifdvI4XBcJnWFE+8aLsMs4vy5DO+cy0rfLJwPolfc80Og6Z2/hd4Z2S0hsHXYiYrfkMQiqakPbpZgg3mPoZPsgrc4TnilUXeMSnIl4701t892r4K9WuANikzpo9qTn5aXPzCZ/nwy+YIY6Nu5nA7CQwUgoBgLWWHm1792v20aIAiKbZyzCelYhqWyKFqvKk75LYFt1q7MkxhDFThOK44bRmDwaw7ssKUfho1AsEYdfhx8Vt5sytDp+bo+pjjr9j9p2TRCHG/Q4CzR4oFYvnE7ngSWFaB4+IK3jhUL9ib4XBtS+yp3zWxKxNO3LdWV1nEyCco5EU9SDSUZx0Q+MCDJLvf4fYK6JwlJyUav1XroHumMx+R52fRsSIbn2vi5C07NfhXFfc+I3LnZkqR2ZWoQJTCvdD5hzILR1nggEDAoI60H9XguioAzhF+Jbb4mK2lMF27mM6YkLQnR9P/K2gzJrU4B6vIKKTyotSuDsO/wUl74lhKIU53GfCgn8MkBRz9vrcYSGkCjT/hKqYumMkbKnkQA0J0GXM4DIrCwM3It7Bb+aI/wlLMHEySPvXImo3SXVzm3YAhywUvFiqVbOroQQzI92ebqKLwlGEh0ZZTdotafdeWNa1Fl5dVqazh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(451199015)(54906003)(6916009)(316002)(7416002)(2616005)(38350700002)(38100700002)(36916002)(478600001)(5660300002)(86362001)(6486002)(44832011)(31696002)(36756003)(41300700001)(4326008)(66946007)(8936002)(66556008)(186003)(66476007)(8676002)(31686004)(2906002)(83380400001)(107886003)(52116002)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0Y3WUVKZmltdWZzYU1TSFRVeWRMY3p0MFZpMWlDWUwwTVdJL3d1b2wvVHBv?=
 =?utf-8?B?ZHhRNTVMcWo3Q1k2NU1Lckc5Smt4ZjQrR3g1aTliZ0ZsUlhnWUxpNWFGUHc2?=
 =?utf-8?B?ZTA5ZGJSMjBKZkpSMkhURGdYWm9pRlhBYkU5a1ROZmxJK2hvMW9vWlZaaVNS?=
 =?utf-8?B?Z3R4ajd6RlJEdU1kUmZLZWVhWElBcloxYVNHWUVtOG11NWIwYk5zMVhaK2xM?=
 =?utf-8?B?bmFhcDRNMXcvcllVdkt3SUh2RUkvQjRyaW5nMVJsU3VxaUZZSFdscUVFY0xa?=
 =?utf-8?B?dUpRbnlGaW9GbWNSZThGaCtHOGM3UWIxY2ZiYUN3ZXlJRzFTdWVCaW16WTdN?=
 =?utf-8?B?dDl3SnpjWHFRandCcUJ3aWU1Qk9JVWhvNEl6Q0tKWW1yTzBGVmlsNzU4S3pB?=
 =?utf-8?B?VUozdmp2NWZIVU1maGRVTUxiQnkxNzROS1hzbE5KU2pMM0ZIaWtNRHQvTHhD?=
 =?utf-8?B?dFFCTnhlZjlabDdKOTN2ZmdXQkhUOHg4RDh5TmVmMExJVktpRE9zaWRoc21U?=
 =?utf-8?B?YkJVQysxMWFSUkI4OHh6dVNENEJKWldrdlJtMEpxaFdxeG9wYnJsZ3NDSGpV?=
 =?utf-8?B?RzY4cUNhbnQvbUJlcjh5UkpLWkJVUGkwbWQra0ZkMnNJR3NyN0lzN2RyaXNv?=
 =?utf-8?B?ck12bk5YcEJLVVlZUGdKeDRSOHJ4dG43SFdBRnZneUt2R0xLN0F1VjhoOFE4?=
 =?utf-8?B?THRnWlE5ZG1uY0hYbXhhOUtxdmtlSjFISk5RSVNuUnNJQkhxSE5aKyt0cnRN?=
 =?utf-8?B?YW1tK2tKa21QOEpteGJyLzhZRGM5ajZuYUgyS0dLSUpwRE5Ea1dBM1BHdGtW?=
 =?utf-8?B?alJ3YVd2T2k0R0Q4RWE0cFk4dXJXYlg0Wm5JcUFLQzJGOVdETXdwbU9WTkVu?=
 =?utf-8?B?TFRZb3N5OXpXRE1xRWRKVGpGSE0wSWNrakxESnQ1Q1ZyWE5JV3VMM3l3aksz?=
 =?utf-8?B?dFAwSFFkQjExYlhlUnY2MWtXakNTZC9vVmVWOG92TGhaM09zT1h1QS9veldM?=
 =?utf-8?B?US9jbHJ6c2NSckJyNEZaTFlDYWxlckRVUW51L3RTSE0wQ1I4ZjFJMi9zUHl2?=
 =?utf-8?B?UEoxcmxIYUQ2ZmFqZzNHUjl5aytWQy90Z2lONGtjam5MU3hTTkNyQ0NSVXJ2?=
 =?utf-8?B?VWVTWGoxSmsrUHhxWmo3QlhqQktpeGprVE9WRitITml5WmFsODhHYkZibDJs?=
 =?utf-8?B?L3BENkIwQ0pjL05wellzN21IQmczQUpuZENHaDNHbGhHMWJ0Q2NsQWVtT0Fq?=
 =?utf-8?B?aWJuWWFCSGR2NmNFb2JXS0YwSi8vUW02SDFqZFd0LzAwODIxaVFmTmRzeGRW?=
 =?utf-8?B?VkdBRDhSWm1Hc1JubEFjdVA2Smc3TFAvUERyVjNMQzVEcE41QS9QT1g2Vkhu?=
 =?utf-8?B?Yys1RGp4YVdsOGdJRW1QM1RWZitxeExybmRpVWtmcEQ5NlZoc2htOUNvWDBp?=
 =?utf-8?B?VHlPSWllcFB6elVwNUhMa3RrekdWYkVrOEg1dVRUTzhNYWdPak1jbXpNYlR5?=
 =?utf-8?B?K1h6RHZNSkQ5a2srQmhWSUZUQ3hpZnVPdXg3WktWeW42VkI4RVNmc1JwMFhz?=
 =?utf-8?B?cXdYRWltNEkrandWc3hHNmExVzBUNHQ1eEt2MzdTdFRTWjUvSHh0aTlvcGZC?=
 =?utf-8?B?MHkvRlpHZnVucnhOWFk3eG5YUUJiMHNzdWRMRFZlRmNtS0NvS3BWMXNib3FO?=
 =?utf-8?B?ZFB3M2JvTW1PUlBoaEJreVZaUXg1TDJJcWZ6RjNFZDV0c2NKazc4MGNVL0FI?=
 =?utf-8?B?dGZzZmlJYlY3NHJvRmo4U3c4WFp2c24ySGo5VVY3cmNoQjdiQ1VKclFRejU2?=
 =?utf-8?B?NFFyMXA2eGFMZ2NLRG93SlNNbkFoRjVPSFdxcEJuOVcwSTVFTU1xR2x5bjda?=
 =?utf-8?B?ZWlWU1RmWTRneE53YkZHZTJaMG5IUVBYcFBUanJyeG4vdWNJS2IwWUk3ZDdv?=
 =?utf-8?B?RVM2ekxWc0lUamp2Nnk3RjJaUnU0cG9lSGhlY1ZwYXBGUlNOY1BIWGo4cndN?=
 =?utf-8?B?dkVvUE9GUWFMQjY3QnJNc3RhK25Xa2RRNHhMeFJkYW1GSmw5eHdmQjZtYlBV?=
 =?utf-8?B?VmR2ajhXVmwvOEJHZ1B0ZGRFb2w3OE1uQW95NXJXWE1hbEJSdlZCOTR5VFJQ?=
 =?utf-8?B?TTNDc1VZMUJPUWpXQnpqUlJDZG5CVW5mbi9VYUJOOGF2U1kvam5jRm9zOWY0?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c86fb857-0edb-43dd-1c1c-08dad2f06f5f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:32:13.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pffwT8v0/DqFDCzKcN6GO2LYSM145iO/gVT87z97tEE6VTukdJGfBcHkaTD+iRYbBJx1jJTo0Lv4Kjmi7wbHJ/ULr6FZYPX4qqFlvRcmtzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8839
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 30.11.2022 um 16:31 schrieb Andy Shevchenko:
> On Wed, Nov 30, 2022 at 03:53:56PM +0100, Gerald Loacker wrote:
>> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
>> Additionally to temperature and magnetic X, Y and Z-axes the angle and
>> magnitude are reported.
>> The sensor is operating in continuous measurement mode and changes to sleep
>> mode if not used for 5 seconds.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But a couple of comments to address.
> 
>> +static int tmag5273_check_device_id(struct tmag5273_data *data)
>> +{
>> +	__le16 devid;
>> +	int val, ret;
>> +
>> +	ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "failed to power on device\n");
>> +	data->version = FIELD_PREP(TMAG5273_VERSION_MASK, val);
>> +
>> +	ret = regmap_bulk_read(data->map, TMAG5273_MANUFACTURER_ID_LSB, &devid,
>> +			       sizeof(devid));
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "failed to read device ID\n");
>> +	data->devid = le16_to_cpu(devid);
>> +
>> +	switch (data->devid) {
>> +	case TMAG5273_MANUFACTURER_ID:
>> +		/*
>> +		 * The device name matches the orderable part number. 'x' stands
>> +		 * for A, B, C or D devices, which have different I2C addresses.
>> +		 * Versions 1 or 2 (0 and 3 is reserved) stands for different
>> +		 * magnetic strengths.
>> +		 */
>> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);
>> +		if (data->version < 1 || data->version > 2)
>> +			dev_warn(data->dev, "Unsupported device %s\n", data->name);
>> +		return 0;
>> +	default:
> 
>> +		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
>> +		return 0;
> 
> And we still continue?! Wouldn't be a problem if that ID drastically changed in
> terms of programming model and may actually be broken by a wrong sequence?
> 

It was suggested by Jonathan to just print a warning instead of
returning with -ENODEV. Reason was "Often manufacturers spin new
versions of chips that are compatible enough that we give them a
fallback compatible in device tree.". For me this makes sense.

>> +	}
>> +}
>> +

Regards,
Gerald
