Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE762EA42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiKRA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRA23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:28:29 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642110C4;
        Thu, 17 Nov 2022 16:28:26 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHNRAdd030309;
        Thu, 17 Nov 2022 16:28:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=aHJRzQ1Qc+hMtSt3n6uYPVbcWLfWkqTo3wg2GgqhzAI=;
 b=wJAhJ9t/Y8ukamls50YbhgTRA893ZoUSJjomVGNv/57BS8/ZWw3eErw6vEZV1F7qGaH9
 VMvzmNtEtBsx2Oqs4dfGrbPI8zEnuPIey7buv5s/KF8uuAA1lTQUhcB/2tNxTyEGSJHl
 fsi5a263wJb78Cu9FvpVhijRo5uDNTeg7CmjMKwELnII/96euJnzIVxAxyc68bRyaXfn
 foYdPr3ynTpOVy0OwAELrA81ta8PrTPv6sKnpNGRRsG6v1n9P04BnpeE+tKl7LQ0HiRD
 hUNBeB0KSBAXxK7RE/flLAm7BQp50NOgdVHHBBMP0X/KQATecx/LQWsVyenDj9bUoLKI 9Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kwxn2r6an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 16:28:13 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1921DC07FF;
        Fri, 18 Nov 2022 00:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1668731280; bh=aHJRzQ1Qc+hMtSt3n6uYPVbcWLfWkqTo3wg2GgqhzAI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aNgW79XsjhGVZz7qNs72k9OT5+zolZ9FKKAr3T+ZAiaMohB+0ULnS+Z+BQaa2pVkb
         aEWgapTDl40UiRpzE8/TbJfAChuUPCwK0U3olDhMuhbvUV+rEzXKZh4rnOIeMLZpyY
         hjgBWVzKtESIb55rMrdONJ/QRL+0gfUIim8IVc4XAZGNHC81A7nusMmO5RkEN4Ct+t
         PURk67JkgpLA2Xr+yFwfdCdFEfF28+iC5aNYiN53wjOC7VvIl3frByGC6lbYDBjZsJ
         mulFU3jRequ+32Qj5lZpSF1OwrRSUnOk22+8mOdQ64jvelxOGyW13Hjzqkb4whVdBO
         sGpKcPqCDTJeQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0CD85A008E;
        Fri, 18 Nov 2022 00:27:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5D3C9802B0;
        Fri, 18 Nov 2022 00:27:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="e0CG4rYs";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi+Oa6yIcc/FXkGRt04u4S+mmqRA/Ctzuay+cllAxaXPMLHUrPyDU3bPJ0X40zEmjlG0DPomTOdj4tMgYDjhK+VmSPjlcC10aiQvsT0ct6XLVNoBz944ewViKFGi0giBrVnn/Bgcn+HzXyaBBxVRySeGM/qtxasvliw+H4z6Plu4dj+i+XaNfdAQgnNiLd8kr64FCrFZzDE4q9or9MDRHLlAEgBWfTdj8R//Jvvqd24FfS3jx5CDhqmxmViabVCq3D09z0ledLC1cVZCKyYaGFPsipXxlWxGchZDyudlXBGb04yX5vpQVUhYMS6O3e7Yf3qYgInJVsIe9AZZaauCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHJRzQ1Qc+hMtSt3n6uYPVbcWLfWkqTo3wg2GgqhzAI=;
 b=NdNj8BkQH5uIWB8U//kplrk+DmL6cSacAcXmIN+5Yz8ykMbbU/QLEL5Nf5L3GVyyNFx1BY8ry2nCTMM18ZANIOHBg/i/bwlW0bLI5VRYBlT7JVJT2MEa1ek8SZBcHhUxPou0lRnfa7I8iTAPNX+SeHOatDZ1aUbxSjCvOXddQTmgShEEv24uz/9GHR5dtLbivmYYQV50/+KsLpm7cYCOGP/Q/a66NYp7xiYKHgL9USCfvCQvefVDuk8ph2y6kOt2DFv6hHVLj2x3i/3N3qojD5mEE2066YnJ7V/2KWNYrcthft2YaMu7v1TTTCUKV4mwGa+zAkByEnOZvPKGl5T1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHJRzQ1Qc+hMtSt3n6uYPVbcWLfWkqTo3wg2GgqhzAI=;
 b=e0CG4rYsQwHAGhsCVNZjUtZRqsk3wteUUh+JS3M6/Vd9gjqeRbe1QZ+I9ILV7tIlRhrm2gbuCQYWdCXRNhsSoY+KZ5By58rFoyWzFU4YV1wBvGJnSCEW9QzFTY+MLBYJ1G8qJUU2eEniktWrPsgCQeSdXYyo6H35m/6aYq1KX74=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 00:27:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 00:27:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: improve the config dependency of
 USB_DWC3_XILINX
