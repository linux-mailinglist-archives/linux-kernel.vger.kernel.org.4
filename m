Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072956877AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBBIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBBIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:39:13 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C383485;
        Thu,  2 Feb 2023 00:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+a34t4t321zQK8zpLWIs92APkv+7CVNBrq4p784zQ=;
 b=nkaS4XQIxuOkht1f5GMHxVbY/7t/mcufsud9KUOQKhkfm5B/r9KPcIsMRMj8wnBp/6WSdLzvCMmB99ZwXzCdwnZhujZWxL6+opo69zHsgYCbW/d4ENqb4gV7G0ZtrcB9x88VAG/KDD6l9TyF3dCTF4U0BkKElKzs3Mp5jCISQx8=
Received: from DU2PR04CA0185.eurprd04.prod.outlook.com (2603:10a6:10:28d::10)
 by DBBPR08MB6233.eurprd08.prod.outlook.com (2603:10a6:10:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 08:39:03 +0000
Received: from DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::1a) by DU2PR04CA0185.outlook.office365.com
 (2603:10a6:10:28d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 08:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT026.mail.protection.outlook.com (100.127.142.242) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24 via Frontend Transport; Thu, 2 Feb 2023 08:39:02 +0000
Received: ("Tessian outbound 43b0faad5a68:v132"); Thu, 02 Feb 2023 08:39:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8f332296d75d2633
X-CR-MTA-TID: 64aa7808
Received: from da1a0e406134.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D78B9949-EF06-464C-92B4-B7198CFC8F48.1;
        Thu, 02 Feb 2023 08:38:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id da1a0e406134.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Feb 2023 08:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfG0+ZlKBJJqGswB7tCQuaDEjCL3fURB/B7i0jly5Vq5jwqXwH6GmbwU8FXH/GVz0JXPPwtXc58x3HO0sL94aPuISdmJP6FSb4Iny9nFHQChSJMr9Tf77aauCrVWJPGjq1R0sgMJgNchr5dYUyMBvL2MrdimNPZGcUoLLgf1fxaYT9e0a2dAalZnP5tysrgPc8zTBaJq9eS8X5S2rGxazt/EiOW/ncMwrw5AqkgcRu3jzmbNIgLd3sHd7IvppZyq6EU7tcVolMdztVV4C6d0sBz2P7bKeEx7gQ5y3mY5W/ij7HsdO6L/SwkB3RurV4D4soqCRo1a/DkLWa8rLVsHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P+a34t4t321zQK8zpLWIs92APkv+7CVNBrq4p784zQ=;
 b=RkWVMwTAWcT34KrOZHrWWPCqnVnlEXluRnUJvVcKSzKHhtSnYeIGHlbNs9hXS9ftdnjOR/iT1gC1iPtNf1w711GaMOTpNN15GZI4RPZ2y9nW4g0nMxw1qlOrwAaF4SNidXXrKZGveUgEI1b151LfGDBBs2gbExDTWnESS5E2okQK373CfxUBAVw8qT9Gp9D4kEE0fCdXxrTkObGkDCouJhVkWejybmZHBXbwC0fhBPWQeVMMIjyI6RnYygHSAXMJdqWogX51afqfDG2UxPLxMyI2AJZbbH+rc82C1sBZ4dvQwOW/FFRjlPOzhK3JBpZyzvUgqP3Se9dkLUOaGFhX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P+a34t4t321zQK8zpLWIs92APkv+7CVNBrq4p784zQ=;
 b=nkaS4XQIxuOkht1f5GMHxVbY/7t/mcufsud9KUOQKhkfm5B/r9KPcIsMRMj8wnBp/6WSdLzvCMmB99ZwXzCdwnZhujZWxL6+opo69zHsgYCbW/d4ENqb4gV7G0ZtrcB9x88VAG/KDD6l9TyF3dCTF4U0BkKElKzs3Mp5jCISQx8=
Received: from DBBPR08MB4313.eurprd08.prod.outlook.com (2603:10a6:10:c9::19)
 by VE1PR08MB5664.eurprd08.prod.outlook.com (2603:10a6:800:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 08:38:47 +0000
Received: from DBBPR08MB4313.eurprd08.prod.outlook.com
 ([fe80::376f:ee94:cf8a:a720]) by DBBPR08MB4313.eurprd08.prod.outlook.com
 ([fe80::376f:ee94:cf8a:a720%7]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 08:38:46 +0000
From:   Carsten Haitzler <Carsten.Haitzler@arm.com>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Script style improvements in lib/coresight.sh
Thread-Topic: [PATCH 0/2] Script style improvements in lib/coresight.sh
Thread-Index: AQHZNoc4GUrdVc9Pzkib9K6RU7qH7q67VngA
Date:   Thu, 2 Feb 2023 08:38:46 +0000
Message-ID: <b13301b1-104f-ebb5-6b2a-3d6cc3eba8a3@arm.com>
References: <20230201214945.127474-1-didi.debian@cknow.org>
In-Reply-To: <20230201214945.127474-1-didi.debian@cknow.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4313:EE_|VE1PR08MB5664:EE_|DBAEUR03FT026:EE_|DBBPR08MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 734c8a41-5114-4697-16bf-08db04f8f01c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LW67s9v6GnGVeRLV+nnjypWcqkhJjQT6RHYft9P1gXg4fkKiEPCtbRgGC69J0Vb40bI2EtCkCTUe0fTAC3o3rY9tOWRWZMpZHSEHiKgi9WSSpXD/9ig1rNztJwJLb3l5ELsKEMmOQZu1m2XG8tdOlF32q9MtHf0Kzy1EkvDQ3LOmqG0xZmKOP/N/Ejc7d0JfdPCnueUxAxv/jIre0hTUVOB2GtIlDHixLK8ttpLXLaoQ6LDhotR4GCByP22Kz7zdXKqCX4GWTjw4a/20M01NWxiHQXFYfyY+pnypsm79M8mv6w/Ak8Lh5vHeTmcR4JudPJwcMZTbC1gYa5krz+55zcPkEEjga7cXaDhA9iroIeni/glQI0PkSF+oDFepzs98gQKkOJgWZnTp7B10CbVKb5M0AaxbA0GC1WwhLMyTq9gtBZ0BDlNllJCt07b5g7XTtKgGTP22tzf9oiadaIVoIpQA3Het5pWcBNvk993yKH4qo66WG7DOGZdjFrfqR35IYfe8LJcjgHBftfiTWfGQXmyKNzOtUuy7H1HbNGqGVEUOUZMDe8HqcfmYHSodrhJxmbRvXf3zUBWbT7cFVt2+snAjk2UjDtHLfviVzDxEbxvbj8uh0lUhxd9I/qHQk7Cw8tTdJ9HdPNPmIxJvF9BIF7E0iBf/raabtBbajzjMQvw/RU946Ui7WA9DO8YhX1dKV7Kyw5U/f+0KsWK/KajmlW9HcNTjCoBEpMS6Uz3PmGANmmnnFCIvos5EqZ5/4QQopWP1xoIZ4wY3g4zqLk/8TA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4313.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199018)(31686004)(38070700005)(83380400001)(71200400001)(4744005)(6506007)(2906002)(36756003)(186003)(31696002)(26005)(86362001)(53546011)(8676002)(6512007)(4326008)(6486002)(41300700001)(5660300002)(478600001)(110136005)(122000001)(2616005)(91956017)(316002)(76116006)(54906003)(66946007)(66446008)(8936002)(64756008)(38100700002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F0F3AA8039921419D6B2104230C9608@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5664
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: edcc2ac6-589c-42e2-c1b5-08db04f8e670
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQnAzse7jTjLGwbrzbeMD7BvUySIeHQqtX+JBBcoydB8YtSdsJWP2li4DcF3RagRryD6grFDGsT55FXJ3cgY+cqp6YnpQhugx96c5GbVaPezDzC7IwbYadAaYK1yJ3arbXW1v8MmxL7xb3GBQWRUlyNtpNxXWh3XrzsWGrj8yU2I1sx5s4bSmeCxvv4Soi4FgiURF9KEQwG+8afbUZPD9ahvLhyVWqxRtzd8tdsWRtSUo20hz68JjYa3ks5ZrsVgWngrREcLHDxGZhbzt/2h0cDbr0FLnorKbhR3zQIuIyoXFjSolT/2hqBvagOiMJoW+pJdF+6o7mD64PrF9Q5hHVaRdwItHMAM1SC4OA3Xe1w6G21DVN3QcVbFV2U7DzlpQqCmyw/6XIKTAz+cw4v9D2Eduq3M4f3y6CGhrU3k6jrUGfvO8A8vWsT5crfC9UEsa6fGyJX8K/Tw8/6MbUp7KMsiUZQ3dKbDmwyvaynwLL0KSRSNiMcCzRFgCtXaLO8bxjvgvVAuEz8gVEmFVBJI8zBMQqrhzUvkmDOSM1h2PI58A0ztV7PihQJcKemrBLWH/axn8xK26H+FdyLWKcYSap3yOR3XBFGV+V+bqoGchlsbG+UwZ8g9bLWSnbG5XmuVNPNrCAcNxWwzgwcKvc4T4uDsUhAnCyTQ08AuGzT52w+wYiFpwf08nPUdUzXszOljmJ8bn2uI/wAPu7G5SZiNOJy064mOG/rqVPyg+Y8PcKA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(356005)(40480700001)(36756003)(31696002)(86362001)(36860700001)(82310400005)(82740400003)(81166007)(70586007)(26005)(8676002)(110136005)(450100002)(70206006)(4326008)(54906003)(316002)(4744005)(2906002)(41300700001)(8936002)(47076005)(336012)(2616005)(83380400001)(478600001)(40460700003)(53546011)(6512007)(186003)(6486002)(6506007)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 08:39:02.9674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734c8a41-5114-4697-16bf-08db04f8f01c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6233
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xLzIzIDIxOjQ5LCBEaWVkZXJpayBkZSBIYWFzIHdyb3RlOg0KPiBUaGVzZSAyIHBhdGNo
ZXMgaW1wcm92ZSB0aGUgZWZmaWNpZW5jeSBhbmQgcXVhbGl0eSBvZiB0aGUNCj4gbGliL2NvcmVz
aWdodC5zaCBzY3JpcHQuDQo+DQo+IFRoZSBmaXJzdCBvbmUgdXNlcyBncmVwJ3MgYC1jYCBwYXJh
bWV0ZXIgdG8gY291bnQgdGhlIHJlc3VsdHMgaW5zdGVhZCBvZg0KPiBwaXBpbmcgaXQgdG8gYHdj
IC1sYC4NCj4gVGhlIHNlY29uZCBvbmUgcmVwbGFjZXMgdGhlIHVzZSBvZiBiYWNrdGlja3MgKGAu
Li5gKSB3aXRoICQoLi4uKSBhcyB0aGUNCj4gZm9ybWVyIGhhcyBzZXZlcmFsIHBvdGVudGlhbCBp
c3N1ZXMgd2hpbGUgdGhlIGxhdHRlciBkb2VzIG5vdC4NCj4NCj4gRGllZGVyaWsgZGUgSGFhcyAo
Mik6DQo+ICAgIHBlcmYgdGVzdDogUmVwbGFjZSAnZ3JlcCB8IHdjIC1sJyB3aXRoICdncmVwIC1j
Jw0KPiAgICBwZXJmIHRlc3Q6IFJlcGxhY2UgbGVnYWN5IGAuLi5gIHdpdGggJCguLi4pDQo+DQo+
ICAgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9saWIvY29yZXNpZ2h0LnNoIHwgMTggKysrKysrKysr
LS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkNCj4NCkFDSyB0byBhbGwgb2YgdGhpcyBzZXJpZXMuDQoNCklNUE9SVEFOVCBOT1RJQ0U6
IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZp
ZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFu
ZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBp
dCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFu
eSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
