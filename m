Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B4699B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBPRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBPRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:54:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C01233E1;
        Thu, 16 Feb 2023 09:54:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id z13so2175938wmp.2;
        Thu, 16 Feb 2023 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRSURI/V2oyh1+/lXCmSSf5hGU04tceoQ6lHc66Onvc=;
        b=ZVSA1PDnW/GVVqITC3q+aFLyrMGhZoPp1SwIbMDEQM5zrLrt+lc4a3oZgSvfgrSVMn
         WG17GgMHv+7WOgbBRtNCLRxvFktcTNp9KKB47X+9AfXRhhsJLdBOyvBhD3Cf4DB+V5Xk
         fR44y3yEbcd3paSwU92+xI+Fto/8ja3DBzSug7P9SFZOmJAflPWln7mTrmtbn9bJYSSv
         mB+UA2WULHXC5UTbsKLgCdB2qfDnlJM0dMEd8dscaP8DPDCfjrY6XOdYSePMP8hwEcu5
         jBmapzDhMZgD0AyT8KQhybSFSv+YDrylZrXv1IRWBqLh1//3IGEKH3GXjkW6YsPuUjm+
         sJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRSURI/V2oyh1+/lXCmSSf5hGU04tceoQ6lHc66Onvc=;
        b=iaZnG3ZouXLoFawd1ksT0Lb8L+uqlx49ZUSiZyxz81Uu5ttVv3whXiddN/n7dhmpk2
         wqPY37cHlLhszvcMQeYaP++UClPuRsjMoDNk9yxNR6k+bSIZLwp7KpIRhoQeRpTLdU+D
         FBXHNDWzutiQmzkFijPLdMZ9xCKGZ0Fz69T2puZtXUyJfhgzQuYBN2JhNKuwQ9ExSjRU
         wpVIwSZi6hzZB5OyDDbQIopCY51H5EngEx+/ttOFLpE8y1wgJygAAow6C3E1uAHdP86z
         pDepNLbzK/jty0PrS1Ce0Hx2z1bT29vlVY3dNJcIfPNbgcutvi+HpTQx0V0pgFH3n/cc
         Q2mg==
X-Gm-Message-State: AO0yUKUcSwmr9NtWUw0+daDQS5d8Ycfdgrnc5rU7PEZ/abqxmLdGtkEU
        8OOhGBwRJn85AX4Q/3XK275aOsZd2yc1cA==
X-Google-Smtp-Source: AK7set8bYnAD8/rjwzCkHqTHIF7S89uJjuIWGkWNU0JeWxVil+LGh+t5wtVMB5SPTqVAcvuKPFln3Q==
X-Received: by 2002:a05:600c:1603:b0:3e0:1a9:b1d7 with SMTP id m3-20020a05600c160300b003e001a9b1d7mr5163837wmn.19.1676570041371;
        Thu, 16 Feb 2023 09:54:01 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:31b2:19e1:4409:5c3b])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm5826836wmc.27.2023.02.16.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:54:00 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] RZ/G2L: Add CRU, CSI support
Date:   Thu, 16 Feb 2023 17:53:44 +0000
Message-Id: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series adds support for CRU and CSI support to RZ/G2L SoC
and enables it on the RZ/G2L SMARC EVK. Also ov5645 node is added which
connects to the CSI2 node.

Note, this patch series applies on top of [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
  arm64: dts: renesas: rzg2l-smarc: Enable CRU and CSI nodes

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 79 +++++++++++++++++++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  5 ++
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 76 ++++++++++++++++++
 3 files changed, 160 insertions(+)

-- 
2.25.1

