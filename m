Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9B662F56
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjAISiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjAISie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:38:34 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A9625B;
        Mon,  9 Jan 2023 10:36:13 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309IVjXp013566;
        Mon, 9 Jan 2023 10:35:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ukbhl3zHvi2SDqkVX5GbIid3rI7ADT7qFBucmh5hmFc=;
 b=KMDBTVLLxqeVLF4yHfK0KF8UFSzs9nRRBC+4poRq7GIqnF/uh930upW/yUuvUklZxV+t
 oKidN3aMUz+qMzo7FBdgBojYiDBaAWOqZs4smA7AMuCUO2iQbPqGzSBeUd0IrgEHEAeu
 imni9oczhrm16vTQ0zAeAwMQP3x2kAY9SqAnxb6SNeF5AMC7Qg0FrMRSz7Kbp7WzI6fI
 gUMj8WqNp0Kq7RN2wmryGZYG6sQ8Qd20ibaHpUDGXLG4LuLAGJ2QRlAusx4YwNDa3e83
 4760lghbaXZc8Y+S+UKy0pGOVCY+vltMvST8Pirj9K4Fz874n0Xp+frZ07LZZ+ujqL+9 AA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3my8mtde40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 10:35:54 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 24E3DC00F3;
        Mon,  9 Jan 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673289354; bh=ukbhl3zHvi2SDqkVX5GbIid3rI7ADT7qFBucmh5hmFc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=f2u5OI7rJt/ZCQiS2hoC6cgj6LQ8wKaKvhU3WyvVQQsP2qsg5YhBFPyYylLumDrWT
         s7E+xcqT1zXLpuuaI0Hd/XhLH6WP3HPUVmxVbfDjvVK8dhPJJ1zzMo3j/poIbXe6WK
         EVVw/4Zhj4Eabs6t3GGLN9McCdiFea/CvLuwfgH++DW3EcV4c6ae0nqT4VmuJjQ0LO
         a87P/5UaimZICol407+Ew3MiaaO5/AMGYuKeh5156lAytzdJ7Xtn2O4UnUBJ9eDDqi
         B5nXwKnEFR4wO+lDb5uxlaJPuEbLRH0WMOGIi0xQEfwjwY5OwDW0JsGm7GCxq+TZEP
         MiPNsfVWJmWqg==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9156EA0081;
        Mon,  9 Jan 2023 18:35:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2494480169;
        Mon,  9 Jan 2023 18:35:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AFdpc8ID";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El4n1LK8QKjTqwXd1FSk/r2Ofn7c7l3DqsLDwbQZTMLE86D7Fjb+GqEZ+BWVnDKZHcPq+wK+HkXSWGETD/L0g6j/gC/qRjuRdEEk/M6k7yZWgtqW4UPD7qGkMD2pjTwpI4nYdGTKejkdLzVUlPvGiIWWOmFNlbO7H7W11Ql/oWBwpNUmqzW4NktkHLsvZH7LONHeqewlt22gdjrQje5r5DRf7/ijGFv1OsxgG5yuDUoUKGe8n2vrZADyqnyFccWeeTP7bKeFALeYRHdN53H17KxE/Sz5xkWU2S35/+Qsh634xdLKTL6xNDe920MObfYbVPgleTQag9G5ANcfAfx9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukbhl3zHvi2SDqkVX5GbIid3rI7ADT7qFBucmh5hmFc=;
 b=Bkj+jK4fvCGgYF7oLnr8DTHRmCnoEZ7G56WMiD2Rcb+IiUNspKS/Oq4aAnXBeNAdo2ESdxa9nxcFnorbGC4LwC7wPSQBMaJBeNI/IyupS2nDY77JFgCntnYQUPkhIAJInsyIW+Sz0OA6vvoc88AZI7Bu6lX7cTzyHtoWdmj1VRjRFbIJGEU0004KdIRTph6grnC/xWmZ9XfWEUIisngeqiUImloDREDsGXwwu8wdLaJ/OysU8s/E7PQYo1ijnkToP+cOn1pUo4EPGdIEf73UY/Udww32+iWM5c8PA1cHvo+XlH3SP0LUwvhfPh6nO6pLHVPPnsA1y7QQqH3FWcTHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukbhl3zHvi2SDqkVX5GbIid3rI7ADT7qFBucmh5hmFc=;
 b=AFdpc8ID2Zd3uzdegBOB/TzjhbctrWWAapIEBX4inxV1fmlhi+UC8H0WcxFtpGWKNhU5jVWHlz1iLcaatACcTcPcECJoVQRbUSntJD/+Eq9Jl8cuOsYb+3d1u6z2+ZBxpxFj4190h1KxAVCm5a7MqsOyftQ96VaiPPQVmGatEXE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:35:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 18:35:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     JaeHun Jung <jh0801.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6WdY2A
