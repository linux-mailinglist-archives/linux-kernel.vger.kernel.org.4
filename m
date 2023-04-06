Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3B6D8CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjDFBib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjDFBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:38:29 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D16A45;
        Wed,  5 Apr 2023 18:38:27 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3361FI27007654;
        Wed, 5 Apr 2023 18:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=IpivrTDou2Z+WObLK3W0rs7OlJZqidWulMeQlkoDIno=;
 b=FgweaI3DRmsDhc7I7TqRTotjCmzrIcoRVoo+2bgCuzUASTfbv2ZGsjNBqFR+F3YUrrJO
 cRBMdBIoyh0sCg94+7zOKHek0BX3g0utjSZaG4CHXjzKG1IydHn4zrZAd/yBjAOdYZAY
 1tTg279SVbYZPE1JMYICLY4/88lSspgLdffgEPpUob0tSkTCD/yfuB0Cfi8oVspbCqz2
 JLkGFtA6rr4H7MFz3+Is/qH7yMkPUAgDrlpo4aMV5XRDgYhVBRS7lcJmeYqC6NgWm91C
 6v1ICthpNhjdbEq/xlao6byilfGBFFfzolsEWdU4B1d0JAK/9dDtCYS0Yge5Q2moiy4h 4w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv97h41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 18:38:16 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2B57C04C2;
        Thu,  6 Apr 2023 01:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680745096; bh=IpivrTDou2Z+WObLK3W0rs7OlJZqidWulMeQlkoDIno=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kqGgdPBQTUaWtXyPhYXxe9oDREN8avm1wlgrpiTL01y6VzX/eDwmhhjvfQYW6PC4p
         gs7o7/Y+iMmUWMs+hdxAzWMFk7JwBG/T2V7qkTtOhPcMfdyT7Iy/LoKJUPEPVm5U06
         dOdjLl/0fGChw9qCeQlrY55AJOHqtux8sAulLJYJaq4yIRwfvR8k+oUYc1nGmTDRdM
         xTLClt6cEiNFaXSpk4BK37IgtRqNburGQSB6W7hHxhCEEJypyV/hUqhuXxsHDDszyE
         VJC3T0mA5uIN82ofMNAoDqeTyEfHrLwBGYmlIh3CLsbbsPCbU8iqS7KUOIqJbyHgun
         Nwip6Kz6flMsw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CBB07A0071;
        Thu,  6 Apr 2023 01:38:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 013F680095;
        Thu,  6 Apr 2023 01:38:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uDb4Hm4q";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjTV4PsJhQbCizihbXKBTN3hxQ+QDhe5UECgGO54Al0f3sGgHEmIS/HrBys0D7cB2+M/GrZREENUCnRTEwYQbe4wcsDRLjcyg6Xp72FQpY4c9aTScxe8dsIVi961pPWm1D7nktbyfesQi3MrelmKPkbecQyIeK4JbGk8eQxkxYFV/+enZHXm18+S+mJyok9RbrlMlb0cZLC2BltQjZS04sonlmu/6MbaLB97YEIWEPy11IQdlQ5cJdpCpQ6bm+27DUBaF6GiC0Kj7qW31gX6EWwVdH5Gssv35B7DFfD9O+dlxbC5wixgQuVhbym4ZemTYpUE3Md27gUMb2krph2Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpivrTDou2Z+WObLK3W0rs7OlJZqidWulMeQlkoDIno=;
 b=BH3mIdBFetkfbDUOinUQVe+MpC2hlNQM0Fd+pazKgIwlHOKovuB6/3hrCSd1cRs7r8QnwJwGqOnQDzJSy/8Pw+B2W0UZ4TGa5M84Mpd9uHSsiK+fxBo+4LN07X+XNHka9q2N8YS2FAj1hvz2D4UVfXAbINGMwnxVSnIcKLzHDvz0t7qSwwBZNqYpAfVSqxcprI3sZ1oHd57zzUYBuKJ4SW/2EXEq4vK0cQ9w2DRxFqubGYrM6uusCSvfHMNsg5Ulnffgn+pXDj7x5Ds647ypTZjVmYxHeQAHrSGdq0sYkRMGZryyNEoq0DwWkStughlhSiCHq5KniCqoy9ARu4wjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpivrTDou2Z+WObLK3W0rs7OlJZqidWulMeQlkoDIno=;
 b=uDb4Hm4qeUgIqSpmVQnhrSGqZTvCZEkUxHwrqnyPg7qQCOWb3RTMQf7DQCz2cQbDQg4yuQ1msueR1pQT//yLknKZAFbivfVtgzbTZOhHJbZqPe5Q1ZiX5s04d93cSe6OiWBWoSq22oDFRG535iVnyGYVn/O/1GpLeN8Ubd2LoKQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 01:38:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 01:38:06 +0000
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
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueAgAB4pQCAAL6cgIAL7uaAgAWI6QCAAI0fAIAA6EWAgAC5X4CAARfCgA==
Date:   Thu, 6 Apr 2023 01:38:05 +0000
Message-ID: <20230406013803.x2fp6c3wpvqtbues@synopsys.com>
References: <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
 <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
 <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
 <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
 <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
 <8884129b-8c73-df1e-e342-01defce0d407@kernel.org>
