Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FA65B18D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjABLzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:55:19 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6CC29;
        Mon,  2 Jan 2023 03:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsND8VPorJ7lVdf+0La0IC8pvMNg8DMqVpe4N9+r8nwxb+8wyvxT4o0wZwoQYYiglhnpXqnUDYfQhah0Gdflx6PvcQ1dTKtTnGoMKCXu3F+paRSnOzXampZJseDClCEMOFTYREdzP1y3cO5PWEKFy1NXE+DZKyvPc3KKvGoMH1DfXh7vAm+ZV4ZurxyBIhWmeme64pqrL/PyswQBx7i+fD7tlrRvXF3cCya6b0lUGJxWx/pyw8JFGkZXBVOC+V6ge5RGPuR4d7z1mqZfFjeP7ELZhlOXrmuFsPpyjmqmVUBHHcW4jWi0ImklhcPq7eBSTQgpfT2mtSW/fzY5Xa/dSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7+aQzDnwlT7eViFojHSYSn62gAhMsCic1zc01y8skA=;
 b=EctNdLhCLmJApklv/kZsTlEUG83SM8EtRicKVmCmlM4tFA5PMLTxffeGKlQcFpQ5q26qFbk+leoHKgfp01x1LHIdl1pYpLrhzWp7QsPgmpfPqMOcXdBpB8wLk77CFCr1jjLenlpJEhuH9lpwi553YXARbQMrXIpxvfcMxzUYypxl1FVfrxjtl0TM+KWlVUwasjL3RbfePhgH+0oq0G2CPoW4UC/PnkSZ5GVm+KYizSshtVx9Dkrxq/oTPP3EVjc9+QCuWfSgCsFhh0Tp9v7kQkUvljhy6WMQIO+53DK+B5Ba9TdRAQqz+rYxRVdXjXVkwzKjidC634eXNJ+zovSNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7+aQzDnwlT7eViFojHSYSn62gAhMsCic1zc01y8skA=;
 b=iZ1JwLzLFZt8A4x1ffm+BVHosL84vrOGV+R0PMSwjECfonbShN0LgCWoVUJqK98TbcIpX9MwIJuiY/8ax3rc2hRkmo8Id7lNELhgjR+jdbWQa+u10Fea1EWcq31XxvCZc9yMQGOIwckOOq9RKPDf8TV9Nd52apDtNmwy3NnHSZMURv2Mz2WBvQtmPUvCWA/hZ5WS4cYxkAHsNB+MTYHNCRnmIlDP2YFwB0fFeisxuCeaVqiEEPmheFO+DldSTQ1l3yMm+L4XmtsJ5nx42MjOv89q3wWtH7Df+txz0cBpjisC1Ejl9os4ppNUkG+HmTIcC4bGqoG43Q9YbDNlOMuClA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 11:55:14 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 11:55:14 +0000
Message-ID: <f98a3ab9-73a8-812d-c363-8039b8837bd2@theobroma-systems.com>
Date:   Mon, 2 Jan 2023 12:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/2] usb: dwc2: fix USB peripheral role in dual-role
 mode on PX30
