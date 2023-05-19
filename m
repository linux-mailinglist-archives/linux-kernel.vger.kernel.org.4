Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74097097E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjESNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:03:52 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5345B6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684501429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qw4WHYbaSVESRX4XQDKLWmUmx8x0UqynYNI5g+INQZA=;
        b=dxgDTxBb1UDcSi5Yebj+94LnX34bCOPbqBayWTczKZyqH+ej4pXwej8SaPCPa2ikNZZDiQ
        T+rR0Yp4Gmbm3i/id+XVs6mkgd2fxtNttB1OybAQEkDCZVknhyD91ACFOfaGsDanjGQOFm
        KwM+AMTtEhV91KO/hzpOX6HJsbE/C+8=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2052.outbound.protection.outlook.com [104.47.20.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-122-EWaNQDRqNu6y0to4a7C6Wg-1; Fri, 19 May 2023 14:03:43 +0100
X-MC-Unique: EWaNQDRqNu6y0to4a7C6Wg-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB3416.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:03:40 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 13:03:40 +0000
Message-ID: <1e4e6886-70ed-2db3-23e1-b22bf2f39dc0@camlingroup.com>
Date:   Fri, 19 May 2023 15:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: sc16is7xx: Add property to change
 GPIO function
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230518132905.4182265-1-hugo@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230518132905.4182265-1-hugo@hugovil.com>
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB3416:EE_
X-MS-Office365-Filtering-Correlation-Id: 454553fd-4739-441d-c2b4-08db5869774a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: L0aVNyjJeYq8S74dojKK3T0rffjpF/AQ5my9aJqw28fDtwj2sa54KCO8cCyFPU4a0yCZeH5F35vlUA9SlM5vH8MPhT3bfRf4tOlSwoF16TZ0HNaQAvCLtlcpu7stYV1zAXUQsdDoAlzrPiOrlGriKEjkq2l0Fi4G+1LGWTszvhVesvKYI4Piq4REc9KyfTyPz3f9HfYJmQS3IRZFUbVte5O7y7pHGD/FPYJI7bnhBY2i5rPDy8kociClMMu8MtIAgOHJjXP6ZNXmJhoa2ge/9hhzLp7dVQFa74+vRrUtmp9vKWOwTNg4hTHH95pRLpTvEhExUO3RGnobRcvvSwic2O6N0810XHBSYl5l/5SETqGpsErvHwzEqs0osIxvxweJuixsZus6bjdidPnGtS6Z5OUGfde9EPUx+nmD0s/k11Qh1XPICFvgSbaWL8r26ZoSWn99b9o+Pd8fmUPZrKKQMZ1p6UU6qJalRX6Je6tNIOwpMrOr9QhtZhUzSCYp9Y956dZvQatjr8cjIUoliErJX5Q3UV2fM/DXCW86gcksIYZpYfYvBTJLSCvMmQKvOPeBrOX2MF86GCJBM2OW7+T0LFJMK8wMgJiISl12TsreVYyEp7wMzGQFJFEegIG9aaqIvlj8HNpyp6hryKZHFOm8DUgLkDUxcbYFlCGyLHz6KeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39850400004)(366004)(396003)(346002)(451199021)(31686004)(66556008)(966005)(66946007)(66476007)(478600001)(4326008)(316002)(110136005)(86362001)(31696002)(36756003)(83380400001)(26005)(2616005)(6506007)(186003)(6512007)(5660300002)(8936002)(44832011)(7416002)(8676002)(2906002)(6486002)(6666004)(38100700002)(41300700001)(45980500001)(43740500002)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFKRQpINTWYZ5Is2jjeGRx409tc49VD2ypDJutlkeHfenaQRqIYR6jFBrzOx?=
 =?us-ascii?Q?qlR3nQ+lLIx6gNCY7bKcfVcqpFZvhHXRB7xvwWS1MpjwJiZV+05jim1lp+bH?=
 =?us-ascii?Q?gXR8xDlFNObKFh5hUATttoCY8iXUqMiPwqUm1hsRVQTZytWP5APxeHTtfvSF?=
 =?us-ascii?Q?xHRdUkOcNfXyKS2hEHQWbQuJsYfEWoQiqikrToV2Z79GbwGtnj2JDpeyyPbt?=
 =?us-ascii?Q?S7QNCb4W7e3p0MFqhXrlU5qtpvGs6AvG49wtohgF7Zjvm83p7r4l92VqKyZm?=
 =?us-ascii?Q?gokmq1h3ywkHSNZ24BCvjjB+RkTdkC2tgWVW1+CTvAIqEfJveuiWp2RAHDjx?=
 =?us-ascii?Q?hhXQiB/Vsvnuhibq0SeOEb0VFLXSC0Ee+ffgUbyfJrIwn6gc9kCUQabOP8v/?=
 =?us-ascii?Q?5NkRa8Xiz3HdHZ4yzU/cyWTckKn/3LvbGy90eyywZ7yPAMpj1mNoqwwdZ9eD?=
 =?us-ascii?Q?I4CXiDmVLY8ChKIgKm87z2LngwBpNrReJzUWE0Ov9tNMtCO5cLGVOVJVLCBY?=
 =?us-ascii?Q?EcPIPLxxerlncQhk+FberARdm/qkraIJgym6aQBhyhoeldBfQV2JUe5YI1ua?=
 =?us-ascii?Q?N6ll0ptfwr77Fq2VnqqjHprXIF3zGbi3cdQ0aKPvNbR5uiJvxx/LFMfW9lxc?=
 =?us-ascii?Q?3IjVdn18NQVGE7jeCU8TI2hoCsPER7gFMceDeDasqDZg4HW5i+RfXaNDAQ1t?=
 =?us-ascii?Q?6BgEXWacug/1xJYa6h/llSzBYhpGRh19JpdHKtG8sPkdbWbYV6DY2B3LD/nX?=
 =?us-ascii?Q?i+qXsMfTUWInHTmWTF+8fbJKer+TxWYAFvmS1FTZvA/x/iTDltNYOP0D8KWy?=
 =?us-ascii?Q?OOt2Z39LFl9zv3abRBvzih98JkfnXfpNvNPfYpp6znMyidk2l2BFt8kTwgx4?=
 =?us-ascii?Q?PnGQrqsLpe+WG/6nmVyIfMfp5DRTLBvlVhyPq0chEs9LQNuD67zebrZf8g48?=
 =?us-ascii?Q?Xx8FCkdpwGlRlcAXBij+jpMg/xc1/qQJJYatjBNQCba5vsr5WlFiPQu/8e5+?=
 =?us-ascii?Q?iD701RzVbK/T+o8OVLbwenfPJ7bZ9Un4KxP9Liv3DEzzokhcbKrqgCF3JN6a?=
 =?us-ascii?Q?Ofc4AUnHlenkUI4aYvrmIljk47pZV6/pKq+6XWjr7N5Tztgy2+kFxokG2Wkw?=
 =?us-ascii?Q?zbS15biMC8CEq8ikFqIRWrxx9Ex26EDXsObO0n5KtFHRTh3QV8OAhxayA9+D?=
 =?us-ascii?Q?JZxIrIRZ3q74znXRO/UeO+0DgYD6r+5O+VqBmDTPEP2FWrTrzYDJcei2Q793?=
 =?us-ascii?Q?9VC+T92LuKpUeojgXS2nXiN+AL/J6AbGyWdtLpGLMYt4jpk+xYnNj/n8ZvS1?=
 =?us-ascii?Q?CeoBPH0MHQuKZQkneEFgk6i5ZA5q/ZWtqMLj4rGToeH8M25Q4pKJ3AqIw+B4?=
 =?us-ascii?Q?FbFHB8Q2euFIKeTJ2UG3NGwalswd2PCYjRr+TrGmw/EUjbizIr4dQdl+ZqGr?=
 =?us-ascii?Q?wjj79ewJnqC/xX5tJyNwAiM0e92cegjk56YkFIcDpvG9fHisXhxwezwNlCbE?=
 =?us-ascii?Q?Mwy9Kh72gGpuh3vpsvCjFrUeZ0noBOBaE5X8kwa/dy5cmjt+ztN73B7UBcf7?=
 =?us-ascii?Q?UCmahSVzCK+eQQRvwekMePt1+3ybsaNAqrAooHPuMwM4B+h1xBnqmCOd+JZI?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454553fd-4739-441d-c2b4-08db5869774a
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:03:40.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6LNQ9qiTUqGRSb7+1c8yuVYgRZv8QhoL5QZM9+yCz9Bz3kzN0FXANf6xZezQ4uuUAhNq0/FfqOnXHB+xWAWpLSpFD2CDrH8ktC0XQxLuAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3416
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hugo,

