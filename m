Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA963082A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiKSA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiKSA6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:58:02 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC8DD4281;
        Fri, 18 Nov 2022 15:56:41 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILi8pQ015274;
        Fri, 18 Nov 2022 15:55:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HxpvTtTs3u/j1RGAhMuJHvecMhhkBSJ7UcfmGHLWimk=;
 b=r2u6G5FA6q4uyezc4ihIv+obW9ZwzGuW6bKZ/FeWGdZGb0BxqvZvqh6SArhrwGjdFtBr
 D+GU7IIzH1tZ5WHVOXpfaRcDkAQl7bD15GXMJriqXMP1tj2HEFO1QAlto+mGiXOF8xTG
 uc85UUTF4T/2LQ8LEC5RxIRtc2uglawWsTKcCf+fRY6BB39Zm9SRTxfp1+7CnYPxLwR7
 YZVnLGDeFHMETt1TEfmqNmTJ4aF95p4JxgESBSCBUrys6wkZfpKxSg9gHlyV3VTgzqa2
 5AC2JLXLbK57h/Z8+wdydoJXD33ruvv03dCSsHREABF/5X4742sOwMk/SX/DtIqhlEdx uA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kx0p24ykn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:55:29 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 78A5640020;
        Fri, 18 Nov 2022 23:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1668815729; bh=HxpvTtTs3u/j1RGAhMuJHvecMhhkBSJ7UcfmGHLWimk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T0aL10gYYEb/SxcyRkmd0ctLNgUmcr/zS9h/lsaqi7X1tgQbW7X1PZtQ3IDy1LyyN
         oi8XrkU79vEbZtNrLmAbZCt+eq9N+pe7qBPuF7vUeMMvzhFev85CrhxARR2geroo78
         V6xDNB6aIjV8ZKiafcbjJlobZXA1n7EHDtSft6cLMaRaVll/M31Dd74/LqmuuvDLJS
         Zzxi2v480zx8nerrOU+Z7OfjeKHIMDHbzZ+rjYVSptzJ1nQfGFIi69Re6o6e9KgvI9
         5KkyuN5PnGqGB3q0gCzabbryFZqKsEZ9CO1nXSbOXfmUzUVN0jiskodbMqFmXmWelA
         8x6mwD1ts+8fA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2E33FA00AA;
        Fri, 18 Nov 2022 23:55:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E295940052;
        Fri, 18 Nov 2022 23:55:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fPrbwEpl";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDKm58obELGFeHPomZQhYU2fnwa69vmuT67r55DEH8IHbKf7Hc93oKh+hUwmlRpntQFNMkTCwPNBKH8HGmKa/+V1WG0pOS70oTAlnykx029LfakZCV5a8tN9T5i+fJKSFwSqznMsuHdnYm9mMCdceUGqM4XFxXojZ2z4/oIREdaglKh5URWvmJCt39OecGEcGNgSGK4B1Q7bcZMMMjRlDJhmwGh/I+C34zNgrwvUggCXuHlBlSK53MCAYjb1KjyTBHgPuKiE4gYFgSA4ebhCFbCBynbRRQTSok/wzJaQ/n5x39S3sNzhBNkQu4iUGr9jwchWwfWG1kY8jAwF1zW9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxpvTtTs3u/j1RGAhMuJHvecMhhkBSJ7UcfmGHLWimk=;
 b=GhyUuqjr7laUSI1WRTCGyoLmA6kULAbMVSvrltelvJHLtchTEijtnZVuR5QA/KKpUGGEdzh4THbOzoKuzL3IE3Sql0D9Z4VmHgXRYBPrym0I+bF8dVZQwYS9BbumD3hviCa6wMuVCNORwYbhkAWqrKVuCIjtkganYdxwZWHJ6vhVYhWQJQ+AteOLBqklW145lFL0iEzPVgqtKlnovb+itWtVragYsWwDJSSrRy9OXOfNO0/QbGyL+k+u5IzC1MhLQtkE2SPXsngbEnSsjoklSR4GdwI73XR2vuVDCAj8oySbjTcWYZvB0NB2QV5tRrslROrBxI7tv/u7qHF6WItOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxpvTtTs3u/j1RGAhMuJHvecMhhkBSJ7UcfmGHLWimk=;
 b=fPrbwEpl1Q9mTRQ8DaRCzI5lJw++vcUMTDs4MO0gHiEfRjCT7BhZh9vp7RTSossXnESppOxsldhcoF+skpNVB/9QcVoxuQr0Xi6+HhgNfW+jCbjAvCZnP0Fei2r9r9knj5REZfuJADU7LfMcqwnMctLtYL5q0i3zS1WeEDhQF2A=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 23:55:23 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::e58a:7cc5:864c:b0b1]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::e58a:7cc5:864c:b0b1%5]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 23:55:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ferry Toth <fntoth@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Topic: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Index: AQHY9IlJN29tIhObE0O0gi/uwdEV+K43R46AgADT/YCAAIQ2gIAAUaAAgAxf/oCAABfzAA==
Date:   Fri, 18 Nov 2022 23:55:22 +0000
Message-ID: <20221118235512.h44h24lpisbw4r7u@synopsys.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
 <20221110000643.xdoav4c4653x3tjd@synopsys.com>
 <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
 <48e7b906-d7e3-46e3-e2bc-71512a1e64aa@gmail.com>
 <20221111013048.p6ahttrpbgzpavid@synopsys.com>
 <641c4fa2-5406-0254-42de-8fd821876ddd@gmail.com>
