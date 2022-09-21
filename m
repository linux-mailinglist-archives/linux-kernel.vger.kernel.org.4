Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975F05BF369
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIUCSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIUCSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:18:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9E7C751;
        Tue, 20 Sep 2022 19:18:19 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KMJe7i012739;
        Tue, 20 Sep 2022 19:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=UaSgY7ZB4FMHuma3RG+8cQBa+s4tb/iddk6mYHcKXig=;
 b=Qhmbtt8m/JdENQQdlHDo4zcTaFOt0NGPoGQWSeJ9jvg21pqp8YMUein162YsYagB1dO/
 DKdf/SMqkGOWY66iqhylKT1QQuWdWv+n6o13pGlMBRBGRZOcqTEb4ezWQAqExf7YlchZ
 Ldhdz+S5/lq11CWa9J8VTCxBwaTMVuwtldTzxeLzcxWjzkb1q0ftT4wxiGlcPVVmzwJX
 9/yw2hNudjs4MKQXq98FYnErSS5oG4MP+S4EE5AuY7fZ+s1HsoVkGcyBc4uDja20dJgg
 TJn71yXBEzDWrR1hUGuX9Ei+Wzkj8Brbc9ypHvmA9BdEF6p18yiRM/BkAExNth+hlq1p 3g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3jndg4tbuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:18:07 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 04AB640083;
        Wed, 21 Sep 2022 02:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1663726687; bh=UaSgY7ZB4FMHuma3RG+8cQBa+s4tb/iddk6mYHcKXig=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FGW3xChTMlyzAqxPaJ1SdEqXz0neXmbpKa4eAmw26yK4xhCMFDT2a57ghsBWqdg6S
         SU/PkpIi+n1/0JRzkUo7/8M2UJloXfym9GaFy2th727AxULe5ChTCEmEkF7JoQdQO0
         2+fDBWgMyZZxseMyMB4Gbk5f3SywbzHfFu4c22lUXCpA5XMMVOx5qplJio6q6i9/oF
         WuWt1KFcq3SDAdXxR8J7FpmHLP66lUIW1vm1YYVZkugx0fqs9inxg9eyeh40ao7zWj
         k///mND5eZPhxi+44H5zmbhjZPOvtqwB/1VZBKmSzMvSzvtK73rLpdSHyBhrNW4Fx2
         gJFssBD8+gxwA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 380F6A005C;
        Wed, 21 Sep 2022 02:18:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 107D24006C;
        Wed, 21 Sep 2022 02:18:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Ntet6GhJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcENE8aZQYKy4/8u+ysHrxV+XH0EF8buHmFfHRo6kWL1aBiUwHYS+oSvyxAVFQRSRxKyUQKdWNC5XvNW6EzWZRqNckvgMDQsiitFj5EVrqf0TU66Ihcd1MyroOp9HbdOvjlbWU5fOnr6EEb+dJKeviJQLIkaFgXgM9pcrV4mqnFBq/r/X8uwxrq2z+ev+/N+mQndp4wXniY+mHGLEWUUGjF1Kk9NiEyHjhNxKFwGyQDlYObiPfMAVrpwSycnXSH7WuPl466rdJev/PoU77tzxBXCreL/j5i9YVAXXJuD/rz0ebAWd/9AjejR21WjukFh0nOxuyQffMc1sResTKro7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaSgY7ZB4FMHuma3RG+8cQBa+s4tb/iddk6mYHcKXig=;
 b=aZkQ3DCF5sEg524Tc+XgXi5QYbXuH78Oj1dtbV2ZOR3ZbRRneko/YCm1b/Xb+GAGoBObt5kbzHhRxbCyNVmsQzdCO493g1YP1+R/kHoj9woA8DPI2WkB/gRfjVIcvKIRQqlWy2m6tiKyVm1rTC5LUD2aA1BoiM1MojLWiAxnAPiYp0Qcx1ye3TIGSGkdG2WKA5as+DotP6lL7f/DtoKVhN90QPd7jRzy/bzLjyT/1ouAN5WLNf9AIOmZO0cnXN6PWXANaxYt0fOjpT2T8ua/f8ftj7m4A5lUTqHGlgpCN7V/rd/Tka9YXUSuxQ0j+DSheomu5k/PNuHx7fWy7h82/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaSgY7ZB4FMHuma3RG+8cQBa+s4tb/iddk6mYHcKXig=;
 b=Ntet6GhJ4iivjX8UVCBMRhbkW9VkjKZ2+vBgEBpk1DFjCLvoLXrpWox4/sCw3NdcfdcJYQ8y8URJN5b54fwCAaIja/nNDxIVmY4PxJpc4Iaz/5TZta0gscdYR5qLq4poR1jKOnyqLmPHwx/TOWjKM8eBYap9YvPYUij/1tRjiRE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Wed, 21 Sep
 2022 02:18:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::5f4f:d0f9:7f76:eda5]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::5f4f:d0f9:7f76:eda5%5]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 02:18:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Do not clear ep delayed stop flag
 during ep disable
