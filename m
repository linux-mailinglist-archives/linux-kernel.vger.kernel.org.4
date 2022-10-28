Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2680610DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJ1J6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJ1J5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEAEA9E4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951010; x=1698487010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BgN+8iSWd8cYylvYK6FRliQdJ8AUyo6BZ6FMoT0gJnA=;
  b=CckacA80iX0zQ4fWR0KZ3kXYfSHUZa/14cf5xCg6vZvrSbTy6B7/In5T
   T6NhAhTqZtmFphj3FjLptrH3LnciAR7Ly1h3Cz4CU8qUKD0vBFPAoiKBi
   CoLTF+OHr0gnvkdxqLnbM+5ZK8pbM+OK1si9uQtxUdVLG/foP/h834+Up
   hRD9IS2VNUNzuO2UlLcZ2pl9mchBXnr3FyoduZ0Xs1Dly9/r59KGcZX6U
   y9b+1ToOcBk4TxOcQXz2Bgm9Y5UORVJLaa1DO/dWZh46MoAj/h5xJbTL+
   /c9OGlKshoUMONB0UU8MLCGOSmovM18Mawr5fh24PscsEH92xnpUWb95b
   g==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="215317959"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:56:49 +0800
IronPort-SDR: km46ehyA5rpGXVb4plvwtucSTeNuAZikHaA7CegVDEMP10BrPcZFgKYS9Pul/oK1jN9SWSrKMz
 XEaofztbSm2xc1lDeyspmLFwzvjlu9cRl9+ZlPXOP4K1WgbE8fAvgb7xh72EsK5eUeqmhh2iEe
 DK8egC1zz/BQPnqT7+6XH7PlOfR1bdIA0Dftt61gsuhbMZkGaSOBWh1DcteubqzAdfsYSOvolg
 faY/8q5xqWhFBKZlmFflPBRvmZENnuQu54KS5/GxXc8h+1q+CWhoYakLnCMEjFj8MQprbaoB42
 trMurRdNFgCn3y6GgBddCsMt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:10:26 -0700
IronPort-SDR: dft7ZdtbVJtUmB2OkwmXlt9gSew7gW2pjHfhW45PT6VTrDfWij8BXD4WmMOaWAbZPsd8A+i89r
 /uV4xTswnVlFK91sVoh5l0R2lZcnyUN0Dr06Ms9Ihs8hv6Is8+RQfllwiFTimjTBU2tVLn2b4J
 5R7hMB9198nIYTKduNJ2wg6o0jBAxzp7WE5JZiAJXBvepMCBc/QQL+E8NZnrYzeaaPbTrZiWWq
 KDwIhNSr/vV9rVMTEqQuTSUWtnZV3yUYvV4BS4NgBbn3Wf8ZfOMvqguj7OTTyXM2wi90IQcMle
 Zuw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:56:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHy81CSJz1RWy0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:56:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :content-type:x-mailer:message-id:date:subject:to:from; s=dkim;
         t=1666951007; x=1669543008; bh=BgN+8iSWd8cYylvYK6FRliQdJ8AUyo6B
        Z6FMoT0gJnA=; b=TZ/OXYWLpzrktMUlmpuxX7nmfXmcysrAOvOIeAA1P47SDEME
        Nsn2uJB1Y0bVuv4nsVqqMQtvDSHF+qWcMATpJCHCqUxLLpMZbZ0ZHwAe0sMab+jB
        bD22UFay3FckIrC/gdGxKnpmvxj/nqNd5Dsl+/2XKcp3cw3sW0vgQTsT2xkXxetb
        np3kwK7Ayi8YwQVP2E2USwhd9PxIKFJ0INBvbADG87h/cH//n07GMQOKNZW9aeaI
        V2JfFboZtJ2Rtt+fRP8x8qMVenHmiBo/WtAvN+z7awVWooGLZ41iGxfdnmPePVYx
        CeReqy8D+9jHC5tJ2lhcBo7DxVReO/o6qw4MzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GlbiL__ZYyDh for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:56:47 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHxz74RDz1RvLy;
        Fri, 28 Oct 2022 02:56:39 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 0/6] Fixup perf tests for 32-bit systems with 64-bit time_t
Date:   Fri, 28 Oct 2022 19:56:26 +1000
Message-Id: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This series aims to fix perf for 32-bit systems with a 64-bit time_t
(like RV32).

This series also adds a public futex waitv syscall that userspace
can use to avoid this complexity.

This series hasn't addressed the build failure pointed out in:
https://patchwork.kernel.org/project/linux-riscv/patch/20211209235857.423=
773-1-alistair.francis@opensource.wdc.com/
as I'm unable to reproduce it and unclear on how it can be fixed.

v6:
 - No change

Alistair Francis (6):
  perf bench futex: Add support for 32-bit systems with 64-bit time_t
  selftests: futex: Call the futex syscall from a function
  uapi: futex: Add a futex syscall
  selftests: futex: Add support for 32-bit systems with 64-bit time_t
  uapi: futex: Add a futex waitv syscall
  selftests: futex: Use futex_waitv helper function

 include/uapi/linux/futex_syscall.h            | 119 ++++++++++++++++++
 tools/perf/bench/futex.h                      |  52 +++++++-
 .../futex/functional/futex_requeue_pi.c       |   2 +-
 .../selftests/futex/include/futex2test.h      |   3 +-
 .../selftests/futex/include/futextest.h       |  60 +++++----
 5 files changed, 206 insertions(+), 30 deletions(-)
 create mode 100644 include/uapi/linux/futex_syscall.h

--=20
2.37.3

