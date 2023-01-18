Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFF671FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAROej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAROeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:34:08 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03284DBD8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674051765;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+sZbL7fRbpTAv6J497fVGDtB8o3ODgLCHg183tsTS64=;
  b=ezbImeZOR0CfVxFbDQjF9BT4Jk5ZLo9U3KDS6HJHc76MqN5/VfjG3nX9
   z1RVm2iAX1Adg5oFp2hyizVcv3t4Tcadk8ueZA99mXh+PRSN6G2XqKt3v
   CEtHFPYfVQDWCCZxpvHeEoiXUOF93M001czgYKcijUhdF5dTuuQCzqzHI
   A=;
X-IronPort-RemoteIP: 104.47.70.108
X-IronPort-MID: 93213683
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:nf2mxaDGZUJehRVW/6riw5YqxClBgxIJ4kV8jS/XYbTApDJ2hDNRz
 WMbDWjSbPeLajf0KtwiYY2y/U4HuMOEytBgQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nNHuCnYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtMpvlDs15K6p4GpB7gRiDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw691dUEQRy
 PYkMSkLNxbcpfya6paFc7w57igjBJGD0II3nFhFlGmcJ9B5BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTK/exuuzi7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prr6Ux3qgBtJJfFG+3uZRhwaMw2c9MhRMDFe2nOC0jkyTdfsKf
 iT4/QJr98De7neDQsb4QEeQoXiKpBcQVtNcVeog52mlyKXO5B2CLnMZVTMHY9sj3OctXiAj3
 FKNm9LvBBRsvaeTRHbb8a2bxRuiNC5QIWIcaCssSQoe/8KlsIw1lgjITNtoDOiylNKdMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzhnYWnKN6gJ/eZK/YIqp+R7X4J5oNI+ESnGRs
 X5CnNKRhN3iFrmInS2JBe8LQ7eg4q/dNCWG2AY/WZ486z6q5nivO5hK5y1zL1toNcBCfiL1Z
 EjUukVa45o70GaWUJKbqrmZU6wCpZUM3/y/PhwIRrKiuqRMSTI=
IronPort-HdrOrdr: A9a23:OSrXA66vssb6filftwPXwMbXdLJyesId70hD6qkRc3Bom6mj/P
 xG88516faZslgssRMb+exoSZPgfZq0z/cci+Qs1NyZLWrbUQWTXeRfxLqn7zr8GzDvss5xvJ
 0QF5SW0eeAb2RHsQ==
