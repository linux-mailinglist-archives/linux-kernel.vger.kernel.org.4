Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0706CB7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC1HLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjC1HLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:11:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2120.outbound.protection.outlook.com [40.107.6.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C57F1BEE;
        Tue, 28 Mar 2023 00:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2AVU38mxewEXXd2uYNIC6bTcO7GTyU4mRWy06pnWjpD5l1x6vqE2/mjd1vqNrhNz7lnqPIP14uK9391U5HCiusIoS3YbgzauH9esGdy2yw6imKZPIaracsMvKZnTwIzu2ORnTzUqf4NN2GVnwV1cp8jXdxteGOPw3dcCeeDtfkU7HfIA5IFjjhfbhv9d5WtX6a9xXN3MYMJBkljUXJhihy7EiTlK5Tgfnf7tCWRFCpZ11sn//leV57pPzVfhm3UcA1wJC28XyRniWVK1Xzln6NF8V809FUa7+RHd5sYdAbpPdR6OIJXxVc8Ox7CGBba9SGOp1UCks4+RX89yKLMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7QNVwyDGahBTNNONnkOSXvqX/mEI0TDxGOF1eKbK2g=;
 b=lQ14smd5bMGWEOrSHBlyWBgT8Kmv3+YjVxU0P/X7uxnv5IBfYjl6/dclOPS4HabjwDnkXKZqhkRw7JxsUklhXk3yw3mnNWXGdakVtvHVToGgOZQjLDv55C0M4gLIFIct3BBuM+9MbGSyshxJ/kXb2jqT+3W1fs1rDZLyxC+3pcXrc5lFyn7ZvEh3SeFkWU59GqAodXo3Pkc6qO+opOT+FYQxvPWpGy92Ygiah2E17amceV7KDYcAi0z6zQ/FSBPT72kVYYE8Njyn2jgJZye9XivNWc5beK27ZJYSDSdTe8wfGcIFYtXIxqHj40KW9vczf42kxPy47pu0PLDERC7sBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7QNVwyDGahBTNNONnkOSXvqX/mEI0TDxGOF1eKbK2g=;
 b=aNl3UeyUXNSpo2U8yo/a9xBC6KV/hbPiEGiI1bem1gcsf5D8HjdFXShjGe8AxKfBO/jfcAdUJ+ZViZ9EtKh6ckoPf3aw0sc8JU/HiD2zpxUXckhCxb2pE9PEW4kub19sTHOFmdMx63qehtkWMtEhXMPAibpyYWwUMw4hgQdttcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB5336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Tue, 28 Mar
 2023 07:11:00 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7ec3:9d2c:15ac:e1af]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7ec3:9d2c:15ac:e1af%3]) with mapi id 15.20.6254.016; Tue, 28 Mar 2023
 07:10:59 +0000
Message-ID: <cb4d7ae5-f10f-e5d3-60c8-b96151160e10@kontron.de>
Date:   Tue, 28 Mar 2023 09:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230201143431.863784-1-frieder@fris.de>
 <Y9qQHpySbrFcBB0P@mail.local>
 <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
 <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
 <da83fdd0-9eae-09ce-ff6f-47cc012f9628@kontron.de>
 <31b0a8b1-d027-d47a-e10d-614c09211734@kontron.de>
 <2023032222190171a38d5f@mail.local>
