Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94B701F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjENTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 15:00:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20FB1737;
        Sun, 14 May 2023 12:00:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-530638a60e1so4505502a12.2;
        Sun, 14 May 2023 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684090820; x=1686682820;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvaHiNJqWsmyFn/ekVz/emUkR3dSqPvXajmdSTajqVE=;
        b=GVmeq51NK/tWqfjYVZEWsoyWH0NmNmKnj9v+Xqu/VprIo3dXKjY0sSSvsEFFpVsquH
         totFEhYQwnUrkj6etw4SZqwKbZBsnPmOhAEBz2Ep0CBFxuPaIWfDi6cGeS6dB/P8cqm3
         ktsltV8z2PtEjWSqVbb/YsEiAZ6rxw0M/e73u18dvkw9wJ2wgP2Z7lBYd8+4qLKVs+4e
         y+CRf+9pFbyms0PfrRZMb7kRUR1fF4sqYz4HDEUNZC+YlIyZWXHk62Gsxq2JNPLmS5EA
         RQ2pYIOIQOF8zGKnzKsCeaytGbBcWPRwSQ0Y9qTZ1KdPJcZeYlp3KOvw6SurwNz1W2lf
         s5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684090820; x=1686682820;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvaHiNJqWsmyFn/ekVz/emUkR3dSqPvXajmdSTajqVE=;
        b=iDfBMV2qT9UfzI8Ak6dQwVy/vKXNIbRdzqNYzRweD9fNW/hl65xGmvbpy/YnQzIvfU
         w8SalyPUlZui/BYixin6/Ryg/LynN5oqQzOciaSXhMkZ32v11uVp8Lytm8LvuxDEDjn3
         m0Ie6hsdsB4jmVdOP0t2YyNOypMX0Dh7GzMU0Epty9OpQCmprJpJ3PoQXHsWS6R4vK+q
         MOqzxOzDBb+WP27/VdCjXRK1XKQfE68kjSCJqBPphRp7bRYYLVwPu7uB3mqgBspA28Q7
         zNgl80RzKqUD7MlFMzxouOR/nInrqWL77nnEhPSsyCbK4OF5GzvPiMipo6EygSZgYfzD
         40jA==
X-Gm-Message-State: AC+VfDxfpz7QjuuA2Qz6wuQPUeelxJH6YLgsfLtrCOFb/2EUdJu/kjHF
        /PRjdkVWpnBB5pgBvMTGoSObh1v61qh8E98d
X-Google-Smtp-Source: ACHHUZ6UaDgvw4ldOShttN91tw6g3sRFHfvY4bFY+iVSiTr1DADT7l9mQeikUuI8sXnwLSonlwpNbg==
X-Received: by 2002:a05:6a21:32a0:b0:ff:f2c3:c103 with SMTP id yt32-20020a056a2132a000b000fff2c3c103mr35826539pzb.18.1684090818757;
        Sun, 14 May 2023 12:00:18 -0700 (PDT)
Received: from yoga ([2400:1f00:13:3840:2d88:3593:2af7:2b37])
        by smtp.gmail.com with ESMTPSA id p19-20020a63f453000000b005287b22ea8esm10133177pgk.88.2023.05.14.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 12:00:18 -0700 (PDT)
Date:   Mon, 15 May 2023 00:30:09 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add dt-binding support for ti tmp006
Message-ID: <cover.1684089997.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches introduce device tree binding support and
add an of_device_id table entry to the driver.

Anup Sharma (2):
  dt-bindings: iio: temperature: Add support for tmp006
  iio: temperature: tmp006: Add OF device matching support

 .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
 drivers/iio/temperature/tmp006.c              | 10 ++++-
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml

-- 
2.34.1

