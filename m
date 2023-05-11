Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF16FEFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjEKK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjEKK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:29:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8405D8A4E;
        Thu, 11 May 2023 03:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+8u7onyYPCIjw6FJcJQasjjW7QE1/joustPpvF/5si8uongrfuRzNjXcbgFmSrVPR9pe8J2eg9QqHJGf6Dm6QI3VCUexdhzdHPS3ZUWjx6CtXbjvXDyBAyvBnePuCJ3lvD8xpggBXgjrykJ9l1fJiUWXNhbtqjZtJm4ivsCdkQD3wFbyd6B1jwJ/sQKe2gpirLE2Q3lJMT2aH6ok/Pcue7Ghmt36bKzvf473TTYgyU4zkCqkMKajTvVcF/7xKOWEtg5sOjIwl6Eh/KxFyVEVuWosXvvmtDOfYhrexg38wrJ7VrD7qB39o/u6DziloFvd06lN009YFUkcSiFuhg31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLx/N6lX70h1Jg7Nz7AQHg03rFRRDF3z4pq9w9CYKVg=;
 b=LAxHdZRiXWEpNF2ZUwQ/Q7WZt5Eo4uiqzg4iPxwDR93+HhHdq79Xwl8L7fDKIyr3jYWCxUdypLoTSynQyvbDYpldi9SubMZ7MTlBIhuuqYTREDDlONY+aQHi3RJaqLm1tqKJgfTmnZG/sGMKLJ3J1GeOcqjU6ux5P9XvA2aufKTu6K8up4YyZ+VxqqC0lapW30Kkvq0e/ljT/Txonet5q1lfY7MxM8bfgl+zQU7RPdAwBZianvDXdEFyJxVzzsoZR8K+Tfdi0WrOsjhUGNP2pkFs7sGM2D4yIMnSe8AImqGvT+8q6J03sTVgr+T8Xz1nRwbed1XIFOfoAzDIqdU0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLx/N6lX70h1Jg7Nz7AQHg03rFRRDF3z4pq9w9CYKVg=;
 b=r4kGHUGhzN9ceXr6gsU31a80mS02DqV/VZ4WuptRjFnJ5boqA4WnZYEKD1lP30kcTG8FYEuNIJozsvIZJEdFyqgTm5cPYckx7ivJmY3ZvBDvUAtyjuDyVQbVbCnjQJgUubJBwPJEmIUDHBkpJBtgsNLWB177fTg3mpSGhSjUhjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 10:29:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 10:29:01 +0000
