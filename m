Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982FE734191
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjFQOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjFQOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:09:53 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559FB173D;
        Sat, 17 Jun 2023 07:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnc4DbQ7uHFDyAE+2p8ogzPR02+X3j4EMuYEUqqrUVlH5hJ9I1Z6/UaXWN1WVYoZ4PO1hbXJbm0+ISx1TPPP0Fil5g/qRGzyqA3W8cZIidqYquo6IQxz0nVoibesutq/0eXqyCSeJCb/WXNhpTvX3QcOr/YuBjSHX58bQZ7c4SoFgBWxBC8flfJxacOWnOT8LS/skmpt6N95LKdCdl2ndEmSnCC173tpLDJropEtTWNXc15WOsYvqXzvxSKCG3V9B2tFgOlD2HlQu5cdNumFfdT7fBuM0XZ1dYqPGuHzlI3mjnTFE5tUMEQPufteVZv23goR14J8nqzKO13BmPCK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv6BnQv6Zl0kIfdatTGo5+gKijq2w9oKvwN2227i8fk=;
 b=Brz9wRShU8fyNkh+PJGDpk0FwHY/+2vEeI+5p34jjffsq43xDxFolXo6lExtn+6gVG6XAWYUe6vmfHMN/+Xm6eT2PaPditWbqayVENVLQ6n5bsspQRwT17YIFAO3nn9B1vny1gSmnnIYy8thwaPJR7h/aLryQ8CLnxcrM66HmkoQjab8jf55MeRULcJ1kz5SnG3iiEMzFZX8M1kJ470EtynMkg+aoSS5sw3v6ydhx/pDAQwrHEUxDcOnOobOtR5DISEAyN3PhO7NRIVEXboDld2xJs8p1bJkonDH+4cgK/m4cY2XWbIFcKvXU8l4wCbyjL8+GEQt9r3G8VpcSjXsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv6BnQv6Zl0kIfdatTGo5+gKijq2w9oKvwN2227i8fk=;
 b=E5pddAgH9akDpCZbYrmu0p9vZ0Jw3kTlQtMX2x3PAWIcBBX0yZ1sJCRF8G+thIIhpE4fnnB9BHoKegs9+33GuUn7CmTfirzA2wsObfgl89qZpLzWtWZSJvPJznv5Lz+EYD3FBNwIq4kUyp4mnAYmHF0C7C0zA30dmsrKjxL6EL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM8PR04MB7250.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.32; Sat, 17 Jun
 2023 14:09:47 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 14:09:47 +0000
