Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7B700259
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjELINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjELINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:13:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461E1704;
        Fri, 12 May 2023 01:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIFkiAKMSskqrTthTHMBkq4z7NyaNPESN6p4QroXo0xOoQWzi2EzJVaHXNStwFPSRZtg/AMs8LtF0XL4kYnsI+Pwd6XyQpg+/UYSDh6nHPWHXf/auBO4l6ljsdyT5fariLdgsiS0StyE/HJBrYgyZqcKNLJk887KcQiGPO/4+M7xypzY5T61Y0SZeGVnoIgyfc8q0ztDZxKhkO5MG+Z613GdJUIAfMiaoTJ9YbYgca8f2ZzBUsiTQ3nsJ14YhOnVPJtmgqpsEBGIvV4iyykueBMG51tC7WPIH5Lq9RCna1wxv0+daWAkuQpB8C1K9uJRJLcQbhzPFEQV/PmEum2VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW5Ssx1Fp3BODDcVmMWQCWd/nono0Wsh7IMBS2rnq7c=;
 b=hXxsdZ224rEru5GT47oiNHIY5UYiEEP0YuHfLDoxFk3elnqQTCCSyr0fg61LWafYsFqwgsaY5q0VmEcu3tQO878ikrMSjzwDamfr8lx8WGm2ZIphqzBJaBDaR69qS8jNIfAsCggSmCVPGdMAustJgAV3TD9VMHvAB8AFmzEotuw3A8thc5dwFoNpl1BfICRXqQdRvoPE9RfYMT6PBBx7Icxrt/FxXNrWayivaV8H4jm9vwOaLiYr3SDLONOp3gjJkQi4wYGympT46MhIyDnw/jWf9e4tEPCHd9NwDgVCiHv+PfeciT0jaFWgiu3fQBWY1gxdYNjQD238aV0UWHRnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW5Ssx1Fp3BODDcVmMWQCWd/nono0Wsh7IMBS2rnq7c=;
 b=2ttAXEzdkBD/tEBu9dvLF13W/nl/VTXZG2DCcu4X0OcATB894ow/3GIf+hhI8yWuPiEjFsuj7tD8HpdDlRGYu/Fs7MD4zCFuUvQmbXWhNh4K+vQVj4M96eBsaDIZyF9qUj9gEhZS1cKWTCWIHoun8WGTd9ekB8AtyCjoHitrShg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB8061.eurprd08.prod.outlook.com (2603:10a6:20b:54a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 08:13:33 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%6]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 08:13:33 +0000
