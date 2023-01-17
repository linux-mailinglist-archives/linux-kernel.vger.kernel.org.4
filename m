Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282466DBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjAQLGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjAQLFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:05:54 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184F3252F;
        Tue, 17 Jan 2023 03:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpPh0wX17CuN3GYW7YqlQ3jlTVC7vp7NwkcctVmhvyI4iHakrjwBC7rwU5Xle3rzeZHjbXcSuhLiqT1wWtgwpRRhjZ+UiRwh8S2NM+7IAGd1ZGO2CmR21HaseZof01hUnR7oaSj9jdmqPo1yp2E57T5jpEOnu9ARKxf4cm0okwvvltFj5d/qrXJrJ44kS2smec+OnvycTO/eWSXiFJXN9nIhcTZJyaRNo+zTmMMwIU4IGeZnhBLiPqBQs6MOk22A9XfIpc7dvvD4CTetxX95/W8qRTE5yC1Ll+7SVfeGw/NtDJnhEU7x1J0iQOzyU7rfYgX7gcAtT36KRomMpO1g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF1ReVoipSviDNh72W02zjF4ntKrrTbNrxbMl8zUSFI=;
 b=luJJ2EkcMiRmL67o2G0Eqh+uwXrAYunG/djFORni9uLrqUceSj86FaofoYULOjlB4BZuqgZTrmofz3pMmB50e5rG35rMzu0VIn9Aip80UkQFUj9Udc7pP7iwX8A55+G9Ohou4rQNNSKYV3st+h/iq5eAXey1iGfd454E/2ARH2zKT/wsKYRzYlpwmHCAeSijR8Vzk7bhA5/mjwsWWXCXXUxsYRhkt1SSMomI/KqOCM5loXpb97BroGjyaO4UyzlHu1Kb9cYdksKtc89Swb+U/k69MzRxDqNijy7tAFMvNWs9XnrxeAHyTmuXCgsuVf0N6+JmYZkLREucTn2MHggZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF1ReVoipSviDNh72W02zjF4ntKrrTbNrxbMl8zUSFI=;
 b=FW1MVXPVuHJh09D5Os20vjNaDWr0ROENAOiXUFseFOorALDoMm9YqoEPZgFzdPM+MaiI+kE5hHbujn7FhTkmjUVmmEzbmEftSaDzHgFgkWT81Ig4BRo+iKs/EiB14rkE52paEXO1DuZDWHmrqWHxDMT6NtV4o6nWefcJdrMflks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 11:05:44 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 11:05:44 +0000
