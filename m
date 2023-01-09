Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0895B662FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjAITKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbjAITJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:09:43 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFDA40858;
        Mon,  9 Jan 2023 11:09:36 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309IettC002798;
        Mon, 9 Jan 2023 11:09:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=D7/H8hfdpDV1/yqKs+sUDyN8OzZCrsK02wXo08GUJUg=;
 b=UnZSi4RVvguP6H+5hwbXaVtuOnf2ElKbcv7FR3/Y/XMkObxWdgNm/LzNS0aS6kL4tzdS
 c7vCBDra5+Focw2Hpx8FKP/OtUddday1eJYw3sdoifC+LVHxYJ2A9bmOWBxTycOGrgBl
 gj2awmIs6VnVE9OIDEnWZB5g/Mh2S01MDamNs9PbGE5/fxhs1LpcRJpdpyZ6v0w4ZBG4
 RZVhUSV0rfSjrEdWEgbWkzJziaYE/VBCQcZe4cPcCw9TGD5EofE1eWDCy0+LAKOU0Lsg
 g6LYFpGJZacTsPk4iZWIeknZ6PMBNpx7jzLtYA7tkgOTB/A+1YVrptGYFXzoNAO/moWy Aw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3my8j11b08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 11:09:25 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 67301C0906;
        Mon,  9 Jan 2023 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673291364; bh=D7/H8hfdpDV1/yqKs+sUDyN8OzZCrsK02wXo08GUJUg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Cyc1tvmrwuLosl7xszyr1BXKTfHKwDUXWK2p4Afs00MgDMtDHhKU4TfbJEehlwPqb
         dGx8/3GWQgundpyr7nOEud6aZTMx0Ykd62J7eMHLMf2GABW/dM4jRlZAE3MQ014WTc
         5z5aYQSBUbs6todt8Uh803gkHSL3dj3ji8Ic8Cyvc+1uElytkiMcaQzS0GfZx2/6d0
         p85L3Dso822t2e55BRSk2fQw6omt0CYzhRSslIcq6lfOR+H7+i6g561Cwczi6ucd/y
         o7/YXL/KRYCd24Kes8EyTvxnhSh/kHjvvOIr66fRzweUfj6UlEjqg8I97tvwasBOv2
         RZ0jBTdY/lm1Q==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0BA9EA0062;
        Mon,  9 Jan 2023 19:09:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 08E7C80169;
        Mon,  9 Jan 2023 19:09:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AGfwE6GK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG9IC3gI6bCq0lUhWkmxqDbFKJ8l2rjZ8SKr9tJla+Cre/1fkRFh3/rn3ag5Ha56QkOFkbvJLtYH5QTPHEOiapEVtO4gdp7ZqfP8gR/RIlheQWQ1+qJ57P1OJiSdqVyQnOXZb/Biv3rbs0mqBqbnx5Emnj0SmowmqeDGFoj0Ii0Kn4WNvJ/jcddLTQl1GtF34z2BQ14Cxlg7pBCHiBcVlYVjFt6j3Tybt5beJRbLBcfwwqJp3IizMC28FBmkaGLlIsiMBqK5GmhqfRlIBuEu8XmTtCD8aebasBasoJTc4s1edRuBOFlaEWlQtDGJCCz2/rE3oJfNHU52DKQnVUrfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7/H8hfdpDV1/yqKs+sUDyN8OzZCrsK02wXo08GUJUg=;
 b=RXY8nI7bDT5HSbmkRegnBVAsy53m+GI2EQ232J7X+Hh7mmQh14nrona8TgntTMUWd686sBXDLih0tfwhSWpJX5gFEgNIwK63EmBNIagLHVR1mQPVAbkL+xBwhJvZn3jkWecQCGn6beWZpBbz5w14LM7WMyNpn5xTrReAQbMS806YW6sO1HbflfaKOTjoDblVewYM+zj7WjB69pxnUAh78wUQtQgpsHrBJDlUK8TcWc4NR8FeybWFKceW03/fEO82bUvxdfQEo0onRAgLPgwtD8TrEWoICgw8/v4+f2vDJ3T4pfCnLN3cfEQaq8Rk7Ar5+ug890WCqDP8oApWKMVmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7/H8hfdpDV1/yqKs+sUDyN8OzZCrsK02wXo08GUJUg=;
 b=AGfwE6GK6WaNAeoVlM3P173AITC/Vh+6qIcxnCeTwIfubLyJN0SHbf6gN+Y/07OPAR3m2l6+Hmc+rccRHZsxos2uawKCcIjdw3DqoKtTIQ/wQA4LzbFXmWyLF/juIdFNQYQjgo7eBJgrXL+VjyKe9TyZsGJgaXgd7kUifp6qzRo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 19:09:19 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 19:09:19 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     JaeHun Jung <jh0801.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6WdY2AgAAJWgA=
