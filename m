Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C8694497
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBMLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjBMLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:32:53 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB92134;
        Mon, 13 Feb 2023 03:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk2Gjhgl/5FWtllXLaieKITfupfqX7DUt/DaW1DgUFY9qHkIPcrIKxblhJTdJ/JGhneNqvKFMsWTjbGLR5UEPWCNOb5RU8PG1tVUioDsl48Ucmiw2Y5Qz0aKoO4JrksKjRxeAC2wQ1PpPfJH0YCu8EirUuXwBDPZWngSN94M2ql7oRGX+Bgc/qspaqsMO7kOQImYlWRWs3EOYocOXXDmF5DSHek9Omx7QIQlvZ1GmPTEaZfKWzcMo72B0f307dyClIFEEOHPAs5v6iHLSQCzZvkbKpFPYaJZaYoAWppRmQMrg09LPzW+n/WqxrPXGE+cL+EwCzlYb0ajxZOM4V13Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBtZlxfl85Exc/+dotQEMmZFG/sTffU6y00HbgLYcXQ=;
 b=ZXwEc8pPpd0PsTTV2Dw9VLqycfLqo6sC7NzXxnB2y9eRf45JfdFEsyDrv9V8Lhz9x45/jKE4YoEXy5nJa2+oedF0tfLxH61rwKuM71DIwBzaXqPdur2W1U7+JPqV9Zyr40PS8zBdAH8dSwJhMWE0Xz6hb8t4KO3iO1RCcK0Ea6NZ69SXPgusMMuKCtzB8t8geu+U5AKkE6jI3z0JCz9EfEbfX5DWfKgVGwqOY6NfX8wBDAWMcJ2uSXmInQ6jR6ATczkR/hIza3I+9hjy58P+KAcAbXbdaTNegnq7yhDTSHD+0LDi/3YfMgUfYm7XBkPgZaGsaXYE6oFnnG4HlNNyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBtZlxfl85Exc/+dotQEMmZFG/sTffU6y00HbgLYcXQ=;
 b=bN8+0U36aMDCUEc3dDFn/WmWHseFWab1woe/pXOy22xe/62JmUVnwDjPhyRvUnnp9GarhidigKBdKq85uchLTTYy/TdnNeM2fzXioydIhPko0uXiIUK+qEp3r13wR49/qEBZ3NUHbiPQHb9Eg1dFoGHjLVK0HIHG8OLF3YYwlvglZ2JIouGQVEbZsANgAiZPL8jroQmg1uAC3jEApUyOPNC+b44okQ9ulOXSVcCZCnQdk6v3zhiWTPTBI/nd9/BEf+u0WKga7rmkk511ViKOZ7oGPfvjLglyGnlb7jTIxRlTaMur5YPOe0AkL7znGUY2Z2JgwsfdOsGBzGc2M3XHLA==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PAXPR10MB7951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 11:32:47 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 11:32:47 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/1] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH v5 1/1] tty: n_gsm: add keep alive support
Thread-Index: AQHZP5vElDjPA3ZU/UiymkvRgtEhSK7MvpJg
Date:   Mon, 13 Feb 2023 11:32:47 +0000
Message-ID: <DB9PR10MB5881C08001D7FA76D6E2C06CE0DD9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230213094327.3428-1-daniel.starke@siemens.com>
 <aec7575cd784ae4fe9e9f2c1e08107a9@vanmierlo.com>
