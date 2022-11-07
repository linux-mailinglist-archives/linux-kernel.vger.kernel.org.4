Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706261E882
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKGCEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiKGCEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:04:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52313DF36;
        Sun,  6 Nov 2022 18:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRzHlpHpXPmWSDrDfpdl042oY572M8BOdxr00h7hsTHY8CYxtA8RVNDpQhNpjo/yBLMWF3UVOT9oax9q/h3yz+45Zq9ShYJpTQZitcyAr23d/ZYy8SXxuI3GoGl6lkMvyIo6WAj2B75nOeH2QiVDZ7rjpuIFW+oD/3T1gzesY34bfT0YYRk4BqvAZwa6PsE3q7XIxQgwxgFfHQKXoENc460523x7ecIqLgIe3c2YWEtCf/fYYC2EWbnjWwNsEyEEIihkUX2i4GhD0NUn49jPVqMOcTrdjk5HeCJexhSWXjmG4G1HhiYM40OO8CFfwQq6NlvbB1wCYjtAcvv+tzBHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFwVOAfIBoKgDrJ2IbCUMR/dSRIqiZ87J4/GsEpqTcI=;
 b=S2LySFzNdphvOVZlEZ5xRdU1pRO9UP1pi5jNNZFKCnTSUomaUVtwLmGnciIjZslCowfgqUSgdeihkOvhhrB5OAloir5gpNx4G9GU1utibp0pm0lJ15bF5RTGz7JyF13vZNO1tcrCf7i0JM27vwsJ/qmDMbOf92ON4ejxBSmOu+gyRHdQotTbyDydiEiNwtB5ZpV+3NGKGl76EmmetL3/9xSBUYm5cQyVmCuhQC80h19z2T3/AREG5ffZpT0BJFhpLK5fCGFnsApSJ1xDPijHflpnuaNAiYbsHiMKxqNla9KVdDmOiKpHVdOzCeCJgxZRySLnDcFlNzivAlHSJpjC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFwVOAfIBoKgDrJ2IbCUMR/dSRIqiZ87J4/GsEpqTcI=;
 b=YHg4bLFtLB2F2lq1Wtgdn+eyEjDRj0epPQi5d6nbseWq1xpucYREhXDv7Ak+sH9WgDONyFiRamQzYx0c+HydDB6nl8TmeCtq0Cji/0qRdpqcOJfzMenQ6P8FPPlHLGAuzDCYWeXVZdQjLxKhGilIoseQinq8p9r+DDOVsRvkxrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW4PR03MB6348.namprd03.prod.outlook.com (2603:10b6:303:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 02:04:16 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 02:04:16 +0000
Message-ID: <41d0e696-c472-eaff-94cf-1327a20f6442@synaptics.com>
Date:   Mon, 7 Nov 2022 10:04:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        nicolas@ndufresne.ca, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <b58e2678-8d2a-a323-07e4-12cc01c8c3c2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW4PR03MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f157878-c5a3-4e35-df4a-08dac0645fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8CMizhSlRv3YjLwqkE3FAvLn9I7mtyQiPQPHSAIJZLITMVyrUgpdKhX/4rHWNGD0odLiWa2waBaNq/4F2d7+X2r3shRjojn98tF5Ce+i6cwXpA0E/tBn4vR2GdUOR7NPfCLPQQ1bk8kEkhb8BaulpiaMxoHqFX1MY/9jImO+IriUQxklmOtRFldD44gNoQ6dKSTX7ijY3TzIIRavJu4rRgySa3IpSQbKwJFu89Ywuo/kRxPnn8KXo5RcEs7uEWEyoxyMBa0DuoO1KmSFj1eVo1V9PNMzUuqgbkrrihmoOhxAkBNSPrggSCwPlIsxsLsJ33xHvHfhgqhxPwVrfRwgGK2Ahb0ufVf+K6cVzGRfvfNMknPHgyB0h601dlJKCR96iooFLc8mEXJCxX/UzQ3JOxxA+ZiCxGamb7WQMS+lbj3LsLW0oc7N60Pun68YIMA3xohrfA0jOvGHguQo1th2XhchWGNxKS7edu3k8RYmqqx8L4cjTc/3nTrbIqHp1np05XVqu+BmIuNZn3jLcQxTommMJgXtezxSAA3fjroRRts78tG3FkIchuzLPyS0vqYYvGYUUjmrxClRIaClnoRuri6E3rN3N8p/M6IBQNH1OpFBXoXMeYgQjeyxqqun4gN+JcX93KKToakbZaJ6qzXpe8JS22noTUHCmElFidUtUNLSRSKy6u9DhpX7tUeDFhFfdnCBipQIK43f8umuGk7bvbJ7B16UBTD4ZSYq9ZpAZESNHKcRyIyei5HZV9y6ZsephfA6fiVZ62PMZn5eN1TpX98osfvG1RSBZOSEUKTXfpAw6h9irfiFm3m0oJMfGnTKK1XQK1rweSE9aYIl5soMf2HRGE6LR9FMnrOGUR3V38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(31696002)(86362001)(36756003)(186003)(66946007)(316002)(6916009)(2616005)(66476007)(41300700001)(83380400001)(4326008)(8676002)(52116002)(53546011)(26005)(6506007)(6512007)(6666004)(54906003)(478600001)(966005)(6486002)(38350700002)(38100700002)(66556008)(5660300002)(7416002)(8936002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1NneGFadVgxRFBnT0xXdVQwa3o3YWJsTlZITk0vWnBHc2NIMnFkUnpha3lL?=
 =?utf-8?B?WWM4ano3MVFGdDY3cVd6MnpFRDB3NHR1RTlRaFlPUU5DMllmQ1h0RHlsdzlT?=
 =?utf-8?B?L0d1aUhJRk5mdjVkQzVwWExUVzRHd2g0S211elpOcjJHRGFmaXFBL0kzaExE?=
 =?utf-8?B?WlRZTUJjWjBJNWQyeGdmL1BVQ05iMDlqSzZPMmlQYzBDZUliTVorOTUzZEk5?=
 =?utf-8?B?QzltdWM3ZHpXSkhrS1pZcDZweHNvMzJFQWFhQ0IyempTYWVpRjRJSldyNzJZ?=
 =?utf-8?B?Nk1qU0svd25hMHYzM2VCN3pDYTFUVVhFcHVydEI3bEV3b3ZZMGpTVS92bEJl?=
 =?utf-8?B?YzMzRlFlYXd1THJlbldNa01OYlNZR3l6R0ttbXBFMUF2d0lpdmY5aXMvTnl0?=
 =?utf-8?B?UU9nTmhDWmhYbVpZd0FvamFoSW01eWgzYllSRUQ1cDI3dXE5SlZoQkVNZklM?=
 =?utf-8?B?U2FrdkR5TzlsRXp5NDZJY1hDZzVYVVFCQ0xkSHB2cUUyL3FOZnM3c3RhejdT?=
 =?utf-8?B?OS9YOENaL29SbXdEU0prZVBjN3ZBb3NsOCtoMHB3VlVWN00wV1NzcUZYUUlQ?=
 =?utf-8?B?MlBNM0NWZUlsUmovZ0ttK29qcUY4dmJnVHZXYms5T2pGYjVPaEwyZGNXbVNl?=
 =?utf-8?B?TDdnbzd2bExxSFlsYWRmZ2p2YWtDRStDVVFpQW8xQk1BMmNNSjFYL1d3S0tH?=
 =?utf-8?B?aUMwSkx5TlMwOGNiaGNXdnJwcythbmtwUVc4ODZkeEp4MXJyY0d3VHJKcWMx?=
 =?utf-8?B?UWlDYjBYM1J6VmlsQVBvNEhvd0xkN1NRdmM2QmdUSG1na2FkVjh2VFpkWWdu?=
 =?utf-8?B?STV1dkVxUFNxeS96UTVCS3NQakFwc3UwM1NWUnhJME0yczl4anAzWnplS0ZC?=
 =?utf-8?B?Skh0L0xaa3krWlRYN2VTdjRhb1dOcDNDdURJZkRZdmtHVTVYNjM0dndHUkxn?=
 =?utf-8?B?TW42d3phN3JqMTQzMmhuYVUvVHZJNGF6WHo1Mzk1M0FRTUtaQk1jMC9LVUFR?=
 =?utf-8?B?YVc3K1Y1UDRkMHhJT2RrYW0zS3d5enNob2UxQ0M1dEdiTWN4QXFxMGF1RXAx?=
 =?utf-8?B?dk1JN1FqTFU4SXppQllwdkY2b003UWUzYnRBdEhGNnJKUTZySUh4b3pSZHlJ?=
 =?utf-8?B?R2QzVFFkMzA3MnVTQ2k0RVk5RUFLdjd6SHgzKzR0OHMvbWlTUHZyYWlGS0RN?=
 =?utf-8?B?U0tHWXl0SG5jRzcveThCV0Rwa2hkbFc4V1ZNMUh5Rmd5eTlxdlpsK3l0ZE9H?=
 =?utf-8?B?bGpsL2pUNytqNHYvRUhZemFESjBwci9ZOUpYN2FUMzExd25QRkxLMG5nbzVu?=
 =?utf-8?B?elE5azFCQ3lIU1hrR01keXAyL0ZtNW4zSCtWeHFCSEZVeWJNNjViWXBvYThW?=
 =?utf-8?B?WkJiVE9uT3JrN25mOWp5VjF1NGlYNTcySU1OKzJYaEREUHlLMnQ5b01QR1Fn?=
 =?utf-8?B?Z1BHTHBmYVZyZ1lDaC9jOC9EZm1MN3JQT3NjVTJLNXljdW1ScitHUnk5RG4x?=
 =?utf-8?B?MStpZ25OQ3V3b3U1eE9la2FwVlJCMEN2MHJjbzlUYWtwSkkydWZKQXhuNzJs?=
 =?utf-8?B?T1dhOVdMSS95aEsvcEc4bkpwZGxXNDNaUCtyWTZkMzhMMm9xWnhHK3FHdzlJ?=
 =?utf-8?B?N2RKVkxDc0hrWWljRHVFeGdDU0NDeDJJR3ZvQ1pLandIZWVWbFpEOGsvVncz?=
 =?utf-8?B?MHNiOGVhZFhueTlibTl2SmI4MVZCeHU0Rmp2Y21rRWNHdFlQZGx0NnN3Z3pu?=
 =?utf-8?B?Tm51SUlwVkduNmtNNU5UZFl6UEtZSlRHdnRPU1BBakJKanVyYVRHWWwxaFBE?=
 =?utf-8?B?S3hldUh4S3d2RlQ5Y2I5MkpvYjZGcWNSU3FnYUdSL2Rxc3QzRXhpQWFWRjNt?=
 =?utf-8?B?RXhvUm5lQVhHU2FHS2dPeHIrZEVwbjBNSGpxNjhCNlZaQW9yaTZQMUFQNWJu?=
 =?utf-8?B?SG1ZNEUzSSs2VEVYbVZzUE1hNVhXWTBTbkxzSkNFRUY3V0wwNGtPdE9iY1RI?=
 =?utf-8?B?R0tCcHZLOUZSYkR3VWJQYTI5RURtZThueVhKY0NrbDZ4WUhKY09scFViZ1dn?=
 =?utf-8?B?SVlHeHFCbGwvd2lqOGwyMk9TbUZuVFhRemJXc1BXUytTNzlxSXlQZWxWSVVs?=
 =?utf-8?Q?XZU8NV4jFB9x+uNb8Lpsg6S2M?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f157878-c5a3-4e35-df4a-08dac0645fdd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 02:04:16.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+TLNMrNiicDNpMLkTFG5XNVng/dzq27ldHijwZQ1rlvH+D9Yfgw4VGOWQx8sPHI4mbQaUlYK4jpScFdscJlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6348
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 06:11, Dmitry Osipenko wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On 11/5/22 18:19, Hsia-Jun Li wrote:
>> Hello Helen
>>
>> I didn't see any updates from V6 and V7-WIP in your repo. That is what I
>> need to for our complex tile formats in our platform.
>>
>> Any future plane here?
>>
>> Besides I have some ideas on these patches.
> 
> I was looking into updating this patchset few months ago and the biggest
> blocker was the absence of immediate upstream user for this new UAPI.
> What your platform is? 
Synaptics VideoSmart
https://www.synaptics.com/products/multimedia-solutions

Is the driver stack completely opensource?
If you don't include the trusted application(firmware) then yes.
I can't post it in a short time, because the firmware is not released 
yet. While the v4l2 still lacks many features I need here. If I release 
it in a short time, you would just get a version that outputs non-tile 
linear pixel formats here, the tile formats were only used for internal 
buffers.

Besides this TEE in our platform is not optee, even I posted it I don't 
think it could be merged in a short time.
> 
> --
> Best regards,
> Dmitry
> 

-- 
Hsia-Jun(Randy) Li
