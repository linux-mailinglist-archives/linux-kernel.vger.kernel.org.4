Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A575F74973E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGFIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjGFIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:17:18 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD21BF2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688631429;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dwWhS+OHpuH7onc023wGBQr4L5EfDSMSVWZz56h4F+w=;
  b=hIZhrVaLHJHy5GQwE8NYpBjI1VTgCZ2dyrVPY18Oxa+a+sCk1pajDgZD
   YYUpsrRXKb/JtIH5e+gJ3b6LYeCbQUy7RnWzH5Nj/rjnEWI7eh26ZBlJf
   u+ryhuLZzSAR1drQkTLFHZIKB9o6Ab5bqiYrszhaZvnWTtgbaPXVgtqxi
   k=;
X-IronPort-RemoteIP: 104.47.66.49
X-IronPort-MID: 117897198
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:wZwIganq+rDK5RMIwqAVeuDo5gzIJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZWGuOMvvcMzHyetl1OY++8UoDvsKDm4A3QQQ6rC4wHyMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgU5AGGzhH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 b88LTEEXyyBvaW3yurqRONd1+h8K8a+aevzulk4pd3YJdAPZMmZBoD1v5pf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVklI3jOmF3Nn9I7RmQe1PmUmVv
 CTe9nnRCRAGLt2PjzGC9xpAg8eWxHyrCd1LRe3QGvhC2AyQnkEtLSIqTlqphtyk0WjufohbN
 BlBksYphe1onKCxdfHmRAGxqnOAuh8aWvJTHvc85QXLzbDbiy6eAmUHVSJQc9wOu8o/RDhs3
 ViM9/vrCiZoq6a9Um+G+/GfqjbaES0cN2oLfyIHZQoD/dj4oYs3gw7PT9BsC6q8hJv+HjSY6
 xeOoSsljrMfl/k3xr679lDKhTGrjpXRRwtz7QLSNkq94x9jIpaseYi1wUPG9vsGJ4GcJnGRs
 X5Bl8WA4eQmCZCWiDfLUOgLBKuu5fuOLHvbm1EHN50g8Sm9vn2uZ4Zd5BlgK0pzdMUJYznkZ
 AnUoww5zIFSP2GjaOl4apixFM0u5aHlGZLuUfW8UzZVSp14dQvC+T40Y0eVhjrpiBJ0zfB5P
 oqHe8GxC3pcEb5g0De9W+Ya1/ks2zw6wmTQA5v8ynxLzIajWZJccp9dWHPmUwzzxPrsTNn9m
 zqHC/a39g==
IronPort-HdrOrdr: A9a23:QrgGfq7A2YlwAb5tiAPXwAzXdLJyesId70hD6qkQc3Fom62j5q
 WTdZEgvyMc5wx/ZJhNo7690cq7MBHhHPxOgbX5VI3KNGXbUQOTR72KhrGSoAEIdReeygZcv5
 0QCZSXCrfLfCVHZRCR2njFLz4iquP3j5xBnY3lvhNQpZkBUdAZ0+9+YDzrdXFedU19KrcSMo
 GT3cZDryrIQwVtUizqbkN1OdQqvrfw5evbXSI=
