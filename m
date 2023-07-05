Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BF747FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGEIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGEIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:32:45 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9FCA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688545963;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eL3MKtJPc6clE+hXfNEUdpeDKzjtx7chsrXgt9T9MJw=;
  b=GTzyLwNgXk1ck8v8yAOlibKusbyLJu4fNZduZMGEbmSRmgaf53XpsZym
   cZ3GF5kq6RQS1wbdMgADm+p1WboQv35f0P79kCy2oEUuMvZQSAqnMbS6/
   Yew2YajidiO/vyyFu08dpvKHRk5x7lrWEeFybaS11Kjws7LyPiog3NtnH
   w=;
X-IronPort-RemoteIP: 104.47.59.177
X-IronPort-MID: 114503051
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:MQchhamsk9OsANAhDt+H3pfo5gzJJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdD2nVO/vbYTb9ctsgbo7ipEwPsMSBmIdjTgNk+y9mQyMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgU5AKGzhH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 d0nDxsGQyigvL67y+y7E7RAvd58d8a+aevzulk4pd3YJdAPZMmZBonvu5pf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVkV03ieeyWDbWUoXiqcF9hEGXq
 3iA523kKhobKMae2XyO9XfEaurnxHqnBdpJTODhnhJsqFqKwDRDIhw9b0Omgvy01HeOd4hDA
 VNBr0LCqoB3riRHVOLVWBm1o2WYrwUcc9VVGuw+rgqKz8L8+B2FD2IJSjpAbt0Ot8IsQzEuk
 FiTkLvBBzN1t6aOYWmA7brSpjS3UQAQJHUHbDUJTiME5cfiu4A5ih/TTtdlH7Wxh9ezEjb1q
 xitqCU9nLwVgdQ867Sg/VvHjjSvobDEVgcwoA7QWwqN9g5lfsi9bpKs9HDA8O1Nao2eSzGpr
 HUC3sST8u0KJZWMjzCWBvUAGqmz4PSIOyGahkRgd7El9jKw6zugcJpW7TVWOkhkKIAHdCXvb
 UuVvhlejLdNPXiwZKoxbIurC9sjyYDpENijXffRBueiebB0fQ6DuS1rO0iZ2jm3lFB2yP5gf
 5CGbcyrEHAWT7x9yya7TPsc1rltwT0iwWTURtbwyBHPPaeiWUN5gIwtaDOmBt3VJovdyOkJ2
 76z7/e39ig=
IronPort-HdrOrdr: A9a23:rkZru6oDgcM1Is04Yx5I55kaV5oleYIsimQD101hICG9E/b1qy
 nKpp8mPHDP5wr5NEtPpTnjAsm9qALnlKKdiLN5Vd3OYOCMghrKEGgN1/qG/xTQXwH46+5Bxe
 NBXsFFebnN5IFB/KTH3DU=
