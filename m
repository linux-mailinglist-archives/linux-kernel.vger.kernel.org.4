Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5674081C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjF1CPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjF1CPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:15:14 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815F2D6D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1687918513; x=1719454513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FpgvK8wtsVb0tZwOnyjtccUQqjNpPYZRgKBLyDzubsw=;
  b=x7R45Eph5Bl2J066UsC5YXIhL3cpHYpDITAzBOPCrb1Ha4XNiEqQ9C9a
   FyH7QTK/elLHJhJ9jvZwxzewyVAzIrfj2AkFYxQhNAE8mKa/F6M8C7kfb
   sPeauKONMHbFLa94yhTCGzt6ymaJE87/ooNEoy3Isl7bIhm4loRYAF8gf
   2XzANlyunlC2AfTQlmu2PMXv5u80CzkxrnbPUZ28khBAdTEAdO6rK/2dz
   JEz66TgsvS1TNQQrRxbqqL/G2RHXuUSNeVUPIqd8c5j/1VP54rZraTiao
   01kjrVOSAoJVCHnfcR65Q4CmR0Bw+ogmxHD8RZhxRLn0W1kcMLXrXbfXb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="88406780"
X-IronPort-AV: E=Sophos;i="6.01,164,1684767600"; 
   d="scan'208";a="88406780"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:13:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ+eeqnYJDHgxrrQENcXEr2c/jfknD9TzCjaB+6fnJvPGT1ybl2/XlQRo9hIrPVYZTgcyOgpuyNn/ehi6BxXjiUw2wPA3Q4ZnmSROl5OH9hV4sL4GbDTJeoIC3t8Z899ua7A2AjYuydDdvHxO77vO47znAESqTkH1OJ1ZArHYijEl8Lxud2Y3/9ti0oCcOsDvFSquKdi2+aG4EKO1Ao174DaiMPLXIvA0w9k2abFdjD0/cRzQMraFuwRGH9xn3HEtwONCas4OYS9vTTLodpKi6tCUWv+lnxWzd203d/ASdDKhNItY9tvYkTfDT1EtX7Gxqk5b9zc2E+yNdSfVwwucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpgvK8wtsVb0tZwOnyjtccUQqjNpPYZRgKBLyDzubsw=;
 b=ddhIbJtFEp3yK90PtYHlpTcs3j0S8/IF7dlUNApTad6NpchQ9Gr7PX7FZ/ytdVw9o+lWyHVdMFUwNwr7GGnTEDl3nPEPHoBVpLb7OVJ0joDSoAyJ4g+GEw1JF1ZAeYr1Lv4Cfr084I4EigoyPtjNH7mLsrdrq64MVqaLGNfRCB5TtB/Rn8iUyexDMN+VADTxk2ghL32klPT2wfv3IzTksitIuj/N8ktg0G7NSJ/KkGkpfbZnrJtFYGEfW5jFBvfS6Mpy3XkGYnXzKEsznc0ScFnjtpzBMePms6ZXZ+QcBDZ/YLLXNcb2tDH10mHQqTrXWhFBgW2oxmKTNi6ycuIvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS0PR01MB6179.jpnprd01.prod.outlook.com (2603:1096:604:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 02:13:55 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:13:55 +0000
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
Subject: RE: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZqVlq2MhXilXk2k+p9CI3QgjETq+fZxBw
Date:   Wed, 28 Jun 2023 02:13:55 +0000
Message-ID: <TYAPR01MB63304C114A2C0E8B7BB537DA8B24A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
In-Reply-To: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMjhUMDE6MDc6?=
 =?utf-8?B?MThaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yMzM0NDZkYi02YWIzLTQyMDUt?=
 =?utf-8?B?YTE1MS0yYWIxNjdlMzcxZTY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: b63b83c2d2844e4ea86e03b99a927dac
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS0PR01MB6179:EE_
x-ms-office365-filtering-correlation-id: 43cb0df3-c8c4-4dfc-9ffb-08db777d5312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJbMVZHLQWNAVlffLBL4wfzx5ALMhy9gqOoarum4KD1IciBc9CH4sOY6o2f1UJEmHPdNfGELad71RE+NSUa2+Uqwu9UH35rlZUZvS2c17BChf4wR2bRuXxylRZtOHXHHcjHluWpxDy/A2RJXaIjd3kmZ/eSSnVLLiKWzMQdzmkdlSGD90DYOMrTmdlysj3W/60+AvyVhluRJm0I4UdNPiK/Jm37WDKObv47U62ICW2Th9GP/TMLE/CjWeezNSjoYt4lIYApR6rd2DO6Cs1LvWBs/QzVSFjSaQQJrpgTJUhUlr1Nsplamka1k/AOQtRVRfi1xB1VyCTquUk1W1KMv5OtDJCttcDC65fsP5ZkbdksB/5vDeGq4iWWRIt2i8KsUZPVVeZKaAMkWP0J0iozyeBLtkLwM+JNcIZ9OprsVtGJOqDo84pEDmabqKEZXGyFgMNMzhkbb4GtKb2Ed9S5p/YCGPxFxnpXzobL7ZIdcVL3g1AXAS3T04ndQl+8GDSPH25J1DOGP9v+gl0cnyRMS8H6A/rIKtbOqc6BgdAhDi/jg0sQ1/uYAh60Q2oidMKm0+UjH7qf2XgDiSBnxFggxYNmngXJIHvnVLzhJHgfyRTYpClSSFFHAqoALtStsvPLuUiW6RL9qsjVp0KS3H9OV3HuDGHkYQEUVGpgbWF/hI+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(1590799018)(8676002)(66946007)(66556008)(66446008)(55016003)(76116006)(66476007)(64756008)(316002)(9686003)(4326008)(6506007)(186003)(26005)(7696005)(110136005)(54906003)(71200400001)(41300700001)(8936002)(1580799015)(52536014)(5660300002)(7416002)(7406005)(2906002)(478600001)(38070700005)(82960400001)(38100700002)(122000001)(85182001)(558084003)(33656002)(86362001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnZwYktBNWZxREtsTGlWRHp0b2xsOHlScGk0MHFweis1WUhwaU1uM3hEeCtL?=
 =?utf-8?B?UVgvVFNtYllMUGRpNXlZQWxkdERFYVR4UnNFMm1WeU1sLzJURkdYVnc5RS80?=
 =?utf-8?B?NmhhM1N5KzA2b3B2a0M1SlhWbEFXRTBUYXdjY0NPeWpKZ0thakdIdkhTQXZK?=
 =?utf-8?B?RTBFaWllemFpVDEwSWpBbk5jb1dLRUYwQVVZcDdHdGZLcmd6azNnU2YySVdp?=
 =?utf-8?B?UHlWZURkaUtnU1BSVXlKc05XdWtGcC9WY2QzZWFMWXZPcG1hTUh4MzNoSWVK?=
 =?utf-8?B?Vks0K1VnRGNISnRCRjhtM3hjZlhWMXYzcVYrdnZjUlRiYXdkSHEwV2FaUFh5?=
 =?utf-8?B?RTdnY2FpSjlFZGp0ZlFaaGQ3cm5iVU5uUVgrUHBubkxENStXSHVBL2NiWjFl?=
 =?utf-8?B?VUphMHArNXNEdmE0Q05EQ0MvUW4veVlhSm5VM1l2TjFDT1ZGYStuRGFoT0Yx?=
 =?utf-8?B?Z0JCUGYvVGtyMTd0OU1KQ0lESitvQzlkRFJZRTFYSkN2TkNNT1Qza1dzcWJ2?=
 =?utf-8?B?TGUyaTVqL3pyQzFCZVUySGN2VU44T0VFVVNLZFA1VU1nWnpMUDI3TzNqUVp6?=
 =?utf-8?B?N1M1Y0NWdmduTXVTaU85SU9rM0cxUHlxMHNTSEhlWm9aVVpYOHpkZzlwRFp1?=
 =?utf-8?B?YS9jbGJwNURlZFRudTdtdDV2U01PL3M4aTVSTFNkcVJ5cnliUCsyYXZ3dk11?=
 =?utf-8?B?cHEvWnVqM1RwZW50UXBuRVlIdFd5b3pHMXljOCtqcHpTdURFVTl4SFRnYWNW?=
 =?utf-8?B?ZTNNTm9FZS95aUtGV21ZVlRJaHE0RG1UMWkvbG5ibTQ2VXg2N0YwQjFhZG5z?=
 =?utf-8?B?Yk9RbnZMSFpvZzE5QjhnTUQ0NE12aFUvTWRUcTJzeE8rbVBJb1g5a24yNzdo?=
 =?utf-8?B?M2lRZmlyTStjZ2krWGJRK1R5Z0NTSW5pR0VjVWNzR3RvMUYrK1htT0d6eDgv?=
 =?utf-8?B?NkJRcllVY1hmV0MxZ0lObC9EOUliRnQ2ZXZyVGs4dUYyVzNVZE84U0w5Z0NG?=
 =?utf-8?B?ZjVOakRLaXZTZk1kMmNiNm81a3V5N1dUQ3h2eDVJNzBwcU9XSWpEcy9hOWhW?=
 =?utf-8?B?VldVcUMwSS9MR0VJMEF3OWV1YVJCL0gveEJZTmhLL2RpSzdjWnVNbmlOck5B?=
 =?utf-8?B?YzQ1Wmd6b2FBelNXdEVvTytPVU9wdnNoaGNSaVpnRFU1b0MyTUJGTUNqckUy?=
 =?utf-8?B?TVhnaiszVUxzZVBQUTBQTUlxSlg2dWd3UnI5QXN1TnF2VEI1QmpGemI5TWsw?=
 =?utf-8?B?amZ5LzZneHhKMVgybll6cmRCaTdvbEZmWFUvVEdMeGdUR01JMzJKSU82SkFS?=
 =?utf-8?B?VlVzblpVeHpTWEZJajNZcXZhdWhLYm5nS0h3aUE1MGJHMHpNQWZBWkdyM01z?=
 =?utf-8?B?MWViMlpQZ0Q5QUprempRM0xPVENjVXNkZS9iK3RsbzF3RmFkRE8yTnRoaWYv?=
 =?utf-8?B?WGlhQnVsZjhCWFhYLzFsdFgyU2ZLbzNzWVJ1K0FQMHI1TnRhUzZXWXJjR2Ny?=
 =?utf-8?B?ZEtsS0Y1V3ZlUUlKNU41TGxDcXRQODJKbHJIZ1EzWktaMXZwTWU3cjBZZjZp?=
 =?utf-8?B?MU00eWdhS080R09vdFMxYVBOZHhzYTd6ZkRqZk90RTNDVDNhNnF2TWNIeWFC?=
 =?utf-8?B?WFk3b0lBQkhSYjBzWEJROXVieXlITGFEejBhTUh6NDVjckt4U3VXMlFtTXVB?=
 =?utf-8?B?N2dQKzlYVDhwcXpIZzM2Mml5SjBtaWJHOVExVkFmNjAzRnFwOTV3MWFQY0RK?=
 =?utf-8?B?eDhzNXdRY0UyVmdMOVc1S3ZiVVRMRGlhaW55RDhGSWtDVW9sNVhEWHNKNkJD?=
 =?utf-8?B?ZGx4eW43VUN5cUxFSTJCSitnQlN1cWVOdDlGYWRMZUp5K3FxeC9SWVNrSUdh?=
 =?utf-8?B?b2p4N1JlVnNVR3ZGbThwVmFiZG11YnR4NW9pTWhnQjFXNXNkN2RseDI5MWRY?=
 =?utf-8?B?czltSW1EVWd4UTZxREZ2RWV6ZjJJNEVIVWNwZjZ0bFhoZGVZaU5QeFdLMTlp?=
 =?utf-8?B?Mnp6dDZRMHFHZUwyRStSKy9LQ0ZXRWo5QzlORG5pM0oycForUTFId0RwaVZL?=
 =?utf-8?B?S0k4WFRHczhwbEhINWdMbTNWRHdrSmZOQjg3bVJpeUN5ZGVUSGpTZkM4L0g1?=
 =?utf-8?B?QVdDZnZQNVg0YWlRd001WHdDa1J0U2FzcWV4MzN3MUNoQlVYMzEvL2hkNmpK?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VVBOOVJoNU5IUWg5OWFUUlZlVXdsdWRna2gvOXU3U1VLQjdNRGZvTGkwYkZO?=
 =?utf-8?B?K1RaZDMxNTgwdHl0bWtMNllVR0NkL0I3eC9jM3ozcmdpdW84T3R3QmFhS3VT?=
 =?utf-8?B?NEhRRGxvcDJhaWdUR29WSGZoa2NiYi9FM0xEeCt1NTJHNjAvR2JLckllN2s3?=
 =?utf-8?B?dXFRVG1ZZjlJRk9aUmJ0Y3F0K2syM01XYXp4Vm5kOHlocDFtQkdtWkpsM3Bj?=
 =?utf-8?B?RVU0L201RGtWeEZJMW1pMVhQeUtTYnAyam94REkvYkVOSTN6Y1dYcDVnNkpk?=
 =?utf-8?B?aG5uamUzVUNxcDF4NERvNmxzaXFvaUJ2WGlHbEFmb2F3Q2d4Sm5SdG55Vnhr?=
 =?utf-8?B?eDRpY1hwTWRyTTBVaVhoSUxvWmlPMkRyWHE4bEFuWnhoeDBocEhlQm9wdlAz?=
 =?utf-8?B?ZnRKS0pEcnY2V0hiMllqOEJickErTi9ucTZJWkhGN2QzNi9pNi9JWlcyVEdO?=
 =?utf-8?B?dm8xTFZjdzI4VXNQMmYzeU4wMktLb3pSYVBFT0JiS2Q5cXZUVWsrNjRBdFh2?=
 =?utf-8?B?bEtxSEVUQXk0aDVqdHJCb1IzNzhDTEdwaUpmM3N1cElTMFdYS2s1RjQ4dVhN?=
 =?utf-8?B?WlUydEFiQVZtSFJPRjdNRzdKdjJOMC9nMUMydE1DQVpMUitjSDdLQWlJUm14?=
 =?utf-8?B?SmcxMWJWcDdFdUNnQ0paVC8wT2ltRFlVeklab3FuUytjbm5jbVFNT0ozNlJS?=
 =?utf-8?B?bWp6U3VsNjFPZWdlU1E5S0RKbENjQWZGaVF3clJiSzZHK2NKMDRGclFVSDNV?=
 =?utf-8?B?ZUdEM0tSSW5LQmYyMVBrTDhOY1VLdTRMTTZyUkpMRXpyRko3bXBSVkdXc0VR?=
 =?utf-8?B?bXRyYlJKMXdLK1c4WlF6TkFrVlR6VDVQUWdIM1RWczZPdy9EcHNyYm13QzBC?=
 =?utf-8?B?WHk5OVhrKzFBeCtNeG9lZFl4RlhicUljYU1ha0E1aVJoaEphWUtIRzgzdlpY?=
 =?utf-8?B?MGYwS0dMU25Fd2pyVTYrUXp1T2NXS0JxUDVuaWc0NVBMcVVVM3BqTVJnbGJi?=
 =?utf-8?B?em1qUUxsQTI0L2lCTXhXWHlIZTZzbUF0U05aQTk4QW1MTjlNVGY4QVd0OTlK?=
 =?utf-8?B?NWZPeFFad1ljN3ZuVnN4NHNudzZEeENpclAyL2o5cmpPdHdZd0FBOUhDU2xp?=
 =?utf-8?B?enNIdVU4YUdrOHZmV0w4dWNTQU9KMWVERHYyT0FzcnFBelZXYnpIYUx0Y0dv?=
 =?utf-8?B?OTluK08rUHVuVDBSbGJqMWlEQU90MDRvOVdqQ3ZnUWM4T0ZDTGZ0aEJPMWc0?=
 =?utf-8?B?ZGpEdjM1dkw5VUhVYzl5TVlUc2NnYTBrZHgzdXVpSnBMbTRvbG40TFk1Wi9n?=
 =?utf-8?B?cThKQjJMZlZXMHJRUi81M01tbi9tZGtIdVpoRG56ZVVpRks0Y2VqZzJMR3VY?=
 =?utf-8?B?eTNLUzg2djdCb1FRUldvZmxZRFpEZDlsUmozS25WRWFGRW4wOTJVMkxnVTYx?=
 =?utf-8?B?MlVBelZYK0RyMzB1NkQwcFcxVjFqRHI5dWJKd3BBQisvbzdpWU0raGtKd3NN?=
 =?utf-8?B?cjV4cVArYmxIMmpoQS9FNGpXUnpXNFNqN1hYQjlHSEJWL1hOUnh6YlV6bmJR?=
 =?utf-8?B?b3h0OE9CVXFjRUd2V0R5SDlmVkZ0NXVVLzlpNXluQWZtNUFiQXBTZmNCMFJR?=
 =?utf-8?B?a045bTBpSHN6d3BmVlBaZGVwVW12KzZwdFhPelJLMlJjc1p6S1NpQk85NTJ0?=
 =?utf-8?B?VTlkUFRzV1Q5NVJ6QnR4dHpxSWthK2hTRVhoWnV1aWxvQjIvUFFId0I4cjI5?=
 =?utf-8?B?YStVZ3RyUGlqSEgxcmdSMkZITHhlN0pVOWJndVhKSnVzb2ZqR2p1ME14SmpX?=
 =?utf-8?B?UUdoU1QrOTJ3SitIUFEyUT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb0df3-c8c4-4dfc-9ffb-08db777d5312
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:13:55.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4MiNKHDfWZiYUmdIQSZaTfJreKVBuqI40nwNlAQ6cJ1vQ1gIUBXFfWLIBzPLlNl/Iw5aUuzbgbnve8oDdMzuXXWoQ5U99tOQKb+FG2B5eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6179
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFidSwNCg0KSSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcyBhbmQgaXQgbG9va3MgZmlu
ZS4NCkkgdGVzdGVkIHRoZXNlIGZlYXR1cmVzIGFuZCByYW4gdGhlIHNlbGZ0ZXN0cy9yZXNjdHJs
IHRlc3Qgc2V0LA0KYW5kIHRoZXJlIGlzIG5vIHByb2JsZW0uDQoNCjxSZXZpZXdlZC1ieTp0YW4u
c2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo8VGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWpp
dHN1LmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KU2hhb3BlbmcgVEFODQoNCg0K
