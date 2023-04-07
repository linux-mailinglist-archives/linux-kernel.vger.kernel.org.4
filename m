Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD736DA72C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbjDGCAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbjDGCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:00:13 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D286A8;
        Thu,  6 Apr 2023 19:00:00 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336IZRWR017318;
        Thu, 6 Apr 2023 18:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ougHM6jlGgqTnGxKX3033iNhBMg9qWaBE5pexkRhVKc=;
 b=eaOmjbsj03C+UJLLiwRbuKjKyiZyK/tMLi4Dqlgpd9OxKH5L3mUvfOGLg7rXjDx+sLKw
 O+IOGwyveVrYOshok026qETvVaG/oN1IOfEsU2dsBTY9ah7vdFDWVT4Ty+U+7ZEikLVw
 FrsgTrlBftfYeKefvvQUaEpQrMGFJHFOp2tDkN3qIDhcKvGYncluoqqAPu7SiDA0ih5L
 ijZnUnkhDGlCRqkFFI6/mGUmMAk/sI/SiuDcypFy0OHlk0RWeuR0KroA0wvfu+86G3XX
 ViNa5wZEh1S+aHPxfX+GRpe0axheScEdbzqulsBWeLTS/XsJKpFTpaoDryvzKsCTjTmJ 9g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ppk8jsum3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 18:59:55 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F522C05B0;
        Fri,  7 Apr 2023 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680832794; bh=ougHM6jlGgqTnGxKX3033iNhBMg9qWaBE5pexkRhVKc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j0DAXUI2lqT+IUvdm8meNpOvc5KB05+JRqL0I0sE29J7SwvyGcBr8YFPUMC5o5ffo
         Y+svq7rduxc4OmQ+6kixGg3WRpBWtJtwUfeCvHhB8LxXsRAEHu+ARES3FykrqBp5zT
         dqYfnG8ErjT7CaDyTeNIZZCxaUxkJkT5irqxHEio3KScu3MUHMXWrtdMpb5sgBx9TM
         oNAITbQQrQKKK0Re24qpWJy++U+TkkMr2soWNpZBaToqnYqTduxNyegmmqxBOeENAb
         o+aJmIsCvNn8zgYF+SBOBjZfur/2IYYKkXgxedYJH3n1mBEeIMXZ6x9KcMarYA3IH7
         +VIPOKVjajRSw==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3E59DA007A;
        Fri,  7 Apr 2023 01:59:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CBC00800BD;
        Fri,  7 Apr 2023 01:59:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="W7sEwjHp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdAODNhb6YwsCGV6pvTThZyxtoV1rAq7BFF5++vcGJVKXAu4DVCDIdFHdkW+jlv+OlhcyWWmLBKdglTj3OhpyaTg4Sey+fXZpk7uiM51U9RG9cJU1GPcTo1xM+h1lzYdVwh/cs+mpe3quoLCv7QK7CFpfB2MzE0DR1qgonODo8TTqBv5ENWfMfjuy8Qqz2Co+4WpmAoyS2QHYpGbeyuDuF0eHWLiUvkU63GyItgAO6rpgWUNbD9laWgDB01EzpnCHU2tdFmM3AoWiANUojePzv0mHIlFTupXWMk1Sf6VNd1k/4U4Y+9di1lTVjmBrzea7fIYuzyROR4BzbuPf9XgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ougHM6jlGgqTnGxKX3033iNhBMg9qWaBE5pexkRhVKc=;
 b=GDhTn2/QXXw7No1qc7Y3ZyTkFklZlZOXh/tbFUmip/Q8zhRE5XKEd7UGtI6UlSfPKqm/jMB+eZ5ImaMu3dehypS3rwaI+3Ly/U1U83ZWH8kDLezSlqfsRIvgKWMk69dggG6z/Yz3j7haj7V7rLJgVrgkaM4lxHaLXOR+Qq+4/MurugGHsNpPFO12YacJdtvyHTrbcY/oznwX25WUpYm/sn5E/z57B4ycuq4z31dQjNH3/EkzJskqmyejSEINVaqFWS+Hem6cxYn0IC0Nq3BN1SOt9ua/IXYB4Q04KbTEAz/ljBH57iEM7wT9a/Lnz2JMO93qwJbZw02dlf5RkmXBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ougHM6jlGgqTnGxKX3033iNhBMg9qWaBE5pexkRhVKc=;
 b=W7sEwjHp4AXjV+BZajbN1EBiQTcFk8f7N8RE1QhWS8WT//qgaFLvQ+5mLIpSitS8Dd38EB4y4bNpx9quQ3AWwlKVahhATo0oNgTgJLM7nKU/56lfsMiDH1Tlqp5VPXwvEZYWBpE6mOHX1DQbWtY/pG8uddeknoysKFLICn3MczI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 01:59:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 01:59:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/11] USB: dwc3: gadget: drop dead hibernation code
