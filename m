Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92F5EECE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiI2FCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiI2FC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:02:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08F1251A4;
        Wed, 28 Sep 2022 22:02:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw17so326573plb.0;
        Wed, 28 Sep 2022 22:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=slMGVfBYWKh5mQRhEr4L8/hzR1NRfQNBr5rgRMCfnYk=;
        b=HZkhANATMknwN+umeUoj1OKs4z/NbG1xSlRzRDNTH385eCzMjvsMeWIzfcYqRyAnJR
         yS9VQoq40YlZp8zdv5w/y5f0R4akzmIOr/lO27ds6jNJdJVKSl65WRd9H6wZWCj1YULe
         4/nycy7oev0d5NWkB062Dqx/35qFGHsJ2PBJMBHO8mgUdUs+Fhs69p+o90ufnA/pk4Ba
         XEbz8nLLauvKQ0KrAnUtJJNQjKt8l2CGB3CeHeX/YRa2Hfnggm4IwQa6wumkKWAUZamm
         6Jqm7zAWLAlrEk9TD3wa4qdQidUZLsZJY4Pt9VKyc2bngy2H6og2obyCAh9Q02Wf23H9
         2Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=slMGVfBYWKh5mQRhEr4L8/hzR1NRfQNBr5rgRMCfnYk=;
        b=dXDHC3ftm1OHVrqFPN9orJx0nImdqS6zsFScBCyyywyiXXQi9vCOuHbiC7h+Iw3e7s
         BmZNjjh3O2/+oB6dXmx596Vhmi4ScXJT0TrZOV12vlTqahDj+B1FXZuKYI6Jvb7yktIF
         F/NuZQqMsa/hMYfpsFhmiNjKfZtX1qUdKpcQwL3dE7K7cKCTYZ5rR7iMna06MBbJfMF8
         aMiSDtM+SrXSxPRl28h5tE1v5jc4CEAKIcw5X0BFJCAnSwpP1/V8sWwltFNTe78cnYey
         14HCnMqahsxXleALB33Fh/9sg+qgZOxjL7iXIN8mVBYGwstNLC7ObM/kWN44ooWOsoSc
         a7Eg==
X-Gm-Message-State: ACrzQf1Iz1NAQksPUSEpjYW5S5UVOwd2HkM2IdipSVlvNfk3aFjMYXno
        88OnlxRZGGcrVdcQyyoXrb9Kd6a4PwSpnQ==
X-Google-Smtp-Source: AMsMyM7O7Lys8K0BTqTGgbCE4B9w2MsORFINiDoYFvXvi3tnqCV2AyaIyz3AApT5OWDfdXlcoJUaQg==
X-Received: by 2002:a17:902:e782:b0:179:da9d:6b8 with SMTP id cp2-20020a170902e78200b00179da9d06b8mr1567431plb.50.1664427746251;
        Wed, 28 Sep 2022 22:02:26 -0700 (PDT)
Received: from skynet-linux.local ([2a09:bac0:579::681d:4237])
        by smtp.googlemail.com with ESMTPSA id rm13-20020a17090b3ecd00b0020263b7177csm1895962pjb.3.2022.09.28.22.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:02:25 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v5 0/5] remoteproc: qcom: Add support for pronto-v3
Date:   Thu, 29 Sep 2022 10:32:04 +0530
Message-Id: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
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

Changes since v4:
 * Addressed comments to YAML conversion patch
 * Added patch to fix docs for MSM8974

Sireesh Kodali (4):
  dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
  dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
  dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
  dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required

Vladimir Lypak (1):
  remoteproc: qcom: qcom_wcnss: Add support for pronto-v3

 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 -----------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 294 ++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.c               |  13 +
 3 files changed, 307 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

-- 
2.37.3

