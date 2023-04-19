Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9266E7890
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjDSLZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjDSLZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:25:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E648FE66;
        Wed, 19 Apr 2023 04:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfEdWWJjtOXOts3BFXPNx+VtnV2bGcL0H5kLWnVYV5tbcWHIy9pB9n1o2mswgAMtifpF6z4GOdKIUBLRschZvIo7oZcQ5q4t0suW2mb5KdykQ2tdh+PIp77tAD/8C0Rbk4dGoPAD9mdr1bAfStr21N12Gf4vWLAnctU6/91jluIjNKc54s90MfoKCzzI/43aZOdK7IRXVZzHoldvv6fsEfEeGWsEG9aDlXwjwj9BW0IEdJKBqE5wjzMlmyoORdi9p+rhNSU+7u2qC02ClypUe3ctvWNlFvU54aazFcpKg/Fol9sfxhid/ogwa38Nfd24bLPgjrjkrp/wmvby5kwf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqGQ28GhXp86LpWccVJ/t3TOTQwgHc8zZMVSYaSj8EA=;
 b=CSw0cVhlv7rcR0PGDq8B7Rq7y8Ch4JtEqUsrNn3r3FoDEAeO6xQQyLL/tOaVl4tvWUwg4Fzo+huEvPLYzyl7E7E+fqTX3B2ueI2Wx2HJFyTjM0Gu2e10YEnUImTiABuRi25f78UvbGSNSGTMBTAEKNfdLN0vqJ4GaOnhSabPk7j/AaF7wjvL1e4UwiJ9ow/LYcOnhcpt+7xZ0XNHYNlhZK5c2WuxDPp1ydDFsfH/epmSyZCr76uaIEd1fSNgIEG0EgpH8nNkBJIl2UafbSWuCmJivZ5NbGbxp6lnbC9fJ3y6/eGl8u+tOmsyzSlil+/sU7d1Dl3rN8FvInratwykhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqGQ28GhXp86LpWccVJ/t3TOTQwgHc8zZMVSYaSj8EA=;
 b=cNYZcjfzkbByEzxiP8sxmbvN3oga+YQnOkUIkAlHQuDd0Jd4iKbMYgeqBEsObFB/48QoSyr2YXpbP2Q7qVCmPlVY+FV8JboMlSY5LueJte+SQM8KDEu6uU+0uYPNE7c0EDm50VXv9/vWpvnpz5NGrsgybniXZyMLCnSRsigJQio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB10225.eurprd08.prod.outlook.com (2603:10a6:20b:64e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 11:25:00 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 11:25:00 +0000
Message-ID: <45fea085-54c3-157e-6459-adaaf1edebf5@wolfvision.net>
Date:   Wed, 19 Apr 2023 13:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Brotzge <Alexander.Brotzge@wolfvision.net>,
        Dieter Mathis <Dieter.Mathis@wolfvision.net>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
 <ZDbKU5kwcb7RGeCo@kekkonen.localdomain>
 <ccae3994-3b1b-4050-ea34-98f97cf886e0@wolfvision.net>
 <ZD+t5QYH20Y8+8MV@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZD+t5QYH20Y8+8MV@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: b162616f-1a95-450b-b1cd-08db40c8b692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfugEc0Umo3bAKwVdUBFXLEvYouQhM0UYTDpFaKvieAxBCjvDcMQLoFC2kYFKve4Q1cfcjofBMB93GOjLV5iRUJCF6Mg3jgizQTtFNx1qcyI+RC4ZWQIr+C492gqtXEcgJo5QBzj+N4RVXZNzLig/xPuyGAyGsI9PvQ9YKZqSwJRHLlHomct1fh3uk88yoFLv4RLmbl76rDbGW3Xr8oYfi+beeVNm37SREMDP4KTaxtdE4MQ8yj+GUgE7NCjVZNTjZwDpBJbkXQIBtHv4qo+MzQwLBh9C/2FmjFz7CWIHGSinl34hHKmAGm0YhCoUC+TShiIZeZNrAiW7PaFD7h5pNOTF+Z/6/VUXdGWjVfssad8rzIkgmVlxxtbCsskTyMrFHDbysk3gflMVxkfQpPpDq6iIEcFCoCm9XntN7l5K/mq4NrtzVxTzBdqEeItj5bcGfrSwaXXgDcCJyGGlF8u6PuKjaRfLaKorPJZKgRN7KnB4upserZjhF8LC/rg8w3DYuqFz65x3IEKGk3zQWgaC2XSn1lLBkFWNgG3iDWSReuDxhsb4uLa6uHuk4KWTRsV+E+yzwVFyGi9VLoAyKMA8WuAMJYMPcUZfPTWMeEJjItWp8wj51C2kPIRbShuzqtp+YR95LJux8azU37h6nkoZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(451199021)(5660300002)(44832011)(8936002)(8676002)(2906002)(36756003)(38100700002)(31686004)(36916002)(6486002)(107886003)(6512007)(6506007)(478600001)(31696002)(53546011)(54906003)(186003)(26005)(2616005)(41300700001)(66946007)(6916009)(66556008)(66476007)(316002)(86362001)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVvODFpbDd5STZUUTdMdU1JSmEyMmxKL0hmOGh4ZFVxWEE1T094OUtCYUdn?=
 =?utf-8?B?MlY4bm1VM3diQ3laR05lL04wWDJPTUx5dEdJRnE5Tmx4emJsOGc2blRBQmIx?=
 =?utf-8?B?SlVzUTg4akhXY0VFUnZmQ3ZvVFptMk82TFNFeDlBKzBvMGVDZm8zTnI1TlVN?=
 =?utf-8?B?TUdnTXZ5dE9SY1puWlhUK3FxVk5uUmVSZEN5MXJhNC9YRWpYM3ZKNDFxdmZm?=
 =?utf-8?B?M3RuRTJ3MDE0MUV2WEhMNHZneDBMVGZheGRKL3RUKytYZXFVd3VDRUtRZEdp?=
 =?utf-8?B?a0hxNkxieGpWbm84WXF4V1NLakx5VW9RcTREY0RyWTV3WVJtL05Ra0ZNMENM?=
 =?utf-8?B?WXNHWlNlS2FGYXIvWmgyVFJwMUJzYm1hZy9USjZJc2hyazUxTXhRMnpFVkZz?=
 =?utf-8?B?Zkk2eDQ2UEVacjVsSFR5RVpVcGUvQ0prTHZzeEh6akJ4MXN6WkY4YmNMTFBn?=
 =?utf-8?B?M0ZXMDRJMWd2ODF0aDZTTEVncWFoSWdEL0RCWVhES3VhbTlEd1lIMU5mNEhF?=
 =?utf-8?B?cTBtQjJ5d1UyWnFkVVgzd1JlTFJrdFZXbEtoVm1pMVBPRVNWNldqVHZXcDhS?=
 =?utf-8?B?ejIzYUdmUEU2ZXVzVW1BTXYyaTJpTXFJU1RJY1QvOGRBZWs3MG43U2d6ZlAr?=
 =?utf-8?B?Z21RZDJRK2xURUMyL0tzb2dpTGxwWk92cVZBajZMVlVsemhmQXBRUzBDSHU5?=
 =?utf-8?B?NFhZN3VVTGY4T0c5NUllUHpUK2lwbktsQzl5Q1NiQUVHWlJMWHJjNVZZdG9J?=
 =?utf-8?B?cjFWRGxsWDhwUmlDcENWblpGTmZMTE5JTTdRek9rcjZIZFZ0Qk5SY3dhMWFv?=
 =?utf-8?B?NnBsWlROY05iczFtd2xpbWdSMktWODFqUElqM2gxYVRxS1d1UUN0QklLc0Fs?=
 =?utf-8?B?ZTRzTmxYWEFhVmg4d0RxcVBhejk3SWJjMVFyUnBrdTdqY2t0TEtFNCt3T2Vn?=
 =?utf-8?B?ck41d1ZpTFZhdzcvYzNVMStPcXpHdXVsUjRiTG15a3V3czR1REJ6VSs5LzFq?=
 =?utf-8?B?anNzZEhCY0FCVXRGVHVzeTAzUmM0clo0Sm9Hd1Q0aGNQR0dKU1M0bkoxRW5K?=
 =?utf-8?B?RlhBOStTTDNBUS9ZcHpwTXQ0Qm83dzE1S1c0NHA3TnVzNXhzbTJMZnFteTNJ?=
 =?utf-8?B?blF5dXVxRGJBS0t4N2NhQVFYK2NmSlRlbC9aaHptMW53eVp2TDMrWVpnMzZU?=
 =?utf-8?B?Nnd6YzNwcENJUk8yb081L205Y044TFZJVUN2bHZaK0MxUlE0UUE2NWZBM2hu?=
 =?utf-8?B?R2RSaXBsS0daMHNkVERIM2F2eTg4enlTWWJvU0pDRCtLWDhPbllLZ3J0Um5q?=
 =?utf-8?B?dlJBczludjNMd3VDUkRtdVYrVUx1RnVqOXZjdWlML0hvR0JCMkhkV09lY3lW?=
 =?utf-8?B?aENQNi9nN082Rys5cWdiay84WW11am1GODErSEx5VzJkTzBta2hrVFlCTzd4?=
 =?utf-8?B?NmhKUm5IMExMa2Q3aFBRWmNSK0VPZ0xnb3NWVHVGdU5vZDFqTWFMZTV2a3k0?=
 =?utf-8?B?QnpNcEVyb2gxVTd4ZjFRa3N2K1NOTEJKUzJUbnFSZG11WE9XY0c2VDQyVEJ1?=
 =?utf-8?B?WlppUXMrckk4ZUhBNFZyeUNVU21NeFJRL1loMDJ1VFpQR2FNYXZZSlZNeUc0?=
 =?utf-8?B?VnYrVXZnZENzL0s1aDNBNXdrdUlZbU9UaHZGVHFjVnRaTm1XNE05Rm5HUkdm?=
 =?utf-8?B?bjhHZm1sdjJaUExxL013TTZiMk9ZMnRjMGpMVTZXd0tFN1Rrc1NzT1RhY1RE?=
 =?utf-8?B?RHdHT1hUbGk1aG9wL0dyTlRQZm9CQ2hTbWR4ZHg2b2dpUzlVakhEek1ZUjZD?=
 =?utf-8?B?YUczYjhpb2V2S1cremQ0UXhwU3hlTGRpY0gvVFl3ZFNPK292V21FczM5N3FV?=
 =?utf-8?B?cFVVdjZrTzc0eFBid2RQL1ltMjZvVmg5RTVkaldQVndldDR5WUxtR3pHeWtl?=
 =?utf-8?B?bHl0OFI5Y3Z3U2hSSDVIK0o1bkRiTFd4SWVzczVtdkVwWU9pN2ltblVPdHVj?=
 =?utf-8?B?SWc3bXpUNHNSc2w5NnMvL0ZJUXNkMDFVUlpDdlFyZmlJQ2hUTWdiSzNZRHQ1?=
 =?utf-8?B?TTR0S3FuZU51SWJCWTJZZ2MvK1pjL1JTam5kOWhsRW9OU043c0phNkRmNzgy?=
 =?utf-8?B?V3Q0WEVCZVR2eTJ5SXh2NzU5Z28xdHIvVHNyOGdRaW5wL3E2aXFJbFdJd3F0?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b162616f-1a95-450b-b1cd-08db40c8b692
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 11:25:00.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FmzuprboSnWWMs2sWKMpYWBhglPg7q3WmEjcs9dOSdG2SvYrtc7EP8delyH7ra+SFTbOpYr4u8sjpXPqRHd9vX+Ntp/Rb9Vp/8nVSSbitc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10225
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/19/23 11:01, Sakari Ailus wrote:
> Hi Michael,
> 
> On Mon, Apr 17, 2023 at 02:38:20PM +0200, Michael Riesch wrote:
>> Hi Sakari,
>>
>> On 4/12/23 17:12, Sakari Ailus wrote:
>>> Hi Dave, Michael,
>>>
>>> On Wed, Apr 12, 2023 at 02:55:56PM +0100, Dave Stevenson wrote:
>>>>>> If the ranges aren't updated, where should that out-of-range lens
>>>>>> movement leave the lens?
>>>>>
>>>>> This is up to the hardware controller, but I would guess it typically
>>>>> stops one step before disaster. Wherever that may be, the error
>>>>> condition and the current position can be read out via this new STATUS
>>>>> control.
>>>>>
>>>>> Does this sound good so far?
>>>>
>>>> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
>>>> Laurent), and I'm just expressing my views based on the lenses I've
>>>> encountered.
>>>> All of my lenses have a single drive for focus, a single drive for
>>>> zoom, and where there are multiple elements they are all connected
>>>> mechanically. Your setup sounds far more complex and is likely to need
>>>> a more extensive driver, but it'd be nice to not unnecessarily
>>>> overcomplicate the interface.
>>>
>>> Could we also have a driver that uses these new controls?
>>
>> If you are referring to the driver for our custom lens controller, then
>> I have to say that it is under development and simply not ready for
>> release yet. Also, the decision has not yet been made whether or not
>> this will be an open-source driver.
>>
>> A different approach could be the adaptation of the vimc-lens driver,
>> which currently only supports FOCUS_ABSOLUTE. But this would raise
>> several implementation questions and at least for me this would be a
>> nontrivial task.
>>
>> Is it required to have a driver for this interface (in the sense that
>> the patches cannot be accepted otherwise)?
> 
> That has been traditionally required, and a virtual driver isn't usually
> considered enough. There are at least two reasons for this. The first one
> being that if the driver isn't reviewable and targetting upstream it may be
> difficult to figure out whether the interface changes are the right ones
> for that driver. This is perhaps a lesser concern here. Secondly, there is
> also unwillingness to add interface elements that might never be supported
> by the kernel itself --- this is effectively just dead code.
> 
> Also cc Hans and Laurent.

