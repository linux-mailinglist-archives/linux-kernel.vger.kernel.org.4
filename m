Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCC63AACF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiK1O1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiK1O06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:26:58 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD115FF9;
        Mon, 28 Nov 2022 06:26:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUcPxLd5ijUkOHL6qeVzxeDjVUEyjoT3FIxJ8WpikFK5NvPxF4nUy91Ps6wMSYn18edpfwr1LgADQxb+HFKVa59gzemY/6SEbXMzL0LCbruenkLsHMOb/aD7lSuIwW55xiDYzAWuxkpkL45GHL1CNX7tEna3hcuA8CEJ5E2KnVBCd9Cq1waw3gFeo6cTagOxz25nJgX5RlVEqI3iylgTPuDt9MVg5nxU30FS9Wcpkz5jwlV295SnBNFHas+b6Wqz7H2PSnUOidtvyH24nNyAAMqhpmnAgJAxfPvtkYP61KxLVGhh4JXpctAs7NmHltFSvP97qsOMzb8tkwjO/fygCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfTs9vhN6819HGNxpT8iMT32nLUqkcNFv+EIDAqCZYk=;
 b=IrXAbyif/kF8utfXxT1soD10x8CHwRtsTuPqMhp3UhJK4QwJ2jnFHheCU4blWmG/BzAcrdeGOFqOoHoUrBmLve3Nyw0iqs0tvOKtwR0wjmdZFi3N4audHYm8YchdRQhJXuJAjr5xNgkM3hOmIdj2WwhaNGp6uqS3422QC9cnKgxEmw1/ovDzamb4hdeI71IMvAOvhAX3zYHxnP96xEJvVPzl8XYxeiD3jZXOi/dp5YjRyjZN4PzztWaQLRUY5Vt/swkW6LYGJsr0hhjrgP6KxojD0R5IbE9gUCf29Hh3YZHJUqkS78K+RD2JIIQ346nkbI6q7exYf18nil91ETQoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfTs9vhN6819HGNxpT8iMT32nLUqkcNFv+EIDAqCZYk=;
 b=FbYAcYoCl5vFxkw78TE65PUd6nGk56rbobOAz+Evsem1rQbKYOpAjV34thaQDuMyI16CQyYxExFcLdkO0MVLIaK/eRm44u+aATnO1eeqgpa3PXgfg3KeVAd5FHq3RlTt4pR667WnE4WjvzJRY4c7As8Wpwf+Y+JChg5ZVuWd/Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB4PR08MB7959.eurprd08.prod.outlook.com (2603:10a6:10:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 14:26:53 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 14:26:53 +0000
Message-ID: <b56cdcf1-459b-63a2-a060-49564e11ce9f@wolfvision.net>
Date:   Mon, 28 Nov 2022 15:26:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com> <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
 <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
 <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
 <4d1b0054-efd4-e10e-17a6-d236052afa49@wolfvision.net>
 <Y4TAF1hn0l1CziUh@smile.fi.intel.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <Y4TAF1hn0l1CziUh@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB4PR08MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: fec0a83e-4070-419e-9954-08dad14c9866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz+461xSIJVZKmPjimoRyv699Gsq10fw6m+KwnhTWSXuV4pkbZf+gv6tAsrYjT3RD3dDidFPBKlkCQBi05Re5Nssdyb7riYmbdQj7uiYmoeb/iTd6OUKXcDfjBqipIPEebXrZWHKTJZFQCGs+V5rg88tsN74UGzStWUZ/gGvVmGZnGjbrUqZ2Qcxbz0JkWXELPQbOny9jrhdNtwaMytHKiQ4CY1/nJqC08bLYTZagdzPEu5mBsBgpcrNjjsdb+hp9Zyi4wUJiEyb0ugDMZSjov3SjSGmUTOxkSvUyw2eROvpxGj/m9tEZ76xmBoYhaTCnP2ML1qMht67/8ezu0JkZdQKDlaW0DUUv2AOmQcVF9z9VHHefSmxWnS7vmPSvLdw5ezrAD5yBYFGyJF04Qxxa98WGlpjlzvqFPYIMe4Ns5u7QFJNWgoA6cOYOxaeIVyXGqi645qHHEkEzfS73vYHsv+ym8hLszXfrlh9CCqgNGJ6ei92OZFf5W0+2hCtMdPOGG2ekCbw79uCf/L3fDCvLT/NESCBraNJmPxKJuKJH+7LGfrPUwI2Szik4XRgpKDfPvZ1aznZ4nQRWEVuUa5Rq2DOSUXlkty3PEaHWh+QXv3QrpYqMqny8HJIPXHhplWNVzUt9msfbhnIlNiUDmkBOA/eIOJ5OlRQY7lniFw5o85QOeSzkxJzxoVeisFzME+pTj5Wvcugx1BBAI4yxhd45rhLna30lDQjrZlR2h6MU3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39840400004)(136003)(346002)(366004)(451199015)(86362001)(31696002)(36756003)(316002)(41300700001)(66556008)(5660300002)(66946007)(54906003)(4326008)(8676002)(2616005)(6512007)(6506007)(53546011)(66476007)(52116002)(186003)(478600001)(6486002)(6916009)(38100700002)(7416002)(8936002)(44832011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFuNG4xWjJidU5XNUIrSnZnb0lkbG5JNmNqdXhYeGdIWk5DZ0RueTFncjZa?=
 =?utf-8?B?RGRJK3BCVDF5TUVVWU52Q0JGS016TWdPQ2RHM2tjNHBXWEtzd3Z0YTRuMTRO?=
 =?utf-8?B?bllEQktYV0tKdko1a0R5a2R4LzlHQkUydVNtS0lMQUdnSERtaE8vUUdrMEtC?=
 =?utf-8?B?S3hua0Evcm9EbUt2YlJMZDdUNi9vbUR6UnRHK1VpREhkTW0rWnQwVFBaQ1JV?=
 =?utf-8?B?SFZZTXRMSU5BbDFmOUU2VmZJUXUyYUM5VHo2YUtRdXVWMHVvTUEvNG00djRi?=
 =?utf-8?B?eVNtNTk5aklWemN6Y1d1ZWwrYVZrMkN3NXVQUkVsQTZSTVhGVXBFejIvN05R?=
 =?utf-8?B?V29pbERrSXlhQ1FhQ2loUUtreDR2NkR2MUIxMmc4RE5UTDhWVDc3SFppOVFH?=
 =?utf-8?B?YS9GV2FTNWw0OStxbEw2bnZoNTRwTFpCaDlrMGFwSGloMEZJbzBQQWsvRGRE?=
 =?utf-8?B?cVJSNTE2SHRRSFkzSGwyVVBpUGJIU0owaEplZmdkaHhsQ1A0SmNqMjhGVzNF?=
 =?utf-8?B?blZOb2hneE5hM0tXeWJjNkVQdmNxd0Q2eUVGaWdDWUExb0ovMkhvTDFlc1Iz?=
 =?utf-8?B?K3BsTkVWbGh1RlVGZ25hUklVN0VmMEZGZm5EMlFiWnc4VWRwRUNXekVaQmhO?=
 =?utf-8?B?YU5YK3lpaVdSVkRRSVlLRmVIczFHd2dXZnI4YmtiM1Z6SGFzWWZXUWszMW5s?=
 =?utf-8?B?NkZMbG9sRW1GV3o1ZFNYanRoQW5ZZ1hqd0UxTm4wc1A5TG9KRUxZTUs1by9V?=
 =?utf-8?B?RDV3L2dKQko1dWIxbXdaa1ZGU3B0alVpeDRsbkF2Y3hOMUxQeGlJaTNvVmE3?=
 =?utf-8?B?MUQvWnEyM0VkbjJLdTVxWmwrZEwwRVNSSGVuTkI3a2VwOFE4eGVBZlpTclpY?=
 =?utf-8?B?TjYxTkJQRDZZSWFORktrdWxaZ1FLa2ZrcFNnNmswT3huS1BRMzVyWDgvaHll?=
 =?utf-8?B?UjEwSFExdzBGdkxtVElOKzMyUmRKcVhtZnBGWldUOHZYQlJKM0NGS28yQmNJ?=
 =?utf-8?B?djJKa0pZVW1mc2x3YlJkN3ZhR3dkMmZoOFRNVXY3QmZsWjhVdnRUWThXVEpD?=
 =?utf-8?B?UkF6RGZlRk42QjRHZUJBby8xTG9nOFdzdXNkVkN5ZUF5TGZMcnhBeDdHakJ1?=
 =?utf-8?B?RXlSUzRNS0dnY3dvc21EVkRWdkU0cDJueFF5V05oY0s1Tm9kKzN1Vlc4bTJh?=
 =?utf-8?B?aHJuRC9rR1hMS2ZLMmU0dk92TkdITkFmQ2YzM2JnbU42T0hKcXdWeUoxNThz?=
 =?utf-8?B?VlJCUjZHK3FIdjBxYlJGVUp2Y0RKekNsQ2drU3FJRXFvekx4b09QYWJKRW4w?=
 =?utf-8?B?NUFnQ21GQThSMFNoNWhSR0ZZY1JMdEVwK2NCTVQrOWxjQ1BaNzlDS0Jib2NC?=
 =?utf-8?B?SEdoaFRJbHdwL0tSOERubnBOMk5iMlhTdUd2aHd0UkpjcmdDWHdNM2trMXFY?=
 =?utf-8?B?dTMrM0k3V0o4elhqVU1ZVms2QjVmS0dPMW1ITU83TDRiSDdqRzB1Ry81TFRn?=
 =?utf-8?B?OXFpcUVvSE1qbjg4UDh3OHdLNjFVblVZR1Q1cmlITVF0SExCQWlPakJRM0x6?=
 =?utf-8?B?RUhPWUkvTDZYN3ZIMnpVWEhldUkrQ3oxUjVqeXpLN3V6QVJPY1Iwd0RuZlNH?=
 =?utf-8?B?eFBlc2ZBbzdyU0Rydms1N3A0SllpWHFxTHJrNk1mNlR2UlpyMlFEQmU5WmUr?=
 =?utf-8?B?elhmTm1oWVcwbzVEbGtRWC9vS1NyT29mT01vS3JqNVRHUjJHYUJUV3ZINDVX?=
 =?utf-8?B?NkJGU3VYRGgzRXdhS1l5U1NBYjZhNjZBTFlwZFI5THMwUHBFeitSeUNsbmJJ?=
 =?utf-8?B?aWFPQUlrZi9rMytyWXNUdFliemJCWjY4cFV5ckw1ejhGb2pDOEtPZXpwblln?=
 =?utf-8?B?OWhWU1NFdzRXV0ZGRldLVm54Q2F0Slpjd3JYZTNxQkVrVlVMMVpnWkUwY21r?=
 =?utf-8?B?bHdWUnBFdGtYbGRyL3dnMWM2Y1VxT0hUa3NtaTdpQXR1NXBkZWttc1UwWjkv?=
 =?utf-8?B?WXdsb1dyOWwxZjJEUG1GWFlZd3llSVVaTHhoWHJPUHVYbUxITHZaWU5qNDdo?=
 =?utf-8?B?Z3JFbktmYldtVGM3a2gzU0F6UHNESktoQVNES2JMQWJWajh4eng1M2U0M2J4?=
 =?utf-8?B?ZjRoUm5DczRMSG10UkhnUmFYNFR4Q0hwME8yTGtlQU9VUHFWVW9iaGx5cXQr?=
 =?utf-8?B?M2tIa0l0VjdkMmhCclhwMlNXd29oMjdwdjMrdWorcW95eGFyRk9BcUh2MlFu?=
 =?utf-8?B?RUt1cU5ZRUVjWC90bk9VUzNBQ2pRPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fec0a83e-4070-419e-9954-08dad14c9866
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:26:53.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRCgVyA5lqrinfIpFVNFDXIg/ME01I+ABVTtL88DwhHLlNbZWZDJCd9YJ+xr2NhtJwUUyPdWPq5DeGPSeNLbVxdCMhnN3e+B4l1WslAPSEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7959
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 11/28/22 15:05, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 02:48:48PM +0100, Michael Riesch wrote:
>> On 11/28/22 14:27, Andy Shevchenko wrote:
>>> On Mon, Nov 28, 2022 at 01:18:04PM +0100, Gerald Loacker wrote:
>>>> Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:
> 
> ...
> 
>>> It's a rule to use _t for typedef:s in the kernel. That's why
>>> I suggested to leave struct definition and only typedef the same structures
>>> (existing) to new names (if needed).
>>
>> Andy, excuse our ignorance but we are not sure how this typedef approach
>> is supposed to look like...
>>
>>>> or
>>>
>>>> 	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;
>>
>> ... because
>>
>> #include <stdio.h>
>>
>> struct iio_val_int_plus_micro {
>> 	int integer;
>> 	int micro;
>> };
>>
>> typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;
>>
>> int main()
>> {
>>   struct iio_val_int_plus_micro a = { .integer = 100, .micro = 10, };
>>   struct iio_val_int_plus_micro_db b = { .integer = 20, .micro = 10, };
>>   return 0;
>> }
>>
>> won't compile.
> 
> I see. Thanks for pointing this out.
> 
> Then the question is why do we need the two same structures with different
> names?

Most probably we don't need "struct iio_val_int_plus_micro_db" at all
since IIO_VAL_INT_PLUS_MICRO_DB and IIO_VAL_INT_PLUS_MICRO get the same
treatment in industrialio-core.c. At least it should not be introduced
in the scope of this series. In the end this is up to whoever writes the
first driver using the common data structures and IIO_VAL_INT_PLUS_MICRO_DB.

Best regards,
Michael

