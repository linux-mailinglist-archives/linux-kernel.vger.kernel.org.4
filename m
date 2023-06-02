Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7171F872
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjFBCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFBCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:35:21 -0400
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B4184;
        Thu,  1 Jun 2023 19:35:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowAC3velSVXlkn7zICQ--.60074S2;
        Fri, 02 Jun 2023 10:35:00 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     simon.horman@corigine.com
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, davthompson@nvidia.com, asmaa@nvidia.com,
        mkl@pengutronix.de, limings@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] mlxbf_gige: Add missing check for platform_get_irq
Date:   Fri,  2 Jun 2023 10:34:56 +0800
Message-Id: <20230602023456.47362-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3velSVXlkn7zICQ--.60074S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1fWw1rtry5CF1ftF4xWFg_yoW8Ar1kp3
        yrtwn3CFWDJ34xKws7G3W2kFy8Jan8Cr98Wrn09a93Zr9xAr93Xr1S9w4Yvw1UWFs3ur43
        Jas2gr93tw4UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUHWlkUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 23:08:54 +0800, Simon Horman wrote:
> Let's take a step back.
> 
> The script is here, so you can take a look at what it does.
> And I dare say that changes can be proposed.
> 
>   https://github.com/kuba-moo/nipa/blob/master/tests/patch/cc_maintainers/test.py
> 
> I'd also say that the problem here is that Liming Sun <limings@nvidia.com>
> appears in the above mentioned commit that is being fixed.
> 
> I think that get_maintainer will dell you this if you run it
> on your patch. Which is what the script appears to do.
> 
> Locally, I see:
> 
>   $ ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
>   "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS,blamed_fixes:1/1=100%)
>   Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
>   Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS,commit_signer:5/5=100%)
>   Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
>   Asmaa Mnebhi <asmaa@nvidia.com> (commit_signer:4/5=80%,blamed_fixes:1/1=100%)
>   David Thompson <davthompson@nvidia.com> (commit_signer:4/5=80%,authored:4/5=80%,added_lines:94/95=99%,removed_lines:19/20=95%,blamed_fixes:1/1=100%)
>   Liming Sun <limings@nvidia.com> (blamed_fixes:1/1=100%)
>   netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
>   linux-kernel@vger.kernel.org (open list)
> 
> N.B.: The script excludes linux-kernel@vger.kernel.org

I have got it. I will run the script on the patch.

> 
> 
> As an aside. This patch is missing v2.
> 
>   Subject: [PATCH v2] ...

The patch is not changed. I only add a recipient.
Therefore, I think it is not a v2.

Thanks,
Jiasheng