In-Reply-To: <8884129b-8c73-df1e-e342-01defce0d407@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB7993:EE_
x-ms-office365-filtering-correlation-id: 0729b563-e7cf-4709-76e3-08db363f9157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4pcaD0DUyuSvoxzWiDMK4PAbOC3ZzpuCRqbZ5YUK4SXLygiasu4V25Q/CveoWMxD1AwNLHPTxEzbuys6EOcDMWrt36wCOYTYwD3HKUVlw5X8nOa24XLv/j1mgjDo0DgxzV34o6zVr+tleEujVR9nOSBtrBZ/3ryMQMg2ZLi8/+ExEiHM33bhSRvoJGb6mdGNdg/XsVwKZ79lkO3VKlIeBkUuHRKrWWy1hDSynagj4h8CLSeompbFS/IvjJrljXDxn2/jrBUZjYYDUTlMxDQD2xhAfDcpo1RVw2tJMLjQbEJR5wsParS8rKa2UGCCfLIZxPAM0ti7RCDTMPrbsUjKROwwbBIJXSjwtZ59ABzaC4UjvfYFfIcpsQb3NrYnVzZDgwmyo84fW1+f6eJkcPe9AnTf1lo6zN2V+XJmiQM9axHDHyYCsqio82zrZdQF24mHdCTR6+55jTIsZj1qJtvKHl6vUQl8f3BU23OiLDV+KzypzPEyivjomJCS0UbEWU7KEHIR7gqGtrUWldLemFRc1EZFD8m/pZDO4hWiHUECYVEWS606qpjwHPpGDJ0YrixLPi0KHmKpsmFZh8CaOdutY6nuLHXUtA9wLZ4xYbzNcQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(54906003)(478600001)(2906002)(71200400001)(38070700005)(966005)(6486002)(186003)(1076003)(6506007)(26005)(316002)(83380400001)(6512007)(2616005)(53546011)(66946007)(66476007)(5660300002)(122000001)(41300700001)(66556008)(76116006)(8676002)(4326008)(38100700002)(64756008)(66446008)(6916009)(8936002)(30864003)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXpjRm52WEV4SXBkZjYzZWtBNTZXVmpPWkhtSnNmVGF0cldlY3JsSWNsTWxI?=
 =?utf-8?B?R0tJb2NQUFdOM1lkMGNHZzVLVTNiZWt2MXpDdzJxOUpSNldxTEdUMUVDU21I?=
 =?utf-8?B?Ry9qNjg4UlcvTG1mbW5FVWluQytJNi83b3h0RUxtZzFaZFI1blVhSklUbi9w?=
 =?utf-8?B?dzNNWlNpcXJFWUwrQjlmVWNSVnpKM3JIdW9KekhiekhyV2tHNDE4bHM4dThB?=
 =?utf-8?B?eXA3SmNHRVlBVkNsaVpUT1FSc2pjeFJ1QVlzYVN3MllCQ2M2UFZrMDVxNVFy?=
 =?utf-8?B?ZDBFKzFQZHYzMC9MRERoSWZyTmVoTEZ2NzRJMk9WaWFjVmJHRW9hRVFNUW1D?=
 =?utf-8?B?b0l3bWJybGRFZk9kRVFEdDlralpPNFc3a3ZQY0VsYThFOS95b2hGZVdZYzM3?=
 =?utf-8?B?SitHU0J4QXhhSEk4YnMrcGNveVRKa2EzYUE5NW81OEYwUDArcEFYalBiY1dD?=
 =?utf-8?B?TGhla2RxOFZzdHBtNm5UNTQyaHZoWEc5S1dQWGUwWEpCMm9POTlZV1p3OXE1?=
 =?utf-8?B?RVRVTm9WR0k0b1pMUGNIY3lLdnNHUWhDU2o0Q25LbWE0Qm1xMEVaTlNrLzhD?=
 =?utf-8?B?SWJsWHVxdXhaZ2wzSnVzM3o4cHYvVS9kaWx2R0NKdnNKd2R1SEUyb2xCcS9R?=
 =?utf-8?B?a2xoNnJFcVlSdXZzeEtSeDNyamlCSkNUbzNIQkV6Y3M5eGs1eFM0VFZqN05m?=
 =?utf-8?B?THp5R0p5UGxtemZicEY4MHhXazVQSVU3QXJaWHZuajN3eUFMVlFaajZpR1p5?=
 =?utf-8?B?alFNZWZ5T2NVUjVBQ1IyNm4zYVBnbTlxQkkxVU53Zk9tWnlPU0IweHdzOUF3?=
 =?utf-8?B?SmpzZ1ZOenBwK0tEaG5YdDdwcUxJNkdDV2JYNThTWXphcUZQVkFhcU1URy9L?=
 =?utf-8?B?NE9YRDFWSXQvMVcySStTMnNRbUdUbGE2RHhjdHA0Z0ZJUnRWSzVGcjFoTjFQ?=
 =?utf-8?B?NXlCRGtmRDZ1L2h0SXRJMytSc2IwaVZTTnNYRElpMmk4STdBdHBpeEdHclFM?=
 =?utf-8?B?cnYrVUJxS1pmL2NxcHpEQSt1NkhJYVVCVU13em9lSEtyRW9CRUl5bkpQNW9K?=
 =?utf-8?B?QWdUQisrYkN3eXhyR21GRTJma24rclhkbXZoQTFjOS80V0lXOGJTQ2RHQi84?=
 =?utf-8?B?WCtNanRZUGdpOHh3b0NuK3pMbG1WckxuRE0wZm1iSUlnckxhSWZNaUZ2MHYz?=
 =?utf-8?B?dnpoR1NkNEczZ1VlODdpOGc2b2l2Q1JXSWFpQzY4bEtKTit3cDk0ZzMwbUNx?=
 =?utf-8?B?ZFdnRk50dldQMjEyRG1Lb0lpSFJxTGNjSnZWNzhMYlNSWUhhaFBVUkdpZDZj?=
 =?utf-8?B?T2dreW5SZU5HN1E1cVFwaU9QNzZIYS9hRFk5bUhZVWtNUk16UTB0RTl1WWdx?=
 =?utf-8?B?K1JyYkpscUY1N0kxNmNuY0U1cUxtdWNiTXdjS3lLV1djV0Q2SHJ5RkhDTSs2?=
 =?utf-8?B?OHE0ZzJUSWJWVjBmN3I0TDRUaFhvWEJ4V05ib0FHTTJJN1lORWtXOGF3TC9q?=
 =?utf-8?B?RUI3Nlpxa3VMZ2JHMHRVOGNpYlJZNUhvKzhFNEp6bFgvTnF0aFFuSm4yQmlz?=
 =?utf-8?B?QUc1RXl6Sm9ZeVVUcjJVM29DK2lnRVdnaVcvb2h0MnQ2eFR5cFlTOG9vQ1B5?=
 =?utf-8?B?TG5NekpjNTl1WGlRcU8yN1RXcVUvbld3M3Q2cnhXWllMbUlBZlJvSklXdWVB?=
 =?utf-8?B?cGFQVnZ4YXE0MWlSeXhqUkpoUXgwWE9yS2pjby8rVjU2NWRLRFNzLy9ScWw4?=
 =?utf-8?B?N3hURTdpK2pFSHA2UDJYcXJFRGdEUTY1SmRLa3F4OGd4V05XTUtVUTdyQU81?=
 =?utf-8?B?NFBNTW04V0ZISldseGZnZE9PY1NKN1laVmZQaWM0WTh1OGZlZEtKZTlKYlg4?=
 =?utf-8?B?VEVzZGs2cFFYbnF0ZTNuUXl6cXZKS1ZieERINCtVaVdHK0lwSk1kZVF6YlNy?=
 =?utf-8?B?S0g1bzI0cmxOMU9rUys4VFdxdDlNQkNYcjVnb3drN3FIbHU5Q2RVekFpVEpZ?=
 =?utf-8?B?b1RTWGk3Vks0RGZVUnVZeE1RSlBGK3ZtVVczOXBmV0dmTXFvUE85YzRWUXBw?=
 =?utf-8?B?MHMrKzE3dlNLNmVSSlF1dU5kbFlpY0s1aVZyMDY5TC9JK3FjOHM2SjBNWFl3?=
 =?utf-8?Q?8pFg+SX5Zk+adwydJ9Jc8NDAm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24CE890C8FF8DD4696E6FEFCFE8BF4C9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OERFZXJmMHVlR0FkcHhHbG55aXJJNEJEbE9DTUpoVTVjWWhWclJ3SWE4RGti?=
 =?utf-8?B?aGJLWFgwMzJwbkt0OHo3eXQxaU9icE9rbWp4YTdrNnRBaWhzZFkzYUlSR0tK?=
 =?utf-8?B?UUpsOTNvL3dYSzVHK3lHbVpvV0RiR1hCaXBGczFEa2F0TXR3SjZOWERPaHpM?=
 =?utf-8?B?S1pQb1d1M01MNHVnaXNMQ0U3d21tcE01eVdDeWpCamR0WUMxbzBDUWFtZlMz?=
 =?utf-8?B?YXNuT1h0SFUvYjZoNTFqRXUyemNNYzJiQjhoMFVSN2lRcXJZc2c3VHR2NkxL?=
 =?utf-8?B?QWxZU1huQmU4dzgycVFJeTRzRTJ5dE8wZGxFRkNBMk8wNmwzSU1zUEFLYjNT?=
 =?utf-8?B?eTNtMk5IZW5ueDZvckdxL3pHRDdFV056M3VicFliUGN4dFlDMVJtU0xZQ3dh?=
 =?utf-8?B?bnJQbFI1UnQ0OGZlTFg1QUxBNURnYUlLb01pWWFOVDBTZEM2OXY2SVI2emV2?=
 =?utf-8?B?QkNFYlREZFRNRk5DRDRBeUNXUlRINGo0NkNXSkVjMHg5V01LcWExTWJhdEli?=
 =?utf-8?B?cVRZWHM1NWVYK2FTZnZvcnlneW8wRWhYMVFab0lpRnMvaUM0S2Yzamo1SUJV?=
 =?utf-8?B?U0hYc3l5YmFOVlltd0d3c3JGMWx6T01hbnFER1dOMDRrc2FQUmZ4aE01SjhC?=
 =?utf-8?B?S1hKMk8zYmNrVzlwandpZ0tjRUwrTTREengvWGVDbFFNZXd2TXRiZ3BaL2h6?=
 =?utf-8?B?RVVXVXlpQnc3UWZFb2NoMHI5ck02QnB6L25VY3BoVTNwZ2p5eWNQRFg4MUNt?=
 =?utf-8?B?VVQyeDZBMlE3c3N1ei85cGZkRkxWcDQrbVAzb2xIazh4NDJkS0dQVEQyN29o?=
 =?utf-8?B?R0o2eGpXNGRvK056bDErVmhBb0VVQnhwQXVHMCt5bWVVRm5EeE05dm4vNW81?=
 =?utf-8?B?WXlPT0g1SGR1NVNvbkp4dUZ6V3VpMi9YNzYyeElXdFpQN3FqbDFWVVo5blg3?=
 =?utf-8?B?V2xiNFlQSmNZZUorV2wxY1N5U3RORHJXM1NrRjBrWUNIUlZYN05Ca052WnlF?=
 =?utf-8?B?N1JuTnJ3NlFocDcvUmN2RnM3S0xMakJacW1SV1BZOGhta2hIWEl3azVENS9j?=
 =?utf-8?B?SnNaSi9Vd0RDQzJJQTJDczBTQytoZVNBc1kzajdPa2F1Qi9YUUFCa0xhWmJZ?=
 =?utf-8?B?MndqSVh6Yk9pbHdRVU9ZN3RsbHVFYU5waVFtVmx4bFRBd0UyQ0pBRFk1WVl6?=
 =?utf-8?B?ZTc2UC9kcWZVOUdxUnJxU0ZkTU53eTFGRDhjelFHNzFBWnNMa3BGRVJwZHFP?=
 =?utf-8?B?VXp4Sis2VmVVODZwZ1FDZWx0a3lYMzhPMVlQbysrTmVQbzg1Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0729b563-e7cf-4709-76e3-08db363f9157
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 01:38:05.2081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWiZxRQg7UbVYkBD75eRLUKkCSAd23xTLruJJVA127WvWPAN9dIjts0y+X7PTYVs4aD8As0YPFwC2tLdAvUSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
X-Proofpoint-ORIG-GUID: JP-vhY_a-qu9Fafj_o5yD-14gvbv3klT
X-Proofpoint-GUID: JP-vhY_a-qu9Fafj_o5yD-14gvbv3klT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304060013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMDUsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MDUvMDQvMjAyMyAwMDo1MywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXByIDA0
LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAwNC8wNC8y
MDIzIDAyOjM3LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+PiBPbiBGcmksIE1hciAzMSwgMjAy
MywgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPj4+PiBIaSwNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIz
LzAzLzIwMjMgMjI6NTEsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4gT24gVGh1LCBNYXIg
MjMsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+IE9uIDIzLzAzLzIwMjMgMDQ6MTcsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+PiBP
biBXZWQsIE1hciAyMiwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+Pj4+PiBPbiBX
ZWQsIE1hciAyMiwgMjAyMywgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPj4+Pj4+Pj4+IE9uIDIx
LzAzLzIwMjMgMjE6MDUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+Pj4+PiBPbiBUdWUs
IE1hciAyMSwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+Pj4+Pj4+PiBPbiBUdWUs
IE1hciAyMSwgMjAyMywgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPj4+Pj4+Pj4+Pj4+IEhpIFRo
aW5oLA0KPiA+Pj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4+IE9uIDIwLzAzLzIwMjMgMjA6NTIs
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4+Pj4+Pj4+PiBIaSwNCj4gPj4+Pj4+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+Pj4+Pj4+IE9uIE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdy
b3RlOg0KPiA+Pj4+Pj4+Pj4+Pj4+PiBJbXBsZW1lbnQgJ3NucHMsZ2FkZ2V0LWtlZXAtY29ubmVj
dC1zeXMtc2xlZXAnIHByb3BlcnR5Lg0KPiA+Pj4+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+Pj4+
PiBEbyBub3Qgc3RvcCB0aGUgZ2FkZ2V0IGNvbnRyb2xsZXIgYW5kIGRpc2Nvbm5lY3QgaWYgdGhp
cw0KPiA+Pj4+Pj4+Pj4+Pj4+PiBwcm9wZXJ0eSBpcyBwcmVzZW50IGFuZCB3ZSBhcmUgY29ubmVj
dGVkIHRvIGEgVVNCIEhvc3QuDQo+ID4+Pj4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+Pj4+IFBy
ZXZlbnQgU3lzdGVtIHNsZWVwIGlmIEdhZGdldCBpcyBub3QgaW4gVVNCIHN1c3BlbmQuDQo+ID4+
Pj4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRy
b3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiA+Pj4+Pj4+Pj4+Pj4+PiAtLS0NCj4gPj4+Pj4+Pj4+
Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAyNSArKysrKysrKysrKysrKysrKysr
LS0tLS0tDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIg
KysNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyNSArKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4+Pj4+Pj4+Pj4+Pj4+DQo+ID4+
Pj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+Pj4+Pj4+Pj4+IGluZGV4IDQ3NmI2MzYxODUxMS4u
YTQ3YmJhYTI3MzAyIDEwMDY0NA0KPiA+Pj4+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiA+Pj4+Pj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiA+Pj4+Pj4+Pj4+Pj4+PiBAQCAtMTU3NSw2ICsxNTc1LDkgQEAgc3RhdGljIHZvaWQgZHdj
M19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgCWR3
Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+
Pj4+Pj4+Pj4+Pj4+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ID4+Pj4+Pj4+Pj4+
Pj4+ICANCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwlkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3Ns
ZWVwID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJ
CQkJInNucHMsZ2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAiKTsNCj4gPj4+Pj4+Pj4+Pj4+
Pj4gKw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgCWR3Yy0+bHBtX255ZXRfdGhyZXNob2xkID0gbHBtX255
ZXRfdGhyZXNob2xkOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgCWR3Yy0+dHhfZGVfZW1waGFzaXMgPSB0
eF9kZV9lbXBoYXNpczsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+Pj4+Pj4+PiBAQCAt
MjAyNywxNCArMjAzMCwyMCBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0
IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIHsNCj4gPj4+
Pj4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZCBsb25nCWZsYWdzOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgCXUz
MiByZWc7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJaW50IHJldDsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIA0K
PiA+Pj4+Pj4+Pj4+Pj4+PiAgCXN3aXRjaCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4+
Pj4+Pj4+Pj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFOg0KPiA+Pj4+Pj4+Pj4+
Pj4+PiAgCQlpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0KPiA+Pj4+Pj4+Pj4+
Pj4+PiAgCQkJYnJlYWs7DQo+ID4+Pj4+Pj4+Pj4+Pj4+IC0JCWR3YzNfZ2FkZ2V0X3N1c3BlbmQo
ZHdjKTsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0ID0gZHdjM19nYWRnZXRfc3VzcGVuZChkd2Mp
Ow0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQlpZiAocmV0KSB7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJCQlk
ZXZfZXJyKGR3Yy0+ZGV2LCAiZ2FkZ2V0IG5vdCBzdXNwZW5kZWQ6ICVkXG4iLCByZXQpOw0KPiA+
Pj4+Pj4+Pj4+Pj4+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJfQ0KPiA+
Pj4+Pj4+Pj4+Pj4+PiAgCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gPj4+
Pj4+Pj4+Pj4+Pj4gLQkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJ
aWYoIWR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXApDQo+ID4+Pj4+Pj4+Pj4+Pj4+
ICsJCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgCQlicmVhazsNCj4g
Pj4+Pj4+Pj4+Pj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gPj4+Pj4+Pj4+
Pj4+Pj4gIAkJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdj
LT5kZXYpKSB7DQo+ID4+Pj4+Pj4+Pj4+Pj4+IEBAIC0yMDg4LDExICsyMDk3LDE1IEBAIHN0YXRp
YyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBt
c2cpDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4+Pj4+Pj4gIAlzd2l0Y2ggKGR3Yy0+
Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICAJY2FzZSBEV0MzX0dDVExfUFJU
Q0FQX0RFVklDRToNCj4gPj4+Pj4+Pj4+Pj4+Pj4gLQkJcmV0ID0gZHdjM19jb3JlX2luaXRfZm9y
X3Jlc3VtZShkd2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAtCQlpZiAocmV0KQ0KPiA+Pj4+Pj4+Pj4+
Pj4+PiAtCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJaWYgKCFkd2MtPmdhZGdl
dF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQl7DQo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsJCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7DQo+ID4+
Pj4+Pj4+Pj4+Pj4+ICsJCQlpZiAocmV0KQ0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQkJCXJldHVybiBy
ZXQ7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJCWR3YzNfc2V0X3By
dGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwkJ
fQ0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+Pj4+IC0JCWR3YzNfc2V0X3BydGNh
cChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIAkJZHdj
M19nYWRnZXRfcmVzdW1lKGR3Yyk7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICAJCWJyZWFrOw0KPiA+Pj4+
Pj4+Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiA+Pj4+Pj4+Pj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaA0KPiA+Pj4+Pj4+Pj4+Pj4+PiBpbmRleCA1ODJlYmQ5Y2Y5YzIuLmY4NGJhYzgxNWJl
ZCAxMDA2NDQNCj4gPj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPj4+Pj4+
Pj4+Pj4+Pj4gQEAgLTEzMjgsNiArMTMyOCw4IEBAIHN0cnVjdCBkd2MzIHsNCj4gPj4+Pj4+Pj4+
Pj4+Pj4gIAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1aXJrOjE7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICAJ
dW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsJdW5zaWduZWQJCWdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwOjE7DQo+
ID4+Pj4+Pj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIAl1MTYJCQlpbW9kX2ludGVydmFs
Ow0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICAJaW50CQkJbWF4X2NmZ19l
cHM7DQo+ID4+Pj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+Pj4+Pj4+Pj4+Pj4+PiBpbmRleCAz
YzYzZmE5N2E2ODAuLjgwNjJlNDRmNjNmNiAxMDA2NDQNCj4gPj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+Pj4+Pj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+Pj4+Pj4+Pj4+Pj4+IEBAIC00NTcyLDEyICs0NTcyLDIz
IEBAIHZvaWQgZHdjM19nYWRnZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+
Pj4+PiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4+Pj4+
Pj4+Pj4+Pj4gIHsNCj4gPj4+Pj4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+
Pj4+Pj4+Pj4+Pj4+PiArCWludCBsaW5rX3N0YXRlOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgDQo+ID4+
Pj4+Pj4+Pj4+Pj4+ICAJaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIpDQo+ID4+Pj4+Pj4+Pj4+Pj4+
ICAJCXJldHVybiAwOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4+Pj4+IC0JZHdj
M19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiAr
CWlmIChkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwICYmIGR3Yy0+Y29ubmVjdGVk
KSB7DQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJCWxpbmtfc3RhdGUgPSBkd2MzX2dhZGdldF9nZXRfbGlu
a19zdGF0ZShkd2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQkvKiBQcmV2ZW50IFBNIFNsZWVwIGlm
IG5vdCBpbiBVMy9MMiAqLw0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQlpZiAobGlua19zdGF0ZSAhPSBE
V0MzX0xJTktfU1RBVEVfVTMpDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJCQlyZXR1cm4gLUVCVVNZOw0K
PiA+Pj4+Pj4+Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4+Pj4+Pj4+ICsJCS8qIGRvbid0IHN0b3AvZGlz
Y29ubmVjdCAqLw0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCQlkd2MzX2dhZGdldF9kaXNhYmxlX2lycShk
d2MpOw0KPiA+Pj4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+Pj4gV2Ugc2hvdWxkbid0IGRpc2Fi
bGUgZXZlbnQgaW50ZXJydXB0IGhlcmUuIFdoYXQgd2lsbCBoYXBwZW4gaWYgdGhlDQo+ID4+Pj4+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+Pj4gRHVlIHRvIHNvbWUgcmVhc29uLCBpZiBJIGRvbid0IGRp
c2FibGUgdGhlIGV2ZW50IGludGVycnVwdHMgaGVyZSB0aGVuDQo+ID4+Pj4+Pj4+Pj4+PiBhZnRl
ciBVU0IgcmVzdW1lIHRoZSBVU0IgY29udHJvbGxlciBpcyBtYWxmdW5jdGlvbmluZy4NCj4gPj4+
Pj4+Pj4+Pj4+IEl0IG5vIGxvbmdlciByZXNwb25kcyB0byBhbnkgcmVxdWVzdHMgZnJvbSBIb3N0
Lg0KPiA+Pj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+PiBZb3Ugc2hvdWxkIGxvb2sgaW50byB0aGlz
LiBUaGVzZSBldmVudHMgYXJlIGltcG9ydGFudCBhcyB0aGV5IGNhbiB0ZWxsDQo+ID4+Pj4+Pj4+
Pj4+IHdoZXRoZXIgdGhlIGhvc3QgaW5pdGlhdGVzIHJlc3VtZS4NCj4gPj4+Pj4+Pj4+Pj4NCj4g
Pj4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+Pj4gZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZCBhbmQg
cmVjb25uZWN0IHRvIHRoZSBob3N0IHdoaWxlIHRoZSBkZXZpY2UgaXMNCj4gPj4+Pj4+Pj4+Pj4+
PiBzdGlsbCBpbiBzeXN0ZW0gc3VzcGVuZD8gVGhlIGhvc3Qgd291bGQgbm90IGJlIGFibGUgdG8g
Y29tbXVuaWNhdGUgd2l0aA0KPiA+Pj4+Pj4+Pj4+Pj4+IHRoZSBkZXZpY2UgdGhlbi4NCj4gPj4+
Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+PiBJbiB0aGUgVEkgcGxhdGZvcm0sIFRoZSBzeXN0ZW0g
aXMgd29rZW4gdXAgb24gYW55IFZCVVMvbGluZXN0YXRlIGNoYW5nZQ0KPiA+Pj4+Pj4+Pj4+Pj4g
YW5kIGluIGR3YzNfZ2FkZ2V0X3Jlc3VtZSB3ZSBlbmFibGUgdGhlIGV2ZW50cyBhZ2FpbiBhbmQg
Y2hlY2sgZm9yIHBlbmRpbmcNCj4gPj4+Pj4+Pj4+Pj4+IGV2ZW50cy4gSXMgaXQgcG9pbnRsZXNz
IHRvIGNoZWNrIGZvciBwZW5kaW5nIGV2ZW50cyB0aGVyZT8NCj4gPj4+Pj4+Pj4+Pj4+DQo+ID4+
Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+IEl0IHNlZW1zIGZyYWdpbGUgZm9yIHRoZSBpbXBsZW1l
bnRhdGlvbiB0byBiZSBkZXBlbmRlbnQgb24gcGxhdGZvcm0NCj4gPj4+Pj4+Pj4+Pj4gc3BlY2lm
aWMgZmVhdHVyZSByaWdodD8NCj4gPj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+Pj4gQWxzbywgd2hh
dCB3aWxsIGhhcHBlbiBpbiBhIHR5cGljYWwgY2FzZSB3aGVuIHRoZSBob3N0IHB1dHMgdGhlIGRl
dmljZQ0KPiA+Pj4+Pj4+Pj4+PiBpbiBzdXNwZW5kIGFuZCBpbml0aWF0ZXMgcmVzdW1lIHdoaWxl
IHRoZSBkZXZpY2UgaXMgaW4gc3lzdGVtIHN1c3BlbmQNCj4gPj4+Pj4+Pj4+Pj4gKGFuZCBzdGF5
IGluIHN1c3BlbmQgb3ZlciBhIHBlcmlvZCBvZiB0aW1lKT8gVGhlcmUgaXMgbm8gVkJVUyBjaGFu
Z2UuDQo+ID4+Pj4+Pj4+Pj4+IFRoZXJlIHdpbGwgYmUgcHJvYmxlbSBpZiBob3N0IGRldGVjdHMg
bm8gcmVzcG9uc2UgZnJvbSBkZXZpY2UgaW4gdGltZS4NCj4gPj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4+Pj4gRG9uJ3Qgd2UgbmVlZCB0aGVzZSBldmVudHMgdG8gd2FrZXVwIHRoZSBkZXZpY2U/DQo+
ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gVGhhdCdzIHdoeSB0aGUgVEkgaW1wbGVtZW50YXRpb24g
aGFzIGxpbmUtc3RhdGUgY2hhbmdlIGRldGVjdGlvbiB0bw0KPiA+Pj4+Pj4+Pj4gZGV0ZWN0IGEg
VVNCIHJlc3VtZS4gV2UgYXJlIGRvaW5nIGEgb3V0LW9mLWJhbmQgd2FrZS11cC4gVGhlIHdha2Ug
dXANCj4gPj4+Pj4+Pj4+IGV2ZW50cyBhcmUgY29uZmlndXJlZCBpbiB0aGUgd3JhcHBlciBkcml2
ZXIgKGR3YzMtYW02Mi5jKS4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBEbyB5b3Uga25vdyBv
ZiBhbnkgZHdjMyBpbXBsZW1lbnRhdGlvbiB0aGF0IHVzZXMgaW4tYmFuZCBtZWNoYW5pc20NCj4g
Pj4+Pj4+Pj4+IHRvIHdha2UgdXAgdGhlIFN5c3RlbS4gaS5lLiBpdCByZWxpZXMgb24gZXZlbnRz
IGVuYWJsZWQgaW4gREVWVEVOIHJlZ2lzdGVyPw0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4NCj4g
Pj4+Pj4+Pj4gV2UgcmVseSBvbiBQTUUuIFRoZSBQTUUgaXMgZ2VuZXJhdGVkIGZyb20gdGhlIFBN
VSBvZiB0aGUgdXNiIGNvbnRyb2xsZXINCj4gPj4+Pj4+Pj4gd2hlbiBpdCBkZXRlY3RzIGEgcmVz
dW1lLiBJZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIGhpYmVybmF0aW9uIGFuZCBpZg0KPiA+Pj4+
Pj4+PiB0aGUgcmVzdW1lIHNpZ25hbCBpcyBjb25uZWN0ZWQgdG8gdGhlIGxvd2VyIGxheWVyIHBv
d2VyIG1hbmFnZXIgb2YgeW91cg0KPiA+Pj4+Pj4+PiBkZXZpY2UsIHRoZW4geW91IGNhbiB3YWtl
dXAgdGhlIHN5c3RlbSBvbmUgbGV2ZWwgYXQgYSB0aW1lLiBGb3IgZXhhbXBsZSwNCj4gPj4+Pj4+
Pj4gaWYgeW91ciBkZXZpY2UgaXMgYSBwY2kgZGV2aWNlLCB0aGF0IHdha2V1cCBzaWduYWwgd291
bGQgdGllIHRvIHRoZSBwY2kNCj4gPj4+Pj4+Pj4gcG93ZXIgbWFuYWdlciwgd2FraW5nIHVwIHRo
ZSBwY2kgbGF5ZXIgYmVmb3JlIHdha2luZyB1cCB0aGUgY29yZSBvZiB0aGUNCj4gPj4+Pj4+Pj4g
dXNiIGNvbnRyb2xsZXIuIFRoYXQncyBob3cgdGhlIGhvc3Qgd2FrZXMgdXAgdGhlIGhvc3Qgc3lz
dGVtIChlLmcuIGZyb20NCj4gPj4+Pj4+Pj4gcmVtb3RlIHdha2V1cCkuIEZvciB0aGlzIHRvIHdv
cmssIHdlIGV4cGVjdCBzb21ldGhpbmcgc2ltaWxhciBvbiB0aGUNCj4gPj4+Pj4+Pj4gZGV2aWNl
IHNpZGUuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4+PiBXZSBtYXkgbm90IGJlIGFibGUgdG8gc3VzcGVuZCBldmVyeXRoaW5nIGluIHN5c3RlbSBz
dXNwZW5kIGZvciB0aGlzDQo+ID4+Pj4+Pj4+Pj4gY2FzZS4gSSdtIHRoaW5raW5nIG9mIHRyZWF0
aW5nIHRoZXNlIGV2ZW50cyBhcyBpZiB0aGV5IGFyZSBQTUUgdG8gd2FrZXVwDQo+ID4+Pj4+Pj4+
Pj4gdGhlIGRldmljZSwgYnV0IHRoZXkgYXJlIG5vdCB0aGUgc2FtZS4gSXQgbWF5IG5vdCBiZSBz
aW1wbGUgdG8gaGFuZGxlDQo+ID4+Pj4+Pj4+Pj4gdGhpcy4gVGhlIGxvd2VyIGxheWVycyBtYXkg
bmVlZCB0byBzdGF5IGF3YWtlIGZvciB0aGUgZHdjMyB0byBoYW5kbGUNCj4gPj4+Pj4+Pj4+PiB0
aGVzZSBldmVudHMuIEhtLi4uIGl0IGdldHMgYSBiaXQgY29tcGxpY2F0ZWQuDQo+ID4+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+Pj4gQXMgd2UgYXJlIGdvaW5nIGludG8gc3VzcGVuZCwgd2UgYXJlIG5vdCBy
ZWFsbHkgaW4gYSBwb3NpdGlvbiB0byBoYW5kbGUgYW55DQo+ID4+Pj4+Pj4+PiAoREVWVEVOKSBl
dmVudHMgdGlsbCB3ZSBoYXZlIGZ1bGx5IHJlc3VtZWQuDQo+ID4+Pj4+Pj4+PiBTbyB5ZXMsIHdl
IG5lZWQgdG8gcmVseSBvbiBwbGF0Zm9ybSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiB0byB3YWtl
DQo+ID4+Pj4+Pj4+PiB0aGUgU3lzdGVtIG9uIGFueSBVU0IgZXZlbnQuDQo+ID4+Pj4+Pj4+Pg0K
PiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBZb3UgbWF5IGJlIGFibGUgdG8gZGV0ZWN0IHZidXMgY2hh
bmdlIHRocm91Z2ggdGhlIGNvbm5lY3RvciBjb250cm9sbGVyLg0KPiA+Pj4+Pj4+PiBIb3dldmVy
LCB0aGUgdXNiIGNvbnRyb2xsZXIgaXMgdGhlIG9uZSB0aGF0IGRldGVjdHMgaG9zdCByZXN1bWUu
IFdoYXQNCj4gPj4+Pj4+Pj4gcGxhdGZvcm0gc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gZG8geW91
IGhhdmUgb3V0c2lkZSBvZiB0aGUgdXNiDQo+ID4+Pj4+Pj4+IGNvbnRyb2xsZXIgZG8geW91IGhh
dmUgdG8gZ2V0IGFyb3VuZCB0aGF0Pw0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBJJ20gbm90IHN1
cmUgaWYgeW91ciBwbGF0Zm9ybSBzdXBwb3J0cyBoaWJlcm5hdGlvbiBvciBpZiB0aGUgUE1FIHNp
Z25hbA0KPiA+Pj4+Pj4+PiBvbiB5b3VyIHBsYXRmb3JtIGNhbiB3YWtldXAgdGhlIHN5c3RlbSwg
YnV0IGN1cnJlbnRseSBkd2MzIGRyaXZlcg0KPiA+Pj4+Pj4+PiBkb2Vzbid0IGhhbmRsZSBoaWJl
cm5hdGlvbiAoZGV2aWNlIHNpZGUpLiBJZiB0aGVyZSdzIG5vIGhpYmVybmF0aW9uLA0KPiA+Pj4+
Pj4+PiB0aGVyZSdzIG5vIFBNRS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBObywgaW4gdGhpcyBUSSBT
b0MsIGhpYmVybmF0aW9uIGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGUgZHdjMyBjb3Jl
Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEFjdHVhbGx5LCBJ
IHRoaW5rIHRoZSBkd2MzIGNvcmUgaXMgc3RpbGwgb24gZHVyaW5nIHN5c3RlbSBzdXNwZW5kIGZv
cg0KPiA+Pj4+Pj4+IHlvdSByaWdodD8gVGhlbiBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIHdha2V1
cCBldmVudCB0byB3YWtldXAgc3lzdGVtDQo+ID4+Pj4+Pj4gc3VzcGVuZCBvbiBob3N0IHJlc3Vt
ZT8gWW91IGNhbiBpZ25vcmUgYWJvdXQgUE1FIGluIHRoaXMgY2FzZS4gWW91IG1heQ0KPiA+Pj4+
Pj4+IG5lZWQgdG8gbG9vayBpbnRvIHdoYXQgbmVlZHMgc3RheSBhd2FrZSB0byBhbGxvdyBmb3Ig
aGFuZGxpbmcgb2YgdGhlDQo+ID4+Pj4+Pj4gZHdjMyBldmVudC4NCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBCdXQgaW4gU29DIGRlZXAtc2xlZXAgc3RhdGUsIGFsbCBjbG9ja3MgdG8gdGhlIGR3YzMgY29y
ZSBhcmUgc3RvcHBlZC4NCj4gPj4+Pj4+IFNvIEknbSBub3Qgc3VyZSBpZiBkd2MzIGV2ZW50cyB3
aWxsIHdvcmsuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBSaWdodCwgeW91IG5lZWQgdG8g
a2VlcCB0aG9zZSBjbG9ja3MgcnVubmluZyB0byBkZXRlY3QgaG9zdCByZXN1bWUuDQo+ID4+Pj4+
IFRoZXJlJ3Mgc3RpbGwgc29tZSBwb3dlciBzYXZpbmcgdGhyb3VnaCB0aGUgZHdjMyBjb250cm9s
bGVyJ3MgaGFuZGxpbmcNCj4gPj4+Pj4gaW4gc3VzcGVuZC4gWW91IG1heSBoYXZlIHNvbWUgbGlt
aXRlZCBwb3dlciBzYXZpbmcgZnJvbSBvdGhlciBzdXNwZW5kZWQNCj4gPj4+Pj4gZGV2aWNlcyBv
biB5b3VyIHNldHVwLiBIb3dldmVyLCBJIGRvbid0IHRoaW5rIHdlIGNhbiBleHBlY3QgdGhlIHBs
YXRmb3JtDQo+ID4+Pj4+IHRvIGdvIGludG8gZGVlcC1zbGVlcCBhbmQgYWxzbyBoYW5kbGUgaG9z
dCByZXN1bWUuDQo+ID4+Pj4NCj4gPj4+PiBXaHkgbm90PyBpZiB0aGUgUEhZIGNhbiBkZXRlY3Qg
dGhlIGhvc3QgcmVzdW1lIGFuZCB3YWtlIHVwIHRoZSBTb0MgaXQgd2lsbA0KPiA+Pj4+IHdvcmsg
cmlnaHQ/DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBIbS4uLiBJIHN1cHBvc2VkIGl0IG1heSBiZSBw
b3NzaWJsZS4gQnV0IGl0IG1heSBuZWVkIHNvbWUgdW5jb252ZW50aW9uYWwNCj4gPj4+IGRlc2ln
bj8gVGhlIGR3YzMgY29udHJvbGxlciBpcyBjdXJyZW50bHkgcmVnaXN0ZXJlZCB0byB0aGUgcGh5
LiBGb3IgdGhhdA0KPiA+Pj4gdG8gd29yaywgeW91ciBwaHkgbmVlZHMgdG8gYmUgYWJsZSB0byB0
YWxrIHRvIGJvdGggdGhlIGR3YzMgY29udHJvbGxlcg0KPiA+Pj4gYW5kIHNvbWUgb3RoZXIgY29u
dHJvbGxlciAoZXF1aXZhbGVudCB0byBkd2MzIFBNVSkgdGhhdCBtYW5hZ2VzDQo+ID4+PiBwb3dl
ci9pbnRlcnJ1cHQuIFRoZSBkd2MzIGNvbnRyb2xsZXIgd291bGQgbmVlZCB0byByZWxpbnF1aXNo
IGNvbnRyb2wgdG8NCj4gPj4+IHRoaXMgb3RoZXIgcGh5IGNvbnRyb2xsZXIgb24gc3VzcGVuZC4g
VGhlIHBoeSBkcml2ZXIgd291bGQgdGhlbiBiZSBhYmxlDQo+ID4+PiB0byBhc3NlcnQgaW50ZXJy
dXB0IHdha2luZyB1cCB0aGUgc3lzdGVtIG9uIHJlc3VtZSBzaWdhbCBkZXRlY3Rpb24sDQo+ID4+
PiB3aGljaCBpbiB0dXJuIHJlbGlucXVpc2ggY29udHJvbCB0byB0aGUgZHdjMyBjb250cm9sbGVy
LiBBbGwgb2YgdGhpcyBoYXMNCj4gPj4+IHRvIHdvcmsgd2hpbGUgdGhlIHBoeSBzaWduYWxpbmcg
cmVtYWlucyBzeW5jaHJvbml6ZWQgd2l0aCB0aGUgZHdjMw0KPiA+Pj4gY29udHJvbGxlci4NCj4g
Pj4NCj4gPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGFsbCB0aGlzIGlzIHRha2VuIGNhcmUg
YnkgUEhZIGludGVncmF0aW9uIGRlc2lnbiB3aXRoDQo+ID4+IERXQzMgY29yZSBvbiB0aGUgVEkg
U29DLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEZyb20gdGhlIHBhdGNoZXMgeW91IHNlbnQsIEkgZG9u
J3Qgc2VlIHRoZSBjaGFuZ2VzIG5lY2Vzc3NhcnkgZm9yIHRoaXMNCj4gPj4+IHRvIHdvcmsuIElm
IHRoZXJlIGlzIHNvbWV0aGluZyB0aGF0IEknbSBtaXNzaW5nLCBwbGVhc2UgYWxzbyBub3RlIGl0
IG9yDQo+ID4+PiBhZGQgaXQgaGVyZSB0byB0aGUgc2VyaWVzLg0KPiA+Pg0KPiA+PiBUaGVyZSBp
cyBub3RoaW5nIG1vcmUgYXMgdGhlIGRldGFpbHMgYXJlIHRha2VuIGNhcmUgYnkgUEhZIGxvZ2lj
IGFuZA0KPiA+PiBuZWNlc3NhcnkgaW50ZWdyYXRpb24gd2l0aCBEV0MzLg0KPiA+Pg0KPiA+PiBG
b3IgdGhlIFBIWSB3YWtlLXVwIHByb2dyYW1taW5nIGRldGFpbHMgeW91IGhhdmUgYWxyZWFkeSBj
aGVja2VkIHRoaXMgc2VyaWVzIFsxXS4NCj4gPj4NCj4gPj4gWzFdIC0gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDMxNjEzMTIyNi44
OTU0MC0xLXJvZ2VycUBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFheXFwYVd3bldJTzdTS2t0
azRrSTJFSkx3RFRJdjJuWVlDZ0JHSFVsdDU2S1R6ZVlrREVkcTJRNVp2WkZzdUNXSWxjWEdFVDIz
MFlZNUozeV9zSFYkIA0KPiA+Pg0KPiA+IA0KPiA+IEkgbWF5IGhhdmUgbWlzdW5kZXJzdG9vZCB5
b3VyIHBsYXRmb3JtIGltcGxlbWVudGF0aW9uLiBNeSB1bmRlcnN0YW5kaW5nDQo+ID4gaXMgdGhh
dCBpdCBjYW4gb25seSBkZXRlY3QgVkJVUyBhbmQgdGhhdCBpdCBjYW4gb25seSByZXN1bWUgb24g
VkJVUw0KPiA+IHZhbGlkLg0KPiA+IA0KPiA+IERvZXMgdGhlICJMSU5FU1RBVEUiIGhlcmUgZ2V0
cyBhc3NlcnRlZCBpZiBzYXkgdGhlcmUncyBhIExGUFMgZGV0ZWN0aW9uPw0KPiANCj4gWWVzLiBU
aGUgd2FrZSB1cCBsb2dpYyBvbiB0aGUgU29DIGlzIHNub29waW5nIHRoZSBVVE1JIGxpbmVzIGZy
b20gdGhlIFBIWSBhbmQgb24gYW55DQo+IGNoYW5nZSBpdCBjYW4gZGV0ZWN0IGFuZCB3YWtlIHVw
IHRoZSBTb0MuDQo+IA0KDQpBcmUgeW91IHJlZmVycmluZyB0byB0aGUgdXRtaV9saW5lc3RhdGUg
c2lnbmFsPyBJc24ndCB0aGF0IGZvciB1c2IyDQpzcGVlZCBvbmx5PyBEb2VzIHlvdXIgcGxhdGZv
cm0gc3VwcG9ydCB1c2IzIHNwZWVkPw0KDQpUaGFua3MsDQpUaGluaA0K
