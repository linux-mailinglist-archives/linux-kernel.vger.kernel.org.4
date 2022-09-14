Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C905B8A44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiINOXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiINOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:23:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E94DF33;
        Wed, 14 Sep 2022 07:23:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f20so18026186edf.6;
        Wed, 14 Sep 2022 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=YPvsRlxDXDggxUZEYNyLFWt8bhYF3sK51JF3gp5tKs4=;
        b=DfG79Bxo9Mk220BFJ9GudyUmnYtx9ujPjDfk4CPL+eXGyLToURmJygHbRPzzhoDNR3
         8LomaJpMLDvQJRGUR3oDoqNcci+/AgMCErdSECbIyUc+5VY9lV31R1bIKwnPsSJQQjfy
         EnkuRZ+d5tje59EU/+Dg7e8FvcQLpY6Ae8qx0h5HwiVboV78l+QvJ4sb/h8gW1U5MH64
         WPAqSvS+wU1ajlVNrxyrDUAsIfAzxV/9ePZREFKfeVlUAL6faXvGzJfWu2ZBuLv2r//G
         VSp+IbwiAocSKQUVXQpN13LMvcYDpbTo+h5HvJ7R6wil/AnRgUWdE3CUHoTJR5/1oc/m
         iOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=YPvsRlxDXDggxUZEYNyLFWt8bhYF3sK51JF3gp5tKs4=;
        b=3C+A5yvQ235m+ws5TS0NlZGjEAi7alTKY18Uvie0p1Pp6NW/4n0OVhtP9BaFhjl+TR
         luo0l57qeEeeCg4L7gJzk4pe9YP6YVXFwaUfTF6wXkpi2YTw3R//7nb1mIMkjSd9m6Ak
         ZtnpFF3DCGVQ6JRogwUaMBPr3jKjj5y+Z/ngsQmlbcZXvzHJYjDIfjoL0uqD1wxbXt7l
         g8ffp5yNUtRBnN02thsVOJZBic0j73+s+W+maitlpY7S3yphP78iSDU5UJngFe2pW8AH
         AbVCf9GqUBFdTlMxRyCI5BQa8nQRh7WJzmLuPET7zNsBaSjjDyVKNcMICTZw3PKRz++8
         aApw==
X-Gm-Message-State: ACgBeo3WY2i6ucCEvEitgDYliMhML4Y8er1g2jMRN6T/8XuMytPPJjvl
        8F65Luu8E6eHGudlzBMoGBs=
X-Google-Smtp-Source: AA6agR6Adtbwg0XngCJQUdCrR1RyjdAlF3r7kqv3d0tBhYlFZhnOKN2HDiBoeS7c7nURjfuAdXlX9Q==
X-Received: by 2002:a05:6402:ca9:b0:44e:d8f3:3d0e with SMTP id cn9-20020a0564020ca900b0044ed8f33d0emr30442006edb.397.1663165391456;
        Wed, 14 Sep 2022 07:23:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id 9-20020a170906310900b00779cde476e4sm7614773ejx.62.2022.09.14.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:23:10 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 0/5] Krait Documentation conversion
Date:   Wed, 14 Sep 2022 16:22:51 +0200
Message-Id: <20220914142256.28775-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert the krait-cc and the kpps-acc/gcc Documentation to
yaml.

This series comes form a split of a bigger series that got too big and
now hard to review.

While they are still more or less wrong and doesn't really reflect real
driver implementation, they are converted to prepare for a fixup later
when dts and driver are finally fixed.

Minor changes are done to the kpss-gcc driver and minor fixes are done to
the various affected dts to fix dtbs_check warning with the new introduced
schema.

Also fix kpss-acc dtbs_check warning.

v5:
- rebase on top of linux-next/master
v4:
- Fix error from kpss-acc schema
- Fix dtbs_check warning from kpss-acc
- Improve kpss-gcc for apq8064
v3:
- Update all Sob
- Rework kpss-gcc Documentation with the new finding
- Fix dtbs_check warning
v2:
- Fix bot error by adding missing #clock-cells

Changelog for previous series "Modernize rest of the krait drivers"
that was split to smaller series (only Documentation changes):
v7:
- Rework kpss-gcc Documentation (split patch for pure conversion and
  tweaks)
v6:
- Address comments from Rob
- Fix warning from make dtbs_check
v5:
- Address comments from Krzysztof
v4:
- Fix more dt-bindings bug errors
v3:
- Split Documentation files for kpss and krait-cc
v2:
- fix missing new line on patch 16 (krait-cc patch)

Christian Marangi (5):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
  ARM: dts: qcom: fix various wrong definition for kpss-gcc node
  ARM: dts: qcom: fix various wrong definition for kpss-acc

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 ++++++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 ++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 21 ++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi           | 15 ++-
 11 files changed, 287 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.37.2

