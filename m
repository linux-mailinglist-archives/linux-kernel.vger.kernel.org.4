Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD35FA145
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJJPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJJPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:40:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7B5A8B3;
        Mon, 10 Oct 2022 08:40:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu30so17606548wrb.8;
        Mon, 10 Oct 2022 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=lBLTrivHCVMFl16FnTB7kPPRo9YIcGNvYxKlFQZcjFfZ2VioZbASk1D/rnUdW4Snc2
         Q6ZtkPEE7HgrLIOrbTdxTdCALMFKUt8GJgj2imwMKwInMcrv1lgi1M23RLjGYtLTcLq9
         tLE9bBiDP4c7d0ts+h0BJXFhJhG6PDizyYyRNx6lB4F9viP0L3r6IL1XfQ/Kkf/Ipwxa
         nhTdDBPLtmu4YTvEA/YFiFl7Nb94T2gyS8gPsAMEkMwMeWVP75aRtVIFMLhN0Zh1+N+G
         Gcl23Pp1XNMM/xfoozc52pYXdDwUg/3zv1YTTnZskkB+gQUF6QdW9RLP7TVUslXvepb0
         7Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnL+He7Da96VSkLj6A5rMl8m0utiApVsa5fPZkDJuiw=;
        b=nSbtxkpV4hembAfU0oJV46YuVc2RdlD17P2UqmXff1Lx1lkE3FlgBVF+OjepBQ/Hx8
         6i8WYLkQhuz/OpStfzACQYwnnsc1pi1aat3IjymftLp0QxrelGnKPpJhQSHPUduuTvHt
         Q1yxRbrVNxrhKHdfCaTbRjPIX7uTO8of0ygMFOLi9O2k7d6lBCSWq/KFkOUlDxb0rx1j
         7iByISd9ItYwUUovnFcmgz4NH+k/Fysb709w0+AiC8n68CKIAixsRMNsA926C86Y0/6j
         7i3ryNcMQjqNt8B+WqB2iP40GeCK2szpqTwi6CjJ5fR7lICm8umXOiOLpDBkhHi6jrw5
         2ERg==
X-Gm-Message-State: ACrzQf3V9yu6HJM1UP0V+czyYSiT5Q3qxuipJOxjVqQ3om1TEuCmwgCP
        NdLd9boDgHZcnr37Dc7kMpbhQP7K1yg=
X-Google-Smtp-Source: AMsMyM6etuSoIRWuIrT4SiFjj8W0iyiE6iida6M9XyNRPjSUim+R53kTmbR402WW903l+kySVvN/0A==
X-Received: by 2002:a5d:47aa:0:b0:22e:3ed6:77a8 with SMTP id 10-20020a5d47aa000000b0022e3ed677a8mr11939690wrb.648.1665416443320;
        Mon, 10 Oct 2022 08:40:43 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id b2-20020adff902000000b0022e66749437sm9068321wrr.93.2022.10.10.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:40:42 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v8 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Mon, 10 Oct 2022 18:40:37 +0300
Message-Id: <20221010154039.1144605-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
  arm64: dts: qcom: sagit: add initial device tree for sagit

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 681 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
 4 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

