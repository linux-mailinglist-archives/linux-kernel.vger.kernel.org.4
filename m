Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63106604999
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJSOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiJSOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:44:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A51C3E77;
        Wed, 19 Oct 2022 07:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKNT1ZRvE7b2GHOCRilEUVZrYBoefkFhxMt3IWYCDAIx87jf45j5qqVcrqqFCg1uuS0EUQWvEhelRMrWXERdFuR50VpTmRnB46pdPLFpCBxtzH8tSGA+TnlIm3wTFHxJj2yqMgiEmpjew3JYBOmFi53l1bUARcPZnkh9U8hbc/dBVJoTlHVw6K/pLYnaySAvq6dgAQrYKIw7zpOFf6cx7NOxSTIVm+X3JRyRN0gbV9asuuCSku1r62W49DTzhYcNL7MEJl+kNVAvSyEL4B1mzco2Th+M5JMHeLML49boYvguAUjowcTS6rfzGB/Vs9uOSptRXDVLUrzbaKKrp8F57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YESVmSHODceoGwoKOk8rUDqHOEVpBAgtSVG1RvQIxEk=;
 b=P1+oDZJyS2GLytI6D07PRcTSDUairA6C8E+Tocmt+c0SMBMInNaPEyZe2OZxDa3JjyxFdPhGguWbmJB4tGczjcB+2wEBcHqMcAnr6CHrJeGJPNsFRvSRB6GuOuBlIaphrXEC00YcP6lmQDURmLXCH0Q8/KzKzxCFtEba/DaAvR8gTFgvo9xXolK4MBdO+VWImOhkGV1xWxA+NP5g7qOE0xL7LdWlrLLet/nm56REUVdU4tBxcYPapqGkAJVB1pe2wMOx2ORdEFGKCgTBKkY1SmvcuJePxRTLJt9e1ZVpEGNEwIyy/3qjMB8DJh9yBgfj5Vu1mYsrX/Ud2/zYzqeqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YESVmSHODceoGwoKOk8rUDqHOEVpBAgtSVG1RvQIxEk=;
 b=mqLSVQLqUSMya+DaKQ3t/ftkmAvvT4wQBRP12ek0G9evCXDH9g5XCVbymyXtvXgWDMcpwSIwUrUgwMaB62DyQ8oMC7vOHMY3XhRJKutpLCZCgABTGtxVttmHHF/Qgp4qvvHMYoRelKdvzeUkH/vbmtcz4+4WM8hQWJG3uDUlTt8=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 14:29:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 14:29:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Sherry Sun <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Index: AQHY46tPGsWS6/GjTUKv9PLcJYTIjq4VxoSQ
