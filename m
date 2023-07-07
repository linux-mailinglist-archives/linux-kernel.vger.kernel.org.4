Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F574B3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGGPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:14:24 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDD2123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688742863;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qMmaHZjeSn3gIhXj7nl8zW5R+QKswSWkuB3tB4ciZMI=;
  b=J+99Mpue1naoi/MCDi1OZWVUJop/8+ynwF0sajeu3dd+BQSxM/8ioMxX
   NrJMIT/YO+o5A9fmep6zaGYNQQ4vFHIPCtAyhtbzaP8KZxmIQwGAqgZy+
   kZdSchRf5jugvICnIgKsuzqpHomwnNhMfXie3tFzB2DXyd1ql79MXocLn
   o=;
X-IronPort-RemoteIP: 104.47.55.177
X-IronPort-MID: 114210122
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:K7sck6loUzYqcsYAR0M/AqPo5gzJJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcWGiPO/eOMTfxKtggbY6/908PucXWytJmQFNq+HpnEiMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgU5ACGzRH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 fYfAWojaEu9vrunh72VePlj1/gIMsa+aevzulk4pd3YJdAPZMmZBo/stZpf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkVE3ieeyWDbWUoXiqcF9hEGXq
 3iA523kKhobKMae2XyO9XfEaurnxHqnAttKTefinhJsqEyh7UgpFgQdbFfh4smbhBKyVMBid
 VNBr0LCqoB3riRHVOLVXRKip2WflgUBQNcWGOo/gCmW0bbd6QudAmkCTxZCZcYguctwQiYlv
 neOm97qHiB+q729RneU97PSpjS3UQAQJHUHbDUJTiME5cfiu4A5ih/TTtdlH7Wxh9ezEjb1q
 xitqCU9nLwVgdQ867Sg/VvHjjSvobDEVgcwoA7QWwqN9g5lfsi9bpKs9HDA8O1Nao2eSzGpr
 HUC3sST8u0KJZWMjzCWBvUAGqmz4PSIOyGahkRgd7El9jKw6zugcJpW7TVWOkhkKIAHdCXvb
 UuVvhlejLdNPXiwZKoxbIurC9sjyYDpENijXffRBueiebB0fQ6DuStoNUiZ2jm3lFB2yP5gf
 5CGbcyrEHAWT7x9yya7TPsc1rltwT0iwWTURtbwyBHPPaeiWUN5gIwtaDOmBt3VJovdyOkJ2
 76z7/e39ig=
IronPort-HdrOrdr: A9a23:zLUxAKMuRil1K8BcTjGjsMiBIKoaSvp037BK7S1MoH1uA6ulfq
 WV9sjzuiWatN98Yh8dcJW7Scq9qBDnhPpICOsqXYtKNTOO0AeVxcNZnOnfKlXbcBEWndQtsJ
 uIHZIeNDXxZ2IK8foT4mODYqkdKA/sytHXuQ/cpU0dPD2Dc8tbnmFE4p7wKDwNeOFBb6BJba
 a01458iBeLX28YVci/DmltZZm/mzWa/KiWGSLvHnQcmXKzsQ8=
