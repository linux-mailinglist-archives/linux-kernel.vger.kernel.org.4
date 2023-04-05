Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF26D7461
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbjDEG1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDEG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:27:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80D2D50
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:27:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j11so45218901lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680676023;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbguUgawsCe7zb1mn9asSInaSJEAc8njZ7HzZ+tIgaU=;
        b=A84l4DGr8WUS7zCXfRe+7AX9NAoe7RomnQXWIBSKDtkqXOerCknSecq1aQALAVCJNU
         86Ja0pQca0GPYeuVLgI9EZ//VUmtuvhQXeuFyx/xMnQHXZ2RPBxBpm3xE9I9VAxhAc4v
         1+2HEblYRyf1ur/44DiQ+eXL2Z055J11xZ6f7ZKKkcR68AxPfGNXt35YyZb6y+qeKIP/
         7a5tptEsoXnb/0Ix27GIE4yAdh1KsiC7NRsntrtvxCsNp4Cr8WOraz4uO2JOtCaYrI+X
         Lf56NLp1ipQeOB81vMdswtko8PumyF5K+4FvHfKllIVcq370iWaUcRUJO+dHAJlU/unq
         id1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680676023;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbguUgawsCe7zb1mn9asSInaSJEAc8njZ7HzZ+tIgaU=;
        b=xHpdEauFqfs281krv/eASuljxs8xxxiWZqORVk4Q/z4HWvrd+CeuVhTBpr+1qt/eHJ
         UmFHdP9xJYDrLXWrOxAmc+cpx8MpOWD7GChBJTtggSxRv3RqZCwyIPMHtCz+D5xCwFp6
         diGgpaHGJKDeZoHOclVvH+3mRUlF9ADl1LOd8G/j/l2AmzPoS2KB9nQHDHFjv4oeqY89
         K5ZRzHVhBoCFxkVPHhlgymvE1vEBcebKdRZu4WkqDaKhWmlffmX9FRoF/zc20lutKZwO
         0P7uVH6hY0dm18gHH8tGL6twyAsqaLSBoeJTR85Z244EPUkyA8o71F+Lf1pmGWR0LfFH
         bhiw==
X-Gm-Message-State: AAQBX9dD8eEeujZyRxzOzdIItkUgGiV3J3ckGs0OuDDVf4OpEjmqfEul
        Ak3OLKjKMluXImRq57zV1TVx1RqOPjDlquVlRdA=
X-Google-Smtp-Source: AKy350YJmCPryn03SV+cEWg2nQOaJViWzu/BH0gzZ+w7PZpo7ajhkK4wUPVSrjyFPcm884/MFQmmOA==
X-Received: by 2002:ac2:5e81:0:b0:4e8:44e3:f3da with SMTP id b1-20020ac25e81000000b004e844e3f3damr1328726lfq.39.1680676023040;
        Tue, 04 Apr 2023 23:27:03 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b004d783b0d310sm2679356lff.307.2023.04.04.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:27:02 -0700 (PDT)
Date:   Wed, 5 Apr 2023 08:27:01 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] OP-TEE load for v6.4
Message-ID: <20230405062701.GA3391925@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch to enable loading of OP-TEE by the kernel.

This feature is by default disabled and should probably always be so since
it requires a quite specific security model to be secure.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-load-for-v6.4

for you to fetch changes up to f3040daab8104ac68e2b241bc93288f63b88a3c7:

  tee: optee: Add SMC for loading OP-TEE image (2023-04-03 08:57:49 +0200)

----------------------------------------------------------------
Add SMC for OP-TEE image loading

Adds an SMC call for loading OP-TEE by the kernel.

----------------------------------------------------------------
Jeffrey Kardatzke (1):
      tee: optee: Add SMC for loading OP-TEE image

 Documentation/staging/tee.rst |  53 ++++++++++++++++
 drivers/tee/optee/Kconfig     |  17 ++++++
 drivers/tee/optee/optee_msg.h |  12 ++++
 drivers/tee/optee/optee_smc.h |  24 ++++++++
 drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 243 insertions(+)
