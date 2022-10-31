Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA18613113
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJaHJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:09:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A2EBF52;
        Mon, 31 Oct 2022 00:09:23 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=X+MEr4a5wqwLxeazXulZsT6ytT4VnYmlMDwC4FBauQDxkMCjCcJS97FR2pgYeQg+pOqXTvYBvaA5YF398t7DV6Ai3uKtnif2vMh6A16nEC2bBcg7Tbg9qV1is1zlrKmbdJGuj/qWogapEyx1jmxprW3idnIiS1PK5gL42GTqf16+YsIgquQGPeKATwaRBoPcKoSqOOYjrKQBRVKBAunBrFrRrxkz3NPTJNWglvHWcHe7Ewr2E/hjchlsr6lLzGkfGJOToT4PuSWkGMQyU4NO8tD4k12sQzAAD4llVpfSKsc8s6ca4Roxfjls9SaWMGdAcBVIkILDt33ClhtLR+DndQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9l6igGCXVdh0j22NIbdSD++gNk8SAYVWQcNMGRggbc=;
 b=UtYSdktzwJI1wOtgE7FAAWNa0E3mBVNrH9qP8k4EH2o4RNocidsjdoHW+q5ijfgUruHzCzj1HkwIz+Jur8ZDSzc/5DM6vLfjiDUgE+vZJ88htaZu7TmhUhqSFcFJBjmEHCJ1ZXo5NFpQ0lqVENqaB8EVT9wcONsmpv5vTgdHuU+QHm0NHe2m8MXAo9PYK0n30XhUNS1oIeBnx039s8y9ws0XWy3xw2s9OZxc4ZO5T9Rd225w11Py/uybIgx/V5pCAZR23UPXiN/GymVyhifiqD9+3RNK8vUA1bE4i2u/TM2fc5t2f/m2EKruURE+EhO6eDoONGqZLiAgLJCh9U3TyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=delta.nl smtp.mailfrom=topicproducts.com;
 dmarc=none action=none header.from=topic.nl; dkim=none (message not signed);
 arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9l6igGCXVdh0j22NIbdSD++gNk8SAYVWQcNMGRggbc=;
 b=NrwrIwBR74qExesg1/IZ57vgS9T/bLpgrS3VjLDdWDtzXpzbpFNHDkv8rcn3aRitJ31KQNxyEXO4bD7GT0+i+iMeRFVoabmOzNPc8fQYc2iepmYYdap0bHVxkBjjJ4bEYdeC9ghQ9rPOpAVVBSAzRaAkLzHxgGpAhoZyjZwSz/j3gtl5PW3D8w2luOHnwySWeHyHr+c+lOIZRia2IjpmCdqShX318T4/JOGPHMLvr2sq/PH622kAhd0mfSvd2xCIpztoPLMQA0eehy2GfDx4v57ANsfYh4jjX1RHz69yxSZzI8E64hJuB2863F7/k1NSEN6mCRxtwGWiM96M58838A==
