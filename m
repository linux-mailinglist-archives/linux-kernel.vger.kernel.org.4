Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEA6DDBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDKNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDKNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:14:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC494EB;
        Tue, 11 Apr 2023 06:14:51 -0700 (PDT)
X-UUID: d42b12c0d86a11edb6b9f13eb10bd0fe-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1T5wVJMCoumDd7oA8G+O/05v0mTgdFRxv8oQkM/tgWQ=;
        b=HJyz8M77tcqcE/ezcNsOi4B3QEPuEn0o76F62wz1ecDHNTsdHhhxX9O/g9hvrnL3bp/8pY850jsPgOm3RL0WCg+eozMBVcMDAA+efeENoOcA+7Jt78554jePjkCTYqgOuC5+4+o+k/LvSWineiCZHT9Q/jby67WufgY7/0u9Yr8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bcaa365e-e732-4767-ac2a-61ad0bc8d2a2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:bcaa365e-e732-4767-ac2a-61ad0bc8d2a2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:bb5eb383-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230411211447IAL7CYOE,BulkQuantity:0,Recheck:0,SF:17|19|38|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d42b12c0d86a11edb6b9f13eb10bd0fe-20230411
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1413227102; Tue, 11 Apr 2023 21:14:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 21:14:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 21:14:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcylorX6PNIUuSc1hgojFt0rZeDxEcifIJ9L7f48VIn+HCqHOwVM0hSyOG/H2vhdsH9brH1wP9LhjYZoYd2BiXO5jF1A0yN26824XcmdDgBRicjNhsOUCSMlzbpkdYvH1qSeLzfmCHjPr4MW8fQXXO1YV+pnX+lB2lNvMPqV7CjADypgpfS8vXU9lrFKr0AAMAg6HDk0XnaIj5KrtydDaO6KYLLV0pfDcdaJApmmWEg70IeK0jBoC8TzLu3mj/tTuvnaFYqZcEs8qee77fWI3gAdQi4oiOv2CvfU/4koKrN57GeAvpEfSsOv5a6BbIk06BGuIksQ21p0sq7OAqhQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T5wVJMCoumDd7oA8G+O/05v0mTgdFRxv8oQkM/tgWQ=;
 b=nYrSAyoiVQLmehHu2QGShYajsVanJPd3uHCodtxmPO7WxY3FehWeG2s2NYpOcoPkF0yRYSRURDqbp/TonEQ0sBYr3tG6VFvDXVCSB6zu8tG84UHSLU06bFjKd+oUYNzGTt9pLMU6AXOwinZNNojb8eMWndoFXHeYuTH0F1lNn8NRo1d6XMaoYpH6nrhr2AePnfAtb5/3KUjFkqArbyQel742ah6YFmR1tnQS/bb6koxIhxtVVYh7nVi2Bb+7Z9Ni34OJFdGPWBLsiYCdKKnJkWskVTYhLgJbejMY0GK579HcUe4crop/3HrsL6Agpl8WcyN45PwsLZN6W4WSfVF83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T5wVJMCoumDd7oA8G+O/05v0mTgdFRxv8oQkM/tgWQ=;
 b=fMuV6/98Ol/iagifXCYhFIZjMz0yMZaRuQ/PDtcqxX94O4oeJ3KEB9wPaFnhWK8GmSoA8iZ6tfsY0fePm8LdSYRezhKz65ZJ5v8Wz6aAagNKzKpyAA9sOKn4qC5WmDnZkUCSQQrMsJuBhUzjkl4jzjdvg355rN0DMkFCfXqcfgc=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by SEYPR03MB7165.apcprd03.prod.outlook.com (2603:1096:101:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Tue, 11 Apr
 2023 13:14:42 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::b8ab:9f5e:35e8:b26a]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::b8ab:9f5e:35e8:b26a%7]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 13:14:41 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] ufs: mcq: Add supporting functions for mcq abort
Thread-Topic: [PATCH v1 1/5] ufs: mcq: Add supporting functions for mcq abort
Thread-Index: AQHZYiYIe9kOmFwy+kSe5Q9mg12CB68mKtkA
Date:   Tue, 11 Apr 2023 13:14:41 +0000
Message-ID: <ee415bbb6f1196103bbfeea1e393fa71de109f05.camel@mediatek.com>
References: <cover.1680083571.git.quic_nguyenb@quicinc.com>
         <0351ea8bb5d7b223778367867ca3791cc6ee608d.1680083571.git.quic_nguyenb@quicinc.com>
