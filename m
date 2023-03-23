Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42106C68D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCWMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjCWMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:50:01 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2128.outbound.protection.outlook.com [40.107.24.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5490323329
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJL77eRSxp3c3et7Wb5B6ka/Xpvw2O+XZB4Qr6UuMAI=;
 b=gZjNVoM7JL3kIk458zn6TgpKDkUoyJHW9LQqmCFM1Fz66VMtNnw6yh9Ja+NZcL7nZKOikKm5l9RFrwt3cvBjIsQGDVeCfjHDwGslKBYB6JH18XdJthZvlt2tRnKiAWWjvZpZZdgPawvvjfeMezo/QGDThPzMhxLoAB6MOtzK+pU=
Received: from DB8PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:10:110::25)
 by GV0P278MB0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:49:55 +0000
Received: from DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::8e) by DB8PR04CA0015.outlook.office365.com
 (2603:10a6:10:110::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT058.mail.protection.outlook.com (10.152.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 12:49:55 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.44) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 23 Mar 2023 12:49:53 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=GZ34E4b6RGLckkNhMkdHUtFvzm5iJj/2V9GOvhUePFJunVPUKxiUaiyGF7MTTUtt4V7Lg3xoJVZAANBmvI2uv1BvfqRY8ABuuWu3fah1CrDtzWM41Fm/jQhBTSp/JYct1A7t75q9tdkmM3bDOhsiYL4jApvuWnWyumH9rNCHubaJxEMl6W6HD39KA+fzGo4FPSagNyDXLatMX8Qrk4VO47jAV0IrAg8oep+Teb3O0s9PENfltFVqRrYs5GkGEdLB4v15ggxgOyNho+0Jr6C3U40aSy0x3q3k3kIMaEsLuwpUkYYndvElgVCQoSo4kVS1c1T5ySpLsuJvqUfem/MC/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJL77eRSxp3c3et7Wb5B6ka/Xpvw2O+XZB4Qr6UuMAI=;
 b=TGFqx9L8LpQ6Z3KPmj9nQnizul+Opkfnw8zLkHW1Q9AFTgCN2cl/4sK3zcec/i1EW3N8OSFSQKKVRmot4k0xvzDpXCAW5MRobm/08NrXWI4qRa1CmQrlM8//NXEIUK+iL7h1GfcASoJPDbiq86SSBvAGcaUdOz1jYbelkRc7eli0WCj7w5xUtwNTuVIVusvh0RDKhFauJTHQJeU0CtjFRpQm1hXV/QTxj4Qt7+/QqbgLwyzG5S52vc98btSnMHE6prbn6oKRgzOTP67id4mpVrSu2OW7GkKWrBS8aAE3PL8kn2pgDmDjx4PzhHSTv+cXBX1GPVKOxBTwo8oHnVgl8Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.111) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJL77eRSxp3c3et7Wb5B6ka/Xpvw2O+XZB4Qr6UuMAI=;
 b=gZjNVoM7JL3kIk458zn6TgpKDkUoyJHW9LQqmCFM1Fz66VMtNnw6yh9Ja+NZcL7nZKOikKm5l9RFrwt3cvBjIsQGDVeCfjHDwGslKBYB6JH18XdJthZvlt2tRnKiAWWjvZpZZdgPawvvjfeMezo/QGDThPzMhxLoAB6MOtzK+pU=
Received: from AS8PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:20b:127::25)
 by GVAP278MB0930.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:49:39 +0000
