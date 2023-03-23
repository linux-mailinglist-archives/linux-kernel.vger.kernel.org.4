Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB06C6BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCWPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCWPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:12:19 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2096.outbound.protection.outlook.com [40.107.24.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B222BF13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGwyy/W0waJKoNAgRudQ4eBUCkEg2zpVTjntSryx3oU=;
 b=mg2EsqoxvcYf9IuV7Iy9p3D5TDz/dlRSah245mms8XWWeEzsTkQ2MOGDxjMf/vmcHPj/o42ZLSV8rGlNIZl5xXjzkyMQ3+rwPN8+nRL0Ele9eY6ZWKv+KK0D+RnonY89XwgnycrQa2rEsiIfRLJbPOJ1Z5wzW6pqjfWRf7JgZSo=
Received: from FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::8) by
 GVAP278MB0971.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 15:11:42 +0000
Received: from VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::5e) by FR3P281CA0040.outlook.office365.com
 (2603:10a6:d10:4a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.6 via Frontend
 Transport; Thu, 23 Mar 2023 15:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 VE1EUR01FT011.mail.protection.outlook.com (10.152.2.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Thu, 23 Mar 2023 15:11:41 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.48) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 23 Mar 2023 15:11:39 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NAk1AliNpVfEWp6SH1oHMFxZ8j2C0zQAHy1i3vO4srTMNV5ykUMlJ/iWcJ7cjVc3hPTw7WObrlLK1bUtC0jhro6gu/V+NQgY5oQH0hCosNwYHNz3hN1+dVy+G4yJMnzud+og4wXKOmuOKZOkD6cXaE3PVtUOTWjVLqbaDZ7bCIBPmAL9DudBviEqASineoq833uVVM9h15YD3L4JePKIIudHEse6L0/KeVQIam3R5sQVDs2HVFBx3rJ+37jjHoJ5ACpVSnZMpLIqxmDS7Xjuza0mEfmEYDtIMQ8DIsZGtG2NpEp5Cy3rEUYhmiAk9wxenD3YZ5WR6ayUav1xZkLuOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGwyy/W0waJKoNAgRudQ4eBUCkEg2zpVTjntSryx3oU=;
 b=meuZ1vpUPD/LcT+O60XUOkm24okghp5y3csYIAUJy7x2Kr/2g8bio1YHhUGUZY61oHXPZi+JMbCOppgOP40K61/2g9Zu0EQZeKN7XPij6jzZkVAf7Dl+gG64pv14VDZIZTVadQMyEpA3pXvB1olk4vMKKVTir4/PhEEe4nTUyf3y9KanXdmk45avX7It2Ipmf9F888kCnjUGI9becexWsDo+tRRX+BpdUfN4g98y77Dc6cEW8NU119u70e3kji68uV890FPSV+L8zDdBydP+NKNqOquY5NI82vOsyCbVsZTfS2YrafxSgo6AwZa+ZuoS5QGZriWQre89tNeroXF9VQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.111) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGwyy/W0waJKoNAgRudQ4eBUCkEg2zpVTjntSryx3oU=;
 b=mg2EsqoxvcYf9IuV7Iy9p3D5TDz/dlRSah245mms8XWWeEzsTkQ2MOGDxjMf/vmcHPj/o42ZLSV8rGlNIZl5xXjzkyMQ3+rwPN8+nRL0Ele9eY6ZWKv+KK0D+RnonY89XwgnycrQa2rEsiIfRLJbPOJ1Z5wzW6pqjfWRf7JgZSo=
Received: from DB6PR0301CA0040.eurprd03.prod.outlook.com (2603:10a6:4:3e::50)
 by ZRAP278MB0788.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 15:11:38 +0000
