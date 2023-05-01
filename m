Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB746F3140
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjEAMzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjEAMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:54:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491F310FB;
        Mon,  1 May 2023 05:54:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94eee951c70so400357066b.3;
        Mon, 01 May 2023 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682945695; x=1685537695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAo8dNemyBmZKJzwSHPX9ecfV5E6VcgUCP+zC+HkHnY=;
        b=CmjQZiAOnFAYZR1iJFg1UyrygucofPe4yJvQZt6urfpK26nO91PXdV9f+BMTodzQ5a
         waojkO682ZSpNC/Gm6TIikFr6wmCv34IkWCSU5JckA/cU60IBQCYlK9PETNdTxLTvGC/
         UVKfF4xIHOR7nGLh4Aa/LtSmDHDVlnxXbmzbVrWYvfVygJ8QFPvwWD201twKNrU2v+No
         s02pqU5/lOUbpCWJDC3Zfvrg9PjfxZrWjAlMMfTxa7reOhT6xJn0IhLPIbP2KJ2h3MbI
         us4tajXV4x0denNJFb6rybxgUrunpeKXB7RWyGyIJARx1EVjbAmHGv8odTG6tI08sJq5
         1Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945695; x=1685537695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAo8dNemyBmZKJzwSHPX9ecfV5E6VcgUCP+zC+HkHnY=;
        b=PDDkjJEpRs1EQJk02n9S8VRIq8+ia/lC3QafqpPXNonUwdq/JzUf6SIstlictckJZ0
         Pk4OSdmwFZmJkOCPAIQcGLuxokFSTz4+Kf3Cz3hASHV7w+AwiZFXbuijzYJf2qUTqNOE
         oEnGscEDQN12ix2l4kUD/7tyO6TfZ7QCz0UcucikYAjK1jFxwL89BF/tsYvqf/YObilx
         Dqxvm8pXEhPSi/7RMe47UFZLjuEulpyfY1iuv7fLiRP2GeubdvZ/eYAv+792JRrJSefH
         MdZowDUwmd+SJ+SV8Z2YAwn5lP1k6lI5sqtvXC4kh6aiyddk7szb9L/rL/cezY9tiVyh
         7sCQ==
X-Gm-Message-State: AC+VfDy9yeaH59bo62wfbnblOtYsU0YD99HDjq51S0az5jDMMAeEq8+r
        Hn5wmCml/xoeZE4786uQqVZk0Z6lbFkg4cC0UhU=
X-Google-Smtp-Source: ACHHUZ6jCwxyd8+8g9DQaMNs8TENzwl0unrTlOJT5nyQ3e8v5ZzqmFvpuxafJO2Nh0+7grkYHMexx/wTu4vKaKPIKPA=
X-Received: by 2002:a17:907:7f89:b0:94f:24d7:64d5 with SMTP id
 qk9-20020a1709077f8900b0094f24d764d5mr13956548ejc.56.1682945695567; Mon, 01
 May 2023 05:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230425165624.11999-1-exkcmailist@inbox.lv> <20230425165624.11999-2-exkcmailist@inbox.lv>
In-Reply-To: <20230425165624.11999-2-exkcmailist@inbox.lv>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 14:54:44 +0200
Message-ID: <CAFBinCBpMbEN5obKeF_jYXYmNX9WJSNfCTKaAd9BpgvuNAt7iw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: amlogic: add Xiaomi Mi box 3 binding
To:     Karl Chan <exkcmailist@inbox.lv>
Cc:     linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
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

On Tue, Apr 25, 2023 at 6:57=E2=80=AFPM Karl Chan <exkcmailist@inbox.lv> wr=
ote:
>
> From: "Karl Chan"  <exkcmailist@inbox.lv>
>
> Add the board binding for the Xiaomi Mi box 3 Android Set-Top Box device.
>
> Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
