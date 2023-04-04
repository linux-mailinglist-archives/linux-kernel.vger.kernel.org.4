Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19876D6F51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjDDVxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjDDVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:53:43 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB343A8C;
        Tue,  4 Apr 2023 14:53:40 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334LZSti024785;
        Tue, 4 Apr 2023 14:53:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tf9W3qhdsBbvGjZY9/cAYUCR6NdGX1cjtcSr8ozUyC8=;
 b=d1sKlUpOuT62BFgOWx/5KI6R1cOFeGA9TkTztJnwtko/xlVmzRqzTHsNFon0H/fwwx0f
 06wlBcFQNNWOeUYElj2D0Ve/uy71NdMEthHUmHVwv1OXgbPn/LUbPMB50WI51DTK/LuC
 YYyJeJyEVAXscxuqXyvyHvBNaSH4J5Qwto6TLFcO30C8fqBJH6fMWPmURFrQCDM28jIf
 gTNt1ilGyT/gEaHH9gcUM9HN1/UO0mPZdMLT6biew3Fcqb4z8QfoNv6DJSk+GAK145qZ
 2kQpzPyIGkSPqDdCoxXTMx/9cGvLS+D4nyVB2YAjywNjioqQQu6SF8vSbE/aA4F3eogb bQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ppk8jactm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 14:53:29 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4F378400D9;
        Tue,  4 Apr 2023 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680645208; bh=tf9W3qhdsBbvGjZY9/cAYUCR6NdGX1cjtcSr8ozUyC8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jgyEfKzj94h3dXSlBfwn0qy5pMc2+52D7+LcXFPgo9rLaxzXcaWgxTRhBUI15bg4k
         ikkPn+HYO9fTIpi/sR3KDfxwZHx2RK/iMLgYqeVqUEjVRmbr4tW2H9acPOlOeRu0jt
         5i6xGHWCNzaeVn+WuypKlhGw3qWdwXXmviJkx6lwD/QKIFYLoc4urnGgkL2HrJqgRr
         kPPDFaqu0OwH4832CjPpF9OvOyU8zMG0KgmGrIEBAKq4ySZd8iVxMOHwLdNzQWYryo
         vdJzJciwskQqtr4eENI+f/vecVGVCLQBfjbt7gADEe+ydyHhfHe6OjfcV18tedIjIN
         Wm5qALbMxzifw==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BC2C0A005C;
        Tue,  4 Apr 2023 21:53:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 939AB800DF;
        Tue,  4 Apr 2023 21:53:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="i7SAjj21";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2tMSGaolhMEHSPen6r/qR1d/bcPhr5PBP1s+BXRDGL0IPZHIfetDI9IgUbL+O5ZkdTVwelykf8B0WpPI/5NuJWd+eE9uorTDkp3rQ5kNjhewvxI3VvnW/JkHKwlXV75I2Wdu/3TmHKhXYOnAfMDYLjTmcK0XftvhaAfIXYmIFpbKZCkHYmt6dkwr1ApoNABHhbjN10rWPpdx2Kv+RaepCatquVugjbrDZiz8RJr0JQ9nMXe3Ka4aX0PZAY8U15CUUZcEtOOMCYybtNne8IFwFPIWQzo+rrKW3qLQk4ePBj04Rc/vtqPBc35CeTjAvKqArVcergLf0mSDW94QsJ5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf9W3qhdsBbvGjZY9/cAYUCR6NdGX1cjtcSr8ozUyC8=;
 b=j9ZRhS9jT3sNn+OorHl3E3MC4J1PQjy6JYTVW6KidSVlsktVtZmS+JprOOS3vhFo8U+Uhu02toTd+yogcnQSKYNTlxLGdZfp5CqjccEe0GuM7YzhMDZJJIhNwPgezR66nra8e05Y/qhh8HVE3Z5kIE58ioGAD25FDxFjat3VhfKAvEKGMYXSVzEJ0U5Zj4idPO8CDS7hWu37F3pWk35H+tedtvsslHuHegRUiejd7eKrEo2g+mSZq5tEhLKJw/r5MH1U9idEjDLq/zQ1V66tcvkjzjs2RpES/ncg55DMt3mZ8Zgj0L48NVikYYrTQ8W8oYmwvBvGxysA8SUjzqophA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf9W3qhdsBbvGjZY9/cAYUCR6NdGX1cjtcSr8ozUyC8=;
 b=i7SAjj21FyaBMS1U2XZ0iD6aQ1dSYy/DTozZgtF6SQI3Cb0rCkENVYrOYqJLL48AfwjUCgFm+eyLZBA5WefKmSaEI5aT4aAxGRr60T+eAmIuxOvnb0jFJdG2A5+hiMWd6HRomr/wvcDG2fTYDdLBq9p85kg7ZagTSNw5RJSV1Uc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 21:53:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 21:53:20 +0000
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
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueAgAB4pQCAAL6cgIAL7uaAgAWI6QCAAI0fAIAA6EWA
Date:   Tue, 4 Apr 2023 21:53:20 +0000
Message-ID: <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
References: <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
 <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
 <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
 <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
