Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96162EDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiKRGwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbiKRGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:52:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F941F9EB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w14so7809770wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGKQuiawH7Sdf6Z05OzXu3xdOP+mLg0wu7i+RPGyvnk=;
        b=FIFhbfWnuLmZVIOLl6Aw3AiEQJwGnRa5AjtzlummRfNRKaTZLk1nqbFyfKRMG/1E1o
         0+ZWP40avf+x8QlJMvUo/Lr1+D8SlFp1Re+l/yk1JMxVtDapSHwaYPzCKPPLYsOmpbYb
         al7nYd74ZkPTme+Yp3aEFVdTDgRC9iuIqOIiV3P5Dj47zd35dqQA8PT2RAcOQfKMMoix
         P4ZjdCJYNqH2WsyLCSBV7IQ9r7yGl53zAIQNoxE6Z0a7z2QeH6+xVPClyZBRbiiZObfP
         GxNvOh6P6uKFX1gR01/eE/uytJJz2keS0ZK1JrIgJXsuPn6XRkOOvPLcIF5GPO2EIh87
         p6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGKQuiawH7Sdf6Z05OzXu3xdOP+mLg0wu7i+RPGyvnk=;
        b=BiDsVYxW2xbw2+hTYFeCIIkeHovEj65Ubr+Gw93QyhH48g5phzR8rmW5FUO3odJ55E
         fDEslFBeLdAqsMGUGfEeo/cr25CuC6W5VcWVslpS8dzGrZQDWf5qNZB+U7HV4njc8Zd8
         IEE4W23Ct0USK762vpOIIT+lnJk8LEADzLt23zsQCIdbtNnAtwUPMdO/d84va7/3HqcD
         v0qRd6Zps1R3/Voi19VpYGCV0Olwm8iRnF+gcmpgRWzUNl6WJQ1WkAl11Y39c6wIfdDk
         aLqJE5GBBhhY7NF1pxOmnZ4Ddvns1owdeJMH0DFtYnN4VmUG7Opi0fJuefTqe/V3eqgq
         uzAA==
X-Gm-Message-State: ANoB5pmnHnC0rEWMUmyc+WORJyiExS5r+8qXNnM74N8FqwjC84iNdM9v
        WnlWn2dYp4HKczd/qvYbxDuAOnoUHO75vA==
X-Google-Smtp-Source: AA0mqf7UxRpteInFjRRv5pc2/cI0LpJEjQMLGivxYt023HqjOhADMzRotCW1GWmiyQpQqw+aP3bH0A==
X-Received: by 2002:a05:6000:544:b0:236:64ce:2c0a with SMTP id b4-20020a056000054400b0023664ce2c0amr3433777wrf.230.1668754357947;
        Thu, 17 Nov 2022 22:52:37 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm4400165wmo.32.2022.11.17.22.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: fixes for 6.1
Date:   Fri, 18 Nov 2022 06:52:26 +0000
Message-Id: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are two important fixes in slimbus one is to fix the presence rate table as per
the MiPi spec and other is fix a build error.

If its not too late, can you take them for 6.1.

Many thanks,
Srini

Krzysztof Kozlowski (1):
  slimbus: stream: correct presence rate frequencies

Zheng Bin (1):
  slimbus: qcom-ngd: Fix build error when CONFIG_SLIM_QCOM_NGD_CTRL=y &&
    CONFIG_QCOM_RPROC_COMMON=m

 drivers/slimbus/Kconfig  | 2 +-
 drivers/slimbus/stream.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

