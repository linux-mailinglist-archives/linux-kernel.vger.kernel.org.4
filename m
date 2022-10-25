Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FB60CAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJYLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJYLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:16:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6B10EA1B;
        Tue, 25 Oct 2022 04:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFrS1hqxJII26pzDm7fidQseKbB1jAvkMXexvMXket/gEeA0yX39w5SDfo48yGbnm+dqlrJlIYpzW7OCM559xhdI18QJ2BLHg/krRovgUg+JgEQH/nyuBa/IiequmnjBRVRW6Cf08NdV3HaIhTg5oA5Mb2frdRIR1QrkPslFwX+i29AVEhEmkDkMTkLCk+1mQzDmf9imLqHqZ17XjQ5JRQ9ST+tn0e3thOb1N8qoRWtnynJEZ5F9TmSzUT6kLKvpH8s3lJN7LwZ9Y8pLE4t5PCphe2EeoWMK/nLHmGS1HqgLPXuZjkirjVUxiaBOQ8r565ev+XQU6gVTrDs1dl1AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxr7xin/t1MYqiU319vA4KAi0h5f8BKzwPg3k2WV9dA=;
 b=USdmSfntxzFOuapb0eLIt0BohB2IEdBSz5f9G2UX8XssRjK4a+tayt2tFDt5mbURmjA0rE4vdlqevuH4ahpZrnVvOgGgtTMzTf9xcyQUhu4dqkimuZC2Lw437+ZzkyUWkT4k6g9epDAI5MDEcUVV3PJ9oOhNVRUiPA6ECZZf3N2htopHRKzsI5Oeziq2E0dWZ2dyCEcoHe+uIHUosz2c5bReAtNVJ49vMi31ZSmp17bX8blNKZ7rQclbAO3GSjctXTnROBgzdcZWMRRL1ZSfp1eika+LZOnCRYu18y4ffoit3DchsJezTn5cUKrtEPCRljz+E5WKg4HwLX0PPpNQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxr7xin/t1MYqiU319vA4KAi0h5f8BKzwPg3k2WV9dA=;
 b=Psc/hcPhUXMFtxuWBDaM8LPMuDyYDouFehl64Bhq3mHXf89b3skRhgeGjac1nF0T9c+46CuEk9bmntm9DmQ53oXyRoM2ByXWwXOsc/GZ4Tjmw+5sdiqvjfrkMlK/KCshx/TEjrlyVXj2uFLkvDUes+rGE3a5wpo8oGM3I+g3w7t0J3b+45RbXCki5cE1eh2N8FhMOVu7xmRmcJsg7pEQv0vEwaV1hZ1xJRZvGvBjjtwEYTzkNICDmltdw1cUvcc5rcdvr7GtiQgi7HCoh7TPfDMpzixe/D3dspjikOS3L75PTTPra25k1kUUmBy1uN6coWo4zNXTkIHbC7bRICamZg==
Received: from GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:58::7)
 by PAXPR10MB5613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 11:16:13 +0000
Received: from GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b8f8:a9de:ae69:21b2]) by GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b8f8:a9de:ae69:21b2%9]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 11:16:13 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Topic: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Index: AQHY6GI/fI/RQHsoj0KTBIsRrsLIca4e9ZyA
Date:   Tue, 25 Oct 2022 11:16:13 +0000
Message-ID: <GV1PR10MB5892040CAC0FED4857BB771AE0319@GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM>
References: <20221024130114.2070-1-daniel.starke@siemens.com>
 <20221024130114.2070-3-daniel.starke@siemens.com>
 <403445fd-fc99-290-2a5d-cd7c18fb715c@linux.intel.com>
