Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426D874396F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjF3KeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF3Kdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:33:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7530C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121235; x=1719657235;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=bh+mzwZsv0sqyvr7ZUOmbGwgq8sCUfE12/5m1clQC8A=;
  b=Wrnu99Nyyf4Djnk9un3Q3likYp/ECVADByziehWC6Q4oxOravS6Qp0gi
   skYhPFhd85KNt/k6NR+fKDETk+nUTCUvqTo5vAdoUijI+GVHmXm9KgYoE
   7ewG6IUalKDagptg4lLCmDr/WHEQUN3+GQizEoaiE/JwT/WH5YXW17R+6
   7wprjXoDX8tCD/bDUfSa48PoLDGy3uWNZjmqnVaANcbzYXsCo19n3TJSO
   r1rjVTLAQ74GN02we7T97czB2FY8inm456F7f0rb9TWdLGKreDzKfe7nq
   wGX4BtPd31ekPJ1I4tuOl/ywbRo6/O79aUUu7Kd/TROkzHnK0WKzDPWDT
   A==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="236618453"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:33:54 +0800
IronPort-SDR: cP25xD1Ch0xn26LBwx2t7BopIAuXy+/uvB6HjHkxmTREr799/3c9LRK837HS0BRrn+P8yPyVwa
 T/nnY1Q/V5Q4HenIfuv7eBZizYwWDn9gL+l/Uvw7qz+leMRBQm+ey/YK5BCM2+5t+Vk3IIO673
 jWbfM35SHf3+RJgoCwLetODRlEpfhT0jPj6qk8seAh3wWoxuIUqSQmkJZIHorTrZkj4zdS9Prt
 qMtpfhTJM4Rv1rQTJDkV8mBHCBLVV8xXaRRV+3JuCvvAuATXsuwLzEpD5dgz2Pttyz+BzEd4Qv
 tqY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:48:09 -0700
IronPort-SDR: FqEHsljVVnwqBxlGasowtuzlCwI9sgS4bP5KTDXKeSQOS9zZF7IyWBoOv8FXrM3zahbOCXfMYW
 ZQWOuKX9Wc/tgIzWzvPm3LkWXWcfpA7mWYJO0T9KtvbAnvHX/44wIrJ08M77/1sJdsCCv8HXQU
 X76LtOpnEBR7MnNRgcdVGaQ5JP8b8TegngT+Dgw4J4xMQ1Gcx9WpPr6tYsUMM8wyxs9wFs0k/h
 G38gPef507kZOW5hh7rVr+WWoLVIbXJ+7hLHTu9tzDyTJume32sDcnMAQgZmCfh7uVEgsM9pWv
 Tyo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:33:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Qss9s3HwKz1RtVp
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121218; x=1690713219; bh=bh+mz
        wZsv0sqyvr7ZUOmbGwgq8sCUfE12/5m1clQC8A=; b=mg/2dVzZ9mHH66e8lYah0
        kAQ/xE5I9J0LfBZZFEtHDYp7B1ujTVs1yDkT4RxqBY/bou5E9GxVHTx3RvHmGrSb
        4PMBj5sJn6o5anpuDmfXeWluUuYPF8cYfFFIDFb/ZaxJ5lpCw4dWDiGYc/lvcf0U
        gSaDLZ8oD3rwVPmxHVu3f6lYKgivQ6UKiMSHdkcBTh/Y/K/XBhYK8NZAu7toB+4N
        er28XVhB82OIENJKzIxKL37PJmdY1/xOaAKkh0Toqlh5AqIQ/I0J5jFjJt6UneS7
        ZSmJCUVUBJ7GB/31B3xGGGOxdovmnHedOdf1hBpSwge9pzEGVGUOySn+xRo6Cc/r
        Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x1qqHVgZNf56 for <linux-kernel@vger.kernel.org>;
        Fri, 30 Jun 2023 03:33:38 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Qss9Y6Dxwz1RtVn;
        Fri, 30 Jun 2023 03:33:37 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:03:37 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 0/4] ublk: add zoned storage support
In-Reply-To: <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =EF=BB=BFOn 29/06/23, 12:37 AM, "Andreas Hindborg" <nmi@metaspace.dk
> <mailto:nmi@metaspace.dk>> wrote:
>=20
>=20
> From: Andreas Hindborg <a.hindborg@samsung.com=20
> <mailto:a.hindborg@samsung.com>>
>=20
>=20
> Hi All,
>=20
>=20
> This patch set adds zoned storage support to `ublk`. The first two=20
> patches does
> some house cleaning in preparation for the last two patches. The third=20
> patch
> adds support for report_zones and the following operations:
>=20

Just to clarify, we do need you ublk user space patches
to create a ublk device node (with these patches in kernel), right ?

>=20
> - REQ_OP_ZONE_OPEN
> - REQ_OP_ZONE_CLOSE
> - REQ_OP_ZONE_FINISH
> - REQ_OP_ZONE_RES

REQ_OP_ZONE_RESET

>=20
>=20
> The last patch adds support for REQ_OP_ZONE_APPEND.
>=20
>=20
> v3 [2] -> v4 changes:
> - Split up v3 patches
> - Add zone append support
> - Change order of variables in `ublk_report_zones`
>=20
>=20
> Read/write and zone operations are tested with zenfs [3].
>=20
>=20
> The zone append path is tested with fio -> zonefs -> ublk -> null_blk.
>=20
>=20
> The implementation of zone append requires ublk user copy feature, and=20
> therefore
> the series is based on branch for-next (6afa337a3789) of [4].
>=20
>=20
> [1]
> https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952=
dd88bf5e668b
> <https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e99895=
2dd88bf5e668b>
> [2]
> https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspa=
ce.dk
> <mailto:20230316145539.300523-1-nmi@metaspace.dk>/
> [3] https://github.com/westerndigitalcorporation/zenfs
> <https://github.com/westerndigitalcorporation/zenfs>
> [4] https://git.kernel.dk/linux.git <https://git.kernel.dk/linux.git>
>=20
>=20
> Andreas Hindborg (4):
> ublk: change ublk IO command defines to enum
> ublk: move types to shared header file
> ublk: enable zoned storage support
> ublk: add zone append
>=20
>=20
> MAINTAINERS | 2 +
> drivers/block/Kconfig | 4 +
> drivers/block/Makefile | 4 +-
> drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
> drivers/block/ublk_drv.c | 150 +++++++++++++++++++------------
> drivers/block/ublk_drv.h | 71 +++++++++++++++
> include/uapi/linux/ublk_cmd.h | 38 ++++++--
> 7 files changed, 363 insertions(+), 61 deletions(-)
> create mode 100644 drivers/block/ublk_drv-zoned.c
> create mode 100644 drivers/block/ublk_drv.h
>=20
>=20
>=20
>=20
> base-commit: 3261ea42710e9665c9151006049411bd23b5411f

Regards,
Aravind
