Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB7687AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjBBKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjBBKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:49:09 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673F07C711;
        Thu,  2 Feb 2023 02:48:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd0NmV9qowgEdJPuf1CbAoppsd5ze5sh4nGa8IUHui1HfvEiQvZ4ss9mUdav0XpAh7elQ5FZ25rtY6M/VHhz9OPeoo9NekDOh5qHNXHCbYyNdUKbWkfYECEsdkDppu/mAwVDrXLT03MtWgy9tDeGfOTmWK1Xtdv7v4VzFvtZl1ubExYzxdt1i3V/4lWwdZSjp/Hli/JUFOEFgMWpuS8BBcBhUmQvInFjaG/14yqIWApL6gwbVqc8exe6FBXCZ7r2ki629KtKjDGuwVe16S9QI4a9AlZAN9cqf+JoyL/umWn66gOWSo6MlHgIznSXb3ZAnBbyd+uI4xqxMKNfRTv8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWwit33bqjXqSZrqWj7LtxcXi9st6ebbG/kfQ7qVqUs=;
 b=oagUPSntZIlMnfHuhypfPML7epB+MjhOFxt3+8zpGqZbQiEhK9DgJh7ullMpaHg/e57+lZ4vVOXuY2yKTpUUyMFgSruhPxQhzD3+iF0UL1ssCIryiAt574m2Rg3boaMKmW44aMJMsfPG2j3wWmyBh5QzJ1pcvzEba58Kp0ZAflaKEb01eZ9q/CojqQHHp4eysRO1RAcMOkhrXDtw5TMSLO86QBm1XWRT2I7rhsvthm1cI7Cq7SnrmyyvaBoT/4BKoAkaEUE6k5JPqP4BGW4+SWHGmhbF9x8Mr7pOtRaqGd+TAWT6auBbYyNGnZ4inDGxu+Hvr0p/IkLmtx5Tnp41Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWwit33bqjXqSZrqWj7LtxcXi9st6ebbG/kfQ7qVqUs=;
 b=Q0FaJbZ/vJSco5xFn+YBM5fARaGVPv+hJ0dLy0QmdqfCOFu6iug8vSNFsz0HlfRLbMQ7lMQhqs7O9ZmX6JAexY7PaXUWn5e/zWIj8+So1g+JxJyjVjqQyxxCeshKC0TmyRmOjqsLHwk/X3VkNa5NUt/72OpE64vNP/x/CjFvKbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DBBPR08MB6297.eurprd08.prod.outlook.com (2603:10a6:10:20b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 10:47:24 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 10:47:23 +0000
Message-ID: <8d605b82-3367-e555-90e8-64015d5a8db4@wolfvision.net>
Date:   Thu, 2 Feb 2023 11:47:21 +0100
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
 <395807d3-e242-5779-5c6d-06d750357b8c@wolfvision.net>
 <Y9t72at49U97brb/@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <Y9t72at49U97brb/@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DBBPR08MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3120f67e-c913-471d-53f9-08db050ade20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2byYN9U8suTB/MZaPJITPwFDU9M2GDFFMn9ThrYFlyApqBmNHWjODmsNUGNyCEfQY3D3YSOtXXt6F5hP0PpLJGT2lifyM5K43T5xh0logLT9GJrNaEFwsej+tOI0HbzYQdN1hNMy03MZ3bCWt16g5SQvZoZjjxVNFOGWzI5LioBx38HQLDqEVtaTHsUFNKCb82GwU2kBbb6Cos6X+0aOxuLiA5DNA9t5cBiXwcESkCv5BLka/KCBs+2PbOZts5RSiqCzNSEpvXEOhQ5tmk56rMioazVNBo5h8EXXrSVR17FmyG1WBsOkS3qa8ueU2EoNqx1pHrRnBhGIRXONi2dqUCGBOHjoLKnCq6letUDcznjV6U91pqO7Py48L92C1fwP7c09R7zNLuwz5mmgIG6BcGj6kXb6b+pxyi556m4/x/idKC6kP7xbe9Q1CdliB8iASqXZpRWOgT64i0bZ1zNSfhGi/Y1CMzSyNTmfVrz9bI40EL2/xU7fbX59KIC7FnK2U0pwi5PtQAnPfwROp7npfLLF0Fxjl5cmBOqosx5QnuqlcO/DOpuzoYByjZ0JMATiIZU/3S3/NBaWbncAlsCPs23ofqwP5gkQukIKeVNxxFQoxu/wHhXCRWZIbKz1xloTbMV/i3vPwxwEcC3AsGMcGiJDcxUJBhx7rC1NoeWA9+go06zduVzt/Amrs3IbeSFohks8f3JVbNvTVbJgLJNmbpda86gz8tJvCj8xke8JmAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(346002)(136003)(376002)(366004)(451199018)(31686004)(2906002)(31696002)(8936002)(6916009)(478600001)(8676002)(38100700002)(4326008)(36756003)(44832011)(5660300002)(6486002)(186003)(2616005)(6512007)(52116002)(86362001)(53546011)(7416002)(6506007)(83380400001)(66476007)(66556008)(41300700001)(66946007)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNYeExZRDBOK0pJMm15a28zMW92Mnl4UFU5aUdLZTV5aktFeDJEaXVhSm4r?=
 =?utf-8?B?aVp6WDBHYitaSDc2R2FlbWVxSWUyeERTS3dYb1RnTVk1enBzc2dxcVJQWnZi?=
 =?utf-8?B?N1g3OUlJQWgwZkUyclU2QitiaXhNVEVkRTBaQ0ZCblhWaTlvdlBUS2dXaHVj?=
 =?utf-8?B?MnEzc2J6djFyYlQ0Kzl4ak4zcEpoMUE5YlNaOUxQV3picUxrS3lMSTNZN1NB?=
 =?utf-8?B?UFI5Y2YvSm9FaTUrNWpMVHNtd3A5bmxwbDBXbVlBbWdtYmdYMWZYMmxITktp?=
 =?utf-8?B?dENuVWJoNWY4cDhsb0dnbXBlL0NVdEhsWHJKQlBNM2FCYmZ2TDRrOFg5YUNz?=
 =?utf-8?B?ek5GZUtSNWlHRm1YdTRLaGJrWUtWcVZ1Snh6c05hVjhTeUdSSzBRQmZKRllS?=
 =?utf-8?B?NGRvY0NYbFdRZkpRbjNKdEVzVTB5OFI1enVCQ2R2VVVpNEhGZVFqZ1ZTQW1X?=
 =?utf-8?B?QzZXWk5DeEVrdXdrU000clBGcFVDOUJDWEE3b0dJRE5DbHdRTVB4U3N1Vld4?=
 =?utf-8?B?a0FQdHZ5ZHhyQWkvRVAzWlJXMmlndzRYbGpoSHlxQUkrLzNaTmQyVExjcHkx?=
 =?utf-8?B?cW1GMzJsQzFZSURjTFRsNVVKWThFQm1XRmd1dFViTDZFMXM4YzFwbGh0czZw?=
 =?utf-8?B?bUFwZDY1cmpCenYycWRhZVVxRzhwK2RxZDdidzVoN2xqQTdKbG1UTjdnZE1H?=
 =?utf-8?B?dkl3bGw5b2QrVmJUOG4xWDdaaUJZY1JVbzh4L09lZGpuc0ZKT1owclIrZk1E?=
 =?utf-8?B?NS9Talg1bTZyWndnZFZlU05LeHF0c1JOMFJQSFZlUHRSY0xBY2owUHBHYXVI?=
 =?utf-8?B?d1RYdXJEdFYrNEhWT29wV3pPZ001Q0F5emJwdm5kdVhKUUtpaFR0MzNHYUNh?=
 =?utf-8?B?bEJCMHZNcXduSDBJOGJQWFRmNkQ2dnY5c2xPZW9hYlM1bnJCZkF4WUc4cUpi?=
 =?utf-8?B?R3ZMUmFMdEpYd1RMMW1jT0JPd0JtcFhxaXdhZ014ckdEUm55RkgvcXEzTDNO?=
 =?utf-8?B?Vis0VEJJeWdRMVU5ZkgrUzlJazRMdnBHaHF1N0ZoN0E5MWtONldoWlVRang0?=
 =?utf-8?B?NjZlSitTUWZVamowMFFZOVgxV0tRenJ0VWF0Y0NZOWFtVTB0dktUdE1MWGIv?=
 =?utf-8?B?VlF6eUUxdUpFUXRNYUlJWEZtcnIwQ29xK2NiSkJZMk1EMENvWjh2aXBXNVJ5?=
 =?utf-8?B?OGJrTU1sV1A2eGE1S2E2eXM3TDUwOVA2TERCc0xXbUxMdXJyd1ZkU1FWaXN4?=
 =?utf-8?B?SGIwQjBmTVVlbjQ0OWRHZG9FeGFrN1RMeFdkTzNRck5zcnhRZTY3NU9ab1Yz?=
 =?utf-8?B?MTJ3QkJoWVNsTUZobVNQNUZkbCtLL3JuZVhBOERjRnFrbFhxUnR2WWViYncv?=
 =?utf-8?B?VHYxMjl6QTBSODRUU05qNTJndUFUbTRjNW45K2FJMlRBelZXTjJ0TkE5cFhO?=
 =?utf-8?B?OC9VSExrVTVpN3Z4dng2cVJKem1jQUxRY0RuY0NqNEN0Mm43NVhtMStmZ3lR?=
 =?utf-8?B?NG11Y0hiQUhuNVNmdGtWMEN6cEl2ejJ1cjZhajh2V1NYSmZjbVVsWFFIRnNH?=
 =?utf-8?B?dnZ4Q0RxcFVHUmtqc3ptL01FdlVCSk1nQjFVUEYyRHdTMXFSTnNvT2t1Z0RZ?=
 =?utf-8?B?M0k3c0QyVy9uWnlBdDNTSmwrM2hyZTJqTkdBMW0vUDFIb0UvVmlMUE5TbDh3?=
 =?utf-8?B?SHVHbStZcWUwMXFjUlg0c0labndFaEJiaTF2UHRoWGlBWGFxdjB0cmRyR2FD?=
 =?utf-8?B?V0EwcmF5T2RoeXQra3JseDU3RlFpaHF6ci9Ec2x4QW1KVDlhWEFCL3FDMXFG?=
 =?utf-8?B?SlRPdGpNcGVlYVk4dDFIV3pqSlZyZDFPeGxsdmMyZUhMQjE1RDc3R1lnNE1L?=
 =?utf-8?B?TTRPZ3U1QitNVWRUWHhsK096RDYzVDIzSjVFaGI0QndlNGVVczNaT1VCWGFT?=
 =?utf-8?B?Z3NFSkh6TktJMlQ3MVdaK29HS05yVG84OEdyeWt5Q1YvVnZRQXpKUlNzZ2ZJ?=
 =?utf-8?B?VjJTQS9lYi82U05NOUtiZmFRc1ZKMHZ6NlhuSU02SnFwQ1VnY2pDSER5RWVz?=
 =?utf-8?B?RjcrYVFhVGNuZkxGMzVZUG5hdGI3ZkNncmZDT1FwOWNCMFhTalROQ3hpdE9C?=
 =?utf-8?B?VXluRjlycjU3cFduVEdpVXd5VzdldVJPckdjVWtydzJxUmVNTHV4Rkg3S2xz?=
 =?utf-8?B?VWR1Z0JEZjVRMVpaNjNHVytPTFM4Sm5xalNEdDl6bW9YMHFINXRrVk5EaWdl?=
 =?utf-8?Q?qf0W1U4lup2QEVekuIX0oDQ3egvZD/qY4fsTLZiXhM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3120f67e-c913-471d-53f9-08db050ade20
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 10:47:23.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/dzH04K1b/9/UkN9j3r16hxHxr+Y9pec9M6B70sGWoSPjAAxXkBCxpUbgZq2E+A52Ih70Yed2RoPqeVQ1f3e2xd521yGh6NtEze1j4W6r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6297
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

We tried to gather more precise information from the IMX415 data sheet
and support package, but these documents are super secret and equally
super vague.

On 2/2/23 10:01, Sakari Ailus wrote:
> [...]
>>>> +static int imx415_stream_on(struct imx415 *sensor)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/* wait at least 24 ms for internal regulator stabilization */
>>>> +	msleep(30);
>>>
>>> This is a very, very long time to wait for a regulator. Most probably
>>> either the time is too long or we're waiting for something else.
>>
>> I just realized that both msleep calls are after setting the mode to
>> operating, i.e., after getting the sensor out of standby. The other
>> instance of this code (see below) documents that clearly, but this
>> "regulator stabilization" comment here is seems wrong indeed.

The data sheet mentions "Some time is required for sensor internal
circuit stabilization..." and "...after internal regulator stabilization
24 ms or more." Well, there you go -- we need to wait some time or more
for whatever reason :-)

