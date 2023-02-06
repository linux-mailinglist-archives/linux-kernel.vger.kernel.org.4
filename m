Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB568BE84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFNoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E610FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so3230536wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAX/rHtOXsS5+ehflAraxCcsyOFCMSB+AwuT3O9IHkM=;
        b=zqs/zYlbWsfhfjvHd3Vom9/5Mqr6cstBcLiJXZl0Fo8llsj4nkZSiRyMaevqErln6u
         UEL5X33f0Hq1aads3hyGlc08KmC+UZSJA0CV/tUdk49RLSGU65gWEXF2uIt5U6WzL05i
         z+v9cF7kzum7x+hcWtC/L/Ji9Mzctz92cEUlpYZSq5CNCRzY9O5ap1ekOX8RHpxTAUn4
         x1Dx0QQU38BX5CAG1UmgYFqK99DyMRlrB6KIzW423+QfpA+banjAB+Qdlhq+JkW4eulg
         cLX2vQyPv0aTHVUeWMPOGiS9zwYxb4DHONRzau+65G4nC8xLsegxMqA30TvZiVRhvgfi
         sGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAX/rHtOXsS5+ehflAraxCcsyOFCMSB+AwuT3O9IHkM=;
        b=XQobbyVJF+N7FUgk1Po86cxqkkwmqzoXRQKF0wZ4oPHkMR5LtrXwgwm/bCzJg9i6Ww
         JorPEkTNHpxuB9gmqGdTyQlek3DQ493yiwBIqJLUSM4M4ClnRFSbqYNx1MSQz6cEtJfe
         Q6wSSj7IMVBFPg/9b/4c437s4y5ckCBFuSft1cTLtNvLXyqtn5ciNWOyMOTIasPwk5tn
         GHGJao9JaCg/TvmFDftQUNfbwmw9PMYHTOMFy0pCK6p3zntjMXRuXTAgDOURJ+kpuoI0
         ZF9/72dzsifzAjqYKLNPvvnsPoVyAKtyyglJVDbTHC8R+6SYhST1cCMvrr+uEd1AZP6Z
         MVqQ==
X-Gm-Message-State: AO0yUKWSPhGe6Mh7jBupY3+YusK/vP1by0m3kj2J/AJ8WBRGpbcTDjOG
        O59LsO2bJLuG4lV/71WSe0UH/spqgYDPbyec
X-Google-Smtp-Source: AK7set8RS9VKI2V1upvtcdC6ZovlW+lcvsoGVx/QjteJl48qfSaCHIlNXU+cnqESJebijblxkd8rww==
X-Received: by 2002:a5d:64e6:0:b0:2bf:ba69:71ef with SMTP id g6-20020a5d64e6000000b002bfba6971efmr20106100wri.1.1675691042299;
        Mon, 06 Feb 2023 05:44:02 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/22] nvmem: patches for 6.3
Date:   Mon,  6 Feb 2023 13:43:34 +0000
Message-Id: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi Greg,

Here are some nvmem patches bit more than usual for 6.3 which includes

- Add support to stm32 STM32MP15x OPTEE based nvmem provider
- Updated to qfprom bindings to include various Qualcomm SoCs.
- adding sl28vpd provider layout
- new helper eth_addr_add().
- few minor enhancements to core and providers drivers.

Can you please queue them up for 6.3.

changes since v1:
 - rebased top of char-misc-next as dependency on few fixes in rc7.
 - removed fixes tags as the commit ids are untracable.
 - dropped layout patches for now.

thanks for you help,
srini

AngeloGioacchino Del Regno (1):
  dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering

Arnd Bergmann (1):
  nvmem: stm32: fix OPTEE dependency

Johan Hovold (1):
  nvmem: qcom-spmi-sdam: register at device init time

Konrad Dybcio (2):
  dt-bindings: nvmem: Add compatible for SM8150
  dt-bindings: nvmem: Add compatible for SM8250

Marijn Suijten (1):
  dt-bindings: nvmem: Add compatible for MSM8976

Michael Walle (9):
  net: add helper eth_addr_add()
  of: base: add of_parse_phandle_with_optional_args()
  of: property: make #.*-cells optional for simple props
  of: property: add #nvmem-cell-cells property
  nvmem: core: add an index parameter to the cell
  nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
  nvmem: core: drop the removal of the cells in nvmem_add_cells()
  nvmem: core: add nvmem_add_one_cell()
  nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()

Patrick Delaunay (2):
  nvmem: stm32: add OP-TEE support for STM32MP13x
  nvmem: stm32: detect bsec pta presence for STM32MP15x

Randy Dunlap (1):
  nvmem: rave-sp-eeprm: fix kernel-doc bad line warning

Richard Acayan (1):
  dt-bindings: nvmem: qfprom: add sdm670 compatible

Robert Marko (1):
  dt-bindings: nvmem: qfprom: add IPQ8074 compatible

Russell King (Oracle) (1):
  nvmem: core: remove spurious white space

Samuel Holland (1):
  nvmem: sunxi_sid: Drop the workaround on A64

 .../bindings/nvmem/qcom,qfprom.yaml           |   7 +-
 drivers/nvmem/Kconfig                         |  10 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/core.c                          | 145 ++++-----
 drivers/nvmem/imx-ocotp.c                     |   4 +-
 drivers/nvmem/qcom-spmi-sdam.c                |  13 +-
 drivers/nvmem/rave-sp-eeprom.c                |   2 +-
 drivers/nvmem/stm32-bsec-optee-ta.c           | 298 ++++++++++++++++++
 drivers/nvmem/stm32-bsec-optee-ta.h           |  80 +++++
 drivers/nvmem/stm32-romem.c                   |  84 ++++-
 drivers/nvmem/sunxi_sid.c                     |   8 +-
 drivers/of/property.c                         |   6 +-
 include/linux/etherdevice.h                   |  14 +
 include/linux/nvmem-consumer.h                |  10 +-
 include/linux/nvmem-provider.h                |  31 +-
 include/linux/of.h                            |  25 ++
 16 files changed, 626 insertions(+), 112 deletions(-)
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h

-- 
2.25.1