I understand your concerns. Cc: Alexander and Dieter

We aim to be an open-source friendly company. If you are OK with us
submitting a driver that targets very custom hardware that is only
available in integrated form in our products (and not, for instance,
available for sale as a standalone device), then we are prepared to
submit the driver sources for consideration for inclusion in mainline
Linux. Would this be acceptable?

As I already stated above, it will take us some time to prepare
everything in a form that is suitable for submission. Now should I
submit the next iteration(s) of the series at hand as RFC or as regular
patch series?

>>> The controls themselves appear reasonable to me as well. I guess there are
>>> changes to be made based on the discussion?
>>
>> I'd summarize that whether or not the status controls are compound
>> controls of the type V4L2_CTRL_TYPE_LENS_STATUS is the open question.
>>
>> As a potential follow-up question I recently asked myself if the struct
>> v4l2_ctrl_lens_status should contain trailing reserved bytes for future
>> extension (no idea, though, what this could be).
>>
>> Alternatively, we could come up with "V4L2_CID_FOCUS_CURRENT (integer)"
>> for the current position and "V4L2_CID_FOCUS_STATUS (bitmask)" (and add
>> further controls when they are needed. Here, we lose atomicity but maybe
>> this can be ignored. One could assume that all relevant controls are
>> read out with a single ioctl which provides at least some level of
>> atomicity.
> 
> There might be something that could be done in the control framework to
> address this. But it's not something that can be expected to happen soon.
> 
> I'd perhaps keep them separate, not to make it a compound control just for
> the access reason. But I certainly don't have a strong opinion about it.

After some further considerations, and following Dave's and your
comments, I'll keep them separate.

Discussion to be continued with v2.

Best regards,
Michael

> 
>>
>> Any comments and/or recommendations to this open question would be much
>> appreciated.
>>
>> Other review comments will be incorporated in the next iteration of this
>> series as well, but they are quite straightforward.
> 
