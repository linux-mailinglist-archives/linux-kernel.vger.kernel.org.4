Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78067E20E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjA0KoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjA0Kn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:43:56 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864747922D;
        Fri, 27 Jan 2023 02:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc9LhUpqFRj2cy/0swgOrLvFPJOZ86orTfyUDWKvEkhwd4/bGCQe4+w6SFnM/Qyd46nb5KxE+EzZfWdXI2MM4BAFMFWcTkicJLhZ6qZ18uzVtZ7LgQmZOSrA99SIgziVrMZ8+zMxNeMJhzejU79w6jThMC2yhnlIXTBb3Zs0oOf47T7c9PNhlvMIaI1w3c5MuzRL5hs1FlVxyvZDHZ6+AS5Ial1yjU4O0nHjQppNkugjidYi2JLNuUAB21PgAsA5aG2aqApckNbqZHA0dufcG6iBwunf0SiJ0Zv6TKURZNLQvq28iWgKQqYhM4GG0C63SolH04Rc2nBdppVHunNBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zznnECEpAI/sTnhEStwsCEr8mSaXaiQASMiyne+lAcg=;
 b=PpjS9HBEKcfMSBxHpD+Pu42CebmexsCMZtbZhbsD4eUepu45n8yA36lPp8TuOBAGCktZhlfz1cCdtE81qT8CA+WdtO0TAyln+ZMfpLsFJHovMOTrkd4LD/tKaokpcHcWrHaVV+gVbzJhxvAJh8GSjn2HyiHK22A/UJq2QbsZkb/nPtxVeyebq89z9pBMjJhIWrjLyxOV9QwQgD2/msmp8s7ru/I3Q6d2qfNmHfUVtGhRfqQfFiMCl9y+BSLL1amvHS8vwadLl+FgJqMrMMmPkZ84X5lv4Gli+ywVEM42kxj/c1RENSg8FM0GdEB7Nr9ZGHLWGpN1D2bNQ0ozb9PFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zznnECEpAI/sTnhEStwsCEr8mSaXaiQASMiyne+lAcg=;
 b=Mbrhf+BExtbvn+RKGnUrlChaebDWZP+pNvCNMqjHNBvrd0o1KJh5Ba4KvAskwxaZ9Bdw4EGEuBpV2dfHIy+bhe6D2a+Ad27ATU+A13WbJwTulF/g5Sv7dn+9JkazkZwHOG3eZ9s1PWX7WQgaUTEo9+He23j+sNYjU5KGp72mdNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by VI1PR08MB5455.eurprd08.prod.outlook.com (2603:10a6:803:135::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 10:43:35 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 10:43:35 +0000
Message-ID: <395807d3-e242-5779-5c6d-06d750357b8c@wolfvision.net>
Date:   Fri, 27 Jan 2023 11:43:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] media: i2c: add imx415 cmos image sensor driver
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
References: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
 <20230124060107.3922237-3-michael.riesch@wolfvision.net>
 <Y9EKqwfDSsF31dLZ@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <Y9EKqwfDSsF31dLZ@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::11) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|VI1PR08MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6a1c12-5280-4977-1173-08db00535776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OUOW4KrhkoABpysT44g0kbxkri/bZdvU3a1MB/lqeZRQiz5Jq4GBVaN1N6MFkeBWyFbjVyNZVjxXiA+IdbcV5Bp0l2ArDyoUi0DAowYFipf57l2YdqJ/wcgWayX3o+q6FqfrO02kcMU8wXN0JwjzpYYAi01IkPzkKyVHPn5G+Pm8nwPeF4QBjieo7cXAvJ12532vv3qoop3dLvcZU9Oa+7bmiwIr3LJLAkmOM42eXnMo8RlE7CIdW2zFVlPBtGzaA2CdzxXsrjbiwxqGNw4A1X48YuRMYxm1f1Br5LAvecMmEALZPFgoJuP6H2bKr99hXPMSMmM0dcG9qDEQJiE3QRyG8w4ZkNolXZDL+qjFA2/QC8DjPt7mHflUdAWI+xSGGRV4Pcv5X0XJZmb/4X9qIvFkTWA4BndwLL4CEB4BDj5NPTfwa3LQxQI+eycX9BCAERH+H/vnwbcSG80odJBvR0Vb+XJQXjNMN9lig/S84w0gfX4HOeTuA3i0RAKa0JtfLkHbhHn6xJr30Z4q3/8njP9HCYkW0Sr/cLH96nKUNROMxE+LYM8RyOncODN0U8UYxTxFRrny83Ox62ESDGg+XCuVAyDOc9URZILCLTKoIkZsYmCsfuqrh0ZIxi+FdXNYvqMNmly2JGJmTkxpdGtfN7EcHLpj60c6gnR/KhFAuh/OaOsbgIBPg08eWAM0T/kI8XphaVHNkhQ0KsqA2bEQhrZwV4QdwLo4EymiL1Xqz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39840400004)(396003)(366004)(376002)(451199018)(36756003)(44832011)(2906002)(54906003)(52116002)(6486002)(478600001)(316002)(2616005)(53546011)(6506007)(186003)(6512007)(8936002)(38100700002)(5660300002)(7416002)(31696002)(86362001)(41300700001)(66946007)(4326008)(66476007)(8676002)(66556008)(6916009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODE5WlVUaXFkNTRxVm03NUZINGc3eW5pUHpGa3ZoKzRKKzk0WXRNZHNycFJY?=
 =?utf-8?B?VDFpblBJT2x0Z1ZqcUYvcHA3RUlMSlMrNENLb0xuNTFKZUQ4UzdFeHV2Y1h4?=
 =?utf-8?B?SDYvWHIzTUk3Qkk2cXhrMnBkeXFFWncybzlDVkRrRDdjblV6SFdKR2dVRVNV?=
 =?utf-8?B?MTZVNnVpQ1ZzRXloNkpBRTdDaTUwT0M5TWF2ZGNxbktKUnhsZlJVbEJSbFhM?=
 =?utf-8?B?VDRJaXRVNkRWVitiQ2tXc1NkM1lOS2t5NExHaHZyUDNaaE4yb0cyaXZhNGJi?=
 =?utf-8?B?MG1SWVFVeDBIMWFPVE9jcWh5aFc0cERhRG9mMzg3RitlbE1zc0VveGRKcHM3?=
 =?utf-8?B?b2cxc1hBY09qV3d3SEpoSWZvb0dIUnRjWXFyWG1ncHltZXdCeHFZVjRIc1J0?=
 =?utf-8?B?L0JTb05tS2VYa25ZZHRSbzA1Q2l6ajVCS3hvNGpiM3ZvRkpNSWt4M2xYamZz?=
 =?utf-8?B?cXk5VjFxUkt3c2VMS0pKMkZ2R3JXWmNWQmJSUHE4TnlubHpsaUhPdEhjcTJn?=
 =?utf-8?B?czRsdkpQWmEyNVpSWERKUTdDMkFYTWI5blN0YzFmcUVTak1qUTYwa3dLVDJw?=
 =?utf-8?B?UHRsQkphdFh0TnJJT2UvanZ3di9jK3RDVVp4RXJMUCs5NUJKekdlUFQ5cDZs?=
 =?utf-8?B?d2dzYjRvQllzWm0vd1NVZG8vRTZhbHQrMGF4VjlPdE5GSmE5eTFnTmlwV1F6?=
 =?utf-8?B?M2VUK0t0bXNaNFJPaEduTUZwcStqS0NNOHd4WktxcmtBSUZoRjN0UUN5bXBa?=
 =?utf-8?B?WmRIc2lJNXZsQWtCbE5SVTBMMytWZU52a0dJc2dLeWJBaklod0k0eHNwSElv?=
 =?utf-8?B?eXdHaHRsY3FUSFBWZ2d4N2xRL1VZeFZYYmd3SmtrQkN4VDJzYW56N09qTkFo?=
 =?utf-8?B?TmxldDNVdnd0bTdIRmRLSDdBdWJCaVdjWnBUUzEvZXdJOUR1Z29zQWUyblNU?=
 =?utf-8?B?b2VGRE1TWmQwQjlLb3krM2doc29QclczZ2hMald5RGxuT0xlZk1meTdZa1ZO?=
 =?utf-8?B?NzhUUnF0RW9VYUprYkRwRGFheitXa2ZnQ2xSaGtsNWREQ0I2ekYvQzlNZU1U?=
 =?utf-8?B?Q05WcGU5VStRRiszT0lITlgrbnhDU3FZTDFsL00xVGtsbmpIdzlRci9CeS9Z?=
 =?utf-8?B?YXhITmhaTDQwbnNsQlNwS1V0bWNlR09LMXk2eHdTWUhWczRiaGFZekpla0lj?=
 =?utf-8?B?TmRlZFVWYWVpV3ZkamRnZXdVdHA1MVM5aW1aS25kOTQ0T2E3b2ZEeVB2d0J5?=
 =?utf-8?B?MUUwR0k3Yk5vaTFvZTRaczNNTnUxOFlreDQxaGRxbnEwUytINXV3eGh1SmtI?=
 =?utf-8?B?NktlaEc2V2hOazdPZFpLeGRCdnY0RlF4eHhYME5NTndoZmZlM0R3Wjh4WTdn?=
 =?utf-8?B?N2dTTVc0NHFNcHQ4cVd3RmZYVzFIS3RyUHhSZVhNY0Z1KzVpZUtZZlJNMys0?=
 =?utf-8?B?ZVJQV0p6WVRWekNCSTBNejVad0d2ZjRmdk1uM2w1TjhlT1htY2l1VzVEeTBC?=
 =?utf-8?B?TDg0Z21xcW0xbi9GQ3Rna1FrcWpOQ2c0QnczRGptN2RpVlJlVElIWS9sS3Jx?=
 =?utf-8?B?TGtJMVN4aDZRQ0FDT0VqcGFOVWd4bTJOam9FcmRSZitUSmtPZDFpZHFiMDFF?=
 =?utf-8?B?MW4xMWwrUkdnTExhV1pTcXpHK1BrOXdKcDVySHExZTlDcGFoUDFVcTR1eXgz?=
 =?utf-8?B?ODdUdDdPMDUvWlNNOFFmZTBuZTFoZWNlR2Q5WnRmWWo2YWt2cDFJaWdwTEZs?=
 =?utf-8?B?S0RUTElIQ3JwbUpqYVorQnNKcGFiTWlvVGlDVEdNbG5sYVg3RllaOVZUc2hS?=
 =?utf-8?B?Rm1hMUNwbzFQR28rd3dyQWlsQ2ljRUpjRS94NG5ndno2ckJmdk1BdzRocW1y?=
 =?utf-8?B?UEZsZEkvQTV6RkJ3UDNROTluS3JiVDE3emt4dCtjQ25JWWNsOS9XK08yRG9X?=
 =?utf-8?B?SUN0S3A5M09MVjUxRkdFUlB4Ulh1MmpteFlDQzc0NklEajh5Q3VzSVVKY1g1?=
 =?utf-8?B?dm14UjVrVG93NlR6YmZsZUtEMDFYQzc1YTR1QVVkZE5OVjFXV3VsV2FBVzVW?=
 =?utf-8?B?ZWZuWUIxVkNjRnlKMldyQjlQZ1IvRStheThOSEVpajNIajR3ZnA4UkNFdGRZ?=
 =?utf-8?B?SmZ5TWVqNTN0TXlJVWRTaUVFQUdpakhFd0VOYXpBZ1lkYno2TFVidGZnV2lP?=
 =?utf-8?B?VWozZFd3Rld2K0wwSkkwTk4vRDA4bDFsREY0eW5qRWx0aUIwSHo1UCt0S3Bi?=
 =?utf-8?Q?Z0ft0Vfx6dSLSVINY7ctCmaj4EbF6txGu4pRiGBRws=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6a1c12-5280-4977-1173-08db00535776
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 10:43:35.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7dnttxl+eX+g47bzAOxc8stEp3vtoEUFI4CRd5fx7t+3xdysotNdR6qLlNgqgSYpF9GJBA54f48WqzR8QFH+ISwFL6L0c0xiwibIuTFdwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5455
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for your review. The majority of your comments are clear, I'll
spin a v3 next week. Just a few things:

On 1/25/23 11:55, Sakari Ailus wrote:
> [...]
>> +++ b/drivers/media/i2c/imx415.c
>> @@ -0,0 +1,1296 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Driver for the Sony IMX415 CMOS Image Sensor.
>> + *
>> + * Copyright (C) 2022 WolfVision GmbH.
> 
> You can use 2023 now.

Time flies, doesn't it... :-)

> [...]
>> +static int imx415_stream_on(struct imx415 *sensor)
>> +{
>> +	int ret;
>> +
>> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* wait at least 24 ms for internal regulator stabilization */
>> +	msleep(30);
> 
> This is a very, very long time to wait for a regulator. Most probably
> either the time is too long or we're waiting for something else.

I just realized that both msleep calls are after setting the mode to
operating, i.e., after getting the sensor out of standby. The other
instance of this code (see below) documents that clearly, but this
"regulator stabilization" comment here is seems wrong indeed.

>> +
>> +	return imx415_write(sensor, IMX415_XMSTA, IMX415_XMSTA_START);
>> +}
>> [...]>> +static int imx415_subdev_init(struct imx415 *sensor)
>> +{
>> +	struct i2c_client *client = to_i2c_client(sensor->dev);
>> +	int ret;
>> +
>> +	v4l2_i2c_subdev_init(&sensor->subdev, client, &imx415_subdev_ops);
>> +
>> +	ret = imx415_ctrls_init(sensor);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	sensor->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> 
> Add V4L2_SUBDEV_FL_HAS_EVENTS.

Just for my understanding: why is this required/a good idea?

>> [...]
>> +static int imx415_identify_model(struct imx415 *sensor)
>> +{
>> +	int model, ret;
>> +
>> +	/*
>> +	 * While most registers can be read when the sensor is in standby, this
>> +	 * is not the case of the sensor info register :-(
>> +	 */
>> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
>> +	if (ret < 0)
>> +		return dev_err_probe(sensor->dev, ret,
>> +				     "failed to get sensor out of standby\n");
>> +
>> +	/*
>> +	 * According to the datasheet we have to wait at least 63 us after
>> +	 * leaving standby mode. But this doesn't work even after 30 ms.
>> +	 * So probably this should be 63 ms and therefore we wait for 80 ms.
>> +	 */
>> +	msleep(80);
> 
> Wow.

This is the other occurrence of this long sleep. We could refactor this
code into a imx415_wakeup() method if desired. Otherwise, we need to
align the sleep period and the explanation at least.


Best regards,
Michael

> [...]
