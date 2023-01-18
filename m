Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC467200F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjAROrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjAROq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:46:57 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F591554D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674052780;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=61deY8fdjKe37EO7vaHkGmNrWpN4ki2JTcLxXAhuSh0=;
  b=XHuL75qP7upg1UGFfAskfvxaTC9yZ3hTzfmxllVQaIpj0aFygw2gOYIZ
   HY9eNZndfzO5RbdxI0KyjqR27pgnYagGkvINZUJqwvju+i3uS3QXj98+9
   zBaSJ03d6mpJSjDoExDFHvIbNWLk75kbNh+N9W2U6ZmcCOOkle9Bg2ezS
   Q=;
X-IronPort-RemoteIP: 104.47.55.170
X-IronPort-MID: 95631096
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:F944uK5k8YLCGQY26KnZNQxRtLvGchMFZxGqfqrLsTDasY5as4F+v
 mYaUWDQOPqJNGHwfI12PInn8k0FvpXTzd9lTVdu/is3Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraBYnoqLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+45wehBtC5gZlPakS7AeC/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m0
 sAaMS5SYRC/qM3v/aiUcdkyoe0EM5y+VG8fkikIITDxK98DGMqGaYOaoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooj+CF3Nn9I7RmQe18mEqCq
 32A1GP+GhwAb/SUyCaf82LqjejK9c/+cNNPSubhrq806LGV7nUwIhsXUWOpmKiWj2W+Z+lRD
 k0w/BN7+MDe82TuFLERRSaQrGGBoUQ0WtxeCeQ25QiBjK3O7G6xBGceSSVaQMc7r8JwTjsvv
 neShM/gDzFrtLyTSFqe+62SoDf0PjIaRUcSaClBQQYb7t3LpIAokgmJXttlCLSyjND+BXf32
 T/ihCw/gagDyM0GzaO2+XjZjD+24JvEVAg44kPQRG3Nxh92YJ6NY42u9ETB6vBBPMCVQzGpp
 HEZn+CO4eZICouC/BFhW80IFbCtovyDYDvVhAc1G4F7rmv1vXm+YYpX/TdyYl9zNdoJciPoZ
 0mVvh5N4JhUPz2haqofj5+NNvnGBJPITbzNPs04pPIXCnStXGdrJB1TWHM=
IronPort-HdrOrdr: A9a23:8+eV+6qgFgLfXwr+u7ODOZAaV5o6eYIsimQD101hICG9E/b0qy
 nKpp9w6faaskdzZJheo6HjBEDtex3hHP1OjbX5X43DYOCOggLBEGgI1+TfKlPbehEW/9QtsJ
 tdTw==
X-IronPort-AV: E=Sophos;i="5.97,226,1669093200"; 
   d="scan'208";a="95631096"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 09:39:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYtObBzAErfhzWLRoU/BRdEM2HGB2Fby/gdhEfNYAvzhIc7NfOPMzi9sXjboG8RjE1MmtJif5iXLNNhk7l+IG9I0BzrXAsU2zO8a5cLQya37nnUrmrHiX47ovmiUp6c+8nBuoxD6FNwEL0792S1TJGyAxXdQ9yB3f0kw4wfgmqL/STv9G49Ax4PYGiXT49VC5VAHgl0nFirepJTnZqb6WyCfTRFiejnL1jC+7YmqphAtXZOOYJLquFOGdOfA/wmQRe28dWtBvrpKgOJDPrQsBRitG5CpkPsI1hM3lgSeGOIbRYgebnd0luYFBLS3paJqvmz9XkybLtdfNErFV63oGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61deY8fdjKe37EO7vaHkGmNrWpN4ki2JTcLxXAhuSh0=;
 b=Xogm+ldjUb2QajbICSw5eu6/rScHnjazDs+1yK8pFl1xMo1QjT11Y2mMR2PgoDdOKxORmj4L/o3aWdBRv1ugsaMS/iFd0wqqahe3kWl8aDCtfS/8ueAkwp8pjHAjADPr/JS6el1vMRCziI1Okvg5zJ0ngN9YxTnD/hxGcAf6BBLuTokQXLn1+x3QbHDAdRvvzofAD1SXxGL4SZOQ1skWJsiCmIjP0NrMxBISYxY5+LQ37sRovdDTlt3H7yrelGUu7pnbL6YQow7SaWYbxlvAJQ4LzccU9zq/h+Hpc18W6oIzQrHFXhP6+BUppx52fPdNcmpq5SQrZkv395iJtsG1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61deY8fdjKe37EO7vaHkGmNrWpN4ki2JTcLxXAhuSh0=;
 b=R+A5chSNAgwIige+VZVtP5GhG1G95gebmVuYtTXx0us8ylDvbgmJSNvTmXbQpJE9L6xsABbzAv5yJEwY+WodYwN8HLh6GsFzpEb4LAp6pRK6GvJNLjD3JL5E8uqHxdJ5fRAgyUon8jGHFLnHQPJZcr40k8Pz5RMMV8YtqvI8mf0=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB7009.namprd03.prod.outlook.com (2603:10b6:303:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 14:39:34 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 14:39:34 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] xen: Allow platform PCI interrupt to be shared
