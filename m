Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B3614569
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKAIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKAIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:03:14 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 01:03:10 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F56590
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667289790; x=1698825790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/JlKsGHwBHY2VzRBIT16IdYQ2Gsnwp1XhxDR/ZuBQrY=;
  b=j8ThasVa/AQTdBR0tvrxFffDzte8fCk/NzeHSKd/Vj3yefqlFNid1O9b
   C0AJUcY+JKwUgS5g2GHwad/F9tL138CSOhQPILJBocrtUfSFJLf4pkEMH
   2enE+AzZzsGs3w+wpSQ3PIsjFAy1F50nDK3Mka2/KAkHRdaIghjo3LEfq
   Ck9DGDLPZrdP7wurm3qjQlp5ABNOgoDJN8tkjCDeVOdG3FENk1N8MkTfO
   h0Nq8KiNNC+IhounzfAV9Bfn1yl+z7BTKa7k0MTIeY8TFGM4ng8LPdX6L
   hnJhKVD71G+wud/9RIB7ZHsfJrEmGXbX2gA0GxbJem3NBflZHkfeYwn9A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="77103389"
X-IronPort-AV: E=Sophos;i="5.95,230,1661785200"; 
   d="scan'208";a="77103389"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 17:02:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNoHkR9AX/B3zwFqm+VJNMj3wGoPCkfU1lFuBN/LcJD2pnY6nQw9JwIgfAwfoAbb8znzcNViaswoKemD+ctX1+2D3euZ9lIpeSH8ty2Q3qfBIIFPCkzP9f1728sDYBaE80i8fYu87IXiLvWTV4sO/d99bbRZMMZWLuoAcrkAX+2bt6Xb9nfo1FUgQaLKerC133bEWirB7pROE7bdzCWcegPQ2Z+mdjQlu0ApopkpMo3HzG7US6b0bfb8HwlQObVWHhfM10h75PWFMan5Cj0Y/QFhLdZzFYqps0egZsGY8dGXqb0HtHlt7jHjG+0EtBrm8caqVhRx5kAyfJQYTECJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JlKsGHwBHY2VzRBIT16IdYQ2Gsnwp1XhxDR/ZuBQrY=;
 b=OM2qvthl2ZG3JZtYGGQZXWEYrfolExGUTgZddZHeAhQV0xkZJv2RCKHMfyzv6a/it9AyA8l1fkwjF1DyoAtLLwXIfg9X3JqhndShvWEY99sMpH5QbNHira4xRtR4/VExeaT9vP3a0QuS7iNWWILnFLtIWgKyVrZIUHLxuyzTUA+ylBeArA5Ywcp8/vfXKEWgMGjoz4hwwpINFFjpOOVuAZGhIQz6pgeRVQ5xJA+4H9invfwMl0VPVVgbJcZgd5ftO9PGjuC2fNq2+LiNwd7WRwWR5D+YcmNSZU3AZgiFIDkRcscU2DE6CGeuUNxJmXRET40YNlKjFCWhvicNF7WHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB8268.jpnprd01.prod.outlook.com (2603:1096:400:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 08:01:57 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%8]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 08:01:57 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH 00/18] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH 00/18] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHY5U7EVas4qDwHfkCIXZHUEX1dDK4pwPWA
