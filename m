Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596D6614A8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjAHLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 06:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:08:18 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8009AE66;
        Sun,  8 Jan 2023 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8YW1+
        iZwSJpbGONI9vwYy0SnVshkwM7RWh3KdQZfkio=; b=kTNCafXuFdLmh9JC4nXV5
        e8cLrW9TsQ/qWNoLljhR0ynu/D6l1pnV2d2B03sSavGVOjTzOX8MWUe6hp4CjdMr
        tTXTQikjAJ/2VrnaE9aZMRRMNjDYzuJFHRMnqrbKY0DIjEEjCuI6xYSXDq52uPPQ
        BAUXohwagjkYbdo8tAq438=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wA3dw_do7pj+UhYAA--.53284S2;
        Sun, 08 Jan 2023 19:07:14 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com, Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 0/2] Add support for EmbedFire LubanCat 2.
Date:   Sun,  8 Jan 2023 19:07:08 +0800
Message-Id: <20230108110708.2214718-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3dw_do7pj+UhYAA--.53284S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1kGr15uF1kWFy8uFyrtFb_yoW3ZFcEya
        s7uFyrKF48JFsYqas8Ka4xGrZak39xK345Ka4rAF1UA3ZrZr4UJFWrJ34fZ3W8AFWIkr13
        Jry7XF48u3Z09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRX18m7UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiFgnwXl44WfBViQAAsi
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lubancat series are rk3566/8 based SBC from EmbedFire.
So these Lubancat 2 patch should apply on top of Wenhao's
series for LBC1 [0].

[0] https://patchwork.kernel.org/project/linux-rockchip/patch/Y6Ud9MhRjCVAYMCj@VM-66-53-centos/

Changes in v2:
- keep only one blank line
- Fix underscores in node pmic-int
- Keep rockcip,pins of pmic-int in one line

Andy Yan (2):
  dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
  arm64: dts: rockchip: Add dts for EmbedFire rk3568 LubanCat 2

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-lubancat-2.dts   | 733 ++++++++++++++++++
 3 files changed, 739 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts

-- 
2.34.1

