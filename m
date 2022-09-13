Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D95B6CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiIMMQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiIMMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:15:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DDC5FF6A;
        Tue, 13 Sep 2022 05:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCR/0ueS7UU3UcxAkKlDTycPSfQOOLnj92GsmPSmhslkhkZBRnWOqSeDP20QIzj8NEsDMPqU5q1rU2mnu+uxXu/ZhOhU0x2bZ6Tp0dkbyzWoxTBXgw+MBiGfLIcYvUMlUMFs/yJ+8tFNN2Z/bb0IdBBCou6MkRT90LlIbaL3h+BNCxC4DNPIVb1yVBWanylgDC674WnABCj8GZ0Zw9aRhP/0wPHLlkOayPq+x+J6AKp07ZO6woB7xij45/OPcSYV+A8r8be5y2BWeOyzBjB8RnPXnO/fF/NY2thqqTZ6ZKnvrllFd4bj5EhRAuYPETN+xPpyryTR2KeqOWGGAImjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJCkfMXRc3y4+kaNpHQ/N1+zhLT4U+h0OitD5/qiKKk=;
 b=StTNCnbBnEaj8KBlNNULoIMFNsTwvmY2b8bpxHVXsgnvq5BLg+kPFoluG4eCxOWTUWvRMY9p/2O1kDAV4T2TsAG4oDhBAJCpYTrPhnYvA0AJo5M4l/f0YIDI7jrlL1NEkNfEorLbfilM6ydE6BPF41lzOj4oPYLiX9WS+B7JiNhGZBMKRc9hLMSRifBNOG8Vj5sEYNLWIx6WddawdXKQmJsHdbV5cOzNHqz/8991vWjIRDSv4iHb68feYAxD+nK8/XyBZJr9Yo28BtXROvgqpiIX/5WHTG/o2ASaA1xgh86s8xsd7FAWo5KZv0ZlCBqfT9ZFi7OjwC4g3xDSjBvLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJCkfMXRc3y4+kaNpHQ/N1+zhLT4U+h0OitD5/qiKKk=;
 b=KWjxndIU1Fo5rtrn3G/dNdDGj3hCkVk9hrp4Q69DSw6YWkHPdiHnkyX0FbARMrKVNOJdMJLdR6T8UFScGUcvRTc3Vg274zGWw0aztmhRNOFebxyuCIROOQVHtIpq4Y7aO38mZkeBOW9C38Qnn5+bd8LSTS3ZUFIX8aWG9whaE5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 12:15:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 12:15:15 +0000
