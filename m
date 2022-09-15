Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B015BA00C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIOQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIOQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:53:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A247F2;
        Thu, 15 Sep 2022 09:53:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f13so1083259wrs.1;
        Thu, 15 Sep 2022 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PIWtgxuSs51lP7vh2pS8wxo/qh0gqoJnq9qHR7w5Fmw=;
        b=HvdZ6MZPBtYSs+QuLllWAWuPKuLL90yIZ9heG9+l+xHjR6avKGrZU0GeLsfWXR8fpk
         o1NAfMc+LuzeFBX/CcP6ALn7dPt3jnzpXp/qJXKm+i0chQKpbhlJOVuwJVxZ0YpkQKvu
         g8ABK1kj3NCRocW4u7gqdGZEP5XUG1y697WAN8JjVLbQlyO7qFvMICe1qT816wRhCy4u
         VAxu4i3taaYjs7G4E3VYYvOi68+vDqFvd4QC7psAyXVwcYp/tsYcuNmsLi8WOwzPk1la
         HFc/dYmEdO+7Sf8wiuVWIhTHdnmLt1ai0FFeOoowLrP7p2LVvuj+jdVNSEGULduSkn8u
         WA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PIWtgxuSs51lP7vh2pS8wxo/qh0gqoJnq9qHR7w5Fmw=;
        b=Z2uF9j5hhazMxtm1MqGBR1kEloeIutBiT03cHoYgEERRN2iu/YFllrNzddia285kEt
         fAnMlus3CwN8r7jB7+eByF8BVSdTWZTJ/yg51jDEb0VJulzJlGJiwDMhZcpqNXiJM1x0
         HWYqfkObNXKM5KqnLixt8opWTkECNYfnov2TgJiG3bPzcO1n76jS3uqlib0ELKGAcwx6
         XFJ+VoACzKosRUm0Z2tJ0P2xHij3Ejl83I2nWlPJu1PPjK1y0h40ATls0D1fofs59MwJ
         OPB3+PyFarr1/ULV5N6kC4y4Lw5nEKQHg/p5FlK8OSGbVcuotDRfBaa3CmcC73BFobc7
         jtuQ==
X-Gm-Message-State: ACrzQf14QTZQt4Pdi6NJmwaCrh90x5uhaJ2OQj5+oDfs63iVzFqq2IJv
        eYZDS79actfChoFA5qpfY8E=
X-Google-Smtp-Source: AMsMyM7Smj7XkDPI8KNdZUmcFF2mr+Wlq3K8Hre7PSGckGoUiwuBMBOS5l8rA+wSS4yk6s4yhCAV1A==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr392171wrv.413.1663260817874;
        Thu, 15 Sep 2022 09:53:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc6e:cfa1:9281:3490])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003b332a7bf15sm3562129wmq.7.2022.09.15.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:53:36 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] RZ/G2UL SMARC EVK trivial changes
Date:   Thu, 15 Sep 2022 17:52:54 +0100
Message-Id: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series includes changes to RZ/G2UL SMARC SoM and carrier board
DTS/I so that it can be re-used by RZ/Five SMARC EVK. It does not have any
functional changes.

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
  arm64: dts: renesas: rzg2ul-smarc: Add /omit-if-no-ref/ to pinmux

 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts  | 12 ++++++++++++
 .../boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi  | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi   |  7 +++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi       | 11 -----------
 4 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.25.1