In-Reply-To: <aec7575cd784ae4fe9e9f2c1e08107a9@vanmierlo.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-13T11:32:46Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=37e56d3e-88bb-47e9-8286-bf0db241eccb;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PAXPR10MB7951:EE_
x-ms-office365-filtering-correlation-id: c0a7d136-60c2-4ccc-d68f-08db0db60823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAEkyETy/7FkC1jcoqfoRkqWZu74EGdPTRBq0/E70lYVKF6274QFHCbhzocS90O2g9Bi9eeN3Zj9aClkTtdyT9qi5eCrlYURjrsXwwNy8ZdbSnaN1x0usR2pollFl232EaJgiGqtXE3W0arInAWj0jT8Fv1qMaWbXJa5vs8U0UMuUeS/emk8OxV0mBIwSK+cihtb+BfymkqduuSPi0mphv+kD3sK+X7+f1w/ePWwFUY8AWsKXR7pae744Kc/9xUk+09AMWJrzS2buiorxZpNgbsZ4ypQUccqI0H+c9aRvY+IhI7ZAywLYoFvdZy4RGIhruI/xAI8yutuydKlZ9VmjPaFEHGFwznf9KqhWYpzrbOliARvFWVxdavcvpk4yp8HzDsjoiG5iAvp0CTYe4zOz1uQeBYkVF6fat2HADk2H2wd2cA8p4Up+3OhI7yHEqeqlArmVP1JIsb3zIGjjHG987pfSXyZcA1rEDCcmCOHhaZZVNgsN76sFbnOAJCdLcV7WYkd6BjhHSNtdmLDDBnoCBiWz9F/rhTFa0LIoN3Z3vrhTtLuSU7os5G7UHMa1P2UpJ1V1eisI2xzPQzZ9cuajLt82niv69bPRmVdG9ZQVaEg6c2HDBeNBVGjHrMrtdK4c1WtmfnCZ2bIIEg8TzL3JT09wpAE63qotgdpQgfKkngsNCjbEWJ1ishLzsnGKEfBtZsmnaGhCNygcizkY7k/kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199018)(66476007)(66446008)(64756008)(66946007)(66556008)(6916009)(4326008)(76116006)(41300700001)(8676002)(316002)(52536014)(8936002)(54906003)(7696005)(4744005)(55016003)(71200400001)(33656002)(2906002)(5660300002)(186003)(26005)(478600001)(6506007)(82960400001)(9686003)(38070700005)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xQBuJhQTCfBqnRi2Hb/FExv8OxvsEVREgnbnL2hoqYKXaSExMW5ZXudfqp70?=
 =?us-ascii?Q?vLCQWOzEZFjAyOAeKp3bqFKQ+D/ooVakBoTVNv30pVfbBtBY7s+lW14pgE0J?=
 =?us-ascii?Q?ITywAaZ1j+WPSJOhcnQkQFOi5M4csbI2SLb0lzSzC4wkACnPHHL6b2vKXLHq?=
 =?us-ascii?Q?kwcqnKTofttOgs7IR2/E46YBHX0vmF8qSrXnCsw2ChIZ/esatSwyQqYq4jmo?=
 =?us-ascii?Q?E9G6UqjlRGzHcrkxD/r1GIzxaxvMJZNWpFgpBlySRkGieXJuYmv10SYjcTZY?=
 =?us-ascii?Q?x/rokYNYZokWYlwfklzQCDmXVbAWbdeWfM1mzi3rjqfXtp71eXOAoZ8sy5eP?=
 =?us-ascii?Q?S7jxoRz9q7l0nLjiP1uRAxDkZIGkwd8c3KKbtlmdLG3SUV6uPuIhc0FrUUM2?=
 =?us-ascii?Q?JqxGg3txsasgbAl1TQFJlD7Rn0dc0Muar0MVLOodMpuqe2feBjWdKzdAoGnZ?=
 =?us-ascii?Q?n/laM/8iB8V6TZ72bTOi9Ukb0mijTy5C+w37nZM+T7u71Zb9ye1EqMvHTF42?=
 =?us-ascii?Q?9Uwz6Mrngq6QkyUPlA91RffDIomDxX2V1VKqHAeoJuCGo/Fyg9evmfjvw1p/?=
 =?us-ascii?Q?ygyzihIOgRRROvCNTz7+4O5zW76KDNG8V8q6FDC5xT77MeWhmWK2sIihki6j?=
 =?us-ascii?Q?NObXLFkW6k+InYKunxsr9aCXFA2aW0wwjLrWnMJeJGHBAjFAhmQTRlR5+kXT?=
 =?us-ascii?Q?DwNa7V3pYolQnD5YcJz1spuFsB+26Wys6nouGZqH+Hf50AYAWpKQ8zyolsMS?=
 =?us-ascii?Q?bCI1q9/5a38+FXMJZnpFMFM/wxMzJ0eg0bQ7wsMCJSFOQfwgAapl4ozwRvMp?=
 =?us-ascii?Q?tybZpGJb46HEAx1HYJq4oOMtcZ1mk/1hKJA40O7iBqJpnmXcJQKdEOk8kzSP?=
 =?us-ascii?Q?w/xwgTCWzyj7GX4OQXDY+3bbyrsr0VGOGbNLXv7Ue+rO5YXLPscGzlza7Ehl?=
 =?us-ascii?Q?Es2BCfkBOUU+6oC5zbDOHK4GcDe+6jVUWVEynULV/M/pK4srucOU/Ewte5gJ?=
 =?us-ascii?Q?L+g3oS1QkCHAyHu/DBKXWgrRrvrv6/Gg0RYOe4zpDoVP52TuddbZVJMDV1RC?=
 =?us-ascii?Q?L28fjlISQ7XOaMnw1pgLUI4id+h8DJtuMnsw1Zoz+xDedGjShr5il4xcpR/C?=
 =?us-ascii?Q?pDwpKHgmZ9OjY6Wmm6vaA0B4UgQ4qBma6lxfHvzOOcctp1shiza2jXWsBfic?=
 =?us-ascii?Q?CZibnN2TPvqx+bcTWVbrBamH+3dRnIlQNso7uSP2wRL70DhQGq1OLqZ/SEKb?=
 =?us-ascii?Q?vkU5RtaPbzMYWvpYMwhIX7LBrQiCDtgZ6Nh1bCmzZpwkRzaFvhfaj22f20cL?=
 =?us-ascii?Q?qdcmemSRQNeU7jn+uMpDnDAQaemWnUKk6/57HudwcoxcksZ3Hu1Dzv2GZ3+U?=
 =?us-ascii?Q?XZ0bgZaAELGzoJTvJvs9AcnQfiYj4GSn9adRgNwPEJEMsIfmuXt91mTjicZF?=
 =?us-ascii?Q?GhDcGBApzOatlJyIEjan8xq5qn9sQKrzCtE5n9jGl5wlcLW9iq+QBkoEakbG?=
 =?us-ascii?Q?X7lVgVaPQ1lTOiPt64VhNiJEQfaRGxonzwYSk0f2mG/jq+yqmmJZjGU5/Tu9?=
 =?us-ascii?Q?nCpl5U502Q7xLL/+SbGEXDB2yq8fYFaI2WVmhW64Nnq8C3ODT7T4NjxaALk4?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a7d136-60c2-4ccc-d68f-08db0db60823
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 11:32:47.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hWr/LbHNjbjBH7yjl7zIH45NW6cery0t0Qh3uS4xClqjZ7/IaOycFzQxGsrxbo7dBXWsYiETbqXNxi0xGSN1lvaZ9QGqEv4STESyNXeN30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7951
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Daniel Starke <daniel.starke@siemens.com>
> > +	u32 keep_alive;		/* Control channel keep-alive in ms */
> [...]
> > +		if (dlci && !dlci->dead)
> > +			mod_timer(&gsm->ka_timer, jiffies + gsm->keep_alive * HZ / 100);
>=20
> keep-alive is in ms? or in 10ms?

Good found. The comment is wrong. It is in 10ms as also written in the
comment for "keep_alive" within gsmmux.h to be in line with t1 and t2.
I will correct this for v6 of the patch.

Best regards,
Daniel Starke
