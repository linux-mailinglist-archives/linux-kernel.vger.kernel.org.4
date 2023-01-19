Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D7672D93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjASAmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:42:49 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE9577C6;
        Wed, 18 Jan 2023 16:42:48 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30INwv1n011974;
        Wed, 18 Jan 2023 16:42:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6P1Q/+SC2Uj+pkEuNrJ2uVn1xFKcE76AmKj7EXajpOA=;
 b=anqilOXMqg35K3aqAiQjjuc6AV/dSn8oNV81Nffm9iJonVYa18qDLrztTcstkpSwrxpW
 H8Ci0Rv8xEzGf+PyduA3j6E327bGmbKBbZgkmYQ7v66mdUpulun/VnqA8wGCf1CXILK3
 H6gjy+l2/VwV9jDE+1uzQhr80KGBbmLTMDmRziaJXo7SJf7Mk9H3Ul9B9eM4Ly+sJI5y
 DrZdijgmX8zSbH/Fwx1D3A/SL+XxiAYDxbZL//TM+LbodKYVbdtHAYQHUBJSxRY7vEKR
 L4aN09CskpiMso11jfoOZLrSdy4dXgwYFUb6AjvCIBF3nRP2Bm/NIwW1h2ODjA/ld39P EA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3vhb0jgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 16:42:32 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0945FC2326;
        Thu, 19 Jan 2023 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674088952; bh=6P1Q/+SC2Uj+pkEuNrJ2uVn1xFKcE76AmKj7EXajpOA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M1JNE/M1hRPm13rkzKMCqATF5rXFwNisZf7P5dsvCG2NL7aIQ/ckpGZIhC6j/4gvy
         FzOcUFaYMMZyRly/5pXYyutXkYhxvFjdHbSo6ja9I0RyOqRC8WShK8fODD6ECmImyx
         yUwdpEo1jDrbKTevBhJsvZ2BdtSCb1Fnccn5s6lQscnaMwhIvWlYSdcqXMT9AU6Aad
         c8M9GCFYlhU0fwRZnFpuN4lJWaacINlhjXvSWsMrTCBDOcjBvs2jak21/U7cfWBVMH
         JcVAd1XVTEm2gi6acK8l71sM9/b5ePwMjZ1H+8Y6Wu7MG5Sj9IjnFW7CAyQqxKVrar
         L7yC7SfJwPP1g==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3B7D7A008A;
        Thu, 19 Jan 2023 00:42:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 79A55A0020;
        Thu, 19 Jan 2023 00:42:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KqMkmLdH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z00AxpK66gome/44bqxG+W1vKQrgZA8admp8Hxj4dkmUc7E8VETw1M57Nk0vFNROMixsiBCrfstXJ2iC8WTx5zM8HyXXw8IbWweQZrUsHZsUmKk4sk7kSQKZ9SQaX0bb6q8KYNFJjcm8HSbB3FluYy1ucVW9tvUZPA7botOtlWnc8N8XAEn/mcKyXtIuzPxQmbfC36OWkjP+1pLDmtHf0h59TiZUBQa/6Ssa8Ck2L0zQ5Tn/8/Ax0+7sbeeBFZ5VMd0/pVsaD0BXw04I4C0gyz6plwD2wfUyiid+ng6ZXrLeysK92APRbUBXpu9Pbcb1GsWhILfqaJR9asGDTc9qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P1Q/+SC2Uj+pkEuNrJ2uVn1xFKcE76AmKj7EXajpOA=;
 b=fyADsMAhqanjAzJty6af6IAiS6b4dxS87VfXXhiteqF9T+T7yBFXOMicsgKIm2iJ2ktBcosVRKMzFvJ7qTkDD0+QQGiznW07AMb8p6R7Pk9+hhxNb1pKbfD1i5bMv5B+LsQ3G5bsoV3d1r2X3PXNiDVUJuoE2bHgd+M6rBd6tVj8MqvBgNFfZzMaiQpnpx7QsUSGHPcU9mGWqtwzumepNmav0+bAGK1vC9r5/zJZuuDfRrtkMIumFvAlkPIlwyc7Hh2gpQ+sp0Gqy7tbEqy8xZyKYDSVA0amAdRTrl9j6jkZcruvDr4nTl8kTjmI9dYmcLEcm/Y0FrMbqtsIq6naSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P1Q/+SC2Uj+pkEuNrJ2uVn1xFKcE76AmKj7EXajpOA=;
 b=KqMkmLdHaiWEodQuVOlLqB+frq2dB4r1DR0gqTuUiR6geg9uyHCjfXvAMrFAgp5V4xTJVAmEQKuQ0LHso81HfudcUPMjO9Lwngbk94dALTAoOIGBayzoYHA+1TjfG4YZwfSqlyJEWCwTx+NA2fNo4Bl7iGEn7h7T33MAJyHfWjw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 00:42:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 00:42:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kushagra Verma <kushagra765@outlook.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: fix extcon dependency
