Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBA6C8F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCYQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:36:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF653AA8;
        Sat, 25 Mar 2023 09:36:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r7-20020a17090b050700b002404be7920aso3782454pjz.5;
        Sat, 25 Mar 2023 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679762193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA9n8a27gA8kTUJpSEshzCNiRNDsajmOjGwfhhvIo7w=;
        b=R7vcO9N+gBpo9ysy7yqA67yGh+CR1pkyBnPo1ITdOV/rKZlrFnO8dDDdsQR2gaoRhT
         9EuqF+cRYaBY+2MnPgU3HEm6j5UWfsuI2sjgKDOL2roH0VGCbwthPAv3gpBp60Z1UiKA
         gOeJqDm7kEtXqCadHg3BBQleOZFnvu/Rj8HN5i2mfOAuPT6aR6ZK9g8JyogH5CowXbHG
         wSTnu1ywUp/7CLOG4JwQFjUWCzxbCzq+6SujK6N8CcfHNNDxQyo6IVFjhNZzUUn3Qgx+
         e6L1SgIb+6xaJ0AtDQ1vBW1Yo0KMHrB41pq29jYt9Z0QOlm/YJcGWP5q6dCY++GGpTY7
         Ttng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679762193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA9n8a27gA8kTUJpSEshzCNiRNDsajmOjGwfhhvIo7w=;
        b=WZUM6frfsk8wIlYFAN1C9kqjRz6IhWBcAqiqGUlZh247BFhB6XSM1D7DIsfx/IdWLt
         LQJRKUDl5x/TzyFNOPLYtzNThyM9HQHuggu+3YqD7SgT3EBfR4OtoVEB4n4hVzPZ+vxZ
         24H2LgOrauQuz0tSdctKG9TYFgBqrvsTq7QY7cNHUUz/YTNq9ZP6mZRArexr/54Qp5Wx
         M2vUB8YMCVGAwkp3d0AbyD0Ifv6fkPAZi+y4nbaBq+3RFnBH8rXedZxyxMWFwnjBZhSd
         9mBkOFYtoC8umyXfWu88M/N4VOndCpNXOxaeLSzEMGwtwBt26sCar4czuhgeGDZgk01N
         nFlw==
X-Gm-Message-State: AAQBX9euD7iBuW19bgqzUWZPvLmBa/qg9qEQvQBLS+++/KUaBZHb7CEd
        DY4LEan8TdyObZwIva+bkKw=
X-Google-Smtp-Source: AKy350ZHL7G2KFrTkI2HzyipXt3HsrixoT/aeQU76WAtDtWGPJbfyToTNxrcP+XsPqhU41eEzR4m9Q==
X-Received: by 2002:a17:903:41c8:b0:19a:9890:eac6 with SMTP id u8-20020a17090341c800b0019a9890eac6mr7538636ple.24.1679762193400;
        Sat, 25 Mar 2023 09:36:33 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:dbe7:6935:261d:5dd6])
        by smtp.gmail.com with ESMTPSA id ix18-20020a170902f81200b0019f1027f88bsm16178714plb.307.2023.03.25.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 09:36:33 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Sat, 25 Mar 2023 22:06:24 +0530
Message-Id: <20230325163624.6704-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <323401ed-3549-f45d-f9c7-c8f9f2d5c381@linaro.org>
References: <323401ed-3549-f45d-f9c7-c8f9f2d5c381@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. That's what I also said in the beginning, but for some reason
> Saalim cut this part... and re-added subsystem maintainers.

The file was last updated a few years back and it was by Mark, so I added him as well, while the
original binding was written by Leon only, so I added him as well.

Regards,

Saalim
