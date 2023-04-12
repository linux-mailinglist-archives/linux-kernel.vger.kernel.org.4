Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1501F6DF788
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDLNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDLNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:43:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14CB5;
        Wed, 12 Apr 2023 06:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1W7d2VZXfMyWbaL+QpXDn0fnSFyIi1lgcuu1o5wnCDz4+y6sDKlNJEGZGviztQaSoP6fUdAcWGheNK+2dLDDJrTwYakZeoc+77R5w/olTjX5bHNy5DoXvb1YISS+I5if7h9/F+z313lQ5RSWztvB9QZ3hFs62XFA69bpItCLzQTcZUYurlMVOtQKeXnGH9MSrGR02VW7Ii+AqNA4YZDZrbfKYtjdD9iCgOngpTVaV2x52r+mFJoQxxYMp/myeJwIFV5x5ZxXhv0Adgtjr8kPHUzPsUVlp2XP7rVKgSoew2HY5UucDn0ngSLpOzTkK+9g6DDZ3Sys3Evm4ssS506AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZm0lkw6e+YNwYph5V8s63DooepVU7rJOtqyrjT4wGM=;
 b=aj5QNpUalpOEbpKjDqYd894Xs4ubbDJndJ1+Tgdgf06qUXFe3lubphCUndHC3lKc4bA7TrH2oNumrQkld0ElCeT4ABmo5yjB9A8e1SbDQxOoMahqF2/DZi5osomYiuB1cLv4hPXYM8YucgHaOK/D8T7quCe5MhnUlEoN6P1KT98PyyFSks35oz9pszCzOL0galDlC5gY2LQfigu4utW/rSh5TOJTZtEv/1aNPKnZHN8oE7rmoJKQY/4+bqxaG1ZvbOyfHNRc36azGmukAznIPVqMeLBtb7UHO3ICCO6qxm68GO69kcE2QqnjbyFCYEUCCXFkds4xGgFHt0aHbxFymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZm0lkw6e+YNwYph5V8s63DooepVU7rJOtqyrjT4wGM=;
 b=EIWhOO1CQJb1/GYBzWItsvu9UrMBjwYpe8yegdNBBMYnTPTG8GFz2HprtaZGiv00FFeamHguG2zbcukbtRFsTFXtAEb0sADUgFKhtpnU4rhI7YxdNDxgmqhuuAsxLJLpCwTHClx1GuBWpSYxFFQRJmwKj5sJocR9suyDmtjeVFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB4PR08MB9288.eurprd08.prod.outlook.com (2603:10a6:10:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:43:29 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:43:29 +0000
Message-ID: <77d91964-de0a-8bd4-12d9-bc16110cfa7c@wolfvision.net>
Date:   Wed, 12 Apr 2023 15:43:26 +0200
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
        hverkuil@xs4all.nl
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
 <8fe5c9c5-6eb0-86ae-9e5d-fbaa72be25fe@wolfvision.net>
 <ZDaemghP0HQSw3Fo@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZDaemghP0HQSw3Fo@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0401CA0024.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::34) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB4PR08MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c83fa3-8ab2-46fe-8462-08db3b5be629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkf5Xbc0LbCltnbTamdEBwSpg93mOE4fwHcn+8QeYnE1E6+y/tHc4nbDwTXdSKYe0rIUtM9z8xogV9D4UgVfTrx7O4EQpdmSJncL0OWMTALmGU8CJNnSKJiW8sTj7LTfTANOTwGAHgS+wbg9VEVoyjcpSTE/1NB0EPl+8HOjxZZSwzlSoDosx3l78FgtBxktJdgN9QiGj1Sy66+50behC4/X/GdxKYVKl+j8EfdIMLDQir0Mj0I6wJvNAmXtpc1MeiLv5DnwPODyEcm0rW/yvPY3EC1fE4WSTo5iBIU+gECRlFavUmOlBygwGW54xj1pp3hq38nNta0jVGrMLSR7eJP2RBu+VimiWLMVXJaIK7F/avuKMYU+QF3rVJA0+rD8q4oHzVmdK3vMmB6HkyXTf6U20JXk3l4kydmIu7kMG2n25uIUosIqbA3qQ1aUqU1gWttLkVxF6eHs4k/EFLdKZVAIc0gOvc1jpNOYbsfmWwUhlKeUHG813cvWtC6acPhRRECyAQmtU80EeY2nj/yM2rV6IWOnzCwhfj571pwF+IWY7Kg1B3uV7vc/CNK8cYK45ztCg58dPw1GTabn7uBGa7tWVo3oEvHznUeZqpfdu2ELGZS+//b1CRMjkB/qXORn3ocQUH4A+D2VwSB2Jg27Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(451199021)(6666004)(8936002)(36916002)(44832011)(6486002)(5660300002)(86362001)(4326008)(31696002)(66556008)(6916009)(53546011)(66476007)(66946007)(8676002)(478600001)(38100700002)(316002)(31686004)(54906003)(2906002)(6506007)(6512007)(2616005)(186003)(41300700001)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRvQTRvQ3lzdzVNT0h2VjRHVHZ0WVo0M25aZ1JUOEdnNHpRaUJiNG41TWla?=
 =?utf-8?B?blZFVmRqK01vc3lkVGFuNWYxMFZoenpPTTBSTVlRa0ZHM0dsTVdmdVo2bmlD?=
 =?utf-8?B?N0pEQ21KVm9QOGV3ckM3b0srWEs2UVJtM1hkTERLSkltVlRCTW1YSC9FZEwz?=
 =?utf-8?B?VnpmZlZvbEN0aXJ0RjRLdUpqVGk2QzdJSzFnaHNLU2ZHckd5bDJiTFVoSmh1?=
 =?utf-8?B?TGdMQ0ZFSy8xZGUrS1pMYmxkYzVGSS9RQlpXZnY2bUtzcmUwVWE5cXBDM0pW?=
 =?utf-8?B?YTNYQXdMc2xsekd3R2dIMFZiRXRiK0k4bUhZa1U2dFkrblMzekNJSUx5ZzlP?=
 =?utf-8?B?a0szTExYeVBKeEhZajdtRzlSQ0lOQVJadmtITUgrZ09lalk4UzErT0VBb1Er?=
 =?utf-8?B?aUd5K3g1THpZU00ybzh4ZlBSOTAzZ0M5S1RVaG5RRWVxRU9Ia0daMmhraXM1?=
 =?utf-8?B?U1NEdmtjcUdZV3JOckdzOThqUE9RY2pYclE2RUQwTUlNdlVUKzhySWl5Y3RL?=
 =?utf-8?B?MDgyNHkrdElDYmx2QVhYZElGYkF0M3oxMDhXbkxqVk5NUnpmTUNFOG1Jdlgz?=
 =?utf-8?B?TmY0RWFzSjBVTjJPcHNOeG9NYkF4Ym5ndzVuTmZmNVdHMUpkWmlVdjVuZ1Fi?=
 =?utf-8?B?UzVjanFZY1BySnlCS0J1NER4TmxKaGZTU1VuaDVuTFR0LzlIMHF1Z0hZS0tG?=
 =?utf-8?B?WmY1Uk5nc3NJSTdXV1IyRjk5NnE2cjlHeHR3UHZlbUhMRUVZOWY0ajFZeGVs?=
 =?utf-8?B?SnNhS3haQ0hIcnlXdW02Y3FzQ1BRZzNJeFljZEhnSk1NaStVTU1lWVQveFY3?=
 =?utf-8?B?WE8xVlJFVmVUWG15bFB5cTh4VE8zeXl3YnZiK3NXK1dtVTJOOHI1UGVUVkhH?=
 =?utf-8?B?WU12Q3FnVVBkZGtRTWhIWVZxenJpQUtUazVndldIVTFDK3RRWlVoYXZkd3dt?=
 =?utf-8?B?ZXhTNEdnbGgzc2wvdW5INXpUK0t6Q1QwTUJKQnFUQzFHTnFxcmRRREFOZ1Za?=
 =?utf-8?B?bHpOQzlkWDZNcEJjL1lKeWNvakczdlBEQWlLQm9iQW9OdTNLUEsrTzdmTzRw?=
 =?utf-8?B?M0dLSFBnSEtHcUVDTTlDQjdheGhBV3RsbmxvNW5sVmNWdHF2TWFXb0tLUkF3?=
 =?utf-8?B?ZlVQRWhJQTlZemtMZGFSMkxKcHg2QWxSMkl0T1NmOFVPa2RJY3N5RWprVkw1?=
 =?utf-8?B?Q2IwMERKejZjK1I5LzhuVE12L2VZdGhhYWkrYllQc2FvcFVNYVp2eTJ6YWZq?=
 =?utf-8?B?SlRXSytkaVpZOWdZSkR4QlRMSlZkakZtWnhZWjNJM1VTZElyeWFScEgzRUx1?=
 =?utf-8?B?cnFNcVFVM3hoV3RxRkRwdHdaNVNLUUVIS2ZoNzJtTzBxS1FwcHhMSGZ2eksw?=
 =?utf-8?B?KytsMjRTSEh5VTQ5Unhad0lDdnBKK25NOHNwbmZsWDdVRWhVTUJRODdHbVhF?=
 =?utf-8?B?VDJUbFZSeDcyVHcxbHZIQnVNVW4yVUljdEM0TW5Wd3MxWnFlQ1BhZnh6RGw0?=
 =?utf-8?B?L1Z5Wm9kcGdGaVZzeDcwYUtuVUZHejV0VWNRUlYrVkZXN2s2M0ZQd3g4UW5t?=
 =?utf-8?B?USs0Q1F4L0xONEpFWjliMGxZTVkwVmhiclVtbmhzbHg4UlRzZ3VQa0hUcmJv?=
 =?utf-8?B?V01LNVJXaFBhL1lHNW9zd1RhdjB4WjVXdlV3cjdCYUk4dHIwelU3YVVDdm1C?=
 =?utf-8?B?K3JLYjZsYzQrVC9JU05VNkp5VnJNUkovdmV5a00xN3loNTR0cHg0YlJOaXEx?=
 =?utf-8?B?ZjJJK09KUmZkKzY2ZGZvVFZGSVN6MEU4ZzhxOVJqZE5xSVQ2ai9zMTFGZ21k?=
 =?utf-8?B?UVVoTEk2QWlQbGEvdkQvODdyQ3prT3BrdFhkSkVlOXJwaitva0piM3MxUkFX?=
 =?utf-8?B?TE5uNldTRUJiZE10Z3ZLZElBSGlYWVdoQjJaYlYvVkN6ZFRyelFwMjFHQ1Z0?=
 =?utf-8?B?TEZtSDU2MnprNCtxcm1MZll3dXFtdWZ2ejdERmZ5QVRzMURLZk1jbXdnbTBp?=
 =?utf-8?B?M0F3amhlWGVzTzdYaHBMcFNBVThBUWdkYUp4ZlhHbThjZXpzOEZoZnBlOHBv?=
 =?utf-8?B?Q3lYbHNPbDRleWZpTkc4cUNtTU5OYlc4TnZ6NkpJdmEwcFBVSkg3clZvWVhm?=
 =?utf-8?B?N00vemt1SlVtSGt6eGJQYnVkUVJYYU9icVZyOXVJYjJjWS94TGtrUVFDOWQ0?=
 =?utf-8?Q?DIeiKqkLwFu0gy4bJ+UtfxY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c83fa3-8ab2-46fe-8462-08db3b5be629
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:43:29.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZi/jaHXebmoWbp6cFSt0jXGwqGDrzuJzTMAC0GOUoIVEMVDecPndSiCEBU5FrmDhCnLIGKxrSIZ6LYb6LDpzKE8NCgCsH6EGy3jZZ1Vzz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9288
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/12/23 14:05, Sakari Ailus wrote:
> Hi Michael,
> 
> On Wed, Apr 12, 2023 at 01:57:36PM +0200, Michael Riesch wrote:
>> Hi Sakari,
>>
>> On 4/12/23 13:50, Sakari Ailus wrote:
>>> Hi Michael,
>>>
>>> On Wed, Apr 12, 2023 at 10:00:26AM +0200, Michael Riesch wrote:
>>>>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
>>>>    then what happens if the application performs a
>>>>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
>>>>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
>>>>    the application's point of view.
>>>
>>> Would there be a reason to implement both of these controls in a single
>>> driver? AFAIU, the relative one should be used if there absolute value
>>> isn't known to the driver.
>>
>> Probably not, but on the other hand there is nothing the prevents a
>> driver developer from doing so, right? Point is that should there be a
>> driver which does implement both controls, we are in trouble AFAIU.
> 
> I think the documentation should be improved in this regard.

The documentation of which control exactly? And what items should be added?

Thanks for the pointers!

Best regards,
Michael

> 
> Also cc Hans.
> 