Content-Language: en-US
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bin Yang <yangbin@rock-chips.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
 <BYAPR12MB339938A2413F4D40A084F4DCA7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <BYAPR12MB339938A2413F4D40A084F4DCA7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::29) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7687a260-8a92-41d3-4e48-08daecb835c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bHCXVPiFFOcwftkzNh7DfUFQwd/a+N3QOF2oa7+4DNrHnSyXnTjvRKQoUzJR3MZIDUzTtibsxycjXpj1sNTUSNNVRgYMGt4X1eXNqZ1wBJg6YQ1XFAMU1C5fk7ungL6z/ttPP9r15pLRd/IkjM8iQoPY0ONKxza8VCOQKZq7lj1vlJnS3aVRbc/uvwryfIH8ZswpQSjRJ82iixg3oVJi88JNk45CqN60XWWIB5kx20RErX1ZlzkBwAzF9t811YBRsvPtGLOkxP8QfV3s48g2LEMhNyNWDKPnf/PSXiIXCUDnXuZPKlmQrL1dl62DVj52Q7nmtcgalXP0RMOd4qQAIk09GyMBe2ugJ+sftqQgnd6KMnVsUaJQxtvVAS3TuLgHOfXJ/itLD/qxbHeIzgFz6T75jouZHiYzkNqk6BlkOIqtdoQhUZuB627tKfKfcTOcaSeOBttcVjfHOXNF1606d67dta1kSyA92IFSYRftx4VnaqjEgo0dRyRM7j4fjT/Qd0ROYfk45qT+dgKvf4raouZ1PFY2hfCvpovxYQrerKj4xfTVkrHPMaOI92ss9zElg6n75XBXRglyOOyMZgqYitAfq9ys5kkbXqaJDn3qCHtZ9idldcOimG2OWorzzQYZibF5a6Lw7hzfmTGAcAisvvNtB48qRZM+Ce3Sl75TDHcgrCRVS1PW9IdisReNHQTSkAgYCuw5TuB7P3n07KkV5jFjYkc+IjgkDnd73unim3qEWvB1fv1o+doIn8TO+8wgobL+TPGfcrksbJicp8lMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(451199015)(83380400001)(2616005)(31696002)(86362001)(36756003)(38100700002)(44832011)(31686004)(5660300002)(2906002)(54906003)(110136005)(316002)(41300700001)(8936002)(66946007)(66476007)(4326008)(8676002)(66556008)(186003)(53546011)(6486002)(6512007)(478600001)(6506007)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXUvS0l6MmEwd3JDOHZqVDZqdUw5SlkvSS9mZ01OakQyZHV3eVVrYWlRbmh6?=
 =?utf-8?B?Wks3TzI2OCszRW9seXBGYlZBK2RJZU5oaCtqVHdjUjRhQ3pTZ2FwczBra0l2?=
 =?utf-8?B?U2M2V0lXdU1zdUw3T1VKT01vamZvQmJGTTR3Q05QK0RSc2pPa01HUlpGMXlO?=
 =?utf-8?B?L2YrMVR5VW1TWVJNSmx4ck5zN0pXMGd6TkFKQXpkL24rbklzTzAxU2tTVmU2?=
 =?utf-8?B?bGJRS3M1VHVLY3l3R1RYcE5XMlpNbFcxWmJuTHBoQ05zNm1hOVNrYmFBaE90?=
 =?utf-8?B?RlhDZms2bGlYdk9ORjQ2aG5UeEhpOFByMjl6cTF2SGxwZDAwT25TMUtsVkpU?=
 =?utf-8?B?V3VRYkFidjBLdUhkd3NLOHVkdDhyYU9DbStKWjBhZk9lcXR6WFJVYnBiTExY?=
 =?utf-8?B?dHhPbDZER2phTyt5TVlUUXR2UnNjY3hHVWhDbjBDRWhsNXQ3blJTVWhlRlVp?=
 =?utf-8?B?Q3JPRzZqNkNWRGhZcXBYeGIzb2xIb01rRXRkYkxMTEJicThiVC8rNnNxOUNN?=
 =?utf-8?B?VklkaDNtemVVQ1JDd3drYzROem02V1VlWEhkNHJZMGtKb1ljbGJHWS9FRzlI?=
 =?utf-8?B?OHcwb2pDV0MvNVllWGFaOVFqV2NGb2pwSEg2aTMxYzFNOHg1QTV2R3ljNnYy?=
 =?utf-8?B?Z0ZNSzlEWGpyeDI3WXArTE9nTXlnN1Zwa3JXWFRjcjRIdnRwZ2NyWHIzQ1pG?=
 =?utf-8?B?RkFZdlhLbjRCdEJzeDlKbW9Sc2ZwL0dZaDd1SzZIeGVNTXNJWDRIbG1Fcnd1?=
 =?utf-8?B?UlNjK0F2OTB0bm94YjQzazQzZmNSQW5lcnYxZ1ZQWlJ5M21zK3ZnMzE3SEI0?=
 =?utf-8?B?dytUY3Y4TkRxWWpvNlhWcTVUV2FXUEswNnNoeC9HOUFFSmwyRVN0WHFlcUVM?=
 =?utf-8?B?WVlJYXQvbDZLc1U2VGQyMjZDQUV1UnYvRFl2S3lhZFdjWStvdVdmYkdsdHhn?=
 =?utf-8?B?cW1VL3Zyd3JIMW5OTllXMkVLMzcrcWJ2SGcvT1Q4b3hnb2QvdXVvRUVnWUNT?=
 =?utf-8?B?OHNqQmZSbHFtSlpxSUoyR3NaVUR2QUhZc2sxVndTZHNldzZEZ3JhTXFEUWRy?=
 =?utf-8?B?RXhQSUJObkhOa0c0djBIVTE0c0JoTWNMUU5jMVRSQTNZd3prNFpBRTN2T24v?=
 =?utf-8?B?OTM5L3h0bWNYSVBWTlNFaGRTdWdmQ1hacDJLNmtGcUR3bmM2SFMrRjFydnJG?=
 =?utf-8?B?YW5xcFlQU3NrM3VEbkJWdXk4aXRGZ3lQeERuR1BFMW03REh3MFZtMVlLT2ow?=
 =?utf-8?B?VlBJMFp4dkI2RWtJcXVvdWxtNWV5V0prUmg5aFhBRWVwZE5UbUluT09KUlNB?=
 =?utf-8?B?d2RpN1J6K0hpZDM0VTFNSUQ3NW41aHNRVWNFSGJZcnNSOGF0bHMyVjZpa2hF?=
 =?utf-8?B?L2JYYm94VmxQQUliVU9OY3ZZczduZDE5NEtOZ0ttdWdEaWpCN1k5UVNGSnRR?=
 =?utf-8?B?WS8yVGhFem1jQ0x4NkUyd0Nra3ZvM2NtTWZtdElZLzVlUENzYnlIalZoemZP?=
 =?utf-8?B?bzVMZVN2NHlEYTJCODl3ajVoN0t6Y2MvcUJyU0RpNlFvcEgzR3JUMlhjeDVL?=
 =?utf-8?B?RFlmMTNrekd5d3gzZlFmc3BUOWtWTVhXcllCaXBadDl0Qm5kZEJveWR1K0ow?=
 =?utf-8?B?azhOMWhxeGtUVCtkNm4wUnc5Szh6NGhGSjhLejR4QUdYYkJMSmUxUTZCME1N?=
 =?utf-8?B?eTFvY2NLZlBzbDM3NCtCYldadW1HUC9WbzJrNElWN1l3YWFHdXFvSUVsbGFL?=
 =?utf-8?B?TVVLVTNIVlhUVGE5UHl4aWRmSGdrdFo1d3pTbHBYZnNpb0tUV053OVVQd2tS?=
 =?utf-8?B?NVFzN1F6WGNMUXRGRVZmSW91WmtBdTAzOW1KUVhkTXF0SXpkalpMNjF3bndr?=
 =?utf-8?B?V3dDQ1V3K0R6ajhJSE1uaU1md0tlZWRHYmcvNXhxMWR1RGNMSjVqYkw4bkFI?=
 =?utf-8?B?WkFETGx4UW1yOTBCL09yV01FWFo5S09LRW91K3BMZE9iZCtoQTl0RVpCdmNN?=
 =?utf-8?B?UWUrVFhvWVB4Nk9PQ2djdGhkQUYxeWdIZkE4TytCd0l2RzFZekhWRXZYUUhx?=
 =?utf-8?B?MGVOUFJyWDM4SkpyMWpGTzNUZTVnSDhUWmQrYXl6NG5CL3Bod3JEb0ZDaXlB?=
 =?utf-8?B?TzA5T0pQTm9HdkR4SmtWbHhTV1hPUkpnS3hMeUkzakpCSE5sdjA1dWFPb1BT?=
 =?utf-8?B?aExNZ29oZDFEWTB1UWh5NEtzL2Z6NHdHL0xETnYzYkxNeWVTcDVHaTRGYkVQ?=
 =?utf-8?B?ZVM4YS9EamRIZXJ5MVdzSWx3VTFRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7687a260-8a92-41d3-4e48-08daecb835c3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 11:55:14.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMZkgpjgFKPIGZ++x3+0XkoMB5JU+HDcArZSbWsuCzxN5OGu/lwgE1O3Z8EZ8KD8R1vxKA2T6+xeejb8ga9peVlCtiHBniNWoVOHjEpZXPXo9xrjpWwlHQCD6y03J9Tz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On 12/20/22 07:02, Minas Harutyunyan wrote:
