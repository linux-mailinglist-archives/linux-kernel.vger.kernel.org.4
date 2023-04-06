Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AE6D905E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjDFHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjDFHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:22:02 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4A6585
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:22:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8988E42463;
        Thu,  6 Apr 2023 07:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680765720; bh=bfmAZp+wJP0fVa7Z2AOr2BR874IaVs9SMwhsVm+aaUg=;
        h=Date:From:Subject:To:Cc;
        b=is89vcXar+LfDjA1wsFp2rwFANGWVYDEsyxwOHpZ2EoSxFjmJCzSBMFur+Nz6a/ji
         nlekAqHQCdh82ECA18p914QJ+ckBM/qkIDpAFdrqcf7NWpbvI/vf/tnstx2SBSUMpx
         PP2x9rSD28uykTd2lb1iLCMdDNrCjq8lCI8BFxmp1uvVk5H6woGf4RIKzYP1Nro/8s
         UHtEYrJAp3XaSyo6jmOknZ99/2Ppydgz6MD+LMXOumYsCaZ/sxhG2HZVSNxH/eOg6x
         /hKF1jQKnjI1yqbJS3hoR5KK4DaBHKeA0p7tbseHDNd7QyFdYmtY2x+DGdB+L/gtyX
         y6MLQuKsgsroA==
Message-ID: <0dbd2dc1-6a2c-5b21-354b-d8314937e8e7@marcan.st>
Date:   Thu, 6 Apr 2023 16:21:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC RTKit updates for 6.4
To:     SoC Team <soc@kernel.org>
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi SoC folks,

Please merge these RTKit changes for 6.4.

This time it's just one bugfix (only relevant to upcoming drivers) and
one improvement to syslog forwarding.

-Hector

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-rtkit-6.4

for you to fetch changes up to bdfe6de2695c5bccc663a5a7d530f81925d8bc10:

  soc: apple: rtkit: Crop syslog messages (2023-03-28 19:59:34 +0900)

----------------------------------------------------------------
Apple SoC RTKit updates for 6.4.

Just one bugfix and one improvement to how forwarded syslogs are sent to
dmesg.

----------------------------------------------------------------
Asahi Lina (1):
      soc: apple: rtkit: Fix buffer address field width

Martin Povišer (1):
      soc: apple: rtkit: Crop syslog messages

 drivers/soc/apple/rtkit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
