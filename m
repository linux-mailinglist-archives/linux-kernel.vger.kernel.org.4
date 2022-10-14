Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891F95FEE05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJNMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNMhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:37:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6B181CAE;
        Fri, 14 Oct 2022 05:37:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b2so10191678eja.6;
        Fri, 14 Oct 2022 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BElY3zj5J2fYFTJ0RPslkHgvyyXgBEXfPcu4R8WcRPQ=;
        b=jNPKOyLU0SrI2xT7FEsBNdwRhKu8jkaIdyEoiq7u/3n9RAJkUCSklDmmbJ4h0w9OAE
         LhJGUL7DMOfhELkqg2sgNiW7u9Dqr81ugDuuDYc3OlMyAOE9lPz7HiFoO1jsCoi70CCz
         gge5+uBD4XOUch8d+E4xwOaeLn01bweW6f9UZBxvq68fC1QdK/frtOuiHkC3/5CVwD4A
         MzBVTEyRA+hF6C6i1zAIzkZejeoaItHnKpUFi+D7K3Y5vhVf+n9fIWX/qL3OONpLUy1E
         lVOrApnahvLgPl7vgsZBaR1I8Ra25NpxhwI8+tBiDEG5ZV/mtmDi3yPD5ikQMbL9KjaI
         QZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BElY3zj5J2fYFTJ0RPslkHgvyyXgBEXfPcu4R8WcRPQ=;
        b=Rmtv3TOnZ60MitKNoy6JqFIuvTBwXvlyvbMOfzLapMUsdRlMJIjNliOiAD7DMoY/4s
         NDWjxCFNMM//vyxwwT0NcgmAKp0+qhqLMh8tg8Sy2p1oRvQgEt3B0LWnUbYdcxrlvcCB
         16hUWSLo3vHq/lGOTYifHuqwzRvP7hJ4AQ1dsljLAM6psGWNJjxcZTB8XH3UFsEpSqRW
         qxcI+U8GWlHwW134SI20WpR8fH81Y2EsFuLuHctup6ZnnVB1tvaXywVj5SnSiKnFC29/
         LSkbhkPJ+SDWX4rvEzRljCW7TaHZ63bkDU4kDlvUuyTyOMX0bN2DwQ9my7RRgA2nG/cO
         OrVA==
X-Gm-Message-State: ACrzQf0ul8sYblc2V8E6VutYfu7MM26k7zWytZ8Jifw1QfiekqMl468E
        5827Mx+XbkUV109P9fmPgPA=
X-Google-Smtp-Source: AMsMyM71cZAxTqFGQDy6LN3gnTgoSQ31JESWaxnkIbtukxeZvsnqBJGa+0IX/NqQ3FxsPDtyxw/5EQ==
X-Received: by 2002:a17:906:cc57:b0:78d:3612:f0e1 with SMTP id mm23-20020a170906cc5700b0078d3612f0e1mr3479322ejb.188.1665751055571;
        Fri, 14 Oct 2022 05:37:35 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dk24-20020a0564021d9800b0045b910b0542sm1774756edb.15.2022.10.14.05.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 05:37:35 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 0/3] Support more parts in LTC2983
Date:   Fri, 14 Oct 2022 15:37:21 +0300
Message-Id: <20221014123724.1401011-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Also, remove excessive allocations on resume.

Cosmin Tanislav (3):
  iio: temperature: ltc2983: allocate iio channels once
  dt-bindings: iio: temperature: ltc2983: support more parts
  iio: temperature: ltc2983: support more parts

 .../bindings/iio/temperature/adi,ltc2983.yaml |  63 +++++-
 drivers/iio/temperature/ltc2983.c             | 195 ++++++++++++++++--
 2 files changed, 240 insertions(+), 18 deletions(-)

-- 
2.37.3

