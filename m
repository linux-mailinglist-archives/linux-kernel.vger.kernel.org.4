Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FE67BA51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjAYTIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAYTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:08:42 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825859984;
        Wed, 25 Jan 2023 11:08:40 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PIXHDx002975;
        Wed, 25 Jan 2023 11:08:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=p0TwYX+JsSH1m1rhOKTQFrzRQulCOZqOB+HbQ8HGjAM=;
 b=ugzhnfOWBfXKNy+h3d7RgVT3dOry0VAoM3jQ/VUo73CtSvIApZNLVhtr+2/xuUR02xpD
 mhFv9AjwacBFOkW+AqPOSeevqZksb7oM28+SEuzb7ERP1QLf2zPzYNpkULoIaYptd2NJ
 EfA7MSCW2sIfCkKuEHAwAi+ZN0K7JjJsuInvOo/qN+KJVgfRVeToJZDD9qRBoXnujf6C
 hT8Nvt4ioBZx4g74McbruTR5wwFDqCzBp0u+E0puFbM/0q7uwNCcoCBrxXv6qS5EwRju
 UiZNdzuSo4G2laA37lSyNOcQadd6KdIIvmNC2ZoWlSKRGUs8QDLLGdqD7iEwG5mtgajY hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n8fjk3684-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:08:20 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1E32C0100;
        Wed, 25 Jan 2023 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674673699; bh=p0TwYX+JsSH1m1rhOKTQFrzRQulCOZqOB+HbQ8HGjAM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZK6yvLqivfLhdcOcvYeJxVJim5bdKVwkds74Hom3nn4qGUTpvISYWOY2GJH88UaO1
         PUPTLR1Rz5lewC6xylbCa8L3xGzVj0e3tK6ROvmwCgAv3Umc3GDNTnqsrVjUsNepuU
         gjeOahy/pOUzKZ+gcoPqHt1aokK7KLSy4zP5nb+tAiqIdyn40kv7k47qIirB5TgjrE
         o+5fishAIV+BD0ZYxtrtGMxJ7i02uEaYG6yWVN0cgCwQEdGC4xUzBAoFtxgY+MkqZL
         IcjRVyZalvo34N0txjE1VIgH5LbT1Khf7S4AwZP/sS/XgW+3nASkaAZfIHdQbXGbD+
         cAIezvM56GDLQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E9ED0A009D;
        Wed, 25 Jan 2023 19:08:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4A46280199;
        Wed, 25 Jan 2023 19:08:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rtP0jOuV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAXgqIfJl5pPFI9KcIRaja05+Ce3KgFyy70NnmRM1OHjtnil7Thzpfl0udg92Cs/oJWfYW5RV+sDP3HFpNbi0L1lNDqsAOWFu7YLPWWW8lo439KvsNgfTsmVXCf2rTeo/SNKWjl5CPDgw85SI3TpX75LUsxIG0pq9kHj/BLaH36d3q13755Ik2+TEyjNewdnTBrMmRZ47e7I3CjUezl+U81ZZPgslKQf94KT7COYbzt1grvO2cbNtfvSPP449ytXSonplKzAh9DC8eac7iG6RoXNhXVbxaU6o+9Qybxm3SBusMn5QRwwn594nhqLywEqkTqTIF4nMR3wnXFEjLOPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0TwYX+JsSH1m1rhOKTQFrzRQulCOZqOB+HbQ8HGjAM=;
 b=QQj+48rCcCcajWGzvRfxMKwdD9HrQEiSmshY1fEiUiCn7eMDYb5FeUD9jZslVn7MLr1MIZpqs63m9IN1bDNUUMZIRYhUM4PGvDA1tA9Jz82zf3l5BxwAInGng9PRFuaDJNFYwbktI9DZKGcUmvOGvVJqmibvK2FlLaNj/Nst/BXL04GUR4LeA7pIVcUjjvnGlWjz8QUi4I6NbuoXc92hefcOmTyyZT5lsho9HALIMPoFcm3opm/s5t0bUtB8NiJL/p8jyOSdSyotWX/3d6Jic1zg66yO3bJ12FL1ZA1v+rwoMq/4dhHrqFkwmTEj9PUdFd0PFueyvAI/Yo0f6rrbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0TwYX+JsSH1m1rhOKTQFrzRQulCOZqOB+HbQ8HGjAM=;
 b=rtP0jOuV/CQpprchFCzqBrKyuLx/d8UfvekZv6MQ5YYR2n/itmMZL/YM91rnHaTh5nMNLXRYYlaRE1CjcQin8ZK8aH6f8FhKeBRGS40QDYDajGIvtVCt38MlWAzbOwu+lmXu0/weEsTr3bSBARVICNzDufocErQGTrZ8KeJoXFk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 19:08:11 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 19:08:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAAojICAAXEUAIAADDCAgAFfeACABwg/AIAAlxWA
