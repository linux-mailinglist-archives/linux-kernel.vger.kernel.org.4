Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E19D63A81D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiK1MVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiK1MVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:21:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07001DF25;
        Mon, 28 Nov 2022 04:18:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG3Hdh6g9gdKt+JMCOMoTsYuM8zHY29rtqmeHIZ4Tr092w4fL4lmK9NRRxY6XjlQkoDTJ1ax1WZdjP2BI/8ci0JJIVxcUalWVBLnrQhlTdaBkucH8oYrfAk3WUzE2ryu+qoTehmLwVAD1suixfukZDmQN6j+cPzjKzoZusFfCCfZboFNpxBO7wB2/Ra5QLtFPejB7IHuQDCY+tkAoKTfN9l0dxEuH7vvmLXWX9ZrvqwkoiWFkj8Ge+tZ+BTuwKUOz0MAQtHp39Q9w+XzwIlgOS2+vfnF0IeBXqE3yYDBpkqzVGmNr6tz/TcjFTD9XTgCNallN0y3DQblyP5FY3iMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdy2bk+zadzK5rQ6q8FfYU18luVcZYCdGMFNd7M3aAI=;
 b=ASLpypGcesEiTxcb7XnSk707F3NgkVXChUd1AGF3VuU61PM9WFHRuWXREY4Kkibn+lGVkelg3NGrq7lVxXHfl5JZUwC07cz5ID3PMs+ENWjdF6JDhyvvpVvMje6OMQMn57UEFQxNhk90weXoVWujPyzG7ToaND1u0MWMwaNobJivEE4Blqzsk3AKiI/0GVjSoLRr40sgCUxjZGmLFnd/gv12J7hZonByM8W0FoACLdUdcw2kDOT5JJzoTLnq/aHCtnIkX4ABEyyFQbbdqTVEBjoUU69gQWIeZyXn7ezx/22JXC6fw/DeU5FS3MSKRxtcYab3w7t8uJ9QUApReQ9q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdy2bk+zadzK5rQ6q8FfYU18luVcZYCdGMFNd7M3aAI=;
 b=bmM9mCLpjIxCtSBlOZmjUXEuS8L9xzlZQYbf+r9397x+3IhWSMxTY69pnp9vwr57cTJPe2oQKrniL0oBjihldSTCskD8lQCNVS2KQhE+hj9KXqNV/lV3Yqc4d0lTUQybKDB3ERRqtRp4O7JjMSrDS9O88Ef5CvNvsw0+Nlf5AgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DB5PR08MB10064.eurprd08.prod.outlook.com (2603:10a6:10:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Mon, 28 Nov
 2022 12:18:07 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 12:18:07 +0000
Message-ID: <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
Date:   Mon, 28 Nov 2022 13:18:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
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
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com> <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::32) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DB5PR08MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f3e9de-9d4c-4de6-8a0c-08dad13a9b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQeTxos7sQBtR9T+UX/zt5VSzUwGCAp0X77DYhJ+PIod03kq/ofbSglTg/K6kHunmGP8kosZsmBLL41Laz4goru0LlV+stIYxb+Fglglq5nBuL1gWnTCskRSdq+NjfL3fSJHi0xlsd5z9BZFUMrhcL77xVvkGrGvorYzlCjaEN8yIKMPs3kRlCmcdeUkeqr3z71TPs+NdquRUQCN36mA6yvOOfCmYqBpYh/vO54sEnwPVCeD4ZeUSWeDk+Rme9dipQDZ7TpvRyqjFKKxXL3ooSsduj1BM8oXFSxGbaPhNEiYh1HVD7OgU5/dxyCI5lenYhYSVzX1vKT//2Mq9lullLax/3l44wtCQqg1Rb/pjI4U1TGs3sL6dFZVMj2l3f83XPU83Wga5iKYz6gqGxAwYL6sxprdo2GQI/11OlQoyvsFa42Kjp0iuLkjcjuOu3AjkqzMq4BqFNMY2Li2HnxBusPz0y/pQW/rQ2iStEV0eqf8Imd1blpravrG3RX1GE+f8bPO8jfiHPrWAZTsyI6porrIiYkxYrscM56pTf509a5NZX6LrEuAlA9DImqDsUg/tMznEYLMMDIHW/vQkZ2hFp/pi41ExGzUXNqU/z4XuudtvjHylq0hc7YQmCqpq+va0qah5XshYC+WzIXD/qo7g7hr2uHO7B4/dhGcbiB1UPd3C/94IT8zUCwegsm+vx/XcNp3l6dO0Fo84yoAfP6F76oBTTOu/QzlVJdsvLVGZ4KpwLZQaozimz/H0OH1vHQT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(451199015)(6506007)(52116002)(2616005)(186003)(26005)(6512007)(6916009)(6666004)(36756003)(478600001)(86362001)(107886003)(36916002)(6486002)(38100700002)(38350700002)(31696002)(7416002)(44832011)(54906003)(2906002)(5660300002)(31686004)(316002)(41300700001)(8936002)(66476007)(8676002)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFEeXZMREF4ZzdIZnAzNUo2OWdyOGU3c3FOL3YvbmtXZnlrZEp1SVNWUnlV?=
 =?utf-8?B?dEFjOXZZcDc0SndtTytZN1AvRCtJQzdHK0xJdFl3Z2pjL0YyWXkzVjB2dTh4?=
 =?utf-8?B?clIyNU5vZ3F6dk1Ga29VMHU0QXhlSjhDOVh5NXpKaEVqQnQwaGEzSFEycVNw?=
 =?utf-8?B?ZUQ4MkhCY0F0R0hRR25TK2MxWnpUUmFCR3NLSGNRMFRRUEJOSHczS3gyYkgx?=
 =?utf-8?B?VFVpK2ZkQTY4MzZYZEpDSnlkVGthNWx5d0ozRjZ2bldvZTN0aEtuRFdwMStT?=
 =?utf-8?B?c1VzeHh0UUZOdXFaVFYvY0VSR0RMWnJlTXI0a3ZwZ1hwQUwrOENzOGFHREtL?=
 =?utf-8?B?TkY1T1J5eXlOTlBsWk83RXpOcDNldHA2OWdUYTZFcUNEcmtKRnZzTDZLSEdu?=
 =?utf-8?B?ZjhnV2VIY2NjOWpnamdHN3BwN0Rhd2w3bk1reFpZbktUelJjOEdhMmtsMnQ2?=
 =?utf-8?B?UHVHckZKam91NkhLdTZld2x6WFl1eUVJdWFiUFdlZmoycWlsMzhjekt3b2FG?=
 =?utf-8?B?ekR0ay82V3BFR2FISEFOZ0cvaC8weGdFc3NrOW1XclJpL0ptR0hLdXlNOExt?=
 =?utf-8?B?K0tTd203M2JLUUxJcmZweXZqcDBwdjVrTFNFdTBiR0cwa3dMUXZ3L2ZlOEZO?=
 =?utf-8?B?ZnVCWk5LclowSk9aRk5pK0d5b0JHVExBUGVEcEE4ZjJkZTJVd0lKdVZVS0x4?=
 =?utf-8?B?SWZNYWF0M0tqbE1hWm8wbTZPQlg4LzNOcHBtWHptcmowUktGZjRmOGYzcWli?=
 =?utf-8?B?TTFjR1BoQnZJcVRkNldDMUVzS2JQbHpmOUZhNEFFTlJaenpTQU5aWlJpUFpG?=
 =?utf-8?B?djJlUjZXYzIvQ2UvZlpOYmtPcTZxZ1h3M2gwSmRxZjJUYi8rSy9IRzlNOGlh?=
 =?utf-8?B?K2hJdnNpeWNlMVM4QUYyRzQ3MlpMUlRrcVFzYjA0S3dOMldxbVFOMzczT1lk?=
 =?utf-8?B?RHdraEhseEtnc3FqakdISWpLMFRmQjZDQWRyYmMvajFUS1d4ZHpvWXpiQlRu?=
 =?utf-8?B?KzFmOUZ6MUtxL0NNYVAxTG1PdmU0bEF6K251THVwMk1tSDFKa1ZlKzROWnkw?=
 =?utf-8?B?TkUycVl5NWdOTTZ4RGkveW5lVjZGWXBPT09pc2M2aUFrZzBNeGFHV3cyMzIz?=
 =?utf-8?B?UUdQN1IrM3RhYS9EWXE5ZlNsSEtYNDBVQzM2SGswR2ZyNjMwUmxIN3dPRWUw?=
 =?utf-8?B?MG1hVDQwbWF2RXZEVHZTVjQyWEoxbzhCNmVLZEVHRmIxcEpvbkpjUVBFS0Z6?=
 =?utf-8?B?TnpvZFE2Z1R5bXlyRVVTcWgrQjV4SzVENzdDSzI3TDZKRXNXT3pHQklpOGFL?=
 =?utf-8?B?TjhsTWRIUWxtVjkxVFhHMHY3YzlTNC85aE4zWEQ3aWpxaTk3bFpudTlpQWFW?=
 =?utf-8?B?MVVmQWNSbFBpcmordHhtNzRWbUZ0eXVOZnBZU29DUWRwZGJRdUZJVG5tK3ll?=
 =?utf-8?B?V0c0ZEs5YVJyUzZFUStPVUw1dDJXU3JQWnF4U09NQnJySFpUWTJMOGl4bllC?=
 =?utf-8?B?WWNISXI0Qis5b1ArQjRMY0tXeTF5VXV2ajVuZmpYQ1lXbXh3eU1ObFI1bFVq?=
 =?utf-8?B?VUFtbTRwOWYwdDVYY3prUFBMUkM3cWYzOFRsMk1MNW5GQ1JwSis5TzdRNFVk?=
 =?utf-8?B?dmRMcUZDdkZQZm1KVXdTMEkrT2gyekl4WWI2aHEzYmZaUUF1UGk5Vjlhc0FH?=
 =?utf-8?B?MUNnYzBvWGZ4UitkRVVFZDVabDlDTTRPWCtFaDdqS0EveVdiQlpkdGxNUkRq?=
 =?utf-8?B?YVpyRkVKaWVERW44bzJudmRjRjFqSXN3dDBQSFdKSVN0dHcyMU9mdUZUSVdt?=
 =?utf-8?B?NWE0UHY5R2FRRHVjUDR6dEsxMEtQN3B5SzFCVklYS21Ed0ZDZzJmbHF5TEtl?=
 =?utf-8?B?a3VrRU9hYVFqc0lYbzl5ZEl4Z2dIZVpNUjF4UWFOZVZZYmN1V3lEczNNVGIv?=
 =?utf-8?B?N2NjL2swaUxaaDh0V2I3K09BenFoRko4V1IzR0FlRnFBVTU3VzdZeUF5RUlM?=
 =?utf-8?B?cXVrSkowNFlFem9UU2NaSnBsakxLbUlmMmpyQ0l1Vk4yTTY5UmY2cVloVEo5?=
 =?utf-8?B?UHp6cGFxSUlVdWlBcDNXR0IycXZsOXZmNUVjYytyL0hZMHhDYjI5KzNQeWl1?=
 =?utf-8?B?RUFndGxsMkliMEFkTmxCMGVqRE5JanpodWdyMnZ6MC9TTXQ1SENVcWN6S0J0?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f3e9de-9d4c-4de6-8a0c-08dad13a9b95
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 12:18:07.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQy68KG/M3PgRsOxIY44J9ri8pAhShiXs63qdSLwIxnVTkyXw5uZ7h2+P2JY9VPAXIVrARc40O4Ebbx6tneg2INigvs9zxdzJhxnqSmyZ7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10064
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:
> On Fri, Nov 25, 2022 at 12:45:06PM +0200, Andy Shevchenko wrote:
>> On Fri, Nov 25, 2022 at 09:35:24AM +0100, Gerald Loacker wrote:
> 
> ...
> 
>>> +struct iio_val_int_plus_micro {
>>> +	int val_int;
>>> +	int val_micro;
>>> +};
> 
> Thinking more about naming, why not drop val_ completely?
> 
> 	int integer;
> 	int micro;
> 
> ?
> 

Yes, this sounds good to me. I think of adding only

	typedef struct {
		int integer;
		int micro;
	} iio_val_int_plus_micro;

for now, and one can add similar structures when needed, like

	typedef struct {
		int integer;
		int nano;
	} iio_val_int_plus_nano;

or
	
	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;

If you think it's better to add them all, I can do that, of course.

>>> +struct iio_val_int_plus_nano {
>>> +	int val_int;
>>> +	int val_nano;
>>> +};
>>> +
>>> +struct iio_val_int_plus_micro_db {
>>> +	int val_int;
>>
>> 	int val_int_db; ?
>>
>>> +	int val_micro_db;
>>> +};
>>
>> Actually why can't we simply do
>>
>> typedef iio_val_int_plus_micro_db iio_val_int_plus_micro;
>>
>> ?
> 
