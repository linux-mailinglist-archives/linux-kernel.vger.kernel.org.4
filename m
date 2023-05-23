Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91A70DF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjEWO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjEWO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:29:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD2E9;
        Tue, 23 May 2023 07:29:32 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F319D852DB;
        Tue, 23 May 2023 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684852169;
        bh=6ptexe/u4vS+fQddFLan9T1NLcrbA6NWyhAdTJ0l0nc=;
        h=From:To:Cc:Subject:Date:From;
        b=VJln1mKhUGPqvxddB6Euz8zLAn9rT/oOeWCPltDeweYtsD5gPbzYhylgbwhOPnTE8
         6lNToyfkv8Rmjffk35gRkOiMyRoXRwDnOud4k9SJCqL5anTbVgmLl4TGm6uCjzUH6j
         x3S1Lqn0uGkNtPeXtOuJ9WafAojF828/wo/L+nKm51LUYnzL31VOp2fltztFSADhk1
         xZ8UgHeGiRZwgQLYyyD0lWeKIO2iRrT4gSmj+GLA+3lO46wb8R/baBADAdtQsICYUb
         uS6ENe8jXSfU18skRYUiVapMyS+f5FL8S6iUZD9qzvLu42YtEtsQ/SjsgQ6nvaz313
         nz6PvtqfFdpEA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v7 0/3] dsa: marvell: Add support for mv88e6071 and 6020  switches
Date:   Tue, 23 May 2023 16:29:09 +0200
Message-Id: <20230523142912.2086985-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit (SHA1: 7e9517375a14f44ee830ca1c3278076dd65fcc8f);
"net: dsa: mv88e6xxx: fix max_mtu of 1492 on 6165, 6191, 6220, 6250, 6290" the
error when mv88e6020 or mv88e6071 is used is not present anymore.

As a result patches for adding max frame size are not required to provide
working setup with aforementioned switches.

Lukasz Majewski (2):
  dsa: marvell: Define .set_max_frame_size() function for mv88e6250 SoC
    family
  net: dsa: mv88e6xxx: add support for MV88E6071 switch

Matthias Schiffer (1):
  net: dsa: mv88e6xxx: add support for MV88E6020 switch

 drivers/net/dsa/mv88e6xxx/chip.c | 41 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  2 ++
 drivers/net/dsa/mv88e6xxx/port.h |  2 ++
 3 files changed, 45 insertions(+)

-- 
2.20.1

