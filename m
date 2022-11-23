Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008C63595D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiKWKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiKWKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:09:00 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCF1173C2;
        Wed, 23 Nov 2022 01:58:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0qFNRtlz9AbMEVXZ5qfR+xdf7QxmnnebHyFx+uxPHJOqeyYkcDECARn6RCH4Vsp/20TFw+c2V6726fz24W7Tsd6U8xehoDrt3HY3OmqjMBh19JRW57lYTCciCj0MuQOwDm8yVA2c3uV1tqXcwlh50vc+6VZDbcIQZVhriGAEI9dW9JnDJ8GvzqqisVXQla7KJsrTanJeY9jWCq+8Ff/4SsIGJZIM1F6GzBQyzI6DH4xDCuNOd5AKSiMNB0Rd/PHSX7RFzQhNnysN7ZkDYi55UeL+F1bIeOmDFVaWvEL1qieFHzi9aWqE+4XPGVrEO7u5TfcB07JqxqbjG2peKzRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7afvXYQgRAgaadWL2WIE7fPZj+rSpLkf5pG13oQ7m+4=;
 b=cRVKx4l9Lnzm0b9AsXjOhLKQf1bSDgKF6jnwg3Cg2yDO0U7j5W21VjOKHSfhpwiL8R6l3AHJ8LU/G4v7srlohx9IlJPqzrMhqbhuDsDPVCr8Kc/5Q7DzK2wPmyPVlr3yl9SDeQj+G6QC9dH8LEcz0WPnJMVeapCDYxfeDi/qASeXEkNGt8oMdLriEGXL7NrB16GUT0CZooudwEuXTslGxWI6hm+rg+Eoo73ygSaavrxolt0XXnCsaCQ3NFuJdHiHz3oA1idK7j9rhyjAPs6vn20JOR0R0gxNcsulvdGArCJNe4B0nPnhmr+R6DxLx3NTUnjV2/vxvvi7urv3AeZkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7afvXYQgRAgaadWL2WIE7fPZj+rSpLkf5pG13oQ7m+4=;
 b=1AvSGRY7cbmQdAPCDtlJIq2itQtPRbbam2UwGSLDBuuCbvhrjzf+YlsQsCWkvtWTi7GWl9MiJBHd4maTU+FQzoyoln04SkSDHgnHD2Q/W2pW35v4GG/n5eZF5DHYl+v1PEDl0x5PRkx8TDSAXtZPNXDF8CrgwXsQgVjusREIQTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 09:58:51 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 09:58:51 +0000