Date:   Mon, 9 Jan 2023 19:09:18 +0000
Message-ID: <20230109190914.3blihjfjdcszazdd@synopsys.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
 <20230109183545.kqej7vmtf5o6ihq4@synopsys.com>
In-Reply-To: <20230109183545.kqej7vmtf5o6ihq4@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB6199:EE_
x-ms-office365-filtering-correlation-id: ae0871c4-f1b9-4d69-72ca-08daf275023d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvjS3vrBDU1hrGYSBB/Phutrz7HWjxBcANHQpt9OwAsVDc16xWa+Jz7NxoH1zv5rf8XaAmQNTiFPe9hyL9qoM4y83FyRQCrEUqQbTaZ/Cp97XFbyI7OKxUfEVPAKkz4C/bxlXOU/QtY0ALXVXO2V+ux7Y19we+470bQm3x7uzaK90Ot3Fke4ljv7+ZJzbSX886n1cEv3DkDSkjsm7ruguR6s6swbNAJ+8DQZJPgz+hxvfnbk5Amcr7+g3dkE8EwC1pAIxJWJFQu0L6W6eZhU1u0eWd4jhzfveKHZlnUklwxYT0Rt0tbpXD8vM6mHnknTOGWc+kgRpFQ64wg1Hj3JS/cYvRSK0HQqMAqVlK2POibVUR+OocLMvbwB7TxUKmVG1KV3Gs4dG4QUFswn9fOPZhi2onc3zyFAPDW8VfmeguicLMeXYH8exZyiOPtE7H8lblqN5qxKEXMac7RFAQiUhPPjrsxksGoo5WW+3EvbNyjNrKV3njiJBGeX8wUPHjPnNVc5keoWCaA2y0MkR+AXaBCJx0k+f3fa6nJFL9tldmLRp1SISRxHHgOtcrElLZRxLEclqBV8evojGazQr3ZT1CdvzHwV+5Rb2FjVEALBvoOrhDZ4fuSy173pQjdxIrRd+HfTMelMOLItgiVJJ4fod8sEDs9k/R2qVP8yIvvWZ8n/Qc7XWY97Qd0o13Ux3B8Gf+Vy0XuC/U2yOy4xwB6XmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(478600001)(64756008)(66946007)(66446008)(4326008)(6506007)(41300700001)(38070700005)(66556008)(8676002)(76116006)(66476007)(86362001)(2906002)(83380400001)(54906003)(186003)(316002)(37006003)(26005)(6512007)(6486002)(1076003)(36756003)(8936002)(6862004)(5660300002)(2616005)(38100700002)(6200100001)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUVXWThsWTg1Yk0venFoVWhYS014UldrQ3BnYjdqVFNYTmRlbTBNTjRYYVQr?=
 =?utf-8?B?VE8yd0dzUUxSc3V5Zzk5cmFybzVibFhKUmpEQXV5eVhyZ2FheUN0Z3d5dDFG?=
 =?utf-8?B?KzM5bW9nWkVjUE5XTlNFS0FQOVZpWmFUU0FHVkQwYmpRaGJTQXUzVW1ObEg0?=
 =?utf-8?B?MjJkN1pUSk9jeUJNZzFCNzZ6OTlCUXlScFJJVUE4bStzMzZRVUwxdm10QXFk?=
 =?utf-8?B?eEN1NHRvajRqK25wVGVoVmJaRHZXWkdndCtpeExvUEgxTHo2RkFGZXY4elo0?=
 =?utf-8?B?ekZZVE1Nb2svVEhQK2FSemJNcWs3cDlBZFIybk9VSUhNWkxGd2tHc1VVd2o4?=
 =?utf-8?B?R3lwSlErUDNDSlFWR2dWSFFXamQzRFJodTJXbE9iTURiQ3R6U0ZKamhpY1Fh?=
 =?utf-8?B?MWlCWDlkTnh5S3VHeWpBaEhjU2hhTGlYUE9VZEtmTzEzUUR6L2luNndoclZH?=
 =?utf-8?B?L1pBYVlBUG5OL1gvajRUSFEvcDRRWm9UU0tsWnJHOTI4T0I5dllOcHpvQXRm?=
 =?utf-8?B?UFZxWktJTVpxV3NSTXZyV1JSYnFkTEFYeUtwR1VpaFJXakRtamw1RGFhVmJw?=
 =?utf-8?B?QnlCUDdiSFRBUks5M2ZyZVE5L0o2MWN0WHA2a0NsdkNySnMwbU9YQ2ZYTDJn?=
 =?utf-8?B?L1JSNFN6eDBqbkpPSk5xd3ZNSmQyL2g0SnBBd2xDNW9kU0lGRE1mQTd5OW9O?=
 =?utf-8?B?OFk0Z0VIYjd3NGRMTGhrb2pvV1JYSXRKMlRHanZjK0VSYWRCamdGcG9GQWZB?=
 =?utf-8?B?RHFIU1ZDL2hrRkNuU1BwM29NWWNjdS9nNEM5YjRvRjR1ejBNVWIyZU0xdXpG?=
 =?utf-8?B?V0JTQlErQkRKZVZ3RmJ4cEU0bm9JQXVUK3ltM0QyTWtNT2tJZVBtdnprSzFE?=
 =?utf-8?B?OWtJbHBvK0QvVktscERCMUxMTU02VFpKMDZucWFjeEpjOTR1QVJBMHZkUGJ0?=
 =?utf-8?B?bXFtM1cyVXZXbFpvYi9IK0g1bnVXU2s0c2lvZytvKy9SdnZmUWhXemFvM0ZQ?=
 =?utf-8?B?bUtGSlJ1cjVKd3VmbTRWcUxraGVYTVp2aDlHLzY4RTgyUW4rMW1DNmY0Mk9K?=
 =?utf-8?B?WDlKSjNXZ3ozUTFpQngybVBzT1p5MHYrZU0ydGU4RFFaZ2NWV3FFV2R0NDVY?=
 =?utf-8?B?emMzcSt6MDNvYWpnR3I0Z1VMQkdLZFlVREkrZUJBMlpGdHl6eDlXS0pYMEs0?=
 =?utf-8?B?cjRnNjJwQTlOYXk5VUw4c0tJTFpwTC9TN3Y4emxDZm0yZ1hUUVJtN2pRT2VQ?=
 =?utf-8?B?RnMzM05QNHUxOENNR1lMSlIwYXlZS3BqN1BmOEVlVFZuS0toeStFNHJudkdV?=
 =?utf-8?B?RnAwUksyOUd3S2VBdDFCdW92L0RIdDZPWU9aZ3JIbUdjcGFSRzlQdHJZd2Vu?=
 =?utf-8?B?ZGZFMUNNRlFGc0FJeUJoRVBwalQ0WTAweGd6VlN0RTBpMVFheWtNbHVOZmFa?=
 =?utf-8?B?Q2Y0NjRpT1RRUVJ0NC9EVmxiL0pXdGVYckJRSEx1VW0vL0xOKzE2YkNvODc1?=
 =?utf-8?B?dUlDR1NoVVo5ZWQweUt5bDdTWExUMXNacVQ3UjVCVHZZWjQyUG9lcmRSNmFp?=
 =?utf-8?B?eFQxaW9pRXRSdzdqRDdsNVF5dUlPTUdiRHVBb01nRkF5Nkd1SFJBNkgrcDF0?=
 =?utf-8?B?MW5jTk94MUFjc1U5L1d6UWl2aXQrbkFzMWkzc2dmZzJaM2QyT2k4ajFmS0pr?=
 =?utf-8?B?OGNObkdKb1I2OWdhZ0dJWnROZkYrc3BFZDA5SE1TV2tlNys1T2hXejZXa1Ny?=
 =?utf-8?B?aDVBMEFFOXV0VEhZN2IrYXdnU08vNndlaTFoVzdEZkN0Z1lOaGQwcDRWeEhn?=
 =?utf-8?B?Wm04cHdaN2ZjV2FOUUZDYnNQV3htVDk1anNGOGU2U1dIWTJmOWRMRlN3RGZM?=
 =?utf-8?B?ZDd0V0pVMzRGbU02K09ZS3h5Z3lhOG9jSnp3WnJVZE9YNHR0OFp1M3g1VktI?=
 =?utf-8?B?VGRkemZ5bmJKYXl0NTR2YnFFczFNdm1VckxXaGduSjhlS0lpa0o2UHZlTFU0?=
 =?utf-8?B?aXJqMytyOERXRGFmaDdzOVc5U0Q2azYvMktoQi9tK05kWDdCc2xWZlBCdUpY?=
 =?utf-8?B?NGViU056SFUwWWhqbEtERk95ZXc5UlkwQXNLUDZXbnluMDN1R0VHTG5UZXo2?=
 =?utf-8?B?K1ZnNGhkQTBGMDVRMjljc1F3M1E4c2VVVURpN3owT1Fha1ZQZUs1T1c5dkFK?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B04532BA189D5409C1EA05F377EAD32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aENrc3R6ZlBDajczNFhLQjhtZk9DOEprcXR1TVhwMEM0bHNvU01mN3ZYNWZI?=
 =?utf-8?B?b0VoZ2ltY1ArWkpRN01ERjBsUkZPMmJqSjMrS2lUK2tEK0p0azM1WkxWcE5R?=
 =?utf-8?B?YTNnNjI2UU8rTnQzWDhMNm1HT2U4MUtVb2d5MWRxNlUvTzkzVTk0L1RHcENW?=
 =?utf-8?B?K0RtUDI2MXEzdGtBVTcyOTErL0xtTEVmWmNLUjVrTzBnZlk5b2ZMcUNURDVm?=
 =?utf-8?B?TVl0eFZmZkxQZTNFY2VMTXJSZEJqZlVIQlVmaElZQzRTZkVIVHNoeUxWZFFy?=
 =?utf-8?B?a2hPb1VvVFZrbGVkNXpoeTV4aWpSOVh4amtmTWYwRHlFRHcrZit5cVgxLzFQ?=
 =?utf-8?B?T0pNajBOeUdyWGJGbGJLcjNQdmZqVkZvOGJFUXpESVlKamQzblhuZUYyeUhV?=
 =?utf-8?B?aUlNZzdLZUZmek9KZ0RDUVRkK1ZGQ3FVYnFxemF1WWwrUmlEelFzWTlBTmd4?=
 =?utf-8?B?aVc0LzU2ZTFPQldTVENvYkY5Q2xBRi9KVFZqc2tzS29hSElHQWxuYnUyQ1g5?=
 =?utf-8?B?VG80YzRCSUtMS0lRaTk3N1R1ck5CSEhrZTZzbk5QN01VTXMrTXdBWDRlejNn?=
 =?utf-8?B?a3hPVkxUNEphcGNYVE1OTkFMS0pjZnk1TTRHNEFqV3pwOThzWlRGeHphUTh4?=
 =?utf-8?B?dXFUTlJERW1pcnFvWldNK0Q1emdIclFsbGlQRVlQS05rb1FzOFlZYkplZlk5?=
 =?utf-8?B?M2hVS0x5R2cvVnl6bkkzK1d0S2NPakZEU01LYXFCWWpOUTFyaFl1Z0NKUS9H?=
 =?utf-8?B?Z0hrekViekFqb2ZweTNwL0NsQVN1V25OdDdsdmExTkhITXlaL2pPM2FkRWxV?=
 =?utf-8?B?dkgyMXdndWZIbE5HNDVlQnBMejN1UkFVSzV5c1N2M1o3RGNzQkc3YlBwRy9r?=
 =?utf-8?B?TGxTNzhkWWxYcXpVd09PZ2g3cGNWS05pbTAwZzBlQUF5cHBpNFBQVUJEMlg2?=
 =?utf-8?B?eWQyK1VPZHdHM29JeDM0Wm9qUkNuK1FPTHVmdFNHaGM4eWJmQzZHNUdVMFNX?=
 =?utf-8?B?dHpqUXlxZWJ0ZkZ2SzVLMzF1SERZalVmOU9ncWdsRzE4YzlVUTg2Y2kzaXBR?=
 =?utf-8?B?bkFQN3oxOCttRnBiR3gyNkhUM1RrR0hPR0pmVDNqcExuUFFPQmFEQWJ5QnRK?=
 =?utf-8?B?RjZQaVJsYXJyeld3MTI4LzdGam9hSEhUalZ6aWpNcGZnVHF0MXJFR1diT2ll?=
 =?utf-8?B?eEliTkpyZXZPVUQ0aTZSYVl6MWMrYStRbUN1a0FEZTdQMmRvSTVhNjB1c2R0?=
 =?utf-8?B?QkcwTjdRaGlNeVdwOHR1SFhabGpRMTNJYVlZT201cnFtZXlYSTJNMllyK0Rv?=
 =?utf-8?B?SFovTmViclgvNEZKTzZNU2YwQlBQTmpZa08xRTl6ZTZ6VlFtK2I2RmZGUC9k?=
 =?utf-8?B?OEE4TEk5U3BjM3c9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0871c4-f1b9-4d69-72ca-08daf275023d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 19:09:18.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKG/3cvgJ8ezvEmLZBmYK548cYinRdAEsgVhfU4TtNkBH5TaarMtgDubiFp4sg/cvtktPFGALS3oL96i8a2v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
