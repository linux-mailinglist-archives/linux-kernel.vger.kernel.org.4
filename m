Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECE614E97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKAPre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiKAPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:47:31 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DF19022;
        Tue,  1 Nov 2022 08:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6fGKZ17qsuN4cnC2U+TVps5KBKxOtG6Cvw7D1LDlrhwXs7ABpVnkHbI3yPzZvltKGgc97/R2y75F30iT8s1TmlRPGxalLw8R/ALngmQFQQUgRBGo/9gc1mwBRMBKLUJOmJ89TkedBNQtABnPGK33izITkyBcgfTD7cGZHdP8ZuPyf6yit1Hlr9nqFloAt9znmgElaUiXDTR90H6cwZCSio/gaw4bORf7Hck1gIkcwMN2IWNvll14Hi4esTBkbtl/gTmYdxU+y60S71mwc6GpWdjezUbHDK5pm7t5di94D64rPJodUFQD5Wd+I+rVJ5yZP1DV0Tv+QBDRa+03qCNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy1Ys/6UVesHfPEiEKdqfdpllpRpCW0FZR9lwjs1VRo=;
 b=NSx2/4DNgR6CSneajDRnGOa+sYW6iQrwJ92KCrAdepvsPXn28ybWVu+EH+48KcwVPjFlpV3UdGqhWpUs7qjFm02T2Z/w5GlqKdKZQLPmi5dd4Vb9sWHWALKXba4Z/JW14zagDdq8wtWjyExSx74jHsElJN4eQHpKNLr24gUlaFI40XGKD9qInQgfEmxNzW5ZsOWyhjmijm4SUKfcRH2emd/A/ITzyI9OgRYjopD+OamaivsFOW/DyIuXeKd1giOWq5ZCSO7dmsDhC9PpcJR6wUckLBxOLB73yWo58b9vAj2kh7PQ3jv1X41aVqQyFG9Jf/2rsNwiCxAb3unQowUCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy1Ys/6UVesHfPEiEKdqfdpllpRpCW0FZR9lwjs1VRo=;
 b=he+RuhSf8oj0swr6yX4QVfRgG9GHvnLDiFhQhE8cXS6IdPlDHnp2IYYvzR7MtAQol1ZtSQr8xVVXExJthY8PdjaqiVGCmjxRVCl/1LsNJWFATJtk+t6KWQK5WpynzogKyR1nWq9H7Z0+aY9BpGY0fsQn11jw5pmUVRNFnYNjYUU=
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by VI1PR09MB4431.eurprd09.prod.outlook.com (2603:10a6:800:15f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 15:47:26 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::f753:b38a:74:5b87]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::f753:b38a:74:5b87%4]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:47:25 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Bo Liu <liubo03@inspur.com>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "dario.binacchi@amarulasolutions.com" 
        <dario.binacchi@amarulasolutions.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: edt-ft5x06 - replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Thread-Topic: [PATCH] Input: edt-ft5x06 - replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Thread-Index: AQHY7coQC9zJB9+CUkaELN80gM46ga4qNuWA
