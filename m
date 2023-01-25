Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB367BFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjAYW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAYW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:28:31 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318B40E7;
        Wed, 25 Jan 2023 14:28:30 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKRqdv027943;
        Wed, 25 Jan 2023 14:28:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=AzXdbElpwjzLmAXlvgHwVtGzKEf8jY642pkJ1t418kc=;
 b=Q6MUk3IMtfC/fP8/9J5t1YAjH4WOQb/E6XIxs4pMS9orXdscy8e7g6YNkBvNeuAxrZYO
 exA+0/cR9c2aWdrsRJrU2DqqI4Cz318G3BVp3o+XHh38GgVYxLbzr3F8Y9q4sFgMviUc
 yXVyFficsLtMCmh17DlADSvnM5iJFQwWje6UPjkKev1bknZRmcWgnGuXKHgTTe+ZpQjR
 wjnErJvj5aZjzMBbzQKA2d8hQeatXylYYZBdzIcG7Y/PyxxvUZ3iMY2jgu11QmD3RK/l
 omcF7XYEIAYjL47dqhOdWbaXfHIjKQFI2BL+RgdTKRbfWIK8wFstc02UjI5mxUDZH9hy hA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n8fxrt1up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:28:07 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BDD6F400F0;
        Wed, 25 Jan 2023 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674685680; bh=AzXdbElpwjzLmAXlvgHwVtGzKEf8jY642pkJ1t418kc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jn8QWNL+/VkqZ5tQCl+lOpJeMV+Eqd9q//U0G/zY8u23hWcT2khRNx8rMTpLGQzwf
         Kq6XU463GbVHe97VbExp6bXVJ4Hw50woSwqhvk7azBxcQ0Qptc1pRqShwtTMeljgCm
         VR9cpfvm21KWB1QIlYnRaj4lqx/QpvUmXgGFangmH8SBwzjVndmYE/VkYnxsC6lhc5
         dpRA/Dsjcm47vnCr7SofH3AWsUCMgfc6kweGow2D5asGO8bcpvTUCRzZkCX/TixuUq
         h20c25z5svV8c6RHdVgeyJvUQ2JkWgdky7SfjXsZh9O20K3fwUfoRmCKZQSAFFbEO0
         hUdM2GG+WEZHQ==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 19FE2A005C;
        Wed, 25 Jan 2023 22:27:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F288640A66;
        Wed, 25 Jan 2023 22:27:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="DxJNnzEX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH65SP26FRThTE9X73PemVEPcEKkSiItaXTINRjanj3aGXYrDngy9wc7hFeFwhBGytVdDXi5oURwz60WHesdY/H4Cjhi499DA9sp3aNDWuZBtKSXU9VcZpHWt8BK99bLDcoEhAaup4f+MAwR4a2XVg+ecBIGDscHlAkVA7yHXY07kpsdB/tAl7VLRdoujrneCTfGMJUGSKiQ7MhZ2c5kKi/cYrgganPUnoqr2DofQ8zLOlq59Iax7jQBbZJIjHC+ucyqHhuxZSgmkQQP96fBhcwh8Ec39QmNndiP7PEH993zG5XwkEfyDoXVqLC3SubIbLSerYNnAbvD+pVonnaPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzXdbElpwjzLmAXlvgHwVtGzKEf8jY642pkJ1t418kc=;
 b=MvMXmMa/MfLmViITrmnL5ddLXti2tvkRcT0IMp8kg7Z1LWlT27A2D5wDeygw5Kyc887sDxzx0SfQMBMNajEUVEm7IEJMWIl1TIU6elihuA6Nrvas6ru1fznKpBvLoIe6m66QNys7pNsmczWO7hgHqomERBlFu8betQSyhcqUaXqc3w25UWzIyd3bz73Ststit0iaj8ULau1pBtKAPSpbZEZn8jcfDCxmSn/XiFz6Vlf/iyv2TSbkqYW5RC5r3YTBjwKEJqXiVYv+m8MJPs61L/P4070N8vhofXmruqLbHneHlV4tdTqS++8J5xLPAlMy8RuYQCbeAKTK1ngxclNAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzXdbElpwjzLmAXlvgHwVtGzKEf8jY642pkJ1t418kc=;
 b=DxJNnzEXpe4lBfHqFdsuiS/PqcQQfB7mjsWnRNSQ1Iuny4e5NqBau+FLbMNx2vKJENwjsxdnLdTv+3JywTIFk6GKuSRkxjoFb2s5W++XPq/L9vwEq9KariG+0dKMOezhg9/HBEzL1g+1B9YgQVNCYJ+/Rn0J68XukgvZbv6iEnA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:27:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 22:27:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jack Pham <quic_jackp@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
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
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAAojICAAXEUAIAADDCAgAFfeACABwg/AIAAlxWAgAAcP4CAABuSgA==
Date:   Wed, 25 Jan 2023 22:27:51 +0000
Message-ID: <20230125222751.qfaikiiwr2m73ihu@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
 <20230120010226.wjwtisj4id6frirl@synopsys.com>
 <91fa86d8-f443-db13-1544-73e2dd50d964@quicinc.com>
 <20230120224400.77t2j3qtcdfqwt5s@synopsys.com>
 <0d9eab77-ad5f-be23-8ed6-d78c0d3ccef1@quicinc.com>
 <20230125190805.l7yo5lls7gfhoo4b@synopsys.com>
 <20230125204911.GA2657@jackp-linux.qualcomm.com>