Date:   Tue, 1 Nov 2022 08:01:57 +0000
Message-ID: <TYAPR01MB63300BD8AD0F65961314BD208B369@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-01T07:44:35Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=01136d72-ac37-4978-bcb4-916bea9b89b2;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: efe543034b1149aabd6fc66d98338a33
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB8268:EE_
x-ms-office365-filtering-correlation-id: 57c83185-3f97-4659-e1ce-08dabbdf593e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbYqJQQiGEiFcA31LuOUKM58lIHsR0sk8EjXFSoDYDo+6yuoOaCHavDOpP1v56vvlBHrnirBetduV9rTqny/jYC/S0nN5R2Lm62PIEBZGaIE++Pd0RTGJzDe7/LANvhY5SbrKhj7QPPdU92HzQR6tZ3O3AvdWwWTuyqOXZOguFYPyN/6pgj6YLJupAdTCKhcaVB86Q4f0OcKqOGD9PX3TJRPGHGH5hxbcVnrHCJoiQphM7OqTTWUgJmlHGMEO09unbrMDoYzyCODqpio2Ax9dkwAETn+BgykhwzdeQFgc1D8ni1U0gGQc/N9XmB/SPSJ6u5f/+DvaCrllCDM4ACqjRTvfLRRugqwfM4mtJBkniWQTEu3zBtAwVlebdP0LQrR1angeivTqtXppF9xOklNowILvU2FEOn6cAIIESBlNofcMWeYUPqg3FXjBvbukI6OMUKsBsKGqzV20rywofA4vpzf3YH1ITE56riYSyf/9W6+AQwSANooYw6hptZ+FW+QU1pUoqaSOuJ0o/hau7iBEXYUVgEeNkBH+jhNCLTvZfLaf+boKkR67AbwZ/mLppU9YnUl5sKLwL6jwCBKBr/88txrFvGJKvOSIQDYKoze6kDM0GArZY32njlKQJplmVAHOTdR3UNdNeX2DzWAUKM/cORhBKYkEIyi11v08QPxy90qS8NXlSYVnuyfZG5x6h2hMzDQbI1naIAE3DMLVayOU6qSi8ECOMc8Ldl9BWrKl5suugO5myKveXmljVyzLHJ0G/KRIy+EsLezJ9cbbQoSvLRiTG60UNQSvnveXTw7yA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(1590799012)(451199015)(7416002)(8936002)(38070700005)(5660300002)(558084003)(86362001)(33656002)(2906002)(41300700001)(71200400001)(316002)(55016003)(478600001)(6506007)(186003)(9686003)(122000001)(38100700002)(26005)(82960400001)(64756008)(66476007)(66556008)(76116006)(66446008)(66946007)(4326008)(8676002)(7696005)(110136005)(54906003)(52536014)(1580799009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K0hML0pnUFF6NE9ZeHdGQkV3U2ZoUk52Q0JUN01WaWxESnZXREdLUytl?=
 =?iso-2022-jp?B?QXcrUDRzVHlQaU1aNXFSd0MyVXI3M1VLbmpYcVFlQlNXZGlnbitWRU9s?=
 =?iso-2022-jp?B?RGVGNVA4L2kzaDg3Ull1ZXhwa1NJQ0hsTHp2aFVFMWIzTk5EYzAxOXFG?=
 =?iso-2022-jp?B?UVhQenEyU3MzWXc2b09ySyt3Y0VHTUpnNWY5TER0bTJEZWM5dk8zZ2ZN?=
 =?iso-2022-jp?B?dGplUW9aOHZscGxJWjVhRWx5aVRyK1V2VWpNOExvU3lQUjNzeWtMMndn?=
 =?iso-2022-jp?B?Qko1WXRQWGFiT0JuVDRvN1ByZGt6aWp2bjZVK1VoMkF6RjF5QXFJOExB?=
 =?iso-2022-jp?B?S2o3SFZWblQ3ZDNrOTdMcGczUUJSTWc4bDNtSjJRUDRjRG1CTEtrVXl4?=
 =?iso-2022-jp?B?U083Z3hyVzU1ZUwxeERuRHQ1ajJ3bXFSZ2tTaVBsMDJvTitpNjVtTHFk?=
 =?iso-2022-jp?B?d3FoWURkTWRKL2JmbVdwRkUyMlpWZWdZMzhUcUpOQ1luVmdacTVpWXVn?=
 =?iso-2022-jp?B?bXJiNUk4dTlGRHJJampZNVpjaVlucjRValV6NlprS01LSmlrZEFuRzFP?=
 =?iso-2022-jp?B?ajFCTUlCaXU0TTV6NkdnSExFcDhYS002Z3NZZEZmUUQwbTFCeXpCN2or?=
 =?iso-2022-jp?B?QlMvTy9iWWJvMFFYb2d5am5XVTg5QXQzcytOSjBJd3ZsOVp4bU5FUnJN?=
 =?iso-2022-jp?B?c3lXa0UvZnpCam80UFY5ZXdWbVl6Nld3WlFETndmYUI5Rm9NRGRFdDU2?=
 =?iso-2022-jp?B?UUJQYzFEbUdKa2RkTWR2ZENaRkhnUTNrWmRkelJmYm1UYSt2bDlwTlZj?=
 =?iso-2022-jp?B?M3hhaDQ4T2xDTVcrSXZhNmpUL0ZWb2pZenc2enBiMGdUQUFSV1BNZEgx?=
 =?iso-2022-jp?B?V0xWQlI0MExqbGpWb0tKOS9DbmpnZ0EzdEpzU21Wd2Nqc1FFZFczNWhW?=
 =?iso-2022-jp?B?WSs2U0s3MWpUT2YwckJ0bnRRN2hRUk9BU1U5N3FlMTAzRTUxRHRJRGpO?=
 =?iso-2022-jp?B?MWRWSFBVNHFwbVo0bFVwVktTSkk0eXI2NndKU0c0UCs4bnRoRk95SkRT?=
 =?iso-2022-jp?B?Z3dTdDMzampBNlhjRDQvTlJVcHNlNTBqQXZKUSs3c3dmR0NRNzV0SHZG?=
 =?iso-2022-jp?B?UFJXZmlWL2J4NUh6cDFIS3JQTkpJY0ZCNTRSUys3VGVkdnZvMzUwUHo3?=
 =?iso-2022-jp?B?ZEhPelJHbmlFWFJLRE80ck5qRXNqYUtQMW43anhTR1pwWHhabE5vbWNt?=
 =?iso-2022-jp?B?RVJJdDR0SjhLdEFLVHZKVEFEN0FYNU5oOEVNOENiaGtBR0NIL25xWXg0?=
 =?iso-2022-jp?B?SGRXL2taWTFDSDhvOUkzR09CYndhWGthMFhqZjBzaURxSVVLOStxMDVC?=
 =?iso-2022-jp?B?WnVOZEMxdzV0RldnVFFIUE9Sb2ZUWitGdTk4MVYzYU90enVJTU11QnVa?=
 =?iso-2022-jp?B?LzcybWVOT3FJbGM1cllGb2EvV2VYV08yU01uRS9qVVh0REVIbXBObG5Q?=
 =?iso-2022-jp?B?VHNvQU0vemxBRUw1NjBjVWdTeGY1Umd5SDdCTGxmR01zTml3aGJGRTkx?=
 =?iso-2022-jp?B?UWk2a3RJZWc2WEdZQlZ3ODg0aDJQczhJendpeWZQaGd6VGFEZElDOUty?=
 =?iso-2022-jp?B?QTRPbm1GQkk0cFlyN2lEM0pKdGZuMlMwT3YxaTdWVEV5WS82dXdWVGo0?=
 =?iso-2022-jp?B?b2ZYVTFvSGxKR2FXS3pYbXJ0Nmg4ajZRZmtOVE5FS3dMaWl5RHVuYmdr?=
 =?iso-2022-jp?B?ZGMyMU84UUV3eFBlQzlsNjhXSFZ1bDBicDVvTUhvNXExWXY2WmFFT1cv?=
 =?iso-2022-jp?B?MFA4eFp0SWtMaXpQSzA3Zm1zdkZDNHg3eXRUS0xUYVRHRWg4QWN4N1NR?=
 =?iso-2022-jp?B?RURvOU5JSnlyOG9ldlRlRFkycGFibHJ6N0ROS1ViN2VsZVZHeG9jMkV4?=
 =?iso-2022-jp?B?L0hYVjJTTzNhSGpCOFY1b0FYQTdpay9EWUwrMjFyYjZvMThaeUNHOVl4?=
 =?iso-2022-jp?B?NHdFZlZMeWkwUzVUNWY3ME1GR0FBVnNFbWEwRkw3RUFuQlRiVFhIV0Rm?=
 =?iso-2022-jp?B?YzdTRjR3c2htS0pCZ1ZneHNNZHQ4NUF2amdtV28vTzJYcmNnMjNQeUxH?=
 =?iso-2022-jp?B?M1VndVRLMml1a2VnakdrUW8wcExVOTNpalhLbTlqRERiTGdXQmtUYy9q?=
 =?iso-2022-jp?B?NlQwc1kvem0xQW5rQXZEMWhQdmNJSTNuY2sxMDN0d3pheXR2SjEyeVdZ?=
 =?iso-2022-jp?B?dTY1dklmUUovYVlPMlU0VUJzbVM3Yk0yeWdkRnBVNzVBZjloaHh0TmJK?=
 =?iso-2022-jp?B?Umc4Skp0Mi8xQ1E1QVoxWU43OWx4MDd4RHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c83185-3f97-4659-e1ce-08dabbdf593e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 08:01:57.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZX1yvzdRHXCWihnT9o/sBAkPt9SuMnfjuHAMe2b/2fdvz2puGL4ohDaX5JEWFoVh1ABF0WGF4tBYoVX5jVpKHP688MyQa1TMX3aEbW8SB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8268
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I tested this patch series on Intel(R) Xeon(R) Gold 6254 CPU with resctrl s=
elftest.
It is no problem.

I am going to review this patch series.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

