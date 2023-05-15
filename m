Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D0702DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbjEONOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbjEONOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:14:08 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0E212E;
        Mon, 15 May 2023 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcRX/nuhk9QnH9lG8ghpDiQT5ez9e5RVu+BzSRzFQDE=;
 b=N3jU5qniAnHfvWYQMGpct28vQXATClKg1QlFfWdOWH/ibmVLHWKFWpTAM+kf+4jVkCiLzh/54eKB50fIuwQI3GlSMakJQvzDqT+25E0CQUq1GfFWZTDwj0/2/L5PbRbTiAEBLeUnwNHEJ7utbuCSuboSRWGgmpnNRieyDOYeq8kTKnedsUWvFUcOPZQXI4ilMz1+jRTsZzXKBvvhk31uT1XUof3XI+jPutrIo1uUwMHJUwR7SnB7UmQNRatsL5qKZt4ikArWbTyMDXGBzhYntjnUtQ7wRyAW+iSYl5bGNTI0HeTwhyBD/BSbuhcVtplNWLNFAuuB23I7t1v109JInQ==
Received: from DB6P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::31) by
 AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:13:35 +0000
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::4) by DB6P192CA0021.outlook.office365.com
 (2603:10a6:4:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29 via Frontend
 Transport; Mon, 15 May 2023 13:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT031.mail.protection.outlook.com (10.152.4.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 13:13:35 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.174) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 May 2023 13:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5EpMt82TkbZYqSQ2hbgvsToQNVJpUhNtpyZZggCYtqPwszayX7bPoIM2pUMxzuiEZpw5KK2D3MfGTXyXkjP8a3oF6fnEz9jOqLHiKQ2P7u0P5n1OthDoIf+wE5rOr/eJWNPSXpOZt0LI4+VuXYCMlupDyNHjxqqX6fLsmDRq2p+tX8HN1UeQJbD2iNk0GrF46uOM+SGfvPpTPgxg9e9KX2IUuBmgmB+69Qzy4KOCvZMnFfxjUkpQR3shUMq3FUUeOW0CIRwZYJ/mbPccah6V3crrOKTnN9c6x/RxWdba32mWm+1xsVWrFEDm/sufKSkUenahPVIb3utSbDOohUCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk8j327iy50NdO8a8C6LLRdUTOaqZflfF30JGy+fvyI=;
 b=BnWoNo+IJqztnuWC6i5DKYNdEfQiSmsPTdfMCwnmE5iQUBYb7BR7811YMNC5mrwMibLVe1frf4hCbkaeV4URaooB4FgjS79JX0SH1KwIdRf4AsNKqbS9mRt/qimxz/5fdg8krkIqqNOigDYpCMBuKS/pEcZa7DIU0ipOCrD3e1bZmyBwQpM1Z0gtQOpkdwkjh59Lx25dK5XAlJgSS7nZ1YwrXfaoOZtI1ytUSlcl1z1rjLm7s29WUmrsjXapT7IMrrFs3iNQ0I3sqWT6Zv+rf8zEzrHUkpcY+TbQtaEkystBiEptFRHPmLANrtE74VOEUDOL6aGdRYk7AuHxbqwCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:13:31 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 13:13:31 +0000
Message-ID: <12aa5eb5-77f4-0eb2-cc12-d9dbca0dbee7@topic.nl>
Date:   Mon, 15 May 2023 15:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f4f6ec47-9e6b-4978-b229-53520227ed28@emailsignatures365.codetwo.com>
 <20230515062502.29273-1-mike.looijmans@topic.nl>
 <d880d18d-5a2c-ad69-fe9f-56f98056b9c6@linaro.org>
Organization: Topic
In-Reply-To: <d880d18d-5a2c-ad69-fe9f-56f98056b9c6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::33) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB8047:EE_|DB5EUR01FT031:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a93d6d2-a5ce-45ff-7f5e-08db554630ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vlK9hX6MCXFCUwpK6PdH+WuS6NvZinHneWghZC04nv1TA+sipNynKInWF+KJkC1wBYeh+Ra/Do5UmFHI0vG3c7rSGsbQ2fhveBvkoLBfg1mPrnCnyCBkOafuoOZCh7dsHfgVHXerxVwGBIFtnfRPyqh7tSw3blUgTqsSMaeu1BuADhL3rKxTL7Es4i05+Qk+1+7kJEWwE2boeA6ptr8qe25qYZ3NahBw226UCc1PkDBjVtQe1L2sgE11fNj38aSpHhjpAyIoaIvwjmmsBZDy4O8Nx9fvZtMzxnCNT4c9Zu2SdQqRtHUvfO4vmmuu06tiQSOKFZXn80OoPqZR/lEASG6gvFvlP1OUnPrvzuYOcBWmaCiF5qQRT/rWK/AwHdTYFD6lYYgs/dSgrGXW3ujFjdTOJ7ZBMp956XGrrVWgAaarr9yHV4NV+bBKruF31/+psoIWTSR5myladgoStunWldG7DzJmGsiemkE+9mI4CtDBaB8nY5CRwjUvEg5n2uu60DU8NsE9S/deIYATYodW3IkhfHxIkUGDMRxdpwjgYF/1d47/9PiHQnAecGoyuXmA5n83QKTPx6q+Yo0OZ3wVE67oURen/A0JkOmHIhqZTdQpfsMxx9GKXw81iUNr2rgrtLrk2otUQbqe0pPn94z7SRi8BBkcSZUVDnJOOhnvx+iJMtwVx/1kjlFuLjz0/vCX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39840400004)(136003)(366004)(451199021)(66556008)(54906003)(478600001)(4326008)(66476007)(66946007)(52116002)(36916002)(316002)(6486002)(8936002)(2906002)(8676002)(44832011)(41300700001)(5660300002)(4744005)(26005)(83170400001)(31696002)(38100700002)(38350700002)(42882007)(2616005)(53546011)(6512007)(186003)(6506007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047
X-CodeTwo-MessageID: eb58e929-01e5-4b8a-8ae1-16ba3dd50d72.20230515131334@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2e0dc484-de3b-45e0-0e56-08db55462dd4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dcZa/svURfMMYWnpp2zK8MCiYhgg659rSD3+JA6VMYyD5igIDK8PjZZ1KzL0t/UJOJAvMiMOg4bicHgY1/mISDCDX3+C9TE9PyMI0ak56wMcRWK59MVhwLLwQKOWcHTLQN+JcAYMhylM2nK/nsYKJJKoOpFLiniWlo1joTWL77XaW3CkN/sm01q4kjsbiMQuSCLzjM9kl8gAJnav1S8PDjJ7nKB+nAxR+xAVNKIzDWTXrmAR2d+iKdAviOpnBkPDAxbXuvukBHNMWGRmVFdcxeINxL000DmajOVmGX+8TYRdcRkKC0YRlWmGtWhP46G58/om6v2r2+F+0NseqEkKdnLU1YxvBmHclcNBuEM7Whr9VKtvyV17CWiLP7RDOCGn06CPy2Qc/0/SxiQOxGLPxu6Xz2gq58aCWuVhLL+giDE0cnzq1nhxxQpp5ky4oGuhg+xzn+i9UaVZD5QQ2w7xia5quxLRGxnCBPGnKITIUm/IVkaDGsghg0lSfXTqo/rG2VMKM1CpBhdiMFFxy0a7lu+H3utyyN/GzaWQogqq84iAf/rJMhtoFCDUlxtKECBlawjegB3toYOU8YYxVVnMqpSUuItyCyh2HvJP0KQKpxci9SMQSfmzV5S9xfwZkZIjSu4ZnlyAhX9QVkZuWogLYFjJEBJ9CotdDMqNH7XrP9qG7sio34tlJsNwdD24htyqrMS9Ezyh+A7o8K4GfrNcgyWI+SWXJX9WDT9/9fQBt4=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39840400004)(451199021)(46966006)(36840700001)(83170400001)(356005)(7596003)(7636003)(2616005)(36860700001)(47076005)(42882007)(336012)(186003)(26005)(40480700001)(53546011)(44832011)(6512007)(2906002)(41300700001)(6506007)(5660300002)(8936002)(8676002)(15974865002)(6486002)(36756003)(478600001)(31696002)(36916002)(70206006)(70586007)(4326008)(316002)(54906003)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 13:13:35.3955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93d6d2-a5ce-45ff-7f5e-08db554630ab
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See below (mailserver has a top-post fetish)


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 15-05-2023 12:38, Krzysztof Kozlowski wrote:
> On 15/05/2023 08:25, Mike Looijmans wrote:
>> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
>
> Thank you for your patch. There is something to discuss/improve.
>
>> +
>> +  swap-dx-lanes:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 8
> Missing minItems. Bug in the other binding caused this one to be hidden.

Will add "minItems: 0" in v3...

I initially based the code and binding on the usb251xb. Later found the=20
mismatch and fixed it, but somehow forgot that I copied the "int8-array"=20
too.

>
>> +    description:
>> +      Specifies the ports which will swap the differential-pair (D+/D-)=
,
>> +      default is not-swapped.
>
> Best regards,
> Krzysztof
>

--=20
Mike Looijmans

