Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE21A73D7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFZGed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:34:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C7BA8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687761269; x=1719297269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+QpDeNxrvZsdMGCOFBthzUrmbmm9NaHndh87ZnwJ/Yk=;
  b=co1HSq/jzxGZn6HtQh8n6kzcgVv2l676vvBMxoSZI+25UsL+HuxEAJ2f
   41WMeWBeuLKzgqN4BC+HpXeVjTUFlWNg64Y+/Ew2E5BnTjUavSC08WkDv
   XCKggdDMz9xQCZRdGAsgt3cHYB6D2BgsnE8s9/1Xmp5tdhLfp0m0Uhjg5
   fNczOI8+kS5HE6FjKCa7PRh6TSsUbxJlOebUXDyM/6X7fA4KNLz9+dngV
   QRvSW8/n5KmcftXUbFL4bI6jtd1Z4kYn/Ab1axZC+Zln5ExKAykmq8nMR
   UAbLO8D6lCEfBzpHdAaI8vKYBJKvm8T2ngiRTEEJMPorWQydK4qsjShC6
   w==;
X-IronPort-AV: E=Sophos;i="6.01,158,1684771200"; 
   d="scan'208";a="241201201"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2023 14:34:28 +0800
IronPort-SDR: IKUKHqk/4eMq0fr10XgmO2r1xq/TBE2ytwacxk+6WiH1j4CR6taIvCsviBF9nGuHTBW5aWwpPf
 ECPga3939zZr3lsCmqrm9dZznEQ5YHd5j1U2P4rXAY3UdLM8qJqEkAqSUnQRA45+cgXNuCQH3o
 Agt95MZIfCMVos6FSTGLzvPeJ60lDDFnu5wU+u2H7LaME8kF5VF1dLBpBT0LlYf6CvbhGIGlPA
 B8kXO42UAY7NQhxlSb6m1Hb7taBxKrhra2hWlB5b6jRX/iYuSkHTMd3kEUOAye6gnIVgWS70En
 oG4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 22:48:49 -0700
IronPort-SDR: 1a8LR4bW4Cz48ylWEZdeeCAhFy/y9KN4rXbRSyCZFE2o96dmD2ezuOv1nI1+QBAFqDr3WIMo1A
 Mio3QvdXQnD58k8+UURCahP9T9oolud3973Fa7Xo4m/m48Nry158X3ovBJnQE5CtE9IMZ3RNZU
 hL1meS8W/J/Zyjf3ieNUQUAacqfIFdFqbhfM/YBaikKBZ4DhccK4lOTO6q57y1l0tvG2EKrdIj
 kkqj8eE1Mt8I5j1hs2JdMm/kAwyghbmuwlxUTgigvc1PMqaIPAgKX3gLd0styW5D1zm9VHU8IQ
 +aY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2023 23:34:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     morbidrsa@gmail.com,
        =?UTF-8?q?Rodr=C3=ADguez=20Barbarin=2C=20Jos=C3=A9=20Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, jth@kernel.org,
        =?UTF-8?q?Sanju=C3=A1n=20Garc=C3=ADa=2C=20Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH 0/1] mcb: Fix crash mcb-core module is removed
Date:   Sun, 25 Jun 2023 23:34:17 -0700
Message-ID: <168776121004.898395.14706133623744117839.b4-ty@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616113732.83210-1-josejavier.rodriguez@duagon.com>
References: <20230616113732.83210-1-josejavier.rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 11:37:50 +0000, Rodríguez Barbarin, José Javier wrote:
> When allocating a new mcb_bus the bus_type is added to the mcb_bus itself,
> causing an issue when calling mcb_bus_add_devices(). This function is not
> only called for each mcb_device under the mcb_bus but for the bus itself.
> 
> The crash happens when the mcb_core module is removed, getting
> the following error:
> 
> [...]

Applied, thanks!

[1/1] mcb: Do not add the mcb_bus_type to the mcb_bus itself
      commit: 87504ae67790fb83160fd3d74c7c8e714894b203

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>
