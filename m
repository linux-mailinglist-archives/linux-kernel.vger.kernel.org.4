Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3256D8EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjDFFR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:17:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3D8A66;
        Wed,  5 Apr 2023 22:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuQfL2l36RFo1Gq0isbLWsjATbAenalVqSP/EACE6AltDmfwQG7Dwrcs22OiCuJeXaVfpRx/w0uKjkb5LIv8mysKb8F5+uvz4WkYR6xjBexWus9SJnatMteJ1zt+P2n2EslKuHOzCeNdNzubEg9dBCwni4Vku7O2sSIYoug2dNlm9MioZ1mz+RPQ/4pV5jV2Ogj/dyavMwaLeUYQBTQCTst/LZHUKICzZYjtEjDZYq2YsOj0FhTkOIOI4dPwE6WHvao9Wp0XUDXlvAofWe2c5C0H02bcx0MU2DzXMrgbM5T+f0gpJMZhDyIqSFCgI3Ato/76js/s5Ah+oum+iYd66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxYHOjdQtLE+b9TeWYy0elsfDosH096qMf2JKON2x8E=;
 b=GXzcbMdcBKXlsdVtcqeXZq6Zi1OQAEixgGnmWszraayFpc7FiAhXmgmjfm0BsKsClOPhIlCfvczoqxpLLRi/71l3YxiDr/QLXJk11zy5hTYJUIZe1rmp6G7e8lLXlxLrtJ6D6xGrqy3S/PLjR17M/q9PtOOkPrvm5HzSWmgJ9Encq/Ce2KwPDHrompoYHMG8Xi3tF+nm8rkUoP9LGwmINm9Iiyo9JkrhUyEc//rmd2rzL4VvtENVwF7+wLrSBmu71/44JIMtcZ9StIv4kLxQQ56agsX84pMDOmFq0y0Tsr+MDBXHOqJW0oV6rDCetUi3FGjnSYdi3MzpxMHpgXbxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxYHOjdQtLE+b9TeWYy0elsfDosH096qMf2JKON2x8E=;
 b=qEdyolnYV6BUFMUHzG04R/N+uoxl2/zSlxZp53GiRsgxY5r2ADF8S/XrGDGMjZauabCI/1Z/70sGI/dQyrRN0au4jt8ntWjZVhZ6IvigyLLrQ8ZRmYW5CAUMD9K2v3broLicT67qdI8qsvwk0dCsKTNGuhGJPJfsiIb/dlx/km+NUWuUwb4q8SIXLhwxhUkLgNkB3NgkCWHZ1qiLDAPFW3AxcsWFO83qz1yKTIVTLDBRu60SltRZ/9Pm/NajfP2z/Ya1DoF0lRsgGP8SSOm2hrTDzGmCDSweMOEubryrsyOiY+DX5bGDAB1kCuVnJExRFG8zTXjv53R9BZ8OsWu3iw==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by AM7PR10MB3592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 05:17:50 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:17:47 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/9] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Thread-Topic: [PATCH 2/9] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Thread-Index: AQHZZ5bbwe8nLRzr8Eyt66RoZhL9na8dvxFg
Date:   Thu, 6 Apr 2023 05:17:47 +0000
Message-ID: <AS4PR10MB5895BA5B2ECFFF74DDBAB571E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-2-daniel.starke@siemens.com>
 <cd7c33c8-2634-382d-cf62-3785e391af2@linux.intel.com>