In-Reply-To: <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB8082:EE_
x-ms-office365-filtering-correlation-id: 05d3784f-cc42-4ca3-5362-08db3557017b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZpZr82xXVeO1CeWzwMgbJuxDG+XqnpolLIagSMsSJVipGT5Op+f5siuoNrdw9uWkZ4+0kcQ9NGNIqyGEpg2PvkfIqdQHobwNosgfRJ/aZ9oYUErK1iRR1vuQcZJMzW1gVxwXr0NFFtrPH7IYTsLvuXCGunjt6vsMGRWv9qhGcVY6s6TiBK5ctza5XeiCfxbnSFz2Fx3Mzi3VHLwrMvGqnqER5R8zcNx3LyBjev/ePIHtm8i3K9fsKTIbksPkSTVbyuz9TBSAlAuj3IUAmeRavruAHZga/KYSvcQB6RO3F1OVT5md4yOcTbYmumgWcnrsgtLkfgKj6MnDic2Xf7sITSw8FBkuKxGpx3hLEmW84Eu9hZqRPpfzxAyGYwQekGmhsMy8DSvNon97RquDmvv01nlCIPx1mEf+r1zSPAYXBgt86ylKmdInfej6b2lGEzlLNtGx4HiCHC9YeSGIRw3nFTN33R6V76ntgsGjBcPCHWx9cuX0P6PoXCPPIA1YjvYOzmpBKLQhCHV69RrUtfC7e9hAHgnJFfn5CYvXV+KBZoOhD3Nsh14i/n1QD33MB1YuA0ndJDLXSsRvFHgN2YxOM6AK8rMg+nDASb3PAwkn9o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(76116006)(66476007)(66556008)(2906002)(41300700001)(66446008)(64756008)(8676002)(4326008)(6916009)(66946007)(8936002)(30864003)(5660300002)(478600001)(54906003)(6506007)(6512007)(966005)(26005)(1076003)(53546011)(2616005)(186003)(83380400001)(316002)(6486002)(38070700005)(122000001)(86362001)(38100700002)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZhcDJzR2VUbWJiK28yZW5UYlJWenExNjdVbTNMVWVqVDk1QzJoOXlHaTly?=
 =?utf-8?B?OENXczU1dG02aW81QitiU0gvbFIxUElIYmpXZ3g3QXh5RW4rUkN3YytGNXli?=
 =?utf-8?B?cmYraEdUc3dWc0dwTWJUTEY4ZlA2VEUwSk9tU0I2N2VJUjh1NldIQ1c3dVc1?=
 =?utf-8?B?VVF3Z1hKOTlremdyUy9uY1JZSmRCQTJzZ293cEVFM1lYT2U2WW9MSWFqUEM1?=
 =?utf-8?B?LzNvNy9WQyt6OUVDaWFXcjNhTVFEVGNJVjJ1NlBPcnMvQXlyL0oybGFoNFFR?=
 =?utf-8?B?cFpTSGJQUmtwWjc2NzRPNXA4aW42ci9vR01MRjJ6azF1T253UjJzSGRhb2No?=
 =?utf-8?B?TWFoaGlYa0x5V0J3MXFzNkErQ1gvR3BMS1VseENtMVhXMER2ZFNhblMxT2tX?=
 =?utf-8?B?Tmc1L2hmYlNnQ2p5U3dqUlBTS011d2RsUytwQ1JYaDNDbWkvQ2MyM211aUdZ?=
 =?utf-8?B?T25yNjRobndXRzU0SGZCV3ZJV1BVcmFUMUdHNG1rZVhaL3puVENvdGpIUlJx?=
 =?utf-8?B?M1RuZ1lNNWhPMWpxWmRIdVBRWHlELy93SzFlSmpEbk1xRHZuaUVqNTVYWTFO?=
 =?utf-8?B?Mzc1bUxJbXo5eDJ3ZEVHTEJ5cy9TUWxQUDRid2hNdEFKV093MlVhVEpxOEZI?=
 =?utf-8?B?OWdVbkptT2h3OHk0cW9reHNmd2N0U21hNmFFTlpHNC9raWl1VExKMDQ4R3Z6?=
 =?utf-8?B?U1FLOXFOVkR1Z0Q0ejh2SU5jRGdwcUFVNHk2NWR2UkExaVBMY2VONWg4WG42?=
 =?utf-8?B?OG8xK3FDZGV1OS9QT1RSaWt3cmpoUXJvcVE2U21WcnFGN1k2WVBkYzhCczEr?=
 =?utf-8?B?VERwSmRjYkJvdkVsakN5QUIza0w1V0dHOFpaMGpiZDl3R3p2NjJHOFBudkJH?=
 =?utf-8?B?SHRUYlNFaXFuMUtvYjdLREZhS3BoVGZqV1ZHVStiTTlpUkd1aC9NVEhPWnBH?=
 =?utf-8?B?UzhOaE4yOVF5OGNhS0RiMnZwT2ZoLzlTUkFvZzlzcU4wMUlLUVRwUWhQdVdK?=
 =?utf-8?B?UnU0MnM1WXNGWTExQXFocUR1M1NBaFhSbFhDVTNlbXZ5UStpMHQrWFk5aUMr?=
 =?utf-8?B?aWdSVUsyaUN4NnRuNFZwc3Q2eGRrSnMyVGdRenB3UUJicm5PMHowMmhMcDFU?=
 =?utf-8?B?S0NNaW9hRk5mUXN1OTNqbm11bW9TNnRtS05Ob3gxTmg5YUFPL01LbDZJcUpw?=
 =?utf-8?B?VFJBeU9MVmI5MHhwVTkwM1ArazI0Sm9FKzd0dFJMWU5XUGt2NkJBRHdCRlg5?=
 =?utf-8?B?MkxHQkVkVnVHSXAySERYNllMK0o0VFlWbURaU0ZxeDVSa2pLcGVHQjRuMmlX?=
 =?utf-8?B?azllVUhReWJQZVVoK3NQYXlCbzVaUFhoU0ZlZFVrZmt2THlwMzRpS2I1N3Qy?=
 =?utf-8?B?RUhTVzcwN0JXMDZHN2poOGFWbEdJWjU4V0h5aElTTEpIRXIrSlFSZlNvR05F?=
 =?utf-8?B?UDRSK3IrQ1cwY01Wd1hTOWhVZFlWQ0FBZC93UkZUczU2MHdNWHlmdWUvaElU?=
 =?utf-8?B?aWhNUU9EUU9RS2xWOWhOeU5VazdHY1YvbUpiMUoycGlLeFhqTHI2eHpCVUZW?=
 =?utf-8?B?b2t3eGFURnlHS0hxZlNKckxNWVUzUW42c0ZFT1M2Z0FRVUltQzVzd3ZDNjgz?=
 =?utf-8?B?cm53VGZUUzRPbWQ4QlJCcGtrV1pxZEhIL3hwd1d3aEVXRE5pUk1HVE9kTGcw?=
 =?utf-8?B?Q0FNcVRHTWg4N1BsL0VpZE5RNDNHV01FQ1Fqd0gwaWpPODV2TnJmODRkU0xw?=
 =?utf-8?B?ckV4Yy9sWS9NTGlIb1Z1NUxjOWthMXlNd2VnTHJ1NXpIU3JmdUQwYWJmcHo3?=
 =?utf-8?B?VGpvYld0b04vTy9OWFhhdkxnSzFOQ3gvM3M2d1k1UDVjZzc3TnV3MVR4cjRt?=
 =?utf-8?B?QmtzV2NSYUM0RzliRUlBcnVVZGEveUpZZm1MNUJNOE1BajBIZm1MZXM0YjJC?=
 =?utf-8?B?L3BqNEliNTJPa2VuMVZpM0dSd2RIU3liN0lmVmJJSkpzQzgvejZlNkVvYkJN?=
 =?utf-8?B?Q0laSzN4RGdYVU9JT0o5MDdkd20zYU4vcWUzTEtQcnNTSlZoV3IrYVZxbXph?=
 =?utf-8?B?SkZhdlIyQXhOVmFwK0lsdDNUSkFkTGxQZ3BaRU5kUkw2YXlGRXVsR0xrQUdx?=
 =?utf-8?B?WGx6VXBDbXl5M2wxV1daazFsVmgvV2hpRFZXMHlhaXBEVC9UVmtTUEQ1L29s?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9976A7AFB0BA4A4E9012430288D796CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzF5V1RTMnJmb2dMZDJkOUk4dVJTM0lRT1d2ZFB0Q3Z3VWZvcTRGYUF2OFM5?=
 =?utf-8?B?MHErYkZ6L2p2T2p6MGo3a3V2R2dKaUd6Ni9keEtka3VzbWZBNlQyckhwTGZ3?=
 =?utf-8?B?TXlydENLSVBEZmdmUFI0SWRFMmFGRUtsbjZQUDFRUS8ydVRSK0l6d3MwV29n?=
 =?utf-8?B?WG5xZlZERGpscDVlY2U0YjREaFZPQ2NibHZjaXlVN0hWQjNSOW1mSU8wVWF2?=
 =?utf-8?B?TC9GbGhJWWlHODFTcFhFb0Z6MlBaM2FSWnNOUVM0QVZRaTZVeWFsWm5nWHM1?=
 =?utf-8?B?bGhhN3U5Um9YR3FONHN2UjVQUjgvWGlNVnBhOUdDbndrU3BGL0FVdU5UbVNq?=
 =?utf-8?B?T2oxb0k5M096dnpvN1lMdk1xbDlObjRlU0x5QnNjNlIzcWZWaFpaZUVJbExs?=
 =?utf-8?B?SFpzaXFBS2NGY0EwTXg1MWhKNU9QSGpsbTg2L1B3TS9tNkh4cDBiSGNsYmdT?=
 =?utf-8?B?MFAvSHU0N0t0RG44RmhzcWZmeUZMeUY5MlJGbHFob1R4Z2V5aWZTaTlFV0JI?=
 =?utf-8?B?RWcxaUlLdDJMc05RREtzWWdzRHVqejdJU0k3MmZ4ZDkyV01FeFdYcDduRks2?=
 =?utf-8?B?Mk1MQ2xFeUJaWDlGZ2RpbFViQzRRdUkrbkNjOUJteVp3d3VWaHdaTmIwVTdD?=
 =?utf-8?B?dDBEL21zbFFHNWVWU1Z3N2VCUldNQk13UDUrWXRqclRNRUFFLy9EeGZMQ01L?=
 =?utf-8?B?bVdpQ0pTdnVPTWs5SUJSY005blNmZDlzMTA4TkJkSUQ0WDhwcGZESmZxSXo1?=
 =?utf-8?B?eUdrNFdtRlI2SksrNC9CS0dhQjBJL3ZlWmc2REtmcXpRcms2L0Q1MnkyR2d1?=
 =?utf-8?B?K0FtVHVvSUlPSFBZYTk0TlpybUhLRy9td2o1MWR1Y01oVko3ZXpUOER3Ti80?=
 =?utf-8?B?cnYxZWtldktPc01SQk8wS2szdzF1N0t4NG5BVDFpd2NRcThXbFBXallsNjNo?=
 =?utf-8?B?bFRUekN3eE1LNS9WZmR2TDV1UVZINVlvajVNc0FaQSs4eEU5S3Y0VjV4NVQ3?=
 =?utf-8?B?eCt5UFZHNlljb05KemZGVUlwcW5YdnQ3RU12SGVSQlJKU0loUEhtODZSemV6?=
 =?utf-8?B?dUY4dENUZHVodlAwZ0N3cEdRaVpzZ2E5bk1wR1RqYUtvbXJJdnRJZCtJcjNv?=
 =?utf-8?B?dlpwbTg0VUVOaHQrTCtFVVdYTGNSL05FVzNFd0NtdzF2NnpHb0RJSHluOThl?=
 =?utf-8?B?L255T3dPcVk1MmJ2OTVncSsrV3ZDa2ROb1MwWm1DS0lLQ211Rnk0THlDUzVB?=
 =?utf-8?B?SU13dUUwU29Dd0JBN1hCaS8vbTRURTJybHZUSmZkVHk4cGJIQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d3784f-cc42-4ca3-5362-08db3557017b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 21:53:20.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tImMyRkMZJZQIfKr1wsyOP39KhHawosEiNgnBONjDxBPlApw9sowTcCvy59Z5uDL1s8yVG3PDw95O6gFWfeqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Proofpoint-GUID: EyWvnJipYS9Bp3p5g3ObdyTS1Uxe4olj
