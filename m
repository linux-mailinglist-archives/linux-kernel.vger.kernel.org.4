Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93374B331
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGGOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjGGOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:43:03 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76691FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688740978;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=df+/rVJMYWXW1GBljmz9n57ywdi33sqr7imjf2Q7/Ic=;
  b=ORlQqQKPd1mxdti/gwKhroFRixnW+1NdbOZAg6z9gzRXSpDVp1WueNP2
   LxL+PO69iWzTJCy0M6nzGpG4FkHYWoidubUSMvjw7oJQdLshWgLU/jcB9
   nGQ3Oj5sTouPwqnUxziqcNaIOEC3So023JCD+7tKF3NLexaN+v6jT9Uqe
   A=;
X-IronPort-RemoteIP: 104.47.70.101
X-IronPort-MID: 118064505
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:aHZxcqMcx87yyELvrR3tl8FynXyQoLVcMsEvi/4bfWQNrUp21DACx
 mcfXTjVMv7bNzD9e912PY+xpB4DuZSHzIMxTwto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/vrRC9H5qyo42tH5gNmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0spQMV9O5
 aY0ER4qQQydgeyf0JiZFPY506zPLOGzVG8ekldJ6GiBSNwAHtXESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+vJxujCKpOBy+OGF3N79YNuFSN8Thk+Fj
 mnH4374ElcRM9n3JT+tqyv83rGTwHumMG4UPJam/Pdh2mS3/E0sIx06cWadgeiVk0HrDrqzL
 GRRoELCt5Ma9kOxScLmdwalu3PCtRkZM/JLCPEz4gyJzqvS4i6aC3ICQzoHb8Yp3OcxQTEpz
 UOYhNPBCjlmsbnTQnWYnp+RpCm3MDIYLkcDYzEFVgoP59T/oIA1gQnLR9wlG6mw5vXSHTzz2
 DmMoDIJu6QIjcUL2qO4+njKmzup4JPOS2Yd/gjLRCS95x19eaa+epelr1Pc6J5oPIufC1WMo
 nUAs8yf9/wVS4GAkjSXR+cAF63v4OyKWBXYgFhyD9wi+i6r9nqLY49d+nd9KV1vP8JCfiXmC
 GfNuABL7ZoVM3KwbbB+Z6q4Dshsxq/lfekJTdjRZ9tKJ5J3KwmO+Xg2YVbKhji01k8xjas4J
 JGXN962CmoXArhmyzzwQPoB1bgsxWY1wma7qY3H8ilLGIG2PBa9IYrp+nPXBgzlxMtoeDnoz
 us=
IronPort-HdrOrdr: A9a23:KG0OVKye8Ofveg6HyYo3KrPw2r1zdoMgy1knxilNoHxuH/BwWf
 rPoB17726TtN91YhsdcL+7V5VoLUmzyXcx2/hyAV7AZniAhILLFvAA0WKK+VSJdxEWtNQtsJ
 uIG5IUNDSaNykfsS+V2miF+9ZL+qj5zEir792usUuEm2tRGtBdBwQSMHfqLqVvLjM2fKbQjP
 Cnl7d6TzzLQwVuUu2LQkMrcsLkvNPxmJfvcXc9dmIaAFnnt0LS1FbieSLopCsjbw==