Message-ID: <b91576d1-a026-3c7e-955b-b36182cbc2c7@solid-run.com>
Date:   Sat, 17 Jun 2023 17:09:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog
 Board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-3-josua@solid-run.com>
 <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
 <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
 <f6283bf7-2c38-8257-e430-d17dd4dd233b@linaro.org>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <f6283bf7-2c38-8257-e430-d17dd4dd233b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM8PR04MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1260d2-6e10-4de6-50ea-08db6f3c8208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfVx7frLuBGUU9REhH6SNEmqyX8fb7Esl8dSkbJT92mrHV5AWihkotaE1jqZRRJyyZ0aZElCzNALH+Add6xqFcGgvioi9aatA25EvebqLomaE/AZ7/dV3GLmUT4qjFh8JXaPNgEeAp4XaEjw1VOvF0yR0Ca1c0ZZiKwYJszL6006TS1p6Nuky09vCvvSApJbDJXAsMbVsjUxKb21DENQjzs8HhsZVUQh7OsD4012Xb7sX+/7AdYIPcLtPTAcN+mq1UeLsZEzaHKMlh5bvN1kTx/PKdiYp64N+sSCrk0WsRcSZDUswJpcAIn0B9QJxvtlxHYv60CIvpDgpz7b2J2sIO4EjtMot/FMdlyQJyAkfS+7eDOYiaLStnvQluteobYAK0VNOuofhfjmagvIDP7bWNCsulRQhVpz2t9PEGnCkAKYRzvPM7yw3Vbf7BhDttiDEyf8zJPHf+gEoGJbHt18+Mrg/+zP5BgCSjhFY7/0b8bZRKxQvEPmObfyMQ4tkHvM7GNB6Ou5qrbMdlY/vquLemfvghZomDDJbMOpkXNNLJZ9m12gciQctnHt5CvUXIQgBw8hmjP7OeGMEf6+pl3S3ffWCdBNG/ETkIq0GKrjWXAGVpMYR9+w4lpY76V+OdJW/9I95NxvgXo7S1YtwCqVzXrx6xKufkJ9rxdOBHK3TSZ00ZHq7zD+zlTgAJNp4AQD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39840400004)(136003)(346002)(366004)(451199021)(316002)(4326008)(5660300002)(66556008)(66476007)(8936002)(7416002)(8676002)(66946007)(54906003)(478600001)(41300700001)(31686004)(966005)(6486002)(6666004)(2906002)(4744005)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFvQjNjMUs1Qm1xcnJuaElHT3RrMmVFSTFkYVpEMDdLcXVleUk0bVlxbXhW?=
 =?utf-8?B?MldEdmVnZis5a21lZ0V4OUMwR1JSYlVyeXdjWlltcnFRUUlvZ3RTQmIxYXlM?=
 =?utf-8?B?Szh0K01LZzF3VHFjbEZBcHR2cGJUclpuVXhSYytrNGcvNkNIZzhtZVZsTDVV?=
 =?utf-8?B?clFyWU0rY2Y4elZPbzM0dnNGb2lWYUtlOVBKWHRhQXRCNEIxTlZXckduNWlJ?=
 =?utf-8?B?QjN4VHJRZnFQVWFySXkzYXg1ZGJQcVd1aEFHSlpKdHlBMGhJSHBmZHBJUGhq?=
 =?utf-8?B?RHhDMStpbEpReVlkS1FOYnNUd0VjZmZqdUZUM0x3bzVzSDZta1piMVF0WDd3?=
 =?utf-8?B?NjBvVlpmb2luYmhKQ0JHcHNUYkJXM3A1YWh5cWNoUG9EeDZuZmVodmIyMEkw?=
 =?utf-8?B?SEhaOEN3UUV3YW8rV1c3MXRHWXRqL0FUZkY1d094MGNxZ24xcEVtblE0VTgw?=
 =?utf-8?B?dEY4NUR2VEQwbUxoOUNFMHF0N3g2QklOY3R6SzYxRmNtVmFmTzJobzU1TDF5?=
 =?utf-8?B?YW82d1VaY3JrYll0bGlFYzcyUyt6ei9MUVFha3ovZnk0aythL1p0SUVucHc0?=
 =?utf-8?B?SE9VRFV4dXY3L3JZUWhnM2hyVkZzQ2RxdVpZNnlucGlPVnJiWkJML05LRng4?=
 =?utf-8?B?T1BlUzJ2bnJLTGxtU2Y0SlNKQlA4M2pabm5OeWVUSm9oQkc4QUZQa2ptOG5t?=
 =?utf-8?B?ZE1JTjBNUURRK09UcXFrRHNWVC90QXpMYXptbmhpQXlnUGtEcm9UQytCRXIw?=
 =?utf-8?B?Ri9DMUZtcGRoNXU3ekhlYU9veGYxcHVScjhpY2xEWlFudUQvUlp5Z3k5dTln?=
 =?utf-8?B?SFA0bmMzUzBNeEhVOGtwbEhpTW9td0ZIUGhFQ1RpNFdMMUl0Z3pkQm1aTVNV?=
 =?utf-8?B?TzdwcGIyTkxHeVF5K29aemRyOGdsa3R0TWMxek11SnhsQmU1RWx4OVVqNEdk?=
 =?utf-8?B?VS8wa1FWcGZkVVprK2orUFNtdEZnZmVTbjR2ZDcvclpkNVpCbUtVekJmejVv?=
 =?utf-8?B?VHRxdE44NlFDRmVCd0FHYjd4OXpIZEcvUnkwYjVpN0FLQm5JYm05S1hFdHhi?=
 =?utf-8?B?ajdUb3FXRkE4NjVTdmpPVTNqNnJTWUZkc2dZeVZ2cDErV1JwKzkwQzhpaVg0?=
 =?utf-8?B?czNVL2dEdzBhV1FuN01PQnduc3Q0Q25MZU53bS94WmFWT2cwQmc3RmYzNW5U?=
 =?utf-8?B?Smo3bzVhQlZJc0lMaUhOTDlYemRlU0F0RVBQaExPeVF2OXBXU0hIUkFzRnh3?=
 =?utf-8?B?WEg1eXRpV2JiU2s0VmNHTU5STlBRZWtsL0wxcHJTQnN0RmJXakN4ajRWSkZS?=
 =?utf-8?B?V0hLUlR4aUZHWjlNRXNpbjQ1TWdPTExHUVNrMlZ2Um5kZ0lqMmVwZHExTE9D?=
 =?utf-8?B?cWFZSy91SU9KNVA4T2hRRlRDTncyYS84VDhUN1JMQjkzZHVvNXhIdHNqY3VT?=
 =?utf-8?B?SDJWNkxwazM3MEJOM2VSVzd6bVVuNTdZZnpmR1d4WFFiTnNHdkl0YXd1alI0?=
 =?utf-8?B?bFVrWk10b1lxZ1M5Mm5aVnRKNlhZdkp0S0lEVExvN2IrbkxjS0VHODk0cGdI?=
 =?utf-8?B?S203NUF5MzJCR2JrWEM1b1o3QStKME5vMWxCRXlzRVZ6Y0RudHhWcnlzMG5h?=
 =?utf-8?B?SysvVHJ6SWRmdmpIWEh0ZUNXTlBUWUwyeDRsOWUxYnVoQ2ZjMlA2ZGIwWHdP?=
 =?utf-8?B?b2dFUkVHakg3eTh2SThZQ3dZZHRKVHg3WFZRd0w0MEdVQjhEakJLbHBpaDVn?=
 =?utf-8?B?dGtzRHoyZk5rZWJxMGtMQUV0SERjRGlhNERxbUdtUlkvMnFOYm1lR3Y3SXhy?=
 =?utf-8?B?ZmZNYzZpUlhwYU9rOVZkdGx5VkFhVDR5Q29pU3k2WHo0MkdpSWhvRkgzSW1L?=
 =?utf-8?B?bTBnWEd5N1U0OXRDTEZlb2FtaXpQU0dUSWx1NmZqekRsTXRMRFlrYXcraVov?=
 =?utf-8?B?M1AzNE5RaXkrN1R4Y1pSelFCaXpFdDUxemg1Z1BPbTdtWjdqbHN3aDVZTGdJ?=
 =?utf-8?B?S1dGRlM2WThpMmVyMzVabFVzMDFKaXg5elhoNi85Z3F0Q1FLZXFveFo2bVVB?=
 =?utf-8?B?cXFWNGFMNzFwYlg3K21McjZjVHpNQ1dxNThxYzJuOEFjdVJ2YjBqVlk5aUFD?=
 =?utf-8?Q?+tKuV637dzmb4QInIJTmzc3tQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1260d2-6e10-4de6-50ea-08db6f3c8208
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 14:09:47.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UySjmfJAjeFy8+QFF1oZeNyAi5eTAIxXYElm/tqzrJn4Ag7V/ISbuoo+dUaBLhQfcRch0MjOJz6hlCE2zy3ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7250
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Am 16.06.23 um 19:59 schrieb Krzysztof Kozlowski:
> Test the binding and test DTS against it:
> Please run `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
This was helpful! I ran it a few times and studied the results.
Many complaints related to lx2160a.dtsi, some common among different 
layerscape based dts.
Finally some mistakes of my own.

v2 addresses all that were under my control, and a common one that I 
understood well enough.

> It might point you to answer.
>
> Why do you make solidrun,honeycomb compatible with cex7 and som?

Exactly - unintentional.


> Best regards,
> Krzysztof
- Josua Mayer
