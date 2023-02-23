Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FD6A10FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBWUD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWUDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:03:24 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94F15543;
        Thu, 23 Feb 2023 12:03:21 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NJtW9C012705;
        Thu, 23 Feb 2023 12:03:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=7LDSPL5amzjQlUbffQ0V5vsxz/7jNiQnnoMz7lOHrCc=;
 b=XXP8wwYFy2aM9+kco1/4ebGGVfLMppsBp9/ND7BMMgXHN3vhHKxAxaBEMNvWxoeTRV6K
 LMf9/ESoi0qjwzsvBy7wWJuodbO8W9nFxBQHQMsnOqMzRm6Bi3JlBtqt7Bsr5iwIyfes
 L5Nv5XiFdeki9VnuG2C8I2FtDHKKD+4Wnhcg4al9y9+YTkBONxNxPIYr+ZB4snobvRfu
 6ae4G6d1w1QBwDCoQHP2JLhFH7XrqMOjWFPwuxmYZothD6w+wGeTkbKC3fLPFuzj9N75
 NeUTu7d1SvheKAL47Mjq7ihbpgoF9BHCj2o6ewLpUy6ewhxtyf1557T+RQWsixxvdJ4P nA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nwyr4sa9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:03:17 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 527F0C00E0;
        Thu, 23 Feb 2023 20:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677182596; bh=7LDSPL5amzjQlUbffQ0V5vsxz/7jNiQnnoMz7lOHrCc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bJz/B7OfqTIJ0ITwV6rdvoTl1IMrQEVDtMR+TH4YjW1OQ38Hrh+qkGeVQiFgj1xKe
         FVtKF3s6iXq4aL49Q38VU29v5oWMH1UaWegJiUigOM/UqhGRi1h5FZMKajtU5TnPHj
         X1xnaKQtQZOpyU1nuGgBrUqyd/1aClssto1GO3y/1oEPmV4z6jPY+BnXtUySeU40fj
         BhbQ5XAGz89efGPH+IOXWJND/fPNhoP0EiJ5QaA5AKVCVZ5597xnXQ0fS3MQJHml0q
         zwp/XgIx2XLSyUz0QLh/32iFlWWTCz5jTFMezHmZKIFIqf+nd4nDOOnWYkSuWIVahe
         R+fEMYNrRuuwg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3230AA005C;
        Thu, 23 Feb 2023 20:03:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FF1240042;
        Thu, 23 Feb 2023 20:03:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cSWvmswx";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg9dAQp8f7U8NqgF9/28WgBJcsPQUXLrapxmJxPTDjpO6Je+u0VuTO/hvBekiNIu2fBGcBAPY1b5ttd6lhbQojkCGXrXe6BkDFZ2iTQHHNjw2z9W8krGq5QMrizINlwsK8chyVX1GBLULv4Nb+3ZINf38f0/BpWYf5+UIGGY3g/cGA47yu15+YkFPuuo+pcAWOKr+0f/+/Q0OFBV8B9N/IxtnD/4hFWpgwTUA6uKIRF9Wpt8DBp9yG3pNpQQENb8y06N+4Ceoi31kbKxC1NseqaVQoWuBuGcwYU1fkpsIQlxXKxJG+xBa11wz7sFsCUq6vxPoLpH7OMHpyMgD4lb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LDSPL5amzjQlUbffQ0V5vsxz/7jNiQnnoMz7lOHrCc=;
 b=gpNtDInfPb6jrNyAyN+xzMKde6VJes/ZMBgo8LTPge0mo+GqEMP10DboyjfDMoFsC77TrodTQTKBpCa1Q09RHtMh7/9Ju2ubGYtrghOE7rqbHRqJ7C0Uq0FKIDngGj+d0GYdi48Rme4jTtXtMxNu9+kXsBRgyADwzzZfmTE3hpKod6Zfy8HE3xzQLt63TIzS0QMw54hOKbwWHUlshIObT/1fe8XTGTgiDgDBuoUrRzuUwaLa1lwaG+I7/4+1lm5BCylo88l4r1ISpL1p+l2KljVA2Xtgwg/SOM8peIicQoxWQ6amVBj9vMuvaNngjz0r+ZME+Hefscw4sRd27UZttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LDSPL5amzjQlUbffQ0V5vsxz/7jNiQnnoMz7lOHrCc=;
 b=cSWvmswxatD8M/Qkyn4q612fvUqiunIoZqGWv2aJLQqOf+bi6IL8S3DGaCGEiU2hhR1tBRroMEZ7KYZHgpcfiJA1whcNjEWhCDgfyv6BIuByAGISsgiAqPIFSnRjvq7UtPW1EKwfMz+eJmAtZWi9CJqVmMGfwwkevBG1MogEbxQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 20:03:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 20:03:04 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: gadget: Change condition for processing
 suspend event
