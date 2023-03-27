Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A726CA98B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjC0PtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC0PtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:49:17 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3F198A;
        Mon, 27 Mar 2023 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1679932156;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QzJw79AnlrNANyl0hEbRbBBO1H1MYOhuiCxDTV/3mJA=;
  b=O2Tydr5aqv2p5B1LS8k+TAaoPF9eZDLubr0A3e2MMr6xEmndAkHwZCs1
   OHUGxx5Y2oI3g2+piLO7Unevd0LR2JMRTaKgh0ueOu3+996JBVmj+G0R8
   KG0QHeh5zKIRetB/ms3hwwrNjUjbum46422SlJdYd5yZhVrrGbJbGn1kv
   Q=;
X-IronPort-RemoteIP: 104.47.56.176
X-IronPort-MID: 103442823
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:3ZEera6nb6UmbSuyxR1/2gxRtGTHchMFZxGqfqrLsTDasY5as4F+v
 jZNUDyFOKuJZWbzLo1yYIu+oU9Xv8LQyd41TAprpXs0Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7JwehBtC5gZlPasR4weE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5my
 qMldhcKYy+63sGL/aOhZ8V+o5QaFZy+VG8fkikIITDxK98DGMmGaIKToNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6Okkooj+aF3Nn9I7RmQe1PmUmVv
 CTe9nnRCRAGLt2PjzGC9xpAg8eWxXinBNhCTubQGvhCg1iYmjw+Mi0qVlanr6CBqH65fIxiN
 BlBksYphe1onKCxdfH/UAe/u2WspQMHVpxbFOhSwAWMzLfEpgWUHG4JShZfZ9E88sw7Xzon0
 hmOhdyBLSd0rLSfRHaZ97GVhTC/Iy4YKSkFfyBsZRsI5ZzvrZ8+ijrLT81/C+ilg9vtAzbyz
 juW6i8kiN07l8cF3qi/1VPKmTShot7OVAFdzgHaWGiN7Q5jYoOhIYuy5jDz6vJNL52QSFWbi
 2QVgMiV7O0IDpalmTSERaMGG7TBz+iINj7VnVN0H985/jCp+maqcYF44TdiKUMvOcEBERfga
 0/SsAVezJ9LenCtaMdfZ4O3FtRvxKP4FPz7Wf3OKNlDeJ58cEmA5i4GWKKL92XkkUxpmqZmP
 56eKJ+oFSxDVvohyyeqTeAA17Nt3jo52W7YWZH8yVKgzKaaY3mWD7wCNTNic9wE0U9Nmy2Nm
 /43CidA4043vDHWCsUPzbMuEA==
IronPort-HdrOrdr: A9a23:+WkoOKGkL2hV385+pLqEL8eALOsnbusQ8zAXP0AYc20yTiX4ra
 CTdZEgviMc5wxxZJhNo6HkBEDiewKkyXcW2/hoAV7KZmCP1wWVxelZnPDfKlbbaknDH4BmpM
 BdWpk7JefcSX5dpq/BjDVQFexL/PC3tJqFv6P16VBDbS9XUIlczyFfTjy2LyRNNWp7LKt8G5
 qY6tBGtDa7EE57Uu2wGmMZWezOvP3n/aiWAyI7Ow==
