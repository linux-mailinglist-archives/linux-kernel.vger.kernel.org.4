Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CB5B57BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiILKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiILKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:03:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D044275FD;
        Mon, 12 Sep 2022 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977006; x=1694513006;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=knYJw82xFhls1wVNxnoMLPhssl3/Gp7C1sIfu9NLZoIaNsAzPRHZKmXp
   3DQoffUT0bF64EWgDfu97O4j1YfA3MKTbO9eBWlgRuDKnHPXzUW6wINSP
   PQNJC3cJrWxdRQuGbey35FuLVSb+7das+nD/t/tQ08XfJlP11SeV5iIJg
   kep0QWeVCwrerZ3FeTqLfZJDHTm6XuCiOlToLwcvSLxiTZE4l4CHC6ojS
   hQR5SSQuTfLiXMgOoywJjXx1CvIyMUmS50Q7e06ZH+rkRi+siaiOzvCx7
   9d4rvd1bpxpZ5z4/oWLe1ECNdj/JD24X0ITHS4XdZQGeHT8jc4pJxSl+c
   w==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="323221065"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:03:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRUDd3tcvzVxpuGv4P8F2wbl+IFxoYvq3Y/G+P4SvCq1dw2UYwJehQCflicPA4DeUkhJxGVZ7r8Ix0AGwiLR+QfyUz2AhwuJ161itmH7soStmMux5SCFzEbsGO/KvIsiry2Af+Edby2GLWwpNis+ukp9rnniMjbrX9fLZwP/661UHZ29lkB7P7DT3iNSi/pFXZK/jyfEF4JW7jm5tEQSVB8LQjrTm46qGnaSbKUxBTKlwRAmYjY9Q6GYnykAsUIkXYctdM0Fyr35HBJTX1f9+cj+yynUbntJ+3/pflVhTBwalE3nkgK+4+xOYgOcHukTYKmZTk05EmjTwBtnhNTPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gzxsHBF6l/T3/FUsY5UeZfM3nTsNmnZjsHSA5X8hU24BfywdBcYBj6ItxTno2ejLoDxam16sZir4265YhnRr7BAnqbNdzBu2Y230CTIP3/b7iXTrK1X9EGmjhZHtWytxtecXAu5PWbci+SwM1NVJWIEIOcr7/SASbPAn0jQ4ynf/Bm9gXXecq9JN+8mhiBJ5Ow/NCpsHYugwj+ivPsGYRlghl+jfeCG8MS/oQ5kFIhu9mJ/OJoWFtZ3f5XvGzim6AhQ1TDR5xgmLVqMv3FqYJ3oRT+mzfjvltAZuB1CXMj3R4qf1/31+OKrWNp4WxlF/D4b/RQavAdZG9ShlZosyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VlFkRj6+TLSBrqH3zg+tR51DVu6oNaMZfumZDT6BkkRLwqRT8I7uwLg2HESdog313FijuAS9TVMB0pS1/GbNfVK4gRSAL0iPwKE0Tdh4uf6RAxukBOdGjcVYKM1OJ98XNeJWZmSQZXOUlflSCU8RCV3hFSDBZkmQZ9V/7YUFeAI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4067.namprd04.prod.outlook.com (2603:10b6:406:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:03:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:03:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [PATCH v13 02/13] block: rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helper in blkdev.h
Thread-Topic: [PATCH v13 02/13] block: rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helper in blkdev.h
Thread-Index: AQHYxoDRPzKSIy7hXEqEXGC/7G3EjQ==
Date:   Mon, 12 Sep 2022 10:03:16 +0000
Message-ID: <PH0PR04MB74168872BECCA784BEC6227E9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082207eucas1p14b1bcefc6045a0a835e83db8ed810d5e@eucas1p1.samsung.com>
 <20220912082204.51189-3-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4067:EE_
x-ms-office365-filtering-correlation-id: 3153a815-537e-469d-1896-08da94a602f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQxgry3Rt4BkTzicM4Xg4wZTEveEtZQsQ/rb7JZOCLxUesiLLLvZ83dy2gCmUXidSRcBa1XlacEQMELenIipTvC1JgSUWG05yB4uAaVN2uUa5AcPAZKVrAYOHGlTDBq6mWNeK92jqH5qbEMpWcqy2ONkVR+qbC789NVZx0SUTutsx7ozEIh9ErPjzYxkTDiOTdvBRXU5Uzgkt+1cFYOfxGdFRFWJ3p1T4f1jm5g0uYVuDhau9XwWD+oBDZ0tlRvnOcMBDEg0w5ZIrlnQdv+KP1A/6CJ/oIXmTiUkGLhFcuZhSn3vNUpv28ysjjmUT/SdTF13yistUigkRFboFv9txbDweW8l0yND96LpblKCKlCnRjxsWGPOIpCMNP9no0lQkeVAM823Lz/hWWMr4Q8vXZnW6x1P/C2CNvrtF0xa8c9zO+rJN/Yl2dNvMn6ItiUUGwtAnXpWJAFARtLlhfIzTCFfc9WwYnCUwVNW5zvQ6rDANcsovpXnCcoI9h9aNpb0ZyteLO39bkSPm7h87wh6+VZXat1oT0r9ZsLVz3+ZvcZmAGMCOMDmFr+sS8bwGl2j1hoQSfMSceDMAS8hFvwbXAXIXan7+JRZR2KKeGCqhP/u9ynPIyYURLLtpwziW1CJRpwwNmnRCtwlm3PZEjYVKKyKFLSy88o6j7zHDSLsvfgJcfADF1CcGWeEBllM9UjMRXfHJ8ciPd6zoIuJHJkEc7WFaESjxHaIMBYvy/KQvR550Bku7aG7sY1RVeNZavUhAFJKbShSOd3lT1twC347f5mD8uAektccGn31LJsgOXc0fSeYFeSucC0GZa3zvA3x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(38100700002)(8676002)(86362001)(122000001)(82960400001)(66556008)(66446008)(66476007)(76116006)(64756008)(91956017)(66946007)(558084003)(38070700005)(33656002)(71200400001)(41300700001)(7696005)(6506007)(478600001)(9686003)(4270600006)(316002)(110136005)(8936002)(54906003)(19618925003)(2906002)(4326008)(55016003)(186003)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JCchuXVrQX864MsHsFrZfW/AhLAD3AaueLvO35swHDVFXzXWCM2utAM3up?=
 =?iso-8859-1?Q?NU2fbyCWBfNXm2QvfPBnHv/bU2p1RvverZm6Aoiu8cTHQ3F2w4k10LDnWk?=
 =?iso-8859-1?Q?HOl6j8N7txoM+1+BNK1AzOY85N+mYgzQ1DjHw2vxplIjMLKaN/G+6n5QTG?=
 =?iso-8859-1?Q?zV/lzhnhCaBatHnVrWzHWiAvqVi44FDql9m6z/z6ul0QgVE9cfzeiAWEIr?=
 =?iso-8859-1?Q?SwnxFhebu7zLUXlgdSt+jyC7gWLE9ML9rjSWrycKZZz8qs//29A9C3Od4E?=
 =?iso-8859-1?Q?uswlYH8rymoP5TzaoH1WJZsb9rCS0wOU8soy+b4wberrkZDK3pyPxYHCRy?=
 =?iso-8859-1?Q?flZEoeZRbzblsGSZMhAN6VKiFH6Yvt4bKgEt0Phagu9Nl6up05LZfG8Pl3?=
 =?iso-8859-1?Q?AjXJ/rSleuqVjXSqjR33g+1N3bCMZUZhBblEva5/uxZAsUHPUNoI7C/Pvj?=
 =?iso-8859-1?Q?1wVI6Vdh3+CRBTznCbKjnVEpN89Xwx7uks4zS+PfeA5lHe7HvvW9S9DHMR?=
 =?iso-8859-1?Q?50nTjBrjo9nHdC59q47jownnKE8WhWMFbnqY8GUldAFimcXx72srLQwVYw?=
 =?iso-8859-1?Q?k4+Rz50N68YqmPw8jLhP9Yo+kPkCuaUAQn5NiBKbfghkwZKI5GlexY/1CI?=
 =?iso-8859-1?Q?l1L6XbCW59FpT6YvT39pOOd9EdoPDhgQCalylEsiHGJlijMKeEW/8qlGdV?=
 =?iso-8859-1?Q?fx1YukGR6J8+VwJJN2ah1Xa/YRxiTuLEA/VKSFJtwCT7EDjKkKdMGP7JRA?=
 =?iso-8859-1?Q?V2HySpOhSamSpabiTjMcrfOvQ51I5GFJc0HLOsnpCiofrU875pV5m+fCr7?=
 =?iso-8859-1?Q?sa39NswLNQ1VDorbyWM7E/olsYV7wpa6nlNBI+Yafu2o+lvS9q/29mpAuv?=
 =?iso-8859-1?Q?cpeZueAjPFo9VovzvAE6ziOgJQ+RKYC9AzBiKdZqZwttcxAPyyii+Ng8XO?=
 =?iso-8859-1?Q?ba4AOapueaZ7y0NiauWwYtQ+45KrIO4CBIq6dxXx+AIb20Cqqlk0KEGenI?=
 =?iso-8859-1?Q?UnAcI0tzF2NprH4uTQ1aK2bNm/gTa1YAX8Eu2abYlBA7ji2I8C/80bUUqS?=
 =?iso-8859-1?Q?kFUU0EtenJ+t2dcZedFF4QA7Lo8Kj21OCOu14ifc344gpFw8qwpDpE33Ho?=
 =?iso-8859-1?Q?Fx6x014DeLLQFg3hb1UI0ZL817DcKyKqz/IEfukZEfxdPsSrrxube4dMsF?=
 =?iso-8859-1?Q?w0GTX6Le64vb0JHGiJM+tglTI5BRwSLFBcM5fIe0JXhsXIq0RJNd/eiS71?=
 =?iso-8859-1?Q?LzR+2gaKD0fYipK1Z11LQCJ9RdrlIkgDDjFLfGptjoGARZWAg0hAUn0lfa?=
 =?iso-8859-1?Q?IX8+EXhKXCk4/O0K5NdbgYlej73tng1HA95TvFMERuaYtQ231jKgHFHDze?=
 =?iso-8859-1?Q?1k7OxNgzVY6MsNU+aCWUswe6yyGO7AqxqLHMuejO2y0mHxCaB7WNOUEZyG?=
 =?iso-8859-1?Q?2OJz056R3QDkrInpp1OPYVTIJxgnKXzeQDLCX7VsuCAkIdpvPOXfxMd9+w?=
 =?iso-8859-1?Q?o+5KQPcM5jrOAEWss82Z24Rsi1PmBmFGYk94k/qJFbs0pRzO9NV4+8SWhl?=
 =?iso-8859-1?Q?swO2vhOC49bg1tefMIxaJUyN5lF+oqB74CTuv2lEdjv9eqCuQ9xz+TY5jH?=
 =?iso-8859-1?Q?NKWOiP0L0SIOTV0O87ywvN6f9XaZ8mDAytv3qGRuGweCI/8q/l2GvKzCPn?=
 =?iso-8859-1?Q?WzNtENI99jHEi0QNrIkswWLIxWnxUzr0wA9Ekx5u5Uj2eKYRFtWY4eqA1F?=
 =?iso-8859-1?Q?4djHW4ApzzYaXBNoGZeI0p5Xg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153a815-537e-469d-1896-08da94a602f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:03:16.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WynjysHIkb1KYgIraD5o8bUEjIid2EnlmYTTI02jbWhIVHuUYm4ksX+gczIFQVlU4prep1xBJLNEifmUU9C4QtVYb1ooeWZg6HKPj3Tqrzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4067
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
