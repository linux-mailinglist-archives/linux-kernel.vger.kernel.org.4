Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B073DC40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjFZKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:31:30 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF2619A;
        Mon, 26 Jun 2023 03:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eayNWNEPNdo3iwG1ww/LouaJfcGf8A/uBYqbK6gyN9G3UKm2wZ5kj7Op24WPSYm1suiJalYRUJ7qkCMjYLjvrt5phkgh1Bh+5Dh+nuFaLfs31PM89SCFCBoS9RZW7qFF6YzLFjPPsoYuSYIHp13J2dFiaG0A3b16YSisICoOtM9h/BGW45GlorFQ52Rr492FvJFKkzlEXdaSRw5MYGZ/aU65QMXrDrCYXvnltfqd+TG2QDbJNcz2kNA1P20DkP2hDqGcQiyhu4w+Pfds/KiucTofmxN30VrVM9nIzlo45Z3MCfUw6FBNRgKYW+gYuSxzglwvDj5f30zrooYidx2x6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMXmBDgAgJNISQdNr9zifcqh7+n9iQnEVMh6lClRjQw=;
 b=mh7rzNwV584m0Ec8k6pcCgkFmesjidEdQToFSB6k/YoqIM5v+OUSIKEt0Ipk8XWHlDngf1+vWCF9g44eL7/seQ2EzW0QRhh9ElAXV9HHxlvYIEyDZ8x3bYmJeRuHwg86Dnyt17rejEL9cdSWhukCFYgXJG2+f7v8efMSkGW6kOb+k9woI0xscaY2g8RWU7p6/Ss5jCQMN5EzG7ijsy+Eb066hwWuC/2nlKDFvvY7SBoaZlZMSpPbzVHYV0m1GCxjv7gNNUNnTtv0HGh/G6yfLVjQvJh8cMQCIQ71nu53AV07vBQ8YZAFFlGTm5ykTUKAlAjWG4hhbxvSWn2m9bku6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMXmBDgAgJNISQdNr9zifcqh7+n9iQnEVMh6lClRjQw=;
 b=CSXoHKcImavl1AAhQlBBVp1lqJ22+8BRbGVDDFqShy2IwTUuvHj0cLoRVsCiajolD+xPJFLmDoMW3X2E7GfgZxCz+qW2QLkPiIMB2IpKJ59bmISWj9IX0PCkTM+Lzt3fRIHW0Q3ZaS4Pw4ajJMfsYhSez3B/SkUioV2gdKXWyIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB7692.eurprd08.prod.outlook.com (2603:10a6:10:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 10:31:23 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 10:31:23 +0000
Message-ID: <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
Date:   Mon, 26 Jun 2023 12:31:21 +0200
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
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZJj5VcHvfMMWMRx8@nixie71>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR08CA0224.eurprd08.prod.outlook.com
 (2603:10a6:802:15::33) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: a455b2c9-b1a9-4246-f5b0-08db76307d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNBPD/FEITdmIgDKfqyK0hAsg7nrxslLW4ZDxUbKjdE0OlDZHiXd9TLmacTV4z4net3FmpKmuMre+LadQzAGS/Qj1SBiKUfcj0WCWSZ48OpAUS1Oi+qJkwI52r4yWHR8lBYAq58W2o11UJgycrkj5XbB4WJN91esyh7i/BSC9VRuFo09UHgmVhxD5axMgUUAzCnbv3vMomHVsZucXlI30x76ZulGozioo3f9wCCyWh19VO6D8cn3GtZ+CtUTwC1z8vHZNSijYS1Za409mN0UFxbTg2AykI74aFRNIU78hkzcGLgcKGx05gtn4zfmP2aei7rouzktLtoFKlfGOf41WUkdAM2jP4eLwsoFglsg3fLTYdUYhlxmO6Ze8eU/hca/Ab7IYSayM+afEREZPHnMC0deapsbZK20Jh1BU82+3JoYHD5Sda3WudPPbTmRsesy15hsiooUVlLIxGjwdSKcYkt1dvQ/QF/sxNH7E0ZVvSgAWtqs81Kxx/IKqO9tMuyOh/CSmaD2rcQuQ1VtcR1jZeE14wbOIOmcZRUnOiurOMxfKgvIGIUi3eyumD3D1zWIXJo54ZQMA8qwsjtIDjNKl2Dtibw+JkT+bxNNn66ZiksDGP7uWNZ9lDSx5yaJFWYpvS5CvRxTNQU+0meU9Ja3Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(451199021)(6512007)(44832011)(7416002)(31686004)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(8936002)(36756003)(8676002)(5660300002)(30864003)(2906002)(966005)(31696002)(86362001)(54906003)(41300700001)(6486002)(45080400002)(53546011)(186003)(6506007)(26005)(2616005)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRSTzl3RkZ6anZLdHd6ZktuZnRpR0tGWlpqZ1pSZE5xOW15cmhaclVTVjEw?=
 =?utf-8?B?bStISVpidm1zUGUyelErRk9CYmFCU1I1d0dCRVp0OFlvUkpkSU1heGVhOWQ1?=
 =?utf-8?B?ZGQ2MFBzZ0Y2WUI2b0l1U2xBYXpCaGFZUExBU080Vm1EcFpjVnBad2k2RzRW?=
 =?utf-8?B?NDI2b3NydDRCRGNJMy9BU3VLUVZUS0hzSDZjalorVzROZlBkWmR6TFliRVZk?=
 =?utf-8?B?elF5UHNvM002VzJody9MZzczeTlrSU96akRNTUpqYVo2SjVsZFkzT3kwb0Zs?=
 =?utf-8?B?QVBENjVRTlNpa1lQY2hXdmQyZTFrejBNK3Y3TjlLTnV4ZHJjdXo5dnpJN3ZE?=
 =?utf-8?B?bzdxbGZ3SzEybjJJa2h2cUdvMTNJVFVEYWJjK1dIUXUwbzd2cVVFQyswTFBl?=
 =?utf-8?B?OUpVdytsYnRKeGphbkxZS0djaWlTdEZ2b3drcjAvMkpmWmQ4ZnRsYUQ4ME1W?=
 =?utf-8?B?bW5UWUlBY1dMcm5EMjF2L01xQ1dLTUhyWndkZ2ZnVlVFWEpHNEVxOCtTckZk?=
 =?utf-8?B?N0JGZjAzTm1ITTdKWmxhaTVvZG1OWGxrNmdPSzJwd3JYaUFIMmhzZ1Y4bmxY?=
 =?utf-8?B?S0h4K2FYSG0vRGpOelZhS3dvSDZjOWJRWjJacXZmekpmVGJJS0t5N1FEZG84?=
 =?utf-8?B?YmVta1J0L0gwOWdvRjB5eGJmamloZUlYK1NDWm45VkkwdXFMVXhqS3AvR0sw?=
 =?utf-8?B?SW9MSXJqbzk0czc1RG14UVZFSkM3WFhtMFl1SUtHZkZqbHFrVFpaTWN3NTRW?=
 =?utf-8?B?SDNQbEd6cWphTm9KOUI3U2p4Rk1nMkdjeEF4QS9lTUJxYWExakhxdUNCMHZC?=
 =?utf-8?B?RTVsR1VtWUNQWStRTkhhNGhNdk4rYU50SmV2S1pMbDFSc2p6WUF4THRQaFdu?=
 =?utf-8?B?RWlmdVV3Wnl0dGVKS29PM2lCajlUUTNaRVV6MDN5Z1I5U0JKOWUrWVY1andn?=
 =?utf-8?B?NitROFd6eGhMMVM1b0hKbk93dFFlYXRiN0R6WmNIVFJVdDlObk0zQ21CTmpB?=
 =?utf-8?B?OTdwRDVWaTN2KytrQ3dLb2ZQdXNnNXFXOEZOVEhrcWM1Z3FIbUlXaU92YXp6?=
 =?utf-8?B?T0JPUlFJM09lVDVKdjJoV0I4MnltZ3dUczZqNUdSbVpRazVxS01Ob1BOelZW?=
 =?utf-8?B?N3I2aXJKZmtPODd0SWhzb1loYWhvTzZIQThRTldWREkrR0NrUnRaMzBYQ0Yv?=
 =?utf-8?B?MHY4N3lhdlBtdU54alR0ZHZNNDRKeE4xQVR0cGtHZUUwVzFrdTRqSkU0S2t4?=
 =?utf-8?B?N0M3d0kyaytHeDZXbTdlYUZhMUNqc2ZlTnQxSnl5NTlHbXRIckVqQkxFRUI3?=
 =?utf-8?B?U2kyL1VaQmtYVjRSZmdqOGwzdFJ4TVZDT3ZDWldWV3djQkQwNUdRSXVhM3Az?=
 =?utf-8?B?bmcvRUtlNmlqU01xRDdsN3NmaHJqSC9PRzUyOUdlRXpyRjc3dXptbFRhTENF?=
 =?utf-8?B?MXpjbXVOcjB2d1Q5SFBPWk5VVEFTbVRTcWorYUh6V0VybnhJSi9SZE54aVI3?=
 =?utf-8?B?UzVYSWFJWjlEeFBhcHkxV05DNDIyb0R5elRxcnhxSkl6RnRiMlE5LzRQL2Yx?=
 =?utf-8?B?Q0tLaTNDRTVuOStjUlZ3ZG9pK0RieTZKSWp6cEVZSEhtYmJEY3g4Ujk0TTVl?=
 =?utf-8?B?RDdtL0E5bk5jd0l0RDdpVnRPZ2g3bG1EMklrT1l4VVRZdmYwNWpjWThZcFpO?=
 =?utf-8?B?amQrams1KytBM2x0TWpheE1NT1Y3aWlsQjJaZ2phZFRVeVg4U1hxN2QzQllY?=
 =?utf-8?B?UG02NG5GMVdzV3IxdGZjMmd4YThkT09JRktMRHpTSUVnSXAyN2FmcWpkK1pY?=
 =?utf-8?B?dWJKcWp5VVFjUjFBa1lyc3VrTUJDdm8yZTQ4eTd0SU1qdXpiL0RaZzJydHJB?=
 =?utf-8?B?SmVjREFIQjkyQ1ltMm9ZZ08zMVkzVkZhY1pyVDNiVlVnb0VQb2REZW1WUE5j?=
 =?utf-8?B?MVFMYXFlaHBRT3ltQ1dKQXFiNTFQdWRiT0pWYUVCbEg5RkdDVFRzaWNTTGJY?=
 =?utf-8?B?ei9qYjhhRFNPQVhjUlYwZjdrWkFzZUZsSXNYUWdmOGhSOXlCdmJpNm93L0tW?=
 =?utf-8?B?UkZkNDFMUnVRVFBDcFdsdlVNdG1nTklKaE9Dd203N2V6Z1hZY2pSUzNCanBJ?=
 =?utf-8?B?K0lGaFp0Z2UzVXBpYmE2eHo5MGZIeW1YekxKZjAyNGxoL2tGZkhYSnlhMFZa?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a455b2c9-b1a9-4246-f5b0-08db76307d0a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:31:23.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DG+pMau1OXgoYp0Y67kSF3CP0inu5KHSAw+YD2y2vcr8l17uwq30VkB8dNZjnnKqghw4hHeweFXkVctORdfdL+SC7PY/XGbCPirgdP5I/yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7692
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26.06.23 04:35, Jeff LaBundy wrote:
> Hi Javier,
> 
> On Fri, Jun 16, 2023 at 09:28:51AM +0200, Javier Carrasco wrote:
>> Some touchscreens provide mechanical overlays with different objects
>> like buttons or clipped touchscreen surfaces.
>>
>> In order to support these objects, add a series of helper functions
>> to the input subsystem to transform them into overlay objects via
>> device tree nodes.
>>
>> These overlay objects consume the raw touch events and report the
>> expected input events depending on the object properties.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
> 
> Excellent work; it's great to see this series move along.
> 
>>  MAINTAINERS                            |   7 +
>>  drivers/input/touchscreen/Kconfig      |   9 +
>>  drivers/input/touchscreen/Makefile     |   1 +
>>  drivers/input/touchscreen/ts-overlay.c | 356 +++++++++++++++++++++++++++++++++
>>  include/linux/input/ts-overlay.h       |  43 ++++
>>  5 files changed, 416 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7e0b87d5aa2e..db9427926a4c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
>>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>>  F:	Documentation/translations/zh_TW/
>>  
>> +TOUCHSCREEN OVERLAY OBJECTS
>> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/input/touchscreen/ts-overlay.c
>> +F:	include/linux/input/ts-overlay.h
>> +
>>  TTY LAYER
>>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>  M:	Jiri Slaby <jirislaby@kernel.org>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 143ff43c67ae..8382a4d68326 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called himax_hx83112b.
>>  
>> +config TOUCHSCREEN_TS_OVERLAY
>> +	bool "Touchscreen Overlay Objects"
>> +	help
>> +	  Say Y here if you are using a touchscreen driver that supports
>> +	  printed overlays with keys or a clipped touchscreen area.
>> +
>> +	  Should be selected by the touchscren drivers that support
>> +	  this feature.
>> +
>>  endif
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 159cd5136fdb..f554826706ff 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
>>  obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
>> +obj-$(CONFIG_TOUCHSCREEN_TS_OVERLAY)	+= ts-overlay.o
> 
> It seems like this feature is useful for any two-dimensional touch surface
> (e.g. trackpads) and not just touchscreens. For that reason, the touchscreen
> helpers in touchscreen.c were moved out of input/touchscreen and into input/
> such that they are not guarded by CONFIG_INPUT_TOUCHSCREEN. A growing number
> of devices in input/misc are taking advantage of these.
> 
> Therefore, I think this feature should follow suit and be available to any
> input device as is the case for touchscreen.c. As written, the newly updated
> binding is misleading because one may believe that any device that includes
> touchscreen.yaml can define an overlay child, but the code does not currently
> support this.
> 
> To that end, it seems like touch-overlay would be a more descriptive name as
> well. I understand that the name has changed once already, so hopefully this
> feedback is not too annoying :)
> 
changing names is no problem at all as long as it makes the feature more
comprehensible and/or takes more suitable devices into account, which
would be the case. So I will move the code from touchscreen to input and
I will update the names and descriptions to make them more generic.

