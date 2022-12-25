Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA81C655D23
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiLYMGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLYMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:05:47 -0500
X-Greylist: delayed 923 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Dec 2022 04:05:43 PST
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC8A33A;
        Sun, 25 Dec 2022 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F9gkZ
        SD7c3nHA5BZkH+F7JuoJmI7vSuVT8KI2Bn7tWA=; b=GF6VvIkzIQMGURMLwbd2R
        PNbfFdLcd0irg7U0TbGa9rqYWhEv/GeUaHJ/4Q1MttnYsZXEAxvGv+hj31nzWafo
        uhS2LPL1GGnGYTTfuR2KTwy+hTwYOEGQnP8SHNf0FgrMOyWczgif0ZybMwmDq8Vy
        3XPF88GR1Nhxvybg92dR8U=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp19 (Coremail) with SMTP id R9xpCgA33rq7OKhjaKYnCw--.48484S2;
        Sun, 25 Dec 2022 19:49:19 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        piotr.oniszczuk@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH 0/2] rk3566 box demo io domain and network fix
Date:   Sun, 25 Dec 2022 19:49:15 +0800
Message-Id: <20221225114915.3518502-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgA33rq7OKhjaKYnCw--.48484S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RAOzVDUUUU
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgDiXmI0VoFerQAAsc
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The rk3566 box demo has a gmac and a ap6398s wifi demo,
These two patches add the io domain setting make gmac
work well, and fix the sdmmc1 dt nod to make wifi work.


Andy Yan (2):
  arm64: dts: rockchip: rk3566-box-demo: add io domain setting
  arm64: dts: rockchip: Enable wifi module AP6398s for rk3566 box demo

 .../boot/dts/rockchip/rk3566-box-demo.dts     | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

-- 
2.25.1