In-Reply-To: <20230125204911.GA2657@jackp-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8575:EE_
x-ms-office365-filtering-correlation-id: 13e99e92-668b-4ccc-b4be-08daff236540
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aly2Vd9P6W4AAPvmWDXoJbMd5IwNHMWZZG8ORDUytw9gaWmn7f81uQC82IoKWdS/vFu1iVNmkVvvYCYpSlmuQt2ljH08xvI4LRzMGW62ZKCnAm4UI6jRzuCssRwrBYlb7Cq+wonTpM8gCN6dJ6z1ssJ8lut9oH2MN7WDPFWfRF3upm+x4aw9uDQ6tp5J1Ni8CX2ENczkM7zoocvyM0QdoCmvRYm5n242ZiW3VkDJ/znCQWDKgG/RRFWknPxu5CelfDflEuC+3w0ddW9xkKyyIs4FVGw2VqRuCR4L7cSzcVODyO0Jy3OSEwGdb78XY9J+cHQjcOJO9M31mPe04dlmmnkEEAJKF9JxMQ2ets7bY3P15tyTFiGtUexi0qR3xuuSohP66/V3KA37epliXhm6peh7bMPeUpmAV4CfvWUcVdb7sZENQ9vkS0GE2Ah1WWAl6e2Bh3aG0pdlMwIVsEOHYklMJTwMswqQM0T6bqVtkoNrB5OWjnJjNrSpZMPcljQ+jjG7zBwW0GLq51zs4N9mFivMEWSaAFgAB3CPGsF6W3Xuf34ZiZHXSQgXdXYN7lGsEY2eeNr21BkORWVULKAu0ftkLilDfnZAttApse1huFPwq1pUG8Wnaxm4bdVPw6obHnFDBnLOblmNSYqtXZW9yn9SSmEdXUO5iPn2n85j85hCU9ZGQGUxTm0LtlyeXbJk9nIY+9qhxvbanSVLj4U8ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(86362001)(478600001)(71200400001)(316002)(66446008)(54906003)(5660300002)(2906002)(6486002)(6916009)(8936002)(66946007)(64756008)(66476007)(66556008)(4744005)(7416002)(76116006)(4326008)(6506007)(122000001)(38100700002)(1076003)(6512007)(36756003)(38070700005)(2616005)(186003)(8676002)(26005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJ1UitYd0NyYUk3L0RlSHpDcU0wVjd5Q3RWWVl4UDhORG5LZWZUbERiL2V0?=
 =?utf-8?B?Y2F1RjB3YjROOFVDL3ZERkZxdnhjVVlGSTAzU1NUdC9Ic1FJRXZLb1EyMXgv?=
 =?utf-8?B?UTJPZFNUcExVckx0bzN3SmZMZXNCUEVZZVRKeWFWZld1YlNPMXNQTVBxbW4x?=
 =?utf-8?B?cUIyZXU3di93aXVNK3ZwZUZUdml3b2lJUHRHSDk5RlBXcDFsNmVYQ2RobjhU?=
 =?utf-8?B?bzdPaVY2ZWU2VWhmUDB2WWVvbUVPanVpRnFsakdvNm1xOVVlZ1k1ZDU4c0xh?=
 =?utf-8?B?eEk3Wjc4N2NwU3dEMzhJK0RmTkpFenBXVXdmZWRyN0JjdGJ2N1BtZUJ1RTFx?=
 =?utf-8?B?QnJBMmJkUG5EbVVsMlIzclVycW5tNk5ISFpNeDVSYWJFaEsvTVpJZlBMTStV?=
 =?utf-8?B?Qi9ETjJpYWtlOE8yL2RmWnFyeUJXODBia0xjSVIyenRzb0V1NkJPb3YvbUor?=
 =?utf-8?B?dmNUbkcrUm1ZaWRaM1ZKUHAwWERNSXdQVWM3Z1BSeFM3eDdEU2hHU1RkVkhy?=
 =?utf-8?B?YTVyaEF5QWQ4dUJqdUxPeDJoTCtkdmRPY2N5YVErMmd1aW1BaHBzN3I3OWY4?=
 =?utf-8?B?UVlndXJLMFE4UU1lczBPbjV2UUZhQ3FKL09OTzE4bTlaU3piZlpOWG53SG9L?=
 =?utf-8?B?TXo3YUZOQWh3d0E3bk1ob3JHaENDcGdCa3hWT2YyZmVCT3UrNHl4cC9ibklS?=
 =?utf-8?B?OWVUWURHOVVCUUFjNHlPNWNobXR0UzJPWDVVVmZYM09aYm1oRGVGQ2laaHNl?=
 =?utf-8?B?bmluNHJWWnNReFlRM2U4a0NmelJsS1BsSDBvOUxYTmNjSzdFS0t3bVlpQnc4?=
 =?utf-8?B?U0twV0R3dWRlbHdnVzFiVDVrK0FqU0JLVi9ueHpVemNmeGxocjJmVDVZTk9X?=
 =?utf-8?B?dEs1bG5tZHRtcXZWNXlQSlRkSnBuSXUydCtUNFBzQjhKaXdvREpXS2FHVURQ?=
 =?utf-8?B?d0xaQXUySityWTJrWXRkNm1jMUxZcVpHdm5nVDJhOEZrWDBKVE9QTWxyL2Zo?=
 =?utf-8?B?SFVEVlp3K2NncFVCRlVHYzNCRFp2ZWZwNk4zN1JXTDlaOEsxa1BIdmVTWGZo?=
 =?utf-8?B?dk5UOVlVM2VITnBLVU1DZ2VjOUNrTjg0M3RQMm1wc21Pb1VmTlNnTXZ4WHZ0?=
 =?utf-8?B?VU40VTJiZnlzMnpHQkRtU3FSSUJtUVpUQXlDOTJmNVV2M0hwQUNNS3VNU0xh?=
 =?utf-8?B?aXI4TDlVcXArVXIvcEZKUnBWRVRiRTdaTjVyTWQ2ZXk0dDFQZDhyU29aSXp5?=
 =?utf-8?B?SXNncXBjdnVzRUoyWU9YbkpFQWpaZFFab2YwRjUyTkRQdXFNYTZXRVFpRll0?=
 =?utf-8?B?SE1hdUdvbkpMTmZFNWNjTHRGc0VSYUVtSHp0NFYxQzdxK3dXNHZhTnEvRkZa?=
 =?utf-8?B?bTBaeWU3M0JTYVprOHhwc2JOdXNXa1ZvSHNtV2piSEpHZGxRWVgvOVhJZUxN?=
 =?utf-8?B?ZW5YbElWK1B0Q2xkT0REQVNONXVzWWdEL3ZMUUV2QU5wcFJSV2Z3MVFwLy9n?=
 =?utf-8?B?Q3dQcXlQaVZ5bGJzazB6allTZXgycFF0VkhzWFM2OTgxTnJFMG9nc1NoL1BZ?=
 =?utf-8?B?YkY3azJabDVMbTliZWNEUEdaYjBiTWtObFpwMXlob1c1cUZlcXFiY2xtRno4?=
 =?utf-8?B?RGV3QzlJTTNxVS9JZE5iOEFOLzJxNEZrQm8wRVhEQVZQcDN3L1M4cDdFTlJZ?=
 =?utf-8?B?eTF6Q3ZuVmFpbXl2VEcxdzZFMmVrelRQT3lHZjFJTE43R1UzWCtOYnp1cks4?=
 =?utf-8?B?QlNFT1Y2bDhZVkZuWXdxdlBNZldRSDdwYkVjWWJsQVE2NlBHZU84Qm1yQXR1?=
 =?utf-8?B?cUVDcVhLeHJhbEh1M2ZLdURHU1N6TEN3eVJpV2ZQS092RzRabWIwSzd5RHZz?=
 =?utf-8?B?dGEyOVIxa0trTlNLcVZtZTd2N0ozanUzYVpUb3hscjFST3BvSU83UXh2MmdX?=
 =?utf-8?B?UWNYWVlhTWgvMGRwYkNVYnJnLzFGdUVuOHk1YWo0SlhNckZSN2lyam1CSW5E?=
 =?utf-8?B?WkwySnFXcktDdGp6WWl5VDFPZEZhQkFGVWRaVk1Xb3RhVGQwQ2IvRm1ieG9Q?=
 =?utf-8?B?aUliaDlwZTZpYjFDL0dTWXdadTVCcDdRQjNieVVhRHRTWUdaeDdVU3ZRaEJG?=
 =?utf-8?B?dUpOSzhVZTE1VHpzT1gxcXVUMHh3NlR2Y2NWdVpQeTFSNndOblAvTVZqS0xV?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D0FB9ECBA46943A32E5DC53350DEE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MEZKam14YWZnZlFQUUpML0ZUS1FnTzZNRFg3eXo3cWQ0WmRjN0dBWkJqdFZk?=
 =?utf-8?B?UTJFMEE4ZEN0dmR1ODVuRGF6ZlJwQkNjR04yUkhzTy9zd1UwbVY2SVcvVUM1?=
 =?utf-8?B?WTdvLzRtdTJDSEVCVHlraTU1ZjBUaWNpSGN5VVpIL2FzcTR1aEZjNmh3Zkh1?=
 =?utf-8?B?cEg0RHNTOHVBVkp6ZGpTWW4rb1pPTHZlckgvWm80VXVGNmduZ3VkUmdXNHpH?=
 =?utf-8?B?RklPV0dNNkVpWVJ6K0tWWnRCRW0zcUlQaEI2TWt1MU5LUDVnQXBQSHNOam1O?=
 =?utf-8?B?Q25neU9HQzVWQ3FvYnlQTTkzc2FwbmVkV3JHb3ViVWhJSUp1UFJERmg0UStt?=
 =?utf-8?B?MUtKT200M0lDNWFRamVkaWllNFEzVUFaclBjUEx5aTRUMk43THRoNFl2KzZD?=
 =?utf-8?B?TFhlSDNOcFZNdFFYc2M3QW0zWGllcWtVWnMvOEdRbXJRcXpVNm0zdUFVaWlP?=
 =?utf-8?B?MlFlUGJHMWpBbTZUNFFhMzFYNzdoQnU3SmErdm1Uc2pwdWkyNWlaR3hjNlVC?=
 =?utf-8?B?MThYUFI5WVNlOCswUUhaZ3FNazZyZ3QyajRad2tRaVpMdFRnSDBGQnF2dVBx?=
 =?utf-8?B?U05QM0FVYW9YWWlHRmpxd210VXQyVFdOUlhyOWcyeFFwTG9UYWx0dnhEQ3Az?=
 =?utf-8?B?cFJPQXhNYU8vUGFTTUxKeFZZSmRtMk9RN0hScDhNdkVmNGN2b3FwcTJmUmNn?=
 =?utf-8?B?Vkg3VVhQVUV4cnJQeE9IS05aS3FpMmErWm1LTjJtQVhLdjZRSUx1KzhMZ1Vv?=
 =?utf-8?B?U1FoZ0RLUG40QlB1QWg5QmJKbkRtQ0RpSnQydGhSY1FMZjM4SGdObGJnL3ps?=
 =?utf-8?B?bFN5NzVGMjBBSE9wQnc0YkpUN3RnNytDYUlUR3Nyd2pyVkZocmtJRlM0Q3Vx?=
 =?utf-8?B?TS9RTlkrK1ZPK2h6aGZxdHVXdnlzeFJHbHY1R0Q2eDFjNHBSQW5jMEh3YllI?=
 =?utf-8?B?LytoTFhZYW10MmhyalpJU2J0NFdBY0gza2FzTUxGUzArZG1IcUF3Mis5bTVX?=
 =?utf-8?B?UDhuRTVaRmYwSndZZFJSY1AyYXpOUFRkRTZFZFFzQlRpQWJMUDA4d0xVbWM0?=
 =?utf-8?B?d2dQa1RoajJvVjVIeHhXbjVobWZZUzNVb0g3ZFZNQkFlQ1JTRU1IZXBQWERV?=
 =?utf-8?B?bnZwVC9aM0tBWGJVQ3BwTW9LRGMxWnYvOTlIaENWK3BXa05ySzVlM0JuU2pH?=
 =?utf-8?B?OFV5Q0xWYWxYVnlpVDJuMTdUbHNmbGdUbUxkYXA3SUpudmlFejY1emZ0TkRj?=
 =?utf-8?B?dXhRRkY0RWRLRkhVMkt6a2hBUzdaR29OcEZHRlhXVWpXOXY2NmtEbTllY2RX?=
 =?utf-8?Q?56eNdZ6uljCfE=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e99e92-668b-4ccc-b4be-08daff236540
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 22:27:51.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXtD4WWYgc6H7PDnpRnFbP9MBd+NoYtSEIOibI67mjMp3RRavHaGL8yUSkcQX1HpbKaLgGeG6Htx05isJLla6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-Proofpoint-GUID: qRCjeK6ORByfZigssu_g8zYgzi8ECiah
X-Proofpoint-ORIG-GUID: qRCjeK6ORByfZigssu_g8zYgzi8ECiah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=848 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMjUsIDIwMjMsIEphY2sgUGhhbSB3cm90ZToNCj4gT24gV2VkLCBKYW4gMjUs
IDIwMjMgYXQgMDc6MDg6MTBQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiANCj4gPHNu
aXA+DQo+IA0KPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gKyAgICAgICAgKiBJZiB0aGUgY29udHJv
bGxlciBpcyBub3QgaG9zdC1vbmx5LCB0aGVuIGl0IG11c3QgYmUgYQ0KPiA+ID4gKyAgICAgICAg
KiBzaW5nbGUgcG9ydCBjb250cm9sbGVyLg0KPiA+ID4gKyAgICAgICAgKi8NCj4gDQo+IFRoaW5o
LCBpcyB0aGlzIGEgY29ycmVjdCBhc3N1bXB0aW9uPyAgSXMgaXQgcG9zc2libGUgZm9yIHRoZSBJ
UCB0byBiZQ0KPiBzeW50aGVzaXplZCB0byBzdXBwb3J0IGJvdGggZHVhbC1yb2xlIGFuZCBtdWx0
aXBsZSBwb3J0cz8gIFdlIGtub3cgdGhhdA0KPiB3aGVuIG9wZXJhdGluZyBpbiBkZXZpY2UgbW9k
ZSBvbmx5IHRoZSBmaXJzdCBwb3J0IGNhbiBiZSB1c2VkIGJ1dCB0aGUNCj4gYWRkaXRpb25hbCBw
b3J0cyB3b3VsZCBiZSB1c2FibGUgd2hlbiBpbiBob3N0Lg0KPiANCg0KWWVzLiBNYXliZSB3ZSBz
aG91bGQgcmVwaHJhc2UgaXQgYSBiaXQuIFBlcmhhcHMgc29tZXRoaW5nIGxpa2UgdGhpczoNCiJD
dXJyZW50bHksIG9ubHkgaG9zdCBtb2RlIHN1cHBvcnRzIG11bHRpLXBvcnQiDQoNCkluIGNhc2Ug
dGhpcyBtYXkgY2hhbmdlIGluIHRoZSBmdXR1cmUuDQoNCkJSLA0KVGhpbmgNCg0KDQo+IA0KPiA+
ID4gKyAgICAgICB0ZW1wID0gcmVhZGwocmVncyArIERXQzNfR0hXUEFSQU1TMCk7DQo+ID4gPiAr
ICAgICAgIGh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERSh0ZW1wKTsNCj4gPiA+ICsgICAg
ICAgaWYgKGh3X21vZGUgIT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkgew0KPiA+ID4gKyAg
ICAgICAgICAgICAgIGR3Yy0+bnVtX3BvcnRzID0gMTsNCj4gPiA+ICsgICAgICAgICAgICAgICBk
d2MtPm51bV9zc19wb3J0cyA9IDE7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ID4gPiArICAgICAgIH0NCj4gPiANCj4gPiBUaGlzIGNoZWNrIHNob3VsZCBiZSBkb25lIGJlZm9y
ZSB3ZSBnZXQgaW50byB0aGlzIGZ1bmN0aW9uLg==
