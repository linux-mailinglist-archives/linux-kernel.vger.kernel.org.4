Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BF6D8EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDFFpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjDFFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:45:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728671732;
        Wed,  5 Apr 2023 22:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNjF7Rgg/FjMSVmAzHQPJWqBnRj0TszCVSEhjmZw1v8MF9b2cKtQQYfIO9nEFrklMxkWkFzayTlSVd3VtGINVL3kzL4iaFuevlE0uXPu2j5F5ugdPGFpFfI97p1+IxVRLibUZOHbPaEc+iQ6LM262OEF1+HslHd/YjEfl8hfBMRmvLWh+VGXcUQet96djTY+QZGHDTdX4MnEfSwYYCid0ftJaMeQU3rLsCpkG2nRQ6eNXIKNPwqR2/YT3y9IEsdwhcql2l7prBg4yZpJkZVGRjistIzVHni5XhVQTqSKQSxbX42nI/+2fp9SdDgOeFTslGOPcXRu0d3QVM+g+YJC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSlBqL+y4x6Y+inuG5xgaEwzgfgOmedsFY7hgRMX8zk=;
 b=dgQAj4E0CZ+Ybb7I9DmzIgKCm+n33FFb45vDJwM/OJv8COWdGYa1ZfM+cWpZ5xMtTr6g16O4PZZD0GEyMwqxzsERATEKv+ZotmgdIHeZdK5/rrLLfQJWkwoYhMuL1tHmUU4qZehpuduRnF2LIAn8EIma47hKGaZQvAxfhESNwcijwsdyOKByzpp2yxjts7OAv25YZPp5O8LYQQpdWAlHsfqVeeLl56zdw0wUn2gctuU48c/PGtEIo1N7TnNvGEvjycfFBnKWfLZazdFxKFQkKG1ZiPZE4L0pR539eSfRnvPO0DP6yiA4uAalLBLFo3G2KJFbZu9Ek7CIlWLd8qTEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSlBqL+y4x6Y+inuG5xgaEwzgfgOmedsFY7hgRMX8zk=;
 b=TzaCdq6DsFp7ONNlndXuFoyWPzQdjNYZ7o6/3XHWsH8amWQy9dI6B0ny20Kllqq/d3bwFjSSeW8m/k53J5Q6XnpndEzXG3gs5Cbnez+HZNGQPCRH3bvm5hBWTrwc3xlxgbytIQhDd/tTYFtsNHKBgtOhwAmsm3Z3BaeyWCJJlF6q5QtsN1xrLbPg1gXUabYXWUn4Bafh3xWt4NgX9rLlaZDf8yezlutVezTHcvG+qUiQz2Low8JfwWIFQliQYpzqTLxsWOhr0Mf2RwuufSBe1WskUX3TB04ND4HxN0wt5alDrzNmjIxV8ysuNVPU5SotOyeiUUFcIe8u+d8n7N6XxA==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by PAWPR10MB7317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Thu, 6 Apr
 2023 05:45:27 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:45:26 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/9] tty: n_gsm: increase malformed counter for malformed
 control frames
Thread-Topic: [PATCH 6/9] tty: n_gsm: increase malformed counter for malformed
 control frames
Thread-Index: AQHZZ5rsuYpRNh6YqU69B50sabYfHK8dxsNg
Date:   Thu, 6 Apr 2023 05:45:26 +0000
Message-ID: <AS4PR10MB589597931E257D7CACB984BCE0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-6-daniel.starke@siemens.com>
 <90b8e37d-2f53-af8b-535b-3ffad4b43e31@linux.intel.com>