In-Reply-To: <0351ea8bb5d7b223778367867ca3791cc6ee608d.1680083571.git.quic_nguyenb@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|SEYPR03MB7165:EE_
x-ms-office365-filtering-correlation-id: 85b5bb41-1bc4-48d8-5b88-08db3a8eb5dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V21Ol9RHBLKuaQ+xKY7WipEkWgwmC3l6Ikta+iRc4AeIwdb0MDyDEBugBk0P4/i9bWty2a7A7R+wPKosqj/ultGnNoKadBitf8SEwpVK6ZjvBfIIDSmEGFinvLfNoQ0dxrYgVQyYGvTrnEDq8wm/LqA1Gy9DLQrEIRQcrDmBjZeoFAa1T84cIZc8GgKjYz7Pqk6J8xejLMV0/cvpAJDhwImQpw50w/scfKjW7QiwJrVa+hw8Fq1X1JNfrgI394f9Xqk0Wsnzl6+tISogcjc7L6XVpkXCzKtY0BYLgmg1fQtkqkuFhfR5MGr1GmS6aEJnW89KXYZtP3ukSoE+t4kamZSdY5NeJkKcY4tZVS879FRBCZphbNJrVNzqaT835mUEVVVtBcERrTCil4zl8zhA7TB0bzIohSIccRoCq8+zhmGikG3bl0UE1ezhy4m51Homr/Ej5YSQh4jYqvuiehI8bQ3W/ZOTVumnyHXTq5CJ/BvsCcytEHUurOYQzR6+6R/eEKCIxMkik5KHiB3O8PZnS5lxxQ3r5EvUGOWbI5Ffb8Izfb1AXFu+qei9mfz/f+8wOxd3bgUMtinHXZsPE4alBU83RDaz+PjtnbYpN/54E3Nc8sPl1A/Y+yzj27YrQgVXjRtV+bDGglDBIZT1Uwxcmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(38100700002)(83380400001)(2616005)(76116006)(54906003)(6486002)(71200400001)(186003)(26005)(478600001)(6506007)(110136005)(6512007)(38070700005)(7416002)(5660300002)(2906002)(36756003)(66556008)(122000001)(8676002)(41300700001)(66476007)(64756008)(66446008)(8936002)(316002)(66946007)(85182001)(4326008)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXZ1cGJ3eWw5MTBSbnZOc2NCRU5pVWRlTTFQbXlCZDBNak5pR29kdDZ5ZVlL?=
 =?utf-8?B?TFdVYk13RXVBS2ZvUy9DN2dsekZXSmFKT1V0VnRQTjhCREZnaC9vRVhRRFh5?=
 =?utf-8?B?SUt1ZTdNMzRsRnJKcEhtUUJMbkorc3Uzd3JoaTk5TlAvMWFWQXUzQllIV28y?=
 =?utf-8?B?bGRpNDFMUVJUSVNIYTIrZjFFTmlmeUhZOTFoRDR0RE9IWS9JTUJPb04wT1li?=
 =?utf-8?B?dmYzVkNyRy9LcDlwUGxDa0pRbWNGeXE5RlE3Njhqa0JkMGpvcEJTRE5BcDB4?=
 =?utf-8?B?WEtmOVZlVjZ6TWRsZlk4aktpNFNkL0E0b05ZdWw5Ym9iNUJva0ZZYnppbWVO?=
 =?utf-8?B?VXJIVG5HYzhoVkxmV2JoMDhVSlMwd2IxY1NqY2d5RUxmSGVuUys3bGI5OVJ6?=
 =?utf-8?B?SlFiWlA1UlVMMmtlenh1VzlROWlVcC9QMzZSZTFUWUM1MDFLckhmSmZIMEtV?=
 =?utf-8?B?THpKNlBMbW9nRkhJcmNwblgwQWtRMmphbnNJUmlwVDJ0Z1F4MUJIcG45Z0tZ?=
 =?utf-8?B?LzNGU2FpSGtja3RrL2ZadGI0SHpSdENtMkJCbFpTeFp0dnpjZGR5akgyNVRV?=
 =?utf-8?B?Y0pkcDlaWFRYZ1djMlVpTFJKdms2MENqK1FvRDVFUFZSOHFrQlZrcnBQL05T?=
 =?utf-8?B?RjhJdUNIdHl0NzhFc0FUUGlKNzQveC9QZ3d1YVVZQVRlVVFVakdpM0MzRGlq?=
 =?utf-8?B?ajliRmhPUSswZFgwZXJVQ1J6aGdjNTV1akRoQUZ6Q2tGclhXekl2QkFQejNk?=
 =?utf-8?B?QkhKYUhOaHZKZW10RzBCSVlXRm4rQnYzWEJoSFBrTm5MbUY5cjBuZzRkNlJ4?=
 =?utf-8?B?Q0FsWXQwRWJ0VVVVRFVrM3lEZm8zVmx4NVlmNXg1MisxUjYzenpkeVhyQ3lF?=
 =?utf-8?B?aWx4WFZ4RG5ndGN6eEVSSEZjaGJINDl1ZERWczRjRWs0b0J6akpDem1pdDZ3?=
 =?utf-8?B?TXlJT3cwWXZrcXFuMkpQb2VDdE9mMGlvVjc0OUVpemQrUDRGZWhGVEpVNVNI?=
 =?utf-8?B?MFBzb1p2OW5LWFRyandpNWdHaU1HQlcwOGQwVEt1ejFIVkhNUlVpUzZXVm03?=
 =?utf-8?B?MHRoMTFoY0thakEzdDVVV2ZrUVBFQncwY1lubHdWeklyRUI1dW8rZWFQckRW?=
 =?utf-8?B?TitaYy9pVU9Ib1Z0WUNXdmdxUHJGZTNwdWFreG9Jc3JEOExFdUZ5bXhoK2Nj?=
 =?utf-8?B?bXRVTGMzRUorZDdZUnZmaFJTcUxKU0J0OHNnZ0FWa1owelZFbFBxTHZyYkVH?=
 =?utf-8?B?ZjU3ek1HNEdwUVBIcHd6bmNUVkpXeU1lNUx2aklQOS85dEpiLzFJQ0dtUm90?=
 =?utf-8?B?WmVtaXBWaUhtVHRLNDI1Y0tkWGwxSzJNRFBCSjFuUk5GS3RKK2h0SGdrRUll?=
 =?utf-8?B?ZWJobTVSRnN1TGJuSVhtM0JObnNKejdldTgraVhscngwdU5FQ3ZEbE8yM2w4?=
 =?utf-8?B?WWV3VHR5NkRDdCt3L01OVU5HUExBQ2gvU0c5UW8wQmxtelg4TDBjN1l0ZlFK?=
 =?utf-8?B?eGVJSURnWDFBb0loMkUwVTQzVVJKSzJqQnJxTTJKNXlRWnJWT2d1VTlyanFo?=
 =?utf-8?B?V1cwVENPY0RqdlNiazhtMHd0WC9WWkJGZ2dTQnZ0cW55VFhNWUdFSzdlWXdr?=
 =?utf-8?B?VXVPakc2YVc1M1dHdElwa3AzRWhYVzl2M2hjQ0N2Yll5ZStsNEdjL1NkakVp?=
 =?utf-8?B?dlNFMzZnU0tBdTBublg3VEsyMEdFOWhpeG8wN3NITy9Rd1F0Z0lLQlNhSDdJ?=
 =?utf-8?B?WDZMbnNCQU5VU21taXhzbThNT28xRTIwMWZBWjE2eGxvN2Z1MDBBMWNoZmt2?=
 =?utf-8?B?bVQzMGtSQVhjakxqMXJZUW1icm1KRXVLQVBwWXJzaU01aGo4YjdBNGx1cFFB?=
 =?utf-8?B?bU0wRUhZNWlkMnNzUFVRMzF2L1Y2cmZ6R2JmeFo1U3dkWlY2b2t2aFJRNC9n?=
 =?utf-8?B?K3FSK3B0aWU3OUJlSGp1UXE0enlESmdrdVZxVmZFbzFSYzNpR016U3hoWUZm?=
 =?utf-8?B?dXJTTGhQWEIweGlpMXpEUU50R20wTEM5N2JqQjM0eVVQbTdDeEhJcG5Qa1Nx?=
 =?utf-8?B?SWdKVEJDNTFFVW5QeTQvWWJUaHQ2dEhISWhTWmFNNHhHYzVnSXBmaDRYTXBy?=
 =?utf-8?B?MFh0MC9jdFB4aEdtT1ZUZjd1bEVrYkVMMkNpS0x0TEpWZ25xMElwRm5CODhM?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FD9600FADF63540A36709D178E96D1D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b5bb41-1bc4-48d8-5b88-08db3a8eb5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:14:41.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY/VD4ToXllNOFwPuiD9OVFBECK5/pHKB20NhjJgVH0IdDPaY61RerI4xl6LPuqwxAX4xJdeq5vRAGxXaEnSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7165
