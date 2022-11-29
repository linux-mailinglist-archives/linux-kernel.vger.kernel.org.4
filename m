Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2063C5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiK2Qwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiK2Qvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:51:49 -0500
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E107EAE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669740457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wiVejkUtTCvISePLPLgmBAkikBqZPO/chuk88Ngyh1w=;
  b=KMSKk9+mTH3/hzNWcTDmg5ufncYQVJbKFdnaWet9Xw2JPdKNgkP4IryO
   573VS4ZaeoU6J1a3qnHOFQ5glEdxkWeVlfd68UYWM1icFzgcGaxC2y4h/
   GHqmhpaZMr8rD146ifL/W97rQ/gx0V0T3YfBN9OjCI6SqSKkkBDwZIs56
   M=;
X-IronPort-RemoteIP: 104.47.55.107
X-IronPort-MID: 85351291
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Cf67aq57EkGG/HfEO8nutwxRtKXGchMFZxGqfqrLsTDasY5as4F+v
 mYdXj2FbqmLajDxedkgb9m+8U0BsZfVm9drHVFl+SE9Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraBYnoqLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+4pwehBtC5gZkPKkR7QeF/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m1
 941ODMXTzC42+uMnp2eVulWpOIzM5y+VG8fkikIITDxK98DGMiGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooiOeF3Nn9I7RmQe1tk1zej
 GPC5GnRCRAGLt2PjzGC9xpAg8efwHimAdhDTdVU8NYwuE+znm5MESQYfnuZuumyineTY/dmf
 hl8Fi0G6PJaGFaQZtP6RRyj5nmfogQbRcFTAsU98giGzqeS6AGcbkAATzhceJkludUwSDgCy
 FCEhZXqCCZpvbnTTmiSnp+Woim1IjM9NnIZaGkPSg5ty8L4vIg5gxbLT9BiOK24lNv4HXf32
 T/ihC86irYIhMgHzZKn7EvHiDKhoJvOZgMt7wCRVWWghit7boO4Y42j6XDA8O1Nao2eSzGpr
 HUC3sST8u0KJZWMjzCWBvUAGqmz4PSIOyGahkRgd6TN7Byo8n+nOIVPujd3IR4xNt5eIGe2J
 kjOpQlW+ZlfemOwarN6aJ6wDMJsyrX8EdPiVbbfad8mjoVNSTJrNRpGPSa4t10BWmB2+U3jE
 f93qfqRMEs=
IronPort-HdrOrdr: A9a23:GRcMLqjujDN9bXOBx+RDLE183XBQX+t23DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICRF4B8bpYOCUghrTEGgE1/qu/9SAIVy0ygc578
 tdmsdFebrN5DRB7PoSpTPIa+rIo+P3vJxA592uqUuFJDsCA84P0+46MHfjLqQcfnglOXNNLu
 v52iMxnUvERZ14VKSGL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftxK/mHwOe1hI+VSoK5bs562
 DKnyHw+63m6piAu1Hh/l6Wy64TtMrqy9NFCsDJos8JKg/0ggLtSJV9V6aEtDUVpvjqzFoxit
 HDrzopIsw2wXLMeWOepwfrxmDboXkTwk6n7WXdrWrooMT/Sj5/IdFGn5hlfhzQ7FdllM1g0Y
 pQtljp96Z/PFflpmDQ9tLIXxZlmg6funw5i9MeiHRZTM83dKJRl4oC50lYea1wXx4SqbpXUt
 WGPvusoMq+QmnqKEwxeVMfhuBEa05DWytuhHJy4/B9nQImxEyRhHFoufD31k1wiK7VDaM0pt
 gse54Y641mX4sYa7lwC/wGRtbyAmvRQQjUOGbXOlj/ErobUki93aIfzY9FkN1CQqZ4u6caid
 DEShdVpGQyc0XhBYmH24BK6AnERCG4US72ws9T6pBlsvmkLYCbeRGrWRQriY+tsv8fCsrUV7
 K6P49XGebqKS/rFZxS1wPzVpFOIT0VUdETuNw8R1WSy/i7Y7HCp6jearLeNbDtGTErVif2BW
 YCRiH6IIFa4kWiShbD8W3ssrPWCz7CFL5LYdjnFrIoufYw36V3w3kooEX84N2XIjtftaFzdF
 diIdrc49CGmVU=
