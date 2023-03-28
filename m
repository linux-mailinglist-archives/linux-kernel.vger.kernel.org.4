Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F956CC224
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjC1OfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjC1OfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:11 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2093.outbound.protection.outlook.com [40.107.24.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5661AF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxnQRIo7oaL6AtBZ0HFS/TgaIoD1r6TNi5Zq45ijFgc=;
 b=A+sPrrLCExxaMnfjdeocizfkJbC4t9aK474LaGa2gA5eBTXyFcJjtEPT1eGv9wbwRKaF2nZmrdunK78xl1PoVC7yB90ePuMSa485+39gsSZbQLEjb3jIFbGZrZqH4sIZs+FbLH6I1cIusLItTty7F97dk1jkwOIHNDe18cwD2+U=
Received: from DB6PR0202CA0009.eurprd02.prod.outlook.com (2603:10a6:4:29::19)
 by ZR0P278MB0153.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:06 +0000
Received: from DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::58) by DB6PR0202CA0009.outlook.office365.com
 (2603:10a6:4:29::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT071.mail.protection.outlook.com (10.152.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 14:35:05 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.45) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 Mar 2023 14:35:04 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Lq5pJnOugNMkFiAkEakJGDUeqNXBIfeUOZEP3KBclqZdMhsq/77o9SxMnoi+vmFmIrg9w2p8vf4DfIjMNvG3eDVeGbLZUEg2TFqWrfLDPvLnLmR56PpwcsxS8k3zVO1b+CW9U9iKJlv3rvalD9uonaqZrkjE68td4OfSdGc6Z8Wga4C02vGg9hSbyiK9mIUQYqd+0XJR1fVyOOfVueQoMYwUBqvDa+tva/mlwIxyx5NMjTejhVN5CNpKfRtm1ACRh+3Vd76Ln8z/0QckhBOZjhopMxyuT7Th4rTpV5WJw+kfa4UxkTFADopfMDX737fIpzlLI5OoRIw/V99bEndh6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxnQRIo7oaL6AtBZ0HFS/TgaIoD1r6TNi5Zq45ijFgc=;
 b=CAtpdViPcUlHCDdvOp6voe6VvZbZkhtODCZaAYk/gf5sJVsVyAD0cqpVZ1dM1/700tyrA4sRNbHH09HHkM7NHpGDiiR4LP6jlNBzlM/OT9gqcp9tfkbcYr5VqbpvqeXP6I5F+uvk9coeVAhQr1yL9+MC/BV8lY/0Rp1vRByNRtomhyUF+YGyrJC0kFY/XFp2lOew/lL8akQ8MD8qgY2E/eUu1kk/1TlRWqv99HK2vxIcHxbLzwHP5RvCprl/HBpfP3znAB6gxr9T3ycMK/6rU1hAmmpk4MJsLoKlVCRBYwBE0KoDpsaZ1gA8BEyY4o/j+ExE5mtJHd/0ujJHxJI4BQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.105) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxnQRIo7oaL6AtBZ0HFS/TgaIoD1r6TNi5Zq45ijFgc=;
 b=A+sPrrLCExxaMnfjdeocizfkJbC4t9aK474LaGa2gA5eBTXyFcJjtEPT1eGv9wbwRKaF2nZmrdunK78xl1PoVC7yB90ePuMSa485+39gsSZbQLEjb3jIFbGZrZqH4sIZs+FbLH6I1cIusLItTty7F97dk1jkwOIHNDe18cwD2+U=
Received: from OS6P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::12)
 by ZR0P278MB0758.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:01 +0000
