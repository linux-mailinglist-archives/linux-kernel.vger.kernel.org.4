Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5826BE2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCQIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCQIIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:08:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2293B8560;
        Fri, 17 Mar 2023 01:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A75C6B824D6;
        Fri, 17 Mar 2023 08:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5197C433EF;
        Fri, 17 Mar 2023 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679040396;
        bh=F1RVNnHTQi58MsXnXoc63veIjmnP9O89ul6v9KyMj6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR4kvm2MIfrnGvl7LkoyCp0mYK8FJJb7NVrhsClSwcA77seW4Xe5vLPvKK/XpCseS
         bRfX/vyfS5QMQ/YY7dyTOFpXHJ46Z5mM/OjOodgWTekY0HebmebUM585YdOcexb7p7
         0YWvj9Cvf7KPSQSfuPmdPgVOjiGJRpQJtkaXyVFsipy5Cr/NmDM4JhO+uJew2miMsE
         wxaa6qOSj/4mT+mY48gyMX+h038IAz6BDQeEIqd5K0FYdBivtjBfutpuqjT88+6Bvv
         FINK/LZFP3gVPJaFx9002enF1cBslhbQc3TUf/yO/VXFxH6P3YhIr5TK/f4dT55i/0
         7HcuJD9RRerCw==
Date:   Fri, 17 Mar 2023 08:06:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Immutable branch between MFD and RTC due for the v6.4 merge window
Message-ID: <20230317080631.GE9667@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131183008.4451-1-virag.david003@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-v6.4

for you to fetch changes up to bb7929626c4f57f590b6028540a4bbd2a73809cb:

  rtc: s5m: Drop S5M8763 support (2023-03-16 15:12:03 +0000)

----------------------------------------------------------------
Immutable branch between MFD and RTC due for the v6.4 merge window

----------------------------------------------------------------
David Virag (2):
      mfd: sec: Remove PMICs without compatibles
      rtc: s5m: Drop S5M8763 support

 drivers/mfd/sec-core.c              | 46 -------------------
 drivers/mfd/sec-irq.c               | 89 ------------------------------------
 drivers/rtc/rtc-s5m.c               | 82 ++-------------------------------
 include/linux/mfd/samsung/core.h    |  2 -
 include/linux/mfd/samsung/irq.h     | 50 ---------------------
 include/linux/mfd/samsung/s5m8763.h | 90 -------------------------------------
 6 files changed, 3 insertions(+), 356 deletions(-)
 delete mode 100644 include/linux/mfd/samsung/s5m8763.h

--
Lee Jones [李琼斯]