Date:   Wed, 25 Jan 2023 19:08:10 +0000
Message-ID: <20230125190805.l7yo5lls7gfhoo4b@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
 <20230120010226.wjwtisj4id6frirl@synopsys.com>
 <91fa86d8-f443-db13-1544-73e2dd50d964@quicinc.com>
 <20230120224400.77t2j3qtcdfqwt5s@synopsys.com>
 <0d9eab77-ad5f-be23-8ed6-d78c0d3ccef1@quicinc.com>
In-Reply-To: <0d9eab77-ad5f-be23-8ed6-d78c0d3ccef1@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB8312:EE_
x-ms-office365-filtering-correlation-id: 8ffbbd50-7312-443a-7a57-08daff078034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTjEdhVMPLWVYy6bXvX7jPFJzbZGdTXdEQ1GHg/JTEXEmUGMpqUHS7fbk4WTpE+oK97ClghKLoTAcBusvPnlQ05QJM5KJNg8Bh3h9NZaki9gJ2CKbmP3ChJvIPY0u0nlf2qu6pUc+KApIDzNuYfc5U609PfDvAw1dUkRsn0nobAyvdVMeV3G5T0MnOrzezd7kRoOOn4XlrLawHVQlD+rzLFJh1jZvtNN9avseQZq/VZ+JKSvqdSeeMv0nioefPsMNXaaB39H0NGW2QvoeNoHMdhWp2zRZZQAST1jFVL+kh5bYBQeoOGVXAIjV5DLYZ0EBxPtWgQM1OP8ez4v4wlOYFs6t7ViQnPuWUEe9m7DcWppiOfsw216sIQqwgCGBG9Q4dg+7+z7pabh8p03DpOkkuxvARx1SMWpSRj1n7gTMeRuxUn7OgeFoeJhXv/SYNwhlvg2km0wmBIS3DDJ3EDb8b5Yh2zz6VHU1Z64o2CqaEcczdkVManMS40fSe9hhuKu6AZnayF6mT4XGpchvkgUqAMS2q/K3f0CgcYFKL2X81O0ua3H/2ZHTY6ntN1zHW13K/TabOCdX4MH+/Ov542qt+ycjCVB6QG/VmsK7mBvxzrH464j01HJKehZv15V9w2mUzyQlZVSS4Ib2gVXIKhZBmHh4yizhWAYKDnucczzuGREAi+bx2vAO4/gHrbjtLFzmOvkT15yFpCNuO+irRaNdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(38100700002)(83380400001)(122000001)(26005)(5660300002)(2906002)(7416002)(41300700001)(86362001)(4326008)(8936002)(316002)(6512007)(6506007)(186003)(8676002)(66476007)(66556008)(64756008)(2616005)(53546011)(54906003)(6916009)(66446008)(478600001)(66946007)(36756003)(91956017)(71200400001)(6486002)(76116006)(38070700005)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d21VczNYSG5oZTJHV3NFTVNTbHNlQkw4aVdUNmZIUWYxY005WDVzeWpSVjha?=
 =?utf-8?B?UXNtV2J3SjAxZ0hRNGtmaU12aGlTMU56Vy9PeFM0QlMwRDJYaE1JMHd1NnJk?=
 =?utf-8?B?dVhXSTJzc1FtTkVtWDdpYTdwYStlVHk3bmtxY2MvZklGa3lBS3U0NVhCUmFm?=
 =?utf-8?B?N0dXRFFWUUZ2WXZyT0pTSzU0eXZSTFc4UmtTQkdDSUQ5RXJ6SlFTMnR4WUg2?=
 =?utf-8?B?Q3FZdnY3U01KT1pzcjF3TTVrZ3h5MU55WVFRNXpENWF6L1BSZEZJSFlUSGMw?=
 =?utf-8?B?akdsNFdJZmpPKzY0N2srTmgzeVU0Nnd6NlQrY1lkd1dvZ00zSjdmVVhSUzlE?=
 =?utf-8?B?QTd0YzFDTHRjaGduY2YxSFJtNnliNCttTTN5cXZ5NkozUG1RK1FZN2JWWXIy?=
 =?utf-8?B?NUxvOFdnSlMyWTlJU3ZrcU1Dekp1VVdwTXVLUkw0a0dUc1pBaVA1Zzlpay9Y?=
 =?utf-8?B?UkZFR2VWbExqVWEwV0tyY0pXaGFSNHJ5SGk3YVJGbFhsOUs1WHc3S1lPRWJo?=
 =?utf-8?B?ZzBZMUl3TGJLSmM2K0svWENWdlRPZzVGUWVxOUswdDFDN25GdkJ5MGZ1Zllo?=
 =?utf-8?B?TkErT2I3NUFDTUZLSHZFTHZ5NmlGOU5QU1ZzaVdqS2pEZFJaSVJmb0RVOFo1?=
 =?utf-8?B?YXJkOUN4eGxlNlBya3FDa0xRLy95YVpzanJvNHYydFh0bk1MYW9xM3JqV01R?=
 =?utf-8?B?L1JIU0IzRCtvSGw1cnEyY1crai9sRXRMR2xHYUhTTnpJMnhaanI1OUVhSm9V?=
 =?utf-8?B?K2VwNGhJMERwVXFTUU9kTHVBT2Y2WVBKdWx4ZEQwNVNDVW9CK29CV2NtU2ps?=
 =?utf-8?B?a0lsS3pXYnJRSVJLTkNmNWZrV05YY2JLV2Iwa0tvU0xybVhUVzA2Qk1USjdn?=
 =?utf-8?B?UlBjbkJOMXYyeExMM0MzNWJ1MUFxZXJSUXFDUWRFWEhpdjBPQVFMdk5VdlFI?=
 =?utf-8?B?WDdZWXJYYWV3bE90MXpLcTBQMzR1b2ZLMTM5QSt2eUxYWkhxZWltbHU1bU5Z?=
 =?utf-8?B?MmorWTNsYWl0QUNyY3JybkJqRHZhSXJGTGVFcVdGcThDM1gwZ0tqTVh1RDE0?=
 =?utf-8?B?UE45QVVVa3d5VXY0eG5LU2NQYXdkZnQwbENpQ0NteUl1K1k3TWdKaGl4TEJW?=
 =?utf-8?B?SHdtVnFzNVF2aHY5dzBPbG1KSlgrbEN5VHEvVDE2Z3JBeEgvalN5UTVEQnBW?=
 =?utf-8?B?R0ZQVldMUjV1Qit5eEdYZitSSk9USjRid1B2RkIrYVhBUFNtdHBEc01OcVgv?=
 =?utf-8?B?QWVjaTNXV0FhdVFlMm9yV3BWaXBMZHFQeHpiMC84R1hQLzZiZGJZeWhlUkow?=
 =?utf-8?B?dTlVeXYvdkpBVFNXcFpzcm9PTXEzVzBPMUF4MkV3UCt2UUdQUk1SRDRzTS9P?=
 =?utf-8?B?VysyQ3dBOWFYZEZPQTFoS3lHMWZUMVFnT3VMSGZrYU90TUVhcmhqaXlJVDl5?=
 =?utf-8?B?bDFSRkgyM0xjSE54cW5tNHZHSitnYlc4anQwSmVDTjloaGVCRm9tamd0VXYw?=
 =?utf-8?B?RTZ1Mnd4blNSUXVXSE9Bb050UVJ2UlFaVzhJVTBTMTNWcjdMbG5DTFZJc21J?=
 =?utf-8?B?Y08zVWF3V09QRUwxdUtjVVQwN0J2WWFnZUN0WW1SbnhrRVJDbnkvRHE1V2o4?=
 =?utf-8?B?MzhBejJjNHNlTGU1eTJtb3NWMXBxZDdVZzZubmlqWis4OGpvMGxuemQ4clJX?=
 =?utf-8?B?VkoyZkpwL0MwUDRCMzNJcFlOWnB5bWFyN1pQRlFFWkdqV0NNWUY0Y20yYml2?=
 =?utf-8?B?eFFZeDA5TlFYaHNnck0wVGRVb1JJVG5ZSmswT3B4UlJ4emt5QUF4cXBNcGhk?=
 =?utf-8?B?SHhpSm5UbWNpYVhwNng4d0FwcldlRHhxRWh1aWVxbVJaelZ6cDRJaHNmeC95?=
 =?utf-8?B?SytnM280VVdMbzRWUGlNUkVDcjRlS1JjenhYaDkxa3o3UkRBSkR4V0dRR2lL?=
 =?utf-8?B?Ym9ud09wajh0Qkljci8zUmszRGhWMVhBRFgxNEZWeThmRCtxVUtiaVVsOHZS?=
 =?utf-8?B?Y3hSUE44Skp2UGdmbjYwNzNna211MERLaC9FdGJmR0I1a1J4V3hNeDk4WG8z?=
 =?utf-8?B?UzVwM3dTUmNvK2M4UXFQN0xUK3Q5K0ZUZGNoQWkrcVNzcXdiS0N6a25xME82?=
 =?utf-8?B?amJEbzVtWkhuZ3JDQnUyeDlidHZuL0JrbnVaRUpqakQzMWpOK0VMWnAvbDVV?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81D1F75EA8DE0A47923AF4DF616AD25D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGVuZXJWQXZ4aWRWZ3Z6RkxXdmR4Zjd3N1h5d29ZcHFydDgvaUlYakRQYjJu?=
 =?utf-8?B?SzA1QzVKSC9UMmh5ZzVFQVJtZ0Y5d0lvVHRKdThlTm9JNlgrR0ZrclJNOVp0?=
 =?utf-8?B?UmVyK3hzQzVCR2U1bkRuQnhwb1RubVJkaWdra0JHMGoyTWF0VStSSnZ6TTRu?=
 =?utf-8?B?a3FVNUlUTTJJYS9FYUpWdm1vY1RJeGZ0ZmkyR0ZxU1U0bCtyQnJaRnhFYSts?=
 =?utf-8?B?VkEzQ2l5Y1pyNnZMWFBKK3daSFg3VTJxaWtPQ3Eydy9jZkt0OWRsa0NGUzhM?=
 =?utf-8?B?VU5DY0Jwc2tCakd5OG01MnVsZUVtYUNPUTNEcmRXUlFCNjRHZmh5clRlUktM?=
 =?utf-8?B?QU8za1l1L2djQ2NWNzlBVnpaYWJkeDVheU9KbCtpcENkdTNQSDJHRFc1SzBZ?=
 =?utf-8?B?YzA5dnBrRnJBem5qajAyTWxheDBGYXhYdXI2dDRzYTFiRzdNaU1TcHdzc05G?=
 =?utf-8?B?YlpLbFUwVW1SUCt6dENXMTNvTloybzhFajh3QkF5UGRORms4UnRvVE8yNDJo?=
 =?utf-8?B?clV1Q0tVZWQyZWg4QzV1djlvMWFlaWthcHAvVS9GbUhUZ0xUQkk3TzhlRC9O?=
 =?utf-8?B?TXlIOUVXcEtQbkhqaGEvSWVuVFh6UVh4L01ObXJ5RzF5UGMxT0JvaUwyOFVo?=
 =?utf-8?B?U1Ird29aTldOQXAvNkpZYnIvclN6d0lPSE9mZmNBOU5WT0lOa2VKYnZ0RkdL?=
 =?utf-8?B?OVZXSUpRbkVXUlBRYzlCNmpqRHpablRrSmpzekpBeklRVmdFUkxFTDhSR24z?=
 =?utf-8?B?RkpOTlArU0wrMVFtT0Ria3NocjZGYUxGdTVUbWNpT2pEZEZGTGVjUGN3emFy?=
 =?utf-8?B?Vk0vZTBzZkQ2UFUwM0JydlVxRjFtb3FQVFhoT1RCU0ZRb3owaXNqaEdMakxl?=
 =?utf-8?B?MkN1Y0pZejlRdmtMK2NpZnh6eEJsbmp5YnN0NzUzVGJiS1NSQjhia0hlVEpQ?=
 =?utf-8?B?dmhiNGhscnFCdmxEbTBQYzhNbTVROE1ONFdTcnBHL1kxMVlua1ZPS2liaHBR?=
 =?utf-8?B?RzVJVUc3U0hELzUyOU5WYi95OEkrQkRUN3VnWjA3dnhrZnEyYkJkS09nTmMz?=
 =?utf-8?B?OUxIR29WeWFpN21Bc3VnN1NnZUZ0dUwrSWtkdTJUaDJmc2dYdWVza0NUQ05t?=
 =?utf-8?B?Z1VnRitGd0RPaHdZSXovY0g0Wm5ZQWZSUUMrczBqR3JBTWsyZDJLUklSc3Y4?=
 =?utf-8?B?ZEhnTG54YjhBWjE0UmZ2ZXM5Qy94WXZ5QmdWOFJFTmlwZ1hkZ1N6MTM0NDdR?=
 =?utf-8?B?TjBqd3ZQRFZvRkM5STJ5RS9xSE9mRkJib044OFE3RXVqV1Y5aGFYWnJEME1M?=
 =?utf-8?Q?ffXh6126LofB4=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffbbd50-7312-443a-7a57-08daff078034
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 19:08:10.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj6OZqcyYMReYA/je5QfNm5PRsIyoL78oBiUfd3Tw/t6jsv1eEEBdqZryEj8s27N180SCc28COXgZMF+aD9duw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
X-Proofpoint-GUID: YPMMiHeBdwRuhWy0ZNsFjqF2ZfKGfFmg
X-Proofpoint-ORIG-GUID: YPMMiHeBdwRuhWy0ZNsFjqF2ZfKGfFmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMjUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMS8yMS8yMDIzIDQ6MTQgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiANCj4g
PiBUaGlzIGJlY29tZXMgcmF0aGVyIG1vcmUgY29tcGxpY2F0ZWQgYmVjYXVzZSB0aGUgdXNlciBj
YW4gc2tpcCBjZXJ0YWluDQo+ID4gcG9ydCBpbiB0aGUgRFQuIFdlIGhhdmUgYWNjZXNzIHRvIHRo
ZSBob3N0IHJlZ2lzdGVycy4gQ2FuIHdlIGp1c3QNCj4gPiB0ZW1wb3JhcmlseSBtYXAgYW5kIGFj
Y2VzcyBIQ1NQQVJBTVMxIHRvIGdldCB0aGUgTUFYUE9SVFMgYW5kIGVhY2ggcG9ydA0KPiA+IGNh
cGFiaWxpdHkgYmVmb3JlIGhhbmRpbmcgY29udHJvbCBvdmVyIHRvIHRoZSB4SENJIGRyaXZlci4g
V2Ugd291bGQgYmUNCj4gPiBhYmxlIHRvIGdldCB0aGUgbnVtX3BvcnRzIGFuZCBudW1fc3NfcG9y
dHMgdGhlbi4NCj4gPiANCj4gPiBTaW1pbGFybHksIHRoZSB4aGNpIGRyaXZlciBkb2Vzbid0IGNh
cmUgd2hldGhlciB0aGUgdXNlciBza2lwcyBjZXJ0YWluDQo+ID4gcG9ydCBpbiB0aGUgRFQsIGl0
IG9ubHkgY2hlY2tzIGFuZCBvcGVyYXRlcyBiYXNlZCBvbiB0aGUgY2FwYWJpbGl0eQ0KPiA+IHJl
Z2lzdGVycy4NCj4gPiANCj4gPiBJZiB3ZSBoYXZlIHRoZSBleGFjdCBudW1fcG9ydHMgYW5kIG51
bV9zc19wb3J0cywgd2UgY2FuIGJlIHN1cmUgdGhlDQo+ID4gc2V0dGluZyB0byBHVVNCM1BJUEVD
VExuIGFuZCBHVVNCMlBIWUNGR24gYXJlIHZhbGlkLg0KPiA+IA0KPiANCj4gSGkgVGhpbmgsDQo+
IA0KPiAgIFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIElzIHRoZSBmb2xsb3dpbmcgZGlmZiAv
IGltcGxlbWVudGF0aW9uIGdvb2QNCj4gZW5vdWdoID8gSSBXYW50ZWQgdG8gZ2V0IGl0IGNsYXJp
ZmllZCBmcm9tIHVwc3RyZWFtIGFzIEkgYW0gdXNpbmcNCj4gKmlvcmVtYXAvaW91bm1hcCogZGly
ZWN0bHkgaW5zdGVhZCBvZiAqZGV2bV8qIEFQSSdzDQo+IA0KPiBJIHRlc3RlZCBpdCBhbmQgaXQg
d29ya3MgZmluZSBvbiBTQTgyOTVQLiBXaWxsIGRvIHNvbWUgZnVydGhlciB0ZXN0aW5nIG9uDQo+
IG90aGVyIGRldmljZXMgYXMgd2VsbC4NCj4gDQo+IA0KPiArc3RhdGljIGludCBkd2MzX3JlYWRf
cG9ydF9pbmZvKHN0cnVjdCBkd2MzICpkd2MsIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiArew0K
PiArICAgICAgIHZvaWQgX19pb21lbSAgICAgICAgICAgICpyZWdzOw0KPiArICAgICAgIHN0cnVj
dCByZXNvdXJjZSAgICAgICAgIGR3Y19yZXM7DQo+ICsgICAgICAgdW5zaWduZWQgaW50ICAgICAg
ICAgICAgaHdfbW9kZTsNCj4gKyAgICAgICB1MzIgICAgICAgICAgICAgICAgICAgICBvZmZzZXQ7
DQo+ICsgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgdGVtcDsNCj4gKyAgICAgICB1OCAg
ICAgICAgICAgICAgICAgICAgICBtYWpvcl9yZXZpc2lvbjsNCj4gKyAgICAgICB1OCAgICAgICAg
ICAgICAgICAgICAgICBtaW5vcl9yZXZpc2lvbjsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAg
ICAgICogUmVxdWVzdCBtZW1vcnkgcmVnaW9uIGluY2x1ZGluZyB4SENJIHJlZ3MsDQo+ICsgICAg
ICAgICogc2luY2UgaXQgaXMgbmVlZGVkIHRvIGdldCBwb3J0IGluZm8NCj4gKyAgICAgICAgKi8N
Cj4gKyAgICAgICBkd2NfcmVzID0gKnJlczsNCj4gKyAgICAgICBkd2NfcmVzLnN0YXJ0ICs9IDA7
DQo+ICsNCj4gKyAgICAgICByZWdzID0gaW9yZW1hcChkd2NfcmVzLnN0YXJ0LCByZXNvdXJjZV9z
aXplKCZkd2NfcmVzKSk7DQo+ICsgICAgICAgaWYgKElTX0VSUihyZWdzKSkgew0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIocmVncyk7DQo+ICsgICAgICAgfQ0KDQpXZSBkb24ndCBu
ZWVkIHRvIGlvcmVtYXAgdGhlIHdob2xlIHJlZ2lvbi4gSnVzdCBkbyBpdCBmb3INCnRoZSB4aGNp
X3Jlc291cmNlc1swXQ0KDQo+ICsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIElmIHRoZSBj
b250cm9sbGVyIGlzIG5vdCBob3N0LW9ubHksIHRoZW4gaXQgbXVzdCBiZSBhDQo+ICsgICAgICAg
ICogc2luZ2xlIHBvcnQgY29udHJvbGxlci4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICB0ZW1w
ID0gcmVhZGwocmVncyArIERXQzNfR0hXUEFSQU1TMCk7DQo+ICsgICAgICAgaHdfbW9kZSA9IERX
QzNfR0hXUEFSQU1TMF9NT0RFKHRlbXApOw0KPiArICAgICAgIGlmIChod19tb2RlICE9IERXQzNf
R0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCj4gKyAgICAgICAgICAgICAgIGR3Yy0+bnVtX3BvcnRz
ID0gMTsNCj4gKyAgICAgICAgICAgICAgIGR3Yy0+bnVtX3NzX3BvcnRzID0gMTsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiArICAgICAgIH0NCg0KVGhpcyBjaGVjayBzaG91bGQgYmUg
ZG9uZSBiZWZvcmUgd2UgZ2V0IGludG8gdGhpcyBmdW5jdGlvbi4NCg0KPiArDQo+ICsgICAgICAg
b2Zmc2V0ID0geGhjaV9maW5kX25leHRfZXh0X2NhcChyZWdzLCAwLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ICsg
ICAgICAgd2hpbGUgKG9mZnNldCkgew0KPiArICAgICAgICAgICAgICAgdGVtcCA9IHJlYWRsKHJl
Z3MgKyBvZmZzZXQpOw0KPiArICAgICAgICAgICAgICAgbWFqb3JfcmV2aXNpb24gPSBYSENJX0VY
VF9QT1JUX01BSk9SKHRlbXApOzsNCj4gKyAgICAgICAgICAgICAgIG1pbm9yX3JldmlzaW9uID0g
WEhDSV9FWFRfUE9SVF9NSU5PUih0ZW1wKTsNCg0KV2UgcHJvYmFibHkgZG9uJ3QgbmVlZCBtaW5v
ciByZXZpc2lvbi4NCg0KPiArDQo+ICsgICAgICAgICAgICAgICB0ZW1wID0gcmVhZGwocmVncyAr
IG9mZnNldCArIDB4MDgpOw0KPiArICAgICAgICAgICAgICAgaWYgKG1ham9yX3JldmlzaW9uID09
IDB4MDMpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZHdjLT5udW1fc3NfcG9ydHMgKz0g
WEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAo
bWFqb3JfcmV2aXNpb24gPD0gMHgwMikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBkd2Mt
Pm51bV9wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5UKHRlbXApOw0KPiArICAgICAgICAgICAg
ICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycihkd2MtPmRldiwg
InJldmlzaW9uIGdvbmUgd3JvbmdcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgICAg
b2Zmc2V0ID0geGhjaV9maW5kX25leHRfZXh0X2NhcChyZWdzLCBvZmZzZXQsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFhIQ0lfRVhUX0NBUFNfUFJP
VE9DT0wpOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHRlbXAgPSByZWFkbChyZWdzICsg
RFdDM19YSENJX0hDU1BBUkFNUzFfT0ZGU0VUKTsNCj4gKyAgICAgICBpZiAoSENTX01BWF9QT1JU
Uyh0ZW1wKSAhPSAoZHdjLT5udW1fc3NfcG9ydHMgKyBkd2MtPm51bV9wb3J0cykpIHsNCj4gKyAg
ICAgICAgICAgICAgIGRldl9lcnIoZHdjLT5kZXYsICJpbmNvbnNpc3RlbmN5IGluIHBvcnQgaW5m
b1xuIik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICAgICB9DQo+
ICsNCj4gKyAgICAgICBkZXZfaW5mbyhkd2MtPmRldiwgIm51bV9wb3J0czogJWQsIG51bV9zc19w
b3J0czogJWRcbiIsDQo+IGR3Yy0+bnVtX3BvcnRzLCBkd2MtPm51bV9zc19wb3J0cyk7DQo+ICsg
ICAgICAgaW91bm1hcChyZWdzKTsNCg0KTWFrZSBzdXJlIHRvIGlvdW5tYXAgb24gYWxsIHRoZSBl
YXJseSByZXR1cm4vZXJyb3IgY2FzZXMuDQoNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAgICAgICAgICAgKmRldiA9ICZwZGV2LT5k
ZXY7DQo+IEBAIC0xOTEyLDYgKzE5NjQsMTAgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgZHdjLT54aGNpX3Jlc291cmNlc1sw
XS5mbGFncyA9IHJlcy0+ZmxhZ3M7DQo+ICAgICAgICAgZHdjLT54aGNpX3Jlc291cmNlc1swXS5u
YW1lID0gcmVzLT5uYW1lOw0KPiANCj4gKyAgICAgICByZXQgPSBkd2MzX3JlYWRfcG9ydF9pbmZv
KGR3YywgcmVzKTsNCg0KVGhpcyBzaG91bGQgYmUgY2FsbGVkIGFmdGVyIHNvbWUgaW5pdGlhbGl6
YXRpb25zIHRvIG1ha2Ugc3VyZSBzb21lDQpjbG9ja3MgYXJlIGVuYWJsZWQuIE90aGVyd2lzZSBz
b21lIGRldmljZXMgbWF5IG5vdCBhYmxlIHRvIGFjY2VzcyB0aGUNCnJlZ2lzdGVycy4gUHJlZmVy
YWJseSBhZnRlciBkd2MzX2NhY2hlX2h3cGFyYW1zKCkgYnV0IGJlZm9yZQ0KZHdjM19jb3JlX2lu
aXQoKS4NCg0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiArDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBSZXF1ZXN0IG1lbW9yeSByZWdpb24g
YnV0IGV4Y2x1ZGUgeEhDSSByZWdzLA0KPiAgICAgICAgICAqIHNpbmNlIGl0IHdpbGwgYmUgcmVx
dWVzdGVkIGJ5IHRoZSB4aGNpLXBsYXQgZHJpdmVyLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAyZjgyZWRh
OWQ0NGYuLjg1MzU0MjViODFkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTM4LDYgKzM4LDkgQEAN
Cj4gIC8qIE51bWVyIG9mIHBvcnRzIHN1cHBvcnRlZCBieSBhIG11bHRpcG9ydCBjb250cm9sbGVy
ICovDQo+ICAjZGVmaW5lIE1BWF9QT1JUU19TVVBQT1JURUQgICAgNA0KPiANCj4gKy8qIFhIQ0kg
UmVnIGNvbnN0YW50cyAqLw0KPiArI2RlZmluZSBEV0MzX1hIQ0lfSENTUEFSQU1TMV9PRkZTRVQg
ICAgMHgwNA0KDQpDaGFuZ2UgdG8gRFdDM19YSENJX0hDU1BBUkFNUzENCg0KPiArDQo+ICAvKiBH
bG9iYWwgY29uc3RhbnRzICovDQo+ICAjZGVmaW5lIERXQzNfUFVMTF9VUF9USU1FT1VUICAgNTAw
ICAgICAvKiBtcyAqLw0KPiAgI2RlZmluZSBEV0MzX0JPVU5DRV9TSVpFICAgICAgIDEwMjQgICAg
Lyogc2l6ZSBvZiBhIHN1cGVyc3BlZWQgYnVsayAqLw0KPiANCj4gDQo+IA0KPiBQbGVhc2UgbGV0
IG1lIGtub3cgaWYgdGhpcyB3b3VsZCBiZSBhY2NlcHRhYmxlLg0KPiANCg0KSXQgbG9va3MgZmlu
ZSB0byBtZS4gUGxlYXNlIHJldmlldyB0aGUgY29tbWVudHMgYW5kIHJlbW1vdmUgZGVidWcNCnBy
aW50cyBhbmQgYW55IG90aGVyIGNsZWFudXAgZm9yIGEgcHJvcGVyIHBhdGNoLg0KDQpUaGFua3Ms
DQpUaGluaA==
