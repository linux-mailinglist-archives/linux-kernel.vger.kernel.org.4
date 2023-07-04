Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1274746C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGDOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:49:21 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62A185
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688482158;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GoQLM3ePx+7KPZBJVGBcUQYU/brh23m+rtZYoh7Wv9Q=;
  b=PljejBW2D/S1py2Lqrua2MmZAqcofDyESmkWy6TzbP8wvRDqJXVBsIA7
   UeZE1AujOaN+4aC1P4+1UH7WFqs7o+T52bT4/xVCwOWPoq51UcAjgMRUi
   hIfl95ybEvWKnaxEGhDxdU9PupNoe0XpnX63a3nn+D1zBkxzMHTAqCY4D
   c=;
X-IronPort-RemoteIP: 104.47.56.169
X-IronPort-MID: 117690903
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IS6XAakZPWgM1nE/fIl/0pvo5gw8J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfC2COPPrYMGDyeItyYYTn/BsP78TdnN83HQE++HszFCMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgU5AOGzBH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 cwYdj81TwGju8mZh7+WSNJImsI9COC+aevzulk4pd3YJdAPZMmaBo7tvJpf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkVI3iea8WDbWUoXiqcF9hEGXq
 3iA523kKhobKMae2XyO9XfEaurnxHqkBtNKReXjnhJsqB6i7DMCK0QdbH+QhaGkk1+xfPR+C
 VNBr0LCqoB3riRHVOLVWhSipXeesx00WtxOEvY74gWA1qrV5QmCAmEOCDVGbbQOtsAsQicx/
 kSUhN6vDjtq2JWOUm6U/LqQqTK0OAAWIHUEaCtCShEKi/HEpIwwlRvJQsxULL+ujtb1FDfzx
 BiHtCE7wb4UiKYjz6in5xbfiiyou7DSUxU4oA7QWwqN/g5/IYKoeYGswVza9upbapaUSEGbu
 3oJkNTY6/oBZbmJlSqQUKAOEauv6vKtLjLRmxhsEoMn+jDr/GSsFahO4TJkLUIvPc8eeSDgZ
 GfavA8X75hWVEZGdodyaoO1Ts8tlK7pEI28UuiON4QfJJ9saAWA4SdiI1aK2Hzgm1Qtlqd5P
 oqHdcGrDjARDqEPICeKetrxGIQDnkgWrV4/j7ihp/h7+dJyvEKodIo=
IronPort-HdrOrdr: A9a23:kLd+o6iHlir4lMlBqYnMvVTwOXBQXhsji2hC6mlwRA09TyVXrb
 HVoB17726ItN91Yh4dcL+7Sc+9qB/nhPlICMwqTNOftUrdyRqVxeJZnOnfKl/balTDH7VmpN
 ldmsFFYbWaZzUXsS+52njcLz9K+qj+zEnHv5ak856vd2BXgmNbgTuRxjz6LmRGAC1PBZ84E5
 TZw8pculObCAQqhw2Adxo4tvD41qL2fYzdEGI7OyI=
