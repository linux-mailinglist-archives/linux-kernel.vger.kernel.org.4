Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0C5F0147
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiI2XRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI2XRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:17:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35048153A6C;
        Thu, 29 Sep 2022 16:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5m3EKBdeAp/tjYfUiTBgF6zmXZnjNXu12Ijqnf0MvjtNt1o3OjKuI9aw3gIIKfdhJoFCb9cfXo+qXcjhUZX/jalGHXFjJbVzSRY+BNAcS7Hs6SBbVm9p61qVg2dXGAKOo4E5l3fod2G2nV/EFYTSahhquCZ5LccbxsbXfMRWBwsHPlmjKNAM1vC7XIbp9PFFx0GAAZpjcxBwUuPdzt90ksGxhP465N0YNacuhnSW7oJTbfgvhg4uknkYvgCS0bx2B/E9kLMpnJAmdcYAmE5anuj8dN1cUxiRM0KuiqsULDZxpO8SFCoRgsbcc4WX9+TwHOc6XuX+LCc0hWLSs98Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxH1vyBX8iVWfZurotvMYMkIVDaIxyRKpzjhKeWWHgE=;
 b=Lf2TdtHI4ZA/r/TzxBrv3GR88jOumJAdJDjM/yjOMrqKMGR4m0in5soorSppH2ZGjbsMgngD1tlAo60SKmlYUXwr4wlWDu6wKkceu9CXrB3wI1Je9vxP8Sq0BoRqfL3ijeJUY4rFSvga3BzjM7gDSf/sUY7S2iX3sxtJOdYIiD9PqwS0Q5DlRyC5E5hXgW0jAKd6yCKki+geSb91Kot5SlVQaH4YLjRFjD/tZ8yu+wDE44B7f+IR5qbrSKcqp5QweF9kOXfN51mxxq2iZPbJBqvQSMvYQB9qfLuku2wEgtGzVsIJ6bluOHeKYICnjnSk1q7j2mgcSQ+BEKsVLCO53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxH1vyBX8iVWfZurotvMYMkIVDaIxyRKpzjhKeWWHgE=;
 b=AZMsYEufiRjzANXoBH0DMqITr7Z1HKqbRzzZQZOgUNN12QcfTYjkjM3jDgRtIxMGldr/lzupr8M4gt66d//OrV5RYfyvnbE4kdNCPDK70PJ186TMNVSz3eG5G1sWu8PRolM8zPeN0gxkyjXjTsYQcfVrodgJWF7Qn/AQiex5HOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8448.eurprd04.prod.outlook.com (2603:10a6:10:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 23:17:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 23:17:10 +0000
