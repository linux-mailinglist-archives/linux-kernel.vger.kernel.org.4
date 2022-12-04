Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B4641CD1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 13:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLDMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 07:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLDMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 07:10:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAF17AB8;
        Sun,  4 Dec 2022 04:10:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 284E55C00FF;
        Sun,  4 Dec 2022 07:10:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 04 Dec 2022 07:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670155840; x=1670242240; bh=CoGojBldvp
        8vts1WXDufl3QTeeG6RrXZWoBhB7qP5HI=; b=Bt3t+pCvXTostL74alusXgNN2I
        oLhoOcA34WlUK1HpM8zYrIq09NT6vJeDNBj/QdZnjHPCSY+ZUy+12uImKcNpjSPM
        o0Qr+CIcrehvro9ebDcKpmBO8KNVO0BSLyVsZqv9jkmom0XPxGpvLeiycBhyso/8
        pWUyCCDG5sY1PPjQhiPvm7NU5068KCV9X/PWB2P1GHq+0C96bygXAKrn+V5Ukhl7
        s7lNWObcsg2gwh4/61eV3/1UOs8rIoQb6FB3dYEy/Ck7h0skHoTgrMXUYD92caiH
        LVymfXQoewwpqSKzAiqVC6quJzrOTZYuY02ME7g19RNKqeqgpVhO3za9ITpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670155840; x=1670242240; bh=CoGojBldvp8vts1WXDufl3QTeeG6
        RrXZWoBhB7qP5HI=; b=DxeCgNBVAAMM2gNNTDGahzTQIA8E/3lkh9laTq8iI5JI
        oocBov/dRgohjG7gGHMhodEsrIvcUGfX70TlrC5hErvHwlfTVVTfGqKcTDhS329l
        rD+FaM0sMNpM3jsx9euuXm8KFkx502Dwdn3v5snXh5/yrmCGjVUmHg4VFsC3IQOm
        rLgVcc1ZcgdX7GJ2QRCaCaXSBBv1eAIhu8iM2xjO6xiG+7n3ECRMdG0oJq9aKmiI
        6SG12snIId67D0+6rJud3wzLSmPtuY+EFsHc/yywdYZFUwR088jM6Mk0ITGUNKvn
        qf3WI/ip6fDNv+zXdoNPQCXdP6unHlzazkw2UySLnA==
X-ME-Sender: <xms:P46MYzvkUIE9aAbyhKZ5xYdb6E_zNjnLgcSXVed3u_JPDYFlalAFUA>
    <xme:P46MY0dL2JSgQQQFPD_QnBCs9YwuQ0hZCxxxWbYhrsT-7PbvOO3waNCDVA8UBJ5Jd
    sc6wTVP5DdQ_oSIErY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:P46MY2wvjqIL0WULSDsDjK2-iWTcNk577njI8u8urdyWK-INhkIjdw>
    <xmx:P46MYyOlmJlUGLbTFFm1o1B00hIvptlHzyHb1bGuRvSjePi_cyJwKw>
    <xmx:P46MYz-G41yzfBtB2Sie70DPf6o0D0uviTpg1dU4jIB6f2uxc1rpew>
    <xmx:QI6MY_TKF5dWc-RYdd4P32M5mWDH0VGUvz1FAOLC-6R8Be_t2ivPsQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 623A3B60086; Sun,  4 Dec 2022 07:10:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <81a7715b-559f-4c5c-bdb6-1aa00d409155@app.fastmail.com>
In-Reply-To: <Y4wnGgMLOr04RwvU@google.com>
References: <Y4wnGgMLOr04RwvU@google.com>
Date:   Sun, 04 Dec 2022 13:10:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, soc@kernel.org
Cc:     "Li Yang" <leoyang.li@nxp.com>, "Qiang Zhao" <qiang.zhao@nxp.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [RESEND PATCH] soc: fsl: qe: request pins non-exclusively
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

On Sun, Dec 4, 2022, at 05:50, Dmitry Torokhov wrote:
>
> SoC team, the problematic patch has been in next for a while and it
> would be great to get the fix in to make sure the driver is not broken
> in 6.2. Thanks!

I have no problem taking thsi patch, but I get a merge conflict that
I'm not sure how to resolve:


@@@ -186,23 -182,27 +180,43 @@@ struct qe_pin *qe_pin_request(struct de
        if (WARN_ON(!gc)) {
                err = -ENODEV;
                goto err0;
++<<<<<<< HEAD
 +      }
 +      qe_pin->gpiod = gpiod;
 +      qe_pin->controller = gpiochip_get_data(gc);
 +      /*
 +       * FIXME: this gets the local offset on the gpio_chip so that the driver
 +       * can manipulate pin control settings through its custom API. The real
 +       * solution is to create a real pin control driver for this.
 +       */
 +      qe_pin->num = gpio_chip_hwgpio(gpiod);
 +
 +      if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
 +              pr_debug("%s: tried to get a non-qe pin\n", __func__);
 +              gpiod_put(gpiod);
++=======
+       } else if (!fwnode_device_is_compatible(gc->fwnode,
+                                               "fsl,mpc8323-qe-pario-bank")) {
+               dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
++>>>>>>> soc: fsl: qe: request pins non-exclusively
                err = -EINVAL;
-               goto err0;
+       } else {
+               qe_pin->controller = gpiochip_get_data(gc);
+               /*
+                * FIXME: this gets the local offset on the gpio_chip so that
+                * the driver can manipulate pin control settings through its
+                * custom API. The real solution is to create a real pin control
+                * driver for this.
+                */
+               qe_pin->num = desc_to_gpio(gpiod) - gc->base;
        }

Could you rebase the patch on top of the soc/driver branch in the
soc tree and send the updated version?

       Arnd
