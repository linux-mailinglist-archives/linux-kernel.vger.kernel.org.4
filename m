Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA768CB70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBGAtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:49:00 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5B24CB3;
        Mon,  6 Feb 2023 16:48:56 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316NAgWB029443;
        Mon, 6 Feb 2023 16:48:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=0al/5CzZ3Wk/gG0xMFAnQXzvDCOJUQkQLJZndSoEx5A=;
 b=HtIVr5qQ624vomt90wGwlaSufmkGeldufz1j0zq+KZyib/RJsJDKZA3yECl1ZovPXD1U
 wryEWs3mhhZTfXVvB+GehiOohJQJhEspM5IqrlPLGvqqJebH0X3J90+oB2UjoRyIwZKh
 LH23m5bZ7UTMxcZvM5QTflygg64Bk9t2s2arnxZUkrl5LHFiyWoUN9THHBbCnXSKoTB1
 da6hY87TBqqXYIm66OcD9BsDpii9FbyH+pjQ55gDu9yQVE5lP3/uem1waJxT1t5Nc0T6
 OlM8s4xheLoC2Hd0l8k+ABCWsXkHMOd9OuQLdpkztkR1pDnnY01qCiczbuGj3hYmYqX4 rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nhq61b3e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:48:46 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D0026C00F7;
        Tue,  7 Feb 2023 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675730926; bh=0al/5CzZ3Wk/gG0xMFAnQXzvDCOJUQkQLJZndSoEx5A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DmXBkgmG/lgUbho2m+yz529mLJu2taqCijRPMfHP3youboH6DMZ6Pca3iqALDv0j/
         1eaFK6HdrSYBjpF2G4NJ7Zb0XF+CMC8EByjveKqTnB8F1tlu7KUKkcKm+KkLeD5P8w
         0ardhaSLupc2F0o+r//68Ll5YbCKYTdeldmVogmRzVsudiRvLjl6myGnWtKTWtUWRP
         zVeuFxrSNdl0OqMyAPRyOvpfBaF5iVS/bzxGwGh8W+JojtHYg3AL9ejDxMwE2XZCgv
         GJKA0tOAbAJvFkZgWem+QYbi5C5q0RLbm5HyMr3bDiXyaZREhDaJKQtLzJg9nRQ12Z
         rfYPgf2hIFhZQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 489ABA005C;
        Tue,  7 Feb 2023 00:48:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7A917800AA;
        Tue,  7 Feb 2023 00:48:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sq8/Qq9o";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3jbC2JpmQQw4GQyvewYgVlVX6nqCDAjYojLT1ztsLU44SDkWHxhRbjzmyMv5jhtcCPHQL14zgzobgljemox6nDrdxMFraw8xzheaWctU8WRmpMkfcvoUIWB+DcihDxgTlb+3yUahpUAPYtYln46NtOhRmzsXHNs5gZ6usW8U72KEdTfnoPmKmp4r5hMfBziqbrOSbIT5vcDRTl4jgMcR8ns6fB4JnRkrQlLr280B6LtnoKx+GjnI5f0v64c+MkbImi7pjwrLOk4ryjQQ0eiml3XtgqhWy6vWXqa6QM6twXzzna3URk7ZsmiJFr8/J4jiO7tf+sW73M5pFdF026ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0al/5CzZ3Wk/gG0xMFAnQXzvDCOJUQkQLJZndSoEx5A=;
 b=bSJUTOmJuTvZ1WglV+GVt/gtXb28/yzlPpRaKCe5OrTt2OzNC2eNMMaiJBF1QcOeGFJJNcme1yUCLiflnQJX1GjohlLV2Atg9vpDIuyh2jC5eExbAz5UHJ44bpldJI6ikrsQJXqNuZA07DZL6tsV9EKiJm9IspZi3nCqYLUezbYdni3XBf2XkSVJbc1/FiZ+IsW7gQsfeRlFumYzt7qYok+iT/rKjigVC/xbfKefL1XlFdhBieMi0FVXhn3OcjbyTQaGJR+SOgUeG3mIc9pCUBtZFjv0mxqRE6S5AfNJcPaMyBwglQRUPKKt4/wpKZZLT9JFzg1zWKHtrotfnUyJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0al/5CzZ3Wk/gG0xMFAnQXzvDCOJUQkQLJZndSoEx5A=;
 b=sq8/Qq9ob6SmcPlN88MyGT2NJvSqkk/DSrNeGi7maHdqFhflToBqkZK7GOwQ3UQFaiq8n2h8teO7PdJ5LnGTgy3NM/GL5IYjmdYQjqjW2BibmQ3CMi21swxP83KwqBaq7Y5z0sESw3A7iSFA5i+6s/h0NRJxUhF/Ka+qR53zb3M=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 00:48:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 00:48:41 +0000
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
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZOl8gO3KZIGBpqkaJFw/1xTLpFK7CpxCA
Date:   Tue, 7 Feb 2023 00:48:41 +0000
Message-ID: <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL3PR12MB6571:EE_
x-ms-office365-filtering-correlation-id: a2ba7f21-6343-4e6b-beaf-08db08a50eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLIRWLEUJFcYvHY7psbBXeMNvYNAL/vk2keXitlbgvZ7tbomELsIRF1CkJrWgTs5Y57ymQ8MV+ygyLzEhrOIFnCQqVBfGfE1p5FQfd6s16H0k0/1uOxZHngf06GfOPsnbiggbgt4p2TB3bCeCC2y8DYZjhZAEEMzO6EFENxrVQI8nljJ4hl6VuvD8kAPva4XPESrHdc93rFUxFsE+3ay+IPW4QQN5fdJiovPCqH+6hagUnkQqtlvDSB9hsZs2j+X2GWYiuOlVVJSCP9Rpdej+UxayH+CTah562vgckD3rbAqX95C72ekdWRsaCuA3r1nBnGeAqSXAXBWelwNBGaJ4CUPnZeJDTgXr8Z+f0zO83YEAwc9ayg4Md+cwSRYD7uGtSYjWSDjLJiQa1TL7xwnpLlRl4g2zBSZIpLuP/unIHI/PuHPtzQZk9oBZFREZ40HRX1nZQLB+7clB4CU95s84FC7rUagl0Lk/xtpIM36EoUPGG5x/HqnRlOLYwG5ITxH/mdH8QL4O1EYGMeKJY9Aj/nCD5/nu7Q85301cjIhMwKacDyxpEekEAfVNp5+qELcfrXrpKs41gheicDBpZzkd4uBq0ZtJanIiq6iyFETTMRp3r+FlbTpNFxv/+D6mJi1q5g6I7/3dscMtQSbWXlLarcKxYmDu1LFOXLDeTMnfpSap7fPd6uRKnAzilFcyqOOUHmS2ItHEmOw7pcpM+vcsf6YaCBVKTcztfUvh006OM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(36756003)(71200400001)(316002)(5660300002)(1076003)(6506007)(54906003)(64756008)(8676002)(2906002)(66556008)(66476007)(6916009)(4326008)(66946007)(478600001)(76116006)(66446008)(41300700001)(6486002)(8936002)(122000001)(6512007)(26005)(38100700002)(2616005)(86362001)(186003)(83380400001)(38070700005)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?by9PQzl4R0d3UHVoTUNJMmN5RlNITUdvdTZZeENsRG9IQnpZWlhXOWR3Ykh5?=
 =?utf-8?B?cU9aMzZhNVNPVE5hQUpuTmFHOXBtdGZVS3Y4blEwTG1ObjhOMXJuQit6NDl6?=
 =?utf-8?B?UE5NT1pBMWpXS1dzZURVMjBEd015M3g3WE1pTzNiSkUwQUNRdVRsSWJKbGtD?=
 =?utf-8?B?dzg2Q3JWcnkxa0NJTGdaaE9KY3N3c0NhOG1TVlB3YnRuZDVzWEJ6ZS9La0Zs?=
 =?utf-8?B?OVA2QXBhd1M3MEFKd05pTWc4N3ZIaXBxNEVTUnJjOTYyMVU2dW15WXpRWGM0?=
 =?utf-8?B?WWkrVHVtU1hIWDVXRXAzTHpla2F3MkttTGRvRjFyanB0R3YrdGhCVnBFWXFW?=
 =?utf-8?B?UjVDOW9OL2NpNTlxWkptTzVFMmN4K1pYRXBvZFZ4Y1ZCMWRiQVlBUE5QYWNK?=
 =?utf-8?B?eUJlY2s5dzJwWWxXdjdBSEtXY0dJVXduS21EVm5oa3lLY0prOVFHaldPQk5D?=
 =?utf-8?B?by9icHdoVEVsbTltRjY0WTNEWi9BTThGYThzZUsvRDFOTm9wQlVPQnhnY0ky?=
 =?utf-8?B?Q0FaYUV4aEJVVlFNVjNZQVFiYThObmsraE1lWFI5SVZUeWx5VUpxZVc4Y0hl?=
 =?utf-8?B?TldUaHdjcjFvZFFaRk1IbHJraVRUZUNyb1pDU3dyc3ozZU9BQWg2Si96US9a?=
 =?utf-8?B?eW0xSGFYSVh1c0M4V2FPMzlhcUVtdVB0VVFUMFNnZGR1eFRCUkd2RlhHQnhz?=
 =?utf-8?B?YjYwT0EyVVZsS0R6MHEyTThCL2NMUmZEalRqYnNlK29uTE85UC9vMFhrTTI1?=
 =?utf-8?B?MHd4V0JkSWNKV0lnR0hDL1JpYkZPRHdFbXRyL29ZWHJtR3VQcjQxQk5ya1Bi?=
 =?utf-8?B?bW9hR3hWdTkxRk1laUdnaVA1MkhlZXBTYXJRbjA3SFJSMVVYcE5NTVl4Y05i?=
 =?utf-8?B?Z0c3eTFHenVJK0xZa1U1VmNGbWJ5dGh6L1pHaEtkN1lUeWpySldwSXlkYzRh?=
 =?utf-8?B?b1lMRUxWUG52NW41elR1VHFMckg4Znh4V1B5aWxqRU9VWnVLdU9QREZsVkl2?=
 =?utf-8?B?azZOekM5VU4zTG9WU29xN3BNZVZNZ2RFRVhFeEdLQWpsZTNqQTlwbjd6Tkk2?=
 =?utf-8?B?dEJTbGNMWnh4UFhrQmNldzN3R3lVK3NiWmRSS0g0Y3M4YWd6YWRhUE41UXg1?=
 =?utf-8?B?YzIyWkN6dUlZbTVXcXJwbzN1NWsva2tqOGFxZlVMZFo3d1ZRbW1ucDJtaEVC?=
 =?utf-8?B?SGVwRVlBQ3c4TWREZHhzTEdjalh4aXpZNkptU3Y3K1dZelBNd3hmSThtMXQ4?=
 =?utf-8?B?dTZ2Q2swTUhzODB0cjdxQWVScXVpZXBsZ29tRkIrVGcwNmVaS2ZLbmNqN3Az?=
 =?utf-8?B?aVhnWm8vbWtJMVRmdmhOckRTMisxbE5GdjhCQ0t1djRjM2x4UmJ2OXpJZUha?=
 =?utf-8?B?ZDBXZXpsRnFNOStSandQYjZnb0dIMHBSZGRLeG80Z0QzeEovR0lNOUZFWWZF?=
 =?utf-8?B?VEpXakt0ZkkvR2x6cCtCMXhHTFMxWEdCM0ViQk1zQ0tGaGJ1cXNETllrdGUv?=
 =?utf-8?B?Tk5qQkpmOXlncVdsVU0rYW5jSWd6d1M5L2dhSWpMdGNpQUFTS0hzV2tUQzJx?=
 =?utf-8?B?c2RoWURla1BJLzQ5U20xWTNiK21JRkZkUEtxSG81U0tOSERiNGhPOFNnb2VN?=
 =?utf-8?B?TkJ6NTFwUVA0T2lQSnI1SWZmblg4am9qZ1gwQ3cwS2IrWkNlWUFMMTUrYmE2?=
 =?utf-8?B?eW8zNkFnWlpaeFkxeGJCNVZmNWViMHcxOWNYRklJQmtXazFUK0wvbUhSUmhk?=
 =?utf-8?B?R2ZVaTJURlhRYllRYlNvaE43dHhROVUxK1ZxWjJjRmlBeWZZdGlVTzlIM2x0?=
 =?utf-8?B?d09SRVJ6RytTUzNhZjltd0xnNUs0S1kvSE9wVUhYd29NQUhEYlVhNnFpRU4x?=
 =?utf-8?B?MEthOGZSREl2ZkpKT01HTkVRU0FwMXJjQjUzaHd6cEROZlVHN1RnWDlxaHJa?=
 =?utf-8?B?d01xYW9wU3hUUTJ0N3piTDkvZTN3V2dRZUlYSXpKZGhPWUoxMWN3d2dtNW1j?=
 =?utf-8?B?dzFsQVJ3WTVPQmRIWVhLU2krOVMwMzQ4NTVncWJjWkpVTXFybUt3TWJnUmdG?=
 =?utf-8?B?U0NId1FTaFozVjdMWWRmQUI2TFM3TDNvYlhEUEU1OVdOODZNL2QrN21CM3NO?=
 =?utf-8?B?U2xRRm1heDVISThaMXMrT0llWFYyT2c0OEhZSzgwUjJscTNtSVBGY00rZFVw?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52CA2A965AB6F040BE3C481B9CB4AF9A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pny1o27PscNM6mlN6h5ikqtwvyKB6IVyoTxIGOcC2QjL7KnF/S+7hvK7NLO1x8UAFSaEZIslJfMJXhRIolLtg1chYQIuR18w6WwZMC8S37FjQungBXUHRyi7KX6YY2E6vImr+/jYhtGu+RA7sM5vXotAxxLmmtrXKkr89WwagrRoxQ1ZaTyFLZihizZ5cuPb0rEYovUGzrVuy0Ht33KMUVqOQsoPdHoXIhUKpOc7gCCeV5qT8TauiNtYEYYA06JCSUG5a/ztjcldfjtB6RJpjweSDChnALGqUfHNE9hl88wM6tp/45himu0BtEyesc/y3D1vCJ8/CsSG2xA2eica0g4lD9qiXiZBXpRacl7FqLMCaMt4vByisrGwlohXgDozBd/5MqZALNjYcmdzyFsPhefZXayiapLP8dupup7oDNupdj0eBLJFt2O721s9RRAxkcDmqwS7a6FIMeFg2c3jDYSm8XmTbw/K0y6PIHs7GK2J2KqLM0ZZch5Q2v3XA7fz/vtoIQVGvPI62RZAcruP70zTYxOQDVE3RYm7CgOpb/gK3LCKz52v4ED9ACZ0aho6S0srnUQLnx7c6jx+VUr3Gfgi0Gh/VTxTZ0YUftiz7mW75hnSnFifyV7K+rUZw8Qd7Y9xrzAK/xkJQNnCsBHtzT1KSC3qS2fazpgP/okDYgCpemJBpQ6avVrA6S+SBJLTOJM+pgjj2d1GIZAnoUMj7JDUdZwYVfxbnQhdcrwekNfWvKf0ooV9TYvhC5XPsQ0FZHYFL+axcV8hQon2MsDJ4crgdxTxgGWktTm9BvI7Dtxy1YrcCVd/my4AHRMahqJzctcPRuWDXY03ffKuEUUthjHBikUWnbsmRAp3gmsCAJB6nQKk9jK3/jj3TioMEihk6WcHD5BH5E2SAjddoOEhwQrj24u1ynw350Fj1iY8HvE=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ba7f21-6343-4e6b-beaf-08db08a50eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:48:41.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NptDP71eZsw0ueWFDMKhjdpfLuju3ITqgOL5jwqtlOVW+BKb+LKuyK6xdvUS55RMivp+QRxP8X2AIeCzMF8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