Message-ID: <484445ad-d2e4-c73d-aa87-85f0bbd73440@oss.nxp.com>
Date:   Fri, 30 Sep 2022 07:16:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220927175649.GB2883698@p14s>
 <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
 <65b7224d-d3eb-4513-d733-ec781864fb7b@oss.nxp.com>
 <20220928173054.GC2990524@p14s>
 <DU0PR04MB9417F8BE0B50230F689102CD88579@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CANLsYkyqzN2PY12WSBTMPOXbPHoZQ7rPux6RecrGAgJe+G2WKw@mail.gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CANLsYkyqzN2PY12WSBTMPOXbPHoZQ7rPux6RecrGAgJe+G2WKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: e16d0264-8a0d-460d-8157-08daa270bbac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRzN6/eO9UNL0xqEYpT/eog+VyKJZSMZh55aYR5+tpoe3NCONIIGZjtsawyqavfIIX6nSy83hLAPZJHuqn3X842os9Z+N09TjEZTS3y1+jrroggf/K8OaXuR+8/1NVpR0dXykKYb4FaYW0Phxfu9dUsMezUTQ9VbUuHIeJHyFcUgS0IxW4rtBO/Rb3m4gRwOCDoJKte8qK/DsUa1n5KKxJcfrHTaCOWt/HjJt5XRgJJip0TU+ie3/UBiQTuJYKaHDFE6jrlFV/9tLVrvQZUaJSOb4nPXsjFdlyNfWd+pJzT2/cqGp81KUnJop3+5HH6/D/3cxgwSDd/S5AQ3T2i7JQnqm6sUXjLiOg+vuth+fOPsXLMQ7faP5GywBMYc1YDbGiKSK189jL43J0xqLXgZa5nH/Z+W0RFizcOmSd+SN0/Mku48ns0AwbHv4d169HiLbSs3BVNkoyoGsr/j5r/gJcZJ2lztwC1nqazqk3sFmdcw2TNXMQ677G8YauP08F+m3KxIl++O6+nm7Kqnklh58qAuPrTLoxCiWjoOg+ZFq3vrWwmwbWC2kIzVQnN16Bz4I1FNIluy/i6tYOpTdKCsuxQ98bnqy9KDBrDR4h4oeFxfuMpPXD1W6psKB2xm9rdqEsotte4U8yXGYxjisXl1ONKyP9C01A8aRmBkuwY7jrmOvi84ISXqN30QS2eFxjXwqrnGGAA3wx5lIWUQtxiK3BZhEVhHXCWjHmQX7O+W1i95uNsA60XhQrtIjR/UB1FAXXmNNGf+Ento5kg3+8Vy2LDZOnzg5vE4TQcn0j2wotvti0uhFDxbG42n3jQfxJhrS0gd9CVMarKL0qVMvPpE/qpgIfI7sH0zvmzEg95YJ6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(83380400001)(2616005)(186003)(86362001)(31696002)(38100700002)(38350700002)(8936002)(30864003)(7416002)(66476007)(66556008)(66946007)(4326008)(5660300002)(2906002)(6486002)(53546011)(478600001)(6666004)(966005)(6506007)(52116002)(44832011)(26005)(6512007)(316002)(41300700001)(54906003)(110136005)(8676002)(45080400002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjV3ZXdFbDZjY1Y5Zzk3M1FhSXFLZDFlMXE0S1dMTjdCcGdDTXVwRTVZOVUy?=
 =?utf-8?B?SFc0aTZyajNnSm5KYXFFYVEyblJOcGRqWVBrQkVkaWEwMkNnamEvdUNkZ0ly?=
 =?utf-8?B?eUlQRmloUEFlbng0ZWptdzZYSW1JajNVSnNxNzBQcTRzNTdEeHg2WkhpdXFZ?=
 =?utf-8?B?dU1wcU5qM2FqNnJmeGRDZEw5ZGlQQ09KYzh2K3V4K3hzWTMvTXBsdnIwZXJy?=
 =?utf-8?B?L2dFVTdlRWFNRUd4d1k4ek5QTE41WWxQS2hFWTlXY3EzcFdVbWNZd3FKWGpM?=
 =?utf-8?B?bHhSSEt2dHlFSWJJM1MvM21BVjZ3dVRSZ0JERWFHQzREcE5PUWRTOWZTVUZM?=
 =?utf-8?B?WGdUaldSenVXWmNSak03L3RKMWxJdzV6Y2p5MVV0WTNqazNPcEZtQWI5ZUJJ?=
 =?utf-8?B?ZFFIWmxmaWhNeGRQYmN3UDBTbm1rNHhmU0NiN2JuV1U1MnNrQStmNzI4OFZN?=
 =?utf-8?B?MTZUVE5nRExlTzkyQXljN1ZyVi9UKzQwOU5QS1g4WlcvT2N1Y1g2WGoraHFy?=
 =?utf-8?B?a1pTUE5kcHVpaGZYQURSZnkzWVpjR0YzdVJtdG96NEFYR1A5STVjdDVQbFBa?=
 =?utf-8?B?a2FlOS9JTmRGVy9lby84ZDRucHBJL1YyNW9MR1NNRmlsQ0g2dy8yVzJNK3RV?=
 =?utf-8?B?NVlybjNIV0RLdUNtbFRVM1R0SGZWelpldXNSdzRVVzlvZTIyZGx1djJqemZV?=
 =?utf-8?B?RVh0YWFHMjFhL3VGczFka2lZN204THl3NnVkQUEzRzdjQWowR25jaytOU3Yx?=
 =?utf-8?B?MFFPeW5Fd2NuYnRHMEJoVU5rNkdxeGYxSWRablBjb0RqeVVIZHdsTjFNOC9j?=
 =?utf-8?B?T0ZiRUh5NkUyU3FhMzZlZFROb0J2a0dyK2tnSkxVVTBuUmkzTlhTQW5wcitH?=
 =?utf-8?B?bSt5K2crWXJHWjk4M1pFdHBsTHd1NnEyRmd2aThFR3pEOEdOZVU5NmxDYzNi?=
 =?utf-8?B?OTc4VEdHYlJ2cVlTWitoZU9vTHQvRzdQcHlQM3dqUm5DdnY3V083UHJSdUty?=
 =?utf-8?B?eVZWY3NCblVZRTVqclZrendTL1ZwYWJ1dEN2NUNRTk5VNSttcXhPS21RRVhI?=
 =?utf-8?B?K0ZIMGxyNENJUlpQcGY4VW9uV3NveVFzRjQrR1pWZHcwelo1MFBLVGZOM2tx?=
 =?utf-8?B?RDIyNitEMERCOEpQblY3c2xYcnM0QzU2K2M2b0NxMnB3QkhJc3FwY2o4cmNy?=
 =?utf-8?B?S1V3Vlh0VUl4Qm4rWHlZdmYva1crazduTmJrZDkwSXYvblZnT2UwU0tFSDFm?=
 =?utf-8?B?RGZIcjNRZzh0U1NlYW43OHEyYUt5Um1RU3RIbEQ2QVVPOEdkSWdEemFCU1Uy?=
 =?utf-8?B?cFRjMk8wZDhnMHJCenB5ckhjREozOVhYOGJac21JRW9ORXEwK1prOEhjM3hK?=
 =?utf-8?B?Sm90TkV6cWVtRHQyZjdrUmY4SVJDWHh5TzJwS1NPcXpNU0gzZWVaN1dFcy9K?=
 =?utf-8?B?ZnNVTkRIUHdPVkQ4OGdVRUh6cnNXZklZNERqcW1ZU1llL3N0aGtFdXlBVmFq?=
 =?utf-8?B?YkVHU3JxK0ZpK1ZpM1RnakY5ZFlNTVpBMGhLbEVHaUh1SkxtWDNCK3Fpd2JC?=
 =?utf-8?B?Zk1idDBXVUtleFc5d1VtbmFJalUwc1dGb1ZGWmx0dWt6OFJBSmpwSFVFbTBk?=
 =?utf-8?B?MjFYSStZOENwdTZRMGhHU0hRZStic1J5UlJjS0QyV0tnbGZ2NDNyUDZPSjRU?=
 =?utf-8?B?TlVUbU90cms2UHhSU1MxWHRwbFVMbnFDYmpsb25pMURkWkhtbDFKbVhXUE9R?=
 =?utf-8?B?T05UdjJlN1FVV0tCcTVNdmZjQVRhMEZpSUd6c2JtWEN5azlkc2hTVFRvTmQx?=
 =?utf-8?B?SWdib3BiZHZFVk9QaWlRNEc1VW5rcnVXTGlObVNOaGR2Y05DWHFjNGJ5MzNy?=
 =?utf-8?B?bzByK2Y5bmZ2MDI3M1N4M0FuVGNaZENQWE9sRnZYRkJnbjNid29Uc1A0UlV4?=
 =?utf-8?B?Tk9QK0d0bVN2a2FhdnlvRVVqVTBIVXVreDFQekdYOTNxZmFYOTJNWXpueWJM?=
 =?utf-8?B?ZWVCeWxSSmgyMHorSGNBSXJ4RWhyMk5hZ3lTS0Nwc1pXTENFaEJSZVR0TkQ0?=
 =?utf-8?B?dTZuT0tLZlJadVBqbmplUDdQT1ZDSzBjRWs4bER5R0U2WXUycC9BemF0VUJ2?=
 =?utf-8?Q?jsetN1dF5GG8VP7la0Kvu67Lz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16d0264-8a0d-460d-8157-08daa270bbac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 23:17:09.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYw90BbWVfFplm8NsPgvXClDpuB3YwSkdDBBMsujWcUg4pwQ+6DkqQ8ijCXnCLPMg56BncKDrnUOdnzhbBk8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8448
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2022 10:58 PM, Mathieu Poirier wrote:
> On Wed, 28 Sept 2022 at 21:52, Peng Fan <peng.fan@nxp.com> wrote:
>>
>>> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
>>> i.MX8QXP M4
>>>
>>> On Wed, Sep 28, 2022 at 06:01:45PM +0800, Peng Fan wrote:
>>>> Hi Mathieu,
>>>>
>>>> On 9/28/2022 3:39 PM, Peng Fan wrote:
>>>>>
>>>>>
>>>>> On 9/28/2022 1:56 AM, Mathieu Poirier wrote:
>>>>>> On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
>>>>>>> Hi Mathieu,
>>>>>>>
>>>>>>> Thanks for reviewing this patchset.
>>>>>>>> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support
>>>>>>>> attaching to i.MX8QXP M4
>>>>>>>>
>>>>>>>> On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
>>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>>
>>>>>>>>> When M4 is kicked by SCFW, M4 runs in its own hardware
>>>>>>>>> partition, Linux could only do IPC with M4, it could not
>>>>>>>>> start, stop, update image.
>>>>>>>>>
>>>>>>>>> We disable recovery reboot when M4 is managed by SCFW,
>>>>>>>>> because remoteproc core still not support M4 auto-recovery
>>>>>>>>> without loading image.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/remoteproc/imx_rproc.c | 108
>>>>>>>>> ++++++++++++++++++++++++++++++++-
>>>>>>>>>    1 file changed, 107 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/remoteproc/imx_rproc.c
>>>>>>>>> b/drivers/remoteproc/imx_rproc.c index
>>>>>>>>> 7cc4fd207e2d..bcba74e90020
>>>>>>>>> 100644
>>>>>>>>> --- a/drivers/remoteproc/imx_rproc.c
>>>>>>>>> +++ b/drivers/remoteproc/imx_rproc.c
>>>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>>>    #include <linux/arm-smccc.h>
>>>>>>>>>    #include <linux/clk.h>
>>>>>>>>>    #include <linux/err.h>
>>>>>>>>> +#include <linux/firmware/imx/sci.h>
>>>>>>>>>    #include <linux/interrupt.h>
>>>>>>>>>    #include <linux/kernel.h>
>>>>>>>>>    #include <linux/mailbox_client.h> @@ -59,6 +60,8 @@
>>>>>>>>>    #define IMX_SIP_RPROC_STARTED        0x01
>>>>>>>>>    #define IMX_SIP_RPROC_STOP        0x02
>>>>>>>>>
>>>>>>>>> +#define IMX_SC_IRQ_GROUP_REBOOTED    5
>>>>>>>>> +
>>>>>>>>>    /**
>>>>>>>>>     * struct imx_rproc_mem - slim internal memory structure
>>>>>>>>>     * @cpu_addr: MPU virtual address of the memory region @@
>>>>>>>>> -89,6
>>>>>>>>> +92,10 @@ struct imx_rproc {
>>>>>>>>>        struct work_struct        rproc_work;
>>>>>>>>>        struct workqueue_struct        *workqueue;
>>>>>>>>>        void __iomem            *rsc_table;
>>>>>>>>> +    struct imx_sc_ipc        *ipc_handle;
>>>>>>>>> +    struct notifier_block        rproc_nb;
>>>>>>>>> +    u32                rproc_pt;    /* partition id */
>>>>>>>>> +    u32                rsrc_id;    /* resource id */
>>>>>>>>>    };
>>>>>>>>>
>>>>>>>>>    static const struct imx_rproc_att imx_rproc_att_imx93[] =
>>>>>>>>> { @@ -117,6
>>>>>>>>> +124,18 @@ static const struct imx_rproc_att
>>>>>>>>> +imx_rproc_att_imx93[] = {
>>>>>>>>>        { 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
>>>>>>>>>
>>>>>>>>> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] =
>>>>>>>>> +{
>>>>>>>>> +    { 0x08000000, 0x08000000, 0x10000000, 0 },
>>>>>>>>> +    /* TCML/U */
>>>>>>>>> +    { 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN |
>>>>>>>>> +ATT_IOMEM },
>>>>>>>>> +    /* OCRAM(Low 96KB) */
>>>>>>>>> +    { 0x21000000, 0x00100000, 0x00018000, 0 },
>>>>>>>>> +    /* OCRAM */
>>>>>>>>> +    { 0x21100000, 0x00100000, 0x00040000, 0 },
>>>>>>>>> +    /* DDR (Data) */
>>>>>>>>> +    { 0x80000000, 0x80000000, 0x60000000, 0 }, };
>>>>>>>>> +
>>>>>>>>>    static const struct imx_rproc_att imx_rproc_att_imx8mn[] =
>>>>>>>>> {
>>>>>>>>>        /* dev addr , sys addr  , size        , flags */
>>>>>>>>>        /* ITCM   */
>>>>>>>>> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
>>>>>>>> imx_rproc_cfg_imx8mq = {
>>>>>>>>>        .method        = IMX_RPROC_MMIO,
>>>>>>>>>    };
>>>>>>>>>
>>>>>>>>> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp =
>>>>>>>>> +{
>>>>>>>>> +    .att        = imx_rproc_att_imx8qxp,
>>>>>>>>> +    .att_size    = ARRAY_SIZE(imx_rproc_att_imx8qxp),
>>>>>>>>> +    .method        = IMX_RPROC_SCU_API, };
>>>>>>>>> +
>>>>>>>>>    static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp =
>>>>>>>>> {
>>>>>>>>>        .att        = imx_rproc_att_imx8ulp,
>>>>>>>>>        .att_size    = ARRAY_SIZE(imx_rproc_att_imx8ulp),
>>>>>>>>> @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct
>>>>>>>>> rproc
>>>>>>>> *rproc)
>>>>>>>>>        mbox_free_channel(priv->rx_ch);
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> +static void imx_rproc_put_scu(struct rproc *rproc) {
>>>>>>>>> +    struct imx_rproc *priv = rproc->priv;
>>>>>>>>> +    const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>>>>>>>>> +
>>>>>>>>> +    if (dcfg->method != IMX_RPROC_SCU_API)
>>>>>>>>> +        return;
>>>>>>>>> +
>>>>>>>>> +    if (!imx_sc_rm_is_resource_owned(priv->ipc_handle,
>>>>>>>>> priv->rsrc_id))
>>>>>>>>> +        return;
>>>>>>>>> +
>>>>>>>>> +    imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
>>>>>>>> BIT(priv->rproc_pt), false);
>>>>>>>>> +    imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int imx_rproc_partition_notify(struct notifier_block
>>>>>>>>> +*nb,
>>>>>>>>> +                      unsigned long event, void *group) {
>>>>>>>>> +    struct imx_rproc *priv = container_of(nb, struct
>>>>>>>>> +imx_rproc, rproc_nb);
>>>>>>>>> +
>>>>>>>>> +    /* Ignore other irqs */
>>>>>>>>> +    if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group ==
>>>>>>>> IMX_SC_IRQ_GROUP_REBOOTED)))
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
>>>>>>>>> +
>>>>>>>>> +    pr_info("Partition%d reset!\n", priv->rproc_pt);
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>    static int imx_rproc_detect_mode(struct imx_rproc *priv)
>>>>>>>>> {
>>>>>>>>>        struct regmap_config config = { .name = "imx-rproc" };
>>>>>>>>> @@ -689,6
>>>>>>>>> +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc
>>>>>>>>> +*priv)
>>>>>>>>>        struct arm_smccc_res res;
>>>>>>>>>        int ret;
>>>>>>>>>        u32 val;
>>>>>>>>> +    u8 pt;
>>>>>>>>>
>>>>>>>>>        switch (dcfg->method) {
>>>>>>>>>        case IMX_RPROC_NONE:
>>>>>>>>> @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
>>>>>>>> imx_rproc *priv)
>>>>>>>>>            if (res.a0)
>>>>>>>>>                priv->rproc->state = RPROC_DETACHED;
>>>>>>>>>            return 0;
>>>>>>>>> +    case IMX_RPROC_SCU_API:
>>>>>>>>> +        ret = imx_scu_get_handle(&priv->ipc_handle);
>>>>>>>>> +        if (ret)
>>>>>>>>> +            return ret;
>>>>>>>>> +        ret = of_property_read_u32(dev->of_node,
>>>>>>>>> +"fsl,resource-id",
>>>>>>>> &priv->rsrc_id);
>>>>>>>>> +        if (ret) {
>>>>>>>>> +            dev_err(dev, "No fsl,resource-id property\n");
>>>>>>>>> +            return ret;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        /*
>>>>>>>>> +         * If Mcore resource is not owned by Acore
>>>>>>>>> +partition, It is
>>>>>>>> kicked by ROM,
>>>>>>>>> +         * and Linux could only do IPC with Mcore and nothing else.
>>>>>>>>> +         */
>>>>>>>>> +        if (imx_sc_rm_is_resource_owned(priv->ipc_handle,
>>>>>>>>> +priv-
>>>>>>>>> rsrc_id))
>>>>>>>>> +            return 0;
>>>>>>>>
>>>>>>>> If imx_sc_rm_is_resource_owned() return '1' than the remote
>>>>>>>> processor is under Linux's control and what follows below is
>>>>>>>> not needed.
>>>>>>>> That is also
>>>>>>>> coherent with the comment in [1].
>>>>>>>
>>>>>>> Case 1: If M4 is owned by Linux, here directly return 0.
>>>>>>> Case 2: If M4 is not owned by Linux, the following code after
>>>>>>> this line will set state as RPROC_DETACHED.
>>>>>>
>>>>>> I understand that part.
>>>>>>
>>>>>>>
>>>>>>> Patch 3/6(this patch) is only to support case 2.
>>>>>>> Patch 4/6 is to support case 1.
>>>>>>>
>>>>>>
>>>>>> Let's leave the subsequent patches alone for now.
>>>>>>
>>>>>>>>
>>>>>>>> That is in contrast with what is happening in
>>>>>>>> imx_rproc_put_scu().  There, if the remote processor is _not_
>>>>>>>> owned by Linux than the condition returns without calling
>>>>>>>> imx_scu_irq_group_enable() and
>>>>>>>> imx_scu_irq_unregister_notifier().  That seems to be a bug.
>>>>>>>
>>>>>>> No. The two functions only needed when M4 is in a separate
>>>>>>> hardware partition.
>>>>>>>
>>>>>>> The scu irq is only needed when M4 is out of linux control and
>>>>>>> need some notification such as M4 is reset by SCU(System Control
>>> Unit).
>>>>>>> That linux got
>>>>>>> notification that M4 is reset by SCU.
>>>>>>
>>>>>> I also understand that part.
>>>>>>
>>>>>> What I am underlining here is that when the M4 is independent,
>>>>>> function
>>>>>> imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are
>>>>>> called but their cleanup equivalent are not called in
>>>>>> imx_rproc_put_scu() because of the '!'
>>>>>> in the if() statement.
>>>>>
>>>>> you are right, this is bug in my side. It should be as below based
>>>>> on patch 3/6.
>>>>>
>>>>> diff --git a/drivers/remoteproc/imx_rproc.c
>>>>> b/drivers/remoteproc/imx_rproc.c index bcba74e90020..a56aecae00c6
>>>>> 100644
>>>>> --- a/drivers/remoteproc/imx_rproc.c
>>>>> +++ b/drivers/remoteproc/imx_rproc.c
>>>>> @@ -713,7 +713,7 @@ static void imx_rproc_put_scu(struct rproc
>>>>> *rproc)
>>>>>           if (dcfg->method != IMX_RPROC_SCU_API)
>>>>>                   return;
>>>>>
>>>>> -       if (!imx_sc_rm_is_resource_owned(priv->ipc_handle,
>>>>> priv->rsrc_id))
>>>>> +       if (imx_sc_rm_is_resource_owned(priv->ipc_handle,
>>>>> +priv->rsrc_id))
>>>
>>> Indeed, which raises questions about how this patchset was tested.  And it
>>> is not the first time we touch base on that.
>>
>> Patch 4/6 has this change, anyway I should not mix patch 3,4 here.
>>
>>>
>>>>>                   return;
>>>>>
>>>>> Thanks for detailed reviewing.
>>>>
>>>> If you are fine with this change, I could send out V6. Anyway, I'll
>>>> wait to see if you have other comments in this patchset.
>>>>
>>>
>>> I am out of time for this patchset and as such will not provide more
>>> comments on this revision.
>>
>> Sure. Thanks for your time. Since you have applied the attach recovery
>> part, next version will enable this feature in imx rproc.
>>
> 
> I would rather not.  Please introduce support for the recovery in
> another patchset, once this one has been merged.

I pushed the button too early, sorry. V6 was out yesterday, but the new
patch 7/7 is an incremetenl patch to enable attach recovery.

You could ignore patch 7/7 in V6, I will reply their to note. patch 
[1-6]/7 is to achieve same as V5 patchset.

If you need to send V7 which just drop patch 7/7 in V6, please let me know.

Thanks,
Peng.

> 
>> Thanks,
>> Peng.
>>
>>>
>>>> Thanks,
>>>> Peng.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Peng.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> There is also a problem in patch 4/6 associated to that.
>>>>>>>
>>>>>>> If the upper explanation eliminate your concern, "a problem in
>>>>>>> patch 4/6" should not be a problem.
>>>>>>>
>>>>>>> When M4 is owned by Linux, Linux need handle the power domain.
>>>>>>> If M4 is not owned
>>>>>>> by Linux, SCU firmware will handle the power domain, and Linux
>>>>>>> has no permission to touch that.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Peng
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Mathieu
>>>>>>>>
>>>>>>>>
>>>>>>>> [1].
>>>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2
>>>>>>>> F%2Felixir
>>>>>>>> .bootlin.com%2Flinux%2Fv6.0-
>>>>>>>>
>>> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=
>>>>>>>> 0
>>>>>>>>
>>> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
>>>>>>>>
>>> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
>>>>>>>>
>>> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>>>>>>>>
>>> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
>>>>>>>>
>>> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
>>>>>>>> =0
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +        priv->rproc->state = RPROC_DETACHED;
>>>>>>>>> +        priv->rproc->recovery_disabled = true;
>>>>>>>>> +
>>>>>>>>> +        /* Get partition id and enable irq in SCFW */
>>>>>>>>> +        ret =
>>>>>>>>> +imx_sc_rm_get_resource_owner(priv->ipc_handle,
>>>>>>>> priv->rsrc_id, &pt);
>>>>>>>>> +        if (ret) {
>>>>>>>>> +            dev_err(dev, "not able to get resource
>>>>>>>>> +owner\n");
>>>>>>>>> +            return ret;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        priv->rproc_pt = pt;
>>>>>>>>> +        priv->rproc_nb.notifier_call =
>>>>>>>>> +imx_rproc_partition_notify;
>>>>>>>>> +
>>>>>>>>> +        ret =
>>>>>>>>> +imx_scu_irq_register_notifier(&priv->rproc_nb);
>>>>>>>>> +        if (ret) {
>>>>>>>>> +            dev_warn(dev, "register scu notifier
>>>>>>>>> +failed.\n");
>>>>>>>>> +            return ret;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        ret =
>>>>>>>> imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
>>> BIT(priv-
>>>>>>>>> rproc_pt),
>>>>>>>>> +                           true);
>>>>>>>>> +        if (ret) {
>>>>>>>>> +
>>>>>>>>> +imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>>>>>>> +            dev_warn(dev, "Enable irq failed.\n");
>>>>>>>>> +            return ret;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        return 0;
>>>>>>>>>        default:
>>>>>>>>>            break;
>>>>>>>>>        }
>>>>>>>>> @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct
>>>>>>>>> platform_device
>>>>>>>>> *pdev)
>>>>>>>>>
>>>>>>>>>        ret = imx_rproc_clk_enable(priv);
>>>>>>>>>        if (ret)
>>>>>>>>> -        goto err_put_mbox;
>>>>>>>>> +        goto err_put_scu;
>>>>>>>>>
>>>>>>>>>        INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>>>>>>>>>
>>>>>>>>> @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct
>>>>>>>>> platform_device
>>>>>>>>> *pdev)
>>>>>>>>>
>>>>>>>>>    err_put_clk:
>>>>>>>>>        clk_disable_unprepare(priv->clk);
>>>>>>>>> +err_put_scu:
>>>>>>>>> +    imx_rproc_put_scu(rproc);
>>>>>>>>>    err_put_mbox:
>>>>>>>>>        imx_rproc_free_mbox(rproc);
>>>>>>>>>    err_put_wkq:
>>>>>>>>> @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
>>>>>>>> platform_device
>>>>>>>>> *pdev)
>>>>>>>>>
>>>>>>>>>        clk_disable_unprepare(priv->clk);
>>>>>>>>>        rproc_del(rproc);
>>>>>>>>> +    imx_rproc_put_scu(rproc);
>>>>>>>>>        imx_rproc_free_mbox(rproc);
>>>>>>>>>        destroy_workqueue(priv->workqueue);
>>>>>>>>>        rproc_free(rproc);
>>>>>>>>> @@ -852,6 +957,7 @@ static const struct of_device_id
>>>>>>>> imx_rproc_of_match[] = {
>>>>>>>>>        { .compatible = "fsl,imx8mm-cm4", .data =
>>>>>>>> &imx_rproc_cfg_imx8mq },
>>>>>>>>>        { .compatible = "fsl,imx8mn-cm7", .data =
>>>>>>>> &imx_rproc_cfg_imx8mn },
>>>>>>>>>        { .compatible = "fsl,imx8mp-cm7", .data =
>>>>>>>> &imx_rproc_cfg_imx8mn },
>>>>>>>>> +    { .compatible = "fsl,imx8qxp-cm4", .data =
>>>>>>>> &imx_rproc_cfg_imx8qxp },
>>>>>>>>>        { .compatible = "fsl,imx8ulp-cm33", .data =
>>>>>>>> &imx_rproc_cfg_imx8ulp },
>>>>>>>>>        { .compatible = "fsl,imx93-cm33", .data =
>>>>>>>>> &imx_rproc_cfg_imx93 },
>>>>>>>>>        {},
>>>>>>>>> --
>>>>>>>>> 2.37.1
>>>>>>>>>