Received: from HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:32:cafe::76) by OS6P279CA0043.outlook.office365.com
 (2603:10a6:e10:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.105)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.105; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 HE1EUR01FT074.mail.protection.outlook.com (10.152.1.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Tue, 28 Mar 2023 14:35:00 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 16:34:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErL4M+QO7kRh+J9NN0aSB+RFNwXgqtf+NC5HrcXCaLnz0/OQX8OUBep3G99/t6PdxWfHotIBCFv1/rpQWBmi05a1TlUqvo8suNNMRNgxhzZrzTTfDll4jsLYMd6CrM1BLY4UUpscGtQ3soFKU6SVsGwoHvPCAOZDC4CeNTctFghoREAl7lNQwcgsnfcxeWI8I7FxNUn5NcoPDvnLtu1geX8jsUB5KOVJu3PEU3BbKsG6x+csyOXBG1mD++yr74sh+bcwRpTgX8h8p6AeK8c3mGlHdQ5d2nyGQJ0XGuQYGvqiSGz0kCxeu91Xu6fh632ceaPF5ycUNUCFjMNPH/jgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxnQRIo7oaL6AtBZ0HFS/TgaIoD1r6TNi5Zq45ijFgc=;
 b=jKK0B8Y1prn23PPYta2A78nsiyb0s9VqsYex1JGCE0vmFdRDSJuDv+dLD1d9qF7CY/+Zu6zuE8hOhPO0Xhjlw0LaE5S0j05XjK9WBNc1vobfFZN5sUNHGuSc7DoYR/ke4rw3oSqqxJubwwzmLQfHXZsOq+UUCTbkCitqSFgIIWzMUtPKY5obB2JtM+Qr2AhZ6ECHe1GpIQd/VV9HJW5ZZbJu0WNWJPja5BS9hdVWd/h14qNfFsB8Z0kIQRGRl4B8qMzkkW+yTPtZFI29SQN9NuxK8okn6+gQQoEKn0VXDzgX3HrIK2RVPKKW/mo0l+pKnLTXXhnW5kbwtmbdzadp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxnQRIo7oaL6AtBZ0HFS/TgaIoD1r6TNi5Zq45ijFgc=;
 b=A+sPrrLCExxaMnfjdeocizfkJbC4t9aK474LaGa2gA5eBTXyFcJjtEPT1eGv9wbwRKaF2nZmrdunK78xl1PoVC7yB90ePuMSa485+39gsSZbQLEjb3jIFbGZrZqH4sIZs+FbLH6I1cIusLItTty7F97dk1jkwOIHNDe18cwD2+U=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:34:58 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 14:34:58 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v2 1/3] mcb: Return actual parsed size when reading chameleon
 table
Thread-Topic: [PATCH v2 1/3] mcb: Return actual parsed size when reading
 chameleon table
