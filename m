Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC57147D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjE2KWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE2KV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:21:58 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 03:21:56 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C391
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685355716; x=1716891716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lnrXakbxv7rjmihniEXhdksqeqkCD2oxWA4x6CwzL78=;
  b=L8qkhF2WE3PBvrL9A9WryyomKd6u0e6yP5kF7dFdEsWVq/w70VZ/nJQC
   7dUE/HCihDLVfj09pR/fYqJy1yTvkEgbZkCj8qv56vIgIqRtdbW/ok3Hk
   Y5jPLV8INd75LK4nogtOvXhkKgx+5N4Q+1CrzItOJayJUT447uHvSUURu
   dS0ipilr+9dN7oIg1l7VdBWsNE4i4pHLmxdDUzGDToKeYp8TFiTe7KeyM
   CXfr2Ech7I64Gr4VvtawVT96T+MFfWYqw0KVXBgskmFXWYX3IkUdfYjbW
   Kv/ty8aa//A+xM+GMpyjA6Vp/pvDLdlk0KCJ2xzxWaqQTD/vxKHBFgirl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="85304229"
X-IronPort-AV: E=Sophos;i="6.00,201,1681138800"; 
   d="scan'208";a="85304229"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 19:18:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9tynmf/jdNnwW07Vtb9TxQFX/H/uEXm4HK05IeNfY6YTVpDsNmhFXrH0lsV4PSeuShgAA6U9bYAmHPKcpwQ60OWimXj6HP2D4GQdL92cEGBrspc4SbWmr6sA9SGL7wf87b4d6bmtE/ZpVNMBlU8ZYWRM/wOV6jX1332OHAiANONWxgkj9K6K7qWVf8o2lqUmmcKOipgki0I8B8clxCxV5ddtlcDAiBHvKXuKwku+fSqssuqZ+0k27fk5IYJ3hSEVNfVDYMPl/xM0Lw+197Atutx7Vul9abOBdJcv7+YHd0AqupAtAfKKHc28MV/kUaJ3UTFWdvXOomii8AciUlgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnrXakbxv7rjmihniEXhdksqeqkCD2oxWA4x6CwzL78=;
 b=ZsggP7eBbr0xsbeQ03U9miUI5C1MxxxyF5d/9Zkz5IN1UvpTOnIErF/t3kVtSIx7ZoiOjg2yIsTHHg/JU2OZSdf5NhEZFhDNn+fBmxdQw6XM0VF+rMDCTLuA121Z3ncugHTBjS6DDWeZ+cvwD9IIt0GE6it1uMhVtU+IjTPLZt8joQzv2svbi1tieqAvikefWFTsc72wiC9egvjPq60sOrVEAW++ph+SYWAvjdOU+lJJ4tNmK3JOM2TeriUEVL95nq5qCwv1ODJW42tqjApnhDHkWoA+h6DU1Y7PlfqFpwOnxYe6cw7mpDufCV2CPVu9nEIIFTid0q/GJIpbi57U+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB11991.jpnprd01.prod.outlook.com (2603:1096:400:37b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Mon, 29 May
 2023 10:18:35 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:18:35 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Babu Moger' <babu.moger@amd.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
CC:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'babu.moger@amd.com'" <babu.moger@amd.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
Subject: RE: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZkgbBOb3IvrS+mkSMKkYt66DYY69xCIiQ
Date:   Mon, 29 May 2023 10:18:35 +0000
Message-ID: <TYAPR01MB6330FE696DCA7996C85F76478B4A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMjlUMTA6MTQ6?=
 =?utf-8?B?MDNaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD00ZDg3MTk4OC04Njk2LTQ4Mjct?=
 =?utf-8?B?YjhkNy0xNTJjZjI5NmE3YzM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: d2daaaae554f49beaff6567890580518
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB11991:EE_
x-ms-office365-filtering-correlation-id: afa1a6ad-63ac-4683-b303-08db602e0fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0XOLc/LXozmREPwOkw4hvdpINPaYVSQ08yD8+80VKHAAgRYRm89Q8IKghp5Z3W7DC59PXDrBrkybysWDQKSIsrbfgDZAkUoGWHbr/63hlayho/wBfRPfRDBic1bRb89eGSvIWgz9+L8ozziZtNBFboaT4NLU6XzvyBA/8pJdpJCrzJolME0//oAoTOxeR7r54y2uefPyLIqexEYr3tpR+dYvNjDePG6j36E9DsvlB3sX5HlNkAN3kY3sMULmFNyrBs2iulZ7+lt56GDyfWTPCi+qHhbQY4QHsADseRsYhT+OT5QfBHwuzcduI6ayrTKAxSm2+yHVpzKHnxcMo2enC6Dxlw5U0hA6FWgZBIEz1s/ex5jBHlY5YIMNQmRJULSRAggGMZzbD9g8uocLuURa6alcfKDyKXUqpzzOc75CSC/KhjI/eTN/A66uJ9c+PxuKpjdVdM/bSCtN/NHC/c8FKwgWvDE4LSWtkVgTF1TMdp0kazNvYQEpvw235GGExmwApJS0FIfGP+xkX4VJNjiYX8wuUqpXxQB9RUZIID3fN1dnWs/vEFUTY7Q+x2KohIsXyi14XTxeQVa3cpqk6RO+C2QQ9HbdCFDd6nLKevTti3DRUb/MhfAC5HofcUX3kbytenR0ij++7QY4LjZATcnap09/oUDQPmzKIUWE4g6a4v8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(1590799018)(451199021)(478600001)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(110136005)(4326008)(54906003)(38070700005)(86362001)(33656002)(85182001)(1580799015)(316002)(83380400001)(6506007)(26005)(9686003)(186003)(5660300002)(41300700001)(8936002)(8676002)(7406005)(7416002)(52536014)(4744005)(2906002)(71200400001)(7696005)(55016003)(38100700002)(82960400001)(122000001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1VeXlJaFdyVmI1N0pnM1BENzVTWHdSbVBRYTh5SngyODFDdXA3YWZSc3lh?=
 =?utf-8?B?UFEwU3R4d3ZCMjUzcVMxRkZuZitOR01sR0V6V3AwMWVCM24vc0VmNk10aU1k?=
 =?utf-8?B?aDdiNXpyZW56NzhKTWV3dnhHSitpMitYWFVGU0RldDBSWVZ1a3BCMXZ5cEtQ?=
 =?utf-8?B?VTZUMDNLQ3RyKytidmpXZTJ3LzVtbHJpc0NyU2U5WkhqSGFOclZUOHViL2x4?=
 =?utf-8?B?aDNtYWZaTjFRRjRYN0pCYlArZFlqbndnSlB5MmQzeVNjNTBXK0Z6aGMyU052?=
 =?utf-8?B?SlduVWV4bC9EdUEzblVBNmZycFc5KytWaktsTUljOHVsZjlZYjVYcldKWFVK?=
 =?utf-8?B?WGRGRFJEK1BMSXF5SEFXbFZsRzVWR1ZJcnJqM25Ld3ZaODI2WUEvbkE0dDNU?=
 =?utf-8?B?YjlDRXZaR3R3SklrVzZlazBxcHBZK1l5SVhDdEhkL2dyOUFib3NJa1NqaFNa?=
 =?utf-8?B?TVFlcmR6UVBNSUpUUXYvejRWazMwQXA1SENFTFRFNmMrdlE5UW0zaGJlZ3R0?=
 =?utf-8?B?Z1l2ZDNoUml1ejNLOFJQM2NSeTV1ekE2M3FhMXZDZ280KzFhSnRVS1BMNDlu?=
 =?utf-8?B?dC9pU3l0UXFYOUlYenl6NGNYRE91ejVzRFpzWlA1RGlVU3RsYnFhYXNOWXYw?=
 =?utf-8?B?REFNcktXN2NkcG16YVp0alZxYnNVR1FaeEhNdXFMSkFvZHdIazVWNzJGTGRr?=
 =?utf-8?B?UDNvdzByT2lmZkVSTjJqY3hkTnlBZzZpMEFYNFR3LzlUZFpaNUhBR1MyaFN1?=
 =?utf-8?B?RGcyUEhJYWRxRVFrNE4xQ2FOVnY5Sm4reDcrT0JBNzRxVGJBYlJleDFjd09J?=
 =?utf-8?B?SzFBNCt6Z2VjN3FOcnVrdEN3R2h0M2FnT0o5NFFwVUVPb1FTUTJIcmpKbVo1?=
 =?utf-8?B?VzFwQXR4RmZoWkE0aDRMYkFZUlhtdjl6U1RLQkV0M1lWaktiUFNxOHNWVVht?=
 =?utf-8?B?SktmRHE3NEdHU2FnRGZRUnVRZWZGOFY3RWFzOTFDcEJoaFBkTGVuVGdoRC84?=
 =?utf-8?B?a0wyV3VkRnhuczVTdDBDNDZoK3ZaSHNSQnFqTEs3VDJYMWY3TXVCdnQ4dHZ1?=
 =?utf-8?B?eHBjUHhVdkhHUHpUU3o5QjNOTXRpUmRYRXlldHJxT0FYdXR1NUlvRloyVkVJ?=
 =?utf-8?B?UHNXeWV6OS95T1hscUVlVzBjbjd0a0QzNWx4K3NuSTJWNTluM2dmTXl6Q20z?=
 =?utf-8?B?SGNHZXRPRDdaZjFTRXBFa003Kzc3dXdvSTBHVTJhTzZkd2tJWWVLWHMvQ24r?=
 =?utf-8?B?V1ZzMnZhZUszRlY3UEJKaUlNUklOc2MrOG1RSHJscjVwc2ZqTVNPOE4vNDdh?=
 =?utf-8?B?Um1tMlQ2dUthcVB5cm40SGxvQWJoWGlOOGtXRHpMTmJURFJHdjNiUDlrcDVs?=
 =?utf-8?B?THZDb1R6cW9xTFZ3OG1GaCt1V01saHAyVVVxVzlIZ0IzZFpWckFFMCtGNHYw?=
 =?utf-8?B?dUR2MndQRW5oQ2U3aEZkdTI3VjUrUVA2VVpaNlUvekQ0ajdoUXgweVg4RlFz?=
 =?utf-8?B?cUkzSHdlTWpERmdYT2tyelJhajVCM3hScWMxWHY1cTEzYzRYUTVSeGdXM0tZ?=
 =?utf-8?B?Z2FzRWwvZmlsdUNUb1RXRmlwbTd5RkM1VXZweklxeHF3UmdNOG1KVmNUcHRn?=
 =?utf-8?B?cG44QlcrYkJpOUNabllLRzg5UUx4UlVqS0IrTkN2R1lQbnIrZ1RHd3VHKy9C?=
 =?utf-8?B?am5PNTZjdDNmVk9QQWlYZ3VBdVRBc0xqcWMwNEl0TUw3M3FaMGhIY2RqQkVj?=
 =?utf-8?B?bit3RC9KZG0zN09kdWp0Z0NiaDZQeHlET2pnTmROSXNleXVSNEgweUx3eXo4?=
 =?utf-8?B?QVJzMjZVRnh3N0hYM3RvQ2Vja3ZDWXBHOUtuc0F5TnVDbDJhQVlhM0xnNnJZ?=
 =?utf-8?B?bVJFQ0RnanRXT2pTRGRUR1hZdVpPQW1TZ1hRVTBJUEJUTytWdzdSMjg3Vjcy?=
 =?utf-8?B?WFJCeVlnL00wVXZ5SkFBV0UyR1M4L21KVEJUbTA3dzdNMGlXRWtSWS9mSkRG?=
 =?utf-8?B?WWo5SUU0a3VxcFJ4cmZEY2hLa0dpb0RYcGpSQXpMTVhPdW9QZXdOc21ScGxh?=
 =?utf-8?B?Z2l5UUp1bFNQYUhDbjMrNktDbXo3WHNrcnJQcTdUYzFlNWhrbkJzVkNFV043?=
 =?utf-8?B?TXN6M01wZHhVdEw3UEZPeEp0eW01R3EveWI1Q3kvdTg4cTNLT2I3dEVDeXZ2?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVF0eDBDNUE3dDlFSytodFJFM1JLdjEwNy8wTUgybGVqc3VWekR0Zy9CbFRD?=
 =?utf-8?B?c1VEK2d3ZW9oemo3Q0dkVXRTVGMzTG1TSVVHZ2VuS3E1ckFWV1lpbUxQbmt6?=
 =?utf-8?B?TFR1NTQ5L09EU2ZJNEZKMERHTzFPQ0VEVXo1U2FJYVhJaUtPVHFSdzU5WjBI?=
 =?utf-8?B?YjhnckEyaWNtSWZFUU5XUVJxdTRHOWNpRHpRNWJBVzN4anVPcjJmckVPZkpo?=
 =?utf-8?B?THg0KzhVekt5NzZ3UnBVYU56Slg3aE0zSUNZMGE1aWpENm5kTHFCZVdQOU01?=
 =?utf-8?B?MWFXcmNxbWlTZkg1Qm82aU9lMEk0bVNUNE12NHFsc3VlM3JLUEthNjZqeWNL?=
 =?utf-8?B?TTFMUFJ2S2dHODMvZWg3L0ozRU0xbnpoTGJvNXNZbFVvVmI2MFhIY3EvN1VZ?=
 =?utf-8?B?ajBaSVVJT2d5WCtLOGxVSkgzMFBqdjl0RFRkTXc4U0JSRjhNU3hYUU9EVEtC?=
 =?utf-8?B?dURrUStBOE1wRXAxVThvb1RhM3BEVU5PVkF3NGRkZUpKZEFoVGpRdVVDanVB?=
 =?utf-8?B?VW9JbDdwT1M3TDVtcjVwTWZxQjdQN29VQVU5bDNMa1JwdERyTitGTjd0ZXJs?=
 =?utf-8?B?YTE4a0x0TjFGdGRxT0dUK3MrMC90MXorMi9oZE1MS3JKQWllb0RLN3hySzRM?=
 =?utf-8?B?bDJyeFoxVFRHemNUVU9UOVlOSGlMNmc0d2NYWFZQOUFPQm1sRUlqeDFZUkw4?=
 =?utf-8?B?NkZFNGh3WU9pbHRJSDVVZmE4TjMrOUJXenMwT1dMYjBiOWM2OHRDdC9OU29I?=
 =?utf-8?B?R0dPbXVrTldVdXNsSldXRXg0T2ppMm51cXgreE9zRUxtcFN6OS9vMXVzbFlW?=
 =?utf-8?B?UXpwY1dHVUZ1Z2I2Z3RQNUxQYVo1TXpuNHdCRC9hVTh4U0JMYWc5QUdoenZ5?=
 =?utf-8?B?OVIxeVcvQ0ZZcDZlSSsxLzNlZ01IL1NmdHQvb3R1ckd1UmpDMlNKclgvZnd4?=
 =?utf-8?B?S3NxUmJySzY1NG04VTNWN21XSXNuUEFNTDEydHE5eWM1TU83eTRFSy9qMHdZ?=
 =?utf-8?B?NUcyS0hDZTkzSXBTMVE2WTNzQnAycnVmdkcxM2g3eG8wRnc3dk1ydkREOVlw?=
 =?utf-8?B?UklFWFlkZktmc2VxNFhtUDRFVko5RXZMVlRIUzhpZGVlRDBIM1VzN2pXS1Ix?=
 =?utf-8?B?QjFRd09JWDlBcXpOb0duTndyNXRNeG14SXJLQ2QxOExwZ1NIeGxML1VReG93?=
 =?utf-8?B?SVZTd243eG0raUhteU1TQjV2ZjBFMUljN2lVaXdxZkRESnFMNE93QnVlYW9L?=
 =?utf-8?B?ZHNrOGowZ0Y4YjNkNG8ydTBpNU1aZlFVYy9xNERwUGZvMHljZExtb1RTRStR?=
 =?utf-8?B?QUoySUtZSHVkaEZZbytBU3RndCtNajh6cXhhZlVTWjZSbWNINzN3bWV1U3FR?=
 =?utf-8?B?SWtWZEdWM1NpbFFxY0h0ZlpJTWtDMlBXVGdwZWhBaytyRVFWakRjMkViLzMy?=
 =?utf-8?B?MHB5TVdpRVE2eDlYT203UjIrWjJ2TUVjWm5pSkxudmVFSE9KdFVQU2ZLWk1O?=
 =?utf-8?B?TFlLK2FkZ1VVMHdMa2tJU3orSnZ2ckk5dFhST0g5ZGtuZUNvTWZIMEFyR21E?=
 =?utf-8?B?aUdPSkNEbFpPd1pHb2pnUGFHTDluemYrYlJEN283Rmg4NDFrcWs3akdacG1y?=
 =?utf-8?B?WTZpVVdQcXVKcGtldzgrdEs3cUJJTzFqaDlnYUYyOUJ3MGFHNzJ2ZlRGRFdx?=
 =?utf-8?B?MVFPc2VGWTR3WGw3NTdHZkdiWGhJb0cyS2lFeXBjbkdyOEdKY05lWlBOMC96?=
 =?utf-8?B?aENVVDR3NnhnNlJLT0xjYXNIU0o5SEh6MWJPallRVGhXb1lMK0U5NHpqTG5X?=
 =?utf-8?Q?wSuGlhnwzyj28kuVQRpUzs6XCj8x3JS88nRpA=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa1a6ad-63ac-4683-b303-08db602e0fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 10:18:35.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaLjyVuyAoh0CtGnd2HJZ0xbLSXYVQHtt1ecFxX1F38lGmXk8GI48MNO3RFCGlOVJgyxyuOb2WTRHSrVvlr+wPy7fghufzhLfn9YUasYLBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11991
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFidSwNCg0KPiBUaGVzZSBzZXJpZXMgYWRkcyBzdXBwb3J0IGZldyBtaW5vciBmZWF0dXJl
cy4NCj4gMS4gU3VwcG9ydCBhc3NpZ25pbmcgbXVsdGlwbGUgdGFza3MgdG8gY29udHJvbC9tb24g
Z3JvdXBzIGluIG9uZSBjb21tYW5kLg0KPiAyLiBBZGQgZGVidWcgbW91bnQgb3B0aW9uIGZvciBy
ZXNjdHJsIGludGVyZmFjZS4NCj4gMy4gQWRkIFJNSUQgYW5kIENMT1NJRCBpbiByZXNjdHJsIGlu
dGVyZmFjZSB3aGVuIG1vdW50ZWQgd2l0aCBkZWJ1ZyBvcHRpb24uDQo+IDQuIFdoaWxlIGRvaW5n
IHRoZXNlIGFib3ZlIGNoYW5nZXMsIGZvdW5kIHRoYXQgcmZ0eXBlIGZsYWdzIG5lZWRlZCBzb21l
DQo+IGNsZWFudXAuDQo+ICAgIFRoZXkgd2VyZSBuYW1lZCBpbmNvbnNpc3RlbnRseS4gUmUtYXJy
YW5nZWQgdGhlbSBtdWNoIG1vcmUgY2xlYW5seQ0KPiBub3cuDQo+ICAgIEhvcGUgaXQgY2FuIGhl
bHAgZnV0dXJlIGFkZGl0aW9ucy4NCg0KSSB0ZXN0ZWQgdGhlc2UgZmVhdHVyZXMgYW5kIHJhbiB0
aGUgc2VsZnRlc3RzL3Jlc2N0cmwgdGVzdCBzZXQsDQppdCBzZWVtcyB0byBiZSBmaW5lLg0KDQpN
YXliZSB0aGUgbmV4dCB2ZXJzaW9uIHdpbGwgY29tZSBzb29uIHdpdGggc29tZSBmaXhlcywNCkkg
d2lsbCB0ZXN0IGl0IGFnYWluLg0KDQo8VGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1
LmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KU2hhb3BlbmcgVEFODQo=
