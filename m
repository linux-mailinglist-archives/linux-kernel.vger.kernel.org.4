Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3963C685
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiK2RjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiK2RjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:39:13 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 09:39:12 PST
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929063F052
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669743552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uG/FEATAhOMNZcQ2jF0SvGGRkIGOUT6OcTPQ3NjN2Ck=;
  b=Jab2QUDWIoI3HRPqtbh1zR04Qae4dJojF4R4MfqKJq5i+VaDdkxPHZNd
   NYqDqypim2wEiltxmc1C40Lglr5c1oEqKFiYC1wWTN553YDXnZVPdlhT3
   LpeIHtOlKf4jYbVvTVFhwfCX4Xp1n4J+5MbInswD5YUdwzXB1nBcHjcwr
   s=;
X-IronPort-RemoteIP: 104.47.58.168
X-IronPort-MID: 85789444
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:tF9Gk6I+4p5U9TzhFE+RTJQlxSXFcZb7ZxGr2PjKsXjdYENShjZUy
 TceWm/Sa/aIamT1fNsiYNy19xkA7JKHytZqTVFlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5wZvPasjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c4tEzoX8
 /g7AQopazWOlqWc0ujlcMRz05FLwMnDZOvzu1lG5BSAVLMMZ8CGRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGNnGSd05C0WDbRUuSHX4N/n0KDq
 0rN/njjAwFcP9uaodaA2iLx2b+ewX+nMG4UPLbmxKBYp3GY/EseCA8wWQe1/qGn2mfrDrqzL
 GRRoELCt5Ma71e3R9PwWxm5pn+svRMGXddUVeog52mlza7Z4B2QAGQeeSJQc9wttMIwRjsC2
 0eAmpXiAjkHmLeSU3OGsLCPsSm1JzMWPEcFfyYPSQZD6N7myKkxhB/SStdoEIauk8b4Xzr3x
 liivCU4wrkek8MP/6G65kzcxSKhoIDTSQw47RmRWXiqhit7a5SifJeA8kXA4LBLK4PxZl2Au
 mUU3suT9uYDCbmTmyGXBuYABrek47CCKjK0vLJ0N5wo9jDo8Xjze4lVuWh6PB0wbJZCfiL1a
 kjOvw8X/IVUIHahca5wZcS2Ftguyq/jU9/iU5g4c+ZzX3S4TyfflAkGWKJa9zmFfJQE+U3nB
 aqmTA==
IronPort-HdrOrdr: A9a23:nJyRvarraP6t3PGUrREtnWsaV5saLNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXbsibNhd4tKLzOWwldAS7sSoLcKogeQUBEWk9Qw6U
 4OSdkYNDSdNzlHZIPBkXGF+rUbsZW6GcKT9IHjJh5WJGkEBZ2IrT0JczpzeXcGJjWucKBJcK
 Z0kfA3wgZIF052Uu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyR+49bLgFBCc/xEGFxdC260r/2
 TpmxHwovzLiYD09jbsk0voq7hGktrozdVOQOSKl8guMz3pziq4eYh7XLWGnTYt5MWi8kwjnt
 Xgqwope+5z93TSVGeopgaF4Xiu7B8er1vZjXOIi3rqpsL0ABggDdBauI5fehzFr2I9odBVys
 twriKknqsSKSmFsDX25tDOWR0vvFGzu2AenekaiGEaeZcCaYVWsZcU8CpuYdQ99WPBmcIa+d
 tVfYXhDcVtABSnhrfizy9SKemXLzEO99G9MxE/U4KuomBrdTtCvjYlLYQk7ws9HdQGOth5Dq
 3/Q9tVvaALQckMYa1nAuAdBcOxF2zWWBrJdHmfOFL9Ccg8SgTwQrPMkcEIDduRCes15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIRGmmRzzixsxX+pA849THNfLWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umKWf1A45G0wD3RpEXI3gDV88evMo9Rju104v2A5yvsvaefOfYJbLrHzphUmTjAm
 EbVDy2P8lE5lDDYA6MvPEQYQKeRqXSx+MBLEGBxZls9GEkDPw8jiEFzVKk+8qMNTpO9qQrYU
 oWGsKVrp+G
