Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA365F36F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJCUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJCUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:22:05 -0400
X-Greylist: delayed 4583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 13:22:03 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C010FC7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 13:22:03 -0700 (PDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293IhmC3005836;
        Mon, 3 Oct 2022 19:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=HIzMwsTKhKJF/xz0bPhfuOUwZ300Pw7TZ9CeOwA0aAA=;
 b=A03LO37TPQP+CuvARh2KNOID13ebJmg9aYmXS5hmHFOQXVj3LfgR5enLR8PW7LKP2pvN
 IqH3nhnJ2R0FH2hWO9sP+sWYNJh66jVNlIiIjLjjNZI7pzY0K1TS1hgSAQBgRuZ3Mozg
 8zeC3uF+X72JhGKQpnY6CSJlpqUiGkthXXWKNTziTTY9RG/4Eqp/VkMShmtjCKv10roi
 I4gniBakpN6ODi63Sx6T9e0uF9v4qmwQnOKY2e6HOiSFFRWLakiyXimwqWkYBQpD2M83
 VKbjOvmhxzbKYfuzm+I3PTQJYFK0zbkoIJyH/KysA370kWOwC8u9j7yTtouhIkHqljEi PQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3jxc46t5yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 19:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeXDv0nXRXTaV7RiiqXZIO3K4NbxRcAF+gk5GHYQTRzM6mZ9MRaU7kiRyjmx7Q074v4m1+yWwU5RpaLt2LomDwBC3xMQuj+8ZHp69sbthNG6gq2Ut00vuQki4nYbUra4IrTLZ1BdSmrp0SozVV5pTk/DL9YeVyiH2NI/vaIFr2GmKkUuy549ZpUhqyGdvqOWh5t2IFwRh4X6FmEzvPvnkMZrHxUF+dpWT4Artv4fDQFAalNfjZXTz4YzjIImH7uPUAiNu9fOxbBVJEHU9uQCwBLtNIxbhx73kwTiqAsbqH64nGH2KwIME1NIyXrLGtFdwZEQdFE7FHDgoq5WQxGSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIzMwsTKhKJF/xz0bPhfuOUwZ300Pw7TZ9CeOwA0aAA=;
 b=Zt1cb9WYNR7Vu9Gcq0ceTEXHu1HSpgM4XYtExIsaBuB4nUHT6rxYWW7jiBDGY+n1ORGq9JdTX2pRKiFVnJedpeRno+rDIisKRag5CanUaHOBYzWH7GvAVP5E56vJrqKZWqzZci71v5C8AYa0eLpH80uvfRcr3L9P/gzFvZcgtHW5tW45ODJaSGt8oGrzI4CRdcWmrbzw7NXPL5TP+D589H2pfG7X2790HBDf6/UV5W5dWM2z8wcj4YNyM/yLobZoXLqc6D8nci4VA5oWmehUjG0HJ2ZIINGp8Ru6jwO57hnXalw12oOxq/gLiefFQpkZ6rWY1Ab+fAHysHSLUduh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by PH0PR13MB5520.namprd13.prod.outlook.com (2603:10b6:510:12b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 19:05:18 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f%2]) with mapi id 15.20.5676.015; Mon, 3 Oct 2022
 19:05:18 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "verdun@hpe.com" <verdun@hpe.com>,
        "nick.hawkins@hpe.com" <nick.hawkins@hpe.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-gxp: fix typo in SPDX identifier line
