Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E26A2932
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBYLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:03:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7914E87;
        Sat, 25 Feb 2023 03:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q00bcva+eLvAlpEfN0dIda2xzjX4B/I+yqBfhLzbzhs=;
 b=ko/0QBKUJNRLJjfJBD1GWJhBSAAebjDPyVo1lmiT79AAKfLkOWqhiUzan9BUl9HTiOfv4otFFfbX8LX38ka1dI/bBdMr0hQVZFu3kPb+mhb6MG2/s7c7VzsP3vLAR/Lp6EVY/Nx8RPm/xmgAqbESUFq9ex2hCYjYsE0KAoe4abfo3h/UIiVcDMXnGRzYXz2WnVingm8DRNWFxlUeD0tvE7mR3avR2uf5BrCrsqoVz+jlavDnXs/v8IGlP+Z2vyUqbXsbD3o++h95fXxhKxia5WWQ0ajKLtyRtammEIx29YVAy/fY8W8yZ7hiKyDGGadc53U5y5YJ5C8NeMNUo9OOsw==
Received: from GVYP280CA0038.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::15)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 11:03:14 +0000
Received: from HE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::7c) by GVYP280CA0038.outlook.office365.com
 (2603:10a6:150:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25 via Frontend
 Transport; Sat, 25 Feb 2023 11:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT072.mail.protection.outlook.com (10.152.1.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15 via Frontend Transport; Sat, 25 Feb 2023 11:03:13 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.52) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 25 Feb 2023 11:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAdRyo38zYGR1cwnAy33fArlCVdzFxe3hk4AqS3golOSQXtcxWBqVKjgvqsohhK8P0SfkZfceRj+PJhLdz27IrqHoNDcAftf9oi2cRKdPjTFtsMurXbdtpYq4v2TTE+NJABYbW0kZrXoS5wzm9QNetlHn3Txh4tXop5gazUL/VkmH6fFUm2LIdWZUJn2F0HdXOdwWzOAIivoQZ6kBmyR45LIdkfXJ+MlxB7kskiU80wHPEGk2aJFQSUdOSw3kiYckDQxWkMQ9hwU4HTOwX0ZodWCogFapkc8NO2B3Mup7ilpgLlTvNjYAhSee1gTt05C792SugIsPI7sQMq7kf2a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rQBGsvDBBAian8pAXeY9P38GYPlJDv7NtbUlvvKNQk=;
 b=iLIEv8ltyPEGivDN8hite/88jNxADW7meqgyQHrUm8qXJizH12CF9WTO6b428ain+rQn9uOyAC5YeOrL5vueb/3beVov+ZVbyKkaq8fJH5ik7f3/i3Z5lZyYivW4PR3pFAGxlu/cUkcQjaL1gfc/BXQ+GwDlUzEbWsCUxTUWsPVWG0OGT3M4Sz1YblWF/qGMWeRb/z6xVXqt7YnEDwTMHTqUk0Z/zVbtSYt98YXZhOZ85N73996nWNyvy/CBsmCZCowo8U4DgYzcIIWoNhJWoH6XZS1+k2AJ9TrRw0X3VGbFbc5eqAbWMNuONoFLiDxYQhDOBYcErO8HVUGuoCoxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 11:03:08 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6134.024; Sat, 25 Feb 2023
 11:03:08 +0000
Message-ID: <18a6b72b-4165-c9e7-3dc7-81fa85f0e4e9@topic.nl>
Date:   Sat, 25 Feb 2023 12:03:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000 chips
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
 <20230217093128.8344-2-mike.looijmans@topic.nl>
 <20230218164832.695fe5b5@jic23-huawei>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.02fda1de-62d6-4f7a-9537-1a2cd4a482bd@emailsignatures365.codetwo.com>
Content-Language: en-US
Organization: Topic
In-Reply-To: <20230218164832.695fe5b5@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DBAPR04MB7285:EE_|HE1EUR01FT072:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fd910f-a0b0-4b14-43e1-08db171fe3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TFCGzgxN34bQUz7GcEKOm7EsDZICwcmG9cpcL0i9SQ9vQqckSH12gPudKhSqsnDD6noQIWWecrqrbZ+qUKpfHyWWeXtADNOIseie0tsdKZk59lVKkPLBy/EQDO0YVHb0H2d2qtzyXjamAa7D87pKsdIqZpbM1ZVyUG1vkHG1R1wFyICDQQfHUF60uh5w3lLI8rZw6u0tWHfYo7OTRBkTFv1cHKt++lUo18lGP1yRQxlbrYCoGGfikFV/feQyuXWAiQ0FvNckaWt/wAMj6IKbE6i/W9v6w3xW718MCsvYDMvPpntVBQHBM19Jg38gXzA/YhBuz/N06w2EQdDdUpM3zT1q4bB7uPJeEwfgfMrK+JqZj1t7xC88m+wVLgK9Fz1WHoZgbZZLc9PFZAXVvvUOuqD5/NYq9UScpghIm34HCkZKloxQWHkS8eMgR8Bc5BSlZqQgy/Gem703HzuwQi780jxXIfK+Al1HfPkwPuz2k3WJ6+uELky1FdfCwXY6/oiWujN2Fkt0+lY0lHhw4SzW4ih50kHbmvbKB127teZTAek+3VZB6ZgWIfIr7tkz0FL2TTKeUNFbvTkqnPKk9WDWbJXSuWJo+mrM6c6HjIZaWI1/z9BCNJyZchDaSUAjkRBQfC3lKJw5gKjg8fuUHnDoDAx3vBNGrgVhs501Xj/k/WVcyAE2skwRt85EztRg2o5lzhpL8eRC9OfES+D8RQm4UcWuGDjlnFzkAL2D+hIGQHiTGcLwOW1ZoG5Bc6uy6yLGK5PYIFcYQPMK9QkjJZQQww==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39830400003)(376002)(136003)(396003)(366004)(346002)(451199018)(6512007)(6486002)(31696002)(2616005)(83170400001)(41300700001)(6506007)(54906003)(8936002)(42882007)(6666004)(26005)(186003)(2906002)(316002)(53546011)(66556008)(66476007)(6916009)(66946007)(4326008)(38350700002)(36756003)(8676002)(52116002)(38100700002)(30864003)(478600001)(83380400001)(5660300002)(7416002)(44832011)(36916002)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
X-CodeTwo-MessageID: 02198223-036e-49fe-8857-ccb177974b7d.20230225110312@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34a308ee-b541-4dcf-9564-08db171fe062
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWogJyb6zxYpfa97tnIAw89ZCe+Wuh6b04y7hRYNr1myWQ5l4O87ZP4hf2tBOSRpKJJ8PmhpMW46pgNR/K5vAaaPaCQZ8Bdoqt9CYDzYYZZNLE+EjkD7g06Y7f4rYAdtUqqCZEkKwV3VsZnvyIYVxsMEq6wMfNtLDWWZ14yQ4XlIHDUQ34c9nq4YOXExZxY/Qhz6RGQkJbZFFnam9fiKXzKwjOZXCotu/5Jf8hGeBz1kuocVaaodhxwF2FRxxKgOuzrHa/q/iARecRc7LiuOVwvABkYQcaOxYoNFmubb4XD7G5vmxpscuCVo/VxV90PWdLE60oOM+J5FyF5izWxGLYmMBz0mUYy/KZMb9QcZcd4SMluuUSWUuPqOo6WW8vuC3zFg6XoomM0UH+YU59f89jOvNqs/vdB7G60Gx3rE3F7w4Dwe3E3g/FQJSFDQjpYT3nnyQPIOhn8esGc2nnk6w4/gu8uq3BcwEexmSE9w/weV3IMchmo9AVbXc7hOA1P/UwO4HB99qUXVzCR5dxAzcGg4BIC/0XpUimOymF1KWju/LODPrKAGhXKDpQMTyab14ZAYkDz6wXkedlPDCS9mQchXIrxKh7u3kz+k41yNE0IVwNzmrfqd41D2g8CfubWgOOMw7AImn2ZucUcg2RMSzAvzYAekFTeqH83qf1FSozy/LIvNmWOkUlkXdISE84aq
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39830400003)(136003)(396003)(376002)(451199018)(36840700001)(46966006)(66899018)(30864003)(44832011)(356005)(82310400005)(31696002)(7636003)(2906002)(7416002)(83170400001)(7596003)(31686004)(6486002)(478600001)(42882007)(36916002)(336012)(53546011)(6512007)(26005)(186003)(47076005)(15974865002)(36756003)(40480700001)(70586007)(70206006)(8676002)(83380400001)(316002)(54906003)(4326008)(41300700001)(2616005)(6666004)(6916009)(8936002)(6506007)(36860700001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 11:03:13.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fd910f-a0b0-4b14-43e1-08db171fe3d3
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments below - mailserver has a top-post fetish and will inject a=20
signature here somewhere...

No further comment from me means "agree, will implement in v2"...



Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 18-02-2023 17:48, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 10:31:28 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> The ADS1100 is a 16-bit ADC (at 8 samples per second).
>> The ADS1000 is similar, but has a fixed data rate.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Hi Mike,
>
> I probably overlapped a lot in here with what Andy said, so just ignore
> anything you've already fixed.
>
> Biggest thing is HARDWAREGAIN.
> That is very rarely used with ADCs.  It exists to support cases where
> the gain is not directly coupled to the thing being measured (light
> sensitivity of a time of flight sensor for example).  Userspace expects
> to use SCALE to both control amplifier gains and to multiply with
> the _raw value to get a value in the real world units.
>
> It's a bit fiddly to do the computation, but typically at start up time
> you work out what the combination of each PGA gain and the reference
> voltage means for the scales available and stash that somewhere to use la=
ter.

Complicating factor with this ADC is that the final gain value depends=20
on the sampling rate as well as the power supply voltage. Which would=20
lead to the "available" list being different after changing the sample=20
rate and confusing userspace. If a userspace app would read the=20
available sample rates and gains, and then proceeded to set them, the=20
results would be weird, as the order in which they were set would=20
matter. Setting the gain after setting the sample rate would likely=20
result in an EINVAL error because the selected gain is no longer applicable=
.

To me it seemed more logical to provide the analog amplification and=20
sample rate as separate, unrelated values.


> As per the docs in Documentation/ABI/testing/sysfs-bus-iio userspace is
> expected to get real units (here millivolts) from
>
> (_raw + _offset) * _scale
> where _offset =3D 0 if not provided. Hence any front end amplification ne=
eds
> to be taken into account for _scale and _scale_available
Have to check the math, but I think I made a mistake with the final=20
result being "Volts" instead of "millivolts".
>
> Thanks,
>
> Jonathan
>
>> ---
>>
>>   drivers/iio/adc/Kconfig      |  12 +
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/ti-ads1100.c | 467 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 480 insertions(+)
>>   create mode 100644 drivers/iio/adc/ti-ads1100.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 63f80d747cbd..bc1918d87f8e 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1207,6 +1207,18 @@ config TI_ADS1015
>>   	  This driver can also be built as a module. If so, the module will b=
e
>>   	  called ti-ads1015.
>>  =20
>> +config TI_ADS1100
>> +	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
>> +	depends on I2C
>> +	select IIO_BUFFER
> No sign of buffers yet so shouldn't need the dependency
>
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  If you say yes here you get support for Texas Instruments ADS1100 an=
d
>> +	  ADS1000 ADC chips.
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called ti-ads1100.
>> +
>>   config TI_ADS7950
>>   	tristate "Texas Instruments ADS7950 ADC driver"
>>   	depends on SPI && GPIOLIB
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 4ef41a7dfac6..61ef600fab99 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) +=3D ti-adc108s102.o
>>   obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
>>   obj-$(CONFIG_TI_ADC161S626) +=3D ti-adc161s626.o
>>   obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015.o
>> +obj-$(CONFIG_TI_ADS1100) +=3D ti-ads1100.o
>>   obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
>>   obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
>>   obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
>> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
>> new file mode 100644
>> index 000000000000..0b0d3e5b6bd6
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-ads1100.c
>> @@ -0,0 +1,467 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ADS1100 - Texas Instruments Analog-to-Digital Converter
>> + *
>> + * Copyright (c) 2023, Topic Embedded Products
>> + *
>> + * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mutex.h>
>> +#include <linux/property.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/types.h>
>> +#include <linux/iio/sysfs.h>
> I doubt you need this last header. It's only needed for
> non standard ABI definitions.
>
>> +
>> +#define ADS1100_DRV_NAME "ads1100"
> Just put this inline.  There is no particular
> reason the driver name and the iio device name will be the
> same so I'd prefer to see the string in each place rather
> than using a define hidden up here.
>> +
>> +/* The ADS1100 has a single byte config register */
>> +
>> +/* Conversion in progress bit */
>> +#define ADS1100_CFG_ST_BSY	BIT(7)
>> +/* Single conversion bit */
>> +#define ADS1100_CFG_SC		BIT(4)
>> +/* Data rate */
>> +#define ADS1100_DR_MASK		(BIT(3) | BIT(2))
> GENMASK(3, 2)
>
> same for similar cases.
>
>> +#define ADS1100_DR_SHIFT	2
>> +/* Gain */
>> +#define ADS1100_PGA_MASK	(BIT(1) | BIT(0))
>> +
>> +#define ADS1100_CONTINUOUS	0
>> +#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
>> +
>> +#define ADS1100_SLEEP_DELAY_MS	2000
>> +
>> +static const int ads1100_data_rate[] =3D {128, 32, 16, 8};
>> +static const int ads1100_data_rate_scale[] =3D {2048, 8192, 16384, 3276=
8};
>> +static const int ads1100_gain[] =3D {1, 2, 4, 8};
>> +
>> +struct ads1100_data {
>> +	struct i2c_client *client;
>> +	struct regulator *reg_vdd;
>> +	struct mutex lock;
>> +	u8 config;
>> +	bool supports_data_rate; /* Only the ADS1100 can select the rate */
>> +};
>> +
>> +static const struct iio_chan_spec ads1100_channel =3D {
>> +	.type =3D IIO_VOLTAGE,
>> +	.differential =3D 0,
>> +	.indexed =3D 0,
>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>> +	.info_mask_shared_by_all =3D
>> +				BIT(IIO_CHAN_INFO_SCALE) |
>> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	.info_mask_shared_by_all_available =3D
>> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> Hardware gain is normally only used for cases where the gain is not
> directly related to scale.  Things like the gain on a signal that is
> being used for measuring time of flight.  Here you should probably
> just be using SCALE.

In this case, SCALE depends on SAMP_FREQ as well as GAIN. Which will be=20
very confusing to userspace.

Hoping for some leeway here...

>
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +	.scan_type =3D {
>> +		.sign =3D 's',
>> +		.realbits =3D 16,
>> +		.storagebits =3D 16,
>> +		.shift =3D 0,
> Default of 0 is kind of obvious for shift, so no need to explicitly set i=
t.
> C will fill it with a 0 anyway.
>
>> +		.endianness =3D IIO_CPU,
>> +	},
>> +	.datasheet_name =3D "AIN",
>> +};
>> +
>> +static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, =
u8 value)
>> +{
>> +	int ret;
>> +	u8 config =3D (data->config & ~mask) | value;
>> +
>> +	if (data->config =3D=3D config)
>> +		return 0; /* Already done */
>> +
>> +	ret =3D i2c_master_send(data->client, &config, 1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	data->config =3D config;
>> +	return 0;
>> +};
>> +
>> +static int ads1100_set_conv_mode(struct ads1100_data *data, u8 flag)
>> +{
>> +	return ads1100_set_config_bits(data, ADS1100_CFG_SC, flag);
> This wrapper doesn't feel very useful. Make the call directly.
>
>
>> +};
>> +
>> +static int ads1100_data_rate_index(struct ads1100_data *data)
>> +{
>> +	return (data->config & ADS1100_DR_MASK) >> ADS1100_DR_SHIFT;
> FIELD_GET()
>> +}
>> +
>> +static int ads1100_pga_index(struct ads1100_data *data)
>> +{
>> +	return (data->config & ADS1100_PGA_MASK);
> No need for brackets
>
> Also just use FIELD_GET() instead.
>
>> +}
>> +
>> +/* Calculate full-scale value */
>> +static int ads1100_full_scale(struct ads1100_data *data)
>> +{
>> +	return ads1100_data_rate_scale[ads1100_data_rate_index(data)] *
>> +			ads1100_gain[ads1100_pga_index(data)];
>> +
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
>> +{
>> +	int ret;
>> +	struct device *dev =3D &data->client->dev;
>
> This function makes the code harder to read.  Just make the
> pm_runtime_* calls directly but for the put don't check the
> return value (as it will be set to an error when runtime PM not built)
>
> It also tends to be unhelpful to fail the caller based on failure
> to autosuspend.

Power management was copied from the ads1015 driver, which in retrospect=20
isn't up to modern standards. Needs some more overhaul.


>
>> +
>> +	if (on) {
>> +		ret =3D pm_runtime_resume_and_get(dev);
>> +	} else {
>> +		pm_runtime_mark_last_busy(dev);
>> +		ret =3D pm_runtime_put_autosuspend(dev);
>> +	}
>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +#else /* !CONFIG_PM */
>> +
>> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif /* !CONFIG_PM */
>> +
>> +static int ads1100_get_adc_result(struct ads1100_data *data, int chan, =
int *val)
>> +{
>> +	int ret;
>> +	u8 buffer[2];
> __le16 buffer;
>
>> +
>> +	if (chan !=3D 0)
>> +		return -EINVAL;
>> +
>> +	ret =3D i2c_master_recv(data->client, buffer, sizeof(buffer));
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	*val =3D (s16)(((u16)buffer[0] << 8) | buffer[1]);
> 	*val =3D sign_extend32(le16_to_cpu(), 15);

Looks be16 to me though...


>
>> +	return 0;
>> +}
>> +
>> +static int ads1100_set_gain(struct ads1100_data *data, int gain)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(ads1100_gain); ++i) {
>> +		if (ads1100_gain[i] =3D=3D gain) {
>> +			return ads1100_set_config_bits(
>> +						data, ADS1100_PGA_MASK, i);
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ads1100_set_data_rate(struct ads1100_data *data, int chan, i=
nt rate)
>> +{
>> +	int i;
>> +	int size =3D data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) =
: 1;
>> +
>> +	for (i =3D 0; i < size; ++i) {
>> +		if (ads1100_data_rate[i] =3D=3D rate) {
>> +			return ads1100_set_config_bits(
>> +				data, ADS1100_DR_MASK, i << ADS1100_DR_SHIFT);
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ads1100_read_avail(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      const int **vals, int *type, int *length,
>> +			      long mask)
>> +{
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +
>> +	if (chan->type !=3D IIO_VOLTAGE)
>> +		return -EINVAL;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*type =3D IIO_VAL_INT;
>> +		*vals =3D ads1100_data_rate;
>> +		if (data->supports_data_rate)
>> +			*length =3D ARRAY_SIZE(ads1100_data_rate);
>> +		else
>> +			*length =3D 1;
>> +		return IIO_AVAIL_LIST;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		*type =3D IIO_VAL_INT;
>> +		*vals =3D ads1100_gain;
>> +		*length =3D ARRAY_SIZE(ads1100_gain);
>> +		return IIO_AVAIL_LIST;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ads1100_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int *val,
>> +			    int *val2, long mask)
>> +{
>> +	int ret;
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +
>> +	dev_info(&data->client->dev, "%s %ld\n", __func__, mask);
> Definitely shouldn't be having prints in here. I guess left over
> from debugging during development.

Guessed correctly yeah.


>
>> +
>> +	mutex_lock(&data->lock);
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret =3D iio_device_claim_direct_mode(indio_dev);
>> +		if (ret)
>> +			break;
>> +
>> +		ret =3D ads1100_set_power_state(data, true);
> As above. Make the runtime pm calls directly for better readablity.
>
>> +		if (ret < 0)
>> +			goto release_direct;
>> +
>> +		ret =3D ads1100_get_adc_result(data, chan->address, val);
>> +		if (ret < 0) {
>> +			ads1100_set_power_state(data, false);
> As you won't be checking pm_runtime_put_autosuspend() return value
> (see above) you can do this as
>
> 		ret =3D ads110_get_adc_result(...)
> 		pm_runtime_put_autosuspend()
> 		if (ret < 0) {
> 		}
> rather than having the autosuspend call in two places.
Makes sense. I'll peek at other drivers for inspiration.
>
>> +			goto release_direct;
>> +		}
>> +
>> +		ret =3D ads1100_set_power_state(data, false);
>> +		if (ret < 0)
>> +			goto release_direct;
>> +
>> +		ret =3D IIO_VAL_INT;
>> +release_direct:
> labels within case statements are not nice to read. I'd just factor
> some of this code out to a separate function so you don't need to
> do that.  Ideally leave the claim_direct out side of the function
> and then all the returns within it become simpler.
>
>
>> +		iio_device_release_direct_mode(indio_dev);
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret =3D regulator_get_voltage(data->reg_vdd);
>> +		if (ret > 0) {
>> +			/* full-scale is the supply voltage (microvolts now) */
>> +			*val =3D ret / 1000; /* millivolts, range 27000..50000 */
>> +			*val2 =3D 1000 * ads1100_full_scale(data);
> This doesn't seem to take into account the PGA gain?  Userspace is only g=
oing
> to apply _raw * _scale to get the real world units.

The "full_scale" method also applies the PGA.


>
>> +			ret =3D IIO_VAL_FRACTIONAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val =3D ads1100_data_rate[ads1100_data_rate_index(data)];
>> +		ret =3D IIO_VAL_INT;
>> +		break;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		*val =3D ads1100_gain[ads1100_pga_index(data)];
>> +		*val2 =3D 0;
>> +		ret =3D IIO_VAL_INT;
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
>> +	}
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads1100_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan, int val,
>> +			     int val2, long mask)
>> +{
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		ret =3D ads1100_set_gain(data, val);
> As above, would expect this to be SCALE for an ADC.
>
>> +		break;
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		ret =3D ads1100_set_data_rate(data, chan->address, val);
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
>> +	}
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_info ads1100_info =3D {
>> +	.read_avail	=3D ads1100_read_avail,
>> +	.read_raw	=3D ads1100_read_raw,
>> +	.write_raw	=3D ads1100_write_raw,
>> +};
>> +
>> +static int ads1100_setup(struct ads1100_data *data)
>> +{
>> +	int ret;
>> +	u8 buffer[3];
>> +
>> +	/* Setup continuous sampling mode at 8sps */
>> +	buffer[0] =3D ADS1100_DR_MASK | ADS1100_CONTINUOUS;
>> +	ret =3D i2c_master_send(data->client, buffer, 1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D i2c_master_recv(data->client, buffer, sizeof(buffer));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Config register returned in third byte, strip away the busy status =
*/
>> +	data->config =3D buffer[2] & ~ADS1100_CFG_ST_BSY;
>> +
>> +	/* Detect the sample rate capability by checking the DR bits */
>> +	data->supports_data_rate =3D !!(buffer[2] & ADS1100_DR_MASK);
> FIELD_GET() !=3D 0
> is probably more readable.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int ads1100_probe(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct ads1100_data *data;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data =3D iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
>> +	data->client =3D client;
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->name =3D ADS1100_DRV_NAME;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->channels =3D &ads1100_channel;
>> +	indio_dev->num_channels =3D 1;
>> +	indio_dev->info =3D &ads1100_info;
>> +
>> +	data->reg_vdd =3D devm_regulator_get(&client->dev, "vdd");
>> +	if (IS_ERR(data->reg_vdd))
>> +		return PTR_ERR(data->reg_vdd);
>> +
>> +	ret =3D regulator_enable(data->reg_vdd);
>> +	if (ret < 0)
>> +		return ret;
> As below. You should be able to use devm_add_action_or_reset()
> to disable the regulator in the remove path (and on error after this
> point).
>
>> +
>> +	ret =3D ads1100_setup(data);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Failed to communicate with device\n");
>> +		goto exit_regulator;
>> +	}
>> +
>> +	ret =3D pm_runtime_set_active(&client->dev);
>> +	if (ret)
>> +		goto exit_regulator;
>> +
>> +	pm_runtime_set_autosuspend_delay(&client->dev, ADS1100_SLEEP_DELAY_MS)=
;
>> +	pm_runtime_use_autosuspend(&client->dev);
>> +	pm_runtime_enable(&client->dev);
> As below comment suggests, you can use devm_pm_runtime_enable()
> which also fixes that fact you aren't turning off autosuspend
> (which is a bug as the documentation for use_autosuspend states)
>
>> +
>> +	ret =3D iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Failed to register IIO device\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +
>> +exit_regulator:
>> +	regulator_disable(data->reg_vdd);
>> +	return ret;
>> +}
>> +
>> +static void ads1100_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +
> Always read a remove path with it in mind that runtime pm might not
> be in use at all.  Everything must still work.
> As such, I'd expect to see a disable of the regulator in here
> (or even better in a devm_add_action_or_reset())
>
> Also would expect to first ensure the device is in a known
> state with a pm_runtime_get() - which will be a noop if
> runtime pm isn't in use (and hence the device is powered up between
> probe and remove)
>
>
>> +	iio_device_unregister(indio_dev);
>> +
>> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
>> +
>> +	pm_runtime_disable(&client->dev);
> I'd expect runtime pm to be disable before messing with the conv mode.
> With a little care you can use devm_runtime_pm_enable()

Setting the conv mode involves I2C traffic. After runtime_disable, the=20
power supply to the chip may have been disabled, leading to=20
communication errors on the I2C bus. Hence I thought it appropriate to=20
write the config register before turning off power.


>
>> +	pm_runtime_set_suspended(&client->dev);
> I'd expect this to be handled immediately after the
> set of the conv mode to suspended.  Which will be fine if you
> have moved the runtime pm before that.
>
> Once those are together you can just group them in a devm_add_action_or_r=
eset()
> callback and make the whole remove process devm managed.
I'll try to do that - using devm is surely the better option.
>
>> +}
>> +
>> +#ifdef CONFIG_PM
> Addressed in other branch of this thread. So I won't comment more.
>
>> +static int ads1100_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +
>> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
>> +	regulator_disable(data->reg_vdd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ads1100_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>> +	struct ads1100_data *data =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D regulator_enable(data->reg_vdd);
>> +	if (ret) {
>> +		dev_err(&data->client->dev, "Failed to enable Vdd\n");
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * We'll always change the mode bit in the config register, so there i=
s
>> +	 * no need here to "force" a write to the config register. If the devi=
ce
>> +	 * has been power-cycled, we'll re-write its config register now.
>> +	 */
>> +	return ads1100_set_conv_mode(data, ADS1100_CONTINUOUS);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops ads1100_pm_ops =3D {
>> +	SET_RUNTIME_PM_OPS(ads1100_runtime_suspend,
>> +			   ads1100_runtime_resume, NULL)
>> +};
>> +


--=20
Mike Looijmans

