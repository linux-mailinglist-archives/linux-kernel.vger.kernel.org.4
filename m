Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D925EEA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiI1XQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiI1XQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:16:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC28FD4A;
        Wed, 28 Sep 2022 16:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPZSKbmPJSoCqQBVxj8de1rdejA3O39HLwRta4MLgOjArTlAXqwJZBMOGCDR1PmeNnGLLKQU2yum79v1aULaUpyKwT/Bj8Feg6VJKAobA6zMqFATwBXPBtXjNwDi+2yyXX6YOoHqAP77xx3unQVgiEiLDwHXnDAQha21ymHQGuPiX1gv8JA5v4E9LXPsc4H8YQ0jwazmBmLFl0ot0zmc/kkPBg0zmF01h/d4g5qPcIgLkR8R6wd1jQFNaW2JHMHBldFnSuQm+iJ8vDh+ko2yzaQvso5we/BDGr5y970yipfma+7oyhhEJhrc5Da7KQJTd8qApEwSizGSgxsdBgb9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC5Z0GBuq6BT2VtYqayhSapWw2kwILKnC+ZCHAipjEA=;
 b=F84viwMg05dh2mJDxmhcHCR++FfY/epa+AuxnqfGQ8qKc6XE0CpU7Wcy8SBoazJEs5Jhx3Dl96G6KuyBK5pdySY9gFvXqhouyfkqvQ5vIzBuPBBoiNDT+uJI0RaKTHnP3cs4j/hkPHTeZvOfCJ/jLOwWIhe5wO/4UJhQ3M0CMYzwNEBY/aqCwSFDfX3SKzNzLlnlmBC5GpDwL7uxtkBDLQyGtbEVY0M3z8stoa1sY5h0fpy0K2vEVAKKRp39xhGPkNkJTghsu3meBNqaVxijawDAEiu2P27PJlGA49I91QT8V3+WvNIzKHo9tLZCg3640AShXaldmMtD9toJjfqYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC5Z0GBuq6BT2VtYqayhSapWw2kwILKnC+ZCHAipjEA=;
 b=T3yK6cc9Mk3o6KvAnlVn6jwS0jtW+9ay7q/5nwicKVPd45regSi2O2svzesB5JE9UNRcjhieBD249NcpsJ9P4hRXC+KDK6DLA5lIEEjiZQIwJ5L2Bxn/YI8mycOISmqkacI1W8h8k3xhFNFbIKu7MpClXYy6JwAoFDSLcZWN9HE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYCPR01MB10380.jpnprd01.prod.outlook.com (2603:1096:400:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 23:16:10 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::87b3:6d49:458e:8db1]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::87b3:6d49:458e:8db1%2]) with mapi id 15.20.5676.019; Wed, 28 Sep 2022
 23:16:10 +0000
Message-ID: <5a037955-4832-e42a-eb58-719ed4672395@renesas.com>
Date:   Wed, 28 Sep 2022 16:16:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
 <20220926230438.GA3128861-robh@kernel.org>
 <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
 <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