Message-ID: <e95a0155-54b6-5aaa-ab4e-10cc3a74f1b6@nxp.com>
Date:   Tue, 17 Jan 2023 13:05:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: add module parameter to ignore
 ready flag from remote processor
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230116225343.26336-1-iuliana.prodan@oss.nxp.com>
 <CAEnQRZDXPtE096aPHRcggdzeha5MeUaWsXqncYE33cdYBByV6Q@mail.gmail.com>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <CAEnQRZDXPtE096aPHRcggdzeha5MeUaWsXqncYE33cdYBByV6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:205:1::43) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: ecabc197-4724-4603-a333-08daf87ac770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nt0/fQh2YW9wuU04QmyWYoaxHYX04x/U1OxhFHxJ6/cwRnDBpWLXiv4NivalIxYlx0TgjApctRpnMCod7J4i1nbJ5CScCybH0iiEc5Nw4ftC+MAUMYuVVC9utvEF5GCNfKIXQ1JzNE2E3cgmVh6+TL4AKvO9+jhGS8O1rL3Fi4HnPOttFZUGXtAvMGFAatzFxV+A36n3r6DIOeUNcUUN14P3xJRaav9IRQgfwKQe+7Sisa+md2epbDLCAtbuhvkQYdbUE7zzz9YpLlPul7TLPTi7gHGiaKeWPePfLFLr0lwBF2UJo/SeCF2hREzMLvsH2OzuKZAhc/nFSkYVx78gf1KYWwC1EJf2YCJt9ii03rwPIu7q4coE20TogxTj8YjIuxg82XfgIdeT6zXvAJclxIowaREjjT1GhySOV0W99Hp/OVs2TIL/wAMy4RvYM8I1hyjOOysE/Z0XzkOykCd81mZ8EV267TbJeOh4qpupQjQLwd6HJDNWGvMOhcMyrnuOMWtj+T6ojQ9iCxBf6sL2r7F+XW68RltcmuhYa4/1+x6A3GjcythRVW6lgiaDhCVQk8EeYxbQyruBEkLau5+fCRfjoc62qvkSs0+uhpyDrpk5VPizVTTZcnE1n+GI9D37lkSC0ck67bRnFC4yOBkPQYRg+aYuekef4Q3ESxojYsKHWHXk6eNsDWq3+ZkSiGXcu7GZBhGCai8TB7Ih+yvM8UmlNNRZHDSYqTXDl6EICL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(44832011)(4744005)(7416002)(5660300002)(8936002)(31686004)(2906002)(36756003)(4326008)(86362001)(66556008)(8676002)(66946007)(66476007)(54906003)(316002)(31696002)(110136005)(41300700001)(2616005)(26005)(6486002)(186003)(53546011)(6512007)(6506007)(38100700002)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXovSitybmJRWVZDUGV6QjNoLzNPVlM5ZGU3cUhERXJEaDlxc09Ibm1salFw?=
 =?utf-8?B?RjdCcHJLT3UyamsrSFJkNE1nNGR2RUc2SFlnbGNIa2Y1U3FGQWRsbCtZSTJU?=
 =?utf-8?B?U2NYMFFyaWEzdTVFaTN3R0cyTFlrSUt4Z2g0QWZDek42NTAwd21JWDl5cEVm?=
 =?utf-8?B?T3dIbmE4eGErbE5DTWlNaHlhRFAxckczeHNSN0N5RlBWMUJWSFBJRndrVXIw?=
 =?utf-8?B?VHJ2QXd4amMyb3BYYiswYjdiYkdHbzNncjdUN3JOKzZ5RDk0a2VxczNPOWNw?=
 =?utf-8?B?UzhyWUJpck9TYjl4MDBBOGtMTUcydVFGb1IyUzczU0lOUHljbnZ5ZzRZbm03?=
 =?utf-8?B?bkhFVVFab1BtZkZkRkp0VDVQeEJkYXRIY3llYnQyR3hHZ0piZ2s0ME5WWW5k?=
 =?utf-8?B?MittL2RVckNuc3ZuaS8zNzBBZHV3c1Bza2ZZUzVvUGhJbVh5Ui9zek9uL0Np?=
 =?utf-8?B?ZUxaRUIyRVZ5R3ZRd2hHKzgxK3RzbVQ3SGNnVlNNN0FLc1VmRXE1OWxtYzFK?=
 =?utf-8?B?MUY3eC9MTWtwRDhaTm52amZlSm1DeEZFbWtHMFgvTEpVc3c2aVZON3ErK0xa?=
 =?utf-8?B?c1hkWFdYNitTa3ZRaTg0QjhHelBHMllwWW10RDZSU1N2Vy9hVElzUHd2aE1N?=
 =?utf-8?B?ejJSQ21pTFNCMXZabExHc2Fuam5UckVQTHdyMW9BSlZqRnpEbWlJenZlNHh3?=
 =?utf-8?B?SFMrUm9tZVRoUkpOQ29VejgzcnhJejdNNVhGd29oN1l0NHlVNnhkZ1hpcDF0?=
 =?utf-8?B?TGx6eVBCRGVtNE9kd3lVd0I3Qk50c2JhZGVwWGRQb2tBd2Uvc3VVTmJFLzE0?=
 =?utf-8?B?YkJ6d3hYdkhaakhyYU4wT2VJT0xBa05yNzZNVjMxa3dJMXJ4WWl3c2dySE8v?=
 =?utf-8?B?K2pRTXM3UjNJck1pZmxaVmwyeGQ2Kys5dWIrU3UxVmhaUVRWZzNncVprTHVi?=
 =?utf-8?B?TlNHdGNuemZ5STdGQVRFTWN5SlVsL09uOGZOcXdWSlpGamhVbVpOWXp2UXBq?=
 =?utf-8?B?ZDFLR2FYWmtiVFg3Uk5oSG5YdmFJM0dpbE9BWUlBUGZFNGpsS2xkWlBWd0pz?=
 =?utf-8?B?NDRYOFYzYVB5R2V2ZlFvNW9lMmhTUnVsZGFYRmdxK1o0NGJjRWY3ckx3a3Iy?=
 =?utf-8?B?NFhqWVBEeEFEQlNQZHZhWGV2Ykw5UWhPdGYrSFRxQUpxSHZNeW1GZ2lsb09n?=
 =?utf-8?B?UW9qYm5uaDljdHhVa3dHNGdjbkRpU0syT1FoTVBBaUNIdSt5TFkzNEg1eE1l?=
 =?utf-8?B?d09VTU9VSThGc3ZWLzZDTzlzQ055YnZDVjMwT1Q0Y3dCaTRoM0FiNGEzWkRL?=
 =?utf-8?B?SHVKUkw2MlJwSzNONVhDaGl0c2pIdDhHTXAycllzbHBGMjRQQXJYZzNyQ1pE?=
 =?utf-8?B?Y2J1L1Z4M3JHbVNWR2lQblk1a0dlMzFtTVMva2tOc3M0MWJuWWlCT0JvQ1F4?=
 =?utf-8?B?Y2F2WTg5Syt6eFRuRzdqNmh0U3pneVVSVUF0VmJSRzJ4RFVsWnIrVUcwZWw5?=
 =?utf-8?B?akNoZndyazNaZmMzL003aFdsbU5zU1NtMmgyTTlkRHltaTRaTWdMNEZYem9s?=
 =?utf-8?B?Nlh6ZFhLaWNhUkhIbHY0Rnp5NEw2TENuYnhNQllVc3RTeFQ4dnlOQlNPMGox?=
 =?utf-8?B?OUdVU1N4aUFOTzR0TkxycXIvUkgrTm5RQUlHcXVSSlNyMUVYaDYzNm1iNmJ4?=
 =?utf-8?B?L1pqSGJjQ0VhZlp6ZXFGUWc2d25oRGhXVU1ocU5aNmRPNWwzMVhEeXhmK3F0?=
 =?utf-8?B?QTM4Tnc0MUcxVWQxdmp4TDlvNmQraVl4ZDhsVklZSXdvTUdyTEROWUxQcm82?=
 =?utf-8?B?SEYzanZPa21LMXlIcERyZ05sSlRidHRKTE5zd1VhZTJ2WkpWTEQ2QlpwbHJZ?=
 =?utf-8?B?by9VeHlRU05CQ09WRUVFbXlvQXNDeU9vWEl1T0FhTFhOdlFWQkVkeDd3UFRh?=
 =?utf-8?B?ZTdsLy81eXJqUzRHWmgyc0FReHdPdFdtUU1FWDlVRk1UTHIwemY2VUpqSG15?=
 =?utf-8?B?bnR5cXRzOEpiVjRna1J2Y2VLcEhVOGJOZ1FLT21kS0VSdHlhWDVGdDVvQ0Nh?=
 =?utf-8?B?Vy9oRFIzcWhEcG9sdmtCV2tFQ3hTWStubmRtcDlMS1ZEVkRBYjRiV3YzbUp2?=
 =?utf-8?B?b05oc0FUeGhzc1JEVU5mbFdOVmp4aGpEUjJGY2JqeDNZMitpLzZ3WFBDc0hD?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecabc197-4724-4603-a333-08daf87ac770
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:05:44.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX0bTPmIdSFH47Or19aKeBq15fCDzUPXxQ5dUk2pXTwgAZD+Igqvaed/99NU+LDslPRkAbABvvmfF8WlBKCwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 11:28 AM, Daniel Baluta wrote:
> On Tue, Jan 17, 2023 at 1:21 AM Iuliana Prodan (OSS)
> <iuliana.prodan@oss.nxp.com> wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> There are cases when we want to test a simple "hello world"
>> application on the DSP and we don't have IPC between the cores.
>> Therefore, skip the wait for remote processor to start.
>>
>> Added "ignoreready" flag while inserting the module to ignore
>> remote processor reply after start.
>> By default, this is off - do not ignore reply from rproc.
> I think that ignore_dsp_ready would be a clearer name flag.

Done, I've sent a v3.

Thanks,

Iulia