X-Proofpoint-ORIG-GUID: EyWvnJipYS9Bp3p5g3ObdyTS1Uxe4olj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040199
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MDQvMDQvMjAyMyAwMjozNywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWFyIDMx
LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gT24gMjMv
MDMvMjAyMyAyMjo1MSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gVGh1LCBNYXIgMjMs
IDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDIz
LzAzLzIwMjMgMDQ6MTcsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4gT24gV2VkLCBNYXIg
MjIsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+IE9uIFdlZCwgTWFyIDIyLCAy
MDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pj4+Pj4+IE9uIDIxLzAzLzIwMjMgMjE6MDUs
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+Pj4gT24gVHVlLCBNYXIgMjEsIDIwMjMsIFRo
aW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+Pj4+IE9uIFR1ZSwgTWFyIDIxLCAyMDIzLCBSb2dl
ciBRdWFkcm9zIHdyb3RlOg0KPiA+Pj4+Pj4+Pj4+IEhpIFRoaW5oLA0KPiA+Pj4+Pj4+Pj4+DQo+
ID4+Pj4+Pj4+Pj4gT24gMjAvMDMvMjAyMyAyMDo1MiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
Pj4+Pj4+Pj4+PiBIaSwNCj4gPj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4gT24gTW9uLCBNYXIg
MjAsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4+Pj4+Pj4+PiBJbXBsZW1lbnQg
J3NucHMsZ2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAnIHByb3BlcnR5Lg0KPiA+Pj4+Pj4+
Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4+IERvIG5vdCBzdG9wIHRoZSBnYWRnZXQgY29udHJvbGxlciBh
bmQgZGlzY29ubmVjdCBpZiB0aGlzDQo+ID4+Pj4+Pj4+Pj4+PiBwcm9wZXJ0eSBpcyBwcmVzZW50
IGFuZCB3ZSBhcmUgY29ubmVjdGVkIHRvIGEgVVNCIEhvc3QuDQo+ID4+Pj4+Pj4+Pj4+Pg0KPiA+
Pj4+Pj4+Pj4+Pj4gUHJldmVudCBTeXN0ZW0gc2xlZXAgaWYgR2FkZ2V0IGlzIG5vdCBpbiBVU0Ig
c3VzcGVuZC4NCj4gPj4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gPj4+Pj4+Pj4+Pj4+IC0tLQ0KPiA+
Pj4+Pj4+Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAyNSArKysrKysrKysrKysr
KysrKysrLS0tLS0tDQo+ID4+Pj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICB8
ICAyICsrDQo+ID4+Pj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDI1ICsr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4+Pj4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+
Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gPj4+Pj4+Pj4+Pj4+IGluZGV4IDQ3NmI2MzYxODUxMS4uYTQ3YmJh
YTI3MzAyIDEwMDY0NA0KPiA+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+
Pj4+Pj4+PiBAQCAtMTU3NSw2ICsxNTc1LDkgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVy
dGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+Pj4gIAlkd2MtPmRpc19zcGxpdF9x
dWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+Pj4+Pj4+Pj4+Pj4gIAkJ
CQkic25wcyxkaXMtc3BsaXQtcXVpcmsiKTsNCj4gPj4+Pj4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4+
Pj4+ICsJZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCA9IGRldmljZV9wcm9wZXJ0
eV9yZWFkX2Jvb2woZGV2LA0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJCQkic25wcyxnYWRnZXQta2VlcC1j
b25uZWN0LXN5cy1zbGVlcCIpOw0KPiA+Pj4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+Pj4gIAlk
d2MtPmxwbV9ueWV0X3RocmVzaG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsNCj4gPj4+Pj4+Pj4+
Pj4+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9IHR4X2RlX2VtcGhhc2lzOw0KPiA+Pj4+Pj4+Pj4+
Pj4gIA0KPiA+Pj4+Pj4+Pj4+Pj4gQEAgLTIwMjcsMTQgKzIwMzAsMjAgQEAgc3RhdGljIGludCBk
d2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+
ID4+Pj4+Pj4+Pj4+PiAgew0KPiA+Pj4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZCBsb25nCWZsYWdzOw0K
PiA+Pj4+Pj4+Pj4+Pj4gIAl1MzIgcmVnOw0KPiA+Pj4+Pj4+Pj4+Pj4gKwlpbnQgcmV0Ow0KPiA+
Pj4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+Pj4+Pj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9y
b2xlKSB7DQo+ID4+Pj4+Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+
ID4+Pj4+Pj4+Pj4+PiAgCQlpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0KPiA+
Pj4+Pj4+Pj4+Pj4gIAkJCWJyZWFrOw0KPiA+Pj4+Pj4+Pj4+Pj4gLQkJZHdjM19nYWRnZXRfc3Vz
cGVuZChkd2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJcmV0ID0gZHdjM19nYWRnZXRfc3VzcGVuZChk
d2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJaWYgKHJldCkgew0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJCWRl
dl9lcnIoZHdjLT5kZXYsICJnYWRnZXQgbm90IHN1c3BlbmRlZDogJWRcbiIsIHJldCk7DQo+ID4+
Pj4+Pj4+Pj4+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+Pj4+ICsJCX0NCj4gPj4+Pj4+
Pj4+Pj4+ICAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiA+Pj4+Pj4+Pj4+
Pj4gLQkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gPj4+Pj4+Pj4+Pj4+ICsJCWlmKCFkd2MtPmdh
ZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJCWR3YzNfY29y
ZV9leGl0KGR3Yyk7DQo+ID4+Pj4+Pj4+Pj4+PiAgCQlicmVhazsNCj4gPj4+Pj4+Pj4+Pj4+ICAJ
Y2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+ID4+Pj4+Pj4+Pj4+PiAgCQlpZiAoIVBNU0df
SVNfQVVUTyhtc2cpICYmICFkZXZpY2VfbWF5X3dha2V1cChkd2MtPmRldikpIHsNCj4gPj4+Pj4+
Pj4+Pj4+IEBAIC0yMDg4LDExICsyMDk3LDE1IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29t
bW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4+Pj4+Pj4+Pj4+PiAg
DQo+ID4+Pj4+Pj4+Pj4+PiAgCXN3aXRjaCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4+
Pj4+Pj4+Pj4+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gPj4+Pj4+Pj4+Pj4+
IC0JCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoZHdjKTsNCj4gPj4+Pj4+Pj4+Pj4+
IC0JCWlmIChyZXQpDQo+ID4+Pj4+Pj4+Pj4+PiAtCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+
Pj4+ICsJCWlmICghZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCkNCj4gPj4+Pj4+
Pj4+Pj4+ICsJCXsNCj4gPj4+Pj4+Pj4+Pj4+ICsJCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3Jf
cmVzdW1lKGR3Yyk7DQo+ID4+Pj4+Pj4+Pj4+PiArCQkJaWYgKHJldCkNCj4gPj4+Pj4+Pj4+Pj4+
ICsJCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+Pj4+ICsJCQlk
d2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ID4+Pj4+Pj4+
Pj4+PiArCQl9DQo+ID4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+PiAtCQlkd2MzX3NldF9w
cnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ID4+Pj4+Pj4+Pj4+PiAgCQlk
d2MzX2dhZGdldF9yZXN1bWUoZHdjKTsNCj4gPj4+Pj4+Pj4+Pj4+ICAJCWJyZWFrOw0KPiA+Pj4+
Pj4+Pj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gPj4+Pj4+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+ID4+Pj4+Pj4+Pj4+PiBpbmRleCA1ODJlYmQ5Y2Y5YzIuLmY4NGJhYzgxNWJlZCAxMDA2
NDQNCj4gPj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4+Pj4+
Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+Pj4+Pj4+Pj4+Pj4gQEAg
LTEzMjgsNiArMTMyOCw4IEBAIHN0cnVjdCBkd2MzIHsNCj4gPj4+Pj4+Pj4+Pj4+ICAJdW5zaWdu
ZWQJCWRpc19zcGxpdF9xdWlyazoxOw0KPiA+Pj4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZAkJYXN5bmNf
Y2FsbGJhY2tzOjE7DQo+ID4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+PiArCXVuc2lnbmVk
CQlnYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcDoxOw0KPiA+Pj4+Pj4+Pj4+Pj4gKw0KPiA+
Pj4+Pj4+Pj4+Pj4gIAl1MTYJCQlpbW9kX2ludGVydmFsOw0KPiA+Pj4+Pj4+Pj4+Pj4gIA0KPiA+
Pj4+Pj4+Pj4+Pj4gIAlpbnQJCQltYXhfY2ZnX2VwczsNCj4gPj4+Pj4+Pj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiA+Pj4+Pj4+Pj4+Pj4gaW5kZXggM2M2M2ZhOTdhNjgwLi44MDYyZTQ0ZjYzZjYgMTAwNjQ0
DQo+ID4+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+Pj4+
Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+Pj4+Pj4+Pj4+PiBA
QCAtNDU3MiwxMiArNDU3MiwyMyBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMg
KmR3YykNCj4gPj4+Pj4+Pj4+Pj4+ICBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+Pj4gIHsNCj4gPj4+Pj4+Pj4+Pj4+ICAJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4gPj4+Pj4+Pj4+Pj4+ICsJaW50IGxpbmtfc3RhdGU7DQo+ID4+Pj4+Pj4+Pj4+
PiAgDQo+ID4+Pj4+Pj4+Pj4+PiAgCWlmICghZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiA+Pj4+Pj4+
Pj4+Pj4gIAkJcmV0dXJuIDA7DQo+ID4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+PiAtCWR3
YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gPj4+Pj4+Pj4+Pj4+ICsJ
aWYgKGR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXAgJiYgZHdjLT5jb25uZWN0ZWQp
IHsNCj4gPj4+Pj4+Pj4+Pj4+ICsJCWxpbmtfc3RhdGUgPSBkd2MzX2dhZGdldF9nZXRfbGlua19z
dGF0ZShkd2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJLyogUHJldmVudCBQTSBTbGVlcCBpZiBub3Qg
aW4gVTMvTDIgKi8NCj4gPj4+Pj4+Pj4+Pj4+ICsJCWlmIChsaW5rX3N0YXRlICE9IERXQzNfTElO
S19TVEFURV9VMykNCj4gPj4+Pj4+Pj4+Pj4+ICsJCQlyZXR1cm4gLUVCVVNZOw0KPiA+Pj4+Pj4+
Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+Pj4gKwkJLyogZG9uJ3Qgc3RvcC9kaXNjb25uZWN0ICovDQo+
ID4+Pj4+Pj4+Pj4+PiArCQlkd2MzX2dhZGdldF9kaXNhYmxlX2lycShkd2MpOw0KPiA+Pj4+Pj4+
Pj4+Pg0KPiA+Pj4+Pj4+Pj4+PiBXZSBzaG91bGRuJ3QgZGlzYWJsZSBldmVudCBpbnRlcnJ1cHQg
aGVyZS4gV2hhdCB3aWxsIGhhcHBlbiBpZiB0aGUNCj4gPj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+
IER1ZSB0byBzb21lIHJlYXNvbiwgaWYgSSBkb24ndCBkaXNhYmxlIHRoZSBldmVudCBpbnRlcnJ1
cHRzIGhlcmUgdGhlbg0KPiA+Pj4+Pj4+Pj4+IGFmdGVyIFVTQiByZXN1bWUgdGhlIFVTQiBjb250
cm9sbGVyIGlzIG1hbGZ1bmN0aW9uaW5nLg0KPiA+Pj4+Pj4+Pj4+IEl0IG5vIGxvbmdlciByZXNw
b25kcyB0byBhbnkgcmVxdWVzdHMgZnJvbSBIb3N0Lg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+
IFlvdSBzaG91bGQgbG9vayBpbnRvIHRoaXMuIFRoZXNlIGV2ZW50cyBhcmUgaW1wb3J0YW50IGFz
IHRoZXkgY2FuIHRlbGwNCj4gPj4+Pj4+Pj4+IHdoZXRoZXIgdGhlIGhvc3QgaW5pdGlhdGVzIHJl
c3VtZS4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4gZGV2aWNlIGlz
IGRpc2Nvbm5lY3RlZCBhbmQgcmVjb25uZWN0IHRvIHRoZSBob3N0IHdoaWxlIHRoZSBkZXZpY2Ug
aXMNCj4gPj4+Pj4+Pj4+Pj4gc3RpbGwgaW4gc3lzdGVtIHN1c3BlbmQ/IFRoZSBob3N0IHdvdWxk
IG5vdCBiZSBhYmxlIHRvIGNvbW11bmljYXRlIHdpdGgNCj4gPj4+Pj4+Pj4+Pj4gdGhlIGRldmlj
ZSB0aGVuLg0KPiA+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4gSW4gdGhlIFRJIHBsYXRmb3JtLCBU
aGUgc3lzdGVtIGlzIHdva2VuIHVwIG9uIGFueSBWQlVTL2xpbmVzdGF0ZSBjaGFuZ2UNCj4gPj4+
Pj4+Pj4+PiBhbmQgaW4gZHdjM19nYWRnZXRfcmVzdW1lIHdlIGVuYWJsZSB0aGUgZXZlbnRzIGFn
YWluIGFuZCBjaGVjayBmb3IgcGVuZGluZw0KPiA+Pj4+Pj4+Pj4+IGV2ZW50cy4gSXMgaXQgcG9p
bnRsZXNzIHRvIGNoZWNrIGZvciBwZW5kaW5nIGV2ZW50cyB0aGVyZT8NCj4gPj4+Pj4+Pj4+Pg0K
PiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IEl0IHNlZW1zIGZyYWdpbGUgZm9yIHRoZSBpbXBsZW1l
bnRhdGlvbiB0byBiZSBkZXBlbmRlbnQgb24gcGxhdGZvcm0NCj4gPj4+Pj4+Pj4+IHNwZWNpZmlj
IGZlYXR1cmUgcmlnaHQ/DQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gQWxzbywgd2hhdCB3aWxs
IGhhcHBlbiBpbiBhIHR5cGljYWwgY2FzZSB3aGVuIHRoZSBob3N0IHB1dHMgdGhlIGRldmljZQ0K
PiA+Pj4+Pj4+Pj4gaW4gc3VzcGVuZCBhbmQgaW5pdGlhdGVzIHJlc3VtZSB3aGlsZSB0aGUgZGV2
aWNlIGlzIGluIHN5c3RlbSBzdXNwZW5kDQo+ID4+Pj4+Pj4+PiAoYW5kIHN0YXkgaW4gc3VzcGVu
ZCBvdmVyIGEgcGVyaW9kIG9mIHRpbWUpPyBUaGVyZSBpcyBubyBWQlVTIGNoYW5nZS4NCj4gPj4+
Pj4+Pj4+IFRoZXJlIHdpbGwgYmUgcHJvYmxlbSBpZiBob3N0IGRldGVjdHMgbm8gcmVzcG9uc2Ug
ZnJvbSBkZXZpY2UgaW4gdGltZS4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBEb24ndCB3ZSBu
ZWVkIHRoZXNlIGV2ZW50cyB0byB3YWtldXAgdGhlIGRldmljZT8NCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+IFRoYXQncyB3aHkgdGhlIFRJIGltcGxlbWVudGF0aW9uIGhhcyBsaW5lLXN0YXRlIGNoYW5n
ZSBkZXRlY3Rpb24gdG8NCj4gPj4+Pj4+PiBkZXRlY3QgYSBVU0IgcmVzdW1lLiBXZSBhcmUgZG9p
bmcgYSBvdXQtb2YtYmFuZCB3YWtlLXVwLiBUaGUgd2FrZSB1cA0KPiA+Pj4+Pj4+IGV2ZW50cyBh
cmUgY29uZmlndXJlZCBpbiB0aGUgd3JhcHBlciBkcml2ZXIgKGR3YzMtYW02Mi5jKS4NCj4gPj4+
Pj4+Pg0KPiA+Pj4+Pj4+IERvIHlvdSBrbm93IG9mIGFueSBkd2MzIGltcGxlbWVudGF0aW9uIHRo
YXQgdXNlcyBpbi1iYW5kIG1lY2hhbmlzbQ0KPiA+Pj4+Pj4+IHRvIHdha2UgdXAgdGhlIFN5c3Rl
bS4gaS5lLiBpdCByZWxpZXMgb24gZXZlbnRzIGVuYWJsZWQgaW4gREVWVEVOIHJlZ2lzdGVyPw0K
PiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gV2UgcmVseSBvbiBQTUUuIFRoZSBQTUUgaXMg
Z2VuZXJhdGVkIGZyb20gdGhlIFBNVSBvZiB0aGUgdXNiIGNvbnRyb2xsZXINCj4gPj4+Pj4+IHdo
ZW4gaXQgZGV0ZWN0cyBhIHJlc3VtZS4gSWYgeW91ciBwbGF0Zm9ybSBzdXBwb3J0cyBoaWJlcm5h
dGlvbiBhbmQgaWYNCj4gPj4+Pj4+IHRoZSByZXN1bWUgc2lnbmFsIGlzIGNvbm5lY3RlZCB0byB0
aGUgbG93ZXIgbGF5ZXIgcG93ZXIgbWFuYWdlciBvZiB5b3VyDQo+ID4+Pj4+PiBkZXZpY2UsIHRo
ZW4geW91IGNhbiB3YWtldXAgdGhlIHN5c3RlbSBvbmUgbGV2ZWwgYXQgYSB0aW1lLiBGb3IgZXhh
bXBsZSwNCj4gPj4+Pj4+IGlmIHlvdXIgZGV2aWNlIGlzIGEgcGNpIGRldmljZSwgdGhhdCB3YWtl
dXAgc2lnbmFsIHdvdWxkIHRpZSB0byB0aGUgcGNpDQo+ID4+Pj4+PiBwb3dlciBtYW5hZ2VyLCB3
YWtpbmcgdXAgdGhlIHBjaSBsYXllciBiZWZvcmUgd2FraW5nIHVwIHRoZSBjb3JlIG9mIHRoZQ0K
PiA+Pj4+Pj4gdXNiIGNvbnRyb2xsZXIuIFRoYXQncyBob3cgdGhlIGhvc3Qgd2FrZXMgdXAgdGhl
IGhvc3Qgc3lzdGVtIChlLmcuIGZyb20NCj4gPj4+Pj4+IHJlbW90ZSB3YWtldXApLiBGb3IgdGhp
cyB0byB3b3JrLCB3ZSBleHBlY3Qgc29tZXRoaW5nIHNpbWlsYXIgb24gdGhlDQo+ID4+Pj4+PiBk
ZXZpY2Ugc2lkZS4NCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+
PiBXZSBtYXkgbm90IGJlIGFibGUgdG8gc3VzcGVuZCBldmVyeXRoaW5nIGluIHN5c3RlbSBzdXNw
ZW5kIGZvciB0aGlzDQo+ID4+Pj4+Pj4+IGNhc2UuIEknbSB0aGlua2luZyBvZiB0cmVhdGluZyB0
aGVzZSBldmVudHMgYXMgaWYgdGhleSBhcmUgUE1FIHRvIHdha2V1cA0KPiA+Pj4+Pj4+PiB0aGUg
ZGV2aWNlLCBidXQgdGhleSBhcmUgbm90IHRoZSBzYW1lLiBJdCBtYXkgbm90IGJlIHNpbXBsZSB0
byBoYW5kbGUNCj4gPj4+Pj4+Pj4gdGhpcy4gVGhlIGxvd2VyIGxheWVycyBtYXkgbmVlZCB0byBz
dGF5IGF3YWtlIGZvciB0aGUgZHdjMyB0byBoYW5kbGUNCj4gPj4+Pj4+Pj4gdGhlc2UgZXZlbnRz
LiBIbS4uLiBpdCBnZXRzIGEgYml0IGNvbXBsaWNhdGVkLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4g
QXMgd2UgYXJlIGdvaW5nIGludG8gc3VzcGVuZCwgd2UgYXJlIG5vdCByZWFsbHkgaW4gYSBwb3Np
dGlvbiB0byBoYW5kbGUgYW55DQo+ID4+Pj4+Pj4gKERFVlRFTikgZXZlbnRzIHRpbGwgd2UgaGF2
ZSBmdWxseSByZXN1bWVkLg0KPiA+Pj4+Pj4+IFNvIHllcywgd2UgbmVlZCB0byByZWx5IG9uIHBs
YXRmb3JtIHNwZWNpZmljIGltcGxlbWVudGF0aW9uIHRvIHdha2UNCj4gPj4+Pj4+PiB0aGUgU3lz
dGVtIG9uIGFueSBVU0IgZXZlbnQuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBZb3Ug
bWF5IGJlIGFibGUgdG8gZGV0ZWN0IHZidXMgY2hhbmdlIHRocm91Z2ggdGhlIGNvbm5lY3RvciBj
b250cm9sbGVyLg0KPiA+Pj4+Pj4gSG93ZXZlciwgdGhlIHVzYiBjb250cm9sbGVyIGlzIHRoZSBv
bmUgdGhhdCBkZXRlY3RzIGhvc3QgcmVzdW1lLiBXaGF0DQo+ID4+Pj4+PiBwbGF0Zm9ybSBzcGVj
aWZpYyBpbXBsZW1lbnRhdGlvbiBkbyB5b3UgaGF2ZSBvdXRzaWRlIG9mIHRoZSB1c2INCj4gPj4+
Pj4+IGNvbnRyb2xsZXIgZG8geW91IGhhdmUgdG8gZ2V0IGFyb3VuZCB0aGF0Pw0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IEknbSBub3Qgc3VyZSBpZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIGhpYmVybmF0
aW9uIG9yIGlmIHRoZSBQTUUgc2lnbmFsDQo+ID4+Pj4+PiBvbiB5b3VyIHBsYXRmb3JtIGNhbiB3
YWtldXAgdGhlIHN5c3RlbSwgYnV0IGN1cnJlbnRseSBkd2MzIGRyaXZlcg0KPiA+Pj4+Pj4gZG9l
c24ndCBoYW5kbGUgaGliZXJuYXRpb24gKGRldmljZSBzaWRlKS4gSWYgdGhlcmUncyBubyBoaWJl
cm5hdGlvbiwNCj4gPj4+Pj4+IHRoZXJlJ3Mgbm8gUE1FLg0KPiA+Pj4+DQo+ID4+Pj4gTm8sIGlu
IHRoaXMgVEkgU29DLCBoaWJlcm5hdGlvbiBmZWF0dXJlIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhl
IGR3YzMgY29yZS4NCj4gPj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gQWN0dWFsbHks
IEkgdGhpbmsgdGhlIGR3YzMgY29yZSBpcyBzdGlsbCBvbiBkdXJpbmcgc3lzdGVtIHN1c3BlbmQg
Zm9yDQo+ID4+Pj4+IHlvdSByaWdodD8gVGhlbiBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIHdha2V1
cCBldmVudCB0byB3YWtldXAgc3lzdGVtDQo+ID4+Pj4+IHN1c3BlbmQgb24gaG9zdCByZXN1bWU/
IFlvdSBjYW4gaWdub3JlIGFib3V0IFBNRSBpbiB0aGlzIGNhc2UuIFlvdSBtYXkNCj4gPj4+Pj4g
bmVlZCB0byBsb29rIGludG8gd2hhdCBuZWVkcyBzdGF5IGF3YWtlIHRvIGFsbG93IGZvciBoYW5k
bGluZyBvZiB0aGUNCj4gPj4+Pj4gZHdjMyBldmVudC4NCj4gPj4+Pg0KPiA+Pj4+IEJ1dCBpbiBT
b0MgZGVlcC1zbGVlcCBzdGF0ZSwgYWxsIGNsb2NrcyB0byB0aGUgZHdjMyBjb3JlIGFyZSBzdG9w
cGVkLg0KPiA+Pj4+IFNvIEknbSBub3Qgc3VyZSBpZiBkd2MzIGV2ZW50cyB3aWxsIHdvcmsuDQo+
ID4+Pj4NCj4gPj4+DQo+ID4+PiBSaWdodCwgeW91IG5lZWQgdG8ga2VlcCB0aG9zZSBjbG9ja3Mg
cnVubmluZyB0byBkZXRlY3QgaG9zdCByZXN1bWUuDQo+ID4+PiBUaGVyZSdzIHN0aWxsIHNvbWUg
cG93ZXIgc2F2aW5nIHRocm91Z2ggdGhlIGR3YzMgY29udHJvbGxlcidzIGhhbmRsaW5nDQo+ID4+
PiBpbiBzdXNwZW5kLiBZb3UgbWF5IGhhdmUgc29tZSBsaW1pdGVkIHBvd2VyIHNhdmluZyBmcm9t
IG90aGVyIHN1c3BlbmRlZA0KPiA+Pj4gZGV2aWNlcyBvbiB5b3VyIHNldHVwLiBIb3dldmVyLCBJ
IGRvbid0IHRoaW5rIHdlIGNhbiBleHBlY3QgdGhlIHBsYXRmb3JtDQo+ID4+PiB0byBnbyBpbnRv
IGRlZXAtc2xlZXAgYW5kIGFsc28gaGFuZGxlIGhvc3QgcmVzdW1lLg0KPiA+Pg0KPiA+PiBXaHkg
bm90PyBpZiB0aGUgUEhZIGNhbiBkZXRlY3QgdGhlIGhvc3QgcmVzdW1lIGFuZCB3YWtlIHVwIHRo
ZSBTb0MgaXQgd2lsbA0KPiA+PiB3b3JrIHJpZ2h0Pw0KPiA+Pg0KPiA+IA0KPiA+IEhtLi4uIEkg
c3VwcG9zZWQgaXQgbWF5IGJlIHBvc3NpYmxlLiBCdXQgaXQgbWF5IG5lZWQgc29tZSB1bmNvbnZl
bnRpb25hbA0KPiA+IGRlc2lnbj8gVGhlIGR3YzMgY29udHJvbGxlciBpcyBjdXJyZW50bHkgcmVn
aXN0ZXJlZCB0byB0aGUgcGh5LiBGb3IgdGhhdA0KPiA+IHRvIHdvcmssIHlvdXIgcGh5IG5lZWRz
IHRvIGJlIGFibGUgdG8gdGFsayB0byBib3RoIHRoZSBkd2MzIGNvbnRyb2xsZXINCj4gPiBhbmQg
c29tZSBvdGhlciBjb250cm9sbGVyIChlcXVpdmFsZW50IHRvIGR3YzMgUE1VKSB0aGF0IG1hbmFn
ZXMNCj4gPiBwb3dlci9pbnRlcnJ1cHQuIFRoZSBkd2MzIGNvbnRyb2xsZXIgd291bGQgbmVlZCB0
byByZWxpbnF1aXNoIGNvbnRyb2wgdG8NCj4gPiB0aGlzIG90aGVyIHBoeSBjb250cm9sbGVyIG9u
IHN1c3BlbmQuIFRoZSBwaHkgZHJpdmVyIHdvdWxkIHRoZW4gYmUgYWJsZQ0KPiA+IHRvIGFzc2Vy
dCBpbnRlcnJ1cHQgd2FraW5nIHVwIHRoZSBzeXN0ZW0gb24gcmVzdW1lIHNpZ2FsIGRldGVjdGlv
biwNCj4gPiB3aGljaCBpbiB0dXJuIHJlbGlucXVpc2ggY29udHJvbCB0byB0aGUgZHdjMyBjb250
cm9sbGVyLiBBbGwgb2YgdGhpcyBoYXMNCj4gPiB0byB3b3JrIHdoaWxlIHRoZSBwaHkgc2lnbmFs
aW5nIHJlbWFpbnMgc3luY2hyb25pemVkIHdpdGggdGhlIGR3YzMNCj4gPiBjb250cm9sbGVyLg0K
PiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGFsbCB0aGlzIGlzIHRha2VuIGNhcmUgYnkg
UEhZIGludGVncmF0aW9uIGRlc2lnbiB3aXRoDQo+IERXQzMgY29yZSBvbiB0aGUgVEkgU29DLg0K
PiANCj4gPiANCj4gPiBGcm9tIHRoZSBwYXRjaGVzIHlvdSBzZW50LCBJIGRvbid0IHNlZSB0aGUg
Y2hhbmdlcyBuZWNlc3NzYXJ5IGZvciB0aGlzDQo+ID4gdG8gd29yay4gSWYgdGhlcmUgaXMgc29t
ZXRoaW5nIHRoYXQgSSdtIG1pc3NpbmcsIHBsZWFzZSBhbHNvIG5vdGUgaXQgb3INCj4gPiBhZGQg
aXQgaGVyZSB0byB0aGUgc2VyaWVzLg0KPiANCj4gVGhlcmUgaXMgbm90aGluZyBtb3JlIGFzIHRo
ZSBkZXRhaWxzIGFyZSB0YWtlbiBjYXJlIGJ5IFBIWSBsb2dpYyBhbmQNCj4gbmVjZXNzYXJ5IGlu
dGVncmF0aW9uIHdpdGggRFdDMy4NCj4gDQo+IEZvciB0aGUgUEhZIHdha2UtdXAgcHJvZ3JhbW1p
bmcgZGV0YWlscyB5b3UgaGF2ZSBhbHJlYWR5IGNoZWNrZWQgdGhpcyBzZXJpZXMgWzFdLg0KPiAN
Cj4gWzFdIC0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIzMDMxNjEzMTIyNi44OTU0MC0xLXJvZ2VycUBrZXJuZWwub3JnL19fOyEhQTRG
MlI5R19wZyFheXFwYVd3bldJTzdTS2t0azRrSTJFSkx3RFRJdjJuWVlDZ0JHSFVsdDU2S1R6ZVlr
REVkcTJRNVp2WkZzdUNXSWxjWEdFVDIzMFlZNUozeV9zSFYkIA0KPiANCg0KSSBtYXkgaGF2ZSBt
aXN1bmRlcnN0b29kIHlvdXIgcGxhdGZvcm0gaW1wbGVtZW50YXRpb24uIE15IHVuZGVyc3RhbmRp
bmcNCmlzIHRoYXQgaXQgY2FuIG9ubHkgZGV0ZWN0IFZCVVMgYW5kIHRoYXQgaXQgY2FuIG9ubHkg
cmVzdW1lIG9uIFZCVVMNCnZhbGlkLg0KDQpEb2VzIHRoZSAiTElORVNUQVRFIiBoZXJlIGdldHMg
YXNzZXJ0ZWQgaWYgc2F5IHRoZXJlJ3MgYSBMRlBTIGRldGVjdGlvbj8NCg0KVGhhbmtzLA0KVGhp
bmg=
