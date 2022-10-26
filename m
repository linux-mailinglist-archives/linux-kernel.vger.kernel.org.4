Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0560DDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiJZJDr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:03:45 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E698362;
        Wed, 26 Oct 2022 02:03:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VT6gSr0_1666775020;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VT6gSr0_1666775020)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 17:03:41 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 0/9] Drivers for Alibaba YCC (Yitian Cryptography
 Complex) cryptographic accelerator
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <1666691616-69983-1-git-send-email-guanjun@linux.alibaba.com>
Date:   Wed, 26 Oct 2022 17:03:39 +0800
Cc:     "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>,
        "artie.ding@linux.alibaba.com" <artie.ding@linux.alibaba.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuchun.shang@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <73066E97-4ED2-46DA-BAD5-4F0DFC95C1C5@linux.alibaba.com>
References: <1666691616-69983-1-git-send-email-guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2022年10月25日 下午5:53，Guanjun <guanjun@linux.alibaba.com> 写道：
> 
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Hi,
> 
> This patch series aims to add drivers for Alibaba YCC (Yitian Cryptography Complex)
> cryptographic accelerator. Enables the on-chip cryptographic accelerator of
> Alibaba Yitian SoCs which is based on ARMv9 architecture.
> 
> It includes PCIe enabling, skcipher, aead, rsa, sm2 support.
> 
> Additionally, this patchset has rebase Linux upstream tree and ensure no compile
> warnings. -- As Herbert's comments said in v2.

Hi Herbert,

Very sorry for this disturb email. For some reasons, I didn’t get your point exactly that you mentioned in v2.
So I recall this patchset. I will ensure that no compile warnings with sparse turned on before submitting next version.

Thanks
Guanjun

> 
> Please help to review.
> 
> Thanks,
> Guanjun.
> 
> Change log:
> v2 -> v3:
> - [01/09] Fix the lost "$" in Makefile
> - [08/09] Fix compile warnings when both CONFIG_CRYPTO_SM2 and CONFIG_CRYPTO_DEV_YCC are enabled
> 
> v1 RESEND -> v2:
> - [01/09] Remove char device that is not used now.
> 
> v1 -> v1 RESEND:
>  - [01/09] Adjust the Kconfig entry in alphabetical order
>  - [05/09][07/09][08/09] Adjust the format of algorithm names
> 
> v2: https://lore.kernel.org/all/1664350687-47330-1-git-send-email-guanjun@linux.alibaba.com/
> v1: https://lore.kernel.org/all/1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com/
> v1 RESEND: https://lore.kernel.org/all/1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com/
> 
> 
> Guanjun (3):
>  crypto/ycc: Add skcipher algorithm support
>  crypto/ycc: Add aead algorithm support
>  crypto/ycc: Add rsa algorithm support
> 
> Xuchun Shang (1):
>  crypto/ycc: Add sm2 algorithm support
> 
> Zelin Deng (5):
>  crypto/ycc: Add YCC (Yitian Cryptography Complex) accelerator driver
>  crypto/ycc: Add ycc ring configuration
>  crypto/ycc: Add irq support for ycc kernel rings
>  crypto/ycc: Add device error handling support for ycc hw errors
>  MAINTAINERS: Add Yitian Cryptography Complex (YCC) driver maintainer
>    entry
> 
> MAINTAINERS                            |   8 +
> drivers/crypto/Kconfig                 |   2 +
> drivers/crypto/Makefile                |   1 +
> drivers/crypto/ycc/Kconfig             |  18 +
> drivers/crypto/ycc/Makefile            |   7 +
> drivers/crypto/ycc/sm2signature_asn1.c |  38 ++
> drivers/crypto/ycc/sm2signature_asn1.h |  13 +
> drivers/crypto/ycc/ycc_aead.c          | 646 ++++++++++++++++++++++
> drivers/crypto/ycc/ycc_algs.h          | 176 ++++++
> drivers/crypto/ycc/ycc_dev.h           | 157 ++++++
> drivers/crypto/ycc/ycc_drv.c           | 567 ++++++++++++++++++++
> drivers/crypto/ycc/ycc_isr.c           | 279 ++++++++++
> drivers/crypto/ycc/ycc_isr.h           |  12 +
> drivers/crypto/ycc/ycc_pke.c           | 946 +++++++++++++++++++++++++++++++++
> drivers/crypto/ycc/ycc_ring.c          | 652 +++++++++++++++++++++++
> drivers/crypto/ycc/ycc_ring.h          | 168 ++++++
> drivers/crypto/ycc/ycc_ske.c           | 925 ++++++++++++++++++++++++++++++++
> 17 files changed, 4615 insertions(+)
> create mode 100644 drivers/crypto/ycc/Kconfig
> create mode 100644 drivers/crypto/ycc/Makefile
> create mode 100644 drivers/crypto/ycc/sm2signature_asn1.c
> create mode 100644 drivers/crypto/ycc/sm2signature_asn1.h
> create mode 100644 drivers/crypto/ycc/ycc_aead.c
> create mode 100644 drivers/crypto/ycc/ycc_algs.h
> create mode 100644 drivers/crypto/ycc/ycc_dev.h
> create mode 100644 drivers/crypto/ycc/ycc_drv.c
> create mode 100644 drivers/crypto/ycc/ycc_isr.c
> create mode 100644 drivers/crypto/ycc/ycc_isr.h
> create mode 100644 drivers/crypto/ycc/ycc_pke.c
> create mode 100644 drivers/crypto/ycc/ycc_ring.c
> create mode 100644 drivers/crypto/ycc/ycc_ring.h
> create mode 100644 drivers/crypto/ycc/ycc_ske.c
> 
> -- 
> 1.8.3.1

