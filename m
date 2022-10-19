Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44F2604651
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiJSNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiJSNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:06:12 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C21BFB80
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:50:15 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x66so8901973vsb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llwNEBSWfDR2F4LeCd9ZXwYAAh5P7iVgSJnKoSyLXKI=;
        b=YLmP0/KBj9Q2FCXfeclwl/X/y8N/avRXarErHiKhsmHKs8OUzXXtB3/6YI0k/hfDjo
         pObxpRk4EqBvcfMTKQXuNs3albxd4v8jsrF0IX/quotd9+CwAgXT0rtFHD2TeqfFDEhi
         2R+azEJW7z2721AlV1g3cvfsDy+P87TPBMk97Tw5PiH01xnfThwKQHDFHrx2WGiUAxI2
         j+BYN7ilaORt/IHeTSTo5xEwu36ef87s71VFYwjLIQxIg/KZGbh8HTfQd19KleDGhTJS
         ui7cRbRZ3EiA8kaJlmAiRYPjONjwQ/8nMFF3WWl36ONscRtwT8PuoVuHrP3yTFrtBK5T
         qKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llwNEBSWfDR2F4LeCd9ZXwYAAh5P7iVgSJnKoSyLXKI=;
        b=pL3es1lMgWJ0AHiyquscgP+5s0qOx2o/2GVSU9/6IzhL+eYJteOLWKV13BbCTfR6OP
         +NQwIVNMTBpig/FaoEyC7AJVghxKz7e/ffp7DIOcKQE98FR9RlMVcWE6woLK73fF6ONg
         oPNAdzjDO86/UXEyXmrc5EBqNVzUrHbnTxlWRMQ27RTzztcnyMLzkPJrsvMA5PjRIuwF
         NNQAV9J4f8/D1IpJhbyXk34PsF2DqnKwIOW8/pOBYrhblwzgPMDJIirIH7hu/MBA8jzh
         x7R0FZWZTDkS27rRgDHwzHaGN2uIKJMw5eM0iqiBtEA1CjBLsRn6HLzsqYe9IvhsZzPY
         M50g==
X-Gm-Message-State: ACrzQf2sil3uFeVnbAo/MywufP0QXdTN2PCPbIf74ekjVTQ9i062JGSS
        yZR9dFhxBRYUKFV08TKr7HnEDRENO1AZJw==
X-Google-Smtp-Source: AMsMyM62HomAhFnG0yZwJ0nc3YwJPIAXboVv2EvWDhNAclvdiPK4S0zmuUuXsI7d4EkH0rnjg3IKbA==
X-Received: by 2002:a17:903:1105:b0:178:ae31:aad with SMTP id n5-20020a170903110500b00178ae310aadmr8114123plh.3.1666181804916;
        Wed, 19 Oct 2022 05:16:44 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017e93c158d7sm10529824pla.214.2022.10.19.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:16:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 0/4] Add PMEM support for RISC-V
Date:   Wed, 19 Oct 2022 17:46:18 +0530
Message-Id: <20221019121622.179024-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

The Linux NVDIMM PEM drivers require arch support to map and access the
persistent memory device. This series adds RISC-V PMEM support using
recently added Svpbmt and Zicbom support.

First two patches are fixes and remaining two patches add the required
PMEM support for Linux RISC-V.

These patches can also be found in riscv_pmem_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebased on Linux-6.1-rc1
 - Replaced PATCH1 with the patch proposed by Drew

Changes since v1:
 - Fix error reported by test bot
   https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/

Andrew Jones (1):
  RISC-V: Fix compilation without RISCV_ISA_ZICBOM

Anup Patel (3):
  RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig               |  1 +
 arch/riscv/configs/defconfig     |  1 +
 arch/riscv/include/asm/io.h      | 10 ++++++++
 arch/riscv/include/asm/pgtable.h |  2 ++
 arch/riscv/mm/Makefile           |  1 +
 arch/riscv/mm/cacheflush.c       | 41 ++++++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c  | 41 --------------------------------
 arch/riscv/mm/pmem.c             | 21 ++++++++++++++++
 8 files changed, 77 insertions(+), 41 deletions(-)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