X-Talos-CUID: 9a23:ZdfZlG3eVEyBItfuCrZpALxfKsB7fUX83VfsCGD/BEtrc5mJT0G00fYx
X-Talos-MUID: =?us-ascii?q?9a23=3ArPpL2A5EN1ix0xF8xpudeZxIxowr0o7xGWNUmqw?=
 =?us-ascii?q?ikO3cKDVhNBC7rRaoF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.01,181,1684814400"; 
   d="scan'208";a="117690903"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 10:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfU9qXoZ1t2w1SiIiIaERUNHq5a4Oo/ukxRCKVBz41hTPPeZ9PUUJroeiV//KstA2A2o0HkJI0qUJmEqrCZmdg+sEmulVLkjghuGd+bJMhHjmmq1y0M3kGqvB8yNZjS8fE5tWjoDkuagzI+c+imHDwYOrjzFJgaNatp7UlXjtyMJhcKhIcoZQ1r0Dd3OcyhOseC4Val0wIciJOsW4nlZv6PBPmklWhTLMDU1FgpNazDuSGwCFsj2q2Z3gxH608MgWnpfPh0hgDXD2w2aJCW5XRzvXScAbE40s8/PbfYiShPKHK1qrlYsah4ZHQOjyTdtYwmQOW7pOIKvQsJ/ZfR7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a3Wu7ZwpKUye8yTK3Oda4WTS140fzit/X7bwpStt90=;
 b=bTcGDdINW5wAC0QUYz/DEnP0G5pR+nM+ROx4N/SypXQKadnPt11gntNWTmzyGH9er3eNvX3XKFng0LSovuZK/adY4/s4ew2qf+ZnCoE5EWJ4V9oPTV9F38XcJ9XXZMIuUrN2lhjzVWrjss9i9A+fk/s5xNaVEYShFk5Bz2niKwj+rWfEhRa8ZgxXTmyGlMbpa8j73J4jUBXFGiv9kSoD/pkB8o+/TNBtKI7mkeg2SOweB1vO5YmvvGUJb1tvZcsPGygCvRSwwTOdlXTizNNsBBF7KdggmBhNloOhUchDChaLuTcjrS0y/s+HOSbdiDGlTD7ADvC7GkYFs4xKA/i+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a3Wu7ZwpKUye8yTK3Oda4WTS140fzit/X7bwpStt90=;
 b=eNLPQqjV8GSnI/RPruiQbP5kCS/brN1A7Vu03hvj+K+WqsF5440gozuyQ7dELifMY9kq5BqQ0/jkM1PRvu81DwkWcKhj2MJcDu7/TgvbUQpC+23gY1ohj1jMtyE+a9DJY6OYkhZffwLmV2uBGoc1LkgVKowNYCvJ0vh5PGzskUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by BLAPR03MB5442.namprd03.prod.outlook.com (2603:10b6:208:291::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 14:49:13 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:49:13 +0000
Date:   Tue, 4 Jul 2023 16:49:09 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
 <ZKQF8qq8Oh5E+Fxx@mail-itl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKQF8qq8Oh5E+Fxx@mail-itl>
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|BLAPR03MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 2319758f-86bd-4375-76c2-08db7c9dd558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1T3d5TdZ1hP/eSJAJWBDKimtMUic5TzDT15/brgwHraVfYM+D3ZfJC8Eyj409+MQ0lexfbGimqH9om5Vog5Z8mYiiNNGQlnApHul7/itdZp/MzY1pgL0FhMovcj2XH7nDFbQVvh0fN+0ENeVg3afO6IgYOARqNybMLc+RbcjDzzwWT3j6/CF2N0HcNYTDGDTc+jiwqmUb4P9VRb0wyzkrWPEPvKr/iXuET69dIAp1GCip8Sfa9jJwt4zpYYAWs2wQoCjiyrgCq5GjpF5ThqjeM0xGuUWD9iFcRe/plegRqNo7u9BBv6hm6Ak/gr1hkiO2VwXew9arVVepQcb06CU03fyvIw067Wwn5vCbrUQtey1yoVENHry9j7KqrL8bxdBdjD+Xf6fBfs4NgK9FCVXw9hj1MFqdA9xHLAWcNelnTZva/YsoL1NacknCnynIvk1YFEM6Dh79dpRdSab4OJwYw6Agovcqd6j0cvIg5GJQP6vJ8PT8Swb0i6Ducr12l8mMd9sbiRN/Uh53w8UBWIww5j8R9nkU7OwyGoB0mF/xv6WMiT6hEd4cEEGF75naaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(186003)(82960400001)(478600001)(6512007)(9686003)(26005)(6506007)(53546011)(86362001)(6666004)(38100700002)(6916009)(4326008)(316002)(66556008)(66946007)(66476007)(66574015)(54906003)(83380400001)(6486002)(5660300002)(41300700001)(2906002)(8676002)(8936002)(85182001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVqZjFIOXZyTW9iaWx1VWgyS2ZBQW1qTmE5Q0J0OUxtNExqbmN2UW1XRmtH?=
 =?utf-8?B?ZHNMaE1ReXU4aVpkeDB5QlNlWFAzRDU2dXBGZzIxU0JZa2l2TmpuVWJwSGRF?=
 =?utf-8?B?VXgzU2Vld2h2N3FCazlMTjBZYWNrclB6Q2JRR05idTU3SDhFWWhEWXdDelNk?=
 =?utf-8?B?NHNTWGZKT0tMUkNheGxzemZoNk5wWXU5bEg5ZkVENElSUHR1TERKb1ZkYVlx?=
 =?utf-8?B?cGtRU0x6bmNwaTVuYWtzdkFkMUlWTU42cnJFUitjcmM0MUxKclBZNWxmVlR2?=
 =?utf-8?B?K3lwQjkzTVVtbGxQZXVMSm92QnMyNFlOL2Z0SHJuUkNFeUlVRStSTUlZbm1v?=
 =?utf-8?B?dkhIRnpEOHh6b0VnMTA4cFJ5Z2JSQWh4TTZ1NTJPU0RQak9KNjhXa2NudDIv?=
 =?utf-8?B?Y0Z2dGhuT2RtdkFDSmM4YXpEbjFPaHNIWEIzNjN6aDhYQ0kzNWVaWmM3Zms4?=
 =?utf-8?B?MDlvOEtKY1d1OHZ0bXR2cW1ubFJZUmZEN0hxUGN1clg3Y2YyajBDcStIUW4y?=
 =?utf-8?B?L2pvK1hSVkFkQ0NTb25pMDdWaDFPZjdCd0hONXNLSWR1TU5BTy9laGNwTjRt?=
 =?utf-8?B?MUR6OVA1T2VVelVSMGErZ1laTy95dWptekhVSnZBN2IybGZDdmpjbmwybkZa?=
 =?utf-8?B?Tklyb3VJYStvZHlIcWl1RmtyVm8rNnJrWEhidU9QMG90RW9mdkNPTjQvWHV6?=
 =?utf-8?B?NmI5RTlPQVFBT3ZWTnF1MVFRRUdYRkhqVzJRUWlUQnFGVkE1VWVVT0ZtZjlV?=
 =?utf-8?B?U0FPTXFTYkdNSU1wbzdwaks5RUJsb0Z4WDhwaHZTK1lqcU1iVmErMHpqYmt5?=
 =?utf-8?B?RFhEWUFvYlJHaVBpQW1kYUJIYlZVRHh5M1BKdUZXM05vck8vZys1N0U3TnRu?=
 =?utf-8?B?NEdCQWVJNTVXUVZ5MHppM0ZQdkZ6ekdTbE5BaGNsTGRVQmdwOU5pTFJLQnZp?=
 =?utf-8?B?RHhJUExDNEpHbmczTzg5UkNnNHN1YUphU2wrRGdiMkZhdXMxVGJNM2QwdHg5?=
 =?utf-8?B?M2ZJTHlHRElGYkJCd2ZNYTZIanZDKytQMXoycXBJUTBINnVtbDlEMjRaWTVJ?=
 =?utf-8?B?NjNzUHh3a3QwNVdqU1dvZEhoa2xWQ1l4N2V5RUJERnJwY09YTDdwTDcrZXBh?=
 =?utf-8?B?bHgrSDhtTnJYangrMFhyUmd5ZW4zaDZnb2JQb3QrMGF6ak9ZeWViVlJ1QjN2?=
 =?utf-8?B?MmsyYU0rNWVJVlloc1orUjRlNXNtaFVVSjBERjRaYllLeTgzUmdnQmJJMlZ4?=
 =?utf-8?B?cERqdVpwZjNGWmE3T1l5b3daekRscENNTVM2WExPSHNWaFpWZURSWVVoZlc0?=
 =?utf-8?B?dlpCV3dGYUltNk9DYkU4WVoyRVJKWkt4Q3FHeDcxaDdTTXYrMWh6bkp3Unk1?=
 =?utf-8?B?bCswY3dlVlluRTVZcGhBRS9yblMycXVSMmZsMjJxZGJFV1FYNFJlTGExenVi?=
 =?utf-8?B?TExSckFrV3VkL2h5REhwdHZaZHJDTlhETTJZK3kyVFlrbzZya2QwZ3laOUp4?=
 =?utf-8?B?TkV2ZW9ocThJMFljUXhBR1ZPK2YrbWpsOHhXNndkSmtaQW4zbEhFRGpVTi8z?=
 =?utf-8?B?OVBlVE1qTTJPNDhPMGE0UkFNZzdmaE1Ob1BreTNrM0M0Mzhud3AxM2V6Lytw?=
 =?utf-8?B?OGFVemRjNlhvTTNmZkhFM3dEcU9ERmFqNmlUenRGTFdFYndYTTdJa2Z6TDVl?=
 =?utf-8?B?SlV6dkx0cVVCRGRqeWh6VnBxaGVORkhicDJreDdOd25BYkpNRmczRGFnQ05C?=
 =?utf-8?B?MElWd2xMUmgrb3JBa0hZekZNM0lhOE9oK1FGSXRvSDJxaUE1Ry8wNndFTDJm?=
 =?utf-8?B?b3hYUDRabWJwQXVHdW1EaGxRWDYzR24vQ1M3czBQSTFTaUhNOFZxbmp1QU45?=
 =?utf-8?B?TDFZTGVBTlBkWktncHFBYjBEc2FxWjcxem9rUnM2dXJXT0syN1pJUndaTEFz?=
 =?utf-8?B?M0dzMTUyN0Q0RXhpaDVJTjlmb1VZVnFIMm5LOUhmcndidmMrSG5LRVVTK2Fp?=
 =?utf-8?B?dVNlWXZFK1lUNFRWViswVjRIcEFPcFdhdEk3R2xJOFJVSnVnWWc5N2pBL1I4?=
 =?utf-8?B?cStxdGYvQlpMbXNuaFJoUzlIazI0RFZTdG53N29PVW44VmtEL1czTFg2Z2xq?=
 =?utf-8?Q?8mvithw/sRremeoOTtlETnCbl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHRIL3hGbEdIZFdueDdRRTlYK1BNdmVrWmt1SGoxMUNGRkE4MXR1UlFjbm1D?=
 =?utf-8?B?SVEwUGw0T1BMd1BDMXR4RUhlZVVnRUYrZngyZDRiOUFDSzVlamcreHdseVJo?=
 =?utf-8?B?VU51T2ZVOWRlZEhrdkJsczNPeVAxSDJRUEVjN1RKaDJNNnBoenJUdTk0MDA2?=
 =?utf-8?B?blVTU1dIYjJBT2VGSFg0OGxOSHJXQW1wR0V1YjRmcEZRSE03bVJ1Q3plREJp?=
 =?utf-8?B?Q3NYWktWM09pd043b2dZTE8rUEtQNnZTN0xzazUvRDlaV3BmZ2IvbWxRZERO?=
 =?utf-8?B?TUlMRWtSbVo1cUFGaTArV1hCcVVBME10c2hTOG5tSDYvN2pMRXhGUUxtQ1Ex?=
 =?utf-8?B?ZDlOQXByOEQxajNVQVBwWmRNcys1UURNWHEzeGpHci9aeTI2aEMwYzNmc2lD?=
 =?utf-8?B?NS9TZDF1Mk13RnFkWm5PaUVDL3prRm9DYjRUaktsb2xDTTVlQW9CMmtnK3ZB?=
 =?utf-8?B?c3ltcXZWS2RTTTdRTlRSaGI5ei92a3lidEFhNkQ3Nm5sMXVMallrRGlwK3gv?=
 =?utf-8?B?Z0I4ZFcrZVg2SE1qSXFxY2JieVRCcFRldFk0VWJKQzhMLy9lSTE2WU10aFgw?=
 =?utf-8?B?YU5MMllCZGJTTjVlQ1FVSzZieVg1aXRyTW95OXFqdERvZVQwYW55dFI4bWFo?=
 =?utf-8?B?VWUydjhKZy84dlBjZ3lEcCtFYm9kVEtHMHJtZmlGY0JMK3ZLT1A0dkVlbzBy?=
 =?utf-8?B?OG0zQll0NGk5NFpoLzBSdXdvU1NuZjh6WmQrSWNSbmNQTVpaTFg0OXVwdHlN?=
 =?utf-8?B?aWNsK1ZiTkZTR2ZWSmwwRHNrRTNuVVNVclVhd09SSEUweEdERlpQTzRJSWk0?=
 =?utf-8?B?UUxMTnQzdU1Pb3B0SmVLUW5GK3F3cFd2dFNjWXpVQUtTSTdZK0JHY3dWZEhB?=
 =?utf-8?B?NmVnRTcvQ1pKWnFMOGEvTDc4akZRYm9rbVFBYnNjcDRpZ0JqWkZyWnFPSzRE?=
 =?utf-8?B?VEVnOElWU2JiM3pMVmozOG1tT25pQkZwZGxYNTdrQUsrMU4yNFdoZDI3TzZJ?=
 =?utf-8?B?aHMzandtazlNTVNUbXVRbEdyeDhvYXlSUS9xMUZ1aXUrOFVsWGVKVHpXemdW?=
 =?utf-8?B?MXlTV3l2bFhJNmhxZkVXVWtXRmlweVBTRGtiOWlnN1E3YlNzV1Z2SWZmd0JR?=
 =?utf-8?B?eVN6TVVPSlhTRGRlaGlsSmYzTC9GeXpYcHF3K3JpY0hEd1RYT3FBL2hDdGtL?=
 =?utf-8?B?d0JDZ1FzMFRIYkRWVWdZcGdvTUtkMzFZb2RHZ0tDYTQ5azhOOEU0WTlKWnJ2?=
 =?utf-8?B?S2QvbHIvSk51VVhmOFg1aHREV1cycjZXWXd5bktySmVFRkJoaS8zY0dzd0RK?=
 =?utf-8?Q?E0ypvvWOLXGG0=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2319758f-86bd-4375-76c2-08db7c9dd558
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:49:13.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWg7fDdByVOuDbp3hhj0/McEWYMLvZkju/Ti54ttU9y7JqR5iqPRmJ0fJ89+dihhYgjaqGOVVqr0kDV9LZy4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5442
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 01:43:46PM +0200, Marek Marczykowski-Górecki wrote:
> Hi,
> 
> FWIW, I have ran into this issue some time ago too. I run Xen on top of
> KVM and then passthrough some of the virtio devices (network one
> specifically) into a (PV) guest. So, I hit both cases, the dom0 one and
> domU one. As a temporary workaround I needed to disable
> CONFIG_XEN_VIRTIO completely (just disabling
> CONFIG_XEN_VIRTIO_FORCE_GRANT was not enough to fix it).
> With that context in place, the actual response below.
> 
> On Tue, Jul 04, 2023 at 12:39:40PM +0200, Juergen Gross wrote:
> > On 04.07.23 09:48, Roger Pau Monné wrote:
> > > On Thu, Jun 29, 2023 at 03:44:04PM -0700, Stefano Stabellini wrote:
> > > > On Thu, 29 Jun 2023, Oleksandr Tyshchenko wrote:
> > > > > On 29.06.23 04:00, Stefano Stabellini wrote:
> > > > > > I think we need to add a second way? It could be anything that can help
> > > > > > us distinguish between a non-grants-capable virtio backend and a
> > > > > > grants-capable virtio backend, such as:
> > > > > > - a string on xenstore
> > > > > > - a xen param
> > > > > > - a special PCI configuration register value
> > > > > > - something in the ACPI tables
> > > > > > - the QEMU machine type
> > > > > 
> > > > > 
> > > > > Yes, I remember there was a discussion regarding that. The point is to
> > > > > choose a solution to be functional for both PV and HVM *and* to be able
> > > > > to support a hotplug. IIRC, the xenstore could be a possible candidate.
> > > > 
> > > > xenstore would be among the easiest to make work. The only downside is
> > > > the dependency on xenstore which otherwise virtio+grants doesn't have.
> > > 
> > > I would avoid introducing a dependency on xenstore, if nothing else we
> > > know it's a performance bottleneck.
> > > 
> > > We would also need to map the virtio device topology into xenstore, so
> > > that we can pass different options for each device.
> > 
> > This aspect (different options) is important. How do you want to pass virtio
> > device configuration parameters from dom0 to the virtio backend domain? You
> > probably need something like Xenstore (a virtio based alternative like virtiofs
> > would work, too) for that purpose.
> > 
> > Mapping the topology should be rather easy via the PCI-Id, e.g.:
> > 
> > /local/domain/42/device/virtio/0000:00:1c.0/backend
> 
> While I agree this would probably be the simplest to implement, I don't
> like introducing xenstore dependency into virtio frontend either.
> Toolstack -> backend communication is probably easier to solve, as it's
> much more flexible (could use qemu cmdline, QMP, other similar
> mechanisms for non-qemu backends etc).

I also think features should be exposed uniformly for devices, it's at
least weird to have certain features exposed in the PCI config space
while other features exposed in xenstore.

For virtio-mmio this might get a bit confusing, are we going to add
xenstore entries based on the position of the device config mmio
region?

I think on Arm PCI enumeration is not (usually?) done by the firmware,
at which point the SBDF expected by the tools/backend might be
different than the value assigned by the guest OS.

I think there are two slightly different issues, one is how to pass
information to virtio backends, I think doing this initially based on
xenstore is not that bad, because it's an internal detail of the
backend implementation. However passing information to virtio
frontends using xenstore is IMO a bad idea, there's already a way to
negotiate features between virtio frontends and backends, and Xen
should just expand and use that.


> > > > Vikram is working on virtio with grants support in QEMU as we speak.
> > > > Maybe we could find a way to add a flag in QEMU so that we can detect at
> > > > runtime if a given virtio device support grants or not.
> > > 
> > > Isn't there a way for the device to expose capabilities already?  For
> > > example how does a virtio-blk backend expose support for indirect
> > > descriptors?
> > 
> > Those capabilities are defined in the virtio spec [1]. Adding the backend
> > domid would be possible, but it probably wouldn't be that easy (requires
> > changing the virtio spec by either expanding an existing config area or by
> > adding a new one). I'm not sure handling in the specific frontends is
> > generic enough for being able to have a central place where the backend
> > domid could be retrieved, without requiring any change of the frontends.
> 
> IMHO the proper solution is to extend the spec. I don't have much
> experience with virtio code, but reading the spec it looks like new
> config area will be better for compatibility/uniform handling in a
> frontent-agnostic way. Since it will definitely take time, some
> transitional solution (maybe even xenstore...) might be warranted.

My fear is that such 'transitional' solutions end up being definitive
ones, as people move to other stuff once things work.  Might be better
to implement a transitional approach based on a future virtio
specification change rather than something out of band based on a
completely different communication channel.

Thanks, Roger.
