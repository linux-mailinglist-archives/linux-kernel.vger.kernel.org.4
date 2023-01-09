Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08F663097
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjAITkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjAITkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:40:39 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43676EC5;
        Mon,  9 Jan 2023 11:40:36 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309Iev5f015606;
        Mon, 9 Jan 2023 11:40:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=cRUGYPghimN6iIUt1OcESGxg+zzYjb8HvGiv3jRtRJ4=;
 b=N9Wxnvq112zMPGJmwtr+0MTOyagh9er+UkvfNXtxW2kcY1hrwp5aWlaxuGHidpUZyatW
 IteoSPRC+Xl6jJlZWwydDplyb8V6AdkEJuYXeiFAj5qGZp+MO8YtuBuDVGmmWgLrJqTU
 +Go8Hx/jYn8XuTPPFZLV/sTIzzWli+7diZFH1g7UgB1OxA0caB1WNnqeiAWGVIOKNAl9
 4VEmx/bLTCYMgeun1VVZZfPCU5y6fGAPfzOpY+x1iEOVCYHfWX0CN4rPatGZV2NSJl3Y
 wNHdesKmqgfuYTTiYeulXwO8iNBx4JPfiEoHmyEk6EeZtp7Fcpr7XcfNUuodkG/oa13U 3g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3my88n9h60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 11:40:20 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3755F4008A;
        Mon,  9 Jan 2023 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673293219; bh=cRUGYPghimN6iIUt1OcESGxg+zzYjb8HvGiv3jRtRJ4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Di9JNJlPKFM0vPotflduaG+DjGs+g96epwOtS0TWvLADEZNMvKqql5rgo83C6zvJA
         d5wMFh9amdrZfHoRmXvw1MQBHg46IoJH/W2rqCefkFzPW5H6faE5znotWLXYxA+ZST
         1mYgioINt2zBV5qaV2aqxDk4yZZyrV85KqrrlUKysZA1DFYd2Ln4f56Uu68Atoqmu7
         ivLyMcL75rZbsqrAR/E/H0ALWvq0wZ3Bo25Br180df6Dcg9IqVpXyCLau57InOYBO3
         Dbgv2wr4D9mu0vDHfEsWayX/NHdXeyDxVztfAesq2YmyfOxN8nPcaiTWz0Q7JQS3xb
         oxtD74d5eTpiw==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B5AA6A0084;
        Mon,  9 Jan 2023 19:40:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 788EA40060;
        Mon,  9 Jan 2023 19:40:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vTo4tqrq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3MirmfKn5pAwDI6m9a8xseLiH+g/sKXrgZaf0VkJI7KMKX4mnaM/pN4gUm89JJ9G8ZjKW2rfb3HlYJ8rTkmTlp+nyH7gug0GT2w9PUUGcazBblUPd15GCrbQ67gWojUalmR0iKDcWW4uotNad6RhKLp6eOpKUtY4suDCzn4NXdWb6JRHPQaTgJz/Syr2KJTNAQHDPSZgv06u7oOig13f7IubPabSpajXvQRTVdHXEelL/Ft4RXYVATHj6a8iw6/OO0mRhV+D2vDTH5hZgCcEA/YAzeafdXtWoqfDgs8KiK22KxHWkztp5VVyq95nofiPD/19bZg3CE8T3oVGNQlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRUGYPghimN6iIUt1OcESGxg+zzYjb8HvGiv3jRtRJ4=;
 b=c2/R6hn9ZwR/fyL57R+mOZFJQJAMrJUwX9Er1GtTMLfzEH82fxacGfBJeP8/ciQHUHG5Sq6zvuDEUqRWWXBcGZYndYnm6hwiw785AK6o8/HHc6POxfYfhS6vxppfqmPcgwzv4bO+2VwsVYG82QyFQJPJWRzxJsefH4p4G0UWrH66JL0o1Vw0u70w7+jwnWHG/4x2PGY3epzzczloUHGeegrE3XCbd/Tv1waxax27UTcCwCuaYeFwYiFtFqSoDe0ix2PNjvXXwtOqHP+40fkefT2PiLmFsqey81dprMJn3oPjbBCqtaEP7Dlw3DXZq1uwLGdmg7kYf0+Jm37MHQC54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRUGYPghimN6iIUt1OcESGxg+zzYjb8HvGiv3jRtRJ4=;
 b=vTo4tqrqaT9TzmzctkRygqx65d2vZ9OIc9xruTBx7/AAesKEiD6dUvoL83db2alc55eTWPMsmRv8IZQRi4bQ1dRVZap0BeANK8E/SMxM7+NaE7TW+ou5XlTDHybb1Aj147X6kCt++Si33IJq0UBDkYBdkUuP4xyjlMxv+kY2hf0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 19:40:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 19:40:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Thread-Index: AQHZE93Ovub27gHGRUWi+BBXvB4w9652Yz6AgABs/oCABHtWgIAA4T8AgAEoRICACNjVAIAAiSoAgAAD/wCABmgOgIAJeXoA
