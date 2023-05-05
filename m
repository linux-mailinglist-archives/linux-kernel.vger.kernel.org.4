Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61196F8C60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjEEWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjEEWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:31:57 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 15:31:56 PDT
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728C11FFA;
        Fri,  5 May 2023 15:31:56 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4QCkkY1dBJz8x;
        Fri,  5 May 2023 23:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1683323125; bh=PwOi26H3hPkYFA82ugtwbn0hlISMPV9jBmzzs4zLWRU=;
        h=Date:Subject:From:To:Cc:From;
        b=PjxC192uBsEXrQW/27ds8oD3HnH4GvWpr6X3PdS6ly/qOFWbKrUN6YDTH1qK4qjbO
         V7y7yA9+Ql+zur55aZrQBp3PUdtwHWOV1RIkekCuduOzho+zkzoH3YIHCD5qwHG/Dj
         ux7t+0yxyV3AjCyPDQNgX9fSRmKvMBnaxnCmfj+Dt+6XoIulcIOnT6qeyQJGesda5r
         eph1+2jDFOdw785+Q0CBoEn1hpkvIjQIfAWLZqm1vWXx8CQ1mviovLEBzPDwCCQLQA
         fdHMYrdGl5+x9fRbtApF7shKhUa1twveB+w/wz1lON+2YUSXqHiDbnj62ny4XJIpM9
         6KT3zdUg+WxaQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 05 May 2023 23:45:24 +0200
Message-Id: <cover.1683322608.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 0/2] i2c: tegra: allow compiling out support for Tegra's special controllers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches that, combined, reduce I2C driver's code by ~2kB and a bit
from runtime overhead for non-Tegra20 or non-Tegra210 builds.

v3: added parentheses for IS_DVC and IS_VI macros as requested by
    Wolfram Sang (from checkpatch --strict report).
v2: remove KConfig symbols as per Dmitry Osipenko's suggestion.
    This assumes that for relevant SoCs the special controller
    implementations will be used anyway.

Michał Mirosław (2):
  i2c: tegra: allow DVC support to be compiled out
  i2c: tegra: allow VI support to be compiled out

 drivers/i2c/busses/i2c-tegra.c | 35 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

-- 
2.39.2

