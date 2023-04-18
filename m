Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F26E57FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDREM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:12:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2D469D;
        Mon, 17 Apr 2023 21:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKAXytZKzNqtR0Yi677km+9eZCY+U8Lv15Yk5reL8Lr7qGuJMb5+Yo15OJJcnbOjMZej9p05BvBGIKLwLD/kvCtr4SJP1acaOaWzh0Sri68MBymyST82vhaQDoN3dRhOGqaPFHYkezrrBu5BhhVAZehOmtgFnAqusRptYKFrAfZrBmvUULL7UEzblD2NPLkjZJE4vURzyWsmHJwGCd9ibYUzsJozmpxKNcFqSFU9q+WoaHBCq0DZBTAkq/4IF3yzgPRbyWpN54gmZUpcGFlqxQXe460i/DUubIG6lW0m8X+YH9Bw/Apc6jTcCiDLO3jpK1QPMtfk3GYDSZJr95L6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZibWWrxexhLtAilGgxHoDgZF0hqqtJDoE0/5l5zgVAw=;
 b=D+DJfL/vNUtaPPs4DZnQKvcgEIyb09fSJuUPqCfSr6z4nEgIgtOwTNjxmKIbT8HWCDoP4fcZigbgyMK9AP40LGgY9Rj8BoSHc3zne1BJt9uVh3YgpJ6dQyC9cd8KTmBEzCcm77Kl7B8/+yjKHuMGT+vpBxxVb8RDxPLgRTFWeolPpfaoCPPfgIRngoMlLG+3lUPipA6fflQ2KScKJ/I2OLxGbn83p/L/kXpFbAJJxKBs5lJnQn36BbmRVrIebzGIwvF703FxmQHUHaeYuBUK6uWbkOoGyuvrYjutPKZecentfU1VYu3jTN+k+PDdMdQMETrHiWauIMboeUPMCFm7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZibWWrxexhLtAilGgxHoDgZF0hqqtJDoE0/5l5zgVAw=;
 b=Zc91iEoRV2k0AbV4YnVQ2ARfZHoyfmuxHQy10w5IDBp1HHZQ6JbiYgcC+Q3sPnGo1TfFJScoiYQHt02CGDJwGor2dFs+t2PhmuTrfsdylHQWgc7jaSpGLVOyp+iLk7rE940ribfHX4jVIgMczMdUiQzizTrT7F34sgQDWNZ0hns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6191.eurprd08.prod.outlook.com (2603:10a6:102:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:12:18 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:12:18 +0000
Message-ID: <a440be18-21f1-a0a0-5456-f62aa5332053@wolfvision.net>
Date:   Tue, 18 Apr 2023 06:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Input: st1232: wakeup in Suspend to idle
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
Content-Language: de-DE, en-GB
From:   Javier Carrasco Cruz <javier.carrasco@wolfvision.net>
In-Reply-To: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0011.eurprd08.prod.outlook.com
 (2603:10a6:803:104::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ccfb67-c3ae-476a-c267-08db3fc3191f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87QEDaeEXsUUsOGUXHP2nglUAu9JMRFn5/2YVF026IuM1vcXfrbkELD+aOkE22sL3CAVg+ZZY1STfeqV+XK4yqmOv2Jc3CrmAM0geSPZFf4jhKZ2Il0Lyo6Hl18VQhIppQ0dh8bZL9BRO95uukLhlDhiZPO0erRvVTaqUjMPPdGI73XlWepZ8P1gsVkva8hHhj2+6gUKGZ/i6k5JBpPyyLjrCiE82huNljQCMYWx9+27kiFxGByx56mYfg57Qu70tk2puWP0D+YpJ8+n1lqwn6vH5QXDPU+zFBWnH9jA5Ltu2cfz1ui+ryAPGvbVdAdX9PGYXQinp8EKVBprdJzccAKXAvU6/EWne1Dxiy5d6bxJRlTWy5mAFUYMMJv8HAFVv1Z10/0Y395nYo7WvoqB2mJMAz2K17iNX2s3gDUBgggP6FbIDQkGxW3QlmVPIs//cOs/tqutp2QSxnyl/nyZch+/Og7r3Nnvhdt11HXUzO0TWTP5hO6bTqv0NAk4QMhge32f07LZ+YgBfNEvJ3c28M6vnBj98kohVVoa4cV41nTuWvdPS1wnTjFA/mP3COLmYISIWQQeHEEnZc7SiuzWqjEOyJIpyQkPQcE8QzCu0fFsugpSQ8yOwF/Ks3mTenluVvbBJTiP7nkWR6GMefIamg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39850400004)(136003)(346002)(451199021)(36756003)(4326008)(54906003)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(41300700001)(5660300002)(6486002)(8676002)(8936002)(15650500001)(2906002)(31696002)(86362001)(38100700002)(2616005)(6506007)(107886003)(26005)(186003)(53546011)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lyVzdzQnNnTGtiYVo0TG5TUWVodDF4OG9ROFlsejBTb0xhNXUxQUZBbE9v?=
 =?utf-8?B?bDdISENIVVg1QmRuKzRhS3VvKzZWa2E4L1V4N1Y4eVpCdjY1emNWVXNGN0Y0?=
 =?utf-8?B?TUhLd1hMODdBSVZVWFhNQVRuMEdRZ1h4bzZNeUtGM3J6S1Z3SHMyN05SdFEw?=
 =?utf-8?B?UzF6cVB4NkxDR1ZGZlE0WmFSUVhMeUdVNHVXaWZFdUxZeThsV1ZIeWdiakNW?=
 =?utf-8?B?WWgrblJobXpvMG9MRlBHUnBnVTZETDRvcHpLSW9ZR25YcURCSUpIWGc5RW5s?=
 =?utf-8?B?MVNnS0pSN3Z2dHNaeWZScFVGOUVvQUpJYU1MOUUwaGd5NEkwYzRNYXZpbmdW?=
 =?utf-8?B?aGVRdVAwaThKT25WRVJVS2dLR2NoUG56ZnE3T0ZnVk1NOGlrV2V5UUN3RHBX?=
 =?utf-8?B?Tjh0aWVrOXVySE13cTBZdjNVMEtIVEdFU2NZSG9HQ01NVXFpVklHMURyY1cw?=
 =?utf-8?B?T0lPRE5jdWFySXg0eVE4SWNrcHIrQ0I1T2Y0MmZvSndWc0Z4MVhqS0VPRjI1?=
 =?utf-8?B?TFV2MjE5QzR4d2U5ak9oVmI2aDRsZnVBWFpYaWx5SGdlSmRqRGZLUmhMVlNx?=
 =?utf-8?B?Z0tjZ2ZFM1JRS1Q3ZG5YYmo0NHhOSUQ0cERKOXNZRVZjNmFSdy91NFdlaTMx?=
 =?utf-8?B?a0EzYkQzeDVxZEtpR09KMVZ5cXhPVzZobTBNbldjNGJFSHZjNG0xa0NtY1Bl?=
 =?utf-8?B?RmFhaVJiYmpJYTRSUWRnUy8rUEpXQjRyN0NSdzVxSDRIamhaWWxlR2FUOVU5?=
 =?utf-8?B?aTh0cWxJdy90UnBJV29yb0trY3dMTXhhZmJNamZpN1hidFdqV2JmbXd3MXNH?=
 =?utf-8?B?SVBKZVlHbExqNnhNSkdjeXJ0MlpUY2t5YWYwclNJenJldDNsUDhMTmorSElz?=
 =?utf-8?B?RCtQTmdia0Irc3lOQTY4YjRRNGhlN2l2RGRiNXdHS1Nwb3U5QTlLTHM3MWNG?=
 =?utf-8?B?bGh4VFEzbm0xTksrdHVJTEVVRXJNRUxVV2lncE1zYldaNHBuR1M5a3NuN2h6?=
 =?utf-8?B?enJpRlpwZ2hsYmtsNVhUdWFmS1A2RHA0V2M1dmFmdkZPU1hDSWFnTGZtcGRN?=
 =?utf-8?B?TVRQcVo5eTkyTnRub3doQWlkYnhlTjQwYUVzL1hBZUpMWTB4dElteDJJMVMz?=
 =?utf-8?B?aGpGKzE1NnBGVjY4VmRtRVJHZFR5d05qdVd0UGpHNVVVb2lkYzdMUHBUVUh2?=
 =?utf-8?B?ZDJUdlBhaTNaRzE1SlhqUnZ2cmoxVFp1Nm9xVzcxNzVtcmtLSjN3bitFVmJa?=
 =?utf-8?B?LzdLYUtoRi96ZUpBbW4xU2lDN2M1YUZ6RTFrbEl0clQxWlBUZjJYdmlrQ0ln?=
 =?utf-8?B?Qml0SEVzdjV0OXpyNE8zb1hpSDkzSFZaUTcwWktLandEZG8vVjRtbFdZU2Va?=
 =?utf-8?B?aGsvc25odys3SVZyQXlRQTdZc08vKzBUckRYUjdMQmIvWlNRNkJSKy9Ua1h6?=
 =?utf-8?B?ZGprZjJRcXVZcG05UnFMNDN1SHFGVDFweWxlNnY0YU1rZW4rRi9yTnYrazds?=
 =?utf-8?B?TTBuRWdSQkxkM0FEVUtXS0ROQUNrK2E3T2IrYWlpcDVzOGJUNTFQOUZ3b29C?=
 =?utf-8?B?eEJYMkJYazdpaG90dlJhckszcTlwZWR2eXhaV09iMzJYV25qWksyYWl0djZa?=
 =?utf-8?B?ZlRPSkRrWkN3QmE0YWFFQ1RzcEhGZmJNWDhLTnRJTlMxa21QZklLelRoVWhy?=
 =?utf-8?B?dVFGMWhuS1EvUlBSak45QVFsNEZRd0lrQS9BQmpLRmpYaWFHS2xuQStFdUtK?=
 =?utf-8?B?S0dhdm1QUHYvMkVuTEF4d1E0QVIzQ1p5eFFOYkFWWmRlL085dTU4TmlhSEZK?=
 =?utf-8?B?b3NXNkdidnNzSG1SenF3Ri9GbE1vRXBqOHBuaFlmZlA4OGV5bG0zS1g0bTg0?=
 =?utf-8?B?eENGdXB4cnNzYmV4Q3VrWTRWb2N1WXp2TXJUOUZoNzkyS2lxNm0veVZhVmJM?=
 =?utf-8?B?T2pMU29xYnY4S3JxSFRiSmlBUjUwWEtFUWhDa0J6NU0wb29xQ3gxZWFpekVv?=
 =?utf-8?B?MGw0VnlYNW44ZWlZaEFiYUNQS0dHb2p6OGVKbGRNcGFjK1AzUlJkNkwwVTdB?=
 =?utf-8?B?aTh4LzFXcTVScCtHSjE3WVhjRGdhVFhhc2QzMkc2ZHJjSExjTW9iTkZiT0JX?=
 =?utf-8?B?WXpOdmFLYXhoS3phTGsweFhqOGlGZ0EraGk5NTNVeUxMckxkWVM3NnYwWitz?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccfb67-c3ae-476a-c267-08db3fc3191f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 04:12:17.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN4zRk61TvpNQ6ZQAvNV6V+d18Uyew7kSJlI5LPeHV75Y1yfAJj+M8IsoIsGdjWZdtVLrhBFq++A3rEdYeF3K5Rhf+yVFC+2PKk0Iwyn/bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6191
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.04.23 14:47, Javier Carrasco wrote:
> The st1232 touchscreen provides an interrupt line that can be configured
> as a wakeup source, and currently it is possible to use this mechanism in
> "Suspend to RAM" and "Hibernate" power states.
> 
> Unfortunately, that does not work in "Suspend to idle" (freeze) because
> the device driver disables the interrupts in its suspend callback.
> Given that the interrupt handling prior to entering the mentioned power
> state modes is managed by the power subsystem, the irq enabling/disabling
> can be removed from the touchscreen driver, allowing the device to work
> as a wakeup source in "Suspend to idle".
> 
> Given that the st1232 device driver does not reflect its wakeup events
> in sysfs, this series also adds pm_wakeup_event to the interrupt
> handler.
> 
> These changes have been successfully tested with an ST1624-N32C and a
> Rockchip-based platform.
> 
> Javier Carrasco (2):
>    Input: st1232 - remove enable/disable irq in resume/suspend callbacks
>    Input: st1232 - add wake up event counting
> 
>   drivers/input/touchscreen/st1232.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 

Hi, I submitted this series 2 weeks ago and given that I did not get any 
feedback yet, I would like to make sure that the patches arrived in the 
right lists and if so, that they are "queued for review" and I just have 
to wait, which would be indeed alright.

Thanks and best regards.