Thread-Topic: [PATCH] usb: dwc3: gadget: Do not clear ep delayed stop flag
 during ep disable
Thread-Index: AQHYzH4BWgOkmcil6kSjXt/IMCtdEa3pJ7EA
Date:   Wed, 21 Sep 2022 02:18:02 +0000
Message-ID: <20220921021746.5v6suq6tc5ytudt4@synopsys.com>
References: <20220919231213.21364-1-quic_wcheng@quicinc.com>
In-Reply-To: <20220919231213.21364-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB7686:EE_
x-ms-office365-filtering-correlation-id: a39a4c8a-ab84-419e-9f54-08da9b7782d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Isbw390eoFTZvcNXii3ajxr183BMuLO6E9Ec/x8wpNjorhUCriVlPK91FcX97QZak/WljnvYdOEiNoG379rHS9CA7JVWfipehMkMhTtZsZGszO8Nr94r8c8CV8AqIvnR9fhDW20YTXERzFSJoI3+4TEE6zgJHLtNS+Gfhqm8NS2uzaAKE9tgAK6XQzdoBgkaoE0C0O3K7wKtcIradXQlaAgWFuQBYrKyxxG43y8HLGAQQ9NiEWc8fSC0V7R4k/hfpAABloFuC/n1ylFMLv/Ccx/KSuhmHlnYmKMKrefYMm+8fISMw2vfhE5Va8zTY/FMkxb2FIZiDVvJeDj8aa0tfYKDYTjGcLAbvjbVW6d21wVzDZh3Bg96sGy98NtFntGntwpbXUMtoSNkKZrR/ZgmPpOpbIfnboZe4W7M/fWdY5Plg20lv+aElxSmD+ufM7Dxtfj05o0QhkJfMEtWJqXD9ajQo71Txy1E9P3HVbMplaCkk4c3yPC35GADw3SYdDTaqUsx3szlTYC6zmLfogwCI5Y1RCGraiIw7I0kSn1EViWN7iDbDJS1t/6eZCpZnXzp1//C3trJgznIxi1bE7A+BtYAWmy4wq69OoAS5H4bJbrL9Sg37B0Ee8uG3436g5Tg9+YbEfPYwnTPVVw5DUv8nDTEk2Cr69U3jC6R63Zqcgvz594JYBA8bqQrYzsokw5Fn7b28aOY7ZsWpdlcx5OXLxBfs/3llLQZ1j4alGSuZ6PVvodBl82ppcfZkZCeVPqNMEEmAsfuxXZiNHn6FmaY/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(6506007)(71200400001)(6512007)(26005)(36756003)(38070700005)(54906003)(66446008)(64756008)(8676002)(66476007)(76116006)(6916009)(66556008)(4326008)(41300700001)(66946007)(86362001)(122000001)(38100700002)(83380400001)(2616005)(186003)(1076003)(6486002)(478600001)(316002)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjNsejNtdFBjMWIvVXJ5Zk10UGhQMGY2VmRoaUhHRCtOR3dHQ25Bb3l2aFNE?=
 =?utf-8?B?K0FSUFB4bHhJUDZURFVMcmdyQisrTVNwYlhLMFVyeWR6NkJLVmROT3lQcXh0?=
 =?utf-8?B?OFFhd1RFR0htVjdhalcxdTVuT0NhS0svOW5UZlNuSW43V3piY2piQkF1MmND?=
 =?utf-8?B?T29kTm12NldQM2UyOG9ydTJobG9zY2FoS3RDRSt1TllJQTB1VklzVnJaeGpv?=
 =?utf-8?B?ZmsraHI1SG54RWMreEw4QkdwUDRHTU1YYlN1amMvcjUxNGdOSWdlNG8vbXNZ?=
 =?utf-8?B?clRHdlVudy9vOWR0UkZ4eWczaFVzQzlySlp1aG5xMkpNZEROTGhaTTV5Um44?=
 =?utf-8?B?dG5EczRkbzBXZ3RPN2hqbWYvYXZhT3picjg0bk1mY0NabVRsMnlZRG1zSFF1?=
 =?utf-8?B?aDNzKzczYlZzZEFJVUtyRGRFbnlkSzhwbk9IOGthM0RqOTNiWUVwamtUVUdH?=
 =?utf-8?B?YWtSTkJvbnhQbDVFSVNhVnhnUDA1cVc4MjFZMzVzM2lieFd5WlBuZVQ2RDhp?=
 =?utf-8?B?ZklKT01OUWwyL2pHOXN1UFJFYS85MlFiczhieWxRVEpQaXlIdXJTV2hGQkxu?=
 =?utf-8?B?Q2J0Y0lSYVhDNHBJU2JvWlRoWjNYaEo5cGVScHRhSkxuaFczemNneFpGRDJ4?=
 =?utf-8?B?c3EweEx3Y1gxY0hiVG93TUYwVFNJaWE4dEQvRDdHc3RCbGVMbHpqWWhVM3NE?=
 =?utf-8?B?YURvaWUrRHNqcHpuWVNnNFRPaWNLSTJPcEhobHVLdVREa2RoU2dIWWpKbGpF?=
 =?utf-8?B?TkZ4Y3NsSy9mcmw1RTQ5dm9qd1lJaFlSNVE3cHkyR3hWeGpIK3p4azVXWHp1?=
 =?utf-8?B?THlHOVdDcHNmS2JNck4xWkhiVUU2UWsxN3d6QWE4Y0NuVG83NDAzL2wyS3FS?=
 =?utf-8?B?ZDRkK2dmZ200YytWaHhGR2lveEg1Mk94V0dwRUVIbE5BcXo1SmUzNm5VWFds?=
 =?utf-8?B?c3BnOHlDV3U0YklnTGVyMFNvbW5ra3cvOWNQTEVSM005dXVnaHgraCtZeWNV?=
 =?utf-8?B?THV0NHVBYzI1ZjVVa2JHVG5VZUtmODhwTUgySDZGdjZWMllqYk8xMTVDbWtT?=
 =?utf-8?B?amwzc0xOb3FjLzBONTE3aTNrYlBDSEVBNE82c1lrRmZHMExhYWtFYWZWMEhT?=
 =?utf-8?B?YVBtZ1N1b2xlVWxBbVpaZUQ4ZUlDa1cwMnZOalBrTFNoV0VQd3JTb2t0TW5M?=
 =?utf-8?B?WklvRUxPS2o2QXZSRWNOblJPeFdrUFRmUUZIT3o0bitPUjJGVjFpZVg4Ukp4?=
 =?utf-8?B?NXFUTHZpaWJ5VEZwZ3Q1ZCtQQmF2cmpWazZZbXgwUFZLUHZtc2hHWVkxaHUw?=
 =?utf-8?B?TFgyK2JtV2xITWE1S216azV0dzhUZGU3MFBLWmoweS9jS0hTTHhLeWRBdW5l?=
 =?utf-8?B?Y280cU0yVWtVUEpScnZYNzJBdzZPd2prYVI1Nllha0hiOWNpZDk1ZklyVzEw?=
 =?utf-8?B?dURWWTI4ZDJKa2xoUkovcVMxM0FsUWJwY3p1Mm42L2JZbG9rUGljYWdNdmZM?=
 =?utf-8?B?cE5lbDlQc0lPSWtMMWIxeUhKZTlnbFV3ZThTZkZ5K1Rkc3FaMlorRytuZmxS?=
 =?utf-8?B?ZVhpM3Vmc28xWjBnYjNNZG9CWG8wVnJZNjdTaSsrenN1UjRYL2ZHazZ3WFlM?=
 =?utf-8?B?OFhSK1FPWTladzlhL1JlY0hST0pFWWdVaEdZb2Q3Y2NiVFgvc05Lc1BueHFY?=
 =?utf-8?B?bkxvV0hlSGpUSkw3ZXBrVDZJYTR5YnpNcVBBVkxBL1M4MkxrbytCRGVhdnh3?=
 =?utf-8?B?TWQ0UTN0OXBEQlJhWTdIelNlSVZTLzIwejhKbWFIQkZlUkVWVTRRNHB4SUIz?=
 =?utf-8?B?bkpObURGN0VtRTBUTFhhT0R2V2lXcGJ0RGVBQ2FaaW1DcFVPdmcvRm8zeUpy?=
 =?utf-8?B?MTFVcmlpVnQ4dHBJWk5RUlBNTGsyMXR0ZTQwem9FamFPdThYdmMrWWtFUjNv?=
 =?utf-8?B?emFQcDF4MEF6MFRyN2JMRHpVVEhsOW1XN04vck1PeGtVakIxeFg2d1FQeXg2?=
 =?utf-8?B?ZVhsRDNVZFR1aHZQeUxJVnJxSm85ZE1JNDRrR0tBcHVyNEhIZG45ZUplSkQy?=
 =?utf-8?B?a3liQnlLdG1jNWNHRDZDZ2Q1SnJIVmdnNERtM2pxaC9mSm01WnFwTWRNdUdS?=
 =?utf-8?Q?uUMv9YYJYzfowPuCtzzmi64uA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CECB91D4007204280218A5BFEF77467@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39a4c8a-ab84-419e-9f54-08da9b7782d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 02:18:02.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joybfIeUJn1kSGSYo2vk/TxJpGeNx7a6GNfsy4kYjv+ivIZxIU4VBEBJJk9/Krtj+ka5NH7n00rYHxuOEcxylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Proofpoint-GUID: hRTjKMryrs3uthVZ_26fQpgoI3-FnVBs
