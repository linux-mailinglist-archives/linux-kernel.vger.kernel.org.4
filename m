Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1006E0043
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDLVAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDLU77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:59:59 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FED92737;
        Wed, 12 Apr 2023 13:59:58 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFwMdX024810;
        Wed, 12 Apr 2023 13:59:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=y2vY+OdNKKDK9LRu9VrWbvoGj16qg3xOkYxU6BEYlOU=;
 b=GbefwWisKQDrCth/TNYiPulR/Xh094gOgkD2rERC32kqNnruL7TSHEXre8MaZOFIUMWJ
 w07t6SsnfZcOYIdw6KRu6hr23/o+89PQRjSmObDFFr0b8SsN+Notp/9Vr69LK2AoScm5
 QoqBkInw744IjUxSK4zJ7jAd7QJapHhxYSw5u4LPYuizcjNp5v+Aaglt//LntLNsaZ8R
 NjFMOTRZ3fW5STNP17lIA91IWnvvvRNBVdWUr2eSruKWnez7nbAlxc+P9JGZv9C+EEF0
 kyVkNJ1Kappa2hDl0zzZ4hSy9C8yEAiqz5dgJfa/xb1KnC4ePs8mKnlCefgVELa5gYhw 3w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pu6wjresd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 13:59:42 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CA866C00F7;
        Wed, 12 Apr 2023 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681333181; bh=y2vY+OdNKKDK9LRu9VrWbvoGj16qg3xOkYxU6BEYlOU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J6ikKWDVrLTFoimRtbb9WorrU3pEI/AcyDIw16oGfOoZBWC3WFNe9kIF6C551pP++
         msehFB8xubxF4LS26jCZdJwQ5oOXyGC9yFvRUskmglqLUyVPTvoTAQwJAMA1VpqrFA
         JBHNPsDC/r7hetn8/SWgtwWPCei0U1WsD9+ZwZxD98y8JYCA908En3jF0hzv5fPzav
         vf1UbmhjZ+vG2jvGbXzS1XJIGdJmL5OCcCIJqyBF6mebgiwfWnMkc8tu7uaUXLnl5/
         5aLexYCgtvRaxL6ez65euF8u+PoRpoatyoIFZeMXSku80O5qmcVSVukuF+LasUB03M
         el5OwVZoQxMog==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1614DA0073;
        Wed, 12 Apr 2023 20:59:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 78FCB40084;
        Wed, 12 Apr 2023 20:59:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="R/uSxP/X";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq6VRncEfEAL+kZiraYmO8IWKAWDIK4QM0JWVn65rDsWN+HLdA18Feq2kd2CfX90p4MJ01Y8hyNP1o+uAoWad75QNdwkKg+M/JSDsXjHb+0DXiLL9Lr3rqoWd1oR5poOEUIUXgTx16yp9SPtpGUCLGwmKMc4UUjrrMmjj4l8SyFiq2Z2meaX7z5KMK8Oh5Bm49tZ+HfCtEFRjGeH0+LO0uzQAu7rgdYVZfdu9/NJQ92BrPkP5j799iQcJKqRp5oRU05NTPc49q6fQke5slPStJk/Ruo4w+IJdjYJfe0u9whyHuqqzQ4VdcColYEuE76nebQA4b4TgRIF/F4FixuIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2vY+OdNKKDK9LRu9VrWbvoGj16qg3xOkYxU6BEYlOU=;
 b=KOuxwRYQ3EDz7bTpR60vDWqXK98q815AP6XgUfWbgh2HB8A77xUHdQcJbZen2DHRZy3oJOjo0i3Y5aDgvmRimi1GQbBrpRU9K+VA4jy1LHKyAN6YNwjsVb0MG5UawmvhNcQ70JEpuJGvJRZHTYo1AyBJZ3G1rCUHF7umYascni/7LhwuokvHGHhLdqXWuX0611itKw2f2YnBeXztcrEH9xRUvDwWq817/pPu0oAdSi31julgpymBv3s63IUboh9Elcbi9w/Il5G4FlBej4kpCcNY+AVchQsHH44+ch0wXPo0XJSG2ywePMmisKIBEKWVNN4H2ucdRKiCa7ja+RyTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2vY+OdNKKDK9LRu9VrWbvoGj16qg3xOkYxU6BEYlOU=;
 b=R/uSxP/XpJUZId6w7klPqbK/D88GxmLgl/rjj9fz6NBd4IQlhFzTM+GdUqMVXGhSogSR0YmenGoQq1/SoCKUe+3iikFdKPICtzUxaCCIK4Hp4hfNOjraeE+HOaxuBqseS/n6VEVIWLwdf05JYZ6snlTCMorG/OzOIToT0TWf6pE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 20:59:31 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 20:59:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueAgAB4pQCAAL6cgIAL7uaAgAWI6QCAAI0fAIAA6EWAgAC5X4CAARfCgIAJ1N+AgADdnIA=
