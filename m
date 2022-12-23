Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573CE655654
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiLWX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiLWX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:57:49 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9215F1E;
        Fri, 23 Dec 2022 15:57:47 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNIJkG023202;
        Fri, 23 Dec 2022 15:57:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=j/kWOWdClGkreSMm89YhLpS/SCsVhjUrywGXbvclU/s=;
 b=iYgNoAEiyU1Q/FILL32+jX0P6ZiAu6Zs2WDfAaAPklF3wfdgsdsZGzqqF9hTFMJBbklt
 tCpKBurZulr+WhNJ0SIT6pdU/7omgcocwAp6IGRJ92zEUTYb5013FBfewhgif9IuBsa7
 hQ7Gogii/q1JuJSbWVPjhSgMnR7i209VHCKVP9kmeFxOUByIqesUnHCl8vXZ/1tnmmaA
 aQQw7kzW493xXI3872UKPS/2IOey4m49lP5l677eCQ02iEdmx+LoEzHAG7Lo4FL8hWtp
 lyWf+dipw9cEQrWMVFHy+z1LyjDIOeWwqyWlMIDJnKXMttv5t403WQaXzJa9XxXHtVe1 AA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3mhd9mdgfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 15:57:26 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 34A65C00AF;
        Fri, 23 Dec 2022 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1671839845; bh=j/kWOWdClGkreSMm89YhLpS/SCsVhjUrywGXbvclU/s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fIatuGQJY3twQ1wK9rNqHym9Nmw1fZYjj96Tj3J3ZVKLgRLLDTqBYxDHYcw5cICw+
         fyzbGrV5bJLXEC7dEvz0Gjotbx5N2uv8SLIER1YrGe8hN1XIZOISJP+e4/xFKE3z4L
         Zo4tK28mYajXr6Yd+8Mf0cZaGYPbXpXOB4opyDWjaMN2mwrfr5ZqkvdpBFGvoz+WuK
         pJOSqDvbRSRRy4NntFPUne8K6eFr8mjonV7hBca0/vVJONbDN99Cdm1PUgwbux4sKz
         q/enMmSv5ahMHv9hJEUbnxSiBCr/m+74+CV2PhU5DFR/1cUBIlRwSzNljfj25hRLQX
         mj6Ebs2covB5g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 56944A005C;
        Fri, 23 Dec 2022 23:57:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7EBB54006B;
        Fri, 23 Dec 2022 23:57:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="h5+X9qj4";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYHvMH+MVf3mg6Myq9GDLwBRzzePVUFK6dU1AYFhsfQDRfXtYhUJAaiT4GYZfbFASqZd1GnOCFOeCpFrONcQ0ZDz9/jgW6HcjvnT4sGLJnu7K3MwVLfEwTDxTT6cyTOn8WgX3uN0PybiVCZYx1L6xIjNNFo5Fxc2ah3u70J9QbYly9eZRs+ughUa05rIPrNGXQrKWQEw2da00NnNodFyzvchMi3aKM+sekdrRbAiwIDDOAc8+kP3fKtRgGZWJJuc/CCQrZ1ZTOliv/mkxkogMQz6MCsj7SDdumGB88/nLxDPiJKaRoR0UE0Wr5QZ5PjARV87EYDu+XB0Jm23As2pKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/kWOWdClGkreSMm89YhLpS/SCsVhjUrywGXbvclU/s=;
 b=MGg/hVCIMR0wf9Kad3nXky3qO1RRfRGgTxmRsnUgY9t33xuYitLgrW3+jWsxIgV6MC+YutfBqpGEKEt1WlbXnGdlSlBuGsLWpaum+BeE7+LX18JByjbOD66XI/rDFO9O6eIDXW6x7VoiBtX7CBM0aOKi5TRljrJG0cSxTYXCzLHvuldeJSa9rkzrnUf977QXnlaLLwuS5+LWk35XzIx4MMqQ6RoSvJ59BFkvS/cGYtDbIp3yr5GYTtvA3qM1T/VRzhSEH8IdtMF0ApUjNuqKkbTcpA3/e4TNNnT+aCc4KkkZAFkhIq5FSp7ioVgdHkc76Q094CSXeS5rgYbnBqGzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/kWOWdClGkreSMm89YhLpS/SCsVhjUrywGXbvclU/s=;
 b=h5+X9qj42WoevvR9mzv0QNUlmYHybustduw4M9MGKiqiJG6aK8OteIXu2T8RarPivaD/jcevBVZLpC9U9dkD4+7vYrzXS6SJtC20csvFDfAg55LJDslk9HTDRGP5nZzpd40nU2iDBpDTw7lFaJ0dq6xC9z0P7BEO1D5iQ7K5KVo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 23 Dec
 2022 23:57:16 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 23:57:16 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Topic: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Index: AQHZE93Ovub27gHGRUWi+BBXvB4w9652Yz6AgABs/oCABHtWgIAA4T8A
