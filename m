Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F474AE0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGGJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGGJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:50:26 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599B1BEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688723421;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zePFT5XiLmd40NLg3plqqxO2fHljGl/Nzfc0ZkSQVJE=;
  b=UvsfyGZZ2RNSGm42TB1rI9LYne5Rw+6C63zD93JDZhCS62NuZYGTCbHg
   NfEaNg9SxqFGgeZRlsj0UuOEpIcMt9CuJgoRRVVulC2spPZ8ZFe+6XCeE
   EM7XFUAZzxaeiVbYiIqIaXDYl1t8veRYekuY8Skn6D88wm2O0ShdvTHgV
   A=;
X-IronPort-RemoteIP: 104.47.55.109
X-IronPort-MID: 115479382
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:BGsT7KtZEYJMR6XhLBxYNs7zr+fnVB5eMUV32f8akzHdYApBsoF/q
 tZmKW3TMqnca2PwfY8gOoWw8E4G78OAztBnSQps+yoyFyNG+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Vv0gnRkPaoQ5ACGyCFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwFRYKYzmIisKP6buUTrlAiJ4YJZHnBdZK0p1g5Wmx4fcOZ7nmGv2PwOACmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osjf60aIu9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAuiAd9OS+zjpqQCbFu72kUTMQQ3RXKBqNamrGC/AdZHL
 Go0w397xUQ13AnxJjXnZDW6r2SDpQU0QMdLHqsx7wTl4rHP/w+TC2wATzhAQN8rrsk7QXotz
 FDht9TtCD90rKyOSVqS876VqXW5Pi19BWoLfyoNVwYGy9jlvoAojxjLQ8pjEai6ldn8E3f7x
 DXihA86irYIhMgHzZKH7EvHiDKhoJvOZgMt7wCRVWWghithaZK/IZSh91zGxe1dN4vfRV6E1
 FAUls7b4O0QAJWlkC2WXP5LDLyv/+yCMjDXnRhoBZZJ3zCs/WOzOINd+jdzIG93PcsePzzke
 knevUVW/pA7FGWrbrV+ZsS+At4q0qHkPd3gWrbfad8mX3RqXAqO/SUrYFHK2WnoyRAoiftmY
 cbddtuwB3EHD6gh1CCxW+oWzb4swGY52H/XQpf4iR+g1NJyeUKodFvMC3PWBshR0U9OiFy9H
 wp3XydS9yhibQ==
IronPort-HdrOrdr: A9a23:OtehYK0UHQugIU94M1T3GwqjBEIkLtp133Aq2lEZdPU0SKGlfq
 GV7ZAmPHrP4gr5N0tOpTntAse9qBDnhPtICOsqTNSftWDd0QPFEGgF1+rfKlXbcBEWndQtt5
 uIHZIfNDSKNykcsS77ijPIb+rJwrO8gd+VbTG19QYSceloAZsQnjuQEmygYytLrJEtP+tCKH
 KbjPA33gaISDAsQemQIGIKZOTHr82jruOaXfZXbyRXkDVnlFmTmcXHLyQ=