Date:   Mon, 9 Jan 2023 18:35:48 +0000
Message-ID: <20230109183545.kqej7vmtf5o6ihq4@synopsys.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
In-Reply-To: <20230102050831.105499-1-jh0801.jung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB5853:EE_
x-ms-office365-filtering-correlation-id: 1b0891e9-863b-4d25-2610-08daf2705419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Uqra2sl2lT3f365NuW40xWhtgOvt+dZ+W594As2ZaZc+9nMpMDj9gmIZq8FKE39XdTan9Dm9SfVrR3FFyU85QoXluhNbdBiB80BngpvHPIz5EDWIpA+pvkKVeZLPvy/L0se5y+lm08vVcPUxyYuY0NfCryZ29tCdwGIw7jLQD4pS3oJjqWksAHmHBw68lza2GzDQVp1VRjhesKUfbCcN/+q36mRCfZVBGBWyYFip78j1ZKhH72sDBcKXRKLfEGuLJiFezzc/68Hncjlh8Fowo1ekY26zmuRRPxfUuCzAcMPwzAkProlVJpFLgvY0jUlhL8moCqcMsPCAA1eMCCvcIGvru58zL6kVhWsPS8y5cZnAJXnU3WgSwBBRyafxlNfChssR2yDtRrec6QIeU8FheNHzmmjY0atslk7ZP1Q1okD19QV2XhqpEmKyz0ZKFQEkniMG8LDUf2l74slX7j7Mo2sIHf7BLcnoBrq45UIzDr+eRBxQ84g1OuNkVOZ3PlIzc0kXht6abiDwuLUDX8Hm6iFJtvzSTikO/Uc+TQmHeuWxEnyCuOFj1p5C/Sq1CUGyXnse1vz0DvdoQeN3U+CTlk5vAaj10A/yaSdHjpaZM8BZ82J006G8CMIg+8r3OUc9//P7rxbQ/uo3BWxC+9d47Qan0YtouFFZYvy6HC6JBZFn2o5UAnwkTkwGl/A3lBq3gZcxk4jKv0SYwUIPq6FcUMo8tEUaL0UZagkh5sqj3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(83380400001)(122000001)(2906002)(41300700001)(8936002)(5660300002)(186003)(38100700002)(6506007)(478600001)(1076003)(2616005)(6512007)(66446008)(26005)(6486002)(966005)(66476007)(4326008)(8676002)(64756008)(316002)(6916009)(71200400001)(54906003)(66946007)(86362001)(38070700005)(66556008)(76116006)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkpxc3dzQ0l0WnAwUGdmei80d3pUZXhLOXpvOTM3NVNpTXdmbDVKenhPV2Ez?=
 =?utf-8?B?bjBBQkk4eWQ1K0xrTUJiWGt1OUc5VEJLemdiTitEenRzOG1IWnYxOTY0cnI4?=
 =?utf-8?B?VFBwSHM3QVJkelNHZ29kQTRSOUE2NkZibkJrRU9lL2R0NFFBbGlsRk53aVkx?=
 =?utf-8?B?YTExNTQ0eWZhUjVDelpUS3pDTDZ3MGkxUGtPQTAwdElzbjVOTFpxcUlmQ0h1?=
 =?utf-8?B?bGxJODRqV3oxT3B6OStxZmFERmhwQXRXRFdCN1ZQakxkSDRab1J2QzRONWRw?=
 =?utf-8?B?VmsxdCtJdDVhdGFiVUVVeENxUG5obmpCL0NiNkJMdERMaXI5Z3MrVk1iZ21y?=
 =?utf-8?B?b1ByQkpxWnVzVjRpc0xHMnE3OWlFMmZ1b2RUa1pLN3ZPRlFFOVArR090ZkQ1?=
 =?utf-8?B?MmlmUGx5NytMRmJNRmMwZC9Gd0daRERidjJaMWhPR0wzOHBuU0ZtVUdGVGdI?=
 =?utf-8?B?TU1EanNKOWh2NDNZTTN6MS9HWXBmdlFCNmhRdm9vZFZ4aGdVM2pMNTRkVlA3?=
 =?utf-8?B?bnNjZUcwUnFxdjdaMnptdXliVkx0c2lSZXBLcVVHQ3k1TXBBYmJuVXV0YzNy?=
 =?utf-8?B?dnREZXJOLy94amtGKzhxWTdIRCtkaGR5ZjVUQysyR0pzUjEreVRFOVN1MDNj?=
 =?utf-8?B?dVkvSEE3aUc5R3Z4aEZBcTFWVENBT09GUHM3QXFJSmU0d1J6WnIzVWRjaE5q?=
 =?utf-8?B?WllJWFJKc3hBOFFCVGdvcWFOaDdIN0JHUkhuSklJZjBGd1J6VkNyaWtZYlBo?=
 =?utf-8?B?MTd3dmxUT0hWeHBRTXRsTnZpWWUzdFVBMnB2REJxWkoxN2dQQVZCQzU0SCtF?=
 =?utf-8?B?YXRFcmRVenR3bFprRklpdmIyNUUzSER2amR1eXRwUGQ4bzI5NXNaSmg3ZUpS?=
 =?utf-8?B?WUxKTmppMXVGS1lXd0FpQzdSbW5VZFM4Tk14Mi9HZ2JnSUs0Z2JFamNkV0JG?=
 =?utf-8?B?TWdLeGZXTHRTRlpKQUpPQVFaSWNBZXdST2luQnBKM3VkVEE0dGpCM1N3dlhx?=
 =?utf-8?B?Y3pHUU1Fb21iUXpHVnNxbzY3SGtoeWJ5MlpxZmZuV0RMam1tbk1mcUdWanRB?=
 =?utf-8?B?K25ONzRONTlaOWRQV21ENWpsM2pmZm92Y1lzbE1KaWh1eER1Yi9kTHVaQVhR?=
 =?utf-8?B?ZFF1dmV1RDlNS004Rk5lU1FiUGJ6Uk1mWFFhamRPYWQyRWVSL1ZDNlkxV2k2?=
 =?utf-8?B?ci9qbys2Zzl3OUNaNVFacDY3QWhFbEpaQk5ha1dNN3pUd0Vaa2VBbElBVmZq?=
 =?utf-8?B?VU1uWVFxZldLRG9HYmtBSHAyN0Q3UDI5Wm9kaW1IUXR0Ymx3OHphMFNQNm4v?=
 =?utf-8?B?OStnWmhHRXFnUmpSZ2lucUVZMnMrbG5ON0NWQS8rdzgyRkVoemQzdUtEMjZr?=
 =?utf-8?B?K25BTDA4djAvUHZVQktVSWJEZzhyNWRveG9aL0ZIa2pSbWxBRW5DZjhseTdj?=
 =?utf-8?B?UGFmU0JmdGpxbFpIb2lXRHlmMDZSc2Q0Q2hlNEtObzhPZ2NKdGg2V1VuVS9Y?=
 =?utf-8?B?dDJ2T0pWcXo0K0xXd3dhakwwc3RZdjlBbldaa0hLWEdWKzRUcDZtbDZyT2U2?=
 =?utf-8?B?TUgvclpiNnRJOUJMZlFHb1YvSzFNVzY3ZHdTaHVNeXhzRlF4eTJLSW56bnk1?=
 =?utf-8?B?MFYwRWpXMmE1Nzhib3FTM2dvYWtodkF4L2NjWUdLMXZoczhNTHZoaVo2MnMv?=
 =?utf-8?B?WWlNakE2NXBEWlJ0aTFBQ0hCVzNldWJzeVNyUE5UemFzdGw0MHdIQzNoa0dx?=
 =?utf-8?B?Y1UwVmswdUxqMGp6SEhMYW9hNWJ2Nmt0UWNRTklWa3J5Q3BBQTNYdElpSzZa?=
 =?utf-8?B?Y3JSc2RNS3RNKzJ1Sk5tK0lYSVVaRUpYNU5vdytiaHArbWxsZnJNQ004b1Jy?=
 =?utf-8?B?SWliYUtiOHJqQUhhTFRhRkxCZ1BrL2hSSTc2SEJ6VjV3SVlJUUhJSFNkOVlY?=
 =?utf-8?B?UFVINmZNdkxVb3k2TUdkcWRPcTIwTEFEd2FUK291UVhzT3F2cVBPUGVoelZE?=
 =?utf-8?B?SjhleVpPMGZsc0YwSHFEblNvYS96YmFWbitOMlViQjlDaVIrVEd5aE85WVBG?=
 =?utf-8?B?cHU5UzlvR1RpZ3RaSlczU2x4THVzZW40azNnazZ6ZXErZmV5QVVXc3ZTYi9o?=
 =?utf-8?B?ZTVzYzk3VUIyR2RQVE1SS2k3OGJlRGVFQ09NM1dmOGJZQVN5V0hFcyttODR6?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B15D5A54BE46B4CBDC1B158C08F8385@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I4CXKTcs4NwUQ/rCquBXcBLYDQupyqQj5UWcn8vx9ZnRfieCbJxPic0lVi+4ORbaIfQdIzw1q2aiL1QMD0LIRGzjRy5bDwgdUfXOaK9nZzQUaJ5s5J8VGw3eGJQhR4FYb67dNmMTcsDJMFcrjOrD6iAptK9ODmTp1nqszOZIGvVTSK/yuBHwSeffw8jWdRqf0K9FOzmsg8dg39x/5mxBKDHXCN2hC8EuwZdNqZnehplZWfS4bLQtGYgXTqhE8dUKQjTAYrpG+9SOcYVqDkQfsKkGXhbZXrDOpFw4VadxtKifmG6OOHNI59F6fagzEEBZEMb1XyYmVZ3Uz4rtSh4XGZPMrgFjswlulEeU2yUElKSeeV39jbUUnNs2ptwHLJkS6DZGB0QeaJw/TFB8BPwJT30frjXj2CqDEmyXlBo+JuBcRQNMwwK5PPqtS13Yl3KBDlidmCvG11ckNmWBnH2Oxv7HMUCTHA8h9IKKtw4oyBos6lZFLKrD1SFZS6yB0tOM2QF8s9CfMe7wR+eo+j4/BvXKE+ZNFvyqs4/m4/C/1JzWCq7CLkEgyXZ3XWorOOWG1OMSjqnPs7/MfgRQaxQJFq+yui+Z5/syhUTSoT8nuJW1Hfzjwk36tkrh1sFXlVhnxQmplGvpsUfBJi+A4Hcv0IdASx8EqMxRzwuYgoyNMHNpMu5a71MnnXDdNyVuEYHY/dH9diewheQeVX6a+lmZ30rmiDgk47bRF1qjTcCBQl+fsbZqYOsDdBwLCgBBftKG252p1UkzGGClYqy6FPk5h0bUei8hoMymTgOLLolJo50BqbDZWpV4H62gSqRtP8+golF314EvRkjnuNtDMWNDNmkdhCnoBRmafE0nCIWfdugtPOUrwEpymdw6xQ4mWUCAJChelmQZS4eFqCqIb5fR834hczD4aVQXovldcX9fMe4=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0891e9-863b-4d25-2610-08daf2705419
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 18:35:48.6758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 013qbZCp78Ez28ca7F4Vc6NlDgGC901knYK5ab1SEH7chAShNOlgH25Q6plWYbpCGp92+kZhYVOgTZFGeVSK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
X-Proofpoint-GUID: PU5oq_S_w2q6gkPQPcdqEV5pcOomi-ak
X-Proofpoint-ORIG-GUID: PU5oq_S_w2q6gkPQPcdqEV5pcOomi-ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=790
 bulkscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgSmFuIDAyLCAyMDIzLCBKYWVIdW4gSnVuZyB3cm90ZToNCj4gU29tZXRp