W dniu 18.05.2023 o=C2=A015:29, Hugo Villeneuve pisze:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Some variants in this series of uart controllers have GPIO pins that
> are shared between GPIO and modem control lines.
>
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
>
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> v1 -> v2: Add nxp vendor prefix
>           Add git base-commit
>
>  .../bindings/serial/nxp,sc16is7xx.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b=
/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 0fa8e3e43bf8..23a81c83f012 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -23,6 +23,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>                    should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
> +                               should have shared GPIO lines configured =
as modem
> +                               control lines.
>
>  Example:
>          sc16is750: sc16is750@51 {
> @@ -35,6 +38,17 @@ Example:
>                  #gpio-cells =3D <2>;
>          };
>
> +       sc16is752: sc16is752@54 {
> +               compatible =3D "nxp,sc16is752";
> +               reg =3D <0x54>;
> +               clocks =3D <&clk20m>;
> +               interrupt-parent =3D <&gpio3>;
> +               interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +               nxp,modem-control-line-ports =3D <1>; /* Port 1 as modem =
control lines */
> +               gpio-controller; /* Port 0 as GPIOs */
> +               #gpio-cells =3D <2>;
> +       };
> +
>  * spi as bus
>
>  Required properties:
> @@ -59,6 +73,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>                    should operate in IrDA mode.
> +- nxp,modem-control-line-ports: An array that lists the indices of the p=
ort that
> +                               should have shared GPIO lines configured =
as modem
> +                               control lines.
>
>  Example:
>         sc16is750: sc16is750@0 {
> @@ -70,3 +87,14 @@ Example:
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>         };
> +
> +       sc16is752: sc16is752@0 {
> +               compatible =3D "nxp,sc16is752";
> +               reg =3D <0>;
> +               clocks =3D <&clk20m>;
> +               interrupt-parent =3D <&gpio3>;
> +               interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +               nxp,modem-control-line-ports =3D <1>; /* Port 1 as modem =
control lines */
Just a minor nitpick: an example showing syntax for both ports would be gre=
at.
This can be included here, leaving the previous example intact. Otherwise, =
LGTM.
> +               gpio-controller; /* Port 0 as GPIOs */
> +               #gpio-cells =3D <2>;
> +       };
>
> base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
> --
> 2.30.2

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