Thread-Index: AQHZYYJ4chFa5DrrS06EFjE1BUZLIA==
Date:   Tue, 28 Mar 2023 14:34:58 +0000
Message-ID: <20230328143441.78932-2-josejavier.rodriguez@duagon.com>
References: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|HE1EUR01FT074:EE_|ZR0P278MB0758:EE_|DB5EUR01FT071:EE_|ZR0P278MB0153:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e1354f-fb66-4fc3-4d11-08db2f999fd7
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m6vwyLyA50A27iexVLU+uklyggP2jdYzE3BSRTIH2s7RyvrlM1ON2UrW2CH2RQ2wDMoMo9iGuNCV92v/XTBVR7IPgaZcU45tb5evjWRXs9fg2uo6mJsRwq9g9ENLVjw56+F3aqoVZMjDaLCQJcIXkzDl1Z2kMYDjBKaIShH3nxMdQxnmX9C/zmiWCEhQrs8P4GLgycaia7ceRVKGCTWeD46cpRGNEiJN8/CWOuFTsvtaApbYg6NO3DHIzOAUvL7WISR7SMPldPgkthFkKsdB3bi6ycTzvcoepA/eTd9MEnHELlgvzP2nbotOGSwezBOobxEDGsQ6ga5xUf/yxDGIvJ0UAFE/I87Ym5genSes6faw93Tt4TkYu42AnquJwGPnv0rSJeIDwrOmw870vfGhAdHN67oR9jJJpv+5UYskrfYJhO44CdiMiX5G8Hl8sqbgx+jmDfH3l4Y04L6ozw2UYU/925mwsuo1TlNE959/SMKnr1BBQOl+XMPt3c59c9MjQQkCGW+qn7AfDs47wPzIM7ufcXS3a0ICysgt9YqXEAk8glH1r81K0hSINGMgbKrJmVBdZshxBDVBACrqKocs98D+CwwDJfO7CoPV4X/j2hGPx2n4YjQf00hr7A62BbTw
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39850400004)(366004)(136003)(396003)(451199021)(107886003)(41300700001)(122000001)(91956017)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(66446008)(86362001)(478600001)(316002)(71200400001)(54906003)(110136005)(36756003)(38100700002)(38070700005)(8676002)(6486002)(2906002)(186003)(26005)(83380400001)(5660300002)(6512007)(2616005)(6506007)(1076003)(8936002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.105];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e024ed9-6a6f-45cd-8b3b-08db2f999b66
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Gof5z9u9PWqmwsz35tkevon9slvjRg8veMd3vsul7KiH+p09dLzaQFYJ+lSmUM3UwRKuVpPvl/BIKi+hulSaECYUMDyoug7vw7h5Qp0FJVwGrohbsQW+/6OMtClVexBRhcGiCDbNUAbkbHVvDagDOqGnD+xQCpPO28FaafsIb9vUXdKKLjyYEB4sYu4UxatfDNvTgHphHONCv98mj8OFaqRrPwcHlxAJEQXPl+gXUNPBnV+GWW/ImBAK8ACKsPE7u1f9bBnigfyyRPieftH+i4KJW5wyjO2Bg6f6PgsU6F2LzQh1Wtmhc4W4xmIIiHHuu1ijXvmTI+WZ2vzHV910no+PsfZsLAptrpMuhIcV+1gngvFWFTg2ZHMLs9HIUICZeHrexESs+C7vJbIpyXPWGcDH1H2ckPM2BO0NRDeqytYYb5Zk1lhQRtybFdWCnHIs7eVFFHxuj/dTNkVl91o+tU0Qfo4m4XwadAPUTIp0bs2ZcXAg/IaoYXGIL39Ile5hjDQbCa/v++p1NXt3SlYqGf7iqmQryAVAdZJYn9SH/KXPQ+HrTEFVOza6rT6waDUoVdt8OVbtVhjpzzN7I4afv29BJXdljuQ9w7IhJXCgUbXI451/7ul0DgmelNueI8jciVjaEggTiiLNgB4YzRlaBRjhreZLOcEX7oNwtBuA4Yqf8H02ajf2cyWpXRwjyL5AUEgBmf5qgd/zDw3g6RTF5FPLdbmM2Lnc7MxIJz4nN1TrM90BGVCNJFRZgV+DlTGujTVdVfo9TYeG85ZlrGj2LPeewLHaBMbww8+NimM4vSIxO3eo6kzTAGzka8m6Xw+g
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2105.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(396003)(39850400004)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(5660300002)(8936002)(82740400003)(4326008)(7636003)(32850700003)(8676002)(70206006)(70586007)(41300700001)(156005)(40480700001)(2906002)(107886003)(26005)(6512007)(6506007)(1076003)(6486002)(47076005)(186003)(336012)(36756003)(2616005)(82310400005)(83380400001)(110136005)(36860700001)(316002)(86362001)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0758
X-CodeTwo-MessageID: 9eee75a5-d336-4546-a1a6-06ce5ab37df6.20230328143504@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7cb3e91e-7135-4694-f3e5-08db2f999cfa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjPg0I3m0iM4W77LGZ2W06yitTZiDi6s+h0KnqJjWoaXABJd4iLl5fqI07aTPyA+zOOs9Q5rDLkD6rZY08emiaV9D+LbD+8u/OCHpJR/70ZKpStEVNY8J4OJ4adtBd5SEzVcU7WGNUbHfTsXYjqJk2SuSVVHBRZiepN3TN92NG7TovRfj0wY7UqMEK5hns9+/8V8qb7GBEbtnDBTABQXmmhPKfxhoahHuJqABPlEvSP9SpjukK79CUZZ2RWrDzYLvB1XDsI4P8dolNULDSAOJBXvR6S4wawT35e5zvwnycYzOek4+zhsAdqpb6x4/EsWqiAFZCK4iiuT7GyG5yD6ouNTzTev4UX3vu0Oh1rb1gxM43FUjS8TMIt19bzcRoEPo0BpGg3vh3pYvNMkikC35qxDIDt30KgAwjXNFfV06pIoTtlbuTaVfgly3HOQU9il5BS1bvrGSbhYWonF8i91rocler2gvAmXKfztMibEMRc7GElO8z3Cuft2FTyudwJPPA4F5NmuiEhJ/AazrG9mCvzajtSVIRbjq8S4BiKthymhMHdboPYgKQcLdhZ58mQXDJQlzFUKMKPTJKJA3WpK1rkOZ3omiQT+Tc0VjNcZy2UbFUA97G+c6Z5p64LwJIsZ/HCjagd9yVWPzFwwEKl5mP8njoN23gK3IqRaSH80cTQ=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(336012)(83380400001)(2616005)(186003)(6506007)(26005)(6512007)(1076003)(107886003)(47076005)(6486002)(70586007)(316002)(70206006)(478600001)(110136005)(4326008)(36860700001)(8676002)(5660300002)(8936002)(86362001)(82740400003)(41300700001)(2906002)(7596003)(7636003)(36756003)(82310400005)(40480700001)(54906003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:35:05.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e1354f-fb66-4fc3-4d11-08db2f999fd7
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0153
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function chameleon_parse_cells() returns the number of cells parsed
which has an undetermined size. This return value is only used for
error checking but the number of cells is never used.

Change return value to be number of bytes parsed to allow for memory
management improvements.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-parse.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index aa6938da0db8..5c2746e1d4cf 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -130,7 +130,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
=20
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -179,12 +179,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_a=
ddr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p =3D base;
+	void __iomem *p =3D base;
 	int num_cells =3D 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
=20
 	hsize =3D sizeof(struct chameleon_fpga_header);
=20
@@ -239,12 +240,15 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_a=
ddr_t mapbase,
 		num_cells++;
 	}
=20
+
 	if (num_cells =3D=3D 0)
 		num_cells =3D -EINVAL;
=20
+	table_size =3D p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_ce=
lls, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
=20
 free_bar:
 	kfree(cb);
--=20
2.34.1
