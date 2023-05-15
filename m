Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA17702DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbjEONSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjEONSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:18:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A919AF;
        Mon, 15 May 2023 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAOudZjuqeeEHJYY38GLjeqLGu3pdn8rrtm/ufBPB8o=;
 b=XFqG1VAecFHqhb4Z187fPwwGCqnyfnYnugiKOcKM9urowOi8FMtH13u//wVIEhZqPRQfQBn9feBD587tmP757jD2GAMR4/sBBsfTcZlx36Q9PG9pi/wO+88192bHNQlDlxDka109tNy5FxoP36DapOkSXUFKcFMiCK8tlsZhuiPrTZ7eUoVvPu+1jOpkh8VSaTOPm53d4Otz2+rR383TMjw+YuUxaVEVOehNV8ArynXGuqj0Z7Cz+WjLnMmYLnd5FkXdNgboy7tRq+PE662mslz6RavIhV+hlFhCTSU555v3MN2DTTpmuvrEYQs3UotOGBt6Ze5MbkrA1kdiRShgog==
Received: from GV2PEPF000000F2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:d) by AS8PR04MB8264.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:17:58 +0000
Received: from HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::208) by GV2PEPF000000F2.outlook.office365.com
 (2603:1026:900::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 13:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT062.mail.protection.outlook.com (10.152.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 13:17:57 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.109) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 May 2023 13:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ith8+6fRohWmNEAH3EAntazZ4wQqXDJ8sok41lowiHhBafP/5sRo8tKpb56eaDoXkgTGpAnHLbctCUOF6XDz8G18ucS1sypUGTD1Otmm6RSLR7I1Jelj9kC7G9fpKQM4Z8umblK/WBzlSn3D1bSDN+fkU2Y2KqCtgMLKKiRGsfcT/65ZNvaI+JgUZwGZbCXxIL25NY6LXyWUdBpTICA5y0b/jM8I0AZlOvx3I+Mltuxp6oHnIdWIDI+VmfQmXUZOlaIX8P30Hrr8cOtf9yEe1uehg0wgadvV6jrxVRAVgRK2KaCjVKhvb4Frqif5YHdGilI/YxgWiSw4AeyFUE7U9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F39GGwWpKW7y0i1+gJZatR9H/7cpHTBEkvhbncEk5JY=;
 b=RMMKmHrxVe6JCXcjTn/C/J0ToU0u4cfKaJoNpzYAy2GGoMbO1t4VG8w0gdctEjiMFq4ew1WbNCYzKzGskzm7M1xuwCPRiQnVnQLGbT/cf5W8UwHXAOMHGCdQIRJ47PhvCWownBIqXk6LNq58g7V4LZg517uQZDvn2JDSskwqPKe0hSNJdT6kXM7N/HPFYnDZqvahz2+E8B+4e6z68DmjB1kRkgrCyVKll2AKr0OpZIDl9tbN1ZGlk23B6Ks+miGJ++qAzhFfw0DeouhgEDa1hKJT5q4QKjwZYqWBhyFTDzOh5dD+duT7PtoTKG9cQxNIsTFHt7kXpB/zPEKX3RCtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 13:17:54 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 13:17:54 +0000
Message-ID: <da66656e-ddd6-99cf-41ee-d6b2d318bdff@topic.nl>
Date:   Mon, 15 May 2023 15:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   <mike.looijmans@topic.nl>
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: correct swap-dx-lanes type to
 uint32
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515103337.130607-1-krzysztof.kozlowski@linaro.org>
 <9b62a0db-1374-2c89-5ea3-286467bd1e4e@denx.de>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ed9c8f5a-900b-42eb-a8c2-543ccf3145e3@emailsignatures365.codetwo.com>
Organization: Topic
In-Reply-To: <9b62a0db-1374-2c89-5ea3-286467bd1e4e@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB8047:EE_|HE1EUR01FT062:EE_|AS8PR04MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 471f8438-b0ce-48a5-834d-08db5546cd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aHZgIw+QwlsBvsX7jyv7h170Gb7b12U7+srqJK0JNFh8u0jDIvvxi194lB3KPTjbia/M0F7KVbd7UNKf93W/p2l/c8qWFZhX42kFci051Lp/yfZMo98r3QW0PntunhwpJC57xWmW8RZ+3bI0/6tQuoLVM3wOyQqDawjGLrjV+c1aL1lJOHUNr9/wE4m9JLfzhSWFVBkU3UtC/FEyJ7YmtEjJGPSxA19Pz2pX2BhGsvG7spb47nB3Qj3vj1PXlQvIAaBXUq654aU8vF25L3Gj3Zzk5l0HGcqi5EI+xYOqODEsKLOaxURpzmS0EVO1TqNpSqdkpbosb3sN8ML1ry/Z2Z8qs0VdTtKOighzOCGmeP8quKFzRTXQ2rvWnK5nxaPGQP1a/VIw2D8OLHXWPdRYOaYG+PVWV8U8tu7QhjTGRFXskT283/86l2RzA54qPp7qQ4T5PZ7o+GJzSRIhqKkResAI8fkt9BBgJYvN3b6cLUqtWIfJmn+tVDhizWLnPmdCiEyzT4ebknzLifdxK+2yxitcWbSxSXhqDEgsXWS0Ki/uoc4avn0SqVdEojJfW9B0M3Am7175VXt4hJhfi+fQKTibse8VQSSlk5+ZBMPliLvQtvL+mM5rp1DNb3OgHSLrOYZisvq05zifkGz/W7gj/xTB/2IuUQ+fseqJJuoWVTU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39840400004)(136003)(366004)(451199021)(66556008)(110136005)(478600001)(66476007)(66946007)(52116002)(36916002)(316002)(6486002)(8936002)(2906002)(8676002)(41300700001)(7416002)(5660300002)(26005)(83170400001)(921005)(31696002)(38100700002)(38350700002)(42882007)(2616005)(83380400001)(53546011)(6512007)(186003)(9686003)(6506007)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047
X-CodeTwo-MessageID: c4771525-6ba9-4077-a7c7-8338c9ba1028.20230515131756@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aca71feb-20a9-45da-d81a-08db5546cafc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY8iJCCSxFNaeiU/G1PhBE5R/LeTMUAuNjjY/1ussXJNGNVmzl98XP4WJN6rJLjoeks2yP5lRZGSiikA3LBpGOo4iPRdvIJyoU4/IFkxfknrlWTqAX3YGLMnZEyPWkJjCqYUEteopjZWb9tfn8ihkMJcy5/8AiJgJlkxqoiVj81ra+V+3ip0L6Ep+kzM/gYKVUjthtstFYkmUjpYsRU8USSrBu2ZjP/FtWQ06CwH3ig6ApjNopM4iPT3fvsu6AEhdQBLy1GLKoo0w8VOOfq2Qg1OvnykoBhxkMawFz2NjUazWursqMZC6Uk2GI7Rk9h06E3sqk8dzNyVbMqbnGhVHPOI/MfcmlKyycrLHDl7nBelVSrOVTuNY0iSXYDJ7FzjQ1S3Rn4PxiIIBD0cap1uTxWFJChdbxmA4u3ubZlZjFlGgbrSgPP6rCixnukyijxYsaLlOfqTYu4ASSnnxbeyHP4E7OQL31XyIv1FvI3rQVYADC6WKiOv6FjgT9iGlPTfYdQzPchn4rtzvUXmBg+CtBrPYxzn7zpLMPi4s88W5UGrRy4GEaD3Sqg0BIPsisTT7BvD5cS6SHGBWXVzabBxHgI5xB3tUamEmQOASC9J0SXr7JLb223kAipeHU/Mx5OUt1nh2XFtv1+w6t1yc6NXGk5TdkB05oe9hTMPcbjfxVZWA0dQ1fRHcGCjb9OVoH0slN0/uq+bd2s9Y+/9yZmKHFj2SAxq/VbCUvz4+sBk+HmMfFJocRmCqYrFIjPnrrLz
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39840400004)(451199021)(46966006)(36840700001)(83170400001)(356005)(7596003)(7636003)(921005)(2616005)(36860700001)(47076005)(42882007)(336012)(186003)(26005)(40480700001)(83380400001)(53546011)(6512007)(2876002)(2906002)(41300700001)(6506007)(5660300002)(8936002)(8676002)(15974865002)(7416002)(6486002)(36756003)(478600001)(31696002)(110136005)(36916002)(70206006)(70586007)(316002)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 13:17:57.5291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471f8438-b0ce-48a5-834d-08db5546cd06
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8264
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See below...

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
On 15-05-2023 14:55, Marek Vasut wrote:
> On 5/15/23 12:33, Krzysztof Kozlowski wrote: diff --git=20
> a/Documentation/devicetree/bindings/usb/usb251xb.yaml=20
> b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>> index 4d1530816817..ac5b99710332 100644
>> --- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
>> +++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>> @@ -231,7 +231,7 @@ properties:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power-on sequence to a port u=
ntil the port has adequate power.
>> =C2=A0 =C2=A0=C2=A0=C2=A0 swap-dx-lanes:
>> -=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint8-array
>> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32-array
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specifies the ports which wil=
l swap the differential-pair=20
>> (D+/D-),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default is not-swapped.
>
> Would it make more sense to update the driver instead ? I doubt you=20
> could have more than 256 ports on this device after all.


I guess there's a bunch of devicetrees already out there using the=20
(misdocumented) 32-bit array binding, they'd break in a bad way...


--=20
Mike Looijmans

