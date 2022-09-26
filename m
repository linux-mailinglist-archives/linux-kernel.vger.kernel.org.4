Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0331E5EA618
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiIZM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiIZM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:28:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D4111E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:08:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so9671624wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sduujl6DN3SaLa2Y/Z6Vcki+0Q9QqbCZHpdlm19R0rM=;
        b=HClTHAMIFLCVpN//cX5WfolUCp9f5W8XmUg56K+JFJnIwNX/lYJWCoQ5LILmvgomLh
         C4CjPZopxlEoI5Um32N8WfnhzJaFu673dK75xzxf9azpwx9iDHPeacw3NEm2wgSd4j0X
         eTYDF1Getx1o+K3IyfbEKGjnAwRM/Tm8RaE8DfnFDbcn/b7SzcyqB8OE0xHUXJcHFI6F
         rg8uUU6GetaJBaEOO7MAhmiSzkNpKxVFBaRfNLnPEH+VSsQIFKSmoIJshVz3nN5vEUpk
         60FHyAT4TrNTEbL3gTn3T0zvUNuVJYzpw4FsxDbZJbaGibyBvm1S/pt02rMwHYkmIc4/
         7pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sduujl6DN3SaLa2Y/Z6Vcki+0Q9QqbCZHpdlm19R0rM=;
        b=QuVmR3ZNMMk8bBgcBSyzQ49l2hxutzYMWaHpy/zes3w/uUyDdVpG5a1LnEpvBLocMu
         jSvre+eNwjNQi7vAVtyQPmxnvmuvSD4arL9QXEbMqCOV/K8imuswCNA64Cl154tQgC/X
         ohDUkk1bTYu3iW+ojn93Ee0Gbv+rYAzSkRAhjc4UemjQQ6rAzFrZZ0/WHnBSu6VMKIBN
         3YQsdaciB6m57weoN2mRiG6JxECByXeYaxukHb0vyOO3DWAfK3H5Sb/rU8KN78HQcxir
         vYEQTchs3qOS82CaOUQzx31SpF+qb8W19f3Pfs5dsS+IVKmDVXG8ATrLtr6B0USF3T3Y
         yliw==
X-Gm-Message-State: ACrzQf3bwzBqEavE233LmUoTTO2QUVoeh2GM9t/MpBGmXRdpPrdpm+WQ
        ebiIX5BPj57OgNp97HbtueHrBhEorwHHXw==
X-Google-Smtp-Source: AMsMyM4b3s9UOlbwdHOcusBcEnFj1C2J/V/PMZte/5G+lp2fXQHMBGTCPDUbre0H5aFETqL4hgiYgQ==
X-Received: by 2002:a19:651e:0:b0:497:aaa5:44c with SMTP id z30-20020a19651e000000b00497aaa5044cmr8211896lfb.280.1664189432064;
        Mon, 26 Sep 2022 03:50:32 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o4-20020a198c04000000b0049f54a976efsm2492936lfd.29.2022.09.26.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:50:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: Second round for v6.1
Date:   Mon, 26 Sep 2022 12:50:23 +0200
Message-Id: <20220926105023.119781-1-krzysztof.kozlowski@linaro.org>
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

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 9f8fb8032febf594914999c33493c682eaf138cb:

  dt-bindings: memory: mediatek,smi: Update condition for mt8195 smi node (2022-08-16 12:21:14 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.1-2

for you to fetch changes up to 5514acb0dd030356e628cdd88b266efaa0a22315:

  dt-bindings: memory: snps,dw-umctl2-ddrc: Extend schema with IRQs/resets/clocks props (2022-09-21 20:34:58 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.1, part 2

Improvements in Synopsys DesignWare Universal Multi-Protocol Memory
Controller Devicetree bindings.  The bindings are being split into
one related to Synopsys core and into quite different derivative Zynq
A05 DDR Memory Controller.  Extend the Synopsys bindings with additional
properties to match upcoming new device support (Baikal-T1 support).

----------------------------------------------------------------
Serge Semin (4):
      dt-bindings: memory: synopsys,ddrc-ecc: Detach Zynq DDRC controller support
      dt-bindings: memory: snps,dw-umctl2-ddrc: Use more descriptive device name
      dt-bindings: memory: snps,dw-umctl2-ddrc: Replace opencoded numbers with macros
      dt-bindings: memory: snps,dw-umctl2-ddrc: Extend schema with IRQs/resets/clocks props

 .../memory-controllers/snps,dw-umctl2-ddrc.yaml    | 118 +++++++++++++++++++++
 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  76 -------------
 .../memory-controllers/xlnx,zynq-ddrc-a05.yaml     |  38 +++++++
 MAINTAINERS                                        |   2 +
 4 files changed, 158 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