X-Talos-CUID: 9a23:I3DevGH0qvPg+H6qqmJL034qGtB/XkTz61jMPUm2IHZDauOKHAo=
X-Talos-MUID: 9a23:T7+x3gtidFYnJpNMJM2nry9oPcwy2oCUKX8mkbkihu+kJABpNGLI
X-IronPort-AV: E=Sophos;i="6.01,189,1684814400"; 
   d="scan'208";a="118064505"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2023 10:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORqETL8Af23G67UQJ9qz1OE5dhvTV3D8lZfNIauT8FbutI/l226+NtLCDbwl8ATHxyUfbNovWacE/7phLPYqTfZZ9EWPb7080ebmjsUfoVsHxC1knjhv5EjVoymjvToa7IXQinsabMSK/fLfI5RuZ4VWg5Wps2P8965XqfDB4mVZr1YJwV1JJFAOx8iqbE/H0Pdp8owfCeyHH++mZbFhRjAsgKHc9gMJONWmKWpLWINNVGIy5weM9WI6TptCDgLgrVGMt7Y0RUnYtfd/HGYDLNyGPIrxKNzxY7EOIkwChk7YEgv1UyzIMjFsL+mRR6VeBXKVo2ffswqxZpvkp+higA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yflHwoduI6GXqH85ABFTPEmbWuDt3ZiTPT/VoKcCoVY=;
 b=AUgFasKH5HHGNDh3xkbZACsxXCu+IWAZpfT5H8R/0mRm0vDoHrM12hjgxR7kBArW2hodIyECgNvkXMvzTWq/q4fLK4Rq/pV+5X0hit/Nnzrh9uy4Xr+lBwG+5wSw1245wfy0YMTFnYMi5DFVGOwI0M2by2IPTzdWpbYR3N3QSyt2tT2LcPkluMfcw023xgD26ciSUgjCbFebgzPFH/K7DOH16alcZpj7tUDA7KB9aD/p8zNXai9LH4DZO4aqBxD+lSjVlTaIObkgJXEEheBS/0aWU2ulRnhEH2Lcqwm8MhabW96ZkU7k3GFvc+d3kyn+pxS/Cp94p1Lx14ubSIuEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yflHwoduI6GXqH85ABFTPEmbWuDt3ZiTPT/VoKcCoVY=;
 b=MZ4Hxrs8vc0o0dfqarBRjWVDzBOjffyFZwrNyXHqfMNUxE/C9PLCBRnruzSuHwXbT/XvqPomuYmjgwLfZC1rOfOyP74v/Oegtp5gGsM5g+uuLkYPkEmoz2nmD8CodJ+WMsKAKFdzLDqPcNcxn6oXea7lY7c6DeUh49kNBE1JA5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by MN2PR03MB5118.namprd03.prod.outlook.com (2603:10b6:208:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:42:46 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 14:42:46 +0000
Date:   Fri, 7 Jul 2023 16:42:40 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
References: <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
X-ClientProxiedBy: LNXP123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::20) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|MN2PR03MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f5f080-a5b5-4a96-3ed4-08db7ef86db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYDwjhE9GQo4adxLGZCw1M6GtoR9J7zJ/QMWhvXBUmLOvt0nEKC77hC9fvjP0nH+qwgpJ4mOlNK+gvV7VLPlTxk5yPWotqPYU/hHOD5caaZ/SPwA4SiANGAwwFlNfuHeOUmy/xHno3htwyVViyLtiXx2/QCUXnG9T2ehvlXV/5N0/uicKC+fOdVu7R+eqbQwpXGBHjszHQXPa8OZhUDAg8+aD7Uc45XJ6diiJsh3qtxqAFjJ9YuQkSDuCCew7uVLxMmaXwLncFiNsP7MpqHTY71MCxr13fFMj+g7qqK+E4PDkLMxid+fFptP5bNM8p4YW+e7vt9xlFd+wWO9D9lOH9IrxYy/MqyUP6XoibAhtpWaRwh1Lb5gN4NQPYGFjzfLdlvNh2UGf2piK/TuDKSnyor8Pce2txZN+PzuqRSGFw0bT2j2kyOz8HS3ZBvMmpyeWEfZlPvQMg/ocro93DL2OTdCfwkAli32L5GClruQqOjjcJy0hpGqJ1S/wRgsXeuLFOukiQEwiJyI5MnfPuBdSBYSKaNN+wUjJqSieCmWAsYceF0PbOSkKkQihPemnT+0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(6666004)(478600001)(6486002)(54906003)(53546011)(9686003)(6506007)(26005)(186003)(6512007)(2906002)(41300700001)(316002)(6916009)(4326008)(66556008)(66946007)(66476007)(5660300002)(8936002)(8676002)(38100700002)(82960400001)(86362001)(85182001)(83380400001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlLVXBKL09qRTNBcnNReFJhU0hXaURheXpiRzZIemJxRkQwS1pFcjFHRGJt?=
 =?utf-8?B?Z010R1h4M2phSXlKMTZCank0eVZ4Mk43TmR3aHNNOVNnWTZVTDFKOUVWSVM0?=
 =?utf-8?B?SkZ6STh6aVFRTm1YK0R3QzIvRy9IeVZsQVltcXVqOWxQRktyZ3VHRFQvbVh0?=
 =?utf-8?B?YzVQL3pacGZuTFF0TGZFU0k3YytUZHN2VzVkRUVXZFFKK0ExdGZYbUtMZFJK?=
 =?utf-8?B?cENMS0VqSGhtcTJDRmJTQUw1eGVjYUZ1d1ZHa0JZNU5Cb1Z5WmZBRlJYT3N6?=
 =?utf-8?B?SzY1OXRSL0ZZeFhYV3k3WmxjMEh4bGw2UUREdlJocE55Q25zZ2tIWGFRY2Rz?=
 =?utf-8?B?aUZBcXk3a3RDRldCMUZlenpUVSt6TGVXcnBnYTVNRS9qMlM5aE5Sd0hKNDkr?=
 =?utf-8?B?SEluT0FJdVlUQmZWWGFSejJYbkNxY2xOZjNJcVR4Sk1qSHJHL2lkaXZremZs?=
 =?utf-8?B?d21VbEl3OTIycU5OS3RVYnV1eGRJRXpRTFAwUDhXOEFHQm5HaDZiTWl4emhY?=
 =?utf-8?B?aStTRVk1ZzBkeUF0d0lDUEJGL3VGMm5XazJYWXlGbStsVkNyRWF3OGduVFJv?=
 =?utf-8?B?bGxqUWtIVTkxWnBuSVRsRXVTMElETUxHMVQwS1RBVkJIRG5OQlVrdEc1elc3?=
 =?utf-8?B?SW44ZzBCYWNhWmREZi9oMXVnV1FhZXJvL3FRTHBUbkNlUUIrWEEyS2FCL1pM?=
 =?utf-8?B?ZGNFSmVSdjUvUEJQZXEyTElnY0ZLNHNzM2tiOWJTamhseUNnejMyYTd2NFJW?=
 =?utf-8?B?NFNOc0FJNXUxMURsZTI2dlZqSGZZSmlPUVdKWEZnejlBak84RXBSbEtiK1Vu?=
 =?utf-8?B?WUwvaGw0WERxN214UjJkM0ttdHFhVERxMDdibGNyUSs1MVMrRStVdmpEVDR4?=
 =?utf-8?B?bGFiVjd1aS8wUzJlaDNnS0dZMFZOVWpiM0tLaERXaC96QjNDVHB1aXU2NW5Q?=
 =?utf-8?B?cHIrRFp5N0p0YS9vQXBNa0pDRFgzYjRoQUNUYmVQUHYrVnNITEtNVzRtbTNU?=
 =?utf-8?B?cEsyclowMHliaFZGVW1xaGgvZ2k4WndsWnpUcUorNjBybmFrbHp3ckd2QWpB?=
 =?utf-8?B?Sk9PSWtqeG1kWWtiaXZxT0JzWFN1Z2M1VUM4YnFIY3oxQTZqR3RMakJlakdz?=
 =?utf-8?B?eEluTW1HWnRaYzNOTnpHQXozNVdaNHZGTWJOM2s1cXZVZ0FSVy8rd3lJejVX?=
 =?utf-8?B?N3Q5YWoyekl1NWUxckJaVlpuTHZkbGhNUXVvME5LMGtwOW1TUlBhT0JzMTFX?=
 =?utf-8?B?c2QvQ240NDFTTjk3OVQzeWN0YjNodkswQ09NSHJlVHVmTGx5VWROYkM1bE0y?=
 =?utf-8?B?S1AyTitCaXFhU29RRXpNYmFhOVFaSUFOVzRhZThRNkZKOFRhQVFIc1ZEWTJF?=
 =?utf-8?B?V1lKdnlyWTYrRVVuS25tWTZDZU9GdTIwOVl5YVFXZlZseUprODNHNVh0aDJa?=
 =?utf-8?B?SU1XdnR0MEpPbExsVjNSVjBSajh6dmdBeW5BU0dpTUorc2ZReFRwcUZmOTFh?=
 =?utf-8?B?SWxSUlVEUjd2b3VWdEtvTWMxUyt6SW9HbU92SFdZT09tVkRyWGpmL293RG95?=
 =?utf-8?B?aGFWcDZTSGI1T3ZhT0JDQU9vaDF4Q3dNL2JRUFhqekhwdlJ1MTRtU1d4NDZr?=
 =?utf-8?B?N3ZCRHFxaUNudzIyWUc0YlpKTjU1ekFhYlprWVZJN2szKzRUMDNQV2dGQWxD?=
 =?utf-8?B?UllheG84bTk1VE92MFV1STlxbGpsSjhZQUFiOXZEZnc3bTBEMXQrMURydUVT?=
 =?utf-8?B?MU5WNkRFY3B0VCtXSVd0KzRSUzlDUE9WZnIzb1ZWSGI1U2JLeVJ6QXNtVkg3?=
 =?utf-8?B?RFhXeTcvcWZjUFRaTVdFQ3FjanhLdEVaRlBjKytwRzJjZDZidFcrTmVQa2N5?=
 =?utf-8?B?ZThWeWlqdUtkRU1pcDNGcDdMdjVvRVh0enVPTUJreUtjOFpOM2tlSmlpRFRN?=
 =?utf-8?B?cVZjVklpYnlhU1ZTYUsrajNiSm5TMHBUdHc1aG1CMVQ4eTJoaVZraENzWmxq?=
 =?utf-8?B?WUI0Mmhib01KNE10U2FyeDQ3WlFta0trRjFmSjBKNlJJWE9ReHdOTDU4UzlO?=
 =?utf-8?B?ZDk0Yjg5dzl6M3pkLzNoYS8xMGVxRWptOE1laXh1N1ZpSTZtN0c2VVJzeGY0?=
 =?utf-8?B?QkhXN281Yy8yS1FCamQwK3IyeXE2aEFPTHVQL0M1RFpuYTJva2VaVkpjbVMr?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UUUvcXlQazA5Wm9DblI2S2FwL3A0ODB6VWF0Yi9nVWY3T0dpSmdKb2ZJZkFQ?=
 =?utf-8?B?bXNrNGFCQWdaK3VVaXZKckhua1EwaWNpOFU0YVRrbnNUS09BQlJhSHdsT2xk?=
 =?utf-8?B?K2RhL0V2aHNURjJidE5CNDRnVS9hcnVWcm02dXhheUZEQjNudldLNGttb0E0?=
 =?utf-8?B?d0w1NkhhQkk5MjVIOENwTXIzbVQ2MXJLUXBuTGdIZGQzbENkMmtSQWM1QjZU?=
 =?utf-8?B?WDZzZm40TzMrNnBNTnQwcWVKQVNjNkIxSGlmemZOREk3M1J4T0lHem84S1BC?=
 =?utf-8?B?Q2pnV2xHZFN4OWJTTTRST0NzZllBRStLNWdIZVVFR09CZ2xXYm1rZlhvYjRJ?=
 =?utf-8?B?TFBvZGlPRWNJeGpjMDBSNUFsZlpUYU5XL055WGgvaTBDUEJQbWdSWFBMa29I?=
 =?utf-8?B?NjhrQ2hDU2hDV1ZzUzl6MFhUeE5HdE93TElXMTVSczBFWnRVdWdzSklzb0xk?=
 =?utf-8?B?SjRXTEQxU1hEeU5GaE9FaFkxblY0U1NFQ1RhUldscmtBUGZhR2hwQTdtRHBS?=
 =?utf-8?B?OWFCVFZ0bm8zM3A3V20wMnRhYjRMbHMwaGpwR2lUR2NCdVB3YjMyaW1iYXdV?=
 =?utf-8?B?K1JJb1Vrd2VDVHZ1cjUvWWdYOC80cFhXMURYUTU1RkM4TVA3RmFwZks3U2hn?=
 =?utf-8?B?Z0N5NHFYc0U1NElLZE1wN3cwVWV2a3k4WG8zQy9NQ2s4VzNnTHJBRDFGOTRP?=
 =?utf-8?B?QVVnTVQ5QndMZzI0eE5jWTZIZFc5NVZGV2FkaU1SU1pjbkk5V2pZRVRIRUhO?=
 =?utf-8?B?YkJoMGQ1NzRWTVhhajRGZVR1ZCtZbWpiZ0craEFnUjlKMXlRL09RU2VLWThY?=
 =?utf-8?B?bjBTRmNoa1Fpa2lFc1VPYnlRZWw1Ynd5dG8zVWE5NnNON09BWFp6b1BVNGZF?=
 =?utf-8?B?amJvQWk1TXZPUHFvclgrM0VvalV0N1p5azAvbGdmcDlHL0M1RzRxUkFVZ2lx?=
 =?utf-8?B?Ujg3L2lFZ0R1ekxuMGxPNGhQcjdWeXFvMVp1dG9GOHpGcnYzNTU4VEw4NDRi?=
 =?utf-8?B?bWV5RGZVb1ZNKytoWXZwYWluak9UakxiR3hOMTBNcTRxR2lQM0xWc3QyTjNI?=
 =?utf-8?B?b1NldDl3SzR2dUlmc3V5R0J1elFhMHUybWdXbytqamZ3dFR2akg5bmdrK0Zl?=
 =?utf-8?B?cVR4UmZYcy8xREZsRHQyc3k5NWpvQWhpSUdLVkpqRlYvZjVxVHpLbVE3R0hw?=
 =?utf-8?B?TFR1a3FqVDVlMHYvTW0vUmgvNmR6U1VTT1lQTVY1N25hRXBXN0d1aWhlbnJt?=
 =?utf-8?B?MWUycjB1RGZSbDFhTmljSjVSR1RlU09DT2RiNjFYcXVEeG5TRFVEOFJGamlY?=
 =?utf-8?Q?J6i8LjEYMvQLLGwKFIF458jNR34buDTqEO?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f5f080-a5b5-4a96-3ed4-08db7ef86db7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:42:46.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCnctZIdTddcqOnLQVmWVlZ+yoQbukY4aERZZeWN5JK5D+eir88x23pMHyeBKwnwYhMxauILSEq3ROfGR383FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5118
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:10:14PM +0200, Juergen Gross wrote:
> On 07.07.23 11:50, Roger Pau Monné wrote:
> > On Fri, Jul 07, 2023 at 06:38:48AM +0200, Juergen Gross wrote:
> > > On 06.07.23 23:49, Stefano Stabellini wrote:
> > > > On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> > > > > On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> > > > > > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > > > > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > > > > > > Part 2 (clarification):
> > > > > > > > 
> > > > > > > > I think using a special config space register in the root complex would
> > > > > > > > not be terrible in terms of guest changes because it is easy to
> > > > > > > > introduce a new root complex driver in Linux and other OSes. The root
> > > > > > > > complex would still be ECAM compatible so the regular ECAM driver would
> > > > > > > > still work. A new driver would only be necessary if you want to be able
> > > > > > > > to access the special config space register.
> > > > > > > 
> > > > > > > I'm slightly worry of this approach, we end up modifying a root
> > > > > > > complex emulation in order to avoid modifying a PCI device emulation
> > > > > > > on QEMU, not sure that's a good trade off.
> > > > > > > 
> > > > > > > Note also that different architectures will likely have different root
> > > > > > > complex, and so you might need to modify several of them, plus then
> > > > > > > arrange the PCI layout correctly in order to have the proper hierarchy
> > > > > > > so that devices belonging to different driver domains are assigned to
> > > > > > > different bridges.
> > > > > > 
> > > > > > I do think that adding something to the PCI conf register somewhere is
> > > > > > the best option because it is not dependent on ACPI and it is not
> > > > > > dependent on xenstore both of which are very undesirable.
> > > > > > 
> > > > > > I am not sure where specifically is the best place. These are 3 ideas
> > > > > > we came up with:
> > > > > > 1. PCI root complex
> > > > > > 2. a register on the device itself
> > > > > > 3. a new capability of the device
> > > > > > 4. add one extra dummy PCI device for the sole purpose of exposing the
> > > > > >      grants capability
> > > > > > 
> > > > > > 
> > > > > > Looking at the spec, there is a way to add a vendor-specific capability
> > > > > > (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> > > > > > today, Linux doesn't parse it.
> > > > > 
> > > > > I did wonder the same from a quick look at the spec.  There's however
> > > > > a text in the specification that says:
> > > > > 
> > > > > "The driver SHOULD NOT use the Vendor data capability except for
> > > > > debugging and reporting purposes."
> > > > > 
> > > > > So we would at least need to change that because the capability would
> > > > > then be used by other purposes different than debugging and reporting.
> > > > > 
> > > > > Seems like a minor adjustment, so might we worth asking upstream about
> > > > > their opinion, and to get a conversation started.
> > > > 
> > > > Wait, wouldn't this use-case fall under "reporting" ? It is exactly what
> > > > we are doing, right?
> > > 
> > > I'd understand "reporting" as e.g. logging, transferring statistics, ...
> > > 
> > > We'd like to use it for configuration purposes.
> > 
> > I've also read it that way.
> > 
> > > Another idea would be to enhance the virtio IOMMU device to suit our needs:
> > > we could add the domid as another virtio IOMMU device capability and (for now)
> > > use bypass mode for all "productive" devices.
> > 
> > If we have to start adding capabilties, won't it be easier to just add
> > it to the each device instead of adding it to virtio IOMMU.  Or is the
> > parsing of capabilities device specific, and hence we would have to
> > implement such parsing for each device?  I would expect some
> > capabilities are shared between all devices, and a Xen capability could
> > be one of those.
> 
> Have a look at [1], which is describing the common device config layout.
> The problem here is that we'd need to add the domid after the queue specific
> data, resulting in a mess if further queue fields would be added later.
> 
> We could try that, of course.

Right, we must make it part of the standard if we modify
virtio_pci_common_cfg, or else newly added fields would overlap the
Xen specific one.

Would it be possible to signal Xen-grants support in the
`device_feature` field, and then expose it from a vendor capability?
IOW, would it be possible to add a Xen-specific hook in the parsing of
virtio_pci_common_cfg that would then fetch additional data from a
capability?

That would likely be less intrusive than adding a new Xen-specific
field to virtio_pci_common_cfg while still allowing us to do Xen
specific configuration for all VirtIO devices.

> > 
> > > Later we could even add grant-V3 support to Xen and to the virtio IOMMU device
> > > (see my last year Xen Summit design session). This could be usable for
> > > disaggregated KVM setups, too, so I believe there is a chance to get this
> > > accepted.
> > > 
> > > > > > > > **********
> > > > > > > > What do you think about it? Are there any pitfalls, etc? This also requires
> > > > > > > > system changes, but at least without virtio spec changes.
> > > > > > > 
> > > > > > > Why are we so reluctant to add spec changes?  I understand this might
> > > > > > > take time an effort, but it's the only way IMO to build a sustainable
> > > > > > > VirtIO Xen implementation.  Did we already attempt to negotiate with
> > > > > > > Oasis Xen related spec changes and those where refused?
> > > > > > 
> > > > > > That's because spec changes can be very slow. This is a bug that we need
> > > > > > a relatively quick solution for and waiting 12-24 months for a spec
> > > > > > update is not realistic.
> > > > > > 
> > > > > > I think a spec change would be best as a long term solution. We also
> > > > > > need a short term solution. The short term solution doesn't have to be
> > > > > > ideal but it has to work now.
> > > > > 
> > > > > My fear with such approach is that once a bodge is in place people
> > > > > move on to other stuff and this never gets properly fixed.
> > > > > 
> > > > > I know this might not be a well received opinion, but it would be
> > > > > better if such bodge is kept in each interested party patchqueue for
> > > > > the time being, until a proper solution is implemented.  That way
> > > > > there's an interest from parties into properly fixing it upstream.
> > > > 
> > > > Unfortunately we are in the situation where we have an outstanding
> > > > upstream bug, so we have to take action one way or the other.
> > > 
> > > The required virtio IOMMU device modification would be rather small, so
> > > adding it maybe under a CONFIG option defaulting to off might be
> > > acceptable.
> > 
> > Would you then do the grant allocation as part of virtio IOMMU?
> 
> Long term, maybe. Do you remember my Grant-V3 design session last year? Being
> able to reuse the same layout for virtio IOMMU was one of the basic ideas for
> that layout (this would need some heavy work on the virtio IOMMU frontend and
> backend, of course).

While this might well be the best option, do we have anyone with the
time and expertise to work on this?  I might be wrong, but it seems
like a huge task.

Thanks, Roger.
