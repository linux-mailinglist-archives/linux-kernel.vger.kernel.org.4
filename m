Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D072A503
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFIUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFIUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:52:53 -0400
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921C2D74
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:52:52 -0700 (PDT)
Date:   Fri, 09 Jun 2023 20:52:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686343970; x=1686603170;
        bh=He8yZMV2kI8DEJFeHkiOpD6I4kpbWyGVezca/gfNczU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZnXS7fHEsgjdPBDSqfMRmtKVAKvHqYiJOovmcJinFKhD+Qe881bRtyJ2yx9rGl4xE
         doy99lYaqjtNQzsyll1qciZtgHDfIeL7o6kyxtrqMyjSmePiPK8eX7D9pMCD9C8XEc
         kIhuGElfd4EK025NFCweSwgmW7XvbZQ6tbHsKG9RL9WZGJrvct9yfMb7poq0s0P//t
         piYx408ZmpvOYIuRSqLwHKRNyCwD9Iazhfu3o3zYK/zHZpItX+IdI+xZrm3514rsCY
         OgWOFzqr3O0YpzbMPVA9j8FqUH+jDH7oF8fJ8GAfNEyd2WIqhq41nhK1uhZQbjlLpQ
         XbmLZDaGv2Kbg==
To:     broonie@kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, jk@codeconstruct.com.au,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        michael@walle.cc, netdev@vger.kernel.org, pabeni@redhat.com,
        raymondhackley@protonmail.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230609205227.105306-1-raymondhackley@protonmail.com>
In-Reply-To: <a3d2dd4f-38ce-40ca-9085-893f808f817b@sirena.org.uk>
References: <20230609154033.3511-1-raymondhackley@protonmail.com> <20230609154200.3620-1-raymondhackley@protonmail.com> <e2bb439c-9b72-991b-00f6-0b5e7602efd9@linaro.org> <20230609173935.84424-1-raymondhackley@protonmail.com> <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org> <a3d2dd4f-38ce-40ca-9085-893f808f817b@sirena.org.uk>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Friday, June 9th, 2023 at 7:34 PM, Mark Brown <broonie@kernel.org> wrote=
:
=20
> Specifically your driver should only ever call regulator_disable() to
> balance out regulator_enable() calls it made itself and it should know
> how many of those it has done. regulator_is_enabled() should only ever
> be used during probe if for some reason it is important to figure out if
> the device is already powered for startup, this should be very unusual.
> If something else enabled the regualtor then whatever did that needs to
> undo those enables, not another driver.

Thnak you for explanation. I should drop regulator_is_enabled() here since
it's misused.

Regards,
Raymond