X-IronPort-AV: E=Sophos;i="5.98,295,1673931600"; 
   d="scan'208";a="103442823"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2023 11:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4fTL2Crh+gGyHa9CfGe8gOvdGeYICouSJV9AUBYAtF7sDACjIl1SwfAuPrVGRC1I/0uHmQi6UGyP1UIPVkvPK9Wiy2mX65mBg0QNg76Pee4UvWxU11+EnXVelp9O2IORE4IQagStHmO68MkWzYMoP9FUjhcMGI2jLw4K+4eqvVnQVzO+pz91h6hIydJXGB/kEWtAMcI9K1yJYsjp+4R58KTu41FGd0PSxWUy06V2cqYPIJefgIg4cIA8MbLEaDcBbJq2COfFojJb7DIzjf9yLMJgoI5WtSpDVxwf3yB+yKuRN3LWiFiYVJHq3K3ISLJOJH7n2fJ7KwnHPA2+RXAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFnXZhChO5CCthg+ZeSR3Ak6o6goOFLBpgEYERvumh0=;
 b=N1NlSgoV3Hop6TH5ALVvu2iZuS8BJF7SgLSNHj1YnvwC8wF73X4IB7rnQN/nVGgiK/0rnown3rw+fxboRM0MsxdhJ0LC/ExBFcIIROvqRCJmryfCTE9955hTP+Vyku4sBvogicrQvnTd/SkAjjB/BqcjW2EKFL8hwB/d0sD24Ua9jyop7keABzz7z07B9vj1bMDgLTEaP/BZc018eYxyY/CRfBdJ0LNgG8z51R7SCybie2skGzjHRH3ozBn/FmBLQ/9cpzz/rgFg0HTCrrIuQP9djaOrtkfH2Ll8tRL0IXjcIO9u71BcT9fbMAwhfOZHFZs4qjZlydmFWzHjOJi6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFnXZhChO5CCthg+ZeSR3Ak6o6goOFLBpgEYERvumh0=;
 b=hS2TQSNmyBUivavUC2fgouKpAs8FvL6+a2Wz33hJ8n0poEfhbBTFUVIQHtvmm012GN5lYeRFzKPV8wSKYpdVEI/D9o9ovXhAeU1/b794LfKdsDc2PjjavaaD5i/3Yd1hEGxcbpSG/egFnKS5QdErYCFGzgbD5ohy+Q6kz0ndEUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by CH0PR03MB6018.namprd03.prod.outlook.com (2603:10b6:610:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 15:49:12 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 15:49:12 +0000
Date:   Mon, 27 Mar 2023 17:49:07 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <ZCG686t8tPDNPFbX@Air-de-Roger>
References: <20230321141904.49177-1-roger.pau@citrix.com>
 <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa1f1ff-ce1d-447d-18ee-9b787e03f86a@suse.com>
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|CH0PR03MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 38686669-9a08-4389-e0bf-08db2edacf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuA2cO7qd8+f5ZGvKmrzwXVBNedjWZ2gqyCG5GeFGA/N/HftJyWV89GQtFoC/n1zAtGX05rLA7maVgz2odaHCsaenNYtsuoack8LSK/u0p9E30KNwFKMNUsp6fjZ11SGcFfrpI7CRziD5kMjM67lcHQA2XTLLw6iZwsSs3hFJQw7ZfWMD/9TWuYZMHFONHWNryiZPxFmghymHeP1Xu48e01H4Z6GhCwbeeQAOFxrg8ywitL4yGr8ieWGTjS8IOA0e6TbF7dljJyrHzhMBEDXKR/Ibv7nBHuUxOCEuMn4BzTh/NdpyYIRsVKaCzBY85bj7ITTb98rULNsgQ/MSQ9E8BLeula0s+eG6CaqOp7VhEsacR1YQmD7JBrn6cmNWJUH9BWDT1gCPhNUaungt1cBDUMZ8tYBs0kO3m5BspEachJ19kzpQzlFgooM2ghHDn5gRokq66GMvKDvGSHOa8tl3GPGlcmchyS3GyWivpEHHAU0pL54ssxPbhYosNbY2PT7kmWMACwODChglM6vhQb7p4w7fz3cprgcCdPiqDfJM0miHrc74USqWNKVLC7bSpAk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(83380400001)(41300700001)(33716001)(85182001)(86362001)(5660300002)(38100700002)(8936002)(82960400001)(54906003)(6486002)(478600001)(8676002)(66946007)(66556008)(4326008)(6916009)(2906002)(66476007)(53546011)(7416002)(6666004)(6506007)(26005)(186003)(9686003)(6512007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklkVklTbG1pT25aWkIyTlBCZU5zMGhteEZmeXNGT1R0UUNZMWN0US8vRmRF?=
 =?utf-8?B?VDFTTzFTNUhiMkV4NVIvYjBjQVBvUCtmRkZUT0xzSzJ1bVpvY2krekxMK0FJ?=
 =?utf-8?B?N0t2YnlFUURmdlNOeHoxVmdmMHREVEE5YlQ3NVVZdUI0czRITjJzZ25scUVZ?=
 =?utf-8?B?T1gvZHEvN2tuT2xDVHp6cG1RRFdQa0tyQ0hqb1FsNWc3NjErZmwyRmQ4SEVN?=
 =?utf-8?B?VFQvVUpMWDRxMGNhSGRSYjFDbXJzOTlPdXFuSUZZQkpmdWVieWNyb0R0QXdY?=
 =?utf-8?B?TVltYUVBZWk3eWdzdUwvSXBWa2tqVmI1bEcxcENJclpRR2s3ZG9hUytXcGd3?=
 =?utf-8?B?UkpjaDRndEhmQk0ra1VkOGVHWk93R0FkVkRyMjl4bXF0VG8xS2w5cGtkZUNO?=
 =?utf-8?B?YkErZFIxTlZxNHBTYXBnNkRGQWp4ZTJZd3BrM1lyY1YyL0tuVzVzSTJiSk44?=
 =?utf-8?B?czd2Sm1aL1FvSFM4U2dnNWRkQkhERG11dFJzY21DckxuMTVMMWNOYVBob1da?=
 =?utf-8?B?Y0VyM0V3NTNxMnBVMlpNVStYbFJIZTYvb1puTmhKei9ESmpWZFBkT3VvK1Z5?=
 =?utf-8?B?ei95YTZ3bElxZUJ0SzV2enZWRUNVYmxNVnl4WEkrM2J2WGQ1aHVHcDVYamVX?=
 =?utf-8?B?VFFzdXFOb1UrVld2d3pKTWRZYU1nTjlTZkEyQUNRS2tUYzZOeW8ybjR6a2xJ?=
 =?utf-8?B?WGtjSUhZOTZEaFpNTkRLdHNmUVRVeUdZcEpuV3A5RnNEOEtUVllOUzZEZ0Jx?=
 =?utf-8?B?SzVuSmZJNFVGL2RUWmhJLyt6dnVud001WjRScHhpOFBmUy9reW5YWFgxdVo0?=
 =?utf-8?B?U3NsRE9CUTdlRk5KUUlvUGNpQXVIL3JUSzBHdllnRStUdWJoNnFmWDdMRHFp?=
 =?utf-8?B?bUh3QkU3OGtkbW5qd2pmN2FGaW44UGg3c0FaM1dpRjdoNTc5VjkxcVdhd0Jh?=
 =?utf-8?B?NCtoV0xuK1pyRjJweWkzMm4vNW9EeVNZeE15S2NpdDl6elBCRXNzczgyTWpQ?=
 =?utf-8?B?Qjg2c00vL3lHTURDOEpPK3Z4ZDh4bldjNkNaMEJsaHc5NmVQVlJWcUN1ekZ5?=
 =?utf-8?B?Z2FFN1BXcmFoTUc2VEp2N25Td3ZubkFrczIrMVlFTy9uODZVMHNvMW9nbm9D?=
 =?utf-8?B?Z0dGOEQ2NkRPcWRRbm1Ib3NuYktnamVDTVdxcDdMaGF6aTNML21qbXpsb3g2?=
 =?utf-8?B?dlFMY0VsNmN6Y25vZVZWMDIrT1E4TGovY01VWGJ4U0JkNUN6NUlDRjdia0lw?=
 =?utf-8?B?MkxMTGxRK09zM0orUDZieGF2VWVVTWZFd3ZZL21XVzg2WnRyOGY2S21HL2ZM?=
 =?utf-8?B?YVVlaDNuZTQvSkIrV1BROE10N1lNMDEvWk5EUGdyOThZM0xJUDdTUVRpdTNw?=
 =?utf-8?B?MkxEZ09lUFNnTHZHOUdxZmpXcmJCRlVlOVRZMlNPd1J2N3BCNzd6QXpleEJL?=
 =?utf-8?B?aWFZWEV2WU11VkVqS2xuYkp0OG9ZdVVJSW02SEZpYzVQQ20zd1FDOGNNWml0?=
 =?utf-8?B?WWZqUEFmV2Q1bGZLYUhJMk0xUHZ3d0VURFdZY09yMjl3TG9ZMzRtazJHSFdP?=
 =?utf-8?B?T2Vya01XclI4WWdmYTFVanJmL0tJWFFRaDNMWjlZU2VsZC91anlKWWdJUDRm?=
 =?utf-8?B?WC9BUVBLa0lyMTZuTHR6aFkrMCtBdlRnTjZQUHZndzlQU3RKdDVIYWMveGUx?=
 =?utf-8?B?ZWJ1K2NkalI3ZEJQVmtzQmRWNWUrdXV5TjhNQ2c2eU5WOTZHaXdnVldZeUFy?=
 =?utf-8?B?VkhOeTZiYVIveHhydVZxYjcvN3pTZmVjclJDNm9lMUwrb2g1SlBEUnJ3YXQr?=
 =?utf-8?B?TGZmQ2VHUnhzZ0xtOHpNTnVOZUlZalZYYnYxdXZkODJQUkdPMmNHbys1bUtu?=
 =?utf-8?B?YVpwNnBqZFVIQWp0QW5zRXp6VWNXZitOMDBtblE0S0JZOXRDdm84dlk0TFhq?=
 =?utf-8?B?aHR3bEZWWWtCbXpDSXg2NmdWcWVnV1ppY2ttZHVRYVlhS2pzZXFCNUgzeUlq?=
 =?utf-8?B?OUhmak5kd00zSzdEM2RXYjFVUzBMRGZhR0liWGo5bFZMaUUzanBneE9qbm1V?=
 =?utf-8?B?aWdYSHdwSEhGN1lKK3BneVRZdkV4RFE4ZmtuVGhaUk5oeFFTelh2MXkrdjBL?=
 =?utf-8?Q?EqZqCXLdJlzEKEhkNzGQsC+8G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXJaUGFpTkEvWWlCREY3M085OHEyMDROTTJ4TXVRS211bUQ0OHhaUXpsUm5D?=
 =?utf-8?B?c2MxM0NPTTFlc3NtaXlvMlhDOFZmeUNpeDZTZCt2cFpOaXFJck5tVHNkaFVm?=
 =?utf-8?B?MjZnTC90bWxicGdWbTdtU1BpSUs1V1JpUkZkeDh1OFRqTUQ4dWZuY2w2alox?=
 =?utf-8?B?eWlSb042RnBwaUQ1RHdZS3YwZFppdWlLWm1idnEyLzU0bzBUUy9ZYzRPaEpY?=
 =?utf-8?B?QUhTMlI3TG9SQ1I0cUtyNFIwcU9RQ2dwYzhFMExMNXg2SHhQVHllcjhYcnV1?=
 =?utf-8?B?ZW1ndkFGYlB1YUcrQUY2d3krQkRYL3dVT3d3ejVGUHlUSlBQSThGclhUYm9Q?=
 =?utf-8?B?L1BmZ2RFdTh5ZTd4WW5JK2xnd1IrVzZwekREbTVsbys4ODJJam9LdGpGOU1y?=
 =?utf-8?B?TGpRNC82ZktyMHdiVFYrTXVFUjFHNmZNc0hkYU1oejRqR3BIY2thNTNrOU01?=
 =?utf-8?B?K1NDcGRNaTlIdkpnVHR3c1pJazRueU82R2dMNTNONk5WeWFVYjVPQmFzVGl1?=
 =?utf-8?B?dXFrRHB0eXZJd2prSEk1bVo3K3BPeXVmU09LTytwbkpXRW5wcnFPYXkyNVJG?=
 =?utf-8?B?MTM4dHgwTEZsRnF2SHFXSWg5RkFoNitWODJIcHJhWExDeU9GZlpWVk50V1gw?=
 =?utf-8?B?dUloV0MzMWszM2F0UTNURklzMk94TDZJanh2VDN5R2NMTWplelVhRDduQ2Jl?=
 =?utf-8?B?RXBYQndvb1BxM3EvV2ViOUU1SkF3QWxhdm1aZnZDbVdra0xDaElFUjFOZzJj?=
 =?utf-8?B?RWpsUzd5bEltKzNCamNKUkcxRE5TR1QvTHUwNFl4MHgvdllMQUFyb1gvVEJI?=
 =?utf-8?B?QkF5UU5leWV3bHVmNU5QeWY0R3JsL3gxdkVuNEN2TEszT29Qa2p6eWwvRGk0?=
 =?utf-8?B?REVISHJQT0YveHpSVy9CVkxNb0F0L3pqTStmNENHOElvUTRienQ2UENEZTlj?=
 =?utf-8?B?ZXNid3Y2WDhnRU1od3ZYUXFLMnYzbmQwRUh0czBEeXE3TUNybzBrK2xQVHhu?=
 =?utf-8?B?WUs5NktWakhveExQdVoybE5sa09YMmtPQUZuNDdCU2JzWVI5QnRYbHU2UkM3?=
 =?utf-8?B?S0haaG5kSkF5akcyQkloNkhBeEpRWDNvQlVRY0hXNmtPcGlOZk5JTHRwL3g4?=
 =?utf-8?B?MWxHUmZnSVJKTVFieW5LUE9XZ2ZWL1ZLeUlqZitPZ3BDaXhjSHBzVFF3ejMz?=
 =?utf-8?B?citYNDZVT3BUVHluMWtPZExyOEVQaStsZ2NldWZDS010U0o2aUJ4ZUxaWmxM?=
 =?utf-8?Q?wX5ABQRxOwGr9pO?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38686669-9a08-4389-e0bf-08db2edacf92
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 15:49:12.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llRPsWUl7+3KiOOeIV6qVW1naf0HoTU1I04BNwx10l2wA7iI1Q13RLCxpiXFfK47//m0+IArOr8OkfZa4zqssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6018
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:58:26PM +0200, Juergen Gross wrote:
> On 21.03.23 15:19, Roger Pau Monne wrote:
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
> > Changes since v4:
> >   - Move definition/declaration of xen_processor_present() to different
> >     header.
> >   - Fold subject edit.
> > 
> > Changes since v3:
> >   - Protect xen_processor_present() definition with CONFIG_ACPI.
> > 
> > Changes since v2:
> >   - Extend and use the existing pcpu functionality.
> > 
> > Changes since v1:
> >   - Reword commit message.
> > ---
> >   drivers/acpi/processor_pdc.c | 11 +++++++++++
> >   drivers/xen/pcpu.c           | 20 ++++++++++++++++++++
> >   include/xen/xen.h            | 10 ++++++++++
> >   3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> > index 8c3f82c9fff3..18fb04523f93 100644
> > --- a/drivers/acpi/processor_pdc.c
> > +++ b/drivers/acpi/processor_pdc.c
> > @@ -14,6 +14,8 @@
> >   #include <linux/acpi.h>
> >   #include <acpi/processor.h>
> > +#include <xen/xen.h>
> > +
> >   #include "internal.h"
> >   static bool __init processor_physically_present(acpi_handle handle)
> > @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
> >   		return false;
> >   	}
> > +	if (xen_initial_domain())
> > +		/*
> > +		 * When running as a Xen dom0 the number of processors Linux
> > +		 * sees can be different from the real number of processors on
> > +		 * the system, and we still need to execute _PDC for all of
> > +		 * them.
> > +		 */
> > +		return xen_processor_present(acpi_id);
> > +
> >   	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
> >   	cpuid = acpi_get_cpuid(handle, type, acpi_id);
> > diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
> > index fd3a644b0855..1814f8762f54 100644
> > --- a/drivers/xen/pcpu.c
> > +++ b/drivers/xen/pcpu.c
> > @@ -58,6 +58,7 @@ struct pcpu {
> >   	struct list_head list;
> >   	struct device dev;
> >   	uint32_t cpu_id;
> > +	uint32_t acpi_id;
> >   	uint32_t flags;
> >   };
> > @@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
> >   	INIT_LIST_HEAD(&pcpu->list);
> >   	pcpu->cpu_id = info->xen_cpuid;
> > +	pcpu->acpi_id = info->acpi_id;
> >   	pcpu->flags = info->flags;
> >   	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
> > @@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
> >   	return ret;
> >   }
> >   arch_initcall(xen_pcpu_init);
> > +
> > +#ifdef CONFIG_ACPI
> > +bool __init xen_processor_present(uint32_t acpi_id)
> > +{
> > +	struct pcpu *pcpu;
> > +	bool online = false;
> > +
> > +	mutex_lock(&xen_pcpu_lock);
> > +	list_for_each_entry(pcpu, &xen_pcpus, list)
> > +		if (pcpu->acpi_id == acpi_id) {
> > +			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
> > +			break;
> > +		}
> > +	mutex_unlock(&xen_pcpu_lock);
> > +
> > +	return online;
> > +}
> > +#endif
> > diff --git a/include/xen/xen.h b/include/xen/xen.h
> > index 7adf59837c25..4410e74f3eb5 100644
> > --- a/include/xen/xen.h
> > +++ b/include/xen/xen.h
> > @@ -71,4 +71,14 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
> >   }
> >   #endif
> > +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
> > +bool __init xen_processor_present(uint32_t acpi_id);
> > +#else
> > +static inline bool xen_processor_present(uint32_t acpi_id)
> > +{
> > +	BUG();
> 
> Is this really a good idea?
> 
> Arm64 supports ACPI, too, as well as XEN_DOM0. I think you either need to
> provide a stub for that case, too, or you need make this stub non-fatal
> for callers (I guess returning false is fine, as currently there are no
> hypercalls on Arm which would allow to control physical CPUs based on
> ACPI-Id).

Currently CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC is only selected for x86 and
ia64, so I assumed if we ever needed this for Arm someone would have
to write a proper handler for it for Xen.

Thanks, Roger.