X-Talos-CUID: 9a23:FqUziG39UO/DOvdTwoa4b7xfWeQgc3Ts8HXqZE6yUTdnQozEZQCX9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ATqFSNgwOjQmEPGqZGoOOOpIAfjGaqPz/Cxggr7A?=
 =?us-ascii?q?5h9KFJwtVJmy73BHtRpByfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,185,1684814400"; 
   d="scan'208";a="117897198"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2023 04:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlfysLimKAF6NbirKNIGaWhnU07ITXIjwyARK7Ek9UsMTMrVQ1oh/X+sS4klUMcBEz8CQ0wMpcfl+FUH7Tdv6f/C6C5Ur+UjeC6qj/5S3dM985Hp1USiLKU4JF3RWZI70Uh0FS/fSlfgTpXK48cR2Mq9g6bNmepE1Z/+OAf6/trs3/xZsI8DFKc6gfM1K6fTPxsn5+7rXFOIp8Q7iCKcDsOCnc/WjiNDuF02bw14/CKCGGvU1isDI6gIPAiMLvDTb4jcs6mNwR3QGU+JDvVk0v3lPolLbG7xTr6RrVONpsYpsk0tNyLYQhq+/qfjDCf9aKiWEZEUYxiqhdZfrpp7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebr3eL0nExbOnagfNqFlIad5XC9VJWJ+dIUg48dt3K8=;
 b=EJq1yjsYdQnpJJaZFj1hmLB5rVPg9jb9Omu454ffJmFLX/nIVfG1Cc6cQEMxDeJAVVukGxoT7RP1umnch14W0RXUiFOS01D98Rp9Egih8ppXNwo4vkM1p1UyOlnp+B1EDVx66MV6xOROdL9Z/pZAXBNyhFxOBXbwz2+j2nu/ofvI5wDYyXcZPEEaJHLmer81V+dygHyTJqXEr7+rF0apgaQsk8HO7j8cbwfwBpIGkP+XtkwVhP9l0wI4CcvwPbjbDvpOCp91r0vid7VjnSPZpIgN52JtdltQooYOXX9w3yDQa7ID7KoPX12xkcAkV9Y3XSu6OkT7ykgSCwft2Y83qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebr3eL0nExbOnagfNqFlIad5XC9VJWJ+dIUg48dt3K8=;
 b=ck/B7MlIY/JDg436ihf5b0DFc9Q5Gd5s7gBVKWiUC/aN4X1ksvKm5isNzRrNQJ59RUJHn8SXZmQ4p9RBK8vz+7RNBxX6oUSBnGG1qGJDUtgN+nnyH3hEWdYE9qY/+FbzpKqkzCOc+ay+8Bq7QT0g36vCsItxY5rTpxviha72kzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SJ0PR03MB5744.namprd03.prod.outlook.com (2603:10b6:a03:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:17:06 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:17:06 +0000
Date:   Thu, 6 Jul 2023 10:17:00 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
References: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
 <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SJ0PR03MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: c4740fa4-fcb0-4cc2-d814-08db7df962e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP8vKvKWP6EO3pCtJRFvQL0IfMni4IHInhavu5Wp0ISy1DN+xbSGjQU3Rx2LdG3HhzY0XeaVQ/hrZns3ch7NYZjvCWKXidvwoF40kAoK9P/P86/j+XjMcuAr7Ru1Q3Xas8fMhrkA3lHtYR0CBGLd3XS1r44/JG8LCWRF2Ir2k2LmHGFxP6OvW/v4t4orIZDbDKjeApuANdcOnzNSpiIeaARSiiq6/sQ+52XzXJa8sTe7e0UsQpG/We+kFXdvmpn/n7yCN8W+od/P9jL+R9QU1xeadeAbKCKVfod8WErFMHVEtgVfNxaxRKTojOFBvay/mEghFvKZd2LL0fAcAiB3OIm7j0J/1e4h1nBrT5YHTjbqK164Hq5PLVEIAMNTcB7Ju71KcTa/tpW78C6p11j1NHJTUcNNMV7hOW2ZxGFTfsL5Hf3oayzmrYOvwd+Op+HM2Ftj65/SJMmvHyYNuotZGGUlMSD2jMsMmiNcoRC7NzfYCJRbAw3/gUNr3juZYTGG2ipVB+auCsKijAR7qWBpoIa7jNyP0zsA284chTg6jV+JUd5Ly3RGlcryJwd1uD8B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(85182001)(86362001)(5660300002)(2906002)(66899021)(6512007)(38100700002)(186003)(83380400001)(26005)(9686003)(6506007)(6486002)(82960400001)(54906003)(66556008)(4326008)(6916009)(66476007)(66946007)(316002)(8676002)(8936002)(478600001)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzh6WG4ydU5FYTNKVVoxdDhETnEzYkxFSDBadUoxVVo3alRaeWU2NlNWaERZ?=
 =?utf-8?B?dXloZjdxTUhCTjAwd0RyU1lJTHNiQlFaWm15YkdvQWdRZW1zM2xpOCtsT2hm?=
 =?utf-8?B?Tzg0a1hOdkw0dWNsZTMvcjFyUU5HaVAyZ25qY1YwWmdDbUtHZFNnelpIcm9Y?=
 =?utf-8?B?dXJMdFQ3eUlFQWZFSFZJdWxJRzJNSkhFRG1xL1VKRVd6TkhEWXdjaTljSUtq?=
 =?utf-8?B?M2kwaHNoSXZoWXMrdWxFR2tPRGFkc2dXRUZWQWFsU1g2bGxIK1VyeHpJWEt5?=
 =?utf-8?B?UGNOMFFxSzJ1V3RPUVFJY3M3THp1R0loekVkS215OGZ5bHhwVUYvQ2R5VC9p?=
 =?utf-8?B?TUgwSWtmV2RSdmRQdVhZdmlMZXdMc3J3SDFyRGRKRWgyTEt3NFczUW5nYi9q?=
 =?utf-8?B?STROR2JXcGlqWkluaDFRTlRsSm8rMXZKZ2NncWRJOVhORmRyNHZ6eVlZR2lv?=
 =?utf-8?B?cjU4UkxGbE1PaG9UeTFDT1JFc2ZXVDl2YUZ2d2NPa2NrVjUwdmdmd3MwOGxT?=
 =?utf-8?B?MEFvNlczOTdYbWk4MEh0WGJmMkZ1YjQwNDc0bXRrVENrWkI3cW9NdmlQMW5J?=
 =?utf-8?B?V0YzZEdaN1lyeGovT0JmQjc1anlabHBHaGpYQ2FabVhuZlpSc0pJUG9IYVYy?=
 =?utf-8?B?Y0UzTU8vTEg1eFNkOGtiZkM4VkZTOXowY0d1RThCc1lVRFBBZzZodU9QVVhx?=
 =?utf-8?B?WnlFeUYxb2lCTHFuYXpZZStWVmFja2o4WGIvWXc4VWpDUmc2T1l2VmNFQVJM?=
 =?utf-8?B?MFpaeVczOVVtNWJ0RHo2NW95Z05iL0NaMHAyOVB6WlV4Z1hXSHZONWJPcGs5?=
 =?utf-8?B?ajRiTDJDdTRNcnhOMmhWNUF2bVJFTlArUVpPMDU2QmJLSy8zTVcyM1A0UlNu?=
 =?utf-8?B?WnNERTZaYVFFQ0hMTXNyWkxLb3ZzQnVPOVVVTzZzdFJwU0FEZGNkOUpoYUtJ?=
 =?utf-8?B?MHpQRGhDcVArS1NQeTVXNmlBeXVDUzUwa253YnozOEpPK20wc2JUeHo4cUdO?=
 =?utf-8?B?TlVFM1BnWk9Vek9aSFkvZjFFT2FNRFk3WU5yYVp1azYrbnVMV0ViL2NQMUVi?=
 =?utf-8?B?Y3UwNmZnOWpCTVgvK0lkZ1N5SWppbDJETk5maGloZjBtd1lDdEQ4Y2NuczRL?=
 =?utf-8?B?S28wa1kzTmtYZ3BvZ2pVUXVXNGIrTURuUXFIZ1NmM3hTczl2eXJzNE5oVkxm?=
 =?utf-8?B?SG5RcFBIOWpVWHl2MTNmNUVHcEpqOTFtVWFGRnpRQ0trSC9TZFZwT2pSV3I4?=
 =?utf-8?B?aGNtOHoraGtMUDlDa0dEbXlJcVBsU3JiazZkSVJPRXZFK2dUanhXWXN2aHUr?=
 =?utf-8?B?UDA3RXFLRDNZUFZQc2dHU3JEakpUZXlrUEt3Z3RvWVd4bXY2cTNIQ1prTTNj?=
 =?utf-8?B?SCtmZC83QkVlMUZ1SjJSbllvVEZoVTFHWlNTaU5GQUszK2RNU0t0R3NpZm0w?=
 =?utf-8?B?QWwxVVJaaFVFZU9LOHBmdDdhRklHRDVmU3p6RjJVb0F5UmcxUFZLbWdHSVJR?=
 =?utf-8?B?NXBNMDRmLzd0LzhpMHZDTzAxMXVZNVpmSUdQeEQrMEVRdE9YcVhRVGNEcVVx?=
 =?utf-8?B?SlFvQnQ1TGRRbC9tK2ZWMjVtMzJkSmUvdDJaLzVZSjRjVDYva0duRHQxbTV1?=
 =?utf-8?B?TzhjNml3SitCYi81bXRUV1ZwekpCc1B3bG1qMkdUdGZsSElYb3hZUmdNR3Rt?=
 =?utf-8?B?TUFZczFnQ2lLZ0I3Yno5VEhjMmlsOHhWRnV6ZzB4U254bXVITmlnWDM4T3Nl?=
 =?utf-8?B?cVVLMENJVmVhZVAvZ3JtY3hVZUd6ay8xRUUvNldjL2ExNCswdnhCQVlYQzVv?=
 =?utf-8?B?SlV5QmgwUTMyanowc1VzUURrR3g2OXF5TzV1MHl0VFl1LzJ0MXRyME9LQnlC?=
 =?utf-8?B?cWJZL2N3OGpqVG5wQWozMGV5L212VTFtVSs1UjQxSHJCQWNOUDdGMDM1ZUhP?=
 =?utf-8?B?OFhCaG0wcm9NL1Uzb3BGYnZJWTFvWWNGZVMzdVpjaUJCZ0FkOStrb3JBUFZk?=
 =?utf-8?B?a1l0WVliSnFlaGRMbjkzaXk4Vjc3MldNU290L1VhTFZwMzZjWks0ckhhNzZx?=
 =?utf-8?B?MEZPSU9qZlNrekFHcW92RlhyTDdrbHFGVXY4aTNjV0hWak9pcDJyaWppckpN?=
 =?utf-8?Q?fmi08oas1BF/M1yokiSlHsYm5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVpZNlJUSzVCTnVaZDdtbGN4VmhaVXJaZTlVSy9MRGZVek1hY1Q3clo0Z0I5?=
 =?utf-8?B?cnl2Yms1dlRKWGZ3Rlp6czdKcFpFalNQSXJxSDBVWnJSUS9rQzhsTWRYYTdz?=
 =?utf-8?B?MTRZd0g1SUJFSzEyUEkyMG1ucm1FSkJlNnNwZmRrWnVQUGIyVm12OEZreVNJ?=
 =?utf-8?B?V1N2aGloTzN4VHZlSG1qd0ZnMU1iZ2VFTWczTGZlRmRyUUVnVmZ2aVFxaFBh?=
 =?utf-8?B?c1diZ3VSR2xiWHliaVNXSWRsamtBZGdXM0Y3eDNBRHBST3FnemZlWUJ1YUdn?=
 =?utf-8?B?WlU4bjBqai9UMUx2V3pnQVNXbDI0ZzI1QXpkMzdiMlo0cHk3T3B2WWJDOUZV?=
 =?utf-8?B?SEcvci9yQk1Tb3JXcWNCZ0ZrNUl3a1UyZ0VnSkJBY2VaMmhOdzd5ZU9xT0JT?=
 =?utf-8?B?YmtMc0NNWTlWVVZRYnF0REVwbzZTY2thbU1EamhWWEQ1enFHM1g3ZGZXSTJy?=
 =?utf-8?B?L1Jjb2JYYnd2VmVINWRtdVhsSTgraTRZZDRoMGE5NkFpaWFBQ05GaFQxcmlR?=
 =?utf-8?B?OEFUQWpYQlg1dFhsYUhDbnpITFRxbEZLRDhRRkRtVkNGTnpzQ3JOR2hrYzUx?=
 =?utf-8?B?bnJWcjgyeWdDS21aUmo1T0k4K2t6bmMxM0U4UVZwdlp5YVhVZ3lkNmxibE1D?=
 =?utf-8?B?aWtWZVdnS09qaVRzdFJIT1FwdzBnZEQ3S1l4THhIczBvVXp0QysxSGlnanA1?=
 =?utf-8?B?MWkyQVRweW52b1hwY3J6WWZJcUI5MnVTc2I5VUhyWkV1bS9HNlMyK3k5KzhX?=
 =?utf-8?B?OVJlUTlRNkp0OVUvY0Q2cEIreFNrazROYitBNlNac3Y2dmI0WUVLRmlNRUpF?=
 =?utf-8?B?THRRVnd6WjNwT0xTaDYxTm4xZm0vL2hVcTZ3VHNBcE1yVGFJSTZzL1g1c1kr?=
 =?utf-8?B?a3kvN08zNTBoN1dJcjFiTStmNTYvam5vOEtPa2lSMVBUVjN3OEI1TDhSMHRu?=
 =?utf-8?B?bk1hRW1FaHM2ZDFlc0FNMk1yQlJxQTkxK2lSandIalJHWXptWlJSZWRCYWEw?=
 =?utf-8?B?aDU3c29IRDNFUlZPU1VoRktyN3FMMVpacUdBNHVMeEIzYmZwMWlObjExVVhH?=
 =?utf-8?B?SzRDNkZoeDgxWk53TFo1T005V2VYdzNzWUdIdDlVbVQyZUtrME1La0tueEdx?=
 =?utf-8?B?M01ZWWd2cmtKOS9PYWhmcmRIYmN5VHNpM3FnTTNpQ2V0ZEVhaUJSWHQyNEpq?=
 =?utf-8?B?QXFMMmxFbnlIVElFK1VwMWRDTHZZSGlNUTZhMzg1UHpmS3hRUC9ueVRUb2VF?=
 =?utf-8?B?MDlXQ0VWUmw5SENUcDFEdXA0eDdQRkg4VE44WGRPUHRIb1V4WkZmVEZmaEZq?=
 =?utf-8?Q?LaMUdsTsBg/DXDsdSP3rwgKDdgJd/B+OIr?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4740fa4-fcb0-4cc2-d814-08db7df962e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:17:06.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjnKhky8pjNOBMsV5hgtgUxabY+65jBnkjXmmZ/3Dcmwdo09nv+1E4Ym3BI4ilsuDUqlpZMetM2wEXaadyp7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5744
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > **********
> > > 
> > > Part 1 (intro):
> > > 
> > > We could reuse a PCI config space register to expose the backend id.
> > > However this solution requires a backend change (QEMU) to expose the
> > > backend id via an emulated register for each emulated device.
> > > 
> > > To avoid having to introduce a special config space register in all
> > > emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
> > > could add a special PCI config space register at the emulated PCI Root
> > > Complex level.
> > > 
> > > Basically the workflow would be as follow:
> > > 
> > > - Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
> > > - Linux writes to special PCI config space register of the Xen PCI Root
> > >   Complex the PCI device id (basically the BDF)
> > > - The Xen PCI Root Complex emulated by Xen answers by writing back to
> > >   the same location the backend id (domid of the backend)
> > > - Linux reads back the same PCI config space register of the Xen PCI
> > >   Root Complex and learn the relevant domid
> > 
> > IMO this seems awfully complex.  I'm not familiar with the VirtIO
> > spec, but I see there's a Vendor data capability, could we possibly
> > expose Xen-specific information on that capability?
> 
> That is also a possibility too. Also we could use a PCI conf register
> which is known to be unused in the Virtio spec to expose the grant
> capability and backend domid.

Capabilities don't have a fixed config space register, they are a
linked list, and so capabilities end up at different positions
depending on the specific device layout.  The only fixed part is the
range from [0, 0x3F), and that's fully defined in the specification.

Trying to define a fixed address for Xen use after the 3f boundary
seems like a bad idea, as it's going to be hard to make sure that such
address is not used on all possible devices.  IMO the only way is to
place such information in a capability, whether that's an existing
capability or a new one I don't really know.

> 
> > > Part 2 (clarification):
> > > 
> > > I think using a special config space register in the root complex would
> > > not be terrible in terms of guest changes because it is easy to
> > > introduce a new root complex driver in Linux and other OSes. The root
> > > complex would still be ECAM compatible so the regular ECAM driver would
> > > still work. A new driver would only be necessary if you want to be able
> > > to access the special config space register.
> > 
> > I'm slightly worry of this approach, we end up modifying a root
> > complex emulation in order to avoid modifying a PCI device emulation
> > on QEMU, not sure that's a good trade off.
> > 
> > Note also that different architectures will likely have different root
> > complex, and so you might need to modify several of them, plus then
> > arrange the PCI layout correctly in order to have the proper hierarchy
> > so that devices belonging to different driver domains are assigned to
> > different bridges.
> 
> I do think that adding something to the PCI conf register somewhere is
> the best option because it is not dependent on ACPI and it is not
> dependent on xenstore both of which are very undesirable.
> 
> I am not sure where specifically is the best place. These are 3 ideas
> we came up with:
> 1. PCI root complex
> 2. a register on the device itself
> 3. a new capability of the device
> 4. add one extra dummy PCI device for the sole purpose of exposing the
>    grants capability
> 
> 
> Looking at the spec, there is a way to add a vendor-specific capability
> (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> today, Linux doesn't parse it.

I did wonder the same from a quick look at the spec.  There's however
a text in the specification that says:

"The driver SHOULD NOT use the Vendor data capability except for
debugging and reporting purposes."

So we would at least need to change that because the capability would
then be used by other purposes different than debugging and reporting.

Seems like a minor adjustment, so might we worth asking upstream about
their opinion, and to get a conversation started.

> 
> > > 
> > > 
> > > **********
> > > What do you think about it? Are there any pitfalls, etc? This also requires
> > > system changes, but at least without virtio spec changes.
> > 
> > Why are we so reluctant to add spec changes?  I understand this might
> > take time an effort, but it's the only way IMO to build a sustainable
> > VirtIO Xen implementation.  Did we already attempt to negotiate with
> > Oasis Xen related spec changes and those where refused?
> 
> That's because spec changes can be very slow. This is a bug that we need
> a relatively quick solution for and waiting 12-24 months for a spec
> update is not realistic.
> 
> I think a spec change would be best as a long term solution. We also
> need a short term solution. The short term solution doesn't have to be
> ideal but it has to work now.

My fear with such approach is that once a bodge is in place people
move on to other stuff and this never gets properly fixed.

I know this might not be a well received opinion, but it would be
better if such bodge is kept in each interested party patchqueue for
the time being, until a proper solution is implemented.  That way
there's an interest from parties into properly fixing it upstream.

Thanks, Roger.