X-IronPort-AV: E=Sophos;i="5.96,203,1665460800"; 
   d="scan'208";a="85789444"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 12:38:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9bk4lOKIoaxVbUP3Tg6l5dvbICf3c5mfzpRodLd7OQoZiyMsbBbnY5Llw0ttU9OZhHugTOnAxxz+N/cpGzRC8GsJGqBXPxiEEtGxUjSym2L/mokhbpHKyT3KP5YH4Z3oK0iMwjn+DW8umrbXi4LOMamK44mTsmF4UWVuO++lD3Huf+wsbNJiMzCVmh7j0g+5qVrHiHpKdPFvuKidbHcMSEaeadefr2brS4S0sBE5bxW48oMHHMdwu8oXrMKRJgLAngX0hMbIKCfamBXG6Px+ZBD2WNqWT6wzASn9LXJfM2sBJCLWx/JJp1aXXV8/exI7eOXH/HKfwt0f06GSKocXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG/FEATAhOMNZcQ2jF0SvGGRkIGOUT6OcTPQ3NjN2Ck=;
 b=emFR/TzMPrZ0REFYQ8/Xeu8eWkCdueB9BM5PNrJo+Q118mYloQusZMshMNRTqdlta0yNevuL3So6KI8oF+2tdluWW3f6VUaq4lApDhl3Q/uDEFtwt0C3vowYZnDX5v2zh+oS97Rxn4AW8gltXh0eg/vbJraPhQ64MRd2WjdWJjqkDJEcxghfaJAxPIjlapRHh5Xu+Gl5NwtLrB7HlOlGJlVtKhyCHj1tZ9rlMlRI20hv04EOYhsvLnjeF8HfBmwwf41Ur4nBY5jscNYNUf6wmAMRCVBkfWc3nE3y+/u1FlD4ih1MQPhrBNXtlHTyrAQMrBgGJanwlOOkrMOChDzhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG/FEATAhOMNZcQ2jF0SvGGRkIGOUT6OcTPQ3NjN2Ck=;
 b=iqiqNM1FqJAWCdk2oAL+dRYZBV+WKqKIUJZSZabTPB+5WRLUQkeI+IKtXvhQo/GdE5WLcptUcmW/dHRqFdo5rarxweUZf0o8XguJzz/sDu8kSGG3r5C63FXnKdXmTOX6SdukLqNILQ6LUFNsS/PuFXEovJHvQC32ib2bASDcE2g=
Received: from BN6PR03MB3378.namprd03.prod.outlook.com (2603:10b6:405:42::30)
 by PH0PR03MB6479.namprd03.prod.outlook.com (2603:10b6:510:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 17:38:06 +0000
Received: from BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a]) by BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 17:38:06 +0000
From:   "Per Bilse (3P)" <Per.Bilse@citrix.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Topic: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Index: AQHZBBlWhmTXSR3gVkWwTyVOnEbYaw==
Date:   Tue, 29 Nov 2022 17:38:06 +0000
Message-ID: <dc2c5f88-89c6-7a20-8135-d6650c5baf21@citrix.com>
References: <20221129150058.266943-1-per.bilse@citrix.com>
 <358e49fa-8ce7-67ce-8e0b-e523dee9ea19@suse.com>
 <92300a81-b97b-f5d6-e3e8-363d8a7d3742@citrix.com>
