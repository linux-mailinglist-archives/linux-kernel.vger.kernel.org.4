Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA416DCEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDKBOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDKBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:13:56 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA72722;
        Mon, 10 Apr 2023 18:13:52 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJ5juf011782;
        Mon, 10 Apr 2023 18:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rCCpQVftqOIcVHilJiIDb8jfxB5u885W0tBRxRX0pjM=;
 b=h01QIFH6Tr7EkZgMkFfeaidLcgeyKd9NcmRimqZrYnErIBELM700HyGTejfviVbbT+aC
 Svde6Lgk8YiJvgZnFCI7f6EOzlu/8V5c4DXXyTQK5SvLzcqVJ0ejP/HHzrLBUsCXdpBC
 k9mp/e4BWTAYZLuRaalVOh2v4hWVoyoMEXAjazSImAVO3QD/+vY4reNe9Pfsdh/A8h9k
 1Vfaag8yq4vBHJu3zeC7N26ywQWn/0pIQR0IjgNgOCo67gi47w2bt0NynkUC7oqqPRfS
 KruWdvkD3dyUKjq1xRNeLVSvvVKk1v7wlFJrQQDKOHNbK+foflTA0PeK7qkAEo208/kS ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu76vu754-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:13:49 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E456FC00F7;
        Tue, 11 Apr 2023 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681175628; bh=rCCpQVftqOIcVHilJiIDb8jfxB5u885W0tBRxRX0pjM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QE883clc1kJCWqDBUXE+09fS4PFfTfcTmX5V/pOu86RCBPryiq3sygSYnwIDOVxXt
         dch/C7qMwAlRSV4o0yd0NpEmwvGhtSSsVXnYWATAzCtoQV9/P2SqqoU/94vylBp7/9
         gwP35ZRvlH89bWL0q/UNbeDcmfPE0Tb4psY7D/pbP2sxv+c0z1ks/SICFj5PoB1D6+
         EIDw97UIyNU9O2swvN1w1jhDJ3cn2hrwPO3LtjVBZezSNte+56+7Q6mlFwXLoObr9Q
         m7SzkLM6Oik2/LTBmCTGxaS7m31rNThJpwKEguUrc8NNuSQB6g2UOVcSOmlPZ+HFtk
         JEvhi1h+FGcMQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 360F9A005A;
        Tue, 11 Apr 2023 01:13:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4995040074;
        Tue, 11 Apr 2023 01:13:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="P3Gt0/X2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ickyZcS4118wxBVOiJbeyoWEhwLVdrNK6ZjnpryjEshG3qGChDolaRw6knUlcAlAYPKLhceifWbPUUK2MV8vmYrmdWK1qK8anqjXc6cuYIg0MuKYyUMt9/FEoK8OXd8mSN960qhgDzCfx5lVNjcHFqF6selgTXgkvKYaShIIxGTmZjkbTnfNlgBvznD6fAECHxgYcrvGeBg1PmBxDSsKokIyMeZFPvgO0xDCC20Xupxv7r6cHDaQ2F9Xpw9XkiDeFbwzmmQCE8qHSQ4jia2Jr4THupQcQMyiPv7/YO7n3o5G4+sfnVF/WpvZPeSCzEKIr58ukh2dWs/x3ap7cxZV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCCpQVftqOIcVHilJiIDb8jfxB5u885W0tBRxRX0pjM=;
 b=EVeVH5seJ+p9xUugiMWsSJZDPop+t9spezA8FTxnpngQchqfi24nba9BWmcgBCgG1FSRfM6LvVgz2Let4mF2+w9SljxHLa93UP5L/GD/jdOPUOalY4VqUGvFfuaJWADuNOy6juCBhKGNzONXmWm5HCTTnBiFAgmxY+aESpAWH69EyrekjGYCR6MUP1g+6zIHJIcekK0HbxKTnnVZdODzau26ossG2f78gSw4sWfDeT3jG0zHOv181/om4FklxOO4bALVwXrWHpSGihVQ8Knl9HhhOkvPBhk2xGMltUsVmCbyFb/SctDI3CoU94PDLnBJtTtPrh8yrdHiuhLBkm5p4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCCpQVftqOIcVHilJiIDb8jfxB5u885W0tBRxRX0pjM=;
 b=P3Gt0/X2IJkv7KEhIiFSdukjh2zs4f6K5MV3GgW2945+6FRDEHyZ70cRfo3DkvIfWeRA6El6R4gu0S6+oMJ44b35Xj+KoCny6XxFcuJ5Xtle+P1L7TJPW76E63DaBSwNHH++TQuMM8/hnJretSWJk/AuWXHKN5QHNFDCHFWGbrI=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:13:43 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf%6]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 01:13:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: gadget: Stall and restart EP0 if host
 is unresponsive