Date:   Wed, 19 Oct 2022 14:29:47 +0000
Message-ID: <PAXPR04MB91854B68F039C9F109398756892B9@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20221019110720.31722-1-sherry.sun@nxp.com>
In-Reply-To: <20221019110720.31722-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DBBPR04MB7900:EE_
x-ms-office365-filtering-correlation-id: c570dd54-629e-4fc1-5738-08dab1de5fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWs8nj1sxe0hlPHduc/jktXuJoLEHun8gxW/I5fMMTxCzYiQ6wfsV0LuGye+hbNIET2htSibMwg8c9mSWbwNoigcd1qCaHfW0xoN5K4CcHJps4OgFErcm541dKuhUuK+D8yutFY5/gxgeDDWnu3H751POlGr+FasQcBMeDc9b4+nIb9KsV73XnA1c8vpZNRXDWPH/2xyHFBbo0k7wpWJ6Vsit6F+h3gVoK7JM1VKdAQ9CkteOI+GUXu9k6ws+W7HBoYeFmcZLPLvG0eZhT2Ve/pS7X/izATLzD1MQmjQCwZpC3GROLhDPrjJlPm8yNBVJnRFktp0tl/GR7Tnmr17sjf9AnugTIuM3XqO4SIsfyHmuHjQvnMBxSMPLbnH4MSMrffI4RWma6zEeCbKXph0VKk9gd6Sd6G/HicwN0McpPzD2bpDonabbK3BAxJ4XhoAR0+49hPRK0tnPLbyxdoAvZ1nvEID6RZsaE7qJhD+vv5YQ/91V11A9LuObinDaxIMShQ/UgQ9sv3vixG6sWeG5I+ntizUMh+3bENstdVWOKfYLVulSe2ywvLo8Hd9egoHhxtXUm7F7hlybqacFNB4EE6cW3gEeFsZzDLqVlK+NitWBT4itfszBeP76W0oNvXFHXdP8GlblSI6B8Pti+X3b7ewCig7qtFveJd+3P2e18Gd1+J3BTqhrTu88hjs2iG7iEXoZJYlIqg4vtVkDFC2d6hP3/j6XtyfHh2VE2lsDvIjZQbLBD+uxCSBRkZWYtkIVx9YS9bmV77OMSF1unvwAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(83380400001)(8936002)(38070700005)(86362001)(33656002)(44832011)(38100700002)(122000001)(5660300002)(52536014)(4326008)(76116006)(66946007)(41300700001)(53546011)(66446008)(66556008)(2906002)(7696005)(66476007)(55236004)(26005)(478600001)(64756008)(186003)(110136005)(8676002)(316002)(54906003)(9686003)(6506007)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?euatY5+Wmj5suD1bhsBUd1FRJrDxCjIpeIcwaxhtPpFBPg4kTsVH9SUVSt9f?=
 =?us-ascii?Q?NDorFUT3Z2CKyS6RwQK+T6k7wAJuk7KuHE2FUEFMLHdL4Oy9HJ6OlxIAGVmN?=
 =?us-ascii?Q?xRrEYobxC2ngvy/8SlDQUKtWOu20p2b4+9mQpoN8aWC1NTZq/H6WefW/4LSw?=
 =?us-ascii?Q?RrePkQSVi42S0gDwCmEEZWQi6HLRalxGcjYsv04y2Pa8+fIutMmqNk/AlUb6?=
 =?us-ascii?Q?HS7lGZcvdUpQ7CQk2srKbjTrKohOq6URX8ldPPpIWAiBUmurRi8jhvo9KA5N?=
 =?us-ascii?Q?gPLxjKmWYWhY6oqcJuclypAxpCk9UO6kXlbXeFER29323uqI6ZE+qrNhN7G+?=
 =?us-ascii?Q?wW+ITrXuGO4m6WRfX4Ctkifl/uCQLWx+/Onm4CgldkQFinG9zf19m8Ingg5x?=
 =?us-ascii?Q?aY4OiocNE0UbF70JQYtfzcb0aniF79H0cnQUrH9XQuBeKqzA3tmTad4rFehT?=
 =?us-ascii?Q?T/NJMhIH96VEhyKAPlW5QYjt5ki9md+MV4Ki/crar2rRqJ3w5Rm64rpj6PJs?=
 =?us-ascii?Q?Y5tzKm7GMAGYmAgojrPWqEE26V7RJpU/vXP5z/hx+CaSvdvvZVCH1t/ceW1n?=
 =?us-ascii?Q?Whq8K86tVJv2seqTpGyd5VlBnZaISn1/WgEsujIwE7NTAnCAVuaXs0KRpqxq?=
 =?us-ascii?Q?Ye69H/PxOAdmF65bddBWjb9UnXyMGiNDGd+nBzZtuQthXgZVstM8XAGnex3F?=
 =?us-ascii?Q?Ozkaryrd0d0eGS86S7UqNdbO5+qJnE3j0ujOUVSuPwGPOobw58figbeGkOKJ?=
 =?us-ascii?Q?mG2IiBPLE2iu0lLnVLugMQp79KyNRYOdhdEN7wyJnOPkrsN0JMAqoVlif4QW?=
 =?us-ascii?Q?RXKe3BQqox+OiihgYg9WEUmGdb6BYiPpVe4pIsdcTjU1j1HMGLZaLWaukq3v?=
 =?us-ascii?Q?+/yj1Q6MDir72Ttt2FoGJm++frndF2XY/ZbMQQbz6qsU3ULqkdaXnuhPDR7O?=
 =?us-ascii?Q?G3N1J8wX2/d83XKFJ6H2Hk1SyUfWu7lV4zIa15wS+ccYMNOFGG1gMR5eNMo2?=
 =?us-ascii?Q?tItkKRVz28H4cmRIbpC9XygNmV7A9WGOmXcTiO98qzcrllzpeiuslAAHp6NX?=
 =?us-ascii?Q?LjmdasaNta6q5SuWruncVcOQ7NbvzovgO6JlSDTPIWXQ1u0d25+M+uesZF8E?=
 =?us-ascii?Q?oari7vDqekdhnX4Tpku1RfB2q+PsWVPPM8AEfMyZwXc82tpYCKJtzhJ0xkre?=
 =?us-ascii?Q?7ctVwD7r1LzTaya8ST8ItAHagrdCD/aWiVM7Ir52iVWfC5Cv6s7UKGL6yprv?=
 =?us-ascii?Q?Gvtaj2fuBIlw2xiYAd1WjBdTT1XtFtmM93TyY7RsxGhomUvQvCDGD69E/CgC?=
 =?us-ascii?Q?s/7wkmQZHC10RUgXUiIVoajQeUmir/rb05NQdaJJZud+Xfijjn+rT5qfV7MO?=
 =?us-ascii?Q?oJ01uWuJ9bYoNA1WZV0OUxJpG/1jFS7s8wc09TK7zA9RkdCvSwOdFI+23xM1?=
 =?us-ascii?Q?cNrEdBoyBqs8UZQ2f3VGKkUHgz2tKbE1QG/+sx6yb2t3nN3VCzRsE4hBGicZ?=
 =?us-ascii?Q?QmLntKGpFdee5I2FuisPttY13TRTUyPLwOd/RKsyNteCQw9WgPS5BEEgmw+k?=
 =?us-ascii?Q?l2nBMmnJrMGInTUC9iZEAjF/QOpxF/ClkTd4UHrD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c570dd54-629e-4fc1-5738-08dab1de5fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 14:29:47.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMaafUNSMtnF0pWMRPnwmH62uladnDC2PrTB0Tub53AFWHmTCEfUG+BfKWr3jPBu8Zs3VWIq1J/WV62pKWI5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Wednesday, October 19, 2022 6:07 AM
