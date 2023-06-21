Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B49738F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjFUTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjFUTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:05:53 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE80B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687374351;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=hFoiIgauJUdisXUuZZGm5A44v/YRCSGze0db1HjeRJQ=;
  b=cSEZKWTxZLTjril+zl9xIemLzZK6rnJjJqRaKIddFivBaoIyudwKBNiS
   mjMq1fTvMzEd7UBVclN+Bk5J9bnQDKnPO6LpnWyv+LSeZuvYndMuSQZ1P
   g0qZzsC7rOiYtWwMGUFiw6rfXbC4VoKe4DPrHHGzfcOXUGeh0tCcKqSUv
   E=;
X-IronPort-RemoteIP: 104.47.56.175
X-IronPort-MID: 113686095
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:089Cda8RQnYKEp6jaewZDrUD6X6TJUtcMsCJ2f8bNWPcYEJGY0x3x
 mYYC2uEb/beZ2unft1+a4+y8E8H75aBz942HAs9riA8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks31BjOkGlA5AdmO6oS5AO2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklcq
 cQzLx0ScCyOivOy36qmdLg8q9gKeZyD0IM34hmMzBn/JNN/GNXoZPyP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWNilUujdABM/KMEjCObf1YhACyp
 2bd8kzyAw0ANczZwj2Amp6prraWxn2rBtpDSdVU8NY1oVqUl09CDyY/fmaYg/yIsRCHAetQf
 hl8Fi0G6PJaGFaQZt3gQxqQo3OeuBMYHd1KHIUS9A6J2oLQ4gCEGnIDSD9RLtAr3OczRDol0
 XeTkt/pDCApu7qQIVqX7p+dqTK/P3hTIWJqTSMNUwZD49Dlu4w1phbOSMtzVq+zktDxXzr3x
 liivHhgr7Yel8gG0+O851+vqzK0r7DbXxIy/EPcWWfNxgF2fom+fKSz9EPWq/1HKe6xVUKdt
 XIJn8yf6uEmDpyXkiGJBuIXE9mB4PKIMybVh1J1KIUw7DSm+3Olfod47Sl3IQFiNcNsUTvoZ
 lLD/ABc/pleOFO0YqJtJYG8EcInye7nD9uNfuDZaJ9Cb4Z8cCeD/TpyfgiA0mb1ik8unKojf
 5CBfq6R4W0yDK1myH+9QL4b2LpynyQmnzqMGNb80git1qeYaDiNU7AZPVCSb+c/qqSZvAHS9
 NUZPMyPo/lCbNDDjuDs2dZ7BTg3wbITXs6eRxB/HgJbHjdbJQ==
IronPort-HdrOrdr: A9a23:HoAorKNeQKvq8MBcTsSjsMiBIKoaSvp037BL7TEWdfUxSKelfq
 +V7ZAmPHPP6Ar5O0tQ/uxoWpPsfZq0z/cci7X5W43SPzUO01HYSb2Kg7GSoQEILBeTygeN78
 Zdm/kXMrPN5QYTt6nH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3A7vZnRmpD88KPB1oQ8n7hCpfmUdJ5Slba4WjOH0K?=
 =?us-ascii?q?1GGJ2UKCrGA+95Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:qqYTNAY+4qqcguBT6B7rg2BBZcBTyo+TK2IIoK5YgpO9Onkl
