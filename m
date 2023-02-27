Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D06A3FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjB0LB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0LAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:00:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B502007F;
        Mon, 27 Feb 2023 03:00:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so5737651pjj.0;
        Mon, 27 Feb 2023 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFzgTaiWcQIPYwKIkE4QWiTWeDFQMo1N82kLFrXukaQ=;
        b=OPz8eYyLQJ7KhWOumITy9lQam4wFZij+pd7qvjPRO+RxtIh9HEUGdDZE5OxqgA7HXO
         bcsmA7e5S3+wfI9B6l0CN84Hf2RCO/hZmJDy78pnD5mnO8cxm+fajkPJYBn+vVWX061n
         6pjkdJXWM5TT4puVefhwCfIl7AfbCx1FikV2Kd+URNaUzsYA9lmxND+C5/6BkhfH4Ev/
         TIUXYJTHVsysuwfINf8W9T9bztowbQpfOX1oLHiy3THDb2lu76oIVc0KWhjMzA1x9r34
         eaKUgPIzXhXl5vln6YmYkEWXl006nArQqQWJ86hT16OAeFDgsw6Z4Ab6JLjB5M5ISQUJ
         0D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFzgTaiWcQIPYwKIkE4QWiTWeDFQMo1N82kLFrXukaQ=;
        b=QsQcNHut4gdVRa0V768Tsuh3WOlgKvNc9PlcvM4Wi0rzVQzkkPq2QqISJaz74TL/8l
         W0g0HyFgoxzRpY6cIjTjUHIiq3tnhFUJMkrVldw/cpzwJS9zr7eRUcPEFLYmCbC6z2Am
         LEInRB7uniFpjsttjfduy1cH82spb3RToFF2wLf4GrWrtr95N7hzl30O9v6jsR0CcS9v
         tkIXhDLbd+gWJeEG2AgTKIzXaB1Zpxjx3UwAYMllqorfp1IwlmW8O6dNLNa6zNrzjNfG
         dN1pkvXgJcdNBMFVYUZnoR+3t2xCZn7FKCP/B8EsRB+VQIItMU24bTmasxfGCSqpY8u2
         3dIA==
X-Gm-Message-State: AO0yUKUrK0OuxymB/3RG+fsUqbVICkubdN1s80bn+51RlkW33UZjPTod
        V0oCIKYZHzXBS/GCcB5mlh0=
X-Google-Smtp-Source: AK7set9tHTkqdUjni8Yoqj+dQFR6RfCuA7YAg7Vi/pbwgMFz4YIas8EaUb6bFHEgmK4tjS6iem3Jdg==
X-Received: by 2002:a17:902:d2c8:b0:19d:19fb:55fd with SMTP id n8-20020a170902d2c800b0019d19fb55fdmr2924513plc.20.1677495596942;
        Mon, 27 Feb 2023 02:59:56 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902b68500b0019a7385079esm4292115pls.123.2023.02.27.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:59:56 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        robh@kernel.org, conor.dooley@microchip.com, palmer@rivosinc.com,
        leyfoon.tan@starfivetech.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] sched/doc: supplement CPU capacity with RISC-V
Date:   Mon, 27 Feb 2023 18:59:41 +0800
Message-Id: <20230227105941.2749193-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit 7d2078310cbf ("dt-bindings: arm: move cpu-capacity to a
shared loation") updates some references about capacity-dmips-mhz
property in this document.

The list of architectures using capacity-dmips-mhz omits RISC-V, so
supplements it here.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 Documentation/scheduler/sched-capacity.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 8e2b8538bc2b..e2c1cf743158 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -258,7 +258,7 @@ Linux cannot currently figure out CPU capacity on its own, this information thus
 needs to be handed to it. Architectures must define arch_scale_cpu_capacity()
 for that purpose.
 
-The arm and arm64 architectures directly map this to the arch_topology driver
+The arm, arm64, and RISC-V architectures directly map this to the arch_topology driver
 CPU scaling data, which is derived from the capacity-dmips-mhz CPU binding; see
 Documentation/devicetree/bindings/cpu/cpu-capacity.txt.
 
diff --git a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
index e07ffdd391d3..8cba135dcd1a 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
@@ -231,7 +231,7 @@ CFS调度类基于实体负载跟踪机制（Per-Entity Load Tracking, PELT）
 当前，Linux无法凭自身算出CPU算力，因此必须要有把这个信息传递给Linux的方式。每个架构必须为此
 定义arch_scale_cpu_capacity()函数。
 
-arm和arm64架构直接把这个信息映射到arch_topology驱动的CPU scaling数据中（译注：参考
+arm、arm64和RISC-V架构直接把这个信息映射到arch_topology驱动的CPU scaling数据中（译注：参考
 arch_topology.h的percpu变量cpu_scale），它是从capacity-dmips-mhz CPU binding中衍生计算
 出来的。参见Documentation/devicetree/bindings/cpu/cpu-capacity.txt。
 
-- 
2.20.1

