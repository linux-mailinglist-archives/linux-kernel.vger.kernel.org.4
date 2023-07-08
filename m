Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80B74BE19
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGHPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:19:40 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4DE6E;
        Sat,  8 Jul 2023 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RprtSTj84Jppval4+sMvFNcZUsPsluDyfsFW8/vj7ko=;
 b=U29B6L8qrmhH6jLMHv4DPmkXZnigpjktpVsRLx0Mb30Nn3Td9vnu9h2thYuZRU294rvn/4PboRux3kQtnrelSgqU16ee21vCiAuCR2YKQhxyw8kIYgM8vTEiDNqNvc68xXAFs85xSLzduCVrV5SnL8gQE6ZOj7SOtL5LU3ABseg=
Received: from DU2P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::11)
 by AS8PR08MB6360.eurprd08.prod.outlook.com (2603:10a6:20b:33e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 15:19:36 +0000
Received: from DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::87) by DU2P251CA0002.outlook.office365.com
 (2603:10a6:10:230::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Sat, 8 Jul 2023 15:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT022.mail.protection.outlook.com (100.127.142.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.13 via Frontend Transport; Sat, 8 Jul 2023 15:19:36 +0000
Received: ("Tessian outbound e1fdbe8a48d3:v145"); Sat, 08 Jul 2023 15:19:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a1c1579477affba5
X-CR-MTA-TID: 64aa7808
Received: from 564c96c4d874.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0592F865-FAFD-4017-A535-898F071BA315.1;
        Sat, 08 Jul 2023 15:19:24 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 564c96c4d874.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 08 Jul 2023 15:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuY+lBt9yL+iAY0F9njd+HEEnP7zlo7C+0gsARl9M4+gMbkMflfU4BXjmbNACykYLQnbDogq/JEC9AFdYy7PLsmTbIn+BzaQZW3J9RQjg1ZB91XyWR2XBZ2/lnu/XwqHxylTU4LkTNNykrzTzVOguzK5NJO48eIvMq0Owx+4ux3ZT51QUM2N4GuVjtNSGKWVPbgiZKEeljd/vyQtQg/IbJCGfLk1jLrxPYGpampDVtLUJiLp+9k9eITn5gGTkKIA1ZLIQVGCfGdhHZeEH35fi2sKGsX4Psh5OSBNQLpnARGTTBV8jm+df6LiU+j642bmMlhpzDBefojbJf3CrVlvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RprtSTj84Jppval4+sMvFNcZUsPsluDyfsFW8/vj7ko=;
 b=XCJ80XEsrOudTQNnNym2eD+0EQ7QyM1QZJQ9855cf7R6buLXbgIIr09mUbsXJ94Iv58zS1GcNl9pECSMXIeWvZ5OomMZlA8oV2YufxTIpXg7kxZTpHI6lAtn2lBUAjdvm/0hOaxrvvJM57nLQmBBK8hdY0GIagHgAkIirHh3nS+5Js2UZggeiARk01AFez5czqPjVZ2tqfKQW10pUzvOcaH3zdoBcoZJl0pr9dhy6rMKGDtOwxUAnMO8UwBKtKgR/Z2GI3MnqFlFSTQUtKXSKz7ycpYAkdeoC10UuZKXm7qTb224pURbT8a1cqzRyYIzt9v86X2BP6GBpV5jXmm5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RprtSTj84Jppval4+sMvFNcZUsPsluDyfsFW8/vj7ko=;
 b=U29B6L8qrmhH6jLMHv4DPmkXZnigpjktpVsRLx0Mb30Nn3Td9vnu9h2thYuZRU294rvn/4PboRux3kQtnrelSgqU16ee21vCiAuCR2YKQhxyw8kIYgM8vTEiDNqNvc68xXAFs85xSLzduCVrV5SnL8gQE6ZOj7SOtL5LU3ABseg=
Received: from DBAPR08MB5783.eurprd08.prod.outlook.com (2603:10a6:10:1a3::7)
 by AM9PR08MB6307.eurprd08.prod.outlook.com (2603:10a6:20b:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 15:19:21 +0000
Received: from DBAPR08MB5783.eurprd08.prod.outlook.com
 ([fe80::5a38:5c71:d11c:ff30]) by DBAPR08MB5783.eurprd08.prod.outlook.com
 ([fe80::5a38:5c71:d11c:ff30%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 15:19:21 +0000
From:   Dong Wei <Dong.Wei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
        "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "yc.hung@mediatek.com" <yc.hung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng@mediatek.com" <allen-kh.cheng@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tinghan.shen@mediatek.com" <tinghan.shen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "weidong.wd@bytedance.com" <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Thread-Topic: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Thread-Index: AQHZsMt6oQDhpieW/0S8k7EFY2ASWa+uQuoAgAAyxACAAALggIAAARfggAEV2oCAAG4Oag==
Date:   Sat, 8 Jul 2023 15:19:21 +0000
Message-ID: <ED8788D4-82D9-4B60-88F5-0FA5F00E4A36@arm.com>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop>
 <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
 <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
In-Reply-To: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBAPR08MB5783:EE_|AM9PR08MB6307:EE_|DBAEUR03FT022:EE_|AS8PR08MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: c4435dce-9bf6-4ada-529e-08db7fc6bd69
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: j/p4/gn7GGV3bp3kOZPTNlr8obNEIskDaEOQM0SWrRhZWU9kWxXhNZgq1J8Svx2aq7adF/fD2UnHHkgwPsLs1E+YH/A/iMrvd4EgzZIAjyuNi8QyBSUk/CuxFdCiHoo/xSXYJNv8dVRXuSmCsRUsJnxnZHewQx88m0mY1+sqGHckHDFWoeCHRRmMJaO8hN/Vshc7w+fjKY7JfZLux/C280t4UyYKXDGgD/zbPhDn/zNva1puF8P4i7UU6bYd9K9JHcnxtyqaRl7DxpGhM8/Pmli2v90WNRWl0NT+uwa9K0iIE+9EIA3BRGRSNifrzT8Z/72Dyyrwp6bPu6QvEKiYY6IWcZhYXBOHkjQNSMc0IFyEiZdpQTHtmQTLLKZY6aLwQh2CtiaX+Gxqmk2pL2FdEOXn1SwqnqDoelb8nBj0HzTBUWZficLXFnkj/O/DgOjCd7P0rEQ+iLy2wra+QaW0AfW0n5s1Gyk6l0MrNTtyHXGuNXmKQ3xPqXDpUecm3SCudji3jUqd9JluAygY/4VaQDbyeQUUG2V8l5nNrt1Q8h2ogURgumG26OZCZFpS4yZKmQmleLwKeH4FJIJoOkupEbkyAdtVePtn3czStatHl5KPsEsbMLudoZybOAZGrNZBMiNk9VpJQOyV2nO/3wcCLA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5783.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(316002)(2906002)(7416002)(8676002)(8936002)(5660300002)(38100700002)(122000001)(53546011)(33656002)(26005)(6506007)(86362001)(36756003)(38070700005)(83380400001)(2616005)(186003)(6486002)(71200400001)(76116006)(6512007)(66556008)(66946007)(66476007)(66446008)(64756008)(91956017)(6916009)(4326008)(478600001)(54906003)(41300700001)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6307
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58836ea1-5806-4157-ea2f-08db7fc6b49a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgfoMVzib0vpKjonutT6JU74Fippu3RoRPnjVRdvYIQXY9061Wxras2DdWYyT1kQC8kR0kJiqbR9ik4ZdCvsz9T8fldsP3uHQrKXKhQkdG6Bi4HDXIQ0k0JOn19TMc3Gvj5HePLMzYpFeyrSPdsGa2uhuUK2ziLqKUA7jn+aZgjnkWYY7l3a54LamvUuibFsTjGOpY4mJqFPD3apGsxvC57blzpMLdq6OpgeaN7zdKksEvlqPvUl9yai7t8j9gK2qUntujHVmp9HJhz/Vw8Pb6I82mvNoqYqKW7xhRj+WjmxEzTzdhR6n77hAcg4aUFYid8PEaIXJetbZ4qwt7VKS1EO1MJOOH7oqtIZb//jg3VeIw85cjvNblvctYbZH6ppVYYthjemrrq6DqCSa5oPbxBRMLjmFny35bJN2yoF4wcsPSUVP3MjTRfK3Z7WG3D2pEO3GzRyBIw0332/JlLHn28GqbJDgJLaTcLA1CNGcBKM+S+P9rtpNdHppj0uqVdeFWONldtHWbLvzjR84eo0jnH9oYJek1MVAn+38YYtpsxAD0w2x+DcaYu6jJ65YLlnAnuKHvu+srUzR2Aoth47Lncjk09yIdi5pR4vE4EmrmCQ2S77KFdEBKCz8JZLP4MwJra04NUPTXC8jHCH11UmF7cVOPqtAH4rWUIFCA+8Jfy2M46K9pQw39eMuj+Ypf/IO1JhVMyrEjMfK6Z6Ay5cPbILhEuyisZBORTEu34p2qT5B0B/Mg9s7W5jGah6WwS5
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(450100002)(40460700003)(4326008)(70586007)(70206006)(356005)(81166007)(82310400005)(107886003)(2616005)(86362001)(186003)(53546011)(6506007)(26005)(36860700001)(82740400003)(83380400001)(47076005)(336012)(33656002)(36756003)(478600001)(6512007)(6486002)(40480700001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(6862004)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 15:19:36.0949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4435dce-9bf6-4ada-529e-08db7fc6bd69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6360
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkLA0KDQpBZ3JlZS4gSSBwb2ludGVkIG91dCB0byBOaWxsIGluIG91ciByZWNlbnQgZGlz
Y3Vzc2lvbiB0aGF0IFVFRkkgbWVtb3J5IG1hcCBpcyBhIHByb2JsZW0gd2l0aCB0aGUgQ29yZWJv
b3QgdG8gTGludXhCb290IGFwcHJvYWNoIGFzIENvcmVib290IHRvZGF5IGRvZXMgbm90IHN1cHBv
cnQgdGhpcyB0eXBlIG9mIHJ1bnRpbWUgaW50ZXJmYWNlcy4gT24gQXJtLCB3ZSBkbyBub3Qgc3Vw
cG9ydCBFODIwLCB3ZSBkbyBub3Qgc3VwcG9ydCBzZWFyY2hpbmcgbG93ZXIgbWVtb3J5IGZvciBB
Q1BJIHNpZ25hdHVyZS4gVGhvc2UgYXJlIGxlZ2FjeSBCSU9TIGludGVyZmFjZXMgdGhhdCB4ODYg
c3lzdGVtcyBhcmUgc3VwcG9zZWQgdG8gbW92ZSBhd2F5IGZyb20gYnV0IGFyZSBiZWluZyB1c2Vk
IG9uIENvcmVib290IHRvIExpbnV4Qm9vdCBhcHByb2FjaCBvbiB4ODYgdG9kYXkuIFRoYXQgaXMg
bW92aW5nIGJhY2t3YXJkcy4gSXQgaXMgYSBrbHVkZ2UgcmF0aGVyIHRoYW4gYSBzb2x1dGlvbi4N
Cg0KU2VudCBmcm9tIG15IGlQaG9uZQ0KDQo+IE9uIEp1bCA4LCAyMDIzLCBhdCAxOjQ1IEFNLCBB
cmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4g77u/T24gRnJpLCA3
IEp1bCAyMDIzIGF0IDE4OjIxLCBEb25nIFdlaSA8RG9uZy5XZWlAYXJtLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gT24gQXJtIHN5c3RlbXMgdG9kYXksIHRoZSBBQ1BJIFJTRFAgaXMgZm91bmQgdXNpbmcg
dGhlIFVFRkkgQ29uZmlndXJhdGlvbiBUYWJsZS4gVGhpcyBpcyB0cnVlIGZvciBhbGwgQXJtIFN5
c3RlbVJlYWR5IGNvbXBsaWFudCBzeXN0ZW1zOiAxKSBTeXN0ZW1SZWFkeSBMUzogTEJCUnYxIGlz
IHVzaW5nIGEgbWluaW1hbCBVRUZJIEZXIHRvIGxvYWQgTGludXhCb290LCB0aGF0IG1pbmltYWwg
VUVGSSBGVyBpcyBwcm9kdWNpbmcgdGhlIFVFRkkgQ29uZmlndXJhdGlvbiBUYWJsZS4gV2UgYXJl
IHdvcmtpbmcgb24gTEJCUnYyLiBMQkJSdjIgaXMgYmFzZWQgb24gQ29yZWJvb3QgbG9hZGluZyBM
aW51eEJvb3QuIEJ1dCB3ZSBkbyBub3QgaGF2ZSBhIHdheSB0b2RheSB0byBnZXQgQ29yZUJvb3Qg
dG8gcHJvZHVjZSB0aGlzIHBvaW50ZXIgdG8gQUNQSSBSU0RQLiBBcm0gZG9lcyBub3Qgc3VwcG9y
dCB4ODYgRTgyMCBCSU9TIGludGVyZmFjZS4gMikgU3lzdGVtUmVhZHkgSVI6IHRoaXMgc29sdXRp
b24gdXNlcyBEVCByYXRoZXIgdGhhbiBBQ1BJLiAzKSBTeXN0ZW1SZWFkeSBFUzogdGhpcyBzb2x1
dGlvbiBjYW4gdXNlIFVCb290IG9yIEVESzIsIGFuZCBpdCByZXF1aXJlcyBBQ1BJLiBTaW5jZSBi
b3RoIFVCb290IGFuZCBFREsyIHN1cHBvcnQgVUVGSSBub3csIHNvIEFDUEkgUlNEUCBjYW4gYmUg
Zm91bmQgdXNpbmcgdGhlIFVFRkkgQ29uZmlndXJhdGlvbiBUYWJsZS4gNCkgU3lzdGVtUmVhZHkg
U1I6IHRoaXMgc29sdXRpb24gdHlwaWNhbGx5IHVzZXMgRURLMiBhbmQgcmVxdWlyZXMgQUNQSSwg
c28gbm8gaXNzdWUgZmluZGluZyBSU0RQIHZpYSBVRUZJIENvbmZpZ3VyYXRpb24gVGFibGUuDQo+
Pg0KPj4NCj4+DQo+PiBTbyB0aGUgQUNQSSBSU0RQIGlzc3VlIG9ubHkgZXhpc3QgaWYgd2Ugd2Fu
dCB0byByZW1vdmUgdGhlIG1pbmltdW0gVUVGSSBGVyBhbmQgZ28gdG8gQ29yZUJvb3QgY29tcGxl
dGVseSB0byBsb2FkIExpbnV4Qm9vdC4gV2UgYXJlIGN1cnJlbnRseSBleHBsb3JpbmcgaG93IHRv
IHNvbHZlIHRoYXQgaXNzdWXigKYNCj4+DQo+DQo+IEhlbGxvIERvbmcsDQo+DQo+IFRoaXMgZml4
ZXMgdGhlIFJTRFAgaXNzdWUgcGVyaGFwcywgYnV0IHRoYXQgaXMgbm90IHRoZSBvbmx5IHByb2Js
ZW0uIEkNCj4gaGF2ZSBtZW50aW9uZWQgdGhpcyBtYW55IHRpbWVzIGFscmVhZHksIGJ1dCBsZXQg
bWUgbWVudGlvbiBpdCBhZ2Fpbg0KPiBmb3IgY29tcGxldGVuZXNzOg0KPg0KPiBBQ1BJIGRvZXMg
bm90IGhhdmUgYSBtZW1vcnkgbWFwLCBhbmQgQVJNIGlzIG11Y2ggbW9yZSBmaW5pY2t5IGFib3V0
DQo+IG1hcHBpbmcgbWVtb3J5IHJlZ2lvbnMgd2l0aCB0aGUgcmlnaHQgYXR0cmlidXRlcywgZ2l2
ZW4gdGhhdCB1bmNhY2hlZA0KPiBhY2Nlc3NlcyBkb24ndCBzbm9vcCB0aGUgY2FjaGVzIGxpa2Ug
dGhleSBkbyBvbiB4ODYuIFRoaXMgbWVhbnMgaXQgaXMNCj4gZXNzZW50aWFsIHRoYXQgbWVtb3J5
IG1hcHBpbmdzIGNvbnN0cnVjdGVkIGZyb20gQU1MIGNvZGUgKHdoaWNoDQo+IGRvZXNuJ3QgcHJv
dmlkZSBhbnkgY29udGV4dCBwZXJ0YWluaW5nIHRvIHRoZSBtZW1vcnkgdHlwZSBlaXRoZXIpIGFy
ZQ0KPiBjcmVhdGVkIHdpdGggdGhlIHJpZ2h0IG1lbW9yeSB0eXBlLg0KPg0KPiBDdXJyZW50bHks
IHRoZSBMaW51eC9hcm02NCBnbHVlIGNvZGUgZm9yIHRoZSBBQ1BJIGNvcmUNCj4gY3Jvc3MtcmVm
ZXJlbmNlcyBldmVyeSBtZW1vcnkgbWFwcGluZyBjcmVhdGVkIGZyb20gYSBTeXN0ZW1NZW1vcnkN
Cj4gT3BSZWdpb24gYnkgQU1MIGNvZGUgYWdhaW5zdCB0aGUgRUZJIG1lbW9yeSBtYXAsIGFuZCB1
c2VzIHRoZSBFRkkNCj4gbWVtb3J5IHR5cGUgYW5kIGF0dHJpYnV0ZXMgdG8gaW5mZXIgdGhlIG1l
bW9yeSB0eXBlIHRvIHByb2dyYW0gaW50bw0KPiB0aGUgcGFnZSB0YWJsZXMuIFNvIHNpbXBseSBw
cm92aWRpbmcgdGhlIFJTRFAgaXMgKm5vdCogc3VmZmljaWVudDogb24NCj4gYXJtNjQsIG1vcmUg
d29yayBpcyBuZWVkZWQgYW5kIGN1cnJlbnRseSwgYm9vdGluZyBBQ1BJIHdpdGhvdXQgYSBFRkkN
Cj4gbWVtb3J5IG1hcCByZXN1bHRzIGluIFN5c3RlbU1lbW9yeSBPcFJlZ2lvbnMgbm90IHdvcmtp
bmcgYXQgYWxsLg0KPg0KPiBPZiBjb3Vyc2UsIHdlIG1pZ2h0IGJlIGFibGUgdG8gd29yayBhcm91
bmQgdGhhdCBieSBwcm92aWRpbmcgYQ0KPiAnY29yZWJvb3QnIG1lbW9yeSBtYXAgZm9yIGRvaW5n
IEFDUEkgb24gYXJtNjQsIGJ1dCB0aGF0IHJlc3VsdHMgaW4NCj4gbW9yZSBmcmFnbWVudGF0aW9u
IGFuZCBhbiBpbmZsYXRlZCB2YWxpZGF0aW9uIG1hdHJpeCwgd2hpY2ggcHV0cyB0aGUNCj4gYnVy
ZGVuIG9uIHRoZSBMaW51eCBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMgdG8gbWFrZSBzdXJlIHRoYXQg
YWxsIHRoZXNlDQo+IGRpZmZlcmVudCBjb21iaW5hdGlvbnMgcmVtYWluIHN1cHBvcnRlZC4NCj4N
Cj4gQUlVSSwgdGhpcyBtZW1vcnkgdHlwZSBpc3N1ZSBkb2VzIG5vdCBleGlzdCBmb3IgUklTQy1W
IHRvZGF5LCBidXQgSSdkDQo+IHN1Z2dlc3QgdG8gdGhlIFJJU0MtViBtYWludGFpbmVycyB0byB0
YWtlIGEgY2FyZWZ1bCBsb29rIGF0IGFybTY0J3MNCj4gYWNwaV9vc19pb3JlbWFwKCkgaW1wbGVt
ZW50YXRpb24gYW5kIGRlY2lkZSB3aGV0aGVyIG9yIG5vdCBSSVNDLVYNCj4gbmVlZHMgc2ltaWxh
ciBsb2dpYy4NCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFu
ZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmls
ZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRz
IHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9y
IGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
