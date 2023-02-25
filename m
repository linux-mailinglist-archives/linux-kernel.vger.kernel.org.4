Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAF6A28E3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBYKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:16:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5A2057F;
        Sat, 25 Feb 2023 02:16:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id da10so6973557edb.3;
        Sat, 25 Feb 2023 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeexrnsfKxBTOcA3D+ZUlVNtFgpihCGwKRrGZjNCkaw=;
        b=F98gOqKA63kr7GmsTaWBWi5PM3SAB8AWAbyro5aCO9RUNXdNP39BrJ6RvMjHX48f/T
         cGpD/BGJQgEzyNkdSShz5MpQTmBdyqimqcYitvgGchaefFJlf3oXSjRdtquf+kxixgaJ
         wU4smkyQIcu8dGFsnaIOxk+kEQ4o+MIiORfk6gMxZgpTZzOqjMkkxW0Lr5Wk/vYDgMdU
         Z4rH3wk1qCI+Ul8R/TOYw6kIBgqTIhWLfeFBAHlZ1EQ28QmeADsQvpuSBNW2Zcrvun6O
         B26GM3EGlrjck8ZXlYFZJHzndHXisj5rvLoucx15SrTVGf0WcoNIl76G4C17K+aBaQkV
         2G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeexrnsfKxBTOcA3D+ZUlVNtFgpihCGwKRrGZjNCkaw=;
        b=wO1xD0m1XpW0lzggyWne2NnM7V9Qx5uMTILCbCQiZVVKn8w4tAPVNxo3Ucavha2jMS
         nyI8g6yJx3opiJA4f9E5gjwjo0zACefU9VdzBpeDNru+7Guuo10EtvWz2nY1Q58DZzVN
         fVQfHvODxrQixAbAOnyESgvxWPDAmlxhGHp0UWx+lsQDDaHYpInjusWo6WieL6AlJtvz
         fV4QlfoMA/Yk7dtVaTep8FsC4vvIwsiB+6Uxk4cXkcZGkZDkX72wRenIrxxOwvjkN76v
         bsaykApLoM+GQYzW6DSeC8+wp61Ge1XU27/e2HUrhtG/+G/VrSQb8HeaKN1atEQhHhDj
         HlzA==
X-Gm-Message-State: AO0yUKUrA5UkmiIUjaGFz0QLMsLxMLwLgAAlykBVkN6rPELsyJaYujtS
        oygKrPgkXT4vhUcSPtUQyUU=
X-Google-Smtp-Source: AK7set9JHaSiK3fqBZ0S6nmtza14LUX52Pe5rBY4sov4MPAXb2H6EhECHy+481qsmKKbgIL/iKTCcA==
X-Received: by 2002:a50:fa96:0:b0:4af:8247:273 with SMTP id w22-20020a50fa96000000b004af82470273mr3697503edr.7.1677320214580;
        Sat, 25 Feb 2023 02:16:54 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004af6163f845sm677722edi.28.2023.02.25.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 02:16:54 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] MediaTek MT6735 SCPSYS support
Date:   Sat, 25 Feb 2023 13:16:26 +0300
Message-Id: <20230225101629.264206-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
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

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds support for most SCPSYS power domains on MT6735. See patches
for details.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (3):
  dt-bindings: power: Add bindings for MediaTek MT6735
  dt-bindings: soc: mediatek: scpsys: Document MT6735 SCPSYS compatible
    string
  soc: mediatek: scpsys: Add support for MT6735

 .../bindings/soc/mediatek/scpsys.txt          |  2 +
 drivers/soc/mediatek/mtk-scpsys.c             | 84 +++++++++++++++++++
 .../power/mediatek,mt6735-scpsys.h            | 14 ++++
 3 files changed, 100 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt6735-scpsys.h

-- 
2.39.2

