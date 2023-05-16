Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5705D704869
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjEPJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEPJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:03:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FEB8;
        Tue, 16 May 2023 02:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZdmS+T1xfu9/b3ZhuNVHpk3d2Lm9qG9HZyisU4Oby5idO6SFXruFL3h3q737DieyK7alXKET+ARWOvi9dyg55D8VAlFUVlyy3PKUNBux52LyO4TPlYqQTPBud40nspW7iIGWu5ePnvixlag8pmQSOrJQDJwmzmazeBSMwVggK+xonhOEfIoWcFf5AQQI4unepQI5OXXyPryCoYYfEK8+ZRttFMDmku0FZQJj8VFFcE0jzQ/173mPJfKdCjRnIgnYQNIq3FsTM8wRSSqb/WLEXu6NRLwmyjnUXNvP3db8VmR5jFyQLgq/WvByF6zYZBq5SkEXXP813HxRb5dxEePeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wIJpFrZSETBWEZsAhMVtGZXcdH18aPeh28s4mnh+b8=;
 b=QLV3Sc8R9SQ/uV8cz1OFH3UxLTb/dIVibYTWPFrZjtZ+cD2aSur/14sVOql/8ztpOCJHYZaeBlzmzmrjmynoEt2BJvX/z36+e9meMEWjKCBj8EujeL26i5jC/n8ZSYTzL4BByxkuanph/Y/NcO4Wu/SjYPhiAx0tv99b6qK8LDiFlYT8QuBoWTNZukzzV33GRPNbYXTiaCqzQe/o8vUsetK+pFGsgUInvRcBBJpPDvAXK3wRUNKCuT1CtbJJqJAjpmh8LrZVbTsXztgWJZE5NDJ9kq3JfyHO729LVI7/55tI/ezvvdlDPNxqsmv6RymPS7xEteIU5ueunLzSuqT8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wIJpFrZSETBWEZsAhMVtGZXcdH18aPeh28s4mnh+b8=;
 b=0mN2hffUFnQ6KAiHDAbURSidQU3yiGdkPyJWH5LxmmX9qXaoVd6qEO3exJZGYbEmGReASz//coahcUCfr4agUjAgdXhQhH3xs0uHncI+JbuHOMyTnGfV4BsagIuiIiiW1XlziGHcSilRHzVUFqi1Q+9I2ZqUquRfMaoEWawyiEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS1PR08MB7636.eurprd08.prod.outlook.com (2603:10a6:20b:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:03:51 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 09:03:50 +0000
