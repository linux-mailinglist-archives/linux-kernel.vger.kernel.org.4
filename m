Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0F7297E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjFILMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjFILL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:11:29 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 04:11:27 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8542D41
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686309087; x=1717845087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhkJadSszct4jGoSaiX7DRLRkGZFgBUYAERychujKRg=;
  b=VAmgcx94UY0nhcVoxkzEBggZORoBT/2EY7fTxdg2owL2kWNDMEl7kaCY
   6iC03P3SgRGXAN1eR/CJQIsPJm4qfcNssg+bb8+141FG1EXUxMJiI3hay
   Oa6OSgxA6HRZJ0FDnSDKaHcKueQcqKre3/Tx3q+ZJttdfLN0dPk3y9XMI
   dbG5JameDjkumNS6qUHAI2qfgNwaUpDe38+/GEWuoIPxfmYvtwYYFMg2W
   zjN9PAMTjlk2HWmSgVmDpjRZlFH4+Efry+IaZMhQaatCKfalWgZYltCw7
   M6LVch8NHvTD8aUQFhLZxqPyBa3vtBnEEb5s5NTvunAHb49lkyO3NQ4tt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="86905689"
X-IronPort-AV: E=Sophos;i="6.00,229,1681138800"; 
   d="scan'208";a="86905689"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:10:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKloFq42BGeZDUtmeML9ytRx0XvJnnUey7w5bXh6Mat2vXL3dvTGeJylmfVIM8tvYP4NqHCkUsOhzyvwmvsu9YHvfw0xNUAZ1IAv4G+ZMXPJylyzIarB7aMtxs96iUtXvWgUokice3mnoRJk4/niDyaOlfaYm8gZuE92MNKDV3wHpd5ST1NFWCSeocm+iYq1TuCoby9L7smxliKRUS3KloczXzyssZL49nZHiXI/46aBDq4DytDq5y2q47ASEEecpVU6MtCN9yxVCHNCI6mFIgNebqdm0/WP0tR41x5eOg4SMuoDB9XYuugNaAC8WbA9iwtclJdr36Vw5qLUFnx/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMnV0grqxCrRASfXmjr6kjoWy1kbMr1i1lM/NlWA31A=;
 b=OeMDa9DLg0s+22eMjHGLial0Rtq5ukWNfZNUatFRnU/4Fifw3PK2hJqrXV+u+1YfVMTV7GUYrh4TqMWI3dVm9s1ADseh0bVogPU3+mxJJv1wI+s7yU8ZvXdzR1XEnW8zP1Nfw0tJlZUl2mpJAjz6o/u/kSdLzccm9OkvqIEYN7VJp5WiVI6EDNGFQsbALFinFE/zSlnnf7WFNJJvOXbGrQ1VnUja86TsEvahuIY8SRgpQOFJ1WAJ2+eKzPbh66CfE7rOoUUvf43bszYALZTZmOdjh76vHlM+N7uAilx61g8/3zL/JDzOyEQ6i5yqPhCGI5LvWwLt+MfH/EGaIBfyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB5516.jpnprd01.prod.outlook.com (2603:1096:404:8042::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.35; Fri, 9 Jun
 2023 11:10:14 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83%7]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 11:10:14 +0000
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
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>
Subject: RE: [PATCH v4 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Thread-Topic: [PATCH v4 21/24] x86/resctrl: Allow overflow/limbo handlers to
 be scheduled on any-but cpu
Thread-Index: AQHZjzM7cWN/JXfzFk2xm7bR4q4Ya6+CZYwQ
Date:   Fri, 9 Jun 2023 11:10:14 +0000
Message-ID: <TYAPR01MB63307451E66EBDB7F885F13D8B51A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-22-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-22-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-09T11:03:09Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cce3e141-7ac8-4fc3-bc75-decff2a6516f;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: fb460f3032584bf1add40b2030b2a3f3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYAPR01MB5516:EE_
x-ms-office365-filtering-correlation-id: 67a9bfda-3334-45ba-a6e4-08db68da1978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlNRmHTfYizZ/Jmz4LzO3IUS1MHqCphyD4EKh6lK/uruPZegfdF/eCRDMu5WoGIBqn1YENehCnbmp6FQW6xlvbNdtjVAAceyHdm+jej8fwKIxAtTL4/a/dACxy9e9jtYGRjha7nc+TYBkmkehTI89jalRDGz6dF6mODLgMagMCEVrjBa4WIBMusYEO/NE44cybMVFbcoiAVkwaAs5ACMKPuHG2onMhHxcVtJbJNY56CpLaT4ppY3fxXtPGMYr8NV80zH24rQzY0zibaBQlg2t5VSHDHIqOJbvcH85HgbrCiLggTlnBAAH7ol37g69QRwLaTpsa7jtSwza+aO7jCkLsFjtBUsrWfgklF0hfvRAnWRCTIXC2VouXxDa8Lvm3sFLCsRIzCVgRtWZo3Kydk77vBrw2lRmaFlji4AX+gQFxTQPSdZCvSxr2DcdlK34oDDDl7u0qX0WvwGbTJg4AL8EuUgWF7NJnBAa1/B+hngM2zZu/cV4QqoykLkeXZM4dd7cEQqNhfCOzFNqzeiqCKi/EoB1Q50JM5wn0pa2aDZ99VNm3TIfyOb8KIJB6/w44YGSBRhmLaxA3NLJjVrIDp8tayM2p+N3ARGO/f8jWyk9YmWJT9iOuy0YIh57p+dXaE4IGoGC/WFymuVZinOpyC0tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(1590799018)(451199021)(66556008)(2906002)(1580799015)(64756008)(66476007)(52536014)(83380400001)(5660300002)(8936002)(66446008)(8676002)(7416002)(55016003)(76116006)(4326008)(110136005)(54906003)(316002)(66946007)(41300700001)(71200400001)(33656002)(7696005)(85182001)(478600001)(186003)(86362001)(122000001)(82960400001)(38100700002)(9686003)(6506007)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?L0RQdWxNQUxtbWtaMGJiS2Uvbm1DSVAyenZpeWxzOVBXQzMrOEtySkhz?=
 =?iso-2022-jp?B?SDE2UDVqS2NsaWRydnpzN2xXaVZrSk5PMzcrK3NwcnMrL2JUZUhNUW9j?=
 =?iso-2022-jp?B?UW5DTTROdUpFbUFsMjdqaUFwZHlhVDg5YVhXeWFITU5YTlZ2Ky9WSzAz?=
 =?iso-2022-jp?B?V04reEwxckY2ZEJnQVgvWENPWlcwZVZNdS9peVFWRngrdk9aZ05rTUtN?=
 =?iso-2022-jp?B?Y2VremJtbS82SStTVG5mK1R0RTljUWZFWDloU1N2K1BpckZHWXorWGkz?=
 =?iso-2022-jp?B?NGNqSFBLREN3RndHT20veGpDWUJObjlVaGlkNXBYZ2U5RjZHb01QVVB0?=
 =?iso-2022-jp?B?NHRZSTNERnZvVlkzT2d1N1paanVMVW5ySWhSMW5HaXQ0bDVCT0FSU0oy?=
 =?iso-2022-jp?B?VEJxK0ZOVEwxS05sQ3N5ZkFBOU9kRlVWSDRQaGFiOEtZWVMvMW94OFYw?=
 =?iso-2022-jp?B?a0o1bE9mWkJ2WDc4VVVvUVpLZTg3NFkzWTBINW5NM1VpaFFlTWgrUHVp?=
 =?iso-2022-jp?B?S3B3aUNhaHdXVlpJbHFmcFhWam9zRU9jeUtON3pyZ1hQMzBsbDA1WFR5?=
 =?iso-2022-jp?B?cXdNcjFMYnpGK2swOGNLSm1iRmUrbHROV0VTQWFUWEpqU3h0V1A4UkZu?=
 =?iso-2022-jp?B?SEJVRDExbVlyV3Vjc1VTZGxMYUlzMm1mOVdIdVlhdFNGRjRQVmJtbkdp?=
 =?iso-2022-jp?B?UUhjdGo5emFHemV0Qm9RUFRMcTIvWlcwT00wd3NWaDNrMFNPN2hGRk95?=
 =?iso-2022-jp?B?UnQ4UnVJZjRjd1VkT1UzbnIxZ3BoVTZocGNKRXpWWVlWRjhHdUg4eGdW?=
 =?iso-2022-jp?B?MDZ4NmNyNnVmRU5nREozNUZvMFgweE9OL0pnZnFNekIvK1lFWHpRZFF5?=
 =?iso-2022-jp?B?djZQbG1iUUVsRjZVeUlLaGVia1dmaEh3RnRxQUpqRXVaOTZtOHltSjYr?=
 =?iso-2022-jp?B?K2dmMm00L2U1U0ZkWTZ4WUg5NjRGYkoxc05acEpBNjJwM0lMZUdzV1Zm?=
 =?iso-2022-jp?B?Y2pjc2ZjN0FaZ0QxRXBHMi93WmQzcThSS3lQNFZvajFIcUNDckErN1kv?=
 =?iso-2022-jp?B?bkRRQkJjZkZhVXRMUUpMYldrUzBhc0VQOHZySUswUFFkUFhyKzNRWm04?=
 =?iso-2022-jp?B?d0hQbDRkZDFtRlJ3T24xYlVRQjF4VFhHZVBvM1BDekxoT2syMS9wY2dh?=
 =?iso-2022-jp?B?YzBjWWEwTmJRRFNNT2cvdDJpbmRxYzJ0S2c0VE03VGVCTVd5dWZUYVFV?=
 =?iso-2022-jp?B?cThLbkEyQVpUNkdtTkxNcjNUdGEvbkZYeDRabTlvU29LVGVheHVlMnRB?=
 =?iso-2022-jp?B?QldTMEFzc21tUHlSVWlYamJUbTFDdS9tZ21YL25adi80ZnBUc2Z0bFdN?=
 =?iso-2022-jp?B?T3Vnb21vZ2lZVnhMSmR4Rk5Zb1Q3ZnJqTUdtLzgzRkhEZjlyWnJ6Vlli?=
 =?iso-2022-jp?B?eU5iS3hJTXZCNEhhLzFTQXFIQzZWZ00wSjIxM2lLRThvQ0xhZFFIRTlh?=
 =?iso-2022-jp?B?R1dSL05UZFNIc0J4aVVQUjZLaytueUxvdHRBcE0yY1Y4YlVndkF3Skdk?=
 =?iso-2022-jp?B?a0Q4MnU1eWJhYXpObG5jNkg4Z2N5bTRsZUpORktML2xRMGQ1eXdZRVhN?=
 =?iso-2022-jp?B?WGlac3kwZWlQNW51R29wMFZoVjI1bm5CSENrZkVJbE9uWHk0SVZUOWtT?=
 =?iso-2022-jp?B?blMzdXIwNXBPbFdjc04rLzlqOExMaThkL0tmUUJSQndyQU9OVGVWclQx?=
 =?iso-2022-jp?B?QURUQStSUy9QWkJZTTVZb1E0b1I3R0U5dFBib1FPOWpoWnhYODJSRk5X?=
 =?iso-2022-jp?B?NjlqamdkalpPcVQyaktyNjN0N0RmTDgrazl2OEorTFZZekFQaGVuWGxD?=
 =?iso-2022-jp?B?bzlqVERCa2VqVGc3QmlqZGFoUlFaVlVicVFJTnRUVW4xZzUzenFPSWNY?=
 =?iso-2022-jp?B?SHZLajRlMEx0VnBWOFE2c2dMNC93aUxZYUlhZnQ3VFFMdGNMd3QxUXIy?=
 =?iso-2022-jp?B?S2lCUjhEb0xmaS9ldjd6L1U1SThiRWYzVjRnQnNsaGJ1L0dtbVJvcngz?=
 =?iso-2022-jp?B?YUtndVVBTXd1YS9ub0dUSG84NG5XZ1duRmNWN25HRnZ5ZTJESFJZZ3dH?=
 =?iso-2022-jp?B?b3loUHFpTC9SRFpaRkJIYzUwbVgvRFRDblJ6UXo5RUV4QUV0eVdSTEZh?=
 =?iso-2022-jp?B?TFJSUm56SkcwVEIxWkEwak5SMmp5VG4zMU1GeS9URzl1R1VmdGRSOHBt?=
 =?iso-2022-jp?B?TFcvaVFFWDBicnhqWCtoK1o0clVFWWFzUVpMUnVITXZPaG9FZU83VXdR?=
 =?iso-2022-jp?B?ZFNhM0hKV2RlTjVKdUc3eTBwK3pQdWY1bVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?VWh2UmVFSTIvcTZxVkliRmJzUEVWVVVnNCt0dm93TXhveFRHQURlSGJa?=
 =?iso-2022-jp?B?VnpVbG9kQSt3SEtXNlNQUXZRa2ZFMWd4SkNIOFBndkM5bjJ1N1R1UXJC?=
 =?iso-2022-jp?B?aGYwKzdPZTFsOEVxMXdNRVp4M2V4S2IvVXBRd2NnRE4yRU1CWkZpNXc2?=
 =?iso-2022-jp?B?cFc2QlJRLzQ3aXdiNitOTnhta3NORUY2WmtWZGlTQWJKY0lrcEVZeXJP?=
 =?iso-2022-jp?B?VExhTTY5YnVpSitOcDM5ZTZyMW5nUGFGeGlwaWlpZjE1TXNjMlJPRHMw?=
 =?iso-2022-jp?B?bHZoRXM2Z0trVUsyTGJsL3B5bXVNYXBlWGdIb0ZLQzBRR0ExMlFqVnhj?=
 =?iso-2022-jp?B?Q1Z4Y3VtREF1a0lkVEdoTlVxUDJNMkc3T0JCRFdPcmZvTjFoT0xOQ0Rv?=
 =?iso-2022-jp?B?NVQyRzAxZVhoR2x4VTVBak1CdzhMbSt2YzlBeTJyVk9tV2pKMFBhd2xB?=
 =?iso-2022-jp?B?TGZoODY5WTU5K05WZWtldVAwU2Y0SHd0ZlNzMlFVTHVNeFZCN1ZuMFVj?=
 =?iso-2022-jp?B?S1J0UFVPdU1kMEE1N2ZpUXVqSmVUUndPYjB2RENCcExKanh2Yk1LemQ4?=
 =?iso-2022-jp?B?NTk0RFpiNXpXR1ltWi9ia3R0ZGFOcXFlYm4xbkRtUWgzeWVHZHdQQ0du?=
 =?iso-2022-jp?B?U2p0TkMwRnllMjVqOXJPaFEwMEwyWVFNRVplTFlFKzBLSjRzMXZPZ2JZ?=
 =?iso-2022-jp?B?ZWNBTURMc094SXdFeTVNNXRyamZuam90RmJ0clRPK2NPNTBOczNRWitF?=
 =?iso-2022-jp?B?Z3Q1c2dUZWZJR1daVXUzWFJPOW9oVk1xNjZQdkY4dURJUFBnSS9DUTRF?=
 =?iso-2022-jp?B?NUdWVkNsNjBFc2hnMGpkYTdIaEVuSXUrU1JUWHd6ay92VWxReWFyMzdI?=
 =?iso-2022-jp?B?RDFPQ3hLKzhqVjdSNnJlUzVpRnE3Vi9TRy9EcHFKWHlPVzVEUkh5Um44?=
 =?iso-2022-jp?B?dHpPQTdHREVUbjhmaCsyaFUraHBaTENzaWtQQ1greXhWMVV5clAwSklK?=
 =?iso-2022-jp?B?Y3I2RXlmZk9hR2Y0Zk5SemR6S1U5VjNRU21BS3hqUUdvV1VLOE45NkNw?=
 =?iso-2022-jp?B?aGo1T0c4aUhaZlc5ZStPT2VRMThrck85QVhJd2JKdTIvOHNHeXZkUitJ?=
 =?iso-2022-jp?B?NU5JZ0daTmkwTlNCbjUxbDZzMWpEcEpvbjl3SkxFbjhLUG1lcUJGbXJH?=
 =?iso-2022-jp?B?YkVqR0F1d3J1NVNFQTFyb1d3R05QRWN1SXIzQUk3bklOcmJhbWhXa1Vm?=
 =?iso-2022-jp?B?QVc2NW5HS2ZDQzA1enQ5N3M2cC9xY1dJampVU1lWZHdXSVNHMklLSlQr?=
 =?iso-2022-jp?B?MngyNlBmRzcxR1o0MzdhMHFuelVlUm0zQlI4dXhnTDkzMjFlUkQ1SHhR?=
 =?iso-2022-jp?B?Vklqa2lRanBnbTF2eTdMdU0zMHhzZmJiTlczdWVWM1djdFU2elczSDJO?=
 =?iso-2022-jp?B?cHpmczA1TnlINTM4cC93OWtlUG1PSDQrRGZNcDdwSlhFNHF0TzdvWElW?=
 =?iso-2022-jp?B?TVlvbWNUSW5SWU5YZFdwcXZLMVFFWERrSjYvNmdXUExXVGlyUWhYV3hk?=
 =?iso-2022-jp?B?OTV1a1hDQTJaRVJmVHdTU1E3cEplRVVIQmsySTM3eTdEZnI5c0tMd1lw?=
 =?iso-2022-jp?B?ZUxxOWdkdjkwQkRpSHVxdHJvcXMxMzlFRTczaFdJRW0vQzdLT2MyUVNt?=
 =?iso-2022-jp?B?bVVxVkdMdVREc0RSMldHK0JWQW1WcmhwU2xUWkZLVmhIcUJiSFJnS05h?=
 =?iso-2022-jp?B?bEJkM3NheEdIY1Iwb3pGZHBKTFhXeEE3c1F6YnJDMURWeFVCdk1GdDAw?=
 =?iso-2022-jp?B?UFBVSkUzb3ZZd0M4NHFDZTI4b0hUK2RmclQ3NGY5cFArM0V6eTZxSXUr?=
 =?iso-2022-jp?B?N2JKTld1cnM3aFg5cEZHOEtQVDVRPQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a9bfda-3334-45ba-a6e4-08db68da1978
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 11:10:14.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/+BG9+qbGqt0YxUZVqAokeGhNNQnBLLRdEHEfB3or15ey9FMOU6WRTfyYluW5K3yzhaTGEjlDr3Q7Od0vD1l0/Lq60MS91z4T5r4OE/7dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5516
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> When a CPU is taken offline resctrl may need to move the overflow or limb=
o
> handlers to run on a different CPU.
>=20
> Once the offline callbacks have been split, cqm_setup_limbo_handler() wil=
l be
> called while the CPU that is going offline is still present in the cpu_ma=
sk.
>=20
> Pass the CPU to exclude to cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler(). These functions can use a variant of
> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
> need excluding.
>=20
> A subsequent patch moves these calls to be before CPUs have been removed,
> so this exclude_cpus behaviour is temporary.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Rephrased a comment to avoid a two letter bad-word. (we)
>  * Avoid assigning mbm_work_cpu if the domain is going to be free()d
>  * Added cpumask_any_housekeeping_but(), I dislike the name
>=20
> Changes since v3:
>  * Marked an explanatory comment as temporary as the subsequent patch is
>    no longer adjacent.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  8 +++--
>  arch/x86/kernel/cpu/resctrl/internal.h | 37
> +++++++++++++++++++++--  arch/x86/kernel/cpu/resctrl/monitor.c
> | 42 +++++++++++++++++++++-----
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 ++--
>  include/linux/resctrl.h                |  3 ++
>  5 files changed, 82 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index e00f3542e60e..187ed127a446 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -582,12 +582,16 @@ static void domain_remove_cpu(int cpu, struct
> rdt_resource *r)
>  	if (r =3D=3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu =3D=3D d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
> -			mbm_setup_overflow_handler(d, 0);
> +			/*
> +			 * temporary: exclude_cpu=3D-1 as this CPU has
> already
> +			 * been removed by cpumask_clear_cpu()d
> +			 */
> +			mbm_setup_overflow_handler(d, 0,
> RESCTRL_PICK_ANY_CPU);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu =3D=3D
> d->cqm_work_cpu &&
>  		    has_busy_rmid(r, d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0);
> +			cqm_setup_limbo_handler(d, 0,
> RESCTRL_PICK_ANY_CPU);
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 021a8956518c..9cba8fc405b9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -79,6 +79,37 @@ static inline unsigned int
> cpumask_any_housekeeping(const struct cpumask *mask)
>  	return cpu;
>  }
>=20
> +/**
> + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring
> those
> + *			            that aren't marked nohz_full, excluding
> + *				    the provided CPU
> + * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
> + *
> + * Returns a CPU from @mask, but not @but. If there are housekeeping
> +CPUs that
> + * don't use nohz_full, these are preferred.
> + * Returns >=3D nr_cpu_ids if no CPUs are available.
> + */
> +static inline unsigned int
> +cpumask_any_housekeeping_but(const struct cpumask *mask, int
> +exclude_cpu) {
> +	int cpu, hk_cpu;
> +
> +	cpu =3D cpumask_any_but(mask, exclude_cpu);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu =3D cpumask_nth_andnot(0, mask,
> tick_nohz_full_mask);
> +		if  (hk_cpu =3D=3D exclude_cpu) {
> +			hk_cpu =3D cpumask_nth_andnot(1, mask,
> +						    tick_nohz_full_mask);
> +		}
> +
> +		if (hk_cpu < nr_cpu_ids)
> +			cpu =3D hk_cpu;
> +	}
> +
> +	return cpu;
> +}
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -564,11 +595,13 @@ void mon_event_read(struct rmid_read *rr, struct
> rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
>  void mbm_setup_overflow_handler(struct rdt_domain *dom,
> -				unsigned long delay_ms);
> +				unsigned long delay_ms,
> +				int exclude_cpu);
>  void mbm_handle_overflow(struct work_struct *work);  void __init
> intel_rdt_mbm_apply_quirk(void);  bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long
> delay_ms);
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long
> delay_ms,
> +			     int exclude_cpu);
>  void cqm_handle_limbo(struct work_struct *work);  bool
> has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);  void
> __check_limbo(struct rdt_domain *d, bool force_free); diff --git
> a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ced933694f60..ae02185f3354 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -485,7 +485,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(r, d))
> -			cqm_setup_limbo_handler(d,
> CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d,
> CQM_LIMBOCHECK_INTERVAL, -1);
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -810,15 +810,28 @@ void cqm_handle_limbo(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>=20
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long
> delay_ms)
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for thi=
s
> + *                             domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick a=
ny
> CPU.
> + */
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long
> delay_ms,
> +			     int exclude_cpu)
>  {
>  	unsigned long delay =3D msecs_to_jiffies(delay_ms);
>  	int cpu;
>=20
> -	cpu =3D cpumask_any_housekeeping(&dom->cpu_mask);
> -	dom->cqm_work_cpu =3D cpu;
> +	if (exclude_cpu =3D=3D RESCTRL_PICK_ANY_CPU)
> +		cpu =3D cpumask_any_housekeeping(&dom->cpu_mask);
> +	else
> +		cpu =3D cpumask_any_housekeeping_but(&dom->cpu_mask,
> +						   exclude_cpu);
>=20
> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	if (cpu < nr_cpu_ids) {
> +		dom->cqm_work_cpu =3D cpu;
> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	}
>  }
>=20
>  void mbm_handle_overflow(struct work_struct *work) @@ -864,7 +877,14
> @@ void mbm_handle_overflow(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>=20
> -void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long
> delay_ms)
> +/**
> + * mbm_setup_overflow_handler() - Schedule the overflow handler to run f=
or
> this
> + *                                domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick a=
ny
> CPU.
> + */
> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long
> delay_ms,
> +				int exclude_cpu)
>  {
>  	unsigned long delay =3D msecs_to_jiffies(delay_ms);
>  	int cpu;
> @@ -875,9 +895,15 @@ void mbm_setup_overflow_handler(struct rdt_domain
> *dom, unsigned long delay_ms)
>  	 */
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
> -	cpu =3D cpumask_any_housekeeping(&dom->cpu_mask);
> +	if (exclude_cpu =3D=3D -1)
> +		cpu =3D cpumask_any_housekeeping(&dom->cpu_mask);

Should RESCTRL_PICK_ANY_CPU be used instead of -1?

Best regards,
Shaopeng TAN
