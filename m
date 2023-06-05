Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03B77222D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFEKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:01:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EED3;
        Mon,  5 Jun 2023 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbcqn1K9SkzXE4jgb6WG17EyM/TsnH6TD1w3HWfUg5o=;
 b=D+7J+Sx7hhYj3mZv4nEaMQIZaR5Z7MZElQWb6ibp1pkyl2lZRZE8gqwVAOrpmqHm3bxIeplEmE8jOepiKySQ6aJnmiNiNAHYusPScyldquDtXxQXz8Owbt/1yAWqrN4pDv2xRwUbdtsLDbzVodYmWUIxZ0MHmyGNW9z23EtRyFlTWFkEaEzlX+zt1GUtsPp3J6+l5CGWB3qkb9ST2QXYfVUevSd+h2U22w2dYi7IPODC54usWw4oeJY7eRQNUW5KkxDRZWDcny52xxZHwqePr6ckPYzP3hgMSwXQI+ndt8x+dNj5Ffp52piF8XGkMl62JqP8vzJ7XwLuq3aQvGXFXQ==
Received: from ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:44::19)
 by DBBPR04MB7660.eurprd04.prod.outlook.com (2603:10a6:10:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:01:41 +0000
Received: from VE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:44:cafe::50) by ZR0P278CA0184.outlook.office365.com
 (2603:10a6:910:44::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 10:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT023.mail.protection.outlook.com (10.152.2.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.18 via Frontend Transport; Mon, 5 Jun 2023 10:01:40 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.49) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 10:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrwTUfLGJNEQKzvTSv+LAbo5BDv/eHsbuyv6nKVX64SpZ9a6fis1Y9/HoNeol/E7Thognx8PVQ/QlG6taIDCzF8XH1CdMzBMDHdIEDG2MyzhfEMAwm6bVZIiRSsivK4qSRpNAPXnOQz7Sxd5EboDlP+FBvA/DNRzIRLr95+QDuyxPEjttZ01SO6ITZZYpdaMfFQM8dSrrvqfJD+Gpv0iJQ9gtiX35LgDXSoCuodoxYcHZpVhlGCThUVB45JdtmUFdOAsp+K0se0hNCz9Lfj0FAvTnVHpK5w1/zLnhpHp6tVQBvgpRzEfEOuZiDmw2oRxpPvIVPSt4uPRRb4cREMbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9u43TFUx+rCyt4zwj8CGK4Hio2R9CL3d6dzWzFRoK4=;
 b=LXtmTg+vhJsYwdi2WQMMxBwzgMrFyKGq+D4IcJMsPQJR9JSLCyi8DUkRt5jU9BMrsFCjyqc3YyHhtnvu0WLRhv+8rf8EdE+AbIIA0q4E6pfkp8QkWSXYdTrlXAHJARukeeqWZP41wCXZy24AlAm9LqIuPOUha9z7td1ebZcLTyJCLZyQKh+24wOW9Xkvivw/ibqo4WSSmh+oo7EaQTwsKEOmVq7pJ8eLvIgjVqMp2mWNFq9mCy0O148F0Dd54PuHdM+ZA1dBHpQEHaBZbn5zxtYLyLgxAfsXZlbnkoK5dn1fkfahmAyjm6Pt/MynhhMfn/855CaEMTrzKCtGDVqSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9u43TFUx+rCyt4zwj8CGK4Hio2R9CL3d6dzWzFRoK4=;
 b=pbNUGbXbFxwEyKe2CNgP9G2iPebeFZMYD4CtGpox8cN4HHshr40l2hfO5jdpwGKJv9DE3jY7a+rsn8DWQRTveBdBA18FsX30YojaFl5ON5HMGXyfz7+WGxVNj5SYIgFmbscktWNMML3xnFMbLAYJeyoce/mt8LYfyMVLA8856DBmo2xjmJ+BYh+N/oMxSLcISoT37sq2P32pkkxvrozoEGuiyMu/fl0fqVoWRXMHlBQDRwnT0O94hxZsegMQBe93UZYW2XGfKu8STJOlXleE2SsfxyvMvpAJmFfQ4zZSNMCWuCY1jwqJWFuBxLRpA8q9MlH6mgpgNdhY8rJxLXghXw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:01:36 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:01:36 +0000
Message-ID: <ae4e2041-9fd7-30e7-8c0a-22a423c5871e@topic.nl>
Date:   Mon, 5 Jun 2023 12:01:35 +0200
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
Organization: Topic
In-Reply-To: <c6d886d9-8f74-7af3-5478-030f5d6e4b1c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0219.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::26) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AS1PR04MB9683:EE_|VE1EUR01FT023:EE_|DBBPR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ec630e-0f1a-4abc-7b34-08db65abdc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: anrrKJCc2URoe/g3BRyIt6qSnW5MzMz4feqPO0nmGFOtZstwPc9oXDw9JLVuTCy/35bxhdaR58pZQaYqcTYOn883OA3sMevoZNrj8+yIB3aa+Oi8JEK8dM0hIdb3IpBB7g33+Z+dziNO1yjUKt62/hQzPh47w+u0oHVoIZ1+46nXnTW479xCgCjYyyTwUtmQjxIWk8+98Hp19DvN7Hi/IZJ6yLlhH3JIV+1fZuz2J4Vbn1lyttDvX69EGbmJem+s8OdD+UainMARjMEz2i5pZnEF9glvs4K4u+96h2dam4oVWur5g5lbfzBsngd5NnbQ3U7p2DnysWM+GEWDdbuQGd8/F8TMZJhFySIVilTtmtEShNMj7/CH204MuTjgz6hRrtt0q0VhddXAgM/Ii/7+RhQnGpAyIy9fAQxlRS6/PYkLXnbVekOJbXGSaMjnZCfxwK9HZdisxquqUdUTin8CCz9Mr7e1LanY9S2AJ8pErYhUXReUKYC00Yw9/XaSygCwqrn/GMa4FKzDWGNWEslmVeei2pKlzCYhyMVYx0yujTQMy6q1Ogv0mQSMisd/Tu9PWMXxmkvaGL4A3L10J4UE5lS9hY7B2V11roF47afgA5hU3z3ETyGvNjAGdQVD87KVhkcnjO5D/GjGDdMv9LF0cquzzAf7QDvFqzYvhItRazU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39840400004)(451199021)(53546011)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(31686004)(36916002)(6486002)(52116002)(186003)(26005)(42882007)(83380400001)(83170400001)(478600001)(54906003)(4326008)(66476007)(66556008)(316002)(66946007)(8936002)(8676002)(5660300002)(44832011)(2906002)(31696002)(15974865002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683
X-CodeTwo-MessageID: 0245adc9-b7a5-483c-ace2-196be3da7e17.20230605100139@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0afd62b1-0ba8-456e-5b6c-08db65abd948
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69klB3EXCWIf61HqPkCPNdkbaADWlMw3KJnsGM1CfI5JRXyr2mFiHhZyO9meB2rNJkM0CSMHT0qVuPlJkQV7M3AsIG21TVIqa18/JufT7HwFDEKx2IT64fgVU8yoHXDbSsghIyFpfu2Hj+6PliewH7AB+oTSFwYqY3iGRDt7hXZl+B8oLgJwqsAGxCu94EbzpcpIPPTVd7r8pS+m8Zmd7kWBq9nfwHD2+pK2h+J3FCy1hJq8/VgM0/SeCdvliyCFPeuN8EKzd7ebgGS20xC4FKVwVnPb1HvNlxzRYkfK7r71FZma4O+RXAPWFalhm55DeeX3mKjbjPp4nqqqYorRM3WrhPfjpKOPm/Mbd4OIw6jvV0h7IndZylcMbo/pOMygZpLfuPYuFiTejJNgkiXmZOpP1/g9ZrQAFIfxvmRQGxnLBQZrarKMjPaKT3ijwULaAwsROu8L20wY93n9E3fogNC5Amufj/+4GXV0Ku9yAcrKZDmZ9Z9BHzIRRk0t14dKGS56MIfB5hH6oBZl9badZ2N9nC7cnksDOMc/9JyTHqriMTfp2GPLKKZ0ye4jorqZl0flM7CW7jSKPw0CBJ7aFLZ/ULBsh/EVrLl+i+PIN/Nc0pWl9wcDrUhnsasvKP/t9NxpdvY723Nu2wivTA3sdY/vNTh+mg4O1FX9wZ1fa3OjoS9MDB6q6+uWrmORKt3AF+UyHqjoNDFcZkEFh03mFxVmPc30Z+2BsybjDyUAoJTlWsUy+aoTot29o9WP07n3YkOeYpGmdT9nQRxggGFYmQ==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39840400004)(396003)(451199021)(46966006)(36840700001)(47076005)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(31686004)(41300700001)(36860700001)(36916002)(6486002)(186003)(42882007)(336012)(478600001)(83170400001)(54906003)(4326008)(82310400005)(40480700001)(7636003)(7596003)(356005)(70206006)(70586007)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(31696002)(15974865002)(36756003)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:01:40.6725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ec630e-0f1a-4abc-7b34-08db65abdc12
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-2023 21:27, Krzysztof Kozlowski wrote:
> On 26/05/2023 16:38, Mike Looijmans wrote:
>> Add bindings for a fixed-rate clock that retrieves its rate from an
>> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
>> or similar device.
>>
>> Component shortages lead to boards being shipped with different clock
>> crystals, based on what was available at the time. The clock frequency
>> was written to EEPROM at production time. Systems can adapt to a wide
>> range of input frequencies using the clock framework, but this required
>> us to patch the devicetree at runtime or use some custom driver. This
>> provides a more generic solution.
> This does not look like real hardware. I mean, the clock does not fetch
> its rate from nvmem, right? It's the Linux which does it, so basically
> you described here driver, not hardware.
Right, this just reads a setting from an NVMEM provider.
> Extend existing fixed-clock bindings to allow reading frequency via
> nvmem cells.

I just tried and implemented this, but it does not work. The reason is=20
that the fixed-clock implementation returns "void" in its=20
of_fixed_clk_setup() init function. The nvmem provider returns=20
EPROBE_DEFER because it isn't ready at this early stage, and this error=20
will not be propagated up because of the "void" signature. Thus, it's=20
never retried and the clock just disappears.


> Best regards,
> Krzysztof
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