Content-Language: en-US, de-DE
In-Reply-To: <2023032222190171a38d5f@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 682be579-9654-4cea-d501-08db2f5b952c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ8LIaGMiplBGNb4sYksOYmAnMGgFaRsP0kr25gOmyrqPJDZrV1X0i0UMm2a5Z+8Wqaofz5GqMkN7NEY2+PtdfVvK/TOm15urSZLNC0eovqYERsgHxcvbP9Ag6Yvzz8rc5IV1gQZpKPx+M8X61efHjUufQ9s1TyAnH9SvxvoLRH789vLrkw68SAGNvhiY5EgL9fY1O+owu3cAHQOeSHzewXPV4paml/4ncR/46JrVjkYUfdkqD8H5LcZ++0+c/EGxGY6R7GS8sY5bFTk2xnv0gdstOrhU9ChqsTUoentrpnmHUFzAuRmyL4fQMx2amN0eSaUh4lUx414gJPMTQhoo5quMpa5HqWwfQG8zTXT9KdsGJvlNXVY2izXYx1kC570cc43pE8WrzwQ7z8TF94vAprPuuXNLLMMYqll+PgLcFDTAQHoDzHB5P9YiKoSHLfkYd+wXd48dqZl3qgmFWO+T/ZZcrb5pgbn7i4VXw42x4k04kepidsfjRemlcwLhH3uHGwOlJnIrM3+t//MnjOwD0ZjqDaJaIX3SYRDYRyZ5ciPH8+1DlEAHGUnGsF1Hpqo/pOg30pDnE+ym2plExXi+X2nnr5i7amRDyosJnL56z1feYVF/hkINeB5CK85+Qyhq+loFoN6EiR2sU4l+Uum4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(38100700002)(31696002)(86362001)(36756003)(7416002)(8936002)(44832011)(5660300002)(6666004)(53546011)(6512007)(6506007)(186003)(6486002)(41300700001)(66946007)(31686004)(316002)(478600001)(54906003)(6916009)(8676002)(66556008)(4326008)(66476007)(66899021)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJtYXFNUWZZenluUnRGQis5YzNMQTYyS2dhYjJWdEg1SDl3QTExN2F5RW1B?=
 =?utf-8?B?TTRJd3d2L2VzR3hEb2FsYTJHNVNHN0M0dTYrRC9wYmtENStEazUwbjFWYjlr?=
 =?utf-8?B?OTRPMHAxL0tuQThXUlZkaFd1alZSSVhwSmZtaWdGODNHVDc4MkpYSzNKbUdx?=
 =?utf-8?B?ODJiYi9HYTZNQzA4eEZwbFQ4Wm5xWCtJS1RZVzEwN0hvUUdmOVNob0VhbWYy?=
 =?utf-8?B?bHpKZlMzMUlEZ3JNNGJRQXZGVy80YllYcmdZSlBMcElzcHRHa2lEVlRaRGU3?=
 =?utf-8?B?a2VRanh0Y1NGUUs5YldNNEZWQUg3d0hFeTRnQ2s3emdGWDZMSFpNRnVXMG9u?=
 =?utf-8?B?WnRubUR0bVREK2lRZnFzN0dCV0N2eEx2dXdZRkVDdUVzSlZncWZ0UVJmRHFt?=
 =?utf-8?B?ak1mOFpyVDZVQXpDRlVKc3pTY0lxWnJpNnlWOVZWZy9YQlkzdGU1enFZblRU?=
 =?utf-8?B?amJlNUpoendUL214NWp5Z2RBSHVjMEdaYm0yLzdleEI4YW82cGIwcWxoUXRp?=
 =?utf-8?B?Yjg4eHpEaFdlUXltNDJZU3VQZ3d0M29IY1diYlV5VDUvZHhOVzIvWDBzdmlU?=
 =?utf-8?B?dFRzVE92TFp1bENZbDlBemxKQ0tDQVQ2bE1UZzN6ditiSWlTeEVQSkpBY1pG?=
 =?utf-8?B?RUtUV1Zqam1GMHhDeFllV3FtSHl5Y2ljaVdtZk45WVNHRzhYSFhtY051T1lI?=
 =?utf-8?B?eW1GSEt3NElUMDBlSEpqS2NYU29RRDN0U2VmeGIwaitTWWdoSnhyTExieVhE?=
 =?utf-8?B?SGlJZGZhVHVXdnhUaFVrUU1pRy90WVYvT0lSTEZVTmRIbStEV2tjd2dwNmlu?=
 =?utf-8?B?M25LSUxNM3gzZklPVUZLMVovY01icnlqVTJKSjRsVmFGdEFKQkgzUVNnbm1S?=
 =?utf-8?B?WTJSMXlNZTZjbGxwMU5CaGtWV2RrQlJtZEhXR1lZWHNYelJjaTdSUlVCNnlO?=
 =?utf-8?B?K2czR0tLdC9tNjF3V1REVDBnazlMdVJPTm50eHlkWVdFQ3V4RU1wSlpnbEpC?=
 =?utf-8?B?ZU81WlY5UHFZOEFQM3NNbFdFcEg2d2lqNUR3b2NPNFA3dHU0dlpHK2ZsdFhk?=
 =?utf-8?B?NE5GY050YUsrODB6OHpOczhUWlVHTWNJRHJ6QzZlaGpCeU5RUFRoc01HV3FK?=
 =?utf-8?B?UkFKUWRLWmZ2NmZ1ZmFKcHZXcWNnRVM4QnJLM1oyM2xnUUJUdFJSMmtXYnpy?=
 =?utf-8?B?MWhWY1k2U3N1ODZBQkpCWmpOZHI4bXZHN3JDV1lYNHJrd2w0L0lsTXluWXFL?=
 =?utf-8?B?cG9YVy9pR3JHM1Fzd2VjUDFIVnlJTnpqKzRjS2p1R2M1MXpGaXo1YkRSTmg4?=
 =?utf-8?B?YWRGckJaNExYcVhnek9seXVPZVlGUk5mTFZNaWR6WVJ1MnFpdmNrVHhEMGho?=
 =?utf-8?B?YTBtWEVaY2NmYVNic3kvUlFBZG5VeVFhakNGMFdkR0Y4OThoUnV0dE1mb1FF?=
 =?utf-8?B?bURzRDM4OVdQT0l5clM2bXZQcGJ2d1pxNE4xVlhjWm9xTlJ0aExlYm1zbHN5?=
 =?utf-8?B?clFvcFpNRnZiTUFncTloeit6SDdWVE1VQ2hzcGhNblVBc01QY0JiTXF3elZJ?=
 =?utf-8?B?Q09pOGJJVHF0anJUS1dwd2M5OFBRWWV5cms3NTVOOEh0WVBPTC93ZkpIc2Fr?=
 =?utf-8?B?RUFIOUZ6d3FYd0d2TXZkOHNOS0NUUm02WHF6M25STlZMTGZ6S0d3Q0RFcW14?=
 =?utf-8?B?T2J5aGgxRHNMdWErM2FaUGFmc1NqYVBFSXlWcGd0bnhZWHV2Um8zcmNaZThX?=
 =?utf-8?B?NENlWVUzbnZmTmhJM1FXY2tHVnFkN0EwR0VCSUIwdnJXc1FhckNQblVSOW9X?=
 =?utf-8?B?dVlsQ1hYMjBzdU1nU2c3UG1ucm1mLzEwcUJaRU1ybEFLQ25MZkJGTnd0VTc5?=
 =?utf-8?B?RVZQcDlDbGUvdHN5UUNzT2hQSUVuWWJVYzU3QndUWjROOHZ4andra1Q4WHY4?=
 =?utf-8?B?NkV5ZzZQYlJ2dHZrVDU0MU9xcGVBbDFlbWhFQkhqakZIZ09DYkxaNWM0UUdD?=
 =?utf-8?B?Nyt3NUtQSVRweGhxS3JqWjlPWFAvaEdZY0xZQ3lvYUVvcVpGc3hzWFRuT291?=
 =?utf-8?B?RU85Q1NiVVBqY0JJSGIxOVFla2hycGVkaEp2V1Q1VTA5aG0vOE5nZVp5M0ZB?=
 =?utf-8?B?b3ZNVXBQSXpzaVI5Y29HWEdIQmhrOHZqVURJeDV5Ri9EYkovM3VEQmdmQ0Zh?=
 =?utf-8?Q?WJNZ6cw71LBv4fCnL7tKpnTFzKnWT6TgVGq03zSI9fAG?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 682be579-9654-4cea-d501-08db2f5b952c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:10:59.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQVU/PdNUDMb4wmrOAq22c6IrgMPTTDvo17wSag8tVeBOchtp+Q0D2kTI/vZf7RuziRD8lsx26rS+avJ/crJhoUA1g8lDPJBocBNibzu3L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5336
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 23:19, Alexandre Belloni wrote:
> Hello,
> 
> On 22/03/2023 14:14:50+0100, Frieder Schrempf wrote:
>> On 06.03.23 14:27, Frieder Schrempf wrote:
>>> On 13.02.23 10:18, Frieder Schrempf wrote:
>>>> Hi Alexandre,
>>>>
>>>> On 01.02.23 17:26, Frieder Schrempf wrote:
>>>>> On 01.02.23 17:15, Alexandre Belloni wrote:
>>>>>> Hello,
>>>>>>
>>>>>> You can't do that, this breaks an important use case and it is the
>>>>>> reason why I didn't use device tree in the beginning. What is wrong with
>>>>>> setting BSM from userspace? You will anyway have to set the time and
>>>>>> date from userspace for it to be saved.
>>>>>
>>>>> Ok, I was already afraid there is something I missed. Can you give a
>>>>> short explanation of what use case this would break?
>>>>>
>>>>> There is nothing wrong with setting BSM from userspace. It's just the
>>>>> fact that users expect BSM to be enabled in any case as there is a
>>>>> battery on the board. It is much more effort to ensure that production,
>>>>> user, etc. are aware of an extra step required than to let the kernel
>>>>> deal with it behind the scenes.
>>>>
>>>> Would you mind elaborating on your argument that this would break stuff?
>>>> I currently don't see how an additional optional devicetree property
>>>> would break anything.
>>>
>>> Ping!?
>>
>> It seems like you decided to ignore me for whatever reasons there are.
>> I'm sure we can sort it out in some way if you would respond, please.
> 
> I do what I can with the time I have.

