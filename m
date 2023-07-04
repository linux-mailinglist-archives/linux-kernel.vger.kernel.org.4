Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB021746B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGDHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGDHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:49:05 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C21A7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688456943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WxKuljUVJZ+NeCazNlKEO+PnHvhTo0CW79MzopQi7mM=;
  b=NYjMkzg8uoahsXCm45u4gq/eRD/B+nePdfyzg9Id5JXnWDb3kvi8zS6g
   3WrFpoEFFF8k9gIDUxhL+q1SU2Wb6vPz0YYc5mafAgFDugB6kC/gX1tnw
   ps2+K8mH5IRapKCcw0mZXq+W0d1J5DqisaNXIf7vqygoYLn/a5gY0/3O0
   k=;
X-IronPort-RemoteIP: 104.47.55.103
X-IronPort-MID: 114385826
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:lj+2NasM3pi0McIvwrKA+V1hZ+fnVMRfMUV32f8akzHdYApBsoF/q
 tZmKTjTO/iCamD2e4txPYjnpB8H68Pcx4RiQVdsqyg1EH4U+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Vv0gnRkPaoQ5ACGyyFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwKDsKfjaEvseMkaOBEq5jgu4Bc+u2BdZK0p1g5Wmx4fcOZ7nmGv2PwOACmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osjf60aIG9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAuiAd5JRODorKACbFu71mhNIQw5anKBv+SGmFPhacoPL
 BU49X97xUQ13AnxJjXnZDWju2KNtBMYX9tWEsU55RuLx66S5ByWbkAjSjNCc9UguNUBeS0x1
 lSJktXqAhRiqLSQD3ma89+8tT6uI24NJHEGeAcfUBAIpdLkpekbnh/JC9puDqOxptn0Ai3rh
 SCHqjAkgLcehtJN0L+0lXjDgjSxtt3KQxQz6wH/QG2o9EV6aZSjaoju7kLUhd5CI5yeVUKpp
 2Uflo6V6+VmJY+MlzaERaMCFaup+P+BGDTZjRhkGJxJyti203uqfIQV5S4kIk5sa54AYWWwO
 BSVvh5N7phOOnfsdbVwf4+6F8Uty+7nCMjhUffXKNFJZ/CdaTO6wc2nXmbIt0iFraTmufhX1
 UuzGSp0MUsnNA==
IronPort-HdrOrdr: A9a23:GbkrGaB4LG68f0XlHenP55DYdb4zR+YMi2TDtnoQdfUxSKelfq
 +V8cjzuSWftN9zYhAdcK67V5VoKEm0naKdirN8AV7NZmfbhFc=
X-Talos-CUID: =?us-ascii?q?9a23=3Aguv1EWkgD0+17tbxUQrb/4PDgH7XOX3Wy2f2JHa?=
 =?us-ascii?q?dMzd4cuXSRlu62vxGzvM7zg=3D=3D?=