Thread-Topic: [PATCH v3 2/3] usb: dwc3: gadget: Stall and restart EP0 if host
 is unresponsive
Thread-Index: AQHZbAMBF6gC4jluqkCzo7SRoEyGIq8lTa0A
Date:   Tue, 11 Apr 2023 01:13:43 +0000
Message-ID: <20230411011340.6qrx3gcr67cq3fi5@synopsys.com>
References: <20230410231954.437-1-quic_wcheng@quicinc.com>
 <20230410231954.437-3-quic_wcheng@quicinc.com>
In-Reply-To: <20230410231954.437-3-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|MN2PR12MB4439:EE_
x-ms-office365-filtering-correlation-id: 270619a9-12d3-4299-071b-08db3a29fe55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/8Zt1Q4QEnj2jYE9rP3S3EKWLy/LYqo9C1mc42zeSf51wV7s40J9QCxJAXgHp1JPOfCgXxEnKmFsOQ4gKF7gAEzUCGesYxO/BzyxfD6DidnfpXMBX566sl4Hqyc4pav/obheyNm7u5OUTTTi76IHYVFPYt/oRMPAO2f619MvTqOUkdirLhULmzKcaXfAw92PXj6bRcNr/GI4fGLHZQavhoryqGqWg/nJGCrZgGVkzLXIRm6uBChl3XS5gnfQS+qTVjlAd4Li8oJ2pUqIxEr3MGxNQLA1NdKiKLJPSTlX779SCGIf+GR8umVg1UOwGrB8TksGUmXQAIL5alyqKs/nMGjP2Ukp1DXDznxDdB+gN0uwZGFvoLMWueCS/FiPXbVs+ECamm3lD9h6oakoM6qGX0IfeO5GSkeOFuWX1Tlczu2OlJI+bVOEBcrMJ++Wh8DQVgGwhOQQnAh4rJC3XcVHG7pQSCew+EmA2KX73tlD3ImKzCqdxoPTBJVz+frP9JKOqRJ97coTOPVHa9AuV9UiuUBZJf7wOTis0gMD0Q5dO9zIOMQo8HNAG6gN6W+D5HL8aJP1+S7J5NhPv3R0EVwLD4pclqDHan//m0soZiPUseXBKsBhnZLT7mICfGtJwMF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(2906002)(122000001)(71200400001)(86362001)(83380400001)(6512007)(6506007)(26005)(38100700002)(186003)(1076003)(2616005)(316002)(38070700005)(5660300002)(54906003)(8936002)(41300700001)(6486002)(91956017)(36756003)(478600001)(66946007)(4326008)(64756008)(66446008)(66476007)(8676002)(66556008)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkYrQkpIaWRzY2ZScHRLM1U5VGlJRTZubERxRlViOGNaMncvM1REY09VSkk1?=
 =?utf-8?B?bXNGdi81akFyNFpJaTJmR3JQbTJOR1RlTzJ6dVU1RHFyU1NkanMyRFVXSkhJ?=
 =?utf-8?B?bVZBTFFxV3hjc1FBRWg5Uy9CY1dURlU4S24vNUdsTGZ2N1I5UmtOMTl3OWkr?=
 =?utf-8?B?NktoRkF2U2lza0ZhUTNLSTIwcEFqZWRkbVkvcmxpNlZHdWNUVTJNT1dJU2Ri?=
 =?utf-8?B?bTdNWkY4WjFHZ0ZjNzUvaGZMK1prRVFlOCtwME1WQVF2a0xXNTlyaWlEVU96?=
 =?utf-8?B?czZPcHdUUkg4Y1JHNEEyaW1WVjViOTNvWjc0a0swQXhMN0JtTkF1cFAyV3hE?=
 =?utf-8?B?eVM1OEtEUU9NM2hWRnJOT3IvQVZXL2dvYk04d2swM1crZEQrWnpadStpRXNh?=
 =?utf-8?B?d0RhSG1oYVNNSFZzSm9sditTN0s4VERuVGwyNExNZlpUMDBTaXNPUXJGM1ZU?=
 =?utf-8?B?Z0Eya3JzcTBpNy9Oc2t2S1I0YlkxckJTZ2ZvVWE4Tk5nK2xLdVlzNmtJMjMv?=
 =?utf-8?B?anpRcWZ0d2pSWU5xcW9RMklXd21yNUZBT0N1NlBUQXkxY2QxTHRLRzV4TW9C?=
 =?utf-8?B?RWFYekRUVGpuTG1ZMUtVZmU5ZG5FYktZWE85M05CdzV5d2V0YjJvSEhLRW5L?=
 =?utf-8?B?RVkvZzgvTFE1T2RCRDZwdW1GU2dwMXFtSmszMDg4T3BHeW13Tm5hb2JMMjA4?=
 =?utf-8?B?U0pBdlZZRGRVaUFBV1pFTkhXa0NHbjREKzBkNHVxM0lDMitEdk9lMW9XcHZ2?=
 =?utf-8?B?VGNkVU5NWXNRTTNsZHl2V1d6KzVjRUVvTmJTVjQxSnBVN2hTQk5wVC93MTdU?=
 =?utf-8?B?dFB1ZVJuUXRQTVlCMGNwWWJMc2YybG9JVWlSL29HS0t2T3h6SHFBbVFRYm1M?=
 =?utf-8?B?MTZWTGIvQjJGMndvT2EyeGd6dUh0eTB1SWN2NGVyZnZZeU9ablQ3bUxlanZs?=
 =?utf-8?B?aU1nTFVRVkVadTh3VDF5bit1MGVwMnBNbXhObzVZVkl5WElEZm5HVkk5VStl?=
 =?utf-8?B?b0tWNXNTbktTek1KdzFnV0xsTHNQVG9JQVFkZXgvOUpvdk82SmhTZndVZjYv?=
 =?utf-8?B?ZzRteXZzcU50NzU2RzNqUVR6VEZaNXNLS2JTMVp6WkVTM0VNcVRiZGFlQWFC?=
 =?utf-8?B?L3dvTHd1ak9YNUgvc3NkV3BZWnczZXlGUjhrWWduVnZ5TUt5ZWNUa1o1STJE?=
 =?utf-8?B?YzlXWU54SENwSE9WMXRvZ01laTRvQmNIMitUNlQ3UERnbVQ5MWxJODQxQnBL?=
 =?utf-8?B?cVZrZ0xxbnlLVW9IMjZ5dnEwbDIyRUJ6OXYrcjNRQjlISS81ZTA3S0J0QW9z?=
 =?utf-8?B?dWJSSk1LaUdCNitaWUNLZ0xUNTBBOTAxbzd1Ymd2N1hYQi9CcEJWa2FhSHNQ?=
 =?utf-8?B?NHRiTVRjb1JRZ0tqc05zOVRKRXdSV0RNTDlIeUNtNjNwNGVqV3E5ZDVkci9L?=
 =?utf-8?B?QW1iNmkyK2pQajZaRnZNWmtMa3BXOHRabXRCMUQ3VlJEYy9PVWdEMGFIeWtq?=
 =?utf-8?B?REFmMTNhanl2RWFRKzZ2V1ZiNk51SWNac2llZVlmT1IzVTdBYTRBUmd0WWpW?=
 =?utf-8?B?TGdRYzM2UmR2QXBpMU8wWE8wVG5ET3dqTDNJeWw2elZZVWxOdjJHRjNORmQ5?=
 =?utf-8?B?SGZORFFSNmFheTdZcFRaNkZ0K083dUZTNXJ0V04zQUlWSmZjd1I5RmZjSXhO?=
 =?utf-8?B?TW1zMDFyb2NSdVRmdExpTFpueWpWUWFVVUFDbitaYXdHZ1R5Q2NraTVuZGJr?=
 =?utf-8?B?SlY0TlNCTVVZbXBhMS9tcjAwc0xXR1ltbHBSbzB5aEVYOEY2RXg1aWp1NGZT?=
 =?utf-8?B?bmZLMDYzSno0ZjZJZUl3ekJiQW5kb2pDRGtiVldDczlmeDltekdwY0k2eVpj?=
 =?utf-8?B?Q2dwN1dKdTJveUN1RXFhL2U0TkN1d0tCYjQ2ZkVEYkliMUZCK1dMWks1ak9Y?=
 =?utf-8?B?QSs4aXkvUGFDdmNkSCtEcUJIWmkrUG40dVRTOUJzZzdyakVTeGNzWVp3OUp4?=
 =?utf-8?B?cFUrbHpqK3FTdE9VWkQrRFhJOG9IUG5oNnI4WERMSkp1azBoVHoxVmNVT3Q5?=
 =?utf-8?B?ZTMxTjRGTVlOY1NGU09mM2p2aGEySGFKVHNMdkxNUSt5WkhtZnVjV2xZSUNJ?=
 =?utf-8?Q?Cemsu0X4RgMr+Kn7H7rPxynN0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25E1C6B44B96C34F845DC9F21BE23111@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wbUDz+MVlWkvd/tKvFt98+sVZwV3P1WuOBXKnozQocTGnla1zywPYiHZ4HQGltItqX9mQ5XuvVdI6kvkL4nf3etED6Rs4xNfX7oKWQySEUnbkXCPtYCcnjHuRMOqNB7Pyr+P9o1QzcnwS+UEbh0VGgtFBLy9GtTrSgqMY2EFRPifPWRi9MS0T3INy8hVXU9fbcXLjUsEFa7QV61qEsPang5cuk8V+av8dNZpI9ryS5KP/edHcN7ZX2HA9IZ4yqVNZqShc78/0axXkIFeW+oPAVdDL8fUG/6fRTPVpFQwBFUa0Vjh3CYtYp7k5+YLGuUHp4tmhc/+wYqUUVhVKqPU4ygIblioSrWx7SXJsCnTDB5cuYLzrSkV3CepZKNz2hXCMSlb9BeqvoILg+rFDRAIfxeS1IV6OtU8piiWu2ttshMAyKXmhoWZBlvX5e5iN2aBbLw+5jn+kM2KLau3SeCxfeFUvS/ntLwjahyqTXp1LfVeFCQQRQ2vHX+iZfSrmy5NAQHxxTSrP8hXC5/SAjqLZHUm8d29yrexwS0yCR3Ztxyu/G2ZRAMgLb9iKtS4FGMbEQOe+dt1OUFJpTkxQG6QGwjUJU3xyIsHJpGmmOhVJjH3jpmwA8643qGNs0e5nOWQYjaxsUAUMBayllWTkr8HGiSX10lf7BkJOynJxRik5FnTv0OskVDcYXR1X9IWceSrnRiRir7US0gqgEc5FBbm6lu+yKj39Mj+c3MFt4dCOhU9pser4gRAdRd6LZFqevJocgyZvU3o0ibojh29zmXVXkpPvMW3yRc7YJw4/EjbaYoX6+mp3PHwm63+Xkd/vnMxL+sannu11yaL2Nvg0STbDbpdrnYkpaNheLEsLR7EwmBSvAJVYFuHmT0DI8KxqRsvEIj/VpIAocNOi1mw/90RdQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270619a9-12d3-4299-071b-08db3a29fe55
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:13:43.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuWOjNNy7xPY4iW60TBkhAm2AxsMVR7+4yGc2332IG+q1Scf1Ak5+88DsiAmldxhVz0bQD/ToyAvl0VmjP8wEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Proofpoint-GUID: 5nYyXMnW5b2yvGQTlsZJfkuw63jRqthO
X-Proofpoint-ORIG-GUID: 5nYyXMnW5b2yvGQTlsZJfkuw63jRqthO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTAsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSXQgd2FzIG9ic2Vy
dmVkIHRoYXQgdGhlcmUgYXJlIGhvc3RzIHRoYXQgbWF5IGNvbXBsZXRlIHBlbmRpbmcgU0VUVVAN
Cj4gdHJhbnNhY3Rpb25zIGJlZm9yZSB0aGUgc3RvcCBhY3RpdmUgdHJhbnNmZXJzIGFuZCBjb250
cm9sbGVyIGhhbHQgb2NjdXJzLA0KPiBsZWFkaW5nIHRvIGxpbmdlcmluZyBlbmR4ZmVyIGNvbW1h
bmRzIG9uIERFUHMgb24gc3Vic2VxdWVudCBwdWxsdXAvZ2FkZ2V0DQo+IHN0YXJ0IGl0ZXJhdGlv
bnMuDQo+IA0KPiAgIGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUgICBuYW1lPWVwOGluIGZsYWdzPTB4
MzAwOSAgZGlyZWN0aW9uPTENCj4gICBkd2MzX2dhZGdldF9lcF9kaXNhYmxlICAgbmFtZT1lcDRp
biBmbGFncz0xICBkaXJlY3Rpb249MQ0KPiAgIGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUgICBuYW1l
PWVwM291dCBmbGFncz0xICBkaXJlY3Rpb249MA0KPiAgIHVzYl9nYWRnZXRfZGlzY29ubmVjdCAg
IGRlYWN0aXZhdGVkPTAgIGNvbm5lY3RlZD0wICByZXQ9MA0KPiANCj4gVGhlIHNlcXVlbmNlIHNo
b3dzIHRoYXQgdGhlIFVTQiBnYWRnZXQgZGlzY29ubmVjdCAoZHdjM19nYWRnZXRfcHVsbHVwKDAp
KQ0KPiByb3V0aW5lIGNvbXBsZXRlZCBzdWNjZXNzZnVsbHksIGFsbG93aW5nIGZvciB0aGUgVVNC
IGdhZGdldCB0byBwcm9jZWVkIHdpdGgNCj4gYSBVU0IgZ2FkZ2V0IGNvbm5lY3QuICBIb3dldmVy
LCBpZiB0aGlzIG9jY3VycyB0aGUgc3lzdGVtIHJ1bnMgaW50byBhbg0KPiBpc3N1ZSB3aGVyZToN
Cj4gDQo+ICAgQlVHOiBzcGlubG9jayBhbHJlYWR5IHVubG9ja2VkIG9uIENQVQ0KPiAgIHNwaW5f
YnVnKzB4MA0KPiAgIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4Mjc4DQo+ICAgZHdjM19lcDBfb3V0
X3N0YXJ0KzB4YjANCj4gICBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVjDQo+IA0KPiBUaGlzIGlz
IGR1ZSB0byB0aGUgcGVuZGluZyBlbmR4ZmVycywgbGVhZGluZyB0byBnYWRnZXQgc3RhcnQgKHcv
byBsb2NrDQo+IGhlbGQpIHRvIGV4ZWN1dGUgdGhlIHJlbW92ZSByZXF1ZXN0cywgd2hpY2ggd2ls
bCB1bmxvY2sgdGhlIGR3YzMNCj4gc3BpbmxvY2sgYXMgcGFydCBvZiBnaXZlYmFjay4NCj4gDQo+
IFRvIG1pdGlnYXRlIHRoaXMsIHJlc29sdmUgdGhlIHBlbmRpbmcgZW5keGZlcnMgb24gdGhlIHB1
bGx1cCBkaXNhYmxlDQo+IHBhdGggYnkgcmUtbG9jYXRpbmcgdGhlIFNFVFVQIHBoYXNlIGNoZWNr
IGFmdGVyIHN0b3AgYWN0aXZlIHRyYW5zZmVycywgc2luY2UNCj4gdGhhdCBpcyB3aGVyZSB0aGUg
RFdDM19FUF9ERUxBWV9TVE9QIGlzIHBvdGVudGlhbGx5IHNldC4gIFRoaXMgYWxzbyBhbGxvd3MN
Cj4gZm9yIGhhbmRsaW5nIG9mIGEgaG9zdCB0aGF0IG1heSBiZSB1bnJlc3BvbnNpdmUgYnkgdXNp
bmcgdGhlIGNvbXBsZXRpb24NCj4gdGltZW91dCB0byB0cmlnZ2VyIHRoZSBzdGFsbCBhbmQgcmVz
dGFydCBmb3IgRVAwLg0KPiANCj4gRml4ZXM6IGM5NjY4Mzc5OGUyNyAoInVzYjogZHdjMzogZXAw
OiBEb24ndCBwcmVwYXJlIGJleW9uZCBTZXR1cCBzdGFnZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFdl
c2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDMyMGUzMDQ3NmM4OC4uOTE3NjhmMWJkYmFmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTI1NDYsMjkgKzI1NDYsMTcgQEAgc3RhdGljIGludCBf
X2R3YzNfZ2FkZ2V0X3N0YXJ0KHN0cnVjdCBkd2MzICpkd2MpOw0KPiAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiArCWludCByZXQ7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJZHdjLT5jb25uZWN0ZWQgPSBmYWxzZTsNCj4gIA0K
PiAgCS8qDQo+IC0JICogUGVyIGRhdGFib29rLCB3aGVuIHdlIHdhbnQgdG8gc3RvcCB0aGUgZ2Fk
Z2V0LCBpZiBhIGNvbnRyb2wgdHJhbnNmZXINCj4gLQkgKiBpcyBzdGlsbCBpbiBwcm9jZXNzLCBj
b21wbGV0ZSBpdCBhbmQgZ2V0IHRoZSBjb3JlIGludG8gc2V0dXAgcGhhc2UuDQo+ICsJICogQXR0
ZW1wdCB0byBlbmQgcGVuZGluZyBTRVRVUCBzdGF0dXMgcGhhc2UsIGFuZCBub3Qgd2FpdCBmb3Ig
dGhlDQo+ICsJICogZnVuY3Rpb24gdG8gZG8gc28uDQo+ICAJICovDQo+IC0JaWYgKGR3Yy0+ZXAw
c3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFKSB7DQo+IC0JCWludCByZXQ7DQo+IC0NCj4gLQkJaWYg
KGR3Yy0+ZGVsYXllZF9zdGF0dXMpDQo+IC0JCQlkd2MzX2VwMF9zZW5kX2RlbGF5ZWRfc3RhdHVz
KGR3Yyk7DQo+IC0NCj4gLQkJcmVpbml0X2NvbXBsZXRpb24oJmR3Yy0+ZXAwX2luX3NldHVwKTsN
Cj4gLQ0KPiAtCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
LQkJcmV0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZkd2MtPmVwMF9pbl9zZXR1cCwN
Cj4gLQkJCQltc2Vjc190b19qaWZmaWVzKERXQzNfUFVMTF9VUF9USU1FT1VUKSk7DQo+IC0JCXNw
aW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQkJaWYgKHJldCA9PSAwKQ0K
PiAtCQkJZGV2X3dhcm4oZHdjLT5kZXYsICJ0aW1lZCBvdXQgd2FpdGluZyBmb3IgU0VUVVAgcGhh
c2VcbiIpOw0KPiAtCX0NCj4gKwlpZiAoZHdjLT5kZWxheWVkX3N0YXR1cykNCj4gKwkJZHdjM19l
cDBfc2VuZF9kZWxheWVkX3N0YXR1cyhkd2MpOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBJbiB0aGUg
U3lub3BzeXMgRGVzaWduV2FyZSBDb3JlcyBVU0IzIERhdGFib29rIFJldi4gMy4zMGENCj4gQEAg
LTI1ODEsNiArMjU2OSwyNiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVj
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCV9fZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiAgCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgDQo+ICsJLyoNCj4g
KwkgKiBQZXIgZGF0YWJvb2ssIHdoZW4gd2Ugd2FudCB0byBzdG9wIHRoZSBnYWRnZXQsIGlmIGEg
Y29udHJvbCB0cmFuc2Zlcg0KPiArCSAqIGlzIHN0aWxsIGluIHByb2Nlc3MsIGNvbXBsZXRlIGl0
IGFuZCBnZXQgdGhlIGNvcmUgaW50byBzZXR1cCBwaGFzZS4NCj4gKwkgKiBJbiBjYXNlIHRoZSBo
b3N0IGlzIHVucmVzcG9uc2l2ZSB0byBhIFNFVFVQIHRyYW5zYWN0aW9uLCBmb3JjZWZ1bGx5DQo+
ICsJICogc3RhbGwgdGhlIHRyYW5zZmVyLCBhbmQgbW92ZSBiYWNrIHRvIHRoZSBTRVRVUCBwaGFz
ZSwgc28gdGhhdCBhbnkNCj4gKwkgKiBwZW5kaW5nIGVuZHhmZXJzIGNhbiBiZSBleGVjdXRlZC4N
Cj4gKwkgKi8NCj4gKwlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0UpIHsNCj4g
KwkJcmVpbml0X2NvbXBsZXRpb24oJmR3Yy0+ZXAwX2luX3NldHVwKTsNCj4gKw0KPiArCQlyZXQg
PSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmR3Yy0+ZXAwX2luX3NldHVwLA0KPiArCQkJ
CW1zZWNzX3RvX2ppZmZpZXMoRFdDM19QVUxMX1VQX1RJTUVPVVQpKTsNCj4gKwkJaWYgKHJldCA9
PSAwKSB7DQo+ICsJCQlkZXZfd2Fybihkd2MtPmRldiwgIndhaXQgZm9yIFNFVFVQIHBoYXNlIHRp
bWVkIG91dFxuIik7DQo+ICsJCQlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICsJCQlkd2MzX2VwMF9yZXNldF9zdGF0ZShkd2MpOw0KPiArCQkJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAkvKg0K
PiAgCSAqIE5vdGU6IGlmIHRoZSBHRVZOVENPVU5UIGluZGljYXRlcyBldmVudHMgaW4gdGhlIGV2
ZW50IGJ1ZmZlciwgdGhlDQo+ICAJICogZHJpdmVyIG5lZWRzIHRvIGFja25vd2xlZGdlIHRoZW0g
YmVmb3JlIHRoZSBjb250cm9sbGVyIGNhbiBoYWx0Lg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
