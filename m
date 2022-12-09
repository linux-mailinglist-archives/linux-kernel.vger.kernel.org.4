Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A986483DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLIOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:37:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FD22536;
        Fri,  9 Dec 2022 06:37:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n7so3722472wms.3;
        Fri, 09 Dec 2022 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksjf1ifYnL0IeOGv0R3sruLheVUdXvnakVg9dKCd4O8=;
        b=OQbbA1cK0DLAHzSfbCq5R8N42tSEvcURMYHt9ZKK+qQWDGzmd6F6B4RFf1jPssJGbj
         ZVLzrI0eVT8/DemfkWZX4S2ly6YAMd4Igj2dHB5DSD+4aeEdEVoScZ8oSd4eJTr5tyRR
         Yf3GkNs4OgraFIWhrjQE8n/HMyqK5p2aGAxY40oV1AVYan85DJXLUrnud+gMZcrhJHiY
         AYhPxe47WfPQdQ4+0W8NhvANhC7JWtG7EG+Bl5TZSJjVmsDgF1F3SEXCPqKjMbrY0UQW
         Nlp6j6rGt3VHI07A1wXyixNjgDjAzGlUj9olUKmAUgmI2+RfO1j3ezGdMzKoC8tC8lTn
         MoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksjf1ifYnL0IeOGv0R3sruLheVUdXvnakVg9dKCd4O8=;
        b=Ru/8MXPuwfhtWmbP9oiFb9btmfYeKny7UEmymkPdY0YxaOnm2iO2joMuERF+pXTnn6
         dIMdTJUQlx+kmnjDZyFEamOFey/z/Uri3vj7uj9DQm8M+ceLaU43WCKjy4xrQAps+h/7
         /Y5gmQ7/DU5OrO1S296oA4neOAQbvBXTm6N9ydYb2bXw4naGbjtrV7hPaYNXGEhpzVzR
         tg8vPMMI6e/GP58U4pFKomhy49XbzjpxMvuoMNbF3lo6sEpvewdC8AA0XrogQ0o7jGv4
         yexSnkYYiNinpAOyanJcVWvQfAyTy0bAO0Dw4+Vjh0MxqAk2QPZ+6ul1TOL7F4uhRRKF
         YhYA==
X-Gm-Message-State: ANoB5pmUBt47kjny+xOc8ask+ruPmlGagWn3yurZL1ZDX4i1R9EAo0mN
        7ghjmQHQhwXgKmHCfiK9i68=
X-Google-Smtp-Source: AA0mqf63osf9GJAqNUmeOnHYl7OcmwLZoFhTthT6awFqHx8o40PCq+85mTgT5LZ3WhrI54SyAX7gVw==
X-Received: by 2002:a05:600c:1d91:b0:3d0:274a:3171 with SMTP id p17-20020a05600c1d9100b003d0274a3171mr5173435wms.0.1670596676855;
        Fri, 09 Dec 2022 06:37:56 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003d1e3b1624dsm9645517wms.2.2022.12.09.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:37:56 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Lee Jackson <info@arducam.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] media: i2c: ak7375: Add regulator management
Date:   Fri,  9 Dec 2022 17:37:38 +0300
Message-Id: <20221209143741.214242-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds needed regulator management for the AK7375 VCM.
A DT schema conversion is made before adding new properties.

Changes since v2:
  - Increase delay to 10000 microseconds to match the AK7371 datasheet
    and because 3000 can be unstable sometimes.
  - Use dev_err_probe to report regulator parsing failure.
  - Remove AK7375_NUM_SUPPLIES macro.
  - Use unsigned int to index supply name array.

Changes since v1:
  - Add vendor prefix to DT binding doc file name
  - Reorganize variable declaration
  - Change the power-on delay range to 3000-3500 microseconds.

Yassine Oudjana (3):
  media: dt-bindings: ak7375: Convert to DT schema
  media: dt-bindings: ak7375: Add supplies
  media: i2c: ak7375: Add regulator management

 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ---
 .../media/i2c/asahi-kasei,ak7375.yaml         | 52 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 drivers/media/i2c/ak7375.c                    | 38 ++++++++++++++
 4 files changed, 91 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml

-- 
2.38.1

