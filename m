Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE16972F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBOA6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjBOA57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:57:59 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1E1A649;
        Tue, 14 Feb 2023 16:57:58 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENjGKN013530;
        Tue, 14 Feb 2023 16:57:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=FlomAhR7UTC1w/NdnTk71NZ1VdtIjFSPUfkjqe+Rw2g=;
 b=UHudchELgPfQd7ni652qFr+2Ig/IuRiuK649xAnJn5C64GuGSsok6jgdP8ZN96f+nmH4
 /YuiiopU2ugvHz4uFiciIUEB4GLAQugejXTI7Q31Y/1HWe4BRt6M8O8YAPE7gCHmfqrs
 vxm4gNpIq3vKufmvtIHd5Vy09C57TASeB0InChzGcByOCqxHwAhbq3T+DIXA4NMdgDeB
 +KXYmMEchh4rrOVJO6ADUPM2JruoTbrYENG0Ebt638TKaSdICjEGcOF3bzBnwDGFXMXS
 jiekSG4KewkkgHkAtlrnX9hzozx3X2blWrkOb3AP0NaamiLz/dMO66bhJ7I/rubz0jV7 ZA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3npawu3c2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:57:46 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C89EE400E8;
        Wed, 15 Feb 2023 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676422658; bh=FlomAhR7UTC1w/NdnTk71NZ1VdtIjFSPUfkjqe+Rw2g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CVLsYRSePz9hMySZZkkUARdg/Xa7jW7s2JbUrmGoGxQuwGOQbwocRzzjcq+UIbs9P
         xeIzhw3+9gYLJMifcKB0XnTGjRlZW5+oTtR4fm8u6Z4wy3uYNTpYVbF6VGolbjRiZg
         Gnggm6ZP4MdvGV5jhliPU3l1TxcKR69iQ9jUXc8Ul/UtyUDWd1vm6LcvFnFMKuk2Ku
         dU8RORoUpr0hDNDkgQUYnQ3Tfy2cBaEtaczuHMGkqb/77H9v2LbJ6mqnyAsLXSlcs0
         nDM+YGafhJeZsn5/5BIrcimf/h7e/QN/T8b8vkF2HCcpBuvahwMaN8jASfgKaECXxp
         7c19JXml4lolA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4FDE4A005C;
        Wed, 15 Feb 2023 00:57:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EE9A840101;
        Wed, 15 Feb 2023 00:57:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JkWYIM3f";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YElvULL345/lpxbC7EY5YvUcIE/P6mPWHQDZSoMt9gwFM5v7KoXrka0rjfBz+MdqAMfMnFEzPQb5HPwjCe49tOtcbCITBDVkx1mmDu1AiI/g/N9Zcp+eCSUEnH4cM9oNkXYtbLr12WUYd4GI7v93YK1gJ8zUl0y1wi51dyQN2kj/XgLPqReytAI2AbGMegNT3o6NQ4q2fAJ9qj3cdW6pMIofc9G6Pz525Kk4i0665dJ4mMSqJOXPPDOl1kv6fHFTjKDSDaNV23W0nxQr53BBnTtGBAJ/hQrafK+OO158SLYvo3m4NdP7KHHlhgQhIbAyKHx38Vz8ModHtChIrraMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlomAhR7UTC1w/NdnTk71NZ1VdtIjFSPUfkjqe+Rw2g=;
 b=GWAtXFpSmWXSNWNyP6najst4V58R6MfRhCidv7E7yXDhu2AJHgDuNQrTSN+7YDxPJo7xehrDAnFWLHa4URkYTg7IynFjkyhOCodx7PWjb8/HjPznSYXxgET2ijRFMBJjEterTfBc6RpQIZppQozd5/Ju5keQaYRZRnzpzcm60iNVfFpINtqJuzJu13zVeS38ee7yql88ivitACqf4aWCQxQmI8vOFpc/ITRXV3W7cLDKdZt/wkh1jDw2WsWDrxdbuZErUzUMvhjbSAEg+jU4fLa+VUXsw+r0VxQQxh396asCdchTPTZu1RdEmVzT0xwCRWuQs61mlbRqSeNYg5+pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlomAhR7UTC1w/NdnTk71NZ1VdtIjFSPUfkjqe+Rw2g=;
 b=JkWYIM3fDUyUuqP5Pq6+40Uo6TCV3xUx7k/q76+K/rsEryskeZQjfD68ZBkYybEgCh81n3op/l8R/FyBEtMyDTnYwq+MP0s5e1+rIquWNvZNkJ3r/GMmxtrGsJczEHtYOjFT3qufN0tecMiT01TwakAdBp1DRSLFBtVuPLqEBrI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 00:57:34 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Wed, 15 Feb 2023
 00:57:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v4 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Thread-Topic: [PATCH v4 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Thread-Index: AQHZP+HH23zCeWVTh0O28CKcyoHouK7PMS8A
Date:   Wed, 15 Feb 2023 00:57:34 +0000
Message-ID: <20230215005728.xa4dinvtroqjxqdl@synopsys.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
 <1676316676-28377-2-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1676316676-28377-2-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: 78519583-ab57-411b-536b-08db0eef9fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdc1/GYNiA6TTguGeD4w7nydR7p6T4tvO6AY7ISHBxoagNdxk3qqXIUWRktkKCMREEO1snWM95hWqzaUcbNVOAyPqJuF5JI3u6wHZKI2LRUPId9HwXiPbPQbOwtYlfvmXVjesLzsgvZOknhBU6J6gibOWP+ybBz/3T0od59gVolid6CpiUCKTvdJ9xz/N4vBCLz5hFdcCkB9IVgbZniTR6/V55jr/MVJpXbrbYqRyY+fKSDhv8EPUd1dcOaKT4TEfNLD/i5Oe45Ysf4HBX7PMoB5EdOHlBxvxqpKFImkiZPg/Hm8uVqOJKSm3mYG+zyDoUAm7fjo5YSV8wpq0i+KsCfhbz1NLKSCxt1DeFt3p/lHWGEnE0tLQ4yToRtjcXUjcm9OZOR3JzpBB3SDEwApZxabb06QHcSttVH90FcbsHypPyeDUCq+1t61m4x7Pigmz35NRHuw/2pYvIvUPKcnx9vvV8q8k7ZGPhoAUm6rtAzAR7kkAXnScr+nnqnHQYhhgKUU1ZuXGkurQVOco1WNK2VIKVadxi4VyonokXNCppJ3hRxHuGI8PC4jKgb6DeahxxbqNXfGndBTzdVRSmvsbSa6muB6mbARTPszYa2Eyxh73xoKay8zWtoSM42ArlSwKum8TkoeP5G7CBkf4gQTOQ9MDPRTLa3sXyF7eFAh73abcqpgBVvs7dKi92pYPNfh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(86362001)(41300700001)(186003)(26005)(6506007)(1076003)(6512007)(38070700005)(6486002)(478600001)(2616005)(71200400001)(122000001)(66946007)(76116006)(38100700002)(4326008)(8676002)(5660300002)(6916009)(2906002)(66556008)(316002)(83380400001)(64756008)(36756003)(66446008)(66476007)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZKV1VEYTRGU2RWNks2K1poUmVPcXFpVlhJWHpPYUhoV0paWStOcWRZS1A1?=
 =?utf-8?B?dzdtaytHTkkzL0ZhSCs4WmNZZXdaanIveDU5U3BwVG9RSk9mNE5ZT0VBeDFB?=
 =?utf-8?B?cTBQYW1DdlVLMlBaUVhKd3RXUWlIQnV0aUVhdVVab1Zhbko5MFlEUmxKandx?=
 =?utf-8?B?R0xmamR3RFNVbytYbGpITUpaWVZyS0RZOGF6dXJkVnNxL3VTVUduOG9USUxj?=
 =?utf-8?B?bnBhVFNUd2UzekJFL1luZ2xydnltdk9ERkc3NkR5aFdXWXBkbWlQNXdWaEIz?=
 =?utf-8?B?YzZ0T0poTlBpd1pTR1dKMlpMTzBVQ1hPVnVLR0FBa21Cb1FnUFpKV0tVNVNM?=
 =?utf-8?B?R0lyMTFwMkhYNW5wQ05EQW0zVThrZmRnS0k4dkdXbmF6LzJrdk9pMzVBQm55?=
 =?utf-8?B?MVNqZ1gwU3RzbUs3Y29xVERvUDA4NDE0S0trU1YxaVJzZXo1OGM2dWxJY1hy?=
 =?utf-8?B?Y2ZLcWU3STFXZkl1Sm1ja1dyK2loRnZTOXNqMWtzdjFmUGJpMUZlckRrZGdZ?=
 =?utf-8?B?T1I4TkFJM1RCVGt5SnFXaEcwT0d6VkNOWUZaOWNyZG5LajIvQWJoY05zZlho?=
 =?utf-8?B?d0V1czdVcmlQNE9sL0VzVm9PVDRjVXM3MFJDN1ZDWWNxRkQyR2E2U29rMDR3?=
 =?utf-8?B?WG9kb2lIVE8yTEcxSEpGSlovajFqOUFwSkI3dFREWm1aYnNIRmU3RVBuMUY4?=
 =?utf-8?B?SzZiVG9KdkR3ODgrWlpBZFhRM3NKMGJjc1RpOWVOdHdRMVhZTkdUMURMSE1K?=
 =?utf-8?B?RTBQdUl1WkUwUmJuUDlZOWI3VjhlTmhnNXhoakVneVI4aGlxNzduZFBpSnFV?=
 =?utf-8?B?d1YrdllqKzVHa2MwRXMyVWdVbnhNM3hrK01FVEZCKzFoRWozaUNKMnVnZFpE?=
 =?utf-8?B?djcvSnI2eGdWZ2NLaGFiMXVYYytOMUV1ODhkcm56ZU9GRm9vN3EvVmtDamta?=
 =?utf-8?B?QTBUMTY2ZlR5MzEvM0piOHlrMlhmTzVkb0swM0F0YmpaWVEyY1JhNUxOS0dn?=
 =?utf-8?B?Z1RkVDN5NmhhYnhlZjFFVTVFdGMzK2duaDMzMmUwWmFVK20wdlFmYi82dVB1?=
 =?utf-8?B?MGRkTDlpK1dmckgrYjAvUmxYVFlVZDV1SkZreXNjanNnMFlCNWpCd0ZjLzZJ?=
 =?utf-8?B?VERrajlQT0Z4SDlDTXRzd1VYcmNVWjRJN2FOczJNV09Ha3NtMTl0K0t0Tld2?=
 =?utf-8?B?dzRjZytCbVBBSWw2dXFKNlg1VFZzWVZGQzZOeWRsbC8vb25rWkNMT1Yxd3B6?=
 =?utf-8?B?cjFuZ0tORlgrOXk4eXdCdHVEbUlWVitPNlM4U2JIWU50WTJIbmVuTEl3cFA4?=
 =?utf-8?B?SG1qUUNxdklqQ2dhUkVORlc5YkIyaVNiTHVEWFFidFczeWtad0VZRDFjT3JW?=
 =?utf-8?B?MHdtNXNUYVF3MEZ5Z05SbUdnOFplMlNzSzVGRXVjMlp4YzFUWmg2T01pUms4?=
 =?utf-8?B?dkhKOUh5WStvV052SjBRQi9MNXVOcCtwY1JNNDE1WlVlNzFMZGpBUkFlcDFX?=
 =?utf-8?B?c2p3Vmt4WnZTKzd6WUdZYzN0SWNITlJLejhRVkVCUWVZUGRPL250Vk9jM1NY?=
 =?utf-8?B?bkRwbk5qN09KOEp4NS92c0dMa09qbkR3cWdjM01IQ1RUM08reXRkbGFUTEtM?=
 =?utf-8?B?NUNDNG1WeER5eThHcERNUmJYNTNDc0FSNzRSVzZaNlVvWktRbkNyZ2tidGFq?=
 =?utf-8?B?WGRnVGdyL3l5dWV0R0RVRzFsUGU1dXliQmhHU1dJQ3hXMko5TnpCWUkwaHdN?=
 =?utf-8?B?cXJ0aTlwRDNIREpzWUJDM1BRV3lac081NUhoL2doR1orOEt3VEdhNHZkbUVL?=
 =?utf-8?B?NnFqYVczaWlsOG01OUJMSkxYcVIraVhsSE1LWG9JejhabUxEVHl1cTVNSWNW?=
 =?utf-8?B?NmNQZ3lIWHJsbDV0NG0rMDBoTjcrNXRSL1RxYkwzZndRellobjhObEFFa0VX?=
 =?utf-8?B?N0RlTVhBZW5GREIvU0kyUnMzUnJoeGhlRDFtUERIK3l3MlY2VFJtUktxNjdo?=
 =?utf-8?B?cWFCSzFRYVhuU1lFeDZQc3pUTGxldnlWek9HMW5aT1JVdDl2ZjJ6V3JmcThp?=
 =?utf-8?B?ZUd1clhTRnBwRDNNMTdMSVdMOFJub003NDYydGxjbkltUDlBdlJ1Q1BQdGhK?=
 =?utf-8?B?MTA4ZGZUeFBDTTdOUzRjS2ZSUStHTWc4dTZpYzYzaVN0azNlR3RlN1JNNGF1?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4FAB1CB90D8E34B8133F0DC86972A6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fB9BluPv8eB1ZmH+KcoWtbgJbCzK9RTPoKK4Gb/kyVhJikzSaX7CoJ7CAQKpD3nDZC9/WYNECz/3fAz48ojXhvdnmavCx2bUxMSvm53Ouw1UCbbVj/BN0ogVtrVFJrREHgvkv1sp3695pT+xW9XYm+kO0sQLr+QlrqyT+cGKRL1CbTCVNSUH2B2VBrjQmHBUQI3KruDwJeMy5oFv3TIA3p22m+QmyndJA76ohDnwTK7CUAHJf9LyIWjBdAApPCH2KHJtBBv5/HldWitrZV/RiBaOTOOrPtAVM2sMH+pOmhQip/PquXpOKQjfK0ZhFmLHtjyZ0WIoaAo/kndgwCJLjlkYL6LJJIC1zhR0nS/ZfeCixU+amtz+k/lZGTie7PWuczOKGDywUcz0vFf57+AnGgjoL7/Jdh0Mcd2kcQmbL4J4tvHCb11rTI9GWDqHdkIhYF+B4D8IzyqH2SFynt95AVYvuYnnZn96Sv0praP5aWKwrzwB1RnTLMLUrDD3WtzJVi5TT3UM/CH337tZiSVs6PavCm2GzspbHQquyeeJD1kWyqqu1PNaLz5tvUOzGBeiF0lRmeyc50hZN3yxl8t2zJUaafDe5Yk2bVP43y8UWAq7pOi+JeeCWwsKuHuCM5TvD6BOvmVVO7BaDEQjP1XBhG4PWaw7TtHfL6ln0fbJF3BcBkUun8KZ4mFubpbd0ISEDiSXVDju8xjI+FGnOe+s5Tw/QfhAJ5racd8K111gABxtaEAfNeXMHoXx/FEtoOz/PbvAc8tzeomEG7HiNqbrEprCWINvfcedggIeZ1Iju6gY7bbMcQ2LLWLluEiGxy5PHtNGZeMa4T3N9xFvNPyxR9DTFWH4lJiqjWFkVVxWQ1EnrxBYSc4FFwiqnr4QbBkvcBAICKrvbRhIlmLYezNKFp1E5G3tanvWSz0SaxcWjdc=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78519583-ab57-411b-536b-08db0eef9fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 00:57:34.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOEN3pbhxy7cGVMzcOjnX/licrsCaTQnDLu44Z0RPaPvVXIuGg4F5hETswdmeKG0Uruqbzu8fWQQUjMdN2inCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Proofpoint-ORIG-GUID: oLwrAXMgSmQpe7350gQncpULyNT48Ypo
X-Proofpoint-GUID: oLwrAXMgSmQpe7350gQncpULyNT48Ypo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFRoZSB3YWtl
dXAgYml0IGluIHRoZSBibUF0dHJpYnV0ZXMgZmllbGQgaW5kaWNhdGVzIHdoZXRoZXIgdGhlIGRl
dmljZQ0KPiBpcyBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLiBCdXQgdGhpcyBmaWVsZCBz
aG91bGQgYmUgYWxsb3dlZCB0bw0KPiBzZXQgb25seSBpZiB0aGUgVURDIHN1cHBvcnRzIHN1Y2gg
d2FrZXVwIG1lY2hhbmlzbS4gU28gY29uZmlndXJlIHRoaXMNCj4gZmllbGQgYmFzZWQgb24gVURD
IGNhcGFiaWxpdHkuIEFsc28gaW5mb3JtIHRoZSBVREMgd2hldGhlciB0aGUgZGV2aWNlDQo+IGlz
IGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAgYnkgaW1wbGVtZW50aW5nIGEgZ2FkZ2V0IG9w
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1
aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyB8IDE4
ICsrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbmZpZ2ZzLmMgIHwg
IDMgKysrDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYyAgfCAyNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvdHJhY2UuaCB8ICA1
ICsrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3VzYi9jb21wb3NpdGUuaCAgfCAgMiArKw0KPiAgaW5j
bHVkZS9saW51eC91c2IvZ2FkZ2V0LmggICAgIHwgIDggKysrKysrKysNCj4gIDYgZmlsZXMgY2hh
bmdlZCwgNjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dh
ZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBpbmRl
eCBmYTdkZDZjLi5hMzdhOGY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29t
cG9zaXRlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IEBAIC01
MTMsNiArNTEzLDE5IEBAIHN0YXRpYyB1OCBlbmNvZGVfYk1heFBvd2VyKGVudW0gdXNiX2Rldmlj
ZV9zcGVlZCBzcGVlZCwNCj4gIAkJcmV0dXJuIG1pbih2YWwsIDkwMFUpIC8gODsNCj4gIH0NCj4g
IA0KPiArdm9pZCBjaGVja19yZW1vdGVfd2FrZXVwX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdldCAq
ZywNCj4gKwkJCQlzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMpDQo+ICt7DQo+ICsJaWYgKFVT
Ql9DT05GSUdfQVRUX1dBS0VVUCAmIGMtPmJtQXR0cmlidXRlcykgew0KPiArCQkvKiBSZXNldCB0
aGUgcncgYml0IGlmIGdhZGdldCBpcyBub3QgY2FwYWJsZSBvZiBpdCAqLw0KPiArCQlpZiAoIWct
Pndha2V1cF9jYXBhYmxlICYmIGctPm9wcy0+c2V0X3JlbW90ZV93YWtldXApIHsNCj4gKwkJCVdB
Uk4oYy0+Y2RldiwgIkNsZWFyaW5nIHdha2V1cCBiaXQgZm9yIGNvbmZpZyBjLiVkXG4iLA0KPiAr
CQkJICAgICBjLT5iQ29uZmlndXJhdGlvblZhbHVlKTsNCj4gKwkJCWMtPmJtQXR0cmlidXRlcyAm
PSB+VVNCX0NPTkZJR19BVFRfV0FLRVVQOw0KPiArCQl9DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBz
dGF0aWMgaW50IGNvbmZpZ19idWYoc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjb25maWcsDQo+
ICAJCWVudW0gdXNiX2RldmljZV9zcGVlZCBzcGVlZCwgdm9pZCAqYnVmLCB1OCB0eXBlKQ0KPiAg
ew0KPiBAQCAtMTAwMCw2ICsxMDEzLDExIEBAIHN0YXRpYyBpbnQgc2V0X2NvbmZpZyhzdHJ1Y3Qg
dXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYsDQo+ICAJZWxzZQ0KPiAgCQl1c2JfZ2FkZ2V0X2NsZWFy
X3NlbGZwb3dlcmVkKGdhZGdldCk7DQo+ICANCj4gKwlpZiAoVVNCX0NPTkZJR19BVFRfV0FLRVVQ
ICYgYy0+Ym1BdHRyaWJ1dGVzKQ0KPiArCQl1c2JfZ2FkZ2V0X3NldF9yZW1vdGVfd2FrZXVwKGdh
ZGdldCwgMSk7DQo+ICsJZWxzZQ0KPiArCQl1c2JfZ2FkZ2V0X3NldF9yZW1vdGVfd2FrZXVwKGdh
ZGdldCwgMCk7DQo+ICsNCj4gIAl1c2JfZ2FkZ2V0X3ZidXNfZHJhdyhnYWRnZXQsIHBvd2VyKTsN
Cj4gIAlpZiAocmVzdWx0ID49IDAgJiYgY2Rldi0+ZGVsYXllZF9zdGF0dXMpDQo+ICAJCXJlc3Vs
dCA9IFVTQl9HQURHRVRfREVMQVlFRF9TVEFUVVM7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvY29uZmlnZnMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQo+IGlu
ZGV4IGI5ZjExMzYuLjRjNjM5ZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9j
b25maWdmcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQo+IEBAIC0x
NzYxLDYgKzE3NjEsOSBAQCBzdGF0aWMgaW50IGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kKHN0cnVj
dCB1c2JfZ2FkZ2V0ICpnYWRnZXQsDQo+ICAJCWlmIChnYWRnZXRfaXNfb3RnKGdhZGdldCkpDQo+
ICAJCQljLT5kZXNjcmlwdG9ycyA9IG90Z19kZXNjOw0KPiAgDQo+ICsJCS8qIFByb3Blcmx5IGNv
bmZpZ3VyZSB0aGUgYm1BdHRyaWJ1dGVzIHdha2V1cCBiaXQgKi8NCj4gKwkJY2hlY2tfcmVtb3Rl
X3dha2V1cF9jb25maWcoZ2FkZ2V0LCBjKTsNCj4gKw0KPiAgCQljZmcgPSBjb250YWluZXJfb2Yo
Yywgc3RydWN0IGNvbmZpZ191c2JfY2ZnLCBjKTsNCj4gIAkJaWYgKCFsaXN0X2VtcHR5KCZjZmct
PnN0cmluZ19saXN0KSkgew0KPiAgCQkJaSA9IDA7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvdWRjL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jDQo+IGlu
ZGV4IDIzYjA2MjkuLjNkY2JiYTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jDQo+IEBAIC01
MTQsNiArNTE0LDMzIEBAIGludCB1c2JfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAq
Z2FkZ2V0KQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX2dhZGdldF93YWtldXApOw0KPiAgDQo+
ICAvKioNCj4gKyAqIHVzYl9nYWRnZXRfc2V0X3JlbW90ZV93YWtldXAgLSBjb25maWd1cmVzIHRo
ZSBkZXZpY2UgcmVtb3RlIHdha2V1cCBmZWF0dXJlLg0KPiArICogQGdhZGdldDp0aGUgZGV2aWNl
IGJlaW5nIGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXANCj4gKyAqIEBzZXQ6dmFsdWUgdG8g
YmUgY29uZmlndXJlZC4NCj4gKyAqDQo+ICsgKiBzZXQgdG8gb25lIHRvIGVuYWJsZSByZW1vdGUg
d2FrZXVwIGZlYXR1cmUgYW5kIHplcm8gdG8gZGlzYWJsZSBpdC4NCj4gKyAqDQo+ICsgKiByZXR1
cm5zIHplcm8gb24gc3VjY2VzcywgZWxzZSBuZWdhdGl2ZSBlcnJuby4NCj4gKyAqLw0KPiAraW50
IHVzYl9nYWRnZXRfc2V0X3JlbW90ZV93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwg
aW50IHNldCkNCj4gK3sNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKw0KPiArCWlmICghZ2FkZ2V0LT5v
cHMtPnNldF9yZW1vdGVfd2FrZXVwKSB7DQo+ICsJCXJldCA9IC1FT1BOT1RTVVBQOw0KPiArCQln
b3RvIG91dDsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBnYWRnZXQtPm9wcy0+c2V0X3JlbW90ZV93
YWtldXAoZ2FkZ2V0LCBzZXQpOw0KPiArDQo+ICtvdXQ6DQo+ICsJdHJhY2VfdXNiX2dhZGdldF9z
ZXRfcmVtb3RlX3dha2V1cChnYWRnZXQsIHJldCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAr
fQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwodXNiX2dhZGdldF9zZXRfcmVtb3RlX3dha2V1cCk7DQo+
ICsNCj4gKy8qKg0KPiAgICogdXNiX2dhZGdldF9zZXRfc2VsZnBvd2VyZWQgLSBzZXRzIHRoZSBk
ZXZpY2Ugc2VsZnBvd2VyZWQgZmVhdHVyZS4NCj4gICAqIEBnYWRnZXQ6dGhlIGRldmljZSBiZWlu
ZyBkZWNsYXJlZCBhcyBzZWxmLXBvd2VyZWQNCj4gICAqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL3RyYWNlLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3RyYWNlLmgN
Cj4gaW5kZXggYWJkYmNiMS4uYTVlZDI2ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy90cmFjZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvdHJhY2UuaA0K
PiBAQCAtOTEsNiArOTEsMTEgQEAgREVGSU5FX0VWRU5UKHVkY19sb2dfZ2FkZ2V0LCB1c2JfZ2Fk
Z2V0X3dha2V1cCwNCj4gIAlUUF9BUkdTKGcsIHJldCkNCj4gICk7DQo+ICANCj4gK0RFRklORV9F
VkVOVCh1ZGNfbG9nX2dhZGdldCwgdXNiX2dhZGdldF9zZXRfcmVtb3RlX3dha2V1cCwNCj4gKwlU
UF9QUk9UTyhzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IHJldCksDQo+ICsJVFBfQVJHUyhnLCBy
ZXQpDQo+ICspOw0KPiArDQo+ICBERUZJTkVfRVZFTlQodWRjX2xvZ19nYWRnZXQsIHVzYl9nYWRn
ZXRfc2V0X3NlbGZwb3dlcmVkLA0KPiAgCVRQX1BST1RPKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBp
bnQgcmV0KSwNCj4gIAlUUF9BUkdTKGcsIHJldCkNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdXNiL2NvbXBvc2l0ZS5oIGIvaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmgNCj4gaW5k
ZXggNjA4ZGM5Ni4uZDk0OWU5MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC91c2IvY29t
cG9zaXRlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmgNCj4gQEAgLTQx
Myw2ICs0MTMsOCBAQCBleHRlcm4gaW50IGNvbXBvc2l0ZV9kZXZfcHJlcGFyZShzdHJ1Y3QgdXNi
X2NvbXBvc2l0ZV9kcml2ZXIgKmNvbXBvc2l0ZSwNCj4gIGV4dGVybiBpbnQgY29tcG9zaXRlX29z
X2Rlc2NfcmVxX3ByZXBhcmUoc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2LA0KPiAgCQkJ
CQkgc3RydWN0IHVzYl9lcCAqZXAwKTsNCj4gIHZvaWQgY29tcG9zaXRlX2Rldl9jbGVhbnVwKHN0
cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2Rldik7DQo+ICt2b2lkIGNoZWNrX3JlbW90ZV93YWtl
dXBfY29uZmlnKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiArCQkJCXN0cnVjdCB1c2JfY29uZmln
dXJhdGlvbiAqYyk7DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHVzYl9jb21wb3NpdGVf
ZHJpdmVyICp0b19jZHJpdmVyKA0KPiAgCQlzdHJ1Y3QgdXNiX2dhZGdldF9kcml2ZXIgKmdkcnYp
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCBiL2luY2x1ZGUvbGlu
dXgvdXNiL2dhZGdldC5oDQo+IGluZGV4IDAwNzUwZjcuLjFkNzk2MTIgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdXNiL2dh
ZGdldC5oDQo+IEBAIC0zMTAsNiArMzEwLDcgQEAgc3RydWN0IHVzYl91ZGM7DQo+ICBzdHJ1Y3Qg
dXNiX2dhZGdldF9vcHMgew0KPiAgCWludAkoKmdldF9mcmFtZSkoc3RydWN0IHVzYl9nYWRnZXQg
Kik7DQo+ICAJaW50CSgqd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqKTsNCj4gKwlpbnQJKCpz
ZXRfcmVtb3RlX3dha2V1cCkoc3RydWN0IHVzYl9nYWRnZXQgKiwgaW50IHNldCk7DQo+ICAJaW50
CSgqc2V0X3NlbGZwb3dlcmVkKSAoc3RydWN0IHVzYl9nYWRnZXQgKiwgaW50IGlzX3NlbGZwb3dl
cmVkKTsNCj4gIAlpbnQJKCp2YnVzX3Nlc3Npb24pIChzdHJ1Y3QgdXNiX2dhZGdldCAqLCBpbnQg
aXNfYWN0aXZlKTsNCj4gIAlpbnQJKCp2YnVzX2RyYXcpIChzdHJ1Y3QgdXNiX2dhZGdldCAqLCB1
bnNpZ25lZCBtQSk7DQo+IEBAIC0zODQsNiArMzg1LDggQEAgc3RydWN0IHVzYl9nYWRnZXRfb3Bz
IHsNCj4gICAqIEBjb25uZWN0ZWQ6IFRydWUgaWYgZ2FkZ2V0IGlzIGNvbm5lY3RlZC4NCj4gICAq
IEBscG1fY2FwYWJsZTogSWYgdGhlIGdhZGdldCBtYXhfc3BlZWQgaXMgRlVMTCBvciBISUdILCB0
aGlzIGZsYWcNCj4gICAqCWluZGljYXRlcyB0aGF0IGl0IHN1cHBvcnRzIExQTSBhcyBwZXIgdGhl
IExQTSBFQ04gJiBlcnJhdGEuDQo+ICsgKiBAd2FrZXVwX2NhcGFibGU6IFRydWUgaWYgZ2FkZ2V0
IGlzIGNhcGFibGUgb2Ygc2VuZGluZyByZW1vdGUgd2FrZXVwLg0KPiArICogQHdha2V1cF9hcm1l
ZDogVHJ1ZSBpZiBnYWRnZXQgaXMgYXJtZWQgYnkgdGhlIGhvc3QgZm9yIHJlbW90ZSB3YWtldXAu
DQo+ICAgKiBAaXJxOiB0aGUgaW50ZXJydXB0IG51bWJlciBmb3IgZGV2aWNlIGNvbnRyb2xsZXIu
DQo+ICAgKiBAaWRfbnVtYmVyOiBhIHVuaXF1ZSBJRCBudW1iZXIgZm9yIGVuc3VyaW5nIHRoYXQg
Z2FkZ2V0IG5hbWVzIGFyZSBkaXN0aW5jdA0KPiAgICoNCj4gQEAgLTQ0NSw2ICs0NDgsOCBAQCBz
dHJ1Y3QgdXNiX2dhZGdldCB7DQo+ICAJdW5zaWduZWQJCQlkZWFjdGl2YXRlZDoxOw0KPiAgCXVu
c2lnbmVkCQkJY29ubmVjdGVkOjE7DQo+ICAJdW5zaWduZWQJCQlscG1fY2FwYWJsZToxOw0KPiAr
CXVuc2lnbmVkCQkJd2FrZXVwX2NhcGFibGU6MTsNCj4gKwl1bnNpZ25lZAkJCXdha2V1cF9hcm1l
ZDoxOw0KPiAgCWludAkJCQlpcnE7DQo+ICAJaW50CQkJCWlkX251bWJlcjsNCj4gIH07DQo+IEBA
IC02MDEsNiArNjA2LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZ2FkZ2V0X2lzX290ZyhzdHJ1Y3Qg
dXNiX2dhZGdldCAqZykNCj4gICNpZiBJU19FTkFCTEVEKENPTkZJR19VU0JfR0FER0VUKQ0KPiAg
aW50IHVzYl9nYWRnZXRfZnJhbWVfbnVtYmVyKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0K
PiAgaW50IHVzYl9nYWRnZXRfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0KPiAr
aW50IHVzYl9nYWRnZXRfc2V0X3JlbW90ZV93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdl
dCwgaW50IHNldCk7DQo+ICBpbnQgdXNiX2dhZGdldF9zZXRfc2VsZnBvd2VyZWQoc3RydWN0IHVz
Yl9nYWRnZXQgKmdhZGdldCk7DQo+ICBpbnQgdXNiX2dhZGdldF9jbGVhcl9zZWxmcG93ZXJlZChz
dHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KTsNCj4gIGludCB1c2JfZ2FkZ2V0X3ZidXNfY29ubmVj
dChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KTsNCj4gQEAgLTYxNiw2ICs2MjIsOCBAQCBzdGF0
aWMgaW5saW5lIGludCB1c2JfZ2FkZ2V0X2ZyYW1lX251bWJlcihzdHJ1Y3QgdXNiX2dhZGdldCAq
Z2FkZ2V0KQ0KPiAgeyByZXR1cm4gMDsgfQ0KPiAgc3RhdGljIGlubGluZSBpbnQgdXNiX2dhZGdl
dF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4gIHsgcmV0dXJuIDA7IH0NCj4g
K3N0YXRpYyBpbmxpbmUgaW50IHVzYl9nYWRnZXRfc2V0X3JlbW90ZV93YWtldXAoc3RydWN0IHVz
Yl9nYWRnZXQgKmdhZGdldCwgaW50IHNldCkNCj4gK3sgcmV0dXJuIDA7IH0NCj4gIHN0YXRpYyBp
bmxpbmUgaW50IHVzYl9nYWRnZXRfc2V0X3NlbGZwb3dlcmVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpn
YWRnZXQpDQo+ICB7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMgaW5saW5lIGludCB1c2JfZ2FkZ2V0
X2NsZWFyX3NlbGZwb3dlcmVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpDQo+IC0tIA0KPiAy
LjcuNA0KPiANCg0KUmV2aWV3ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