Received: from OS6P279CA0019.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:33::19)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 07:09:21 +0000
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:33:cafe::d9) by OS6P279CA0019.outlook.office365.com
 (2603:10a6:e10:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 07:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 07:09:20 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.173) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 31 Oct 2022 07:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8CK+h8WGkYdYZYXeoNOHIivSGhqiiOcULgyYI0QA422TMRBdhLY3EQ84ya/tu/35Pzqbu4btCdScW/RTKzkffRMQc+1+o8z6ZhTNQ3t3tpcz2NdBN/GrBCbTrTqlcZhG8LhuOBLVMVjNubMQIJxelNuUvv8a4gSANQGLSn1vF8OcQy49X23yMGG2/wCgM7qbeU0enZJ6jYGbe2mRmrwKeFzzzPqtJve47z9elkvsjV9WmtQZkywYa1B2oXGhaoRFEZaQ9mBEhngi88o4w9lAwv0TRSFEI5zDxBAZxl52zztZtK/ulP/baTJ5fbnb/UVKSVQiXOPRYkygKQsMjcjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLyG/U9RvpeajtQVuFrZDOnBDZs+fJ6f9G6Zp0RxXT4=;
 b=CM+iB+Q0fAjDr0DnpC26KEKeLlpb2R3eQQl4TUwO3riY+UG/bk/de/U5oHLtSVTAInkaJKdAxYiWr6a8NW8fbnzSbI+w+3toNgkU11vcj9FF3Nd9tiDPJ9iMSGrKOyk1hW1iEFVXa++oh3DT1Q4gtFGQfHAEA4gKU65e2pDdhF0w52hOosloCmnm8+5Vmq9qHYcuSo22jnTnP4tXstxscJiu6xWeqLwTiLoLimGTmD8XgTJnfL23PMXIglOa3B5+p3z4Sl4Mo+MLmKfZXTcuB1OUMi7aVEZIATg2aoD+RHeonEWUL2NJdTe3myrJngDa9Tdh7AtTZ4oM9tebiAh96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 07:09:18 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::e9e6:da5:b455:2c6a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::e9e6:da5:b455:2c6a%6]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 07:09:18 +0000
Message-ID: <6a1b9082-6c7e-7a3e-591f-e7ee0a068c10@topic.nl>
Date:   Mon, 31 Oct 2022 08:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: rtc: ds1307: Add support for Epson
 RX8111
