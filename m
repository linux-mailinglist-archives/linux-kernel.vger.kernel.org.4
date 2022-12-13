Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E464AC89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiLMAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLMAiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:38:10 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E493BC9C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1670891889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d8cNu26zaUURXM2U4uEPNLLgJFY0VKM32PtL3psCJMc=;
  b=hzSml0IU6E0gNLoCc5Wf/8qeg6XtkmCJpjJZcesm/HIycuh5ux1ZyziA
   1JBdP2xqj88/KBClNId/vtnz1vRo4kxn5O3kZ0QGAtqY9J693iVNMlflQ
   zWD+2b4i8LF01wnKqPwQ4Wbs6AokI4sNFwhRnFn4thQ3Eegxl+yn6VSzu
   0=;
X-IronPort-RemoteIP: 104.47.59.170
X-IronPort-MID: 90503568
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:eL7mLKkpwsalsmvom6fn3+zo5gxnJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJWm7TPavZYTCjfdp/YYqz9U9S7cLQy95jGgZsqXxnFiMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icf3grHmeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE4p7aqaVA8w5ARkP6kR5QWGzRH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 dceE3c9LTKjvLOJ8ZD8ZNRChfsydPC+aevzulk4pd3YJdAPZMmZBonvu5pf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkV03iee1WDbWUoXiqcF9t0CUv
 G/ZuU/+BQkXLoe3wjuZ6HO8wOTImEsXXapDTODgraM00DV/wERKFUwuCHWYiMKbm2elXtBgM
 V0mqzYX+P1aGEuDC4OVsweDiGKLug40X9tWDvEg7weM2uzY7m6xHXQfVmRpedUguMImAyY3v
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJSMVs4fLo4wpiB/LCNF5H8adisDpHhnzz
 iqMoSx4gK8c5eYG3aS28V3dhhq8o5nSVQ8y4EPcWWfN0+9iTIusZojt5V2F6/9FddydVgPY4
 yBCnNWC5ucTC53LjDaKXOgGALCu4bCCLSHYhllsWZIm8lxB5kKeQGyZ2xkmTG8BDyrOUWWBj
 JP70e+J2KJuAQ==
IronPort-HdrOrdr: A9a23:fF5n8aAobIeTFsTlHem555DYdb4zR+YMi2TDsHoBKyC9E/bo9P
 xG+c536faaslcssR0b9exoW5PhfZq/z/VICOAqVN+ftWHd0ldAR7sN0WKN+VLd8lXFh4tg6Z
 s=