X-IronPort-AV: E=Sophos;i="6.00,261,1681185600"; 
   d="scan'208";a="113686095"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2023 15:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS0JJXPNRvaxgmj2URS2ceSQH/59eCUTCNYW+5trYmgasLLiYJAzkjc6A4NKBGKbbq+12OUE8+mrewBZioQSmdzif3sUBmkTvkVNvuxeFcE4VG2CpjZNrHvThtehQCBfe/B8kHziN9JT/hppeWHXiexdimSdgVMYKdMo6CSbpiWkfTSYZHYlVqMA64ZkTFkl05tixlgFynhU7EwXV3ZlmcVttFytwj8cKDY8XUeww6gfMRLaswo8icNo/j8ehcg40ZPClUIT5hmTUjI+vKlAVur6EYKkhiV2L0FFQIIRS1ON3faoZTnJTp+IjapRXkdctlKjLXGXdf7RjMpvSktApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFoiIgauJUdisXUuZZGm5A44v/YRCSGze0db1HjeRJQ=;
 b=RsQWDI49pAVmjDsIQYpHwSim6lz9n5RQQOgmUucrZZnVJLl+bhDyv0iNYAas3fYYce87zmOFZwAY8O2SzW9nnXFG003Mu07QloqBy3v3QJ4ORWx0Hl3GnPSiR3gqntrrcoGv9f0WIZsV93a+SUZzOJ0sT2iJz0xKH/qjQmeLy9RYcFUKnUoYDxpQPXAypvsNnHIghbTy/0OHjiWoR5lvsBrjL1wvBKFEhw/94kfH58ZJQv41KJ5v5+x3j35AG41EZI5HzsP3NsF+EZkjfX1HgleLGQvZm8PhbcRUhQYmKiFi5BpZEhGFnFgLmQwHBxQE9BfAzsnoV/6BMD+I6wdgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFoiIgauJUdisXUuZZGm5A44v/YRCSGze0db1HjeRJQ=;
 b=iPL6+LP9Dem00Yd0bGHQx7sNFsqkXpfsNX+GzBBmAHnsPb02gRKUCpxz4gHkj+teFe9FONVEO9Kjq0hzUkb5U/YNPObcpveoRFtCI00W8BwOEu41WlFg1dZ8oM+7t6QRi0nnybBfakub2XJzqs1LkjXYKJMDMi2nX/EHKRaZtZE=
