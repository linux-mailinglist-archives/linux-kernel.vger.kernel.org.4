Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3896DED22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDLIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDLIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:01:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7365A6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNguWbLM00yqva0F62SOPzmbMtGuf2TlQtTDfBGJKgji8M02Gmtxg2ZJwNCerQEnSojqa6H5kjNwMD3UK4OTPDRoIKzXH4T1z8A4fyAMxsRp8uZFv/4854BR2fbwoi8jiLIzPYjOXKfOwO1KZPfL1BinJRG2Q1ut5I12KQVom9IkMBaTs2a7oVxessdYUJzCXDc6ykVZO3FovZ+jcB2s0D1mK/B5EGkJIlMNGMujzyNqL1dRbDLQSUo8RCBsWaRJrurCMCgHsruN0QwpnXRsiciMEL+ofWQyzLpbI5BxYkNYL7qegOCJj4ZPKL83YvXs2rqQisabNAVYJ4c5/LAi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtphOvRZsE+pWpzHYqkV6OIKaLhBwWDlJBdWC4nbdkI=;
 b=jz1chODD1hEARYq5E3cQkuknsRB986aZBxNiRCeL78r4+t6otSotxyqqDv7fk50PxhN15As2t38ebUwq0Nb3fHoS/T7SbmLTG1BLDujA//0Ha4PrdCuxvwm3/KjoJfTlpR+ANJOMUHd1OUhl5kKfYY8kpP2BJNHe6SEUsJWQyIhnXfu6QlPBpP0p6AhEQftu0DbugKQlD3SjStljjpINBCMDTUY2NqEPYQXSDoM9JlpBcNwxcM4pqhUzj45nEIvqXriBMYo0AfJANAbY/VNuY0UXgTbOKijVdsWROsaabsoWONEcWOjdbbAwJ1ZpWm55UZzf4RBIsupeKqq8WO1GQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtphOvRZsE+pWpzHYqkV6OIKaLhBwWDlJBdWC4nbdkI=;
 b=OmTWYisG3x3HVRID9enxpxg7dD0QJDZTXT0BS04jB3Yem0Q825QyfkTa4JEUjB28nm2hV0LmnflOdwuOgfEeky2xrIWbawEizLTOH94XSOJW5jfRERVWG8xlJISu/wgCpeOPgWfv8MCaSJtABYubKtBhmbEx5By9HNioaJCcOo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 08:00:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 08:00:51 +0000
