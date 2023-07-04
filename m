Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971F3747453
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:44:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD3E47;
        Tue,  4 Jul 2023 07:44:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so488717a12.1;
        Tue, 04 Jul 2023 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688481886; x=1691073886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgtSIuMRfTClfmMjvb+ApNrn15orir6jxdTmVNFshZ4=;
        b=E3b7quBOxg97PGrhefBmfqeOG7zqSECrznALGZ7dfk1ZFvley1A1eL6+7kwU63S0FT
         bkT5UEWCES5roeqrTiVp8NJRvVSCl8RFloIsOqsQMWuZyIm9PjK6E1FSQMC9Z7GbJbOO
         j4hhdEtSNfKp94Pc9BvNT6K3W/1yyV6pQJdMrLHF9xtVh0Pbz4YfxGa7aFLdRI+kConO
         KZGnEQAkycr0ZtYW0GEvqVVOJHAE//CTFUN/WOMILqkiWuL5NC+ZiRLnwiOI1qGPYMnR
         cSUuv/VGhkVLYIeH+bzLWkOrXArKntBuWqE0Udp9yoiG1eZh9g0CB0Bh3BXz15W5S9UY
         M9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688481886; x=1691073886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgtSIuMRfTClfmMjvb+ApNrn15orir6jxdTmVNFshZ4=;
        b=WRZb7nvT3vTFjyXEqkZBDhUtPZZUCFWWYVHXzthnuG6NtRhNuaL9WAv5Btyy6iimu5
         Dv68JZbDQcCTjU0v9ZdBqSK1mY6cduZ/ohqZi9/Pl01U5zvfz8uLsdbDIKXkPKR4meks
         OmMzitCOlD1L/1LZ3IyYHTWSXgbHNM90DP0GMCTpixzM5EE9fXjQyrid3xzGEJwezbGG
         1W7O5VYTB12B1cVCHHBl1dBCS4q3bNUCMnIqr/LRgM/X9J3TqwOCMeyrUqIkpPyZGv9P
         ymxCUp8CPAOZBrfIcY3/ueqnaeS2bx9+2fN09aAgKgoIYmisPRBFIJrSsE+SZQu7yvET
         BJCw==
X-Gm-Message-State: ABy/qLbtDO6WQezn02eHvEN6lKw8EnlPqS3D9nKuqp4DmbeBOFaCxLu/
        TJTAOa68rLoaxZcI5l+5QKxuuaUctnSAQq9mcWY=
X-Google-Smtp-Source: APBJJlFO4HgsT2gnFinOZVWVKm068r9kMZxzdgaLU9fOvk+y8o/Nm6XYT6g93GgrPI3eZvEHP2GgPD9kEykY+ZvArPY=
X-Received: by 2002:aa7:980a:0:b0:677:bb4c:c321 with SMTP id
 e10-20020aa7980a000000b00677bb4cc321mr14744292pfl.0.1688481886337; Tue, 04
 Jul 2023 07:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230704134800.204542-1-hugo@hugovil.com>
In-Reply-To: <20230704134800.204542-1-hugo@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 11:44:34 -0300
Message-ID: <CAOMZO5DnEL=UFO_Y1N2o9rAW3d+BddavNWCrVi7sVf7Q0xmdxg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som: add missing pull-up for
 onboard PHY reset pinmux
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 10:48=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> For SOMs with an onboard PHY, the RESET_N pull-up resistor is
> currently deactivated in the pinmux configuration. When the pinmux
> code selects the GPIO function for this pin, with a default direction
> of input, this prevents the RESET_N pin from being taken to the proper
> 3.3V level (deasserted), and this results in the PHY being not
> detected since it is held in reset.
>
> Taken from RESET_N pin description in ADIN13000 datasheet:
>     This pin requires a 1K pull-up resistor to AVDD_3P3.
>
> Activate the pull-up resistor to fix the issue.
>
> Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite VAR-SOM-M=
X8MN System on Module")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