> To: gregkh@linuxfoundation.org; jirislaby@kernel.org; lukas@wunner.de;
> ilpo.jarvinen@linux.intel.com
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-=
imx
> <linux-imx@nxp.com>
> Subject: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going tra=
nsfer
> when global reset
>=20
> lpuart_global_reset() shouldn't break the on-going transmit engin, need t=
o
> recover the on-going data transfer after reset.
>=20
> This can help earlycon here, since commit 60f361722ad2 ("serial:
> fsl_lpuart: Reset prior to registration") moved lpuart_global_reset() bef=
ore
> uart_add_one_port(), earlycon is writing during global reset, as global r=
eset will
> disable the TX and clear the baud rate register, which caused the earlyco=
n
> cannot work any more after reset, needs to restore the baud rate and re-e=
nable
> the transmitter to recover the earlycon write.
>=20
> Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7=
ulp and
> imx8qxp")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. The while loop may never exit as the stat and sfifo are not re-read in=
side the
> loop, fix that.
> ---
>  drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 67fa113f77d4..9a0781395b1f 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port *s=
port)
> {
>  	struct uart_port *port =3D &sport->port;
>  	void __iomem *global_addr;
> +	unsigned long tx_enable, bd;
>  	int ret;
>=20
> -	if (uart_console(port))
> -		return 0;
> -
>  	ret =3D clk_prepare_enable(sport->ipg_clk);
>  	if (ret) {
>  		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n",
> ret); @@ -420,11 +418,29 @@ static int lpuart_global_reset(struct lpuart_=
port
> *sport)
>  	}
>=20
>  	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
> +		/*
> +		 * If the transmitter is used by earlycon, wait transmit engin
> complete
> +		 * and then reset
> +		 */
> +		tx_enable =3D lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
> +		if (tx_enable) {
> +			bd =3D lpuart32_read(&sport->port, UARTBAUD);
> +			while (!(lpuart32_read(port, UARTSTAT) &
> UARTSTAT_TC &&
> +				 lpuart32_read(port, UARTFIFO) &
> UARTFIFO_TXEMPT))
> +				cpu_relax();
> +		}
> +
>  		global_addr =3D port->membase + UART_GLOBAL - IMX_REG_OFF;
>  		writel(UART_GLOBAL_RST, global_addr);
>  		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);

According to the statement in the RM, you don't need to add delay here.
"There is no minimum delay required before clearing the software reset."

>  		writel(0, global_addr);
>  		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);

[...]

Regards,
Shenwei

> +
> +		/* Recover the transmitter for earlycon */
> +		if (tx_enable) {
> +			lpuart32_write(port, bd, UARTBAUD);
> +			lpuart32_write(port, UARTCTRL_TE, UARTCTRL);
> +		}
>  	}
>=20
>  	clk_disable_unprepare(sport->ipg_clk);
> --
> 2.17.1

