Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7221618C73
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKCXFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiKCXFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398621812;
        Thu,  3 Nov 2022 16:05:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 7so1831768ilg.11;
        Thu, 03 Nov 2022 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+RvqpG9zfUA2c8hwhB/7wUaM09GTn7GvC/dPddFhGY=;
        b=Hnb1u5u++JZQarGtOFw2aD9XsD74zXfHdnJEJkllhJr1RmuIeDm54kvjOFo9pkASEU
         PLPJCbfxZmfVuG45XUOaOybJQrL64z5DosIF/cg1rXRg2+ARVixguNR5mQ21bFRt5mmr
         rIgxEm34cENKe8NZ7bNLPMog498jgD+dQRq3pxsBFqZVij4n5vG/kzqq9UPRyTQ/4ly+
         Eft86R59cNQVCwskaTXpkvcpJM8EwL2n6LisZtkwp7lfYmg4+QfVuxn0EM8pjPcmkiPK
         mGE8JtLmY5kkQv1VQIKtqGTEGL95OF6SBcXnQSGRTjlR/GxPcI8+adtvjkb4mrujqIF2
         4tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+RvqpG9zfUA2c8hwhB/7wUaM09GTn7GvC/dPddFhGY=;
        b=2KSrAeHh+AHL9xH3W59iu6VVtrAUFCC7bL/YO1GGzC/775ss0xiCiSB93wqLuhfejh
         t0RxNWVz2v6rZICdE6J3HSgrCXajTeFjLgpJnE2KotK3HmDmvXg3Hph+qGSb2ytuFl+s
         tHfnGVYo9Dqpr9yUsfX/Jbl5kfkyIWjjsKHcayswTsxnzSc49SVCbKQK6KlCnH9uVyFb
         BoVMt+9kh5u5UC4gdxC+mgjPf0CX+LGLzuup/S9l95vA19FTi/wjEOf4rBbsdk3p6rqp
         cJWlozoa3qHJXBiokzjitJ8kPOknImOAkWzC3+ZnPd8VSeBYKa+GYkHeHdIMG/Sx8IDA
         ygmw==
X-Gm-Message-State: ACrzQf2zOFb+YGubDG6u6Y2n5lNmPjS7AfKRlSJ7e5fyeUWvfibjIp3P
        GZYzZ7v2iGx386McjYuRN9c=
X-Google-Smtp-Source: AMsMyM6/I6rgKRPKzB98dviP8EI0Pb3JHR4TqFiCS1M9nMT+jXF3OjAbL+nQxWbyw1oY6gJisI5grA==
X-Received: by 2002:a05:6e02:1a46:b0:300:e668:e8dc with SMTP id u6-20020a056e021a4600b00300e668e8dcmr1858419ilv.19.1667516717796;
        Thu, 03 Nov 2022 16:05:17 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id n26-20020a02715a000000b003757ab96c08sm643552jaf.67.2022.11.03.16.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:17 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/4] Initial SDM670 and Pixel 3a support
Date:   Thu,  3 Nov 2022 19:03:47 -0400
Message-Id: <20221103230349.212861-1-mailingradian@gmail.com>
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

Changes since v1:
 - remove i2c interconnects (4/4)
 - change regulator phandle names (4/4)
 - change regulators node names (4/4)
 - remove clock-output-names from xo-board (4/4)
 - remove vdd-supply from touchscreen (4/4)
 - move clocks to device dts (4/4)
 - reorder pmic nodes, root nodes, and phandle references in dts (4/4)
 - move status properties to bottom of nodes (4/4)
 - accumulate commit message tags (1-3/4)

Do not apply this series yet. It is only for review comments. It can be
applied once the "qcom,sdm670-smmu-500" compatible string gets added (or
now if you don't care about handling an unnecessary quirk).

This adds the device trees and bindings to support the Qualcomm
Snapdragon 670 and Google Pixel 3a. This patch series, specifically the
last patch, depends on:

[PATCH v4 0/3] SDM670 Global Clocks
  https://lore.kernel.org/all/20220914013922.198778-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] RPMh Support for PM660 and PM660L
  https://lore.kernel.org/all/20220920223331.150635-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 RPMh Clocks
  https://lore.kernel.org/all/20220920223734.151135-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 USB 2.0 support
  https://lore.kernel.org/all/20220922024656.178529-1-mailingradian@gmail.com/T/
[PATCH 0/2] SDM670 SDHCI support
  https://lore.kernel.org/all/20220923014322.33620-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 Power Domains
  https://lore.kernel.org/all/20221004221130.14076-1-mailingradian@gmail.com/T/
[PATCH v10 0/3] SDM670 Pin Control Driver
  https://lore.kernel.org/all/20221014001934.4995-1-mailingradian@gmail.com/T/
[PATCH v6 0/4] SDM670 GPI DMA support
  https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/T/
[RFC PATCH 0/9] iommy/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
  https://lore.kernel.org/linux-iommu/73eee2ed-f8ee-f136-2853-34b27c099644@quicinc.com/T/

Richard Acayan (4):
  dt-bindings: arm: cpus: add qcom kryo 360 compatible
  dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
  dt-bindings: firmware: scm: add sdm670 compatible
  arm64: dts: qcom: add sdm670 and pixel 3a device trees

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sdm670-google-sargo.dts     |  532 ++++++++
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1169 +++++++++++++++++
 6 files changed, 1710 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi

P.S.: Thank you to all the maintainers and reviewers who went through
everything and made helpful comments!
-- 
2.38.1

