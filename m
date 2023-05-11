Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191746FE9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEKBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:55:57 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D95851FE1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cn2Bc
        LMyMhxye3IxabtnbH4ZW+Rn/MMBFx9wan1/8Qw=; b=WkpwlhZOUtkAIyKMD5dMU
        FfhWQ6WdpmuXGxKoNzLhrIaikgJaGO29pY9mTGIfbfBPjv4MM1U+EEdwJsO1yTAZ
        QZfrdDPO8q5W6ssAO7qDkbm6wwjASdKdphl8mRpO7K2N/70maZx8XNuf25XAHJOs
        2ORHuWxFwX6zgrXYN6+T5k=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wB3f7MQS1xkGnWFAA--.60569S2;
        Thu, 11 May 2023 09:55:29 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     conor.dooley@microchip.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        zhang_fei_0403@163.com, zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH 1/2] RISC-V: lib: Improve memset assembler formatting 
Date:   Thu, 11 May 2023 09:55:23 +0800
Message-Id: <20230511015523.3430-1-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510-cricket-dwindling-a35d40f1da10@wendy>
References: <20230510-cricket-dwindling-a35d40f1da10@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3f7MQS1xkGnWFAA--.60569S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R9txSUUUUU
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/xtbCfABsl2DcJgufkwABsb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

Hi,

Due to the chaotic response in my previous email, I am sorry for this. I have 
reorganized patch v2 and sent it to you. Please reply under the latest patch.

Thanks,
Fei Zhang

