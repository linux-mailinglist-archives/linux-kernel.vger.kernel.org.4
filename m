Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555A6C3394
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCUOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:02:19 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC91302B9;
        Tue, 21 Mar 2023 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1679407337;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Hg8QiyNc0Vom899KCM+alR/CySnDjyKMfq/pvLmP2DI=;
  b=SqdgIGOxr0M9sTUN4byMFbnwS+TrlmoOlH86dKzQXVNq9QRe6OVF75O9
   8ZAv1/1raviEpVgs2dONRWWOlTHkgzw4s9vq8sTbN5degIUW9m0kg8/lC
   d/kCNvu1g3NM9+7bg91MqZZL95X1zBQCnl2SLk66+LQFoCf3CGTDiYJcW
   s=;
X-IronPort-RemoteIP: 104.47.73.169
X-IronPort-MID: 100512262
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:802wmqIG5Z2bpZr+FE+RLJUlxSXFcZb7ZxGr2PjKsXjdYENS0GYFx
 mMfD2HUafyOMzajeNEkPI/n/UoCu8fQm95iG1NlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPTwP9TlK6q4mhA5QZnPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5IUU4Jp
 NEzCQkxZz66q9Kz/7GjFdJV05FLwMnDZOvzu1lG5BSBUbMDfsqGRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/VspTGNnWSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iv03rKWx3mlAur+EpX7rMZsj32Om1UeERIdeVCasfSkmHSxDoc3x
 0s8v3BGQbIJ3FaiQNDwWzW7rWSCsxpaXMBfe8Uk5QeOw7bZ+AbfHmEASj9ZYdAnnM4wWTEuk
 FSOmrvBAjhis6acT36HwauFtjO5OSUTLmgqaDcNSE0O5NyLiJookhvFQ9JnEai0pt74Azf9x
 3aNtidWr7Eei8Qj1Kih+13DxTW2qfDhThY8zhfGQmW/qAh+YeaNd9z2wVvW9/BNKMCeVFbpl
 HQNhcXY7OkIFpyLvCiMRvgdWrCv+/uBdjbbhDZHFYEJ/jCs9njzO4xdiBl7JUFmNe4edDPpa
 VOVsgRUjLdPM3+6Rat2ZZ+tEcMszLimGdmNfvrTdNtVJJ9qaBWA4jptdGaXxWnmlEVqmqY6U
 b+ZftyrFm0yErl8wXy9QOJ1+b0s3S0w7WTfSIr/xhKrl6GTDFaFRLFAPFaQY+QR6KKfvB6T4
 9tZL9GNyRhUTKv5eCa/2YoSK00aaHs2H5b7r+RJeeOZZAlrAmcsD7nW27xJU4Vun6VckOjg/
 mn7UUhdoHL7hHvaOUCDYWhiQK3gUIw5rn8hOyEoe1Gy1BAejZ2H6a4ec94yYuMh/ek7kfpsF
 aBbKoOHH+hFTSnB93IFd57hoYd+dROtwwWTIy6iZzt5dJllL+DUxuLZksLU3HFmJkKKWQEW+
 NVMCiuzrUI/ejlf
IronPort-HdrOrdr: A9a23:JISsQ6txuMpoN/qiOX3s/5ew7skDstV00zEX/kB9WHVpm6yj+v
 xG/c5rsCMc7Qx6ZJhOo7+90cW7L080lqQFg7X5X43DYOCOggLBQL2KhbGI/9SKIVycygcy78
 Zdm6gVMqyLMbB55/yKnTVRxbwbsaW6GKPDv5ag8590JzsaD52Jd21Ce36m+ksdfnggObMJUK
 Cyy+BgvDSadXEefq2AdwI4t7iqnaysqHr+CyR2fiIa1A==
