Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553A6AC31C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCFOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCFOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:22:28 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160C3527B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:20:54 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id t39so8250012ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxZOC/oFAJ7mVCTrB11HvO0wkDiTX72CDJEEOJC+H98=;
        b=oz/3ISlqzr1Mu56AOXdfAZhRsdyVbUIbvaCsf038voyuYh9RBd4ZMV/3TML2N4WaOL
         AevGchGy+zENGB22WKH72f2fhiaJRQOeFKQ5Z7zw/HxDBn49nepzjt58VMf6VIBcvd3P
         wd+P604MzHnOGXdD5OSzlPEjTdMyt3BllKzs/9GhiS3kF4eSR5QliQ+rgSIMipOFkgbM
         DC6OaAAPz3VvAoOVLPQK2GFwtzAgbdsLsNIgUEUinb+Am1Jtjvbo+pFl4dK6tthEqXzd
         Sc7m8p3DqDaO0rhsSUOHnxnyU96UVQdJw8ohBBUfW1MtMZ9oVdnPHEapE5rE70J68SZZ
         EDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxZOC/oFAJ7mVCTrB11HvO0wkDiTX72CDJEEOJC+H98=;
        b=jSEbeglUF5sT0IjWKIWsq7/za8U91u7R+lvL8W6VveKZRi4vJgBbi9uBjhZMmrKqCR
         Do9goULyTO9NUSYAk9eW3U/zl7ncPfG0WAWG/Ax/emj3RGb4oiSglHqYFbCv2ktMl7Ca
         fKgGDLJunU9rtm7297QXVPw1oBdh72AwayYKy7HhOiCgQH0LQEnoLKEepwGt9FfGwqW+
         fhO022DKT1x+4q8FXv3RSqYecSUN4vRNx1AHtJo4Rs76W/yzU7dRZXZ945Zjf9ar5yZl
         SvBjZyj6l9R+4HuwaSBba++yuIdyybS4UysTP3iOaYOQwC2J0sFxjYkI+x+EsL/JmJN+
         Rb3Q==
X-Gm-Message-State: AO0yUKWb1h/E+3t1DgKDOMsjyB+LnOx9QoSIIafjI7XcVxiYeRY5SQap
        6x7xZSq5ey2dH2lvP2GieiL9Unp+VlrkXQgZLy7hbA==
X-Google-Smtp-Source: AK7set/FqB1a3gzaiHVXuJsE8H16TW/OMBYIdNp4jrArFvJtsJcWBeIdZQ/8vyZPwqyhO7+6BMYOgloJ+MUsrPAUvRU=
X-Received: by 2002:a25:9281:0:b0:b0a:7108:71e9 with SMTP id
 y1-20020a259281000000b00b0a710871e9mr2331645ybl.4.1678112380304; Mon, 06 Mar
 2023 06:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20230227205035.18551-1-git@apitzsch.eu>
In-Reply-To: <20230227205035.18551-1-git@apitzsch.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:19:29 +0100
Message-ID: <CACRpkdZROb6q20yMJomhy4KF0R-vwNSwXPSkN7Tn8S-kf0wYKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: atmel,maxtouch: add linux,keycodes
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:50 PM Andr=C3=A9 Apitzsch <git@apitzsch.eu> wrote=
:

> In some configurations the touch controller can support the touch keys.
> Document the linux,keycodes property that enables those keys and
> specifies the keycodes that should be used to report the key events.
>
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