I guess then I will need to move the properties to a separate binding
for this feature because it will not be an addition to the touchscreen
bindings anymore, right?

>> diff --git a/drivers/input/touchscreen/ts-overlay.c b/drivers/input/touchscreen/ts-overlay.c
>> new file mode 100644
>> index 000000000000..7afa77d86c1f
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/ts-overlay.c
>> @@ -0,0 +1,356 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  Helper functions for overlay objects on touchscreens
>> + *
>> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
>> + */
>> +
>> +#include <linux/property.h>
>> +#include <linux/input.h>
>> +#include <linux/input/mt.h>
>> +#include <linux/module.h>
>> +#include <linux/input/ts-overlay.h>
>> +
>> +enum ts_overlay_valid_objects {
>> +	TOUCHSCREEN,
>> +	BUTTON,
> 
> Please namespace these, i.e. TOUCH_OVERLAY_*.
> 
>> +};
>> +
>> +static const char *const ts_overlay_names[] = {
>> +	[TOUCHSCREEN] = "overlay-touchscreen",
> 
> I'm a little confused why we need new code for this particular function; it's
> what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
> can't we keep using those?
> 
According to the bindings, touchscreen-min-x/y define the minimum
reported values, but the overlay-touchscreen is actually setting a new
origin. Therefore I might be misusing those properties. On the other
hand touchscreen-size-x/y would make more sense, but I also considered
the case where someone would like to describe the real size of the
touchscreen outside of the overlay node as well as the clipped size
inside the node. In that case using the same property twice would be
confusing.
So in the end I thought that the origin/size properties are more precise
and applicable for all objects and not only the overlay touchscreen.
These properties are needed for the buttons anyways and in the future
more overlay would use the same properties.

>> +	[BUTTON] = "overlay-buttons",
>> +};
>> +
>> +struct ts_overlay_shape {
>> +	u32 x_origin;
>> +	u32 y_origin;
>> +	u32 x_size;
>> +	u32 y_size;
>> +};
>> +
>> +struct ts_overlay_button {
>> +	struct ts_overlay_shape shape;
>> +	u32 key;
>> +	bool pressed;
>> +	int slot;
>> +};
>> +
>> +static int ts_overlay_get_shape_properties(struct fwnode_handle *child_node,
>> +					   struct ts_overlay_shape *shape)
>> +{
>> +	int rc;
> 
> In input, the common practice is to use 'error' for return values that are either
> zero or negative. The reasoning is because the variable quite literally represents
> an error, or lack thereof. And then:
> 
> 	error = ...
> 	if (error)
> 		return error;
> 
>> +
>> +	rc = fwnode_property_read_u32(child_node, "x-origin", &shape->x_origin);
>> +	if (rc < 0)
>> +		return rc;
> 
> It seems like all of these properties are required; if so, please update the
> binding to make this clear.
> 
> If the binding is correct and these properties are in fact optional, then you
> must evaluate fwnode_property_read_u32() against -EINVAL.
> 
If I end up writing new bindings for this feature, it will be more clear
what is required and what not because I will not be part only of the
touchscreen anymore. These properties will be required.
>> +
>> +	rc = fwnode_property_read_u32(child_node, "y-origin", &shape->y_origin);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = fwnode_property_read_u32(child_node, "x-size", &shape->x_size);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = fwnode_property_read_u32(child_node, "y-size", &shape->y_size);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ts_overlay_get_button_properties(struct device *dev,
>> +					    struct fwnode_handle *child_node,
>> +					    struct ts_overlay_button *btn)
>> +{
>> +	struct fwnode_handle *child_btn;
>> +	int rc;
>> +	int j = 0;
>> +
>> +	fwnode_for_each_child_node(child_node, child_btn) {
>> +		rc = ts_overlay_get_shape_properties(child_btn, &btn[j].shape);
>> +		if (rc < 0)
>> +			goto button_prop_cleanup;
>> +
>> +		rc = fwnode_property_read_u32(child_btn, "linux,code",
>> +					      &btn[j].key);
>> +		if (rc < 0)
>> +			goto button_prop_cleanup;
> 
> The binding needs to list this property as required, too.
> 
Do you mean "linux,code"? It is already listed with the same pattern
that some other bindings use:

linux,code: true

Is that not right? I did not want to redefine an existing property that
other bindings already make use of.
>> +
>> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
>> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
>> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
> 
> This seems like a dev_dbg() to me.
> 
>> +		j++;
>> +	}
>> +
>> +	return 0;
>> +
>> +button_prop_cleanup:
>> +	fwnode_handle_put(child_btn);
>> +	return rc;
>> +}
>> +
>> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
>> +				struct input_dev *dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < map->button_count; i++)
>> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
>> +}
>> +EXPORT_SYMBOL(ts_overlay_set_button_caps);
> 
> I don't see a need to expose this function and require participating drivers
> to call it; we should just have one over-arching function for processing the
> overlay(s), akin to touchscreen_parse_properties but for the button input
> device in case the driver separates the button and touchscreen input devices.
> 
> That one function would then be responsible for parsing the overlay(s) and
> calling input_set_capability() on each button.
> 
>> +
>> +static int ts_overlay_count_buttons(struct device *dev)
>> +{
>> +	struct fwnode_handle *child_node;
>> +	struct fwnode_handle *child_button;
> 
> These names confused me; they're both children, but only the second is aptly
> named. How about child_overlay and child_button, or perhaps overlay_node and
> button_node?
> 
>> +	int count = 0;
>> +
>> +	child_node = device_get_named_child_node(dev, ts_overlay_names[BUTTON]);
>> +	if (!child_node)
>> +		return 0;
>> +
>> +	fwnode_for_each_child_node(child_node, child_button)
>> +		count++;
>> +	fwnode_handle_put(child_node);
>> +
>> +	return count;
>> +}
>> +
>> +static int ts_overlay_map_touchscreen(struct device *dev,
>> +				      struct ts_overlay_map *map)
>> +{
>> +	struct fwnode_handle *child;
> 
> Same here; there are two layers of children, so please use more descriptive
> variable names.
> 
>> +	int rc = 0;
>> +
>> +	child = device_get_named_child_node(dev, ts_overlay_names[TOUCHSCREEN]);
>> +	if (!child)
>> +		goto touchscreen_ret;
> 
> I don't think we need a label here; just return 0 directly.
> 
>> +
>> +	map->touchscreen =
>> +		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
>> +	if (!map->touchscreen) {
>> +		rc = -ENOMEM;
>> +		goto touchscreen_handle;
>> +	}
>> +	rc = ts_overlay_get_shape_properties(child, map->touchscreen);
>> +	if (rc < 0)
>> +		goto touchscreen_free;
>> +
>> +	map->overlay_touchscreen = true;
>> +	dev_info(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
>> +		 map->touchscreen->x_origin, map->touchscreen->y_origin,
>> +		 map->touchscreen->x_size, map->touchscreen->y_size);
> 
> dev_dbg()
> 
>> +
>> +	rc = 0;
> 
> rc (error) can only be zero if we have gotten this far; I don't see a need
> to assign it here.
> 
>> +	goto touchscreen_handle;
> 
> Please think about whether this can be reorganized to prevent jumping over
> small bits of code; I found it hard to follow. Maybe one or more tasks can
> be offloaded to a helper function?
> 
>> +
>> +touchscreen_free:
>> +	devm_kfree(dev, map->touchscreen);
> 
> This set off a red flag; it's unclear that it's necessary. Regardless of
> whether the participating driver is smart enough to bail during probe()
> if the overlay parsing fails, or it happily continues, this memory will
> get freed when the driver tied to 'dev' is torn down.
> 
> Calling devm_kfree() is generally limited to special cases where you are
> dynamically reallocating memory at runtime. In case I have misunderstood
> the intent, please let me know.
> 
Would devm_kfree() not free the memory immediately if the parsing fails,
making it available for any process instead of waiting until the driver
is torn down, which might never happen? Otherwise that chunk of memory
will not be accessible even though it is useless because the operation
failed, right? Or am I missing something?
>> +touchscreen_handle:
>> +	fwnode_handle_put(child);
>> +touchscreen_ret:
>> +	return rc;
>> +}
>> +
>> +static int ts_overlay_map_buttons(struct device *dev,
>> +				  struct ts_overlay_map *map,
>> +				  struct input_dev *input)
>> +{
>> +	struct fwnode_handle *child;
>> +	u32 button_count;
>> +	int rc = 0;
>> +
>> +	button_count = ts_overlay_count_buttons(dev);
>> +	if (button_count) {
>> +		map->buttons = devm_kcalloc(dev, button_count,
>> +					    sizeof(*map->buttons), GFP_KERNEL);
>> +		if (!map->buttons) {
>> +			rc = -ENOMEM;
>> +			goto map_buttons_ret;
>> +		}
>> +		child = device_get_named_child_node(dev,
>> +						    ts_overlay_names[BUTTON]);
>> +		if (unlikely(!child))
>> +			goto map_buttons_free;
>> +
>> +		rc = ts_overlay_get_button_properties(dev, child, map->buttons);
>> +		if (rc < 0)
>> +			goto map_buttons_free;
>> +
>> +		map->button_count = button_count;
>> +	}
>> +
>> +	return 0;
>> +
>> +map_buttons_free:
>> +	devm_kfree(dev, map->buttons);
>> +map_buttons_ret:
>> +	return rc;
>> +}
>> +
>> +static bool ts_overlay_defined_objects(struct device *dev)
>> +{
>> +	struct fwnode_handle *child;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ts_overlay_names); i++) {
>> +		child = device_get_named_child_node(dev, ts_overlay_names[i]);
>> +		if (child) {
>> +			fwnode_handle_put(child);
>> +			return true;
>> +		}
>> +		fwnode_handle_put(child);
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
>> +					      struct input_dev *input)
>> +{
>> +	struct ts_overlay_map *map = NULL;
>> +	int rc;
>> +
>> +	if (!ts_overlay_defined_objects(dev))
>> +		return NULL;
>> +
>> +	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
>> +	if (!map) {
>> +		rc = -ENOMEM;
>> +		goto objects_err;
>> +	}
>> +	rc = ts_overlay_map_touchscreen(dev, map);
>> +	if (rc < 0)
>> +		goto objects_free;
>> +
>> +	rc = ts_overlay_map_buttons(dev, map, input);
>> +	if (rc < 0)
>> +		goto objects_free;
>> +
>> +	return map;
>> +
>> +objects_free:
>> +	devm_kfree(dev, map);
>> +objects_err:
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL(ts_overlay_map_objects);
>> +
>> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y)
>> +{
>> +	*x = map->touchscreen->x_size - 1;
>> +	*y = map->touchscreen->y_size - 1;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_get_touchscreen_abs);
>> +
>> +static bool ts_overlay_shape_event(struct ts_overlay_shape *shape, u32 x, u32 y)
>> +{
>> +	if (!shape)
>> +		return false;
>> +
>> +	if (x >= shape->x_origin && x < (shape->x_origin + shape->x_size) &&
>> +	    y >= shape->y_origin && y < (shape->y_origin + shape->y_size))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static bool ts_overlay_touchscreen_event(struct ts_overlay_shape *touchscreen,
>> +					 u32 *x, u32 *y)
>> +{
>> +	if (ts_overlay_shape_event(touchscreen, *x, *y)) {
>> +		*x -= touchscreen->x_origin;
>> +		*y -= touchscreen->y_origin;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map)
>> +{
>> +	if (!map || !map->overlay_touchscreen)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_mapped_touchscreen);
>> +
>> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map)
>> +{
>> +	if (!map || !map->button_count)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_mapped_buttons);
>> +
>> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y)
>> +{
>> +	if (!ts_overlay_mapped_touchscreen(map))
>> +		return true;
>> +
>> +	if (!ts_overlay_touchscreen_event(map->touchscreen, x, y))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_mt_on_touchscreen);
>> +
>> +bool ts_overlay_button_press(struct ts_overlay_map *map,
>> +			     struct input_dev *input, u32 x, u32 y, u32 slot)
>> +{
>> +	int i;
>> +
>> +	if (!ts_overlay_mapped_buttons(map))
>> +		return false;
>> +
>> +	for (i = 0; i < map->button_count; i++) {
>> +		if (ts_overlay_shape_event(&map->buttons[i].shape, x, y)) {
>> +			input_report_key(input, map->buttons[i].key, 1);
>> +			map->buttons[i].pressed = true;
>> +			map->buttons[i].slot = slot;
>> +			return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_button_press);
> 
> The level of abstraction here does not seem quite right. Rather than force
> each participating driver to call a press and release function, I think it
> is better to expose something like touch_overlay_process_buttons() which
> then handles the press and release events internally.
> 
> You're also relying on each individual driver to decide whether a touch
> coordinate is inside or outside the overlay, and selectively call the press
> and release functions OR report coordinates which is non-optimal.
> 
> To me, this says we actually need one wrapper function that accepts handles
> to both the touchscreen and button input devices (which may be the same at
> the driver's discretion) as well as the coordinates. If the coordinate is
> within an overlay area, handle press/release; if not, call touchscreen_report_pos().
> 
>> +
>> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot)
>> +{
>> +	int i;
>> +
>> +	if (!map || !map->button_count)
>> +		return false;
>> +
>> +	for (i = 0; i < map->button_count; i++) {
>> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(ts_overlay_is_button_slot);
>> +
>> +void ts_overlay_button_release(struct ts_overlay_map *map,
>> +			       struct input_dev *input, u32 slot)
>> +{
>> +	int i;
>> +
>> +	if (!map || !map->button_count)
>> +		return;
>> +
>> +	for (i = 0; i < map->button_count; i++) {
>> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot) {
>> +			input_report_key(input, map->buttons[i].key, 0);
>> +			map->buttons[i].pressed = false;
>> +		}
>> +	}
>> +}
>> +EXPORT_SYMBOL(ts_overlay_button_release);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Helper functions for overlay objects on touchscreens");
>> diff --git a/include/linux/input/ts-overlay.h b/include/linux/input/ts-overlay.h
>> new file mode 100644
>> index 000000000000..b75df0dec3ab
>> --- /dev/null
>> +++ b/include/linux/input/ts-overlay.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
>> + */
>> +
>> +#ifndef _TS_OVERLAY
>> +#define _TS_OVERLAY
>> +
>> +#include <linux/types.h>
>> +
>> +struct input_dev;
>> +struct device;
>> +
>> +struct ts_overlay_map {
>> +	struct ts_overlay_shape *touchscreen;
>> +	bool overlay_touchscreen;
>> +	struct ts_overlay_button *buttons;
>> +	u32 button_count;
>> +};
>> +
>> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
>> +					      struct input_dev *input);
>> +
>> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y);
>> +
>> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map);
>> +
>> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map);
>> +
>> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y);
>> +
>> +bool ts_overlay_button_press(struct ts_overlay_map *map,
>> +			     struct input_dev *input, u32 x, u32 y, u32 slot);
>> +
>> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot);
>> +
>> +void ts_overlay_button_release(struct ts_overlay_map *map,
>> +			       struct input_dev *input, u32 slot);
>> +
>> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
>> +				struct input_dev *dev);
>> +
>> +#endif
>>
>> -- 
>> 2.39.2
>>
> 
> Kind regards,
> Jeff LaBundy

Thanks again for your feedback, I really appreciate it. All the comments
without a reply can be taken as acknowledged and accepted as they are
without further discussion. I will work on them for the next version.

Thank you for your time and best regards,
Javier Carrasco
