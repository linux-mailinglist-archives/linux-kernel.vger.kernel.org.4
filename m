Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CB6C68CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCWMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCWMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:49:37 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2102.outbound.protection.outlook.com [40.107.24.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F57C1BAE8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DflmH7vGsYk/PaHiv7tIP9uTgBGDPi/tWCH2kPkw5U=;
 b=ahpl14Z/6ndRla83AkAx+D/xEDKENV4hLLBqti8/CyV7D/roQH85STyFNd1+rZ1Lof+YtYgiz1tROSb99LGV3m5PUh1LgpPB3dZCmlJBVe/L8rtnib7fKodvHfD+SRE7Typ24/TXDNPa8t1FYMbOPghJnhb1JDIBpZpWJPMSbIQ=
Received: from DB6PR0202CA0027.eurprd02.prod.outlook.com (2603:10a6:4:a5::13)
 by GV0P278MB0081.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:49:32 +0000
Received: from DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::e4) by DB6PR0202CA0027.outlook.office365.com
 (2603:10a6:4:a5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT022.mail.protection.outlook.com (10.152.4.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 12:49:31 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 23 Mar 2023 12:49:30 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=d2WYXKl4vXMbhdycIJkzMrNa/IhljnHsuhosak8o/bOnTubZfuG42C8zBlS7K3CWJeJ2MWprmqkCTyGvkLuC5sQEsfW4Te4zfn1VhSzc1hnwfWh43Dosc2DorHpk58y10eG34sN1K+3IWTw7TexQdCS2nPSFtVv8sPQgJh6l3AJziD7iB/aup2RID8z+I3OgtavJZxU4MsL9UsRBTkvcewu/mlTnpQXc+0ywGIwmwGJCuddq9U8t4vyOZ8r2MQD+9uBrsmTCdBnolgxpI1X3z7O0pphc4XFBaXSfHG6muo3BQRzboDPcBwlICuEKUqL7F3sCy8j2x4qk0ZuYcoF12w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DflmH7vGsYk/PaHiv7tIP9uTgBGDPi/tWCH2kPkw5U=;
 b=NM/XhM5ghBoYHai7We9ees4AaBqAPYZXWnn5bPIOPYoIRq/GoB3d/jdWRl7XKn8cJESNADxPWEYBJkWDk+PjELcHc14tsIyba4ZEL0oYfs3vcLGRU4ArrAicSDQAfJXD9fnwSUmG4S7WHrBg0E2Sn9V9PUkqjjBEyBpHTiH5U4l2nyc82Rb+YTf5SsnsasYL9eUJGBqh5IhjyyYhksRzmlUfS+fZq7G8z/xShLEQ3mV3AafuJxx8xzCqDwZ3j2vhfjtE/m05FHL/TuS8fcCSEyvSqvg1geIRWktJ2K1bApz41sEQR1m5Q6SAnCDkeDwM6P0Hy0LHUHeElfK5oh9LbQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.105) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DflmH7vGsYk/PaHiv7tIP9uTgBGDPi/tWCH2kPkw5U=;
 b=ahpl14Z/6ndRla83AkAx+D/xEDKENV4hLLBqti8/CyV7D/roQH85STyFNd1+rZ1Lof+YtYgiz1tROSb99LGV3m5PUh1LgpPB3dZCmlJBVe/L8rtnib7fKodvHfD+SRE7Typ24/TXDNPa8t1FYMbOPghJnhb1JDIBpZpWJPMSbIQ=
Received: from DU2PR04CA0305.eurprd04.prod.outlook.com (2603:10a6:10:2b5::10)
 by ZR0P278MB0872.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 12:49:28 +0000
Received: from DB5EUR01FT083.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::85) by DU2PR04CA0305.outlook.office365.com
 (2603:10a6:10:2b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.105)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.105; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 DB5EUR01FT083.mail.protection.outlook.com (10.152.5.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 12:49:28 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 13:49:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjlKrDVLNTvfWpCrci8mG9Txce3dYex4gnXC3A9hlPCTICy3SWXdJ0CKyWuk+57ACMqn7V7ZWjhiZybTOwaFiK66aNPyOkskkktuLNlrMq2lgt7Yf9D7TctE/HkDQ8OoPjOse4n9I2xJB6cyCNnWcnGTQONnCSaJNxBfIeeByM7tKvnbSUTbdBV4bPvTC4pOtcHqfl+ShBGVn5MWQsliu/Cx5sQXArd/JXkFeHk3hDqjDLwEHAYcuMxhPSjt8IGDhqTtHdCklsiJ/+yNxNNRj3pO1HHqyG8RanqC7C34ybdVqqADUhVVOZEscLUntfrikrFQZwLwqGbTIZE4bg6Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DflmH7vGsYk/PaHiv7tIP9uTgBGDPi/tWCH2kPkw5U=;
 b=NFrht+8OOtf3Zw2Oh8KNSYNUENqRSG5cALuOqWjQxPXN/spS7EkzkO8WHnka4w1CaDBahWWsaxQD7S8lBg6iuO4i3vNcJEscBihdn8eIbbVJKR98Bwflm0iLm48A1vs7s2eqq4OQ7aTlY+jA97HREIOEHKTblvVHY8J98gR0Wk85Psc0dRp1yyV7ESyEHLs0dsKrWDtqHz5inqlPWJ32P0IpaFmARTXctbtP5aA7ocaRdYSyw1eUfBOiRltgHawkPih6ZpJKiTPVH5RPrX7dplnf9LhqwbGsxMXJODb6QAbCer6uAkqJYglj8vpf6YRSVxLSuj5aTEormvUwtW8dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DflmH7vGsYk/PaHiv7tIP9uTgBGDPi/tWCH2kPkw5U=;
 b=ahpl14Z/6ndRla83AkAx+D/xEDKENV4hLLBqti8/CyV7D/roQH85STyFNd1+rZ1Lof+YtYgiz1tROSb99LGV3m5PUh1LgpPB3dZCmlJBVe/L8rtnib7fKodvHfD+SRE7Typ24/TXDNPa8t1FYMbOPghJnhb1JDIBpZpWJPMSbIQ=
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4b::5) by
 GVAP278MB0796.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 12:49:25 +0000
