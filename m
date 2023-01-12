Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E231F666D81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjALJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjALJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:08:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB44FD62;
        Thu, 12 Jan 2023 01:03:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CEDB85C018C;
        Thu, 12 Jan 2023 04:03:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 04:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673514215; x=1673600615; bh=z28MIn97Rc
        98zMcl0IlmdYkFgGOJRGV34Y2wLplLgGI=; b=DDe1bwierpKaunxk71CoGT6yzi
        SJedgNQ/YlAe+TGcKid1qsvbyAjbCv4saHqU3wjPfsX2JwUXMfVdJPXIe7+C1dSW
        jdh8iYLPBBZ1fLELXkb9Q0QXd5m/rq5R/gYNEdzaVuwr90laSj2jslbVJEKIYVpM
        rJ2w99HKM4Pk8VhElkdG+wWkQ1ld3xPVU4MweQtnZhCXA/YIfwI+lDn23Q90rV3p
        x/vhrNl2yKcZ31u1VaPlZthYyrOuM6gGs56oyMv8UiWtSXE8OYTcgTxS0QSh44C7
        OJKFX37rgTInHCnbKBeT/CzyMaaSzXJTLy8Nq0bQwL6VZWRhZSusVbWJ57lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673514215; x=1673600615; bh=z28MIn97Rc98zMcl0IlmdYkFgGOJ
        RGV34Y2wLplLgGI=; b=E4t3NR5k0rfwB6JFxnkLIK1/WIvewfETzb2a3egUsRbP
        YKgjGSCg+KjN4Ho1L+xRbjDaqpzrr275xA66CQD7vV86jcG4JtFjqMfBUY05R+wd
        NiXD0aaSHsLOdG5GWYJvfrZqXCpoglTcyuqZ3U9YQgJhbrF+RhxORtYtLSfOz+Rk
        lF1g8OXKAOuzIs/CZJhyUQdV2EuM5FwOv3m8sZ67bbhoWRG286ioYPduOGEyCxc0
        L9IvrP26O4kqfFVkePtlbHkHffeZEEKzb9hS22xDLIJFofxiopmlfcTua3xLDGkS
        /mr2UpHbGMKp3CpJ2EDjKaoMUrqgPoBUFNIfgC+mow==
X-ME-Sender: <xms:58y_Y54Uwlzzvx0UrHM37f4F_yHYCnLWm4_QyddRVJFaG6c31VBQ5w>
    <xme:58y_Y27XxiqJlQto_9J50hZfBtUzbclTfZl_i1EYgxJktZLf4P92lQyZqpvfKTTuL
    cGiuK-Ac5tCGSKPT-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleehgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:58y_Ywfm_tCJE7GB5mX8sEgJNwF9q3OfRlA2rPB1-HCl6ItTmNmQJA>
    <xmx:58y_YyKniWSnemOCWdo4QE2UvtOgfV0rGUtvHp_N2HBMxyPbpdf5mQ>
    <xmx:58y_Y9J5YEZFuo5kvunef1dqXpAcopJd3ZLmV8apEqth0gmNhFOgOA>
    <xmx:58y_Y09eXyGstUUkLoKCcalf1NJuu7JAImz0U4cxKXubCZKFJOrMpw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32133B60089; Thu, 12 Jan 2023 04:03:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
In-Reply-To: <20230112083746.9551-4-lukas.bulwahn@gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
Date:   Thu, 12 Jan 2023 10:02:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI support for
 OMAP1/2 chips
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> Commit 0fee2eac5c2b ("usb: phy: remove phy-isp1301-omap driver") removes
> the Philips ISP1301 with OMAP OTG driver and its corresponding config
> ISP1301_OMAP. The drivers, OMAP USB Device Controller and OHCI support for
> OMAP1/2 chips, with corresponding configs, USB_OMAP and USB_OHCI_HCD_OMAP1,
> need this removed driver (see "depends on ISP1301_OMAP") to build.
>
> Remove those two drivers.
>
> With the config USB_OMAP removed in this commit, remove some further code
> in the omap-dma header and mach-omap1 architecture code.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

This would be a great cleanup because of the simplications of the
omap-dma code. I had previously looked at it and concluded that
the driver is still in use though, and I think my mistake was
just in the Kconfig part of this patch:

commit c32fd10914a314dd96c5d24030200070c84df5f1
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Sep 29 15:38:56 2022 +0200

    ARM: omap1: remove unused board files
    
    All board support that was marked as 'unused' earlier can
    now be removed, leaving the five machines that that still
    had someone using them in 2022, or that are supported in
    qemu.
    
    Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
    Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: linux-omap@vger.kernel.org
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index b3006d8b04ab..95751062078e 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -118,7 +118,7 @@ config USB_GR_UDC
 config USB_OMAP
        tristate "OMAP USB Device Controller"
        depends on ARCH_OMAP1
-       depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
+       depends on ISP1301_OMAP
        help
           Many Texas Instruments OMAP processors have flexible full
           speed USB device controllers, with support for up to 30
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0442dc4bc334..a0c14c62ff32 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -409,7 +409,7 @@ if USB_OHCI_HCD
 config USB_OHCI_HCD_OMAP1
        tristate "OHCI support for OMAP1/2 chips"
        depends on ARCH_OMAP1
-       depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
+       depends on ISP1301_OMAP
        default y
        help
          Enables support for the OHCI controller on OMAP1/2 chips.

Instead of changing this to 'depends on ISP1301_OMAP', the line
probably should just be dropped entirely.

      Arnd
