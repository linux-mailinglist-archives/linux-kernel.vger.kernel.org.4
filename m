Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8D6941F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBMJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:51:13 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA910C2;
        Mon, 13 Feb 2023 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnXf7NJULRmzHnoXa295fm7UJ73cpcfuP81uCEzv5Cc=;
 b=dW1KTAWGhG3vFqKu4AA/p8kuS6CgyoaV1dIHo2mxsfq94A4ehEizQ8WfomHjLmdcjTgKE3Ex6qfPSq8bV2y+PY77XsNpakVSf9Gk9CpIXnciJgpSceHfgSJ/cpx5RNzFI5B4I5w8skFTgcANb7+OGcqT1TBSK3AuSn2m54ZRdg8=
Received: from FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:95::20)
 by DB4PR08MB9263.eurprd08.prod.outlook.com (2603:10a6:10:3f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 09:51:08 +0000
Received: from VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
 (2603:10a6:d10:95:cafe::80) by FR3P281CA0149.outlook.office365.com
 (2603:10a6:d10:95::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10 via Frontend
 Transport; Mon, 13 Feb 2023 09:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=wolfvision.net; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=wolfvision.net;
Received-SPF: Pass (protection.outlook.com: domain of wolfvision.net
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 VI1EUR04FT028.mail.protection.outlook.com (10.152.29.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:51:07 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 13 Feb 2023 09:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBLtz9HLJvaO7ApUtLrWj/Lfgckjpqz+wfdgd1L4OV0B23zSBx+mIGHQGdb0VYvvX/f0uYCcPp8fkAXkmw9UieGQSduat70osEIs6sWCq4qrwQDTpSgWoHkJ8XXC4ZmhNr142P2Igfe4TISwFpblTa+jYO2E3EysHd4eAWzxgasD1lx1asNpr8KVHwdDak0Geda590QJlk3YqWCzuKeIx0G6u6Q2o85B0/G4/rn6Rl0Ty87h08WhwXzpYunWjUoQpBBYx2aUjjnu8H05x600IbN08WGxBupgy2TeoNOrN/nyIfZOesNnYAAatiRDdu463Da7umdZqWrucVicZi1KBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwTulmfI9HQ1GPy4LvQkLnxUELWNHDT9RC8UyXmedrA=;
 b=gXP/gHJ6nhQXmgaMXFbJp8k6wLeVcxr3BU6wZ/I1nvJkF22Lejd6UdM821iwPdPH+d3SqjIvW+Ok3ajwVv0xfpH4XZxdQiWyqDyPV06Od6DdeLEN/AW3B7gAit6RfHuy2/k32Znn8Qy4+gkBTHCWtff0EQy3YRD701Zpvn4L2guf49aPCJlEmLkq4f7WJQyBje8c6+RQ/nyOE7RtY2EvfJeV2LERr0kE9X0lfK0c9Or8bQl0Wli/CoppFr5BKnaRl84DbY/R3dvyyJ9aTWI5JjFs48kcUWBz9JzKBv+GQCK7wgcLL6oMOKSAsOWV4HIggJYwdh0LnvPYMuV1IplbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB7941.eurprd08.prod.outlook.com (2603:10a6:20b:539::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:51:02 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:51:02 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] pcf85363: support for quartz-load-femtofarads
Date:   Mon, 13 Feb 2023 10:50:16 +0100
Message-ID: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB7941:EE_|VI1EUR04FT028:EE_|DB4PR08MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fcf9dd-e834-4724-eb17-08db0da7d48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5cUAgyJcPxNGQJjfAcBJyih1JIiuFbs4hWwZxgEuIaNDeZfrobAscfzwCjwCRydPnle7ARLpNbhlFQrgM99gK/kqtUBYajnqDWut/Q4SYMpm5CZxClNjAigrdCzglao0JpmwsPsOA+o4gDxXdpNBgrIrdwrowYMXlOUbbcph+9twiFYv56BLDRb6W7aqlkCuVitfHGcayIaNCYFgeXVXy3XfB+56rYJgxLDReRx2Igstxsi0Nr+oXA8NNrlKNHpgWAfhGrCMYOAczZ+mIfGdHD6IN/Hi95B1M1X1jIwrjh5DJbX25lJvWnzbxdLH8PEeeA2YoW9FrEGgYkApk4gL2rLDV9Z+ZRopWdota0bRGfn69o31JdKz5c7sS6hO5WVSC/Eg/jDalgt3r+7JO/4R8EBkAVGVXgGmoCipGg+S1MIQFtztlv+mxhRJ8QXuxWyfSu/MRLusqUnimA1Ns/OgcRoaklpyuqvTFWuI4VWKFg0prL4rSj0xOOdenv3SgSWMl/Zw/dKinzLpgeT9tT9sQzQYVSZ2j57IwEhdTGaPThsckMdgkBYAndy3qkZg6Tg0heto/bbyu6ACObzBM6lastVwe1JVdVIX+kDuP8L+/g91AY1pz9V0PMwYi1We1NOQyhdCAUmp8UeKcg4rEqbv8OOFlRLFeKakvmUvV68r0ipyvVWlzz4esMiIe3C6co8/eO9f7pAsRsiKwloOTsP+dA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(451199018)(478600001)(52116002)(6486002)(36756003)(83380400001)(86362001)(38350700002)(38100700002)(186003)(6512007)(2616005)(26005)(6506007)(1076003)(6666004)(107886003)(41300700001)(8936002)(2906002)(44832011)(54906003)(5660300002)(316002)(66946007)(66476007)(66556008)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7941
X-CodeTwo-MessageID: 682be564-43ec-4edb-a8dc-b5f69e4b7cbd.20230213095105@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.c239d173-62f0-457e-aa9e-d6e0511e3c3c@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 82c970d8-66f6-4bf2-3be0-08db0da7d137
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJmjwzdKlzIZxWZpqVqz/P8oQbAcSWUtrdTdybYzzoU4+rDNCZLQbjRt9ZiXJxTkCOJDwAFQ2cWG56oHgvZsORNDYNJdnlif5aIUg2CCT3zA4np7FwbUaGN97l+s5mFXD8o/24848Tty7BZ/ngt+mzTMPCc2aTAe/FriCJBDAA/zGKokmMV9CDoH2mHF8fNBkgZL2i6BdZxG0HWr+RzjWbRUKHkdHUS++vGslukdE9aV5xB4oGpjkD6k/TBtr5n9NKCUsYT6CZHXqHbMyZ2nJGXGS55Ko/kJlL9KSjdcclz3aK1RFn72ZHaevUMM62BMi7LwAt/7ZE+FZSx2GA3ZfCoQMfR15RTK7u+zzhEDKiU3LEHgaGfki9YefiVZBV4Za5aGHyg9V3fiXjWB2XbXyvCY7sU1jOaFykEcuWyRvwElt9jkeCdX/6KJFIKRVxzBwChyEefYLtCRCvzb4+OEcxetMgnP43NHSDb+8oq8LBQHnC1Wp422tEHj6m/cMU3buvwolAfOL12qA37RCC/f22hXe3BMSaZB/g+Q0VimZ9RZhDHpihOgdtvV2kF+NmdLc5iEYQc7g6CnVT6+k7maj3snmIwFWRcoCYq+MkczWjmVZDTKD2in6AFAKYAOqi+ClGyZ8iBuovZSpmH/MPXLIhZ1OvDqSH8UH2pEat7sUmjk5/xX5YmyYT/XGLoAu92y5uJFEMBC6amu28E9BpgP5w==
X-Forefront-Antispam-Report: CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(39830400003)(136003)(376002)(396003)(346002)(451199018)(36840700001)(46966006)(82310400005)(1076003)(26005)(36860700001)(6486002)(83380400001)(2906002)(36756003)(6506007)(7596003)(7636003)(54906003)(4326008)(47076005)(6666004)(107886003)(336012)(478600001)(40480700001)(70586007)(8676002)(70206006)(6512007)(2616005)(356005)(186003)(8936002)(5660300002)(86362001)(44832011)(316002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:51:07.6949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fcf9dd-e834-4724-eb17-08db0da7d48c
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the quartz-load-femtofarads property in
the pcf85363 device driver and a description of the property's possible
values.=20

The driver has been tested with a PCF85263ATT RTC and a CTS3-32.768-12.5-20
oscillator that needs a 12.5 pF load capacitor. With no property
support the 7 pF default value leads to at least 2 Hz output frequency
deviations, while setting the right value the deviation decreased to
0.15 Hz. These measurements were made with a high precision oscilloscope
(SIGLENT SDS5104X).

This modification does not affect existing designs where the
quartz-load-femtofarads is not defined because in that case the default
value is used.

Javier Carrasco (2):
  rtc: pcf85363: add support for the quartz-load-femtofarads property
  dt-bindings: rtc: nxp,pcf8563: add quartz-load-femtofarads for
    pcf85263 and pcf85363

 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 20 ++++++++--
 drivers/rtc/rtc-pcf85363.c                    | 37 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 4 deletions(-)

--=20
2.37.2


Javier Carrasco =0A=
Research and Development=0A=
=0A=
Wolfvision GmbH =0A=
Oberes Ried 14 | 6833 Klaus | Austria =0A=
Tel: +43 5523 52250 <tel:+43552352250> | Mail: javier.carrasco@wolfvision.n=
et <mailto:javier.carrasco@wolfvision.net>=0A=
=0A=
Website: wolfvision.com <www.wolfvision.com> =0A=
Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria=0A=
=0A=