Message-ID: <18526d2a-ac5f-2b26-9ed3-5a82f20cac86@wolfvision.net>
Date:   Thu, 11 May 2023 12:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Language: en-US
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
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
 <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0275.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM7PR08MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1385a701-cbbb-45ea-28a5-08db520a8944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUGB+p0csqRAmg3yxD97qMBpyJAR62RS5mxIZkdzhp/dVzO1YrZlK0eFm0/H1wAEbC0vo63ThaNt25XuEprxZXV8/gNZ/D+KD9yQsW49yx1WF0XEL8SAXLAhARyfA7yTcOJ+VPeK/LUIUqfq6ivRM0XMJuLe2ItwEaqORizymbs02F3ejT44rDNUy4JOuNWGfKbCy3TNDKK2vxYDe1Ar+PM5lWn1nnv26pVpKwEcXNJ5pekMHqsWYXwF5dxeS7UirwIGt5wnFuWxgQKiRizvl7lhZfiQN8f5J9svWNHZCcYqX1WrgDUj8k0ydtwfvwLZO5LP1OqzL3GUB5J0l6OossOqct+8vUXbFLJhA+VjkWvE67n5B2y4N0lIDFulvsv4Aaw8Qntmo4hmzoHQQsPqNGI8e5VjGSgpccZVK7W0DhHcKIxT/FwGunfQr1MbQn8mCRMDP6CiiARYmqD3f+pdfkCyc1JCR0FhOjIFXBdkWt2wmIksthmXPe1jmuKplz53whUFZqZ919hY2p7iPWAfIhvkbLXxkjjm0edbVIv25Dpa4CCzh8fpLjN3xVN8osIHGgWgWiJAwEPGVs0j6xYWeR3eIzVfn4MeouRjIYBjpMVWbhnkOsakxBsZGyfgP8xh+q6liqgpaxG5w28MAnujWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39840400004)(451199021)(2906002)(86362001)(31696002)(6486002)(53546011)(6512007)(26005)(44832011)(6506007)(7416002)(186003)(478600001)(36756003)(5660300002)(6636002)(38100700002)(4326008)(66476007)(66946007)(66556008)(2616005)(41300700001)(316002)(8936002)(8676002)(31686004)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNLTi9CNWE0SU1qeDQ5MlFFbmdvMElUQ1pWb2J1V3JENWw1QVV0SGZ5Mmtu?=
 =?utf-8?B?NFM3Wkd6K3JpeFoxb3k5dFI5aUtWS2NxbDMrTXh5TFFqMGJRYUZlaENwNnFT?=
 =?utf-8?B?NTVUOHFYL2pmNi9rR0kwK0FMSitGUVJLSlpYQ0NaSWQ1OTdraWFLZDdSbit3?=
 =?utf-8?B?dTFuRklheUJwMndlV2N5UktETXFDTFd5ekxWUktRODdiVkxBV3EycmU3V1lt?=
 =?utf-8?B?Vi9HSTFVL2liVE5HYTNtcUt0NnpsR1FXd282SytrZkZRVkd3RG0yL043RmYx?=
 =?utf-8?B?VGh6K3A0TldWSHJRWDg0SUtMTWZ6OS9jNEpzUk1tZE9zUVQrSDA0ZlQxaTc2?=
 =?utf-8?B?Wjd0Rk5Db0g4Q2I5U0hWTXhnaCtKbXcxZGtGZGtoakJyMFZsMG82cm9wK3pY?=
 =?utf-8?B?aEJmREFGVVhBb2h2QWZma21Kb0F1RStJcUdxbCtjVTBLTlcyb1dTQjdEdVph?=
 =?utf-8?B?Z0FSR3JaenRIOXo4bTlhblJKd0JZSlk3K0hUMGxOQXFMalFBQmZVTm5qOGk0?=
 =?utf-8?B?c3pndWgzUVVQTmFuSDBCRkpUc1k2STdoalMvemdFcjZhbFZFM3BKeHBWZm4w?=
 =?utf-8?B?c0Niay9uOVU4QjViSFl6ZmdqSSs3TVBTMk9MaU5SMU9ob0Z5aXViRTBvSmhi?=
 =?utf-8?B?azhDSGk5dTRNMXZLa2Vna01XNzZydVRDQTZWWWkvMkFWYWNicDJvd1daaENk?=
 =?utf-8?B?TU5US2FZWmVqSVVzcFhKZHVjazd3ZzZTVVQ0bWpjajJKc2h5L2hRTGdndHZJ?=
 =?utf-8?B?dm5CenJGam1lYUs4YmxHUlNqSitseTFXSzFGN3RZK1FjUVVKOWZVWUV1TU0v?=
 =?utf-8?B?a28xUWJBVU9XcDNNa2J5VFZWTzJCeHQ1dXo5bjEvTnoyTU5TT3gzVDVTUmtk?=
 =?utf-8?B?ZEhVcFhNRktsMHdndi81ZkNZSGFaaGpFK080cUlOT1YrblFQZDlnVVJVK1JQ?=
 =?utf-8?B?ci80VmR5bUVYWjl2UllyZk5Sc1VZajJDSXgrMjh1RTlZYm9Qb3pjZUd5ODBM?=
 =?utf-8?B?ZGhQOHZPODJYQnRLMStLdXRqZGdralZjSVh1R3RIaWJZcUUvZHExYWo0dGV1?=
 =?utf-8?B?MlBYL1dGeGdGd3NJdkt6aktBcEdPaXYvNFgvdlQ4YkhhYXZWbGdscWVmbElB?=
 =?utf-8?B?d0JGdlJSNlZLYUlIeDN4czhhRWdON0JjeVhEa2VPUjBWK0FPb1NNL0ZJMnJa?=
 =?utf-8?B?MWVSNEYvN0xld3E1dXdFOFo2N01HK0RZb0tZeGZCSXdkQW5CYjIvYkVQVzZP?=
 =?utf-8?B?SUc2UjMyVStQcVRINGVtZVVlcVo0ZnkvR083dTFpcUdBRUVzc0pFZGF0WW8v?=
 =?utf-8?B?VDJnNVRyWVBvQ2VDT0ZrQlRUeGZlelg3K0NNRjJrMjI4MmdSR1RVWDdLVVQ3?=
 =?utf-8?B?TVVyY3cydWxPNFNEZW0rSzRCYmJKTzZuaXArdVUxbWxieTE5ZjFDa2dudWJT?=
 =?utf-8?B?K1E5U3RYbVlCZ3VXYUl3L2NZNzRsZDFtZWhDeUp0KzZHSnkxc05haDRLNzl2?=
 =?utf-8?B?bWxrT3J1VWEveVdzeWdxZVhaclk3Nnp4MXp6TThRdmxlLy85NWkrRHhhekts?=
 =?utf-8?B?UFVJeDFFL0xaSjZBRFNNV3Nhc1VZU3hHMXFoZEt0NG81YnFldWVkeUNwTGRS?=
 =?utf-8?B?MUgwUThPdmdFUWxoM2t2ZzlHR2t6Rld1MXIyWURSSXQ5eHJiUlErMW1MSW41?=
 =?utf-8?B?RHdrSjFQTzRqWklyaWdCSmxKWHNaK1JuZGpUWjA3L2Z1VVIxaVdVWWhYRWNF?=
 =?utf-8?B?bTg2WG9Sdlh6Wm1QQ2I1RFM1ZUNhTG8yb2YwQXZqTnluSStGNk90cjRmMlBa?=
 =?utf-8?B?QUhBSitUSjhmWExHVVBSNEdacS9ralNncVRjUjJwd2ZYV1V5WCswRWxGT2dZ?=
 =?utf-8?B?bUF2LzNsN3NxQnBDTTVkVzFTYk4wdjFuMm03QWlkSlJJdTNZT1dIYmdwNUZK?=
 =?utf-8?B?UEl0OEZmY2FMK2RUbTlyQWRjQTBTbDg2NUpuVUFSQnFveVVJZnV0RllmZFlH?=
 =?utf-8?B?RHVyVVlZT3paRmVrV0o5ckc3KzdLdU9lWUQ4NDhBbVF6Y2I4Y1pGWS9aVlhP?=
 =?utf-8?B?eGxZcG1nYWtZNE5rMDU2NFZXMUhSOGtWSjh4dnZlMmErSmRvS3duQ01aemVi?=
 =?utf-8?B?SHl5cyt2MCtQcnRMTjFUdVRtdXQ1NHJSQ1BicHh0OUMzd0k4eXB4NUJDdVNa?=
 =?utf-8?Q?NBVa3yyvLjZRAqa9Ob1ylGE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1385a701-cbbb-45ea-28a5-08db520a8944
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 10:29:01.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHGn6w4oDprRv+IAJt+YemutEUHXHDFo7gGC+v4U5Aod9zvXlit+XFZ9V4b4O4jhmg4QT1IVne7rRBzPuK+vng6hmXSQmCQs7Jc1xw0HBeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.23 11:45, Krzysztof Kozlowski wrote:
> On 10/05/2023 15:50, Javier Carrasco wrote:
>> The virtual-touchscreen object defines an area within the touchscreen
>> where touch events are reported and their coordinates get converted to
>> the virtual origin. This object avoids getting events from areas that
>> are physically hidden by overlay frames.
>>
>> For touchscreens where overlay buttons on the touchscreen surface are
>> provided, the virtual-buttons object contains a node for every button
>> and the key event that should be reported when pressed.
> 
> Hm, I don't understand - are these separate physical buttons? If so, why
> would they be part of touchscreen? Where do the wires go?
Those buttons are actually printed on some overlays which are mounted on
top of the touchscreen and  they are used to provide a predefined
functionality to that touchscreen region. Any touchscreen with such a
physical overlay with buttons printed on them or clipped touchscreen
areas might use this functionality.

These buttons are actually physical i.e. printed and with a given
functionality, but still part of the touchscreen as the physical device
is not aware of them. Therefore they only make sense in the touchscreen
context.
> 
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  .../bindings/input/touchscreen/touchscreen.yaml    | 54 ++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
> 
> Best regards,
> Krzysztof
> 