Date:   Wed, 12 Apr 2023 20:59:31 +0000
Message-ID: <20230412205927.win6wgv6yc4nqrzt@synopsys.com>
References: <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
 <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
 <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
 <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
 <8884129b-8c73-df1e-e342-01defce0d407@kernel.org>
 <20230406013803.x2fp6c3wpvqtbues@synopsys.com>
 <a5993f55-36ea-a2b0-c715-652cdf6feef1@kernel.org>
In-Reply-To: <a5993f55-36ea-a2b0-c715-652cdf6feef1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6735:EE_
x-ms-office365-filtering-correlation-id: cb356ae2-61f4-4fef-e4ec-08db3b98cfde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYw5iicGICMwG8KcshtiMVBYpbFgD1+C4+XFdtY/RBIGLmQaWM/jVGAw7PQFebkwp5Wm1QV4g+xEatOksfpLn3papKmOn555tBbKaA3KbfX8dxS/AY9WDVIPCO/b2oWmmDc11aDKNZHiOVQc15T19KiqFVW4EBWpZwdbeqo7VdvXQsHxHQMhAS1ssIiPF7RRBKLgh9RQTtN/nNCXGmsoi5P+O/qHb3G2gPk8gUgdiJ2CusdB5Dda+N4Tlfbh3M9JMy/UWvnNL28bVznthjTy5O+eoF0OpLgUyhX7qz9qpQ38py3rlepIVgeV/7mgHQkYPSmxSmz3WGd5ha5WRJM7euEdrEN4iRvdh2WL0PmzhAK1DDcODAZdKD/cWGG8KBHGdRdn6mCjs6WFtSmNHmoUaA0vWVT2gjQ8B2PtcbFmVVzlRfFFikgxcir4LIieg/7NqVSQU26yO11H949f2oQMaiX98a5FMwTSpHuKQFxRljR6zhO+3m/Ck42ZIkiHmdM8Z1PIH4fwlI2CmnxGGa4zCLxbQJTyl4C0kF2Ga6/3OtkDMsipXTtoMIIoPWCCIva23nS3g9f6s3rjpRVCKhtDCcgX1Pdpwks/CtSHW+aXEqyIeycrlacCMwkuAs0d4zCY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(71200400001)(478600001)(53546011)(6506007)(66476007)(26005)(186003)(1076003)(316002)(6512007)(2906002)(4326008)(64756008)(76116006)(66946007)(54906003)(66556008)(41300700001)(6486002)(66446008)(5660300002)(8936002)(8676002)(6916009)(38100700002)(122000001)(38070700005)(83380400001)(86362001)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3VmQ3l3T1k3eURueUhGUisyM0Znc2kzdkxqaUthMXVZeHdjaG5rSHlFeWFv?=
 =?utf-8?B?SVpMV0NOd3hsZmo5OS80K282VlJnZ0NjRWlnOEVaMVNQbVdFaFF0NUpTTElj?=
 =?utf-8?B?a2NsZEpWalkyUmV5R0hsYmVJdTJDbktuK1FZWk1Ga3dtSGFTaHdIbmJ1WVh4?=
 =?utf-8?B?Wi8vWUVsOTRzNUJnWWVEeXlOWHFpK215RXhUWDZhbk9kQzhzZml4dFZ0NGtT?=
 =?utf-8?B?ZVZTRXQyMDhLeXVqeUVhSzB2NzdTclp2d1hEWlY3MDZNOEVhM1BScXduOWov?=
 =?utf-8?B?V252L09uU1I4MGR6UHVTOU53RlF1b09EYnp1YzN0M2RCVG1xWmRRYjVldHZX?=
 =?utf-8?B?a3ZNNHNCZUxXWlptcTVKd0hrcS9McmtXWXB3Zkl0QVB1aUpIT1hQelA0L2JT?=
 =?utf-8?B?eFFhU0NXWjdrUW5INy9LR2FSSHdqL2pKUDNCVTkxN3pYb0J5ZFMzRWZwYllE?=
 =?utf-8?B?ZDVGZUgyYVlwa2ladkVFSHBIMjR2TkJlLzRPRlQvOG02Ujc0enptZlRyTXlD?=
 =?utf-8?B?akdnWUJiMjBPcUp5bzl5R0tieWVkZUwxQmVXWU5kOHZ3L2FjazJsRS9pdVl2?=
 =?utf-8?B?cnVsZWhJRDVZSHY0dnRWcFBKUjRLNXFwblorRFo3dmVaSHBWbjdrMGtJVWhQ?=
 =?utf-8?B?ZllseUR0d0ZJb05Va1BERHBVTkdhRElERnovK0RPQ1lqZ1pUblNEdENzeURU?=
 =?utf-8?B?NXVkUXJUSWFtUk12MEozdjBwVkFGdlAzV1BhQ1BCc21vSVU3U0g3eDUzN3Ey?=
 =?utf-8?B?QXNwbFRWZHpQa0h3T0RZR2tsSXpvcmptdHk4SmIvVGlRek5yMlNjbzg0dExs?=
 =?utf-8?B?VTI2RFhKZnRvZjJQazZjM0p0MjVJUXBRQWtqWGh1SFRzdDhBTk5mbVNDb1FW?=
 =?utf-8?B?Qm9tM3JNNktYOUVudWQybWpURWt1bXZOR0djMXVwSGF4TkxvMkZiYWxXUXZr?=
 =?utf-8?B?aWdTTHdJNWsvQzBDdXhualBlWDhGVUlibGQrZU5xUzRDRHc3eGFueUlkemdl?=
 =?utf-8?B?ck54T1h3TUpGNEV1aFl6ZzBQNVBsdDJzaXQvcndrZjk3NExEaFB0S2lSd01T?=
 =?utf-8?B?bGtjRWtOT1UwTitzaHUveXhlVVBxNDNwVWZXZTdTVlpQKysybmVHZCtiRWVP?=
 =?utf-8?B?WjZ1QlVzRmJLczBrT1M4SmllVDdtTTVZM3V4V2ZJUFBod0tueGZSNytQQlhp?=
 =?utf-8?B?NjVtdWNoODlyajBoME1BS1RKUVU4am12ZzM1WnkycVlQNjlqYnVVaWxlRXpi?=
 =?utf-8?B?Z2R6M0krSmtXKzFXZW5odjJjdFNkbFdENHZOUnJnSjRrWjdrZXpaSzlJN3dy?=
 =?utf-8?B?dFpqYnpuNjJ2bml1R0QxczF0MlJBdkFPcGM4bEhUUE96UGFtQWVqVUZlREo0?=
 =?utf-8?B?bUN2WHZZQ3dPaUNxa1UrNTFMMERoYnVtS2ZIVlkrZm1HQnJHM0VSbjNuQVdr?=
 =?utf-8?B?REJ5M2plZzRHR0lkb3VDdnh0Q0dnV0hUR0lZMjgrejFDWXJHMGtYa0R4dDF4?=
 =?utf-8?B?VHg0VGFNU3NCZXhUZWdVbXBPT2dnNlBDYnhCNytSZjl1S3E5UzFuQXp2SkVN?=
 =?utf-8?B?U21LY0VsNytYL09nNndCWk1xNmowZHBlUnN5bk9DUmdWd29OZ0xGQ0I2MFla?=
 =?utf-8?B?RTZlTFB5WkhyWmdpR3M1WnM4QUJFZnQ3VkluUEQra1c5MnZCaWszTVR5YWta?=
 =?utf-8?B?UTB0V21DYU80Z3hKbVh4ZnRWSER0SnlKcHVYYVo5Vlk0eEVFdFluQXBWYldp?=
 =?utf-8?B?MWg2OGNoY3J1STlCdmJwTEtnZ0pyWDJiL1FxQk96N3Awc1RFWW1BRXN4eElQ?=
 =?utf-8?B?Z3lDR3V0ckVPU1F2bUFxSDA1bTdoTDdYcjQ0TXNaUFl1dTI2TU5sTUhpamtW?=
 =?utf-8?B?SEE1Ulo0NWNuZjZEOFVna2lKUWt2bHpja3VTQVVMRXV4Wk5PdE0xMzNCUVYy?=
 =?utf-8?B?UDgxWFBKdmRwY2E1akR0ZkhJNlJvWWtHTHh3dEJNRVdNTzVJNWNldkt4dGt6?=
 =?utf-8?B?c3ljbUNqUDNpVlh0T0hKWTBtUCs0eEdIdWQweHgwR2Z6NVU1SzBSVER3Y3JW?=
 =?utf-8?B?OVVNMlZ3cG81OHIrTE51aFU5L1hrVWNXemNJWEVjSU1CUGlNaktBbzhlQ3h3?=
 =?utf-8?Q?UmY9U4HOdqWCZkNQIX7BBjkEL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4838A7FA7ADE0E489D7DE51133BFFEE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NUJSVGF3Y1F1aHd1aHl4QjJyOFdPVnZqUDY3cm9NL3VaODRNVDhUQUxGKzR5?=
 =?utf-8?B?VkxJSXhpd0E5SFhJYTJSTDhka2RSb1RzOStyeGQ4NGlKekJRODRLRGpld2RB?=
 =?utf-8?B?cHBBb1ZSbk90aDROU3FIRlVsYkN0MGxWeHFsMVU3cGpDRUJHK2JCa2JyRWlp?=
 =?utf-8?B?bFU3SlVURGRPeldYTUl5NGR0b3N5NnUvVk50Q3lCaFhOcnA0N3RwdmM1MllB?=
 =?utf-8?B?Wm9HUCtkbTBZaHdreHpOeS9lT3k1VkpCNzUrSEpOUEtlV2VidWxzYkp4YSt2?=
 =?utf-8?B?R3ZFN3h5QS9CZDllNy9QTnl1aE40dEFhUHVrZUFvM3NHbE55VWc5ZUltMFpV?=
 =?utf-8?B?NVFqTXlXa0E1bCt0RE5qZytYOGF3dnk4dmQxZDJjckd0TWpCSktvREVsZ2Vz?=
 =?utf-8?B?VUJ5NmRneGltYXgxcVdJM0hxQkt0UytveTZQMjJZcjlnZ2dXVDlPQnNvcmNR?=
 =?utf-8?B?SW16Wm1lbTVkZlBHK0JEYnJzbmowcTkwamozQi82Mmh2YVJzOVBySnJuV1Iz?=
 =?utf-8?B?cmw5NTl6TUZka01CRVZ3VWpjUEhCeXJWcmtkRFQyV2w4a3pOTjhnQWhadGIz?=
 =?utf-8?B?WVNtRDFkMHh3WDhkWEE2V1JYb2JLR0NRNE5rbVU4UkpqeVQ5NG04WmpVVDJY?=
 =?utf-8?B?T2piMGI0RzNINzNVL0dmVHZ4V1creGx4QjltUVFJNWxhbkFUQVpLVTJCSnlP?=
 =?utf-8?B?NWo1UEhvdkZtTDhqN3pyMFdaZVErbm1LZVdsVXVYNVMzK3ZJY21ORTZxUVJD?=
 =?utf-8?B?VlVXb0ZGMHphMjk4aGtEcUl0YUlMaWlSa29YUDNFcTBrSU45VWpiTStkMlQ2?=
 =?utf-8?B?NUJjT1B4akg1eUJzUWsyNXlYcDBlL2FHdnVUSmlQUjdQaVFJMXBxT2RGRUxM?=
 =?utf-8?B?VlpvRlc2YmNIajlIZU5CYWxmdk1zSWZpbU9pSFZZN1VKVmR1Z0xSb3o2emtX?=
 =?utf-8?B?QTFVOWpJclJCa3RhWUU4bEpwUEIrZnJET3A4WDFMeGNVeGRsbmZha0lxRTlI?=
 =?utf-8?B?d2tLMFhaOFROcDJla3l4VUc0UzlMb0lyWkFzMUFFUS9lMWVsVXZnYlpqL0tI?=
 =?utf-8?B?UG5TbEM5MlhOSFNMSlV4VDI2WGk1UklDcmVMczR0eElkYWRIVmp5eExBN2tn?=
 =?utf-8?B?QmJhWG5qRUxtWGx4NHJnMldCWE43YkhvOWhpaGw0c1FCaFMvWDVSdUt0Q2hx?=
 =?utf-8?B?Ti9DNWRiOUZxaXRnV0JwNXgrZ0RaSjZ2YUwwVzFOWnVkRW51WUhYeTBCMWlh?=
 =?utf-8?B?VHBlRzVOUFZPYS92QVNzNUlsYUxxSFBtZVdLWnBScDVtUks4UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb356ae2-61f4-4fef-e4ec-08db3b98cfde
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 20:59:31.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd0JpYCRfNWViUcbyZTDY7r/Hmg3uFYxnswK8TBpPoQNU3H6c2LOCItYpjJEbqooUw/1b9SqtlxGMUNZDU3gFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
X-Proofpoint-ORIG-GUID: 6F8flU1NLc-apGv0_Nel2BPJyVhyf_wp
X-Proofpoint-GUID: 6F8flU1NLc-apGv0_Nel2BPJyVhyf_wp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_11,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=525 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304120178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMTIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MDYvMDQvMjAyMyAwNDozOCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXByIDA1
LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAwNS8wNC8y
MDIzIDAwOjUzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gSSBtYXkgaGF2ZSBt
aXN1bmRlcnN0b29kIHlvdXIgcGxhdGZvcm0gaW1wbGVtZW50YXRpb24uIE15IHVuZGVyc3RhbmRp
bmcNCj4gPj4+IGlzIHRoYXQgaXQgY2FuIG9ubHkgZGV0ZWN0IFZCVVMgYW5kIHRoYXQgaXQgY2Fu
IG9ubHkgcmVzdW1lIG9uIFZCVVMNCj4gPj4+IHZhbGlkLg0KPiA+Pj4NCj4gPj4+IERvZXMgdGhl
ICJMSU5FU1RBVEUiIGhlcmUgZ2V0cyBhc3NlcnRlZCBpZiBzYXkgdGhlcmUncyBhIExGUFMgZGV0
ZWN0aW9uPw0KPiA+Pg0KPiA+PiBZZXMuIFRoZSB3YWtlIHVwIGxvZ2ljIG9uIHRoZSBTb0MgaXMg
c25vb3BpbmcgdGhlIFVUTUkgbGluZXMgZnJvbSB0aGUgUEhZIGFuZCBvbiBhbnkNCj4gPj4gY2hh
bmdlIGl0IGNhbiBkZXRlY3QgYW5kIHdha2UgdXAgdGhlIFNvQy4NCj4gPj4NCj4gPiANCj4gPiBB
cmUgeW91IHJlZmVycmluZyB0byB0aGUgdXRtaV9saW5lc3RhdGUgc2lnbmFsPyBJc24ndCB0aGF0
IGZvciB1c2IyDQo+ID4gc3BlZWQgb25seT8gRG9lcyB5b3VyIHBsYXRmb3JtIHN1cHBvcnQgdXNi
MyBzcGVlZD8NCj4gDQo+IFRoZSB3YWtlLXVwIG9uIGRlZXBTbGVlcCBmZWF0dXJlIGlzIG9ubHkg
c3VwcG9ydGVkIGZvciBVU0IyIG9uIHRoaXMgcGFydGljdWxhciBTb0MuDQo+IA0KDQpJIG1lYW4g
Y2FuIHlvdXIgcGxhdGZvcm0gb3BlcmF0ZSBpbiB1c2IzIHNwZWVkLiBJZiB0aGF0J3MgdGhlIGNh
c2UsIHRoZW4NCmhvdyBkbyB5b3UgcGxhbiB0byBoYW5kbGUgaXQgaGVyZS4NCg0KQWxzbywgd2hl
biB5b3UgdGVzdGVkIHRoaXMgaW4gaGlnaHNwZWVkLCBkaWQgeW91IG9ic2VydmUgc3VjY2Vzc2Z1
bA0KcmVzdW1lPyBPciBkaWQgdGhlIGhvc3QgaGF2ZSB0byBwZXJmb3JtIGEgcG9ydCByZXNldD8N
Cg0KVGhhbmtzLA0KVGhpbmg=