X-Talos-CUID: 9a23:EH6ITWOve+ofRe5DUi5OrmASQf4cK2yaw1niM0DpNU13R+jA
X-Talos-MUID: 9a23:qS23OQSRd316clYFRXT9thpGDtlx6J2iUgM9s5tat8aWCHJvbmI=
X-IronPort-AV: E=Sophos;i="6.01,189,1684814400"; 
   d="scan'208";a="114210122"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2023 11:14:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBRMyDbKR1t8ao1WctEcOvNjYH+cnp5YfoUAOrY4Er8w+NaMWB+yCx3/K4oBKl37j0II4Mjgw0rsQJVmaoPJbXDzw6C+RfFVMazNV8rrKqV8Yx1VzWlLiqpmiLSFvgrZIZ1RIjKpgbtfIitlHEizbhi4hAGFZaul6/T0vyZ4K1VBvQCJ+qSQJaW3jWTANjwLK8e4Mo1f+nBnc5RPoJriXfL/uisA4BD+dbmzEudR0gUiEjJjb+ZaCKVuUwBn+dlgFDBLIsA2CWz+C6/pOwlG7pqVopsueLRibvkcdH5+vpjX7InF/uOoMeIdfAGx6GAcIMeSF0s9OYA1yVDDYJ6WlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdPMt4uy6NJ1nQkjCoRwZgEtfPGszj97mY8dwBvcVV4=;
 b=Y7+AIOqFoSAuHd0q5Pp3FInEiFQO5ppsMV53DxXADnOJgE6R5u+F7ADa05SNhPOsIPwyIACm1DAjmZ9SQsxBIoOVBWRwfMLOewGxGelgZsfDAoApioUfn8+ixbgTJxFUBqUkuADNoucgLDASJXTqmmzYPNBWN1aKBqHGZjfK3EGnqOBdTTvKNvYqAZ+6wMRS24Bp2tsWqU7ONT0+UNQPSznpJMthFao0hWyA8SLwP5rfrySQMquDyAIMpu54g1JQYBWapokfrr7gc/sXLFF3F/svHCM+EmVsxdPlgd9COMco57utK8hF6qqwgxD5jWXsQR9uE4LoZWKK2KdgGnW6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdPMt4uy6NJ1nQkjCoRwZgEtfPGszj97mY8dwBvcVV4=;
 b=Zu0XCHfKTFiwAGvr7RTy5iq7INwDbVECkJS0PWWn3KMiJjvoFTeEbPriPJ7l5dab2ZrXlVBpO6szLwPwY11a75qdRhVaUOriuVH3SgLmAS7o0l/tidmGnP/tFnKGl2XTMZXhMuGLx/mI+1FFIqrJOMIfbNf1vJKy3h5kE6WtFgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by PH0PR03MB6937.namprd03.prod.outlook.com (2603:10b6:510:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:14:16 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:14:16 +0000
Date:   Fri, 7 Jul 2023 17:14:10 +0200
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
Message-ID: <ZKgrwvSO9MgLqXTn@MacBook-Air-de-Roger.local>
References: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
 <106781fe-992b-8609-fe37-17619b699353@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <106781fe-992b-8609-fe37-17619b699353@suse.com>
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|PH0PR03MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ff5869-e419-4f72-b99e-08db7efcd422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTAWx+/t0F3Yj++4lqSkmZ80AXyaVnhuxrVsPxw35qmbVkhqhhHOBCaYqNBgO/QGNeRBxLOEvqdRLgi0uzGBxQdMhReo8OkdxpL/tQkKya74XG3ZmG54ceNTb/fH4rEl795hByig1h0W93F14wsBj8jF9+hqxVCCTVPL94CzA9TL63fH3LbZmvqcPMVjCI3hCOLBMRnmT3+E+nkVfPK9aho75yfWXOGvCXCwQGLQCfNZlIPF7l3wXcJWYhban65wS1ZJvoK/cFjvArcWt4gRQy7KQtU871momKi993XBD671KGuwmQApLsVkAUfnhcTNWrzVRJzryZH3X2aLhqRDJRJM/ryyc2+KrI/tBAEk0HOVS3KOgUBB22ahKibOEXGrGpOsrjBeysZf/GDrx8aZiIpDgVifk9O6QGpq56YVKIM9iWikVUR+qrDU3obc9hELyHhuag85pp4WOOIB++bs+sJgb2zuq9OtbJyAj3ahWk+BDn+n/AB9IarEdZMLVwAqg+bMaPSvlrgUhANhf61ezNfv8v6edCQ+/8Zx0+Xd4hc1QHXJkEzzYD99zutQ5lBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(6486002)(6666004)(478600001)(54906003)(83380400001)(85182001)(86362001)(2906002)(26005)(9686003)(6506007)(53546011)(6512007)(186003)(38100700002)(4326008)(66556008)(66946007)(82960400001)(316002)(6916009)(66476007)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZYR3lnVzlndzBZdlMvWGFBY0pFNzFLaTlPQjR1YWlxRHJzMytvTTd0eFJH?=
 =?utf-8?B?ZEQ0VmhpRlVwV3Y5QVVXSC9odGhxMld5ZUxsNzI4L0x4Uy81a0NtSmxvQnBD?=
 =?utf-8?B?aVFmUE55RUEwaEdMdnVtbGxvYjFwb2JVbVhiSWF3TXd6ay85bEx2dnRkb3B1?=
 =?utf-8?B?WnZ5dmlESnFnUkYraUNOR3RMNHl1TWNpT3dxbHNlVlIxM0piVkhaK3BaRVZN?=
 =?utf-8?B?RWE0cmVJRGxJQ0h5Y3dENUg1Mk5aaXM2Q0xjMVZnbk9HSkxyYlUzK1lUUTc4?=
 =?utf-8?B?L3NHaHhXbU1uMkpWdFZsd21Sa3VqMGkyWDNoT0JDL2l3eUMxT0ZIa2NZVzJB?=
 =?utf-8?B?ZVg0OHcyNmw5dTkzWC9UWDI5K05Ta1hmS3l6emdsODUxQzRweDdmNmZzRzdY?=
 =?utf-8?B?YmVObG1IdGttSlZVT0dNNGtJK1ZFVHFMckN6azAweGhnL05hT2lxVmdhOCsx?=
 =?utf-8?B?aVRIWnJpWU9hVC9mQVN6Ym9zbE1TN24vN1BvQ0lSeVZKMzJjRGxWY0RRSzJz?=
 =?utf-8?B?MzlkK3BURklTZ3hBcnBSTnE0MEUvRkd3VVRhUGdwTmkrS2ZybXNmRy9LL3F4?=
 =?utf-8?B?WWtxWjMrOFptbU9DQkFSMkhLVFRaWjVycU11dDJvYnVzMGdJUUpQT2tLcUZq?=
 =?utf-8?B?RmJJQ1YwbXNvd2pNOEk1SlNyb2xoS3Z4U1p1REVydHJleVFlclduSThOelNT?=
 =?utf-8?B?QnY5eVQ1WlIvenlEeXc4Tkx0RW5SNFJCYzZZVlpkL0NYd29GWVN0R2huMVJK?=
 =?utf-8?B?dU5OM2crS09aeDg1eHBHVWNxa2lzTW1XNGVrTTdJT1A4eitaOHhzcjNlODJm?=
 =?utf-8?B?M2VXWTdRTEExaitRdmgybEltTS9pWjE4Z05tWFBRc3VXazJvNUV1eE93c2JU?=
 =?utf-8?B?eVRIOUpsWUFwY2pIY0hPNWtqWXVnRzBVWlBVVVVEVm8wZHRoSmdJRTlxMGxI?=
 =?utf-8?B?ZEJVN1JIQ1RJZmtoTmRRUjBWYWFFQ0g2aDJ0b2g5UmJ4QllucEdwTjVTTVBk?=
 =?utf-8?B?UVR0UlpzZzlNeG9peHdLMWVJL21Ga095ZmIwWmZocTk1clB3QitkVXFkOGtu?=
 =?utf-8?B?OGdoSVErT2xjcHhZeGNrVXozRVRRbC9BQnlHR2JMTEpNZXYzdm80S3NmLzlL?=
 =?utf-8?B?KzBtQUd0WERKNHE3UHVFMTdPZDdzUTJCVHVUclVYbzBBNmNhdnNFbUthOSt6?=
 =?utf-8?B?dW9XOVM2VGp0MTNscmxUbzBsUkM1SEMyaEp0ZlJwNk9jUHVpdmdXSnFLN2lK?=
 =?utf-8?B?QkU1Z25hT0ZXV1dRYUVaOUc0dUV2aXZvYW01ekJuMXhIRTB0ZVZZU0JTV3dK?=
 =?utf-8?B?M1hnQWZ1QUo5dnlhSjlJdXpsZHpDVXdtTzdDUm9WOXY0OGdFRUZhZlFXa0Mz?=
 =?utf-8?B?MGhXWS85SkRWUVR6WDZndEV4MU5pVnd3YUhETGFwQmhvTEFsaUQ1UGM2UVpL?=
 =?utf-8?B?VzluWng4YWNERys1bmtzb3pWY1BjdGtvRnBuZS9VRzVLY2QvY2tLdWNxRWtv?=
 =?utf-8?B?bHcwUWhBb3J4Z3BhQVdHSGFCOHd0ZFFsMENNaXFNWTQ3VTlPSHZSdENHZGJ4?=
 =?utf-8?B?VjM0R1B0QjQ4R1dlQUZOME5SOUxMYjkyZHV3U0FmaFZMcE95OW5WOERmWE9X?=
 =?utf-8?B?RzBWMzk1UTRHVHNDbEhITklQeVBwWVN6N0RmeEJFdDFWS2RzRFI4WllLdUFV?=
 =?utf-8?B?RWNZeVJRd01FQ3B3WVFhM1ppNmp0a3NnYkh2KzJveUptcmlMME0xWUt6dlBJ?=
 =?utf-8?B?eGV4bmsxTVV6OXlUWVY5THVLZ1dXQXREbXBSRVBDN3A3VTQ5N2EwdTNrNUEv?=
 =?utf-8?B?N3YyaTlhdVlBcThWOHlqcUVhSXdGNnBmMWY0Y0JhUytOTXNtRXAvdVBJQ0Jn?=
 =?utf-8?B?VE9VZEhkUWJ0cnpYSHgzVS9PTzBHQU5xTUxxd2I2NmZOUEczaytrQUVpK2hI?=
 =?utf-8?B?WDRkbW1QcW1xcVFuTWoxMXB2cEZLZS8zTzF5SnE4VkVjRVZSR1FnWHRJdktZ?=
 =?utf-8?B?UGVkcHJKU1BvYjE1RitRYXcvZWdBMmNOakJDNWlxZlJ3N0w5YmRBTTU0UlZj?=
 =?utf-8?B?MkRXbmNEY1VhcDh1TjIra3ZKd1lZbW4vZW9tUVMwQXZYVkVCVzRRRmsvUnN3?=
 =?utf-8?B?bVlWR0twbGVFM082UFgvdGcrL0hzVmdVMFEyUzZWN3FUbmRLTnh0YVhoZERC?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Mk5sdmVYQUYxajdJakNwSlBhK29vMEk3Mnpvdy9LMFBIaFNRR3diV25heTJO?=
 =?utf-8?B?VExpc2Jwa284ZWZEN21kc1NhSkhGS24yWTJYeE1wZ1FMc3hoa2JqVXVMMW93?=
 =?utf-8?B?dldBNmI1SjFTWXdUd2lLL0k0bmZ0Z2E1dHJJOG5INThFbUhxUEM1NXVVeVFQ?=
 =?utf-8?B?bTdrejNobGRoR3dzU1dFR0o1amlCcjJ2S3ZWQm9tM0twZTNxa1JlUUtYZ3Zs?=
 =?utf-8?B?N3QyU1NSMzFlZWI2RVQwZjNUUFAxUVFTNm5iYnVjdEFiclh0blJwTWpSd2Mr?=
 =?utf-8?B?UGFxUXo1WjlwNDAzZHRrQkxFUjR1ZlVqNVc2OXpnNDFNMTZ6KzVvRHlBVG1I?=
 =?utf-8?B?Vk9uT3JYWUY5UVFOc3NKQ3RqRnBnUTIwdWdWaFFvK25WcFg0NVR0blFpZmtE?=
 =?utf-8?B?QnFweUMveCtaMG1MYjd3N1FlTWYwZDVtQ0dwdk4vVFhtS3JOSEhFajY5ekpt?=
 =?utf-8?B?TzFybkpvY2x4SndXT0NWWVFLK3BBeUFaOGpwM1pFRmVFRXJocytYQ3pCOUl2?=
 =?utf-8?B?VVJlL1FFZ0g2YVltWHd1d2ZKRkJMMVhFM1VSRFNVZllxSDR0NFFQdENRcHNa?=
 =?utf-8?B?MzdGVnZCSFA3OEM4YmREemQvL3VhL2xzQUxVNTlSNGxkUFpQUTJPdHhCWjJp?=
 =?utf-8?B?WEZFSkZFYmxvdU5mRmk3anJadlUvSC9TZkNkTWpteFRqTmY1WGNiREo5dk5r?=
 =?utf-8?B?OWNpR0NKY0VndllxSVEzdVUrajdHQytsNDgrTTlzdWtid0M1VlJxRC9kUzlO?=
 =?utf-8?B?akJxbUdydkx6aWxURmdmalZuRFpERjRUc05weWhCN2gyYTdJZ0ZMVmlCejF1?=
 =?utf-8?B?OXYzR2tON2VuZ21JbVJlNFZqblE2NWJERVVNUmNLcVQ2R2w2RUFDQVFhQ2Nk?=
 =?utf-8?B?NXJ3YjJBUFpxcWtBYWM1S3puKzZqUkZHcG5lbDlLSWthTnkwTUNGd3NWY0Q2?=
 =?utf-8?B?QmhveXVEQ2tua0VoWGZGL0lVVnlqWm9OdklwZHA5bWJuK2d5UG5TemNmdDBl?=
 =?utf-8?B?NXNwUHpaVDF0S05XK215U2N4eTRjU3EwN3JLSSsxWmhwY2pnZUZrV2FJRVho?=
 =?utf-8?B?bUpBOWtOWXAxZi9mTkJxM1c0OEhMUmZwWTNmQmtJTm9oMEo3L09Mc3ZhWlBI?=
 =?utf-8?B?T1dhK0pWUU5aL01vaUJyMnhreTg4amcvVC9yYXBIb2pQMkRvb1VYVGpUVERM?=
 =?utf-8?B?ZGNVM3NVbUhkMDZrbCszK21WZm5KeTluTGd0cEZCSUkwRVprOTQ2R0VNLzZQ?=
 =?utf-8?B?dEV0NEp1QnA1MTNVYnVPWFR2VXQ5MUI3VGFrQ3dXdEk5Njd2TGl4NDBIQUlQ?=
 =?utf-8?Q?v22UEVbphZBLGhkxRcpV0w8gry3tmDujtV?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff5869-e419-4f72-b99e-08db7efcd422
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:14:16.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unHBp5QmQr/eicm1eRnj/v6xBLQVik+DYDxt0PxItnrGf1F6fPMCWLUNJ2EPf68uGw9TtY9EzdJNxcDW/fv7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6937
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:01:38PM +0200, Juergen Gross wrote:
> On 07.07.23 16:42, Roger Pau Monné wrote:
> > On Fri, Jul 07, 2023 at 04:10:14PM +0200, Juergen Gross wrote:
> > > On 07.07.23 11:50, Roger Pau Monné wrote:
> > > > On Fri, Jul 07, 2023 at 06:38:48AM +0200, Juergen Gross wrote:
> > > > > On 06.07.23 23:49, Stefano Stabellini wrote:
> > > > > > On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> > > > > > > On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> > > > > > > > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > > > > > > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > > > > > > > > Part 2 (clarification):
> > > > > > > > > > 
> > > > > > > > > > I think using a special config space register in the root complex would
> > > > > > > > > > not be terrible in terms of guest changes because it is easy to
> > > > > > > > > > introduce a new root complex driver in Linux and other OSes. The root
> > > > > > > > > > complex would still be ECAM compatible so the regular ECAM driver would
> > > > > > > > > > still work. A new driver would only be necessary if you want to be able
> > > > > > > > > > to access the special config space register.
> > > > > > > > > 
> > > > > > > > > I'm slightly worry of this approach, we end up modifying a root
> > > > > > > > > complex emulation in order to avoid modifying a PCI device emulation
> > > > > > > > > on QEMU, not sure that's a good trade off.
> > > > > > > > > 
> > > > > > > > > Note also that different architectures will likely have different root
> > > > > > > > > complex, and so you might need to modify several of them, plus then
> > > > > > > > > arrange the PCI layout correctly in order to have the proper hierarchy
> > > > > > > > > so that devices belonging to different driver domains are assigned to
> > > > > > > > > different bridges.
> > > > > > > > 
> > > > > > > > I do think that adding something to the PCI conf register somewhere is
> > > > > > > > the best option because it is not dependent on ACPI and it is not
> > > > > > > > dependent on xenstore both of which are very undesirable.
> > > > > > > > 
> > > > > > > > I am not sure where specifically is the best place. These are 3 ideas
> > > > > > > > we came up with:
> > > > > > > > 1. PCI root complex
> > > > > > > > 2. a register on the device itself
> > > > > > > > 3. a new capability of the device
> > > > > > > > 4. add one extra dummy PCI device for the sole purpose of exposing the
> > > > > > > >       grants capability
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Looking at the spec, there is a way to add a vendor-specific capability
> > > > > > > > (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> > > > > > > > today, Linux doesn't parse it.
> > > > > > > 
> > > > > > > I did wonder the same from a quick look at the spec.  There's however
> > > > > > > a text in the specification that says:
> > > > > > > 
> > > > > > > "The driver SHOULD NOT use the Vendor data capability except for
> > > > > > > debugging and reporting purposes."
> > > > > > > 
> > > > > > > So we would at least need to change that because the capability would
> > > > > > > then be used by other purposes different than debugging and reporting.
> > > > > > > 
> > > > > > > Seems like a minor adjustment, so might we worth asking upstream about
> > > > > > > their opinion, and to get a conversation started.
> > > > > > 
> > > > > > Wait, wouldn't this use-case fall under "reporting" ? It is exactly what
> > > > > > we are doing, right?
> > > > > 
> > > > > I'd understand "reporting" as e.g. logging, transferring statistics, ...
> > > > > 
> > > > > We'd like to use it for configuration purposes.
> > > > 
> > > > I've also read it that way.
> > > > 
> > > > > Another idea would be to enhance the virtio IOMMU device to suit our needs:
> > > > > we could add the domid as another virtio IOMMU device capability and (for now)
> > > > > use bypass mode for all "productive" devices.
> > > > 
> > > > If we have to start adding capabilties, won't it be easier to just add
> > > > it to the each device instead of adding it to virtio IOMMU.  Or is the
> > > > parsing of capabilities device specific, and hence we would have to
> > > > implement such parsing for each device?  I would expect some
> > > > capabilities are shared between all devices, and a Xen capability could
> > > > be one of those.
> > > 
> > > Have a look at [1], which is describing the common device config layout.
> > > The problem here is that we'd need to add the domid after the queue specific
> > > data, resulting in a mess if further queue fields would be added later.
> > > 
> > > We could try that, of course.
> > 
> > Right, we must make it part of the standard if we modify
> > virtio_pci_common_cfg, or else newly added fields would overlap the
> > Xen specific one.
> > 
> > Would it be possible to signal Xen-grants support in the
> > `device_feature` field, and then expose it from a vendor capability?
> > IOW, would it be possible to add a Xen-specific hook in the parsing of
> > virtio_pci_common_cfg that would then fetch additional data from a
> > capability?
> 
> TBH, I don't know. It might require some changes in the central parsing
> logic, but this shouldn't be too hard to do.
> 
> > That would likely be less intrusive than adding a new Xen-specific
> > field to virtio_pci_common_cfg while still allowing us to do Xen
> > specific configuration for all VirtIO devices.
> 
> In case we want to go that route, this should be in a new "platform config"
> capability, which might be just another form of a vendor capability.

I think telling people that they will need to implement grants-v3 in
order to solve this might be too much.  I would rather prefer a more
concrete solution that doesn't have so many loose ends.

Anyway, it's up to the person doing the job, but starting with "you
will have to implement grants-v3" is quite likely to deter anyone from
attempting to solve this I'm afraid.

Thanks, Roger.