In-Reply-To: <403445fd-fc99-290-2a5d-cd7c18fb715c@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-25T11:16:12Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1f1c3cfb-a6ef-4725-b988-4584ba22d20e;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB5892:EE_|PAXPR10MB5613:EE_
x-ms-office365-filtering-correlation-id: 9f4dde39-6e7a-4d19-207f-08dab67a53fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWabRvu4xvgScOlJ+FWJh3eQavgDUjnBpw86cayQlp3aIaAuBVKWO4HjhPOIl8ScN9l/urGtOh76aYzkfJ8UzD2EqsJ8iSks9aHQyqZ9AwsjCs/OgZtD6N7UwI3jkC7JO95goX9Y2wkxS4SMypuoNAkvf70IlbwLq/jX0D4IikbzAszJoyAqI34DMcgsu2hLy4Vy154lA9AWTlAv/erVKGJXPH2qC18wwZYWpBnRh8JIUWbV/gU7KjbvFTjg3QybceXGdRHUBK3T0Cr2c4/XGaBAlTicQH9Y8ITSljL61HFug5x0kqIYLVrow3OA5ruEDJKr/WonE5oGOQVc6fPH706sPasabAQzLqkHzt+RNY5amftqoJ8y1McVWl8srHclwBYo77Zw5f5ocy0oxYnn83N0onVXoS80u3Ax7znfGdPmfizV4YkfI/XwntsXA1y4GEf6G2AyyyhdIvWUV9DPTlOlFktW5Rs8lxDlU4kknjawMop3eoZ5fX4x5qtrrqYRSuWihoF8S6pF0opGSaIlwSA3op1tNvIIdz9bEgr97zFJ19SMKipuP4wUjl+p94UFEDIaXvpzNkMbCjPf8vroM7KfQCiuLqfzHnIg4EMBK1Y59dCaN9+rJRvBWe+2Ri42Pg8aoTk49yJWO019vwwFFuOvzzSLoTv/Iryv3dO4I6ZtM1BYTM/KMXjvsaoIy/nphBaUzykxfDL58ZEPsmqAQlHfn5mAoR0dRDl28WSEzOzpkirgpjCwiH2I9ObCoHEKlG2v/X6neJ9bHKtWP3986A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(54906003)(8936002)(55016003)(478600001)(5660300002)(558084003)(6916009)(33656002)(38070700005)(38100700002)(83380400001)(66476007)(2906002)(122000001)(4326008)(64756008)(71200400001)(66556008)(76116006)(8676002)(41300700001)(66446008)(66946007)(316002)(52536014)(9686003)(186003)(86362001)(26005)(82960400001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CDVJICdOqHN1dhHQNeXM4/3gtO89iehMXWHJKdr+iKRhYtnipF9wpxVnJL?=
 =?iso-8859-1?Q?J/89eXkVuC/lEUIeMEDMqgBW/GQZA2+NkbBJrDuvy9kGEcWWgwbBwByUwk?=
 =?iso-8859-1?Q?Y35x0joJlQgxSjhkeagj1pPxiQsMVNjXhKfkXJcW5m7Cw0UrfOmSYEzVZd?=
 =?iso-8859-1?Q?XXKjc9cvLNOgVR1c87z5oeqLGcwLNNtYeLUNLtVNfYjB1MtcbkyszPq7j0?=
 =?iso-8859-1?Q?9mqwNq7PUUuenTxK2BU4/lGXaYGRZS6OsJC5QXJM0uCppK5Qm2mY0M6TaP?=
 =?iso-8859-1?Q?NNHWm7yyXVchSyslcm/Zw+iRupe6st5+I4QJ4A6KKkqdN/WsIU9JwBjGbj?=
 =?iso-8859-1?Q?8tQ0pY+duueX1ykk56tHDHmErh+9ajpEyuutkUFgQ89UfyAGw5vrEEApjx?=
 =?iso-8859-1?Q?8z00+gE74NQB3J/ZmRsB4jZ6e+zqrOZqCPnZkmNKEJ0LIs0pYKQdmqHvqB?=
 =?iso-8859-1?Q?pCRin+tBl44bv6Be7ERV5LiqWqL3EWnXG2yOHUKc7nXleDbJJYcBROQNOY?=
 =?iso-8859-1?Q?kL5smJiUIQ3sK2y/qjRoBcPK8nzF9vSLoCDa8hz9vX9b0Pyl8G10XbAuWx?=
 =?iso-8859-1?Q?jDeJCwGYBd8v3/sASJW0X4OL0jZm36p0NJemqWayZoBCpx6nrWwlVXnMg/?=
 =?iso-8859-1?Q?X2QKT/uGrepCcVh2h0Rz6cLrCc6X1aIg/ir/E4DkVS2Py6o30dERj+RTd1?=
 =?iso-8859-1?Q?0dswEamzyD18uIU4pCBTuk9wo3ujml1Y58qtS3jd6dMUjzm8rXiK0a9Wxn?=
 =?iso-8859-1?Q?brwdjZ4UmCYshjVL7C9RtkKiCGt/yq8INewipbWvYcMP8VLUuwdMZOGmLZ?=
 =?iso-8859-1?Q?UaqGOPGJN4XZvD9BJviS1yF8IKUCNTlWsru35SgaFA44Hf4mTdJX8Th+qG?=
 =?iso-8859-1?Q?x1II2dzvXfQQBVxJz6fNbnzOO1eDac7ovrqgBqh7gxa8TLpjmOxnYXvTIV?=
 =?iso-8859-1?Q?irOXBmNDk1W1T4Bq46+jtRbyhSx1D2r2nKOVPLhETzfp3NEbPqS5kEiNZ4?=
 =?iso-8859-1?Q?E2Phk+7KAxABY7zNnTzEFUz3Dx1JWdr4lMUJG1eu/RFxOuaIL7L01QCko3?=
 =?iso-8859-1?Q?TxF7UUnCp6Kg3SU2o3bMLYW9Fl416x4QNxm6Ry77IRbBFzgT0hTNepaSaQ?=
 =?iso-8859-1?Q?ZB8FVq44QoSYdPY/BkzE4MvbWt3kCE/unxrHEESOiX93kwI/0s0vD5xhI3?=
 =?iso-8859-1?Q?hCo1sDqRNTlFuzd7fXddH840RlpIOHqhJiWiB6FjhHPQ7CZFf0mkqR4PPr?=
 =?iso-8859-1?Q?WpfQuwNksQj0d9nt+o7XCPWR486saoHRCBBTFl60ykPFqR4+afx7OYok3A?=
 =?iso-8859-1?Q?5CXte7tDMl1RUbcuyEVQYcq8F63fm5Z+WFKD4pjm5sgjtyQ4XFJ3YfDRR+?=
 =?iso-8859-1?Q?ISiFGiSzjvcvfIvCZDxG2wETJC8xWSz5BDvOPuwVBqlXKUd+E3OjLIiCz1?=
 =?iso-8859-1?Q?wb8rRATTU4RScDkAw3vUmLYRTd1l2lsze9zRGQVpTju5o/8xqwZz+qUc2G?=
 =?iso-8859-1?Q?Zm1Q0IQWh1FSVJNq/CQGs6nSH6bhjD/8L54AvAfT5+JrHKCzU2kJ55cJhg?=
 =?iso-8859-1?Q?RsDqzPb83o/Ct6QTqtJERLPyKuvChgwHLiicbr5pwDrCumKdozUgVWnUj1?=
 =?iso-8859-1?Q?uljtmn83bWnX/GA13baxoUaDXObkpj/LnBMq11kq7Uz01TMLXAkRA8+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4dde39-6e7a-4d19-207f-08dab67a53fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 11:16:13.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZuYOtJsYkYLRnzLs3u2DEbyBY+7bcg1UV9SUpSCKpLUclCogAog9IzKhEBkNYOgljCjmrUERtqeBlzZpzdRiQ6j1s02mwpmnhTUL3arG+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	n1 =3D FIELD_GET(PN_N_FIELD_N1, le16_to_cpu(params->n_bits));
>=20
> Should this be using get_unaligned...()?

Is this really necessary if the structure is already __packed? I did not
receive any warning by the compiler.

Best regards,
Daniel Starke