Thread-Topic: [PATCH 04/11] USB: dwc3: gadget: drop dead hibernation code
Thread-Index: AQHZZsa5vK8woOWUkUi1pE5U+kTrp68fG6SA
Date:   Fri, 7 Apr 2023 01:59:47 +0000
Message-ID: <20230407015933.yj6nxhwxlg6hfkfa@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-5-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-5-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: fb0be52a-3fd3-4305-00aa-08db370bc447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WM7687Lv8YISTF+dW5G1aCUisZsYJQTxlrfU0d4XuJpmG/+KQdbrdgQIXirD4/Ox6baoP9W5R35Z2X7/4NPgJGIo3EGGV2ePz81/FfbYxkX9ADo+IVRaEoB6kut17d/Jjfo8mM3x8Ee/PzDuWWYqPepBV5daQ+O1qVj2BUGIKUTz3R40t6bouZJqKsnZvxmkqh5akylKILWqav5F2mGlMNmmg+Pek2YDxw94z3jZY1gjhEA0yuCie9VyFKd3f1ha3PXir8pyzgn1v/Tiv/K5VecM+GabSbYUBSPt0g4yj7pH8LJjL/GyJUFZzafHVohbYnFjzF3ySGcGcl2I+jdamwTcC1wEF9KXzx9LTtkQE9cLNJft8446tHfva8b4QDLG56+W6gAPFD8/aOqvicqbOVK/7bsbJojGUOa/waM8qRpkJ7yd1biRYdhT/CACR2pxcoOv23eH0LREkBOD3nAAY0csrHrO2NQzfJxsBShhS+azMnRnpJANh9EcSnidb9NgKZdbbLYLnMEhzBEkwF2Y2IGmsHb+deJL4ZXHAOkP0A3an0glglUTp69RY79jQ/L+W6XsDaryrPOL/mZi42SFTmW284qVIu1fqtVvW1FIt6BYU454u+7tfYSF+m+ugh6C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(122000001)(38100700002)(86362001)(36756003)(38070700005)(71200400001)(8936002)(6486002)(478600001)(316002)(5660300002)(6506007)(2906002)(6512007)(1076003)(2616005)(26005)(186003)(4326008)(66446008)(64756008)(76116006)(66946007)(66476007)(66556008)(8676002)(54906003)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enl2UzdCTzVRQlducnhDVVhXNXRiZ3o1RTRqTXlFM1JpSjltclUxb0tsTXZ5?=
 =?utf-8?B?YWNKSWlhK2NzVktUU2h3eXFQK2xjeHNIZ3Ntd2ZWU2NDeHRTOVZGWXRST09F?=
 =?utf-8?B?R21BZm16K1kxbHJReGhIaWhhWTB1czdJK1FhS29jMlhjbXFuYjlmRFhBMXFF?=
 =?utf-8?B?ditxdVhRd2xER1B2aDAyUkFUaG90UUNxL2tvdEltMElkcElRSEQzakR4Smx5?=
 =?utf-8?B?b1FKY2xIUWpOaTlraUtzRVQ5cForVktnODlTN0l3M3hrU3Y2WVB4SXEybjZr?=
 =?utf-8?B?T1pPblpRRUZCbFROZkE5L014UE1MNzFVdGFWekFHOXViRUg4Tkh5SEM3b1Bn?=
 =?utf-8?B?TXpNOEtFdzlObU5XdHhaZVNRdGc2THA3TmthMFdhczFaS0NLNSsxY2tMZE5W?=
 =?utf-8?B?aW5za0dvSXNERS9jZnAxM2t6a3IzNExMUTZ5aUZsZ2FEMVVaWVhjQ1AxblE3?=
 =?utf-8?B?ZFh2bkRYRFZMMWtxKyt5VHhYNTRCbTZVWHAweFlzRmo4VDBEQldZb2hBL2VM?=
 =?utf-8?B?dXVObGg1c3JrSWt1TE5xaWcwcGFlWDRwdkQrSWc4TC9MMlRLRnVuN29QWnpz?=
 =?utf-8?B?MkVNbzk1cW9LaHlQYkVNbVJ1UmJidTlFOGNFcE5WM2dLQ2M3TExJRTcvcmRm?=
 =?utf-8?B?OEdHMGVld2VrUkxZQnFhNldIdWlzSG0ySXdiejl4SFBoWFA1Uy9DM2dmeVNZ?=
 =?utf-8?B?cjArM2thQWRILzIvUVRvMDNIaFdkMmFQdG4wT3J3dmlBc2hYZmJoVlNtMUpx?=
 =?utf-8?B?ZUVwWkxPOGlyNHlrQXh2Rm85Rzg5UUtiam1wMSsyeGdVczRndjRKRlByZFo2?=
 =?utf-8?B?YUVZZXlpR3IrRG9sM2d4VENCeDF6Z1hJREZackg4N3BLMGJvOUlBOUZiK2Uw?=
 =?utf-8?B?MlkwUXY2TkxSTlg5bU9QZXE5cUFyV1JXcXZubXo3YWZwRG5Ma0RjK1J3YkdE?=
 =?utf-8?B?eGNraEYveTZTTlA3WnJFSjJka3RuSTdFL1ExNW95bHdBeWtGVGZXSlhYYmxo?=
 =?utf-8?B?UGpIUm9MSVozbThGNnFkY2wyU1pqNDFaajkvVW5HbHNqWklKVFY3c3YxTTR1?=
 =?utf-8?B?ZlZZdkw2QlViZE5sMDdIWUFQeEhaazVBeW5BS2ttRU5oNHB3REVzNUJuYjFG?=
 =?utf-8?B?VFo4Q0tRdFdBaHgyQ1ZqQkxDZ3FaWDM1WXZrUFBsMHVqTVJqQmpsM09KbDV0?=
 =?utf-8?B?TkxvbnRXeDBCblZLT1R2a3Jrd1FBNDVNQlFWSW5weUJZVStpNWxiSFB2QjZJ?=
 =?utf-8?B?M1k1QVBTU0RFVWR0NENVZ1FRdkpqeTlUcXIrdmZ1VGY4dlN4aDRVcTdSVG0v?=
 =?utf-8?B?YXJSd3VmUDRPd1NlTUNVYy9DczFINjNpc0R3UElMZU9LL2RHejFPZVN0MkRk?=
 =?utf-8?B?WTJpekRsY0NReUV5OGpIbEFXVmJuWEVNci9sSXdLaXNrMmNDVWU2bGxrandN?=
 =?utf-8?B?d3V6VDdXeno0N2t2NmlrQTZyM1lXUTJMdDZWb1JIUEpmazVzeTgwcHVURTN5?=
 =?utf-8?B?SUJiQmFabExha2tKNVdkVXZTOVpWU0RYL04zOHUra0FhekdhZGprMXg3RkRO?=
 =?utf-8?B?TG16UVovemdQb0pvVzc3NzFFcGIrL2Mzd002b2NwN3c5a0Q3b3FuTUwveWhm?=
 =?utf-8?B?bnp1UXg0am4wR1NwWXRIQkZWNVc3ME15cHo3MnF4L2FGRkI3Z1VIQkZXZlYy?=
 =?utf-8?B?V01OTmRQdThBRTAvSjJIRk1udTR2bEY1eEs3OGI4NEV5WTFmeWkvWU1aeHJG?=
 =?utf-8?B?OWlDVDFqT2lxck11YzQxVDB4NEFndGZ5TlhXT3A4UDdkK3c0UjFSK05IQVZz?=
 =?utf-8?B?MUh4UUtwVTFZN29yYlFVQWZaeFVadFQzWVphRVpKc29tVUxOSTBqU1p4M3Y0?=
 =?utf-8?B?cG96MkZXR3hMS2RYNWZGcVNCYVFUZ2UvdGV4S1JKYTkxR054amRWRWFNYmNk?=
 =?utf-8?B?QUpvOGo5ckw0dkhWTlZtV3NLWk42R3VwSTV1a3V4Q1NZeXRRN3VlNVJzcTJn?=
 =?utf-8?B?K1g3UUVjWDY5MFJKdi9LbGZHN2crcXVtWGI1dktTcWFJSG80L2tSZC9jSjNx?=
 =?utf-8?B?TDNZYzFHdzU3dGNoTDBnenEyWGRILzNaczRPNnpETjcvenJlendFR3RkKzBh?=
 =?utf-8?Q?pgwQNLFPo4qoWQEWWTMD6rjjj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB28C50C8377A64B88300FCE63C08D0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9cAKU3nZkF7s6PaPyFiT9Mg/pF3IFRSOjJOY+UkDY07DeXNIgpQ3HHUTJONONxQ5SBTsqlfIwB3lRjJ5HovyRBwUd0lfoAepjbAd/ByA81MpvpWZZm7qzgCSXbdsBLZ2o93w2H6HHaQZlKIVfQdkWTBccYbfKXblhQf3m2aY+g/2vbknkfJ6/G6bziFV9ea6eR5bY0IBplm/Jd9Y6RvvShDN4CRxvyCwFrEwlGInnMu4kU2ynVHsBwyxDc8pB6AeYWsG6rVRqLWAVJ2twWpWKvgEy+N9r2KBxdJ08HX3xHr9gG1mQETOSnEIbBWsxrj5Swz+Y/I7b+k1sQllHnyi3yfEgJ3V73qFQrA5vlaCgpmC4zh8VYhcbcTmi+cRM5m8HFqe08s+qaIcEzeYQlJ+IFqGsQ7TZDMBf3A2QJIGq2f4Rs9A2fkfvq9cpXdVRz7dVYzzPA3/iemyDQYqj57yxE8XZoq9Pb2XCl2rfqrlVgW1Rifk/iP1ZsOTFSUiD1VuE5OTyzGfuAvVUTc4OgDBV9MLSJiesFBBq4RKiDI411xUccxQZgaokQ2bTOgh5BTAOaAZMOgXZbwDwve/UczMcI81WnTlA0arBv0l0IIPtAWcbGptMU4NyRjWxDIpBhGQqLG4PDTRUiaYrBBC4YEvobIWIUhbYEXP/FtI4VAlxdodGeWL/N9VO1KpJ+6U6TLlVBf/q0C0YhW1EKoTFCAz237QiykPaQW/oGBygd7ptyt7CFObgc/28SKrDZaKDa1aXqFJm59TfxQrt76a2Z6EUkJNmq9bBeiLqHDZ26fdVZj4UIMtzGuAImmzOMJBgl7h2WsYnfo6e38yyHkPrATM+WB+zUObaO4ERWvMCsWv1qCy/UP1YzxqqHgvO4L7zVtf
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0be52a-3fd3-4305-00aa-08db370bc447
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 01:59:47.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2XE/vTIHfHQ7V5FlqRmX1fVQ9olWXK/Dquus7AxgwZFNNJuZwYxfvh3CVakQP2K4qBrwemi0SiRqpo2vvLlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Proofpoint-GUID: Em3cmKAkIyjc5ET9F3aciLnLZ6dxBnnk
X-Proofpoint-ORIG-GUID: Em3cmKAkIyjc5ET9F3aciLnLZ6dxBnnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 mlxlogscore=967 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304070017
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gVGhlIGhpYmVybmF0
aW9uIGNvZGUgaXMgYnJva2VuIGFuZCBoYXMgbmV2ZXIgYmVlbiBlbmFibGVkIGluIG1haW5saW5l
DQo+IGFuZCBzaG91bGQgdGh1cyBiZSBkcm9wcGVkLg0KPiANCj4gUmVtb3ZlIHRoZSBoaWJlcm5h
dGlvbiBiaXRzIGZyb20gdGhlIGdhZGdldCBjb2RlLCB3aGljaCBlZmZlY3RpdmVseQ0KPiByZXZl
cnRzIGNvbW1pdHMgZTFkYWRkM2IwZjI3ICgidXNiOiBkd2MzOiB3b3JrYXJvdW5kOiBib2d1cyBo
aWJlcm5hdGlvbg0KPiBldmVudHMiKSBhbmQgN2IyYTAzNjhiYmM5ICgidXNiOiBkd2MzOiBnYWRn
ZXQ6IHNldCBLRUVQX0NPTk5FQ1QgaW4gY2FzZQ0KPiBvZiBoaWJlcm5hdGlvbiIpIGV4Y2VwdCBm
b3IgdGhlIHNwdXJpb3VzIGludGVycnVwdCB3YXJuaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Sm9oYW4gSG92b2xkIDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIHwgNDYgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBjZjViNGY0OWMzZWQuLmVmNTEzOTlmZDg5ZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0yNDc4LDcgKzI0NzgsNyBAQCBzdGF0aWMgdm9pZCBf
X2R3YzNfZ2FkZ2V0X3NldF9zcGVlZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNfd3JpdGVs
KGR3Yy0+cmVncywgRFdDM19EQ0ZHLCByZWcpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19vbiwgaW50IHN1c3Bl
bmQpDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2Ms
IGludCBpc19vbikNCj4gIHsNCj4gIAl1MzIJCQlyZWc7DQo+ICAJdTMyCQkJdGltZW91dCA9IDIw
MDA7DQo+IEBAIC0yNDk3LDE3ICsyNDk3LDExIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcnVu
X3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3VzcGVuZCkNCj4gIAkJCXJl
ZyAmPSB+RFdDM19EQ1RMX0tFRVBfQ09OTkVDVDsNCj4gIAkJcmVnIHw9IERXQzNfRENUTF9SVU5f
U1RPUDsNCj4gIA0KPiAtCQlpZiAoZHdjLT5oYXNfaGliZXJuYXRpb24pDQo+IC0JCQlyZWcgfD0g
RFdDM19EQ1RMX0tFRVBfQ09OTkVDVDsNCj4gLQ0KPiAgCQlfX2R3YzNfZ2FkZ2V0X3NldF9zcGVl
ZChkd2MpOw0KPiAgCQlkd2MtPnB1bGx1cHNfY29ubmVjdGVkID0gdHJ1ZTsNCj4gIAl9IGVsc2Ug
ew0KPiAgCQlyZWcgJj0gfkRXQzNfRENUTF9SVU5fU1RPUDsNCj4gIA0KPiAtCQlpZiAoZHdjLT5o
YXNfaGliZXJuYXRpb24gJiYgIXN1c3BlbmQpDQo+IC0JCQlyZWcgJj0gfkRXQzNfRENUTF9LRUVQ
X0NPTk5FQ1Q7DQo+IC0NCj4gIAkJZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCA9IGZhbHNlOw0KPiAg
CX0NCj4gIA0KPiBAQCAtMjU3NCw3ICsyNTY4LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9z
b2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkgKiByZW1haW5pbmcgZXZlbnQg
Z2VuZXJhdGVkIGJ5IHRoZSBjb250cm9sbGVyIHdoaWxlIHBvbGxpbmcgZm9yDQo+ICAJICogRFNU
Uy5ERVZDVExITFQuDQo+ICAJICovDQo+IC0JcmV0dXJuIGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3
YywgZmFsc2UsIGZhbHNlKTsNCj4gKwlyZXR1cm4gZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBm
YWxzZSk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVj
dCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+IEBAIC0yNjI4LDcgKzI2MjIsNyBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlzX29u
KQ0KPiAgDQo+ICAJCWR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiAgCQlfX2R3YzNf
Z2FkZ2V0X3N0YXJ0KGR3Yyk7DQo+IC0JCXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3Yywg
dHJ1ZSwgZmFsc2UpOw0KPiArCQlyZXQgPSBkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIHRydWUp
Ow0KPiAgCX0NCj4gIA0KPiAgCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gQEAgLTQxOTUs
MzAgKzQxODksNiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9zdXNwZW5kX2ludGVycnVwdChz
dHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCWR3Yy0+bGlua19zdGF0ZSA9IG5leHQ7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2hpYmVybmF0aW9uX2ludGVycnVwdChzdHJ1Y3Qg
ZHdjMyAqZHdjLA0KPiAtCQl1bnNpZ25lZCBpbnQgZXZ0aW5mbykNCj4gLXsNCj4gLQl1bnNpZ25l
ZCBpbnQgaXNfc3MgPSBldnRpbmZvICYgQklUKDQpOw0KPiAtDQo+IC0JLyoNCj4gLQkgKiBXT1JL
QVJPVU5EOiBEV0MzIHJldmlzaW9uIDIuMjBhIHdpdGggaGliZXJuYXRpb24gc3VwcG9ydA0KPiAt
CSAqIGhhdmUgYSBrbm93biBpc3N1ZSB3aGljaCBjYW4gY2F1c2UgVVNCIENWIFRELjkuMjMgdG8g
ZmFpbA0KPiAtCSAqIHJhbmRvbWx5Lg0KPiAtCSAqDQo+IC0JICogQmVjYXVzZSBvZiB0aGlzIGlz
c3VlLCBjb3JlIGNvdWxkIGdlbmVyYXRlIGJvZ3VzIGhpYmVybmF0aW9uDQo+IC0JICogZXZlbnRz
IHdoaWNoIFNXIG5lZWRzIHRvIGlnbm9yZS4NCj4gLQkgKg0KPiAtCSAqIFJlZmVycyB0bzoNCj4g
LQkgKg0KPiAtCSAqIFNUQVIjOTAwMDU0NjU3NjogRGV2aWNlIE1vZGUgSGliZXJuYXRpb246IElz
c3VlIGluIFVTQiAyLjANCj4gLQkgKiBEZXZpY2UgRmFsbGJhY2sgZnJvbSBTdXBlclNwZWVkDQo+
IC0JICovDQo+IC0JaWYgKGlzX3NzIF4gKGR3Yy0+c3BlZWQgPT0gVVNCX1NQRUVEX1NVUEVSKSkN
Cj4gLQkJcmV0dXJuOw0KPiAtDQo+IC0JLyogZW50ZXIgaGliZXJuYXRpb24gaGVyZSAqLw0KPiAt
fQ0KPiAtDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMg
KmR3YywNCj4gIAkJY29uc3Qgc3RydWN0IGR3YzNfZXZlbnRfZGV2dCAqZXZlbnQpDQo+ICB7DQo+
IEBAIC00MjM2LDExICs0MjA2LDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfaW50ZXJydXB0
KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCWR3YzNfZ2FkZ2V0X3dha2V1cF9pbnRlcnJ1cHQoZHdj
KTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBEV0MzX0RFVklDRV9FVkVOVF9ISUJFUl9SRVE6DQo+
IC0JCWlmIChkZXZfV0FSTl9PTkNFKGR3Yy0+ZGV2LCAhZHdjLT5oYXNfaGliZXJuYXRpb24sDQo+
IC0JCQkJCSJ1bmV4cGVjdGVkIGhpYmVybmF0aW9uIGV2ZW50XG4iKSkNCj4gLQkJCWJyZWFrOw0K
PiAtDQo+IC0JCWR3YzNfZ2FkZ2V0X2hpYmVybmF0aW9uX2ludGVycnVwdChkd2MsIGV2ZW50LT5l
dmVudF9pbmZvKTsNCj4gKwkJZGV2X1dBUk5fT05DRShkd2MtPmRldiwgdHJ1ZSwgInVuZXhwZWN0
ZWQgaGliZXJuYXRpb24gZXZlbnRcbiIpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIERXQzNfREVW
SUNFX0VWRU5UX0xJTktfU1RBVFVTX0NIQU5HRToNCj4gIAkJZHdjM19nYWRnZXRfbGlua3N0c19j
aGFuZ2VfaW50ZXJydXB0KGR3YywgZXZlbnQtPmV2ZW50X2luZm8pOw0KPiBAQCAtNDU4NCw3ICs0
NTUwLDcgQEAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlp
ZiAoIWR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gLQlkd2MzX2dh
ZGdldF9ydW5fc3RvcChkd2MsIGZhbHNlLCBmYWxzZSk7DQo+ICsJZHdjM19nYWRnZXRfcnVuX3N0
b3AoZHdjLCBmYWxzZSk7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBm
bGFncyk7DQo+ICAJZHdjM19kaXNjb25uZWN0X2dhZGdldChkd2MpOw0KPiBAQCAtNDYwNSw3ICs0
NTcxLDcgQEAgaW50IGR3YzNfZ2FkZ2V0X3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWlm
IChyZXQgPCAwKQ0KPiAgCQlnb3RvIGVycjA7DQo+ICANCj4gLQlyZXQgPSBkd2MzX2dhZGdldF9y
dW5fc3RvcChkd2MsIHRydWUsIGZhbHNlKTsNCj4gKwlyZXQgPSBkd2MzX2dhZGdldF9ydW5fc3Rv
cChkd2MsIHRydWUpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAgCQlnb3RvIGVycjE7DQo+ICANCj4g
LS0gDQo+IDIuMzkuMg0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhpbmg=