In-Reply-To: <cd7c33c8-2634-382d-cf62-3785e391af2@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:17:46Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4c241105-fd99-4e42-a3e6-9d6f692c5f7e;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|AM7PR10MB3592:EE_
x-ms-office365-filtering-correlation-id: 3d827d75-f695-4fc1-645b-08db365e42a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHXZuxGW3fwrGaKgET+heEaKxgI+Mj1kSGiOwdDKEJ+n6Zc52ALW6tDEkg9jXUwjOwhnciUR/3708zz22j8Mmbas2bXS4HSVZ6vlRTroqrTL9ZoP42v2G0uZRFvb6eqllocQLMD9gYPCTAymv9Y+UAbu4JJVeNe2Wp18qbbV1S1fqAWcABNYgE3bhsAKbNmti2anAqLtUV0Ix2IkH2I72yhztznvOg4AVCrWgBexpEC5QoH1d+5qeQNVoOxrZDSkktgb2y+HXqCsRfk/U5xzVpWO6N4kYGKg263wWyfCczdukR584xjK1Esv4010b8cujFH+G4oGDX+qBg/95dhGkCpUEz0MFDZXTHReu1a7scPo31+9yjU83ApFp8/Zdge6JAQIqthibhv+n4BRmuAOsBDT6W1SZ81gJHq+1yAMikZ+TV58yQhgRFEzg3zf0+tqc8kfAFCeTHy1Q4zdEvxtkYc0q1Izwq+WcKH/tCqWClj3GT0JgJp0Hjci5siFXVNHTGe70ZcCmBzFTBpLFgmnoSV1ALjvlaRAqCgrO683gDNZPAPhT1QhrW8RShqLDu+Pf7bTtE0ManavLvp2125oDHmBV8mth1iYv9oECBIE+F3FBVVxu2rNVmkZ7WFYcz/sdUgL4Qd6BOaR7EoCEVhQYhSfhgOoVXRFj75qfuZRNPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(26005)(33656002)(9686003)(6506007)(52536014)(5660300002)(2906002)(4744005)(186003)(8676002)(8936002)(55016003)(71200400001)(82960400001)(478600001)(7696005)(122000001)(41300700001)(83380400001)(66946007)(6916009)(66556008)(66446008)(76116006)(316002)(66476007)(64756008)(4326008)(38070700005)(54906003)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qYJ84Gqz/oh8VyKvofMm0Vv5c6XmzUkBejtD80xHOp2J9GEl13Kyfy5u7y?=
 =?iso-8859-1?Q?mTyIV6s2YvS1wXRoMzlwqySJKdjvNy9hDv/22r6uLmM7FRvNIunO/AmUet?=
 =?iso-8859-1?Q?Byc4/ul8A6FToFQt221/Uy7krm6YnvXlpYJ70qtRsLHNG0z4/Del/1LRO3?=
 =?iso-8859-1?Q?9kDcVdOga1At8d0tctr9GsvxytxIKrZb7sK2S5Kp/B3gTdcCEyXLHZcSdQ?=
 =?iso-8859-1?Q?U1B+Dx1TOVWiUXoqZykYwb/9FU+DkM/Ic/jy0cxMCcYIT9KwH7PxHnlLVI?=
 =?iso-8859-1?Q?chcQ4qb/KxuIJkf9QaTx0aKwGWwBFd1oom7XpaznhfETB+cBPKCJAR1S5z?=
 =?iso-8859-1?Q?Sqgksf1bS1gnPcXFcmPmJXeWXoRFOWkdqfF1wcGTN2Ie9J9rSkx+zjSi+7?=
 =?iso-8859-1?Q?n8TGghRAv3nTxFFZb14LRWkiBRXiEP2U+2NU+x61J64YobWuKvP5SxTayl?=
 =?iso-8859-1?Q?JsMeCH4zzB052zXKT2Y3tJOTKeXERVbekN7W4o0wsOH2T9y1hoRYZ/5T1N?=
 =?iso-8859-1?Q?X24SnRZW6mqq1CmC8fjyRBZ67TU2f7ayGKJRatvCWNPqyv3YH8wSvWWBwQ?=
 =?iso-8859-1?Q?HkjqERyzWtzs9iiCXnkSB+BOzkWPp44ddHfrKIrHwo5SNi9nn9LBI5Gq8n?=
 =?iso-8859-1?Q?LiiQF6p6hABM/otmM/lbWuwRmk8lxas+BxvQgN19aacVsLXLDO8xJ+HfVU?=
 =?iso-8859-1?Q?rC3zxd+XVGorjx0H93jHQopqfo9ZVdtk3s2vxDsj6cx6OwJU8t5yyRrW+u?=
 =?iso-8859-1?Q?nUot8FavOAglaI6Vtd0NdDssxKUlVQnoPUCfcRIpNl3e2TConIkKSohoxN?=
 =?iso-8859-1?Q?VO1BIN3ymdAkNyakKMJyAhaVmbU+2Ieka9CnqLLTfJtk6bSfCDdtN9mb96?=
 =?iso-8859-1?Q?SmKjbu25nHqxXKAyIzHG10/v5HZeLec29R4jqKDySwoko4983FWsoYZIUu?=
 =?iso-8859-1?Q?J7aEypBgPT0f8nq9o8FzK8+pLGGyP3DiwOSX6XQLSOnALw3JwEPO1y+Zw9?=
 =?iso-8859-1?Q?3M5Ix/b8oYzQU3J2+Qkk1BPY4m2El9Ry+KuiGWsali5gPB9bFdg4jGNQFr?=
 =?iso-8859-1?Q?gZFaGX22MRnjEuTpFZnHETV659dCvLyp765SH7CVT1B4qwRrWcp23J9LiU?=
 =?iso-8859-1?Q?Bbhb+mAdZj5DXQdtVq0ge7Jc9Z8OXtSdQ6umkTR+m2lcNGc2ahlqPN2e4x?=
 =?iso-8859-1?Q?zYxN1gAo2diGnRarKhBKAaJrwT0Oca0AOYN9nwPhfXRH7JdVoi5q+F+cQL?=
 =?iso-8859-1?Q?SkcM1yN8LzREWUHR/4JTD5fOqZjSvPlGYyeeMEK9+BJ8p2gspVRpQb9CKq?=
 =?iso-8859-1?Q?ilpjMXbELrDmGx8wGhgS7aOrOdWccHemVWkRci0ps9nyY910v55YprwiQ9?=
 =?iso-8859-1?Q?HtTNMS8DP4+smcVNdH0qE4QRQN9tTKb3bdHMJkfc/TKAlEcJvjx8VrWLH2?=
 =?iso-8859-1?Q?j0DmpBs6r750lBTi2WaBtNP6FkJlmF21Cs8ytDKiHr5nyYLR6lpV77uoJI?=
 =?iso-8859-1?Q?FVgQmsOQ4IurHN0l7kUwH9E9P3aT82Zl6nAsK3qq6lLuMrOwANbhf1lykT?=
 =?iso-8859-1?Q?y9ubQsJ6RYIx2COri4wg0UCIslhcFVU7SZgepbBQPQoTmC/o34nQVWrbWo?=
 =?iso-8859-1?Q?jQe9bOM9oc0/JdLqOAdvnoFqTaTkMuIJv9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d827d75-f695-4fc1-645b-08db365e42a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:17:47.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2a/bY+/4lZXcvfNYpwob3Hx4vzOd40SK16c82jP0NNPjdTXSfDahNS2zWAcbCvcVy/WL4Z2e3hW94/txrFYkKU4zjWYdVIjSxI7BdPiycp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3592
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Daniel Starke <daniel.starke@siemens.com>
> >=20
> > 'gsm_config_ext' already allows to force a link reset via 'restart'
> > parameter.
>=20
> Please be more precise, there a function and struct with this name.
>=20
> HOWEVER, there is no such parameter in tty-next (am I looking from wrong=
=20
> repo??):
>=20
> static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
>=20
> ...nor here:
>=20
> struct gsm_config_ext {
>         __u32 keep_alive;       /* Control channel keep-alive in 1/100th =
of a
>                                  * second (0 to disable)
>                                  */
>         __u32 wait_config;      /* Wait for DLCI config before opening vi=
rtual link? */
>         __u32 reserved[6];      /* For future use, must be initialized to=
 zero */
> };
>=20
> ???

You are right. Looks like I was looking at the wrong branch. I will reword
the commit message and deliver the patch for 'struct gsm_config_ext'
afterwards.

Best regards,
Daniel Starke
