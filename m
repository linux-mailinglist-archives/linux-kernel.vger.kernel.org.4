Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF046E520A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDQUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDQUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:46:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F3449E;
        Mon, 17 Apr 2023 13:46:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l21so9362760pla.5;
        Mon, 17 Apr 2023 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764403; x=1684356403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW1W77t+hTd5dBsO7LqOvsGmGjvsBWZwm6oBjjHSRxI=;
        b=EPIpCONpQIjyYKAFdjlI1lXx6DV9t7G+ZlhOQdxphC7zJeFZCHawOxjbnFqo6Cqz4P
         6UUGkMLShM2Tl1TWMJtEIbtOpPOQOATsWLB1c65pORCWhYQplELbToPdSEPWMSNbszMG
         8ceMbsr1r+yc4+k+RNR+dMKzxulPus6a835BWcDB+3FkWyHIuI1xoJWIP69mY8L+kJfQ
         JUgjdjzo8HJtrMIAwXDZ27FLAQM3hChGE5j1ez0BQJ33WO3HAXjIn3eVjhgaQ3c5qmpY
         HfVRua3BwnFYTUHP9AjApYD2izRy6nbeNGZjKalPI5wkxV+GaL8dh7KNZyhD2AZvzCR/
         aA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764403; x=1684356403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW1W77t+hTd5dBsO7LqOvsGmGjvsBWZwm6oBjjHSRxI=;
        b=PGhvhqfqqrgH0FJSpBwMwboFMvm1QDyFbwp/RjnrL7kNV8rsK4kxHJ8RfyDcitRkZN
         0c+glQ0SS9cVngQR6ptRW/bOXGktnhpxeDn/g/Zs5iGDpT9XUEN7/Y7yIFYAlOHbxDV2
         FQbCaLyBuW9gBw5LwX4s3dGEBF8PTQf7HNQJQaIvm6ZaQrJZez3k5yZrbnl2U4+zrFfx
         lTc76jLTGB4MyZUVkxhIimmPwkm8RK/Wy8OyKJJ9/wP/6FXVJi3UHf0sGJpjcm2Zpf8+
         LZy8iJGBEMG1yw7FkhCAEyQGFPAQuBkYoC0RXhOCwqf/Vt6oqOLJBB8UyIyS4P6aDk1/
         FgvA==
X-Gm-Message-State: AAQBX9endEsUHfBPg5345FFBp2pPUoV908cNYt1fzm0YmiJDA/4DXS0G
        ga62hUm+9S308/nZg1Lp44g=
X-Google-Smtp-Source: AKy350bRXLKLwaeRDW7sMd0ByKinn6Da0Tpa3cDSEUTgIjqC7O6aPCiDW/VU3dsCsMyaDjoJJgRuog==
X-Received: by 2002:a05:6a20:728d:b0:f0:4dbf:5f92 with SMTP id o13-20020a056a20728d00b000f04dbf5f92mr2315120pzk.26.1681764402424;
        Mon, 17 Apr 2023 13:46:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:218d:82:ae97:7cb6:b12a:54f5])
        by smtp.gmail.com with ESMTPSA id x14-20020a63170e000000b0050f56964426sm7198932pgl.54.2023.04.17.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:46:42 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Date:   Mon, 17 Apr 2023 20:46:27 +0000
Message-Id: <20230417204627.137883-1-danascape@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <98da9a32-9771-1002-f323-909e8b49a536@linaro.org>
References: <98da9a32-9771-1002-f323-909e8b49a536@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for that, I will take a look and soon push the patches for bindings
that are actually being used.

Kind Regards,

Saalim
