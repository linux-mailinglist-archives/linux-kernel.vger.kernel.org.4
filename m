Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3277283C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjFHPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:32:59 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C901730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686238374;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WjpY7Bi2u7E6TBTajO8ZBjer1lTeoRPOC3lkZhdsyuQ=;
  b=JwLd8mdNC/EVgQmFLYrFRrXES4b3pR1Tn1EkE3Re1zTZ58rpjtc4iNMs
   EX635ibvDk2cNAAIwKKfeiMSdVUTpSVWhbMdlMLsk20IJpRVf1WMwdXp9
   YX/p/25cK953TbULI/h4LUi+tImCGMe98S6wGdTaVMd4ieKX+4u/+jeLu
   o=;
X-IronPort-RemoteIP: 104.47.66.45
X-IronPort-MID: 111971237
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:SqkRc66OpvRWDg6fCmOrQgxRtNzGchMFZxGqfqrLsTDasY5as4F+v
 msWW2vQPfaIMGCge95wO9i0pBsF78XQytZqQAFuqSBnHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35JwehBtC5gZlPa4T7AeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m/
 NpAFxMgdx65p8H1ypO6aOxBoZkyBZy+VG8fkikIITDxK98DGMqGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6NkkotjdABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdtLReLhrKU16LGV7ksLVRlVSXqBnaigmHDhV/JDF
 BE24AN7+MDe82TuFLERRSaQomWAtxQNc8FNCOB84xPl4rbb5xaxAmkCUyJbb9onpIk6SFQC0
 F6K2dnuHz10t6O9Um+G+/GfqjbaEThFc0cBaDUCQA9D5MPsyKk3jxTSXpNgHbSzg9ndBz792
 XaJoTI4irFVitQEv42+/VfMgDWEvYXSQ0g+4QC/Y46+xgZwZYrgYpPy71HetKxENNzBEgTHu
 2UYkc+D6uxIFYuKiCGGXOQKGveu+uqBNzrfx1VoGvHN6giQxpJqRqgIiBkWGaujGpxslePBC
 KMLhT5s2Q==
IronPort-HdrOrdr: A9a23:paxQQKHjUTZSReZxpLqEU8eALOsnbusQ8zAXPo5KKCC9Ffbo8f
 xG/c5rsiMc7Qx6ZJhOo7290cW7LU80sKQFgrX409+ZLXXbUSiTXfxfBbKL+UyeJ8SGzJ8i6U
 4DSchD4azLfDxHZJ3BkXCF+r8bqbHtzEnrv5a9854Kd25XgspbnmJE42igfHGebTM2dKYRJd
 6z5tdnuzHlQngedMK9b0N1JdTrlpnklI/GfRVDPBIs6BCPgTS0gYSKaCSw71MxUy5v3bxnym
 TOkxX46qK/99m3xwTRzXW71eUnpPLRjvVCGe2RgYwuJjLghh3AXvUYZ4G/
X-Talos-CUID: =?us-ascii?q?9a23=3AUILue2gmFsAZjTYcvXykI5HJpjJue1uF81T9OkG?=
 =?us-ascii?q?CKUUqQpyUa1q93/51up87?=