Date:   Fri, 23 Dec 2022 23:57:15 +0000
Message-ID: <20221223235712.h54lggnjjuu3weol@synopsys.com>
References: <20221219191038.1973807-1-robh@kernel.org>
 <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh>
In-Reply-To: <878riy9ztm.fsf@balbi.sh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: e1c9401f-b690-4d5e-87b8-08dae5416b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12ie9eT7Q5uVJGw72TxHudRv4wDni/tgrKn/PNbsOdWh06kC7aFl52E6Pcc5CaTgcOJ4eEckQ92EOIUi/Yc2oPrv2zW7i+66qpP+r8xFGm7VNMKGD3m4X36TYLGob5O86lutL2Pk9HkVpZ2Rsq45/1GwHZHcH9iGU3Z6/eUSt9940qPlRAMJSw3kaYvzmFQvtBBzj8cwrKqAZgOVKwYlc3JpCZQfSarFsY8RxiBOBrEc2n7elfA0+VFdO1Lwi9+G7Zp1xsd0DUKmMij3DWiqoEBWuOGblACPbXvdelvGbLeeIf323KL232v5yc+xW9JdSRiyQFt/ghBr14usuvEdNK6SL1X8uSwl5Lz26ooP0IajJ/m37DkaI5i/YH+UHVo9sBKJwoTVf5GqXPljHn7mhECqJjgj89dQoCg75a6XNBjOGQyshOAPl2TJVcS1/8xoZ6CgaViMcUq+zzp5oayia2sSS1kV3n6ayyvuGKrj0W9GMMDd8ZpHffk+O2tGtAFbypg/zBQCOtzUeB+GUAEsdIfDZYVK0Bb1nvhefbw673gzyL/SAqFOq2HUaGM0s1YVL5bdY6CGKIhDqJ2ZFR9N1EYPVgBP5Y3yGWZuqPR5VsBaqv0Z/QwZuVFIZ41335NBda7IAZBwYuEDm1sPGHQHplHdJ++Cx5XTMNIVBU1POPTKydd+KmTCV+DjxFanbcD3a8HmppzB8b/qdo/7vMt5zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(6916009)(36756003)(54906003)(38070700005)(2906002)(316002)(6486002)(478600001)(8936002)(83380400001)(71200400001)(6506007)(26005)(1076003)(2616005)(186003)(6512007)(86362001)(38100700002)(66946007)(41300700001)(64756008)(66446008)(66476007)(7416002)(76116006)(66556008)(8676002)(4326008)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2xTTmxvRkluL2hYUm96a0JESTlCa3R3NDdHREF0MU0rR2I2VkxCbXpMeS9D?=
 =?utf-8?B?QTJSa0hNYkJIbHdOeHgwMzBnajI4VFdkZlVNMG1qb09PbGVxV3licWMvQmlC?=
 =?utf-8?B?Z2pUc2g5ODFncGFvbHoxTVRIYWNYWVJSQXlDTW1IU2duWUc3MnRTZ1RQdjl3?=
 =?utf-8?B?UHE0YU04U053ZGR5OHJLdFhkODZMMXl5bkkrd096WHB6NllkYjlMMTBKSEhD?=
 =?utf-8?B?Vm5qaFB6dTE4SHk2NDcxd2tRak1CVzZYWjhXZEx6NzJGUGdXcUJQV3ZCQ001?=
 =?utf-8?B?V2FWbURzb1BhKzVTQTVGaFFZVXU3LzBXbFJ0UFhqWmRYTklaSGtxMldiTFJC?=
 =?utf-8?B?cFN0dVBvTXUwTE9jM1ZGYXNnZERRMFpXNDM0S1lRVzQwQkdjWDVrRFM0cFdC?=
 =?utf-8?B?aW1qYkFkZHZRSzk5RGd0Z2hpTWRDK3BEQUlING5Ddm4xbFRiSGVWVlk2WC9k?=
 =?utf-8?B?NytVNlNtODJIeXFpS3RjbkppZ0FkM3M4c1hESnBoMWpuM2hiUW5nY0tKWjVB?=
 =?utf-8?B?Qm1oVURHazFsRjlRbmkyN0RtUmxVblN4SHBuc25rZ2cvSGo1VmJZR2Rhdjdr?=
 =?utf-8?B?d0ZvUzc4TFlac1B1K2wrNi8ySU10dElFd0xQQzNxdkdSS1NBM2F2RmI5WVhv?=
 =?utf-8?B?ZGZKSldVZSttbnFaemRsTGJsc0VzRFcvZCtDZ1NadUhGa29WQ0JTa042Qkxi?=
 =?utf-8?B?eUhTeFFveWxKQityL05TL1V5SkUzNEhoUVFGbEJyTGE0R1RSVERROGdMdnZk?=
 =?utf-8?B?ZERaU3hCSkVjQVorU3pDcjZJM3UwL3p5ZnVTaEQvQ3RuY1FGWTdhQ0gzNElt?=
 =?utf-8?B?d0E2bVFQc1oxMlNSc2lJL1c2OEJOWC81cHBwWUtPZWxReUlISnlveTVSdEE3?=
 =?utf-8?B?MGtBK3BQdWVrWVpQVUI2Z1A0QTgyWkRJSVVvbUZUcWk1bi9ESmQ4TGNmWk00?=
 =?utf-8?B?UTBBb3RHUmt2QlduMHczMVQxMXZNaG5ENXhIR1pWbnNWNTgyVFlUTll1UkNp?=
 =?utf-8?B?TE9kSjZuZ3lueE5jbkdUSUVmSjNGZU9jZWlYcmZKemwvdVk1UWxwMVg5V2dE?=
 =?utf-8?B?UmU0OS8zektJZUlpcmhMeTRjbUs1dWxvWVhsRTM2OHZiYjA4VzR0cHJEK2tV?=
 =?utf-8?B?NWM5R2pVV0wxVTYvc3RibDZrelhIbDBWcTlDWURWMFBnUW40QURXSGtzanNm?=
 =?utf-8?B?dENxKzJ5NzZRdFlic2QvWVpLbEU1VzJjK0tYbFVXaU13Q0tQazZjTlVxTlgw?=
 =?utf-8?B?cE1EVkdUMmNXdE5NTk0xUkl2Zms1aCthUVZVWmdXZ2g5RVk2MHIzS21SaEh4?=
 =?utf-8?B?UnZmb2xkTUgwVFBoL0Vhb1V0aEQzSWdQM1VsbnVFWEw3SFl2dklTTFF5dzhu?=
 =?utf-8?B?aXFPdFovWGp1b1QrMWJ0bnhTdlgvbjlKOGhHSzBkL05UUjdCeFNZRzdYN2hN?=
 =?utf-8?B?U25KUkpESGtjWjI3aWNERWJkdTRMOERWUTBZd0YyZWVDTlV3OUhtd1pzSHJM?=
 =?utf-8?B?SURubkRBRTZmMjd0Rk1JUXdkRVFtRGFGNjZoRVNyaHdvSnNnV1pBVDBSMG1W?=
 =?utf-8?B?KzlhYnVtRzhEWWs2SW1xRUxjNisrcEZCbkVnUEJpbms5ZkdFbVZJUlNPU09B?=
 =?utf-8?B?eThnSFp3djJvU1ZpZ2p3WGpCalZzS0hIUTlHSnJYRzB0SUduRjh3L3laWkla?=
 =?utf-8?B?U3ZTbVpFSUJ1Y1RIQkpSL3dYRW5SLzNXMEdtWHM3WnY3NVlHb1haMXBFU2NJ?=
 =?utf-8?B?ODR3VXozdHpsZWdKK24ycnQ0QkJ6KzRKTDJUZG1YTkFWemd4cXZlcExhL3Zr?=
 =?utf-8?B?c0dIUkYrc0R3ZGRNU0tzNmJYWTkzOHpoL3grSUlNMS9Pb1RURVFVNlM4MFZY?=
 =?utf-8?B?RlJwcU8xNUM4Ymk1ekJ0UHJBMlo5QlBHSnV2L3lQYm1CekNlK3RabWtXKzhn?=
 =?utf-8?B?d0g3MGFTV3RjQnpPcXhrNWZ1N2dKZFVlYmhKcmFZN2tBVEVaZTQ0c3V2VHlv?=
 =?utf-8?B?QTA2UFpGU05xdjhpdGZ4K21zMmRCM2JGc1BYVURxV3g4RUtvS1NVUnk5Slk3?=
 =?utf-8?B?ZWZGRHB4SWZLZXRvK09PNzRYRFgvZ2RDRGtKL2lrM09CSU1ROWp6R0J3Y3Jq?=
 =?utf-8?Q?uy/XPSNOFNWPL5R63QANw5naB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB79D1116E07974D825B4580DCC84A13@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c9401f-b690-4d5e-87b8-08dae5416b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 23:57:16.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnjfunIVjY708v1pe2jmFxXsrdwV8jCWMSKnVnWOINsyQ2ZOflMVPH6wb8bH9lGRKTUYhHA9iJ6A7FO6r8zoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Proofpoint-GUID: Q_86hF5vZF4xhGYawQZLhFzt9owFCCRD