Thanks for taking the time! I know that maintainers are usually
chronically overloaded. Still I got a bit worried after ~7 weeks that I
wont get a reply at all.

> 
> There are 2 issues:
>  - the first one is that this is encoding device configuration in the
>    device tree which is forbidden. BSM is not really hardware related.
> The worse that could happen is that the backup voltage is not present
> and so the RTC will never switch to the backup source.

This is an argument that I was expecting to hear in the first place. I
think this is kind of a grey area as the BSM feature is definitely
related to the hardware implementation of the V_DD and V_BACKUP supply
voltages, but at the same time it also might reflect device configuration.

> 
>  - the second one is why I got to a userspace solution. There are RTC
>    where it is crucial to be able to change BSM dynamically. Those RTCs
> have a standby mode: they will only draw current from the backup source
> once they have seen VDD once. This is useful when you install a battery
> in a product and this products stays on the shelf for a while before
> being used. However, if your production line needs to powerup the device
> to flash it or perform tests, the RTC will get out of standby mode and
> you need a way to get it back to standby. This is possible with the
> current interface, I'm not going to have a second interface.

Thanks for pointing that out. The userspace solution is definitely
useful and necessary and I would never argue against it. What I'm
proposing is not really a second interface but a way to set the default
mode at boot time. If you really think this is too much, then I will
need to scratch this approach.