Content-Language: en-US
To:     glasveze@delta.nl, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
CC:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20221031065406.5684-1-glasveze@delta.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.9ece6833-e74a-4c7a-a461-cb644d735850@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.26ae0640-23b6-42bd-b752-f9965c8a2c94@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
In-Reply-To: <20221031065406.5684-1-glasveze@delta.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0079.eurprd02.prod.outlook.com
 (2603:10a6:208:154::20) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8353:EE_|HE1EUR01FT063:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: dc92d0e0-bfca-4926-063a-08dabb0ed50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NQf1KDyeqDVVvNndmDvL02mvgLcdq4RLwYuyHrBXFo83nxWCPMDtZ/ogpBlCT6wob97JWgBHRQcOXKveU/wbJgdhQyrKERLA6GMvNyZHbeynAkO7fmFgTy/wHKIHbIOMje7bsZvfnxdmdLS3TFs00oFp27nJK6TVTjYBRhAmCEar5G+4n4xgboiyWKdEJo0z5hmT/jfSQS4kmzptRreIRW6PY55vrByZesgeEESNDx4mdQOCLQtVLbV/yEWkLV5oxVnZoZg1jqFzj4U98K1oRnCRrsvN/9EQBg/z/qOrns07Dp+BwC/fHgo84IaAKaPk5UlmfduR/g3n3OKrrMtaEjMzPrdDeOIGIDZJPdGEK0w403q45XVjgqwT3xtbEuW4TlHamyYqMU4PyfcDm7nabNYpPfRiVbVuZDtur7xmB9mQi/47OxenBcJ1lowOoXIukIiV9iVAMemNrorS2Q0g4iJxzDmi7+Eh2X2GyvwYE4TSg8ASSHGWWeYjRopklPPA3QTa3me682cVEycKD77IO9k0PHArHjsd3ljvELVtDI3ebswa0cWSmjifTKbT8iCtf9lSbQZqWJk25/n8aadC9l53ghaj+BpeRQX12OVDZ9unqpGCTG6xnV49CRKnWv13bkC3/AEqEV4T206aEfa4ZLnp1U+A7o89kNiV4+LnkgqZrljk19dd2lebM9+00t6F4t4A4uMt9HPWY8LJO9q/HT10yzzUCIlYdzrl3WXaKozEtVVdrVZpaoKV2hwMFrfezzySD5xW1KI/gNG63rwdnRT4vakrYjOHrlXeMCmjUuJA/YMumy0joldZybi/k/q5aIGX0wcD2iOuUdAPuJh9lw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39830400003)(396003)(346002)(136003)(451199015)(478600001)(5660300002)(44832011)(2616005)(186003)(6486002)(4744005)(31686004)(36916002)(53546011)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(6506007)(36756003)(52116002)(31696002)(8936002)(42882007)(2906002)(41300700001)(26005)(6512007)(38350700002)(38100700002)(83170400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8353
X-CodeTwo-MessageID: a75dcafb-7f55-486e-9778-bf099dcadce1.20221031070919@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2f0f4ac5-c5eb-4f08-92ea-08dabb0ed38c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GqwpPRvou78akBWMuBq30GqnTI34/ONqR8PNfvs9B5gM36tV99aay3boujdw3wyk/8OVpecrTW8AO+PDBKmmaSaeYS4rLRv22Waw+gHZOtmcPLVTznwr8Gvwa2d4SX/cyNF1z6R0LxoWWsEjFkORrVZPA9Zzw589oM6oA4TUz9zsmOyfm4+sWPLvy984BC71u2TbfScX34a4saaxtAFu0rEKkfsIn7rp1CWe10DgKnyPa77zmzr2GZffGJiEOleDUGIz9N7FaPLvFuze0jDuNvG/wEjYQrk9B65LY8GedjZrcNPTxs4Am875VasegoRRFK47pNxdPOJy+fdxMLR/JqMhHI+0tgmJiuGB5jIPHYT9UNo2qzFaiLP/knfpidVPdRdqs+m7XgGfuQF4SAKHJX7rHy7HPPlfkDrqiH20sAR2GEFQ0SDrcpaJb2Y9GkOBew/Mcu0LZZMAuWs+JJjUX76uMu0OwDmDjSD/M0bW1DDuqzMLrKxyt7J4n7H4LoaZUFB3BpGeM0JvFxzsi2exU8ZAntppZ5dkItQ1XpBi25b57WEY7Pop82AKS8qCWFK5S50epmqgPAqdsMpZEL0PD/tOXmWxi3si9kjhSQrvZ03+5j3vGKhiUXErCJWTbbuFJsdS09D9VQFlRtLHyg/xBPFQCTE7EFpmmPvHGJCxI+FvKqrbRTBC7yXyPayEjQLzJcLpJ+9FzZtLIMr8C+REqXl1KgnS8U/ejF718i29RruBAzicSKh6Z/qkzYKNpqCKe4DIu7OssA3PboLxwChrvnBJ/B5Y3N0TiDUU6qSErXYgirYoJMdHuLV1VqucuBb
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39830400003)(136003)(376002)(451199015)(46966006)(36840700001)(36756003)(15974865002)(31696002)(31686004)(83170400001)(7636003)(7596003)(356005)(186003)(47076005)(40480700001)(2906002)(44832011)(6506007)(36860700001)(26005)(6512007)(478600001)(42882007)(336012)(36916002)(53546011)(2616005)(41300700001)(6486002)(82310400005)(316002)(8676002)(70586007)(70206006)(4326008)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 07:09:20.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc92d0e0-bfca-4926-063a-08dabb0ed50a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the duplicates - there's some trouble with company spam=20
filters that won't deliver mail from myself to myself...


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
On 31-10-2022 07:54, glasveze@delta.nl wrote:
> From: Mike Looijmans <mike.looijmans@topic.nl>
>
> The rx_8111 is quite similar to the rx_8030. This adds support for this
> chip to the ds1307 driver.
>
> This adds the entry to the devicetree bindings.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>   Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml b/Docu=
mentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> index 98d10e680144..a9590da64b84 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> @@ -30,6 +30,7 @@ properties:
>             - pericom,pt7c4338
>             - epson,rx8025
>             - isil,isl12057
> +          - epson,rx8111
>             - epson,rx8130
>  =20
>         - items:


--=20
Mike Looijmans