Message-ID: <d32e46aa-af50-ad60-7679-5c235487039e@wolfvision.net>
Date:   Tue, 16 May 2023 11:03:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] dt-bindings: touchscreen: add virtual-touchscreen
 and virtual-buttons properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
 <58c8b822-8b47-3269-3b78-334b53c20bff@linaro.org>
 <99e39fb6-26e0-eb9a-3c07-e07d1fa4122c@linaro.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <99e39fb6-26e0-eb9a-3c07-e07d1fa4122c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0142.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS1PR08MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b83990b-89dc-43a1-94f0-08db55ec7719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FD8Faar5JSv9GF2qecyL5nWHB3pqBXiAvy8chQFg7V7oekIhfxZtRKd3xFNG8NGfxAlaHyuw8d8fPh9Pmc8Z7muFzWbqNfB0cLrgCemwzeUr77Wyo1Ljf4V9KGbQ5y7SOKT34c5c1c1nhInjmerssxL8W/gorUWjlNbjaPKhvSJksR88YG4add4/NPy4xjmHr9SeMBL+ufabVGw5xsRekAXUFpypv63sV19mUoRXvFU5tUnpv7UQMVMa8IMKTtXKG8yTvy5rqWczOJ0fHCy8Ojq0iXHtYB6o1GoMG04gu7OW9VQyqTHmhzvsTbys/KW0BabM+Fkms5mcyek/3vIZPE3w4eQbSfZEdo/fIjn2g/R2dofrzYjwkSgAtKCS1q87a7L91X1+wwfGiMf73StC1ZwVBa/RqlYzQKMPn9Za+WBLW96YAg/9yd7vcQqkbdRqi7wN8yq9T6OPjL7/ZstcAGU+iWBgbGyfhnVtkGE70NPBqf5ysAnGTAU0UBQw0ri8VTbeBeaaB8XqaEKIBhlBiz13/KVqVcY27LU1aZSgWESbv1AZ5+VK96QLcPFUY3dJIaS4+wqoxpCcPZrp7IM6HJDgHXmp+P8e2+Li5gay/ngzWyZrdIvjoCSnTjsJG0/bkEuj0TYB5UeymNncMvOpHPl5ic0oF7PKaizPWiXz1++C5kaOBwZUqNTiDWLjhhweCEMRTkv6PvboimPSM4RvLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(451199021)(31686004)(4326008)(6636002)(66556008)(66476007)(66946007)(478600001)(86362001)(316002)(110136005)(6486002)(36756003)(83380400001)(6506007)(186003)(26005)(6512007)(53546011)(2616005)(7416002)(5660300002)(8676002)(44832011)(41300700001)(8936002)(2906002)(38100700002)(31696002)(34154003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZUOC9KTDByT0ZoQjFvUGx3OXFyOXdTWXhZNFFINldpdlI3YlVOOGRlSkxw?=
 =?utf-8?B?N295SUdtMGF1RkZ2SlZWQm02cUU0UDh6UHJsaWNTbXNQOG9VK3R3bVZVYksv?=
 =?utf-8?B?TU5KZzdML2pnelJIcFdLWm5SR3J5aVBQdFJFMjdFZGgwZkZaQUR5WnRrejFw?=
 =?utf-8?B?UzlSSk5MY3ZuN3ZWb3BsNGEwa0l0ZjByeU1JL2NacE92dVNBQW5lblJIYlYx?=
 =?utf-8?B?d2pzMDhWRUtKZXlXcnYzMUFwanZXM2Nhc3ZTUmxrbVVsdGJZMm8zN01udWl6?=
 =?utf-8?B?S04yaUpqMCtTR0RveUI0aTRCZW1OaUJqUVREWjk5Q1dYamc5OVk1UjVYNFFX?=
 =?utf-8?B?M1VlTHlQQ0c1cjJYdUdNeSsrMi81SWlwL3hCb2xjQi9BcjdrZGNidDJGYUJa?=
 =?utf-8?B?Y2FoOExiOW1idXFJdFdKdyswZWdZWWxlSkhzb3BJb1E4VHBBRmlvejdOUEtS?=
 =?utf-8?B?OFlUSWdzUm5xQXVjYzhSakIzOE0wWmozWndGT1VwWEZZRTFselFvbUNjOFA0?=
 =?utf-8?B?MkwzeDVSM2ZiMzh2U2NwVzUxNzdHZE1QNGh5Mlk4bnhsbGhNS1JaWnVtUVN4?=
 =?utf-8?B?dUpHdU9qTUpDYmkzbEIvTjJhV1REMDhBbnh2Qkh1TUFvYVBPWWlFWWh1RWpQ?=
 =?utf-8?B?bVJKMjB2TnZ3bjNNVEo1andBVjJaTGFlaHJuT3V2cjcxZ05kLytvR0JOY0dS?=
 =?utf-8?B?T0lkVjRML3JBNnJsSGY4Uk9PQTJ0UzA2aDgxUitvYUxLMFFQNGN5SFdQWmh3?=
 =?utf-8?B?enRrTnVkbSsycHJyRWY5UnRuajg5T245YVI4aG9WdHMyWHBhOXJXU1FhS2Vo?=
 =?utf-8?B?Wkd6R3BRcDdadysvY0pCR0Jhc2dVbTJEYncrMmZmbkxIZEgrOURYR3hmd3Q3?=
 =?utf-8?B?MEQzYWRQVTlyeS95K21IVXg3SXcwOHdqTFBZakJ6UElNckV2VHBraGpyM3V2?=
 =?utf-8?B?U0tCMGRDQjBoNUxtTThkVVlXeGNQTEFwVUVoajVWbVNGam5KejZoRURqSk9m?=
 =?utf-8?B?Z0N6R0VDekhpQ3d5eU81OWMrTmNSZGV0RXNkRDRsaGlOU3hpM0REdy9lc2lB?=
 =?utf-8?B?amFKeXVJeXhVb3A4RzY1SnRrNWxMYlpEeEhKQi8rTk9pYWxtQ1JSTzRqWmNw?=
 =?utf-8?B?VUJHTG9OT2lTTHkrYUxya1RvZnBkektaZ3o3L0l6WmdjUGF5bjRRUXpSbmx5?=
 =?utf-8?B?aHZLNG82SzhDb3FXdDBSQWZqQUhGTTZjVUR4d1Zzb0FZWWx1b0VQQXdybG1F?=
 =?utf-8?B?ZVUrQWtTK29EczhFd1c3T2MwVlloTjFJSkgwVGRSKzZjUUIrLzJRRXgrM25C?=
 =?utf-8?B?MHhESHZBWkk5YXN2UmQyS1EwQWtVcnBHN0kzVUlNQjg3Nkx4UXZUQlJSQzNF?=
 =?utf-8?B?eTFaU0Y5K0lNMEp3UHAzSVorTG0ySGQzY1oybElhZ0tXY2xXeTZsRGpqWXBw?=
 =?utf-8?B?QzU3b0pIT2Q2SkFzSGFWQnNBU1dkMGhCUmVydW5vVURobWZsclh2eGtDZVd6?=
 =?utf-8?B?Mm9UZExOb1NramNoRFZ3NjYzQ1RtSmpvdWlRbGl2TE5zbDB1c2J3eFZwZEFh?=
 =?utf-8?B?V0pJRmpFeC9xVy80Wm5yTiswQmlTY0UwdGs0L0xiMVRjZWc4SGFscklmblNq?=
 =?utf-8?B?ZUFvMTByZ1J1alJlZlVTbzkvODBVeW1ZS2pha21SUVJYUnFyRm5QcVRUMUI5?=
 =?utf-8?B?Qm9kZ250SzY1NGYwM0NVanBKUktxZ2dqU3JLMXk3Z2kvRWZWeE5sc2NZMTAz?=
 =?utf-8?B?QVlwRzZlOHZ0M0FvRE5vMVRaRncxZUMxRmFJTFFCU2dyRHhKTHZ3bjN1Nk84?=
 =?utf-8?B?VExXYTVUbGxISTZ4NlFtbnl1VFFVNEVwbXppUkU2T0ZqVWdYNVpnN0FWRUdZ?=
 =?utf-8?B?QmlJVElqS2Q2aTRxZW1EL0xnREp4THlDc2dGVm5ETHRGUmo4SGxpb1lIcVBP?=
 =?utf-8?B?ZGNMV0pmaUlHT2pKdjBpVVZsUkU4bldVMmNlUFkzWW1TTGFZY1FWejVJNmJJ?=
 =?utf-8?B?Z3JrNWw5MlVWeFdGam5sSURaeTN5MEVJbk9tL3c0cjZLYlVnTGxyS1RkZTRX?=
 =?utf-8?B?dHU5VG5ac2xXZXl6M2FEYUt4aG9MOWNjbm5zTWlWcEhKOVRjN3RKekF2U29D?=
 =?utf-8?B?NzgrM1pQQ1F6cDQySWdiTG1zN2o0ZWJ0cEsxbW5CU3RqUkhFMkZtQitmWjBY?=
 =?utf-8?Q?7hbd1nJUm5E3Ov/S9mPTJrg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b83990b-89dc-43a1-94f0-08db55ec7719
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:03:50.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHqjSDEVd1od108dsLK5BmztUvbzIB0/w2wuRu2mDDu7KBc9GI71DPvoSa0q8k8srousUw48eWZ4JrrqE278dR3BKtd9YAVCLjyK6d4eZy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7636
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 10:13, Krzysztof Kozlowski wrote:
> On 16/05/2023 10:10, Krzysztof Kozlowski wrote:
>> On 15/05/2023 17:00, Javier Carrasco wrote:
>>> The virtual-touchscreen object defines an area within the touchscreen
>>> where touch events are reported and their coordinates get converted to
>>> the virtual origin. This object avoids getting events from areas that
>>> are physically hidden by overlay frames.
>>>
>>> For touchscreens where overlay buttons on the touchscreen surface are
>>> provided, the virtual-buttons object contains a node for every button
>>> and the key event that should be reported when pressed.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>>> ---
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Apologies, second thoughts - why calling all this binding and properties
> "virtual"? That's the word which immediately raises questions, because
> bindings are only for real things, not virtual.
> 
> Touchscreen is just clipped, not virtual, so maybe "clipped-area"
> instead of virtual-touchscreen? Buttons are real, so maybe just "buttons"?
> 
> Best regards,
> Krzysztof
> 
I guess it is a matter of perspective. For a user the buttons and the
clipped area are 100% real, but for a driver developer they are virtual
in the sense that there is not an "active" hardware behind apart from
the original touchscreen.

I just wanted to avoid misunderstandings when implementing this feature
for other drivers. One might wonder if the touchscreen now has
mechanical keys attached to it. With the "virtual-" prefix it is clear
that the objects are not additional pieces of hardware or extensions of
the touchscreen functionality.

For the virtual-touchscreen your point is stronger because there is
indeed a real touchscreen hardware no matter the area you define, but my
approach was keeping homogeneous names for the different objects in case
some new ones might appear in the future: every object that gets on top
of the touchscreen area is virtual, so add a new object type and name it
virtual-xxx.

I have nothing against about doing some renaming and I will do it if it
is required, but with the documentation I think it is now more clear
what everything means and in the end it might make more sense for the
drivers so they can differentiate between real and virtual devices.
