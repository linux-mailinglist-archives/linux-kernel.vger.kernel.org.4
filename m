Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA55BBC0B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIRFlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 01:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIRFlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 01:41:47 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D46A227150
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=L6ozd
        f2KEmZz6UdpG0ZFUAYyo1y/S2z5zIIgU4sBd3U=; b=cB/SHauBNTDI60CHd8iYl
        UZfqQ/FErKjmJu0AliQT/ISy6hfUMpj5xO/HpNVCnrBBVso3fpkrSsgM3GQ/kmpJ
        NvkuiYb/lTc3XlsfOhq3pAmMXj30rDUqAa0vgcq9ulisQFYY1Hc3j05c5cEg2r2t
        UfY6DbcdW3fN4f31ydrrS0=
Received: from whoami-VirtualBox.. (unknown [223.72.42.150])
        by smtp14 (Coremail) with SMTP id EsCowACn1zMUryZjQMfzAQ--.48323S2;
        Sun, 18 Sep 2022 13:39:33 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     ajones@ventanamicro.com
Cc:     akpm@linux-foundation.org, alexandre.ghiti@canonical.com,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, falcon@tinylab.org, guoren@kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, sunnanyong@huawei.com, tjytimi@163.com,
        tongtiangen@huawei.com
Subject: Re:Re: [PATCH v1] riscv : support update_mmu_tlb() for riscv
Date:   Sun, 18 Sep 2022 13:39:30 +0800
Message-Id: <20220918053930.23380-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906144126.3enx6y2mhevrc4ur@kamzik>
References: <20220906144126.3enx6y2mhevrc4ur@kamzik>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACn1zMUryZjQMfzAQ--.48323S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfU70eHDUUUU
X-Originating-IP: [223.72.42.150]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiVhWAeFqzt7lobAAAsY
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jinyu 