Date:   Tue, 1 Nov 2022 15:47:25 +0000
Message-ID: <A805401B-39FB-4575-8C2B-CC7343199869@kococonnector.com>
References: <20221101081458.8119-1-liubo03@inspur.com>
In-Reply-To: <20221101081458.8119-1-liubo03@inspur.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4884:EE_|VI1PR09MB4431:EE_
x-ms-office365-filtering-correlation-id: 1affe05d-dd96-48cd-e3d9-08dabc205fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ksw9rY33kouqY+2EIyZcfpDHRsGAnhw8gXLbeEaiHjFiCQ8mGt3S2Iil8SjiYQb34ahczB0kMhO7ShFRmSxkrGR94x3mrdl0IL7JIvTfo5PrpWtHpRhCopc8ObYf0Iuefk2P7HIeBkJnwDO1+pUdlnB5q6BB5+VOUjQuNZCxqqjZa16LhBqIZSS5/ypJU3zcJa5uAvZH6p0hKklNa3dca9ch8U6wLeyUtD4g7VLnquYiRX+rP23LXjA1cs97aMkNpDLJZM0hAY+wCBFJHF3utu7OO2PTlKREtjxn9fZDNvCEFrzdGIySEUHnQXsK/fFi6LlKYeK2OsjgWBG+zdRgUR9K6qGkv6t/xoMWsyzBStvE3gI18Jo5/Dk1KiVpn5kWJ6gASoRYl+/2zSPqHZWEG0E/UDVSIWuw9uWfB9GwS4h/11v6ASU5caFe6L96Iqoj8VouW3txPfDTleAHZQF+qWXmbZ0pK9VmRYZP+YdzxU8TSHCO40mJ3lWF1VK5AdU3HaijhB5cNLEJCQjK51ROT/sYLy+9YNHOkRajTgRVt7PJIbQmBa5mwv+CRe8yWjXq5l3qr5tSAtdxU8ejsnsr3VpF2asOH9/jmHtIVNehTeNZBgTunJwSIG7GZKYWZyYTL+2OW1oY39ECVUe6gcHImCchRSyTQM/eLzjB1SjnFGweIMZFVdXUjwBpTr+I0Tk38oKon/K+4VZiSEMKdQWZIXVJ7qERnaPvJ6McdZRQxM1sdJAf08j/hetG5GxbriSqskIUOZ77MkgwmSGAYzMh5eWYd2DpUHA/HNipDUjgG2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39830400003)(346002)(136003)(451199015)(186003)(6506007)(26005)(36756003)(6512007)(2616005)(71200400001)(478600001)(2906002)(6486002)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(33656002)(316002)(41300700001)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(4326008)(6916009)(8676002)(54906003)(8936002)(44832011)(5660300002)(91956017)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DtKpty5sVj5SI+vUhQkhv+cGbTQCngQhVMOnnHwvuUhDP2QqVbYiGR+0L/IB?=
 =?us-ascii?Q?w2PUQUPLD1r1Dx4+NhSNFznwdQwSUk6bJXeyhe9+GhC2DqMAEgWF3t+cuQSs?=
 =?us-ascii?Q?qUDmp9wiNihcfGV6NKEDRr/GJ/GWtN9YpiEOcYcrv8cPfX6jKZRQkASbNdgo?=
 =?us-ascii?Q?U3ZZecU+C3vUyvZCC6SXDNyvSk35+P+f1t/1RZCH0A+3B5ZXZbaR4owWPm6M?=
 =?us-ascii?Q?jFFQ2F5BJN5b/VH8oByl5tJgNCDpm9ArequYf7TiFcuw5bXVSLg1BWIQ8KiI?=
 =?us-ascii?Q?e/+x6vdrNZfnA/OmujAIj+1vdSsagjyK6VdcKHzifSd7YdmftIEoiCAgaqPm?=
 =?us-ascii?Q?wNrpNCactt0AQI7U9YynjJhWn4KiAKGmf9dst1j9Om69G/BzdZZSuMfwnsMv?=
 =?us-ascii?Q?Ht4KhTV8b6o/aweclp6vs3SedSIIa4xlxgjwuTo7qoyUYrQDjW3efF/QZccG?=
 =?us-ascii?Q?P6RMl2zISiMjOWlZIIgoi0SxV8mc9oR//4W0uyouFaM43Esf/cYtaRpdOWB6?=
 =?us-ascii?Q?pZRWCp+mU8JKVCkszz9MoDTC9MDLwRQs9Py2lbS+d95lnZfzNzrH4pza2JKf?=
 =?us-ascii?Q?QobM3Ymy3LBFrZzj8Lwt+MmLWP3EzzMgKru2l96WHmaSEwWwm2kTsMx4O96B?=
 =?us-ascii?Q?nBVaOre7uf8TLvlYZtzZwlHV7Zw199xvw6bLnsVuXyndV2kubLx3V5geHmEj?=
 =?us-ascii?Q?DymQxfnDvqgbFNPXPj9O73RxnHU1grTKujawTMnpuxdLIahYOV7GbLMIiMrA?=
 =?us-ascii?Q?rdeZviehIFPtqNw5Aqx5lbPk3lXZgmR4JY43uQgQN+Q7epQwJo6IE5nZKP6v?=
 =?us-ascii?Q?2Q/WW9osbNDFUMuPL9zpyUxfA3fo6iFB4FswtRjGFfOtkc6cFN/ekHMelSDV?=
 =?us-ascii?Q?HzU94llrTt+M/A+WZuVTlm1MI1ZpTMekHCLw8il+AMfRXNh+OGkSqS2oJ4GL?=
 =?us-ascii?Q?Kh6mEqunecyMN4SU64svDxDDYnx4oHl1strhFDbQNigjDqgqs6Mp31YTunaJ?=
 =?us-ascii?Q?QDnkST1aXD98jAW0PTSppMPwCb/R2u8fatTGMXujMxwJrcpktUzjgXcaNk4p?=
 =?us-ascii?Q?hhi2L1911FRBSvtW7KTRj32aUfg+wO1U1qudOHDRUkId3x4is6g6XTJH7Qk7?=
 =?us-ascii?Q?DLOD1qk4EYiN1NACh43OMOAunuGq1wcLKr1GqJXfY+d1gr0Tj8AI+lUeE5s9?=
 =?us-ascii?Q?D8f//F/Jx1V5fyPSA8SHrbpxiaqR7JDbmvdPuWboTyZ7nP7jOtEc1iGNClEW?=
 =?us-ascii?Q?sJEYwliiPiFbjVDCKA+I/NoykF7Fe7NsYgnhIavZkiynuagwXqVU4UHgNMu4?=
 =?us-ascii?Q?O0hAPLKjdj1/pAHkNztbzV3pYjyNA8DkNJ1TGGdYR+U0FGINrzoZjyJs2PKv?=
 =?us-ascii?Q?xzK9LNbORwy+Xlu3ayqnU4WIEusi5wClCvupBjAOBrdhudoj6maBYZgzN862?=
 =?us-ascii?Q?LytAGv8L2nBusi3i5VofRWwY5ha/73fqnBeHUNS8G4bC42YsNxMhalpOBz/8?=
 =?us-ascii?Q?KR/nc4AsV9EdPxgpD6Nz1ugIJoL2azt0tkV4Va0/dwuUAeRQlKPXS/BJQMXB?=
 =?us-ascii?Q?QFPpqGfOlkosvoarng/dfK+7Yy8uPRP33B80u7Sna1jRfqzbbR1aEN+ordVp?=
 =?us-ascii?Q?cI30lSqoxaohQmaYMbXDCDI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35133F2372318342B49978F052B74290@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1affe05d-dd96-48cd-e3d9-08dabc205fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:47:25.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXrxKeP6jfWEb63BcmnYSCuHA3Mt4SJnxISbKq/x5yl9O3tZoXltixunpmSLbyCRnsmAdkohsL5VaKYVHwsxsBbhBKOjXnr6I89YGTiiH7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4431
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 01.11.2022 um 09:14 schrieb Bo Liu <liubo03@inspur.com>:
>=20
> Fix the following coccicheck warning:
>  drivers/input/touchscreen/edt-ft5x06.c:756:0-23: WARNING:
>    debugfs_mode_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Oliver Graute <oliver.graute@kococonnector.com>

> ---
> drivers/input/touchscreen/edt-ft5x06.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index 9ac1378610bc..a184425b6985 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -753,7 +753,7 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u6=
4 mode)
> 	return retval;
> };
>=20
> -DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
> +DEFINE_DEBUGFS_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
> 			edt_ft5x06_debugfs_mode_set, "%llu\n");
>=20
> static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
> --=20
> 2.27.0
>=20

