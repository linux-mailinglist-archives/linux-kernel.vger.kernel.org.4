Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815016D0224
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjC3Kuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjC3Ku2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:50:28 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2102.outbound.protection.outlook.com [40.107.23.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67719B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgNLfxaXgcNY0MEnfTtIoeaDFDqyb6LMJhchKfD6VaM=;
 b=CeagGJpTHw6hHLTepNmEV4qpdfKoYXV0Yv53cCdzyiqc2xhjXbi/pw3+F77mx+Y8sRJdGUdc2F2BwUDaSUwjXnMQIZJApU4V+JP6Gp5LKuf4gf+m9KzOKSai9ZNufTaPuJOV4Beit0yfzWT3vDkHJFXznXqR8wk93JfSzPWBca0=
Received: from DB6PR0202CA0030.eurprd02.prod.outlook.com (2603:10a6:4:a5::16)
 by GVAP278MB0056.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 10:50:12 +0000
Received: from DB5EUR01FT068.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::7f) by DB6PR0202CA0030.outlook.office365.com
 (2603:10a6:4:a5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT068.mail.protection.outlook.com (10.152.5.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 10:50:11 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.109) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 Mar 2023 10:50:10 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=aXRnbzsFohAl3m4bwTaosOPrw9slzGqeGbU0GnMSReHYl11sfEEPIjlEyVFdWfUzU+e/fRGT7NdNRdx2tK001r6dxkIuBiUOPiX4Fj3m7WKQhjBv2o0gGUd1FsgQUhHhwcGOux3MuQFtnVEFf+Ta7fE1HEacOjPOjIm4E25Hp8LHnCFYN3vzBNkvQ4gSfPjwraoIU8/bPoaiICb6NtGBzV5W2gQf5FK1Zj2w8svMdBa2qlPKN0QU1pzqXUI4yfEQqisrbffOn0OW92JHqF/0kiBtjupmVnnfVHKDKAHkaCWttm2PMcfhZBVUAL651KtOm+QOou2jvu0fu3iD1lcXQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgNLfxaXgcNY0MEnfTtIoeaDFDqyb6LMJhchKfD6VaM=;
 b=fWIgXHzAzEZheZyUz+yB6jIOB3jxd4udLvzKvf5dvlBIYz6CMEalj016HwoAt0Vu4+mchv1CR3SCVLJVINF0yn84ltc/RKOkIDOzIZ3q7t2gaJfH8+h00IlP6EV5Q2SBI38+VfnF12dutBq37Nvgbu1E6JXUm31dCAlQnkhhk3y36CgF0uXdetnOXiEXDXt+uStqrrivn82ETzMwK71DVZsR6HzWDiOWJ1XAKzdglvtUPn5kQwjSJ/BpCn4jyo2s+u19nNfFMa5D5PB25Yy8E+Iyk9XgB5A6cXxWbuiKe1g7q9bKzmcI9LKHT3WRlxX/7X1UPwrSbDEGgLtQ2J9OyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgNLfxaXgcNY0MEnfTtIoeaDFDqyb6LMJhchKfD6VaM=;
 b=CeagGJpTHw6hHLTepNmEV4qpdfKoYXV0Yv53cCdzyiqc2xhjXbi/pw3+F77mx+Y8sRJdGUdc2F2BwUDaSUwjXnMQIZJApU4V+JP6Gp5LKuf4gf+m9KzOKSai9ZNufTaPuJOV4Beit0yfzWT3vDkHJFXznXqR8wk93JfSzPWBca0=
Received: from FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:9f::11)
 by ZR0P278MB0976.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Thu, 30 Mar
 2023 10:50:09 +0000