Received: from DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::9) by DB6PR0301CA0040.outlook.office365.com
 (2603:10a6:4:3e::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 15:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.111)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.111 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.111; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 DB5EUR01FT042.mail.protection.outlook.com (10.152.5.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 15:11:37 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 16:11:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfbxTx0W4fezQ8MBMorU25dl8lqe/od0hnMWhw+saqL0MeOphk+LG2M825krjwiE/z+L5CaCycyzIaattYZ8eGwoV/VNromC51WlfqyCF2WTtf0Y4TkQyqkOu/KUncga/ANUfD23PrTy2QvPeKcFr6Go3dvonvMqu0glu6BCKsLLysPckJXb1nKCCMvHE1CpmYDuRqBMwDJEfIjEMeCsUnnT6cEMki1UZUBEr/GGgHcyauuz50vladaVjivaT5r0AN7FeNGyZmE7S09tprHb/vJRyBx1GOARmQ8dpDSvLceKg/QG6mrrVeAbwLF8PA/NLmAq3q2BtwKpSNFGObZ1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGwyy/W0waJKoNAgRudQ4eBUCkEg2zpVTjntSryx3oU=;
 b=hH8G7P4dsdpMG9PdmlPxcymSDXqhA8Lab3Em+Wk1FAL/RALAfng/WulvhKnNIlQecsd7oXyJoXPbCwOOmW3MN5JnDK2WSMcUbCqWbM8MjLUHE0nIybZ5uatxtGu5Je8a9e//lB5KJq16ktja5D5w6Gx57zm954df2QeP3o3jL3t3IYR99fcl1Ly8NEPURbkC85+229vxg7PbYG35ze5JqJcSjz9biWWc8qyNOFi2bPnN/uZfh5xWhCgvi8SvAtKD4uKm6hlb9pQapKVkMWer0GNHavGMTBN/8P5mpNW7Jwnoo/Z1VSVncBn3wghLGvI6kIpcIB8F7oLbphhJ3VBvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGwyy/W0waJKoNAgRudQ4eBUCkEg2zpVTjntSryx3oU=;
 b=mg2EsqoxvcYf9IuV7Iy9p3D5TDz/dlRSah245mms8XWWeEzsTkQ2MOGDxjMf/vmcHPj/o42ZLSV8rGlNIZl5xXjzkyMQ3+rwPN8+nRL0Ele9eY6ZWKv+KK0D+RnonY89XwgnycrQa2rEsiIfRLJbPOJ1Z5wzW6pqjfWRf7JgZSo=
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4b::5) by
 ZRAP278MB0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 15:11:35 +0000
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a]) by ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 15:11:35 +0000
From:   =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "jth@kernel.org" <jth@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>, "mmoese@suse.de" <mmoese@suse.de>
Subject: Re: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
Thread-Topic: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
Thread-Index: AQHZXYXrwDx2MzIzuEmufu3o3jFzl68Ia7QAgAAMwgA=
Date:   Thu, 23 Mar 2023 15:11:35 +0000
Message-ID: <121decd1d4f8c4aa469636756557fce02b245ddc.camel@duagon.com>
References: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
         <20230323124900.898035-2-josejavier.rodriguez@duagon.com>
         <c08407ec-8553-87ca-85d5-1988b8f9172b@kernel.org>