X-IronPort-AV: E=Sophos;i="5.96,239,1665460800"; 
   d="scan'208";a="90503568"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 19:38:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNFkCS7V7SOeAs5vB1K6ocPVhnIqPGizVTYp2DRsgl+0w6hcEJyQSEOy2Ux2npeHkuVOx6mPtlHwaODmAF+mWfwwS686CG58yLwm24pe1VtLLljGJNqA0Mlt05hNuUsLdohWvkHenyT+MD/C6AUamZxnKKUpjA0hmQWTLVGUIippgCvHJYT1awzPpANSK5SYaJjjTuPOpRmQtFNxlNhF/Hm964rXLjrbuTCWgPBo+ZXHHjMm/3MDJ8M8PGLRlXvyaT1/1dx4e/Yda4UMxgyHWVNLur86fgrItBROWl8e3vy4MpLuBVUy3Y33/o27PylAfDsnK6gX2yUKHiUHMWwy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8cNu26zaUURXM2U4uEPNLLgJFY0VKM32PtL3psCJMc=;
 b=K+0VtJG5TMLbr1NpWRFEQFHPtgiMOlX5EHon1ua93x91ABviwkoENL29yl//MTQZlYcMgDOQnn704mgSNQPy1cAgUBmRFB//t37AM5YCg3iT20GFBpm3daZAZlR+XPPW69oTnDzVQTNgRTuUFsCLBPQm5TtDDuG5+IwxALfOSDHswYMXhmuEwHDTkUNV5vz7xoRZ9zGmi0U5jPz895l9d9b5fEl6kRDou/qdkyQQMj5Z/cT6yhA3m/zqnG6z+LRPBsCLHSoBqmIGC1ca8IAdsxGH6v09SDr9I/QArxD1x6s/RQ7AxXStifLykzqd+FeggUncmhV8qxIeK8nrxcmJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8cNu26zaUURXM2U4uEPNLLgJFY0VKM32PtL3psCJMc=;
 b=jylGTkgW+D0OpKNcSet2pG9iKj+meJKdV0ObQkFb7a+ZMlWF5ZfCP203AIU3L+f1u67p3Y6WnF1mjssRfcTUjc+vJD1dSxoTUnMOSxDjgJ06R5l9xkbhmfnGcNxc/XPMsI7m0eeLdznNxC4pIZcHVPVosb1wW59ce52wGSDBBhE=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA1PR03MB6593.namprd03.prod.outlook.com (2603:10b6:806:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 00:38:05 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 00:38:05 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Thomas Gleixner <tglx@linutronix.de>, stsp <stsp2@yandex.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: strange behavior with sigreturn() to 32bit
Thread-Topic: strange behavior with sigreturn() to 32bit
Thread-Index: AQHZDoldXeBpss4wCEW07WTmaTS40a5q+T8A
Date:   Tue, 13 Dec 2022 00:38:04 +0000
Message-ID: <f341245d-50be-3b25-e064-5311331f0dba@citrix.com>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
 <87zgbsno9y.ffs@tglx>
In-Reply-To: <87zgbsno9y.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SA1PR03MB6593:EE_
x-ms-office365-filtering-correlation-id: 4747012b-6488-4127-5aea-08dadca24c5e
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdLHa2FPDK51tkIf0vLIPnw53Djz8uV0BTqgRS30Q7WvqdD3Qww91xZNBhMA9n+ts+eu7LPkt8QRXCcE65wtfMluB2YL0v4KCWDzDSPX/U6ixzVCim0/idIGQr+Ta9++KvFxBLt26H7OzMHHMUPgAsC1E9Wdnknj+PVdfhOm+o8NwXEuiWtINDnEZC9N9jJSj4XrXJ/zn/pC426Nt6sqijwt1qLddhogb7RFufrWaLXHM4gk5mMr5Get1R5Seihc0Ep2wbBxrcZ2JiInE3ZxKTCdFVUS6Tm4tERaSjovjjPJh/61KPejx8yJE4HZKz4U8XAb04MWdWR+iKBGEMwm1jt0NU+smnKeec3YtXxCiSrPkLHQl5RJHf9Hvrxwj1dP80wFUeHSnU+NX6uGdDzblwGpB5z6x1SBs4+ylUe+MsqMqwzW14m2Bjm7KZjkQZ/mIn5tjTLqiAVOekru+U+H0ngelY5TGmt7crnsAIS6L7pbsWZMgLzz7U6igny0uZex4PHgTm5sUZyH1ObC9CoQHlRijNLeTCs8V8/0w+dYGNBN5MWU0gsOE1a+4I6l+dJINmb1fVA4h5dmzHNBqz5GUVO8Daup7zagZTXFahElf7H9m94RTGcYbQzV2wM449LWfaCR/UuEGzPswF9kWr9Laav6Yoo9ECV3j6ntJD1Q2cyzzoRqoyjW7x7DztGjOEJxZLijR/yh3WybUD866TLKcoRhfz/LbYlucIHp1V/paULxceHDgcLdaMe6Fl3cwHv+FcDQHoP/L39FjVsLi+ZN5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(36756003)(2906002)(86362001)(2616005)(6512007)(83380400001)(54906003)(6486002)(316002)(107886003)(71200400001)(478600001)(82960400001)(186003)(26005)(53546011)(6506007)(122000001)(41300700001)(38070700005)(38100700002)(8936002)(5660300002)(4326008)(64756008)(8676002)(31696002)(66946007)(66476007)(76116006)(66556008)(66446008)(91956017)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05aTFltckhzZVBvUkswOHdORnltVE5wZGlsUi8xSG5PYjI2ZkI2V3gwVnNF?=
 =?utf-8?B?ZmlqRExYZUQvVlBJSms2L2hyRml3amVFa2s1K240ZTkwbkxhejBKUmJVZ0do?=
 =?utf-8?B?Y0RZNUNtYktMY3diRlYxdlhhSVhoaklURkw3N3FvdEpDVXRBdEd0QW1kdzlz?=
 =?utf-8?B?ZHp1dHZXekJXREFEODQraGhucS8vaDdJdXFMSjlKNFpEMXhWV0k2bkdROFk5?=
 =?utf-8?B?bTNMTVplaFJJUERjelhIOGZFMTRmNTRIaEl5UzRFekFXOFlOSEhGdk1SL24z?=
 =?utf-8?B?ZGxDMHpuVEdxMlZ4SGZCOEFKME1YcDhRQ2IwaE9DYlpyMWppbVFkOXQ0SElo?=
 =?utf-8?B?VlhxRFNjWU9lOWVNc3FEdjMyVlBuSHYrT01Mbm9ENDVqREZxSlRBcFZNaFl4?=
 =?utf-8?B?UUZmdWVRTXJjeDR6N05QdHlaTW9NZlJ1cHhmVFNGVm5oMHV4OUtVN05RTExJ?=
 =?utf-8?B?OEV3ZkZSVGp6L05DNnozZmZxRjVoZytxS3VhUHZmVkZXZlE4OXVjSEVWcE51?=
 =?utf-8?B?QkJnSVdIY3gvS1czSmZYZnJyQm1JbXJWZnZ4Y3dHbXUvbDRjaWpCS2h3OTNy?=
 =?utf-8?B?aFluSmdXVW9Na0tQMGptZ2ppL3NjNDZZblQvQURQLzNDaC95RWFZR20rRHlz?=
 =?utf-8?B?L1NManBoTi9wOG8zZ1h3U3Z0SXk5WldKZi9FTHQ4TUs4Y0lSM0hlKzBiNFVW?=
 =?utf-8?B?cTNTYXByVmxvNWVqYVEzdnVXWjNsT05VeWM2RlRod3BVN01HaVk2bFRuUWJM?=
 =?utf-8?B?UWgvWU9QeWh2ODZpV2RmanhObWV3NUJEcUJtNU1qUmJsV2cwdlNNbW56Vm9C?=
 =?utf-8?B?SVBIL0djWjdoTDdFZlVRYy9oOVgvM2E2dEh2ZTkzN2pqazFidFFFUGpQTVZV?=
 =?utf-8?B?V1MzclFoMlhCMnUvRmp5TXpFTGhXcHRuaWt6WnVBaHFLZ2pyK0xIa25PcElJ?=
 =?utf-8?B?UFkxalZtQmNjQm5HeG50ajBQSFg4dXM1RkNyQTZHckM4Q2NrQnJVblhmb0h6?=
 =?utf-8?B?Y0VyKzJHUmhrRjNRSDR4cTNORXRjZFdUc0tNaGxWNFQ4OU9WanVpdGM1MXNx?=
 =?utf-8?B?elpheEsvbjNnZ29lakpTdzBXTExmUkVZa2c0Z2pqYlVscXlnWTRndlNDdHUw?=
 =?utf-8?B?RTI0dlBMOTFYWHRJWWM2RjlvNk1STlhRcStkYmFXK3luTDlNS25wQVQ1cWtD?=
 =?utf-8?B?R3BoeXJDeE5Ud3pHVTNnWkF5VnZqVVZuc1dFV0xjRkFEeFgreXp1MHJTRVp3?=
 =?utf-8?B?bURoVGx1ZWMwV2dienFtc1AxMHM5MHpLTVdtYWZ5M1FZSWZqcWk4WE1hWEZ6?=
 =?utf-8?B?UFQrempqWjlrSXNzYk0zZldWZU5HYWVwQ0VQYXVFU3QxR3NPV0tjUFJwa05i?=
 =?utf-8?B?bWtUNnZHWk1PNlJtOHlzT3JLL2E5ZEQrRXpSUEFOcFZYZEhQTWpxWHErRmZY?=
 =?utf-8?B?TVpKQ3R6akpORlNWczE1SXlwOERrZG9LdkdSem1xenJ1TVYwN3JiR0M2TWFx?=
 =?utf-8?B?dnMrcS91Q3hLRjZsT0NCclZoK1VTMUZUNzE0RjZ2V2FYazY4azlXaVY0eWJM?=
 =?utf-8?B?ekJFdHlHRUVxT01ZOUN1c2xMQ3VFeEVBQkZpMGZxeEVCcXNDOS9JWWlHRi9R?=
 =?utf-8?B?UlFWelFGTXZWcFM5OHFGQjRnRzRMSzhWbzg5dVd4YVJFa244R25QOTU2dkV1?=
 =?utf-8?B?Q0hkWlhjVGpXQlRNUHFkbmV0ekNEVjFXOTlHaG01MDN5MngvdlkweEFOMm1Y?=
 =?utf-8?B?THF2Y0M0bmlLNithYVFhVHZ5WU1CSnZ2c3diUnByaDlmSi9KaUlDcWhzTmJB?=
 =?utf-8?B?ZGVpOGlPV1orQWVpZDdOWmxMT094VjRMOG1SK05NR1VXV20vVnI1NzB0TFdS?=
 =?utf-8?B?SVNJVmszNDRsbHpyVS82OFZsM3kzRW1JdFROZzE3YmFlU3FldkwzSjIwdTlU?=
 =?utf-8?B?SHovVmxqTzlsU0VBMSt3SGx0WWgzdGhOTmNGU3RkQTRZb3BqYktkSGVpcTJ0?=
 =?utf-8?B?c0ZpMEFWT1ZjK0s4UmpYdFkrc0VsM1lNT2N4ZEZRMlRCTndKUWx5VjE0TUdq?=
 =?utf-8?B?aE5sMGVKL05zSmp2V1oxZk1lMEhYMWJwNUQxZUpmdmE1RzgzNVhVTm4ybEZV?=
 =?utf-8?Q?g1IUBesv8j6+GrwQW9Nk0/qKH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0222B65C59CAA2439346BF0BE3030A2B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4747012b-6488-4127-5aea-08dadca24c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 00:38:05.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GW8f8ObNjaUshBfmS+TyjXzYWa41o3uDoMkAjIspNZpQe8V1cEPkgjeyv3UslXHTHGa6s0/Rmvm/SJZX7oqAZ+1N95ytwnfxJFQUi8BmDB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6593
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMTIvMjAyMiAwMDoyNCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBTYXQsIERl
YyAxMCAyMDIyIGF0IDE0OjA4LCBzdHNwIHdyb3RlOg0KPg0KPiBDYW4geW91IHBsZWFzZSBDYyBM
S01MIG9uIHN1Y2ggbWFpbHM/IHg4Nl82NEB2Z2VyLmtlcm5lbC5vcmcgaXMgbm90IHVzZWQNCj4g
YnkgYW55IHg4NiBtYWludGFpbmVyIGFzIHlvdSBjYW4gZmlndXJlIG91dCBmcm9tIGxvb2tpbmcg
YXQgdGhlDQo+IE1BSU5UQUlORVJTIGZpbGUgaW4gdGhlIGtlcm5lbC4NCj4NCj4+IEkgYW0gcGxh
eWluZyB3aXRoIDMyYml0IGNvbXBhdGliaWxpdHkgc2VnbWVudHMsIGFuZCBJIGFtIG9ic2Vydmlu
Zw0KPj4gc29tZXRoaW5nIHZlcnkgc3RyYW5nZS4gIFRvIGRlbW9uc3RyYXRlIHRoZSBwcm9ibGVt
LCBJIGRpZCB0aGUgY2hhbmdlDQo+PiB0byB0aGUga2VybmVsIHNpZ3JldHVybiB0ZXN0LWNhc2Us
IGFuZCBpdCBpcyBhdHRhY2hlZC4gIFRoZSBjaGFuZ2UNCj4+IGp1c3QgbW92ZXMgdGhlIG1hZ2lj
IHZhbHVlIHRvIEVBWCBhbmQgY2FsbHMgYW4gaW50ZXJydXB0IHRoYXQgcHJvZHVjZXMNCj4+IGEg
U0lHU0VHVi4gIFRoZSBTSUdTRUdWIGhhbmRsZXIgcHJpbnRzIHRoZSBuZWVkZWQgcmVncy4gIFRo
aXMgcGF0Y2gNCj4+IGludGVudGlvbmFsbHkgYWRkcyAweDEwMDAwMDAwMCB0byB0aGUgUklQIHJl
Z2lzdGVyLCBiZWNhdXNlIEFGQUlLIHRoZQ0KPj4gaGlnaCBwYXJ0IG9yIDY0Yml0IHJlZ3MgYXJl
IGlycmVsZXZhbnQgaW4gY29tcGF0aWJpbGl0eSBtb2RlLg0KPj4NCj4+IE5vdyB3aXRoIGhpZ2gg
cGFydCBvZiBSSVAgbm9uLXplcm8sIHdlIHNlZSB0aGlzOg0KPj4gJCAuL3NpZ3JldHVybl82NA0K
Pj4gZXJyPTAgdHJhcG5vPWQgYXg9MCBpcD0xMDAwMDAwMDMNCj4gSSBqdXN0IGFwcGxpZWQgdGhl
IHBhdGNoIGFuZCBvbiBhIDYuMSBrZXJuZWwgSSBnZXQ6DQo+DQo+ICMgLi9zaWdyZXR1cm5fNjQg
DQo+IFtPS10Jc2V0X3RocmVhZF9hcmVhIHJlZnVzZWQgMTYtYml0IGRhdGENCj4gW09LXQlzZXRf
dGhyZWFkX2FyZWEgcmVmdXNlZCAxNi1iaXQgZGF0YQ0KPiBbUlVOXQlWYWxpZCBzaWdyZXR1cm46
IDY0LWJpdCBDUyAoMzMpLCAzMi1iaXQgU1MgKDJiLCBHRFQpDQo+IFtPS10JYWxsIHJlZ2lzdGVy
cyBva2F5DQo+IFtSVU5dCVZhbGlkIHNpZ3JldHVybjogMzItYml0IENTICgyMyksIDMyLWJpdCBT
UyAoMmIsIEdEVCkNCj4gW05PVEVdCVNQOiA4YmFkZjAwZDVhYWRjMGRlIC0+IDVhYWRjMGRlDQo+
IFtPS10JYWxsIHJlZ2lzdGVycyBva2F5DQo+IFtSVU5dCVZhbGlkIHNpZ3JldHVybjogMTYtYml0
IENTICgzNyksIDMyLWJpdCBTUyAoMmIsIEdEVCkNCj4NCj4gICBlcnI9MCB0cmFwbm89ZCBheD1h
NWYzIGlwPTYNCj4NCj4gTGV0J3MgbG9vayBhdCB0aGUgZGlzYXNzbWJseToNCj4NCj4gMDAwMDAw
MDAwMDQwMzAwMCA8aW50Mz46DQo+ICAgNDAzMDAwOiAgICAgICA4YyBkMSAgICAgICAgICAgICAg
ICAgICBtb3YgICAgJXNzLCVlY3gNCj4gICA0MDMwMDI6ICAgICAgIGNjICAgICAgICAgICAgICAg
ICAgICAgIGludDMNCj4NCj4gMDAwMDAwMDAwMDQwMzAwMyA8aW50MzE+Og0KPiAgIDQwMzAwMzog
ICAgICAgYjggZjMgYTUgMDAgMDAgICAgICAgICAgbW92ICAgICQweGE1ZjMsJWVheA0KPiAgIDQw
MzAwODogICAgICAgY2QgMzEgICAgICAgICAgICAgICAgICAgaW50ICAgICQweDMxDQo+DQo+IHdo
aWNoIGlzIGV4cGVjdGVkIGFuZCBjb3JyZWN0Og0KPg0KPiB0cmFwbm8gPSAweGQgPSAxMyA9ICNH
UA0KPiBheCAgICAgPSB0aGUgbWFnaWMgdmFsdWUNCj4gaXAgICAgID0gNiAoT2Zmc2V0IHRvIHRo
ZSAnaW50MzonIGxhYmVsIGluIHRoZSAxNmJpdCBDUykNCj4gZXJyICAgID0gMA0KPg0KPiBCb3Ro
ICdpcCcgYW5kICdlcnInIGFyZSBjb21wbGV0ZWx5IGNvcnJlY3QgaGVyZS4gV2h5Pw0KPg0KPiBU
aGUgI0dQJ3Mgb24gNDAzMDA2LiBCZWNhdXNlIGluIDE2Yml0IG1vZGUgdGhlIENQVSB0aGUgZGlz
YXNzbWJseSBsb29rcw0KPiBsaWtlIHRoaXM6DQo+DQo+ICAgNDAzMDAzOiAgICAgICBiOCBmMyBh
NQkgICAgICAgIG1vdiAgICAkMHhhNWYzLCVlYXgNCj4gICA0MDMwMDY6CTAwIDAwICAgICAgICAg
ICAgICAgICAgIGFkZCAgICAlYWwsICglYngsICVzaSkNCg0KVGhhdCdzIGBtb3YgJDB4YTVmMywl
YXhgIHJhdGhlciB0aGFuICVlYXgsIGJ1dCBvdGhlcndpc2UgeWVzLg0KDQp+QW5kcmV3DQoNCj4N
Cj4gc28gNDAzMDA2IHdoaWNoIGlzIG9mZnNldCA2IGludG8gdGhlIDE2Yml0IENTIHRyYW5zbGF0
ZXMgdG86DQo+DQo+ICAgICAgIGJ4W3NpXSArPSBhbDsNCj4NCj4gc28gaW4gbXkgY2FzZToNCj4N
Cj4gICAgICAgYng9MHgwIHNpPTB4MjkwM2U2ZDANCj4NCj4gd2hpY2ggaXMgY2xlYXJseSBvdXRz
aWRlIG9mIHRoZSBEUyBzZWdtZW50IGxpbWl0IHJlc3VsdGluZyBpbiBhICNHUCB3aXRoDQo+IGVy
cm9yIGNvZGUgPT0gMC4NCj4NCj4gWW91ciBvYnNlcnZhdGlvbiB0aGF0IHJ1bm5pbmcgdGhpcyB1
bmRlciBHREIgY2hhbmdlcyB0aGUgYmVoYXZpb3VyIG9mDQo+IHRoZSBlcnJvciBpcyBjb21wbGV0
ZWx5IGNvcnJlY3QgYmVjYXVzZSBCWC9TSSBhcmUgc3ViamVjdCB0byBjb250ZXh0LiBTbw0KPiBk
ZXBlbmRpbmcgd2hlcmUgdGhlIGNvbWJvIHBvaW50cyB0byBpdCByZXN1bHRzIGluIHJhbmRvbSBi
ZWhhdmlvdXIuDQo+DQo+IFNvIG5vdGhpbmcgc3RyYW5nZSB0byBzZWUgaGVyZSwgcmVhbGx5LiBZ
b3UgZ290IHdoYXQgeW91IGFza2VkIGZvcjoNCj4NCj4+IEkgYW0gcGxheWluZyB3aXRoIC4uLi4N
Cj4gVGhhbmtzLA0KPg0KPiAgICAgICAgIHRnbHgNCg0K
