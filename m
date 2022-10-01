Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EC5F197E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiJADX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJADWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:22:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80959BC908;
        Fri, 30 Sep 2022 20:15:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b23so5752074pfp.9;
        Fri, 30 Sep 2022 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=s85Rt60Mfq98bn/SHpgXXXzD93J670OfD27PDsE2EQE=;
        b=OczrCJnpw4f612BkkHjpb6nxbr5u2LjcvKagDHPpjFvXhIITEU0Iey8bxPAtG+jY2V
         loHbLeoYhjftRmMvO8BeYfdSXjgjKXZNQwOT13SaNP4SLrtoIrTMQF+jGZUQ7y7vNB+4
         ixrM81Hq13Yk0oJiv53HhrIw4ECmP38j4gQshlwxSCyyDw6ZSNI3cXTVwhZo+neEPuSP
         rlMFMuGuw4C9QGf1K+IYtmAKZ0lUFtwYIeJ8iPRrvrKj2NfrGnSE0Llgdnfgx5V1h+tZ
         bmE2AmvFaGVqWgQBWWq289DvKDd1nqQW6Q5sxpmQ0L1ZpuuBLVzhBEt+Ac0wDy6bBAm8
         dvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=s85Rt60Mfq98bn/SHpgXXXzD93J670OfD27PDsE2EQE=;
        b=ObsBUKhUGxi9h2VePk3E60mde3fjed4nUaPZ00m0tAbL1C+e701NZvRJuthdZu7ntk
         DG4Q8isXHjjFSGWz+G9W92xRB9/1E/o5ItBmXj8hed7oYfpc7uccfuovE43s+i+H6SxL
         l3IYPweDxe+dbjrzPKPBFbDUJBcEg0Ta/ya4N736Iai4dlsGB+hB0czCz/KWy9ZEoIfE
         YkHRT/QwAjZNyUzURHA7XLwkmjvSUmD4wNa5Op9bZhiO8wOKQezMRx/0BYIYosRyM3Iu
         8+bJyCoVI0ArrH5giehxJWMeXKI2q+EFmNhX/G6ifNcuXvJzT5pnnUiff5ja5yKtt1NA
         104w==
X-Gm-Message-State: ACrzQf0WgC2xjHhrRBuY/IkubmQ5637aHzshCQKbEhFnaj+x91JacVoe
        aLrxNBpmK1GjQBIN8AjBaoCbRge/5/UPhrN2
X-Google-Smtp-Source: AMsMyM6I0UsX6fFsD60St3/A+1+4GzgAAD/xDqa7v5cxn8QZrs4ASfUvHi/1vDy2A3nOVqE8EGS1yg==
X-Received: by 2002:a63:2a02:0:b0:42b:2711:d534 with SMTP id q2-20020a632a02000000b0042b2711d534mr10078932pgq.176.1664594036934;
        Fri, 30 Sep 2022 20:13:56 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id cp1-20020a170902e78100b00172a567d910sm2627371plb.289.2022.09.30.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:13:56 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v6 0/5] remoteproc: qcom: Add support for pronto-v3
Date:   Sat,  1 Oct 2022 08:43:39 +0530
Message-Id: <20221001031345.31293-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the pronto-v3 remoteproc found on the
MSM8953 platform. It also converts the documentation for wcnss to YAML.

Changes since v5:
 * Fixed memory corruption in driver patch
 * Slightly improved driver patch's commit message

Link to v5: https://lkml.org/lkml/2022/9/29/19

Sireesh Kodali (4):
  dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
  dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
  dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
  dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required

Vladimir Lypak (1):
  remoteproc: qcom: qcom_wcnss: Add support for pronto-v3

 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 -----------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 294 ++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.c               |  12 +
 3 files changed, 306 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

-- 
2.37.3