X-Talos-MUID: 9a23:rv/wGwbH5Mxtz+BTpzuyrSBNC+5S/bmRGl1So41WvJCoOnkl
X-IronPort-AV: E=Sophos;i="6.01,180,1684814400"; 
   d="scan'208";a="114385826"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 03:49:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noPbFuZq2gBGRC6Kwlu74kZYUK6JMkcvfl4XZlikXNlpbL+tMFhEy1tiQuTCIj/ZJhAFwxfEY7zqE5hVN/KHHtcIDfWWbdCnhfhi3nbr0lcbjRLcbnKEDWJ9bhNvIVdL3xQNmQ/Snam26G0Bx9avzd949kv0KP1+jJyPlX3oprx8eUJCUDVYRUYBShcLl98xlX/NNFbBtbsr6RJ2RgWQLl5NhqZN3kUITZhapA04zxKfSfnUgUqoaSWTR3uxU2D4jh157PGvYQEhVZ6vxDdyT/piOZnKAUA1IpyXPl8gKS8i3rab6kSOJpCke3i6swZSnH9qN2+Py0Aet6wvODhAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVM7JbmkIJt65OkIbFHrsl4m6lh9mPKw/yEp9eXztFk=;
 b=AB0QPEZOIOoitfUMG51E3o99wMRWIdODrQYEiE8jaOL2KccFefkurpviTs9Xv1rfTJr4RvKGTwNPrZZW3+yPlsc3a+CYJ33zLDOBz4dq0jamQKQgxQDfV4uHxbx3fImonMJqZ+5NzuJhHoPTpLLgfvZYMumnLi6D7hNfTYrhXa3ZGFnAKQeiVW2r3mQvqhCRC9txLDrCMd0x4CvPrlg21mbtCuACAHFthJsOl/LgzUWV8GUVovvXtrYqPajikUMQJ5lhnKcT/sJjMs9bB2SPDTR+mJp25OVyA5nqX4oDKFSZeYeLgVRPUeDo4g0rCTp6vd04+R37KY/FDgsvb7JcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVM7JbmkIJt65OkIbFHrsl4m6lh9mPKw/yEp9eXztFk=;
 b=Uldcv0RvLtbmYo823umlDPlQt5mjNxJxjssp+zhwI3yo7tCTnzBiLn7hWkysl2O5Cu0b/ixR0HKkWbKyXeYrw6MKqyI3/l1YIAwzIpIVaV8YKA32+hRDTpq2PmiL1QEz7hsIrcqSrLuZa48EKB3MlYfsiU1srD/SoQj3KVwR1IU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by PH0PR03MB6590.namprd03.prod.outlook.com (2603:10b6:510:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:49:00 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:49:00 +0000
Date:   Tue, 4 Jul 2023 09:48:53 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>, vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
X-ClientProxiedBy: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|PH0PR03MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2e5bb6-27a8-4058-fb47-08db7c6320ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPPMGRWwpxg19TNdXgrqP82zwiN3uB3xyd6xF72A3RoObCNVCJSS1l4z058NmJO2m1LeBdW171nX3I45M6MAQu6RNPmclEQ2OKBvdLgdCHJ76jJLTtHXEzYSsJVVuRk9+eeVGk/PGA3c/qLiP2QINABEdX0rcJiRvemwBs5urjruaer3caW10OWJtNOcRPFLbEZlLwYODGOS/Jl99uUnbBBJyp6CP9oEIlTi8NfVtzVOSh6OX8LlNOlg2xsF9Su/XYF74TIDF2XtSFIdjWwnvN8SkMJkuiS5KqvrEVP1jsY0EGjn1oQjlaSvNa2JE9xsycOPJqjUmpeJ5Bvfq2IMdz9KJ99ucovk3uuSq6vnUNpkq229OmUkjLZhPHQzium8eZfYLK7Sjy6xGIOu/S0e/gVVrqmHx5zmzh7RniOjkrCrGXXJboAG+zIWgpHRvwnwdpHkRLgyrfxVMquPYFDEsqkwMlfhlRAp3QYH/gmNG1PJNlqokYz3BEEkRLPi3/HHNR2x9SNs8YopslXjX9wj+0htX8Y/pA/932l+CgS8q7GFo8i7YoR5AEKh513KXOgu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(41300700001)(8936002)(8676002)(85182001)(5660300002)(86362001)(186003)(478600001)(26005)(6506007)(6512007)(9686003)(6666004)(82960400001)(53546011)(6486002)(316002)(6916009)(66556008)(4326008)(66946007)(38100700002)(54906003)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3k2cEdYTGExdmE3R0Y1enBNakY1WHhTRW9vdDlzSCtnNU1SbGovZnBEb1pi?=
 =?utf-8?B?Y2FpVzF5N1FiL3RaMDFrRWx3U002dXpqK0NpNkw2U05mWkpPRmlEcXNtVHZw?=
 =?utf-8?B?VVVyQ0lIM1JYZ1VVRHdhcEpwcGRWdDNrSlREdXFwaExUb3Fodm9EN0YyUVFz?=
 =?utf-8?B?VWI2MGtVZm11cUYzVEtnd2JSUlNYYnY5RGovQnZWQ0xRNjZlYm95Nmt4d25V?=
 =?utf-8?B?Z0c2MTQrSXRjWXhlblh0dkVaajc1bndIaU12Z1l6bm14SXZwRVdBQmdINlpm?=
 =?utf-8?B?cWdRODBUSE85dStZeHpzWW5yNDJrRjJCcytGN1N4T1F4bjJsaDVvckFLK0Jt?=
 =?utf-8?B?eWxOZW5PZ2RXYTkwclJVTTNVV1VyaU0yVkZJNVdoVTJKY0l1aW01eUtlN25P?=
 =?utf-8?B?RW04bGRJWHhxZzhRaXQrOGtkOHhRYnNaV012cHJRQXFvdXNndlhJaDhCZGI4?=
 =?utf-8?B?TG9YQjF0RmJNblI2cm1hemJ3ejU1dW9ERTYvMStNZm1kbVY5MmV2NW5EdXVU?=
 =?utf-8?B?bVNUR1MxS3pQRHdDZGkvQk5Uc292cUljY2tFcTBNOHdNcWtpNTJzRTNGWFZK?=
 =?utf-8?B?NE1lZERPUWNNNzJtYzRSdXgzd2g5eGNZUWNpRzk2MXpET0I1RFYxMXFUTjJV?=
 =?utf-8?B?d3BRNDJtNjVlTDNmVmtSNmRGdlBOM056QStyVERrOXdjUzY4U016cmVmbmk2?=
 =?utf-8?B?QW9xc2ljaXNNU2toNC8rSHRXSU5JUlA2TVlrY2RkZGd0NHlmdDRHeXRLeHBQ?=
 =?utf-8?B?ZzZWeWowVG0wcm9mT0VKMUZCR2FERzJjTzRBWmFaMytvL29wOHdrVlVacWNK?=
 =?utf-8?B?TzJBRkVHNFk1RnE0Vlo1ekdqUS9ZWC93SFdZM0pjbCtQSExvQTBxeFI4cXJ6?=
 =?utf-8?B?N2ZZWFNnbFJraFprN0VyYmNNY0loRUp2MXY3WFdadjZseDkxMjRaVDNPZUsr?=
 =?utf-8?B?emlzVzRkTVNsOUZNZ0owZmpXRWthakpVdUhNNVJxOFF5UU56WnliQkNTVHZ1?=
 =?utf-8?B?MVRmMHNDU3A3WG9KUHF2MWZFRXpDcWVtSlI0NEg3M3NvWEdoSjMyc2FyaERW?=
 =?utf-8?B?ZWRtRzBuNmlwZGVNR2ovUE44cmp6WGF3U1U2WGVWTHkxMG1INXpkdTlPZDU1?=
 =?utf-8?B?NVlEQTQzRHk5UVlEbEtISDlaME81aU9FNkxIczNlUE1GNHFsaVdtK3NHSzNq?=
 =?utf-8?B?dzFMSUpwMVRhOE5pMHhOVFZaS3RVeU9sbnpQaXdKOHUvN1BHK3FqYzVWOUlU?=
 =?utf-8?B?N2JkSDUzS2NyajlmSThmZ3VmVVl5L3YvVTRUWlphcldzWitmSXJxM2xTUFF4?=
 =?utf-8?B?RzFBUUxaQlRTNkV5YUxXNTZRMjB0dkE0Q3dxaXRteWxCVDdpRHlkZTIzeHVp?=
 =?utf-8?B?V3F1MUVFK20vR1RRajNGaURHbWdwZTRzSDloV1FDQmdRVHpObUI4MnNFV2hW?=
 =?utf-8?B?bXM3T0ZCeG9mZkcyMDhvM242YnBhVyszY3RLcnVTSXVKSncrdjdxdEJyUG4v?=
 =?utf-8?B?ZEVjQ3ZCcUsyYUZWWHlYWFJENTdYcWhwK1VUZDVzZDlMOVFMKzgrWDVKZWpm?=
 =?utf-8?B?cFlhdE1GVmIrZExkTTF0TS9Obi9IQlhvUDJMSU5GZ1JVVWljWVlTZUVsMXla?=
 =?utf-8?B?djljT0pjWGFyVm5CSHk5Z005SmNLUnJiQU9hWTVyU3VxK0NmVXQ4TUJVcktk?=
 =?utf-8?B?OStjT3VHSyt2RzQ0Nlp6RExEMzdibk03K3Zobk01eGk0NC9xNCswR0g4SWlr?=
 =?utf-8?B?NFpnN1k0a3J4TGJxZFpTajdOSXBTSFJYNEZ6OUVDdEluNEwwS2lkSXNOUjdJ?=
 =?utf-8?B?WkRKOXJCTWZkemxSODl1ZHRTRmFWZTVyMitaMUhCMzVRUFUrSnhKNUEwL2RY?=
 =?utf-8?B?UWV1M2NkaWxKT1FjQ1hOcXUxTzRra2pwNUkybjU0aXRndlBwQnZLb2EyZzRJ?=
 =?utf-8?B?SFRNOXdsK3FQNjQ3eStVZURjaXNNSkNKazlWTHBSQXN2RWVNZzJTczMvQzFs?=
 =?utf-8?B?dHVhWHhNU29ZZ1A4YzdtbDRVY1Mvb2wra3RpK1JXRmpDQXp0c0wwR1lycE4x?=
 =?utf-8?B?Z05KUXlhUEZwWldFOTh6SVVtNXBQS1pORWtjeWVaajVTb3BjL3NLZ01RSWJM?=
 =?utf-8?Q?DDjsh9gtnIrMKZ6UhhDgdxPbq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jTcxuEXcNjkNjNiQLxMzGf/RZCikpJlwQ115HQZ677f+Edp8TIVAMpyZNfaGuTHbzF1NnTWtyjEfPxC4Xrs33mcetDlbqHxkJCwf+K+S/uiKk7QIXBJYLSIMXdIJFrBtP1XaWqGskcu8wmG6oZ5J6xY0CJ1RJWjfRVwS3416yrszDngyGtBc9PJQoI44gQ+NKMDmp2iFWEqyXcW64jHvTBS86Nd+koqBWs9UE9MFagpbYBR76OdYwVEob031wV7+DUkx8ocAA7QG2HjcNf9YDs4KGGoC7Po1iidaSGNBwdPYKI3QuFUvCsZD7ScLNXQTyeNCBwQ+xBf/H3uK4cdutATNRq5ZBI+CAElsfKGnIbN48PfHqVUgHi2pRU1xSW+ozwrs2S5AHedRkst3OOKf5iqGXjgtr4zwgxbCyhOL8e5WrIDOdiAMdPmQ0FrTyzLBkkxmzR8xAQvZKR5Wfhw2EUajrxQWBXPA7ccQiNFYibIZ+wS27bi26b4qVJS5jjI+IUtazTUWrA2oqDiPnG44dVZ/cR1ZWWzHedttR+apXfjIUsWDEDzbBcFjWYpa6ZOo7JcpST4GXYY0ABkLrN30bnjlqaqgKkaabROHCjVHp38NzXZ+ZJhJGOUeATAW83Jcg60VG59gXJ3wkzEqWT9qqsfNx2xF4dV9gfTLz+DJQsljMnMNE2Rnw66M3JSL1IQCbhSHWwVMkHTLkdzPGKGbho7pqmo94YmonokpPmADQO5hcdMkCPAUjf7JUJGsRlUsyznRWnkKvj2nMuBFwLaTe3FyvHUiS+jcMDZWN3OLQolhKqVf1tdYnuEFv80vIiESb2ZDDa5UuOMHIIdiq/cQdFR1v3HqqNy4TbSW1OpbZemOVrzJljB7TknyHGKP+ObvlGfqBEId1GWXcS+HwEnwTBuUjumVYa/SuJHH/9DRI0I=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2e5bb6-27a8-4058-fb47-08db7c6320ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:49:00.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tL/1gYU9NmIv1ItM1+6V9i3uMXtQZHkb5cQhsUh1MqwsJhdncuSe+jGbez7ze6XRYybNBlrSbksd0sL+pS/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6590
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:44:04PM -0700, Stefano Stabellini wrote:
> On Thu, 29 Jun 2023, Oleksandr Tyshchenko wrote:
> > On 29.06.23 04:00, Stefano Stabellini wrote:
> > > I think we need to add a second way? It could be anything that can help
> > > us distinguish between a non-grants-capable virtio backend and a
> > > grants-capable virtio backend, such as:
> > > - a string on xenstore
> > > - a xen param
> > > - a special PCI configuration register value
> > > - something in the ACPI tables
> > > - the QEMU machine type
> > 
> > 
> > Yes, I remember there was a discussion regarding that. The point is to 
> > choose a solution to be functional for both PV and HVM *and* to be able 
> > to support a hotplug. IIRC, the xenstore could be a possible candidate.
> 
> xenstore would be among the easiest to make work. The only downside is
> the dependency on xenstore which otherwise virtio+grants doesn't have.

I would avoid introducing a dependency on xenstore, if nothing else we
know it's a performance bottleneck.

We would also need to map the virtio device topology into xenstore, so
that we can pass different options for each device.

> Vikram is working on virtio with grants support in QEMU as we speak.
> Maybe we could find a way to add a flag in QEMU so that we can detect at
> runtime if a given virtio device support grants or not.

Isn't there a way for the device to expose capabilities already?  For
example how does a virtio-blk backend expose support for indirect
descriptors?

Thanks, Roger.
