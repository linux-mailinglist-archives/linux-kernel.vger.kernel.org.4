Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26716F5D44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjECRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjECRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:47:04 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7A4C01;
        Wed,  3 May 2023 10:47:03 -0700 (PDT)
Date:   Wed, 03 May 2023 17:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1683136018; x=1683395218;
        bh=OaSVCfhlVZP3PasFE/IchcDTBJ+07/q+uNzjsY0pmRw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=O77AnuyYj9NqMOuskr+Flco+cZ7xI1Awe6Df1+481YYfUPu+mXkAxh/Qg9GkEJ679
         5rasc21ZLo/O4DA5b42HlRwvijp9V98Mt6D3l9pUKqqC8VJNHt4QHL4gjUiKV7QZYX
         +xjFrzqv6R/hx2QXWnKIli5yBsM3FzhV2Gw4TyBKxVlGMugsqOLPTNiLCVllWWK/qL
         gkSkXhWyLUjpRpt4mOSOpnTnUjFVIyyMHIvnmzVd0I+k8VUnBfbzqnLTvAXMGf+kIH
         4+qoO6okEYWYXbIeGOCXk/r7xD8WzvWHb1oKb6glksL0esBjoEFo2gNBBAZrjvIcyn
         XGuZoLUHpWoSw==
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for ASUS screenpad
Message-ID: <_BfjSVwlhmByGevAd1Yo_jhipUa3r6y5HHSi34xdeaYqelyPe1PRnOEru21Yw76x0spJwAAs3jr0MJ0f_jUc8QY75Q1J1ovT5QPvm0p2WhY=@protonmail.com>
In-Reply-To: <20230503040207.257406-1-luke@ljones.dev>
References: <20230503040207.257406-1-luke@ljones.dev>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. m=C3=A1jus 3., szerda 6:02 keltez=C3=A9ssel, Luke D. Jones <luke@ljon=
es.dev> =C3=ADrta:

> Add support for the WMI methods used to turn off and adjust the
> brightness of the secondary "screenpad" device found on some high-end
> ASUS laptops like the GX650P series and others.

Is it this one: https://www.asus.com/content/rog-screenpad-plus/ ?
Or is the "plus" version something different?

If it's a "proper" screen, wouldn't it be better to add support for it
in the respective subsystems? E.g. why not register a backlight device?


>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
