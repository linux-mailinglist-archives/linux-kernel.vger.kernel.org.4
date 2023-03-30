Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716196D021F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjC3Ku0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjC3KuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:50:14 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2133.outbound.protection.outlook.com [40.107.23.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9388F40C5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLnVEeIGFmJd6FPITdJFHhFod/XGqrM1sCgKxr0mahg=;
 b=BAFt1lSQQiNRtFshHvkV6QTJOIMphjefOxf0YGwFnpDn7VAizOLUhLjvEN+KoTUIjkOe5Aczs81K6njDXurzpj68yu7ln34Jn8VLYPlEAsEghjKatXi3eeT5iTvfikUvkvGCEJhhxnHH65z/fzIKjZvvPQTj1OeX8kb4S2rg2f8=
Received: from ZR2P278CA0061.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:52::19)
 by ZR0P278MB0872.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 10:50:09 +0000
Received: from VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:52:cafe::8a) by ZR2P278CA0061.outlook.office365.com
 (2603:10a6:910:52::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 VE1EUR01FT060.mail.protection.outlook.com (10.152.3.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 10:50:08 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.108) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 Mar 2023 10:50:07 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OpqTWSdOHwQPagfFwL/RFHusgjbQFSxkvyip/SWOfpQ6CF/+jRaX0O6xOLf9qnRIUUsxJbPXmsMZpnQMjf/WxSyG/+azG9qnbRi/u/zpqr4rxdCMmqhv8Bqk92F0Qzx6B4T1LxvXt09xRpZTxoa+TFNe1qZZOriZtU7gGufzh81xfDcOX9wMCaRuHkmdlQSVibT2MaAF8RPhCK1576p8/7fXKfHQuBotAFwG5KXZ4UQmemyKvzyRaCBHcv5nVscZDbsrje+gpbxsqVj7pvS15BnYfUGBlfV7OmnDj6O3gYMULQyrA3iUBIYwXGUNmxYhB3QbGPPcK7xbeASgbgoE5A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLnVEeIGFmJd6FPITdJFHhFod/XGqrM1sCgKxr0mahg=;
 b=Q+IyD3BWNMHq+K83kRsIAOdy3Y+zJKjQd9HSjNJrxgtnR+dGQALjf4d1XCGGW7TFncsU+jyc3SsA2q9KJ4vyckXpv4TMttwE2+oNl3JjOBib5aVfnf4Cw7LjGmmGKk8JYBS8mBSbLpKRlLOFVI88cqQm/ZlopoOVL/HRl7cvmyXuTEQf0PS3Akv4DDoAW8L3H5SXzk33gXyUwh/fyfIrjpekQE5BuRmQtlGsTcwqtMR/WpDzy/AuWfnYB003FkjUfXmi8GmW91vzgZkCWepC+1C58/NTGh9drD2LxgX6Zac2Evsirin6yeDljYL+MQRdAs2kMIg3uLPXH0NCUWjsqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.40) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLnVEeIGFmJd6FPITdJFHhFod/XGqrM1sCgKxr0mahg=;
 b=BAFt1lSQQiNRtFshHvkV6QTJOIMphjefOxf0YGwFnpDn7VAizOLUhLjvEN+KoTUIjkOe5Aczs81K6njDXurzpj68yu7ln34Jn8VLYPlEAsEghjKatXi3eeT5iTvfikUvkvGCEJhhxnHH65z/fzIKjZvvPQTj1OeX8kb4S2rg2f8=
Received: from FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ab::8) by
 GV0P278MB0081.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 10:50:05 +0000
Received: from VE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:ab:cafe::86) by FR0P281CA0181.outlook.office365.com
 (2603:10a6:d10:ab::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.40)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.40 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.40; helo=CHE01-GV0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT107.mail.protection.outlook.com (10.152.3.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 10:50:05 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 30 Mar 2023 12:50:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAG7ZTxVDnSNWxPNfGTxeM7Gj9t5mDgVXmg+JQ3lAg/hH87JDmrCkgWSoRGW9FsDkbf5s+Io7Egnx0L0aMK9QLZLopI2ioVt1U6CRo21cuwjC3fsKle3UDWn8s5OdUWmeAW53836CU6GQKdvB2fnnqx0W9mghEGhIx1/YYo0DutpATfkOMo9JMptUvBRXczByv8c3nmp8AC5Th6ly7hFveQeOqwsHtGLD2StNUb85bVpwawncMpHBreOQJTlQda9uhCwfv15Q2jt6bMwT2gKAtfqsl3AgLffVJ/PkKBpkAGnfjkyshHG0VDjEPUdMTjCfajfYG3PRzwIPPEPIjMEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLnVEeIGFmJd6FPITdJFHhFod/XGqrM1sCgKxr0mahg=;
 b=IS9GuVDVZfFoBuoZ9TI+4YowBPcJ4WFU+fdV8Dwqcp6dmdVsylxcPr5GaT4rakljVk2BZcjfCacXYspH5ITbs4tbrtNFMteuB56z1bDPCM8ZQJRYVUf2fh49TlQEenbMCNIKwlLaoc+oAhiJ0dXMpqrNy/5TqJQz2zT5X9gJDHstl4YVtoNyF3IGMQEvA+oJPSNr8RYr52FIbvTTa8IT8f3OiW3MzsD4+IZfuO2Ys+WhEIqPbVjqvl6Vud/+RQuw9n+p3K2UHUnuNYtl3XYJ1eU8tCT2XLXay9zI428xmEUv64jXKsY+HEO1/KE11FxvpeiMksLuckSNf2zQqq+mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLnVEeIGFmJd6FPITdJFHhFod/XGqrM1sCgKxr0mahg=;
 b=BAFt1lSQQiNRtFshHvkV6QTJOIMphjefOxf0YGwFnpDn7VAizOLUhLjvEN+KoTUIjkOe5Aczs81K6njDXurzpj68yu7ln34Jn8VLYPlEAsEghjKatXi3eeT5iTvfikUvkvGCEJhhxnHH65z/fzIKjZvvPQTj1OeX8kb4S2rg2f8=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0741.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 10:50:02 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%8]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:50:01 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 0/3] mcb-pci: fix memory overlapping on MCB devices