In-Reply-To: <c08407ec-8553-87ca-85d5-1988b8f9172b@kernel.org>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: ZRAP278MB0948:EE_|ZRAP278MB0016:EE_|DB5EUR01FT042:EE_|ZRAP278MB0788:EE_|VE1EUR01FT011:EE_|GVAP278MB0971:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c127971-25c4-4417-9534-08db2bb0e8a3
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: e0R4/LndNqMC6BgM7E9C1YcNsRb0wcxJqGhZIDjfQJfmyJIFyg646UpQnYNTo3J/JIXsJIwsjPNOmrsiil34MQJ/vQg9zFCLvXoiY0J42Z3CRcgrhgDqXR+D5HnHjsokJTH/tnYUj7pAcb9njo1Tp3cG1g07HIQTN48RI25IjzAghwfVHKZj3mZr4z/qGqmsa804UXUjipW0MUlXW6hmC1H0ggm/E9E/qKv25kehH6CtbP/xgvTYBIPVW2aUD4oFAA0OszDBgElKBDBrcZSW4ZyAreArvwSPSk2owl279vex/eUQnDp5IpJ98BUWqFQ75OhrOkjrewYJoxV7vid0roE1/EHIFXR+eYhaYeLu342cdEI+n6mXkdrxw+va+U9/cvEY86BOU1UwdXhoqwWFItjx0u7Z7UXxemyV8qKofHCwp/KEyE0MTFZlWBERJ2DnlBgpw+693C/1iBW/W3IAM5yP7TcSgecByr23/GyHM2+gSaR5BM7iYsP5XhMzBPgecwoH7QHYX7F64j5CXfqDYsi0W+d1y4Pckkrk01iKqqLCtpRcxpt1JDvdEUXnnZqIBLUKn6wAnHsY6MD8qTz97+FoedjnBwexb1A3472j+KMAJFcvD+R9OBVxVW4+LE8UlHYsNvqQ3rVRCSv42OtWxDrgVIcruYIKJCnoHocTDHhTp/0aaJ5gbPDezkJ029XEB9kQ7HyF6SVeLXa8SvAnD08m1ZMo26JjT5EyIpZfxZE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39850400004)(376002)(346002)(396003)(451199018)(1590799015)(38100700002)(2906002)(38070700005)(2616005)(1580799012)(478600001)(83380400001)(6486002)(186003)(85182001)(85202003)(86362001)(36756003)(71200400001)(54906003)(110136005)(66476007)(64756008)(8676002)(66556008)(66446008)(4326008)(76116006)(66946007)(91956017)(8936002)(66574015)(53546011)(6512007)(6506007)(26005)(316002)(122000001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <1526FD197D11AD418B897A07F7E357D7@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0016
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.111];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 27ef843d-c2e4-44f5-112b-08db2bb0e4af
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8wkTrqPtBtzI68AjYHbYdU6gNlkvtm+/gKoUWbePxu29WYQCiQukjrBFG0T+lRDvcIgb4J1OZ+1jCImCgtY/U6l+StEPMhZPmeMonbuMp8uJ4ABOUXG6BbMA2e70y6awx/tpBN5td9NiFhTr0B9eGBnxn3JKOAl9d/obFGN4Rab/hz3gqLEylIYdT2twGvpMqfI58/Dvi6zTmy0L6E4VW5Xro+QEnBeUArg5BkFsOFKb+z0uRvnHjYaLsYk//+YB9MeEJ1G1RNmLJLkvktGL295nG47UwrGKbIrif02lRA+oiiLW38WvAwmTYZ6kFBs5k4j2KzsY2O5eRjKnJjjF5wzPSCxP2aGw/O4WD6mnMbf3NNwNEdJ4vFXtPwRxtyTfmgW1aJR9TTlzNkfBIgWAqAPrB7UrQh3WUkIflyQ8IMJKnH6gdlbuy+3aMSBs5hNwE8uN0Bty5q7MFLQlV8Gc86fB+R0AghiuVgXdx9cBSEU6dygc94lToFGPlFzdtcIbNKg8vZxs6BOrXA9FbxSorYKZilbZmgpeMmSNFJFEYbUm0hWzesoCtLAuTRCOCmax8J3+JLxR9nte7X7PcCCiKEvuoFbxhOqOkKNbJBrq5/hBowbSLk/IpBDop2GZCChziKOYvJ8SCwjoCkHT6PWlbT5hie28iXy3Z2Z+BsxM5BuHUVsJLGdq3NiVAFf8L43uGE2pp8u45c3OA/CTRRlX3eOocOy+xh5fcDHAKT+05RBVBspkYDqBgZ5ecPLURjVrxFL0UcOcHcwf+h5RS6OiA6JysQeFUCT69tUrUuHK8he6TF7uRFpySKxXBnsaLI60h9TVD7IiTOywcw3RBLffeEtWFWYm4bnBKVVKXprftYVORdfrSJkVFPQwu3K77V4fsuv5XNlx17I2UgBGFyUUAQ==
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2111.outbound.protection.outlook.com;CAT:NONE;SFS:(13230025)(346002)(39850400004)(376002)(396003)(136003)(451199018)(1590799015)(40470700004)(36840700001)(46966006)(1580799012)(70586007)(70206006)(41300700001)(8936002)(8676002)(4326008)(86362001)(85182001)(36756003)(40460700003)(85202003)(7636003)(6512007)(26005)(53546011)(186003)(34020700004)(36860700001)(40480700001)(2616005)(336012)(83380400001)(66574015)(47076005)(82310400005)(6506007)(6486002)(478600001)(110136005)(54906003)(316002)(32850700003)(156005)(82740400003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0788
X-CodeTwo-MessageID: f55c02e9-008d-43ce-81f8-93f49a6bc056.20230323151139@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d1a5ec1b-22dc-4242-d941-08db2bb0e653
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1KBvd9XRxLWhhwrMyNW9j/DzhkKXIMDRWq+j9IjTCHLMvRPSUgamPJy2GPF4EX0/8coVi9c8QWEmj1E6J6MtJFqWThhYVM5xvRSIgqr3HrtX/NPPmPNaSAldW/zv8KZSncjw80tt7GkLCMPmfldlJNjgR5Z7IWSqOt1ryAFkg6YP9xqg/ddtMMIju5Kfrh9Uo3ZYuiBcP0DQy3dQjyQz2I6oK55OwqFk+YvWqwDxZ5pDzG5dlVWEfUWGzkAXqHe2BANpWWkT2N5iTkflqbuX6GMcrA2JyPeEVrDaDqUj2hW5yTcAGizBvmrhDwR0VBQ/Dcud66fGoHr/7Ue8+AHYvOrRbKcFt3tcGyY/VgMJwzvHVKUW7u7uqfdbn6aF1AxXfhRrav1CEOpQUeFMKzJEsvaYsNQA0HdMrFZf7XqPLzyYtyTWlWwMFT5c9BfxUnF8fGCzqxPx/JZtS5rx1lmq1l/paBP5N2MamNLvb+pJhpQvIUSkONns+oh2tGrIPe/QZUn+ks+aeBVzoYlBFj90/L0MHaFq3FxRNY05wcgZP4v3E8qhJt4zXPPuN+nzvl+d8CwRoUGNrLj5kQcAtdQP2DNLBEGlYeSXm83SiHeXNkWGABi5Qy+hnViKKVsdjnI/5Ln7TP5LLEbczPU0VDuSlkhwyicIettE6w1tUzsVCky6NHYMWWeVudnl2mDehYrZFq673bq111nwdGmMVFwwQ==
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(39850400004)(1590799015)(451199018)(46966006)(36840700001)(1580799012)(4326008)(8676002)(5660300002)(41300700001)(2906002)(36860700001)(86362001)(7596003)(82740400003)(85202003)(36756003)(85182001)(7636003)(107886003)(6486002)(26005)(478600001)(70586007)(110136005)(70206006)(316002)(8936002)(82310400005)(40480700001)(83380400001)(54906003)(6506007)(66574015)(47076005)(336012)(2616005)(6512007)(53546011)(186003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:11:41.9861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c127971-25c4-4417-9534-08db2bb0e8a3
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0971
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTIzIGF0IDE1OjI1ICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDIzLjAzLjIzIDEzOjQ5LCBSb2Ryw61ndWV6IEJhcmJhcmluLCBKb3PDqSBKYXZp
ZXIgd3JvdGU6DQo+ID4gbWNiLXBjaSByZXF1ZXN0cyBhIGZpeGVkLXNpemUgbWVtb3J5IHJlZ2lv
biB0byBwYXJzZSB0aGUgY2hhbWVsZW9uDQo+ID4gdGFibGUsIGhvd2V2ZXIsIGlmIHRoZSBjaGFt
ZWxlb24gdGFibGUgaXMgc21hbGxlciB0aGF0IHRoZQ0KPiA+IGFsbG9jYXRlZA0KPiA+IHJlZ2lv
biwgaXQgY291bGQgb3ZlcmxhcHMgd2l0aCB0aGUgSVAgQ29yZXMnIG1lbW9yeSByZWdpb25zLg0K
PiA+IA0KPiA+IFRoZXJlIGlzIG5vIG5lZWQgdG8gcmVxdWVzdCB0aGUgbWVtb3J5IHJlZ2lvbiBm
b3Igb25seSBwYXJzaW5nIHRoZQ0KPiA+IGNoYW1lbGVvbiB0YWJsZSBhcyBpdCBpcyByZWFkLW9u
bHkuIEl0IGlzIHN1ZmZpY2llbnQgdG8gb25seSByZW1hcHMNCj4gPiBpdCB3aGVuIHBhcnNpbmcu
DQo+ID4gDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBKb3JnZSBTYW5qdWFuIEdhcmNpYQ0KPiA+IDxq
b3JnZS5zYW5qdWFuZ2FyY2lhQGR1YWdvbi5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9yZ2Ug
U2FuanVhbiBHYXJjaWENCj4gPiA8am9yZ2Uuc2FuanVhbmdhcmNpYUBkdWFnb24uY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphdmllciBSb2RyaWd1ZXogPGpvc2VqYXZpZXIucm9kcmlndWV6QGR1
YWdvbi5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL21jYi9tY2ItcGNpLmMgfCAxMCAtLS0t
LS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWNiL21jYi1wY2kuYyBiL2RyaXZlcnMvbWNiL21jYi1wY2ku
Yw0KPiA+IGluZGV4IGRjODgyMzJkOWFmOC4uZTk4ZjYyNjAyMGE3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbWNiL21jYi1wY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWNiL21jYi1wY2kuYw0K
PiA+IEBAIC0yOSw3ICsyOSw2IEBAIHN0YXRpYyBpbnQgbWNiX3BjaV9nZXRfaXJxKHN0cnVjdCBt
Y2JfZGV2aWNlDQo+ID4gKm1kZXYpDQo+ID4gwqANCj4gPiDCoHN0YXRpYyBpbnQgbWNiX3BjaV9w
cm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0DQo+ID4gcGNpX2RldmljZV9p
ZCAqaWQpDQo+ID4gwqB7DQo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHJlc291cmNlICpyZXM7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwcml2ICpwcml2Ow0KPiA+IMKgwqDCoMKgwqDC
oMKgwqBpbnQgcmV0Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+IEBAIC01MiwxNSArNTEsNiBAQCBzdGF0aWMgaW50IG1jYl9wY2lfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsDQo+ID4gY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQ0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZGlzYWJsZTsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgfQ0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgcmVzID0gZGV2bV9yZXF1
ZXN0X21lbV9yZWdpb24oJnBkZXYtPmRldiwgcHJpdi0+bWFwYmFzZSwNCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIENIQU1fSEVBREVSX1NJWkUsDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLQlVJTERfTU9E
TkFNRSk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFyZXMpIHsNCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3Qg
UENJDQo+ID4gbWVtb3J5XG4iKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0ID0gLUVCVVNZOw0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91
dF9kaXNhYmxlOw0KPiA+IC3CoMKgwqDCoMKgwqDCoH0NCj4gPiAtDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoHByaXYtPmJhc2UgPSBkZXZtX2lvcmVtYXAoJnBkZXYtPmRldiwgcHJpdi0+bWFwYmFzZSwN
Cj4gPiBDSEFNX0hFQURFUl9TSVpFKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFwcml2LT5i
YXNlKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZwZGV2
LT5kZXYsICJDYW5ub3QgaW9yZW1hcFxuIik7DQo+IA0KPiBUQkggSSdtIG5vdCBzdXJlIEkgbGlr
ZSB0aGlzIGFwcHJvYWNoLg0KPiANCj4gT25lIHRoaW5nIHRoYXQgY291bGQgYmUgZG9uZSAoYW5k
IHByb2JhYmx5IHRoZSBlYXNpZXN0IGFuZCBtb3N0DQo+IGNvcnJlY3QpDQo+IGlzIHJlc2l6aW5n
DQo+IHRoZSByZXNvdXJjZSB1c2VkIGZvciB0aGUgaGVhZGVyLiBBa2EgY2hlY2tpbmcgdGhlIGhl
YWRlciBzaXplIGFuZA0KPiBkcm9wcGluZy9yZWFsbG9jYXRpbmcNCj4gaXQgb25jZSB3ZSBoYXZl
IHRoZSBjb3JyZWN0IHNpemUuIEl0J3Mgbm90IGEgZmFzdHBhdGggYW55d2F5cyBzbyB3ZQ0KPiBk
b24ndCByZWFsbHkgY2FyZSBhYm91dA0KPiByZWFsbG9jYXRpb25zIGhlcmUuDQo+IA0KPiBBbm90
aGVyIHdheSB3b3VsZCBiZSBmbGFnZ2luZyB0aGVzZSByZXNzb3VyY2VzIGFzIElPUkVTT1VSQ0Vf
TVVYRUQNCj4gYnV0DQo+IHRoYXQgd291bGQgbmVlZA0KPiBxdWl0ZSBzb21lIHBsdW1iaW5nLCBl
c3BlY2lhbGx5IGZvciB0aGUgMTZ6MTI1IGFzIGl0IHVzZXMgODI1MF9wb3J0DQo+IGZvcg0KPiBy
ZXF1ZXN0aW5nIG1lbW9yeS4NCj4gDQo+IElmIHRoZXNlIGFyZSBzcGVjaWZpYyBGUEdBIHZlcnNp
b25zL3JldmlzaW9ucywgbWF5YmUgdGhleSBjb3VsZCBiZQ0KPiBxdWlya2VkIGFzIHdlbGwgc28g
d2Ugb25seQ0KPiBhbGxvY2F0ZSBhcyBtdWNoIHNwYWNlIGFzIHdlIG5lZWQuDQo+IA0KPiBJJ20g
bm90IHRvbyBkZWVwIGludG8gcmVzb3VyY2UgbWFuYWdlIGFueSBtb3JlLCBidXQNCj4gRG9jdW1l
bnRhdGlvbi9QQ0kvcGNpLnJzdCBleHBsaWNpdGx5DQo+IHN0YXRlcywgdGhhdCBhIGRyaXZlciBt
dXN0IHJlcXVlc3QgdGhlIHJlZ2lvbiB0byB2ZXJpZnkgbm8gb3RoZXINCj4gZGV2aWNlDQo+IGlz
IGFscmVheSB1c2luZyB0aGUNCj4gcmVzb3VyY2UuDQo+IA0KPiBTbyB1bnRpbCB5b3UgKG9yIHNv
bWVvbmUgZWxzZSkgYXJlIHByb29maW5nIG1lIHdyb25nIG9uIHRoZXNlIEknZCBzYXkNCj4gTkFD
SyB0byB0aGlzLg0KPiANCj4gQnl0ZSwNCj4gwqDCoMKgIEpvaGFubmVzDQoNCkhpIEpvaGFubmVz
LA0KDQpPbmUgdGhpbmcgd2UgY2FuIGRvIGlzIG1vZGlmeSB0aGUgY2hhbWVsZW9uX3BhcnNlX2Nl
bGxzIHByb3RvdHlwZSB0bw0KcmV0dXJuIHRoZSBhY3R1YWwgImNoYW1lbGVvbiB0YWJsZSIgc2l6
ZSBpbnN0ZWFkIG9mIHRoZSBudW1iZXIgb2YgY2VsbHMNCndoaWNoIGNhbiBoYXZlIGFuIHVuZGV0
ZXJtaW5lZCBzaXplLsKgQXQgdGhlIG1vbWVudCwgdGhlIHJldHVybiB2YWx1ZSBpcw0Kb25seSB1
c2VkIGZvciBlcnJvciBjaGVja2luZyBidXQgdGhlIG51bWJlciBvZiBjZWxscyBpcyBuZXZlciB1
c2VkLg0KDQpBZnRlciB0aGF0LCB3ZSBjYW4gY2hlY2sgdGhlIGFjdHVhbCAiY2hhbWVsZW9uIHRh
YmxlIiBzaXplIGFuZA0KZHJvcC9yZWFsbG9jYXRlIGlmIG5lZWRlZC4NCg0KUmVnYXJkcywNCg0K
SmF2aWVyDQoNCg==