Thread-Topic: [PATCH] usb: dwc3: fix extcon dependency
Thread-Index: AQHZKxuGPWAxG8apQke7FY2RmY5A0K6k55EA
Date:   Thu, 19 Jan 2023 00:42:24 +0000
Message-ID: <20230119004222.jabolevwuzptgtu2@synopsys.com>
References: <20230118090147.2126563-1-arnd@kernel.org>
In-Reply-To: <20230118090147.2126563-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB6822:EE_
x-ms-office365-filtering-correlation-id: ef4c4a6f-798f-4d35-a410-08daf9b6082d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7CZETMmZ9zImrO9cqYg2U2JfuRdshbIGoxraE18RZygZQ7txHpmENL+2sumUjpGmGkWSdNAE3v0BWotGbuxwhq83ABZvYRCBwVnqLK4le3d5FKbf9Y612gwhW/x+wNRev2WvyLZ5KcGviZOLTX0piNKg7zWcYG9hzSV6z5IOlZblZ1ZM+FFOFZqRQhIa4UVwW85DldJN+EAMRrnedvLplqkeSk1GD98sYJvBkw4mel0K/zYp7I8Xgo5Gbh4FVjYetBpe5ZZehdmfuy2e1LUA1y2aclClfy4kEK9T4mjAXfkDfcn2Y4jF5WsbTeOcxaZXTyXYI3e53eZKg+tB8Es2a8mT2PqNp7XDCrXbIAN80zGQkznDCbL1PlGg/lymZshU2Y5DSj2wvT+bSxoiD6RI5alfBE7bhyeg1JO9uRBaoe2EL4rFSoles99J6g/xR2Ovxt6fdfddIRlqPfIY5Bw8Zuv2hc3qXcgKwoRMXm68P0kRn5lgLmFiZTCYq0P57rxI6EUm7qSacmSKLTFHHMcsHuFxWhF74Z074+eh0RH1kFRrma5aX/FDK8uiEupoKz6fUjQipfbs7caJnd0LOTnG1NeWQVxdt5J7+KvTqBYFKslLf7Bij+H2Mc9r2nkvhcILrHUjSqw2HIgTZ3JBgVdF2FnJQZewJTWphTScfqhupSuPKDmaW65FEw7uos/95LfNJtMJwdHOytfVpL7XMZkrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(6506007)(6512007)(478600001)(6486002)(26005)(186003)(2616005)(1076003)(66556008)(54906003)(66446008)(8676002)(6916009)(4326008)(66476007)(66946007)(76116006)(64756008)(83380400001)(316002)(5660300002)(7416002)(8936002)(41300700001)(2906002)(122000001)(38070700005)(38100700002)(71200400001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk1yZmlVZm5ReHNMUy9uWDBJSXRzTHFNU0tHQWpuU0JGQlEydDYvL0xrSjlt?=
 =?utf-8?B?T3dvRUdHLzBuc3FyS3kwYlJxbFROSGNRelJTQ1BWU1poR3JGMVROcCtTZ0lL?=
 =?utf-8?B?Nm1sNDhLNVJ5c3NJNUl4bjh4ZkNoRElaRTdJeWQ0dXNkSC9tU1pJemtWb3FP?=
 =?utf-8?B?UGZEbTRvYmFqallYdDdvSzE4RXMvK1lZT3hYTjhSUEVYUHc5OVJNTmJMM00w?=
 =?utf-8?B?N1BpR2FLblhzY2lnUGZtTjZJS3ZMNWN5bHJXaytxQy9Yd2gzRUI1QWJYN2Q1?=
 =?utf-8?B?cml3VXkwaGRXM3dpREgwZ2J5Mk0wVVZiMnUvYndKdHNNMTA3VGR2TUlCQytE?=
 =?utf-8?B?QmtZVW5zOUhDeGt5YmZjbk9DbTV2UG1neHdSRHJLdDZ2SDZhNVVkeEl6RndM?=
 =?utf-8?B?NDdvVXhYVDlhUEh0OUIvMzdyMUh3TkpKTEpVcDRtN2MwcGJUaEtOQmxUUFh3?=
 =?utf-8?B?TXYzQ0JpYjJaU29Ed1V0VkVRU3F0MHdVZjh4cStOYnQyckFqL3BnNm93V3RB?=
 =?utf-8?B?SEVVSTdNeWNkbEpCazU2Q0dNK3lTb3ROVmt1ZlZEb0hwT1kxa1dUZmtjb2V5?=
 =?utf-8?B?TmMxVk5vNzc4QzBjY3lDNlJqTDcrMjdnUERGU2VOVlJXZVZGN0t3L2hlM3hQ?=
 =?utf-8?B?UndGVlEwWXlDalcrQUdGRm9NUHRJUHBtcWltUHNMVm5kYnpGNTg4aHBZc3NL?=
 =?utf-8?B?VmpMT203SENncUZQYWV2cUlzZnRRbi8yalNnNUp0dGtmcmh3aVdUTXpDWjVp?=
 =?utf-8?B?YXV3c1JIa25aeGhlU25aWGhVdlpXMGtHMzFMcVAzeVQvemYwVmtZR1BoQXRm?=
 =?utf-8?B?RE84Y3lwRElNVTZjaXZpQUxJZVlLR3puWklTTkFjYzViM1FNSElJQXlhNUNT?=
 =?utf-8?B?MkpyZk50cXVOdFZ6RFhUeEpUdkJiRmRwYXFuUjV1QnliT1dtWDZ0R0NUZ2Nq?=
 =?utf-8?B?d1VzQ3RSYnRjUXZQYXJzQ0U2eEhLNTBlQldQek1qZ0s3amxtTE5meVBYa1Fj?=
 =?utf-8?B?MG50amgvWTFwaUNBZ0NRL3BCcER6V2lOSFJqYXhHT05TNWN5c0JsWUwwcmJH?=
 =?utf-8?B?dGllOEYrdFluMi8rV083TmVQUlc3MEhoc0ZXWENSYWxSVzBmdjV6aC9odjg5?=
 =?utf-8?B?aThlMUpHQ05HSWo0TWlqTnN2TW9pSVFrYTRUV21WM2o2ajIvTTJNUEwvak9R?=
 =?utf-8?B?VDJkVUdYT1dGSkg4S2R2T0swQXJlYytqelpuZm5LMnlCV0lyWGtVS0RlYUhV?=
 =?utf-8?B?clI0VHA5bWltR2pQR1NMMVFyalVQZmFpd2cxbjJhT20wSWg5eCtWK0pYbURu?=
 =?utf-8?B?eHdOZ2VkbHU1eGZxcDBMOXpRbG1xTU9wTjBjZzlsZHczQzFGTlZIaVU5a0Vs?=
 =?utf-8?B?OUNHYWVreS9wZzBpMjRQTTJTOTFlK1h3UzlRVyt0SlhVRnZBRlJDY0Q2dEp1?=
 =?utf-8?B?QXk5NlFJK0U0Q2RQN2pHdXBvbVBZTkFpUTJvUDhQNE5ObjRyUU84Rlg2MDAw?=
 =?utf-8?B?UzN6SU1Ha2NlNFZpU2NnYmFOSGsza3VqU0p4UklHdlFWUDJQQXdiRWxRWUNu?=
 =?utf-8?B?cllwR3d1bG5ORGkwQWsxdHU4M3hadHBIL3A0TUlENFRzNTZQSUNyT2loMUw0?=
 =?utf-8?B?OFZ1RmFUN1d0aXl6cGd3RTV2Vmd0cWNUYzVMdWpidmZmZkQwZ1VHM2hWbUdG?=
 =?utf-8?B?ODNqQXVEaUxHVDVKWFlwSk1CRVNCd2xWd1hJOVJCUmZ2aGJWSm9qNGk2ZzFz?=
 =?utf-8?B?ckRRL0p2V0J1VGEwaDRpeFJtZGk4MDhXOFRLUXlkK2JJUEVZaC95TFB5RllU?=
 =?utf-8?B?N3ZHMkVTNTJjdnR6dlZjMWRYa2Z3S1Q0UDJ2anB6dWZVNTh3bmY3OGpjeUw5?=
 =?utf-8?B?ak5MVVlBVXJtdFRHaU9kVnJTR1Vhb2VYbTE0NTd1WU5oeDNQSjBtNVNWcThF?=
 =?utf-8?B?RUpBQUpSUFp0eDVITXFRM1llQ0VmVWdtMmNvbGpydlRkcjBFUlR6ck9QcXVX?=
 =?utf-8?B?YTRGV1hnaW5BWWpTSW01L1piQ3dBRmlwUGk4RlVVSDlVdzZraHkxT0lpWFRI?=
 =?utf-8?B?dGRBWGU2OVZOWXVwMXl1WWhCSnVlTWxYRTlobk9aMXphVytzNVhsckI4Mkpm?=
 =?utf-8?B?aTBibWxhNnBiaFFaSW80WmJ0NUlaVHFnV0pRN2JObFlacE1iOExZSHZ3dUth?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <496D6F5B0408BB4EBC51010367509441@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OTlMWEhNa0h6VHFlT2pPaEExRjlOMVVCZmVOeS94NFpqallIL2c1TW0vRDk1?=
 =?utf-8?B?SUR6Tk91T1VzSXdSallKbW5PRWlDTXNDLzRzMmpNeVU0N3JVWmx1blBZYnZI?=
 =?utf-8?B?NnYvT2pyQUYvMmRxaXRMWE01RU5rWEF5bGVjL2xISG1BOTBiU1pCbGtycWJB?=
 =?utf-8?B?ZC9DaHZGTnduOWQzdFF4OGIzSWV6YTY5ZHhmN0FGZTJBclRTTUMrLzM2aTJx?=
 =?utf-8?B?dEJMbzJSMHIvMjk0NnJ1UytBZUFiNDZleGZMN1VESG1mZkF5UStaQm5Fa01H?=
 =?utf-8?B?Y2ZJK1MyUXZMcGJ3M2dwQS90VUMrUlM2YVdtbXJXLzZlZnNrRHZZT2UwTGdu?=
 =?utf-8?B?aGlYRlhsZVJqTVpoSkNJeXlHakJrVUxOaVVmUXZaME1STTN6T0JSK29NZlUw?=
 =?utf-8?B?djVkR2k4dmplTXlkK1RFenA1ZnJCSmZQS2diQklqaSthS0RrMmxUbTZZcW5D?=
 =?utf-8?B?ZmNLM2F2Rktoc0xTcUQ1cUc4bTQ1dHdreHFpQTduS204U3VSSVBjRG9ZOEZi?=
 =?utf-8?B?VHpMajNETGJJbDdHVTBWM0ZhditzVWVyZ0NaTlJ6VFpVYWlDbUY1RDB5WHRu?=
 =?utf-8?B?TkVXR3MxMFZ6Z1JwSTBJamFlc2FRRjVLMi9BL3RwSk9UQVhDaExwMjRpR3p1?=
 =?utf-8?B?OGhtVnNNeklDU0h0blBEeFk2Y3djWFgwdnRZVnBlQzNSbzNRTFdqS0xwY2Zm?=
 =?utf-8?B?cWkycTR6VnM3Rm1xdmJ2TnJoWkRhMjZobTN6ZlQvQm8vTjVjZnE4RzBzVWND?=
 =?utf-8?B?ZjFYUEJIMnNMcWt2MjQ1YjdiSnpEYjVDVGJwcU5uQXZkOUZ4RHA0bWNyc0pz?=
 =?utf-8?B?OUw4dkc3S3NMSGVKSVRFTThQTTZGd1U3emg0amtYcjZsVS9KRjlDT3BCOFBK?=
 =?utf-8?B?RWoraUx6Y0ZMZTZiVWQ5WEFnRkl5STdtcDFIYlJmUlVmc2Z1ZzhOeFNHZ3Jy?=
 =?utf-8?B?VXlMODFVY2lkS0V2RUMvZWdZYjFDWjJoTk1rS042ekIyVmU5Q0ZObldiN01F?=
 =?utf-8?B?MFQ0N1lnbjV4VVYzVC9TQWQ1ajZGT1pyUzJuUDFOczBOeWdleVRIOVFpVUZF?=
 =?utf-8?B?SFdLczY4THBSempHM2ExbXZtZWk3S0E1cmRuUS9LMzFLSW5WcHRTVkFmSldQ?=
 =?utf-8?B?bXQrY3dvQTU0RFhjWUNDWThBR3RrdlBXT2dTYTQ1SnN1U2FLbmphMFhyNHVY?=
 =?utf-8?B?dm5MU3pSeVZQdElyTEJTVldDYXFZOGt0amhxTXBzcDZyemQ2VXRtOVBCdHFD?=
 =?utf-8?B?WUovUDk5d0ROYmhpK2FBcUw4b1M4UlNiYi9ZemM4Y1V3c0JsM01XZy9zNm9G?=
 =?utf-8?B?eVFKcWFaRlc3UE54VWZJT0tMYjk1OHRTNnIvQzJiRjlxWHFRcEdpRW5iVlFm?=
 =?utf-8?B?UVBZT0ZqaXB5SFE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c4a6f-798f-4d35-a410-08daf9b6082d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 00:42:24.2606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieO+ycK7O1d2kQsXFm370sg30H03l71Jgza0oY+LHj7Kex3YCsenp4xZg27r0j2L4H5rrLIejyH0fWzdYdrvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Proofpoint-ORIG-GUID: VbTFZ2aSjN9uPmUwBDBk4qTVSYuAm2mi
X-Proofpoint-GUID: VbTFZ2aSjN9uPmUwBDBk4qTVSYuAm2mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=636 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTgsIDIwMjMsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBUaGUgZHdjMyBjb3JlIHN1cHBvcnQgbm93
IGxpbmtzIGFnYWluc3QgdGhlIGV4dGNvbiBzdWJzeXN0ZW0sDQo+IHNvIGl0IGNhbm5vdCBiZSBi
dWlsdC1pbiB3aGVuIGV4dGNvbiBpcyBhIGxvYWRhYmxlIG1vZHVsZToNCj4gDQo+IGFybS1saW51
eC1nbnVlYWJpLWxkOiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUubzogaW4gZnVuY3Rpb24gYGR3YzNf
Z2V0X2V4dGNvbic6DQo+IGNvcmUuYzooLnRleHQrMHg1NzIpOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBleHRjb25fZ2V0X2VkZXZfYnlfcGhhbmRsZScNCj4gYXJtLWxpbnV4LWdudWVhYmktbGQ6
IGNvcmUuYzooLnRleHQrMHg1OTYpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBleHRjb25fZ2V0
X2V4dGNvbl9kZXYnDQo+IGFybS1saW51eC1nbnVlYWJpLWxkOiBjb3JlLmM6KC50ZXh0KzB4NWVh
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZXh0Y29uX2ZpbmRfZWRldl9ieV9ub2RlJw0KPiAN
Cj4gVGhlcmUgd2FzIGFscmVhZHkgYSBLY29uZmlnIGRlcGVuZGVuY3kgaW4gdGhlIGR1YWwtcm9s
ZSBzdXBwb3J0LA0KPiBidXQgdGhpcyBpcyBub3cgbmVlZGVkIGZvciB0aGUgZW50aXJlIGR3YzMg
ZHJpdmVyLg0KPiANCj4gSXQgaXMgc3RpbGwgcG9zc2libGUgdG8gYnVpbGQgZHdjMyB3aXRob3V0
IGV4dGNvbiwgYnV0IHRoaXMNCj4gcHJldmVudHMgaXQgZnJvbSBiZWluZyBzZXQgdG8gYnVpbHQt
aW4gd2hlbiBleHRjb24gaXMgYSBsb2FkYWJsZQ0KPiBtb2R1bGUuDQo+IA0KPiBGaXhlczogZDE4
MmMyZTFiYzkyICgidXNiOiBkd2MzOiBEb24ndCBzd2l0Y2ggT1RHIC0+IHBlcmlwaGVyYWwgaWYg
ZXh0Y29uIGlzIHByZXNlbnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZyB8IDIgKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL2R3YzMvS2Nv
bmZpZw0KPiBpbmRleCBiMmY3MmIwZTc1YzYuLmJlOTU0YTlhYmJlMCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvS2NvbmZp
Zw0KPiBAQCAtMyw2ICszLDcgQEANCj4gIGNvbmZpZyBVU0JfRFdDMw0KPiAgCXRyaXN0YXRlICJE
ZXNpZ25XYXJlIFVTQjMgRFJEIENvcmUgU3VwcG9ydCINCj4gIAlkZXBlbmRzIG9uIChVU0IgfHwg
VVNCX0dBREdFVCkgJiYgSEFTX0RNQQ0KPiArCWRlcGVuZHMgb24gKEVYVENPTiB8fCBFWFRDT049
bikNCj4gIAlzZWxlY3QgVVNCX1hIQ0lfUExBVEZPUk0gaWYgVVNCX1hIQ0lfSENEDQo+ICAJc2Vs
ZWN0IFVTQl9ST0xFX1NXSVRDSCBpZiBVU0JfRFdDM19EVUFMX1JPTEUNCj4gIAloZWxwDQo+IEBA
IC00NCw3ICs0NSw2IEBAIGNvbmZpZyBVU0JfRFdDM19HQURHRVQNCj4gIGNvbmZpZyBVU0JfRFdD
M19EVUFMX1JPTEUNCj4gIAlib29sICJEdWFsIFJvbGUgbW9kZSINCj4gIAlkZXBlbmRzIG9uICgo
VVNCPXkgfHwgVVNCPVVTQl9EV0MzKSAmJiAoVVNCX0dBREdFVD15IHx8IFVTQl9HQURHRVQ9VVNC
X0RXQzMpKQ0KPiAtCWRlcGVuZHMgb24gKEVYVENPTj15IHx8IEVYVENPTj1VU0JfRFdDMykNCj4g
IAloZWxwDQo+ICAJICBUaGlzIGlzIHRoZSBkZWZhdWx0IG1vZGUgb2Ygd29ya2luZyBvZiBEV0Mz
IGNvbnRyb2xsZXIgd2hlcmUNCj4gIAkgIGJvdGggaG9zdCBhbmQgZ2FkZ2V0IGZlYXR1cmVzIGFy
ZSBlbmFibGVkLg0KPiAtLSANCj4gMi4zOS4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
