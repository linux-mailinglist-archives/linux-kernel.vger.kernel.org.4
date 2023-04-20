Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243996E9AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDTRds convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDTRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:33:45 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633554EE3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:33:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 12C8664551D0;
        Thu, 20 Apr 2023 19:33:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jA3v9_EJX3hK; Thu, 20 Apr 2023 19:33:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A6C3C63CC166;
        Thu, 20 Apr 2023 19:33:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ILxeHMeUlP07; Thu, 20 Apr 2023 19:33:19 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88AEB64551D0;
        Thu, 20 Apr 2023 19:33:19 +0200 (CEST)
Date:   Thu, 20 Apr 2023 19:33:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
In-Reply-To: <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com> <687864524.118195.1681799447034.JavaMail.zimbra@nod.at> <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com> <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: HhyYkKa9UL/icxFryd8ZleAEcsQTSA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> The kernel is in qemu. We find that the `mtd` is from
> `mtd = get_mtd_device(NULL, req.mtd_num);` in function `ctrl_cdev_ioctl`.
> And we are still trying to figure out what MTD is.

Can you please share the qemu command line?

Within Linux you can query /proc/mtd or /sys/class/mtd/
to get infos about the MTD in question.

Thanks,
//richard
 