X-IronPort-AV: E=Sophos;i="5.97,226,1669093200"; 
   d="scan'208";a="93213683"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 09:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVJGqGghpa5RvgI7rnWIA0cOmdMyL1fpKXS8q9oToljuQ14FkiKfVzhfb/yCpaU3XwXBYO1BdlR5iRlFOAxtNXCZVARgrNfG1XdLoycLZiGKZWIhGVc6ola8/g+NOxw8Z4ZQqTS65f5TlzNQ/eEXQUbUPApumh80dDowDUmv1U14RwPKIqh06wkdhnxIE2HWqN+ooaj395rCmbsuXj2mjOdl40Oh0mFVEJ/OrNfajSNmuI0L24l5RB0A56VFkQ6HSk+P+6y/T93YAg3zjheSw9S0ey4HhFBG905AMQF3X8YXb4L4pHMpiYtqe7wZIYt1DdLNyR+kOeKm0Rrd0yXh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sZbL7fRbpTAv6J497fVGDtB8o3ODgLCHg183tsTS64=;
 b=P/uIzgkoFi3VfcV23OI3RJAw7JXW3IfYFHE8S72d0TCPiVAs50HaH8fV4n5v9z4+u4VCqDVE0kuaB20QqjPkzuJAnCrOLMjHcirSWwZIvKTyoJGGY2lgsJHsTJuTXGYqI32ArbwRNat5l6Z70fNVopd8gC5opoZ0g2XROxoPIECHD9twFml6miYhN6gSdVqtivy/0qODTjCUtTIiqjb1PkpavzRIh9dGJRklz16MC+X2nKrmNFHTxpdihW8WjTpn/7bFnVNzl6uRKc1W2JvtOrrkBLn3DX93rN66uBdO/Yru//kG4vyFT4sdZqDcvTRDIWcBUaPCVO0vouVHvTJNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sZbL7fRbpTAv6J497fVGDtB8o3ODgLCHg183tsTS64=;
 b=FnuNNuTFDH+coNOA229hs0M7n54HuvDOtqyaqAag3dQoDh4/eSWh2GNmRi0f6AyrXS11XaaWJrV3QSK+OAgXrR0orYiU5sHxYoCCJ9Q8dg6cRU+cJUkpmQ3FVRqt32qTMgDMi3bBO1LP/C/mBY5X3nbN5uwNbAhKXKA2rwT9JSI=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CH2PR03MB5336.namprd03.prod.outlook.com (2603:10b6:610:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 14:22:42 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 14:22:41 +0000
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
Thread-Index: AQHZKze3xTuOiK3Or0K7Zn5gBYHKJq6kMguAgAADsQCAAAR6gA==
Date:   Wed, 18 Jan 2023 14:22:41 +0000
Message-ID: <973f9ebd-173e-6753-7799-a660994e38de@citrix.com>
References: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
 <e0b75988-bee6-e0c7-0dda-86e1e973ba74@citrix.com>
 <82e6a68f3cb8c0e440f7dc848fa3444725b3f893.camel@infradead.org>
In-Reply-To: <82e6a68f3cb8c0e440f7dc848fa3444725b3f893.camel@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|CH2PR03MB5336:EE_
x-ms-office365-filtering-correlation-id: f5a68534-ff2e-493d-4e36-08daf95f75b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTCryijanJ9I6oNGT3reIDNxPpMOMv4I/rCFXOaxAoZI56FH+crDLiPKhXVqK5K0mzWxGKZefUIb1efPC4WmNL+bshq90/GdHbcRLVkHbWCX3kNj2QHtn/FpYzBK35oNMeLO9K79DoZgRYvSlkEiHbjeMPCExU+TDc8FDl4lZG4QzxZFYxW1KMuPEPgKcWeiKdYSVFLyUaNYWDaDL0ma9oJW+rs9ReWXqWW/iVC5HRIjW+xeII9mwq/oSALtwfqpkJelSXHT8qvvMTdsK749shADfOBygfIA1Kzk+k+W7oVgsJHlTJ44w+plt6L6WSZI+Nf8FHtGnXHAoHlldnymIBVQ8ar6hoTe3ykc00BSSy8zpd//ePHvxjTjcuWIiIShlbDaUITHkHou97EPjAY9h1d+6DuvBCaETOao7tFGR+AmSTSfMaCsLCiqN4ftEHWykDpkSXgCUJZOLu7f/FnXGUBmHCS0gP9fzuOFiUkfBrgM2oRdT1jDNfzB7Yph6l2DdL9Bebcbt+pcKyVdBm9COKC0xi54dNopCLpY91xAeaa5ZGBcZiAYaXI+yWupc9tniNWEi6hbENJZZk59x8+yTcbdlEULxhkDkhB5T4o+VHy1hxv0hRrOnIRgfmdaeNqno47VCAMtMpB7WyJUhrx11xmyq8lOTtza3KZcV76JdJE6jFRaGaPBdh6bKO36NlfoY7WdCUWCUQXu49tdJ2HtVhJa6W4/D8mMAejYKBCbIOwZ2QWy6lEJseNxUpO4+edbIMnk53V6BJnDiRiniVHqWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(36756003)(64756008)(8676002)(83380400001)(31696002)(86362001)(41300700001)(53546011)(186003)(91956017)(26005)(66476007)(6512007)(66946007)(76116006)(66556008)(66446008)(2616005)(316002)(71200400001)(6506007)(478600001)(110136005)(38100700002)(122000001)(2906002)(38070700005)(6486002)(82960400001)(8936002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXhpbnlSYjB1TG1YTWVyenBHSUwyZ0wySlhMVU9MZ0M4WXVwVE1YSmRyL2dJ?=
 =?utf-8?B?ZVhQdDk5S1pXMzNiZjNtd1VtY1dJak85aHpYZjJKUFFqVm5mVEk0My8xb0ls?=
 =?utf-8?B?WlUxdnBORTYwZkJBbHRWWWhIUFViUE1oKy9VeWtuY20rYmtNUUlBRHNtQkll?=
 =?utf-8?B?eHBPL1Vra2xlSS9BaHJ6Z0VNa1drd3FQV1RyeEEvdUVKVTJvZE5UZ0NqSmkx?=
 =?utf-8?B?SXpzSEpyS05uTnpxTGwwQUNsRzh0Z25TbzdIa0JRZU1ISVVFWEM5MERTVWsr?=
 =?utf-8?B?aDZzWE1BR09EZndMTHZpeEVDNklXaWxuVWdjUnN3WEhGcjBqZ3AwTjAyVG1N?=
 =?utf-8?B?TzB5ZHVZQUQwbmhHaGU5Yk5BVzdEczl4TXpReTBCVHRvbnF6cTdpK0sySXJW?=
 =?utf-8?B?bjRnbktrMjVGWHNIY0xLMkNCdjZpSEdwTy91d2VpOFZOS21GSmpzR1RjTFlj?=
 =?utf-8?B?SUdxNUEwS1RVenJ2OUFJNldBMVhoaUpXcVhpTm1vZnppOWVldnpVclo3dnlz?=
 =?utf-8?B?UEhleFEzSlQzUG02dWQ1Rzc1c2xtWUpIVFZsajVOeThHM1pwbWVwSWJQUm1Y?=
 =?utf-8?B?TzVvb2p3VjMxTjRoREtxd0s0SW4zUjVGS0xOYkJLcVFaQ3dWQ3pFaUZLK2sw?=
 =?utf-8?B?bmMvQTVoTTVDbUNtRlU2TnRKTmJKVnhhOUppNXJRZitIRTBTOHlBOHBrNVdW?=
 =?utf-8?B?dTRFaE5heTY3dkU3cVV6bWZPWTg3QmovZ05xRy9yWi82KzFHY3ZlcTB4MlV4?=
 =?utf-8?B?OXpTVFhRYWJ1cXFpKzRBbWgrR0dwYnNnUjlkQXZtWXdsOGVjdXdYRmx6Ym1j?=
 =?utf-8?B?VnI2QXhOcWlQVTJpa1dKR2RWSytYNUw2RWZhV0U2ZUVnTGl4UXhoVVpEa0M3?=
 =?utf-8?B?STZ4TDRocEtLeExaZ2pObnVCRzJoT09WYVhBL2xlSUVOWC8rY2llZEUvWm5t?=
 =?utf-8?B?WjRrOVVHOVBSSmtPV1U0NGNEVkZrd1JkYnZVTmJzMHJ6U0lOQTRORWZSeWJq?=
 =?utf-8?B?K3NqMk96K0NKSU05YXJUdU94WnU4OTczQTJlTzhMTGlxY21JRll3Ynp2NnQx?=
 =?utf-8?B?ZmRkMzU1VVVzaW02RnIvaUJxNkJqMkNmYU13YTRNQWlVNHlOZHoxMHFkQzRL?=
 =?utf-8?B?bWxZUm9aYXpJbUlrU2xHb3EvczRsVGduVndLVEFQQkoyeU51dlphclBHQkNs?=
 =?utf-8?B?ZThicTdPNzloZldFdXZtZ1V2SWcwcndKWU13YnNZRjdPWEh1eTRZL1g4ZkNs?=
 =?utf-8?B?cHN5YW1oY0x3aEZOcGFGM21UbmR2VlRXMFVkNEFmeXZneXE3OXNEOEFEVVg2?=
 =?utf-8?B?Q0N2YkFIR3lCWko4N0VGdy9PSGtRT014YTRmOU5IakM3Ni9lVjdzVUkyeTNE?=
 =?utf-8?B?ZnkyZUZac2ZCWFpPTVQxSnowU0ExT1BCaDRpcGlFY2JCTEhjRU9qQndOdS9D?=
 =?utf-8?B?cm5jWDFlbHNtNWRGQVFiOUs3RGpWOEdkV1MvK3plbUJPeEFyTU9TN2c3SUlY?=
 =?utf-8?B?amQzRzlMdUdMUHppVjYyUkRTT25zNmFibHFZYUNldFJ5OVNManphRTQvd0Vx?=
 =?utf-8?B?K3NJM2Z2N1M5RTJNN1R2WTE4Qm5OQVVZRFh1bG1ZMVJOcFFBQUY2dVlsODE1?=
 =?utf-8?B?dFJxa09UNHhMczNKY2s4RmtQR3Q5SG54RW8vOGtBYWRGOVpLRFVvZjRsVnBT?=
 =?utf-8?B?b285cmpnaEhZUTdxeGkvc3pWSkRLRVlqSmdnRkF0UlRyaktzWmoxZDZEeGFQ?=
 =?utf-8?B?MnVHRGhNNEhqbXJoWE9YVGp2d1hCSUpROHQxdlJQVVplL0VBV2RpMW9mYWJE?=
 =?utf-8?B?cmVpUUk1NkNlOVRsM0ZQa2h5R0l0WkVEeU1TcTl5YmVCQkZyYW9NMm5qdkdV?=
 =?utf-8?B?K0N2MmxDb3ZkS3VncjJPbWRzc0pidnFrNmQzLzEyandXZGFFQzcybTR3bExz?=
 =?utf-8?B?bU1BbmJ5dkFCR3plYldOeUplOVk2K0R5R0grcXc5bzNYZmFhL2lwQW5nVDIw?=
 =?utf-8?B?YnpuWUJ5ejdvQ3NDc3dEazhWQTArUlRKSHp1MzcrUnJoZXlaY01hVUZrVExG?=
 =?utf-8?B?OGVVUlovdDRVRld0MkxXVXBGdCtYTTAyaGJXOVprMFJHS0ZxNGM3bTUvK2dU?=
 =?utf-8?B?RitWc2oyWHpiRzlNdG5ZR21xQmsra3E2QndFTCt1M2RCQm81eDRXNDg2c3Bi?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5369FA15838AED4C865011484F15B5A1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OVYxbXFMa1hZdkxNellWU1BnMldER2pRMjhYdGhIN01xcjFhM0k5UnoyaFdy?=
 =?utf-8?B?Z3BzZ1ZhZTlhWFI4UHUrZXF2UHdTU1pWUWhJVXZsQlg1cTNkeTl6TWwyM2pC?=
 =?utf-8?B?MU5FUCs0Y1Y2UVhIeTIyU1JhTUFoSmJKMktyNC9IVElYeW11K1hYUkIrMUFR?=
 =?utf-8?B?OVRlTDcwUExmdVdtS1Z3S1p4bTM4T1c1YWJYeEsxZnRGdERDNGRmREJxeGxu?=
 =?utf-8?B?VU9VTm9LN3FRazNDcEhSNXBNc0pxZGplZFR1VHgyTDIxblljcG9ZS05GTE9Y?=
 =?utf-8?B?Q2JaK01RRUhFVjNPdHdmNDQvWXZwSHBiL1pHR1QxaFVxYUIybG5rZm1ndDda?=
 =?utf-8?B?ZlNid2I5SkFoVG9ycldoa2hxQVdKRnFEeUxsNU10SWtLTDZZNENzNnZDVWph?=
 =?utf-8?B?R0ZDcVNHL0dDOXpOZVBCaUdvTGlnU0plTXJpNkZRTUkyaEFCMTFuaDBPcjVP?=
 =?utf-8?B?L2thRkdrN3NzQklMR2x0K2c2UFlNVVZzZHlVcHlVaWxpT0FXY2xINDNUUVJW?=
 =?utf-8?B?SE9xOGFHTlJQaWlzTGxJY1BHZEtnakFNRVdhS2VVeGp1MGF2SVlReE9VZ29z?=
 =?utf-8?B?M2F3cmhxVlJXN244OGhMenJ3MGxLZDFVWUxVUnEzeG5JeWFWZ2VHbG5lc01R?=
 =?utf-8?B?cUNGY0FtdWFnLytacldaWW94b1Rpa0g1OGRVK3JDQTN4ZUl2L2lYUGE1Kzg2?=
 =?utf-8?B?MFY0OTBuSnpnK0VzQ3R1SHB1UFF0RkdxRjNEbTFLaVNJamQxd1Vza21uQnhB?=
 =?utf-8?B?cHp1czBjYWMycFpkR2FXQ0ZxVVd5aXArcit6L243QTdDcDUwVm0wT3JOSXNF?=
 =?utf-8?B?cVdYRllaWFlNblVxSUJQRFVjM0FJam80TTMybGRzUjlyT1BoY2I5VTJMSXBv?=
 =?utf-8?B?dnBKQ2R2dnp1a3RsdlBFa3N0V09wNnBYTy8vT0EzWHJndzd4Z2RpWGF1TC9n?=
 =?utf-8?B?cU1zK056WmcvSnVMekNZV0MraW0rc2tPTXNNTHRraEpzT1ZmSXJZa2JGdHRz?=
 =?utf-8?B?NE1Fdi9QR2ZNaVNYTkk0WTltNkE2V05Wek16Yzl0TzU0SmJlM0d6M2ZxbXMv?=
 =?utf-8?B?dXk5YmNLMlJYOUFpUDl6UERoa25OUlMxWlZnWDV1ek4wZjV2VFBSZ2wwYm5L?=
 =?utf-8?B?Ylh2aVRIYXhDMG41MVhmZkF1NTRTc1lveVJjSHFwL1BiN0NGOE1TeUwwaFJz?=
 =?utf-8?B?by81U3ZtRFdKY2RwOHBaeCtaT0o3WW5OQ2FxRXlpOE1iNkU5OStOYnh3SDNU?=
 =?utf-8?B?YkRjUTdGK1Y2Sk03Qk5rSEwrSEFmSUdxZngvaXA0RUhkVzRUUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a68534-ff2e-493d-4e36-08daf95f75b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:22:41.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmA2AL/K2zK/c1YPY5PxQUYSVJMhQu6vw0C122AgTIaJedBhKMwFWglriDTnBmg4H1p50aUyYFU3AzbtOZiCOFSFmdpVYthWlvLT0JTbTVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5336
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDEvMjAyMyAyOjA2IHBtLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+IE9uIFdlZCwg
MjAyMy0wMS0xOCBhdCAxMzo1MyArMDAwMCwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4+IE9uIDE4
LzAxLzIwMjMgMTI6MjIgcG0sIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4+PiBTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0KPj4+IC0tLQ0KPj4+IFdo
YXQgZG9lcyB4ZW5fZXZ0Y2huX2RvX3VwY2FsbCgpIGV4aXN0IGZvcj8gQ2FuIHdlIGRlbGV0ZSBp
dD8gSSBkb24ndA0KPj4+IHNlZSBpdCBiZWluZyBjYWxsZWQgYW55d2hlcmUuDQo+PiBTZWVtcyB0
aGUgY2FsbGVyIHdhcyBkcm9wcGVkIGJ5DQo+PiBjYjA5ZWEyOTI0Y2JmMWE0MmRhNTliZDMwYTU5
Y2MxODM2MjQwYmNiLCBidXQgdGhlIENPTkZJR19QVkhWTSBsb29rcw0KPj4gYm9ndXMgYmVjYXVz
ZSB0aGUgcHJlY29uZGl0aW9uIHRvIHNldHRpbmcgaXQgdXAgd2FzIGJlaW5nIGluIGEgWGVuIEhW
TQ0KPj4gZ3Vlc3QsIGFuZCB0aGUgZ3Vlc3QgaXMgdGFraW5nIGV2dGNobnMgYnkgdmVjdG9yIGVp
dGhlciB3YXkuDQo+Pg0KPj4gUFYgZ3Vlc3RzIHVzZSB0aGUgZW50cnlwb2ludCBjYWxsZWQgZXhj
X3hlbl9oeXBlcnZpc29yX2NhbGxiYWNrIHdoaWNoDQo+PiByZWFsbHkgb3VnaHQgdG8gZ2FpbiBh
IFBWIGluIGl0cyBuYW1lIHNvbWV3aGVyZS7CoCBBbHNvIHRoZSBjb21tZW50cyBsb29rDQo+PiBk
aXN0aW5jdGx5IHN1c3BlY3QuDQo+IFllYWguIEkgY291bGRuJ3QgKnNlZSogYW55IGFzbSBvciBt
YWNybyBtYWdpYyB3aGljaCB3b3VsZCByZWZlcmVuY2UNCj4geGVuX2V2dGNobl9kb191cGNhbGws
IGFuZCByZW1vdmluZyBpdCBmcm9tIG15IGJ1aWxkICh3aXRoIENPTkZJR19YRU5fUFYNCj4gZW5h
YmxlZCkgYWxzbyBkaWRuJ3QgYnJlYWsgYW55dGhpbmcuDQo+DQo+PiBTb21lIHRpZHlpbmcgaW4g
dGhpcyBhcmVhIHdvdWxkIGJlIHZhbHVhYmxlLg0KPiBJbmRlZWQuIEkganVzdCBuZWVkIFBhdWwg
b3IgbXlzZWxmIHRvIHRocm93IGluIGEgYmFzaWMgWGVuU3RvcmUNCj4gaW1wbGVtZW50YXRpb24g
c28gd2UgY2FuIHByb3ZpZGUgYSBQViBkaXNrLCBhbmQgSSBzaG91bGQgYmUgYWJsZSB0byBkbw0K
PiBxdWlja2ZpcmUgdGVzdGluZyBvZiBQViBndWVzdHMgdG9vIHdpdGggJ3FlbXUgLWtlcm5lbCcg
YW5kIGEgUFYgc2hpbS4NCj4NCj4gUFZIVk0gd291bGQgYmUgYW4gZW50ZXJ0YWluaW5nIHRoaW5n
IHRvIHN1cHBvcnQgdG9vOyBJIHN1cHBvc2UgdGhhdCdzDQo+IG1vc3RseSBhIGNhc2Ugb2YgYmFz
aW5nIGl0IG9uIHRoZSBtaWNyb3ZtIHFlbXUgcGxhdGZvcm0sIG9yIHBlcmhhcHMNCj4gZXZlbiAq
bW9yZSogbWluaW1hbCB4ODYtYmFzZWQgcGxhdGZvcm0/DQoNClRoZXJlIGlzIG5vIGFjdHVhbCB0
aGluZyBjYWxsZWQgUFZIVk0uwqAgVGhhdCBkaWFncmFtIGhhcyBjYXVzZWQgZmFyIG1vcmUNCmRh
bWFnZSB0aGFuIGdvb2QuLi4NCg0KVGhlcmUncyBIVk0gKGFuZCBieSB0aGlzLCBJIG1lYW4gdGhl
IGh5cGVydmlzb3IncyBpbnRlcnByZXRhdGlvbiBtZWFuaW5nDQpWVC14IG9yIFNWTSksIGFuZCBh
IHNwZWN0cnVtIG9mIHRoaW5ncyB0aGUgZ3Vlc3Qga2VybmVsIGNhbiBkbyBpZiBpdA0KZGVzaXJl
cy4NCg0KSSdtIHByZXR0eSBzdXJlIExpbnV4IGtub3dzIGFsbCBvZiB0aGVtLg0KDQp+QW5kcmV3
DQo=