Message-ID: <99aeb60e-4d30-7a2b-318d-8b6f07776fea@oss.nxp.com>
Date:   Wed, 12 Apr 2023 16:00:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [NXP ELE-MUAP 1/7] doc: device tree binding addition for ele MU
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        sahil.malhotra@nxp.com, aisheng.dong@nxp.com, V.Sethi@nxp.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
 <20230411162536.30604-2-pankaj.gupta@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230411162536.30604-2-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd508a5-be0d-4b50-f686-08db3b2c0822
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ctTRFT2ZCyvOVdjpzx9MvVIZvYjP7Yk1xrz67Qw8RaDGjSYqvPKEXJZEifQSk3ac52G1htUfBm5cU1/wXkwxzoIs7h47KX1mCrdaPQGS7GOjVkJht0/qhrPwbLjIBzVnUmtKtIFrqJXuZba9TfqhH2KQGC5WUHZOoArEdFNe6Snyh5r2uB3U7W9y5dtsRC0gKcBq2Kmep91krcsxZVputfjn3udgdWMvyLYdv2NaLe52uOt0Sz96DCloceuxtFux9WwZHV1i1rN5kiW7/crVRjS7GUctRvkMe2lfKM4JJUTMkQxtmfSm4dfcXHKnyhFm5J0brbTS8hPO/vWwE3oSSgZlP693BXXT8mLa6C0w0EHqsrX5A04eUxKxAW7DYbD02/I1YZXXlozceRAcTK9vIRHZjPIBALzZ+uQJL+JehG2VAfM29CSnoWJop3anqd+gFGWxsPCOZUlbkMWXzNJqhSp9t3MoYuGi2yTnssEfqqGnU9OZzt9K1q5XHj33RDmHTVwDKTxjrIxMzOHGxDvhd2SS8k9ZUGGsf0pRliXsuav6FAjsV+F8lQ4/6XJtZcxJpOUfAYJ0G8jLiFwr1jPSUtZQM8EPEnyi2mU2DpF3Znisbk2gh1nsosK+Mp3jAEXqFBOY2Yvx1Xl8bSjK0e2vEN/F2qS1rdOHY5F22FT+FNFsGUt93JEHPB8oVB/F5bC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(478600001)(41300700001)(31696002)(86362001)(31686004)(316002)(66556008)(8676002)(66946007)(66476007)(110136005)(8936002)(6486002)(966005)(5660300002)(44832011)(2616005)(186003)(921005)(38100700002)(6512007)(53546011)(6506007)(6666004)(83380400001)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJydzlDMi9WSk5GaVN4UlZ3SzdlandJUXR1K3J1MVhQTGhHSEdqV1FCaHFq?=
 =?utf-8?B?aGZCMFkyMTRyM1pLRnd3M1g1UDZQSW03d0d1WkhUTFBTa2xSUFV3MjNWempZ?=
 =?utf-8?B?aVhLZkszUFlRU2ZEM0lia2NRRyt1UW1aUlZSTTVHcWdkT3AvcnU4ZFN4QUZS?=
 =?utf-8?B?T0VpeWdsNUw0Z0w0dTZ4SXBaL3pSSFNvT0o1cEw2cStrNmtiejdNU1J3emlq?=
 =?utf-8?B?ZmNOeGI4SjVwZllCbmUrRExtK1BXTFJTRk1KcnVqTTlFMS9sWXhVVWcrcEw5?=
 =?utf-8?B?MWFZU05SNVZGYnBYNWtHVlVLM0hoUGpJV1ozZVordUM5SGtBSjdKNG9nYWFG?=
 =?utf-8?B?UkNSZVBoaUtUbGhQUkthWnpldmFYekZWUmtFSHRvMjROaTRhSkVFZXRyUW5E?=
 =?utf-8?B?ZHdPT0JzRmVOTVI5WGs3VlBCRjdvdVJraW84VTd2OEw3SFNNUVVlUTZtTGdy?=
 =?utf-8?B?bCtraExBQnpIcTVVVzNXZGFzeUYwM0NjMzh6WXZXVmdkS2dac2dCT0JPL2ZQ?=
 =?utf-8?B?UFRPOGEzT2k4c3cvb3MyTGNlS0o3SGFCdkhwTDhMdFVoQmptdGplSlhsK04z?=
 =?utf-8?B?VFJKNWl3WCswOW5waHI5N1hMbHdUaGZScFFBYkRaaWJBbUR4SnBWNStsTmUw?=
 =?utf-8?B?VWNpOFRQUkw0MTNVb3gwenh2c3RmblhXdWpudWdiNFNPT2R1eVV5ZVBSWHky?=
 =?utf-8?B?engyT3J0T2szemJCRHpzM1daWkp2cDRsQ3F5MzltT0RGQ3Fsem5jaWZDQWxD?=
 =?utf-8?B?ak51ZXFvK1padi81bUMxSjVxRkdvRVJEWUpNVWt1Z25jV1pUOVYzK1VGK2gw?=
 =?utf-8?B?UE9zUzNnREU4c2xzSTMrRUNDazRhTGVSRFd1VlBXMnNxWVpTeTRucXM3aWR4?=
 =?utf-8?B?d2hXZFpJM2hGUUtXWnJUdXFUaHRDWGwyRzBYbWVVR3dHR0NaNFc1V1EyZnM1?=
 =?utf-8?B?SDVSSlJRS2dBR05INUVML1p2OU5Hd3cwUkRUaUJzbzhBZXFyTTgrL3lCUklo?=
 =?utf-8?B?TTdRS0pGTEpkVXNvUHEwNW1UTnhvL0I1elhBTmlpQnZxVWcwTGNrNTZQdE5y?=
 =?utf-8?B?WWtyOWxVb1J2QlV4WW11ZElDRGpBeHMxaGtVTTZEdlNXcHlwWVp2Q0dMbVY5?=
 =?utf-8?B?WGxRb2UzdWxqcWFIaUdzdzRxWnVDM1lld3ExdVdsRkhpRjRGYVk2dU5VOGEw?=
 =?utf-8?B?M0xjOHBwWnRiMzhEY1MxeVpkSmttNHFERFlBU3ZweE0rZjBuWWdGL1VsSWxt?=
 =?utf-8?B?eFVMU3lLYUVTZVJtNTkyNHFXeW96a1RhbDE0TVZxYXRMQitkUG9KeW1QK0JL?=
 =?utf-8?B?TFg0UDFhbnZCQ3FMcHBnMHJlTE9SWldRaCs5QWd4UEZrSnhVbE8vcWxGZFA4?=
 =?utf-8?B?elg4SUdVVTAxOVppeVM2M3NwMGIxSzdOdEN6M0RzUU1iaTk5NjZCcUZiQVRM?=
 =?utf-8?B?UFAyOStnREE1U0J6Y1NtRUxQM3FxNFdTWFZOaUlwb2ZMNm50VXkxelBrOGd2?=
 =?utf-8?B?M0NCQUNsRGFwNDV0eXd6YkJGdnRyVyszTytMdld0TDRYclhwU2c3Ty91T2NU?=
 =?utf-8?B?N2VQQ0JOeElFdEtBWVV3aldzY0k4YUtoNXlBSVlRMzcvTUdPUzRtdko4TVVP?=
 =?utf-8?B?R1BYOXBuUkpIOUNIL0xNM1hTTlpYaURiSHJydmdOUmZNRCtTNlJZMjdKbTll?=
 =?utf-8?B?Q00rZnBFNVV5VjVYZDVMMDc2T3BHVzVqQWoyb0s5Q0FxK1I3OS9mdzZHY25h?=
 =?utf-8?B?WU1ZY095MndQNzlnTFNabXNGME52TG1NWCtWbm15UU5WeU0vdlFrb1NaMWhZ?=
 =?utf-8?B?MlY3dUN3MTBMcVhMSnNnejhhVTdEK0VmZEF1QUlPMjV4bnd3c1JrNStPUjRr?=
 =?utf-8?B?NHV1Z1ovbWsxNFliUFBaWXV5TS9teGZ1NnEvM3BrNGtETmY2UHlUaGNEY1Na?=
 =?utf-8?B?K2t1Z0RGTHZ1L2ZySTM3UHBpMWhCaTh3RWhneE5GUEhhOHovNkVqenNaR1Vj?=
 =?utf-8?B?dFJLQ3g1bTRFVGpBRWpKQ3pERHk5NzAzZk82Kys5R2ZTWFZ1QWdQUXhuUW9v?=
 =?utf-8?B?UGFhUkJRbEFYYTlDTndaejdpYnpaOEt2VlJVUjhGQUp4WlJxSjJVOFZTTFNw?=
 =?utf-8?Q?qqypI9RNS6zu4vcCLDvHFGAA1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd508a5-be0d-4b50-f686-08db3b2c0822
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 08:00:50.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek6pAIngIfakJXvRGtJUBFwksOBJs7hpbhRYI3THwHPpJVj17XKWuBeTCPVqyW0Whr9KrlNBpl7FPr17o7ei8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use scripts/get_maintainer.pl to cc all. DT maintainers should 
review this patch.