bWVzIHZlcnkgcmFyZWx5LCBUaGUgY291bnQgaXMgMCBhbmQgdGhlIERXQzMgZmxhZyBpcyBzZXQg
aGFzIHN0YXR1cy4NCj4gSXQgbXVzdCBub3QgaGF2ZSB0aGVzZSBzdGF0dXMuIEJlY2F1c2UsIEl0
IGNhbiBtYWtlIGhhcHBlbiBpbnRlcnJ1cHQgc3Rvcm1pbmcNCj4gc3RhdHVzLg0KPiBTbywgSXQg
aGF2ZSB0byBjbGVhbiB1cCBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZ3Mgc2V0IHdoZW4gY291bnQg
aXMgMC4NCj4gSXQgbWVhbnMgIlRoZXJlIGFyZSBubyBpbnRlcnJ1cHRzIHRvIGhhbmRsZS4iLg0K
DQpDYW4geW91IHJld29yZCB0byBpbmNsdWRlIHRoZSBleHBsYW5hdGlvbiBmcm9tIG15IHJlc3Bv
bnNlIFsqXSBhbmQgYWRkIGENCmZpeGVzIHRhZyB0byA3NDQxYjI3MzM4OGIgKCJ1c2I6IGR3YzM6
IGdhZGdldDogRml4IGV2ZW50IHBlbmRpbmcgY2hlY2siKQ0KDQpUaGFua3MsDQpUaGluaA0KDQpb
Kl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjMwMTA5MTgyODEzLnNsZTVo
MzR3ZGdnbG5scGhAc3lub3BzeXMuY29tL1QvI21kMzJkZWVhN2U2YjNjNmQzMDlhYWRiYTNkMWNk
MjgwMGQxNzM2ODVlDQoNCg0KPiANCj4gKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqKSBldl9i
dWYgPSAweEZGRkZGRjg4M0RCRjExODAgKA0KPiAJKHZvaWQgKikgYnVmID0gMHhGRkZGRkZDMDBE
QkREMDAwID0gZW5kKzB4MzM3RDAwMCwNCj4gCSh2b2lkICopIGNhY2hlID0gMHhGRkZGRkY4ODM5
RjU0MDgwLA0KPiAJKHVuc2lnbmVkIGludCkgbGVuZ3RoID0gMHgxMDAwLA0KPiAJKHVuc2lnbmVk
IGludCkgbHBvcyA9IDB4MCwNCj4gCSh1bnNpZ25lZCBpbnQpIGNvdW50ID0gMHgwLA0KPiAJKHVu
c2lnbmVkIGludCkgZmxhZ3MgPSAweDAwMDAwMDAxLA0KPiAJKGRtYV9hZGRyX3QpIGRtYSA9IDB4
MDAwMDAwMDhCRDdENzAwMCwNCj4gCShzdHJ1Y3QgZHdjMyAqKSBkd2MgPSAweEZGRkZGRjg4MzlD
QkM4ODAsDQo+IAkodTY0KSBhbmRyb2lkX2thYmlfcmVzZXJ2ZWQxID0gMHgwKSwNCj4gDQo+ICh0
aW1lID0gNDc1NTc2Mjg5MzA5OTksIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0
ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzEyNjgsIGlycSA9IDE2NSwg
Zm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1
NTc2Mjg5MzIzODMsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAs
IGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzI2NTIsIGlycSA9IDE2NSwgZm4gPSBkd2Mz
X2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzM3
NjgsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSks
DQo+ICh0aW1lID0gNDc1NTc2Mjg5MzQwMzcsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVw
dCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzUxNTIsIGlycSA9
IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1l
ID0gNDc1NTc2Mjg5MzU0NjAsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5j
eSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzY1NzUsIGlycSA9IDE2NSwgZm4g
PSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2
Mjg5MzY4NDUsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVu
ID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5Mzc5NjAsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2lu
dGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5MzgyMjks
IGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+
ICh0aW1lID0gNDc1NTc2Mjg5MzkzNDUsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwg
bGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5Mzk2NTIsIGlycSA9IDE2
NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0g
NDc1NTc2Mjg5NDA3NjgsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9
IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDEwMzcsIGlycSA9IDE2NSwgZm4gPSBk
d2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5
NDIxNTIsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0g
MSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDI0MjIsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVy
cnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDM1MzcsIGly
cSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0
aW1lID0gNDc1NTc2Mjg5NDM4MDYsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0
ZW5jeSA9IDAsIGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDQ5MjIsIGlycSA9IDE2NSwg
Zm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1
NTc2Mjg5NDUyMjksIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAs
IGVuID0gMyksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDYzNDUsIGlycSA9IDE2NSwgZm4gPSBkd2Mz
X2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDY2
MTQsIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyks
DQo+ICh0aW1lID0gNDc1NTc2Mjg5NDc3MjksIGlycSA9IDE2NSwgZm4gPSBkd2MzX2ludGVycnVw
dCwgbGF0ZW5jeSA9IDAsIGVuID0gMSksDQo+ICh0aW1lID0gNDc1NTc2Mjg5NDc5OTksIGlycSA9
IDE2NSwgZm4gPSBkd2MzX2ludGVycnVwdCwgbGF0ZW5jeSA9IDAsIGVuID0gMyksDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKYWVIdW4gSnVuZyA8amgwODAxLmp1bmdAc2Ftc3VuZy5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBp
bmRleCA3ODk5NzY1NjdmOWYuLjVkMmQ1YTliOTkxNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBA
IC00MzU1LDggKzQzNTUsMTEgQEAgc3RhdGljIGlycXJldHVybl90IGR3YzNfY2hlY2tfZXZlbnRf
YnVmKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqZXZ0KQ0KPiAgCSAqIGlycSBldmVudCBoYW5k
bGVyIGNvbXBsZXRlcyBiZWZvcmUgY2FjaGluZyBuZXcgZXZlbnQgdG8gcHJldmVudA0KPiAgCSAq
IGxvc2luZyBldmVudHMuDQo+ICAJICovDQo+IC0JaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5U
X1BFTkRJTkcpDQo+ICsJaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpIHsNCj4g
KwkJaWYgKCFldnQtPmNvdW50KQ0KPiArCQkJZXZ0LT5mbGFncyAmPSB+RFdDM19FVkVOVF9QRU5E
SU5HOw0KPiAgCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICsJfQ0KPiAgDQo+ICAJY291bnQgPSBk
d2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDApKTsNCj4gIAljb3VudCAmPSBE
V0MzX0dFVk5UQ09VTlRfTUFTSzsNCj4gLS0gDQo+IDIuMzEuMQ0KPiA=
