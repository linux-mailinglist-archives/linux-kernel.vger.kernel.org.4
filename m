Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255068BA14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBFK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjBFK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795E1165A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8349452wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvutuKeu2H4cv34uOuj2hj/8VX5yjWTN04wjG14oa1s=;
        b=BvocsrdD3vmRP8gRQxuIYsTlFgrSPLvF7KrpzSJJ1pvcWO5fW/zoQNW2903ITjRqa1
         FtJeZffe8JWJdts9Y1H0mRHB79ka7LCxnwCwsTzswV2Uep8vZ/GZJ/POV9M1hYrEX/kU
         xbLAWwIOw5hfkxa8BmLZeljfI35s3kWlzeiNYJi6tNoRXSg5wzgYppPl/zO8LXpjoZLO
         ciL6UlcnmiL96ywJajV50z5kESfY6EbgtCJvCcbKIMX2eIn4ZQjiEPsb2K6nVQQyCidp
         YytLSE3wc67S1Ls73ia8zCHwAFc+EeJ4JEywngkYigy7DE7wzD1fepaMyqoWsVbrnK9I
         Cufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvutuKeu2H4cv34uOuj2hj/8VX5yjWTN04wjG14oa1s=;
        b=kFMvtvgHWHVYe88tTqe3Sp4EwiA/420fIYgnvgD6XW65MZwGHB+ImcMjt7Z7PfSjSP
         6uHbx/6+ad10a/wyJ8dRiYO20Q/08A6Sx7+zOBAQRnt13iHOFUunGmsoRqqJ/aLHi2gm
         M1F/Nckx4eTJlwsZn7tKtNtGejnlNf4Ig2I/C128jY2kKVlbNzQFfiqiqmkCG6daBJL0
         0Y8Tx/3s/Dv9sXylwUvHcdALX7YEUbLTuB4zqlLK/whtQ8vr2z0PQ/SulLiFrEHRVFWP
         BIF9qQkYW1n7q4ENzPQPBPSSmw8ozvgy9DLSucoapFqeAasr/b1TzyP5jwgvYIU1Fwnf
         rn4Q==
X-Gm-Message-State: AO0yUKWq/f6ZoOUeJ2NQNvMEeukQaDXxukfsE8/5sw+Ph1f7yiMhN7Vl
        VLs+jsmLQG72NMKQ8zyJkyTRktjWAD2jcOP7
X-Google-Smtp-Source: AK7set+UbsBZwoNF4P20cg7dt8odsLJtj5L7ZrkESLFO10PDDdCtKvVyPLE9V+3gasfKFYJ6Owlx3Q==
X-Received: by 2002:a05:600c:288:b0:3dc:1054:3acd with SMTP id 8-20020a05600c028800b003dc10543acdmr18257441wmk.17.1675679293664;
        Mon, 06 Feb 2023 02:28:13 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 00/37] nvmem: patches for 6.3
Date:   Mon,  6 Feb 2023 10:27:22 +0000
Message-Id: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

- Adding support for nvmem layouts, thanks to Michael and Miquel for
  driving this effort.
- Add support to stm32 STM32MP15x OPTEE based nvmem provider
- Updated to qfprom bindings to include various Qualcomm SoCs.
- adding sl28vpd provider layout
- move imx provider to use new layout apis
- add ONIE provider layout. 
- new helper eth_addr_add().
- few minor enhancements to core and providersdrivers.

Can you please queue them up for 6.3.

Reason for resend:
 - rebased top of char-misc-next as dependency on few fixes in rc7.
 - fixed fixes tags.

thanks for you help,
srini


AngeloGioacchino Del Regno (1):
  dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering

Arnd Bergmann (1):
  nvmem: stm32: fix OPTEE dependency

Colin Ian King (2):
  nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
  dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"

Johan Hovold (1):
  nvmem: qcom-spmi-sdam: register at device init time

Konrad Dybcio (2):
  dt-bindings: nvmem: Add compatible for SM8150
  dt-bindings: nvmem: Add compatible for SM8250

Marijn Suijten (1):
  dt-bindings: nvmem: Add compatible for MSM8976

Michael Walle (19):
  net: add helper eth_addr_add()
  of: base: add of_parse_phandle_with_optional_args()
  of: property: make #.*-cells optional for simple props
  of: property: add #nvmem-cell-cells property
  nvmem: core: add an index parameter to the cell
  nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
  nvmem: core: drop the removal of the cells in nvmem_add_cells()
  nvmem: core: add nvmem_add_one_cell()
  nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: provide own priv pointer in post process callback
  nvmem: layouts: add sl28vpd layout
  MAINTAINERS: add myself as sl28vpd nvmem layout driver
  nvmem: core: return -ENOENT if nvmem cell is not found
  of: property: fix #nvmem-cell-cells parsing

Miquel Raynal (2):
  nvmem: layouts: Add ONIE tlv layout driver
  MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer

Patrick Delaunay (2):
  nvmem: stm32: add OP-TEE support for STM32MP13x
  nvmem: stm32: detect bsec pta presence for STM32MP15x

Rafał Miłecki (1):
  nvmem: core: fix nvmem_layout_get_match_data()

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

 .../nvmem/layouts/onie,tlv-layout.yaml        |   2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |   7 +-
 Documentation/driver-api/nvmem.rst            |  15 +
 MAINTAINERS                                   |  12 +
 drivers/nvmem/Kconfig                         |  14 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          | 283 ++++++++++++-----
 drivers/nvmem/imx-ocotp.c                     |  34 +-
 drivers/nvmem/layouts/Kconfig                 |  23 ++
 drivers/nvmem/layouts/Makefile                |   7 +
 drivers/nvmem/layouts/onie-tlv.c              | 244 ++++++++++++++
 drivers/nvmem/layouts/sl28vpd.c               | 153 +++++++++
 drivers/nvmem/qcom-spmi-sdam.c                |  13 +-
 drivers/nvmem/rave-sp-eeprom.c                |   2 +-
 drivers/nvmem/stm32-bsec-optee-ta.c           | 298 ++++++++++++++++++
 drivers/nvmem/stm32-bsec-optee-ta.h           |  80 +++++
 drivers/nvmem/stm32-romem.c                   |  84 ++++-
 drivers/nvmem/sunxi_sid.c                     |   8 +-
 drivers/of/property.c                         |   6 +-
 include/linux/etherdevice.h                   |  14 +
 include/linux/nvmem-consumer.h                |  17 +-
 include/linux/nvmem-provider.h                |  95 +++++-
 include/linux/of.h                            |  25 ++
 23 files changed, 1310 insertions(+), 128 deletions(-)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h

-- 
2.25.1