X-Proofpoint-ORIG-GUID: T2bHZXs3NSkyHHOWZWKFIARplTS-PabM
X-Proofpoint-GUID: T2bHZXs3NSkyHHOWZWKFIARplTS-PabM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=841
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMDksIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGksDQo+IA0KPiBP
biBNb24sIEphbiAwMiwgMjAyMywgSmFlSHVuIEp1bmcgd3JvdGU6DQo+ID4gU29tZXRpbWVzIHZl
cnkgcmFyZWx5LCBUaGUgY291bnQgaXMgMCBhbmQgdGhlIERXQzMgZmxhZyBpcyBzZXQgaGFzIHN0
YXR1cy4NCj4gPiBJdCBtdXN0IG5vdCBoYXZlIHRoZXNlIHN0YXR1cy4gQmVjYXVzZSwgSXQgY2Fu
IG1ha2UgaGFwcGVuIGludGVycnVwdCBzdG9ybWluZw0KPiA+IHN0YXR1cy4NCj4gPiBTbywgSXQg
aGF2ZSB0byBjbGVhbiB1cCBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZ3Mgc2V0IHdoZW4gY291bnQg
aXMgMC4NCj4gPiBJdCBtZWFucyAiVGhlcmUgYXJlIG5vIGludGVycnVwdHMgdG8gaGFuZGxlLiIu
DQo+IA0KPiBDYW4geW91IHJld29yZCB0byBpbmNsdWRlIHRoZSBleHBsYW5hdGlvbiBmcm9tIG15
IHJlc3BvbnNlIFsqXSBhbmQgYWRkIGENCj4gZml4ZXMgdGFnIHRvIDc0NDFiMjczMzg4YiAoInVz
YjogZHdjMzogZ2FkZ2V0OiBGaXggZXZlbnQgcGVuZGluZyBjaGVjayIpDQo+IA0KDQpBY3R1YWxs
eSwgdGhlIG9sZCBwcm9ibGVtIHRoYXQgdGhlIGNvbW1pdCA3NDQxYjI3MzM4OGIgZml4ZXMgbWF5
DQpyZXN1cmZhY2UgYmVjYXVzZSBvZiB0aGlzIGNoYW5nZS4NCg0KQ2FuIHlvdSB0cnkgdGhpcyBp
bnN0ZWFkPw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IDY1NTAwMjQ2MzIzYi4uM2MzNmRmZGI4OGYwIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KQEAgLTU1MTUsOCArNTUxNSwxNSBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qg
ZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQogICAg
ICAgICAqIGlycSBldmVudCBoYW5kbGVyIGNvbXBsZXRlcyBiZWZvcmUgY2FjaGluZyBuZXcgZXZl
bnQgdG8gcHJldmVudA0KICAgICAgICAgKiBsb3NpbmcgZXZlbnRzLg0KICAgICAgICAgKi8NCi0g
ICAgICAgaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQorICAgICAgIGlmIChl
dnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKSB7DQorICAgICAgICAgICAgICAgaWYgKCFl
dnQtPmNvdW50KSB7DQorICAgICAgICAgICAgICAgICAgICAgICB1MzIgcmVnID0gZHdjM19yZWFk
bChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCkpOw0KKw0KKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCEocmVnICYgRFdDM19HRVZOVFNJWl9JTlRNQVNLKSkNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZXZ0LT5mbGFncyAmPSB+RFdDM19FVkVOVF9QRU5ESU5HOw0KKyAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQorICAgICAg
IH0NCg0KDQpUaGlzIGlzIGEgcXVpY2sgc29sdXRpb24gYXQgdGhlIG1vbWVudC4gTGV0IG1lIGtu
b3cgaWYgeW91IGhhdmUgaGF2ZSBhDQpiZXR0ZXIgb3B0aW9uLiBOb3RlIHRoYXQgcmVhZGluZyBh
IHJlZ2lzdGVyIG1heSB0YWtlIHNvbWUgdGltZSwgYWxiZWl0DQpzaG9ydC4gVGhhdCdzIHdoeSB3
ZSBtYXkgd2FudCB0byBrZWVwIHRoZSBldnQtPmNvdW50IGNoZWNrIHRvIGhlbHAgd2l0aA0KcGVy
Zm9ybWFuY2UuDQoNClRoYW5rcywNClRoaW5oDQoNCg0KPiANCj4gDQo+ID4gDQo+ID4gKHN0cnVj
dCBkd2MzX2V2ZW50X2J1ZmZlciAqKSBldl9idWYgPSAweEZGRkZGRjg4M0RCRjExODAgKA0KPiA+
IAkodm9pZCAqKSBidWYgPSAweEZGRkZGRkMwMERCREQwMDAgPSBlbmQrMHgzMzdEMDAwLA0KPiA+
IAkodm9pZCAqKSBjYWNoZSA9IDB4RkZGRkZGODgzOUY1NDA4MCwNCj4gPiAJKHVuc2lnbmVkIGlu
dCkgbGVuZ3RoID0gMHgxMDAwLA0KPiA+IAkodW5zaWduZWQgaW50KSBscG9zID0gMHgwLA0KPiA+
IAkodW5zaWduZWQgaW50KSBjb3VudCA9IDB4MCwNCj4gPiAJKHVuc2lnbmVkIGludCkgZmxhZ3Mg
PSAweDAwMDAwMDAxLA0KPiA+IAkoZG1hX2FkZHJfdCkgZG1hID0gMHgwMDAwMDAwOEJEN0Q3MDAw
LA0KPiA+IAkoc3RydWN0IGR3YzMgKikgZHdjID0gMHhGRkZGRkY4ODM5Q0JDODgwLA0KPiA+IAko
dTY0KSBhbmRyb2lkX2thYmlfcmVzZXJ2ZWQxID0gMHgwKSwNCj4gPiANCj4gPiAodGltZSA9IDQ3
NTU3NjI4OTMwOTk5LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAw
LCBlbiA9IDEpLA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5MzEyNjgsIGlycSA9IDE2NSwgZm4gPSBk
d2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ID4gKHRpbWUgPSA0NzU1NzYy
ODkzMjM4MywgaXJxID0gMTY1LCBmbiA9IGR3YzNfaW50ZXJydXB0LCBsYXRlbmN5ID0gMCwgZW4g
PSAxKSwNCj4gPiAodGltZSA9IDQ3NTU3NjI4OTMyNjUyLCBpcnEgPSAxNjUsIGZuID0gZHdjM19p
bnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDMpLA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5MzM3
NjgsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSks
DQo+ID4gKHRpbWUgPSA0NzU1NzYyODkzNDAzNywgaXJxID0gMTY1LCBmbiA9IGR3YzNfaW50ZXJy
dXB0LCBsYXRlbmN5ID0gMCwgZW4gPSAzKSwNCj4gPiAodGltZSA9IDQ3NTU3NjI4OTM1MTUyLCBp
cnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+
ICh0aW1lID0gNDc1NTc2Mjg5MzU0NjAsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwg
bGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ID4gKHRpbWUgPSA0NzU1NzYyODkzNjU3NSwgaXJxID0g
MTY1LCBmbiA9IGR3YzNfaW50ZXJydXB0LCBsYXRlbmN5ID0gMCwgZW4gPSAxKSwNCj4gPiAodGlt
ZSA9IDQ3NTU3NjI4OTM2ODQ1LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVu
Y3kgPSAwLCBlbiA9IDMpLA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5Mzc5NjAsIGlycSA9IDE2NSwg
Zm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ID4gKHRpbWUgPSA0
NzU1NzYyODkzODIyOSwgaXJxID0gMTY1LCBmbiA9IGR3YzNfaW50ZXJydXB0LCBsYXRlbmN5ID0g
MCwgZW4gPSAzKSwNCj4gPiAodGltZSA9IDQ3NTU3NjI4OTM5MzQ1LCBpcnEgPSAxNjUsIGZuID0g
ZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+ICh0aW1lID0gNDc1NTc2
Mjg5Mzk2NTIsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVu
ID0gMyksDQo+ID4gKHRpbWUgPSA0NzU1NzYyODk0MDc2OCwgaXJxID0gMTY1LCBmbiA9IGR3YzNf
aW50ZXJydXB0LCBsYXRlbmN5ID0gMCwgZW4gPSAxKSwNCj4gPiAodGltZSA9IDQ3NTU3NjI4OTQx
MDM3LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDMp
LA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5NDIxNTIsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVy
cnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ID4gKHRpbWUgPSA0NzU1NzYyODk0MjQyMiwg
aXJxID0gMTY1LCBmbiA9IGR3YzNfaW50ZXJydXB0LCBsYXRlbmN5ID0gMCwgZW4gPSAzKSwNCj4g
PiAodGltZSA9IDQ3NTU3NjI4OTQzNTM3LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQs
IGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5NDM4MDYsIGlycSA9
IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ID4gKHRp
bWUgPSA0NzU1NzYyODk0NDkyMiwgaXJxID0gMTY1LCBmbiA9IGR3YzNfaW50ZXJydXB0LCBsYXRl
bmN5ID0gMCwgZW4gPSAxKSwNCj4gPiAodGltZSA9IDQ3NTU3NjI4OTQ1MjI5LCBpcnEgPSAxNjUs
IGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDMpLA0KPiA+ICh0aW1lID0g
NDc1NTc2Mjg5NDYzNDUsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9
IDAsIGVuID0gMSksDQo+ID4gKHRpbWUgPSA0NzU1NzYyODk0NjYxNCwgaXJxID0gMTY1LCBmbiA9
IGR3YzNfaW50ZXJydXB0LCBsYXRlbmN5ID0gMCwgZW4gPSAzKSwNCj4gPiAodGltZSA9IDQ3NTU3
NjI4OTQ3NzI5LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBl
biA9IDEpLA0KPiA+ICh0aW1lID0gNDc1NTc2Mjg5NDc5OTksIGlycSA9IDE2NSwgZm4gPSBkd2Mz
X2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSmFlSHVuIEp1bmcgPGpoMDgwMS5qdW5nQHNhbXN1bmcuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNSArKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4g
aW5kZXggNzg5OTc2NTY3ZjlmLi41ZDJkNWE5Yjk5MTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gPiBAQCAtNDM1NSw4ICs0MzU1LDExIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNr
X2V2ZW50X2J1ZihzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gPiAgCSAqIGlycSBl
dmVudCBoYW5kbGVyIGNvbXBsZXRlcyBiZWZvcmUgY2FjaGluZyBuZXcgZXZlbnQgdG8gcHJldmVu
dA0KPiA+ICAJICogbG9zaW5nIGV2ZW50cy4NCj4gPiAgCSAqLw0KPiA+IC0JaWYgKGV2dC0+Zmxh
Z3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4gKwlpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZF
TlRfUEVORElORykgew0KPiA+ICsJCWlmICghZXZ0LT5jb3VudCkNCj4gPiArCQkJZXZ0LT5mbGFn
cyAmPSB+RFdDM19FVkVOVF9QRU5ESU5HOw0KPiA+ICAJCXJldHVybiBJUlFfSEFORExFRDsNCj4g
PiArCX0NCj4gPiAgDQo+ID4gIAljb3VudCA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dF
Vk5UQ09VTlQoMCkpOw0KPiA+ICAJY291bnQgJj0gRFdDM19HRVZOVENPVU5UX01BU0s7DQo+ID4g
LS0gDQo+ID4gMi4zMS4xDQo+ID4g