Received: from ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a]) by ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d496:75f0:4c13:de8a%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 12:49:25 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH 0/1] mcb-pci: fix memory overlapping on MCB devices
Thread-Topic: [PATCH 0/1] mcb-pci: fix memory overlapping on MCB devices
Thread-Index: AQHZXYXlKQbzhfxXZ06xT9vDRulROg==
Date:   Thu, 23 Mar 2023 12:49:24 +0000
Message-ID: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: ZRAP278MB0948:EE_|GVAP278MB0796:EE_|DB5EUR01FT083:EE_|ZR0P278MB0872:EE_|DB5EUR01FT022:EE_|GV0P278MB0081:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d61abf-bf55-4699-08e0-08db2b9d0c65
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YusgxJQLESkJ+ttdJNEo2Afu4l81kNalRjqoA6NBsUBeCeCN4Mggo0dCO9utExQlJ55UBpsymq2BRSvRbAnrUrVJLlSmmWIQCSX4MyYfaCcoOEDW89V2bVnZUvqgLsOdtJYLNdZx0OBO4YiqWykuyt0C0oVtrNEszfYWCYvrpkZ9vStlUfkENXwgAvyocmiQYJXnztE9qEXz6htgVwInqs2sqSwUGglxMrj24P3Jpesinpj7M5MRWU9vLGTpDVAh+OU9U+vuZA0skATprVXKmtwQBHoqF4PhDln04NtEyOrZ+86vDEy1edLBHWaLws30SQDRZd1kZRGyKKQ1ZalZ6OXMXbHQN+MhmDDcGoM2q8Al/yLt1uCQJtZf6yC3ZZ5qoeLBKxb78E8xbSSaU+309MOqnI5ZRR64/ziEwRHXiQSqoe98443T6f3AmNtUF9agG4/Utrei/98jbU0qfSnA3+ve8R5vgpUNtqH0NDZvmoUTZbW/VfTcU0Gp4G+Ubhpkw4TwhVSxnrlja+KwS7P9Ki6pYt6e1f4FdZyBYosrpJYNd/HdogX1NRdQ3wwejVwkhEpNZKDy77XuturJ8nR/4tJydWJLer4kZU+D34aKunpf9YSZimW9e1TuTlE4axBYRlA5DampT+MA7KvQmewGu/9PMUQk0cuYghpeuPRzshmSod/VzkpsS4xt3oaB0zBvTbu7EN8DwphWsc64Y58bZw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199018)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(41300700001)(8936002)(66946007)(5660300002)(2906002)(38070700005)(86362001)(36756003)(38100700002)(122000001)(6486002)(71200400001)(316002)(76116006)(91956017)(107886003)(6512007)(6506007)(1076003)(2616005)(478600001)(110136005)(54906003)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0796
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.105];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 792af1b8-68a5-4809-adcd-08db2b9d0831
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GAG/z6P/jKGS5YDLM3ZPR4rbmMQMh3o9BRjfNfBfFXfld4C852wOhYuenNW6xK09isliNARdux+c562oYgCyguk0Lsib6qBwZYr6yPJKb6Yq0Rig2jfA6tI4IRgLhgsr6WUcreb8rML+8ICMBTyqWADSKFYJ2fL8HCFSdPi96rj6DIU+IibgmSokgnyjMvua+I9QwK+pOmyVlgj1IT36fctk+zVXMxPSJ56bz877kGSXJWBzv1vtmRE16T9UNsMvyukUeTQVtZ+q8XsmOf1ehpG7FOQjk2+czJqqHd1mBmFaII1xxIdyGGDpi3CFSVoN6rA9frQTOAL9SIxDaXg4ep9BsuwqTPAE+PgAKbqzmaGjvshVnTXGmDd9L6iacIxMSdP2SsfGBYLEhtkXxvXi7EAjrjhzSamKx4dds1bmYuWmKtcq35IrGsH9s6MAMKTSEIe4A9D7GKfREJmPHva3ZWRU4Us8qfHTBTIQBjT+e4Xepcut2Dn4rpkJaQNTdBHyxCcDMXXq0tnABKJi1yLTQuyqhPYbgvl17noTGVWCUrpIf4J1FUG+OHZ9gB/fgz5yD4VFT8B5+R9DQzYsDH1dWPcHNVro4av47Nx0IoeL9G39DnIs1uJUW8Abj4r4D8bk63Mr8xRXBL14omdD3ZPMgP9qcz1bh0GN950ugTocMfsP9D37vlUYnTnlDEQvyE4gqv09hTayrusgNXt54q4FHrlHHwsVh92QjVC3ltk0fYzns2Yk2ANw2wGmhawlL0o3fwsjZDsZv/45C5hQ8ZyF7tjHuUt+bpiNE2nXmi5RT2aLbRO5zMcFXjmuRfZtYXRpOnqegGWt/T/llXVePSBrxQE1aO/tJWJNIVi8voEzEqC7ow+hLFrA1NfIWs2vrN3v
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2105.outbound.protection.outlook.com;CAT:NONE;SFS:(13230025)(39850400004)(396003)(136003)(376002)(346002)(5400799012)(451199018)(36840700001)(46966006)(8676002)(4326008)(41300700001)(8936002)(5660300002)(2906002)(34020700004)(32850700003)(82740400003)(156005)(36860700001)(86362001)(36756003)(7636003)(6486002)(316002)(107886003)(6512007)(6506007)(1076003)(70206006)(70586007)(2616005)(40480700001)(82310400005)(47076005)(478600001)(110136005)(54906003)(26005)(186003)(336012)(83380400001)(12100799024);DIR:OUT;SFP:1501;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0872
X-CodeTwo-MessageID: 00ba1965-ea16-4d24-a0f3-6ea58d1e0d96.20230323124930@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5d3be9f1-d402-4d04-4b48-08db2b9d0a2e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n59YaJMXnLTaJFp3gMGOEtLyzvC/lMYSBDjMukqEp5LnKuMBhJFQqkM2NGmXIozvUXWXzBAlaZX7g+rtAZUJE7X5XjVqPCFkXZz1NAeXzni8Oyp19dp2//j87sLg+tAmE6VTlbRNZLCXRElYXEWjGKW6P6+OAGUvPwdBwPJgLOT4XXP1lFZ6Wl9lQab49j3MzMyrx56Z9hV24k8G95iTp3KVHjDcCeWNMjFPdVu/qd1+mrjzjiM24AtlyqXfFBzZfXt53WwG/MeleCBI2NEVsPsWl3N14As0ZWazOAa45d7Y+H+ng2dGZ6U5QnbNkLgU/tlxxE+Ye2H69APeRXqhW4j7zZ6YzI1FW/O4hxTmQfDRb46cbkzafZ/Ikf85EaDjvAFB2FxIJJlKDdQrNbD65B2oe9og2u4B7EP/U6B4q3cBrAoqno4WsV76VMY0P8ZqHcYw+H05RrG2TMxdllhNNRoPBh9Qun/7GQlbQ1jtgdbPiReIJTWuzet775My+mMRneXYu5Go3FRmI69icvRLwJgdv/6DdadHE/sMvKUcxD/HUN0aFfNE/phM9pR46a22fmIRqTmczATzKxLdJ7FDIUedX3QOMLccthg43ISZULbWfgmLr5TLmj+rcrwHBmVcVF0ZqC1tr8TTt8MUONmPW20GXCtrz2R9kRSRAWhI5Fw=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(346002)(39850400004)(136003)(376002)(396003)(451199018)(46966006)(36840700001)(54906003)(41300700001)(110136005)(86362001)(478600001)(8936002)(5660300002)(70586007)(82310400005)(70206006)(8676002)(4326008)(6486002)(316002)(2906002)(7636003)(7596003)(107886003)(6512007)(6506007)(1076003)(82740400003)(26005)(186003)(2616005)(496002)(36860700001)(336012)(83380400001)(40480700001)(36756003)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:49:31.9927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d61abf-bf55-4699-08e0-08db2b9d0c65
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT022.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0081
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-pci driver is allocating the memory region for the "chameleon table"
with a fixed size of 0x200. This region is only use to do a initial
parsing to discover the devices implemented as IP Cores.

If the "chameleon table" is actually smalled than 0x200 and the first
device offset happen to be within 0x200, a memory overlapping can ocurr.

Here an extract of the memory overlapping when registering a 16z125 IP Core=
:

[   31.016972] 8250_men_mcb mcb0-16z125-0:0:0: can't request region for res=
ource [mem 0xa8200100-0xa820010f]
[   31.016994] 8250_men_mcb: probe of mcb0-16z125-0:0:0 failed with error -=
16
[   31.017010] 8250_men_mcb mcb0-16z125-1:0:0: can't request region for res=
ource [mem 0xa8200110-0xa820011f]

And here, the memory allocated for the chameleon table parsing:

user@host:$ sudo /proc/iomem
...
a8200000-a82001ff : mcb_pci
...

This patch solves this problem by not allocating the memory region of the
"chamelon table" that is only needed for parsing. Just do an ioremap instea=
d.

This patch is based on linux-next (next-20230323)

Javier Rodriguez (1):
  mcb: Remove requesting memory region to avoid memory overlapping

 drivers/mcb/mcb-pci.c | 10 ----------
 1 file changed, 10 deletions(-)

--=20
2.34.1