From:   Alex Helms <alexander.helms.jy@renesas.com>
In-Reply-To: <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYCPR01MB10380:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c2b203-0eaa-4073-7af1-08daa1a76e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rmIKq2f7XBLrRKwvz1oy3ehP4Qe6SjnxZsBol2VXeI4CjEsrVoIFI8kMFuYJx9F1/ZgT/585htH6n/PA/VoBBlfO1lIb7QCwmlum7z4D4bBWHXUuViT9IYV7Pm24mcOmmiI9/KF0Xczf71JhPfeFRnhGxiKNZswaMmMASkNo1/6vb6Yiv24XCtEFK5Y5LhXYDk22dQGRuBZtirDm5o4hsBnNGR4Dd7P4QPo3PGtLqFDJfcQEZnWcpyTucqDQ48Ku1p/2cXkwU1MwpEc16gb7hZuz5vymgdXBM+yFxMNeZtkTUmg0wbBbj3k+qxo90AQ1V0ZnyZF28j/4B7kPhZCo3+v5h3rFFNTPNt+QI8/Hy7zStkUCLIUD0Xtu8M7WgeSHhLjxbO6hQB/C1wWTpRN0amQyuXOvAZvgwuEsYvC6gjHk8tylsbF4TiE9LFga5dPmNuTh5QlVnZVgnzac+UiUkKWE8Ng26pS4Zw5/gn5CSEaLpH87W+68ChqYS+jVzWsYuVFbqHAM2b6mK3WNaYfDG2zS7GR+n2K0zCJBxc99Gg6BxnhlBGJ+d9zGZJlu11gmdYJpBUz52cPUhq+h4o4TXHD/N9+2ArDaQsHsmSdqUV/ewdWBGhV4Woh4IPVuf8akmTgaqPPabBbGzcD352ZL/y3dVIPj5BBsXLEGNwWHZiwC7MyXC+t1owtL7M5SHLpvnoUfl8+qbQ/JuAXTnu1ibnhkdFPH1mH+EGVt+h1Ce3HQgnpTNZGeolYVdzJ8DhuNHV2DOuMYWi71+bYBf2LPb3pC+aisGmgLaRTykIetlBQbGEaW2+svaSKGNV0hto7VE4puLN8GLETumZvvGSYXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(2906002)(6512007)(316002)(478600001)(6486002)(186003)(2616005)(110136005)(41300700001)(6666004)(36756003)(26005)(38350700002)(38100700002)(6506007)(52116002)(86362001)(31696002)(5660300002)(53546011)(8676002)(66556008)(66476007)(83380400001)(66946007)(8936002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS82dVdvb2RYa0xSQnFxdFlESEcvMk5zWC9jM0lXRndxbnVlRkcvQU5IUmdM?=
 =?utf-8?B?TWJZQ3ZrSFRZK25WS2h2RWh2OWJWUFdGVVd2UzVjQWtyKzhBLzB5Y0VPbklK?=
 =?utf-8?B?RDBMc2p0TWhkcURpV2FCZi9WYW42L0JSZVdHN2xjU2puUUZvWWloSmNXdlh0?=
 =?utf-8?B?QzR3eGtZU2VPWGhaaDgvL1d2SnZ2NWcxRS9hd25FS3VlblBmV2VlUHYreVpI?=
 =?utf-8?B?dXpEdWVaTmU5bGdDR3JRRUFjZzVZeTczeWhpQkxaNXNJdzdLcmxUdTFaaDhJ?=
 =?utf-8?B?b0MzTXU5MFdESUl6ZnF1QXJ5TGVYM1NsMlJ5bHU3YVB2Nzd6dE9HemxTZGdD?=
 =?utf-8?B?eWtkMmZYNE84bndvcXp2eEJmaXJUTXM4ckcxZEZJaUhocUVEWGYxdGE1YWVY?=
 =?utf-8?B?OERPWjF6VnJzZ3dJN1ZFeTdGZHFOZVBBdDZuWk8zaVRMUTU5dk13NmlpS1g0?=
 =?utf-8?B?YkNvMG9jb081SWdyUXNrNkhaV2FIU082cUd3c3JQbkxpdXN2a00xMGJkcjE3?=
 =?utf-8?B?c0E3dmJtVzY5WXpVRVM4RkJyY3hrWEMzRVdRNWp3SDFvbHpDMHUvVmo2ZFNG?=
 =?utf-8?B?T1N5cXYzcWhEbnN4YlBBUHVlQXRCc3dXMWt0YlhVWEEwOGkreWlLVmlPekRJ?=
 =?utf-8?B?Qzh1VzdOcm9ManNaSis4eFRMdHZMQXJ1bC93MkhTcTA4aVppWWFJQWNXWWRq?=
 =?utf-8?B?R0had2tVK0dDbGg3M0lYZnVKbUU2QzZxNGtpZkFPV2ZWbnIxbm1yRTMrNXhF?=
 =?utf-8?B?bVo0aXpLZ2tTcTBCTHNYTjB3bEg5MTdoSml5cjRFakc2NHo3WForUDhoLzky?=
 =?utf-8?B?T1RwZDA1enNjVEswWTZmZW1uNC9yU2hIdElLSlMwMkRBdTZxTTlvTzRvdEV4?=
 =?utf-8?B?cEhJcHZRMGU4RkRGcEp2TlhXR0VmNFJtUmxTMGdNMklEREI3OUpOcXFMaFlt?=
 =?utf-8?B?RkJxZFpGYWRvUG5UYWtxNmFQU0pyNnJNNkxOYVNFcCtsck5OaXVnSWR0eXpG?=
 =?utf-8?B?d3o0QzZiTGJWUUU2ZDRWZnQzdnJ1dWhyb2FVVGVzUU8rVm15NkRod09FalQy?=
 =?utf-8?B?cGRIWXhkMzBLQnVkb1VUak9RMjVoNFRDWHU0TzRjK3paS2R0L3luRm96bWpv?=
 =?utf-8?B?cm9oNVdveThDZkRvaURYQ0lhQmZwQTFEL2VPQTYvRnUzTTdKVStBcTI5ZXR2?=
 =?utf-8?B?M2V5VTZPTk1PN25CM2VQNTlORGRRR1hzYXBEWkVpYkxXQjZHVzJ0a3RrSEFi?=
 =?utf-8?B?Y25xM3hPWUNDMk1BMDg3emdMZC9zbkkwM2gva2ZCN1huY2FyWHZ1ZnlPNVR6?=
 =?utf-8?B?TEg4Zytmd2NDMDAvLytXdjJWd2ZJdERQNmNjNktFYzArMFZadDZQR2czR1g5?=
 =?utf-8?B?Mkpja29DTWFzTWNxWGhPdlUzSEVwck1DN0NiNlcwNXJwM2JhWFd6Z0JoSTRa?=
 =?utf-8?B?U0oyOHozSWNWZ0tqSVFDWkZsNXk3OXJEWDllSnEzaGxiTTRlNitrZ2pMejhX?=
 =?utf-8?B?aXBQVGFQMHpKQTlxNVg3Ris3UWFOOVluaHAvamkzcGZwNXgwWHNNTTJ4Z0Zz?=
 =?utf-8?B?bTZCY0FPMW1KSjZOWitDSWM1TXpSbk1uenBmdVJqQ2s5UFRoNzVqaW1xYStW?=
 =?utf-8?B?S1ZsTTIvSTZmNUFhcloyTUJ0WE5rM2xma1JDb0N5UGp6cW01eDJ0Q2FPd0Ra?=
 =?utf-8?B?WEIwYXRhNFRoWm1SWTVzNHNlbDdvSkVtKzU5aEZBVFp1dGk0azkrT1FObmhu?=
 =?utf-8?B?TmVrK3l4SEFmS0cyTUIyVTdadnVKNG9Ya2Z3c1o5ck1CM0xGNWcvMnp5VTZG?=
 =?utf-8?B?Y1B6cThId01Ham5LSFQ5d2R5Zjc1VzA1TUZXLzJ0aStEVlpTVC9rZStJNWRH?=
 =?utf-8?B?bXJOakZDOE51V1RCRHJGMDJ2bEFoNURGc2ZhcWZlY1RhNUVOdkpSWmlpL1cz?=
 =?utf-8?B?R2RDbDYveTR3MG0ySzU0TXJFamVrZWIwRkVWUTgyM2VsaGdzUERydXoycTZp?=
 =?utf-8?B?S2NvUDNGQzBLWW5xODc2eDBMRm1tV2I3eWE0WThmZVZObFFIM0xkOHhOVGZh?=
 =?utf-8?B?UWRNUDhlM2VuMVNqaHdBZ2gzdFpDL1A2RUtVOVF6dFp4d1NELzJQNTFNRW5B?=
 =?utf-8?B?d3ZZMnpNdEhnKzhsNXBsdEdwYXFTWEZSeWx4UDhNMmtTakJGRFVTS1k0bnFL?=
 =?utf-8?Q?iQAVsGK65KNeo6nVCFr9Zhw=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c2b203-0eaa-4073-7af1-08daa1a76e05
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:16:10.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0FxnomxAEDHALJzsKujx+PaOSGgtyP+K55lLyr31LKlOkHD1c4IdHomVA0PexC3R90KtDJ/SOfeXpdnTzcT5la98Qj8VJbSDHgW7ZvzERU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10380
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2022 7:51 AM, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Tue, Sep 27, 2022 at 4:10 PM Michal Simek <michal.simek@amd.com> wrote:
>> On 9/27/22 01:04, Rob Herring wrote:
>>> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
>>>> Add dt bindings for the Renesas ProXO oscillator.
>>>>
>>>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> 
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> 
>> Driver is also using clock-output-names which is not listed here.
> 
> ... which is deprecated, and thus should not be used by the driver
> at all.

Can you point me to somewhere showing it is deprecated? It is in the
current dt clock documentation.

Either way I will just remove it as it isn't important.

-Alex

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
