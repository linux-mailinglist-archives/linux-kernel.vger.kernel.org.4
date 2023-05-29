Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22DD71422A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjE2Cun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjE2Cul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:50:41 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60225DD;
        Sun, 28 May 2023 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BtQtD
        QDNBc1rLN9VOsByZob5obbadHZQLbYhv5fqn90=; b=aaRqUY5l9Iz2MZ4qD8X9Q
        LcDQUDH3qs6oI2HqewWhlaSL3Z9AzmdopjwPSa7itZN0z10Pfa2AkudFz45j2JR8
        OKpzhIkZwA3i94bBp4dW1DJHNfhFQ1FDbTDbPP5sXsanVRZ2jsAw4Rh9Yct6Av6p
        3xKpG8R0wtaLD356i3e5eE=
Received: from localhost.localdomain (unknown [39.144.137.9])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wA36+zmEnRk5hF9Aw--.29114S2;
        Mon, 29 May 2023 10:50:15 +0800 (CST)
From:   xingtong_wu@163.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     henning.schild@siemens.com, xingtong.wu@siemens.com
Subject: [PATCH v2 0/1] gpio-f7188x: fix base values conflicts with other gpio pins
Date:   Mon, 29 May 2023 10:50:10 +0800
Message-Id: <20230529025011.2806-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA36+zmEnRk5hF9Aw--.29114S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUkku4UUUUU
X-Originating-IP: [39.144.137.9]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiOwp+0GC5luHowgAAsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch pin base from static to automatic allocation to avoid
conflicts and align with other gpio chip drivers

Based on:
 [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on Nuvoton chip
 which was recently pulled by maintainer


