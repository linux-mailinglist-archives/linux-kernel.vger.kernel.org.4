Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6E6CBA30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjC1JMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1JMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:12:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F4210F6;
        Tue, 28 Mar 2023 02:12:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kc4so11010064plb.10;
        Tue, 28 Mar 2023 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679994770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjKR43VbxeR7vdHwFcvHmBUKzkYBjIRkKu1UHdiheSM=;
        b=FW4A2VOtVLGB0GxGIpIY3w5FcfxKXpaKm9zZWes6oXETZ1Epy3EqFOapKSWtc03XRp
         Nbs4C3Fn9ASNoTnQo//kJC+fapwD1zhzxTvOkFmfqP4gO7DvH7fdcMxsKESPbdmxV2yF
         9Vn2EjISi/CPLefbLUUSJZJYYPagsd7YWxDkspmnXvRnnQmR+tSfHsnWELSapRPgY7fs
         qU8lk9lf6sjtSQ/08zjSk6+xQUBWf4KNVrB9Z01oNwAISIVxIoSVMkPIjBufOFozsmdr
         N+TRZXahoHMDMVv/iztmaXcyXfg6pQ4bA3J7chLrZIBTV/nYgaRp40xj2AUXDeOi53VR
         RhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjKR43VbxeR7vdHwFcvHmBUKzkYBjIRkKu1UHdiheSM=;
        b=AXcrrPYO1tyjEVGYQsFe9QOsigWr646ojX/fgcyodI8HioyA1aJqcy1ya1vhAmwV+P
         /9q1YCuJDoa5AnA8VLch1vpfmHE4N8ebgxuupGL3lYWQ8aPrJ+lLeQWRQfJ9DpAzSb5J
         5vJXcP2vOwBJa2SkVZi1Lf6trgHPwak7NFQNBoBRl2wrw1oJRZQENM5HwGQMSeEWx4ID
         hEoDaMvR3p4vY8uoySmtE+G2pgqjVIt3H4HY2xbBoiuzs/uP7VosqLmV4a68+BEkeID+
         xZiEL0AuGrQ0Y71kEiHyZjxhy6AbiBGI5F1qDvNZ2sEZymACWzAFV+e2SmNWLnd2Nap/
         ugLA==
X-Gm-Message-State: AAQBX9dULK933NGReM83s36+dXQQKSpOp9tGul6XXfEHJPdBeEgW+uKE
        KSxFVfhW/75FAQyBpewuUH4=
X-Google-Smtp-Source: AKy350ZnG1nPIqKzV4bdSTUU92pL8qU8Qm37Z9EZyLIrdFyr754Yefs+tuvZw9kridOxb3Ym7rpsNg==
X-Received: by 2002:a17:902:facd:b0:19e:e001:6a75 with SMTP id ld13-20020a170902facd00b0019ee0016a75mr14183248plb.6.1679994770593;
        Tue, 28 Mar 2023 02:12:50 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:db37:2c9f:dcb8:89a9])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b00198d7b52eefsm20531796plk.257.2023.03.28.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:12:50 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH v4] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Tue, 28 Mar 2023 14:42:45 +0530
Message-Id: <20230328091245.55484-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <992c64c5-48f8-e267-283d-51a57f238433@linaro.org>
References: <992c64c5-48f8-e267-283d-51a57f238433@linaro.org>
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

I apologise, I will keep this in mind from now on and will avoid it in future.
I will send the finaly patch, fixing the schema format.

Apologies,

Saalim