Received: from SA2PR03MB5881.namprd03.prod.outlook.com (2603:10b6:806:11d::18)
 by CO1PR03MB5907.namprd03.prod.outlook.com (2603:10b6:303:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 19:05:43 +0000
Received: from SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4]) by SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:05:41 +0000
From:   Per Bilse <Per.Bilse@citrix.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Thread-Topic: [PATCH] Updates to Xen hypercall preemption
Thread-Index: AQHZpFMl91hHG7ZDuUq21h7QjP0mVK+VceeAgAAsYgA=
Date:   Wed, 21 Jun 2023 19:05:41 +0000
Message-ID: <333138f8-9fbe-be5b-d125-12c9d3ed3eda@citrix.com>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <7fbad052-4c4a-4a49-913d-ea836c180dc2@app.fastmail.com>
In-Reply-To: <7fbad052-4c4a-4a49-913d-ea836c180dc2@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR03MB5881:EE_|CO1PR03MB5907:EE_
x-ms-office365-filtering-correlation-id: 6ac3a148-dbf4-4a49-820a-08db728a822d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqn0/hgFPIxzftczs1sbE5/BA0cQbMNjYrmEWqSRRxl7GqQhrPFxXyv6Y67laauCCTdwpMl54tORIrepRUf+xRMqoXABjlXPYkqosjbcuucJvVHimQZAPDQfyo86IS5RjtCnQ5mWEG+G+1dXYCS4qX9N5Ao8UpXmOKh1ZjhaKvx5j7o83a1qgHmIUdskNA4Safz4kaX+NXcaoPxwzEn1zskjP3nvizZk9r6X6RY0oIUcnKHVy39zzY0YCd+Vrugc6BN6xFz1B5isSTyd57KKCtf8A5dJVijPatEC3d39zcwXPuuXZ7OH/LERcnXFFOHdS3YgqekucMeTKneFwbMtN3+mVQjvL4MWkr8acu7E2wS422QKcubVJIzOgpcMMkGUgPtozcM/a554t1JUJFj3HnSpzapoatHZKT4PXVcy3nHAGXRPoDcA9m/ipi2Y4U73fNIL5VPKRBMjT7sVpMCfInGSuGg5t9IXnuHfOKUoZTugDt/0Bk6ClktZ4cKgcT8K41UnitPk2X93QMgU5uR7GbweRg3kpRe+hkVNuqtIXuQ0fd7DEcadYrSlhx1vkDLe2RWv3hl8YnL61Lyk1TrVR3YK+lnaQgPHEuhzFI2ldGLnXYWvh5XI6oeFYKBpVlJ0c+i+gXySPMDkUbliqwrWczdVYPzdDK1AztCgIyuQYJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR03MB5881.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(31686004)(76116006)(478600001)(66446008)(64756008)(66556008)(66946007)(66476007)(38070700005)(71200400001)(36756003)(91956017)(110136005)(316002)(86362001)(31696002)(6506007)(6512007)(186003)(2616005)(26005)(6486002)(921005)(122000001)(38100700002)(55236004)(53546011)(82960400001)(8936002)(8676002)(41300700001)(2906002)(83380400001)(5660300002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjVTalRSNTRWTlY3YjJvNTZ0bzlybmp3K1NoZk41UklaMTZvSEhYVWMvaEtP?=
 =?utf-8?B?Z20xbGs5dlk3ZHhiak5BVXlJTE1LNUtpTDh1VWNoZVJoVlBYcDVwM3VTWW0x?=
 =?utf-8?B?NEkrUEh6S1ZPaHA4ZE10cmwwK05BS3ozL2YyR1hLNjdJZ2FkMHNPMk8rSlY5?=
 =?utf-8?B?VDA3dmtWWjZ4alRicjkrWHZWWG5XUk5uUlh1cjREWlQwQmZhNlY1ZkxZQ0Yz?=
 =?utf-8?B?VHlIZzZEVnVFSGV5WEtCQ2dDeGh4aE5va0pLejhIRXc2QkJsUy9PSGxhV2dh?=
 =?utf-8?B?Vy9vWDJlQ1k0RE4vS3VkL2VXVk40OFBLK21rWE5TOTA3V1JZYXp4Vmo3TmdS?=
 =?utf-8?B?bHFSaGhOdVB6N3ZvSWZYMzN6Z1E4NXEvemsyWVBvVEV2UC9xdVhmK3dDNnRD?=
 =?utf-8?B?Ujg0eEZnMFJtMXd4bmpLNXFKYVJvTkc3WXdFaUFWeGtQdkpxbU9LMHp2SHlh?=
 =?utf-8?B?TTl1OWtnelg2STh1aVY0TGRiOTlBZ1lNZXlPUUVNWWcwUlpBdTM4QlZLVTdG?=
 =?utf-8?B?cUUrRi9zcC9ST3hmMjRkU3V1dXJ4L09LOFovbndiT1gyeWpkSGJSMXcyQUdL?=
 =?utf-8?B?YStRNjdoeURUTnpGZk9ZejIydWdubnE2OG0zUEx4d252YVdNeFdRVnYraDZK?=
 =?utf-8?B?cGk5dW9kWmFwbnZwUGU0OGFwdzFJM3pwZGxjTEdVRzBDL0xZOXMrblF3cnhU?=
 =?utf-8?B?S1d0eFA3VERZbTg4K1ovSG93OXdSbUpqbFg5Yk9NTS95RTdvMVljdjFXM09z?=
 =?utf-8?B?UUhkQkVKMlh6Kzlpakt3M29Ucmh0QXR5cDJYK240bENxbk9zaFBNZE5IYzFi?=
 =?utf-8?B?cDJBNXhMakhvdlJxVm52OG4yNEZHRGlwcUhlSnlkS3B2TU9iamtvYnZqMXB5?=
 =?utf-8?B?YVlKN2xzYm9TdFRTZklNZTRvTVA4Z3kxbTlPVHRSV2NnU0tURXJDU2hzVHhH?=
 =?utf-8?B?VmF2ck15anRGMnpoVDFmRE90TWFJd1ZFYVBiOG5wcWVLSTlKMFZkbHZ3Ukxx?=
 =?utf-8?B?NXlFMzJQczgwWmFGS2R6bGVzZ2lYcFBTSk5zK28xUDN6TjFDNXh3L1pMSXYr?=
 =?utf-8?B?TmhzVGgrLzlOdDhqWHdVMVJrVmg1ZjlPZUJIWkNRcFMxY2lMcjc0VVRIQ2ti?=
 =?utf-8?B?WWNEWU1HWmZIUUNyZUxpTStpcVE3RnQ3eWY5TGV0YmEzSXZZOG9RV0R3akZY?=
 =?utf-8?B?WVpSMU0wRlAxMWI5RWE1a2F1NE4wM3IvOUEvSHdiVmZIME51UDk3cDNBRkp2?=
 =?utf-8?B?RDVZRlZ4ekFsaDRmVExpeUwxaVFmdkRSbVltUFBKUWs5VnRNZmdNckJSdFlv?=
 =?utf-8?B?QlhGMFFvb1RIM3R6ZDM1c0xHWXBHTCtudGplL2k0RHp3SXJyQUl1YzNVcTdD?=
 =?utf-8?B?OTkxN3ZWdS9VQklIRGpSVGI3ZkVSa1QySFpma1VJQThiY2JubWxqYzBnWVYx?=
 =?utf-8?B?bU50U1pYMEljOXBoSW96N3prTk9Wb3M4R0plejl4aUhjdDJHOTBYS3RDM0hD?=
 =?utf-8?B?WEZ3TW1BTWFibU05SmtrRC9ubk9MNkZaMDJlS29SWG5uUndhaG90em1aVFJ0?=
 =?utf-8?B?b1g1a3FpRVlXUkk0Vk9QVUxzSzA4RVNjV05MU3JXNkFESkh1M25zNTM1aVRq?=
 =?utf-8?B?NitFNGlnNWRIMlA2aFRkVld3VmdNRVh6QUlWQ3o4QlVaV2txUHJtTy9tdnNk?=
 =?utf-8?B?cE92MGZ4MTUycVUvRmdPOUtjL2ZxNlVicnRYOWd5dk1JTEVhYURRMWxVNFp3?=
 =?utf-8?B?OEdVZC9kUExRZEpndnFqNDlKQjFzcDR3WlVJRlRhMldBN2p3b0p6NVRtVXdi?=
 =?utf-8?B?a2xvSkgyYWF2V2ZpWXBaYVBNVWhKNE1XSXhjZXBtVjNUWmhnaUJRc0ZzRjNy?=
 =?utf-8?B?Mk5GREdQZENwRGd6NW1mMkJvR2d3Q0hIZGlyaGlLeDFqc2dVTDBYR2s0UHFD?=
 =?utf-8?B?MWpUN1BqYjM4cSt1UVZDK3VhWkR0SGxzWnlmMmRhM3pzdFpScFZhQVpId3Bx?=
 =?utf-8?B?cERkeDZxbDZzYnFScjE1WWhIVkhpQ1YrZ2VhUVo4OUkvZjBxQ0kvSHE0N1RM?=
 =?utf-8?B?ZURhZDJZTlJwbmdBa25Xcnk0dDhlNEx4bEpKTVZLSWJUdW9oVTRCVVN5NThy?=
 =?utf-8?Q?mPo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E9F563EEAC37447B8F8F2DC6C106FA5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RE1nTndVWnRGcUx0dnd6Z1pWMVh3R3FWY1dpdzZUL3BTMktTYzRoSVBPUlg4?=
 =?utf-8?B?SWZ6RlozSHdOUGxzYlJFWkZmb0RjOGVYQnlTeDEyc3BsVG4yWStJd0VkcVVq?=
 =?utf-8?B?T2x2OG8zVVpDQkE3SGNxOFdYejJybzhNeTRzT2xoTWRxcHc1SGFaWmVGdURK?=
 =?utf-8?B?YWpETkViRTVUY3B2Y1ptTWl5MkxoNThNRWM4UVhWWWVibG9IWFN4N3liUXox?=
 =?utf-8?B?VmxveEJGT0tSL1JsbjBRWHZsS05FdkdWRWo4UEVYYkdHeFN3akc1dHJKUXZE?=
 =?utf-8?B?QzVZSSthQ3Nick9HT2pZVnNHc3YxZ3Z6bnYyM3BXcVlzKzBPUVJjNlF5QmJk?=
 =?utf-8?B?R1BhTE5UU0hhRTBLbUoxaGQ0UVZsUlJNeDRzKytmU3owS1p5N3l5ZFI0Snlj?=
 =?utf-8?B?b1Q5aGhCaVFieGMzU3VMR0xNMkE1WmRIaHFNTzVjOG12SGVsQW5xRjVBS0dE?=
 =?utf-8?B?dmdmRzRPQ0RsQTJibURIWERUVTRBUXBwVkEwb09LNEtqdVp0ZmVBVWE2R1pi?=
 =?utf-8?B?eUVkK2orcWt0RDhYdkN2WjUyVWhmZnBZeW1OUXJvZzNVdzRva3QyTFRjUmlm?=
 =?utf-8?B?dGNsaE9PbnhmeWRHTzhJV2xmbDR2eVdHMG00eTlWSW5SeU9tcEZXVFVUZ3FG?=
 =?utf-8?B?Q25aWGNUL0U0NUxtZmhUS0hqSlJrTGVFaE51WW1NWGxsMWZScHkxMXRURXJR?=
 =?utf-8?B?Smo2bDFObDFKSXNJMmtXc1ZoNjNacXBMWUVjL2F6NFVPVFN1Y1FCWjJIOWFt?=
 =?utf-8?B?VzVtL3ZzeFg0T3hOc2N1NHdXSHFFamlRdDFvb3Q1b3ZGT20xMGdYOXNxVDRL?=
 =?utf-8?B?ZytJN1RiQ2RSTC9iK0JWVlQzbURTUEk3c3haK0xYdkQreVpYUFNFamd1aGlu?=
 =?utf-8?B?b1hOZTJ4aHZ5bDVtU2V0UFczeThFYlhSYmprcHMzUkR2MVk3dWt3R045Wm5R?=
 =?utf-8?B?NkxWVVR6aEVrTGk4a1ltakx2VXZQbW15bEZpZnhBZVp6UFVWWHNPbWt1K1FN?=
 =?utf-8?B?d0REOGZjSmVpYmswUHllUUxUWkhoODVWZXJsKzBnYldxSXQrbk9iL0ZEZTZ1?=
 =?utf-8?B?Rkoyb3JCRlFyVnB0enlKYUlGRlZoVG1VSWhQNE8wNUZ4b2pCaUlKODc4SUtH?=
 =?utf-8?B?bUpPaitueWF2dVJUU2g4cTZ3RU5WMHRPS0dpSU9OaWJGQWNsNFNiN2xVSmUw?=
 =?utf-8?B?aWxKR1h5V2JQVHpHL0NjUU5zZmV1LzJoK1Z3QWYzWlhZODhzenNjbkdhTGJF?=
 =?utf-8?B?WlYxeGRaNzN6UDNaZHhyb2JPOGR3T1B5Tm1xQ1FndmlEcGRFYXQrOTV5R2RD?=
 =?utf-8?B?MmczdGFxdExrZVdQYnlGNTJBTENNWnJ0a0xFc01YMTM2NjdsRktaMS91Wi85?=
 =?utf-8?B?dnpwUE9IWkdrYm1wSjV0U0I4dmxhVTdFMnpScTV2WEJCTis3NlM4T2Y1eFBi?=
 =?utf-8?Q?ZkeWDciq?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR03MB5881.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac3a148-dbf4-4a49-820a-08db728a822d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:05:41.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7exsJgDSmvhk4rJRtlPPtVx5ohsFM6H5aBRWwCyj3j+5K9BYEmQ/pTrbEibXmtKO8eWKhTAegKhu49vF5cH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5907
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMS8yMDIzIDU6MjcgUE0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4gVGhpcyBjb2Rl
IGlzIGEgaG9ycmlibGUgbWVzcywgd2l0aCBhbmQgd2l0aG91dCB5b3VyIHBhdGNoZXMuICBJIHRo
aW5rIHRoYXQsIGlmIHRoaXMgd2VyZSBuZXcsIHRoZXJlJ3Mgbm8gd2F5IGl0IHdvdWxkIG1ha2Ug
aXQgaW4gdG8gdGhlIGtlcm5lbC4NCg0KSGkgQW5keSwgYW5kIG1hbnkgdGhhbmtzIGZvciB5b3Vy
IGZyYW5rIGFzc2Vzc21lbnRzLiAgR2VuZXJhbGx5LCB0aGlzDQppcyBpbmRlZWQgc29tZXdoYXQg
b2xkIGNvZGUsIGZpcnN0IGludHJvZHVjZWQgaW4gMjAxNSBieSB3YXkgb2YgY29tbWl0DQpmZGZk
ODExZGRkZTMuICBUaGVyZSdzIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhlIG5vdGVzIHRvIHRoYXQs
IGFuZCBpdCdzDQptYXliZSB3b3J0aCBub3RpbmcgdGhhdCB3ZSdyZSBub3QgdHJ5aW5nIHRvIGlu
dHJvZHVjZSBhbnl0aGluZyBuZXcsDQptZXJlbHkgZml4IHdoYXQgdmFyaW91cyBjb21taXRzIHNp
bmNlIHRoZW4gaGF2ZSBicm9rZW4uDQoNCj4gSSBwcm9wb3NlIG9uZSBvZiB0d28gcmF0aGVyIHJh
ZGljYWwgY2hhbmdlczoNCj4gDQo+IDEuIChwcmVmZXJyZWQpIEp1c3QgZGVsZXRlIGFsbCBvZiBp
dCBhbmQgbWFrZSBzdXBwb3J0IGZvciBkb20wIHJlcXVpcmUgZWl0aGVyIGZ1bGwgb3IgZHluYW1p
YyBwcmVlbXB0LCBhbmQgbWFrZSBhIGR5bmFtaWMgcHJlZW1wdCBrZXJuZWwgYm9vdGluZyBhcyBk
b20wIHJ1biBhcyBmdWxsIHByZWVtcHQuDQoNClBlcnNvbmFsbHkgSSB0aGluayB0aGF0J3MgYSBn
b29kIGlkZWE7IGEgbWFjaGluZSBzbyBsaW1pdGVkIGluIHJlc291cmNlcw0KdGhhdCBhIGZ1bGx5
IHByZWVtcHRpYmxlIGRvbTAga2VybmVsIHdvdWxkIGJlIGEgcHJvYmxlbSB3b3VsZG4ndCB3b3Jr
IGFzDQphIFhlbiBzZXJ2ZXIgYW55d2F5LiAgSGF2aW5nIHNhaWQgdGhhdCwgd2hhdCB0byBkbyBh
Ym91dCB0aGlzIGlzbid0DQpyZWFsbHkgaW4gbXkgaGFuZHM7IHRoZSBpc3N1ZXMgY2FtZSB0byBs
aWdodCBiZWNhdXNlIHRoZSBrZXJuZWwgZm9yDQpDaXRyaXgncyBYZW5TZXJ2ZXIgcHJvZHVjdCBp
cyBiZWluZyB1cGdyYWRlZCwgYW5kIGl0IHdhcyBjb25zaWRlcmVkIGluDQpldmVyeWJvZHkncyBp
bnRlcmVzdCB0byB1cHN0cmVhbSB0aGUgZml4ZXMuICBJJ2xsIHNlZSB3aGF0IEkgY2FuIGRvLg0K
DQpCZXN0LA0KDQogICAtLSBQZXINCg0K