Thread-Topic: [PATCH] usb: dwc3: improve the config dependency of
 USB_DWC3_XILINX
Thread-Index: AQHY+atN01Wpuvw3fE+NOOPcpOZgXa5D1cyA
Date:   Fri, 18 Nov 2022 00:27:53 +0000
Message-ID: <20221118002741.moxtkqycxv5wkuxd@synopsys.com>
References: <20221116110444.8340-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221116110444.8340-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB6104:EE_
x-ms-office365-filtering-correlation-id: 0f801eaa-ea33-4a0a-8378-08dac8fbbb52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2r1XqMq5cuPcDiMsaIXXZuNZwNwyWPIECDxmmwv5pfdZ7J2nP3o08/W4pKq9YJyo7zUVHusHO8F6c+r0R/9DptZDO7/ZMfzwi6UXlHQlmqKySl5nrtPF0FpEGJI0YosydmNV3qMRZYyuxKTnB1vbUozKLPZqsYWs7acSmhvNKqNBc2aDRtB0e2vOvDoYAjHfzJoFDBPq90/PYP6pJYzb2zp8TTsX/qDHHVp91rwp4P2/GFaJwAgjyDZf+RSbGZUu8ctQ4IPp9jIDBU2mV6kMWteTtdKpEgKR/uLuLmWEciJZL8vTituKeDh6fWUqDj/8gJydr6mtfkzYPIMImMRuJBdhQ+djXm8hMkKGcHPn5ThzRtQnFIG0ySsk9ld/oVKCcFnF8YeHAUx2OM+e+LSgQNdVVQp3ezdZPGJyB6OyHBdldA0O5ypXdYx3IsqG9dw9mknH77AcolCCVOaG4N0rAQMExyUNiIINIc2Zes4X8jTj9m3jR6/HrYO1kHyo3gDskAOqTucXeh+p3YYV7znwGNDC2WbzPldkymfegqQMrkQ/oksq0p2FUfjDGigolmvM6wmhTXjRLkcLRBttelw/xv4GRoSNvjgPc12k+rlql9z6eSXra53W/ky+K0l442k312ZOcwciRLLOqQL/mX8u+fFMhB8zd+LWXxedtfMWh9pyfzQZFAgbBMtefFVSpGjsvaYgPG9SLSMG3k3Z5JGvyXiSzISysgQzz2zECDazaVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(316002)(478600001)(41300700001)(26005)(6506007)(6512007)(110136005)(66556008)(71200400001)(54906003)(4326008)(966005)(66446008)(66946007)(66476007)(64756008)(76116006)(6486002)(2616005)(5660300002)(186003)(8936002)(1076003)(8676002)(83380400001)(2906002)(86362001)(36756003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0ZxV2RqcHlUNlFQcDNpOWRvOHpnd2ZSSm9jNVplRUlpSm54cml6OTRsZm1V?=
 =?utf-8?B?ZGF4c215WklpTXhZNWdOQkRlZDRFV1NXRUtyL08zOU5ESDF6aGJBeUNPTDZI?=
 =?utf-8?B?VElNYzJnb01USUFNMU9XZUh1aldldmk5ZUNHNTVuSFE1MSt5RExpNVJvaDQ5?=
 =?utf-8?B?VFN1ajBRTzlyRlBLbnJLYXdRRlZpeGZKUVZ3cVprTkhIQTc1WmxaM0hCQWpJ?=
 =?utf-8?B?YnB3SXVLNlpzUW1adUFzR21mTENhRENjWmloM0lUWVJDTHZJUkJObU5TTk83?=
 =?utf-8?B?ZHJudjlTZE9oQ2lUMFNZUlVNcXBHd1JXOXV6M1phSGFuU2VydTZlc1E4aCtF?=
 =?utf-8?B?aUd6UUt6YUR2QXAvSGNHdFNHWkx5eGFmSTNxVjFMM1J4RStsblVqaXJXVS93?=
 =?utf-8?B?ZnBsS0NXVVpSUEd4S1VsSUxtY25mbWUvSVFLLy84aVI2bk4vb1h6ZDVCU1Nk?=
 =?utf-8?B?UCttTWE0VEtaSGMrUHE2aWlaZjV1eVNCV0VzaUoxUUJ1WDAwV21SaWhDNlND?=
 =?utf-8?B?RXdrVWcyMEtQandZY0xDSHdRYzhyZk9MVCsyYkF3Y2xwZmFpWndnT3FlNm04?=
 =?utf-8?B?eUw5cldxZ2gzYitRWWR5SGZqaUpVc1Nmb2ZVdTRZZVdYVHN5bCtHTTNzWnN2?=
 =?utf-8?B?K3hpMm1tYVdqTkdpODU0UCs5WHJjTGNiREJ4WVUvOWdsV2ZJTytMZmNZYWhj?=
 =?utf-8?B?dkp6OHlSQ2dZc2cwVG9JbU1aaC9qUmJGTmt1NlNIREdhd0xVSFA1R1cyM2NM?=
 =?utf-8?B?Q2g4RkZCR0lQdEdWY2RWeC9Xc0JySzljL2VLZEc5N2VHbERWYWJFWE1WeStz?=
 =?utf-8?B?Ylg1VzJCVVJhSzQ0ZXpTOHQ5K1hDWG1WSkd6SkIxb3d1NFFJdm5Eb1hlZTMx?=
 =?utf-8?B?cGJQT1E1d0lJenRmQ3daY2RKSGk4bkFMUDF3MGdwQzRmYWIvdmdoRytkVTVr?=
 =?utf-8?B?U2ZWOEd1OXBGaDZNK1Y1WlJTL2lKTnhYU2l6MlpEQm1jK0lvN25BcjhCNlpZ?=
 =?utf-8?B?L25BUkh5aVJ1VVhPY0RDT0MxaWxUeDhMdzY1UlZ4KzJQL3p1WXBQUjNDSXlY?=
 =?utf-8?B?WlI3Z2Z4MjJWamVzNjhSbXBHTWVRTC8vOVpueUNnL0RrTUluSC9xZzVCQmNt?=
 =?utf-8?B?elRFREJjbVRaRWRUck45U29xUkUrbEc0VUtES0Q1ZlBiUGVjbXdXVGhhcld1?=
 =?utf-8?B?NGR5dmc2cDZVcmVJUExRbzJ0QkRBaGhyOWZpSEp4ajhCYXY3SGtHQ1hwVTF6?=
 =?utf-8?B?MVVYOWQ0QVFxVkk2aXlnb1RjK2QwTWdsQVNvVEdTekgrMXNFcDVJQ0E0MjBu?=
 =?utf-8?B?emc1ekRFUmRmVEdGZXUrbVVrSnlScW9OZVZYR2tnKytUZ0JRMkFpc0ZkRlpq?=
 =?utf-8?B?VjEwVmRUcHVtL25nK3d5ajdrNzVGdExpTytFMTM5WEdoRVRHOXpRVkNqeTJv?=
 =?utf-8?B?VFNzMVRuTk51d0ticTlJdTlLSnAvMHdYejRFK3NKWksrTDlINmtzWk5xL3Ey?=
 =?utf-8?B?Tlp5RlpSM3hiRm1ta3AwdlhzMktVNFNKcURQOUVzY2l1d0w0ODJhdDdCTDla?=
 =?utf-8?B?Z2lpOWI0SXF2MENXSG9HK1ZnYW9LNWdZTDR1d0d6NTB1L1BldjZsRnZtV3N1?=
 =?utf-8?B?bkpJd0YvYTFXSmkyMU1kRFdST0NEdVNDTndyd1FkTGpDMUNnSFNBbXBkVk9N?=
 =?utf-8?B?RUZRREZvM0NvMXp0ZFZxUm9hR1kwWHYvU3QwNVpJQmlDRSt4K0xTWDBVY3gv?=
 =?utf-8?B?ZzlOZ0QwQk9FK216YXpmZHFmcS9HK3pURVlkNWdhMjZnSEtzeVBRNnIzOVRp?=
 =?utf-8?B?R2VoK1RCSnRVeDNMTmJhZmpjM1RyWll5cFF4aGEwY0M0TFBuL29hQmxUcSt1?=
 =?utf-8?B?TXAzTlMyd29OSGN1TnFhQm5TZFk4RkkzbHdRaTJqVDUvTFlVWVd6cDVZc1Zv?=
 =?utf-8?B?REJTeVV4Wk8xUHV2R1VUb0xvU01NcVdKRTZ2LzVQQXRwenVmZmxaUThMRzF3?=
 =?utf-8?B?a0wzek5NVDd1RkVOT25KMXpyQzFYaTVkV1R3SEpTU1Z0OWZZdEpIZmo4NHJz?=
 =?utf-8?B?OUQ1dEMvQ2ZZb1FnME1nV2ZaTzJoZm9iRDVYT0dQT1JsN3VGYzFQQkZOMjBD?=
 =?utf-8?Q?YPRyYDJJOufRL1Ye+C2e+Hh4b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCE56273BE9AE42A583DA441F180194@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YkJlSkF3RlZNOFBuOGdlOU1EREF3M2NMQ282NHlxS0VmQys4ZXJybjZIdlVV?=
 =?utf-8?B?eDk2ckh0MTlsMlRSRnIvSk5hY0tRVUFCVGtMb3FGcHZOT2wyRWxoYk5odGwy?=
 =?utf-8?B?Z1BTbjN4RTU5N2dUMzA5ZWVBdHpNRXJwOGVzSVJsUDYvbFIzd05iZnBpS1BH?=
 =?utf-8?B?QndOQ3ROY0swb2FmeUNHOUUzUkRWUHhQZnhxLzFQeWNwemVTVjVSODE3Wis3?=
 =?utf-8?B?d0k3cDU3bEtjREsrVGFReVp2c3VnQThmOW1tUnNqenVjd21KbjZsdldnMXJt?=
 =?utf-8?B?WnMyb1B5clovVlhtbTRhVnoweHZwY3E0cis4UW5jR0V1V01XNW5tMk1LdmR1?=
 =?utf-8?B?b3ZpSmFaU29vYi9HWVFUdzczeVRPY3lTZjExRW8zWE05cEFIZDZvSDd5T05w?=
 =?utf-8?B?REpwMmdzRXRycllHVC9iQlRkcXhFdm54eXdVbERTT3dSN0ptRHEwS3JxaXpU?=
 =?utf-8?B?VWJLQTZTSUk5NGRkV0ZNbE16UXhnTkpVWWxmYS80VGhFdzlaMGQ4UUt2blV5?=
 =?utf-8?B?ZlJzMXhtRmV5eWUrZGxJSEpmd01zNEwrVkZLMXUwZGtHV1Q5WGk2bXEvaTNG?=
 =?utf-8?B?TzFmVG1oZGNXTGhyb0VIc1Njby9hZUp2KzcwYlRmYVNBb3lxRWVBb2NTWmtl?=
 =?utf-8?B?SmV6S2l1bklaWjlyQ2k4K2tyZ2IyZnBvcXVZUG9NL2xUeHcvK21UY0xJS0V5?=
 =?utf-8?B?S2xyRzBnNWZKYnRsbkhwVTBPSkc1ZkFvU0MrUTZOeGt4bVcrWUdJcXdNcHRJ?=
 =?utf-8?B?aVZTTkZLMmlkdDdibXQ4T3FTZWlydWt6TGk2T0VQUFhqMU1aSUdwWEJZUlh0?=
 =?utf-8?B?eGRsUVdoYTk1S0hvWFhJcmIvamxkTnFVc1hqQWdvY1Vxb1ZqWEFDRGlLREFZ?=
 =?utf-8?B?RHluRlBpb0lubXhTaFJTVzdBR0VnZkxMWWlMc0tBT3A4S3QwSnhwWHhYYzZO?=
 =?utf-8?B?d1NKeU5FT3NybmlZM3YzTy9jZzhrN2I4c04xN1lhNXBSUlJJQkVJT0Vuc2JQ?=
 =?utf-8?B?TENkSHIyTXAwcHRXOTFNdFF1bHc2ZlgvRXdnWkR5ajg2eXZaamFoWE95UDRs?=
 =?utf-8?B?U1Q5TVZQZDJQVFlXdHlacEpDYVIwVHdLT3EzY0hRNVF0RFpaUlFxNHo5MWFt?=
 =?utf-8?B?WkdaUGFSWFBYKzg4RjI4V013UnpCeWV0Ny9ZQ3ZJWHBTcW92VlhZcVhRMmQz?=
 =?utf-8?B?UWJkZUpncGpvdWx6UGM2azV5em1CaDBsZUZIS0VZUkU4WEVFamw0OHRTeVJ6?=
 =?utf-8?B?VWJyYnpVZ3NzTzlRbUVRKzhkNXlNSTBXMGZsNGRJVjU2bHhtN0VoM3VoVCty?=
 =?utf-8?B?MFRtZjV2cDBmaWZUc1d5TFhXOEFGN2NBaCs3d0NaanNYQUFkaG1tWHJ4VzZB?=
 =?utf-8?B?OTY1alpmSUhkMEE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f801eaa-ea33-4a0a-8378-08dac8fbbb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 00:27:53.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eckt3fGAje3S090pzRNf7SHU1LzATlJWy1YyJNggvTxwoJqTx2sIB5gqCwY7GrJuzDMLktoKen55p3wl8JR9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
X-Proofpoint-GUID: 4ymHlXt3wZhvFhwNycvipwK4-c4Fznqu
X-Proofpoint-ORIG-GUID: 4ymHlXt3wZhvFhwNycvipwK4-c4Fznqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 mlxlogscore=438 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211180000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K01hbmlzaA0KDQpPbiBXZWQsIE5vdiAxNiwgMjAyMiwgTHVrYXMgQnVsd2FobiB3cm90ZToNCj4g
QSByZXF1ZXN0IHRvIE1hbmlzaCBOYXJhbmkgKHNlZSBMaW5rKSBhc2tlZCBmb3IgY2xhcmlmaWNh
dGlvbiBvZiB0aGUNCj4gcmVmZXJlbmNlIHRvIHRoZSBjb25maWcgQVJDSF9WRVJTQUwgaW4gdGhl
IHN1cHBvcnQgb2YgWGlsaW54IFNvQ3Mgd2l0aA0KPiBEZXNpZ25XYXJlIENvcmUgVVNCMyBJUC4N
Cj4gDQo+IEFzIHRoZXJlIGlzIG5vIHJlc3BvbnNlLCBjbGVhbiB1cCB0aGUgcmVmZXJlbmNlIHRv
IHRoZSBub24tZXhpc3RpbmcgY29uZmlnDQo+IHN5bWJvbC4gV2hpbGUgYXQgaXQsIGZvbGxvdyB1
cCBvbiBGZWxpcGUgQmFsYmkncyByZXF1ZXN0IHRvIGFkZCB0aGUNCj4gYWx0ZXJuYXRpdmUgQ09N
UElMRV9URVNUIGRlcGVuZGVuY3kuDQo+IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBS1hVWE13Z1dmWDgqT3ZZMGFDd1JO
dWtlbmN3SkVSQVp6VTdwNGVPTFhRMnp2NnJBZ0BtYWlsLmdtYWlsLmNvbS9fXztLdyEhQTRGMlI5
R19wZyFhS3M0ZFkwMmlfOGRkcUFwb0d2eEZsb3NjVEJReFdsa2hZVDhYQXlOa0pqUVdoVFFHYUQy
LTQxcWdvNEJlVVpWZEsxV2M0bHFTQy1ocDBtRWlCMXd5cWNFM19VNyQgDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3VzYi9kd2MzL0tjb25maWcgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9LY29uZmlnIGIvZHJpdmVycy91c2IvZHdjMy9LY29uZmlnDQo+IGluZGV4IDAz
ZWRlZGE4NmRhMS4uYjJmNzJiMGU3NWM2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9LY29uZmlnDQo+IEBAIC0xNTIsMTEg
KzE1MiwxMSBAQCBjb25maWcgVVNCX0RXQzNfSU1YOE1QDQo+ICANCj4gIGNvbmZpZyBVU0JfRFdD
M19YSUxJTlgNCj4gIAl0cmlzdGF0ZSAiWGlsaW54IFBsYXRmb3JtcyINCj4gLQlkZXBlbmRzIG9u
IChBUkNIX1pZTlFNUCB8fCBBUkNIX1ZFUlNBTCkgJiYgT0YNCj4gKwlkZXBlbmRzIG9uIChBUkNI
X1pZTlFNUCB8fCBDT01QSUxFX1RFU1QpICYmIE9GDQo+ICAJZGVmYXVsdCBVU0JfRFdDMw0KPiAg
CWhlbHANCj4gIAkgIFN1cHBvcnQgWGlsaW54IFNvQ3Mgd2l0aCBEZXNpZ25XYXJlIENvcmUgVVNC
MyBJUC4NCj4gLQkgIFRoaXMgZHJpdmVyIGhhbmRsZXMgYm90aCBaeW5xTVAgYW5kIFZlcnNhbCBT
b0Mgb3BlcmF0aW9ucy4NCj4gKwkgIFRoaXMgZHJpdmVyIGhhbmRsZXMgWnlucU1QIFNvQyBvcGVy
YXRpb25zLg0KPiAgCSAgU2F5ICdZJyBvciAnTScgaWYgeW91IGhhdmUgb25lIHN1Y2ggZGV2aWNl
Lg0KPiAgDQo+ICBjb25maWcgVVNCX0RXQzNfQU02Mg0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpB
Y2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwN
ClRoaW5o
