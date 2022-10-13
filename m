Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF05FD74D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMJss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJMJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:48:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F583102DEC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:48:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s30so1856380eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=my23X7XxT6pOMsybxxTZUlwXrtvl44KFC1Kd4yeNLFQ=;
        b=T8kwpNGL4ofTXFyi5keWw8GnCMoWUaNoacQ1FkmM4XnUX3gspgXGASmjqQW5f3dBwu
         p6WqNrAE9XQjNzOiACOsodxq8VOIu18F5/JT9FjaoIPG6xnwwE3jljBbVdMaYrlsrAgx
         LppoCAnrxUWtgZuVf0JrydJg4MWAEEaYb/a+ctlgo4kn3ihwFnurmJZL4JsEXMOtnXfl
         f71ctgIu2OtLQIlQyEbvH7QkmxCzG5C4gXeJoCa7VUj/2clQuj7uHB31QWDBSGDRZdES
         TFzmbhgzguHrzxxnon0wu6aOlkzdI7mneyqM9MaWBZbQ3oif4HxauHLQpZC1Fq+Vhg4W
         IaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=my23X7XxT6pOMsybxxTZUlwXrtvl44KFC1Kd4yeNLFQ=;
        b=TCRrn4JpT0HLjSbBdUhk7XBPlP+VqJC+eN7ZgfW2JBTnHgmRM60N90BfFMbCHLMAOj
         HrI/jLuYwApH7OaV5/VIHmE76TJI7f+bY1w+nx6s9F5gtmrmxM8GffVdpSbfQd4AgURo
         jI0xiYAtiX5srEzv+Af7e0qqGYGLCx1FVIEBzqSnWJz6hF9WwYUh121YeT6rqF005Ncq
         qwy4J26aZE34SXrsMvGdTIy2l+YCYFZxhnix3+5PqDqx/ulCrNqeeRH+91Cjx2Z7yskf
         deZ8G2Vbk01p5WR5Jv52FitpHSUg/UD5qrVpZnLx7BWZBkvXbwX/qzbVYKCWFsQKDsqV
         us/Q==
X-Gm-Message-State: ACrzQf0RA+mApRa0eoigOhLjW4c1/M6FjS44BocGB7rgKDaORhpYvvvW
        tERVeGkJ8y4ymfEaPEaa8Fgv4A==
X-Google-Smtp-Source: AMsMyM7tiL6Pf7wWA/lbg0cMMqCs0+HhyeCcG+24yH60eqYG8vntORWjiA4qPzQLvpZpxxoQntgG+Q==
X-Received: by 2002:aa7:de10:0:b0:458:e101:fe54 with SMTP id h16-20020aa7de10000000b00458e101fe54mr30106621edv.80.1665654523038;
        Thu, 13 Oct 2022 02:48:43 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906080e00b0078d25e0f74bsm2685353ejd.46.2022.10.13.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:48:42 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 0/3] Add devicetree support for max6639
Date:   Thu, 13 Oct 2022 11:48:35 +0200
Message-Id: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
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

These patches adds devicetree support for MAX6639.

Changes V4:
- Fix dt error
- update comment
Changes V3:
- correct fan dt property name
- remove unrelevent changes
Changes V2:
- Fix dt schema error.
Changes:
- Add fan-common dt schema.
- add dt-binding support for max6639
- add max6639 specific property

Marcello Sylvester Bauer (1):
  dt-bindings: hwmon: Add binding for max6639

Naresh Solanki (2):
  dt-bindings: hwmon: fan: Add fan binding to schema
  hwmon: (max6639) Change from pdata to dt configuration

 .../devicetree/bindings/hwmon/fan-common.yaml |  48 ++++
 .../bindings/hwmon/maxim,max6639.yaml         |  86 ++++++++
 drivers/hwmon/max6639.c                       | 206 +++++++++++++-----
 3 files changed, 287 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml


base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4
-- 
2.37.3