X-IronPort-AV: E=Sophos;i="5.98,279,1673931600"; 
   d="scan'208";a="100512262"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 10:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtKVRR0lR6Ro1CqYtAQ75HgBqhLDGkQXpOrdBl4QbfRihydMn7iU9AsLAzPXdrPqwZVWnaAI5yifJmYawPjgekliDrArpEy6m8ZMHmMmBB+6AT9Hxn/zBvGzPjsscIVKyrsjReT7TLFf9Imf0XZm/ZBdYpNlGR9r4RGwBJsMiEvCoTjNK9x4tS63KHC9jeYgKuIBDl80NhtrK/BMHad+Jj9QIFRko/YPqS7lv62mb+GgJz3RnT+Kl67jzRBypTe25sxPAOYgl7POCwvRspCFNj5JAwhF5b09MPD8wQoaemLWjAQNMoj6KCItpNhThTciTM/SACPayQJSJg03E4OMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23A/TFIJGEo0EFuDgc/krWX2pmswq4Db1Ol0EjHKRbY=;
 b=FdSMH9vnfEYvxJxpv9oObjbOoooCLiC69ry2NqYwonkbmy3jafWykgYfNnJaJFUsbhv8CAtHvDpLJ4WKZsAEGPzzU1mB2q6mphGT5vdCqQPVpaODe6LbT1uegREEsfXzYZedoAh95zwBHHsotjPVpWe6RJey+1mP+LyNgVMZ3G4Y0KM5mxWvvpyYm4A/d3dCnV3cNix0paq4Rn+XnfUr+dagEPJ0u78yM/BAemesVLgs4R0J9olyAhPp0f5vCz+ScDcx2bJYegVo0E/KE65Pyclt8j+EoQ36XD7MMAfMwmlpB4LT5/pIQVlzc3dQj77kYDBf9oSaiOoB4upwG4NwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23A/TFIJGEo0EFuDgc/krWX2pmswq4Db1Ol0EjHKRbY=;
 b=ZKmEuaPScZm/382hCsWsXb4zJr7PNH+xuTPfy8pbSaIyvAWkEjv5kjgkWx4AU3s66xKU3EOcPTU5AwmJF9kgiAEOP9MzslaI8eHZW2dxGG9afVT8C2PXoYkkxtUkU/Whqp8sTy2DeP+USESpkcgyvRyZLSV1f80aokSaA1BI3Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BY1PR03MB7288.namprd03.prod.outlook.com (2603:10b6:a03:52a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:02:09 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:02:09 +0000
Date:   Tue, 21 Mar 2023 15:02:02 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        josef@oderland.se, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <ZBm42pgVCvsv6dzK@Air-de-Roger>
References: <20230316164257.42590-1-roger.pau@citrix.com>
 <CAJZ5v0jskeE8nJt04vyEkDO3rOwOHp36mcKcV=L9LGXD0HL6Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jskeE8nJt04vyEkDO3rOwOHp36mcKcV=L9LGXD0HL6Mw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BY1PR03MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddcf53b-3591-45d3-9bb3-08db2a14dc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMkrDfpD+WZqPvh3pH9z0o46/8a3sEAkjjwLCVYeyGyVWZpnfu2wT7APuDkMtuy2ZwtFMB3p+qXlP1Drz+cF8saOEaAxIukPOKdw5/dQVDZRkhPg4INmtKqL51AINKO+sHpsUwdyyjEnKB2ZHIbr3aSPNFrZ/78kOOOb0PbZtpI2VNXMybM8UCoMCg39tGYsQis4CKQAgECNQZfbPIMYbsx0E2ZULVKjPem4wRG0q/idtw9zPGAcGwz3lfOYZcH2dPMuf9nMYhVyk8yi7L5VJgJFtNGEs0Tutn4YZfR1nhw9dRwIi5lcZLs2sdKzoGXqBMJ2PlLvHAug7ZM3mQfcf655lWtGJa9qjLMV2oQaLBh7FI7G+Eu6ySHOdPtVuGc/DxjFhOrVhlhS464dQeF2jua4oF9hgEmslyipNZj/Bsu4/fY73xp3uesUeTujHBe9awbxDBtf1eAQ/hA6K7JlVaIl1ASLEQZiGqFuu13/D6kvu7QHZrpofG+moSyMF/NvAvqKeuJvlYMyqm7tjNndShLMdGOXRz0SUlDIrrvrtekk6wxVDrNbQ5nr0jFa4wFbngthWmqiCq7IDuosCk395Zl/Vf9Wnw1B4t8dV1DdNdBFMWOjP2RQQQQMQhhJxNF83aHSPTcvAYx3t2arRNI2TBsaF7+KIdhrF6Ds5RcLWRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(316002)(54906003)(6666004)(478600001)(6916009)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(6486002)(2906002)(966005)(41300700001)(82960400001)(86362001)(26005)(186003)(6506007)(8936002)(6512007)(9686003)(83380400001)(53546011)(85182001)(33716001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5UQzl0dWF1N3YySitFbHVhb3VQSkJhTmlDTVpyRWVKQ1BFUXc2MlVaOFY3?=
 =?utf-8?B?MEh5bVNNMlJFdkRwVjl0S0lvaXYzUnZIaTN1YnhEdmgwMEZWK2wrL29WdkFK?=
 =?utf-8?B?dVZ6dysySmtYaUxyWGxWNklhMk8wTDljRUZ4Mk53Vk1XbW5vYXJpbGlzSG13?=
 =?utf-8?B?clh5d1F0amFkNVh2MWpFY2dWVGxKZHlZWmd3Q2dldHhSMEtNTURhQTZCbmdT?=
 =?utf-8?B?SjdkeFhjUzlvSHQ4Zy9xb3VITXlrUFBXT1NmNEd3TXZhMFkxaFBoWHRYMUpC?=
 =?utf-8?B?aXgxd1hnc092SFRFak9JZ01Vbkw2YW5selZCVzI2RjZxakY0MVFjb2J2WC9S?=
 =?utf-8?B?Wlk5aFVyVmk4RnBZVUFaQ3FaRWhVbEJ1MzREUjQwYm0wZy9tL1BhTElGVlM1?=
 =?utf-8?B?a2g0MGVPT2s1eldiZFl3TWxuZGJLc1IyUkMyM0Z0cmlYWTFXbTRZeXBYYjN0?=
 =?utf-8?B?VWhsZHQ5T3V5VWtDbEtlZFJXaXhSZWV5bCtHN3R3VGU2Z1lDaFRhVDJyM0x6?=
 =?utf-8?B?amMyQmZxUXM4NHBWT3lURnVZNDAwZFp2RkptRUpWaTRISXBHcjN4d2pmaVAr?=
 =?utf-8?B?ZWR6emRqMUZQbk9aYzdZL1NvUUxxUENKN2ZWT01tSHJ5VXVCU21va1N6c3R6?=
 =?utf-8?B?QnZ2QTM2NEVMZ2o2bzRJeUl1R2p0aS9VeERrZzhwNk5HUGZWV1dwRnhKVlhq?=
 =?utf-8?B?Y1RadXU0V0E3QzVTbFYvbjRCaENnY1ZhQXhSVHpvbGIxSDJwZERLN0p4Vzd6?=
 =?utf-8?B?MExNK2RhVWtDNmhaLzgxRlpET1JSQkdKMlBEV094V1huem5JVHZUNjFua3ky?=
 =?utf-8?B?OWJ4SXRUSU5OWmQwTWtZNUsvdXlsMnlHcUExRGpkczFlUmM2RGtidjB5S1BT?=
 =?utf-8?B?MU1iVXVlSjAzdGhmSzdaSEVzQlpONitiSTJEWDVKM0JVNnpzTlUxemJsaVBh?=
 =?utf-8?B?MzdBSmVTYlF2Q0lJZ2FmakhhY1VCNkJUMkNLc2R4STQvVjgzQSs0dWdJRUd2?=
 =?utf-8?B?UXZCU1ZQZmRlSzBWZzkrN2ZHMExHdWoxek4vU1A0dnlNK1V3UDZFUFAxYjJY?=
 =?utf-8?B?ZjA5ZFJudzZxNmVjK3g3TkFscjNTVjB1dzR1NTQwQndYVzk2Uk9CTWVXZWRw?=
 =?utf-8?B?YlFYa1FhbTVHdkd5dHdTdzl5UDRtVHk2OHhHNEowSWlKQVdPNlJ1VUYvdERn?=
 =?utf-8?B?TkQyRGozaGtyaDVIN2N6ZXFGYzkxZ3lHTnJqUUVQZ0QxRGViY2gxNzNQTWVF?=
 =?utf-8?B?L25QRzdpTHFCa1REbWtiL1FWTWk0eVR6bS9sWE9pNXJDeGtyQ1VDK25iK1NT?=
 =?utf-8?B?NzlndjdReDJtK2JSVDhPY1dQeEtNV21XZzJUZFBESENOWkN6MW1GVGJKYkx2?=
 =?utf-8?B?OHZ2UXdocTR4cUZVZG1WNitjbTFWUjM2Mkk2L0ZXYWpDTFZ3ZG9jNU1zbGhp?=
 =?utf-8?B?ZFY1T0FMcTNJdnVlV2RoTDkvb1pNN1YrbmFLeExpWkRZanlocHFsWThqQUNU?=
 =?utf-8?B?NWlKeG1leS9KVjcxalhVbFpzbzd5MnJ1RmpoMWI2RHYvdVdGSytETUdYQkxV?=
 =?utf-8?B?MmhIazBuaDEwN203MHFBc0lNQ2V5cDlTQllUK0tDeXFvajlBK3E5NDUzRmhk?=
 =?utf-8?B?S1lQdGVwL2F0Qk9EbUMvdnZqVHBySmVkWENGcG5KV3cyb3BQRzRCSkQ3SnFi?=
 =?utf-8?B?d2JkRmRLQS9QQ0ZzWEFkZXkvdWx6ZmtxSjFHYjY4M3V0QnVncW44RmkvVWRJ?=
 =?utf-8?B?R0R0Q2tHMCtudVIvb05JNngwbEVQMUphNllUNjRqWWtKS1NETXNXZXc0anlS?=
 =?utf-8?B?OGdRRjBvNUg5VHZQQ0JrYXlRa0RKTzUyOGx2VVJEVysxWUU0emNoNEl4M1dl?=
 =?utf-8?B?a0dCSzVhUVJreG0yZmYrK0ZTTHNUVW10b2VQSXVhZ2ppS2x4NXI1T1orTWE3?=
 =?utf-8?B?RG1CdDlLWVh4NmFJSDUzS1RPRTZoK0s2RXZMbnJXRThHelVqM3VFZm1FWDlB?=
 =?utf-8?B?TENnSE9UK1hreVJWL0V4VzBheDFHZXlXUXhxaGgzU1BDZFplc2tGTTBqQ2s3?=
 =?utf-8?B?ckFaaTM2VkI0ZlRJQ21HMzFUMSsvTGtHOEFTRkZSakZXV1hITjhkV0tzZTZv?=
 =?utf-8?B?b2s2clpnUjBySFJZVlVQWE1rZjY3Ti9YY1cveWwyNE1HQkpMb0J0dnA3NXdu?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aUtOZ1YzK2RKUEd1bDhjQm1GZjFZeXZWYXFSYWk1SHBIRXFSMC9EZEVaODFC?=
 =?utf-8?B?N0hyZk5DNlVyVmF3ZlRneTJROVZaTm1hcjRDOUVXZGtPVDVjY1p0K1p5Q2Zr?=
 =?utf-8?B?VmY5dXdWWDAxMkkwcGZ2TmFCRys1SUZQRjYvdVJ3QndYNFJnVHpIQ1FISTQv?=
 =?utf-8?B?d1JXSjhyeWRGTEllcmxBd0Q3MEU5K1RRNjI2dGJDMGVuaTRkeDJ2bG9jMGc3?=
 =?utf-8?B?U1d0d0RkaThCcVV1Wjd1cDBJMmF2WmU2YXhPaU5NYkRtajhxMXpLSG9KK003?=
 =?utf-8?B?bnF6UFIrd2UvNWdDcjJZb25VWDExRmhPclJIWFBoQVp3MmpUSnExRXdmWlBs?=
 =?utf-8?B?YU1ma3A4RjMyY0UxNnpsSERJOG9wNXlpU0duQjJiRk8zZnlCSXp4MWJxNHp0?=
 =?utf-8?B?cWpVQXNudTRVZ1RBK1JyOFNoZUJQSGV1THJMbGVHdUJROGRieDdvanpobFRa?=
 =?utf-8?B?RVdoZVdScXByTG5mT1NkeFk3dG5pOG9qQ3k5WWJaNzN0Zmxzdm5OcWFUS25h?=
 =?utf-8?B?Z2ZaUm1RU0Mwa3pydWpHQ1lDNERzc3RXaFJ4TUgxdnY4VU12ZUVweWlTUzBO?=
 =?utf-8?B?K1N6NXhIU3RQT2lNK0hEUFFZNGE2VmdxUC8reTlBU014aXJESzdCWk5oL1RB?=
 =?utf-8?B?Qm9LcHRIS2Flb0c5QkpBbEVpQ0JkM2JlajA1OHZrVFYrNitTSUN3eXhEVkdo?=
 =?utf-8?B?OXB2RE9lam53RFVLREF1Zk9DRGZjQnJ5VEg4U0tES0E4TkNKTGFLY0tmRkN5?=
 =?utf-8?B?WmhlZnVKcStGM3JCL0RycDRscGlEa2R3OUxDdXo1TGZ5UnVaSTF5OEFQUXM3?=
 =?utf-8?B?dEc4SlJhQmdnWXJ5Yk1LeEFKY3pOUWhXcmVtYVB4emlONi93N25zc0VoL0tZ?=
 =?utf-8?B?WFVmYnZuK09ScXcva2Jjb09tREJ2Q3orSlJnWTlGVnRaUFBMUlpZT0dpdkVm?=
 =?utf-8?B?SWt6OFRmempaUkhaL2VXMVhsb3ZFdnZXMGdlSDFvWkVOUjhTaHNDVUdqck9n?=
 =?utf-8?B?bitjSFRzUHpxTE50Ni9KcWlXUU5NVnNGRDNoek9NZSt2T3VKMWFQMkJPZjNT?=
 =?utf-8?B?Qlo3TTgvUUVYQUx0dUIzN3FNa2ExTjJDeXJ3RjdVRGpUNWgzQ2I0eEFLc2lY?=
 =?utf-8?B?VWh2T0VNSkp4eGlaS3RYa2krR250UzBGaXB1Q0ltRzR6Ylh1QmZOQi9JejRt?=
 =?utf-8?B?ajlUYjhidXJBaW9zSjRESU9NN2tGWUo3bmt1bDhVYWtZb1ZJTDJPTjQvTHNx?=
 =?utf-8?B?WTVhc2Erbzl1Qm1zVkVpZlZBL0Q2Y1ZLRjdEK2dVUjJETm4xY21OUlZnd3JJ?=
 =?utf-8?B?dUVIQWtleS9Xa1hFNUI5WnQwUGRaUG9DQitEcGVGc3pRV3BHRHJXcjZIVHZC?=
 =?utf-8?B?R2IrTzVtY3hwQ1FQWCtFR29Gb1JEbTZ6Qlh2R3JjNFQ4TUlmNW1PUlN3T3h4?=
 =?utf-8?B?dGFTbWdFOWFaN21JWWVybE1QTmFhSC9WbFFweE9QS0hIdnJ4Q01PRGgzeDZW?=
 =?utf-8?B?cnY5NExTMDR3eStiV05Wd2hRRGZaVFdMY3VhUDRNamN4ajBZcHBZWmxKZHdV?=
 =?utf-8?Q?gKWnhp/SJlX16/kgYiMzv6W0k=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddcf53b-3591-45d3-9bb3-08db2a14dc62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 14:02:09.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFFYSZTmgmA8feQV2h7ObcVv0jX4mVX8L5m4mrZW5hUZMA8PqfkUSvvBBoBqdUQ2Vsq0D6KjukU86WB/5mE02g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7288
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:47:46PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 16, 2023 at 5:43 PM Roger Pau Monne <roger.pau@citrix.com> wrote:
> >
> > In ACPI systems, the OS can direct power management, as opposed to the
> > firmware.  This OS-directed Power Management is called OSPM.  Part of
> > telling the firmware that the OS going to direct power management is
> > making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> > methods must be evaluated for every processor object.  If these _PDC
> > calls are not completed for every processor it can lead to
> > inconsistency and later failures in things like the CPU frequency
> > driver.
> >
> > In a Xen system, the dom0 kernel is responsible for system-wide power
> > management.  The dom0 kernel is in charge of OSPM.  However, the
> > number of CPUs available to dom0 can be different than the number of
> > CPUs physically present on the system.
> >
> > This leads to a problem: the dom0 kernel needs to evaluate _PDC for
> > all the processors, but it can't always see them.
> >
> > In dom0 kernels, ignore the existing ACPI method for determining if a
> > processor is physically present because it might not be accurate.
> > Instead, ask the hypervisor for this information.
> >
> > Fix this by introducing a custom function to use when running as Xen
> > dom0 in order to check whether a processor object matches a CPU that's
> > online.  Such checking is done using the existing information fetched
> > by the Xen pCPU subsystem, extending it to also store the ACPI ID.
> >
> > This ensures that _PDC method gets evaluated for all physically online
> > CPUs, regardless of the number of CPUs made available to dom0.
> >
> > Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Changes since v3:
> >  - Protect xen_processor_present() definition with CONFIG_ACPI.
> >
> > Changes since v2:
> >  - Extend and use the existing pcpu functionality.
> >
> > Changes since v1:
> >  - Reword commit message.
> > ---
> >  arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
> >  drivers/acpi/processor_pdc.c          | 11 +++++++++++
> >  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
> >  3 files changed, 42 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> > index 5fc35f889cd1..990a1609677e 100644
> > --- a/arch/x86/include/asm/xen/hypervisor.h
> > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
> >  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> >  #endif
> >
> > +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> > +bool __init xen_processor_present(uint32_t acpi_id);
> > +#else
> > +static inline bool xen_processor_present(uint32_t acpi_id)
> > +{
> > +       BUG();
> > +       return false;
> > +}
> > +#endif
> > +
> >  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> > diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> > index 8c3f82c9fff3..18fb04523f93 100644
> > --- a/drivers/acpi/processor_pdc.c
> > +++ b/drivers/acpi/processor_pdc.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/acpi.h>
> >  #include <acpi/processor.h>
> >
> > +#include <xen/xen.h>
> 
> This along with the definition above is evidently insufficient for
> xen_processor_present() to always be defined.  See
> https://lore.kernel.org/linux-acpi/64198b60.bO+m9o5w+Hd8hcF3%25lkp@intel.com/T/#u
> for example.
> 
> I'm dropping the patch now, please fix and resend.

Hello,

Sorry.  I've sent a followup fix:

https://lore.kernel.org/xen-devel/20230321112522.46806-1-roger.pau@citrix.com/T/#u

Would you be fine with taking such followup, or would rather prefer
for me to send the original fixed patch as v5?

Thanks, Roger.
