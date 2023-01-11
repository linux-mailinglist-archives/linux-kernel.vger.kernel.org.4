Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7B665A81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjAKLmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjAKLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:42:14 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 03:41:08 PST
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73419C24
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1673437268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Npg4FEh7fyagYb+edMrpBphe4PX+wjiTOlTdbORlpiw=;
  b=LJzv7xkZr2XkAPEc9j6halihyaccUsYtRCPcvx+GgpKSJj/N1GqvmJHk
   qTuMbqt9MleRQNZ0NkRnH12IfW2ViZjK+RWoDe24SQljb5ttUz3aSi+Fi
   DaTpAROrqrlxLHNH0IzPI4sjetFG7HOvSceaLSwgnbQyKBYdgZLsUMJpr
   I=;
X-IronPort-RemoteIP: 104.47.55.173
X-IronPort-MID: 91581756
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IpC0JqMbyQodUq3vrR0QlsFynXyQoLVcMsEvi/4bfWQNrUoi3mcCm
 DZLC2vQPffbZzfwfI92Ydu+8RkP7MDWyNdmHgto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQA+KmU4YoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGj9SuvzrRC9H5qyo42tB5wVmPJingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0qFLAUp02
 d1AFGAcfjWInNKMxKyHVOY506zPLOGzVG8ekldJ6GiDSNwAEdXESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PdxujeIpOBy+OGF3N79U9qGX8hK2G2fo
 XrL5T/RCRAGLt2PjzGC9xpAg8eexH6rAd1PStVU8NZqsAKU+mZQFiEVUHm3mt6yrXPhQo1mf
 hl8Fi0G6PJaGFaQZsHwQxCislaFuBAGUtZdGuF87xuCooLW5A+fDHIZQSNMctUjnMAzTD0uk
 FSOmrvBAT1pra3QSn+H8LqQhS29NDJTLmIYYyIACwwf7LHLsNFtphHCVNBuFOiylNKdMS3/x
 yCiqCk4mqkJisgKx+O38DjvgT22oYPSZhUo/QiRVWWghitjbYCsaoiA6lXB6/tEaoGDQTGpr
 HUC3sST8u0KJZWMjzCWBvUAGqmz4PSIOyGahkRgd7Ej/Tmw/3+ofahL/SpzYkxuN645lSTBZ
 UbSvUZb4s9VNX7zN6tvOdvuUIIt0LTqEsnjWrbMdN1Sb5NtdQiBuiZzeUqX2GOrm08p+U0iB
 aqmnQ+XJS5yIcxaIPCeHo/xDZdDKvgC+F7u
IronPort-HdrOrdr: A9a23:aMabnKi4ttMCk/3wriADwlyW4XBQXh0ji2hC6mlwRA09TySZ//
 re+sjztCWVtN91YhodcL+7WZVoLUmskKKdgrNhRItKPjOWwFdARbsKheSN/9SJIVyEygc379
 YFT0ERMqyWMXFKyevBzU2fNf1I+rW6GaaT79v2/jNWYTsvQYdGwCdWNj2yL21RY019KadRLu
 v+2uN34zWhfHgMbte2HBA+MtTrrcHQiZTjbQUnKnccmWuzsQ8=
