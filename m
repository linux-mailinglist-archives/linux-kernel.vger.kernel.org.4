Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79066C07B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjAPN7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjAPN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:59:11 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B61F5F1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:58:28 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4a2f8ad29d5so381057757b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdmqEadwQhY8LwyQrmgrduPbKJM/C9dg+NjVdK/rjog=;
        b=vEts0zG8SjXqPvmI9cPbfDWfaKSWC4FbMIfl4Nfg/pZa0T8rjuk6Ycg11/ZbqYj5KL
         9NQtS3/ydA9RMrryNwpWj7BXakqrXB3TuEZKNqVrrI2nBSEsX/jBbOTEuSwDa0AEQnOq
         IlryjgUvH0LgC3jYWW3DUUIbOJpL6Chalvi2moupXdMIG5eVIyFGx6LlhdMPo5pXxe5w
         1B261LdURZJcUEfEJH1vfYUIGBY77yp1k3RgiDBcuOLc/7xeCi16q3hsFg5gSdE7cvZT
         v2Tbrfb5eeY4PTswDG1ZiNSnelSJzGXTbQPq+l9aMYxn/WKybztwA4dCe7Kt56854HCb
         tJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdmqEadwQhY8LwyQrmgrduPbKJM/C9dg+NjVdK/rjog=;
        b=W9GJVHBzdwPbLl41vJZU4T3Bm9RA6d6eeGo/Sn4HX0vs4+4TSTcJ5vwMZJSJGmaAm5
         g18rbxeApE5/warbcEeeFBLqdxsk8TUzZkeVcRkEe1ROU4BBmj4p850Eaqm+nb9nrXPn
         B5kKsrsX1HLC5dNcr1fgBT3WvvDQ02OVwA8zYZaWu3TIgwp2Cx+JzPZc6H2Qz81xw/hK
         i81V7hIKIwrZ2moyLrDZ5/wgEy4d0zAVJdZW2QcT7iKou5OPvGvcg8Mt3ZzcGqBYkIaY
         xfhGJKNSyj8DHT2d+9HOVBE3clEHtz4uPoTKnbUc4GfeJzq0Wj2C21o+NcFGqDeHPb/t
         HQqA==
X-Gm-Message-State: AFqh2kqjG2txmUaUoULsGYKDp86d6+zy3hkz9sEKXY7xF7i0O4MAAtEW
        /5PSRVXlK43JSs6slRwh7oYCzzrCYCSsjPtTOoAcVQ==
X-Google-Smtp-Source: AMrXdXuk3lCDgyPv/iBFiIH6yYKI+djJAQTtOQW4/8iFeWmHZk5voPyiEzhF5qJCmRWK+x9otY3kSC2ahQBtp/im0r4=
X-Received: by 2002:a81:b80b:0:b0:4e1:a40a:af7a with SMTP id
 v11-20020a81b80b000000b004e1a40aaf7amr1198749ywe.273.1673877507904; Mon, 16
 Jan 2023 05:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20221231160849.40544-1-arinc.unal@arinc9.com>
In-Reply-To: <20221231160849.40544-1-arinc.unal@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 14:58:16 +0100
Message-ID: <CACRpkdYK_cpeV86uSesyG_64u7OstaxMm+oCbUtz24PcGvPqRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enhance Ralink pinctrl documentation
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 5:09 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:

> This series mainly enhances the Ralink pinctrl documentation, and make a
> small variable name change on the subdrivers.
>
> I've compile-tested all the subdrivers.
> I've tested the dt-binding changes with:
> make dt_binding_check DT_SCHEMA_FILES=3Dpinctrl/ralink
>
> v3:
> - Changes on v2 were put on the last patch. Fix that.

Applied this v3 patch set for v6.3, thanks for doing this
massive clean-up Ar=C4=B1n=C3=A7!

Yours,
Linus Walleij
