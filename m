Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C796DA595
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjDFWKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:10:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B42AF03;
        Thu,  6 Apr 2023 15:10:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v9so2433475pjk.0;
        Thu, 06 Apr 2023 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t7Io9b0xapKrg+J597+vOEMw4l4d8kxiptOV6vFOD8=;
        b=iimJxSsTN4DPUvczAgFy0U4h9XYwp3BTGx//p8IKWZvW/FUk8uYyw/7g25QSy4j8x7
         LRQ/xz3YPp43k8DEAs5llOLKBGNMkI441AtF5IOVairVzXSJ0GW4BD25faQGisGN/54Q
         CAWZaN7dbLW8URWjBaLRLgu2Cc0Z3LzlCMZgUfWwpNpvujjPlSsiUo1274EsP37VwPYE
         BFjacjhHEGurmkYXU2TacowWJ5u3iZfy0kc/gnBCsL/Xd3Xf2q7N2RC5b0pE2Ce/+c93
         JIQU7HQPloMwf7n6egsC0PiHjU3z7hHzpqtBaiyKSuh9uKGpfs5C5GRKSU7Kw9uKbiZG
         0qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t7Io9b0xapKrg+J597+vOEMw4l4d8kxiptOV6vFOD8=;
        b=krqjc9NEmPzBYARYX8u7e5LPnfXISZHkzPvW3rJEoNqeD0Wncle3o/PHtmvPhUHrFH
         hQQtSkCR8jjPBNUnXXnJiQOn3+HVIj69XwMsZ4jdjG3toEI+Rg7yu2HyLJgf91+P8M3E
         yGpwmuT7tKj4QvuA3RrA+HnhKqZlJqoZNsV/2OHJ7BTpXrZZq/lIgaXwD2s7i+Ar4GDC
         KVgXZ/E1D2dyQ0i956Ntc7w0loNcULIb2fpNXwCSq/InU15YMLr287OPJRhbH9hQBxgk
         4CEiJMD1vT+cEVBS8mGCQQcvomu4SwTFp0iI2q9AN+IQWAepy/lZoJU5nfEBnACU1VtS
         vXgQ==
X-Gm-Message-State: AAQBX9dINMD85vAmPyX8z4BupCDyqcG0HJbjiscpyN+lIUTEEMexkxft
        L/sZVqog1+yMfpCs9/XRwZ8bqr0pr8U=
X-Google-Smtp-Source: AKy350aUIQPjcpFlnTV201aedCQbecb4SHDk62k2oFALEXUdwYNP/zwYK4tYwxbFicGu+p4+zmMrHA==
X-Received: by 2002:a17:90b:4a44:b0:23f:37b6:48f4 with SMTP id lb4-20020a17090b4a4400b0023f37b648f4mr35172pjb.43.1680819024501;
        Thu, 06 Apr 2023 15:10:24 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:a082:a1e:6444:f6a5])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00199193e5ea1sm1825739plb.61.2023.04.06.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:10:23 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Date:   Fri,  7 Apr 2023 03:40:17 +0530
Message-Id: <20230406221017.4746-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
References: <2dc882b7-d09f-dfa0-67a1-3f9e6f1ac457@linaro.org>
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

Hi,

I will check if there are other bindings under wm as well and squash them up into one.

Kind Regards,

Saalim