In-Reply-To: <92300a81-b97b-f5d6-e3e8-363d8a7d3742@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR03MB3378:EE_|PH0PR03MB6479:EE_
x-ms-office365-filtering-correlation-id: de35167e-fbfa-4ed9-ba2c-08dad2307958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVVTxUkHWuCmYY4e4IgHqGcsI9kfuGtk/LttqDjVIDtVZMsuUZ9RdBI4zFzUOv6meLFB08aHEKxLw4PVO5WhrDvOahoF17DzCu8KWidt4BMdSikRWl1p93kameNrCvUwTZ6S+ZXdKWBv6jNP+JdiEbtYLypt4zA61om1iyvam6f3b4s4qRKgAMs+iIXxK/L5z4s4HKer6t+aJxFIUnAdHKu6/F12cAQ1dbtj8YKeYJYHQge9HS86g652DiHFJQn+VSPmI8LxUWvnWgo8ydb4rbejSr5YYgMpLohTtyDamjGvi5VhLTBfq9tA8p8xkeAr9xA11gKT+NN9cuoSW065wIxDJYyxcFKFN1N64drXA1AQIl7YJc0mQyEuQoYliNZdRI1anSI8Jyf5AkWK3FneeiTaClN6buaJpxIlH2ZTntEeh6OJdpkJ/G2k9aKvLw1uXtPO0KUtT0aRntRRDVzr9FJZo5of1mGxT56DnFlxmUQXSAKQu6LoUt6NUCcdHw2Upvzggy+39Wzyfoezf4crsImzjANWpLOq2ghljzwZGe9opgLOcaQDLbz4EyBdKyVSWyhYN9DIs8UfabxcpidQ/E/A3X855Wfu2kSvAXfxwF1DeXmjOGQEn1luqLp1rYKblhcoDscllPQ/uoLrzs99s+q7BbKONqCxbFlcBoOgBcSja21/csQJ6CKFULtHQhAMHtDyTEfIosHZLilHOvVIPRMW8JF16EaQLZbZ2vghrn4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3378.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(316002)(122000001)(82960400001)(38100700002)(6486002)(478600001)(37006003)(6636002)(54906003)(6862004)(66946007)(4744005)(186003)(31696002)(53546011)(26005)(6506007)(38070700005)(2906002)(71200400001)(8936002)(41300700001)(5660300002)(31686004)(91956017)(2616005)(66446008)(4326008)(36756003)(66556008)(66476007)(64756008)(8676002)(86362001)(6512007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RFZDhYcjdVQzRHb2pJaE9SYmxPZGJZRlppZU1oSDY1UytkVklxaU5nY2xh?=
 =?utf-8?B?V1JBWWc3Rlc4TSttMjZiZWdFZEpvSjROb0ZBWXYvb1BWZTN2RU5lK3pGeEZa?=
 =?utf-8?B?NHkxTjZKbHdpVHhsL0xoV0NZQWJURmQ4OXE4eW8zYzdSYzJPQVlKTkRnZ0l3?=
 =?utf-8?B?ZWxLNzNXWjdDaFZCOGtjZGpFLy9GL05GZzlWRlFCM3ZJNWxVeEc4K2tqOW9o?=
 =?utf-8?B?Rnphbk5IZExhNnZCemZqTWE2RUZ3bzFVZWMzaW5qaW5IVVU3U1ozZE9LaVRw?=
 =?utf-8?B?eGhSOUlPL21EcjZsNEtLVTF0ZG1POVlPanN3cEsrRCtjdW05VW5MMDdTYkhM?=
 =?utf-8?B?blZXdGVYS041NFlESXJ4bEZYQmRocHNGQ1ZObitzSDE5UUlnNWxLYkhVNVky?=
 =?utf-8?B?ZVFMblRhZmVvUFVkSlBycElxaGw3K0tVcnV2aUN6cnhiTVI5ZXM3VlQvNW1m?=
 =?utf-8?B?dnRKUEJzK2s1ay8veFlpTlJDelowc2I3REo2VVdWUVVHbWliTERzRkxxa3V4?=
 =?utf-8?B?OVpUWUpZOHJTMVBYMUxFeXhXRXZIejMyc3dlUUFNTU9NaWRKREZSMXVWemZS?=
 =?utf-8?B?Q2Zkd0dremg3L2hPS1l6dDczM3VEbXZua01LcDB0dFVOYjladlFkRlVPMjFL?=
 =?utf-8?B?UUI2WXhqaFprdmg5TVBibU1qT0s5anQ0N05kSGdXQnhjZGZ1Q044OWJ1VTBq?=
 =?utf-8?B?Y0Q0OHB3eVh3QW9ObGlicHhDT1RQQ2NrWFptZmlIZE0vNmREdGpOb29QWlBM?=
 =?utf-8?B?eVl1SHVMWlVwZ2ovNnVzdlVtVkZYd3h0N0Yvb0FIN1dDSzZLM1BCN1RNdUsv?=
 =?utf-8?B?RE1YbWZXazlsQnYzOXhtWmh3d2V0Z3B3WVFVQTMyQ3VxbCs1UC9kbmFuTHBB?=
 =?utf-8?B?S000QUMwVmpWaStFZTFhZ0JKRHNiN01MWjlJZUEvelVCNXJBMzdCU24yZmd2?=
 =?utf-8?B?Znczc1lHSmI0MEkvMVVnYzZISkpNejZlRE5vckEvYXRKenhxeWdDRGFFWFBq?=
 =?utf-8?B?QmJyTmlLNUNpaG1TQ3Qra3ZLWnlJZHpnVUdGVmRNeFNIbm00b0FYWlJOTTdi?=
 =?utf-8?B?UjRVWlphRkN2eVhPWkdaZXVTNGhjK25OUXZCWFhPakF3elRlRm0vYnZ0dTI5?=
 =?utf-8?B?cVoyRzhIaG80YmdnajRCY1dOcXJIWmhmUHJxL2Uxd2lsYTFIcC92TTNwZVV3?=
 =?utf-8?B?RlZDWCtwNHpmRmw3alhoa1VrWjRjZUpPcG1Tb1RKTHMybDM4K3NVMXBwQlBF?=
 =?utf-8?B?UjlaaWhYOEZXUHVtNUJuK3NwTk5OK2ZtcU02UUZhdzJzRXF0cXc0Ykl1UEJt?=
 =?utf-8?B?d3Jlejl2Y001N1NyQnp2eTVkNFMwL1RQREgrU0QvMGEvbkhCTlZQWEpLb29K?=
 =?utf-8?B?QVpudHI1ZGlNR2E3ZElwQmdNQ1h0SlNybzJrcVd6Y2ZtQlY1Vk9OUmFFc1Nm?=
 =?utf-8?B?L3RibXozRFBZOElqbXB4ZzAzd0JkcEFHQzBKV2dmZU5XNGxiOXVVdVR2VVlG?=
 =?utf-8?B?RGl4cUptRk5IN0dCOTZzY00xUjlqS1NWclQ0bUhxNzNqZU1kWlBRNU42Sk5p?=
 =?utf-8?B?Z0M0OTlJWVN3dmt4V2ppcUZ1aTNkaGVKUThqUDdJTFB3N3Q3TU95bEJHUVM0?=
 =?utf-8?B?bmMyWU5PWkwyeDh5RnM0M1FkSzMwZjc2bHhtUHJzZjFldityMW9kb1M4TVM2?=
 =?utf-8?B?Zjk0MmdHY05kM0V2VG40eUs4Z0RRS0ZtOWk4c2tkNFVqSmpxQTdDMXZpK3V1?=
 =?utf-8?B?MzB6TmZObnFHQ2hhUW4vNjY3dXJ6WUVHWXA5c0dsUzRmcDZZNGY4V3pSUEJx?=
 =?utf-8?B?TUM3WlkyR05CQk5ySmhGSXhxUFYzZ1VXSzRSYTJkVWk2cHRjTnprNWV0ZGho?=
 =?utf-8?B?S043YnR2eVVYQXF6WTBLdlFlSS9aZXkrYnVhbjVWY2tIcVE3VGIrVHZGTTJ5?=
 =?utf-8?B?TnZDRmlUYnYxWnZvK3F3TkxqUmNUUXc0ejBGbGZtSjB3M3NUd21tR2NCWWxW?=
 =?utf-8?B?ZlFnOFNabHdicjFTcHJiUFV2OWJZNnFiWndCZ0Y3TW9PbXZObG5XTWI3ZE53?=
 =?utf-8?B?VnFEcU9aYjJGa0lxWmNRSXZKVUlybTZRdUJhOFF6UURjdktmN05LL0gydkdy?=
 =?utf-8?Q?pP42STxCmaHRNt5eR/vtSTn1Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC79FA58A7F5348BF3490F3CE9F589D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDFtZHVXWGQxTXFLa2dmdGZBU1BZSTM5eDFwMTlpQndnMlJGbUwxb2tYaEdS?=
 =?utf-8?B?M2MwMG5xdVhiVGJic21WWkJ6UWp2NEZTd2dJemt6d3lXM21oMjFjRXpheGRh?=
 =?utf-8?B?ZjNtTEt4NHdtZzNhbnJiQTRSUzlrcUJwOGQ5NjFMZEVMa1R4ZmJESmU3MHdD?=
 =?utf-8?B?S1YwNjRDRm5GWmtYNGd1NlVPMGNZZFRGcEFPd1p5Z2VHQWlBckp1dFc5emVz?=
 =?utf-8?B?eGZseXN2ZWlvcnMrR2RVV0U1NGMrSVo2S042eVRwcVhHZnM2TURmalgrOCth?=
 =?utf-8?B?dUlVUW1tb2JmOXM0WTVOWDBmRDRKWDlpc2ZYc2pyOFpIRkJ6RERQUDYvZUNJ?=
 =?utf-8?B?cVFrOGNLeHRkU0M3dWRmWDdISlJISzNTT1hibUZCUVZoZ3FzL2FSaWJabDMr?=
 =?utf-8?B?ZGFWMWRscHZ0cVFkODhaKysrZDVDNjVTK2JITlZEem5qOGxJR0xXZWJtZkF2?=
 =?utf-8?B?V2laZk0wc0dYSW5OMi9XRmRLQzYzWUUvY0ZvclYvWWJxeUdrbWkySzhWOTRM?=
 =?utf-8?B?N1BiWVRvakQraElSSnVTVm50cGpGVFY3ZXcwUFhJM1MvK3A0KzE4b1FqQWsz?=
 =?utf-8?B?S1JIRE51Ri9tanNZcG1Cdm83ZWlFS1Rpdk5nWnhBVWJ5MmczVHZRM3dGeXlT?=
 =?utf-8?B?QkZFdHBvTyttZG00WEFFck5tVFRRMTdncUo0ZnNUSkNOSHZPOGRyWm1LUzk1?=
 =?utf-8?B?SzFINElVemgzWFh3bkpZSExlVzZ0SkM4NFRhUlpUWDNMeHlXa2M1MjlIbmFj?=
 =?utf-8?B?cFNBa1JuZHYwRUc2WkZOa1F5T21uc2dTbk9qdktXWHBLRnlDZDZzVUZKN1NE?=
 =?utf-8?B?Vitkc0dyanR3enB2ZzI0QWpWcXJUeThzVW1Xc0RBMHhLOW80UEp1ZWFteGJk?=
 =?utf-8?B?UHdHakJwTEtQU2dBWTQ3ZkY5ME1XM1hXNW5idHFzUlhkVDc5czlxWVRXTjNZ?=
 =?utf-8?B?U2FnRFphVEwrc05QSk5kUG43ek5uZjFmRmdWMHNvQ0krbWVGSjZpa04xVi8z?=
 =?utf-8?B?dFV6N1pTMVNLbElVM2tNY0FkdzhFV2EzWjNIYzRLMXZNenJFZTJnSWR2NTNC?=
 =?utf-8?B?bm0yOERsYWhiQ0tITVpabzBPQld5amZPM2RVdmF6emxsQUFGR3hETUVXQk8r?=
 =?utf-8?B?cE0zNUpKc1RLdkh6VUtmWVhjWkpwZFB3RkYrRDRuc3ZOZ043Mi9NK1VVbkhn?=
 =?utf-8?B?MzY0VW53aUpLQTFGRHV4aktLT0JJdHhqam9ERUd5c2NWTVgzU084OWpNYmZY?=
 =?utf-8?B?WTUzQmtqZ1dYNTBvSWlHTTg2V1llUEV6MzlOQzh5dGZ0bGZRZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3378.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de35167e-fbfa-4ed9-ba2c-08dad2307958
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 17:38:06.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOfrg8Xwfc2S7bNXPAGzZfglcxcLVDQBqaqQqojYNmygJ7nlKyJzbUidL3km5ZaZhW7Pmjbkqd4YX21GsgX39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6479
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMTEvMjAyMiAxNjo0MSwgQW5kcmV3IENvb3BlciB3cm90ZToNCj4gQXMgZm9yIHRoZSBh
Y3R1YWwgZmxhZ3MgZXhwb3NlZCwgaXQgd291bGQgYmUgdmVyeSBiZW5lZmljaWFsIG5vdCB0byBj
b3B5DQo+IHRoZSBleGlzdCBwcm9jIGludGVyZmFjZS7CoCBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
ZXhwb3NlIGEgc3ViZGlyIHRoYXQNCj4gaGFkIGZpbGVzIGNvbnRhaW5pbmcgYm9vbGVhbnMsIGJl
Y2F1c2UgdGhhdCBhbHNvIGdpdmVzIHVzZXJzcGFjZSBhbiBlYXN5DQo+IHdheSB0byBmaWd1cmUg
b3V0IGlmIHRoZSBwYXJ0aWN1bGFyIGZsYWcgaXMga25vd24gdG8gTGludXgsDQo+IGluZGVwZW5k
ZW50bHkgb2Ygd2hldGhlciB0aGUgZmxhZyBpcyBzZXQgZm9yIGEgc3BlY2lmaWMgVk0uDQoNCk9L
LCBJJ2xsIGRvIHRoYXQgaW5zdGVhZDsgSSB0aG91Z2h0IGl0IHdhcyB0aGUgc2luZ2xlICJjb250
cm9sX2QiIHRoYXQgDQpzaG91bGRuJ3QgYmUgcGVycGV0dWF0ZWQuDQoNCkJlc3QsDQoNCiAgIC0t
IFBlcg0KDQo=
