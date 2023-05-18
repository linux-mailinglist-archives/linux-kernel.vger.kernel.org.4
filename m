Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9AB7078BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjEREG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjEREGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:06:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658830E9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:06:06 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-165.ewe-ip-backbone.de [91.248.191.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D9876603147;
        Thu, 18 May 2023 05:06:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684382764;
        bh=SZR719ttfRf6/TscAkcqBUOuFk5b1r7TzEA4BhTZUrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=aGvxoEALqFDo+X1C3Mdq8AGGVIZYC2U07UKUWYMfw2TrUvlsuNgJB0HuWvWec1/zq
         lk1fgDICUkb4Ia52c0CzHY67oeCvu1hh8CjHqnJpCjG7fGmQkdx6sBlZhVeOB5KpxK
         3Kzx/GE125cheiCSf9UTz1zX9VLw57iKa/AlEWWX/FXTD89XD9s/vNND5Is78/cCGV
         StwZ8trC50nfNjYWENjt60SA7BgpnMHR0LXaNvU1qskPDHcMay9wQl5anrLzccPgi5
         z7G/rKj5oennEZ7ljwObqub1I8XrbK/kxJEHMWctAw4DQLzbpGyW29wAQapKgDlPWT
         y+w4iQIpCEntw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0BF244807E1; Thu, 18 May 2023 06:06:02 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 0/2] MFD_RK8XX defconfig update
Date:   Thu, 18 May 2023 06:05:39 +0200
Message-Id: <20230518040541.299189-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I missed updating the defconfigs in the RK806 patchset [0]. Here are
incremental patches doing just that. Considering the current status
it's probably best for them to be added to the immutable branch
prepared by Lee.

[0] https://lore.kernel.org/all/20230504173618.142075-1-sebastian.reichel@collabora.com/

Thanks,

-- Sebastian

Sebastian Reichel (2):
  arm64: defconfig: update RK8XX MFD config
  ARM: multi_v7_defconfig: update MFD_RK808 name

 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm64/configs/defconfig        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.39.2