Message-ID: <f3fbf861-37c6-3bcf-615b-2f55261fbf90@wolfvision.net>
Date:   Wed, 23 Nov 2022 10:58:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
 <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::22) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c6e38b-5fbc-47b4-e2bb-08dacd3952af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYFanwCJXU9kHYqsdgiTb/icfBO/0MpCuvlwxVHA/2klVazzDxwYhg0H/ePPPCp9uhROl2oVBTn01ZV3pJhot3l4tF60Uw6bDgd6g2D9bt46JSUqDgRN+MJMeD5CqZyxbC3iHWJYHaS7GaH/fl4qeemqlGKNWp/wVJPVkDKWpw8SAi0zFNJ8UvIM5AnlxqreB9tWT7n6c/9LbihabSGykDny7ilz9/ue5soHSOgwwvT5Nx+uRKuWYHwx/3H3Mt7OZ4KzW3HwxFHyRLOAeZOMdEGbRm6tljZ5hNaTzgMKXT7ZVMRZKtANnAsLmGNLVmbUsjSlmMtWFvupVtaPuKiI4nIQ23WR7BD2zH1iOperYZwKHKTf9HcxF1xizk1xVM/WasfmGEvlPJAEbbKyVna+O0MX+SQk6rpzsAAWJ1Elm4ANNkv2eGijpxd/r3f3n0EbTT08n5dbdXqAUapC0l1owncwdgBfP4ktR7Aq2kCHAr/ezG/0gsVdDK2kiAUc46ROiMpTC+3K1oX0X92PwP5ygQ9uHZz5SckOaquPGDmhBWrcxPVcCAEG9PveX5y+8lSvYS3n2JGrdvPA40w4+ENvP809L3bRkPN5E7TxdS1DIi7H+AOP/sEIo0QZadQuWfgs0mXjpEceAvuzppSXGnchTF0+pBsaWalPPZgkcQsCSmEx4PDks7h10aPfIrir73P7WytmX77PCz018XMXRrKfNAgXAK7rT0jYZPzNQ+CyP+oEN9dWnNBl9ZA+rghaph6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39850400004)(136003)(346002)(451199015)(6486002)(6506007)(6512007)(6666004)(26005)(52116002)(186003)(36756003)(478600001)(107886003)(36916002)(38350700002)(38100700002)(83380400001)(31696002)(86362001)(2616005)(2906002)(8936002)(7416002)(31686004)(41300700001)(44832011)(66556008)(66946007)(66476007)(8676002)(4326008)(54906003)(6916009)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWI4a1ZUN0xtTjhKYWw5eVdrZkhBcG1zOEt3dllZczFhMlN1ZGZhd0tDUnF6?=
 =?utf-8?B?dTRqaERNY0JWaXk4b2JyNlg3L05HMkwwS2djbG0vUFlFZkZIL2tQZXFEN3JR?=
 =?utf-8?B?dW5yRXZpVFlYUG1XalB1UzRqQW1hckpZTUxMNE8rV21admR2eEVJOHh6M1dv?=
 =?utf-8?B?WStvYkllYTdwM1FZbkw5QjJRcmlPNzA2MWpnamhFZnU1bDFwVjJsUm8vSFdu?=
 =?utf-8?B?U21kUEtoMitKY3JEMTEzeVZtWkNTTWpENS9KRmRmQnhEYnFKSVpndFZUbEVX?=
 =?utf-8?B?ckVoL0s1ZS8zdFE3eHFqU1JQaHBRL0taVmo0T1dGOTBrSFEwRHVNY0tNamRV?=
 =?utf-8?B?SWh1MktOUFlsSmhNZmVPMGpPcENDWVFoMmduZVc2UUFLT0tBcDBpbytGSFVX?=
 =?utf-8?B?WElSQzg5WTYvR205OTlLMHRVaGpkcGhQSFBqdlNicjNGY2YxOFUzMCtpWm0r?=
 =?utf-8?B?R2FKVmJLT3NwUFdGOUJ5c3FEaDd3ajVVY0xkYmtyZC8ydmJUc2pqdXlHME0v?=
 =?utf-8?B?Z1ZvRHZQdjAwRWhzYzdQdmtXQnQxQXk3ZVJ5MmpDclJCSTlLZ2crc1prUmhI?=
 =?utf-8?B?ang4aHpnY2l5NHFVcm0zWjQ3RFRMZFVTRU85VkpiU2NzdG12T3ZmL0RKMHhw?=
 =?utf-8?B?enhpMEh0UU44UlpIWURaMExnNy9vbGhQdk9CUFBxRlI0RkNPbFd4b0NYeXEy?=
 =?utf-8?B?bnpPQUlTSUQ1MzIwVjY4SDA4RUVPbzRnZndoUnJZMDhhYzJ6bjlSODdKZVY3?=
 =?utf-8?B?NkZYV0I3NXFCUy9CZGpDV2dGQ2J3S2lQMkoyNC9TTVpPQ1l6Mlh3TjFGYndv?=
 =?utf-8?B?N1ZKa3djZDh4SEttNTVNejNsb3NMbFVSWGZjcDNlREFJT2RRN0g1MEdiOGxx?=
 =?utf-8?B?UEttZk9TczlrVFRidjN3VkVGaEgrMTZydWltVmU2RzRuc2hFbytQZWpoUlIw?=
 =?utf-8?B?MHl5Tmt6SWFLUnl6Z2ZPcUJTQjl1NzNFeWtRbDM2czF5bTlOSlZmRjBiOU9J?=
 =?utf-8?B?QTkycjlwOHNlbng0RFVXOTZwL1lLYndIVEVLaDhGL2NzQ3YvR3hRTktOVGZh?=
 =?utf-8?B?Y3JLdks2TnY4NUNONEJENFNsUjdpVmxyQ0RES0p0UWxaeWVBeEptTnBRQ1ZS?=
 =?utf-8?B?clg0Y0sxMWNHVkttTTZhaFV0N3NmaXNIakRyUVVTN3g4RzJxV1haNFpuc3VI?=
 =?utf-8?B?TWM5Qm93YUJ6aEhiaDJWTzU3a0ZpM09kZUNVYy9GZ2Z6Y0pINGpEaWJhODJ3?=
 =?utf-8?B?OElqTjVQaDE5SDhDbDNRZ21oR3lwUVFyUlNFWndsUFNrdWV6VkRISCtOZzJ6?=
 =?utf-8?B?VzZOUTFNV2FXVHNUbU8vVmR0UVU1V2xMOFZkd0YzTnBLaEVycHRlTHh0Q0Er?=
 =?utf-8?B?UTFVMHI2alpkcmhqMWdsZFFZdlVGWHlnRitCWEc2Z2tlMkxTYXA2NDRJL2ti?=
 =?utf-8?B?UHQrY1RvNGFkWDVFY1FUdXExSW9QMCt3bE5rOEJnODJjQzRWSXdiYnlUV0Ji?=
 =?utf-8?B?cjFMVUVobnNQWi9LdDBLVFNBdWxuSjBkYlVUczB6cnovZUhicnRMSWtlOXpL?=
 =?utf-8?B?NmlmS3VQNkMweGNzYURRNDUxWkw2a3p1WUVYcUM4WTIweCtNSTBEZkRMdVBh?=
 =?utf-8?B?WndYRTduQkhURW5ZTXFwOXA5cSs2SjNBb2xvdmZSencwYWJGblNaTGYxNVo4?=
 =?utf-8?B?Q0FSRjFzQnFiTnF1K0lTL0gwUm4yTGxjQ0ZHeE1XTW9KVUU2bjVZUnlONW5R?=
 =?utf-8?B?QjVLRVNLdU96Q29sVGo0WU56WnJWQ1FsZlhGQzRBQWp3WjUyeFNrc1BqYmts?=
 =?utf-8?B?RjZNYXltM0N0K1dYbzRyWkFpaWZOYVl1UzhEK2xFT291K0RKaCt6VlN6aGFs?=
 =?utf-8?B?dE94ekVSSWNvTXExVEhxd2srWkpRbTdrRHMwMTB6Z1M3MnJsNlFYd3BWTHR6?=
 =?utf-8?B?SHppcVRiTnM4ZFVxUGdOWFVUNTV0bHFpYnN1d09ZNzFzYm5WVjdxVjhTRlZi?=
 =?utf-8?B?YlB0N1o3Ukdpc0pVWDNDQUlWZzFxejdOb21tcnhrK1IyNndnMDJvTnE2dVE5?=
 =?utf-8?B?UStkSmZXMFNnWWltVFliUjVqbnpPQ0d5am9IYjRyNnRaTmdTQW1Zb2Q0VTRp?=
 =?utf-8?B?OUR3YmN1TG12cko1WjE1em55QjROT2Qxc1RRV3NKSjFEZnVPdDFwcmNzYzFN?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6e38b-5fbc-47b4-e2bb-08dacd3952af
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 09:58:51.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXDTHbCyb3UIh8wRTrM4LpRVN1UCOp+uKlCYC2c8TtkbHwuNAARiqcDv/d7LYqqiVecxHOxWHndMDYPs9YhHISn7yvQMCs2mFWdG2S0oOpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
> On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:
>> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
>> Additionally to temperature and magnetic X, Y and Z-axes the angle and
>> magnitude are reported.
>> The sensor is operating in continuous measurement mode and changes to sleep
>> mode if not used for 5 seconds.
> 
> Thank you for an update! My comments below.
> (I believe the next version will be ready for inclusion)
> 
> ...
> 
>> +static const struct {
>> +	unsigned int scale_int;
>> +	unsigned int scale_micro;
> 
> Can we have a separate patch to define this one eventually in the (one of) IIO
> generic headers? It's a bit pity that every new driver seems to reinvent the
> wheel.
> 
>> +} tmag5273_scale_table[4][2] = {
>> +	{ { 0, 0 }, { 0, 0 } },
>> +	{ { 0, 12200 }, { 0, 24400 } },
>> +	{ { 0, 40600 }, { 0, 81200 } },
>> +	{ { 0, 0 }, { 0, 0 } },
>> +};
> 

I'm thinking of defining structs for all similar types of IIO output
formats in iio.h like this:


struct iio_val_int_plus_micro {
	int val_int;
	int val_micro;
};

struct iio_val_int_plus_nano {
	int val_int;
	int val_nano;
};

struct iio_val_int_plus_micro_db {
	int val_int;
	int val_micro_db;
};

struct iio_val_fractional {
	int dividend;
	int divisor;
};

struct iio_val_fractional_log2 {
	int dividend;
	int divisor;
};


Do you agree?

Regards,
Gerald
