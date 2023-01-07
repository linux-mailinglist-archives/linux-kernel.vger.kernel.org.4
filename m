Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B40660E73
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjAGLxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjAGLxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:53:11 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 544D662D5;
        Sat,  7 Jan 2023 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=La+U8
        67INzBu0h4o8wQUOvS3yylJf8wtl9YAUS0U0sc=; b=lOmiThg5NppnhcdFqX6US
        no75XPmmnxoUYQgOZsk3IQYAsK5JkLScnIChG0iB/Jz30YTWn//nsJfG8WOkmxO/
        MIYeiifFVusYSE4ny4zl7wJiAy01h5Eu6oJc6PIUj5GmYXl+UXscj6b+PbPm3T8O
        vt9c80w6+21TrJjfBAGXx0=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wD3_9PgXLljMbheAA--.47451S2;
        Sat, 07 Jan 2023 19:52:04 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com, Andy Yan <andyshrk@163.com>
Subject: [PATCH 0/2] Add support for EmbedFire LubanCat 2.
Date:   Sat,  7 Jan 2023 19:51:59 +0800
Message-Id: <20230107115159.2125308-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_9PgXLljMbheAA--.47451S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1kGr15uF1kWFy8Zw18Krg_yoWxZFXEya
        s7uFy0gF48JFn0qasxK34xGrZrK39xK345Ka45AF1DCFnrXr4UJFWrJ34SkFW8AFW2yr1f
        Ja4aqF18uFn09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRJKsj7UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwXvXlXmDdX4bwAAs7
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


Andy Yan (2):
  dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
  arm64: dts: rockchip: Add dts for EmbedFire rk3568 lubancat 2

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-lubancat-2.dts   | 734 ++++++++++++++++++
 3 files changed, 741 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts

-- 
2.34.1

