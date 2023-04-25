Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE576EE4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjDYPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:25:29 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 08:25:27 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E7A5F5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:25:27 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B83981C0F25
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:18:14 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E13583C0075
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL4V0+UzF3rLKCR4Ql77RK+DvWEfGS+uALVvYq30Ck3sqV7zhtRwscka/A2Cdfa9cU+iXGpR0F7OX0rStuVY8xSwo87DshY9wc0XrIPi/XxHccipPgzpQkftL5TLxHKQEYYQyx3P7Gu8BPX2yEm8mALYpKJ5Sgwfob18pr+enMbJgJEHDqeiL/3R386Lyq+ya5nSpJ9iRHY7PitZh6HAV1lbFt4Lt05oXHavQis7YPRCxLozvAWL6ufTV4Ir0fvzI29OVF92QGptNJwUXxlMlyan/ci+VSW61i7I2f7CU+dZTPLJkbgCImV6H9ds2D4ig2Vztz502JmHRmu1fPv/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCe51NJoR+XlOaGFJAqOeBlB2Mj1h6t8gDnGf537mG0=;
 b=iZaYr0Xc7HMPnn8w4cicbbjtFCUL3KbL/bmTmFi4QpWzVDX0jDdukQjWefTb9XvaV0HZl/Jj7feVg+5T+OO++TnuctyZCTB4k4LkBidxAizOgujUZAaYGB9/4WYVagPgffOJ7N8YRRzp1WPh6omDpQZvSlEONI5JXA772/auTJahJr2qNUFdy5oxLyPyzBzS1OX8pd+PfO3gOLs64755M/0sEUiFKbQ7dwsXcng4JnGV46xFMxYs2RrZ6dvbSjrtVadOEwgQxLz84C3YfRXFoIM3xwBo91qYVVwEgAlwN966lJJ0hl1uYGXAhDAP5pJZ3FkZpnhg1G1gyrrIj1f4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spikefishsolutions.com; dmarc=pass action=none
 header.from=spikefishsolutions.com; dkim=pass
 header.d=spikefishsolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spikefishsolutions.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCe51NJoR+XlOaGFJAqOeBlB2Mj1h6t8gDnGf537mG0=;
 b=REsECBiu3UvpqDsLN+Hl4Gjgv0Xc4MzCfz0IX0Ld0nLh/Dz+brC35FxtDgSRm5IYuQ0q7UhLoVMxoxdom7fQgVDUpdIzZJvJ6BG+F/oI4rSp888JeX3PjHk/ERgsO8sqHsxZNStfGQBKValAqqmVJAZT9to/3ikwMyynLLMqM0rZeCi9LuhKAqh7rxqJq28No/TawMcoGZ2orXdrT2PesaAS1Yu2l4EYNqhJc/1YijwQ+ga5GqGkfF5cyKpBbTFNtQ459k8rVbaLGh1UsNJrIxO2L+sOimD3L0BsSx/2CY7+r3EWGrHdDYRRHqBNLC4ozjByXBtJ4cA1oDEKuUOeGg==
