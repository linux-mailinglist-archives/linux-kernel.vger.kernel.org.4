Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A64607DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJURrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJURr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:47:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7192E24B331;
        Fri, 21 Oct 2022 10:47:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-037-138-189-087.ewe-ip-backbone.de [37.138.189.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08AD466023A6;
        Fri, 21 Oct 2022 18:47:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666374446;
        bh=PKGZEuVKdr8FZFRurU1u3YBH/F6npr8imjXbNUKUFVg=;
        h=From:To:Cc:Subject:Date:From;
        b=HcYRp6bN1ZwuXMGPYqs95Dz6lGi46cgGCfDcHD/t2c+k8BktNNq1eLnKgDmlK211/
         2HjQAZmy9FKz6ogeFBjUYt5v7HslF45OLknYj+kj/XvWfnQyDbKwKbCB8jKgAkftPp
         KmyNeWLcrZ7MpyQhn9jKoynYItlT8XyU1Pb4t/eONxRY9nJSxU2b9W5x8MEVCHY83O
         Xb7Iea7Y8Q++WURv1wH+U0QNs3AQ7ihZrvAVufEEc+hWPkjZFZnHGvQkTQV3JxcrEp
         IPi5piblYPjfKKy4dH9y/10rketl/9n0YJtjOUtLMI8gG40Jyw05zkl+9r0J6eqnpD
         35VvVyVkRXhEw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 60FF548082E; Fri, 21 Oct 2022 19:47:23 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] RK3588 Thermal Support
Date:   Fri, 21 Oct 2022 19:47:19 +0200
Message-Id: <20221021174721.92468-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds thermal support for the new RK3588(s) SoC
series. The series has been tested on the RK3588
EVB1 board.

-- Sebastian

Finley Xiao (1):
  thermal: rockchip: Support RK3588 SoC in the thermal driver

Sebastian Reichel (1):
  dt-bindings: rockchip-thermal: Support the RK3588 SoC compatible

 .../bindings/thermal/rockchip-thermal.yaml    |   1 +
 drivers/thermal/rockchip_thermal.c            | 182 +++++++++++++++++-
 2 files changed, 180 insertions(+), 3 deletions(-)

-- 
2.35.1

