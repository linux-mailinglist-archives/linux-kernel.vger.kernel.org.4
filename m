Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0C6325DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKUObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKUObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:31:09 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1EF6C73C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669041068;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G3SSruBUWzJkSpyt33DrUwrJ9PiNYwYZUjb0wa/957g=;
  b=gBeW1KKUA4W+9B0dMCihJJjXRjksCqCcLQKqwRQl7MlUdguhWu+k1k37
   b/RfKOLq2zut/JVmQzbxWD8AymM7/qSbLJVHzw37rrFBJCCFwcbpX1YbW
   XnIWUajbrQcwK4KMms2VBlt2tuJxt6yqSW4pTbAVoZ+acrty7l0xfjCk7
   w=;
X-IronPort-RemoteIP: 104.47.59.176
X-IronPort-MID: 87795842
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:5Cba6a4iRCoWEZMAS4LhvgxRtP3HchMFZxGqfqrLsTDasY5as4F+v
 mYfDG+HaPuKN2HyKdggOYri/EkB6pbXmoM3TAA/pCA8Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraBYnoqLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+4pwehBtC5gZkPKkR5QeH/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5mx
 /8GFWlKSDO41/OR25axevdnt/kFM5y+VG8fkikIITDxK98DGMqGb4CUoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OnUooj+aF3Nn9I7RmQe1PmUmVv
 CTe9nnRCRAGLt2PjzGC9xpAg8efwnyqBdJOTtVU8NZpq3C96mJDMiQcTHv4p/iV03abA/JQf
 hl8Fi0G6PJaGFaQZtv3UgC8oXWElgUBQNcWGOo/gCmdx6yR7wuHC2wsSj9adMdgpMIwXSYt1
 FKCg5XuHzMHmL+aU3WG7Z+PsCi/fyMSKAcqbygeTBBD5ML/uoYtlRHeZtF5GaWxg5v+HjSY6
 yyFqDgWg7QVkNIR0KO67RbLjlqEo5nPQQkd/AjbXmu5qAh+YeaNbZSA4Fza4PAQaoqUJnGNt
 WYJ3ciX6vsDC7mJlSqQUKMMGq2k47CONzi0qU4/QbEi+i6r9nrleppfiBl+PE5BINcYfiWva
 0jW0StL7ZFaMX+CbqJtZY+1TcMwwsDIEdnjXNjXY8BIb5w3cxWIlAlnbk6R1mbiuEg016o4P
 P+zb8uqDn8GBL9niiK/Q+McybYnxwg/w3/eQdbwyBHP+b6fYmOFDL4OKFqmcO809uWHrR/T/
 tIZMNGFoz1bUevjcmzU/JQVIFQiM3c2H9b1ptZRe+rFJRBpcFzNENfUyLIlPoBgwaJck76S+
 mnnAxAGjl3imXfANAOGLGh5b6/iVop+qnR9OjEwOVGv2D4oZoPHALojSqbbtIIPrIRLpcOYh
 dFcEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:Q9aBgKxqTqAZtoK6Ua26KrPxRugkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Scy9qFfnhOZICOgqTM6ftWzd1FdAQ7sD0WKP+UyCJ8S6zJ8n6U
 4CSdkDNDSTNykcsS+S2mDRfbcdKZu8gcaVbI/lvgpQpGpRGsVdBmlCe2Sm+hocfng9OXN1Lu
 vq2uN34x6bPVgHZMWyAXcIG8DFut3wjZrjJTIWGhI97wGKrDWwrJr3CQKR0BsyWy5Ghe5Kyx
 mPryXJooGY992rwB7V0GHeq7xQhdva09NGQOCcl8QPLT3oqwCwIKBsQaeLsjwZqPymrHwqjN
 7PiRE9ONkb0QKYQkiF5T/WnyXw2jcn7HHvjXeenHvYuMT8ABY3EdBIi451egbQrxNIhqA07I
 t7m0ai87ZHBxLJmyrwo/DOShFRj0Kx5V4vi/QagXBzWZYXLJVRsYsc1kVIF4poJlON1KkXVM
 1VSO3M7vdfdl2XK1jfo2lU2dSpGk8+Gx+XK3JyyPC94nxzpjRU3kEYzMsQkjMr75QmUaRJ4O
 zCL+BBiKxOZtV+V9MzOM4xBe+MTkDdSxPFN2yfZX79ErscBn7Lo5nrpJ0o+eCRfoASxpdaou
 WMbLphjx9yR6vSM7zP4HUSmSq9A1lVHA6dh/223qIJ9IEVH9HQQG++oFNHqbrSnxxQOLyfZx
 +JAuMmPxbSFxqQJW935XyBZ3BzEwhqbCRHgKdOZ3u+5uT2F6bNisv3NN7uGZuFK0dVZoq4OA
 pIYATO
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="87795842"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 09:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csfjpdt0quG2PviwscLVDKzdldbEYEUIdSDQ8Fzbo3RN90JglsLVBfgl/jMCzZx2DqXXcS3FeF0ap0N80XEDrGXsoJIyasU47YILoyGKwZ4w9pnNedMnDia/52RZ8U6DTbbfSG4hyVpBc3XzhWA7EcmSqmEJM0ZXISOJmWFfB8KBG9KdGqloCpkMbAXex3Wy+uE41U56B3izPlW+OLUYTqFpMzXPvMdis+pxOleI1nwV+1T7i6IsOA61b3s6CMQWNoaD902sN3oqJKEOeQedfocT2PLhsyD8hrp6OrFpXn8a+Ik1sn1AF48yeIkhwmAI5C+Ad/wk8PKypXKcC/I3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/drRiTkJpiXLwzDMMfkyf5zJFFnRxlphj2PfuaNtPjU=;
 b=nBNqQAwt6UjpqDMazs3fm6SK5Kc6PmkVwC0UlwVsMut5BVtH7IIAApi13fgnalTevI3tEB+qDTci+l6gzX/IIe0Ne632ZyKJz501pQmRlZyom3ahMaXP9o8MTHm/rrU3q8jlB0NEZaevXT0RJucI4FOSH0DvJmuTfU18zMyjxtHoAHpfyF2tADUmv1y7lgqJRc4mj2Uetk4CUvT7hJVJ4hXiUnQC28uT5cHw39bmC7EG7DNZIdrqmOXMHrs+q4f/1S8CBsYS5ISogAGv3PKyPwBRkjAuy4eJKDy3gTCo7DFeLq2JnHAVtOYxXgW7DxBGYq6C+M3m+GlZnDaQu9JmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/drRiTkJpiXLwzDMMfkyf5zJFFnRxlphj2PfuaNtPjU=;
 b=A+MhFhxAhyTx2SVsVeec1KFo9SSd9K69Td38AQBYxxwdZ67JQzpT+NDFewHm0kXcOr9nIWJ0pw2uplwwUDZf/oJ7HS9VJuSmN74P8+C+RscWDt301ACnSB+YdlwTdJIEmJoi/q7iaVeLnk/o2Baqu1d8vA3Qxd7/42XZ1+q35nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BLAPR03MB5378.namprd03.prod.outlook.com (2603:10b6:208:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 14:29:56 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 14:29:55 +0000
Date:   Mon, 21 Nov 2022 15:29:50 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y3uLXq1diou2lHu4@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <d1042d77-eb5a-6577-9ec6-e6a7997f15d7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1042d77-eb5a-6577-9ec6-e6a7997f15d7@suse.com>
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BLAPR03MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d95f27-433b-4f1c-ed97-08dacbccdc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fcp2tumsv4w90w3Eov5e0Sl9BP5S4KNl/NFYkhxCsuZMzqWjHjjy9oxrmE/3KhY/SXqePhwKQ2iexZaJ/McNCwhDxjRxTev6pnbyNBot4ysAkRsYQ5ZT91+secJ7x9LYiGm1LWdVLFle/eieOq/i/534azJejrrCW6tCjbvOuw+wAt+lIxS+8oXmu1bv+fc2gbi9ZEdIVrDk1wVsV9lrmd5ftGXDsMras/AUQfkaPiVSVqcCZj6CshPRq3VWPZ9pVUlTgexrGNgd20HUaUITdzj59s13wt0PpXrVfjoqVoX0ugj5NbT1HugK5j3tdgjFNNQIxPDdX95oBOvpb38zWw7YXXuZoD0ERpoJ9xnBenAsTQI2QQjDsHKO99hPUyQMD7UyJSKl5J6J76r1czNMcYl6yuMphQBojDJAXaJTS86KFg/xFZVfg1sCIBjBghgOyLKWjtWqGo4SjHkjnoiOOU57z8kKxfX0LWwRsmO/9RAUIo0y+5T82ptaeUAuMbeVfm3aqpqVbPlJeQnWvjCf9GGIGXfRIksYVKiDkvvLOQcngzmHzi5OjgFB7evoB3hv/1cBG09AqHercirfq/dlTxa3L6/B4TuPGWv6BHQRxJnw9ZyDJSRyztBOzgdi8G5BMec94jPq2O9N2DF/JLUL9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(66476007)(66946007)(9686003)(66556008)(38100700002)(4326008)(41300700001)(85182001)(316002)(6512007)(6916009)(26005)(8676002)(186003)(2906002)(5660300002)(7416002)(82960400001)(8936002)(53546011)(66899015)(86362001)(478600001)(6486002)(6666004)(54906003)(33716001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3V1UnZhenBXeFd3ZmVtam1Vc3RoM3VzVlR4R1NUWTB6MEZqWnp5enFwMnI2?=
 =?utf-8?B?ZUdyWkNsVi9aZ2xLcS8xWDhiTHNuaEpXY3lxRmVkYWpSK3RBTENIRC9jZmli?=
 =?utf-8?B?U21wMlBKQUtQRUI0UkJxcHhXT1dobkY3RHlnYzF2UUdWTTVXN3ZaMERnNVpl?=
 =?utf-8?B?TjB3UmkzRTZlVEhXQ2htcG8wUWJ5LzlKNTk5bHFxSi9iclprRmp6TEJhdGVM?=
 =?utf-8?B?REt3cGxucmJub0JKU0pPaG92b1dCNmRhQU5pQjRYN2FudWgzcitST3kwRHFM?=
 =?utf-8?B?bHNkV2RKWlhmZnNZRG5IdnBBQzFjZUZYZHNrTnRqNWF3R1Ewb1RpcHBZZmtN?=
 =?utf-8?B?QTBZY1Mya2p2aFg0Q1RXTEFlWVZUUHAzUWhKRndwNFpPOVlFaWs0R3U1amFP?=
 =?utf-8?B?NHB1Ri9Lb3A2emFXcWtMeWNXbXovd3FQdHBuL2d3b2IvaGtZOXoxNzNHZ3Ft?=
 =?utf-8?B?QlBPNW5DRGZhZ0NnQ2RpdnN5SjlhVGJBbEVOU2R4bVRZdENkT1dXRmNzTXlP?=
 =?utf-8?B?a0hmd0NsQkg4dmV3MUF4VU9aUXdxQ1pudjZoOEgxK2VPQk13TmFHU2grelhz?=
 =?utf-8?B?NzcwdnZOT3I5aXZWWmFxd1VlT2ltTnRmcFlNSDJKVlhPZEVkZEE4ZDZIMGZ1?=
 =?utf-8?B?OWZaZzJ2SHpYLy9mR2FyOFBNeENHSWZrU21OUGxobVpaZWdRWDdndXJGT215?=
 =?utf-8?B?c0NjcVA1R1VTMFZPYlAvS2IxclhDbGJab0o0cXNoTlBkZnBrTVIxTVNuNERM?=
 =?utf-8?B?TjJlLzVackdnTDFnVUFOUnNZaXExVVExTnIvQkx4MjE0azVETlEwdEZRT3gr?=
 =?utf-8?B?RHlLUnNpOGpLQzl5d2NUa0pGanoxYjNoMzd2Qlo4V2ttd2pNSTN6cFBxTTgw?=
 =?utf-8?B?K3c3QzBwQXhvR014Zi9Ramw1b1EzS0ttRDBYTkZYTmZkTmlFdklMczVML0lZ?=
 =?utf-8?B?RER2R2VmeUROL3NhVUZKMmxVN3hKZ1JHeUsvT0V0elZwblJEcm9xWW1QMnZT?=
 =?utf-8?B?Y3g4QzkwenBLb05YdXJ5TVlad2F2VzNiNDByUlZxNDVjdmNCZ3hJWGJ3VkM2?=
 =?utf-8?B?ckE3bUdmS0p4WCtqVENhb2NhSzBkSGVnN0pVcGNHbkpEVndIYXdWbVJyTkM1?=
 =?utf-8?B?a2cvWVZZK1h3dDBLZ3R5VDI4SlJHL1JxSHo5bzdicVhxbHpXalN0aDJoQW1v?=
 =?utf-8?B?VHdEenN2cHByVDRaWjB0TFZ2SllLL3ZSb2ttREw1aW9VMjA4b3lWSWpubEJ2?=
 =?utf-8?B?TE11VUs3U0VoQkVyaHNFOUZ6bXFwemgxSDhocTFRYXQ5ZVdHM1lRVmNxb0s5?=
 =?utf-8?B?SlhiMUdnbkV6WkhGaXVVVkxJeHoyYXVyaWFab0M5WnhxNXZOQ0ovV3JvaVJI?=
 =?utf-8?B?dEZlSVdrUDB1dGcvdHVHTC8wSzRQRldKaURNN2szOG1jY0t5eXhKWWJnUFcx?=
 =?utf-8?B?U1d1TStKcnNEcS96MjQxdkZHT25zTElxN0EySC9oWXZjV2ZuV0NjK0Z6U0p3?=
 =?utf-8?B?cnZDRmgyZlJlKy9oWXZmbEhVcVovdVRwK3JxR21tb0FXckkzSC9pOEJka2p6?=
 =?utf-8?B?c2JCeEZMS0dYcWtHdWl5WGIvQ29ISExwOHU5Vm5BOFc4YUhMZ1RIb0hNcDFn?=
 =?utf-8?B?MTIwY005aE1rVTc1VmkxODYrTUh1eW4yVFQ2S1pvNUJ6UzB4SHB3aHBGclJq?=
 =?utf-8?B?TlVaNnBwa1oxeXFjaTJiS3hFNU5mOGRNeGRVem5WdXpsR3lxb0hiZFBWRm9a?=
 =?utf-8?B?SVQ5ZVQyMUR0M1R4a2NkUVRNdnl3UHRkcks3L3pBOTk3Y0VmMVJ5Z3ltdHU1?=
 =?utf-8?B?Rnh2cnFVZTZnS1Y0OXBlRlo3QjYwQnZGY0t4Vk50WU9rcGpNZWlCMFgzcGNi?=
 =?utf-8?B?aFlSeDE2RHlpTG5BNVNZSmVIY3NieEZ2R2taem5rZVRkWnZXRC9kMkgzcitM?=
 =?utf-8?B?OHVsOFJUWUllWFBhRWE0VnJkZWhpL1ZZYUdJVDlybGEvQ2tXa0NRWFNxelZr?=
 =?utf-8?B?Q2NvNE9hMmM5bERESVd6d0tFT01UbVpVVTFFOUg0cmlDSHBBY3Q5L1NaRDlX?=
 =?utf-8?B?d0NGaThZWTV1K3FrMGN6blNkNWVYZldJZ1dIRWhOK3MrdDVXN2JtbXRRNHdq?=
 =?utf-8?Q?yuTVttI7LGYABZUHb7uPnI/sN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N3VIR1pseTFBOVRmb1crb0N2MXRaL2V3cll3TWZCbHNoRDF4QUlJRk9NK1Bz?=
 =?utf-8?B?M0RUUFZXR3lCejd6Z2J2cFVqb2xSZU4zZ1ZCYk44b3VGeXJ4aFh0Y0U4QzJs?=
 =?utf-8?B?d20rdDlwY1pkOE54RHJhSGU5OElvNWNnNitibmtBazZ1NzFxRGg3MndRM0l4?=
 =?utf-8?B?TUFuckd5OFdHWm9BSnVDQlpzSVlxUkp6L1RDNjlYaXBmZVNjS283YndJL1ZB?=
 =?utf-8?B?ckk0Ulc3RWFMMVhJakI5TSt3UElia3BHaWllQzBVMEIweXlZdEV0eEx5UDVS?=
 =?utf-8?B?SlJNREo5V29qcGdlTjFpRjhWWE96M2I1SmNDc1pEcUJFdXZIU0hGWmVpQ3ov?=
 =?utf-8?B?L0lPc3E2MHBFNHhGREIybjU2aVppb1BlTnVKRWRqMkl4WVFXMGUwMldUOG5I?=
 =?utf-8?B?ODZoMmwvcEVpNGhWV1BHd0xocXVkdkVMUXJQVU9pbGNmL1daRDJJRkxiWm1Y?=
 =?utf-8?B?cWV3ai9raFUyWm1xTVdKRnlQdVo1VmZObVFuL21iVXA4UFh3OWRKcjhyenZy?=
 =?utf-8?B?bWtGOVJUSzluTHNWTnl4STF3VExtQ2oveGtCdjdaSSt0bHZUUWxrTFhqMUhH?=
 =?utf-8?B?ZXozcnZSSWl5VkNrbmNVbUkrNTAxeHhtUW1JMXdKdThJWmpCY3F6U1hGVkhy?=
 =?utf-8?B?akxmMlNKYzVqUnhRUldHTmZhVmdKR3R1LzlsQzlSUGpkdU45OFY4dEtvWHJ2?=
 =?utf-8?B?NmY1R1MyZkIvcUplVStwYlRzQlIwQzBmdWp3eTA1RFdsb3JXdzRDdEFtcmdj?=
 =?utf-8?B?ZWdLWFUwL0tsWE9aNHFVbllYMWRQMTlPcWtjai8wbEhqcEY0ZHZUN0thSzIw?=
 =?utf-8?B?M1dqVHhFVEpEQmdtNXc5Zys0WjJ2RFgwR0VTYmtRYWwyZXRPc1RqVGs0U0tW?=
 =?utf-8?B?QmZ1R2czcklzdlpXYktDSzY0aTE4dmd2elFDcWJ5ZzhmSCtBNkdzMkFJb2FM?=
 =?utf-8?B?TDJjeDYzck44ZXlod0FWaWNtdjBoaHYwVlFoWjdnVUFCTlg1aU9xV2s3d0dN?=
 =?utf-8?B?bUVkSWZFUUt3UElMMUVydmsyYXRkbnZsVVhsT25Ka054T2xjK1hhbUZST2I0?=
 =?utf-8?B?NFY4Rm5oQThhbzJKRkp5Z1NSNlphRlZULy83N0F4djk1Qll3T2l1eFROY29t?=
 =?utf-8?B?eERwQUpleDFxcCs2cS9VN29iMGNveFJjWjI2YzhSZk80TnJvQ2h5MmxLdlVG?=
 =?utf-8?B?bUZuV3Q5YmxxdzVod2I2MUdJY3llYzdHZnlveFdNRFQ0QjRGSXNuVUg5VGd1?=
 =?utf-8?B?azZOOTI3dGRQQ0h5dCtXOFRXY0dwSHMzRzN1K1FoUmk5Um16N3Fvb3Q3T01V?=
 =?utf-8?B?OFVMWW9CZngydWxXU0dIYjJGdWlzLzZCQ1piZjNEeURrdjAraDNRRTdIam04?=
 =?utf-8?B?d3BWc2N2SU9IWVRIN3dlQnFXNHVrNU1NajY4OEl0R0h4L2NBdzIwZGs5WDFP?=
 =?utf-8?B?MDBXdjhRM3RWK20zT01mSnFrZStaeFBFQ01WdGJFdWQzWU9tSTVjOXlVRUZU?=
 =?utf-8?B?VElFY1pnTDRsT3FLUGFhUTJndWE5V3NIaHZPcDZYdFIyWkhFOUNCU3hPTzVB?=
 =?utf-8?B?Tzk2UDFEUi90cm51UVI4b2YvRS9POHkrTExoWHFRN04xazFpczhoeUxsSCt4?=
 =?utf-8?Q?eWbNWNGduXMYunDu2LFP1tpr3ckpEhmdo/8Z4g8xZc9g=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d95f27-433b-4f1c-ed97-08dacbccdc45
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 14:29:55.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNwHc2HGL68Xjyb/sHJMiDjjLFT+0r9UcdjDs2EOf50Ybm1o/7b/r/G+KRFClUrAobSrlpDygbIiprvIujkFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5378
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:02:30PM +0100, Jan Beulich wrote:
> On 21.11.2022 11:21, Roger Pau Monne wrote:
> > @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
> >  		return false;
> >  	}
> >  
> > +	if (xen_initial_domain())
> > +		/*
> > +		 * When running as a Xen dom0 the number of processors Linux
> > +		 * sees can be different from the real number of processors on
> > +		 * the system, and we still need to execute _PDC for all of
> > +		 * them.
> > +		 */
> > +		return xen_processor_present(acpi_id);
> > +
> >  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
> >  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
> 
> We had to deal with this in our XenoLinux forward ports as well, but at
> the time it appeared upstream I decided to make use of acpi_get_apicid()
> (which meanwhile was renamed to acpi_get_phys_id()). Wouldn't than be an
> option, eliminating the need for a Xen-specific new function?

While this would work for PV, it won't work on a PVH dom0, since the
ACPI MADT table is not the native one in that case, and thus the
Processor UIDs in the MADT don't match the ones in the Processor
objects/devices.

Thanks, Roger.