Date:   Mon, 9 Jan 2023 19:40:09 +0000
Message-ID: <20230109194004.yqaqslcwnqqywkr3@synopsys.com>
References: <20221219191038.1973807-1-robh@kernel.org>
 <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
 <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
 <87o7rlffi7.fsf@balbi.sh>
 <CAL_Jsq+viP_aY3n378WC7WpxZFnsTc-vKjW9Ojvcy0Ef-z09Ng@mail.gmail.com>
 <87k028g6ol.fsf@balbi.sh>
 <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
In-Reply-To: <CAL_JsqKjrXsz6hak2rG3GMKaOot4azDWpYCOsQmdVtmszN1WQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB6186:EE_
x-ms-office365-filtering-correlation-id: 9808df78-e499-4941-3c44-08daf2795199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0RnzbM/Gf+6vFbEKlcrczaAU/+sCRrIuyJqd7CvWRhsjcX3Fz07IqISkz5HdCXOi0fDP00TCoDRdIUlhhhEtYvdpaOULhgHpXyPAGQFk4G61n/X1p0oGnpqE4DUGmUhhUgqFjjTBk+rs61f85aQ/CbflTlaRJKUohifGF35+K/QzlxC2cVbspnCwTsYesD5pxWsQq0q6CGAe8NGIJxC7c0U9e3eROUYLAm41TDTXCaubheEDosKRT2gioSqMlRUJQ0eEkyt5WmN1pIJYURZp4RJs+wThRM2e1bAcPkA5zMSU8eR5NyKRaKxhHcVp4r7kPPTKp4nLojltaPJNu5wg2wvBqu+yF/IFu/ytiPU5PrUUToBQ2gvdoRsI3Er/Asw5g8EKiZA/lpsR+j3XUpSYDddHa63rXPo+oc+Nx7g9OWiai9kGlNUr78zVJtgSmtVZU9g3sqSReKNw3kmQjhzr7GWN0UriRkWFckzhh1YAEF6IF/qWPK4A2t9sSlwpm1uUf7Ts7Wvt2jElphxOl8fP8h8RIwNBU0WmBDpHWXImc+2VSZiUmY6j9zuP15gI6uPAXirko5RgUOYVK1cfDOm27JlTWRHz5IZtUAs/MDYjQLbqu79R1SNdQaDAgSAXVegLeHKz/WpcLlXMPDrPHEonME/segCr7dUca8t+3AnszY27TAoVI9jCtk/vOPvn9n1Fzkc8ZiBk8L48R6CNGat4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(5660300002)(2906002)(7416002)(8676002)(66946007)(76116006)(86362001)(1076003)(66476007)(2616005)(36756003)(4326008)(6916009)(6486002)(54906003)(38100700002)(64756008)(316002)(66446008)(66556008)(8936002)(41300700001)(38070700005)(53546011)(26005)(71200400001)(6512007)(122000001)(6506007)(186003)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0tJZ0FqV2k1VEdhbStkNmRtb00rRGRGaFNGWGt1czVxMC82YlZiUFNVbEtE?=
 =?utf-8?B?dk5IeGNSZGF3S0RQdXVsTDVvSSt3eUpSdjNQSGRIM25Pa0Y5dXF0V1hkWjly?=
 =?utf-8?B?MnR2S25LUm1TMXkydUU3MXVNZ2JoaVVLUE1JcXpKU2lkRlZ3d2pnMXRXK1Nk?=
 =?utf-8?B?RVBYREJDVGY2eVV6WU1scExSSDNJWVh5UXIwd0d3NitSQnlkcXl3QS9RbjZ2?=
 =?utf-8?B?VjhCNFo5cDBnbFZWL3VOQTNVeFd4RHJRUGRuUDExeGtYWjVEbUJKRmpBb0h2?=
 =?utf-8?B?YVZBQ2s1dTlrUlJYUDFEenBESnpMZUZYWUNRencxcC9Cbi9WRCtQNWMyQWdn?=
 =?utf-8?B?TlQ5emw4Ym14cWhPZkxnL1o4dEw2alFHVEtqVXBHZFczMi9OUTBGaHVHczJt?=
 =?utf-8?B?Tld6WEowM1YwRTBKUWptRXpvNm1pd29UZTUxT2pBcGRUVnBvL092TCtuS2VX?=
 =?utf-8?B?TG51NDVWYlk2K1I1RjZyaXdiVnhVZTZ5cGVpRzRYTDB6bjZlNGk4eG9aZjBk?=
 =?utf-8?B?cDg0dldaSEJLZlZZNERDVUVWTWpXUVdWOWJ1V1pVWkhQSVQ5TDdDYWJnSytx?=
 =?utf-8?B?cE9HZzNENFJ5RTRwRHZoSVdOejdjaFRCdmU3dHJQanVnT2dqZUQyNXM4WFNl?=
 =?utf-8?B?d3hDT3hucjJpbjlZMHFsTE9zL2oyT0lkeXlFd3RwNCtGSE45QjRQaEtkS29S?=
 =?utf-8?B?a2VOS2J2bmIvUGErK0pxRm5QT3BYOSs1Y0p4VjlJcHFOY3dhSHJRUGtwbkdk?=
 =?utf-8?B?MGVwV1N2UmNjNGVaVnpZV3Bpc2FkK3hxejd6NWtWZS9uSUIrRkZLTmpiMHlP?=
 =?utf-8?B?T3MySmZTS1k0anY2aEpVMUFwem44Q3E0eWlvd0FCZDVTV2dCOHhDenNHQlZy?=
 =?utf-8?B?aFVjdXJGYTBMMnNpakNrN0dka1VZT1BhY0FTQU1jMmxFWVo3a2NWS2lWK3BN?=
 =?utf-8?B?RExQT2ZrejhYb0JlbThKVGM3OHc4akRsdGg5aE1nSDdpY3lhWE8wSFpxUnNn?=
 =?utf-8?B?TG5GbXoyMnJXcUVOMHFsRTl1bW1BUEY0bVlySktIMVB1dnNicGRLMVJFSEZv?=
 =?utf-8?B?bHBFMU9GNEJmVVNYVklPQmZFNXh2TFhUTGk5bjB4b0lEWGhaRHZrUVI2WUp0?=
 =?utf-8?B?NDh0SGgveCtrZE1Kdk8xMU8waDJzQXhpdTJ3UU53MVdkU0tqRk1wdTBnQXJB?=
 =?utf-8?B?MXd6akJ1SHZTaEE1WlJCYStiQXlMclhucmdPWTl6NGV2SzRSaHdFRU9XUnRT?=
 =?utf-8?B?RU44Y01mMmFjNHIrUStSbnJxTTJXZ3haK3JsU21qN0EwYXJoWU5hbkxoK2tz?=
 =?utf-8?B?bDZIUmYxNDJaVFFrQTVTbmVzYklPT3JHMW15WjdrZ2FUSHZFYVFFUmtYOFNI?=
 =?utf-8?B?NXNpVzdwc2laamFoY3N4VXBOOWtHb25Wc3VHdUk0NUNmMDVWTVQ2aW0vaCtB?=
 =?utf-8?B?UEIxclpwdDFRZU0xRkQwZDBjVXdEMXlKQlEwdEI0ejFDdlNoSHJUVG1LZ292?=
 =?utf-8?B?RG03YmI3bkVHcU0xZTJPYUw5U0t2UWVTaWtXVmtHeVZyazI1STZIV200WEZC?=
 =?utf-8?B?OHNiaUZHVkVaMk40K1JYN09NM0laRVdWY2NhMTBNWlZJaXM5M3BibjR3NHZH?=
 =?utf-8?B?V1FhRlpYTzdFODI1dUJuWnB4VlNhWVQxVFRBL3UzMlJEb2hhRURlNHFVZXdR?=
 =?utf-8?B?eDZHS0tEUHgvcER1Z0M3eEpoT0xiaEllQWVLTnpRcks5UTBHeWVGd3J0WVpW?=
 =?utf-8?B?TFNDWkgvTWxVRGhROWJEWE5JWHI4Vno5ZGFZK0VzZUJhWmMwQmpmRjNMQTR3?=
 =?utf-8?B?Y0x4T3JVMk1sRVdQZWNCbHZ3OTdnWnljS3Ficnl1NDRRMGpjdGJ1RGErelor?=
 =?utf-8?B?dWUrQmZRK3pXNG55S0FXQ1pCaFRoMzc1a0VYNzlMUmQvWTFtVVZoMUhucGRT?=
 =?utf-8?B?WGxZR3NLbG0yeWZSVk5QbnN1OXBIZ2s2VTc0eUdycjlycUhSZ3JsVkRqU1A2?=
 =?utf-8?B?ZnRCTGJNWklzK01ES05Pd3ZSZWJ5bEdIaU9DbkxKNlptekxPZUVqV1JHcjR2?=
 =?utf-8?B?MUdWczJqelFxQ0JibW9hcjUwWDU0S2tseUxmWndRWjc4U3QzMEcySDNwYnN5?=
 =?utf-8?B?RTQ2UDA4NG5qUDJjQVBVNWRBQXo5YmlRVXBpYllzSnR0WkQ1VTVlVXVGMUI4?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEA30A0F8E87EA4DBA8E7A058C57BB9A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eWI1RHhjRGdUMGRPamhFS0gzRVVzM2dQQnZXV3FuOTdnR3B6STB0U0h4U1hl?=
 =?utf-8?B?VlpKNENqUzdOMUtUdGYvR0tWeGdJTWV1YUtOTGsrT1ZNR1RZTDIxZFZxWCti?=
 =?utf-8?B?QXp2ZnArMCtwQldMcmhHS2JEemZ4UXVPWnQzTWxvRzlnTU11SzBWT0pET3g3?=
 =?utf-8?B?WE1KV3RLL3lob1BUYWhCb2hwalVhbWZ0T2c0ZlBHMXhLcU5INlVoK1ZTNm16?=
 =?utf-8?B?VDhIV3ZTUm9DWHE4REh0S3ZUWndPWVY2WWpzcVN0MXBGOUU4YkZMSklCVmJi?=
 =?utf-8?B?blh6RVcvR25jNVpyazNlQkY5S00vdS9LaExIYm9xZmducFdkMmZJWjYxUU1L?=
 =?utf-8?B?VmJ1cXZxN09TQlVJblJ0cEVJWTB5d2NJMmQ1TWgvRmNncE5JMjVWVWxmSUpQ?=
 =?utf-8?B?aXJCelZjN0daczdQUW81bnBzSXlpSlQzaExTWlRVZFR2N2xYVWJyT1B4RlBI?=
 =?utf-8?B?enJvUDhzRFRtUUYxNGxkZmJNbG1GaTJpaG5RNk5UYlB3dWVGQWJkdGRRb3Zz?=
 =?utf-8?B?VmJQeEUrYllPZUxiU3IrUVA3YmRJWkpmYXptdGlDYk5Ud3dMUHBrd3p1a1Y3?=
 =?utf-8?B?TXYyYmIxMVA1Z3dsbTkxTmtEM1NXbHBMVGNnV3VOSnplMWpwVXoxcHVRTUph?=
 =?utf-8?B?eWo0WS82eEhsR2twVUJFZ256eFNyYzhLZmd4c3NZR0V0d3hENVJRYWQ3TzF1?=
 =?utf-8?B?djBVcFZJZEVGeWIwMkk4L1JKQ2c2T3FSa3dTRlFKK2hZb253UDMwdGdBRSt2?=
 =?utf-8?B?amY3OVdTd0lTcC9VSC9JeldxMzc0anhhUjcvSlRLWVlBQmRtdVkzSlEzdkgx?=
 =?utf-8?B?bS8wTU4rRzUvS2c1aDBtMXJpSk5HZ2lEMk1JNjkyRi90elhVeXpoald0RW1Y?=
 =?utf-8?B?S1I5M1RVbW0zSUtXMXlzRkdMeWZaOTVoWUVZTTFsRFM1Y1NTRTBxWGtiVDkr?=
 =?utf-8?B?aVdaL1FnSW8yV2tZNFBNOW9iTUVLSGRmbUcwcHRkdnR5QlZXM051dzhrcW1J?=
 =?utf-8?B?YXl6MmJUdkRzVUMzWDAxNWFnL0g4dDNOZW81SlcvNTdEMmdFc1JvN1JDTnd6?=
 =?utf-8?B?VnA3SzNkNnBpZldVZE1uQWs2bVVqU2pKNVMvcjZadms5S21ZWmxDc2pScGNF?=
 =?utf-8?B?R1NISVllSklYTkNNRktBZm5rNmp1STJTckhzN2pCeFErRWttaFVWaFBFSlVM?=
 =?utf-8?B?YmhhSnE1UnB1ckl0dHVvTVBOTnc2M0gvRlhrRUUySEF2enVqd1I4Ui8xTFRz?=
 =?utf-8?B?a2JJSG5CWVc1d1U2MnRmTnVBbGxCRkdFVDVydFVZcmxQWkxkQ0NtbTY3TmNs?=
 =?utf-8?B?Q0tiTTF2Z0RQMHA0Y24rUFZ2VTVidjNWSXA4ZUZjKzNyRFJldWpHNGM0RS9a?=
 =?utf-8?B?U0h5ZFAvZm1uVlBzamVna1ZMcDBtZlVJRzFRbUxzV3ZzQ01Xa3MxQTRvMm45?=
 =?utf-8?B?L1ErU0dLNnRYcnNIT0pwL2R3MVNYLzc2YmpuWUh0V1Bzdk1oTHFqRzZSWjlk?=
 =?utf-8?B?SWxQSWtJeFR6UzJvYXU3ODRzRXM1dzI2K0xsS2hsRm9zd1VPNFBmQXJxRDFO?=
 =?utf-8?Q?D+WPpznEP2sxVg4pJCJTGN6NeEcKAho87hYh2D92/6t1Jk?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9808df78-e499-4941-3c44-08daf2795199
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 19:40:09.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIJ+h9wENM6OHhLSZJ92BMiHbnUIlLzUHF8kn493g7WttsL0igzLYRps65agiZLf03Unmw3dgsfdBopwCgA0zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
X-Proofpoint-ORIG-GUID: 07cZMhiD90sBltf_2idU9jm3MM1uw_6d
X-Proofpoint-GUID: 07cZMhiD90sBltf_2idU9jm3MM1uw_6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_13,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMDMsIDIwMjMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBGcmksIERlYyAz
MCwgMjAyMiBhdCAxMTowOSBBTSBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+IHdyaXRlczoNCj4gPiA+PiA+PiA+ID4+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwgfCAzICsrKw0KPiA+ID4+ID4+ID4gPj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4+ID4+ID4gPj4gPg0KPiA+ID4+ID4+
ID4gPj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi9zbnBzLGR3YzMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
c25wcyxkd2MzLnlhbWwNCj4gPiA+PiA+PiA+ID4+ID4gaW5kZXggNmQ3ODA0OGM0NjEzLi5iY2Vm
ZDFjMjQxMGEgMTAwNjQ0DQo+ID4gPj4gPj4gPiA+PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiA+PiA+PiA+ID4+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0K
PiA+ID4+ID4+ID4gPj4gPiBAQCAtOTEsNiArOTEsOSBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4+ID4+
ID4gPj4gPiAgICAgICAgICAtIHVzYjItcGh5DQo+ID4gPj4gPj4gPiA+PiA+ICAgICAgICAgIC0g
dXNiMy1waHkNCj4gPiA+PiA+PiA+ID4+ID4NCj4gPiA+PiA+PiA+ID4+ID4gKyAgcG93ZXItZG9t
YWluczoNCj4gPiA+PiA+PiA+ID4+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4+ID4+ID4gPj4N
Cj4gPiA+PiA+PiA+ID4+IEFGQUlDVCB0aGlzIGNhbiBiZSBpbmNvcnJlY3QuIEFsc28sIHlvdSBj
b3VsZCBoYXZlIENjIHRoZSBkd2MzDQo+ID4gPj4gPj4gPiA+PiBtYWludGFpbmVyIHRvIGdldCBj
b21tZW50cy4NCj4gPiA+PiA+Pg0KPiA+ID4+ID4+IEZlbGlwZSBpcyBjb3JyZWN0LiBXZSBoYXZl
IDIgcG93ZXItZG9tYWluczogQ29yZSBkb21haW4gYW5kIFBNVS4NCj4gPiA+PiA+DQo+ID4gPj4g
PiBQb3dlciBtYW5hZ2VtZW50IHVuaXQ/IFBlcmZvcm1hbmNlIG1hbmFnZW1lbnQgdW5pdD8NCj4g
PiA+PiA+DQo+ID4gPj4gPiBUaGF0IGRvZXNuJ3QgY2hhbmdlIHRoYXQgdGhlIHJrMzM5OSBpcyAx
IGFuZCB3ZSdyZSBzdHVjayB3aXRoIGl0LiBTbyBJDQo+ID4gPj4gPiBjYW4gc2F5IDEgb3IgMiBk
b21haW5zLCBvciB3ZSBhZGQgdGhlIDJuZCBkb21haW4gd2hlbiBzb21lb25lIG5lZWRzDQo+ID4g
Pj4gPiBpdC4NCj4gPiA+Pg0KPiA+ID4+IElzbid0IHRoZSBzbnBzLGR3YzMueWFtbCBkb2N1bWVu
dCBzdXBwb3NlZCB0byBkb2N1bWVudCBkd2MzJ3MgdmlldyBvZg0KPiA+ID4+IHRoZSB3b3JsZD8g
SW4gdGhhdCBjYXNlLCBkd2MzIGV4cGVjdHMgMiBwb3dlciBkb21haW5zLiBJdCBqdXN0IHNvDQo+
ID4gPj4gaGFwcGVucyB0aGF0IGluIHJrMzM5OSB0aGV5IGFyZSBmZWQgZnJvbSB0aGUgc2FtZSBw
b3dlciBzdXBwbHksIGJ1dA0KPiA+ID4+IGR3YzMnIHN0aWxsIHRoaW5rcyB0aGVyZSBhcmUgdHdv
IG9mIHRoZW0uIE5vPw0KPiA+ID4NCj4gPiA+IFllcy4gVGhhdCBpcyBob3cgYmluZGluZ3MgKnNo
b3VsZCogYmUuIEhvd2V2ZXIsIFJLMzM5OSBkZWZpbmVkIG9uZSBQRA0KPiA+ID4gbG9uZyBhZ28g
YW5kIGl0J3MgYW4gQUJJLiBTbyB3ZSBhcmUgc3R1Y2sgd2l0aCBpdC4gRXZlcnlvbmUgZWxzZSBw
dXQNCj4gPg0KPiA+IEFyZSB5b3UgY29uZnVzaW5nIHRoaW5ncywgcGVyaGFwcz8gRFdDMywgdGhl
IGJsb2NrIFN5bm9wc3lzIGxpY2Vuc2VzLA0KPiA+IGhhcywgYXMgVGhpbmggY29uZmlybWVkLCAy
IGludGVybmFsIHBvd2VyIGRvbWFpbnMuIEhvdyBPRU1zIChUSSwgSW50ZWwsDQo+ID4gUm9ja2No
aXAsIEFsbHdpbm5lciwgZXRjKSBkZWNpZGUgdG8gaW50ZWdyYXRlIHRoZSBJUCBpbnRvIHRoZWly
IHN5c3RlbXMNCj4gPiBpcyBzb21ldGhpbmcgZGlmZmVyZW50LiBUaGF0IGlzIHBhcnQgb2YgdGhl
IChzby1jYWxsZWQpDQo+ID4gd3JhcHBlci4gRGlmZmVyZW50IGludGVncmF0b3JzIHdpbGwgd3Jh
cCBTeW5vcHN5cyBJUCBob3dldmVyIHRoZXkgc2VlDQo+ID4gZml0LCBhcyBsb25nIGFzIHRoZXkg
Y2FuIHByb3ZpZGUgYSBzdWl0YWJsZSB0cmFuc2xhdGlvbiBsYXllciBiZXR3ZWVuDQo+ID4gU3lu
b3BzeXMgb3duIHZpZXcgb2YgdGhlIHdvcmxkIChpdHMgb3duIGludGVyY29ubmVjdCBpbXBsZW1l
bnRhdGlvbiwgb2YNCj4gPiB3aGljaCB0aGVyZSBhcmUgMyB0byBjaG9vc2UgZnJvbSwgSUlSQykg
YW5kIHRoZSByZXN0IG9mIHRoZSBTb0MuDQo+ID4NCj4gPiBQZXJoYXBzIHdoYXQgUkszMzk5IGRp
ZCB3YXMgcHJvdmlkZSBhIHNpbmdsZSBwb3dlciBkb21haW4gYXQgdGhlIHdyYXBwZXINCj4gPiBs
ZXZlbCB0aGF0IGZlZWRzIGJvdGggb2YgRFdDMydzIG93biBwb3dlciBkb21haW5zLCBidXQgRFdD
MyBpdHNlbGYgc3RpbGwNCg0KSnVzdCBmb3Igc29tZSBhZGRpdGlvbmFsIGNvbnRleHQvdXNlIGNh
c2UsIHRoZSBwb3dlciB0byB0aGUgUE1VIChwb3dlcg0KbWFuYWdlbWVudCB1bml0KSBtdXN0IGFs
d2F5cyBiZSBvbi4gSWYgdGhlIGRldmljZSBzdXBwb3J0cyBoaWJlcm5hdGlvbiwNCmluIGhpYmVy
bmF0aW9uLCB0aGUgcG93ZXIgc3VwcGx5IHRvIHRoZSBjb3JlIGNhbiBiZSB0dXJuZWQgb2ZmLg0K
DQo+ID4gaGFzIDIgcG93ZXIgZG9tYWlucywgdGhhdCdzIG5vdCBzb21ldGhpbmcgcm9ja2NoaXAg
Y2FuIGNoYW5nZSB3aXRob3V0DQo+ID4gcmlza2luZyB0aGUgbG9zcyBvZiBzdXBwb3J0IGZyb20g
U3lub3BzeXMsIGFzIGl0IHdvdWxkIG5vdCBiZSBTeW5vcHN5cw0KPiA+IElQIGFueW1vcmUuDQo+
IA0KPiBBZ2Fpbiwgbm9uZSBvZiB0aGlzIG1hdHRlcnMuIEknbSBkb2N1bWVudGluZyB3aGF0IGlz
IGFscmVhZHkgaW4gdXNlDQo+IGFuZCBhbiBBQkksIG5vdCB3aGF0IGlzIGNvcnJlY3QuIFRoZSB0
aW1lIGZvciBjb3JyZWN0bmVzcyB3YXMgd2hlbg0KPiB0aGlzIGJpbmRpbmcgd2FzIGFkZGVkLg0K
DQpUaGF0J3MgdW5mb3J0dW5hdGUuIFRoYXQgbWFrZXMgdGhpcyB2ZXJ5IGRpZmZpY3VsdCB0byBt
YWludGFpbiBpZiB3ZQ0KY2FuJ3QgcmVjdGlmeSBhIG1pc3Rha2UuDQoNCj4gDQo+IFRvIG1vdmUg
Zm9yd2FyZCwgaG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBwb3dlci1kb21h
aW5zOg0KPiAgIGRlc2NyaXB0aW9uOiBSZWFsbHkgdGhlcmUgYXJlIDIgUERzLCBidXQgc29tZSBp
bXBsZW1lbnRhdGlvbnMNCj4gZGVmaW5lZCBhIHNpbmdsZSBQRC4NCj4gICBtaW5JdGVtczogMQ0K
PiAgIGl0ZW1zOg0KPiAgICAgLSBkZXNjcmlwdGlvbjogY29yZQ0KPiAgICAgLSBkZXNjcmlwdGlv
bjogUE1VDQo+IA0KPiBXZSB1bmZvcnR1bmF0ZWx5IGNhbid0IGNvbnN0cmFpbiB0aGlzIHRvIFJv
Y2tjaGlwIGluIHRoZSBzY2hlbWENCj4gYmVjYXVzZSB0aGF0IHNwZWNpZmljIGluZm9ybWF0aW9u
IGlzIGluIHRoZSBwYXJlbnQgbm9kZS4NCj4gDQo+IChraW5kIG9mIGNyYXBweSBkZXNjcmlwdGlv
bnMgdG9vLCBidXQgdGhhdCdzIHRoZSBhbW91bnQgb2YgaW5mb3JtYXRpb24gSSBoYXZlLikNCg0K
Q2FuIHdlIG9taXQgbWVudGlvbmluZyBtaW4gb3IgbWF4SXRlbXM/IFdoaWxlIGl0IG1heSBub3Qg
YmUgZGVzaXJlZCwNCml0J3Mgbm90IGEgaGFyZCByZXF1aXJlbWVudCByaWdodD8gVGhpcyBjYW4g
aGVscCBhdm9pZCBzb21lIGNvbmZ1c2lvbg0Kd2l0aCBkZXZpY2V0cmVlIGRvY3VtZW50YXRpb24g
YW5kIGR3YzMgZGF0YWJvb2suDQoNClRoYW5rcywNClRoaW5oDQoNCj4gDQo+ID4gPiBwb3dlci1k
b21haW5zIGluIHRoZSBwYXJlbnQgYmVjYXVzZSBvYnZpb3VzbHkgdGhlIERXQzMgaGFzIDANCj4g
PiA+IHBvd2VyLWRvbWFpbnMuDQo+ID4NCj4gPiBIb3cgZGlkIHlvdSBjb21lIHRvIHRoaXMgY29u
Y2x1c2lvbj8NCj4gDQo+IEJ5IHRlc3RpbmcgdGhlIHNjaGVtYSBhZ2FpbnN0IHRoZSBpbiB0cmVl
IC5kdHMgZmlsZXMuIFRvIGRhdGUsIG5vIG9uZQ0KPiBvdGhlciB0aGFuIFJvY2tjaGlwIGhhcyBw
b3dlci1kb21haW5zIGluIHRoZSBEV0MzIG5vZGUuDQo+IA0K