>>
>>>> +
>>>> +	return imx415_write(sensor, IMX415_XMSTA, IMX415_XMSTA_START);
>>>> +}
>>>> [...]>> +static int imx415_subdev_init(struct imx415 *sensor)
>>>> +{
>>>> +	struct i2c_client *client = to_i2c_client(sensor->dev);
>>>> +	int ret;
>>>> +
>>>> +	v4l2_i2c_subdev_init(&sensor->subdev, client, &imx415_subdev_ops);
>>>> +
>>>> +	ret = imx415_ctrls_init(sensor);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	sensor->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>>
>>> Add V4L2_SUBDEV_FL_HAS_EVENTS.
>>
>> Just for my understanding: why is this required/a good idea?
>>
>>>> [...]
>>>> +static int imx415_identify_model(struct imx415 *sensor)
>>>> +{
>>>> +	int model, ret;
>>>> +
>>>> +	/*
>>>> +	 * While most registers can be read when the sensor is in standby, this
>>>> +	 * is not the case of the sensor info register :-(
>>>> +	 */
>>>> +	ret = imx415_write(sensor, IMX415_MODE, IMX415_MODE_OPERATING);
>>>> +	if (ret < 0)
>>>> +		return dev_err_probe(sensor->dev, ret,
>>>> +				     "failed to get sensor out of standby\n");
>>>> +
>>>> +	/*
>>>> +	 * According to the datasheet we have to wait at least 63 us after
>>>> +	 * leaving standby mode. But this doesn't work even after 30 ms.
>>>> +	 * So probably this should be 63 ms and therefore we wait for 80 ms.
>>>> +	 */
>>>> +	msleep(80);
>>>
>>> Wow.
>>
>> This is the other occurrence of this long sleep. We could refactor this
>> code into a imx415_wakeup() method if desired. Otherwise, we need to
>> align the sleep period and the explanation at least.
> 
> I'm ok with the code, it's just a very, very long delay.

It is, and it is far from obvious how this delay comes about. The data
sheet does not specify this register at all, it is described somewhere
in the support package (as the comment above states a delay of 63
microseconds is mentioned).

Our tests indicated that the delay
 a) read out the sensor info
 b) turn on the stream
can be different. Therefore, it might make sense to use different
msleep() calls as done in the v2 of our series.

We'll try to get an updated data sheet to sort this issue out, but for
the time being can we get v3 into mainline?

Best regards,
Michael
