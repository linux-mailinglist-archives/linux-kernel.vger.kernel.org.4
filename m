Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAA740CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjF1JaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:30:06 -0400
Received: from mail-ve1eur01on2044.outbound.protection.outlook.com ([40.107.14.44]:19512
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231248AbjF1Hyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaGutGsXcBjhWQ72uLZtNEGe25mvf0jK/VoiLGf87CjDa5fL8XKkUXzg8KYsQblwuy1u2QlIU+jWQHFv+/NtrXU6w8z+ZCsbmXs9hKX/ENEUlW3u/tlpa4+aU573aOiOJNKyhR/d9eVNAATuAfXOZMswUrqPdSB0NwvTtuLoz9e8x5ZOHFq+4Y8r99n/f76f4B1iLQlOi2Y1UL4BRRU4b0W4Jc0xfk0wBQ/lshNRUak6H7LEYT/WITv1uwxhkADUkikJdJmyywqWDR1CWRNjiiFgkiWoLephyS+pOWEtfyYU3w1lk1CW+CIO/ulNGKbJ+EuWvZ/AfAL3upQIcSJZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYSvsAdSJ9IwLf0Z+7D4f7WAp8jwJjaNjFySv9rlTbk=;
 b=ItxESHn7a1k+cjvxorJE3kzGw0Dam4V9/my0pbRRmYDZK6dYFdfgpSP41Y1YxpOSiFAq+VrMJ7CZKmtjwkUkzSacEaCDxlbmqBPeyHHz3ifGcjNSPOxIC3/CpAstKYSBKgKUHpNipxAe70eIPr3N0Tu7ekhGkjlZb8eCe7mb08blXks4lsiOvw0dgJsdzSJRkk3Lx6/Oxq4WXnueAQikGqX8G5k/hFKdlpbiElXCJQI/fChS1e1/EJOW29zSd2mEqG70jCyOR7ddDUOVKwchx97XPCo1ujMyGMg0Cnr9GU9vZZE5Z4RpwrheO6lm9h3okU89Ca0/5rW5AfYQlHl4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYSvsAdSJ9IwLf0Z+7D4f7WAp8jwJjaNjFySv9rlTbk=;
 b=clWAHZMVgMJO9AD7yTgdbW5yTxx0gLPbnYn2b9/8xRDG4yK6stFrKJoYFl9uWjgVQwNxM1qCifMuSSW+2Xoxex6aS1qUGMFqP+HZNjLWT6Ga9fXGylo3yYP84iCIG61eY2pXgqd5UrnKWOFDMMXInC0fZq//D6gq/2PJ6HLbI1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DBBPR08MB6188.eurprd08.prod.outlook.com (2603:10a6:10:1f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 06:44:53 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 06:44:52 +0000
Message-ID: <543b2d74-eac4-3856-17c6-0654459a91b4@wolfvision.net>
Date:   Wed, 28 Jun 2023 08:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay object
 handling
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
 <ZJmW/KOCJF25Z79t@nixie71>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZJmW/KOCJF25Z79t@nixie71>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::39) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DBBPR08MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f543730-45e5-4135-f80c-08db77a32d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DOPkypeJudvkdjUFVwpEIlkUrY8wNYX5oTvdV/Tl/Cd/OLDUGO4M8n08POV36ZYFSnQAw7IPWoDch3Po7+VJc2RU9wdVgPOWsfkk4nVqX9yIgXr6xAMnVl1cUeAHMXOB5BQy1LPR+s4PR6JetcfvALhKRy993LAYKqfBkScDsqqwIrQv/KDsEyVtv4P1exHu55D111+xSPmIsMrpsJSWBswvgY4EUUWSYl0u7Giyt1au0xyAXydb2p3ZWPe3En+6dgc1rH/7zFndj//dZ7P7/bd8Tx5ScP9R7vyH0+vKzlfW6eXShnJVk+7YmSU8fQ4qYIhfwYTWm6Im62HjxJt67C0aTx4LfzF4e/jIPm4SuksmRQ9mcOuBYOoudmW73cZ88QNDrccJaW+j0uqCC57vMJdZ8+kHLGrpT//D3SmWqMEwk0RxHb96szMT61+FNMGxMminMUy4nddfod7YR1CVSQNpDKX0w00ihA5TVL6g40RdT/xgiG9HiAVDTTfHoqstjKczJvxKuoy+Sc6v7gccPGZ9SIRifWeMcAckgZlDFlyPXHzofvi3r8dnKWDxEKE3PXOTsb8yP9wzTQAgeZ3nYP6FEmQQBJXX5h0Sq/YsT058TfZbc/IIQJA1gnH3p7XdKFDS7Hmlvd1l0mSnqGG6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(39850400004)(346002)(451199021)(83380400001)(966005)(45080400002)(54906003)(478600001)(6486002)(53546011)(2906002)(66946007)(6512007)(26005)(30864003)(186003)(66556008)(66476007)(6506007)(316002)(7416002)(44832011)(38100700002)(41300700001)(5660300002)(8676002)(36756003)(6916009)(4326008)(8936002)(86362001)(31696002)(2616005)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2Q3RTZxY3doT1ZCS09KUFpwaEViNkhJcFBHTlJZcXFaMllwQTF0ZzBZZTh4?=
 =?utf-8?B?RUhLNVlPNGdOQXp6QitTMG9pSFd5Z0l2WmdUVDAzeWRHZS9FMm5ZcldUTHRl?=
 =?utf-8?B?cHRmV2RKOGl1cHJocVZ3d29JSkt1ZkZmTk1hNnYwMTg5V0ttL0xobWFYYytJ?=
 =?utf-8?B?OVJSUEhpb3hzRVJTS3pkbHR1TGxUUG5MTnF5eG5jdVlnRitiTWkrM2xPSkVS?=
 =?utf-8?B?d1FWaFQxSnR3TmZJYVRKUmtiQ2JEcmpRSExiVjhXZE9BYnpZMUsrekFqallG?=
 =?utf-8?B?WUxPT2NvYkU1L280WVVRNDRqU0J5UzlGMUw1Z0N5ZktPK0I3ZjFMUTBRR0Jj?=
 =?utf-8?B?MmpaNVRHSG1IbS9udkpUb1BnTUI4MTJob2N1OG9iNVI1a1I2bnRsWnpDdU5Z?=
 =?utf-8?B?cjRoSUlKSzVKS00zOEdDN0hqcWVhTE1FUUh5OHdBTXhkbk95WGJFM0V3ckFY?=
 =?utf-8?B?MnhGVXRDcFJnYmpHc2czYzdHSkpNeCtYOTJUWWEyQ0tjZG5vRHNlMHlwVDRK?=
 =?utf-8?B?eU42M0JVNXJJQ1VqcUhzaDVHZjBaWHNNWUZHbTRSNmUwMk5zT2lMV3NRcGdB?=
 =?utf-8?B?ZHNhV3BkV1BocE9Qbk9FbmFHNG9TTlpqMmZxckxTMmNSK1BKczFpUVlDQU5t?=
 =?utf-8?B?cjJOMWwyVEFkU1ZsQThRZ0R4cnR1VXJBdnNZeCtabnd0VVFTOENOdHZ5V1hQ?=
 =?utf-8?B?UWxDclZoa3dzMzJMdEZOV01Ya0FaREp5SUg5UThSL1VOTEwwK1FlVVBQZExH?=
 =?utf-8?B?bVkvc3FxVnpwVUZqSU1DTjR5QSsxdmZzTEZ0dVcyOVdjSldQdE9ZSTFmbHJU?=
 =?utf-8?B?SmU0WWhhdTYzYU9ITHFudUFucWdhYzJrRmhEVW9LL1ZHV0tlYURyeStVU1BC?=
 =?utf-8?B?aVJoa3NaTmh0SGtVZ0g3Znc5K3lUSW92VEN1a3ZwdDE1clNWbTVLUUl4SU5Q?=
 =?utf-8?B?Zkd0MWlGZmlCMDJuSDZqV1RFM3YvbjdXUnJNYk5TSEo0bzE5VEcxTEhyU0xD?=
 =?utf-8?B?MjduaUdmcmZ0Z04wNFJSa3pKdTV6dXJmcnFrdUhuN2wvKzhJYzJMNnhpSko5?=
 =?utf-8?B?NUNabHcwTStUcWtJd1lvaHVMTitCdENlTjhVRjlLcklsSW5yVm80ZE4xNG9s?=
 =?utf-8?B?dzMySGNIMGNqOUl0YWFDSmxKTlBzQ1pWU3RqQ1dObkdDeHlxU08rbFlYTVMy?=
 =?utf-8?B?cGRjcWhQRXBNNXlEUGh1OGVrYzR1RHZrbE92U1JVVTdpcE5JZDdiREN2NXlw?=
 =?utf-8?B?TmhraFp4Znh4UUx0VmhZbDdWem5LdDdEaGhxTndTTStBVUk0aC9DUlJHbnRH?=
 =?utf-8?B?eThZUHV1L3RrcjdIV3RIU01FQmNBS3FBaWxJTXh1bmFLTjlBZ3FXemhOdkpM?=
 =?utf-8?B?RkNsS0FxaWxyakQ5WnRnUUVRMlJmK2t6dDRvZkc5dmpsWVpLK0drR0d1UGkz?=
 =?utf-8?B?aXJzVTZrSzA4VWt0M0Y5cE84SFdsZ3N6YjkyY1YzaEFBVjNnL0xDRTcwekJh?=
 =?utf-8?B?NUpQQnhqemVTTHNzSU4yMW1RVU9aWm5jYnJ1azlRTk9tSDc2aXdmK09IYm5D?=
 =?utf-8?B?WEdKSWFwL3hqcTlGQ2NaL1U3bSs1Z3ZoS2NkNGpwNjJucEtqcGlJMGYvNERF?=
 =?utf-8?B?cGYxbzJIem80b2tra0RhWU1nNFA0cTlta25KQmY2aG1pUnExelNJNng1c082?=
 =?utf-8?B?WVFDNkZCdWZhdlZPQ2lnaXZmK1c3VDlUamZCRm1OK3hvYzBTMlJUVHpEaXdu?=
 =?utf-8?B?MzhYSlV4REE0d2lSMTYrQ2syWmNCdnNCWlc5ekthN29DY3ZoR1RnQWN6MzRO?=
 =?utf-8?B?eEI5NUxrSi9mV3JnZFZ0dStoNzk0TVgzcS9Gaks0U1VaR2I5ZFdWTm9yYmph?=
 =?utf-8?B?K28vQkpLQmVQNzNRV2RKMjFVUTh3eGpFb1ZoeGNEa2RBa2hCZ3hNRC8rQmFL?=
 =?utf-8?B?SHFLZzFWdGczcHozbnpjSTl5K1crQVZWVzNjbHQydDBSRkJIWkgyclNST3Ay?=
 =?utf-8?B?bTVFQVVmb2kxRkFzS3hEck84ZmpVRUZhWVc1RFZIa1hiQWJaQzk2WERXZHBF?=
 =?utf-8?B?RGM4UDAxd1lQdWdGMFBxNEJObFM4YmJxeVNQR01hUk5UTzlBQnBGNXdSVzR1?=
 =?utf-8?B?TVVQYWdRUzNTbWZzUTVLQU9UaStRNzM0aFczaGRmcnNZLzU1TXIvcXhOS2tN?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f543730-45e5-4135-f80c-08db77a32d29
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 06:44:52.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8Qoyg2Gh9a/qKdLr+0C901PvAtLbpZC7JlnfvB0g2M8TUzFRkkJGtZ6RiL7XlGJVNecrRM9R6rFbHcF0LSw8s9/7I01X3X0NIrhH9opo2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26.06.23 15:47, Jeff LaBundy wrote:
> Hi Javier,
> 
> On Mon, Jun 26, 2023 at 12:31:21PM +0200, Javier Carrasco wrote:
>> Hi Jeff,
>>
>> On 26.06.23 04:35, Jeff LaBundy wrote:
>>> Hi Javier,
>>>
>>> On Fri, Jun 16, 2023 at 09:28:51AM +0200, Javier Carrasco wrote:
>>>> Some touchscreens provide mechanical overlays with different objects
>>>> like buttons or clipped touchscreen surfaces.
>>>>
>>>> In order to support these objects, add a series of helper functions
>>>> to the input subsystem to transform them into overlay objects via
>>>> device tree nodes.
>>>>
>>>> These overlay objects consume the raw touch events and report the
>>>> expected input events depending on the object properties.
>>>>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>>>> ---
>>>
>>> Excellent work; it's great to see this series move along.
>>>
>>>>  MAINTAINERS                            |   7 +
>>>>  drivers/input/touchscreen/Kconfig      |   9 +
>>>>  drivers/input/touchscreen/Makefile     |   1 +
>>>>  drivers/input/touchscreen/ts-overlay.c | 356 +++++++++++++++++++++++++++++++++
>>>>  include/linux/input/ts-overlay.h       |  43 ++++
>>>>  5 files changed, 416 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 7e0b87d5aa2e..db9427926a4c 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
>>>>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>>>>  F:	Documentation/translations/zh_TW/
>>>>  
>>>> +TOUCHSCREEN OVERLAY OBJECTS
>>>> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
>>>> +L:	linux-input@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	drivers/input/touchscreen/ts-overlay.c
>>>> +F:	include/linux/input/ts-overlay.h
>>>> +
>>>>  TTY LAYER
>>>>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>  M:	Jiri Slaby <jirislaby@kernel.org>
>>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>>>> index 143ff43c67ae..8382a4d68326 100644
>>>> --- a/drivers/input/touchscreen/Kconfig
>>>> +++ b/drivers/input/touchscreen/Kconfig
>>>> @@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
>>>>  	  To compile this driver as a module, choose M here: the
>>>>  	  module will be called himax_hx83112b.
>>>>  
>>>> +config TOUCHSCREEN_TS_OVERLAY
>>>> +	bool "Touchscreen Overlay Objects"
>>>> +	help
>>>> +	  Say Y here if you are using a touchscreen driver that supports
>>>> +	  printed overlays with keys or a clipped touchscreen area.
>>>> +
>>>> +	  Should be selected by the touchscren drivers that support
>>>> +	  this feature.
>>>> +
>>>>  endif
>>>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>>>> index 159cd5136fdb..f554826706ff 100644
>>>> --- a/drivers/input/touchscreen/Makefile
>>>> +++ b/drivers/input/touchscreen/Makefile
>>>> @@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
>>>>  obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
>>>> +obj-$(CONFIG_TOUCHSCREEN_TS_OVERLAY)	+= ts-overlay.o
>>>
>>> It seems like this feature is useful for any two-dimensional touch surface
>>> (e.g. trackpads) and not just touchscreens. For that reason, the touchscreen
>>> helpers in touchscreen.c were moved out of input/touchscreen and into input/
>>> such that they are not guarded by CONFIG_INPUT_TOUCHSCREEN. A growing number
>>> of devices in input/misc are taking advantage of these.
>>>
>>> Therefore, I think this feature should follow suit and be available to any
>>> input device as is the case for touchscreen.c. As written, the newly updated
>>> binding is misleading because one may believe that any device that includes
>>> touchscreen.yaml can define an overlay child, but the code does not currently
>>> support this.
>>>
>>> To that end, it seems like touch-overlay would be a more descriptive name as
>>> well. I understand that the name has changed once already, so hopefully this
>>> feedback is not too annoying :)
>>>
>> changing names is no problem at all as long as it makes the feature more
>> comprehensible and/or takes more suitable devices into account, which
>> would be the case. So I will move the code from touchscreen to input and
>> I will update the names and descriptions to make them more generic.
>>
>> I guess then I will need to move the properties to a separate binding
>> for this feature because it will not be an addition to the touchscreen
>> bindings anymore, right?
> 
> Technically this feature was never bound to touchscreen.yaml in the first place.
> touchscreen.yaml defines scalar properties under a parent input device; your new
> binding defines a child node and subsequent properties under the same, or another
> parent input device.
> 
> That said, it is highly unlikely that one would use your feature without also
> using the properties from touchscreen.yaml. It is perfectly fine in my opinion,
> and perhaps more convenient, to define the overlay child in touchscreen.yaml as
> you have done so that binding authors need not reference two files.
> 
> I do agree that it seems more natural for code living in input to be bound by
> bindings in dt-bindings/input and not dt-bindings/input/touchscreen/, but there
> was push back when the same question came up for touchscreen.yaml [1] some time
> ago.
> 
> [1] https://patchwork.kernel.org/patch/12042037/
> 
I will move this feature from input/touchscreen to input and add the
object to the input-core as it is done with the touchscreen object,
making it available for the rest of input devices. On the other hand the
bindings will stay where they are inside of touchscreen.yaml as you
suggested.
>>
>>>> diff --git a/drivers/input/touchscreen/ts-overlay.c b/drivers/input/touchscreen/ts-overlay.c
>>>> new file mode 100644
>>>> index 000000000000..7afa77d86c1f
>>>> --- /dev/null
>>>> +++ b/drivers/input/touchscreen/ts-overlay.c
>>>> @@ -0,0 +1,356 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + *  Helper functions for overlay objects on touchscreens
>>>> + *
>>>> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
>>>> + */
>>>> +
>>>> +#include <linux/property.h>
>>>> +#include <linux/input.h>
>>>> +#include <linux/input/mt.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/input/ts-overlay.h>
>>>> +
>>>> +enum ts_overlay_valid_objects {
>>>> +	TOUCHSCREEN,
>>>> +	BUTTON,
>>>
>>> Please namespace these, i.e. TOUCH_OVERLAY_*.
>>>
>>>> +};
>>>> +
>>>> +static const char *const ts_overlay_names[] = {
>>>> +	[TOUCHSCREEN] = "overlay-touchscreen",
>>>
>>> I'm a little confused why we need new code for this particular function; it's
>>> what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
>>> can't we keep using those?
>>>
>> According to the bindings, touchscreen-min-x/y define the minimum
>> reported values, but the overlay-touchscreen is actually setting a new
>> origin. Therefore I might be misusing those properties. On the other
>> hand touchscreen-size-x/y would make more sense, but I also considered
>> the case where someone would like to describe the real size of the
>> touchscreen outside of the overlay node as well as the clipped size
>> inside the node. In that case using the same property twice would be
>> confusing.
>> So in the end I thought that the origin/size properties are more precise
>> and applicable for all objects and not only the overlay touchscreen.
>> These properties are needed for the buttons anyways and in the future
>> more overlay would use the same properties.
> 
> Ah, I understand now. touchscreen-min-x/y define the lower limits of the axes
> reported to input but they don't move the origin. I'm aligned with the reason
> to introduce this function.
> 
> This does beg the question as to whether we need two separate types of children
> and related parsing code. Can we not simply have one overlay definition, and
> make the decision as to whether we are dealing with a border or virtual button
> based on whether 'linux,code' is present?
> 
A single overlay definition would be possible, but in case more objects
are added in the future, looking for single properties and then deciding
what object it is might get messy pretty fast. You could end up needing
a decision tree and the definition in the DT would get more complex.

Now the decision tree is straightforward (linux,code -> button), but
that might not always be the case. In the current implementation there
are well-defined objects and adding a new one will never affect the
parsing of the rest.
Therefore I would like to keep it more readable and easily extendable.
>>
>>>> +	[BUTTON] = "overlay-buttons",
>>>> +};
>>>> +
>>>> +struct ts_overlay_shape {
>>>> +	u32 x_origin;
>>>> +	u32 y_origin;
>>>> +	u32 x_size;
>>>> +	u32 y_size;
>>>> +};
>>>> +
>>>> +struct ts_overlay_button {
>>>> +	struct ts_overlay_shape shape;
>>>> +	u32 key;
>>>> +	bool pressed;
>>>> +	int slot;
>>>> +};
>>>> +
>>>> +static int ts_overlay_get_shape_properties(struct fwnode_handle *child_node,
>>>> +					   struct ts_overlay_shape *shape)
>>>> +{
>>>> +	int rc;
>>>
>>> In input, the common practice is to use 'error' for return values that are either
>>> zero or negative. The reasoning is because the variable quite literally represents
>>> an error, or lack thereof. And then:
>>>
>>> 	error = ...
>>> 	if (error)
>>> 		return error;
>>>
>>>> +
>>>> +	rc = fwnode_property_read_u32(child_node, "x-origin", &shape->x_origin);
>>>> +	if (rc < 0)
>>>> +		return rc;
>>>
>>> It seems like all of these properties are required; if so, please update the
>>> binding to make this clear.
>>>
>>> If the binding is correct and these properties are in fact optional, then you
>>> must evaluate fwnode_property_read_u32() against -EINVAL.
>>>
>> If I end up writing new bindings for this feature, it will be more clear
>> what is required and what not because I will not be part only of the
>> touchscreen anymore. These properties will be required.
> 
> The question of whether to split the overlay child definition from touchscreen.yaml
> is orthogonal to this point. If the code fails in the absence of these properties,
> then you must add a "required:" heading within the overlay child node definition to
> call out these properties.
> 
>>>> +
>>>> +	rc = fwnode_property_read_u32(child_node, "y-origin", &shape->y_origin);
>>>> +	if (rc < 0)
>>>> +		return rc;
>>>> +
>>>> +	rc = fwnode_property_read_u32(child_node, "x-size", &shape->x_size);
>>>> +	if (rc < 0)
>>>> +		return rc;
>>>> +
>>>> +	rc = fwnode_property_read_u32(child_node, "y-size", &shape->y_size);
>>>> +	if (rc < 0)
>>>> +		return rc;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ts_overlay_get_button_properties(struct device *dev,
>>>> +					    struct fwnode_handle *child_node,
>>>> +					    struct ts_overlay_button *btn)
>>>> +{
>>>> +	struct fwnode_handle *child_btn;
>>>> +	int rc;
>>>> +	int j = 0;
>>>> +
>>>> +	fwnode_for_each_child_node(child_node, child_btn) {
>>>> +		rc = ts_overlay_get_shape_properties(child_btn, &btn[j].shape);
>>>> +		if (rc < 0)
>>>> +			goto button_prop_cleanup;
>>>> +
>>>> +		rc = fwnode_property_read_u32(child_btn, "linux,code",
>>>> +					      &btn[j].key);
>>>> +		if (rc < 0)
>>>> +			goto button_prop_cleanup;
>>>
>>> The binding needs to list this property as required, too.
>>>
>> Do you mean "linux,code"? It is already listed with the same pattern
>> that some other bindings use:
>>
>> linux,code: true
>>
>> Is that not right? I did not want to redefine an existing property that
>> other bindings already make use of.
> 
> These are separate things. You must additionally list 'linux,code' under a
> 'required:' heading if the code fails without the property defined. If you
> adopt the idea above to decide whether we are dealing with a border or button
> based on the presence of this property, then it goes back to being optional
> of course.
> 
As I mentioned above, I will keep the feature documentation in the
touchscreen.yaml as a node and add the 'required' to the properties
needed for the code not to fail.
>>>> +
>>>> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
>>>> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
>>>> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
>>>
>>> This seems like a dev_dbg() to me.
>>>
>>>> +		j++;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +button_prop_cleanup:
>>>> +	fwnode_handle_put(child_btn);
>>>> +	return rc;
>>>> +}
>>>> +
>>>> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
>>>> +				struct input_dev *dev)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < map->button_count; i++)
>>>> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_set_button_caps);
>>>
>>> I don't see a need to expose this function and require participating drivers
>>> to call it; we should just have one over-arching function for processing the
>>> overlay(s), akin to touchscreen_parse_properties but for the button input
>>> device in case the driver separates the button and touchscreen input devices.
>>>
>>> That one function would then be responsible for parsing the overlay(s) and
>>> calling input_set_capability() on each button.
>>>
>>>> +
>>>> +static int ts_overlay_count_buttons(struct device *dev)
>>>> +{
>>>> +	struct fwnode_handle *child_node;
>>>> +	struct fwnode_handle *child_button;
>>>
>>> These names confused me; they're both children, but only the second is aptly
>>> named. How about child_overlay and child_button, or perhaps overlay_node and
>>> button_node?
>>>
>>>> +	int count = 0;
>>>> +
>>>> +	child_node = device_get_named_child_node(dev, ts_overlay_names[BUTTON]);
>>>> +	if (!child_node)
>>>> +		return 0;
>>>> +
>>>> +	fwnode_for_each_child_node(child_node, child_button)
>>>> +		count++;
>>>> +	fwnode_handle_put(child_node);
>>>> +
>>>> +	return count;
>>>> +}
>>>> +
>>>> +static int ts_overlay_map_touchscreen(struct device *dev,
>>>> +				      struct ts_overlay_map *map)
>>>> +{
>>>> +	struct fwnode_handle *child;
>>>
>>> Same here; there are two layers of children, so please use more descriptive
>>> variable names.
>>>
>>>> +	int rc = 0;
>>>> +
>>>> +	child = device_get_named_child_node(dev, ts_overlay_names[TOUCHSCREEN]);
>>>> +	if (!child)
>>>> +		goto touchscreen_ret;
>>>
>>> I don't think we need a label here; just return 0 directly.
>>>
>>>> +
>>>> +	map->touchscreen =
>>>> +		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
>>>> +	if (!map->touchscreen) {
>>>> +		rc = -ENOMEM;
>>>> +		goto touchscreen_handle;
>>>> +	}
>>>> +	rc = ts_overlay_get_shape_properties(child, map->touchscreen);
>>>> +	if (rc < 0)
>>>> +		goto touchscreen_free;
>>>> +
>>>> +	map->overlay_touchscreen = true;
>>>> +	dev_info(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
>>>> +		 map->touchscreen->x_origin, map->touchscreen->y_origin,
>>>> +		 map->touchscreen->x_size, map->touchscreen->y_size);
>>>
>>> dev_dbg()
>>>
>>>> +
>>>> +	rc = 0;
>>>
>>> rc (error) can only be zero if we have gotten this far; I don't see a need
>>> to assign it here.
>>>
>>>> +	goto touchscreen_handle;
>>>
>>> Please think about whether this can be reorganized to prevent jumping over
>>> small bits of code; I found it hard to follow. Maybe one or more tasks can
>>> be offloaded to a helper function?
>>>
>>>> +
>>>> +touchscreen_free:
>>>> +	devm_kfree(dev, map->touchscreen);
>>>
>>> This set off a red flag; it's unclear that it's necessary. Regardless of
>>> whether the participating driver is smart enough to bail during probe()
>>> if the overlay parsing fails, or it happily continues, this memory will
>>> get freed when the driver tied to 'dev' is torn down.
>>>
>>> Calling devm_kfree() is generally limited to special cases where you are
>>> dynamically reallocating memory at runtime. In case I have misunderstood
>>> the intent, please let me know.
>>>
>> Would devm_kfree() not free the memory immediately if the parsing fails,
>> making it available for any process instead of waiting until the driver
>> is torn down, which might never happen? Otherwise that chunk of memory
>> will not be accessible even though it is useless because the operation
>> failed, right? Or am I missing something?
> 
> If the participating driver does not immediately fail to probe (and hence
> free all of its device-managed resources) upon failure to parse this or any
> other required properties, that is a bug in that driver.
> 
In that case I will remove the call to devm_kfree and trust the
participating drivers.
>>>> +touchscreen_handle:
>>>> +	fwnode_handle_put(child);
>>>> +touchscreen_ret:
>>>> +	return rc;
>>>> +}
>>>> +
>>>> +static int ts_overlay_map_buttons(struct device *dev,
>>>> +				  struct ts_overlay_map *map,
>>>> +				  struct input_dev *input)
>>>> +{
>>>> +	struct fwnode_handle *child;
>>>> +	u32 button_count;
>>>> +	int rc = 0;
>>>> +
>>>> +	button_count = ts_overlay_count_buttons(dev);
>>>> +	if (button_count) {
>>>> +		map->buttons = devm_kcalloc(dev, button_count,
>>>> +					    sizeof(*map->buttons), GFP_KERNEL);
>>>> +		if (!map->buttons) {
>>>> +			rc = -ENOMEM;
>>>> +			goto map_buttons_ret;
>>>> +		}
>>>> +		child = device_get_named_child_node(dev,
>>>> +						    ts_overlay_names[BUTTON]);
>>>> +		if (unlikely(!child))
>>>> +			goto map_buttons_free;
>>>> +
>>>> +		rc = ts_overlay_get_button_properties(dev, child, map->buttons);
>>>> +		if (rc < 0)
>>>> +			goto map_buttons_free;
>>>> +
>>>> +		map->button_count = button_count;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +map_buttons_free:
>>>> +	devm_kfree(dev, map->buttons);
>>>> +map_buttons_ret:
>>>> +	return rc;
>>>> +}
>>>> +
>>>> +static bool ts_overlay_defined_objects(struct device *dev)
>>>> +{
>>>> +	struct fwnode_handle *child;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(ts_overlay_names); i++) {
>>>> +		child = device_get_named_child_node(dev, ts_overlay_names[i]);
>>>> +		if (child) {
>>>> +			fwnode_handle_put(child);
>>>> +			return true;
>>>> +		}
>>>> +		fwnode_handle_put(child);
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
>>>> +					      struct input_dev *input)
>>>> +{
>>>> +	struct ts_overlay_map *map = NULL;
>>>> +	int rc;
>>>> +
>>>> +	if (!ts_overlay_defined_objects(dev))
>>>> +		return NULL;
>>>> +
>>>> +	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
>>>> +	if (!map) {
>>>> +		rc = -ENOMEM;
>>>> +		goto objects_err;
>>>> +	}
>>>> +	rc = ts_overlay_map_touchscreen(dev, map);
>>>> +	if (rc < 0)
>>>> +		goto objects_free;
>>>> +
>>>> +	rc = ts_overlay_map_buttons(dev, map, input);
>>>> +	if (rc < 0)
>>>> +		goto objects_free;
>>>> +
>>>> +	return map;
>>>> +
>>>> +objects_free:
>>>> +	devm_kfree(dev, map);
>>>> +objects_err:
>>>> +	return ERR_PTR(rc);
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_map_objects);
>>>> +
>>>> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y)
>>>> +{
>>>> +	*x = map->touchscreen->x_size - 1;
>>>> +	*y = map->touchscreen->y_size - 1;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_get_touchscreen_abs);
>>>> +
>>>> +static bool ts_overlay_shape_event(struct ts_overlay_shape *shape, u32 x, u32 y)
>>>> +{
>>>> +	if (!shape)
>>>> +		return false;
>>>> +
>>>> +	if (x >= shape->x_origin && x < (shape->x_origin + shape->x_size) &&
>>>> +	    y >= shape->y_origin && y < (shape->y_origin + shape->y_size))
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static bool ts_overlay_touchscreen_event(struct ts_overlay_shape *touchscreen,
>>>> +					 u32 *x, u32 *y)
>>>> +{
>>>> +	if (ts_overlay_shape_event(touchscreen, *x, *y)) {
>>>> +		*x -= touchscreen->x_origin;
>>>> +		*y -= touchscreen->y_origin;
>>>> +		return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map)
>>>> +{
>>>> +	if (!map || !map->overlay_touchscreen)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_mapped_touchscreen);
>>>> +
>>>> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map)
>>>> +{
>>>> +	if (!map || !map->button_count)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_mapped_buttons);
>>>> +
>>>> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y)
>>>> +{
>>>> +	if (!ts_overlay_mapped_touchscreen(map))
>>>> +		return true;
>>>> +
>>>> +	if (!ts_overlay_touchscreen_event(map->touchscreen, x, y))
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_mt_on_touchscreen);
>>>> +
>>>> +bool ts_overlay_button_press(struct ts_overlay_map *map,
>>>> +			     struct input_dev *input, u32 x, u32 y, u32 slot)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (!ts_overlay_mapped_buttons(map))
>>>> +		return false;
>>>> +
>>>> +	for (i = 0; i < map->button_count; i++) {
>>>> +		if (ts_overlay_shape_event(&map->buttons[i].shape, x, y)) {
>>>> +			input_report_key(input, map->buttons[i].key, 1);
>>>> +			map->buttons[i].pressed = true;
>>>> +			map->buttons[i].slot = slot;
>>>> +			return true;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_button_press);
>>>
>>> The level of abstraction here does not seem quite right. Rather than force
>>> each participating driver to call a press and release function, I think it
>>> is better to expose something like touch_overlay_process_buttons() which
>>> then handles the press and release events internally.
>>>
>>> You're also relying on each individual driver to decide whether a touch
>>> coordinate is inside or outside the overlay, and selectively call the press
>>> and release functions OR report coordinates which is non-optimal.
>>>
>>> To me, this says we actually need one wrapper function that accepts handles
>>> to both the touchscreen and button input devices (which may be the same at
>>> the driver's discretion) as well as the coordinates. If the coordinate is
>>> within an overlay area, handle press/release; if not, call touchscreen_report_pos().
>>>
>>>> +
>>>> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (!map || !map->button_count)
>>>> +		return false;
>>>> +
>>>> +	for (i = 0; i < map->button_count; i++) {
>>>> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot)
>>>> +			return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_is_button_slot);
>>>> +
>>>> +void ts_overlay_button_release(struct ts_overlay_map *map,
>>>> +			       struct input_dev *input, u32 slot)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (!map || !map->button_count)
>>>> +		return;
>>>> +
>>>> +	for (i = 0; i < map->button_count; i++) {
>>>> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot) {
>>>> +			input_report_key(input, map->buttons[i].key, 0);
>>>> +			map->buttons[i].pressed = false;
>>>> +		}
>>>> +	}
>>>> +}
>>>> +EXPORT_SYMBOL(ts_overlay_button_release);
>>>> +
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_DESCRIPTION("Helper functions for overlay objects on touchscreens");
>>>> diff --git a/include/linux/input/ts-overlay.h b/include/linux/input/ts-overlay.h
>>>> new file mode 100644
>>>> index 000000000000..b75df0dec3ab
>>>> --- /dev/null
>>>> +++ b/include/linux/input/ts-overlay.h
>>>> @@ -0,0 +1,43 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
>>>> + */
>>>> +
>>>> +#ifndef _TS_OVERLAY
>>>> +#define _TS_OVERLAY
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +struct input_dev;
>>>> +struct device;
>>>> +
>>>> +struct ts_overlay_map {
>>>> +	struct ts_overlay_shape *touchscreen;
>>>> +	bool overlay_touchscreen;
>>>> +	struct ts_overlay_button *buttons;
>>>> +	u32 button_count;
>>>> +};
>>>> +
>>>> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
>>>> +					      struct input_dev *input);
>>>> +
>>>> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y);
>>>> +
>>>> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map);
>>>> +
>>>> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map);
>>>> +
>>>> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y);
>>>> +
>>>> +bool ts_overlay_button_press(struct ts_overlay_map *map,
>>>> +			     struct input_dev *input, u32 x, u32 y, u32 slot);
>>>> +
>>>> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot);
>>>> +
>>>> +void ts_overlay_button_release(struct ts_overlay_map *map,
>>>> +			       struct input_dev *input, u32 slot);
>>>> +
>>>> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
>>>> +				struct input_dev *dev);
>>>> +
>>>> +#endif
>>>>
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>> Kind regards,
>>> Jeff LaBundy
>>
>> Thanks again for your feedback, I really appreciate it. All the comments
>> without a reply can be taken as acknowledged and accepted as they are
>> without further discussion. I will work on them for the next version.
> 
> Sure thing! Thank you for your efforts.
> 
>>
>> Thank you for your time and best regards,
>> Javier Carrasco
> 
> Kind regards,
> Jeff LaBundy
Thanks again, I will start working on the next version asap.

Best regards,
Javier Carrasco
