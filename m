Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4C731A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbjFON6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344256AbjFON5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:57:55 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8F1FD4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:57:46 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78701841ccbso1401475241.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686837466; x=1689429466;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJ7qB9Ep7tkRFvnY4tP6xBdv/LSo3U9AM6agsmPVBBc=;
        b=X1jLzDcwobiSNQVfkgy0tKX2PShVc1mY+QfrQwOUHE3B5ytCla39+sgCglp8OyBtat
         x94JdoGc6u5FqAc8uAJLlBCfJhz7xFlo3Qmm6oA6fyME+Jx0MKAIO0wmPE+RXgU83a33
         DTslpSkjGVhRvBaiTHoujhsfZJmwAqUEPqIiJinO/wAXHSLOLSyxe8pX9A8bhdcO78Dj
         FEDOwz+GBvCsgyGIMSnKodh96o1ILw/+d+YpqCCcu7GtOOqp4q8WfCHMJ9MC2/dfA6dA
         EOCHuOrh+e4pMckEtA9uzHrBB2qI1/LInpGnwgTXFOH8cH3xE6GmRxQrLcB2RKD0PReB
         mVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837466; x=1689429466;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ7qB9Ep7tkRFvnY4tP6xBdv/LSo3U9AM6agsmPVBBc=;
        b=TfWxGiODaqpB2qb8gpAYQodXUiACcUYX+1VN4vJjJbbwKgnT9fcWg9ojn6OsRA/yp6
         I3Qoj1CjuHOW6x+2mfcXz8ehPrHGrHTvZOMqsTW0lfQO10CUTJKVpqArg4OD4nv1O1De
         zWc90GAx3FlHFCpv47Yj0st97OP1icXPMSfos28s+3hBkhFngTsQgO6eVM1Vpv46Wled
         Kw06TtYLJ+wdAO1JXoq4Bay6WmBMyh88B2Cm8UUR9vhABlNxGfRaG0pxOnfMq+gFsMPl
         tc76+pKRRj9WiYTGXp/13yBhNXgZoEO9/cltWkq9FvvULD8108BEA57NZTmTZdisofY9
         qfaw==
X-Gm-Message-State: AC+VfDzDgLIZKUeF4dTnoxl2nui+XkAMzn/bbSbkB//Kv7h0LDeF5aJa
        92V4mt+oAuosVTSh8BWDtxdVCWpThZBKR3MShjy4qw==
X-Google-Smtp-Source: ACHHUZ6V6XJA88EStQsUft9YesOuyH69+RyFcPgZWb8Fev65Xgxl95jyWAcJNgJ6pLsIXD14Ui8afmCKgpEET/u6DMw=
X-Received: by 2002:a67:de0b:0:b0:439:5a25:2e39 with SMTP id
 q11-20020a67de0b000000b004395a252e39mr9005440vsk.34.1686837465649; Thu, 15
 Jun 2023 06:57:45 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Jun 2023 19:27:34 +0530
Message-ID: <CA+G9fYsAvbqVr+W4=17sxwguGSQi6cU+9WZ_YQzg3Wj96e70uQ@mail.gmail.com>
Subject: powerpc: ERROR: modpost: "efx_tc_netevent_event" [drivers/net/ethernet/sfc/sfc.ko]
 undefined!
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        habetsm.xilinx@gmail.com, Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regressions noticed on Linux next-20230615.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on powerpc:

 - build/gcc-8-ppc6xx_defconfig
 - build/gcc-12-ppc6xx_defconfig


buid log:
====
   ERROR: modpost: "efx_tc_netevent_event"
[drivers/net/ethernet/sfc/sfc.ko] undefined!
   ERROR: modpost: "efx_tc_netdev_event"
[drivers/net/ethernet/sfc/sfc.ko] undefined!
   make[2]: *** [/builds/linux/scripts/Makefile.modpost:137:
Module.symvers] Error 1


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230615/testrun/17530875/suite/build/test/gcc-12-ppc6xx_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230615/testrun/17530875/suite/build/tests/

--
Linaro LKFT
https://lkft.linaro.org
