Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6B5BDD66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiITGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiITGgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:36:25 -0400
X-Greylist: delayed 175 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 23:34:34 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B113C6373;
        Mon, 19 Sep 2022 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663655491;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RdU9uiMRac2NVpl4u4AJawQiKXHNPgl53Bwuc/vHay4=;
    b=fVq368q8bd7LGsIFX2Xc6/B6NNI4HTBJHh0djaEvUINe5ZpyqWt9/dzTWfNQawzJhb
    pgLCw8RZw1izaZTdC0HsY/vmT2uaT2lg8GY9j/EWqEjN9m8nw9soLGfQH5d5iAHahmSk
    y40fOf95ABlvXHB9xieW46bA2CRviz806QBsSoJ9X7SdoF/tTpEcP0GW/6GlYEeFJ4Fj
    6BZnxmLgZoQRkGII+C/3VOmrO8yPw+Lzn5y4z32wQjy5lERLhQdIDzrPgsGCYMOjbd36
    QL7cB6cy2CqllRcFtCSZqC03TSk5Ro4tGAtM0jFGl1i4yZcdo599eNjREvIB/PQHzkcQ
    ZDxA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZjzY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 48.1.0 DYNA|AUTH)
    with ESMTPSA id qa2a62y8K6VVU1o
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 20 Sep 2022 08:31:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Usefulness of CONFIG_MACH_JZ47*
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <UC07HR.REF39SO0Y5PG2@crapouillou.net>
Date:   Tue, 20 Sep 2022 08:31:30 +0200
Cc:     linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
 <UC07HR.REF39SO0Y5PG2@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
it seems as if there aren't many places left over where the MACH_JZ47* =
configs are still in use:

drivers/char/hw_ramdom/Kconfig
drivers/clk/ingenic/Kconfig
drivers/gpu/drm/ingenic/Kconfig
drivers/pinctrl/pinctrl-ingenic.c

Is it possible to get rid of them and just have =
CONFIG_MACH_INGENIC_GENERIC?

This might simplify my defconfig for multiple machines.

BR and thanks,
Nikolaus