X-IronPort-AV: E=Sophos;i="5.96,203,1665460800"; 
   d="scan'208";a="85351291"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 11:46:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra0PhdrNkoj70ksSrOEqOBjEgCYywdihXyokdtfXowydJughc8V1Pm0aQ+ucRqWbRdHAXOYWFmNd7kLRBM1Iihh5HlCRMxdYWiQA13FuWv153G7VtcQfh/2+P3yTpUHQo31SQhuKmVhtBoDqYbzjRE1sa4d9LUHOqHOl/gTTt05ky8ev4CvJK19HuBs2vnPcCl2SyCVSIoT5pc5gEhFcWY7FMr4YCEtMQo8/ch8HK/OZVIRPM2GfGvwRLHdMzm0dOBA/aaHq/KmiZ+WId2s72tqixlF2RlIEIVxSdJpsCTQfvK+7AxF/VYykAi4qyjE3yVFj/7qufa4k09usFcLOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiVejkUtTCvISePLPLgmBAkikBqZPO/chuk88Ngyh1w=;
 b=B+++f5xjUoG84a/muAV5eIPMfVHMMoB3TTlZHAp7N84bhUGQG/3N9vTR9s1EVsdUGN4vi2Or/yCcwNU63pgD56PVaaxXwhXQAzyUAiiT+5mJaUAgPiB17NNp/FWGOQq5NwkU0UWDvkwIpdmURRFnoNfVRgN78fBWsGW/5Jp2s96fdhsKn+yTN/wnKNPPKYBn4LtZ2qo64xdC2z63chmkmu2xY2Lcpe6S2ReiFtZ6Yi/SZP9zjZ2yYzkpfwIaHEfor5/1yBlBDnVJoTRIf563WihGnlWgULK0Vh8h85ApOrTwepvBODBuram5NtxWAjz9LE9LhCqjsfYUuWOdKtWfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiVejkUtTCvISePLPLgmBAkikBqZPO/chuk88Ngyh1w=;
 b=OThitF3CVMcroS1w2EKTtyFrUUbE5vh/Si+bgVzQtV+TMrd0+e3EtLpTsCHruGr0Ev/DHTDf0Jqg8HTBxfJS6w82JhgvxDJqvdrtYpOuPYdqY2egWMGhwgyWuaViLI5VXF1ibIeR3dMRqzPBDNDwI3//lSBTmlGM59C2nW3Si3k=
Received: from BN6PR03MB3378.namprd03.prod.outlook.com (2603:10b6:405:42::30)
 by SA2PR03MB5900.namprd03.prod.outlook.com (2603:10b6:806:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:46:36 +0000
Received: from BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a]) by BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:46:36 +0000
From:   "Per Bilse (3P)" <Per.Bilse@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Topic: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Index: AQHZBBIkhmTXSR3gVkWwTyVOnEbYaw==
Date:   Tue, 29 Nov 2022 16:46:36 +0000
Message-ID: <34f726e7-461e-b4b5-96bb-5f934c4d9dbc@citrix.com>
References: <20221129150058.266943-1-per.bilse@citrix.com>
 <c8c13453-c453-7de1-ae07-045064a938b8@oracle.com>