Received: from VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::eb) by AS8PR04CA0140.outlook.office365.com
 (2603:10a6:20b:127::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.111)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.111 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.111; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT089.mail.protection.outlook.com (10.152.3.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 12:49:37 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 13:49:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjJga67Nia7Xgm0g/PjwT5pQn0iySB5oq1DwDw/iWDvfwS6CGg0D3EwBr37NqSj9Re4q4xsbiEXkYRyTWUAWeOnVp1l3SXMQCRMHl7l43pXCJc7Son+8UKmkyNdoe2qhfwXNzXplCJcW47srrlqr/6nKl+44zwjUblFY+6UVJkTPayHf4+iK9pm3cn1PGOLFHtRTUoRkxMj4Xr1PzoiRgZDsxujxPkMUFWzJLgroTocbv13ADoy+UP8VKExpv3R37oSsq2HmChhUgO5j4CGqEyE4gimdFJcuROpRaN3DXIEsbv224xzfQ+Lh040I2yW8VqFojCLvbQYTa8qbU2tU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJL77eRSxp3c3et7Wb5B6ka/Xpvw2O+XZB4Qr6UuMAI=;
 b=C1FwpbxV6ebXADouGg/O67Gq8p8tCuNygWbLUTswJaK1T82itBN/kNkaD/b8aVyH3AI56J2L7deov3LV54CDEqrLwGCwgk8JssqDDDvCCK7VD+B2C0Uwv+R8FQfeH4G0VSilOWdCZf6trl80QhDQRaz5AZmORPfEitjlHi6u7qiCG17vFyP1ostHlOIrE21YxvtBr4YCR+b0JQoADobQSDt2XgzAhZ0cli0YPVTfm67EG4tQX0sKp3/o+62unam37nOx4thvNLG6fxVilnilygajS9k/p1p9Bx4rT7TQPWcqlHYXvN0PfJsz72+5xHWoy5E4uMqa6cqe+wqnrDbHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJL77eRSxp3c3et7Wb5B6ka/Xpvw2O+XZB4Qr6UuMAI=;
 b=gZjNVoM7JL3kIk458zn6TgpKDkUoyJHW9LQqmCFM1Fz66VMtNnw6yh9Ja+NZcL7nZKOikKm5l9RFrwt3cvBjIsQGDVeCfjHDwGslKBYB6JH18XdJthZvlt2tRnKiAWWjvZpZZdgPawvvjfeMezo/QGDThPzMhxLoAB6MOtzK+pU=
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4b::5) by
 GV0P278MB0034.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 12:49:34 +0000
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a]) by ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 12:49:34 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
Thread-Topic: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
Thread-Index: AQHZXYXrwDx2MzIzuEmufu3o3jFzlw==
Date:   Thu, 23 Mar 2023 12:49:34 +0000
Message-ID: <20230323124900.898035-2-josejavier.rodriguez@duagon.com>
References: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: ZRAP278MB0948:EE_|GV0P278MB0034:EE_|VE1EUR01FT089:EE_|GVAP278MB0930:EE_|DB5EUR01FT058:EE_|GV0P278MB0049:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcf49a7-f11b-4801-8e71-08db2b9d1a59
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vekNu07w4jQgdW3jbZwldpJe3wS21rnqIAz5p8ZT2BTR6Li64pOQeH+Gm1jZLajUJ790xMNeSWxRi3BkJjry20dfoEh8EpQJFeWVsDJ/bFoZf4e+XQJb9gOpv37/GIgmij2UAcD5DyhA6wWAkgT+S6yWyUr/2LM6LYZF9bICn1uCFvBI2H6oSiXNMHGhEPgI/W4Ba4HjBHC1Cd2mnkS04xA5xPojeSRl5aWRoQ/EEZLCOjhxSKTl1fBC/kdgJBly2ccjS5dVAUzrDmUxVIqA0CdEgpouBY9SVweKNC6m08giDFKFkIR8zbr4p5iFg1uULJCW0Il80RyVGFVFC+ToyzA64toRbEQLTsb8od5djcr4HIDNqlLbOZ4XICl4k/T0jNC4kQVDyM7Ll6id6FtZO0IEaVVVmlbLZqcpzVhIfVq3BVZT9TPA0Z3956TpfhzHmTqlaac8UofObSmXBrVIPfLPzogMGdUMaARXDT3QX+sFpL5HewtQ/RT6WFj7gaEIo8RczCCVylMJ92o3xlG3CBmNLTbwESlx2gh+M1kSTruL0EOzGOhSCRaqUYEKbFVBLZE+5kMgcQr/I2d2DZduAbsiRLf7e81bN5IG1D8E4H7Z5nXohpEL4l85RYS8Ld0JDm9wPh5AfD9y5gTsiF+6AX7neeHSJbdPsv8M2c8EX//uC9c00WFSstogXYC5zCoxHhy7Cu9POZpQEJAjX1+uvw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(136003)(396003)(376002)(366004)(346002)(451199018)(38100700002)(38070700005)(2906002)(478600001)(83380400001)(6486002)(2616005)(186003)(36756003)(86362001)(71200400001)(316002)(54906003)(110136005)(91956017)(66446008)(8676002)(66476007)(66556008)(4326008)(64756008)(76116006)(66946007)(107886003)(26005)(6512007)(6506007)(1076003)(8936002)(122000001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0034
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.111];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c9da70d9-fa1c-48d9-c754-08db2b9d0dca
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cZcfdO68AEgk4ksDGbY6Mvybrfxk1v7sLADu3TbZhZp5S1uprltzsDZ9SgEyoI66yO0YP0s8t0dj4zVI05ON9zRwzRCuCGqYyColmHehy8DV3Cmvz4S19xuNhMJGSzCiRRBC3ipIjYb3Zy+1onWhc56INDDujGgcnY9qMYlvXkKb4AQKOs2tjPLs8bEThhUycyeuqEoxJiHFK0kZ+E0u7od9FMVh1/Dcd/pMLBz3qlFecGii3vkreVXraIz06Kb6GbZMwIkFM+c2CyUjo9VMo6tgTwIcV+1c3jocMzBDFYxhJNnU6thBViQYw0wAgg/eFQku3SyoXDLAkt350bx8xeEhNmUw1arISKT/rM4GRCfPt14tL8rMvpYOiEW1njf8ZBrSKvEyMqkDIEM55rmQr48gxR4RYonTVQcLj0uK8nDuUIQY1XHrNQgGRzy5hFdh4SBEiQUXKmgJa8ZN523ad82CVyvmR1JGFzDUl/aGs0IiX4oAiRM5/8u1dgNd25ifK2lQrda7JCGyU3xHZ7kskhpmNdJKvxjTLqmlcl4GNNXO/2kreCq43q4c7KoRSvj3nyR7sX+hZ5k6i0hjkHkdLTrDhG77TYFoXoerqOZUw1eqFhjcd9VEbrLssooQPQ8tlar+MBuHwyMd1s7VDtxvG0vZFhuUnYsZu1ly/VSG9V8JA/nHShxENN5MqfcvXvToyf6j32UgA8pS8GBBCSRrpIv8DINb4PYTVWZuFfFGwKCRVHK0rABRfAqdXdYga/c2Ho+FwVQJkORJ9JMUafkykbAIb8P/dp+negJnXvw+gDvn2CL1Sh3NblaUz1gEN6wcRF3KY2xNUUSmruyOmXuLNaFE4oMrJGiCjtry9/IFHM/qyzUH+kIcUeotBaxSLljClZI9/bdZhf0fO6/a1ENZ+A==
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2111.outbound.protection.outlook.com;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39850400004)(376002)(5400799012)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(36756003)(156005)(316002)(110136005)(41300700001)(54906003)(4326008)(2906002)(7636003)(83380400001)(32850700003)(86362001)(36860700001)(34020700004)(82740400003)(47076005)(336012)(2616005)(40460700003)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(478600001)(40480700001)(6486002)(70586007)(8676002)(70206006)(82310400005)(12100799024);DIR:OUT;SFP:1501;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0930
X-CodeTwo-MessageID: 5532eb7e-9442-49f7-ac3b-305c712f89e6.20230323124953@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f9fcf8ca-0213-4416-7fb9-08db2b9d0f85
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feKR8/qZNgiTq99ordcKD1J4qvsHkonHkJgVvc3KGFS4L4XUTO39qSLNrQpuxogQ+us41KA4UfWez3Kvs1wdukQKdcFuD+aggYou0XVr2B90XnECTPS8n9HfZ3qCz4bRMUjLR+ydmKRMArigzCJTiz+KDhpn72vnoN8iPedcKSwSsEqtS7X8UMMmpM3oCGeEGLj3tz8L+80qvt3mAT1bdwrxeSoil8GzzYhOKFSVTsgGBLmufq5uxdZS0P2LD3GtYynTePo1DV3/A0eMoy7aa+ZJQYu9CwuM5LvyxDmQseiYTZp0QJFjSDtnzHNy7I2BGEQpPr4LubRU4PjLLjwkx07z3RSDrHUiiUeyVH2HVk6c3nKaohjEPRsGrHQ0p65CJlTaYkRiSqShRfITNvNF1au5ZMQzYoPGmHjDlGx8SeCQvvR5kDxnLxOqp7sb5bh2R9AFfDCZFYWjTMunt9zyyMJImJbXV6yvdYlN2b57h3eO96+1EMhgrHRUVAD/M6ogaKyA6W9j9n3RNdhaP0TACvtqhwsYs2MaC/YgxNfkonNrXxestZoGatf9mN0NY8ZdhcRKxmKLAmBKmHS67oerLOOoXFA1z58dBOTozrxSseW0mYurCA9XfW0ksAY5980rsydqwR3mAWcFfOogWKliP4/e4RkJxwFPSqjMIFtZGzI=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(396003)(39850400004)(136003)(346002)(376002)(451199018)(46966006)(36840700001)(41300700001)(5660300002)(4326008)(2906002)(36860700001)(7596003)(82740400003)(86362001)(7636003)(36756003)(8676002)(1076003)(107886003)(6486002)(26005)(110136005)(478600001)(70586007)(316002)(70206006)(8936002)(82310400005)(40480700001)(83380400001)(47076005)(6512007)(6506007)(54906003)(496002)(336012)(2616005)(186003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:49:55.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf49a7-f11b-4801-8e71-08db2b9d1a59
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0049
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-pci requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlaps with the IP Cores' memory regions.

There is no need to request the memory region for only parsing the
chameleon table as it is read-only. It is sufficient to only remaps
it when parsing.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-pci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index dc88232d9af8..e98f626020a7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -29,7 +29,6 @@ static int mcb_pci_get_irq(struct mcb_device *mdev)
=20
 static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id =
*id)
 {
-	struct resource *res;
 	struct priv *priv;
 	int ret;
 	unsigned long flags;
@@ -52,15 +51,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 		goto out_disable;
 	}
=20
-	res =3D devm_request_mem_region(&pdev->dev, priv->mapbase,
-				      CHAM_HEADER_SIZE,
-				      KBUILD_MODNAME);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to request PCI memory\n");
-		ret =3D -EBUSY;
-		goto out_disable;
-	}
-
 	priv->base =3D devm_ioremap(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
 	if (!priv->base) {
 		dev_err(&pdev->dev, "Cannot ioremap\n");
--=20
2.34.1