Received: from DM5PR01MB2812.prod.exchangelabs.com (2603:10b6:3:100::16) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 15:18:10 +0000
Received: from DM5PR01MB2812.prod.exchangelabs.com
 ([fe80::7eeb:8ebf:60be:c616]) by DM5PR01MB2812.prod.exchangelabs.com
 ([fe80::7eeb:8ebf:60be:c616%8]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 15:18:10 +0000
From:   John Fleming <john@spikefishsolutions.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How to find information about kernel based open ports?
Thread-Topic: How to find information about kernel based open ports?
Thread-Index: Adl3hdry+T416WCkS92xhONaCJlTcQ==
Date:   Tue, 25 Apr 2023 15:18:10 +0000
Message-ID: <DM5PR01MB2812871BCF7C026223782698AC649@DM5PR01MB2812.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=spikefishsolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR01MB2812:EE_|DM8PR01MB6919:EE_
x-ms-office365-filtering-correlation-id: d85cf6b1-06e3-48df-2b80-08db45a04798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNJBaee8Kw108l+JtiptXXtzMhqrYfxHQ+z07xGBqt5o4q7TykjHHJBRJwam8p3NmdTctQmeqQZ6CjBGarDyZzUq/ZZDFoym/JccnI11jvDMeLCIFb2QxlL0emJO0QnoN5ndzvgEwlcTisQYM33IYkaeM4gJb4lZbOMNr/zIItstpsy3ctQjEVgPX+sa2f1IDv9sFWdX0j6Qrhrs3zREk2FDPLTYOXoPRDwygSAmeIkInaVlkopJAKfRuS3K9ReBHUaVFendMfjGfVXekk9r/VZ8NVd2c2Qvk2AT1FHbILlYKi13kbXAl+tCnz+5EetgdBAj8I7qLuZdP4N4jO8Jw20ZxL3GkMpJUFZQCETx6LZrgrWi1dqrfivyvZ6UNqgzvuLupaDgTBe8EVFixQ7U7EK7geWV07n49i8haakHEE/i5Q7ytkYeZGwui/dXCTZCYAihP33Fu/x5m1iCwIW+sM79X5FHGwv1YpKZDoK+jG2hy9+5FuzEF5DEllglDMhR7p0Rkec4x1e6G2wSbqS2Pkg4UFIqSIZ7mODjxgu8tyl0TE33TyrdziMy43/49Xph4jHERy2K1NpdJoRNp4mpDKRCw834/etQhAEupJ8+3HvJBswrAIFs+HQRcm4nT9pgQqMi+3Uqttebub+CZVHItw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2812.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(376002)(366004)(136003)(396003)(346002)(451199021)(66946007)(83380400001)(76116006)(478600001)(7696005)(71200400001)(9686003)(6506007)(186003)(26005)(2906002)(5660300002)(52536014)(33656002)(122000001)(38100700002)(66446008)(64756008)(66556008)(66476007)(6916009)(8936002)(8676002)(41300700001)(86362001)(316002)(55016003)(38070700005)(37363002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rz4t7DQ0Il7W8m824gW/JaajwemlQ5P8Zck//J5aG22Xd+Bq+vdNzxrkcLrN?=
 =?us-ascii?Q?cw090QpSt6hkPy5Ijf+hWbS+EFLbTVWNv4eqJt2YyToqwbHpj/oOAE7FRG9y?=
 =?us-ascii?Q?LwfZfHUizSEfrVsgC03rdexDQdJfLkx/r7lMFeU13yFFNYI9EyycthVRtFLp?=
 =?us-ascii?Q?4TZ5fp1e23T2PSNhYtO9avi/WtB84wq7W4hNnM/KixAiIq6U72mECPwAdzMY?=
 =?us-ascii?Q?HH5Nm01x45CM6/XKi3FmJleg7jRto2hrDnQ4DCapSu/iROYhZq10FE6+iR8Y?=
 =?us-ascii?Q?gMPyy6PVIbHaIZrEfqsS2JNYd30XznbKnrZgYoIzuGLJ+UQlGphIpmpYXbZl?=
 =?us-ascii?Q?zFAncbnHI51aj8Zi8K7U5HcB06P+vt6I+iCIjduR2k4koyY8uomvLDAiNh7X?=
 =?us-ascii?Q?xeNvDmXsdmULapq17QKgnDzMdbYfVPMvPMXda1dpPhIzo4y5tbpmU7wl9q/y?=
 =?us-ascii?Q?W8FaUWbIg4jEof2OpxTlG6G8p1SEdwWCECcBbjkQjORrdSCvAkonAVFTvDaq?=
 =?us-ascii?Q?uNnRfzAxfmc5jPls9O+4+vLro1BJ/N8mUC51qFk+qxrSPOoiuyYNjbp2yesk?=
 =?us-ascii?Q?LHXvEj6VYY60IOAmuOubkoewPeZYOb3xAxfQzL+RwvYTW4UvT/HenhSrdxZp?=
 =?us-ascii?Q?T7rPoTPJ2EmUZBHSnVS202OjA6qos9qZdRS2XySzLXWjRW168k3EgW8EzU2B?=
 =?us-ascii?Q?mS3/JBkr0ae2I2/FPHAcIoIPRopYmwjfowL1/AfSFxCPqj0grhIjfyuAnZaX?=
 =?us-ascii?Q?vrfjgA2vFT7Y+IBz01pzDFLERFWzQpMXpOzJrsmlkl2ldBcwteIGJZJkZYxy?=
 =?us-ascii?Q?4FCDYzl4cUdXxUMY1Jz7ZZZipEE9yyYQAGswZ477pnYTO8+AP2foBGEKexFm?=
 =?us-ascii?Q?ExLiquZ3QzXArtfetOYKXJcvAOFuKsF6GGnNmiRbXWxPmxdC1WPczNtbbKWz?=
 =?us-ascii?Q?KxxeoPPIrEB6fhiGc+usSw6U5aH2IW+iT71YqWQOlitUOsIErm2LPH9EV4Ci?=
 =?us-ascii?Q?zh3nz4Wtd21i6KtVL9FTgQprmyWIkeoUKzQOHbe7Hh1VXbJDvmpo+YV3JXbg?=
 =?us-ascii?Q?h69lqxiJFxiwkz4o8iiG3O6lAGUyGnyLgpMurUvIjY36roUcQ8H9VTmdAp9I?=
 =?us-ascii?Q?2W+xemMKJq1u/KsGXdpwrK50pYBpgHEeC9hEvtvoUdvvpVIBYYOPSslc/3Jg?=
 =?us-ascii?Q?T9kMwMCVuSEVQmR59uWOrMXQJXomLPGQuXu/LhMbbStGVFNbUdh2utdtr50E?=
 =?us-ascii?Q?kGBpYs14ZJCAS/9OmA+/6+t1LzcsD1AIn4KTTy5nsclEsjPrkSDDv9jcALJ/?=
 =?us-ascii?Q?w9Q9BH1UvpSX5oh7xXoGrNEWc/O2rG/vjE5ZMPYeX+AxvN7EVXepkVglPGPA?=
 =?us-ascii?Q?LpSDubKHx0LYrNXZmKuouSvudV9q0fIhrHNvdiBsSfNoSJ4GVq+2pNp6xRm7?=
 =?us-ascii?Q?t/zJvU1aeTXk9n9qZjaSRhkORQmlnrsIUt8DdcS4y0ybmxfG0TTh1KxwrUs0?=
 =?us-ascii?Q?GyB7S2Z6MtG0F5A9wX936ZKxfR7nb4Dgo2tiJu3aRnHveSV8SBW+vsTunm0j?=
 =?us-ascii?Q?bUTqdZ2/IawnEdEKavMYbL5+BcH7V0M7pnkc8zbz6C2WoKsOLlA+WGs97Duk?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: spikefishsolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2812.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85cf6b1-06e3-48df-2b80-08db45a04798
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 15:18:10.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8612d65d-76e0-4a2e-b2f7-6b410c25808d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VtILIYr1hleKcLntHhexh7inc3SboISfAO+UbjKljeldaxK5DOZy5sUAA05M2pq120nUjn9DgtxA/MRI2/qXch+Liz1aZRyKMeiBtx9cJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919
X-MDID: 1682435893-paUhOrgv5-gL
X-MDID-O: us1;at1;1682435893;paUhOrgv5-gL;<john@spikefishsolutions.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anyway to query to the kernel for open sockets? This is more from =
an administrative point of view. For example NFSD.ko and VXLAN.ko can creat=
e listening sockets (maybe that isn't the correct term). I was going to ask=
 if I can tell which kernel module had a port open, but I guess in theory a=
 module could be built into the kernel so I'm really not sure how to proppe=
rly ask the question.

But basically is their a way to query the kernel for open sockets in the ca=
se of a socket being opening by the kernel and not say a process.

Here is the best I can find using netstat. I see the PID/Program name is "-=
" which tells me it's the kernel (I think), but I don' t know anything beyo=
nd that. If I unload vxlan the listening port goes away, but that is more t=
rial and error.

root@compute01:/proc/net# netstat -nlp | egrep -- '4789|PID'
Proto Recv-Q Send-Q Local Address           Foreign Address         State  =
     PID/Program name
udp        0      0 0.0.0.0:4789            0.0.0.0:*                      =
     -
Proto RefCnt Flags       Type       State         I-Node   PID/Program name=
     Path
root@compute01:/proc/net#

My goal would be have some information about all kernel based listeners, ho=
pefully beyond it's the kernel listening (it's the nfs subsystem, vxlan, wh=
atever else).

Please CC me on all replies as I'm not subscribed.