In-Reply-To: <90b8e37d-2f53-af8b-535b-3ffad4b43e31@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:45:25Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2aa07c6c-fd3c-4f58-9556-ac884f0abce7;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|PAWPR10MB7317:EE_
x-ms-office365-filtering-correlation-id: 67f0d64e-9b7f-446f-3ab5-08db36621fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvnU9IOFZXTV6ZIJhf76dYjIn4U6cJRoHeV3z1GynffXZ6Zz2aZgh5LjOP0Yd42K1wgr/3UeXN0n0PLn25E8r4LfXb/nydpNiUsLXKoSS9LAJtxNUDhmLgdpVJ8tBzW+zWPTMJOQGk4UtXqytFd1GesIWLxDXMvS6+0jppFgcLN2AVe/zk54hQo8fctfuxYxa9h3HMGWu+Ss7O/SHZx9UVYboQI5EP7mEwr0mY0fPu/tdmmsa4EEuGbNztdII5o2dd0T9bJSXbEiz5z0RlClTOJ1k6zWDRXWamoLhf4qbwvpdKcIWO+gb0XK9Z3IyhIWjTRmFjmK157uYHIjLns87rAHj1CjTccEIRiw0sgRLT93O/09BRcnpnu9lNuhq4OX0Y+SGd+59tiLZrsMmljiF4/wgDhXhzJGrbLEJx8OnkHqWCAErU5cQ2FBJ9UCYa//aOtsSobXqWqx4yEOPrN6QLTBCoqGm2AeA63mc5gtVbL+JmH8MUSlHd3WpztoJk9tPdulOWnArdz0Pkxe32xo2Kbv/4cD1YmjXSbZKdOq4gBUj4hBxpdinfjuYdzR5VMHaiCc1fxOlaSbKU8HC25CU5zwIdwhQHyXefP6V5yJE/Jj7OWVkVqb1+1JpLkrcL6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(66946007)(8676002)(8936002)(86362001)(186003)(71200400001)(38070700005)(122000001)(26005)(6506007)(9686003)(38100700002)(82960400001)(52536014)(316002)(7696005)(54906003)(478600001)(66446008)(66556008)(33656002)(41300700001)(4326008)(5660300002)(55016003)(64756008)(76116006)(6916009)(4744005)(2906002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8LlhCp6tIAEOHf1UwvjALODauCl4pGxMDcyxVXv7x0L5sRVtrx0wMTi8sp?=
 =?iso-8859-1?Q?Oc3JFTSZXLsCx5cut2vDaPDw+iLNcDaOgZ6SRwL8AP0d67NMzp1DfGX3Ev?=
 =?iso-8859-1?Q?nraKs4EJmkgORqikbAyrSnbwZZjN0SWeRpU9Z0JtFWKucVkqkteeOCSs4c?=
 =?iso-8859-1?Q?CaWS3k0AhLVkO7P2yY+iZ9+Y7nGqqmQx1vtq/TPM0XBtTlRUnpxt9SMOBU?=
 =?iso-8859-1?Q?ky653phWFSssGHE88bBhTuO+oePFFE7gFpUppo6jhb08IuWmEH9d0BhBRH?=
 =?iso-8859-1?Q?gqhKsdE2Sq1aPnG2ewAyKkMWnz8Kmw7LGazWYB73ss4HNqLwLW/dYeJFtT?=
 =?iso-8859-1?Q?/cYjCsjkxR7Irv4ik5cAYDKup8GZPHOl/1HSRnrlsr75Zxsis74tENC/pA?=
 =?iso-8859-1?Q?pgL5aEb2yRB1tdqFCVHeFlIlvrxAGDIP83QYArE/mVjsmGUe00QOAmRWL3?=
 =?iso-8859-1?Q?bNCcixtsDovKKT3dcJ0YE7Xf93ifoY32/FwowrUj478mIJ+nbLD0Wgnmib?=
 =?iso-8859-1?Q?t6i29wciwTRw0gI5wrSwXlk0C0yUve3fF9Ov3+cXqGlexFD1TC2g8VtkXI?=
 =?iso-8859-1?Q?bVH03P8CfbarXDODFsISopj/iupdDMp2ph130Qiv+PFZYA96ymbhHNUbhR?=
 =?iso-8859-1?Q?9PnYo03ubzQgVfG48I0MvBuGS7hkXe1R/LYqGmUlDC2dt1YqbKzg5+fPc0?=
 =?iso-8859-1?Q?Db8m96/qALGizuBec9vCXe6wLvIKRR2sai2RarHONNLp/aFxQ4mSbxroGu?=
 =?iso-8859-1?Q?L+YLRugJPQ+44TdI+rXRk8XkbfgBaLJiwJ5eqbTHod3hRtiHP4yiEYtHK9?=
 =?iso-8859-1?Q?jRnpqAEP2aeuHxEBNd1vnsDVg+GXAeF9WuOG4l4PMXMKg43zGjmKKtuqLs?=
 =?iso-8859-1?Q?0qSwrzjvNtlAnAmPxs0Ackfnv1rC3/Vcnv1ouXWo9uKVQ5OxlsdNXBFJbd?=
 =?iso-8859-1?Q?68cxmAE8VPoCPwsn3zgAaTXKZPYlbH0CCwJ5yzT4oVPXhy+EBolV/WPL1L?=
 =?iso-8859-1?Q?iPC+idlqUxJMdiT+PcFnAq6e+CqQl1j8d6um2MW5aE++fpX7TIt6jnw3kQ?=
 =?iso-8859-1?Q?hCP5d3TmXCJJ7TO/7dGDoNJGKwHjb0WsDNn52kDn7C4593O2oHuo0WG6md?=
 =?iso-8859-1?Q?eP5D463mj1yC2Ti6liokR6PjBhzRDiLNweU/CywMkXLDmZZD0EUJRxc1pH?=
 =?iso-8859-1?Q?woL/d3B0i4Wy67B+quNwpxHs4pE1RVBH+2Oz1BSErspkzUrRQY6/Y6w9ha?=
 =?iso-8859-1?Q?WsD1yw+HNGJeYnLJ2FPTpqYhuwoRAvWP4S23kbbg5KjyFsGY1YcFpVGIeB?=
 =?iso-8859-1?Q?wBixosMg0utrJcsy/1TR/iM3yw+CV/sFNU6iBdNtQcIlDAZAoAIjrcL5KF?=
 =?iso-8859-1?Q?QqPrbpEK8OqpoxCwfUHfaW5COlWNi59ib5y/YPaQlMoCW0p5F8yWoebqQW?=
 =?iso-8859-1?Q?uca7YKSc/Q7yaA1gicKbk7xXHyveB5GVBKOdZSE6KuxtXgeJEmtmKQrhGk?=
 =?iso-8859-1?Q?fPwD6G5KLD6kH6WeatMt7K3JC56eO+HikeWarOaFE+y9jPBgNg737w6MF3?=
 =?iso-8859-1?Q?3hxxjpLyurDhNMfGsfHi7McB/aMfsLgwnOEcSPTqbbB6k4PDFMBqxtyx+c?=
 =?iso-8859-1?Q?SbAGb78JumctIqAtxWR0knnQC1pPTnwpMJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0d64e-9b7f-446f-3ab5-08db36621fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:45:26.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUzke8yHuLS+/ucLrWgfyVEhzsO6Z0AAnCxy8QVf//Natjq/yPpvnIw82KpP1IMMiEcerqk5oKd03QBLwvrTA4R1ApTsSy0aKnzTtfhHVec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7317
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		dlci->gsm->malformed++;
> >  		return;
> > +	}
>=20
> Should this change have a Fixes: tag? Or is ->malformed just an internal=
=20
> variable which is not exposed anywhere (in which case state that in the=20
> changelog)?

Correct, the variable is not yet exposed anywhere. I will add a remark for
this in the changelog.

Best regards,
Daniel Starke
