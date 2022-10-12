Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8475FC068
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJLGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:04:07 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00054.outbound.protection.outlook.com [40.107.0.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF412AFE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5/jiHHFhJKSBBId92U+59byijaDDfxKEV30OjEJy2H9SWqviH+hDe5LwNZ1GnMkqPghK2X6oEqETg5sdhmU6TQ3MW8cgtNHVq5Klk96WSfMZfxb04mryBdgJsI8tfOYW7uh6Ey9XPuA5ZjW6qc14jHD7xMv+jPz83EJKGjG1BWwlBhtqvrqJrRQe+AdTXJlYb8FsJ78WfIM73MAaYax0KiJy7+gy/JvK13UapMj8ApFy1/PQTSWvtMY/AxPjMqN5Fex55g6G0qW3aaeDYEb4CrgeZVpNQf5c8SFnm6u7RosTOYI3CBA4Vzl9fRfUkGuMm+f6TQz6iLUqriG20GZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiq30x9Jlh2mgitley7M5Rj3rBYWJq/C4luJbxzJ9nI=;
 b=mUoIhx38gMnr4KWUdr9y6OOAkF2a/mD2zZ/uHxJOQHqTAUaqOnVD1ZLR8NHRMyuMFqm+Vgxm/x0BJfR4GxkzOEnCTr3HAAgSVqrEks6ibXXufvtfC+VmF/wVPgDP/odAEctcArBFZ4Upn22FkqPeGlg4jv9DpwjlmLkTk2je5GFy2ZpvCgwuiHlSO6Z+FRpIaSaN12uhvaE69zDqsK/2FXwCYjvc0NO/SSR1hJroip4kH7ZJqUpC7LYmhkp/uXqIWMjAAmwALm4UyOl9GpVD1tc2Ho77uuPLcbVg7ceH49ChGeSk36zZpjNPO/lU4raNq1nUFNQisl5vWBl+Gl4Wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiq30x9Jlh2mgitley7M5Rj3rBYWJq/C4luJbxzJ9nI=;
 b=NQn+D4yClZ9gmUo94K6mEYBH4OQOlB+XZg2k1WTsZFXEW15Ds49ZJq3oRcj9TADWqPnUycaD42iJji5g52EBQnZkGmA8VmTGOSZ5i0+I7ZMrLWfEeJl9IC7v/j89WLh1wBefkhUlSr5uldH6fdGR4n6U5Y64Vzq5mcYtHcNJB9hh6x8/xTMT+JJzfmXFXmmzZeNLyl0//fd8kXOcZ/Xh4+wYC8pB5RIQfRoRHA97ZbEZXlcq0mkcQUJaMwOQ/rI9jr66HZv3ZsvbwQRrJTPWmZ85moPdDPWO3tdsDf0rzCSIsqd+UVQ+wui0KRup/2KgNee+8ZCfWCf6hfK62BMnWA==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PA4PR10MB5705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 06:04:03 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e38:b6e0:190f:415]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e38:b6e0:190f:415%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 06:04:03 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Pavel Machek <pavel@ucw.cz>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Thread-Topic: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Thread-Index: AQHY2KfleP9QglhAv0+8Mjv6RBsYz64EV3WAgAX4FaA=
Date:   Wed, 12 Oct 2022 06:04:03 +0000
Message-ID: <DB9PR10MB58812CCC35455D34B57D0DE2E0229@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20220826193545.20363-1-pchelkin@ispras.ru>
 <20220827091353.30160-1-pchelkin@ispras.ru>
 <20220919113219.GA14632@duo.ucw.cz>
 <46a91b24-1c84-3ab8-2508-11720ee9ed5f@ispras.ru>
 <DB9PR10MB58814C87D370B045EFB6682EE05D9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <3572970f-f40f-5410-651a-a5e019d328d8@ispras.ru>
In-Reply-To: <3572970f-f40f-5410-651a-a5e019d328d8@ispras.ru>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-12T06:04:02Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4a81e6ad-96a0-4a7e-913c-b7e5255d6e25;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PA4PR10MB5705:EE_
x-ms-office365-filtering-correlation-id: 85addf47-0471-45c7-7184-08daac179098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRLxo+7hAQuTdqfyJywfh266oau3iVsuJmdfmlw1qZfScWML1DHlGbbrLluVj50W1+YyRN8e/3tM/bojwLQyLy6E4SWqVt9bHxSccoH48p5S/k80CpPX5dv6QpktrQJ1yyolWvMP9aswnOgD7BY5YzYpglab1FHITi5GDvivTwywqN+45YeBkDA+LK2IOZCsa9wZMuopD2bUiO3BeD8GvnI/XTxr3ufkWiymmkaP5P9Fg6U/Wtsg05DPFvq6HwCWg/6Ai2VnYAqai75+lajhKmi4p+WbMeximjW7qyStihn3GnQdKLgrKsOyfUduRAd2Xd0fzyI4e38zM1HzltkLuhJZu/95Yg/qWb7GlbLQi05tn93tLGdf2sHBohwOH5e7dAwPhdcP2V+2zlWu3lSpj/6QtzCK6vcNmtuHrOyXq7hW1kmahyG5z2Pp2tyfz0THYXaFu2HLECQb32jX5ZVekNQu5jaHMFvR+nSjs9yMpN7176L7fsfElHYf5CSZpjZUspQYNOzMLpqszl/MbUKj0cBp6NX5yewSUxgYe11APZ4QKZakCrVuBchcEiX2CSUNNnycgOcQFEtFnTXhS8pL7xfm7UkA/fbx7oCmp0e3in5e3BG/Sp2Cbz/AKRu8poMvpcVeIMJMNrWetjOJAbot3KRsmgppteCxFIBwpkOiWs3Yw8OhAIFJb+4SR9d+8rUGtnUfApEV/qqtFgzzJigr2iUSjfWuDs/yVX+8pqufsa4QtGizPNA0h8CaM+W0lSYYPj/fOM5sK1kIcZat2WEKRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(2906002)(86362001)(66946007)(8936002)(66556008)(52536014)(76116006)(122000001)(66476007)(82960400001)(5660300002)(55016003)(66446008)(54906003)(316002)(41300700001)(8676002)(64756008)(6916009)(4326008)(71200400001)(558084003)(33656002)(186003)(478600001)(9686003)(7696005)(26005)(38100700002)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1pkRXNlN0c3Tm12T05Ka0p1ZWVhbi9kMitQeFFtdnREY3NrUGNyZEFhaWFT?=
 =?utf-8?B?aFFjanlUS2s3bnBmZXFLNE1yM2p4TFlUYlcrTTc5eHJTbjlsUGEyOVk0R1NZ?=
 =?utf-8?B?NVRsWmJUZ1ltdzdnYlc2NHVQY2RVWGxTMUZjcmpkblQ0Vmx3OW9NVkdYTmpm?=
 =?utf-8?B?K05iYjBhTkFvcWJQNU1rZUJmd1Q3R0J3WmcrR3ZYRFlqaDRBUUoyZ1lRQzJ6?=
 =?utf-8?B?amZaR3pwQVJGK0ZqZVkwMWh2aFoyUWlnZGp5WEFHZmpSQWk2SXVtOWNtbGpI?=
 =?utf-8?B?aGh2d3RabWtFd2dvVXhJdmQ0bFYvbDBPaGNrdnp0NHI1aGhuU3lDL2NMaEpX?=
 =?utf-8?B?Um9GQ1hkbytFL1lXWFRxMHl3Um9hRExCMld3Y3NvbHNieSthZ2JYdDZDQTdq?=
 =?utf-8?B?L0trM3QzajhiUXJhU3pRSFEwVGpCdXZyVlBqL0RvSDFqVHovODNkRFVNU2ls?=
 =?utf-8?B?OWFZTFlYY20xSURKRDBsNFZHNXptdFVXODdtT1U0TmxXQjlUL1VWL2ExOEVx?=
 =?utf-8?B?S09HMXF5REF6S1VYREtlTzdYdFVNamtiSFgyNmFxeU9iUXBMUThBTmtCeHRP?=
 =?utf-8?B?MjJEM0REUXFBTFhuSVQ4UDZrRkl2SFdYL2E2c05NMFpNL05lcnZWbFdlOU1a?=
 =?utf-8?B?eC83RkorbU5WMllyN1J1bHNkYm0vQW9tRzRGY052alFhSXhzRGZKQ3lQaTE5?=
 =?utf-8?B?V1NOcVdKVSt3aW5POUxRZm41dGNCNWczNHQ3d2RuRFJUa1hCTWZ1d3NGdHB6?=
 =?utf-8?B?ekhsSkZRSGlWOWxrN1ZUZnZiQVlPTXl5NkVpNkFZS2pQMFVMNUVBRlJOS1VD?=
 =?utf-8?B?VXNnenlaenlpbW80OG9PempadWFpYUF6SVZSZyt5NlE3TVA3N2JDYzgxLzBs?=
 =?utf-8?B?SHpWcnBORngzMGxFMGtlK0J4VXlqSldUWVJvTGNLdEs0OXY1M0gvOGhKS1RQ?=
 =?utf-8?B?dG1rVUdXVDVkK2J2QzVBWDN3QUVJSi9DOWJsaUQyalh3SVIzbFlMMDhvdEp1?=
 =?utf-8?B?ZktuZGtCMzIrQ2pLcUJ6Z0VWMkdxRi8xMWZhZW9mSHgxWkRBZHIyMEpLY215?=
 =?utf-8?B?M3NGczZFaTVmMTNPcXBTVTdhZ1ZQZiszTlhPam9aalFXZ0dNdGcyZm9BZldj?=
 =?utf-8?B?STVLR3ZSWGlaK2U1NWZ4eUtCVGJRUmZEVTRTVnAxaDRaN3doOXhvKzdNQXFI?=
 =?utf-8?B?d3duMS9iaG55SVBPSG5Pa09uYk1RSHlWalphWk9Rd0FhNDBMZnYzVXdJeFdv?=
 =?utf-8?B?SjFRSE5Ga2VIaE1DMm5FK2pFQ1JTSHZCMTh2aXN4SVAwbWFFaGRWTEI2RXdV?=
 =?utf-8?B?RnBXdUNwdVlZSEh1YU51cVZjVDFmWjl2dnF1TmhTcGgwQ3B6Zk9MVEJabml5?=
 =?utf-8?B?WEpRT0hoRERzZ3BIUHUwVGJIL3NEMlJxNmZRcmRQY0psZDVqOVlTMzlIQnZs?=
 =?utf-8?B?YkZwTWFZVm5BekpqeFVUVHJ0M2FOODc5T2JwS2pOSHlSdHJNZGY4QnpCOEtn?=
 =?utf-8?B?eGlvWWxScGdNV2JJNElTdUJKUVZYQlJJNjdxSisrSGI1QUFXQ3Q3V1dBSHR5?=
 =?utf-8?B?eGhxeS9CNjRIVXhvUmhGMjVtOVlqYUNKZHY0SWd1UkRlWlI3SE9NNGp1eEl4?=
 =?utf-8?B?NTFKYllJU0srekY0M25WbGRYZjhyS0FRTC8wa1h2YWppc2pobTJWOTNUak55?=
 =?utf-8?B?V2VFWFVsU2x5MkNpWEpocnVFWlVZZHlCSU1ZWmhqQ2hsanZZZi9VTUkyRmpI?=
 =?utf-8?B?TGFsdUYyTE05ZEh2M3RFNkFYRVZ2SjRIOFpRdW9sNEhCWm5XRWc3SGF2V2kv?=
 =?utf-8?B?V1lDbFNXaW81RlowL2ZtaHhVVjFaOW8zWnJldUNBanhPbjU1SXB6S0NnTnhn?=
 =?utf-8?B?U2VKQVlEVHpTajdIMVlER1U2ZE8zUnZXNXA1ZDZPMTZGT1dEajFVMGM5dkty?=
 =?utf-8?B?UHlBZEZZZUp3blR4Z3F6SEg2c1Jia3FhMHBtYVNvMTJoU0FWWjlmWkIwMjJn?=
 =?utf-8?B?N00xSGM3eHF0M3VVYkFJWmxpVXRtYXhMWmxDeUlCRGNLQXZZV2tURHlPZjBW?=
 =?utf-8?B?YXVuaWpoUUxnaUhNWkdPYkZ6K0Y2RnZXcE8wS0dCRTlSTHorNDh2M25NOHFD?=
 =?utf-8?B?TXJJNVI2dkJkYy9wdUttTndjZHhJMUNxVk00K0s3RFVJcm9VMC9xcC9CMndK?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 85addf47-0471-45c7-7184-08daac179098
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 06:04:03.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DJVg28FxOplyrMgDiULHdxcP0LpMATyVEgtCEvDRueDlMCPZiE4K6IacS3hQmypUrYYYBDOcNbGOGOxXnyBB6W1EpP7yHo5rxGsYsCxayw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5705
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXZSBoYXZlIGZvdW5kIHRoZSBvbmx5IHBvdGVudGlhbCBjb25jdXJyZW5jeSBwbGFjZToNCj4g
Z3NtLT50dHktPm9wcy0+d3JpdGUoKSBpbiBnc21sZF9vdXRwdXQoKSBhbmQgdHR5LT5vcHMtPndy
aXRlKCkgaW4NCj4gZ3NtbGRfd3JpdGUoKS4NCj4gDQo+IElzIHRoYXQgcmlnaHQ/IE9yIHRoZXJl
IGFyZSBzb21lIG90aGVyIGNhc2VzPw0KDQpDb3JyZWN0LiBUaGVzZSBhcmUgdGhlIG9ubHkgdHdv
IHBsYWNlcy4NCg==