X-Proofpoint-ORIG-GUID: Q_86hF5vZF4xhGYawQZLhFzt9owFCCRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgRGVjIDIzLCAyMDIyLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+IA0KPiBI
aSwNCj4gDQo+IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4gPj4gPiBU
aGUgUm9ja2NoaXAgUkszMzk5IERXQzMgbm9kZSBoYXMgJ3Bvd2VyLWRvbWFpbicgcHJvcGVydHkg
d2hpY2ggaXNuJ3QNCj4gPj4gPiBhbGxvd2VkIGJ5IHRoZSBzY2hlbWE6DQo+ID4+ID4NCj4gPj4g
PiB1c2JAZmU5MDAwMDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgn
cG93ZXItZG9tYWlucycgd2FzIHVuZXhwZWN0ZWQpDQo+ID4+ID4NCj4gPj4gPiBBbGxvdyBEV0Mz
IG5vZGVzIHRvIGhhdmUgYSBzaW5nbGUgcG93ZXItZG9tYWlucyBlbnRyeS4gV2UgY291bGQgaW5z
dGVhZA0KPiA+PiA+IG1vdmUgdGhlIHBvd2VyLWRvbWFpbnMgcHJvcGVydHkgdG8gdGhlIHBhcmVu
dCB3cmFwcGVyIG5vZGUsIGJ1dCB0aGUNCj4gPj4gPiBjb3VsZCBiZSBhbiBBQkkgYnJlYWsgKExp
bnV4IHNob3VsZG4ndCBjYXJlKS4gQWxzbywgd2UgZG9uJ3Qgd2FudCB0bw0KPiA+PiA+IGVuY291
cmFnZSB0aGUgcGF0dGVybiBvZiB3cmFwcGVyIG5vZGVzIGp1c3QgdG8gZGVmaW5lIHJlc291cmNl
cyBzdWNoIGFzDQo+ID4+ID4gY2xvY2tzLCByZXNldHMsIHBvd2VyLWRvbWFpbnMsIGV0Yy4gd2hl
biBub3QgbmVjZXNzYXJ5Lg0KPiA+PiA+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPj4gPiAtLS0NCj4gPj4gPiAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCB8IDMgKysrDQo+ID4+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPj4gPg0KPiA+PiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+
PiA+IGluZGV4IDZkNzgwNDhjNDYxMy4uYmNlZmQxYzI0MTBhIDEwMDY0NA0KPiA+PiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4g
Pj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdj
My55YW1sDQo+ID4+ID4gQEAgLTkxLDYgKzkxLDkgQEAgcHJvcGVydGllczoNCj4gPj4gPiAgICAg
ICAgICAtIHVzYjItcGh5DQo+ID4+ID4gICAgICAgICAgLSB1c2IzLXBoeQ0KPiA+PiA+DQo+ID4+
ID4gKyAgcG93ZXItZG9tYWluczoNCj4gPj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4+DQo+ID4+
IEFGQUlDVCB0aGlzIGNhbiBiZSBpbmNvcnJlY3QuIEFsc28sIHlvdSBjb3VsZCBoYXZlIENjIHRo
ZSBkd2MzDQo+ID4+IG1haW50YWluZXIgdG8gZ2V0IGNvbW1lbnRzLg0KDQpGZWxpcGUgaXMgY29y
cmVjdC4gV2UgaGF2ZSAyIHBvd2VyLWRvbWFpbnM6IENvcmUgZG9tYWluIGFuZCBQTVUuDQoNCj4g
Pg0KPiA+IFdoZW4gd2UgaGF2ZSBhIHVzZXIgd2l0aCBtb3JlIGFuZCBrbm93IHdoYXQgZWFjaCBv
bmUgaXMsIHRoZW4gd2UgY2FuDQo+ID4gZXh0ZW5kIGl0LiBBbGwgdGhlIG90aGVyIHVzZXJzICh1
cHN0cmVhbSksIHB1dCAncG93ZXItZG9tYWlucycgaW4gdGhlDQo+IA0KPiBXb24ndCB0aGF0IGJl
IGFuIEFCSSBicmVhayBhdCB0aGF0IHBvaW50PyBZb3UnbGwgY2hhbmdlIHRoZSBtYXhpbXVtDQo+
IG51bWJlciBvZiBwb3dlci1kb21haW5zLg0KPiANCj4gPiB3cmFwcGVyIG5vZGUuIEJ1dCB0aGlz
IGlzIHdoYXQgd2UgbmVlZCBub3cgZm9yIFJLMzM5OS4NCj4gPg0KPiA+IEkgdXNlZCBnZXRfbWFp
bnRhaW5lcnMucGwuIElmIHRoYXQncyB0aGUgd3Jvbmcgb3V0cHV0LCBmaXggaXQgcGxlYXNlLg0K
PiANCj4gQFRoaW5oLCBwZXJoYXBzIHlvdSBzaG91bGQgYWRkIGR3YzMgYmluZGluZyBmaWxlIHRv
IHRoZSBsaXN0IG9mDQo+IG1haW50YWluZWQgZmlsZXMgZm9yIHlvdT8NCj4gDQoNClN1cmUsIGlm
IG1ha2VzIHNlbnNlIHRvIGRvIHNvLiBJZiB0aGVyZSdzIG5vIG9iamVjdGlvbiwgSSBjYW4gYWxz
bw0KbWFpbnRhaW4vcmV2aWV3IGl0Lg0KDQpJIGNhbiBjcmVhdGUgYSBwYXRjaCBhZnRlciBjb21p
bmcgYmFjayBmcm9tIG15IGJyZWFrIGluIDIgd2Vla3MuDQpTaW5jZSBJJ20gb24gYSBicmVhayBh
dCB0aGUgbW9tZW50LCBteSByZXNwb25zZSBtYXkgYmUgZGVsYXllZC4NCg0KVGhhbmtzLA0KVGhp
bmg=