X-IronPort-AV: E=Sophos;i="5.96,315,1665460800"; 
   d="scan'208";a="91581756"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 06:40:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9z0banVAMugsDsjsV0tOampXUeLXbTxzTf1kK7yOrDGo4UTiVNUXQSLuT+uqjTEmU3Hb1XLRVOfb8A9/LJqSBXJ0BJu32KIHrW8WO4B7UY2OfrdngNxNwNIuiM5viXA/FaMRWEpUGv7Ks1UU3q3AeE+JBH+QZ+weidcSBRn7btv3PettSk+wjkILIib8xNSao4l7spHfKbaaqMzvv2WSXnoQgxIvM0aNItLIg3VbRNs+UlDFUoCdpi2eloKZz6fmrlYy60SuzvWCtGLw5COWuzzp7Z61HOrqDggcl+h/5X8vBUo5YgNqPCEdfk9ukzadDuW3uufftELXDnF0gqXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npg4FEh7fyagYb+edMrpBphe4PX+wjiTOlTdbORlpiw=;
 b=NcxYxjRIVWzXsBw0/rCBpVQB7SQ9K8QFdojr88LyElAi2sH6mN8POPc8zICX+CGUy5LYPES6ia2L1P4KYOgIcj9cVqw1Tz39C8fEb1VbQA8gT9VISI/Y1PTBRJR0NNoo980uqW3CRuczC3HQcMe3TZVXE6z0rY1IUuOfvzu39Fz2Rqnm7ODfT6iOjCg2aAgXJfx2rEA/wyknqtMciDbWH9VMC1bUUsbxP63S85Wjd9C+hzLTwTnxZhU7w8Ahc6J7VI1h/cnGeemYlb4iJdaSK7iHPHYa5v/NwOAHKdU+eGkzIKHIE4FdqX7/Az9A+Fbfh0nmIoYBX1ndohQw7XTBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npg4FEh7fyagYb+edMrpBphe4PX+wjiTOlTdbORlpiw=;
 b=U2imVUrVMzCxLd6YBSraBivx2FPpHGJ52JzzUkTpluQYmihxnwtTGXQGnbfQsU5lD9r9YZNdl3wXgXQv7GJeKSJFpmgZrnW8PshUUbtYOzof7gDAVIO531UUrqKPc0+1zKEZ/7GKDxMrZ0QHaKGkDRI145IihAAbPI84RVqXF9Q=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA0PR03MB5402.namprd03.prod.outlook.com (2603:10b6:806:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 11:39:58 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 11:39:58 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joan Bruguera <joanbrugueram@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Thread-Topic: Wake-up from suspend to RAM broken under `retbleed=stuff`
Thread-Index: AQHZJa6+C7zgK+BmnkyxcC0/cTTk966ZF36A
Date:   Wed, 11 Jan 2023 11:39:57 +0000
Message-ID: <aefed99b-6747-5dcc-65ec-6880f7c0d207@citrix.com>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SA0PR03MB5402:EE_
x-ms-office365-filtering-correlation-id: fa5edb11-4719-4c3d-2944-08daf3c89113
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlpLLYxC/5fSK0lPqZH8Ueh9UtfVynvOyoZdJlLi8fHDuvQA3Gm7OSgiR44CV3cLUM6kRyykRnp2PMfXnlkGvTZRwQ/3+nelIdo1/MLuoGDbu7bICdfVn/GYEkK1w/nxJqT5FmK448DypO+Wid9QJPsJhYCpv8CdU4NOyfd5MQ9GZ5acajOPZCGJGwpei24x0tJVI7zO2sbQvo7PvoBm8fAyswvVPNKyyt97sPFiR2GUtndefFSHYvu+KRuJ2zgzbjSHYIP6JfWag8jEQfIcjOpvXpKrVV5ULrQzMpfHwpzEDLDxNdhi8EdQrUR7pLOAwJcsiaD37JaMl1P2X+uyYfUBEIQQyXeixY90s3CqXylQERED90afvimrwl+HPDegLeA1t9+HmUAp3/JzOTJzJKpXgY3SLDrFvp2HKBNfyToHlB8FjXy1iw9w4I+FWbk+RAv3+NCx+K5bUPQo/cVkfpi8RWLa5ifyB7XeZyRIdDuTSHWaGNFEdH4q0G1lsABmnedxHQFCTKTnLfOv30MIzfE5Mabe4ZcG3O5LmbBAeIMGkjKbAmWSEsIYZoVGqdR2AYwkfIfKQXylF0dWQl/QWZ7UOyf9D/RSpl5O/gd2s/pguGn7+C4fKP54JyU0WaU3b8bPxHiuhKdHKvQnGhTm3qzrOMAeSKM+aA55RIiLkj4QCm/5+LSHBcHx4HX5kYHWkKD3kwqLRKcYhVG9LV+rDrAOMPAFVbS8On8hm47QduTLTchYyEfNG8NxHi64PJ+5vRyqECTQCjFPIgRI+mLzHM8dqylwwI/9ny1+LSjtpXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(7416002)(316002)(5660300002)(71200400001)(508600001)(6512007)(26005)(186003)(6486002)(2616005)(31696002)(41300700001)(66556008)(91956017)(54906003)(66946007)(66476007)(66446008)(4326008)(8676002)(64756008)(110136005)(76116006)(38070700005)(8936002)(83380400001)(86362001)(36756003)(15650500001)(107886003)(53546011)(31686004)(6506007)(122000001)(82960400001)(38100700002)(2906002)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdpeFd1eGpnYVg5eWRIbEVLRkNqdmJlMG1CTEU1MXlXdFBoREhBY1FmcFhB?=
 =?utf-8?B?UkRpalErUU9aMkxXT1Nsd2tXaUl2MjFZaEtyaXdreWc4UVBMUEJwNUd6Wkh5?=
 =?utf-8?B?OFRZQXdadzU2RjJ2c3doN1BvQVhMT2hxYjhLTEJaSmxMZWNnVVJDalY2ZmN0?=
 =?utf-8?B?U2l4TjNndjFLSzJzUHA1VE5paVFFQTNhU0JCQ0pjQ0ppcFlaNHJTNHJiM3lL?=
 =?utf-8?B?bnllVVNZNjNKYXFhaWNYd1dkMEJXLzg1eXI4c25KaXpzbDVzUVIrRnl5clN0?=
 =?utf-8?B?ZFdmd1ZKMHZkcXBpRFBuS3pDQklOQklLVGdCWkxnME1YcGx2YzRjMlhJeVpW?=
 =?utf-8?B?QTF1T3Z6alpSblVHZ3RwdFdEL2d0cjlVTW1ycmdaYlQrRlg4NW9KWlVNdHFr?=
 =?utf-8?B?S3UzU0tzUmZ4V1VGem9rT0lMeENkOXJscnlWTmt3aUtWalF2L3hIWGJIOWxi?=
 =?utf-8?B?L3FrcmRMNnVOQnEzMVM4bk9aMjVqZUxNeTZETnhUVUFYMmdxQUo5cFI2N0Iv?=
 =?utf-8?B?QU9HYUlBeVJNT05MdGw1K0NoTXNqeFZKaHhTdVVFd3pXeWU5em8wellWY2Fh?=
 =?utf-8?B?RGFkQkR4blJXMUkrVXQ4aExvMm0xc0h3eHNTbGFSOVN5czdlMHUxWGtDcjBm?=
 =?utf-8?B?QlN4ek1xaEtsSlF1VjVzdjVTb1RpcXZYWlpDSVJqbGdDa2F1Rm9SaS81QWI2?=
 =?utf-8?B?dnluMHpDQmZDWVk4YTF0NmNVYnlwTDl2R0pJL1EwRDlrbUZPQXpkY2RTQlpZ?=
 =?utf-8?B?UjNnSWl4RTBNTktFdUswOUxCYmZhLzBFZ3g4aEk4UUl2TjQ3S29ST3lhOUtl?=
 =?utf-8?B?djBQRjIrcVVxek5jRkZERFZqRjc0MURHb0dvYndQZitTR3ZKNjM1ZXhKTzlv?=
 =?utf-8?B?UldZNklNNFJIOEIxb3p6VmVKZEJOZTRBYUp4NmZtU0lsM3pDZHgvTG0rcjR6?=
 =?utf-8?B?WnRYWG02UlFjZ3Z6QnFVSDNUZDZzQzhWVFhRRGRxaHIvbGpvWHdHV2lDbFJV?=
 =?utf-8?B?djRjMmZFQzBDVmxhSCtta0VtZlpOQ0pLWUgxOGNueE1vUnBhZHJNWkVFTDhU?=
 =?utf-8?B?SFNqZWVZOHI3cDE5QS9jcnV3Zy83cWNxZkhpekRUZDMyaFh2WEVldXpoc2di?=
 =?utf-8?B?akxxSmhVVXB2bUJGZmZZQWxjTkErc0dkdnk3VzIxazFubCtWNklHYmpLWFEz?=
 =?utf-8?B?M1YxNFBMMHhxNDJTVS82SHNxc3QyeDBDcjRzT1JwUG9PQncrRUVaL0VkU1Z0?=
 =?utf-8?B?eFpZcWZSaEZwMVVJVzIzM1VYWndpOXR1VlAxK3c1eE5mOERhYjI1bmJPWHVy?=
 =?utf-8?B?NXJhZmhPS1RUdWlXWGhpa0laZG5tUHBRMnJ1Sk1ETm0xWjE3UXdXK21zQWRz?=
 =?utf-8?B?U1lnNXBZWjQzL29Da2RXTFB1cHNOZkNqRmhuRnV1eWZHdHU1Ym9kZmd6Ujl6?=
 =?utf-8?B?TkwxanhwZkhYeW9Fb0QyQjJzalRiMDRTU0dlbDkvcDBkbDNzZUVmU0JraitO?=
 =?utf-8?B?bU80UmFLZWRwMFdabHpqS2krRUNXOXFFRWVrazRyclNqUmV2Z2NhUzFKUit2?=
 =?utf-8?B?WjVNK2xKempjLzNiMTNXRm9EeWVLNGk3LzZhYjBtbHAyYk1KNTZMRU45ZFdN?=
 =?utf-8?B?RTlHd1lXeS9YQy9aL2VIbHgzTENsbTBPOXJGY1FlR2ZvUXhGaVZiZjdhRVpB?=
 =?utf-8?B?T01CNnhPR3YrbWM3eUVmOE5iazJuazlzUjFJdjFLSXp0dFZleFMxV3Fsa2pJ?=
 =?utf-8?B?T0VLcnQ0VlVUNXliOUlINy9NcVlZcUtNSjRmVEdWN1p6VnBOeHQrZ1NhVUhu?=
 =?utf-8?B?eDQ5OUdkMDhtU0hYamVSM0NleVd0cTVPakVETWZHVWJRdnRxSkJjaGo1R3U5?=
 =?utf-8?B?eHJjT29QUEdSclFFeVp0VE9JRDRaamJKYmUzMTh0RmI4UUlnSTFLVjlsUzQy?=
 =?utf-8?B?MXFIeng0dEFLRGJvblZTOTNQVDlUSjlIM0pjRVptVzBQeDhwNlhBdnpGQjJz?=
 =?utf-8?B?S0ZDbkRtZ0kyZG9zODd0QWpIenQwc3JnTzNVTHpITXcvQzEzVGRVbFRtSXZZ?=
 =?utf-8?B?MGI4QVVDVzJiSGRrU3haUHl0QWt2SnV0TmRNRkVsQi9CVWd4QTlzNXR5d1Rv?=
 =?utf-8?Q?ENucGTdwCeR05/i77KMV+t1pq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB2D9FFBCB892B48AA3EB49271C7242A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YTBSc2tkS3RTMThhMkRzODdkb3RKWk9VY1dRZm5oTk5WcEpETmpyL01Xd1Ji?=
 =?utf-8?B?MGh4WDQ2cWZnYUtsaTM0U3ZhRFY5c25qT1pPTSs0WkQrWVZoKy9hK2Jhb2d5?=
 =?utf-8?B?K21ySmhRWjl0bXAxaStDN1dyL3hVcFNXWUI5M1pFRXM2dDROU2t4R0VoTDk4?=
 =?utf-8?B?ZHhjWitkYURiVStteEdjczY2V05UaGh1bWxaaHg3MlFaUVJwYzkzbFArN0R2?=
 =?utf-8?B?WXUzelpYbnVrSk9uSGhXTjlwTjllRmZnSjROZXp6NjMweW9MamlvUmNzVDJ4?=
 =?utf-8?B?eFNFSHlFRDRqNkUvU2c4bWd2YjJhZnA4dEo0aE5xOWp6RzNWUkZqaGtwT2JB?=
 =?utf-8?B?ek5yc2VxVTg1cmZqcFprdVhPbzUzbzV6VmV6VXlrOWNGakx6eGRsR3RIeHNW?=
 =?utf-8?B?Y0h5QkJpOVlJSTl6R25uMExiNUJ5TGUrWDN6Wlo5TVJQYkJ5cmd1STV4dWhE?=
 =?utf-8?B?M0RzZHY4bzcrMGlpa01lR3ZpNnZrOEoxNFViLzFlWnVrRHoyVm1oNnFVSEN0?=
 =?utf-8?B?UkJlVzd6U2dNYi9hWWZxSElMU3B0ZjNYYld0SDljNzZpQjAxWmFBT3BQQkg5?=
 =?utf-8?B?bEJOLy9lY05rZEhsQ3pLQ045WGI3MDVXZEhxaFFBeWgzcVQ0Nm56Zlp1eGtS?=
 =?utf-8?B?R0pTOUw0VjZ0WXVuUWpPVkVwRUxPSjI3cDFraGp3Q2lmVHdpUWx1ZG1jSVEw?=
 =?utf-8?B?Y2JUUjNOb3luVWtaRURVNFV4SHFjSThuaXhlVWlyNkNjbDBDa0h6NGNLTnNp?=
 =?utf-8?B?dWQ4SHBMV3RXaFoyNnQ2UFBvRUVFRDFTaThUa0tlT3ZPTXZwYmh0aFAwUDFu?=
 =?utf-8?B?MzNLdmFNZ3BYNHQreWJKQTJFV1lWKzA1Q05FelNPTVdUeWlSQ3hBN1ozL04w?=
 =?utf-8?B?bk5FMlljRWpqTERjTGtDVGVMUUZFS2xjVjFSWXdmbUU1b2ptMmYzVGNwTkRl?=
 =?utf-8?B?ekd4U2VGTFlmZStFeXlkZUp0K1FlMkxDU3FpdzRLRlRaTURUZzJOS2tETHAx?=
 =?utf-8?B?Wk45QWhaUHROVTJyRm9BRVRTUmpNdUJYcWFWaXRHLzBTbDc0aGRCeVhGaS9S?=
 =?utf-8?B?Y01wa3RSRFZIaDBQdFVWcURsZjAxZjEzb09RU0F2UGtCRkZuVWRaMVNLZzJz?=
 =?utf-8?B?c1RtcmJ4Q1JIK0w3blI4Y0IwZWZkOXRQVUpDdnVEYWJ5bmlsUVVsWEZkYktE?=
 =?utf-8?B?eHgzc3V5Tm1ZM3pXM3dNZFNkaUVTa243dlpkQ05iZkdkelRmTGRBMSt6NDRa?=
 =?utf-8?B?NVZaNXhPeVJKazhTSU5VTms2MHl1czVKNjdqMFFOTVduVU00eC94aTNhc3lI?=
 =?utf-8?Q?8QXXdN+5Kf5zA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5edb11-4719-4c3d-2944-08daf3c89113
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 11:39:57.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBAE67blKJopvNNxCVLXsIDkZ5dQBDoa6whsJj3QEgw0yWavIv4M9cThC5Gc6mL6GNrwtLkoCJLWFXxnb/JpmkFmvGzkLOl75T2HQJfBwTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5402
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDEvMjAyMyAxMToyMCBhbSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwg
SmFuIDA5LCAyMDIzIGF0IDA0OjA1OjMxQU0gKzAwMDAsIEpvYW4gQnJ1Z3VlcmEgd3JvdGU6DQo+
PiBUaGlzIGZpeGVzIHdha2V1cCBmb3IgbWUgb24gYm90aCBRRU1VIGFuZCByZWFsIEhXDQo+PiAo
anVzdCBhIHByb29mIG9mIGNvbmNlcHQsIGRvbid0IG1lcmdlKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY2FsbHRodW5rcy5jIGIvYXJjaC94ODYva2VybmVsL2NhbGx0aHVu
a3MuYw0KPj4gaW5kZXggZmZlYTk4ZjkwNjRiLi44NzA0YmNjMGNlMzIgMTAwNjQ0DQo+PiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvY2FsbHRodW5rcy5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y2FsbHRodW5rcy5jDQo+PiBAQCAtNyw2ICs3LDcgQEANCj4+ICAjaW5jbHVkZSA8bGludXgvbWVt
b3J5Lmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZWxvYWRlci5oPg0KPj4gICNpbmNsdWRl
IDxsaW51eC9zdGF0aWNfY2FsbC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+DQo+
PiAgDQo+PiAgI2luY2x1ZGUgPGFzbS9hbHRlcm5hdGl2ZS5oPg0KPj4gICNpbmNsdWRlIDxhc20v
YXNtLW9mZnNldHMuaD4NCj4+IEBAIC0xNTAsNiArMTUxLDEwIEBAIHN0YXRpYyBib29sIHNraXBf
YWRkcih2b2lkICpkZXN0KQ0KPj4gIAlpZiAoZGVzdCA+PSAodm9pZCAqKWh5cGVyY2FsbF9wYWdl
ICYmDQo+PiAgCSAgICBkZXN0IDwgKHZvaWQqKWh5cGVyY2FsbF9wYWdlICsgUEFHRV9TSVpFKQ0K
Pj4gIAkJcmV0dXJuIHRydWU7DQo+PiArI2VuZGlmDQo+PiArI2lmZGVmIENPTkZJR19QTV9TTEVF
UA0KPj4gKwlpZiAoZGVzdCA9PSByZXN0b3JlX3Byb2Nlc3Nvcl9zdGF0ZSkNCj4+ICsJCXJldHVy
biB0cnVlOw0KPj4gICNlbmRpZg0KPj4gIAlyZXR1cm4gZmFsc2U7DQo+PiAgfQ0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L3Bvd2VyL2NwdS5jIGIvYXJjaC94ODYvcG93ZXIvY3B1LmMNCj4+IGlu
ZGV4IDIzNjQ0N2VlOWJlYi4uZTY2Nzg5NDkzNmY3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYv
cG93ZXIvY3B1LmMNCj4+ICsrKyBiL2FyY2gveDg2L3Bvd2VyL2NwdS5jDQo+PiBAQCAtMjgxLDYg
KzI4MSw5IEBAIHN0YXRpYyB2b2lkIG5vdHJhY2UgX19yZXN0b3JlX3Byb2Nlc3Nvcl9zdGF0ZShz
dHJ1Y3Qgc2F2ZWRfY29udGV4dCAqY3R4dCkNCj4+ICAvKiBOZWVkZWQgYnkgYXBtLmMgKi8NCj4+
ICB2b2lkIG5vdHJhY2UgcmVzdG9yZV9wcm9jZXNzb3Jfc3RhdGUodm9pZCkNCj4+ICB7DQo+PiAr
CS8qIFJlc3RvcmUgR1MgYmVmb3JlIGNhbGxpbmcgYW55dGhpbmcgdG8gYXZvaWQgY3Jhc2ggb24g
Y2FsbCBkZXB0aCBhY2NvdW50aW5nICovDQo+PiArCW5hdGl2ZV93cm1zcmwoTVNSX0dTX0JBU0Us
IHNhdmVkX2NvbnRleHQua2VybmVsbW9kZV9nc19iYXNlKTsNCj4+ICsNCj4+ICAJX19yZXN0b3Jl
X3Byb2Nlc3Nvcl9zdGF0ZSgmc2F2ZWRfY29udGV4dCk7DQo+PiAgfQ0KPiBZZWFoLCBJIGNhbiBz
ZWUgd2h5LCBidXQgSSdtIG5vdCByZWFsbHkgY29tZm9ydGFibGUgd2l0aCB0aGlzLiBUQkgsIEkN
Cj4gZG9uJ3Qgc2VlIGhvdyB0aGUgd2hvbGUgcmVzdW1lIGNvZGUgaXMgY29ycmVjdCB0byBiZWdp
biB3aXRoLiBBdCB0aGUNCj4gdmVyeSBsZWFzdCBpdCBuZWVkcyBhIGhlYXZ5IGRvc2Ugb2Ygbm9p
bnN0ci4NCj4NCj4gUmFmYWVsLCB3aGF0IGNyMyBpcyBhY3RpdmUgd2hlbiB3ZSBjYWxsIHJlc3Rv
cmVfcHJvY2Vzc29yX3N0YXRlKCk/DQo+DQo+IFNwZWNpZmljYWxseSwgdGhlIHByb2JsZW0gaXMg
dGhhdCBJIGRvbid0IGZlZWwgY29tZm9ydGFibGUgZG9pbmcgYW55DQo+IHNvcnQgb2Ygd2VpcmQg
Y29kZSB1bnRpbCBhbGwgdGhlIENSIGFuZCBzZWdtZW50IHJlZ2lzdGVycyBoYXZlIGJlZW4NCj4g
cmVzdG9yZWQsIGhvd2V2ZXIsIHdyaXRlX2NyKigpIGFyZSBwYXJhdmlydCBmdW5jdGlvbnMgdGhh
dCByZXN1bHQgaW4NCj4gQ0FMTCwgd2hpY2ggdGhlbiBnaXZlcyB1cyBhIGJpdCBvZiBhIGNoZWNr
ZW4gYW5kIGVnZyBwcm9ibGVtLg0KPg0KPiBJJ20gYWxzbyB3b25kZXJpbmcgaG93IHdlbGwgcmV0
YmxlZWQ9c3R1ZmYgd29ya3Mgb24gWGVuLCBpZiBhdCBhbGwuIElmDQo+IHdlIGNhbiBpZ25vcmUg
WGVuLCB0aGluZ3MgYXJlIGEgbGl0dGxlIGVhcmllciBwZXJoYXBzLg0KDQpJIHJlYWxseSB3b3Vs
ZCBsaWtlIHJldGJsZWVkPXN0dWZmIHRvIHdvcmsgdW5kZXIgWGVuIFBWLCBiZWNhdXNlIHRoZW4g
d2UNCmNhbiBhcnJhbmdlIHRvIHN0YXJ0IHR1cm5pbmcgb2ZmIHNvbWUgZXZlbiBtb3JlIGV4cGVu
c2l2ZSBtaXRpZ2F0aW9ucw0KdGhhdCBYZW4gZG9lcyBvbiBiZWhhbGYgb2YgZ3Vlc3RzLg0KDQpJ
IGhhdmUgYSBzdXNwaWNpb24gdGhhdCB0aGVzZSBwYXRocyB3aWxsIGJlIHVzZWQgdW5kZXIgWGVu
IFBWLCBldmVuIGlmDQpvbmx5IGZvciBkb20wLsKgIFRoZSBhYnN0cmFjdGlvbiBmb3IgaG9zdCBT
My80LzUgYXJlIG5vdCBncmVhdC7CoCBUaGF0DQpzYWlkLCBhdCBhbGwgcG9pbnRzIHRoYXQgZ3Vl
c3QgY29kZSBpcyBleGVjdXRpbmcsIGV2ZW4gYWZ0ZXIgYSBsb2dpY2FsDQpTMyByZXN1bWUsIGl0
IHdpbGwgaGF2ZSBhIGdvb2QgR1NfQkFTRcKgIChBc3N1bWluZyB0aGUgdGVhcmRvd24gbG9naWMN
CmRvZXNuJ3Qgc2VsZi1jbG9iYmVyLikNCg0KVGhlIGJpZ2dlciBpc3N1ZSB3aXRoIHN0dWZmIGFj
Y291bnRpbmcgaXMgdGhhdCBub3RoaW5nIEFGQUlDVCBhY2NvdW50cw0KZm9yIHRoZSBmYWN0IHRo
YXQgYW55IGh5cGVyY2FsbCBwb3RlbnRpYWxseSBlbXB0aWVzIHRoZSBSU0IgaW4gb3RoZXJ3aXNl
DQpzeW5jaHJvbm91cyBwcm9ncmFtIGZsb3cuDQoNCn5BbmRyZXcNCg==
