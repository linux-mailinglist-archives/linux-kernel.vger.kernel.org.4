Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F70722500
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjFEL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjFEL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:56:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D110D;
        Mon,  5 Jun 2023 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZp3On6mjDXCFCCcajUz3vZtpjaPXwFfemLBH+rZwUY=;
 b=fNkv0pG6lXPEzj+zuXiKA5hNkNcDbYskXgU0n13AH18msBdedL3c3ldJXhBohqM8ZbP9fk0+rqN7EKXWmNayU/4dywY/Yj1cPgIX1wrcD+eogqthhGFg+QYN2Ot4Ym5DhRYA355Q0YDLKBrdsdSBPhAn9d6o+0mnpuxR9YTVaxCaBXiSqR8vM8ry5r1fiP1/t6KbPNt+W4uoblGqAtqx+V5/YtdcI8QirP5At8U1ZXaHHi2NP99ueBxHknDWcyUoyuIXAec5ecRAg2cquV5sABFAIYqARk6FdWQh99N+pwo85eXwx/RPs93OGQWaZhwcQSfZVxjV5NBKn4xx47Hh1w==
Received: from FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:97::14)
 by DBBPR04MB7852.eurprd04.prod.outlook.com (2603:10a6:10:1ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 11:56:35 +0000
Received: from VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:97:cafe::b4) by FR0P281CA0132.outlook.office365.com
 (2603:10a6:d10:97::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18 via Frontend
 Transport; Mon, 5 Jun 2023 11:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT105.mail.protection.outlook.com (10.152.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.18 via Frontend Transport; Mon, 5 Jun 2023 11:56:35 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.59) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 11:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzX+rJ9+cSseLLIMp6Y6qp/yEV7l7be8v3M4ZDI4pNLtCICPf7EX54f8cHYjIYWC8FIBSbJD+n1aD+QcgVuzDAKldcZEGmqMyNpRUPcZaplbiCvFByni0WaSW7n1E4LEWUyMhVFnbqMucrLA9kpCNAu4v4ymkzPJh27zA/NFoe6rQ74imyZvRGge5xDBkf97OCCKAgNeLzUoIvtHp9+V7JU3toWVJp6DRItgw/7KzEGGXGYCKbHlw6LUPOsTzcXfxsN06gZ3fxSrAmE8+VsWlhKT+mvokWAVXq1bT4tz4bu453ORpqqW2Y7tEmNtJ59YK7iGdaX7DAtIv376bH/kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6N2hrxxvNCCTizuvZMNJXJCfpm9MbwP+wAPvcHu+s4=;
 b=U/eDYBB4xTGiq5vrdngEiSCTKaXr67zgGK/wi6q93l+RG2V8/ZDKdzSRCSsB5XKn1Ab9KW+1dvxqyy21TTGEQjUaeB+J4zwo0C4bmdHnpoi+j7SY0HV6isZcVqL0mJcgEbvuIJ127FJqmcEDjAU2NuMZZdNpiEHipsfg/YgEJr7iAJyZvu43ehUBySqq3QnAMAAQKXayrnf8FYWXCdn2LphBHF1jpBVQk+ZMe/S8/k9oKnJ4Zec38SU6VrLXEAs1F2OC8SnRcX77H0VLSefbpAg4gkmz6RmDjKwQ+HwQxZGAfZR53+KTxubo/O9aePz2VrzGQu04AG36oYt75ISDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6N2hrxxvNCCTizuvZMNJXJCfpm9MbwP+wAPvcHu+s4=;
 b=GDDWQRLW9xZMfprabyEsyI33JmvtLTbRJaWneq8UDGTWcyfC/VB5Ni6Pt2ElcwG/Pw0C7t5VkfeszwZ4E3uSfCKBqktHs6+vsq6maVkh7SbkYQjDsGPPcGUlqPXfPitPlcTA4rC73UXuITSN9IZ3Ik7lBDu2OCE6Za/mkPSvhsR3UmLrqO/wZ46kRSelslWIPcBhWLjk5Zlbyv2VbfCaEmkc58N3swaRqgYqjOkJhVljhNZIgJ4WDjGO5BVmyFBdZymuqeRU+dPCLNjRmItu6fgwmzQEwtGeoYGki4LBzxh0rA8wG47bmfNE4JYMvYmeT3GQmMeVlZKCqEVMMGpu3A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 11:56:29 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:56:26 +0000
Message-ID: <27baa521-4350-23a6-0e2c-470ecf9bb306@topic.nl>
Date:   Mon, 5 Jun 2023 13:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add nvmem-clock
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2167d5ad-7e99-4eb9-a313-030fc7a7d546@emailsignatures365.codetwo.com>
 <20230526143807.10164-1-mike.looijmans@topic.nl>
 <c6d886d9-8f74-7af3-5478-030f5d6e4b1c@linaro.org>
 <ae4e2041-9fd7-30e7-8c0a-22a423c5871e@topic.nl>
 <578088ff-9feb-3d03-f12e-577f105144f5@linaro.org>
Organization: Topic
In-Reply-To: <578088ff-9feb-3d03-f12e-577f105144f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB9248:EE_|VE1EUR01FT105:EE_|DBBPR04MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c511286-c815-4a91-8839-08db65bbe989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RFtqmvjrQkSk52FEwtqz3kx81N5Vrij0rDFYCS7QLx39q/GKt3t8PsFfn4bB6nHStzDRewxHwbYfP5vQv8hmcBSqjplCjwSlgF8CXGeLekpZDnvBjsiBoDb8//Soq+zwdktiTbBGLDsow280NNJCV1otRdyeuIaPBSO5S/cgJ+xdvsoJepfKyffHbxHhDKIHuqgV+yBHtMSz/daeN5OcOUpWiR6lA7jrElHUkd2lg09/VWpl9si/7k8JLcoWql+AFZ5V4czunJ19t1p3GLadoUsaQkUNirOWlVV89y2zZ7/BXCXorcBeUPQGPcjFrEYZeA07rvsphmo5pNzajAkWupKNS18naT23OXVQAGwpAl9UanWY4dvNMfV8eg7++1IxNViUkegPsHxnVnLWX8AoG+lxIyc4UWQiY/59hCcmyXM03srmoph0FOCLOLxnOv5qBEPDKh8WyJBZMHAy93+7B/M270NwhuGYfpt2nQc7aO/yQ2QfxnJJvQlJsBIXGCPPj4dqedDS6pGyBIOp0lb70l6h3MzIlqzVaXOY+/edrAWu48p2wudCdzadQiG5Yjc80gw99PydK4AHN6WBG38lsM6RYjZj5uEfRJnAFG9vL0hUAanMORFU/mEi2LNuFMTMJOGXK/ZlsLGI9a0LDJy/S8smoq3mzrxocAGXBSiikyA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39840400004)(451199021)(6512007)(53546011)(6506007)(26005)(36756003)(42882007)(83380400001)(31696002)(38350700002)(15974865002)(38100700002)(83170400001)(186003)(2616005)(41300700001)(44832011)(54906003)(2906002)(478600001)(66946007)(66476007)(4326008)(8936002)(8676002)(316002)(31686004)(66556008)(5660300002)(6486002)(52116002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
X-CodeTwo-MessageID: c08add29-d157-4a1c-9676-c6a03aea8090.20230605115633@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dc6b77a2-8cb9-45cc-fba9-08db65bbe3c3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty72ug4EXQtEhaqYWFS5tBIERe5yz+w/KNHRdNqi1HVqKqw3XyDrXpA+nv2Q/O0Ee4Nmw6R6vpw+RHPj7DjSbEXeAHr6JPQBPNrW7S817OhHqtbm4gsv0PdgiPcc+SLrZmexVDBrsaYQ1g3Q14cdKsX3CGrYLw+p8y2rUhMtNkf1aluxWYQQBwPJoSXwZsqSmXYaY/Dhj2GbdRrlOqkleK6I8HZ0kx4ZBEqX0PqRFyrKBbH304VsjfgxXYf4/M/IpXbIGwuOlPBCbANe7QXDOKmhXxm9k4prDWE84+MNO3CpJyo3chcmTUJiSO5NqdpzukdiEddpS0t8i+x9rLAAqrUgTM6IV4x2zq0v5uQxQvnGzC5PvYxRmcQNzMANhOyT/3Fc0WUaxfotm2eP63RMZuGXKGghDfkkQI6ibsbVucBtKt9f7F5tO17/S4zFjtYGay93qHKrK1zoYn2jhcrdM4utiuLIMe/oooWGeMRn7atffSMgecdSaSDIaxdZni1Q/yU1AvfUNFVSCsoL+F9z5Zitd1bSW4Z1TkClwdrlp2aDfK6IrO+FN287RVslqHcQYC81/L5fc+58GKBzGTk494tkNgvBH0l6DuzI+gFrvjCVGfR0dBRoZaI2+Lkq2pK9Z64Ul/2cfJHu9Cbl6fsFjKaFIdN/4mWgYgOnbKJ/KCE982n4OtwmYD3lXWsOyoEF2UPrkR0CvBhUavrfVhgFV39ad6ol3VgpDZ1zi48zTaLr3sf/aCOtxqGW0efMpPTPJgWuw/U7cFU4k8j5wLyoXQ==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39840400004)(451199021)(36840700001)(46966006)(6506007)(186003)(26005)(6512007)(53546011)(2616005)(31686004)(42882007)(15974865002)(83170400001)(336012)(83380400001)(47076005)(6486002)(36756003)(36860700001)(82310400005)(36916002)(2906002)(8676002)(8936002)(40480700001)(44832011)(54906003)(478600001)(5660300002)(31696002)(4326008)(316002)(41300700001)(70586007)(356005)(7596003)(7636003)(70206006)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:56:35.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c511286-c815-4a91-8839-08db65bbe989
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-2023 12:13, Krzysztof Kozlowski wrote:
> On 05/06/2023 12:01, Mike Looijmans wrote:
>> On 31-05-2023 21:27, Krzysztof Kozlowski wrote:
>>> On 26/05/2023 16:38, Mike Looijmans wrote:
>>>> Add bindings for a fixed-rate clock that retrieves its rate from an
>>>> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
>>>> or similar device.
>>>>
>>>> Component shortages lead to boards being shipped with different clock
>>>> crystals, based on what was available at the time. The clock frequency
>>>> was written to EEPROM at production time. Systems can adapt to a wide
>>>> range of input frequencies using the clock framework, but this require=
d
>>>> us to patch the devicetree at runtime or use some custom driver. This
>>>> provides a more generic solution.
>>> This does not look like real hardware. I mean, the clock does not fetch
>>> its rate from nvmem, right? It's the Linux which does it, so basically
>>> you described here driver, not hardware.
>> Right, this just reads a setting from an NVMEM provider.
>>> Extend existing fixed-clock bindings to allow reading frequency via
>>> nvmem cells.
>> I just tried and implemented this, but it does not work. The reason is
>> that the fixed-clock implementation returns "void" in its
>> of_fixed_clk_setup() init function. The nvmem provider returns
>> EPROBE_DEFER because it isn't ready at this early stage, and this error
>> will not be propagated up because of the "void" signature. Thus, it's
>> never retried and the clock just disappears.
> Linux driver problems are not a reason to add bindings for virtual
> hardware...
>
Okay, so what are you proposing?

The implementation needs a compatible string other than "fixed-clock",=20
because of the way the fixed-clock driver is being loaded (it can never=20
be deferred).

So I should add another compatible string to fixed-clock.yaml? That'd=20
make the syntax in fixed-clock.yaml rather awkward, since some=20
properties would only apply to some compatible strings?

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