Thread-Topic: [PATCH] xen: Allow platform PCI interrupt to be shared
Thread-Index: AQHZKze3xTuOiK3Or0K7Zn5gBYHKJq6kMguAgAADsQCAAAR6gIAAASeAgAADj4A=
Date:   Wed, 18 Jan 2023 14:39:34 +0000
Message-ID: <d45d172b-0d9e-a45c-36da-3ed42c909081@citrix.com>
References: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
 <e0b75988-bee6-e0c7-0dda-86e1e973ba74@citrix.com>
 <82e6a68f3cb8c0e440f7dc848fa3444725b3f893.camel@infradead.org>
 <973f9ebd-173e-6753-7799-a660994e38de@citrix.com>
 <1ce5f5501214f1073f4eb86b2fdf3f54b2400057.camel@infradead.org>
In-Reply-To: <1ce5f5501214f1073f4eb86b2fdf3f54b2400057.camel@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MW4PR03MB7009:EE_
x-ms-office365-filtering-correlation-id: 40c97fb7-4f73-4891-1ff0-08daf961d11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdW5bcYI21j9qKVFerOK9WaaURx58f/p9lO73chpuVgVQQZSnOaHSJTVfFhSsGvbPQkeoqAHUJKoXJ60JIQQqiBYfdhPOKLoLxMXyYyP79nUTMK71GUmegyM2B2vnH+yLACXevI2q00Aa5kZPrAcArETyAr2DYG95Fmusi0M3p/Iji78tFpsdPdQJUFYAUae7DoxBdWrCQ4ry4OebBG7INn/W6doWhbwj4M0TwySoNNpfVfw8jeRw9lP8XVBOy538z8o5TA4AYjJu+4iYsucMfcsv+El/IdcO6vvuMdepRvgZflMgZfBh+nC3dKW4QoQzGjD5vobuUZg4eE+QbAqlyjvFxxztxqL4mbX1BPylMiiFD5dJVuqpfnK8+qiNf+uhdAna8tf1al8UJl3FU8M6wuthky/6rO8qrfWf7J/r/tSttFvLxyyg/8dTO9jcaDP0p5mOJOBYPEWz6txqk/AH++b07TAxdqiB+WVSap9dZez8ScQ3n+qVFd2sWy6vVeiRY8Ruw63kvs7cFqdLBsjvgwfRr9pYZumrO/rsAofABoJPVzlnb+KR0uDZQkWKvKBYAQwGHqU1xnkdthF5yOtgvcuWOxvfJ/VdMdOlxBqC8TSoZQTq995Suq+liWJN96GlIwkX8ILpELzQz5h4pTh2d4uoyPfIwKw8EacrXAZZAVvy8+KlKKAKFQy1bxxNN9M8G4IgTOctVX9Ti9eDvnI1/zA+V4GGbarwCdgzg6aIZLN941QpHLJLmBFZ/ICw+N0tDPw2W7JN7beS0U0DSDxVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(83380400001)(82960400001)(38100700002)(122000001)(86362001)(38070700005)(5660300002)(2906002)(31696002)(66446008)(8936002)(66946007)(66476007)(66556008)(64756008)(76116006)(91956017)(8676002)(41300700001)(186003)(26005)(6512007)(2616005)(6506007)(53546011)(6486002)(316002)(71200400001)(478600001)(110136005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmQrWTFDU2tmeFRvOHIwcXhKam5Ibjk2VVY2cUFpaVkxK0JYQ001UktvTGxv?=
 =?utf-8?B?alBwZk9YUGNMSkRDUlJTclFjekNVdHN4ekZLNWtMOUtuSzhRM294bDJHYmw1?=
 =?utf-8?B?K0JrbXZKU0t6YmZSSW9laXBYdTNkbFRTVFJrai8vQnBGUDBDcHl4c0NZR1JG?=
 =?utf-8?B?SUU2UGd1dHFKdW5TTDZHSTlVamJ3c2V5K2lSRVEzRlRmWG9tZmV1OS95cVdY?=
 =?utf-8?B?TlEvQ1cyS2svVnVYelhoVG4yZTdmR3ZpWlJ1VU9NTnlXVm9xa3Bwc3NTaWVm?=
 =?utf-8?B?b0tMMy9qZ1RBRHZ6Y2Rad1hYcG1GVTJPNlRpakN2OGVVL3crZDB6Nml3dE5n?=
 =?utf-8?B?anpMbkJ2MTJCWVZRa3hOZWp1R0lmUE5EQWwvUm5NNjRRUzcwV0dZMzRvVExY?=
 =?utf-8?B?d1VNTXAxZWJ5NXlmNmhhVFdpRW9sWXNXWUI3QURhLyt6ZFg4cDJBMEtjRnVP?=
 =?utf-8?B?Mlg1U3hTRFcrRzBtQ3FoaVBTOUE1SVFHYmxmUkZNbHduYTJjKzljREJwTUhI?=
 =?utf-8?B?dDIxL3dSK1ZhZGk1V2JnMU5aMWdlT1c3bHgwckViTExvUWNvakpqOTFCOS9t?=
 =?utf-8?B?cm10LzdYd2lFTVdFelIxVTdXYnFoL0lGK2prY3ZScldZQmxjdFliUE9McDc5?=
 =?utf-8?B?cHl0UGhjeForaWEycUVQY2dmajBsZE5QaHJJLzc4ekphSVA1amFPRkR6U1RR?=
 =?utf-8?B?NG5EZXJRbmwyVVZiaFVUeFQxK1dvNDllVWpkRC80UE9GaFFJZ3NTdWRBQkxB?=
 =?utf-8?B?YXBva0tZOGt0U293eE1iMjUvQ2xOTDYwbTIzRnB2Z1Jkd1FDa1cwTmlxMi9h?=
 =?utf-8?B?ZWhvVHluVk9VNmIwTENBdnF3MzYrRDVBeFNIeGJBS255TWFJS1BFRnI4Umg0?=
 =?utf-8?B?Qk9MRC9uYnhiSCt6VENWY2Nsd3N3c3NSZDJ1dWl0UUdyMTIxRDl0UkdaWWxC?=
 =?utf-8?B?ZVR1eG85a2ZpWm03YlArUXVrK0I2d3NhUldheHdqL0RBeUtXRWR0am1Wb3lr?=
 =?utf-8?B?MHBxNVRLY1FSVjhFWm0zZFlOOFlqa2dqdGhxVUtaUXoveDJlT1Q3UURqY2ll?=
 =?utf-8?B?L3JHWm11ZEVjNDhzQzJiUXBvVWlLSEozM05LcVRzM2IvSXBIRnMxNk5KZU9Y?=
 =?utf-8?B?WFpRNWk1SjlaU0NKc3ZyVjlpUTU0U2o4VkNYWTBhRGNISlpWV3BTd0F4bWlE?=
 =?utf-8?B?Q09EZitCdFIxdGozbkV3RUNLYjZvazQ3aVVaZlppOWZQV2Iwem5scEsyRmpw?=
 =?utf-8?B?bHVicEptU1RLeExpeWJybUQxS2dJaUNPZHpBWG1oOWtKbUNyci9GSmsrTkJs?=
 =?utf-8?B?aG9RTVN5dnYzSmpYYms2Z0lFZ09wekdNVzFUbUF6bWR3aHIrWHVRTzlQWUt3?=
 =?utf-8?B?QnlHMyt2S1JnbG43VTUrSDdNTENqMFBqcDhOMUx5bjN2M2xQRDhiWVFjTk9y?=
 =?utf-8?B?ZnZvb3V5Ym5JSGloZnJOV3dXNmEydWZjVkFpOE9jdDkyL3JpTHZsQkNxQ2Yy?=
 =?utf-8?B?dFVUT1ZYNlBrV0UyNUV6S2NZYmJQVlBZUldDT1gvdGg4aHZKb0hvWlUwZ2xv?=
 =?utf-8?B?NUhXbEh1T2ljK01ob3JrcGgxaXhkSU9tbDAwRS9xemZtZDVXSHZGMmlWZ0ZX?=
 =?utf-8?B?TjdvaTh2bmN2cEMwTkNzVDlnMDk5TU9GUm4vSk92RlB5RER6RzNneUtSSHRx?=
 =?utf-8?B?bnVIcDZJZEMvSStHK0lwMjB1RmljZUJSYkxNZkxrcUtLU3ZWTHg3d1BXTk1S?=
 =?utf-8?B?QkhJRTNsUGxiWjkxSy9QQkxCSjhMcU9NWmJiMTNBRkNGYmk3L1pTNldHMDlK?=
 =?utf-8?B?N0ZpRnFSQ0lsbFpMMGt6MUIvamMxb0ppNm1PbGtTdmFqNHpZN2VqUkdka1pM?=
 =?utf-8?B?dWQwTEo2emhYNU4rMkVXWTBsdEVZN1ljdEtmYWpvbzFqUWlYcnd3K2s2MFpJ?=
 =?utf-8?B?Q1hDTXJCQ21EamRIblZwdTRJL1JBVzA2OEM0ZUtWNnBJUVh4cUJ5YnNEei9N?=
 =?utf-8?B?NmFSeE8zT2ZWSHRiY094bTcvdDIwWHpYbE5LR3BzNThaQ1NTTjRsTGVaSTJa?=
 =?utf-8?B?cXpLYzlBSmVaYjVSSnFwVCttSDZoYWxHQWN6KzRWUmNmcEZwckViRm5UVGxG?=
 =?utf-8?B?bklpVXU4SmsxczcrZWt2cTNLN0xxUmFldTAybXJ2bFFaYjJadnptVGhxV3do?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61457CD15239A6488F6F48B7395ECA29@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlppaG5zYUFUWi9MS1Z0bEovL1JsbThUc0lLdDZkc3U5ZTJDb01ndDREM1VZ?=
 =?utf-8?B?dGlHaFN2T25BSXMweEVZanV4TUtwNWR2UDZrNFJ3c2F5VlZGenZTRGZMU1NU?=
 =?utf-8?B?TWdPMFhVdW81SThzendNTlB2U3p0S1VwZ3p6cUlxS2NJTElHTzlNSWQxMXZU?=
 =?utf-8?B?QVcwSWNLbUhzUHVscERqbkxHOUwyNUlHd2RXN1p2aWowL2cyd2wvdVpKSDEr?=
 =?utf-8?B?b3pRRTlRTW8vRitMRzZ1RThlaDhiSGg4eE9jOFRHajZ3c3E3YTdHRDVuWW9l?=
 =?utf-8?B?UUJmaFkvV0NwMklITlJBZ3Y4RVh0cDhKejJWa0tjRjFCVkxkWnRFVW9jWGxF?=
 =?utf-8?B?QWFaQ0Fia29OVGowZGNUZkFlTEhQaFhKNSt2VjRFRXM1SDAwVjM2TVlLWk40?=
 =?utf-8?B?R2RvTGZaMlRHbUViZGg2M2hHQUJ3ZWpLWlo4cGVmaGtlbGxXWVZuOUhSWTZv?=
 =?utf-8?B?UlhoZ3dFS241U0x0ZDhVb0pSNXExMlY5QWtFUlNKM0F4bFF2ajJKUThNUUpP?=
 =?utf-8?B?Snc4dVB3L3BoNjFVOFFYOU1DUEVDYitFM01idUZyYUlQaDcrUVJNUGZFL1F1?=
 =?utf-8?B?dkxNdDhwYUliNm1sUUF1R3Y3VlNTK3lzSjMwRDBrK3laMkhROWtTVjllMk15?=
 =?utf-8?B?WGorSG1ERmxpYTI1bkxVVW9sTGRGUEdIV2Q5bm1hV0krMHI5M1dFOUN1YkZh?=
 =?utf-8?B?RW1xRUYrRlNRT3RMcGtIa2cvb1V4VkhjeW5WUkJOcVhyeEJxdzJRRzA5VDFF?=
 =?utf-8?B?b3ZoY0pDWm02dUlyQTdrc2pYZzlEcFFjVHRiQ2FabFdkaUtCdXNHd3RZQmox?=
 =?utf-8?B?UWFvMWhWbk51cjNEakhya2lWM01UU3F3SWtnWmFQRXVCSVYvd2Vac1hEWXZ1?=
 =?utf-8?B?ZXkvNGRoT1ZEZTNFWkZmbWRNUWovMXU0Q1FLeUlwY1lqcHRmalhmTTIyKzJL?=
 =?utf-8?B?alB2QWZVcGhqUEpXdWJ6VzFFT0tTN1BhREsxdDJrR01zQmsxR1ZCNjduM3Z3?=
 =?utf-8?B?VVMzT1RaZWxudFRNQm5SRDBsY3JGZzRGbkpqT2NnckQ0d1ljSU9iM2VUS3hn?=
 =?utf-8?B?cmYzVkp4NDlhL1FOUEVJQS8vUkhzSkVNNXlhL2NpWitpVXFWQzd2Y2JTQ21H?=
 =?utf-8?B?UnBxTFo0ZXBHOWpUMHJFM0dicjZCR2YwYmN2WTVJbkxsM3g0ZEp5bFJaanhR?=
 =?utf-8?B?NkxVWVZHN2hpZ3QxeUZLVzU3ZjYrNUFFNDl4LzR3Vm4ranh3QWdNZXpyYmZp?=
 =?utf-8?B?djJLRVUwSFVEN1FUcXRodTlKZE41NWJ1NVp6R1E2OHlVZzFSQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c97fb7-4f73-4891-1ff0-08daf961d11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:39:34.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLmRLSVwf9ilcHo83jkWQeWMgw8vHZN5yRXqwTekivdeBR/csi/Y/ksk8OlrGWk+pzUzKhxjd87ziF/FTaJJ8Wc/usZ19ZToDIZCBUSAbAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7009
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDEvMjAyMyAyOjI2IHBtLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+IE9uIFdlZCwg
MjAyMy0wMS0xOCBhdCAxNDoyMiArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+IE9uIDE4
LzAxLzIwMjMgMjowNiBwbSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOg0KPj4+IE9uIFdlZCwgMjAy
My0wMS0xOCBhdCAxMzo1MyArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+Pj4gT24gMTgv
MDEvMjAyMyAxMjoyMiBwbSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOg0KPj4+Pj4gU2lnbmVkLW9m
Zi1ieTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4NCj4+Pj4+IC0tLQ0KPj4+
Pj4gV2hhdCBkb2VzIHhlbl9ldnRjaG5fZG9fdXBjYWxsKCkgZXhpc3QgZm9yPyBDYW4gd2UgZGVs
ZXRlIGl0PyBJIGRvbid0DQo+Pj4+PiBzZWUgaXQgYmVpbmcgY2FsbGVkIGFueXdoZXJlLg0KPj4+
PiBTZWVtcyB0aGUgY2FsbGVyIHdhcyBkcm9wcGVkIGJ5DQo+Pj4+IGNiMDllYTI5MjRjYmYxYTQy
ZGE1OWJkMzBhNTljYzE4MzYyNDBiY2IsIGJ1dCB0aGUgQ09ORklHX1BWSFZNIGxvb2tzDQo+Pj4+
IGJvZ3VzIGJlY2F1c2UgdGhlIHByZWNvbmRpdGlvbiB0byBzZXR0aW5nIGl0IHVwIHdhcyBiZWlu
ZyBpbiBhIFhlbiBIVk0NCj4+Pj4gZ3Vlc3QsIGFuZCB0aGUgZ3Vlc3QgaXMgdGFraW5nIGV2dGNo
bnMgYnkgdmVjdG9yIGVpdGhlciB3YXkuDQo+Pj4+DQo+Pj4+IFBWIGd1ZXN0cyB1c2UgdGhlIGVu
dHJ5cG9pbnQgY2FsbGVkIGV4Y194ZW5faHlwZXJ2aXNvcl9jYWxsYmFjayB3aGljaA0KPj4+PiBy
ZWFsbHkgb3VnaHQgdG8gZ2FpbiBhIFBWIGluIGl0cyBuYW1lIHNvbWV3aGVyZS7CoCBBbHNvIHRo
ZSBjb21tZW50cyBsb29rDQo+Pj4+IGRpc3RpbmN0bHkgc3VzcGVjdC4NCj4+PiBZZWFoLiBJIGNv
dWxkbid0ICpzZWUqIGFueSBhc20gb3IgbWFjcm8gbWFnaWMgd2hpY2ggd291bGQgcmVmZXJlbmNl
DQo+Pj4geGVuX2V2dGNobl9kb191cGNhbGwsIGFuZCByZW1vdmluZyBpdCBmcm9tIG15IGJ1aWxk
ICh3aXRoIENPTkZJR19YRU5fUFYNCj4+PiBlbmFibGVkKSBhbHNvIGRpZG4ndCBicmVhayBhbnl0
aGluZy4NCj4+Pg0KPj4+PiBTb21lIHRpZHlpbmcgaW4gdGhpcyBhcmVhIHdvdWxkIGJlIHZhbHVh
YmxlLg0KPj4+IEluZGVlZC4gSSBqdXN0IG5lZWQgUGF1bCBvciBteXNlbGYgdG8gdGhyb3cgaW4g
YSBiYXNpYyBYZW5TdG9yZQ0KPj4+IGltcGxlbWVudGF0aW9uIHNvIHdlIGNhbiBwcm92aWRlIGEg
UFYgZGlzaywgYW5kIEkgc2hvdWxkIGJlIGFibGUgdG8gZG8NCj4+PiBxdWlja2ZpcmUgdGVzdGlu
ZyBvZiBQViBndWVzdHMgdG9vIHdpdGggJ3FlbXUgLWtlcm5lbCcgYW5kIGEgUFYgc2hpbS4NCj4+
Pg0KPj4+IFBWSFZNIHdvdWxkIGJlIGFuIGVudGVydGFpbmluZyB0aGluZyB0byBzdXBwb3J0IHRv
bzsgSSBzdXBwb3NlIHRoYXQncw0KPj4+IG1vc3RseSBhIGNhc2Ugb2YgYmFzaW5nIGl0IG9uIHRo
ZSBtaWNyb3ZtIHFlbXUgcGxhdGZvcm0sIG9yIHBlcmhhcHMNCj4+PiBldmVuICptb3JlKiBtaW5p
bWFsIHg4Ni1iYXNlZCBwbGF0Zm9ybT8NCj4+IFRoZXJlIGlzIG5vIGFjdHVhbCB0aGluZyBjYWxs
ZWQgUFZIVk0uwqAgVGhhdCBkaWFncmFtIGhhcyBjYXVzZWQgZmFyIG1vcmUNCj4+IGRhbWFnZSB0
aGFuIGdvb2QuLi4NCj4gUGVyaGFwcyBzby4gRXZlbiBDT05GSUdfWEVOX1BWSFZNIGluIHRoZSBr
ZXJuZWwgaXMgYSBub25zZW5zZSwgYmVjYXVzZQ0KPiBpdCdzIGp1c3QgYXV0b21hdGljYWxseSBz
ZXQgYmFzZWQgb24gKFhFTiAmJiBYODZfTE9DQUxfQVBJQykuIEFuZA0KPiBDT05GSUdfWEVOIGRl
cGVuZHMgb24gWDg2X0xPQ0FMX0FQSUMgYW55d2F5Lg0KPg0KPiBXaGljaCBpcyB3aHkgaXNuJ3Qg
bmV2ZXIgbWF0dGVyZWQgdGhhdCB0aGUgdmVjdG9yIGNhbGxiYWNrIGhhbmRsaW5nIHdhcw0KPiB1
bmRlciAjaWZkZWYgQ09ORklHX1hFTl9QVkhWTSBub3QganVzdCBDT05GSUdfWEVOLg0KPg0KPj4g
VGhlcmUncyBIVk0gKGFuZCBieSB0aGlzLCBJIG1lYW4gdGhlIGh5cGVydmlzb3IncyBpbnRlcnBy
ZXRhdGlvbiBtZWFuaW5nDQo+PiBWVC14IG9yIFNWTSksIGFuZCBhIHNwZWN0cnVtIG9mIHRoaW5n
cyB0aGUgZ3Vlc3Qga2VybmVsIGNhbiBkbyBpZiBpdA0KPj4gZGVzaXJlcy4NCj4+DQo+PiBJJ20g
cHJldHR5IHN1cmUgTGludXgga25vd3MgYWxsIG9mIHRoZW0uDQo+IEJ1dCBkb24ndCB3ZSB3YW50
IHRvIHJlZnJhaW4gZnJvbSBwcm92aWRpbmcgdGhlIGxlZ2FjeSBQQyBwbGF0Zm9ybSBkZXZpY2Vz
Pw0KDQpUaGF0IGFsc28gZXhpc3RzIGFuZCB3b3JrcyBmaW5lIChhbmQgaXMgb25lIHNsaWNlIG9u
IHRoZSBzcGVjdHJ1bSkuwqAgS1ZNDQpldmVuIGJvcnJvd2VkIG91ciBQVkggYm9vdCBBUEkgYmVj
YXVzZSB3ZSdkIGFscmVhZHkgZG9uZSB0aGUgaGFyZCB3b3JrDQppbiBMaW51eC4NCg0KfkFuZHJl
dw0K
