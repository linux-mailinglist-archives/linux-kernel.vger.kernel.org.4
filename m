Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37A711E30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjEZC6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZC6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:58:41 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 618709C;
        Thu, 25 May 2023 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BtQtD
        QDNBc1rLN9VOsByZob5obbadHZQLbYhv5fqn90=; b=LQ5+5ltqbXpXc+gewuRff
        8f1UqjmUtTXh0Jwfp8ZfmQzz2K47Fe3ztSEL/leHE5uCoZ8vUDTL2jJfSftGe4KB
        x9JGffGRaAEYQp4QPE4RMBmhAtTyLLjmGXn/s3yaGlnBhafowYtOrXxZu18hk6Ha
        eWHDKID8AA1ThKzzGNcPu4=
Received: from localhost.localdomain (unknown [39.144.137.221])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wCnVm4ZIHBkyhCDAg--.50904S2;
        Fri, 26 May 2023 10:57:30 +0800 (CST)
From:   xingtong_wu@163.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, henning.schild@siemens.com
Subject: [PATCH 0/1] gpio-f7188x: fix base values conflicts with other gpio pins
Date:   Tue, 30 Dec 2042 21:08:10 +0800
Message-Id: <20421230130811.2542-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnVm4ZIHBkyhCDAg--.50904S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUBjNtDUUUU
X-Originating-IP: [39.144.137.221]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiOwB70GC5lsNDawAAs0
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_Q_PLUS,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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