Message-ID: <52a95490-477f-f1c8-4fe5-9c27e447912e@oss.nxp.com>
Date:   Tue, 13 Sep 2022 20:15:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
 <20220913102957.sir37bsdr5sayxal@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220913102957.sir37bsdr5sayxal@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: e5334706-8ec1-44bc-6366-08da95819d19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nnux6rrZWbS+lAtGU7gXWV5p8IFTUjs3gvFGb8iqsunNR7qohHYe4wyfC62fi9TcLY/T2/ylw9N+Rqru5O6OfiAyn16MGwnYED4zFQt74m6GGJcJwpSHkq+WZ3inhryj+lzcj4XdUdckasP/oIBBSnChdPUWjQLTB2cCqVa3a2zbgtbbA6ILK9nBy+6nrmWRxfaUgHo9cGWXvIAiK3ybxed64HoeRWvtJ6TAHEe0mn4Upilad6Z2ANm4FLlsEakWaUHbBMbbIBQB4FMs7K7XFhqQ5VRhwhqkjdPcNOrj0iRRxtLpbMQTBOcuVW97BY+37ngeWI+MZ+7JGvHjVVQRH4v83W01x5Ljqk4QqN885DxGTimyFxf2GAplYN7F7w6RU6K0TSlgBQBbGn3wnHoR29xJ5Bf4ngTYzjD+Kq+jUI65y6WgDnucRa1m1FiNwMFnUQt78l26NL9WOZRACzm0Homnj3r9cazfntpw2UXip8SFut7XeEXqzQ/bMVSrBJLYo+T+iM3UQyN8Z8o9SpYiQp2ZaJ7Ld/no0dUuniBrdLrzR2/N++pkHm6mhDsJurw+BIeuYBbytj+Tw4cmmHDR8ISKW0TcgouS2rU0D4cZJLUJeg2VtASVYL2TO5mo7N2wJkBPvbn+MYQl2uNmxvGQwkmngH/dVEe4vDUW/1Zv5xigCSsf5ldDLI4j7rIGzdgKmm1Uy6Oyy8kYujWrX1cAgHY8n+slTZaI+KoVjmiMNuLoW7GX80q92WGkJ4FO0IKk+b2dzHY+IE4dsQ0U4n78Zh+PL+F/ACapi84z51bTJU4NBMetKss4s+WhGb0ODLthdXU/Dl/jNRYOZMAmT1Cg93PXqpwocitfy5YgXOg/gvOiu8fK7bB0MCIvVtJrTb352jhYhQsq1OwgEwcPdxDU7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(2616005)(66476007)(6506007)(6666004)(8676002)(7416002)(6486002)(31686004)(2906002)(86362001)(53546011)(6512007)(186003)(8936002)(31696002)(83380400001)(38350700002)(5660300002)(52116002)(38100700002)(6916009)(66556008)(44832011)(316002)(4326008)(66946007)(41300700001)(26005)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FoOUFIbDMrOGFhYmRuVWMvL2NZMEhJUlBPcldZSWt5b25manpFV2xHQ0hH?=
 =?utf-8?B?Wm9yWFhRb0NVS2NRbkNQb1lnbU5KYXRSc3VXYnhPR3ZVd2NrRmxBRWZUYmRx?=
 =?utf-8?B?KzVXbElyWTN5RFNFMU5RajlyWHYwUXRWdWZsMm5JamprN25rQjF3bi9iNHJD?=
 =?utf-8?B?anJLQktUVWt1WDV0eGRaYnZtUE03empESlZRL1NNYUoxNFJybXdOcW1ETlVa?=
 =?utf-8?B?UTdOTzd4ZCtKeFg5V3djVTZBTkRIcFc3SDc2SHdYV2Q4UVh1ai9mMDNjcnFE?=
 =?utf-8?B?RXBBSDJQdzlwQWlDeldDS2FTT2RVdDFWeWYyQ1orMTJGckQxY01pS0NhMHhO?=
 =?utf-8?B?MGlZRktPeVpRaEVubzBpTkUyWVJPQTVZUkR0ckNtdngrRTdETWVqUys0ZE9F?=
 =?utf-8?B?SjdoWGRIbEdZVXVLMkZHZzJYWmp1SU1ML012RW1WdVpmeGJoU0oxYzVoK2Ni?=
 =?utf-8?B?a1JYWTVyODNsUi9WYUUzTFh3MVlrbXlLOVR5a1E4SDlGb2lXMHpseStQVEVZ?=
 =?utf-8?B?TVFxZ3phWEdCRlp1UVB1TFI1ZWwwQnIrOVZYRGZIQnpZRCttQ3dlSDVLTEFl?=
 =?utf-8?B?QWwzMjNzak9iV2FIU2hHZlBleDh2T1VqRnpiUno2WlFRSitXeHRaSkJIdHFK?=
 =?utf-8?B?akVmTlZtNkpVYnNTNDh5SC9JUWgrcjI5WS9UTWxQejhTT1dsd3pmOU9wZ1pR?=
 =?utf-8?B?ZXdHYXgwOTFTcnYwbHpzeE9pYTlKYnF0RTBvM1BnbCswK3o1QURNak1vQTg3?=
 =?utf-8?B?TTgzZzhETnNYaC9iczM4NDlBUWdkd2Mza0cxMm50bzlDb04rN3UvY2F1UWdj?=
 =?utf-8?B?ZEZMTWxlVlVuOUthd25PNzFSTGJmaGtUeGRDczJra05OSm9UeVdjNm5mSEYr?=
 =?utf-8?B?aHNSSnNTcjROWll0R3htcDQ1R2dZMGpIQU4xalg4WS92c2tpYkdtNk14elRX?=
 =?utf-8?B?MWU1WXF0bnExN0hLeXlJQ1JFWkgycXlxZUgvMm9WdkdPb3hQWWxPK1l2SjFS?=
 =?utf-8?B?SjByLzlxQzVseThTRFFBU28wY3dPS3V5NlZ1SzlBbk4xNWlPNHVtdkdmRXly?=
 =?utf-8?B?TTlsNW1RYWlUUHVyempQbEVCdk5lbDZCMXpoQ0hKRlhBL2EzdGgxbGJsd3hp?=
 =?utf-8?B?S0Jmb2dyRVpHNWVIeGpReTJNZ2lWY2ZuRnQwKzhuVEl4eEtjMHduUTJ4UHpk?=
 =?utf-8?B?UWZnYzR5ZGRyNnZJUmJLZW81LzBLaGpUcHJ2RzRtVlczS1Z1UnozQTBHdlcv?=
 =?utf-8?B?cGVyYkwzZCsrMk1WOFFVcCt1cEdHMTJSeWVRdmNKTXdYZzFyeHlsNzJlTk5V?=
 =?utf-8?B?TU4wcUxBYnB4SUtBNGhzeUFDV1gySEFTY09kSXJNMWJ3d1FrTGhLbjVoZGRY?=
 =?utf-8?B?bnhaQjFGZVhkeHhaOGJ3MDVkK2p1WlNidnh4OGxoejlWQll1RytiVklLQnhI?=
 =?utf-8?B?RDBlSEd1N0FuWHFEMkNtVzV6elUwaVU0QXhORThqRmFjblRjNUZVSFdUU2Yx?=
 =?utf-8?B?VjhGVXBJN1NQL2prNGwrVFhnMEVCbG90bW93c2ZvYSs0WDA5QXQrN05PL2dR?=
 =?utf-8?B?Ukw5WlJnVm1YTis3dnhiR1UyRVZ3USt6S0VGeStkU2ZOc1BqOThGMVFDa0Js?=
 =?utf-8?B?Umh0dVNyYlhrS0JFNHd1SnIwMUx0M1BJWGx5OFJqalprbnpXOGo5UzZ0VHhG?=
 =?utf-8?B?ZEhTR3hVNm12VmxYR3pjY3JyMFFCZ1NjRVh6ckhtQUo4N0g2OXN6Z2huMEhW?=
 =?utf-8?B?VkM1NG4xN0grWkNtNjNTK3F1NFNuTmZtdWlHOXVSS1FSNjlmTEFsV2h0TGZa?=
 =?utf-8?B?eUZJRW5iUXB0c09RV1ZIcENLOUgxUG41a21PNFR5ajZPaDIzemthMm9oZUpa?=
 =?utf-8?B?TEp4aXZCNE5mR3YySVRpaTVpSTdmbmZoeUJYcEp3TE9QaWVncEk2MG5YdFRG?=
 =?utf-8?B?L1FKaUtXZWNJNUROWEJaTnlpY1JZQVE3YkhLeCtQM1JnaEpjNWk2MkNFTlYz?=
 =?utf-8?B?TTdVSjhkV0pmalBmZjVoTHZGVWkyOGxnS0VoeEFYVUJobnRrRnNJN0NDSzhS?=
 =?utf-8?B?dTZuOXBuMVZIN1dHa1FNMnVGNTJ5NFVaRUMwdERxSFVPWDcwTmZUTDVYNE41?=
 =?utf-8?Q?Ha3GK0a+PvNNf5rC+p+jI5fHQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5334706-8ec1-44bc-6366-08da95819d19
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 12:15:15.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZkTYifyP7COXlzNHk+i0DeaF8xszAxNkyYRw21rJyblnMFlQUHHeWNXN9dqIUth3C9YIov/jg5UGRks/lppGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2022 6:29 PM, Marco Felsch wrote:
> Hi Peng,
> 
> On 22-09-13, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V3:
>>   Rename to fsl,always-on-clocks
>>
>> V2:
>>   Use protected-clocks
>>   https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/
>>
>> V1:
>>   Use fsl,protected-clocks
>>   https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/
>>
>> There are two cases that I wanna this property could serve:
>> Virtualization: root cell linux run in parallel with inmate cell
>> AMP: M7/4 runs in parallel with A53
>>
>> The major case is:
>> Jailhouse hypervisor only support partition, so devices are partitioned.
>> But there is only CCM module that provides clock, the CCM is handled by
>> root cell linux, need make sure the root cell linux not shutdown the
>> clocks using by inmate cell.
>>
>> I was thinking whether need to provide a rate entry to ask root cell
>> configure the clk rate for inmate cell. But NXP downstream not have it,
>> see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
>> So just leave the property as uint32-array.
> 
> Can you please check my recent proposal? I recently stumbled over such
> an issue on the mx8mm-evk as well but with the 32k clock provided by the
> pmic. Unfortunately I forgot to add you to the to list, I will change
> that. If that proposal will fix your problem, I would like to go the
> generic way.