Thread-Topic: [PATCH v3 1/2] usb: dwc3: gadget: Change condition for
 processing suspend event
Thread-Index: AQHZR4RHez4eiqYtXEaqUG+ZCHSpQK7c9KAA
Date:   Thu, 23 Feb 2023 20:03:04 +0000
Message-ID: <20230223200300.pnn3vadcqw3olwbk@synopsys.com>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-2-git-send-email-quic_prashk@quicinc.com>
In-Reply-To: <1677156121-30364-2-git-send-email-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6767:EE_
x-ms-office365-filtering-correlation-id: 29b7f752-5292-4df8-1cd3-08db15d8f937
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbeg+Zw5eO+P0bPJBnMtjStjZ7SEwrM5Nt6hyy20tdn8GNusqYkW2OZpb/LeUy0eIVzIwWYOTKXjZ2w5D0ulBCAw1QfuX3wiQX0X7t7lCTZPfTa6xoLHC5KP8NET42SqItQBNZ13ATyAeF2er8mPmQSPvqj8hDaAb6sv3L3YoYvztlTPHeu+FVimxcQd1gjWmPE0hGC904MFOioxz2meZJIHdomD9GOzdoLIPaDiSRXzVUJ0hTJYtqTkRLWjJHcrL+ztweL7JUNu8U4sltF3Am0PRdNBCRLOoZiT+7KuqXtMdDrP+NbeVl18Qx4zgzl6kWYc7g9sZkuwzaj0bfqh6hjqyUQXbpx87JkbeKebtdqkb4xyFyJcOyGQeq4R7/polp7UpyzZs+1A0WMY62M1UtgiN+nKA3tfmUXfVtRkKz7CuH6aDO1PdpRIydk/1qwsBkBJ9fBumoLcT4IyQZJMItrF9H4kTuX5kdNUc+HREMrU9lRxxWp6QVtTmNuyMIxNugu/v0aXUhFNWz64aU3gfwxohRyt9z82X8zHbGt4wQIetPtn3UdmsTBMxTTFK9GeMjpqsTM2sQtHbGZRJ1I9OzIm0eEoEx/D5ZGGkdfKQk4aP/+664pPyB7Id+ItFyvOXmDy7gBxn+iLwf6DV5aMLtNts22aAKcYjBW84R6TM+XK3hUb2Dc32QbojrlOfrDlphsYeOpXhuWKABVBn1QAfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(86362001)(2906002)(15650500001)(38100700002)(122000001)(6486002)(478600001)(71200400001)(186003)(26005)(36756003)(38070700005)(6512007)(76116006)(66476007)(66446008)(64756008)(83380400001)(54906003)(66556008)(66946007)(41300700001)(6916009)(4326008)(2616005)(6506007)(1076003)(316002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09HMzNqUEZmVjQzQ3ZIQnhmZ1Z2YlFvcExzU3ZBNkhhbFhiWnFCSjQ1T0I0?=
 =?utf-8?B?aFUvbDNoWmtidjBMeG5aVVltZTQ2OUFjOXR5MWNxNll2R2NNQVBaMVlqSkRp?=
 =?utf-8?B?Z21iV1dEZDZNYVNXcmIrZkF6VTZON0NwTWtuS2NaSEhhdnJ6MVd4aVU1V3VP?=
 =?utf-8?B?azFVamNNSHE4c3g1TEdzY2QrOWJFNnd2eHNGNHVRdW5MVnBuMnB5TTUyU3gr?=
 =?utf-8?B?WmFzVjhhQldQVWU1a3QremJiMlBha3V1Um9zTGxNQlJaOEk1V0FDK2pLdEdD?=
 =?utf-8?B?eUl3R09hcWNwYzlGL1g1Q0ZkeFNmcjJuc2loQlVZM0MvQWJVcUhScGlDbGlz?=
 =?utf-8?B?aXlMb0JNUnVITkhKT3Z4eWFQUUJtaWRqT0EzeWw2eCt6WGw0Sy80WnA2aE9u?=
 =?utf-8?B?V0JJOXpkbWc2cnJGRmZVamFVQ0FpVit1aFRWUnZ6aGdrdllETGRLS0RnOHhQ?=
 =?utf-8?B?QTkvb1kydU5EZnpUZU5qTXJvVzdOQlRhZU9ud1JUekZwUE5wUURTRi9BdEQ3?=
 =?utf-8?B?YWk4eUlwTDVmaE9LakRKdW9Mdkdvd1BCSmcwRXNjc1NWOHY2c2ZtZnR3b0hj?=
 =?utf-8?B?bjRkUk9MTHNGODNjWWd6c212YmZQb3VyMlJsM25tQmtnVUJJSlY3bUsvbkQx?=
 =?utf-8?B?a2diS2YzUng4OGZ3U2ZLU1R2REFLREZ4UFFMU2VpUDdjc1lQU3VFVGV0cE9Z?=
 =?utf-8?B?bjJ5TEtEVU9qRzBRU2V6MXh3U1VzVTZOOEYrM2p4UnRtMEVmWFRXWEZ3YytB?=
 =?utf-8?B?QmQwZmNucHNJT1RGTlNTb2EzWW1mcjVQVEJVUU50dHhMaWxjYjdXZzRpVnZ5?=
 =?utf-8?B?cWo4RDUxR1ZyWXBsdGd6NVJ5KzAzRmllMFdZQzJjODk0eFI3cS9iRFd2eHlr?=
 =?utf-8?B?OXp4RFE3bktoV3BraXNkcUJLakRCbDlNekZiVlkwRGxZMG8xZUh0TThVU3M2?=
 =?utf-8?B?bzVmdU15TTI4dmxFYWVWMWdlMlVtQ0xrYUc1cjZrQzdVQm9pVmZZeFB1MmxO?=
 =?utf-8?B?c1VTU3FwdkMyK1hRKzVmVTQzSTNUMUkwb1ltUDdWU0V6WXQ2RWVWOVV2bVg0?=
 =?utf-8?B?MzkwTmtjeUl4NTF6MEtjeGp4VWhPbDJTbEc1WGpWUnNha3JMN1FQRStaNTlE?=
 =?utf-8?B?QXNndHRLbmNKWVl0Y3R5TDdWR0lCYXh4TVF3OGtvQS83WXhwL3gwRkZCYkVo?=
 =?utf-8?B?SlczWkFjZDV6cHZ5WGJiMm51dC9UYlJPODFkT2JzWG1Fa05pcnpqOGpHd2pF?=
 =?utf-8?B?YmJmdENIL2dwMVZFbWNpR3NLbWFpSnhLUjRyeklBQkFTZEUwQURTMHJvQTZM?=
 =?utf-8?B?K2FPVUx2VWtiWWZHNm1TNUt1eDhrZko2d2ZIMU83d3paMkV3K1hxQWVZNndj?=
 =?utf-8?B?STN2L2pFUHZJQ1FLdlBEVFYrMVlhZXpQZWVuMkVOTUVIUitrTUdQWW92MTlU?=
 =?utf-8?B?aGNXMmxUTDRjZGZsdmJUaHBFVEo2Q01GaTM1QXBUR0lpb0krMThGSzVucmlX?=
 =?utf-8?B?VnZiOVNnNUFOWDl3NnNWR3hJU1hEOXIyV2laV0xMK2oveDRJUHJpL1NESm1R?=
 =?utf-8?B?QTlrOXBzQjZjdG9QdHlSRkVnMHVIM1lpRFlkaERlbTVDbHppdlE5MFVOL0RE?=
 =?utf-8?B?ZDc3SmxseGVSSmVreHcrbXFsTnNzZmhxaXZFejZ5YyszSGQzdi9TRE93dnJC?=
 =?utf-8?B?dytZODdRK21HaVQzNkZHenhid3lMd1Y1YUIrT2ZBQlBKajhsRHFWaXlSc05G?=
 =?utf-8?B?K1dmTWJUVmxESElIRzVyTkRiRU9xNmx5bEFtOXhtV3owSVpxM2M2aEZxZjlr?=
 =?utf-8?B?emZobDF5ckl4VEdaeFNaaDNsNlZKRjk2a1lqM20ycDBISGx6S1U2ZHhQOFM3?=
 =?utf-8?B?QXl2MGROMDlXTThiSDhCcTc5TjBXYVVGcEFlVERPckp0ZjRHL3FjbmVoWmRl?=
 =?utf-8?B?SlZUM215ZTBTYXk1U1JPbHhJK2hCWE8vblJnbDBZS1p4VENybU9CRTQ0N2lp?=
 =?utf-8?B?cTNtNmU0M2pSNGlBRHhUSUVDZWFxWVBSSGJLK282UkFnOFlheHNTOHZKL3Rr?=
 =?utf-8?B?NXhsTlg0ZkhadGJLR2VIZVo2eWUwWXRsSWh5NjFibS9NQWlRVVh4SCtVeHQ4?=
 =?utf-8?Q?nexNkgR15e1ixyvtwluJRx/mz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7FA11135121FF49B3F6AF12E67BD4C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cE1xTUx3MHF5TVNzMjNVOFRrYW5IRDE0VVNDR1h5UnZLU25ZVmRJckQ3RnF3?=
 =?utf-8?B?VHB3M0ZGUER0Tmp5WkRRU3RxVzFjWUo5VW90N0dJRFZ1ZHdsLzRHRHc0QzA2?=
 =?utf-8?B?b05FWUpEY0pFOTlSU0xxd051dWttTGNuRVJWTzF4SEZYeG9XRm1HVSsyWmdM?=
 =?utf-8?B?MHdBSEVUVU9rRGZ2VHAxOG1maW50QThGMjJBOGg2eW9aRlloeUlBSVhqWDVD?=
 =?utf-8?B?Y2ZEYXdCUUwySkkzWkR2TzVJZVpTOGFDaXFwWlFMcy9wQXhUOWdlWVcxK0pR?=
 =?utf-8?B?TW1BMUNqdC9MNk1uNDFhcHNNNGhjN1IvN01ENzhVTG9hT2E2YzlJZlA5YjFp?=
 =?utf-8?B?aGJOTGVqZlJpM1NqVU9QQUFnMTczU1VTMGhjV3NrMmUram1IcllYVTFQeUJ5?=
 =?utf-8?B?UEpsT3Y2bGNrdGwyQTNBY3NUY3oySUkrM0lkd1ZWTzRrbWcvY0drUDNVMnp4?=
 =?utf-8?B?Zjl4Vkk1MEFwWHhJcU5KN1V6dkRzV2RWOFRFc0tudzgwOTgxeVc2ZDNzRm5D?=
 =?utf-8?B?Y3MzZHc2NEYybld0a3dDRDlScVJxMG56U3NVZ2pBajA2TVh3VVp3czBMSmk3?=
 =?utf-8?B?bzEyT0VBMlE2UTRHUDUyYlN5MnA3bUJiZEFZcHZEazA4Y20yZHZDR3JTV3RQ?=
 =?utf-8?B?YnlxaUJ4RmR6bk1yQUtBa3d4N2EzYS9wY1NXVG1xbS9UUVNmMXpMNEJvWGxM?=
 =?utf-8?B?T0dBZ1ZFNjRnTVN6eEkrYzdpVFBlZkY3QmJMcjd0WWQ0Wm1ma2wyVjM4V3dT?=
 =?utf-8?B?OEdSOXhScGh5MTJkNmFmcTQ5MENJbGJFcUlHVVphMUdsVC80V3h3LzZTNllU?=
 =?utf-8?B?ZXZldkg1WUxiZW90emxOSk80UlNuR2VCS1E0SHFoSlUrZXVmekpGbEZvYmYw?=
 =?utf-8?B?aUtBYlVOcktsVG1rT0ViMEM4RWlSTlVwazZtWExhdVErRlNoTGhjblNpNzJX?=
 =?utf-8?B?dzlzcTJKZ3JHL21ZdU5uWkwydkJqREtrN3Z6Wlp0bGIxSUhYME8zRWZLc1hl?=
 =?utf-8?B?Y05aM1VORlR2Ky9aNkdCRm9yR29POTdJZHA4Um0xemR0OTlXeXNUMll6S1Ev?=
 =?utf-8?B?Z1JtOXRRNGwzS3A2YWFoVzVQbjczMHRBeWRRRHNjaFN1MTBMMFg2QUZZSmlT?=
 =?utf-8?B?c2RsbVVYL1c2Y0dqVlVycG5xOFpPUEFiQUp4L2FJSDc5ZjhMQlVucXIwU1ll?=
 =?utf-8?B?ODR5dTQ2aS9BMWRGWGN0anRPNmRjKzh2TitUTE05cmNoSERzVGZBK1Q5WHln?=
 =?utf-8?B?QTg0UDVZV3IvcVhFK1FWVnJJZHlFUjVVU2V0NlBqVjJNWVB0QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b7f752-5292-4df8-1cd3-08db15d8f937
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 20:03:04.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY7X/Vn9HFi7py+95WrkA8LpGQ/uHkPl2NZHKbaH/3v5eWWZ2hrVKEGHB/XoO57ylhryY5x320Ka18HVAeO4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
X-Proofpoint-GUID: ooGk1h-8_-8Ygt3ODxEw4rM7yGtwA-ni
X-Proofpoint-ORIG-GUID: ooGk1h-8_-8Ygt3ODxEw4rM7yGtwA-ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=851 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302230166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMjMsIDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgd2Ug
cHJvY2VzcyB0aGUgc3VzcGVuZCBpbnRlcnJ1cHQgZXZlbnQgb25seSBpZiB0aGUNCj4gZGV2aWNl
IGlzIGluIGNvbmZpZ3VyZWQgc3RhdGUuIENvbnNpZGVyIGEgY2FzZSB3aGVyZSBkZXZpY2UNCj4g
aXMgbm90IGNvbmZpZ3VyZWQgYW5kIGdvdCBzdXNwZW5kIGludGVycnVwdCwgaW4gdGhhdCBjYXNl
IG91cg0KPiBnYWRnZXQgd2lsbCBzdGlsbCB1c2UgMTAwbUEgYXMgY29tcG9zaXRlX3N1c3BlbmQg
ZGlkbid0IGhhcHBlbi4NCj4gQnV0IGJhdHRlcnkgY2hhcmdpbmcgc3BlY2lmaWNhdGlvbiAoQkMx
LjIpIGV4cGVjdHMgYSBkb3duc3RyZWFtDQo+IGRldmljZSB0byBkcmF3IGxlc3MgdGhhbiAyLjVt
QSB3aGVuIHVuY29ubmVjdGVkIE9SIHN1c3BlbmRlZC4NCj4gDQo+IEZpeCB0aGlzIGJ5IHJlbW92
aW5nIHRoZSBjb25kaXRpb24gZm9yIHByb2Nlc3Npbmcgc3VzcGVuZCBldmVudCwNCj4gYW5kIHRo
dXMgY29tcG9zaXRlX3Jlc3VtZSB3b3VsZCBzZXQgdmJ1cyBkcmF3IHRvIDIuDQo+IA0KPiBGaXhl
czogNzI3MDRmODc2ZjUwICgiZHdjMzogZ2FkZ2V0OiBJbXBsZW1lbnQgdGhlIHN1c3BlbmQgZW50
cnkgZXZlbnQgaGFuZGxlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFByYXNoYW50aCBLIDxxdWljX3By
YXNoa0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwg
MTEgKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODlkY2ZhYy4uYTgzZjM0ZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IEBAIC00MjQxLDE1ICs0MjQxLDggQEAgc3RhdGljIHZvaWQgZHdj
M19nYWRnZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCWJyZWFrOw0KPiAgCWNh
c2UgRFdDM19ERVZJQ0VfRVZFTlRfU1VTUEVORDoNCj4gIAkJLyogSXQgY2hhbmdlZCB0byBiZSBz
dXNwZW5kIGV2ZW50IGZvciB2ZXJzaW9uIDIuMzBhIGFuZCBhYm92ZSAqLw0KPiAtCQlpZiAoIURX
QzNfVkVSX0lTX1BSSU9SKERXQzMsIDIzMEEpKSB7DQo+IC0JCQkvKg0KPiAtCQkJICogSWdub3Jl
IHN1c3BlbmQgZXZlbnQgdW50aWwgdGhlIGdhZGdldCBlbnRlcnMgaW50bw0KPiAtCQkJICogVVNC
X1NUQVRFX0NPTkZJR1VSRUQgc3RhdGUuDQo+IC0JCQkgKi8NCj4gLQkJCWlmIChkd2MtPmdhZGdl
dC0+c3RhdGUgPj0gVVNCX1NUQVRFX0NPTkZJR1VSRUQpDQo+IC0JCQkJZHdjM19nYWRnZXRfc3Vz
cGVuZF9pbnRlcnJ1cHQoZHdjLA0KPiAtCQkJCQkJZXZlbnQtPmV2ZW50X2luZm8pOw0KPiAtCQl9
DQo+ICsJCWlmICghRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjMwQSkpDQo+ICsJCQlkd2MzX2dh
ZGdldF9zdXNwZW5kX2ludGVycnVwdChkd2MsIGV2ZW50LT5ldmVudF9pbmZvKTsNCj4gIAkJYnJl
YWs7DQo+ICAJY2FzZSBEV0MzX0RFVklDRV9FVkVOVF9TT0Y6DQo+ICAJY2FzZSBEV0MzX0RFVklD
RV9FVkVOVF9FUlJBVElDX0VSUk9SOg0KPiAtLSANCj4gMi43LjQNCj4gDQoNCkFja2VkLWJ5OiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
