Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0EA6D053E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjC3Ms1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjC3MsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:48:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C33A253
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:48:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so24367148lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680180486;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8BnzNIV5QaTnXxje77gqnD2tyqzJVL2db5IGcVwrkQ=;
        b=MTeX7MdmiyulECxHRl3ebRisItQd1EqB6NSVqFp1AqzpDS8Ejkz/2RD6KwDH2i7QuC
         X0biN/wiQEMXQz+XTaDhSH/oH+jNE243sUI3awFae0cktxCe9V4kf9LkwGrrnGD1vm+C
         q0d6jeL0MhJ+LD2N8DkWKId2Y5+IqMN9YnwqK3dSoW4uyX4x5O+V0Om+jBrCI+tY4Pmh
         wa6NA/HqXUPXXQWCCaxSXJZznUk/SV/cHI/yr2ckxCnTq2EptG5vMscJ40KTsmVbWcY/
         0Yw5eK606LvEq/GYoXAsgkqXVvO6Q1sAg66ZU3ufMXP1BCF0RZ4/O9umfeu48IKZlzKa
         kQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680180486;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8BnzNIV5QaTnXxje77gqnD2tyqzJVL2db5IGcVwrkQ=;
        b=fQVhqXZMQo13b2dhSEOssElEOab1mvkkcuwf5VAUduRTp/0nfp1RFbTEJqMYz741kS
         kmQTN5sprI3EGjnZz1fXxoxNJY6bEMXVxyVKn4TyWNy+BWhUi0kDz0NWAZ6e6bu0qYob
         jzKCUa7+h0poNy3Y2hJDppLcwo5wHCcd4wRerUpRPpVVeHaCjDDiyDDLs/CfSEI8yMvi
         h3xWJ5DIEFrI8x8Qd+/i2gYKfaHihpxvo/ShHuNzXH1b7PenxPAwyWSqukZoTTGlWXi6
         50N0FLviFcOMydV4k2E2XGQeGXkXkqsSQrZrUGh9h3dv6I4qcvj1qxG9XYQkjDIugram
         1JlQ==
X-Gm-Message-State: AAQBX9crLZLu/iqMqQwu4Ck0dkeCYwnO6SAk6qN6k4g5dtZXDsl2s5bf
        qaahhuBAfYgsgxEA8XTWAZHohA==
X-Google-Smtp-Source: AKy350b1WoCfXUnD84zNy/Fw40IKjYtj9G/5moSb9CG5XfqjIlP8mQnq8R5Sxg/tR6+EY5DgMrMmQQ==
X-Received: by 2002:ac2:4358:0:b0:4ea:fafd:e679 with SMTP id o24-20020ac24358000000b004eafafde679mr7747330lfl.36.1680180486345;
        Thu, 30 Mar 2023 05:48:06 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24356000000b004d57fc74f2csm5819230lfl.266.2023.03.30.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:48:06 -0700 (PDT)
Date:   Thu, 30 Mar 2023 14:48:04 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix for v6.3
Message-ID: <20230330124804.GA1943242@rayden>
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

Please pull this small fix of a call to virt_to_page() in the TEE
subsystem.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-fix-for-v6.3

for you to fetch changes up to 8671133082176d1388e20ac33d61cf7e3b05adf5:

  tee: Pass a pointer to virt_to_page() (2023-03-30 08:34:52 +0200)

----------------------------------------------------------------
Add explicit cast to (void *) for virt_to_page() argument

----------------------------------------------------------------
Linus Walleij (1):
      tee: Pass a pointer to virt_to_page()

 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