In-Reply-To: <641c4fa2-5406-0254-42de-8fd821876ddd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|CH3PR12MB7762:EE_
x-ms-office365-filtering-correlation-id: 6c36a835-adba-4457-0cf2-08dac9c05b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJtPhnMW8Pnnn4fHtUik3raLaDDdjVA4g6be/cydCMOA8n+OTy3jEazPPlOAgfbTjPPwoxGhuGTy5DtoZ4L21LPVhRriSn0/FM4tgmyBy06hjifSKu5H2R6If3ZFmRbLF/pu09wtKOcMywbEvkJQbPEixvazXG0iFjzwI2tb9G9dvAaWfbae0MYGqktSr6uveMqUXA3Y+qRWuBlHhtRgTW3lYesdBZkBw771DFKWS34EqaObfgjNUbXR4xEmyxT8gMFqBbyGcpikjFYP3CyMG3i5jhvC8ChhBXZ933ymEznqBwxltE/rAV2QeaK7whI/cpblaFCBt+ZjKvPd4+GxO1kl7fGchYciD2d+knu2sL3A3GkK7HxCOpr+tY/+AxRuIJk/32DGJ4rxNnVnA8+xzcZh8LFqXr9v+MsSh5O/2Vx3aZlPyhlqw+OQ6bsDvDCC7AvkaAmmTMXdrbYJmI85wBkyKFsAKF2a0y6nkCfUV2tlj2WICqHdshfQBDFDoYlW2xfxXS2HylgHC4LP7VcbHCN/5BShJ5c24llJG/5CTp27AX7zalank3oXGri3ErQA5GJRjENYQTI3Wnj3hUIppG+ub0ttRH7tMJV53WKKBYgjNNp5iBOl7d4SsBr0SN6yUglNWXRYffQlb5OgkSpGqwnpqspmxYHeWWVhuXIbgyLLgSuuNC5Mw4As7DT6XENKZxQvdBcma0kYogk1Py7x6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(26005)(478600001)(6512007)(53546011)(6506007)(66476007)(66556008)(66446008)(2616005)(41300700001)(76116006)(54906003)(186003)(6916009)(64756008)(36756003)(4326008)(8676002)(91956017)(83380400001)(71200400001)(316002)(1076003)(6486002)(66946007)(38100700002)(2906002)(8936002)(5660300002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG5ITlFKSGJLb0tWRU85Q3dIeWcvUlJVdzJvdjN6RHYxT1dXMWUzRmdidnNz?=
 =?utf-8?B?NWZuNUNERGE4TXcvRHR4M2JYSVo4VmN5MkZ5VlhBcTVTOFk0K2FSUHM1dEkz?=
 =?utf-8?B?VU9CelZpWkprSEk2Z3NvbitlMW12K3NSREt6aEE4R1lOWmlBSUlwS3J5RHd1?=
 =?utf-8?B?QmVQVU5TWlVtK25qYWVmYVU3azdENm50TTNTZUVOQW9jdWNGT3BUcjUraVlo?=
 =?utf-8?B?dFdQOHVsZURKdXZYWUlVVjBXTHIyaVhWL2FHSDdmR1FGVEpYNUJRVThSTlhY?=
 =?utf-8?B?bzR0NlZMOGpuRzR3ODZ5cmxHRUpJSHZhL2ZWYVhNUThyRCt5ejYwOXRmQkRm?=
 =?utf-8?B?L093c3hvb0dOdXFPcU4vR29VbmpYYlVqaFcrbkEybGZDVUNBZFR3bHJKNmU1?=
 =?utf-8?B?UlJqcWRYNGVrQzduY3BEOWg4ZENPS3lZdmkxZk9KenJra0hBVGJHalgvUXFv?=
 =?utf-8?B?RXdQN0JTWTRUNmlWTFVSNXoyenBRRmVaUjRXTHpMcGFuY1hYVWdTSkJlQmpj?=
 =?utf-8?B?QnFVek5WMTFSTmhxNXFIdXFyM1V4WGJqMDFqckVCRlZCSk1MSnFCMjNNbk1X?=
 =?utf-8?B?MFZwZ3Z4ZG4xSGtHcEJPWTA0bVQwNHBlZmJ0blNqWWU4V1ErTVFEdlpDRGlX?=
 =?utf-8?B?akRxVkhxOVlsZCtsS2FDU3VqSUcyaWlZVDRpTy84NUdpeTgvK2YzUWtWM05O?=
 =?utf-8?B?clVhNW16N1E5dWRMTkdJY29vTmcrNnJ6cktuaWxQcTdnVzM1RjBaMEtudTcz?=
 =?utf-8?B?OFlPUXUrZU1sQndNeEtxWTlrZTFtWXJjY3Iwb0U2ZDJzbXJPNXRnS2JmUUk2?=
 =?utf-8?B?OVZzcnBqUXBJaVZZMWdxT1lCV25YN1JiSlB3VjEvWUFMTFlSTFJmUEVtcGVp?=
 =?utf-8?B?LzM2ZW1Ha0lXeEZCWk40c25wT2ZVbVMrYmVPa3NEa1RKbGd6K2p1cUdZSW5N?=
 =?utf-8?B?Snh6MzYwWWFkdWJJMms1dld2Zit0WDNpeWZwd0FYelBIQXBSSTlBc25VUG13?=
 =?utf-8?B?bDlpclRFemVjcTNxbUx3T25MVVVseVkrcUx0TTRxZlFqb2EzTy9Pc0V2NlNK?=
 =?utf-8?B?RUU5c2ZobStITjFSSnRZNXBJWFFUT1dVbDdzcGhBMjNNWnN0RDBsWXlpTXNX?=
 =?utf-8?B?TEhDcHhRTExNL1BlbWZIL2duRVFpM1NSRUVzZmREbU14UEFqZmFJVEh1WE5o?=
 =?utf-8?B?aDRZd2xISFNocUE4dFRLUUFqTUkwY1U2Z0w0K0s4R1NhbHBZamdxeW05dkw4?=
 =?utf-8?B?ZHJoTWtxRVJnL0xzdkpLQ1E0MWI3amIwL0o5OXdBTUs4czFaRUFvRHhsL3RX?=
 =?utf-8?B?VzQwcTRHeDZuMnBqWUNZRDM4NSs3c3FjczFwZUNTQUkrQWJHSTdIVGpSemth?=
 =?utf-8?B?a2FPZWZTdm9KeHIzQkhmV3BhM21QUVNQRFZ5WXl6NTVmMHppZDJoSHNnN3Qv?=
 =?utf-8?B?MElIazlnV0pVVG5IZ3JFQW1mVzhjbW9MSVJKN0xLRlRudnhwa3dRN0xiYThO?=
 =?utf-8?B?dlNaT2Y1ZiszRW9OSEY3dmpOaGc3U3Vwc1hmVnlvcGVDN2ZDVWYreDdjczcy?=
 =?utf-8?B?RlNKYzF2OVlqMHlOdGZyREI5b1UwMGRMWXowZmIvNlQvVEg2Vk0vMFlKaDhp?=
 =?utf-8?B?eEwwZVpsS1ZjUldtWjAyM2s1djV3WldaNVRvVVowbVhha0ROQkUwc3IxdHMr?=
 =?utf-8?B?T0Vud1lUQWRaS1ZWVGNYS2ZqR1pMUFhHZVpxbUtTUzE3VTNXaFBZT05vTXB5?=
 =?utf-8?B?cnQwbWd2RG9zbzNvMldUTVpPc3lqZ0hCWUFRbDVpY1pFdGlqU2J2by95ejFL?=
 =?utf-8?B?TVdTZzdnZlQzN0VscXNrdGtMdldTNUdZODBTYTVvZzVqTUI5RmIwTmh0eXNX?=
 =?utf-8?B?NEk3TmZuQjI2ZU94dENzVHlJRFluOEozb0NEMXdwMncrWVVTa1ZuNnY4MWU2?=
 =?utf-8?B?RFhaTFdOcE9UK1A2cER3TEE0eHBvbDg4dDUwc3hpOFhjbmtIajNzR1FHZ21i?=
 =?utf-8?B?bTlBN2xtREt5RG4rc3ZnelZjYmY3VmRvbUFwbnNpc1VUUXB1ZGZFeGVzQ1RY?=
 =?utf-8?B?b2JVYWFQZHJNZkVYUlkzM2RreG5TT283SjAxQTJYT0wrSmFOUWREa3ljekVN?=
 =?utf-8?Q?DfvQCjbFWHkaAt5A8eoSc/ciW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78599433FC3C28478EAFC204F54487E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NEhxbjdRZVZuQytmZXZ2YzBWbjZ2ZU52aUI5NVljbkhlRlJjdWZUOXJ0bkF6?=
 =?utf-8?B?QUF5S05NdlpRTVZQL3hPRnhzRXBKM0Y2L0lpT0NSNXpJaVoxRDBqMnNVR3Bz?=
 =?utf-8?B?V05qWXRQOFFhZ09hV3lockg4VmJXSFlUL0FuY2xRckpPU1VPaHMvK0VZb3Bu?=
 =?utf-8?B?U2xILzU3aC82eWpUbXpmWlJ0eFdKS3B5SlZRSml3ckVSWnZieGVMSTR5TTY0?=
 =?utf-8?B?R1A5M2hlVnRxMXM4bk1sS1ZtdFVNZ1JwdXhSdDV1QzU4aXhFYWJUenI2SDZK?=
 =?utf-8?B?OCt3V1lZU2VjWTdSUFdRUmh6SlhqT2lNMHNnT2pwOGxGSWJFbVFOaXFxRlR5?=
 =?utf-8?B?TExqQ3RUWVI4S2lmZXlaQnlDNUszOFJXZEhZSVF3QmdkU3g4TnJxZXhhMUU4?=
 =?utf-8?B?NWNPTUhpS1BTT1JDczNWVCtZMGFNRWgraWNpWW1jd3FwRDRPbEY2UjMzVksy?=
 =?utf-8?B?bzhVSEhicWlIZVpDRHo2aXZzRXRXaENNZk1sWXJiQWg3NzFGeWIrelFtMUtC?=
 =?utf-8?B?M29STzlSSlJhYjFOZjVnV3QzSWhTenE0WmtraFhZSVJtZ3dSeDRxNW1iODJx?=
 =?utf-8?B?Tjc1eVhmRy9BSE9vZFdDazhyNFJFTWdoVHE3NTVVSGdUbjVrQVVzUXU4Qnlo?=
 =?utf-8?B?YkI1SnN0OUoyRFlYdlFJVEFTZGNxY1JSMUEvNW1GTmZsUVkzV3BTdjdETVkx?=
 =?utf-8?B?WTRKbG80ZzFuc0tIMmhRUkk5TFlGVHVzdHI2N0NxanZqbjhINkR2VFZiTS9p?=
 =?utf-8?B?WmF4em01OGdmR2Rnd21ScG1zU2R6NFZiUFN4Qi8wKzNBTVFWVDdpOFJNdFZG?=
 =?utf-8?B?TU9Qa3gyVFBob0s0YVd0SFBLZXV3QURDZi85dTFXSS9wUE81dEM5YiswTzVW?=
 =?utf-8?B?dnNoc1BoREJDOS9kT1BLMWd6QUc3N3lmRk1rSkRLRXVhNkN1VG93bFNvQ1VT?=
 =?utf-8?B?Zm1NMU41Z0ZoTENSOTA1WG9LUmI4MnMveGlTdnB2Lys0d3ZWcnJGSWE3aUNC?=
 =?utf-8?B?bjNWZGZUNmdGZC96czlBYUpqM0NKK2hNOTZ5MnkzQzNLSWJhSGRLWlZubzly?=
 =?utf-8?B?b1hlQ0FtU25RSmRHekhkYnV0NlU1OTZoQlBPcE5tcW5zNXppaE52WDdlWHdv?=
 =?utf-8?B?WmQ5blRzYlNjaTFVenJQNkxBLzMxaVFvRHNxTlNlcEorVzdnZnlnT041SFFJ?=
 =?utf-8?B?NFVwN3UvVzZjY3NNQWhnYVBFUm5rNnRtbmlOeEIwb05heDNVOEl5SjRKa1Ax?=
 =?utf-8?B?TjJrcVRXaStlK0NQaEwxeE1GNFlXckYwK3BUOXJVZVRjQXJxT01LZTdDYnhC?=
 =?utf-8?B?NTN2TndqMlhWSFJUeVdlQmo1d0hyemJHYlBaM1pYOEZqelB4TElqVzlZTXNh?=
 =?utf-8?B?ekU4bDYvY25OS01GZlJzYVpKWkM3NnNwZGFkdDA5N3NKQUZsYUp6M2h0NWFY?=
 =?utf-8?B?VFExRGhXTkdwaGY3YUpKbko0aDY4MGtERyttUWhRPT0=?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c36a835-adba-4457-0cf2-08dac9c05b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 23:55:22.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twqAmdbXcXcJa/9V4JWDl+Wfq+KkvYe9qHTYAsWT5DQIvCGk9i665FFpEpmGgMBYhIRfBzBIZnWst8VlMkfHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
X-Proofpoint-ORIG-GUID: Nv8EEdXg02o4Cvoq1N7tKTeA4_Oj5FOh
X-Proofpoint-GUID: Nv8EEdXg02o4Cvoq1N7tKTeA4_Oj5FOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMTgsIDIwMjIsIEZlcnJ5IFRvdGggd3JvdGU6DQo+IEhpLA0KPiANCj4gT3Ag
MTEtMTEtMjAyMiBvbSAwMjozMSBzY2hyZWVmIFRoaW5oIE5ndXllbjoNCj4gPiBPbiBUaHUsIE5v
diAxMCwgMjAyMiwgRmVycnkgVG90aCB3cm90ZToNCj4gPiA+IEhpDQo+ID4gPiANCj4gPiA+IE9w
IDEwLTExLTIwMjIgb20gMTM6NDUgc2NocmVlZiBGZXJyeSBUb3RoOg0KPiA+ID4gPiAoc29ycnkg
c2VudCBodG1sIHdpdGggcHJldmlvdXMgYXR0ZW1wdCkNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDEw
LTExLTIwMjIgMDE6MDYsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiBIaSBGZXJyeSwN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBXZWQsIE5vdiAwOSwgMjAyMiwgRmVycnkgVG90aCB3
cm90ZToNCj4gPiA+ID4gPiA+IFNpbmNlIGNvbW1pdCAwZjAxMDE3MQ0KPiA+ID4gPiA+ID4gRHVh
bCBSb2xlIHN1cHBvcnQgb24gSW50ZWwgTWVycmlmaWVsZCBwbGF0Zm9ybSBicm9rZSBkdWUgdG8g
cmVhcnJhbmdpbmcNCj4gPiA+ID4gPiA+IHRoZSBjYWxsIHRvIGR3YzNfZ2V0X2V4dGNvbigpLg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJdCBhcHBlYXJzIHRvIGJlIGNhdXNlZCBieSB1bHBp
X3JlYWRfaWQoKSBvbiB0aGUgZmlyc3QgdGVzdA0KPiA+ID4gPiA+ID4gd3JpdGUgZmFpbGluZw0K
PiA+ID4gPiA+ID4gd2l0aCAtRVRJTUVET1VULiBDdXJyZW50bHkgdWxwaV9yZWFkX2lkKCkgZXhw
ZWN0cyB0byBkaXNjb3Zlcg0KPiA+ID4gPiA+ID4gdGhlIHBoeSB2aWENCj4gPiA+ID4gPiA+IERU
IHdoZW4gdGhlIHRlc3Qgd3JpdGUgZmFpbHMgYW5kIHJldHVybnMgMCBpbiB0aGF0IGNhc2UgZXZl
biBpZg0KPiA+ID4gPiA+ID4gRFQgZG9lcyBub3QNCj4gPiA+ID4gPiA+IHByb3ZpZGUgdGhlIHBo
eS4gRHVlIHRvIHRoZSB0aW1lb3V0IGJlaW5nIG1hc2tlZCBkd2MzIHByb2JlIGNvbnRpbnVlcyBi
eQ0KPiA+ID4gPiA+ID4gY2FsbGluZyBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGZvbGxvd2VkIGJ5
IGR3YzNfZ2V0X2V4dGNvbigpDQo+ID4gPiA+ID4gPiB3aGljaCBoYXBwZW5zDQo+ID4gPiA+ID4g
PiB0byByZXR1cm4gLUVQUk9CRV9ERUZFUi4gT24gZGVmZXJyZWQgcHJvYmUgdWxwaV9yZWFkX2lk
KCkNCj4gPiA+ID4gPiA+IGZpbmFsbHkgc3VjY2VlZHMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB1bHBpX3JlYWRfaWQoKSB0byByZXR1cm4gLUVUSU1FRE9V
VCB3aGVuIGl0DQo+ID4gPiA+ID4gPiBvY2N1cnMgYW5kDQo+ID4gPiA+ID4gPiBjYXRjaGVzIHRo
ZSBlcnJvciBpbiBkd2MzX2NvcmVfaW5pdCgpLiBJdCBoYW5kbGVzIHRoZSBlcnJvciBieSBjYWxs
aW5nDQo+ID4gPiA+ID4gPiBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGFmdGVyIHdoaWNoIGl0IHJl
cXVlc3RzIC1FUFJPQkVfREVGRVIuIE9uDQo+ID4gPiA+ID4gPiBkZWZlcnJlZA0KPiA+ID4gPiA+
ID4gcHJvYmUgdWxwaV9yZWFkX2lkKCkgYWdhaW4gc3VjY2VlZHMuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZlcnJ5IFRvdGg8ZnRvdGhAZXhhbG9uZGVsZnQubmw+
DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICDCoCBkcml2ZXJzL3VzYi9jb21tb24vdWxw
aS5jIHwgNSArKystLQ0KPiA+ID4gPiA+ID4gIMKgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jwqDC
oCB8IDUgKysrKy0NCj4gPiA+ID4gPiA+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENhbiB5b3Ugc3Bs
aXQgdGhlIGR3YzMgY2hhbmdlIGFuZCB1bHBpIGNoYW5nZSB0byBzZXBhcmF0ZSBwYXRjaGVzPw0K
PiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+ID4gPiANCj4g
PiA+ID4gSSB3aWxsIHNlbmQgdjINCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvY29tbW9uL3VscGkuYyBiL2RyaXZlcnMvdXNiL2NvbW1vbi91bHBpLmMNCj4g
PiA+ID4gPiA+IGluZGV4IGQ3Yzg0NjE5NzZjZS4uZDhmMjJiYzJmOWQwIDEwMDY0NA0KPiA+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy91c2IvY29tbW9uL3VscGkuYw0KPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy91c2IvY29tbW9uL3VscGkuYw0KPiA+ID4gPiA+ID4gQEAgLTIwNiw4ICsyMDYsOSBA
QCBzdGF0aWMgaW50IHVscGlfcmVhZF9pZChzdHJ1Y3QgdWxwaSAqdWxwaSkNCj4gPiA+ID4gPiA+
ICDCoMKgwqDCoMKgIC8qIFRlc3QgdGhlIGludGVyZmFjZSAqLw0KPiA+ID4gPiA+ID4gIMKgwqDC
oMKgwqAgcmV0ID0gdWxwaV93cml0ZSh1bHBpLCBVTFBJX1NDUkFUQ0gsIDB4YWEpOw0KPiA+ID4g
PiA+ID4gLcKgwqDCoCBpZiAocmV0IDwgMCkNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCBn
b3RvIGVycjsNCj4gPiA+ID4gPiA+ICvCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4gPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ID4gK8KgwqDCoCB9DQo+ID4g
PiA+ID4gPiAgwqDCoMKgwqDCoCByZXQgPSB1bHBpX3JlYWQodWxwaSwgVUxQSV9TQ1JBVENIKTsN
Cj4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKQ0KPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gPiA+ID4gPiA+IGluZGV4IDY0OGYxYzU3MDAyMS4uZTI5M2VmNzAwMzliIDEwMDY0NA0KPiA+
ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gPiBAQCAtMTEwNiw4ICsxMTA2LDEx
IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4g
PiA+ICDCoMKgwqDCoMKgIGlmICghZHdjLT51bHBpX3JlYWR5KSB7DQo+ID4gPiA+ID4gPiAgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldCA9IGR3YzNfY29yZV91bHBpX2luaXQoZHdjKTsNCj4gPiA+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
IGlmIChyZXQpIHsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGR3YzNfY29y
ZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4gV2Ugc2hvdWxkbid0IG5lZWQgdG8gZG8gc29m
dCByZXNldCBoZXJlLiBUaGUgY29udHJvbGxlciBzaG91bGRuJ3QgYmUgYXQNCj4gPiA+ID4gPiBh
IGJhZC9pbmNvcnJlY3Qgc3RhdGUgYXQgdGhpcyBwb2ludCB0byB3YXJyYW50IGEgc29mdC1yZXNl
dC4gVGhlcmUgd2lsbA0KPiA+ID4gPiA+IGJlIGEgc29mdC1yZXNldCB3aGVuIGl0IGdvZXMgdGhy
b3VnaCB0aGUgaW5pdGlhbGl6YXRpb24gYWdhaW4uDQo+ID4gPiA+IA0KPiA+ID4gPiBJdCBkb2Vz
bid0IGdvIHRocm91Z2ggdGhlIGluaXRpYWxpemF0aW9uIGFnYWluIHVubGVzcyB3ZSBzZXQNCj4g
PiA+ID4gLUVQUk9CRV9ERUZFUi4gQW5kIHdoZW4gd2UgbWFrZSB1bHBpX3JlYWRfaWQoKSByZXR1
cm4gLUVQUk9CRV9ERUZFUiBpdA0KPiA+ID4gPiB3aWxsIGdvdG8gZXJyMCBoZXJlLCBzbyBza2lw
cyBkd2MzX2NvcmVfc29mdF9yZXNldC4NCj4gPiA+ID4gDQo+ID4gPiA+IERvIHlvdSBtZWFuIHlv
dSBwcmVmZXIgc29tZXRoaW5nIGxpa2U6DQo+ID4gPiA+IA0KPiA+ID4gPiBpZiAocmV0KSB7DQo+
ID4gPiA+IA0KPiA+ID4gPiAgIMKgwqDCoCBpZiAocmV0ID09IC1FVElNRURPVVQpIHJldCA9IC1F
UFJPQkVfREVGRVI7DQo+ID4gPiA+IA0KPiA+ID4gPiAgIMKgwqDCoCBlbHNlIGdvdG8gZXJyMDsN
Cj4gPiANCj4gPiBXaHkgImVsc2UiPyBCdXQgSSBzYXcgeW91IHJlbW92ZSB0aGF0IGluIHRoZSBu
ZXcgcGF0Y2guDQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiB9DQo+ID4gPiANCj4gPiA+IEkganVz
dCB0ZXN0ZWQsIGFuZCBjYWxsaW5nIGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgcHJvdmVzIHRvIGJl
IG5lY2Vzc2FyeSBhcw0KPiA+ID4gd2UgbmVlZCB0byBnb3RvIGVycjAgZGlyZWN0bHkgYWZ0ZXIu
IEVsc2UgcmV0IGlzIG92ZXJ3cml0dGVuIGFuZA0KPiA+ID4gLUVQUk9CRV9ERUZFUiBsb3N0Lg0K
PiA+IA0KPiA+IExvb2tzIGxpa2UgdGhlcmUncyBhIHN0cmFuZ2UgZGVwZW5kZW5jeSBwcm9ibGVt
IGhlcmUuDQo+ID4gICAqIFRoZSBzZXR1cCBuZWVkcyBhIHNvZnQtcmVzZXQgYmVmb3JlIHVscGkg
cmVnaXN0cmF0aW9uDQo+ID4gICAqIFRoZSB1bHBpIHJlZ2lzdHJhdGlvbiBuZWVkcyB0byBnbyBi
ZWZvcmUgdGhlIHBoeSBpbml0aWFsaXphdGlvbg0KPiA+ICAgKiBUaGUgc29mdC1yZXNldCBzaG91
bGQgYmUgY2FsbGVkIGFmdGVyIHRoZSBwaHkgaW5pdGlhbGl6YXRpb24NCj4gPiANCj4gPiBJIGNh
bid0IGV4cGxhaW4gdGhlIGFjdHVhbCBpc3N1ZSBoZXJlLCBhbmQgd2UgY2FuJ3QgZGVidWcgZnVy
dGhlcg0KPiA+IGJlY2F1c2UgdG8gbG9vayBpbnRvIGl0IGZ1cnRoZXIgd291bGQgcmVxdWlyZSBs
b29raW5nIGF0IGludGVybmFsDQo+ID4gc2lnbmFscy4NCj4gPiANCj4gPiBUaGlzIHNvZnQtcmVz
ZXQgYW5kIC1FUFJPQkVfREVGRVIgc2VlbXMgdG8gYmUgYSB3b3JrYXJvdW5kIHRvIHRoaXMNCj4g
PiBkZXBlbmRlbmN5IHByb2JsZW0uIEluc3RlYWQgb2YgdXNpbmcgLUVQUk9CRV9ERUZFUiwgY2Fu
IHlvdSBkbyB0aGlzOg0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gaW5kZXggMmYwYTk2Nzk2ODZmLi41
YTFhYWYzNzQxZWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+IEBAIC0xMDk3LDYgKzEwOTcsOCBA
QCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gICAgICAg
ICAgICAgICAgICBnb3RvIGVycjA7DQo+ID4gICAgICAgICAgaWYgKCFkd2MtPnVscGlfcmVhZHkp
IHsNCj4gPiArICAgICAgICAgICAgICAgLyogQWRkIGNvbW1lbnQgKi8NCj4gPiArICAgICAgICAg
ICAgICAgZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiAgICAgICAgICAgICAgICAgIHJl
dCA9IGR3YzNfY29yZV91bHBpX2luaXQoZHdjKTsNCj4gPiAgICAgICAgICAgICAgICAgIGlmIChy
ZXQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyMDsNCj4gPiANCj4gDQo+
IFRoaXMgaW5kZWVkIGZpeGVzIHRoZSBpc3N1ZSBhcyB3ZWxsLiBIZXJlIGlzIHRoZSB0cmFjZToN
Cg0KVGhhbmtzIGZvciB0aGUgdGVzdCENCg0KPiANCj4gIyB0cmFjZXI6IGZ1bmN0aW9uX2dyYXBo
DQo+ICMNCj4gIyBDUFUgIERVUkFUSU9OICAgICAgICAgICAgICAgICAgRlVOQ1RJT04gQ0FMTFMN
Cj4gIyB8ICAgICB8ICAgfCAgICAgICAgICAgICAgICAgICAgIHwgICB8ICAgfCAgIHwNCj4gIDAp
ICAgICAgICAgICAgICAgfCAgLyogc3RhcnRfZXZlbnQ6IChkd2MzX3Byb2JlKzB4MC8weDE5MTAp
ICovDQo+ICAwKSAgIDcuMDcwIHVzICAgIHwgIGR3YzNfY2xrX2VuYWJsZS5wYXJ0LjAoKTsNCj4g
IDApICAgNS40ODAgdXMgICAgfCAgZXh0Y29uX2dldF9leHRjb25fZGV2KCk7DQo+ICAwKSArIDEw
LjIzMCB1cyAgIHwgIGR3YzNfcnVudGltZV9pZGxlKCk7DQo+ICAwKSAgICAgICAgICAgICAgIHwg
IC8qIGVuZF9ldmVudDogKHBsYXRmb3JtX3Byb2JlKzB4M2YvMHhhMCA8LSBkd2MzX3Byb2JlKQ0K
PiAqLw0KPiANCj4gKiogbXVsdGlwbGUgZGVmZXJzIHdoaWxlIHdhaXRpbmcgZm9yIGV4dGNvbg0K
PiANCj4gIDApICAgICAgICAgICAgICAgfCAgLyogc3RhcnRfZXZlbnQ6IChkd2MzX3Byb2JlKzB4
MC8weDE5MTApICovDQo+ICAwKSAgIDcuMzIwIHVzICAgIHwgIGR3YzNfY2xrX2VuYWJsZS5wYXJ0
LjAoKTsNCj4gIDApICAgNi44MzAgdXMgICAgfCAgZXh0Y29uX2dldF9leHRjb25fZGV2KCk7DQo+
ICAwKSAgICAgICAgICAgICAgIHwgIGR3YzNfY29yZV9pbml0KCkgew0KPiAgMCkgKyAyOS4yMDAg
dXMgICB8ICAgIGR3YzNfY29yZV9zb2Z0X3Jlc2V0LnBhcnQuMCgpOw0KPiAgMCkgICAgICAgICAg
ICAgICB8ICAgIGR3YzNfdWxwaV9pbml0KCkgew0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAg
dWxwaV9yZWdpc3Rlcl9pbnRlcmZhY2UoKSB7DQo+ICAwKSAgICAgICAgICAgICAgIHwgICAgICAg
IGR3YzNfdWxwaV93cml0ZSgpIHsNCj4gIDApICAgMy4zODAgdXMgICAgfCAgICAgICAgICBkd2Mz
X3VscGlfYnVzeWxvb3AoKTsNCj4gDQo+ICAqKiB3aXRob3V0IHRoaXMgcGF0Y2ggdGhpcyBvbmUg
dGltZXMgb3V0IGFmdGVyIDEwMDAwdXMNCj4gDQo+ICAwKSAgIDcuNzEwIHVzICAgIHwgICAgICAg
IH0NCj4gIDApICAgICAgICAgICAgICAgfCAgICAgICAgZHdjM191bHBpX3JlYWQoKSB7DQo+ICAw
KSAgIDMuMDYwIHVzICAgIHwgICAgICAgICAgZHdjM191bHBpX2J1c3lsb29wKCk7DQo+ICAwKSAg
IDcuMjEwIHVzICAgIHwgICAgICAgIH0NCj4gIDApICAgICAgICAgICAgICAgfCAgICAgICAgZHdj
M191bHBpX3JlYWQoKSB7DQo+ICAwKSAgIDIuODMwIHVzICAgIHwgICAgICAgICAgZHdjM191bHBp
X2J1c3lsb29wKCk7DQo+ICAwKSAgIDYuNjkwIHVzICAgIHwgICAgICAgIH0NCj4gIDApICAgICAg
ICAgICAgICAgfCAgICAgICAgZHdjM191bHBpX3JlYWQoKSB7DQo+ICAwKSAgIDIuODgwIHVzICAg
IHwgICAgICAgICAgZHdjM191bHBpX2J1c3lsb29wKCk7DQo+ICAwKSAgIDYuNjcwIHVzICAgIHwg
ICAgICAgIH0NCj4gIDApICAgICAgICAgICAgICAgfCAgICAgICAgZHdjM191bHBpX3JlYWQoKSB7
DQo+ICAwKSAgIDIuOTQwIHVzICAgIHwgICAgICAgICAgZHdjM191bHBpX2J1c3lsb29wKCk7DQo+
ICAwKSAgIDYuNjkwIHVzICAgIHwgICAgICAgIH0NCj4gIDApICAgICAgICAgICAgICAgfCAgICAg
ICAgZHdjM191bHBpX3JlYWQoKSB7DQo+ICAwKSAgIDIuODcwIHVzICAgIHwgICAgICAgICAgZHdj
M191bHBpX2J1c3lsb29wKCk7DQo+ICAwKSAgIDYuNjIwIHVzICAgIHwgICAgICAgIH0NCj4gIDAp
ICsgMTguMTUwIHVzICAgfCAgICAgICAgdWxwaV91ZXZlbnQoKTsNCj4gIDApICAgNS45OTAgdXMg
ICAgfCAgICAgICAgdWxwaV9tYXRjaCgpOw0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAgICB1
bHBpX3Byb2JlKCkgew0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAgICAgIHR1c2IxMjEwX3By
b2JlKCkgew0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAgICAgICAgdWxwaV9yZWFkKCkgew0K
PiAgMCkgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICBkd2MzX3VscGlfcmVhZCgpIHsNCj4g
IDApICAgNC40NDAgdXMgICAgfCAgICAgICAgICAgICAgICBkd2MzX3VscGlfYnVzeWxvb3AoKTsN
Cj4gIDApICAgOS42MDAgdXMgICAgfCAgICAgICAgICAgICAgfQ0KPiAgMCkgKyAxNS43NzAgdXMg
ICB8ICAgICAgICAgICAgfQ0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAgICAgICAgdWxwaV93
cml0ZSgpIHsNCj4gIDApICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgZHdjM191bHBpX3dy
aXRlKCkgew0KPiAgMCkgICAzLjI3MCB1cyAgICB8ICAgICAgICAgICAgICAgIGR3YzNfdWxwaV9i
dXN5bG9vcCgpOw0KPiAgMCkgICA2LjgyMCB1cyAgICB8ICAgICAgICAgICAgICB9DQo+ICAwKSAr
IDExLjAyMCB1cyAgIHwgICAgICAgICAgICB9DQo+ICAwKSAhIDQwNy41NDAgdXMgIHwgICAgICAg
ICAgfQ0KPiAgMCkgISA0MTYuOTgwIHVzICB8ICAgICAgICB9DQo+ICAwKSAgIDkuODAwIHVzICAg
IHwgICAgICAgIHVscGlfdWV2ZW50KCk7DQo+ICAwKSAqIDE4NjA0LjAwIHVzIHwgICAgICB9DQo+
ICAwKSAqIDE4NjExLjIwIHVzIHwgICAgfQ0KPiAgMCkgKyAzMC41NzAgdXMgICB8ICAgIGR3YzNf
Y29yZV9zb2Z0X3Jlc2V0LnBhcnQuMCgpOw0KPiAgMCkgICAgICAgICAgICAgICB8ICAgIHR1c2Ix
MjEwX3Bvd2VyX29uKCkgew0KPiAgMSkgICAgICAgICAgICAgICB8ICBleHRjb25fc2V0X3N0YXRl
X3N5bmMoKSB7DQo+ICAxKSAgIDUuMzMwIHVzICAgIHwgICAgZXh0Y29uX3NldF9zdGF0ZS5wYXJ0
LjAoKTsNCj4gIDEpICsgOTAuNTUwIHVzICAgfCAgICBleHRjb25fc3luYy5wYXJ0LjAoKTsNCj4g
IDEpICEgMTEzLjY3MCB1cyAgfCAgfQ0KPiAgMSkgKyAxOS40NTAgdXMgICB8ICB1bHBpX3VldmVu
dCgpOw0KPiAgMCkgKyAxMy42NDAgdXMgICB8ICB1bHBpX3VldmVudCgpOw0KPiAgMSkgKyAxMy45
ODAgdXMgICB8ICB1bHBpX3VldmVudCgpOw0KPiAgMCkgKyAxNS45NjAgdXMgICB8ICB1bHBpX3Vl
dmVudCgpOw0KPiAgMCkgICAgICAgICAgICAgICB8ICAgICAgdWxwaV93cml0ZSgpIHsNCj4gIDAp
ICAgICAgICAgICAgICAgfCAgICAgICAgZHdjM191bHBpX3dyaXRlKCkgew0KPiAgMCkgKiAxMDIz
OS40NyB1cyB8ICAgICAgICAgIGR3YzNfdWxwaV9idXN5bG9vcCgpOw0KPiAgMCkgKiAxMDI1MC41
NyB1cyB8ICAgICAgICB9DQo+ICAwKSAqIDEwMjY1LjA5IHVzIHwgICAgICB9DQo+ICAwKSAqIDY5
NTE4Ljk1IHVzIHwgICAgfQ0KPiAgMCkgICA1Ljc0MCB1cyAgICB8ICAgIGR3YzNfZXZlbnRfYnVm
ZmVyc19zZXR1cCgpOw0KPiAgMCkgKiA4ODI0MS4wMiB1cyB8ICB9IC8qIGR3YzNfY29yZV9pbml0
ICovDQo+ICAwKSAhIDEwNC45MDAgdXMgIHwgIGR3YzNfZGVidWdmc19pbml0KCk7DQo+ICAwKSAg
ICAgICAgICAgICAgIHwgIGR3YzNfZHJkX2luaXQoKSB7DQo+ICAwKSAgIDQuNzIwIHVzICAgIHwg
ICAgZXh0Y29uX3JlZ2lzdGVyX25vdGlmaWVyKCk7DQo+ICAwKSAgICAgICAgICAgICAgIHwgICAg
ZXh0Y29uX2dldF9zdGF0ZSgpIHsNCj4gIDApICAgMi42NDAgdXMgICAgfCAgICAgIGV4dGNvbl9n
ZXRfc3RhdGUucGFydC4wKCk7DQo+ICAwKSAgIDYuNDYwIHVzICAgIHwgICAgfQ0KPiAgMCkgKyAx
NC40NjAgdXMgICB8ICAgIGR3YzNfc2V0X21vZGUoKTsNCj4gIDApICsgNDMuMzAwIHVzICAgfCAg
fQ0KPiAgMCkgICAgICAgICAgICAgICB8ICAvKiBlbmRfZXZlbnQ6IChwbGF0Zm9ybV9wcm9iZSsw
eDNmLzB4YTAgPC0gZHdjM19wcm9iZSkNCj4gKi8NCj4gDQo+IE1heWJlIHRoaXMgaXMgdGhlIHBy
ZWZlcnJlZCB3YXkgdG8gZ28gaWYgdGhlIGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgZG9lc24ndA0K
PiBodXJ0IG90aGVyIHVzZXJzPw0KPiANCg0KVGhlIGNoZWNrIHlvdSBhZGRlZCBzZWVtcyB0byBm
aXQgYmV0dGVyIGZvciB0aGlzIGJlaGF2aW9yLCB3aGljaCBJJ2QNCmNvbnNpZGVyIGEgcXVpcmsu
IFdlIGNhbiByZXZpc2l0IHRoaXMgY2hhbmdlIGlmIHRoZSB1bHBpIHVwZGF0ZSBkb2Vzbid0DQpn
byB0aHJvdWdoLg0KDQpUaGFua3MsDQpUaGluaA==