Message-ID: <d95f98f1-8fc1-159e-1d55-83c93695ef19@wolfvision.net>
Date:   Fri, 12 May 2023 10:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
 <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
 <18526d2a-ac5f-2b26-9ed3-5a82f20cac86@wolfvision.net>
 <a7261bc1-902d-99f9-aa3e-2c90dd264c8d@linaro.org>
 <eb3f40e6-a604-39f2-eb49-8b41590a65d4@wolfvision.net>
 <cdcd5656-2c7f-23bf-d016-fff79a279ebb@linaro.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <cdcd5656-2c7f-23bf-d016-fff79a279ebb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9c9a07-1689-4198-ed02-08db52c0c721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTiftn+xo7CuWDiLtHogd51osmlqS4nWBEeOApgJvtZXJXK/a7njnqzyuwhoqGwem1e5i9E3aV0/B0R8ovGZWoWqJzBk2AC1JwDRmeZj89jxeGzR/seHcbwOmiz/PNMsfmyFyTeStgefOZzxxpOsTGB0crdcoVeVJ3nTmTyDFJ3h7dC6PTU+16sWnIl8jVK3SSdJvSvJ0IwmRYU5wxNPc64j9A59gsyYeLAHjxK+bqlofEkSgPA0jRiK3KiK9Jw2z64ZS7D2zu25tHjGLaXUAp5YYosqfz7IoGazlvlYrN2jkm18mRSV9KyaKpTvdpbw7loYy4AdhLyK07jlQcKR3mK0L6HSNhgumB/IvZp0dLKBhWWf1/Z317h57p1ltnKzHxS9sub474yfvkDxvimZ+8hqYTuVSg7Tbyv9xlU0CwJAS0xL129f+qllT5eSIcvSAJV4+KBPNNBHL8qOZo1GYTL+fcHUKiKaNieGHXZ2JdNGYn9DNHN5sq68esR1/m6XvQCsNEeuRb/Vfu1vvS8Oc9lOG1wibhtK9eJvaMcOPLuTrrcNVBp8e5kVQ4+JMMNbohaK7a4kpGm+UbxpUEDqnbRbV3KCIpkuBZkBYeg0TAAIrmdYGq1sbaBEzON6aP2wbTXiuM497sgMb/GhBLpyUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199021)(110136005)(186003)(66476007)(86362001)(478600001)(31686004)(966005)(66556008)(66946007)(41300700001)(316002)(5660300002)(36756003)(8936002)(8676002)(4326008)(6486002)(31696002)(38100700002)(44832011)(7416002)(83380400001)(53546011)(6512007)(2906002)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnFMa3lxZ3ZJMjZTQ3lwbHF6Vy9zWlVTVUd1bTF5dURKMHZYNUdadHM2MmdT?=
 =?utf-8?B?ZmwwdjFIQ2xrckZtajUyTmxuY0VzR1RhTTQydnFVTjJUMFpSejVVNmFTZXM5?=
 =?utf-8?B?UFVCWVBQemI4YnNWZnZucmp5UkY0bkxHOXlzSHNTL3hJS1Y3WnJvY1lYaXQ4?=
 =?utf-8?B?dXM0OFphSkxCTDdmVk80YXRPLzMwUlI0d1IxTjBNRzhZRERmRHlZeFpjS0FX?=
 =?utf-8?B?a3hVYndoNzdTRHlCVWdnekREM28xVDU4eUExVVFwNnVQNEw3UkkxV3ZYUVpY?=
 =?utf-8?B?UENJTUExSU42L3I1SnUvalM1MGU2QWREMmxhZHJZSGRWZTlCT3ovSmJOamxY?=
 =?utf-8?B?UEl6Z05UMG5mTklKL2dHc3ZrRkRpcGx5blR2K2p6LzRVZlQ4b3dkZEpCTCt3?=
 =?utf-8?B?bHNiY2ZrcWpiQ0FoU0pBcnNSZDZFZ1k3MTRvUmdpb3M0VmZ6ZWY2WTBwaitG?=
 =?utf-8?B?M2llN2Q5VmhTdng5VkdIOVFtMS9CWGs5c3dobnFVazFjR2NobTFWa05ISGw2?=
 =?utf-8?B?aGRvOEpxZUJYbURrRjRKWFlwNEVSSVp0NUc0cEt1NXJtZXRKTmYrWWJZTUR5?=
 =?utf-8?B?UzVGa1BET2hhZ1lLcUMrTFp5SWs1Y0NpZEdVa240b2YvbUgxVVNTOXJrNmxL?=
 =?utf-8?B?bUlPV1ZJUWdrWnRZS3VYUXhVSThONS9oOEpSZzlVTHRzSUJqQVRaNnQ1dEcy?=
 =?utf-8?B?bGxzNkM5MXY3eUtvUnVSanZzSWRXa0MzT2k0OE03RFl2d09pTUFhUHdNUith?=
 =?utf-8?B?UjhrU1BBTldINHFYclRmZWNTVXBpVHB3K1dBTGVUWkhPcTc3TlovYUNpOUZY?=
 =?utf-8?B?ODhZTCtQQldtSEJxU01iVG1qSXlqMUkvVnQrbUlEbDFpekQvdzVpcEtPYU5v?=
 =?utf-8?B?QzF2eGtaS255RzdYeXptSkRrRlViUng0Q3lxNFlqRUNkSFAvZzJBVEFEQkxB?=
 =?utf-8?B?OTBadjNRVHE5VWJSQWZyRm5KNTNTbE5vYjdndmZIWFh6c0ZqNGs1ZjI3a2hH?=
 =?utf-8?B?eHBGQzcyME1WeWlZMEFLNmtUK3pMZU03Qm10ajd4MzRjZEpTMytxbFZMRklB?=
 =?utf-8?B?Q2VxakRPZTdMNXFkMXpZUG9BMHlVQmtHaFZtNVBMaUpYWmJMMFFtcGlmK0N4?=
 =?utf-8?B?aUdYZ3l0V3U5bkN3Wm9vKzJ2cjBEWko3cWc1RzU0ZmxTY2dvWjkrS1pqTzIx?=
 =?utf-8?B?U2dOOHoyWHErNEJNNWE5c3A1ZEVmemVvMjhubjlHOTlDWHpYQjFuVnpUMU9P?=
 =?utf-8?B?cnRic3VOc0plNHhQYk56Zld4dzh5c2xCL3FsKzhrdEhZVnpoRWJPYkp4a0VQ?=
 =?utf-8?B?eU5uK1BsUkdvUjZabDJxVWRwQks4N2I3NnYwelNoTU9mSnRoVnpzTmhCbUEx?=
 =?utf-8?B?a285aTV3NitBZXN3K2lHZkt0VWF0Z3dXWDR5Vm5neExCZVJHNEpDOXJIQzdD?=
 =?utf-8?B?bDZYLzdrWXBaQUdCZzZxWEdKb2FjcUlMak1panpheWJyZmxUSlJEZ202ZThP?=
 =?utf-8?B?QWh5THl3R1l0UlZBTmpIdjc5dHlTMkNIQkNYdmt0Q3V6UzdsV3RpUzIrTER5?=
 =?utf-8?B?RVEreWowUmRQQkdVdW5lSDdOVngvM3ZONGpoRU5XNFJoR1ZPQTNoSmdhczFD?=
 =?utf-8?B?aStMVG5RVXduVTU0ZHMwc0NIb0tjUWtCUzNoVGlSWjZORGVHRGJpNkN0bFQy?=
 =?utf-8?B?UGhBTEhub2VnUjZrRjR2eDVqbUVId0dGMFNYb1hCMjhWTVVZMmc1ZC9YZjQ0?=
 =?utf-8?B?ZU1hRHRDNEI4UHpBU2pLa0pGV01aNDZmQkxtRkFHQUZxY1ZjT3JsWC9iRENT?=
 =?utf-8?B?NlFXbmFBakJzZldBYWhQZS9Xc2ZmcVFETGdxYjhYdkdQYW5Ua25HVjl0a0dR?=
 =?utf-8?B?YXNXdnlqL1B1UDlSM0hZNlE4eGp0NWlVck9vcm1ncDQ2dWRjcHRLMTJwSlQ4?=
 =?utf-8?B?bGdwOEVIMlFZckdTVHRkTGlqb2VQcmpnYitjK2VublI1WEU4TWIvd1JnSkox?=
 =?utf-8?B?NUxReTdUbTVEUnMramNianJZL082ZHMwTCtCMXlBNFZZNEl0VnI1eHhmeWFB?=
 =?utf-8?B?Z2RNRHpabXR1K2hhdlNHWS8yMll1VXIzamlIamJodTZ0Zm9aaDNnMmhHbURK?=
 =?utf-8?B?WnRkOE9CWmpEQS9QZTBGSlhjMGJCa211d0ZkSGlzS2hkdVl1VGl4bEx1TldX?=
 =?utf-8?B?NjBDbEtiQWREOXBsQ1RxT29USjBYRmIwcTk5eXpXbkNtb3JzSC9qNFZMN01s?=
 =?utf-8?B?eXlUa1RQSm9UbDlWRnFMN0UzRnJ3PT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9c9a07-1689-4198-ed02-08db52c0c721
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:13:33.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA4pycipZMH5lRLKP9gf76CElunfuqYfuk0Zd5Xl7V+MIY75nZsuDSXxS0GiWH5op9xyJ3ruk5KnVh4PMlDmErf17CUagXAzEujsRcV+hfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8061
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/12/23 09:20, Krzysztof Kozlowski wrote:
> On 12/05/2023 09:08, Michael Riesch wrote:
>> Hi Krzysztof,
>>
>>>> These buttons are actually physical i.e. printed and with a given
>>>> functionality, but still part of the touchscreen as the physical device
>>>> is not aware of them. Therefore they only make sense in the touchscreen
>>>> context.
>>>
>>> So basically you still have the same touchscreen under the buttons and
>>> these are not separate devices. Whether someone put a sticker on
>>> touchscreen, does not really change hardware behavior and it's up to
>>> system to handle this. What you are trying to do here is to create
>>> virtual buttons through Devicetree and DT is not for that.
>>
>> I have already addressed a similar statement here:
>> https://lore.kernel.org/lkml/20230504042927.GA1129520@quokka/t/#m1a93595c36535312df0061459a1da5e062de6c44
>> but let me extend this comment a bit.
>>
>> The notion of "someone putting a sticker on touchscreen" does not really
>> reflect the use case we have in mind. We are talking about devices that
>> are shipped from the factory in a particular configuration, e.g.,
>>
>> +-----------------------+---------+
>> |                       |  power  |
>> |                       |  button |
>> |   touchscreen         +---------+
>> |   (behind: display)   |  return |
>> |                       |  button |
>> +-----------------------+---------+
>>
>> Here, the real touchscreen is larger than the display. The display is
>> behind the "touchscreen" part. Behind the buttons there are symbols
>> engraved in metal or printed foils or what not. I just would like to
>> make it clear that these symbols are not going to change.
>>
>> We believe that the engraved or printed symbols actually define the
>> (expected) hardware behavior. Of course there is a virtual notion to
>> that, and of course it would be possible to let the power button work as
>> return button and vice versa in software. However, the user sees the
>> engraved or printed symbols (which are not going to change) and expects
>> the device to react appropriately.
> 
> OK, I actually missed the concept that display is not equal to the
> touchscreen ("screen" actually suggests display :) ). In your case here
> it sounds good, but please put some parts of this description into this
> common binding. The sketch above is nice, especially if you can point
> where the virtual origin x/y are. Picture is thousands words.

I think this can be arranged :-)

>> Now if you suggest that the system (that is user space, right?) should
>> handle this, then the question would be which component is supposed to
>> handle the touchscreen events and react accordingly. I don't have an
>> answer to that and hope I don't need to find one. But independent of
>> that, a configuration file is required that defines the area of the
>> virtual buttons etc. Wouldn't this be similar to the (mostly) beloved
>> xorg.conf containing the definitions of input devices?
> 
> If the case was a bit different - e.g. display is everywhere - I could
> easily imagine that on the device rotation you want to move
> (re-position) the buttons. Or if user has some accessibility option
> enabled, you want bigger buttons. Then it would be a prove that it must
> be configured and managed from user-space. How, I don't know.

I fully agree here. If user space is able to draw the symbols, then
naturally it is also responsible for handling the events appropriately.
This could happen in an application with a GUI or on display
manager/compositor level (e.g., weston controller or similar).

But I take it that for the situation sketched above the device tree
approach is the correct one. Documentation should be improved, though.

Best regards,
Michael