Thread-Topic: [PATCH] spi: spi-gxp: fix typo in SPDX identifier line
Thread-Index: AdjXWuP1XgsEiMJpTNKrqObPeZjk6w==
Date:   Mon, 3 Oct 2022 19:05:18 +0000
Message-ID: <BYAPR13MB2503FF6412666D29FEAC8DCDFD5B9@BYAPR13MB2503.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|PH0PR13MB5520:EE_
x-ms-office365-filtering-correlation-id: e3b36146-5fc8-410f-229b-08daa572363f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Otzotq1n4C2SHDj/AftY08D6C/wLsrmArV8OhRNm1nL0RFclf7dgGh5uoFKWMSDD9+fjbNYbcH4qi9WZw9ZNGPDK4QEgVHOXqUh358AjxfB39ZpNccRQpYHYeWXT805yjdPOQzX6QzMxL++SyeGir6LYVJtaRS4RL0Wwqz02WH3s6Z3eq06DG4PflPPTijJof8m7I62/a0NsNaINKFDeaGMW1Uxzn6wr/3jfuWh9Re3yPsiXAy6/VcrqV8u5OghvHUxYtYzKs6QEzEfEfaIn5bRErDHg2XRTEs7pdwu3l1F903OM4N6LNczttEAupthrxMqjvAuiVlgdfD/UGqw4kcM5seyQ6sfuYcwQSZBeo8tlsXrIdNtQoU9mL83g3qoOQaOfNA/WLUl5rWOfks54i4i2qWGzpKwQd3KehaabHg1n3O2cWucS7A4dIvKNTexADpAqo0OyY/BV6Vbfdkc9jm7efem1/9IPT3l7H8TNRFBmJ/f6Jp94uo7TsXqBoIr2TiFhE+PKniz/hID3d69ce20EcCeasUsfJwtxpF8AE5mcQv8PZvDJn2fspVbIYXi0TjzGpnQ0AUuYIKgJz39ERWek1zouLrtY4exoTceN8J8yPxv7yr+fb/q8fvG9ZWfal6PrdbQ8FJ0qn9+NtxdglNSq/D98z4wONs34qg7tB4ztPRLDPeOvq+qHkeoSZaiFaLHJtHJkBUufL3m9rct99jEBfPM6jEDvsyfKWtxdoAMcnTRbNlM6UIOYjoBP4XnyPuBl+gnYZ5HvV+egIziwDXQV2MCKj5aytmyexJNGz4jbyh5sbl1dUGPeFtY1NfX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199015)(38100700002)(86362001)(82960400001)(41300700001)(83380400001)(2906002)(9686003)(26005)(316002)(110136005)(54906003)(296002)(7696005)(38070700005)(6506007)(55016003)(33656002)(186003)(66556008)(66446008)(64756008)(8676002)(4326008)(76116006)(66946007)(66476007)(5660300002)(71200400001)(4744005)(478600001)(8936002)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BOZPPgqGcYMgyC5kaKPhHuGQpEkM75RtLsSmG89xPAEhFCyx5JVM4Jy93/T4?=
 =?us-ascii?Q?SumbSmRPSWDafx+XTyn038Vu8D0xSxuJEJJaWCWu23OTW1zYfWbNfTpACtuZ?=
 =?us-ascii?Q?sq72nUA1ipiyvC1ruSxqWWyO3BKvfTuePeT4J0bsj/6FsiLnf37YtWH6RLbF?=
 =?us-ascii?Q?9A9/AxO5a2tl77BAqXqNwc4UjKexxZ+OOlluIBrAnp3BvVaXdqeez8miID22?=
 =?us-ascii?Q?efzerFvDBM8VhFNhyqyzb9aAJXtiXbFf5tt3XktnYWebPvu7Df9gUXvrXuTV?=
 =?us-ascii?Q?vh436kArdip/JJxneQq9bvyVNVutbAqwnHpxuWG6A4eToLh3boGv4jM+cLqF?=
 =?us-ascii?Q?aDRxOoICu1L3vKsM9U8PREaRjvb97JhLrJVRNWFv2Rt4/9Co/89pz6Br1Bxu?=
 =?us-ascii?Q?wQsOmSWHLtMe8eu7c0RDjm2zqyZ1qOE9vaZCtBsyKSx+SdmChEL45FXnVYtF?=
 =?us-ascii?Q?6poZ6TNxAI3i6wh6MjcAAJxQEiAWXFENisvpimjsYNDbq4KRrwEQkchgeGWV?=
 =?us-ascii?Q?n0wffeDZq8c2u/qDCnIvM4DQikP9MQH1crtjEecBeQoAZqMPv7GaUYZcvtY1?=
 =?us-ascii?Q?UtLT1v/Q35MaOBZuVkeIHqAim16x6CiAw2oXd8H/8C6vhSbDMzwNt00Rhiwf?=
 =?us-ascii?Q?9oJcg4oNCH4gjCqSWbNRWKBXkOrA3GzVyOzxmp5U53Qyy0JK4v3RNIDdwNMb?=
 =?us-ascii?Q?DbnlWVotx4zvmgmQ8+bcQO6pneLBEd2KBP9BntnJ10fv0nc63qPSgp52OhKj?=
 =?us-ascii?Q?eRq8ij/sByTnoJPD1x23kM8A0VW6sIxblsNO9ReRp/i+8pks/wfEWXLUCkax?=
 =?us-ascii?Q?y3tEdaei4uoNGcB7m0S22oi/nb7O1Jjx6zEJOJY0wwCLAwk7ZYrHM8HloKNv?=
 =?us-ascii?Q?2LYKcr1vKi1+9s4/+soY4LhE2dwNx5qmFBuK6TEWxoYpAJA8G4/fKUm0madf?=
 =?us-ascii?Q?YIqA+p8hGg20FdtWGdibXmpm2SAiXU+Mzik1Ohwa77xUsrk+++/wxLtTmH2E?=
 =?us-ascii?Q?uaWxuQzNJTjoD+e3z0ptT8LQx01kYjdlrdSNQSLNC8RzFT+397rQPqaflMS7?=
 =?us-ascii?Q?udyjN+ve/q9NOZGBCloKGjohA6Q8H/NDmNTow5VElTbIZwio0FJ5Y4C/Q7rc?=
 =?us-ascii?Q?qidwR/xQBO4Dk9rglvdehVbM8UZyanhPEMQrnIpq+vW1uh21odGnLDgJcaZ3?=
 =?us-ascii?Q?uKJwVvzXDOEWX4YP5pYynoiv6R8MGLr9KfORsghkj0UwUJfFRd9hDSoWOWPV?=
 =?us-ascii?Q?dgCD86fth2iiauzn/12yD2Wwc48aYTwephp6M8Qv4yxjJ6Uy1Lw8w3sSsbw9?=
 =?us-ascii?Q?zftx1A/CG83gVdF1Ht17R6JxZcE6F2c5EJ+v0bEh8c1mdwv0+0EWoQ7o115p?=
 =?us-ascii?Q?mJWF317hX/6Iir7lM60GWQF8JnfvBPLdFgJBFJmRqb0XQe1W7sNZX8Lz0dKB?=
 =?us-ascii?Q?NfwQqB7qIO2FkmA0PoG0Uw69viGYbm7tCfx2AcvHJhCwbTRHBx+PCXAkzpKa?=
 =?us-ascii?Q?TIGpJkz1aC5T7Qa2jJafL0cU0tmPz70ym8A+Z18EwSZAbySIFXinlllcJ52f?=
 =?us-ascii?Q?+VGhF+4gxyw0MesHITPcqbdal0XhUwNn/PQWxeme?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b36146-5fc8-410f-229b-08daa572363f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 19:05:18.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMxWkVR7VYs4iK/Lxt8EfwoJOOb4Yl8oPlkNnwpayYeqjFUGCCKEc+DH+R0l1BbFmsaWJ6PBELW3rKc9WEmsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5520
X-Proofpoint-ORIG-GUID: XXGVMapxpa7oXyo-PvU6O10L2vqGf5nP
X-Proofpoint-GUID: XXGVMapxpa7oXyo-PvU6O10L2vqGf5nP
X-Sony-Outbound-GUID: XXGVMapxpa7oXyo-PvU6O10L2vqGf5nP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '-' instead of '=3D' in identifier: "GPL-2.0-or-later"

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 drivers/spi/spi-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
index 9ea355f7d64f..1459dd224199 100644
--- a/drivers/spi/spi-gxp.c
+++ b/drivers/spi/spi-gxp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0=3Dor-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
=20
 #include <linux/iopoll.h>
--=20
2.25.1