On 4/12/2023 12:25 AM, Pankaj Gupta wrote:
> Documentation update with addition of new device tree
> for NXP ele-mu (Edgelock Enclave Message Unit), driver.

The subject should be "dt-bindings: [susbsys]: [module]: ..."
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>   .../bindings/arm/freescale/fsl,ele_mu.yaml    | 90 +++++++++++++++++++
>   .../devicetree/bindings/mailbox/fsl,muap.txt  | 89 ++++++++++++++++++
No txt binding. Only yaml.

>   2 files changed, 179 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
>   create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,muap.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> new file mode 100644
> index 000000000000..8f75a43aec26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

This should be firmware binding, not freescale machine.

> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,ele_mu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX EdgeLock Enclave MUAP driver

Drop MUAP

> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
> +  the id of the driver and Y for each users. It allows to send and receive
> +  messages to the NXP EdgeLock Enclave IP on NXP SoC, where current possible
> +  value, i.e., supported SoC(s) are imx8ulp, imx93.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-ele
> +      - fsl,imx93-ele
> +
> +  mboxes:
> +    description:
> +      List of <&phandle type channel> - 4 channels for TX, 4 channels for RX,
> +      1 channel for TXDB (see mailbox/fsl,muap.txt)
> +    maxItems: 9
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx

You listed 9 mboxes handle, but you only has 2 names here?