X-Talos-CUID: 9a23:QSPTBGHShosRs6ESqmJGy2k/Ee0dUUaBwXyOIxblJV1zF+aaHAo=
X-Talos-MUID: 9a23:YYuqMAoEF2Qi9H5+NvcezzZ7Mp84yaWFMlgQspAL5fC0GXZsESjI2Q==
X-IronPort-AV: E=Sophos;i="6.01,182,1684814400"; 
   d="scan'208";a="114503051"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2023 04:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKjjxcFSEMMUl5J+9evJXIErkfoG5bec5ITLaGfD31vYS9liOHJLolrCXonTAur09sdm9Xq/lQhlNxiwvfSSTvZU96902Feh/9F4tFDKl2xkpfOJgirT+7RSHJBfqecI2CRwwhX+pu6/87O4p1xzqH9mmROFAj6ChI1/Zz7r71xLyxpKG2ST8znaz0hLkJ6hfP3ORVWYoeiMetNW7CSPt+xomdeMa8upKIhB2iSowR0YEHHQG21/EhUTGoi+bdUaKyxfEAyHviuL1NTEjkGwi5FabCJCmsFZaFSGh5EXxnJyXJuY1v28g4q92zjvv91DwgK98JpEwFLttk6ktMYmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xo8LwWJoLmfNQ+YRzQ1DOI4zaYY9XdJ9XZv0GQRJN0=;
 b=NDACbzQ6j3y3c2NChiI/N4EKbH2W0JzaFe9adijpiJvaumWG9CoDVFK6x2MakXdrQlvRIA2PSK2JcTD0rA78MoF0YMkowx+RkiHc+Y1GJAXQmgYb31UmEQGH7cgpHl2ulh4+uyWr6WOki8bM5iiR9fdtTSP2EKpND0b6VCMQksj0GNaBNrL8F5j58qjAQEQwVF+h0WjMEBwgElgnajqpeY0BbgHh/7VcgHNOmzvahbh5HxvQUBuxmf/2UtFG71mDEaSsEJCBeM1ajzP/lhgAd3sV7Pui5V1IPUzlkOQxv5R+IijQiOq7GmL14r+v2rVUAi04rYSXJp+8VBY5BjOBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xo8LwWJoLmfNQ+YRzQ1DOI4zaYY9XdJ9XZv0GQRJN0=;
 b=JxIUIPHkC4AHZP514f+158PbSOtWxJmZOVUtrW3fgOk8Eu4suafpGyUWBiPBKBlMw2pSrsaLznzNPZ0yaPIZpYLHwWyn1rpJsRm0Cn0npnUBqddzf/hWgbj3DLZPgnRvuDSE2PFPbIiBQ2fyjWOBK3u/2u+XtwS1R7KeuN+IF10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by CH3PR03MB7410.namprd03.prod.outlook.com (2603:10b6:610:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:32:40 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::1c83:1877:a68b:8902%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 08:32:40 +0000
Date:   Wed, 5 Jul 2023 10:32:34 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
References: <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
 <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|CH3PR03MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d03451-0a6d-41b3-8e0e-08db7d3264fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnTZCII5EMwhhGJ8zHBM7gTaPnm0WcM5+DILxm3fpFoKDlOmuuI0GhUcN63K6Ya6ml7p9oAkAmQBn5e3cKGYgGP3HY81He7LIOHccStKtYIqGeeTh7RxP8elW5ajBlntUX6R39YZruJp7HLC44D0HwVXYENQVHY8k36QlZg3WkSCgckiuZpxaQe6BZ2yzY3IrHH0IgDNglWfU2bduFElP+Ui0EaUI4wTD4qk48hn4GIHmcE3HKih27X7CXuB0Z/K4p4Fqad+8mNe2EwnPH7+hssca7lzgqmrP7h7+NeQw31YBX2WgDf8ZfnM1mOaJa+r4pPyXAwyGPcSP0LtMe8FEtor04cTQV4oL+RFPvJmCdHruC36zEJZ+ytAxm8DEJ9QBK411vSPJnCJT74M6i6+4+t10Gyg1GLjnY5mRJp95J6PiyRBfSG+gWX2wioFJznkWFpyI9o0SMORezOGcLQc11T6Ku7YUc+TQ7nWNbBU8DxHx7C3EOgx6/65TS/O7sf91ORp0E681HsAFtcOE91XyMC1tGjrIVjuN4K8SWDk2PzR3dffx1DrByORfcNTgIU3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186003)(38100700002)(82960400001)(53546011)(6506007)(26005)(83380400001)(66574015)(5660300002)(41300700001)(8936002)(8676002)(85182001)(86362001)(6916009)(2906002)(6486002)(66946007)(6666004)(4326008)(9686003)(6512007)(316002)(478600001)(66476007)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzMrNXE3UEpDMW9PWjRnWGI3cVhpQ1Fid2dVaUFNVWFSMFRteWdCQ1VWWm1v?=
 =?utf-8?B?bVQ0UzhUelRtWEhTSXBIM0JxaTBWb0FOZmR5Zy95bVF3K1VTeXBLbG96Qkhl?=
 =?utf-8?B?QTBwZjdqQjVqbURFYWJNbzU2Y1EvSGh6QkVjOXBkODQ3UFNoSitaUFNNN24y?=
 =?utf-8?B?eE53SUVkVjI4ck16OHhOL0FSYTZlSlZHOThXVG1uOVJhcUdYczRtempDOWhw?=
 =?utf-8?B?MEFhL2V2MGQ1VTFJdE5FNU5QZFVJZ1FkUGdMNUF3bHJqTjlRUk5PZGZDY2pq?=
 =?utf-8?B?QTdmYWlqTVF0OFlwTGw1ZFVDUmVsUy9aWk15djVGdHVlWGo0Uk92c0lCbUUz?=
 =?utf-8?B?MGN1dDMxWnJPa0JOQ2RQOG9mb0UxN2lLRFM3VU5vbWIzSkc5aFRYaldtRE1p?=
 =?utf-8?B?TUdvZmhzWjNodmswbFpnYW05YlMwYlVEU1E0MFlRM3hmTysvUlRwdHZZVWhE?=
 =?utf-8?B?QUZMejdiaGYvaG13eTl5Y0dQd01wTlpPNjFUU24xVlU5VE42cEcrRmJHU3Jx?=
 =?utf-8?B?SXZXZmpweEFqNFVMdC8zY1BEbEo3T1l4ZmN4T3JBV3RMMWkvR2lmemEvUU82?=
 =?utf-8?B?c0xWbXBvbURCVnYzdnlNRk5hd1piS3Fkd2g0MGd4MU10dnp5RDg2MXRpakc2?=
 =?utf-8?B?dHFUK1pQZEVKQmFiTjFNb3hJWkFGRWFxd0VaOVJNbXBoSzB0RGhwYU9jOWts?=
 =?utf-8?B?SHo2TXdPeFRoaXAydzV6SzJRU1JDMEpqbUFleXd1Z0MyRW5FbE1hUjAyWDV2?=
 =?utf-8?B?NUF2UkdsSW9BSDh1ZUhYd1pjVVptb3c3RllaaFpGYmg2MXRheFluTHhaenNT?=
 =?utf-8?B?aDEzaFlieWR2R1B1ZklzLzBWU2ZPeC9VZjFBRitWc1ZENjZsU1RiL0FmTHFu?=
 =?utf-8?B?bEdDTGF6bU1hZHVvdXY1WXgvekYvd0RFVlpOYW1mWkt4dVg5ZDVueU5TajYv?=
 =?utf-8?B?TTdyejNGUkNaN3ZTZTk0Rmc0elFDZVhRZEZacFhwdDVicENYNDhNRG0yc2RE?=
 =?utf-8?B?WEtwSHBhTXoyRVNoaE0xbmZIN3N2QmtnYUM0YVlQZDNtbXk4RFp2NmJEeG04?=
 =?utf-8?B?ZXJHbnlJdkF3MjllVmhmMHRWQlIybzVuWmJGSnpJMFVONmRUMGNYZ0Q3RUxZ?=
 =?utf-8?B?NzV1SVB6NVVYY1AzRlRnekl5NUxkaU5SQnZ6aFMrUm1KODJMZ2RLb3Z0TVA2?=
 =?utf-8?B?cmNwdFdsV1R1VTQ0SzNpS29OTUtZQUtHeFl5MWllWDI0ckVva29uTTB4eFpt?=
 =?utf-8?B?cUtOMWtPRHhvdHdoeDJEQVVtV3Z0YnZBUm5FbUxyMThlZlI3R1hGRUJPR1RW?=
 =?utf-8?B?cmVxc3p4SWptdGtDbStpaU1FZ2hRUUxsaWdaWXNyZ1AyWFN1c1FCOWlEWXU1?=
 =?utf-8?B?M2dydWlrbDhaZ1BVeFFlN2ZsdTM3Z0tmYngyUVVVNnVpckpCc1huZmYvOGNu?=
 =?utf-8?B?ZUV0TThNZWM0dUFvRnd1aUJTeGo3a2ZXN1lES2FaVGpKNXVRZWxLRDIvM0Rp?=
 =?utf-8?B?dlpobkQvcm5vaFdCNitlUUlyOWZVYklNcGljTThaWVBBRXV3T0dwYllNMUU2?=
 =?utf-8?B?SDFFaEJ5ZXVDeEYvZ09VYkpCOEsxQTVxemhWNGRRTWV2dU5vOE05MnFiZGJn?=
 =?utf-8?B?Q1VqVzUybGlMUlBqRjRZRy9iQ20xd1k5NHNHSkdmTzBOWG1kaWE3YmNNTDBR?=
 =?utf-8?B?TG0rcHpxWjdqMW1JbEhrNHRuakZlVkpoZ0p5T0J2RXVsN3F0RlFVaHJ4cTQ4?=
 =?utf-8?B?cWs4WXV6d3RrelVuakxNVWRHRVlMR1dPZXdJYmJMZTlwdEd2bndLK2dsMVEv?=
 =?utf-8?B?eFQyeitNcmE3Smp1UEpjMUkzQW5sVnliNlF3Y3Y3YnhUZXB3ekVUaFZkbFFr?=
 =?utf-8?B?Q3AxeE85ZExQMVRJL2pVYWE0VHRQVFdrTjJxYWpVYjZLZFRQbDRiVno0cUpz?=
 =?utf-8?B?dkNidkJjSTJQeHYxcVJVR0FNTzRzSjJWZjZuc1dXVk5oRml0aEN5dVBkVUVC?=
 =?utf-8?B?NGhHZDlMcEk1TXk0OWZiOFU4L0dsK1RWTFVBbmtmdHNlWEZ1ZTlpSG5kOVE1?=
 =?utf-8?B?NEdpTW00RUwvWXptQXFVdDNxbGUrSWtCTDhFR2dwVmNjQi8rcHBKUnpDdGMx?=
 =?utf-8?Q?k4PFPOmAgt/5RsW8Kjq0Q3/hk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RHhKb2ZpbWxlK1d5UGVJcmRic2huV1BIYzlZRTl4c21SMDdaQUhGT0dXNVNE?=
 =?utf-8?B?SmVVc2MzaDNzWktYazJtWmhQM1U5aTR0UDBaN2liZE5SQ0ovMEpLcko1ZlRm?=
 =?utf-8?B?cDRhTElPVFJ3QUFRYjZTOUxQQlI4bGovRHVEamZqb0x0QjUya1FZcWQvTEZQ?=
 =?utf-8?B?dWdZbmFxR2RiQ0NDWmcvNndEaGc2aStncFpQekw3NHprME1Id2FUWXpSOTJC?=
 =?utf-8?B?TmIrS0lKLzQxWkJkMlhxM0J1TjE4WGVXZDZDM1lGMkpEaGVLQ3RhNTUxSGFW?=
 =?utf-8?B?MjdUSUx5aVYzbmZkZ3ZFRkRCSTQ4V0JNN1dyUWx6SW1hNHRuRk1mUjN5Znhq?=
 =?utf-8?B?ek5CUmNWdld5N1lLSUp4U2ZRZkFaaUNuVWZVc29KcExxT2EvcHozTjAwUXNl?=
 =?utf-8?B?clgrekZhTzlBMURpcmQvMVhRWW9DM1hLL00rVElyNzFFc243NTlDb0RCL3dJ?=
 =?utf-8?B?eWdPR2pkMXNyb0ZZQWFpenhoRXRtVU11d05PbDhqUEROUHVLcytwY1pvRTdL?=
 =?utf-8?B?RGtIMmFGN1VEdFNvK2dkZjVBeTdYb3dta0g5NEF5aXNvQUJCcWJkSUFnN1NP?=
 =?utf-8?B?aG1NdHg4S1BIenhKMU9MUko1UFY2RTZQcU5kYjZobFVpd1BNazFzUFA4d2dM?=
 =?utf-8?B?VlhiZm5oV3FRUnc5bHpLOTV3VVU1Vkk5d3N0bXBJd2NGOUl0N1MzVHhTaFdG?=
 =?utf-8?B?bUZDeWRPY0Q1TXNMWitGR3RzeGhQamorUUhoQlowMUYvVU5vd3NwdEE3eGhW?=
 =?utf-8?B?NXZPMVlrckJLMFFGY1hQVlh3dVdnMXBENENkeHpkSjQ4THBFNWtzMFJYYjF2?=
 =?utf-8?B?Vm84QVQyWlJxcXBLbzZKRkd4TkNZcEdpblN3dUFzUFhGTFNMRUYyVExnaEJh?=
 =?utf-8?B?NWFNL2s1azFCWFM0UUdCYlRRV1M5VTdvaVlFUTRoaVYySHZkR2lLMlY0N0hF?=
 =?utf-8?B?OW1QVHNEcE1Dc1Q1a3BxZzVlc0Q1VlZWdXY2aDkxOVVJYXZGZ2wyZ29sNFNL?=
 =?utf-8?B?cUJmWTZORDJzb0VrM3ZXZ2RjU010RDNvRlE0Y294N085YWNpN1MrMW5uT0x3?=
 =?utf-8?B?SmZaank2UnpkNkRoK2czSDFTQ0ppcXVIYitkYVpPdVRjTUpZclZ5WkllTFBh?=
 =?utf-8?B?cVJkNFU1aVdzcklQeVpXcDJjdXVYVmJkeW95cG1xek1abGZlckM2djhUOExi?=
 =?utf-8?B?YzZmUlM2ZXQzY1Joa0VqNU1YdkwrbUNNTjlRR2p0RjVxMFVnbmw2ditFdjYx?=
 =?utf-8?B?ZDNPRVRUbmlZRXgxLzFJQ0tJaWtmckpRTnpzY2dRY2R2dUlBSVFTV21nbTZO?=
 =?utf-8?Q?SD+GH5n7bHyKrgVZdMh04FoQxrEGzYb2en?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d03451-0a6d-41b3-8e0e-08db7d3264fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:32:40.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaaTlZ50s3ERWKt1KtKcYzb/YwSEIUlhMLpB27MuekP43cLowa0QWOy+AnONG174qGF8s62Ewc955aWdpGiv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7410
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> On Tue, Jul 4, 2023 at 5:49 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> 
> Hello all.
> 
> [sorry for the possible format issues]
> 
> 
> On Tue, Jul 04, 2023 at 01:43:46PM +0200, Marek Marczykowski-Górecki wrote:
> > > Hi,
> > >
> > > FWIW, I have ran into this issue some time ago too. I run Xen on top of
> > > KVM and then passthrough some of the virtio devices (network one
> > > specifically) into a (PV) guest. So, I hit both cases, the dom0 one and
> > > domU one. As a temporary workaround I needed to disable
> > > CONFIG_XEN_VIRTIO completely (just disabling
> > > CONFIG_XEN_VIRTIO_FORCE_GRANT was not enough to fix it).
> > > With that context in place, the actual response below.
> > >
> > > On Tue, Jul 04, 2023 at 12:39:40PM +0200, Juergen Gross wrote:
> > > > On 04.07.23 09:48, Roger Pau Monné wrote:
> > > > > On Thu, Jun 29, 2023 at 03:44:04PM -0700, Stefano Stabellini wrote:
> > > > > > On Thu, 29 Jun 2023, Oleksandr Tyshchenko wrote:
> > > > > > > On 29.06.23 04:00, Stefano Stabellini wrote:
> > > > > > > > I think we need to add a second way? It could be anything that
> > can help
> > > > > > > > us distinguish between a non-grants-capable virtio backend and
> > a
> > > > > > > > grants-capable virtio backend, such as:
> > > > > > > > - a string on xenstore
> > > > > > > > - a xen param
> > > > > > > > - a special PCI configuration register value
> > > > > > > > - something in the ACPI tables
> > > > > > > > - the QEMU machine type
> > > > > > >
> > > > > > >
> > > > > > > Yes, I remember there was a discussion regarding that. The point
> > is to
> > > > > > > choose a solution to be functional for both PV and HVM *and* to
> > be able
> > > > > > > to support a hotplug. IIRC, the xenstore could be a possible
> > candidate.
> > > > > >
> > > > > > xenstore would be among the easiest to make work. The only
> > downside is
> > > > > > the dependency on xenstore which otherwise virtio+grants doesn't
> > have.
> > > > >
> > > > > I would avoid introducing a dependency on xenstore, if nothing else
> > we
> > > > > know it's a performance bottleneck.
> > > > >
> > > > > We would also need to map the virtio device topology into xenstore,
> > so
> > > > > that we can pass different options for each device.
> > > >
> > > > This aspect (different options) is important. How do you want to pass
> > virtio
> > > > device configuration parameters from dom0 to the virtio backend
> > domain? You
> > > > probably need something like Xenstore (a virtio based alternative like
> > virtiofs
> > > > would work, too) for that purpose.
> > > >
> > > > Mapping the topology should be rather easy via the PCI-Id, e.g.:
> > > >
> > > > /local/domain/42/device/virtio/0000:00:1c.0/backend
> > >
> > > While I agree this would probably be the simplest to implement, I don't
> > > like introducing xenstore dependency into virtio frontend either.
> > > Toolstack -> backend communication is probably easier to solve, as it's
> > > much more flexible (could use qemu cmdline, QMP, other similar
> > > mechanisms for non-qemu backends etc).
> >
> > I also think features should be exposed uniformly for devices, it's at
> > least weird to have certain features exposed in the PCI config space
> > while other features exposed in xenstore.
> >
> > For virtio-mmio this might get a bit confusing, are we going to add
> > xenstore entries based on the position of the device config mmio
> > region?
> >
> > I think on Arm PCI enumeration is not (usually?) done by the firmware,
> > at which point the SBDF expected by the tools/backend might be
> > different than the value assigned by the guest OS.
> >
> > I think there are two slightly different issues, one is how to pass
> > information to virtio backends, I think doing this initially based on
> > xenstore is not that bad, because it's an internal detail of the
> > backend implementation. However passing information to virtio
> > frontends using xenstore is IMO a bad idea, there's already a way to
> > negotiate features between virtio frontends and backends, and Xen
> > should just expand and use that.
> >
> >
> 
> On Arm with device-tree we have a special bindings which purpose is to
> inform us whether we need to use grants for virtio and backend domid for a
> particular device.Here on x86, we don't have a device tree, so cannot
> (easily?) reuse this logic.
> 
> I have just recollected one idea suggested by Stefano some time ago [1].
> The context of discussion was about what to do when device-tree and ACPI
> cannot be reused (or something like that).The idea won't cover virtio-mmio,
> but I have heard that virtio-mmio usage with x86 Xen is rather unusual case.
> 
> I will paste the text below for convenience.
> 
> **********
> 
> Part 1 (intro):
> 
> We could reuse a PCI config space register to expose the backend id.
> However this solution requires a backend change (QEMU) to expose the
> backend id via an emulated register for each emulated device.
> 
> To avoid having to introduce a special config space register in all
> emulated PCI devices (virtio-net, virtio-block, etc) I wonder if we
> could add a special PCI config space register at the emulated PCI Root
> Complex level.
> 
> Basically the workflow would be as follow:
> 
> - Linux recognizes the PCI Root Complex as a Xen PCI Root Complex
> - Linux writes to special PCI config space register of the Xen PCI Root
>   Complex the PCI device id (basically the BDF)
> - The Xen PCI Root Complex emulated by Xen answers by writing back to
>   the same location the backend id (domid of the backend)
> - Linux reads back the same PCI config space register of the Xen PCI
>   Root Complex and learn the relevant domid

IMO this seems awfully complex.  I'm not familiar with the VirtIO
spec, but I see there's a Vendor data capability, could we possibly
expose Xen-specific information on that capability?

> Part 2 (clarification):
> 
> I think using a special config space register in the root complex would
> not be terrible in terms of guest changes because it is easy to
> introduce a new root complex driver in Linux and other OSes. The root
> complex would still be ECAM compatible so the regular ECAM driver would
> still work. A new driver would only be necessary if you want to be able
> to access the special config space register.

I'm slightly worry of this approach, we end up modifying a root
complex emulation in order to avoid modifying a PCI device emulation
on QEMU, not sure that's a good trade off.

Note also that different architectures will likely have different root
complex, and so you might need to modify several of them, plus then
arrange the PCI layout correctly in order to have the proper hierarchy
so that devices belonging to different driver domains are assigned to
different bridges.

> 
> 
> **********
> What do you think about it? Are there any pitfalls, etc? This also requires
> system changes, but at least without virtio spec changes.

Why are we so reluctant to add spec changes?  I understand this might
take time an effort, but it's the only way IMO to build a sustainable
VirtIO Xen implementation.  Did we already attempt to negotiate with
Oasis Xen related spec changes and those where refused?

Thanks, Roger.