Received: from VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:9f:cafe::b8) by FR2P281CA0174.outlook.office365.com
 (2603:10a6:d10:9f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.43)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.43; helo=CHE01-GV0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT091.mail.protection.outlook.com (10.152.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 30 Mar 2023 10:50:08 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 30 Mar 2023 12:50:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMyzhh3/1JadOqgIDhD6ZF2v1ZOToi/lDawyLbDe3B/U0rWoeyzWT/7Cxob63LnOE69AbiEhe6cHRjyHO1m4j5yoPgmr++uOqBNDz1JRI2cW/g3YwlSEiEk38NvXAfRa0BitpT5dy6kvTXKG8Rz547DCT0X0iR4MVo3JV3t2Xvw5EphvuEYZTWnxp1QstLYUG9k/3OKIkI+c0/webrlpPXUKZsmTWfTSvv/TCWkd94SwY4Y78qdwjST8WofPc+ZOvPTDeCEJ8T9K1udiDKGs3d+to73vzD9dOfpka4x/O478XEdOWJk7++K1ekhbzeqmGW9rZXqa1g6Nc1wMSQZtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgNLfxaXgcNY0MEnfTtIoeaDFDqyb6LMJhchKfD6VaM=;
 b=heogFVibaL45bmPni5b1+bJvjISeFxsxyH2DEmdInpmNiAxh4+T6V1UiPcE3z7uL1kPWD5BUoS1S4ZicabJjTb4lf5t6yHD0xaYK6vxPv6xmiqIk73hrTA4B+Fp6o8rUGF0GCPyVDkgZXdUTbvzFP2zFsAJmKDQIeCTtADJlS3HZOnl+S9RD0RpvJXbSSgQ8qx9NKUqCr/r0JsAfRRGPHzlh1uVVk9+VxDHMmh6E1mDa0NkgjjXpxf77qLsKqyNlubtn+aqZbmpQLhSQJON9vIolY6tkWdqBVlX/t3K9aLYqHoqjfILngpmqhNbLatjFL58bhJzw9tnU0KfFOYCeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgNLfxaXgcNY0MEnfTtIoeaDFDqyb6LMJhchKfD6VaM=;
 b=CeagGJpTHw6hHLTepNmEV4qpdfKoYXV0Yv53cCdzyiqc2xhjXbi/pw3+F77mx+Y8sRJdGUdc2F2BwUDaSUwjXnMQIZJApU4V+JP6Gp5LKuf4gf+m9KzOKSai9ZNufTaPuJOV4Beit0yfzWT3vDkHJFXznXqR8wk93JfSzPWBca0=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0741.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 10:50:06 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%8]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:50:05 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 1/3] mcb: Return actual parsed size when reading chameleon
 table
Thread-Topic: [PATCH v3 1/3] mcb: Return actual parsed size when reading
 chameleon table