Thread-Topic: [PATCH v3 0/3] mcb-pci: fix memory overlapping on MCB devices
Thread-Index: AQHZYvVgBQRzpjq/6UytHW0GteYdvQ==
Date:   Thu, 30 Mar 2023 10:50:01 +0000
Message-ID: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0741:EE_|VE1EUR01FT107:EE_|GV0P278MB0081:EE_|VE1EUR01FT060:EE_|ZR0P278MB0872:EE_
X-MS-Office365-Filtering-Correlation-Id: 290f597c-e4b7-4cab-02a9-08db310c87a8
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k72hEauuG9CCf0e7OzSYIYSav3kIAx/z8pPJAAfNlz0i+xXpF5iWI/FOm20m5JP4u2oOhDSvNVxS3BTk+5nyq+NnCgDskaR3t5OZvO+9TMzULQntXp2lr9eXyrU96WLlirZPOCy+jcm/6alir30k96i0bs0uWgP3iTwzwvJS9ONHu7hr4f1FqGS0sh8pQnwKiS8jHmKYXak2Y6zEpCGmxi99Xt+NhzbRDfUBnAS15GUWunVqLv9Fq01qQwO9kUYDyMap1B3PawpJwj2ib9QkJlj9jZ+TQRtw8F3eNUNlFu0TfNBSySCe2Fg1AyqKCBfwV4JxwxJ35L3ZOiywkkBSnuI0Kur1RVed5ren760OmTLQIPoDYu9T+7OPlgSpNTR5yefQZ06P1lzP1MZsVGYyC9nByTprPBxNK+AlRF0mq9BBHnzbj6FQFwpom9/cw4Gtg6OKBIF1u+eEDMZjxST63qDsJO0+6VDTSNd9QIgOAcLMT6EFwmZ+xn00juBOzfPoB+zZSSlMJ1tXFnWfsYNF0Bq2acCFzywCXD39U6FRcsXnT5aBjeD7jvP8XiQ5GY36M/zhWBpcnezA3tBP5Xlb4bAurOQZFVXxAK7ehtbxMN9WmrfFH+q51SCvpUVe33Y2
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39850400004)(346002)(451199021)(83380400001)(2906002)(5660300002)(8936002)(36756003)(38070700005)(38100700002)(86362001)(122000001)(6512007)(6506007)(316002)(64756008)(66446008)(54906003)(4326008)(66556008)(6486002)(8676002)(66946007)(76116006)(66476007)(26005)(91956017)(186003)(1076003)(71200400001)(107886003)(478600001)(41300700001)(2616005)(110136005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0741
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.40];domain=CHE01-GV0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8000ec28-19cb-43c8-eb52-08db310c8335
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5yxrVyOJIcnf84YxplzHTe/PwhfQKM+kLMNQJbI/Ybrb6v58cONZfhWFBYS+uIuXgS+wyPOPUkXNqwxeX04tyAN7n41VoQp8Hs3sBYjIvvx/JJMbL1vvWR9NPEKdJnvM1hMSiLKCUHPymSc+XlqeAyBUg1TUJIVfTHKVwC/P4xWpa8PURkSSQGMz1KuL7jx12pyHi9JXYEXcyEIJn0isAK2bj9FYGyP2ZXY+OTtu+io4pm7WWhhRllG8o8xdwQCO9ImhiVy1gPa8QDwbQNTwIKCZQc9TUoQ+hOuCoAbpVhVw4atJsnsLV2xJ0Hi3qDRSKlM1FT0x1MIFga8nPeNCgu9h9Gj/ZSoTP/swyFz2ZP08KRbuc8sHesg1RM7r8eiYiB/hZzhOeWeQpRPsSPiopkeAtqvb0t2EVJ7wAlabGbZYg3I5Ok6eiDJN0fgI1nkZ2tJrVFFctrGwhVb7IEXu0LJDjyAV2JBoKaL0eIHz6yesDiDilg4xTxf8gjd8dqmTqDq+Z/n88Ey44FQAUMVKnnTlnlsvUNtuQvQhxdaSMXSE5LxntJpQEdu2k419oMTPZ0hObFpx4gRswA7CgTwc4qOjSqjWbGaJ+2oTxbT4zKy/ph7mhcFp1L09K80B6ElWqNd3NhxmFfyGTWEZYX6yJgbyOccZVoXCjXd40/R+7U5TGAyJQV2PBPbuvsASV6F4s26C05ZtXnSMEpCBi7JI9TvAXpObRW3fpaM4ZChMNP3yiD1cpRwGrin5ZC6sCm4aOiIqSOhChgSoEz2x7QpyKSuNwq5/Z1miT9yCx+iSMbIXnmXOU4kbqcd4Cek4EQQA
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-GV0-obe.outbound.protection.outlook.com;PTR:mail-gv0che01lp2040.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(396003)(376002)(39850400004)(346002)(136003)(451199021)(36840700001)(46966006)(40480700001)(316002)(70206006)(156005)(110136005)(32850700003)(36860700001)(70586007)(54906003)(5660300002)(4326008)(8936002)(82740400003)(7636003)(41300700001)(8676002)(186003)(83380400001)(47076005)(336012)(107886003)(6486002)(478600001)(26005)(6512007)(1076003)(6506007)(82310400005)(86362001)(36756003)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0081
X-CodeTwo-MessageID: 56c78edf-5b03-4b54-9025-43f57628988f.20230330105007@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b3de307-b889-46c9-12b8-08db310c859b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2B/3tJtrJDHk4PbJ1HUVecvmT2u1M5U6WACHzfKr4TDyrF7zG90LEQsFJ3L5Q73Zja9fnGw6uaUfrBbjZsGuuRPQ4UU5yLgsNHq7YqdFshEEW7yHbNznOh6wMmeWtA+Na6s/hCXrHzUyRCi4/aEJNdmyVYdB7JrRmwTlTAIgbpKwBJdxlMiyXJcNXcPgpoozYZXIlTiwy0mHcw4oVeWAsR6ii7umo1fOmcdE64hKrMSnTNl8/0M4sfmAnnNDYIM8imMJMXhQDkPOHBUGvlns3vvG2OcUG9O01Ck7vhuWJ/2XSgh5CVFTBmsB3zz5Y0TqlfUhgds2bruBrK9LmXXXkksv3OXs7owz40Wp1pvcDaYscV/fYpRPsTAsC+xj+4Qknd4NvMYlL44LwWoalRr9geZRES2duD+9d7NqAcUQqgNfZpPv6L+Q9VlhC/OzeExBwJwpzVTpXOwg/UMeJnqDOygL0EgGChl8GEFk1KxggYZ+Nj5Yo7woryC/CFieVbDoozRSahp5Zes5sXC+O7+SkOE0sK9qX8K8vC8erYcqu/vww2wCchDlwdr2x7/mBd3JRmlJsmwm8Lkb0GiC+wfHQWMHMReuAvvHtMhzQ5boesTvQlN6CwRTlT2s1OPJ/kSL3rbBEQbtOa+wlqnQr/d4xgH/yX4E5/jjEa6mlpGAV1Y=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(47076005)(36756003)(7596003)(7636003)(8936002)(5660300002)(82310400005)(4326008)(70206006)(70586007)(41300700001)(8676002)(86362001)(82740400003)(40480700001)(6486002)(36860700001)(83380400001)(336012)(2616005)(1076003)(54906003)(26005)(6506007)(2906002)(6512007)(478600001)(107886003)(186003)(110136005)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:50:08.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f597c-e4b7-4cab-02a9-08db310c87a8
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0872
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

This patch solves this problem by dropping/reallocating the memory region o=
f the
"chamelon table" with the actual size once it has been parsed.

This patch is based on linux-next (next-20230323)

Changes for V3:
 * handle return value if no chameleon cells found.
 * remove stray newline.
 * reword typo in PATCH 1 commit message.

Changes for V2:
 * make parsing function return the size of "chameleon table".
 * reallocate instead of not requesting the memory region.

Javier Rodriguez (3):
  mcb: Return actual parsed size when reading chameleon table
  mcb-pci: Reallocate memory region to avoid memory overlapping
  mcb-lpc: Reallocate memory region to avoid memory overlapping

 drivers/mcb/mcb-lpc.c   | 35 +++++++++++++++++++++++++++++++----
 drivers/mcb/mcb-parse.c | 15 ++++++++++-----
 drivers/mcb/mcb-pci.c   | 27 +++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 11 deletions(-)

--=20
2.34.1