> +
> +  fsl,ele_mu_did:
> +    description:
> +      Owner of message-unit, is identified via Domain ID or did.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +  fsl,ele_mu_id:
> +    description:
> +      Identifier to the message-unit among the multiple message-unit that exists on SoC.
> +      It is used to create the channels, default to 2
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +
> +  fsl,ele_max_users:
> +    description:
> +      Number of misclleneous devices to be created, default to 4
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> +
> +  fsl,cmd_tag:
> +    description:
> +      Tag in message header for commands on this MU, default to 0x17
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +      - enum: [0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e]
> +
> +  fsl,rsp_tag:
> +    description:
> +      Tag in message header for responses on this MU, default to 0xe1
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +      - enum: [0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8]
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ele_mu: ele_mu {
I would prefer this ele or system-controller,
mu is message unit ,should not be used.

> +      compatible = "fsl,imx93-ele";
> +      mbox-names = "tx", "rx";
> +      mboxes = <&s4muap 2 0
> +          &s4muap 3 0>;
> +
> +      fsl,ele_mu_id = <1>;
> +      fsl,ele_max_users = <4>;
> +      fsl,cmd_tag = /bits/ 8 <0x17>;
> +      fsl,rsp_tag = /bits/ 8 <0xe1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,muap.txt b/Documentation/devicetree/bindings/mailbox/fsl,muap.txt

This should be in a new patch and yaml format, but we already have 
fsl,mu.yaml, is there a need to add a new one here?

Regards,
Peng.

> new file mode 100644
> index 000000000000..6854ce3467fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,muap.txt
> @@ -0,0 +1,89 @@
> +NXP i.MX EdgeLock Enclave Message Unit Driver
> +=================================================
> +
> +The Messaging Unit module enables two processing elements within the SoC to
> +communicate and coordinate by passing messages (e.g., data, status and control)
> +through its interfaces.
> +
> +The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
> +for use between application core and Edgelocke Enclave. It allows to send
> +messages to the EL Enclave using a shared mailbox.
> +
> +The messages must follow the protocol defined.
> +
> +                                     Non-Secure           +   Secure
> +                                                          |
> +                                                          |
> +                   +---------+      +-------------+       |
> +                   | ele_mu.c+<---->+imx-mailbox.c|       |
> +                   |         |      |  mailbox.c  +<-->+------+    +------+
> +                   +---+-----+      +-------------+    | MU X +<-->+ ELE |
> +                       |                               +------+    +------+
> +                       +----------------+                 |
> +                       |                |                 |
> +                       v                v                 |
> +                   logical           logical              |
> +                   receiver          waiter               |
> +                      +                 +                 |
> +                      |                 |                 |
> +                      |                 |                 |
> +                      |            +----+------+          |
> +                      |            |           |          |
> +                      |            |           |          |
> +               device_ctx     device_ctx     device_ctx   |
> +                                                          |
> +                 User 0        User 1       User Y        |
> +                 +------+      +------+     +------+      |
> +                 |misc.c|      |misc.c|     |misc.c|      |
> + kernel space    +------+      +------+     +------+      |
> +                                                          |
> +  +------------------------------------------------------ |
> +                     |             |           |          |
> + userspace      /dev/ele_muXch0    |           |          |
> +                           /dev/ele_muXch1     |          |
> +                                         /dev/ele_muXchY  |
> +                                                          |
> +
> + When a user sends a command to the ELE, it registers its device_ctx as
> + waiter of a response from ELE.
> +
> + A user can be registered as receiver of command from the ELE.
> +
> + When a message is received, the driver select the device_ctx receiving the
> + message depending on the tag in the message. It selects the device_ctx
> + accordingly.
> +
> +
> +NXP i.MX ELE-MU Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- compatible:		Shall be: "fsl,imx-ele", "fsl,imx93-ele"
> +- mbox-names:		Contains the name of TX/RX channels- "tx", "rx";
> +- mboxes:		Details of the shared mailbox node instance from the
> +			device tree. Example values are:
> +			For TX: s4muap 0 0
> +			For RX: s4muap 1 0
> +
> +- fsl,ele_mu_id		Contains the message unit id that connects between
> +			application core and NXP EL-Enclave.
> +- fsl,ele_max_users	For 1 user-space application, value of >2  is suggested.
> +- fsl,cmd_tag		Default value of command tag is 0x17. Though it can be
> +			over-ridden for futures SoCs.
> +- fsl,rsp_tag		Default value of command tag is 0xe1. Though it can be
> +			over-ridden for futures SoCs.
> +
> +Example:
> +--------
> +
> +	ele_mu: ele_mu {
> +		compatible = "fsl,imx93-ele";
> +		mbox-names = "tx", "rx";
> +		mboxes = <&s4muap 2 0
> +			&s4muap 3 0>;
> +
> +		fsl,ele_mu_id = <1>;
> +		fsl,ele_max_users = <4>;
> +		fsl,cmd_tag = /bits/ 8 <0x17>;
> +		fsl,rsp_tag = /bits/ 8 <0xe1>;
> +	};
