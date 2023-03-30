Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A93D6D0221
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjC3Kuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjC3KuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:50:20 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2110.outbound.protection.outlook.com [40.107.23.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4058902C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=TLfK9nB2RE7AwKCJffV45S5d5B5qJiXIOYESwioBpps8kOo+U6JUyCi1dhmvafMS1gWZc0Kat8uDLOzSJFqc7nxTJQTWXtrxV//3mlo9m4Fo3CMpxQHIRgvQwrVZGSQGdqiOIH7Lmt964P6XAwhTLpl9tJMi7w4cJ7ezr0CaZDw=
Received: from FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:b4::20)
 by ZR0P278MB1122.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 10:50:13 +0000
Received: from VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:b4:cafe::c8) by FR0P281CA0173.outlook.office365.com
 (2603:10a6:d10:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 VE1EUR01FT047.mail.protection.outlook.com (10.152.3.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 10:50:13 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.49) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 Mar 2023 10:50:11 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JbjwDjA9F9SiPyhJpfPhNJVg/jgcz8kY8/aeNp1yrCJvcqEsHka+I2QFPJyuGLCvJaXMPJDVZ3Mp2062SLHcr0fOd5L01OtjJ0Du27ppR6nD5xGm2eRPf/tWyEsJPsemfzSJq1cQeKuKBMdUobwJEMh1CJ249Tqa0xUmw3oo1qxzLfHMew6cUVMIGk0AW/1+bbkOoBBYXO3zo3rvIJr4Edg6OabWQS8KF9RhwoWIjRQOBhlEtrNA3Z23gZ31YMkDPK/OnPh26PVL3LctDnpVT0nNcylomuJCiqctXS6c3v1+KkS3MZhzbw6tvTPJTSKcY+KuRFEZ+z25NYvtFwYjRA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=inr+5F7UK8JN5KfpQtgwqcwq7njbPtmmw3VVXsHleKu1sznR/X+uRbtzxRLtnnMHpWf3b5F7dOlKkp0zFVAFcG6/wAQASKahMaP67DTj2y3ly6DrBztaUYBuPoDCvxHXmq2ZJrmFKzsPynDd9aNz6SzzhLL9OBbNQ3K4PBW1KZxFU5SXT1jL9hKSp3l9DhcwMyWg3HRLdYVA5XYPPcT9iH8FBgMURcWqD1I2COk1MmmlulPNibGHsRWvNcZ2DFkv1nsb/RjPoizC/S6Et6dMqhMvumrFezW3jIAV9/nwWhW8vaEeMKGr99SPXodqPMP1gLPUvfRCgXi5JeuGdw6mUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=TLfK9nB2RE7AwKCJffV45S5d5B5qJiXIOYESwioBpps8kOo+U6JUyCi1dhmvafMS1gWZc0Kat8uDLOzSJFqc7nxTJQTWXtrxV//3mlo9m4Fo3CMpxQHIRgvQwrVZGSQGdqiOIH7Lmt964P6XAwhTLpl9tJMi7w4cJ7ezr0CaZDw=
Received: from AS9PR06CA0382.eurprd06.prod.outlook.com (2603:10a6:20b:460::11)
 by ZR0P278MB0122.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 10:50:11 +0000
Received: from VE1EUR01FT088.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:460:cafe::20) by AS9PR06CA0382.outlook.office365.com
 (2603:10a6:20b:460::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.43)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.43; helo=CHE01-GV0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT088.mail.protection.outlook.com (10.152.2.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 30 Mar 2023 10:50:10 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 30 Mar 2023 12:50:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0ZHa5hD661D0+79yHNzCnhI9EFNuV2/e2Zn5mhRhztNB6SVDHsCP8+cSsayyLeGbBg3dc91M8ykfl4tojNQGapj6RwhlSLQFSh3+n2DNazv87Z/80ylYam2EF4HiFv9MGA1QvvjVStAZgJ7dHaSsL5xCb51au0r3UP0LdRvnpfHgiCE4lwK127D+DC6eIi/Rd89iXoP27uDkDD7n1gsG8JeLxhpoq16WN9blvZPz8n3awkNpi5WJ4VXYr+zWKwrh8ufvJy0QkLwWIZP6ZU3isyZn3EXXa6yVIUc9fsJaNdtGMKzClzQ9zUOATJNHN8C7KtRo1GrdFDDBZ4ELGC5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=RHu8VmCt5+0/V6KOpybLzmU2Qx0Cd6O9ixY541goefgHg/LLbFGoaPp/7vW9yEq+JLZswVmUuYJSJGjB7orXhZhlTp+xVB0npG2JhYbNk+S9gyedNe4oTD5oWHCco0iFKvmlD1owyv2P6gFYsZWiIltEdi7smhO6lrmsjgWG/LuyCM1zwzxB/65NRgGE8JqBIH3nnOVIvApIXTNkvE2xzzBHYsN4dDHG43W6KWoo38R37qpHFiuu5yNhq0BEg4cK1+gW2XiEivEikPY0bZS7IPp0LkxrWc8mNhw8vSP2La0voCthV4iQ710Tw9HedQVMvwcWxTyR69GN0ntold7q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=TLfK9nB2RE7AwKCJffV45S5d5B5qJiXIOYESwioBpps8kOo+U6JUyCi1dhmvafMS1gWZc0Kat8uDLOzSJFqc7nxTJQTWXtrxV//3mlo9m4Fo3CMpxQHIRgvQwrVZGSQGdqiOIH7Lmt964P6XAwhTLpl9tJMi7w4cJ7ezr0CaZDw=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0741.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 10:50:08 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%8]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:50:08 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 3/3] mcb-lpc: Reallocate memory region to avoid memory
 overlapping
Thread-Topic: [PATCH v3 3/3] mcb-lpc: Reallocate memory region to avoid memory
 overlapping
Thread-Index: AQHZYvVkYfgmX7xWCEK/WSKxu2oxrw==
Date:   Thu, 30 Mar 2023 10:50:07 +0000
Message-ID: <20230330104949.21918-4-josejavier.rodriguez@duagon.com>
References: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0741:EE_|VE1EUR01FT088:EE_|ZR0P278MB0122:EE_|VE1EUR01FT047:EE_|ZR0P278MB1122:EE_
X-MS-Office365-Filtering-Correlation-Id: 44677f31-4f0f-403b-c36f-08db310c8a3c
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GJbFKF+jMI5CiMvbNP0/N0dNycBSJZxDqyw6v4jmaBuGeP3OP+jZMBnad+VmZ+TOrYjuxlbLl6x+pClo+fl71M0tTIcDgQdHu60vv1PJoGSaGslhJ5ER8mneJMs1N6ouftBXMnE87OVtfRzGyas9LU80FdASNKOJf2YYz9Z29i12bWa/0r9auJk+9nxliBc/TGctfZX5q7VVNa224avXdi80Dk14tOzMYwLq+I/7J/ryArFKN2jhzrC1hojGGNZeloJ3tQ1yuseCHUkMC9gfzV565n8b546HlSTPjcf7n4hucUGjt5FiL2DT1Wmu8EZpVVCQvAaRatB7cQhwuF52YTqf4T6w0W1qmiBKdymPuj0EYxJdpcCTo7cdDtrtZ5W5IL/g0NvEdSnxtrZsP0Rv6XcPhLLNR/BM0QZJtR16XEe13ej+YC4CQOV6e+Nal0zoaSd2Yhocc6PoxgNbngv+mc9Yuq/gz0IB//kXAE5W1t7eExegTWk0bgFgoypquHpkpqKOjxQnljetpugXzXoS5i1+P+D3BsaaIDA9FfGk8UNXJeaoooZuaCG1v0ggd8vqbAjoYmk4TjPP6uouwzhpWYgTguj1Up28YEaXAZ083u1rC8iJOgCbfx8p7GnhAgrv
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39850400004)(346002)(451199021)(83380400001)(2906002)(5660300002)(8936002)(36756003)(38070700005)(38100700002)(86362001)(122000001)(6512007)(6506007)(316002)(64756008)(66446008)(54906003)(4326008)(66556008)(6486002)(8676002)(66946007)(76116006)(66476007)(26005)(91956017)(186003)(1076003)(71200400001)(107886003)(478600001)(41300700001)(2616005)(110136005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0741
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.43];domain=CHE01-GV0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT088.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f6674e5a-f018-42d8-cc16-08db310c8726
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0W6oin+Qa6r1+pi6WUvZGY2wMxjeyMmxEaBDTiI4Gf1C5na0jiIYe+4FPp/3UZLI+qkqpE97Rbfqw8Sr5Zd96NcbUp2tuchbnWiNHRatHRIX5elgkaIfkSaOtqOgYRa/gVNDIRvVU9SvQk/zWDSUEcibPL8M82iGVTxcrBpcwNV4pph7BqRSPcDX79VtPVfjzvzAsbOiPn1FRDoIGq1FQ/k+cu8z+q+cdPJ6/ClSwE4O72ql9CVCVSj63II+Nyec1+f5WYoED3HW5Os13S3yzim/RVsIrC/6OcbOpg8ONtoJL8dd8BvEaYpwMRoHUr3JspwBzMJIf8W8bxOK4L6FbeCqzLTfEdisNmx+5u36h43QgHO+Q1MJzExfgCLBvn0brJbRb8aW4kE774xsDvusXtycZWrJJ29rKvZpf2UfCjqZUCQBhtl1jju4aN3YgZR3yizBP6hjaKImIvG0HmTgz4DrSyf/mdXEUPwOqjwX7g2k56mA4W6cl8vTSlarNKAe8QE7QIiVZwRr40PDTAODTjPRJWNPEk2O2asStFp8ZnJayyJp4Dro9ecurum+XeLtJVRP/O1W81UPceKsSxMtDm1DeosqJ+Tazj9fPE0BvBqGn/N5uBI8/Lytu11n9emSMfoFwXrcMvEjBWXWAEs/RpfMET0Uh/zagG4bXYKHjNtplVzK3/sTzQzCG3tG4N9Ccn1Oy5nNUeKBRWmXq3JXExt/FQtKFSw/xAxcoy8gB1qYK1Lg6pN+NulnNuVjlsqL069WC+k6bUjv6d/LFJWuwpJIPSPSDPEqKy+V6UzV5oisGYZ1uXVJG0QFsEAGh763
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-GV0-obe.outbound.protection.outlook.com;PTR:mail-gv0che01lp2043.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(376002)(396003)(451199021)(36840700001)(46966006)(478600001)(2616005)(6486002)(36756003)(83380400001)(47076005)(336012)(86362001)(40480700001)(156005)(36860700001)(32850700003)(7636003)(82740400003)(26005)(186003)(1076003)(6506007)(107886003)(41300700001)(2906002)(82310400005)(5660300002)(110136005)(54906003)(8936002)(316002)(4326008)(8676002)(70586007)(70206006)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0122
X-CodeTwo-MessageID: 93522a64-d589-409a-b242-833b004d8109.20230330105011@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e2cf3bc-60c1-4a67-1a1b-08db310c88ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwneSbt6gj/lL/e5j1N6z4UtCnIGQBXvLW+PRHQGbAWkXF3MGeEVM8jKhSeBJTn1/KsyVsTRidCnUZiUsr9lyywqrZpFji3TeEYLURYAuCO+TQ+jlCDgJIKeyB1y3Xh9t66W16TuyBTeaZbxumPqSIyOW14OrVbOfl/r+8w4+z5B4ZUeaYX7aVFkPjej9UXZ7avsLfdUKvIQp2apXr6DTs0ENMQ15XQvUSeH0kEO0f1FgKGXw1eJBgYFB68vjJ03BYaWITyDWlanue67bu52SqOMve6GLrqNQQij+D9k+hC3lNmGI60H15gB9FDitVJ81NoT8tVgLlpw4M3PW/3KEGLabdTWjNmEXK/uTax+2rV9Dt5NegDuEcxqao9YJXe1Hz27g3/T0rBpnYZ4Bjf/MSMt1Q3IS9i+RehBpce2vwNxXg8MVnZSGl+CR/4NFYAo8aiZq98i5SiFQfaJXEz7DaJBl2gZ4nknrXk6y4umZNcAKTECYNr1T2y2DBuksrJCMgymkZ+94uS959Ran8gF8WPnH4AOuLvKtUik0/Cy1WnWje+4an3r6nTwcK0fl8xCNSZdWF6EGUMYDii2FUXc29ZJwvrD3PeKEu3WR5bpl2tyG3mBnL/zq9kpmu0MV2AqCsWDVlERZVAs4lmICD0bxSnReo3BTLJ7+YWNRCp8UFw=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(2616005)(478600001)(47076005)(336012)(40480700001)(6486002)(83380400001)(186003)(36860700001)(110136005)(107886003)(316002)(54906003)(1076003)(6512007)(6506007)(26005)(41300700001)(82740400003)(7636003)(8936002)(4326008)(70206006)(5660300002)(8676002)(7596003)(70586007)(2906002)(86362001)(82310400005)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:50:13.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44677f31-4f0f-403b-c36f-08db310c8a3c
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1122
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-lpc requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-lpc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 53decd89876e..a851e0236464 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret =3D 0;
+	int ret =3D 0, table_size;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
=20
 	ret =3D chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
=20
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size =3D ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv=
->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res =3D devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret =3D -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base =3D devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret =3D -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
=20
 	mcb_bus_add_devices(priv->bus);
=20
 	return 0;
=20
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
=20
 static int mcb_lpc_remove(struct platform_device *pdev)
--=20
2.34.1