Thread-Index: AQHZYvVjgML0XJKdG0uVZhMs/U3cPg==
Date:   Thu, 30 Mar 2023 10:50:05 +0000
Message-ID: <20230330104949.21918-2-josejavier.rodriguez@duagon.com>
References: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0741:EE_|VE1EUR01FT091:EE_|ZR0P278MB0976:EE_|DB5EUR01FT068:EE_|GVAP278MB0056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d19d82b-cf2c-48f8-6a4c-08db310c8991
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dSb5Ihcea9ekJu0AhBpBOsTy334n50ti24HCKSkHk4kkHR6wFLitpo+HNp+O5GN7TSPYEBQO9tQxC3zla+4PS8jUzhWjoROPNiRoEYQOPPPawpvTmwu5126eQwSCqY6Q6asjbaETRRp+M4t+F5lDsIN2Thdaja40/XZcNSx5HevPxP7VAv97DXFm1kK1uBtBN3HLbnCUj9pPZVc7vYkETiixSyQjZnl2a6pkrzncvUaMZOvPpnWP/gd1fOlsUcqaVr+CCL1LIFa4OrhALKG3J8sXQEgVFwwNhLsLO44EhYEAzGkZbDdSFTRuvcX4Z/hsJg5UEOpoyMzcdcFYw0439loZTnhlt/IjCe6osFBb/hezxwwQ8b37xBbpVIszhsytsRmMPKHy7fYHiR+i/Blbn9/4MqoEPDoJsbqPrRASiJeWkCzKuMuMnspYOo+skvs0zfRv7YT7fRleKQwmESMGcG/ThDQXNMbiN+BdIPq1LSTY0mzrZNhcamLNVZrhEFREvRG62+izWkgqcCFSYQu9cJAgoc3mHlu3KlQXrQFZKZFMGvWZE7dtW+Re2jVHKUD2RvzDr+Wrcv6MzhQi+fzsdqPe5ehNbwc3RwbanCA0NkO8IZS3xaw4tAclEUbj0Hxg
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39850400004)(346002)(451199021)(83380400001)(2906002)(5660300002)(8936002)(36756003)(38070700005)(38100700002)(86362001)(122000001)(6512007)(6506007)(316002)(64756008)(66446008)(54906003)(4326008)(66556008)(6486002)(8676002)(66946007)(76116006)(66476007)(26005)(91956017)(186003)(1076003)(71200400001)(107886003)(478600001)(41300700001)(2616005)(110136005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0741
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.43];domain=CHE01-GV0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3b7b109c-edf4-40ec-834f-08db310c85b2
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BK4DtIljL+OnslKJ8KNxml/29geYY9/Dy4UqF7XvOyqoZtGhd3q/U5WcojWdL4yJbp+eNE1VbF9J08+OmUv25pKuSExD3zR1VmEf5dCyGLyO6F+3SvEgldQKrS7R9hlIbBLnaCxpGp/heD4Cy5u+P1IpCc7Mc1PX8joE51jAQDCjmP6iIkxisIvCqB6tFtN0N8h/xP+Hhxco/qSkrFdnwtSF5rAF9oVyEQ5o1yHxgHdSeAtDXKhxQjCSSaTRVFF6WSzKkGUSjCUo69vY8W4J/d96XPTNTBNueKH3yrEgJo7kXE0JKjQR3T54kS9wNVglfSWHmLITqgweLg6+CHTih6j4l90foWDYpznZklbeb+fjekXn+YUhEusrK2L6KEbuPJiI8ic4EvqHx2pTC+K4flaEKCQsqRrvz4OKHpAqqJ6bC2Eksjj5/FqPUvLh1nixsydRTOFnuCh5Te0hQhkRWgKvaJIJuvMtFJ+rnFRzsX8XZ48Ph9rmk0CRSt3ObnT9uxU1fjZq7nrOjxWNx0qToNsev6v5IH+p9JOTr4We6kaKml+hNXr+6hH+9U+hOOwnPJHgcaUQbff9hLPc/x0T7lDak9SkDakRxLy2aYJZUvS+imNOoPXXOpNOxwnCO35F3JEbXkPOH5KoTwpX31Uwki6fB2xsBQuQxpNyLUVyQIVIvJv4ZHmZkHcKE8h9C61YNncEAtwfU0nRGBHujB3mqVqDSdu25eCtjDZaPcLL6sI46js3meK2C5TWrzrkkp4udKMkGXdSkv5wLiP6eRLUeLMcwqXN/zbtVuDvwfPp+qy397XigtQluihkrcu8cZNW
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-GV0-obe.outbound.protection.outlook.com;PTR:mail-gv0che01lp2043.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(39850400004)(376002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40480700001)(36860700001)(54906003)(110136005)(32850700003)(156005)(70586007)(70206006)(4326008)(8676002)(82740400003)(7636003)(1076003)(316002)(47076005)(26005)(186003)(336012)(478600001)(83380400001)(6506007)(2616005)(41300700001)(6512007)(107886003)(6486002)(86362001)(2906002)(82310400005)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0976
X-CodeTwo-MessageID: d722aca6-5578-4f0d-a897-42661d1b6853.20230330105010@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT068.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 69eec4fd-7765-4c01-aa07-08db310c87df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCtE1Iy1Erp7GAaRWQMxarbLRU1lU6Pocc0f+Poxp3lAaOLfi3trbyx7w8kDbw4tr6bCLsUsZT87ey6VWw5fUsoWTdDjr1BbBYqm4cDs10SPuySvOihP3mlUo3ZhFQqN6bOXdCm9C6/95s0JFz4uV+bVcThhWdjIAWh25pc4W00rpX3dygFDL2mwuZsYLwIj8IdNjaNE1aS6hB9J1IbZHLZJw2Z3SQKqjLm78JHJKE4zuOAgyJS+vGUukbAOZoSzdqAYKmslc3sE8rJ6WDi3GynHkFpuudRkcE3Y1gNk3UARzT0ewSS2tNPyO2tz1eRvEudjysJM3LTSMyJNvYGmIg368tcOwn8W66znwyuPxNBYvnzPYdpEzoU+wBcfgMfaV/z0jHqhVF8/PprEDNVh1mke73InTpn8/R2kv2fOOIOlEBSOg3st/1DnOqtUL0TXRnws2yqtTZLaKl+tGn5eyN3qzcj+OJVUEIGp73+EvNRreUBBI6Eo46qj4VLMQvcYMroseaQFK8iJBPBEzX1WQ6lWMoLjAG0/b5A05vkIbr1tt1SVCuGV8x4VjdFXuiS2iNKECebrplxGSM/QFJqbggqgHGrvCa4F5qV/58vPIJcxkeSzPrCmnm6j1nIhNjoMK1n4wTKM18FcUXfWcbBgmvSV8qcnzEYiGDXqNKjlXTM=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39850400004)(451199021)(36840700001)(46966006)(47076005)(2616005)(83380400001)(336012)(36860700001)(6486002)(478600001)(186003)(316002)(110136005)(107886003)(26005)(1076003)(2906002)(54906003)(6512007)(6506007)(82310400005)(5660300002)(4326008)(36756003)(7636003)(8936002)(7596003)(70586007)(70206006)(8676002)(41300700001)(40480700001)(86362001)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:50:11.9184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d19d82b-cf2c-48f8-6a4c-08db310c8991
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT068.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0056
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function chameleon_parse_cells() returns the number of cells
parsed which has an undetermined size. This return value is only
used for error checking but the number of cells is never used.

Change return value to be number of bytes parsed to allow for
memory management improvements.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-parse.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index aa6938da0db8..2aef990f379f 100644
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
@@ -239,12 +240,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_a=
ddr_t mapbase,
 		num_cells++;
 	}
=20
-	if (num_cells =3D=3D 0)
-		num_cells =3D -EINVAL;
+	if (num_cells =3D=3D 0) {
+		ret =3D -EINVAL;
+		goto free_bar;
+	}
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