In-Reply-To: <c8c13453-c453-7de1-ae07-045064a938b8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR03MB3378:EE_|SA2PR03MB5900:EE_
x-ms-office365-filtering-correlation-id: 6040e924-3510-4f58-4f9f-08dad2294791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShBcLV5UqlaL2tmVQomv3IGjwXuM/kx+3Pdmeo7H8LUgR2bAJKSLzPtDMurYaZhiEq2KTBk/yCqYIZoQWFC+NQase6S3TSiDqoahkYeFpBfGDJ/Yrh+5nwoOFenZuLG42xiuOQaw3D1rySQOIGRGdVkoLqQ2wcv/d4ogZJFo9W0vzSA3vSISPFUODb3FeUrp/WiaY88lqUEv1UzJ6AmZasuijClJiU4BzU//G487H18ApKxN4ecfY3uy/3IurDsNzzSWvw7TjpvEWu7nHvPKMqHTbTI9Y8zeBVndREtEVGQjNuwqCtcp0yMow6o7LOtFyz3G5IgzriCHk0KZPnLN8UuKC6p6sb208A6F2oZ3bdDX2F1BkAyAV7MFYc+KeKb0uKiD4CJrl8CpZC3CGCKpaeTe0JYV1MWCplrITkm5pm0ehks5V+8IfCITMCo3/G2jE7L0LydvnQD1d8dW3rM/+n/ZDxGHd5Ilki+XBIKbo+aqI4xH+Rcbllwhq747OmGBHdHXUDUrLDin0i2mXflQeUQQkq07smdI7x8yMlLE6bpJYKY8nCbuPg9uWQGYHvJSiUaL4mIVkf1Ub/6fstrLfIiXttwBIst6uPl3YQyeSYZRGXRCXIYWry/ca8jgfIzR3Yb7/tt7WLStsRYKs4z/8M55rRF2x2YJjl0eKAXIxnRLhSmcU7OgCws/8QlLYK40iHFjzZBZFEZ1/o+umnvh6BqzvX2LH+aUDdZRdIUGeuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3378.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(2906002)(82960400001)(31686004)(36756003)(4326008)(41300700001)(31696002)(86362001)(91956017)(4744005)(64756008)(66446008)(66946007)(76116006)(66476007)(8936002)(66556008)(5660300002)(8676002)(6486002)(38070700005)(316002)(38100700002)(478600001)(53546011)(122000001)(26005)(6512007)(71200400001)(110136005)(6506007)(2616005)(54906003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW8wN0lJWDhicm1iV0U0ZGpzY2ViakFEMG5oSk40MSsyY3B3QVFKd0M0UVR3?=
 =?utf-8?B?Y0JsNDg4b0lpMkx5a3F3RDJSWW1saTNHK2ppbEwwUUN4MGNlRWxPRzdMeE5P?=
 =?utf-8?B?SzdSUzNvUmFVRmhpS21LZldRV3d5UUNuNm52dktyWlNickFzOVJ2YXRmbGdQ?=
 =?utf-8?B?RVEyU0M3UURmalNTbFVIMTJQQnBwSnBxbWJ2b1NUbG5ZdnVmUlpZWmxPa3VX?=
 =?utf-8?B?WW9HTGxlYmFZV1FzTDFwM21PdklwUDBIM0ZtdVBMcDdSQ2JQbnJhZ3FxYkNW?=
 =?utf-8?B?MVVETU9GRFZEbnRnS3hIZ3BlSjZVcjVzNHN0RlNUQ24yQ3VDSmh2NDBwR3pu?=
 =?utf-8?B?bFZ6ZVNCdFRPQ1ozMWxjZWUxZTNRaVZ2Y2pET3QwZktyS0NEamFPbG5Cc2xF?=
 =?utf-8?B?alF2RmpNNmEzU1VydVp2UTVpbVBlSDNJY3RhZjVwb2JmYzJJTzg0a2dKYllJ?=
 =?utf-8?B?NUlIdXM1cEZ1NVhBZzQ0Yy9zcDJHNHY0ZHcramZqajlQVE0xU0l3V3VXdlhU?=
 =?utf-8?B?N2hlUUtVK1lsODE5TnN5T01FeU84eU1XLzJneWZEMEQ5czE4Ulh3LzRxUkds?=
 =?utf-8?B?UFVubzhIVm95TEZSai96Tm05d2RXYUFBbDlmY2s4Q2VTZ0NJdk9xTFhnVkNB?=
 =?utf-8?B?Kzd2R1FmdE5DV1QzOGY2dzJ0QnIxaWp1N01hT2hGVzViOGY2QTdack03SFF4?=
 =?utf-8?B?N2IzQk1ldWtqV3hiZ3R0dWpacUlIWjgzekZFR3Qya2ttWmRKd2JrVmlEMUFR?=
 =?utf-8?B?N280OXZUdFUxY1pFdmxNckJ1aDRyOFEvUkhIN2VGUTZpdndrZVNkZHB4L2hs?=
 =?utf-8?B?NDFzSXNDNzl1STFHVFpZdG5Cbit5L1dEU0pWOWpWL1RUTFA2T0FhT2szc2Vl?=
 =?utf-8?B?WUFuaEpEMDdJckhEWWhydW5EbGlGRnBoUkZJSjNWTGZrb3dweEJhNWg3T2dU?=
 =?utf-8?B?UkthNEVuTWpkam5rRkpHejRMampkTm9hU0kzcDlaNXgyb2ZGSUNwS2w5aEJ3?=
 =?utf-8?B?cTJIU0VscGYzdTRRWDVZUmhMVWVDUE5GMTlGbW85V3J4Ym5IN01uSGJWUmFj?=
 =?utf-8?B?bWhwMzBrTEg3bS9WaFpVL0hJYVNsR1RDaTVXd2xDckh1WWFFWFdpY0VCai9B?=
 =?utf-8?B?c2dEKzEwTENMRDl0QUl0SHlGNXhjU1pIaFJuWTVNN21SWVdlcHErMlUrbS9u?=
 =?utf-8?B?R0cxZXZ3UWVUeXU2N1Y0QWQ1SU56MXJCejdOcURaUktmNzBEMHc0VFFQRGtP?=
 =?utf-8?B?TzlqZ24vOXVORlZ2dTN0aDRQQllRSUk0bFBmZFhBaVY0TjUzcWxrdU9OMHZU?=
 =?utf-8?B?SjVvbVl4LzJma2VmZXJIemdPOHMzMjZMbUNQdEhkSmxVVFZPRXdINDZwSWt5?=
 =?utf-8?B?dlZ5N21BVHU3U2gzSEN5Vy9oZXdnUDFmSEZqSk1tcEJuSWpOQ0JlZW9kYUsx?=
 =?utf-8?B?eEF4bEw2ZGNHSTY2NjBPYkVaWUh2UThHM0NyUm1rcG9oZkpJZWRXYjNMQVc0?=
 =?utf-8?B?Y1lIVnNnN3d2YmJQbjdPTEJHVWhMMjF4SCtzZTlEOVIrNHFMcGxKb0xtWGhM?=
 =?utf-8?B?UnQrRjdkd1VEU05lVnV2b1FPZ25GcUE5MzJQSHdxaTc5c0t3eHQ2Z3dQNmJK?=
 =?utf-8?B?VUYvaW4rOUU2LzI0M1hqQkVMT1lPNlRxOFY0M1o1U1JFVlU3ZGM2NWxxZGFm?=
 =?utf-8?B?c2dLaTlnTzczWm50U215b1h4VFdRbmpXQkE2MWxaTmt4L0MvckQ3Y0ZqM1Ay?=
 =?utf-8?B?cXhHckRuNFBYZlY0RDF2dUhaTUs0ZGtQTUxUakxUQ1pMRkYvcndtcjBFQVQ0?=
 =?utf-8?B?bjNQUmIrZnlPOVI0ZUdadGFuWEpndmY4bjBnb043djVlRmFmRjIxTFg0djgy?=
 =?utf-8?B?R1JMOUd0RjhuMHRxSThZNCtKM29wNU9MeXl4WmVEUUxzdVBNdCtwSnJQbFRR?=
 =?utf-8?B?TWdtcHlzQ0NNRklJWTNGUTgwWUtOeXBGV3R0N3ZyUFVPQWtadnRxWHBnTGVi?=
 =?utf-8?B?eG5NL3Y2RHgwbmQ4SHdhTlFGemF1RTR1T25XcGRJdHFMV2crNFBmRHNnU0Y1?=
 =?utf-8?B?NWJUMGdzWlJ5NlJvanZtSnVLSlowdURnZ0tEZDBWNTNsZjlzYU9tNFBQVEFJ?=
 =?utf-8?Q?GsyB8T4SppGY7Ae2lROo6tbsx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE434CA1CDD314EB40B057AE335BC2B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ni9pam1Gb0hwdUpYS0JkaWVKQ2d2TkVDbWJSSHZxLzUzWTZVMTk4U1dCSEdh?=
 =?utf-8?B?Q0FjQUlJbnY4QmtBK3NHdWRYVVNwYjRxaytHQVE0NFI2S0JmZ29oQWdJdlB4?=
 =?utf-8?B?YktRQ1A3a3NZY1JkY3JNcEV5RmZNYm5pc1pBemY4SUI2cE5QSkNLT2V3cXY0?=
 =?utf-8?B?L0FoSHRpSnBUWFlGU0haWW15T2E4RUdLbTc5ZUNienNDcGdpQXdYclVaOEhP?=
 =?utf-8?B?RnlRMFhRd2lPY0V4QnJZbkJXZzJKb29QVGNmR29HRUhyT0FvemVzVzZrMHZT?=
 =?utf-8?B?dFBLb2JiOXhHV0ZDYS9tRzdkOXVSSHZEZVlHeWRNYjE0SktXVHFBN05vSldH?=
 =?utf-8?B?OWNVVmxlOWRBbGFaZ0VBRzR1Sm92VzkybnJ0emtJSStFUlVOODMvb3lFSXRX?=
 =?utf-8?B?ckpwRW1jNUpPZTZTSWJuQ0MvMmwyczJVZkc2ZlhZUXQyREU1NkJpblNIVXdW?=
 =?utf-8?B?dGtqclkxSlBITktWMVFxQTdmYmk0TTRJWHlBditCZFpEYmRPbFZxZFZwUDh5?=
 =?utf-8?B?L0FJdUwyenNkam1OT1Zza09iTzcraHUyRDFod3FRVlpIT0YxdjRQK1d4bExQ?=
 =?utf-8?B?MmljR05telJQQTY5bFZwOTg0Z05HSnBYZzFLSXJpVEFrQ0xmejVuanJjajd6?=
 =?utf-8?B?dFZkZ3hMVjlZdzhieUpHMjNBaHdIdmxTM0JCUkpYQ2swODh6NHpFb21nTUp2?=
 =?utf-8?B?cnd1L2NQaXVidGdNWkdJY0ViVW9SV09qNnkzbWhGeXk1eWIyVUNoc3p0bXpk?=
 =?utf-8?B?T2VTNE02azdKQm82M0JNcTVJSEtHdFlPYzdwdkNsdWVrNWhUYlNyU1BGaEhk?=
 =?utf-8?B?MFRTSksvK1R4YXQvV2pwUmdnMmtVV0JyeEhEeFhsR1BwUDdPcXYyc1ZMNk5i?=
 =?utf-8?B?c2RwN2RtZTl5YityV1V1S3hVZGEwNjdFcG5KbHpHNmIyd2VOZDViTGExVUMv?=
 =?utf-8?B?bE9ZbUhLbWVaT0RUeHQwYjc2Qnk5T3ZlK25tREVjamVXc3NJYzNVMWhlQnJu?=
 =?utf-8?B?TkNaM1haR25XZTZsZjV0UVVJSUhvNk9xaUZzWW12RHJGL0d0dEZhQmJoR3N0?=
 =?utf-8?B?RmNtSDZFYWxJZ2JvVkZmT1FQYUpaOHhiSXVneUtvQVNCOGJPQTcwVEZMYnJw?=
 =?utf-8?B?Rnh3NE9zcmx3aW9qNDdFTTUzdkh4dzVhaUJzTWo2cUFYMDBNUzJHTUx1T2Fs?=
 =?utf-8?B?NEpOZUowTXpMSjhHaHVIazI0Mnk4aThnSWZIZENUVzBlWUdyT2RNQ1BxOWZW?=
 =?utf-8?B?d2wwSzRGSWZVU0NkZ3JMdjFObmQwQXpCNGpTMkxvbTB5bUlUZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3378.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6040e924-3510-4f58-4f9f-08dad2294791
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:46:36.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4uvJ+Yz14acIsz+Jpi6I+f3zqG8DZ5Dr6v77RbWB/P/dhEEXOfAMhbmHs1mU+IJS5WlQoC+7FTemvh4kDSUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5900
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMTEvMjAyMiAxNjoyOSwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiBXaHkgbm90IHNp
bXBseSBzaG93IHVucHJvY2Vzc2VkIHhlbl9zdGFydF9mbGFncyBhcyBhIGhleCB2YWx1ZT8NCg0K
UHJvdmlkaW5nIGEgdGV4dCByZXByZXNlbnRhdGlvbiBmb2xsb3dzIHdoYXQgaXMgY3VycmVudGx5
IHRoZSBjYXNlOg0KDQpbcm9vdEBsY3kyLWR0MTI4IC9wcm9jL3hlbl0jIGNhdCBjYXBhYmlsaXRp
ZXMNCmNvbnRyb2xfZA0KW3Jvb3RAbGN5Mi1kdDEyOCAvcHJvYy94ZW5dIw0KDQpUaGUgbWlncmF0
ZWQgZm9ybSB3b3VsZCB5aWVsZDoNCg0Kcm9vdEBkdDkwOi9zeXMvaHlwZXJ2aXNvci9wcm9wZXJ0
aWVzIyBjYXQgZmxhZ3MNCnByaXZpbGVnZWQgaW5pdGRvbWFpbiBtb2Rfc3RhcnRfcGZuDQpyb290
QGR0OTA6L3N5cy9oeXBlcnZpc29yL3Byb3BlcnRpZXMjDQoNClRoZXJlIGlzIGdvb2QgcHJlY2Vk
ZW5jZSBmb3IgYmVpbmcgbW9yZSBoZWxwZnVsIHRoYW4gcHJpbnRpbmcgaGV4IA0KdmFsdWVzLCBi
dXQgSSBoYXZlIG5vIG9iamVjdGlvbnMgaWYgdGhlcmUgaXMgY29uc2Vuc3VzIHRoYXQgYSBoZXgg
dmFsdWUgDQppcyBiZXR0ZXIuDQoNCkJlc3QsDQoNCiAgIC0tIFBlcg0K