X-Proofpoint-GUID: cy7OeFUJ940p-0aid3N1fQggLDW2bl2S
X-Proofpoint-ORIG-GUID: cy7OeFUJ940p-0aid3N1fQggLDW2bl2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMDYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBk
ZXZpY2UgY2FuIGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQg
b2YNCj4gc3VzcGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVh
dHVyZSBzZWxlY3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBz
ZXQgdGhlIHJlbW90ZSB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNvbWUgaG9zdHMgbWF5IHRh
a2UgbG9uZ2VyIHRpbWUgdG8gaW5pdGlhdGUgdGhlIHJlc3VtZSBzaWduYWxpbmcgYWZ0ZXINCj4g
ZGV2aWNlIHRyaWdnZXJzIGEgcmVtb3RlIHdha2V1cC4gU28gYWRkIGFzeW5jIHN1cHBvcnQgdG8g
dGhlIHdha2V1cCBBUEkNCj4gYnkgZW5hYmxpbmcgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgNCArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggOGY5OTU5Yi4uZmY2ZTZmNiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gQEAgLTExMTAsNiArMTExMCw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0K
PiAgICoJMwktIFJlc2VydmVkDQo+ICAgKiBAZGlzX21ldGFzdGFiaWxpdHlfcXVpcms6IHNldCB0
byBkaXNhYmxlIG1ldGFzdGFiaWxpdHkgcXVpcmsuDQo+ICAgKiBAZGlzX3NwbGl0X3F1aXJrOiBz
ZXQgdG8gZGlzYWJsZSBzcGxpdCBib3VuZGFyeS4NCj4gKyAqIEByd19jb25maWd1cmVkOiBzZXQg
aWYgdGhlIGRldmljZSBpcyBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAgICogQGlt
b2RfaW50ZXJ2YWw6IHNldCB0aGUgaW50ZXJydXB0IG1vZGVyYXRpb24gaW50ZXJ2YWwgaW4gMjUw
bnMNCj4gICAqCQkJaW5jcmVtZW50cyBvciAwIHRvIGRpc2FibGUuDQo+ICAgKiBAbWF4X2NmZ19l
cHM6IGN1cnJlbnQgbWF4IG51bWJlciBvZiBJTiBlcHMgdXNlZCBhY3Jvc3MgYWxsIFVTQiBjb25m
aWdzLg0KPiBAQCAtMTMyNiw2ICsxMzI3LDcgQEAgc3RydWN0IGR3YzMgew0KPiAgDQo+ICAJdW5z
aWduZWQJCWRpc19zcGxpdF9xdWlyazoxOw0KPiAgCXVuc2lnbmVkCQlhc3luY19jYWxsYmFja3M6
MTsNCj4gKwl1bnNpZ25lZAkJcndfY29uZmlndXJlZDoxOw0KPiAgDQo+ICAJdTE2CQkJaW1vZF9p
bnRlcnZhbDsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gaW5kZXggNjFkZTY5My4uY2Q3YzBjYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Vw
MC5jDQo+IEBAIC0zNTYsNiArMzU2LDkgQEAgc3RhdGljIGludCBkd2MzX2VwMF9oYW5kbGVfc3Rh
dHVzKHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCQkJdXNiX3N0YXR1cyB8PSAxIDw8IFVTQl9ERVZf
U1RBVF9VMV9FTkFCTEVEOw0KPiAgCQkJaWYgKHJlZyAmIERXQzNfRENUTF9JTklUVTJFTkEpDQo+
ICAJCQkJdXNiX3N0YXR1cyB8PSAxIDw8IFVTQl9ERVZfU1RBVF9VMl9FTkFCTEVEOw0KPiArCQl9
IGVsc2Ugew0KPiArCQkJdXNiX3N0YXR1cyB8PSBkd2MtPmdhZGdldC0+cndfYXJtZWQgPDwNCj4g
KwkJCQkJVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOw0KPiAgCQl9DQo+ICANCj4gIAkJYnJlYWs7
DQo+IEBAIC00NzYsNiArNDc5LDcgQEAgc3RhdGljIGludCBkd2MzX2VwMF9oYW5kbGVfZGV2aWNl
KHN0cnVjdCBkd2MzICpkd2MsDQo+ICANCj4gIAlzd2l0Y2ggKHdWYWx1ZSkgew0KPiAgCWNhc2Ug
VVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOg0KPiArCQlkd2MtPmdhZGdldC0+cndfYXJtZWQgPSBz
ZXQ7DQo+ICAJCWJyZWFrOw0KPiAgCS8qDQo+ICAJICogOS40LjEgc2F5cyBvbmx5IGZvciBTUywg
aW4gQWRkcmVzc1N0YXRlIG9ubHkgZm9yDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA4OWRjZmFjLi5k
MGI5OTE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTI1OCw3ICsyNTgsNyBAQCBpbnQgZHdj
M19zZW5kX2dhZGdldF9nZW5lcmljX2NvbW1hbmQoc3RydWN0IGR3YzMgKmR3YywgdW5zaWduZWQg
aW50IGNtZCwNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IF9fZHdj
M19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2MzICpkd2MpOw0KPiArc3RhdGljIGludCBfX2R3YzNf
Z2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjLCBib29sIGFzeW5jKTsNCj4gIA0KPiAgLyoq
DQo+ICAgKiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCAtIGlzc3VlIGFuIGVuZHBvaW50IGNvbW1h
bmQNCj4gQEAgLTMyNSw3ICszMjUsNyBAQCBpbnQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoc3Ry
dWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGNtZCwNCj4gIA0KPiAgCQkJZmFsbHRocm91
Z2g7DQo+ICAJCWNhc2UgRFdDM19MSU5LX1NUQVRFX1UzOg0KPiAtCQkJcmV0ID0gX19kd2MzX2dh
ZGdldF93YWtldXAoZHdjKTsNCj4gKwkJCXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3Yywg
ZmFsc2UpOw0KPiAgCQkJZGV2X1dBUk5fT05DRShkd2MtPmRldiwgcmV0LCAid2FrZXVwIGZhaWxl
ZCAtLT4gJWRcbiIsDQo+ICAJCQkJCXJldCk7DQo+ICAJCQlicmVhazsNCj4gQEAgLTIyNjksNiAr
MjI2OSwxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9lcF9vcHMgZHdjM19nYWRnZXRfZXBf
b3BzID0gew0KPiAgDQo+ICAvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLw0KPiAgDQo+ICtzdGF0aWMg
dm9pZCBkd2MzX2dhZGdldF9lbmFibGVfbGlua3N0c19ldnRzKHN0cnVjdCBkd2MzICpkd2MsIGJv
b2wgc2V0KQ0KPiArew0KPiArCXUzMiByZWc7DQoNCkFkZCBhIGNoZWNrIGhlcmUgdG8gcHJldmVu
dCBkaXNhYmxpbmcgbGluayBzdGF0ZSBldmVudCBpZiB0aGUgY29udHJvbGxlcg0KaXMgZHdjX3Vz
YjMgMi41MGEuIFNvbWUgb2xkZXIgY29udHJvbGxlciBhbHdheXMgZW5hYmxlcyB0aGlzIGV2ZW50
IGZvciBhDQpxdWlyay4NCg0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERX
QzNfREVWVEVOKTsNCj4gKwlpZiAoc2V0KQ0KPiArCQlyZWcgfD0gRFdDM19ERVZURU5fVUxTVENO
R0VOOw0KPiArCWVsc2UNCj4gKwkJcmVnICY9IH5EV0MzX0RFVlRFTl9VTFNUQ05HRU47DQo+ICsN
Cj4gKwlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfREVWVEVOLCByZWcpOw0KPiArfQ0KPiAr
DQo+ICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2dldF9mcmFtZShzdHJ1Y3QgdXNiX2dhZGdldCAq
ZykNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGdhZGdldF90b19kd2MoZyk7DQo+IEBA
IC0yMjc2LDcgKzIyODksNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2dldF9mcmFtZShzdHJ1
Y3QgdXNiX2dhZGdldCAqZykNCj4gIAlyZXR1cm4gX19kd2MzX2dhZGdldF9nZXRfZnJhbWUoZHdj
KTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdj
MyAqZHdjLCBib29sIGFzeW5jKQ0KPiAgew0KPiAgCWludAkJCXJldHJpZXM7DQo+ICANCj4gQEAg
LTIyOTYsOSArMjMwOSwxNCBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJbGlua19zdGF0ZSA9IERXQzNfRFNUU19VU0JMTktTVChyZWcpOw0K
PiAgDQo+ICAJc3dpdGNoIChsaW5rX3N0YXRlKSB7DQo+ICsJY2FzZSBEV0MzX0xJTktfU1RBVEVf
VTM6CS8qIGluIEhTLCBtZWFucyBTVVNQRU5EICovDQoNCkl0J3MgYWxzbyBwb3NzaWJsZSB0byBk
byByZW1vdGUgd2FrZXVwIGluIEwxIGZvciBoaWdoc3BlZWQuDQoNCj4gKwkJaWYgKCFkd2MtPnJ3
X2NvbmZpZ3VyZWQpIHsNCj4gKwkJCWRldl9lcnIoZHdjLT5kZXYsDQo+ICsJCQkJImRldmljZSBu
b3QgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cFxuIik7DQo+ICsJCQlyZXR1cm4gLUVJTlZB
TDsNCj4gKwkJfQ0KPiAgCWNhc2UgRFdDM19MSU5LX1NUQVRFX1JFU0VUOg0KPiAgCWNhc2UgRFdD
M19MSU5LX1NUQVRFX1JYX0RFVDoJLyogaW4gSFMsIG1lYW5zIEVhcmx5IFN1c3BlbmQgKi8NCj4g
LQljYXNlIERXQzNfTElOS19TVEFURV9VMzoJLyogaW4gSFMsIG1lYW5zIFNVU1BFTkQgKi8NCj4g
IAljYXNlIERXQzNfTElOS19TVEFURV9VMjoJLyogaW4gSFMsIG1lYW5zIFNsZWVwIChMMSkgKi8N
Cj4gIAljYXNlIERXQzNfTElOS19TVEFURV9VMToNCj4gIAljYXNlIERXQzNfTElOS19TVEFURV9S
RVNVTUU6DQo+IEBAIC0yMzA3LDkgKzIzMjUsMTMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0
X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+
ICANCj4gKwlpZiAoYXN5bmMpDQo+ICsJCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMo
ZHdjLCB0cnVlKTsNCj4gKw0KPiAgCXJldCA9IGR3YzNfZ2FkZ2V0X3NldF9saW5rX3N0YXRlKGR3
YywgRFdDM19MSU5LX1NUQVRFX1JFQ09WKTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlkZXZf
ZXJyKGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIHB1dCBsaW5rIGluIFJlY292ZXJ5XG4iKTsNCj4gKwkJ
ZHdjM19nYWRnZXRfZW5hYmxlX2xpbmtzdHNfZXZ0cyhkd2MsIGZhbHNlKTsNCj4gIAkJcmV0dXJu
IHJldDsNCj4gIAl9DQo+ICANCj4gQEAgLTIzMjEsNiArMjM0MywxMyBAQCBzdGF0aWMgaW50IF9f
ZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCWR3YzNfd3JpdGVsKGR3
Yy0+cmVncywgRFdDM19EQ1RMLCByZWcpOw0KPiAgCX0NCj4gIA0KPiArCS8qDQo+ICsJICogU2lu
Y2UgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cyBhcmUgZW5hYmxlZCB3ZSB3aWxsIHJlY2VpdmUN
Cj4gKwkgKiBhbiBVMCBldmVudCB3aGVuIHdha2V1cCBpcyBzdWNjZXNzZnVsLiBTbyBiYWlsIG91
dC4NCj4gKwkgKi8NCj4gKwlpZiAoYXN5bmMpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAJLyog
cG9sbCB1bnRpbCBMaW5rIFN0YXRlIGNoYW5nZXMgdG8gT04gKi8NCj4gIAlyZXRyaWVzID0gMjAw
MDA7DQo+ICANCj4gQEAgLTIzNDcsMTIgKzIzNzYsMzAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdl
dF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAJaW50CQkJcmV0Ow0KPiAgDQo+ICAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAtCXJldCA9IF9fZHdjM19n
YWRnZXRfd2FrZXVwKGR3Yyk7DQo+ICsJaWYgKCFkd2MtPmdhZGdldC0+cndfYXJtZWQpIHsNCj4g
KwkJZGV2X2Vycihkd2MtPmRldiwgIiVzOnJlbW90ZSB3YWtldXAgbm90IGVuYWJsZWRcbiIsIF9f
ZnVuY19fKTsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKwlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dh
a2V1cChkd2MsIHRydWUpOw0KPiArDQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3NldF9yZW1vdGV3YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGlu
dCBzZXQpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzMJCSpkd2MgPSBnYWRnZXRfdG9fZHdjKGcpOw0K
PiArCXVuc2lnbmVkIGxvbmcJCWZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmR3
Yy0+bG9jaywgZmxhZ3MpOw0KPiArCWR3Yy0+cndfY29uZmlndXJlZCA9ICEhc2V0Ow0KPiArCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJcmV0dXJu
IDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVk
KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAgCQlpbnQgaXNfc2VsZnBvd2VyZWQpDQo+ICB7DQo+
IEBAIC0yOTc4LDYgKzMwMjUsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9hc3luY19jYWxs
YmFja3Moc3RydWN0IHVzYl9nYWRnZXQgKmcsIGJvb2wgZW5hYmxlKQ0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyBkd2MzX2dhZGdldF9vcHMgPSB7DQo+ICAJLmdldF9mcmFt
ZQkJPSBkd2MzX2dhZGdldF9nZXRfZnJhbWUsDQo+ICAJLndha2V1cAkJCT0gZHdjM19nYWRnZXRf
d2FrZXVwLA0KPiArCS5zZXRfcmVtb3Rld2FrZXVwCT0gZHdjM19nYWRnZXRfc2V0X3JlbW90ZXdh
a2V1cCwNCj4gIAkuc2V0X3NlbGZwb3dlcmVkCT0gZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVk
LA0KPiAgCS5wdWxsdXAJCQk9IGR3YzNfZ2FkZ2V0X3B1bGx1cCwNCj4gIAkudWRjX3N0YXJ0CQk9
IGR3YzNfZ2FkZ2V0X3N0YXJ0LA0KPiBAQCAtMzgyMSw2ICszODY5LDggQEAgc3RhdGljIHZvaWQg
ZHdjM19nYWRnZXRfZGlzY29ubmVjdF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0K
PiAgCWR3Yy0+Z2FkZ2V0LT5zcGVlZCA9IFVTQl9TUEVFRF9VTktOT1dOOw0KPiAgCWR3Yy0+c2V0
dXBfcGFja2V0X3BlbmRpbmcgPSBmYWxzZTsNCj4gKwlkd2MtPmdhZGdldC0+cndfYXJtZWQgPSBm
YWxzZTsNCj4gKwlkd2MzX2dhZGdldF9lbmFibGVfbGlua3N0c19ldnRzKGR3YywgZmFsc2UpOw0K
PiAgCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0LCBVU0JfU1RBVEVfTk9UQVRUQUNI
RUQpOw0KPiAgDQo+ICAJaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFKSB7DQo+
IEBAIC0zOTE0LDYgKzM5NjQsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRl
cnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlyZWcgJj0gfkRXQzNfRENUTF9UU1RDVFJMX01B
U0s7DQo+ICAJZHdjM19nYWRnZXRfZGN0bF93cml0ZV9zYWZlKGR3YywgcmVnKTsNCj4gIAlkd2Mt
PnRlc3RfbW9kZSA9IGZhbHNlOw0KPiArCWR3Yy0+Z2FkZ2V0LT5yd19hcm1lZCA9IGZhbHNlOw0K
PiArCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBmYWxzZSk7DQo+ICAJZHdj
M19jbGVhcl9zdGFsbF9hbGxfZXAoZHdjKTsNCj4gIA0KPiAgCS8qIFJlc2V0IGRldmljZSBhZGRy
ZXNzIHRvIHplcm8gKi8NCj4gQEAgLTQwNjYsNyArNDExOCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X2Nvbm5kb25lX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCSAqLw0KPiAg
fQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0
KHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBldnRpbmZvKQ0KPiAgew0KPiAgCS8qDQo+
ICAJICogVE9ETyB0YWtlIGNvcmUgb3V0IG9mIGxvdyBwb3dlciBtb2RlIHdoZW4gdGhhdCdzDQo+
IEBAIC00MDc4LDYgKzQxMzAsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50
ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCWR3Yy0+Z2FkZ2V0X2RyaXZlci0+cmVzdW1l
KGR3Yy0+Z2FkZ2V0KTsNCj4gIAkJc3Bpbl9sb2NrKCZkd2MtPmxvY2spOw0KPiAgCX0NCj4gKw0K
PiArCWR3Yy0+bGlua19zdGF0ZSA9IGV2dGluZm8gJiBEV0MzX0xJTktfU1RBVEVfTUFTSzsNCj4g
IH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfbGlua3N0c19jaGFuZ2VfaW50ZXJy
dXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+IEBAIC00MTU5LDYgKzQyMTMsMTAgQEAgc3RhdGljIHZv
aWQgZHdjM19nYWRnZXRfbGlua3N0c19jaGFuZ2VfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2Ms
DQo+ICAJfQ0KPiAgDQo+ICAJc3dpdGNoIChuZXh0KSB7DQo+ICsJY2FzZSBEV0MzX0xJTktfU1RB
VEVfVTA6DQo+ICsJCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBmYWxzZSk7
DQo+ICsJCWR3YzNfcmVzdW1lX2dhZGdldChkd2MpOw0KPiArCQlicmVhazsNCj4gIAljYXNlIERX
QzNfTElOS19TVEFURV9VMToNCj4gIAkJaWYgKGR3Yy0+c3BlZWQgPT0gVVNCX1NQRUVEX1NVUEVS
KQ0KPiAgCQkJZHdjM19zdXNwZW5kX2dhZGdldChkd2MpOw0KPiBAQCAtNDIyNyw3ICs0Mjg1LDcg
QEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+
ICAJCWR3YzNfZ2FkZ2V0X2Nvbm5kb25lX2ludGVycnVwdChkd2MpOw0KPiAgCQlicmVhazsNCj4g
IAljYXNlIERXQzNfREVWSUNFX0VWRU5UX1dBS0VVUDoNCj4gLQkJZHdjM19nYWRnZXRfd2FrZXVw
X2ludGVycnVwdChkd2MpOw0KPiArCQlkd2MzX2dhZGdldF93YWtldXBfaW50ZXJydXB0KGR3Yywg
ZXZlbnQtPmV2ZW50X2luZm8pOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIERXQzNfREVWSUNFX0VW
RU5UX0hJQkVSX1JFUToNCj4gIAkJaWYgKGRldl9XQVJOX09OQ0UoZHdjLT5kZXYsICFkd2MtPmhh
c19oaWJlcm5hdGlvbiwNCj4gQEAgLTQ0ODcsNiArNDU0NSw3IEBAIGludCBkd2MzX2dhZGdldF9p
bml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjLT5nYWRnZXQtPnNnX3N1cHBvcnRlZAk9IHRy
dWU7DQo+ICAJZHdjLT5nYWRnZXQtPm5hbWUJCT0gImR3YzMtZ2FkZ2V0IjsNCj4gIAlkd2MtPmdh
ZGdldC0+bHBtX2NhcGFibGUJPSAhZHdjLT51c2IyX2dhZGdldF9scG1fZGlzYWJsZTsNCj4gKwlk
d2MtPmdhZGdldC0+cndfY2FwYWJsZQkJPSBkd2MtPmdhZGdldC0+b3BzLT53YWtldXAgPyB0cnVl
IDogZmFsc2U7DQoNCkp1c3Qgc2V0IGl0IHRvIHRydWUgaGVyZS4NCg0KPiAgDQo+ICAJLyoNCj4g
IAkgKiBGSVhNRSBXZSBtaWdodCBiZSBzZXR0aW5nIG1heF9zcGVlZCB0byA8U1VQRVIsIGhvd2V2
ZXIgdmVyc2lvbnMNCj4gLS0gDQo+IDIuNy40DQo+IA0KDQpUaGFua3MsDQpUaGluaA==