X-Proofpoint-ORIG-GUID: hRTjKMryrs3uthVZ_26fQpgoI3-FnVBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_12,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209210013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMTksIDIwMjIsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gRFdDM19FUF9ERUxB
WUVEX1NUT1AgaXMgdXRpbGl6ZWQgdG8gZGVmZXIgaXNzdWluZyB0aGUgZW5kIHRyYW5zZmVyIGNv
bW1hbmQNCj4gdW50aWwgdGhlIHN1YnNlcXVlbnQgU0VUVVAgc3RhZ2UsIGluIG9yZGVyIHRvIGF2
b2lkIGVuZCB0cmFuc2ZlciB0aW1lb3V0cy4NCj4gRHVyaW5nIGNhYmxlIGRpc2Nvbm5lY3Qgc2Nl
bmFyaW9zLCBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoKSBpcw0KPiByZXNwb25zaWJsZSBmb3Ig
ZW5zdXJpbmcgZW5kcG9pbnRzIGhhdmUgbm8gYWN0aXZlIHRyYW5zZmVycyBwZW5kaW5nLiAgU2lu
Y2UNCj4gZHdjM19yZW1vdmVfcmVxdWVzdCgpIGNhbiBub3cgZXhpdCBlYXJseSBpZiB0aGUgRVAg
ZGVsYXllZCBzdG9wIGlzIHNldCwNCj4gYXZvaWQgY2xlYXJpbmcgYWxsIERFUCBmbGFncywgb3Ro
ZXJ3aXNlIHRoZSB0cmFuc2l0aW9uIGJhY2sgaW50byB0aGUgU0VUVVANCj4gc3RhZ2Ugd29uJ3Qg
aXNzdWUgYW4gZW5keGZlciBjb21tYW5kLg0KPiANCj4gRml4ZXM6IDJiMmRhNjU3NGU3NyAoInVz
YjogZHdjMzogQXZvaWQgdW5tYXBwaW5nIFVTQiByZXF1ZXN0cyBpZiBlbmR4ZmVyIGlzIG5vdCBj
b21wbGV0ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVp
Y2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDExICsrKysr
KysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGI3NWUxYjhiM2YwNS4uM2UyYmFmMjI4MjRiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTEwMTEsNiArMTAxMSw3IEBAIHN0YXRpYyBpbnQgX19k
d2MzX2dhZGdldF9lcF9kaXNhYmxlKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICB7DQo+ICAJc3Ry
dWN0IGR3YzMJCSpkd2MgPSBkZXAtPmR3YzsNCj4gIAl1MzIJCQlyZWc7DQo+ICsJdTMyCQkJbWFz
azsNCj4gIA0KPiAgCXRyYWNlX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoZGVwKTsNCj4gIA0KPiBA
QCAtMTAzMiw3ICsxMDMzLDE1IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9kaXNhYmxl
KHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICANCj4gIAlkZXAtPnN0cmVhbV9jYXBhYmxlID0gZmFs
c2U7DQo+ICAJZGVwLT50eXBlID0gMDsNCj4gLQlkZXAtPmZsYWdzICY9IERXQzNfRVBfVFhGSUZP
X1JFU0laRUQ7DQo+ICsJbWFzayA9IERXQzNfRVBfVFhGSUZPX1JFU0laRUQ7DQo+ICsJLyoNCj4g
KwkgKiBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpIGNhbiBleGl0IGVhcmx5IGlmIERXQzMgRVAgZGVs
YXllZCBzdG9wIGlzDQo+ICsJICogc2V0LiAgRG8gbm90IGNsZWFyIERFUCBmbGFncywgc28gdGhh
dCB0aGUgZW5kIHRyYW5zZmVyIGNvbW1hbmQgd2lsbA0KPiArCSAqIGJlIHJlYXR0ZW1wdGVkIGR1
cmluZyB0aGUgbmV4dCBTRVRVUCBzdGFnZS4NCj4gKwkgKi8NCj4gKwlpZiAoZGVwLT5mbGFncyAm
IERXQzNfRVBfREVMQVlfU1RPUCkNCj4gKwkJbWFzayB8PSAoRFdDM19FUF9ERUxBWV9TVE9QIHwg
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gKwlkZXAtPmZsYWdzICY9IG1hc2s7DQo+ICAN
Cj4gIAlyZXR1cm4gMDsNCj4gIH0NCg0KVGhlIGNvbmRpdGlvbnMgYXJlIHN0YXJ0aW5nIHRvIGdl
dCBjb21wbGljYXRlZC4uLiBJdCB3b3VsZCBiZSBuaWNlIGlmIHdlDQpjYW4gY2xlYXIgYWxsIHRo
ZSBmbGFncyBhZnRlciB0aGUgdHJhbnNmZXIgaGFkIGVuZGVkLiBJZiB0aGUgZ2FkZ2V0DQpkcml2
ZXIgbWlzYmVoYXZlcyBhbmQgZGVjaWRlcyB0byBxdWV1ZSBhIG5ldyByZXF1ZXN0IGFmdGVyIGl0
IGhhZA0KZGlzYWJsZWQgdGhlIGVuZHBvaW50IGJ1dCBiZWZvcmUgdGhlIGVuZCB0cmFuc2ZlciBj
b21tYW5kIGNvbXBsZXRlcywNCnRoZW4gRFdDM19FUF9ERUxBWV9TVEFSVCBtYXkgZ2V0IHNldC4g
VGhlbiB0aGluZ3MgY2FuIGdvIHdyb25nPw0KDQpSZWdhcmRsZXNzLCBJIHRoaW5rIHRoaXMgc2hv
dWxkIGJlIGZpbmUuDQoNClJldmlld2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBz
eW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
