Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051A72D9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbjFMGUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjFMGUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:20:12 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 23:20:11 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F11AC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686637212; x=1718173212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4p592Cv/MfvCEJzHM3ocoPMg9iVnWwnixX//vJG4gtY=;
  b=NsewZBCJj5hqxqGkdQDrYih6wsPTG/oEKWY3SOph9v1QUk9vAq37AxkA
   nhXHyTFl0aZ25ec5SCTHWPUuXDMTWvXLXYpT9IIp6LmAw8gkxckr7b+Al
   BYJ+ne2khOXQq1H99YeNrlHjFvNBWLCX6oeRvz/owu0A1TmEiJ1EZxOE5
   3InE+xCEjkj0OehCDZnnl+Zsnpknrn673swXJRrDaQq1YabS2d3YKdP/q
   vfmGmcsLf44xuiqLCecWTAvarTp7+FTXQwY0cc0g2r6rXi3yjba5aoaAz
   uqekvIObHB3GqOZrKq6TsHvCbM58jPH3oh4w/pMf+xl/GBYdNAkUpF2fL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="95185938"
X-IronPort-AV: E=Sophos;i="6.00,238,1681138800"; 
   d="scan'208";a="95185938"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:18:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWCkiyEKWgNA8kiHVGTHsqUajyHQzy0+QdAncBBMDOC5UxbEkQ/AK1EUYw9rKyxBrn48Uck4yQnSWnAjsmwSfTCmy733ZKZ/3hdlUfAzpLkWnu86L5vskBYJtCVRIhJ8VuMn6FEXSRFWVUYNH2Dk9sV4zCVq7n9bqCAc6vzza9Rr0PKDo/wKsrLD0FlyT9ytN5t78DAbvS/trS8w0fMDv6O1bGPP0bvcDn2S5dJPMkwA/ZznZSDPtmyMx4hsO55bA0kYCS3g+HjBkx/ax76pD3dK3tG9r8J7gUWD+AZYJmhw36yfeetbIkIyS7kqBWQYqG90eOc2y/MUIC/3LADjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p592Cv/MfvCEJzHM3ocoPMg9iVnWwnixX//vJG4gtY=;
 b=L0Faioyo1X1s1qnzgrk9ImCYxAJapdIswz9/7/6EAf9xr36gYdtkfz+psDH+GS0VUeJFwdkmbL+oQdB/e1n2ZBB/86WuyumR4f7bw3Wg4lmaMiBA8ZR4YV9GOB0om0hafUsoL8Uu4/kqAzqfwFM+2xtUTULQSNxOQV1YS5WP31sez68AcfxDli5k+hWs858WxOWfJMdUjRvr0LZHFvN0aWUTSlpAFMmcbozDwj4yF9S8jxxhbd/2b/Edqa+TwKi3UcK28wEok0u5i81gSJSPcqaZFW6Ek94z8v1WtRMLA4jhux2uFHYgfGitTseQGAC2snn5Q8HgbI9AEynMESsvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB5981.jpnprd01.prod.outlook.com (2603:1096:400:61::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 06:18:48 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%4]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 06:18:48 +0000
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
Subject: RE: [PATCH v4 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v4 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHZjzMQjUO3LN4JfESuRGAKlrGdDq+IXr/w
Date:   Tue, 13 Jun 2023 06:18:48 +0000
Message-ID: <TYAPR01MB6330F25E5760D9A57733F7DD8B55A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230525180209.19497-1-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMTNUMDY6MTY6?=
 =?utf-8?B?MjFaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01YzUxYTVlNy02NGI0LTQxYzMt?=
 =?utf-8?B?OTdiZi1hYTA3ZWE0MDA4ZmU7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 5f0568dcddea40a39425555d93caff73
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB5981:EE_
x-ms-office365-filtering-correlation-id: 3ef0948e-bab1-475b-8838-08db6bd60c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTXjlsjud8hYv8nbnWXWqhDXndgs0pNKfILNgHNG/jNjAQN5YekZljQrtTd6vRLtjXLOUE8b+avUxlql4pahmhUquePgTzbepxUDzVB4lx6cVoJBUlRNYKzzb/t9RW7R7NKMQH3SwF68nhrmvorp5Dj8rxXB1R9tLQxtfDKgm9hUkHMCvLHJ+5qbvAMsdZ6qhbCgsnO6ip4wOF1E5hzDghwSK1F8DeIwsgo4PYe0h7wahHdpyG6SoEV33M0ye1lVL2J7fpibolpBl4/Mzo+8ptMQToKPuAUDFrCTHByLnZDrmIXfcJvsYVBnlY+6kspIF3njXGKIqBxVG35/oraxgdgqHVgDe526G0kTGHvC/u7sgeEJwiiUWI87BFmO7gVOTb4eBhKPXd2aEmwXd/B3qeoQmg29FkBxrPUWdZgcTCrnlACfY0jJTi7SNryh5fZx1KEwQdNfyGs5bMbLG4q6VPTnrUWvlbAbSEN7RbHjaVEwCieQZ+AfFoPHLRm+RiBkWP2a4odFMINuPnkWq9t0WUZM4GhDnwsiIuY8FtXhDSsL8lgUDiEHXMWu/n6NezSpFeI5QqMUH9qkolhiwN5WZT5vo27hDXWnJUy85ZXkJGOZB6Ftp/8kX6ZzTLNoJSHqpnD9DxDMGNMYjc+382XczQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(1590799018)(83380400001)(82960400001)(33656002)(558084003)(86362001)(85182001)(55016003)(122000001)(38070700005)(38100700002)(478600001)(71200400001)(110136005)(54906003)(4326008)(1580799015)(7696005)(8936002)(2906002)(8676002)(5660300002)(52536014)(7416002)(66556008)(64756008)(66476007)(66446008)(66946007)(76116006)(41300700001)(316002)(186003)(9686003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVMyWW5nQXhQRG5LR3dIRmhpaHEvSzU4ejRjM1JwU0I0OUFBZTYyRTVPS1Np?=
 =?utf-8?B?SHZ3d3ZBNGtQdFZDMS9ZaFVzTVBBZmVQWEtRNHprT0tOQ0c1bWRJZlNuZ0ZI?=
 =?utf-8?B?cmUvdGhoa1JYY0s0cGg2WWhhc2VFS1FwenRrYUMrTGNmY1pQZTdzR1AxZ2V1?=
 =?utf-8?B?TWRHdGp3aU1BUlJ1cmV5R2FKYktBempvZmpVWVg2Qy9Kc24rbmw3TWlMbjYv?=
 =?utf-8?B?TnNVR2xDeDVzL2FDSENUVXZJUXBIODNXd1hmdysrdlBrZXhZZ1VvSzR6cjVH?=
 =?utf-8?B?VllCQXpNLzZGWVRtdjBRUlJuV3RxNFI1VVpDL1A4d2FZTTE2NzBMNXk1SGdP?=
 =?utf-8?B?SmIxZnNPcmI5NUVmTmYweVV5ejRnMTJVdzNZTytpOXJzcWtRbUVESVlQQ2xw?=
 =?utf-8?B?R0lXWlZxMERJR1ZCaXFDREM2eWNBaDlZOENWMlZZUTRXWGlkRiszNnFHZFN2?=
 =?utf-8?B?dmtrcVhBcmZqUWk4UTdKN2ljU3hyeTNKWHBwV05ONWc4dTlSN3pBdlo0VVJY?=
 =?utf-8?B?L1dsZEtmd1RnRXVpckdGQ011YWQyS0NOVm1hZVVhc3VmQVB4dEZzMUdlRXdM?=
 =?utf-8?B?QVBxYS9Fa0RBczh1dXI0U29NWXJlL3Z5S2dIcDhEd09ybmxPdDUvSXhqL25P?=
 =?utf-8?B?WE93cXBSd2pvMi9ZVDUrdjZkT0JmcS9teUFyamlwL0NlUUxIbitGRkdUQU1i?=
 =?utf-8?B?MEdLSXZWWVZnNmk2RHgvYWxIdkNadnRvMnhUN0x3N0JKY0gxbFBHelR2K3dy?=
 =?utf-8?B?b3FKTWdpMUZNeFlCSldGT25jcy9SMEYrYzRVQUQ2dkJaZVdJZ1dMMmZFTllD?=
 =?utf-8?B?V3d6VE1CTUVKY29TbFdFc1BDTTlSVS9DRkc4WFloOEkxc0M1ZGdkUjcvRUc1?=
 =?utf-8?B?UllXWGFBa3c5N1ZkODFCZE9HSUZ3am85L3ZJUzFMa3piRkFzZGVvY1UvSDJ3?=
 =?utf-8?B?M2E4MUw2bXp1Y1d1TGszdm8wMHVHQU8zaGhIdnFFdG4wa2NDc2g1eVhxY0Q0?=
 =?utf-8?B?L1BHcVNuNitPZks1elYrQUZDRCtsRnpvTGtVZnZhYW1WVVlydjlxZEV2YVhu?=
 =?utf-8?B?NWRwRk5Ya05xaklVU0hCTEFlVUFVZUk0bVdGM2FFb0ROdnF2ang4RkVsNFZu?=
 =?utf-8?B?cXhKMlBtOW8rMUlpU1Q5OFZzcE9lWmZJYjZmUFMzeTFCWGtERS9pa3ptY01h?=
 =?utf-8?B?Vk1DWGJ4cEM4VGxHSmttSVdscG9rcTNURG9aOEpPQ3h4eW1YVWp6WHBjVmdC?=
 =?utf-8?B?ODZlTlZhQlhPZXl0bURqMVJWbFpCM2hYaVBVSE1pRi90bno4U1VveURmZFJO?=
 =?utf-8?B?QzBJQk16VDNKTk9iRXA4bTVxZ2x0RXk4TDkwMjhQcEx3SkNxWndmZ0ZROWIx?=
 =?utf-8?B?cHdOZ2Y5NTRlMjloSnk3bksrYjJyTTJvRGxsWjNYWUw2eXNmRWk3ZmRBazhy?=
 =?utf-8?B?bi83UWMxVDdiUVMwMm1IRndDUGxGYmhoOUFJY0xmaDJLT0xRSWJERVNUQWNt?=
 =?utf-8?B?aVVadVMxN3ByUkVVTnRLMjl1dkRsck5ibkp1bU5aZXl5ZEtDeUZIbEp5RW55?=
 =?utf-8?B?WDN0blY1dW41MTB2TkQ2cng4VjF4NWdieWpHRlVYM2dkeVYyTjFmMHV6azZ0?=
 =?utf-8?B?aEdDSmNXMFU5Y284TnRhUHl3VE5rZnZxRGZ4WHVBSTNEMFRUd0dCeEl2NWZM?=
 =?utf-8?B?MXRKMGoyZjFocVUySnhvQ0lUQTRJYS91aW5YejNBOTZqa2xYTFFGemR5bVJ0?=
 =?utf-8?B?WmFrSmRmNFFpK3J5TVppSWVVcmprOEJyekNIMWIzSHdGcDBpMVdtYVNGS3VT?=
 =?utf-8?B?T3IyQmFQSjNFVEsxejYrM3R2V0h1eUdYNy9VVjFUcnBueHhESUJBVWp5YlVQ?=
 =?utf-8?B?VmpOTUFSeEdMbi9TaGJuM3h1d0N2YUdvcC9OTUtTTjF5RHMvVU1iWGRZcEpM?=
 =?utf-8?B?Q240UEF6TW5nMHhGWjVCdUU2N3VoNG5yL01EeWpLNzR6M1lCREpYaHlCVkNm?=
 =?utf-8?B?STVBZUlOQjlnN2o3Z2Z4WUdIR1YwSm9jY1RERWdkYXJLN3owblU0VHpIZnAy?=
 =?utf-8?B?Y213UWpudzJla2pnd1RsM1lNL3p3ZGdiWUh4YTJ1eE5lYTV1OG5ndWFUR1ZQ?=
 =?utf-8?B?WjlzVWVMUVJIZWwwU0hnQnhpazFLalQ0UXF1SW41aWlRK2RRd1A4TTRXSW4y?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Uyt1L1ozdnBBVmxDK2tEbVJXMFczQSsrZjFlMWVPbU4zNlNXQWg2UTNOUzVq?=
 =?utf-8?B?V2IyN2NSWm5maWs3SWtld3daNFArc2hWMFRnbVltQXVXUnJtUk5pdHovN1pN?=
 =?utf-8?B?WC9pV0t3QnIwVHYzUDRrRjFBVTM0Yll1eEhjWCtTSTRoN0dxa3BOdnkrdHMx?=
 =?utf-8?B?RUxwSDVLNnRXdnFvTlhhc2srenpYSXNtNUlKcW1SbmJzNmpyTjRwSDNjNUtx?=
 =?utf-8?B?S1l5ck5UTEpkYjVaRnhqTHp0M2ViRzBzUVcyVW1sT3lZQmxNQ2R0SW8xSE5j?=
 =?utf-8?B?NHJ3MmlJdDYyT09wTVpCeDhJTzNHaVpVSXZYczdsa3NjOHJpZGwwVG5YU1hW?=
 =?utf-8?B?QXkxVHJiZXF2T1NNdm1VQldsSjlVWDF3N0pScWR0b3VpeWlZV0xhZFYxaE5m?=
 =?utf-8?B?MnlNQTdPTHRzMHBWY2RITGpOYjl0RmJ1MUlrOVl0TFZ6eW9xM3h6ZXNkOVV0?=
 =?utf-8?B?V0NuczczMEhLb0JKbEEvSHpxTXlicGI3ajQ1cTI3TWtEeVpMZUtza3B1WnU1?=
 =?utf-8?B?U3cxT3cwMHdLMnFUY2VKaVRKajA1eHRkb0xnaUtKZWpVNlQxbmVuRHc4dG5C?=
 =?utf-8?B?ajM4NkY3aWFhZ2xCdm1hYUhkdXVlZFliM21DeTZFVjNLRnpvMUdNRVU4UWNy?=
 =?utf-8?B?KzFHWVBSZEI0ajJJYkNoNU51U1QwNjQ5dGhuVEFiZnFCdWJ4Qmt5Y2lSMzlj?=
 =?utf-8?B?bGhBNSsrMG9NNXJMU2ZlQ2ZVeVc5VWVCcWlyWllEWjRPWGZXUTV4NHlpNGdM?=
 =?utf-8?B?M3lIUGdVaStZbkFQaEI5MitKclpKKzZ6RGxnc3EyNlVWUlBIeC9FbnJwL2pG?=
 =?utf-8?B?WXIxMXpGTzJydEVaSE1pWkxJdktxS2dOTVB3MFVFZHR2L3dQZ3hrelJOaENB?=
 =?utf-8?B?dkdGU2hRTVRXYVlTNUxTZ3VEamhwZUU3Y1NpSFprbGpyd0JHd3d5S3U5Ynpv?=
 =?utf-8?B?bVExQjVrbFNsNFVOSE8wTm0vMS9WVCt2aDh5T0VyWXVpc1ZqQ0tSUVhZNE9F?=
 =?utf-8?B?UzlEYy80M0x1YVhJdWxjNTVwcHhzV0IwNTJXV2syNHVHMk44bXcyeXJGWU5F?=
 =?utf-8?B?QWVNV2w1ZnNidnllb1FqdENXaXZQUHFoOHdHLzVHQlIxSldEeG9KUEJadWZ1?=
 =?utf-8?B?ZldTZllrbkhzRDNzZDVTZzlpM3luM01Tc0R5Z2dja0s4WW5WdWVQZ2cvSVpB?=
 =?utf-8?B?VGxKYi9tYW91THdqNFcydDM5Sytpc0JqQk5vY2czb2JOYmZWZnhsaFNoOCtt?=
 =?utf-8?B?T0J4bGdaWWtSZ0ZTR1dHdGNTSVdLbkN1K3c0MnpjK3FkS1JuZW9iWURmdnlV?=
 =?utf-8?B?K2xyWDRnZDNSYVFVYTZNTy91ZmdkRnRPa3J0Qm9aZjFVcW5BeVFkNlhuUzBT?=
 =?utf-8?B?YlpYZGRVOHVGRzk0aFlIeHdZc2RzM2llWHIzK1QrQWNGSkdQYnN3M0ljdlBV?=
 =?utf-8?B?MWZEcVJWWDlNZzVCajJyM3dDeDZ3SFIwUTlpMVNxK2w2eTdZalF1eFdOZmo2?=
 =?utf-8?B?YUVhaXJROEVnUzhjcUloMnBQZXUxSkVsMWw0R2grTy92b1dIMk11MmFneVla?=
 =?utf-8?B?ejk3T01mZTFkbDlURGRiSGxnZysvTEh5NjJwakpoaHN4ODhJNHZaTzJFOTB1?=
 =?utf-8?B?WTlQS29LUm1aRW82NG45NXBnNG1Jb3ZIZXRBdUExVlRhK2dzT3pFbFFEcVhM?=
 =?utf-8?B?VjZLQlphNERMM0JQa0V6UElrcDk0SE9oTXk2enRaTFVSQ01uc2h3UFI3VGl2?=
 =?utf-8?Q?hmHNMUs0KfGoIzCoVo=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef0948e-bab1-475b-8838-08db6bd60c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 06:18:48.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz9Gu97aVsSal+k5/o7nxaYk6kFnBUemTFSQXazzao80yA+WHJZsPUzCnSNc7HPChjM4KiDC6YN2Xx8QXAkBk8v18ir60MYXzcL6IzYkSlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5981
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkkgcmFuIHJlc2N0cmwgc2VsZnRlc3Qgb24gSW50ZWwoUikgWGVvbihSKSBHb2xk
IDYyNTQgQ1BVIHdpdGggbm9oel9mdWxsIGVuYWJsZWQvZGlzYWJsZWQsDQppdCBzZWVtcyB0aGVy
ZSBpcyBubyBwcm9ibGVtLg0KDQo8dGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNv
bT4NCg==