X-MTK:  N
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvIEQuLA0KDQpXZSBoYXZlIGRvbmUgc29tZSB0ZXN0IGJhc2VkIG9uIHlvdXIgUkZDIHYz
IHBhdGNoZXMgYW5kIGFuIGlzc3VlIGlzDQpyZXBvcnRlZC4gDQoNCiAgIGt3b3JrZXIvdTE2OjQ6
IEJVRzogc2NoZWR1bGluZyB3aGlsZSBhdG9taWM6DQogICBrd29ya2VyL3UxNjo0LzU3MzYvMHgw
MDAwMDAwMg0KICAga3dvcmtlci91MTY6NDogW25hbWU6Y29yZSZdUHJlZW1wdGlvbiBkaXNhYmxl
ZCBhdDoNCiAgIGt3b3JrZXIvdTE2OjQ6IFs8ZmZmZmZmZWY5N2UzMzAyND5dIHVmc2hjZF9tY3Ff
c3FfY2xlYW51cCsweDljLzB4MjdjDQogICBrd29ya2VyL3UxNjo0OiBDUFU6IDIgUElEOiA1NzM2
IENvbW06IGt3b3JrZXIvdTE2OjQgVGFpbnRlZDogRw0KICAgUyAgICAgIFcgIE9FICAgICAgDQog
ICBrd29ya2VyL3UxNjo0OiBXb3JrcXVldWU6IHVmc19laF93cV8wIHVmc2hjZF9lcnJfaGFuZGxl
cg0KICAga3dvcmtlci91MTY6NDogQ2FsbCB0cmFjZToNCiAgIGt3b3JrZXIvdTE2OjQ6ICBkdW1w
X2JhY2t0cmFjZSsweDEwOC8weDE1Yw0KICAga3dvcmtlci91MTY6NDogIHNob3dfc3RhY2srMHgy
MC8weDMwDQogICBrd29ya2VyL3UxNjo0OiAgZHVtcF9zdGFja19sdmwrMHg2Yy8weDhjDQogICBr
d29ya2VyL3UxNjo0OiAgZHVtcF9zdGFjaysweDIwLzB4NDQNCiAgIGt3b3JrZXIvdTE2OjQ6ICBf
X3NjaGVkdWxlX2J1ZysweGQ0LzB4MTAwDQogICBrd29ya2VyL3UxNjo0OiAgX19zY2hlZHVsZSsw
eDY2MC8weGE1Yw0KICAga3dvcmtlci91MTY6NDogIHNjaGVkdWxlKzB4ODAvMHhlYw0KICAga3dv
cmtlci91MTY6NDogIHNjaGVkdWxlX2hydGltZW91dF9yYW5nZV9jbG9jaysweGEwLzB4MTQwDQog
ICBrd29ya2VyL3UxNjo0OiAgc2NoZWR1bGVfaHJ0aW1lb3V0X3JhbmdlKzB4MWMvMHgzMA0KICAg
a3dvcmtlci91MTY6NDogIHVzbGVlcF9yYW5nZV9zdGF0ZSsweDg4LzB4ZDgNCiAgIGt3b3JrZXIv
dTE2OjQ6ICB1ZnNoY2RfbWNxX3NxX2NsZWFudXArMHgxNzAvMHgyN2MNCiAgIGt3b3JrZXIvdTE2
OjQ6ICB1ZnNoY2RfY2xlYXJfY21kcysweDc4LzB4MTg0DQogICBrd29ya2VyL3UxNjo0OiAgdWZz
aGNkX3dhaXRfZm9yX2Rldl9jbWQrMHgyMzQvMHgzNDgNCiAgIGt3b3JrZXIvdTE2OjQ6ICB1ZnNo
Y2RfZXhlY19kZXZfY21kKzB4MjIwLzB4Mjk4DQogICBrd29ya2VyL3UxNjo0OiAgdWZzaGNkX3Zl
cmlmeV9kZXZfaW5pdCsweDY4LzB4MTI0DQogICBrd29ya2VyL3UxNjo0OiAgdWZzaGNkX3Byb2Jl
X2hiYSsweDM5MC8weDliYw0KICAga3dvcmtlci91MTY6NDogIHVmc2hjZF9ob3N0X3Jlc2V0X2Fu
ZF9yZXN0b3JlKzB4NzQvMHgxNTgNCiAgIGt3b3JrZXIvdTE2OjQ6ICB1ZnNoY2RfcmVzZXRfYW5k
X3Jlc3RvcmUrMHg3MC8weDMxYw0KICAga3dvcmtlci91MTY6NDogIHVmc2hjZF9lcnJfaGFuZGxl
cisweGFkNC8weGU1OA0KICAga3dvcmtlci91MTY6NDogIHByb2Nlc3Nfb25lX3dvcmsrMHgyMTQv
MHg1YjgNCiAgIGt3b3JrZXIvdTE2OjQ6ICB3b3JrZXJfdGhyZWFkKzB4MmQ0LzB4NDQ4DQogICBr
d29ya2VyL3UxNjo0OiAga3RocmVhZCsweDExMC8weDFlMA0KICAga3dvcmtlci91MTY6NDogIHJl
dF9mcm9tX2ZvcmsrMHgxMC8weDIwDQogICBrd29ya2VyL3UxNjo0OiAtLS0tLS0tLS0tLS1bIGN1
dCBoZXJlIF0tLS0tLS0tLS0tLS0NCg0KDQpPbiBXZWQsIDIwMjMtMDMtMjkgYXQgMDM6MDEgLTA3
MDAsIEJhbyBELiBOZ3V5ZW4gd3JvdGU6DQoNCj4gKy8qKg0KPiArICogdWZzaGNkX21jcV9zcV9j
bGVhbnVwIC0gQ2xlYW4gdXAgU3VibWlzc2lvbiBRdWV1ZSByZXNvdXJjZXMNCj4gKyAqIGFzc29j
aWF0ZWQgd2l0aCB0aGUgcGVuZGluZyBjb21tYW5kLg0KPiArICogQGhiYSAtIHBlciBhZGFwdGVy
IGluc3RhbmNlLg0KPiArICogQHRhc2tfdGFnIC0gVGhlIGNvbW1hbmQncyB0YXNrIHRhZy4NCj4g
KyAqIEByZXN1bHQgLSBSZXN1bHQgb2YgdGhlIENsZWFuIHVwIG9wZXJhdGlvbi4NCj4gKyAqDQo+
ICsgKiBSZXR1cm5zIDAgYW5kIHJlc3VsdCBvbiBjb21wbGV0aW9uLiBSZXR1cm5zIGVycm9yIGNv
ZGUgaWYNCj4gKyAqIHRoZSBvcGVyYXRpb24gZmFpbHMuDQo+ICsgKi8NCj4gK2ludCB1ZnNoY2Rf
bWNxX3NxX2NsZWFudXAoc3RydWN0IHVmc19oYmEgKmhiYSwgaW50IHRhc2tfdGFnLCBpbnQNCj4g
KnJlc3VsdCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgdWZzaGNkX2xyYiAqbHJicCA9ICZoYmEt
PmxyYlt0YXNrX3RhZ107DQo+ICsgICAgICAgc3RydWN0IHNjc2lfY21uZCAqY21kID0gbHJicC0+
Y21kOw0KPiArICAgICAgIHN0cnVjdCB1ZnNfaHdfcXVldWUgKmh3cTsNCj4gKyAgICAgICB2b2lk
IF9faW9tZW0gKnJlZywgKm9wcl9zcWRfYmFzZTsNCj4gKyAgICAgICB1MzIgbmV4dXMsIGksIHZh
bDsNCj4gKyAgICAgICBpbnQgZXJyOw0KPiArDQo+ICsgICAgICAgaWYgKHRhc2tfdGFnICE9IGhi
YS0+bnV0cnMgLSBVRlNIQ0RfTlVNX1JFU0VSVkVEKSB7DQo+ICsgICAgICAgICAgICAgICBpZiAo
IWNtZCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEZBSUxFRDsNCj4gKyAgICAg
ICAgICAgICAgIGh3cSA9IHVmc2hjZF9tY3FfcmVxX3RvX2h3cShoYmEsDQo+IHNjc2lfY21kX3Rv
X3JxKGNtZCkpOw0KPiArICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgICBod3EgPSBo
YmEtPmRldl9jbWRfcXVldWU7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgaSA9IGh3cS0+
aWQ7DQo+ICsNCj4gKyAgICAgICBzcGluX2xvY2soJmh3cS0+c3FfbG9jayk7DQoNCkFzIHNwaW5f
bG9jaygpIGRpc2FibGUgcHJlZW1wdGlvbg0KDQo+ICsNCj4gKyAgICAgICAvKiBzdG9wIHRoZSBT
USBmZXRjaGluZyBiZWZvcmUgd29ya2luZyBvbiBpdCAqLw0KPiArICAgICAgIGVyciA9IHVmc2hj
ZF9tY3Ffc3Ffc3RvcChoYmEsIGh3cSk7DQo+ICsgICAgICAgaWYgKGVycikNCj4gKyAgICAgICAg
ICAgICAgIGdvdG8gdW5sb2NrOw0KPiArDQo+ICsgICAgICAgLyogU1FDVEkgPSBFWFRfSUlELCBJ
SUQsIExVTiwgVGFzayBUYWcgKi8NCj4gKyAgICAgICBuZXh1cyA9IGxyYnAtPmx1biA8PCA4IHwg
dGFza190YWc7DQo+ICsgICAgICAgb3ByX3NxZF9iYXNlID0gbWNxX29wcl9iYXNlKGhiYSwgT1BS
X1NRRCwgaSk7DQo+ICsgICAgICAgd3JpdGVsKG5leHVzLCBvcHJfc3FkX2Jhc2UgKyBSRUdfU1FD
VEkpOw0KPiArDQo+ICsgICAgICAgLyogU1FSVEN5LklDVSA9IDEgKi8NCj4gKyAgICAgICB3cml0
ZWwoU1FfSUNVLCBvcHJfc3FkX2Jhc2UgKyBSRUdfU1FSVEMpOw0KPiArDQo+ICsgICAgICAgLyog
UG9sbCBTUVJUU3kuQ1VTID0gMS4gUmV0dXJuIHJlc3VsdCBmcm9tIFNRUlRTeS5SVEMgKi8NCj4g
KyAgICAgICByZWcgPSBvcHJfc3FkX2Jhc2UgKyBSRUdfU1FSVFM7DQo+ICsgICAgICAgZXJyID0g
cmVhZF9wb2xsX3RpbWVvdXQocmVhZGwsIHZhbCwgdmFsICYgU1FfQ1VTLCAyMCwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNQ1FfUE9MTF9VUywgZmFsc2UsIHJlZyk7DQoNCnJl
YWRfcG9sbF90aW1lb3V0KCkgd2FzIHVmc2hjZF9tY3FfcG9sbF9yZWdpc3RlcigpIGluIGxhc3Qg
cGF0Y2gsDQpyaWdodD8gdWZzaGNkX21jcV9wb2xsX3JlZ2lzdGVyKCkgY2FsbHMgdXNsZWVwX3Jh
bmdlKCkgY2F1c2luZyBLRSBhcw0KcmVwb3J0ZWQgYWJvdmUuIFNhbWUgaXNzdWUgc2VlbXMgdG8g
c3RpbGwgZXhpc3QgYXMgcmVhZF9wb2xsX3RpbWVvdXQoKQ0Kc2xlZXBzLg0KDQpTa2lwcGluZyB1
ZnNoY2RfbWNxX3NxX2NsZWFudXAoKSBieSByZXR1cm5pbmcgRkFJTEVEIGRpcmVjdGx5IHRvDQp0
cmlnZ2VyIHJlc2V0IGluIHVmc2hjZCBlcnJvciBoYW5kbGVyIHN1Y2Nlc3NmdWxseSByZWNvdmVy
IGhvc3QuDQoNCkJUVywgaXMgdGhlcmUgbWF5YmUgYSBjaGFuZ2UgbGlzdCBiZXR3ZWVuIFJGQyB2
MyBhbmQgdGhpcyB2MSBwYXRjaD8gOikNClRoYW5rcw0KDQpQby1XZW4NCg0KDQo=