I vote for a generic solution.

Thanks,
Peng.

> 
> https://patchwork.kernel.org/project/linux-clk/list/?series=676522
> 
> Regards,
>    Marco
> 
> 
>>
>> This patchset could also benifit AMP case, check the two commits
>> commit 19565ea12d61 ("clk: imx: add mcore_booted module paratemter")
>> commit d097cc045b64 ("clk: imx8mp: remove SYS PLL 1/2 clock gates")
>> Although I not plan to drop the upper two patches, this patchset
>> exposes opportunity for better power consumption.
>>
>> Peng Fan (2):
>>    dt-bindings: clock: imx8m/imx93: introduce fsl,always-on-clocks
>>      property
>>    clk: imx: support fsl,always-on-clocks
>>
>>   .../bindings/clock/imx8m-clock.yaml           |  4 ++++
>>   .../bindings/clock/imx93-clock.yaml           |  4 ++++
>>   drivers/clk/imx/clk-imx8mm.c                  |  2 ++
>>   drivers/clk/imx/clk-imx8mn.c                  |  2 ++
>>   drivers/clk/imx/clk-imx8mp.c                  |  2 ++
>>   drivers/clk/imx/clk-imx8mq.c                  |  2 ++
>>   drivers/clk/imx/clk.c                         | 21 +++++++++++++++++++
>>   drivers/clk/imx/clk.h                         |  2 ++
>>   8 files changed, 39 insertions(+)
>>
>> -- 
>> 2.37.1
>>
>>
>>