X-Talos-MUID: 9a23:RKMLrAn84iDSS1WCtzuZdnpFLJpsoLiPMnxciIc45MWkKRMtGS202WE=
X-IronPort-AV: E=Sophos;i="6.00,227,1681185600"; 
   d="scan'208";a="111971237"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2023 11:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffv1OOmV2T/Qfpxuf7mi2XQqoE0W+96jF5Qa+gaeNlzTGS0jeUcfR8vtZwgomRET5oDCi3aqSnnt+9OBmSmx1SoAfYeCxphW32jG4q6fvDx45eDoVffOAeYk/TgDLrgnS0gd56GFZQDVLZFczySO4HA2tBGQlDyfh+aegfidOS0Hrfc8wsXSu+JPUiDWc9CTq4BJCvEI5joxX3vlTVj5Vcy5zbasnxTbM2lUzrWLbKxY61qQM1j3/OpTkqGvu/Mjols8cP0yQaC5+XlQZ/+T7wO/l0PFb5mKED0oJd/ZaUaq1foO4qh3WinSFVQuFnWwfvwxEazpjQE4bqS8nKVisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjpY7Bi2u7E6TBTajO8ZBjer1lTeoRPOC3lkZhdsyuQ=;
 b=TtI6FNnp4/lk86T1uE7/F7SIXPJsjSOpcie7506nYsAGxj/WmdyRHJ8GjqYOhATNLj41hDo81keVmYW2pvK1DmCy27/PAJ4cFHt5fscOdo3GOS8oLK12qg0YBrUG0bModGWubrhCfisIrQdNUs4kEWF5KimsURyDlsbZH6OXegOUHmm1H+YWcbOZYt44OCWHaLklxa+LZlzPLR9OeoUfQn11C3BLxHNTHlf/BS+Ks5yLiIz4ygZA4L2QeZ+IoawW9VL0K8Rq/xe84iSuWxNuv9tNVNSK/ooKZSTtR2OfxXI9++EK6M1hEmjlyeFaEGrDVr3WDTVQaF+DbF+FQvsPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjpY7Bi2u7E6TBTajO8ZBjer1lTeoRPOC3lkZhdsyuQ=;
 b=d5bEU0v70l0knIEHIJsA59qqh1Xx2y7LT/1O8FtYjshIe1dXw9HnRCZAKK+2N/CjiG0mhxwXkzAZ/qyRqu0AWeEgX7rOPW4SksUftLEcxLLnE91ynlqVgY/TVS4GVy7wIVIj0Ebo+4MmPhotmsGQyYJUjFpu1QSaZHW2x93P674=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CH2PR03MB5205.namprd03.prod.outlook.com (2603:10b6:610:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 15:32:47 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 15:32:47 +0000
Message-ID: <4b1833cc-a68a-78ce-7e3a-3f9eb17e367f@citrix.com>
Date:   Thu, 8 Jun 2023 16:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-GB
To:     Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
 <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
In-Reply-To: <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::30) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|CH2PR03MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8113b7-1850-4c80-38f2-08db68359c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DoUGm74Jg7G8w176PePj3DU5RiKOCrOBrhO+m4Cte/NB+6cTitzhN92HhWBZBpwBDLhXcYDMWBkIZWWKGzVrT6O3mb+P0rhL0LTm42MfAQsTDSne3r8+ZMIYV2hiX+erlL5JUrQZvoqNo90jD1nt0jmI2dtBg/0VaLcDlLbCtEGUzx7MPAi//4E5k186bbTtjYEwQxUxtxWtSxRBAfw0MdC/zzD09XLKvAKyVC8RA1FCAET9e1h65mCPdHSn8zMMVCzyjUbQNrOYVYrpCf3wIvFjIDJP6P34WGuLqSPabU6zS26PqY43GaVUZX2DGUvtnflR9WJQ/gMELVZyRq7gIumifP5IylJgiTEapnDQefYZqtbLVum677s0wC9EARR0k0cw5+a+kpIrLLyjkmDYXdzmeaqnRBQWhgaeWJq37MGCa+GYL39LH1Vz4WwdbVx36DPdE4i7QI2Lmy7VO447x1QJNG27ous6EiKFPclR4uQD+NirxE2/T9ZYU0mag5hqXJ6QZK0QRtNPVMo6BtlmJUsTMn9fIsbogsSxvE6D320m02qgY+3AyWAe5eCaNI4Y++sFoyABul7Gj3qIntsU9J/jGbFlGq3e7BHfxvlBzR3RDNwdbSnRH4LSGTKDH5EvV0OQtmAHaiSSEG4/XCbvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(5660300002)(2906002)(31696002)(86362001)(31686004)(6666004)(6486002)(83380400001)(53546011)(6512007)(26005)(6506007)(82960400001)(316002)(478600001)(110136005)(66946007)(38100700002)(4326008)(2616005)(186003)(66556008)(66476007)(8936002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2pJSjhuTElvcFhJQlNhOGowM3VCQWVXbHBzZHJ0aDJ4ODFyNjlwL1FIYUhq?=
 =?utf-8?B?ckpuYWdyMEVGcytZczN5MUFybkZEM0Z2cUdjNisyN3c2TTNjTElkY1FHVDYx?=
 =?utf-8?B?QThqU1VuUGZHZWZBTTBYMDI4ZWdydm53c0xuS1dGUlVKVUF4ajdya0oxVCtK?=
 =?utf-8?B?bnF3bkZiVmpXeStDZFhuc3hTMyt2aEVodmkwdmdWWTVuNzVIQzM5dFdDYU9k?=
 =?utf-8?B?SW83ZTJIcTNiaDE1akZlYjc2NUFOU0tVbDM1Zyt4MVllaG9SL21MMXI0Um16?=
 =?utf-8?B?Z3lNbFZ6a0F2RWo5WlpZQzNKQVYxc0thNnhNVEZ4WnlRM2wzV3BGbWp0MHVq?=
 =?utf-8?B?MVFhc2dkRThSVkYyQ3dWSjRNSEFzMkpoc2lyZm1UQ01NYzBGOC9UOUJCSnFQ?=
 =?utf-8?B?alVSaGlJeHgrelFicW8vL1pWb2ZZbmMzaHhNcXBxZEpLdXJ0eDUyZWxIUWxQ?=
 =?utf-8?B?ejBzZkk1aG9PSkdvYlc0a25aN1pNTW5BUzZCZFNHeEFsUk9PdVMrRmI0bFlO?=
 =?utf-8?B?WFpnbEEzSmxKT1lYUTh3ak5WenY1LzEyTXp3eG1qU0xYWTQxaDhXd2VrUytv?=
 =?utf-8?B?c0pEa2doZlBHOG80c3pQTmtES0QxbkQ2bXJkeXBsSGVGcmpGRFFHSGtFNnRZ?=
 =?utf-8?B?cjc2enNDOGtuSUlVN1lmMzhOV1lOa0ZrQXUwMmFmNnpRVmM5d0pCeFJrRWgv?=
 =?utf-8?B?RFg1YnZiZkx3Mnl1YVVPRldlNVNCbzFrNXdkT2pBejcrYXZ5L1B2VVg5bEhr?=
 =?utf-8?B?S2oyQmowK05PTmw3RklGTHdkR0hKbEl6dU1DdnFZV2RDZ0dHb0FMYjhiaTQ5?=
 =?utf-8?B?ZjZSODdGNnJBdDA3aHQyUzY2L2Z2SGh4bXQ5cWVyREEvWnJIb20zYXUyNnUx?=
 =?utf-8?B?aWptVGpWUkNSWnRKUEZGZEticEVIRDcvSHJER0ZabzcwaG4wTDJTOStGWmNX?=
 =?utf-8?B?QWtLcnREeFppeGxjK045a29XMlNCYUtmUTl3SDUrUVVpZ0N6MU5vaGxXZVEr?=
 =?utf-8?B?Q05TQm90R3lLbklQTWRxZjI1NkMyKyswTUhrVHZ0SG9pUCsvZm9PV2FGZ0Vh?=
 =?utf-8?B?NjV2S3puc3BuekZRMWNsclNXdkIxbzU3aUlyVXZyeVRUWDJiYWVoUklxbzhL?=
 =?utf-8?B?d2ZYeEluR1h4OTVtbjlnV0F5WWpLYllvK0NCdGhLL295RFpnTUw2c0xseklS?=
 =?utf-8?B?N3VDZ3gzdWNiZGdxRmM0eU5Jc3pjN3hLUlIwUDltRXd1THhlYWM5ci80K0Ny?=
 =?utf-8?B?a1UvK3hSQ3JyN1E5anVYdGROS2hqLzJwV29VY0puWjd1OHU1OU91SUxNR1Fr?=
 =?utf-8?B?RGViME5QcGtVRklFaC9vc1R0dVZQNnpVSzRNUWpEUlR3SVowL2NaQ2Y2VUlM?=
 =?utf-8?B?cEFvVlV5NmNoYVlKdGtKV3lDQ3FaQmw4MXVMSHFST25pVUo0TkV1RkpNaEVy?=
 =?utf-8?B?OGVCTTVWOHBHSEJUbFRqb2ovRFpQbytKcXVTMlg5eDJkZ09xUUFyZUNJQVpZ?=
 =?utf-8?B?cjdyczQwQzdodkRESllUbmkzRGg1N3p2UlYzbHRRaU5mNzZrTTVkcTIvSzFL?=
 =?utf-8?B?ZjJqQW1xTjVQZzBacm8wTHhmZnN6NnJYQmVLdnNXYmRWeHZQZjdVOXkyYmVR?=
 =?utf-8?B?UVpRU3kxLys2R0ZJbEo3dFQwZ3k1cG85Q0Zta1Nua1hPQUxjaXJJYzFmR3hR?=
 =?utf-8?B?QkdiSjAvYmNGVWxEUmFYekg1QmwxcjVhS3ZkY0FyNHJrLzRwMDJYRWk0aUVF?=
 =?utf-8?B?dEZkU0IwY2pVMU84d0R1c09NVVBxSGJadUdvcTlHZVVsYzJWcHlaRkROR1Az?=
 =?utf-8?B?NGdrbG1XVW9yMkwrNHh0b1czRVZRWDhlZmhBUE4yZ2pPbkZLWDdMWGJOTzVp?=
 =?utf-8?B?NDBqM0k4Umo3eGhsNDhnSTA0NG9CSnYyZ2VJcktGT2ErN2dCeW40WHBTZlRu?=
 =?utf-8?B?ZVcwbXA5Ym0rVTZOeHl3OHV2MGd3MkFUMU1tWlQ0OU5TS0RvdGR4SDVWOUFa?=
 =?utf-8?B?RmpqSjdvL0p6andDUk5jMHFhcmIzK1JVeUJVdm5RYjdlc0J4WGhNSWtTczFj?=
 =?utf-8?B?YWFJNnF5MWZxQ2xYeGc3TGtuQ1pYSHFsWXRmdUM2S0J6NTc1UEpKamFURkFO?=
 =?utf-8?B?M2xTbjdjSGpaVmRUeTBPQ3dUekhEQzUyUk4zcCtwaW5zMmY1M1BiUFF4VElm?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VsrYjmw09+Rn6FkNJZmxdN1GAgcQo4WiQbMB8I4lt8BpdczACLaY7n8bffk1dUh4AGRzaFyCFFw7ICq+Ivm2x4B+wbkeJJRUAXnNV6Gr2R+yCFSw0Y+EYX+4SJ7jkSxMI9bBQUiajA8eI3vih7zExFCYY2sXkgOOZGcgbNhVb1q9Xj3jQuaRYCu2X2h0OsP2Gc4KtXTYgq9uhx0FSaTD8O+yMSKwhehvH1qk4QQ5l8ZO7UAKUcrqKHS2s+3uHmzTRPP8HJIZJw+pDji/LPj96qJvCBjCEcCGyjXK8MW/u17RPvFhtc/2a65kto5z7NJYPpD4DL1aZrjX1J+Kr2YBfzxFjm+vMRj8evFY8REGnbTVYErnJroa5Cfy/RqlyIb5EiSNJyOgFBepiTL/WX+Cw+4iFP7RlglHYtxbFcNlQdpJfxkq/ETzPM1EagQUr9OiXQNpWwK4st9s3G50EfTeUff81WvlxNq8U756TQrKTfpw039phBY2Qr94yRCU46U/ZgabyFHHYHLFw03VO8hKWLQY8t6l2I5f1hXYOYg2hmpZoQFfsr5Psg0b/mxnVH7ypPp8CbRBroGZIIc47Lzm01DSPcc41bxwmj3bvVfYaC5XcW79+k7q12+lnTqlkxXj20a9eZNaH5efCraE/jB4uGEIgNbJql+qAUSWFdSnME+uJ6l4t7CuZ2yjTUanWlWNbsG+mTFdB4N2XSGWJvPO3HeSBCvBpiFi246dRJcdccuS1imH1kwg09NqvxTdfGDZpSgk+K3CxcwoRf1MTO+q9k0JZZs4vI7P6RbR9CgIYbAphaTrvK9LfYuvHYY+zd/AaSStaL/qJ4p/13km8vpO5MDdXY1fJZKaE/yqMMhm/7D7HFZ9LNSWezSC76BvBJP4
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8113b7-1850-4c80-38f2-08db68359c6b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 15:32:47.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSvcOz8Q0N7VP4Iy3pSDa4cK8bJ8G0i3DVJbWfzzgaatgSQ1nqvHNOJRcZK8iUIcpRuxPAcgCTnqjS6jbnxn8ZyHjkcJlC1DlBM40Mp3afw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 7:16 am, Jiri Slaby wrote:
> On 08. 06. 23, 2:25, Thomas Gleixner wrote:
>> I really wish that we could disable syscall32 reliably on AMD and make
>> it raise #UD as it does on Intal.
>
> Sorry, I am likely missing something, but why is not #GP enough when
> we set CSTAR = 0?

Yeah, don't be setting CSTAR to 0.

If you set CSTAR to 0, and userspace has mapped something at 0, then the
CPU will start executing from 0 in kernel mode.

If you've got SMEP active, this doesn't help.  Instead of executing from
0, you'll take #PF.  Except you were already in kernel mode and #PF
isn't an IST vector, so you'll then start executing the #PF handler on
the same stack as before... which is the user stack, and it can still
hijack execution by hooking a return address.

If you've got (just) SMAP active, then this doesn't help.  The hijacked
execution doesn't need to touch the stack to execute STAC and re-permit
user data accesses.

If you've got SMEP, SMAP, *and* FMASK configured to clear AC
automatically on syscall, then you end up in #DF from a SMEP violation
trying to fetch the code, and a SMAP violation while trying to push the
SMEP violation's #PF IRET frame.


It's almost as if not switching the stack was a terrible terrible idea...

~Andrew