> Hi Quentin,
> 
> On 12/16/2022 8:29 PM, Quentin Schulz <foss+kernel@0leil.net> wrote:
>> From: Quentin Schulz <foss+kernel@0leil.net>
>> Sent: Friday, December 16, 2022 8:29 PM
>> To: Minas Harutyunyan <hminas@synopsys.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>
>> Cc: Quentin Schulz <foss+kernel@0leil.net>; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Bin Yang <yangbin@rock-chips.com>; Quentin
>> Schulz <quentin.schulz@theobroma-systems.com>
>> Subject: [PATCH v2 0/2] usb: dwc2: fix USB peripheral role in dual-role mode
>> on PX30
>>
>> On Theobroma Ringneck SoM, USB peripheral role when in dual-role mode does
>> not work and displays the following error message:
>> dwc2 ff300000.usb: dwc2_core_reset: HANG! Soft Reset timeout GRSTCTL_CSFTRST
>>
> 
> This mostly happen if PHY not initialized correctly.
> 

Any way to know which part of the PHY wouldn't be correctly initialized? 
or is this just a whack-a-mole game with register bits?

>> The USB sniffer shows nothing and dumping the host registers is stuck on
>> HCDMA(0) register.
>>
>> Note that for some reason it works "fine" on PX30-EVB (there's another issue
>> but not related to/fixed in this patch series).
>>
>> Since there's no documentation available for this IP, this patch series is
>> basically just slightly adapted downstream BSP vendor kernel patches and I
>> cannot unfortunately give more information than what I have.
>>
>> This patch series was tested on Theobroma Ringneck SoM on Haikou devkit and
>> PX30 EVB. It fixes Ringneck support and does not break PX30-EVB's.
>>
>> For reference, the content of those commits can be found in tag linux-5.10-
>> gen-rkr1, and the following commits have been used:
>> 964d50060bf53a8defd1fc561b9261424f25ddad
>> ad81c375602819a538ad68d979906c05663046e2
>> 6e6adab8f735bc4fe27a67bdc3144d8fa89250d4
>> 7c3a4e60247fd7f7b04d95d15cb12c63a5c20408
>>
>> Note that Rockchip kernel called a slightly different implementation of
>> __dwc2_lowlevel_hw_enable instead of dwc2_lowlevel_hw_enable but it seemed
>> more right to me to call dwc2_lowlevel_hw_enable as done for the forced
>> peripheral mode.
>>
>> Note that it is still not flawlessly working but the support is improved
>> (somewhat working vs not working at all).
> 
> If "still not flawlessly working" maybe required deeper investigate issue
> and submit "flawlessly working" patch.
> 

I would love to honestly. But no documentation and the vendor kernel 
works differently but not better. I get the point, not sure I'll be able 
to provide any meaningful improvement to this patch though. Let's see if 
I'll have time to dig into this sometime soon (I expect not :/).

I'm all ears if someone wants to share how they would start debugging 
this though.

Cheers,
Quentin
