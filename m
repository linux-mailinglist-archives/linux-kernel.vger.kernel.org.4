Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA67F6AE073
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCGN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCGN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:26:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9AE2CC7C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:26:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i9so17042125lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678195592;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFuhdxRZqxntf03G7GBi6ymU4cHeEwSXZBCpFsOBaXY=;
        b=jeIl37blmscy+w3H0lLiPWTZQf3s40FZIBL3LpRRNBVE5fGbK5euavljoHUFPR+pje
         NCbftUTj62+dljluBmcXkR5HT3hfnOilVRF51yR5S0QyUznn97pI6hk5N5fHOZWTNLb5
         BfEqsR2CN804vfCfkbIYuJZNR7wX3iIQZwUQXM210Z+rOL/O7rziIQRDp8yL1gYd+vhV
         8dUe6tHKFUrtCsFBipkfIyQiYE+USnca7OshW93Mi8AcdbBRdygVoZt7xfAG//Bx8hyF
         UjShPA6Dj1vaTzBY2fguSDkAZJh42aI5Vb0PKl5btUfjbFVrdx8/nU8Pc6BpLuGiKeOv
         3wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195592;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFuhdxRZqxntf03G7GBi6ymU4cHeEwSXZBCpFsOBaXY=;
        b=iUOHWP4KDf5NzsYOH/aawzbShxSh0MUYm+cIpeIRBjoxFfhr1R+Xmk3ET3WunAAvSk
         +Zr3lVCU3q+JXMnY6FRMCFS+xBhgAgQT1WsVby5/bDxjkAaIC37UIRt91uaqutUByJbz
         61k/q4uKI+pWA91+1FEoX9CmURKt1SE3415FdrTKXnnwWAP+CnPlMO9XA3QIuhpooGR/
         IwwHKtlUSm+nBPRVDP9s/bu1M+v9ppROfjoSoLy2bbIGCeJyuAjHCHDK4OLE8Qn0G5lE
         JbS35WySi4Hm5b4EorYbda+LBj0yxOJLha8BSLtVFDo7yOwGDTpzuBKvg1milIgeQktU
         A7OQ==
X-Gm-Message-State: AO0yUKWAT3k1iQmlZnNDIudxIKyFaJ5AnhWvkvWrTVBSHUfbQEN9l+tK
        839cDnhoTHwA3MA9htjXwLCTXg==
X-Google-Smtp-Source: AK7set8tmY7vKjxKfz6zQyZXwzBisyPjVYH6n9iEwgWOzr/6TLDpmg27jJ9klI2k3619c2pitb7fEw==
X-Received: by 2002:ac2:41cd:0:b0:4e7:b481:c1c3 with SMTP id d13-20020ac241cd000000b004e7b481c1c3mr3835315lfi.20.1678195592391;
        Tue, 07 Mar 2023 05:26:32 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id m22-20020ac24256000000b004dc53353d15sm2016169lfl.281.2023.03.07.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:26:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] Add support for Lenovo NT36523W BOE panel
Date:   Tue, 07 Mar 2023 14:26:26 +0100
Message-Id: <20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAII7B2QC/32NQQqDMBAAv1Jy7pYkisae+o/iIcZVF0JWEhtax
 L839QE9zsAwu0gYCZO4X3YRMVMiDgX09SLcYsOMQGNhoaWupFYtbLySA4+BM8NqA3qojWuqwdR
 YTUaUcLAJYYg2uKWk4eV9kWvEid7n6dkXXihtHD/nOKuf/fvICiR0Y4uoGqml6R6ego184ziL/
 jiOLzgpJO3KAAAA
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678195591; l=935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Xizse9HQBQyUXnhHIbTDRPuSjgZjafVi6/Q+AwWMPvM=;
 b=vqCvzIGBB5yGa87e65YKpVVOpo2OJcPk23ZHaxw5ZPy2RgAQ36Pp8ynPdtbLmd1oHdHRn/x4CHPI
 RBhjbC7JBRDVnZDPr1C+KjTaWli42sfFhB3L26p4coRWqKwQ/ZmY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Use _large functions for BE backlight data
- Pick up tags

v1: https://lore.kernel.org/r/20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org

Add driver and bindings for the NT+BOE display panel found on Lenovo
Tab P11 devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: display/panel: Add Lenovo NT36523W BOE panel
      gpu/drm/panel: Add Lenovo NT36523W BOE panel

 .../display/panel/lenovo,nt36523w-boe-j606.yaml    |  60 ++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c  | 747 +++++++++++++++++++++
 4 files changed, 820 insertions(+)
---
base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
change-id: 20230217-topic-lenovo-panel-48c63b84e3f8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

