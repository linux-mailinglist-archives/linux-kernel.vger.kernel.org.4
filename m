Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3A732D18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjFPKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:10:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127C189
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:10:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30fa23e106bso316272f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686910226; x=1689502226;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/6bcGnSW0ENKcwAz2UAWm6z073vhA04UcWhsyMysX8=;
        b=sBfFIPSsd2RrHfHyTjyj3vQ+9wlYdukKWhoZeMQzT/eqLMnWVy7xoBdvAiLHXkCflv
         yUMScPJqlOnsv/emA0XjGfBmp9U5HnRDL0evnKtJNoAXLoMhCDI/5dM9gJT1lYPd1nJd
         nqZ3QvrWaUvtfqzEwFLdkx9XkNPn+ZM4s0+yyr5xu1AwoV/AQiRF1BmgA1xH5D0CFP5V
         8j+l1XsiFEg6G+nteudnrMStNPBV3RPhWnvbLt9/20eB4AgqL0p2DpHE7X1zqkUV/YFL
         AEH0uCee4Rcfj5ylTQWu+92tA4wvCcTeRHPLEEsOPBmlr0IXP388Jj9bhYd2iUke/mWp
         kBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686910226; x=1689502226;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/6bcGnSW0ENKcwAz2UAWm6z073vhA04UcWhsyMysX8=;
        b=UFO/p4GP2OUOfYXI/ftBUXa2RJAIYt+dYY6CxiYi+l6GyiQ08GN9yuXFN92V4XWECO
         9EjQ4hZRs5Mj8EkVkcfoy2clslG0NeV7xcKOvlgCccNlEE0814VpFBqXQ2UDyc7QM1xt
         173a9PQ/sXzJckmtRKbP2u4xgnmgfAj27tCBceCw0cvxIyNBlwOge/dmat4mBfMBncAN
         8FUwxJ/gphrzlDMbtWsLN5XU/jf8nQMZC51yvJcROKvivusH8BOhPav6Ka8O6mvjUND1
         pJcGMpmEdPotgDHCbgrce7X0hlXgKW3RsPypFx/h6FZpWRBs14eDkBUlfQhlQ0WZfNwg
         ElIQ==
X-Gm-Message-State: AC+VfDx5CDOOzC55VVisbopKvZ1e3gGnr4v7FRyybinHqBESf/sNI3oO
        c2p73Zlk1RPu88bERuDPEdAk4A7qFJnQLUcJz0E=
X-Google-Smtp-Source: ACHHUZ5RBU9sBfWTU3V8YuWCnXsqUjnpRbVmqj9E8zY+U2C2rUiZyDoXT2jTcaku37VlvqGKKLSZzQzpcSdGGhqsII8=
X-Received: by 2002:adf:f08b:0:b0:311:1ce2:ee1b with SMTP id
 n11-20020adff08b000000b003111ce2ee1bmr935965wro.66.1686910225935; Fri, 16 Jun
 2023 03:10:25 -0700 (PDT)
MIME-Version: 1.0
Sender: gomenouneric@gmail.com
Received: by 2002:a5d:6212:0:b0:30f:ba6c:e338 with HTTP; Fri, 16 Jun 2023
 03:10:25 -0700 (PDT)
From:   "Dr. Michael J" <a45476301@gmail.com>
Date:   Fri, 16 Jun 2023 10:10:25 +0000
X-Google-Sender-Auth: uOYdlHX2DIpWw2O5g5nmQkqO8xo
Message-ID: <CAJvNRMTa27LY-VzfWnuL7=KKKUkh=KQr6MzV-eFEjRtwKpetmg@mail.gmail.com>
Subject: Greetings!!,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!!,
The International Monetary Fund (IMF) and the World Bank is
compensating all the scam victims with $550,000.00. United State
Dollar DASH and your email address were found in the scam victim's
list. Kindly respond back as soon as possible.
Regards,
Dr. Michael J.