X-Talos-CUID: 9a23:Txo0DWNtQFRf4u5DZQ9g+WcfF+AcW3TyyCf8LRWDAD5lcejA
X-Talos-MUID: 9a23:l5KRSAhc+xgOeoYfDh+cM8MpKO5o2r2PGGk3mLoZneeFbyhoPBG9tWHi
X-IronPort-AV: E=Sophos;i="6.01,187,1684814400"; 
   d="scan'208";a="115479382"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2023 05:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdwUEwUpkpyRqOGIStLkrIAVnHKwrLfx/tD2nk3jGV0PdvCViTObP9wTu9u4dB0AfSHyl1IIMYL9sriDi0tTNPZMogUG7IBeJRqOIf9mdVeJpfLwld1Ilz2pqMOlibmstTXQESmamEoZ9B6hstBSvQFWROMt9KIATXlRXowGN8MT9hMI4puFY24R3/D9NG4HSBBITfBmjoy7YmMaWSssD+QBYsou6kUoTrGg3E3CXZ0uPLOjbF4W0QkFSM5AZIHP5ewPFQyrqwMVWQJRkiGfpgtr+nXl1ljkdJCHdVMUIDw4tQC/K/7ZkS7ivmgaYQlflYUKMibo98flG4/S7me4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEN7c4/uKWPuDvJoEF95j+vvshfPei0q6oHxHAVw6pg=;
 b=ID1KNLntzfhjNAoLyHB2OLSftkgwmsIN1UdO8gF6k1tXUJeNrZTCUt0LszfowDLFYVVUoxDiAAEM/ULLMCn4GXwpQXZ+RLKqGCI2pDZRO7rilox/Em8lWHP/G585HsIvFGt3tejToKOWD5+ZPgMubKGTVD4vHe08jJtSITOjJt0yXRY3VjTp9EFuV2MfrWSONDmJetJsLqDn4Y6NC+lIqROZf7sdyisfAn2hVJKHr6cv8Afa8Y8UqpF+xlB37SYu51dU1tUXfClt7C/Azw3S3YK1thWagaG1i8H3E6QUAdpSfhaVUilTb79ir/Vew480TJmTqDrbpRzTHNjhN6xuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEN7c4/uKWPuDvJoEF95j+vvshfPei0q6oHxHAVw6pg=;
 b=vVhpynQGZ+VeJeTM83iJ85DVJrt4Znxy9H5+HDWbDrhIDk1UguGG04VhNE5E/J8LMkEmljl3Es686vCADjLh3xNbjJxxB9sjvmnrTIaTdHqresIsgbQTz3z1Hc8PCZryLXqxaFTNJnfG45wFlqeziq7pCwso46XYsEd+CuFNsoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by BN8PR03MB4980.namprd03.prod.outlook.com (2603:10b6:408:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 09:50:18 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 09:50:17 +0000
Date:   Fri, 7 Jul 2023 11:50:11 +0200
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
Message-ID: <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
References: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
 <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|BN8PR03MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad12349-2f80-480f-cd84-08db7ecf91fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tDTpj9dU8ePL3shRP5PshJ2WmRtYPMNMS3l73tX5/q+QmFInJLGpIM80KwmryJTQgu4BhxV1r1lwlFXag8sNk7vGklEQyvyQb0s897MRoNuNArqVN6d26EXrZd7VcxutSX6ChiXzK9EHHuC995TlxeHlpbsNojp8RYuYtzlvdAT4wQafIazu7J1/cXgPBOQIXnx8VfBWNvRCeTP3xZaGN/0eZzGPx6EhOt4Y9UEGp34wRMHBykoEfZdYYzy9b7+G/ZPowq/TSGkio6Bie2BbhiRUBEtETY4J+Mvhc0aCnb2fA8pYxflbLDJJbpvd0d8+8cwtU4L4ZYsOZ9wQv6zwl/GAmkcb/bnT3xCicRn/RnbRaQ3Eg1UiWhWW6RXrGm0GKoyZsVA9pss4pEidSXaCxWjtLLNSLtwkspP2F2/Msey3u4YmsMi7pIJJKjHxpuiDGgX7ARRccH+bvooaKxu06A5tzHw1DcFyARGkPpjokyRvcF0vkuT9UakKYY9nbEqrlnXqiBzilz09LftFw+rV8BmVuIcKR25qQ24ueAQ/1ByAijRFlTU1MiXzqQwPtH+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(478600001)(5660300002)(8936002)(316002)(8676002)(66946007)(66556008)(41300700001)(4326008)(66476007)(6916009)(2906002)(54906003)(6486002)(6666004)(6512007)(66899021)(26005)(6506007)(9686003)(186003)(53546011)(82960400001)(83380400001)(86362001)(85182001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhXcklsTFdBNDFNc1pEVXBKb0c3QlBQc3kxVUc1NG5NNUNIRkRaTXpYU05R?=
 =?utf-8?B?UzNRd1VWVDIrWFgrUnJCUWJsZm5LTFgvMEJ1MHNZeXBJeVJyNEY3MW1xbnlB?=
 =?utf-8?B?bzN0YW9JTE9jYmdCYmovU3RuOUo1bnNsRTBjTk01YWxQOWtUZ3BTRkZqU0J1?=
 =?utf-8?B?YWFMcVR4TjlOYmhhdlRQcXk1cElGM3dGZHc3dWZIL2RKcEtnck15bE1aWHV5?=
 =?utf-8?B?STI4UTh5dnFkYTE4T3dJR3VXWUU0ZitOUlRlL29XTERNSkdaOWNWYmN2TFp6?=
 =?utf-8?B?RWZKUXNVUDN5eG5zVnFoTVM4K3Z0UjdNdmtVcVdJNysrWWk0SGw0VUFOS1VL?=
 =?utf-8?B?Q0FQYWtOSVVjV3R6TjV1WXZUZ0lKTUdxSFArdzNaWk9RMm1TSWZaV1IxbVFn?=
 =?utf-8?B?WlNoc0xUdUhjd3F4NDBGZVZPOTBVbFdNcUtNYmlxNHZzOCt3c2VrT2ZOdEVz?=
 =?utf-8?B?TXd1ek5XRjlTYjBRcVpPRGxyTDNzNlNXK3hMSndTcFJzc0ZONENDMmJZcjlh?=
 =?utf-8?B?YlRmZ2FBaU1OSXNSKzkwMjV0TXRnQVZYSUlJYXhiMmdZL29YWWxjRHJIU2gx?=
 =?utf-8?B?a252eUl6andVMFVHcisvQjArMGh0VWEwM1VLYzdmMktVUUNDVHlIQkFhWWZv?=
 =?utf-8?B?WkFiR09telFJdkdLUk14bEZMaHRndzZjTWVEbklxT0wvK1ZaTDBIMEJpY0sx?=
 =?utf-8?B?eDVFNGd0Zzc4cHdsNnEvYUNOdzU5eThQbHhUdHBqL0RaVHI2MWh0dWhnbVdV?=
 =?utf-8?B?VTZmeEN0cFFmek5qRThzQm1GMmhydjlaUnMyczdSYnA2akx3ZEpJWkhNdVZL?=
 =?utf-8?B?MDMyRDI1WHpCYys3NzlpNXFGSElSVWVPMTFjejJpR0Nva2FlV3ZVZitLelBU?=
 =?utf-8?B?RE1TcHhBa0RYSEZVbmJuN2lVV0JEb0RtUjRmN1J4ZnE4NzJkNEhtdzdlcW1l?=
 =?utf-8?B?bXFwQXU3aUhRTStoSE52NHpqN3NoNkZHR3NPbUFiT1BncWsycVhyT3Bqb29a?=
 =?utf-8?B?TTdqMWtUWHlQMHNzWk9MRkZjcDE5WU1ZUk9uWjlFZTdMaWNPWnBqc0VoY1pV?=
 =?utf-8?B?L0ZSSVFwOGpwMHhLbkJXKytKb1hVaWVONFVEcWJmbHk3OHRURGJpb1o1WEVP?=
 =?utf-8?B?M1BFYzF4MWZIa0tSRHB3V3B0V1duZ0hUUDRzenR1TDJlVFBFWWhnNVkxZUEy?=
 =?utf-8?B?Rk9LOUo0Q3B5MTBmSVBrNmJNVHRaZk9MVEMrZE9oZlQzU2IxaExNQzM2WDN5?=
 =?utf-8?B?MFlibVplcmVYUGI5M2tqNkVWYUJNSzNSVGxTK1FSdjhDblFpOVE3Tml5dlBQ?=
 =?utf-8?B?Z3MrWEJBYVoySUYyRStkckJMajNQL2RtV1dkTGZSMFVtMXBsQU5memxhU3p1?=
 =?utf-8?B?Y09WNjlZc0RtdnZueEdpcXBjbzA3ekFqK0tSMlE4UUNzYUJ4T0VsZUw2S0tE?=
 =?utf-8?B?cE5HRk9yNUM2MXl1WVlVQVZuRFR5TTh1OUVDVjdlN05NYmJHcEdiYjNLb0dO?=
 =?utf-8?B?UjhqbUNXTzhjaDl5dW9KZnl3NnA3UDUxcld4dWFycUptYlFKejIwak80bCtz?=
 =?utf-8?B?UmV0ajFWc1JTOTVSVzFNQ3l3SFJZL1MzdzVvZnFtVnBWVWMvTEl0aWJta0xI?=
 =?utf-8?B?b0E5a0pwSWY1c0pmdmxHNVJEOG9RTlc1TW1Ocjh0cm9nS2VobVlZRlBUeGVU?=
 =?utf-8?B?dUI3U0NRQmRUSFhXZVEyT1hvSnhLWGFCT3ZPdjNYUnBxZmN5VVJSelBZMXJC?=
 =?utf-8?B?WmlzYk5HOVB0OVRyaHV0RDVoKzZjN2htaUdGRHVJVEV6eEZuUWt6RVNHNm8w?=
 =?utf-8?B?ZTgweGxJdTk4NVladXlVVHVHSTduVDJsZlRuSmg3aVZZVjltdU5YTzhWN3Iy?=
 =?utf-8?B?cis2NTFlVFR2SCtWeEUwMUlhRlRGRGxZRVhqdHlHY0dsd3Z0c0hkVldPZWxF?=
 =?utf-8?B?c1M2UUVKWUp0R3pTWGwwaGRDeGIyckVzSWJjYWtYSnVRRVBHTWtIRGZ4dGRZ?=
 =?utf-8?B?NWwxYXdXOWVxL1cvb3BPcllPU252RWJPbHJUOXdjclR6YVIvLzJmeGQ4WWly?=
 =?utf-8?B?RjNudHR6ZG1UdG0zRkw4eGdPSFVNb2ZUYURDV2gwMTJpM2dOcGpRUlpsUHNo?=
 =?utf-8?Q?CXiuFJw5lrY2qihBl8JFxaO1z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUJPY1FUaXFNVnU1NFQ4Ry82Z0Z0dGV0eFFYdkVaYnZ3ejdNbllpM2RuUlAw?=
 =?utf-8?B?OXJkSis1ZW90cVZWa3pGdE9sMDk1UGNxdGVLTnF1MzV0WDVpbGdna0Z3UHY0?=
 =?utf-8?B?ZHA1cXF2ak1HNWh2dk9tM0E3djFsYzg4S1krNzdrdXFDYkJ0RnNYTzdmNXh0?=
 =?utf-8?B?aW9YbVBpSy9sVmxqUmplTE1ZaHYwY1VFcHJabUQwYWQyTkIzMWsyN01CNnM2?=
 =?utf-8?B?YVFhdjB6ZGVhV0d2T0IrUWRoenRpdTlLcjlHSk11Q1dvVDR6RlkrWkx4NXc2?=
 =?utf-8?B?aXY4L3d2L1dyeFJKK1hqcTRGVFRMbmJUSjhTZmNqRW5Wa3NsNHVleE10WkRH?=
 =?utf-8?B?cm05NkhsMmZDeW5yQjlvRHJMM2RMVmxwbzdBRDZ2eGQvUlNtOVFwbG5Ta3Fj?=
 =?utf-8?B?TFp1aWJxS1ZQVTZCTFJBWUhkb1FCeERTSld4SEQ2VERvZ0prOGdJY0JLQUxV?=
 =?utf-8?B?S0dDbW1vc1dycnExL2VWbVFHS1k3Uk8yakxYcHpuczE5NzllMHRvMmNFU2dO?=
 =?utf-8?B?NmN3Tkw5Z1M3U1NuQmZVMGJhOFJlV3pVNmRtUVVQN0F3SU4wQ0xlbDh2TURm?=
 =?utf-8?B?N1QzeXJiM0lrTjhmTVF6UXl4S0JHK2VFMlhuMEQ3WlM4VHlRcHZ5YWVoYjNO?=
 =?utf-8?B?TjBYT0h2SlE0NkxjaHdMOWZla1NIeEh3Smx1dkp5bmJRQWMyTlNoUmdWR3lQ?=
 =?utf-8?B?ZEZydCs3eEtYemNtc1RUZ2dVY0gyWUJ1WVFDTEFKWnFibU5sSXZhUmNUVm0r?=
 =?utf-8?B?ajMzb3lkc0kwblVydHU0SURiQXI0TVZLNC9zd2hlWkUra29RKzQwdjFJRCtX?=
 =?utf-8?B?ZVpWSVRZWlRwdmJ3U0c2NDFJVjNvRGRiWXh5NnQyYTlVaWkwZ2tJanBkaVBC?=
 =?utf-8?B?dE9ZQ3UvaU5lN1JVZUkvdTRqMzUwQkh1NmNWSkNad1VzTHBaQWpML3ovbXAv?=
 =?utf-8?B?aE4xMEVEY01rR3h4L05VcEQxYjdFejFLZFBWQ0lYU2JwQVZOTEsyNi9TSzVu?=
 =?utf-8?B?Y2VLZUdDVC9QMXpYOGhDYXc1Z1pmcUM4K3dVd1BxQTg4Nm5JTlVidTBDb0h3?=
 =?utf-8?B?ZmJBWEVFUEV2NTFNRlUvV2ZWUWM1MnJ3VXJiNDdzWnpzL0FvSjY2aVY3WFJ3?=
 =?utf-8?B?cDBDRHFjOEc3a0o2bWRvVERrZzF2RGk4bXMrUkJxbEZtMmg0SS9ObkVCWmhj?=
 =?utf-8?B?Q1pxQ21zNU1pQzJ6djMzNlVtMHhMRDdRZi9YTXFsc2tJVG04MFEzcDdvZXdX?=
 =?utf-8?B?L21YSGlKb2UwNkVCL3BubzJBQnlaMGtBT0FTQUpaWlRVOTMvWXAzVmQwaklj?=
 =?utf-8?Q?NnSJR1+Iu+/mFYAbCkFpEbNEQYVxMw4r/V?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad12349-2f80-480f-cd84-08db7ecf91fa
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:50:17.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksjrDWtqWcxejqMpGLIHPl7hsxmC1bMlJIeJxq6dQxfzYLW8WBSCUpQxArMx/4QnyGv+q2vRGwnLakoJ0G3V1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4980
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 06:38:48AM +0200, Juergen Gross wrote:
> On 06.07.23 23:49, Stefano Stabellini wrote:
> > On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> > > On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> > > > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > > > > Part 2 (clarification):
> > > > > > 
> > > > > > I think using a special config space register in the root complex would
> > > > > > not be terrible in terms of guest changes because it is easy to
> > > > > > introduce a new root complex driver in Linux and other OSes. The root
> > > > > > complex would still be ECAM compatible so the regular ECAM driver would
> > > > > > still work. A new driver would only be necessary if you want to be able
> > > > > > to access the special config space register.
> > > > > 
> > > > > I'm slightly worry of this approach, we end up modifying a root
> > > > > complex emulation in order to avoid modifying a PCI device emulation
> > > > > on QEMU, not sure that's a good trade off.
> > > > > 
> > > > > Note also that different architectures will likely have different root
> > > > > complex, and so you might need to modify several of them, plus then
> > > > > arrange the PCI layout correctly in order to have the proper hierarchy
> > > > > so that devices belonging to different driver domains are assigned to
> > > > > different bridges.
> > > > 
> > > > I do think that adding something to the PCI conf register somewhere is
> > > > the best option because it is not dependent on ACPI and it is not
> > > > dependent on xenstore both of which are very undesirable.
> > > > 
> > > > I am not sure where specifically is the best place. These are 3 ideas
> > > > we came up with:
> > > > 1. PCI root complex
> > > > 2. a register on the device itself
> > > > 3. a new capability of the device
> > > > 4. add one extra dummy PCI device for the sole purpose of exposing the
> > > >     grants capability
> > > > 
> > > > 
> > > > Looking at the spec, there is a way to add a vendor-specific capability
> > > > (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> > > > today, Linux doesn't parse it.
> > > 
> > > I did wonder the same from a quick look at the spec.  There's however
> > > a text in the specification that says:
> > > 
> > > "The driver SHOULD NOT use the Vendor data capability except for
> > > debugging and reporting purposes."
> > > 
> > > So we would at least need to change that because the capability would
> > > then be used by other purposes different than debugging and reporting.
> > > 
> > > Seems like a minor adjustment, so might we worth asking upstream about
> > > their opinion, and to get a conversation started.
> > 
> > Wait, wouldn't this use-case fall under "reporting" ? It is exactly what
> > we are doing, right?
> 
> I'd understand "reporting" as e.g. logging, transferring statistics, ...
> 
> We'd like to use it for configuration purposes.

I've also read it that way.

> Another idea would be to enhance the virtio IOMMU device to suit our needs:
> we could add the domid as another virtio IOMMU device capability and (for now)
> use bypass mode for all "productive" devices.

If we have to start adding capabilties, won't it be easier to just add
it to the each device instead of adding it to virtio IOMMU.  Or is the
parsing of capabilities device specific, and hence we would have to
implement such parsing for each device?  I would expect some
capabilities are shared between all devices, and a Xen capability could
be one of those.

> Later we could even add grant-V3 support to Xen and to the virtio IOMMU device
> (see my last year Xen Summit design session). This could be usable for
> disaggregated KVM setups, too, so I believe there is a chance to get this
> accepted.
> 
> > > > > > **********
> > > > > > What do you think about it? Are there any pitfalls, etc? This also requires
> > > > > > system changes, but at least without virtio spec changes.
> > > > > 
> > > > > Why are we so reluctant to add spec changes?  I understand this might
> > > > > take time an effort, but it's the only way IMO to build a sustainable
> > > > > VirtIO Xen implementation.  Did we already attempt to negotiate with
> > > > > Oasis Xen related spec changes and those where refused?
> > > > 
> > > > That's because spec changes can be very slow. This is a bug that we need
> > > > a relatively quick solution for and waiting 12-24 months for a spec
> > > > update is not realistic.
> > > > 
> > > > I think a spec change would be best as a long term solution. We also
> > > > need a short term solution. The short term solution doesn't have to be
> > > > ideal but it has to work now.
> > > 
> > > My fear with such approach is that once a bodge is in place people
> > > move on to other stuff and this never gets properly fixed.
> > > 
> > > I know this might not be a well received opinion, but it would be
> > > better if such bodge is kept in each interested party patchqueue for
> > > the time being, until a proper solution is implemented.  That way
> > > there's an interest from parties into properly fixing it upstream.
> > 
> > Unfortunately we are in the situation where we have an outstanding
> > upstream bug, so we have to take action one way or the other.
> 
> The required virtio IOMMU device modification would be rather small, so
> adding it maybe under a CONFIG option defaulting to off might be
> acceptable.

Would you then do the grant allocation as part of virtio IOMMU?

Thanks, Roger.
