Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B073005A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbjFNNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbjFNNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:46:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384752109;
        Wed, 14 Jun 2023 06:46:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30aebe2602fso4772399f8f.3;
        Wed, 14 Jun 2023 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750403; x=1689342403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsXPCS4S+gkMSRcPDjjLvSrDD3Jt0vvETwXhvxIBuQQ=;
        b=AgVFd20bYOSqBI9tB+SauZvB7LGobLGra3s/n0OVHOKvTLEg4/P8rpoSedrfyIh2Wt
         S7CitgB2Ld3oDPyu2C12hPZX5r2oLCeZYemVu6ZVDpNNCWCtPrmTw1zPUZKZpQsfLIwE
         n9X9giCCKLS2krzRiHsAQ6zQUWFTTAiIAJKpe56xo0tX/S5GcjB98z58C4Sa+Ay7eCk4
         /Zbb7qdHxYPu5eWxge2rt9NXTFJFHJipeCY7zhME1EGm0HeYSQZt/hkXOt4V5shLbeBM
         ZaGhDMbx/8/ZozehJRITX/uzLIZDFifnH9csTl5uIaRHerkLnlANd2VtNZz/qlCWu3rb
         8Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750403; x=1689342403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsXPCS4S+gkMSRcPDjjLvSrDD3Jt0vvETwXhvxIBuQQ=;
        b=Xl2t3jVJ9yBMAuiaHaju79/aXVBbwizp2ffkGuSfw7dlHfdRrm8EqB4fNmQjVhEZSY
         gb1NWbrPDZSeZ2W+yNxirzLjtRGjmYRgO2atsbOpw3saDyqe2CGPh7fqfIm/bB+FOiKG
         dXXexrYadWsDeeiTNvgyfMNX7n3goPu3dcMS9xXavzZAv7d512AbcLpZeqhaMOnpm2Dk
         f8r7jEe09Frc8qfIlHNgVWv5kHneWO7CJVut6bh5puMEm768vJSp8dA40SA72IYNm4/G
         HRP9KFoShJUZ5G1ZBaD17U04vQuS+LnaZCvfggOe6f9J7kow2ITVKssVeDPIKrzTzAnU
         3PRQ==
X-Gm-Message-State: AC+VfDz9q7BAOZmiVjELMAXkPnL+KXXsX0p2qqGDLoAyKTYEM0b7TSM1
        dacWGc3bhXD0sQRvor5Q9ZhLoQaHCrOeoQs4jls=
X-Google-Smtp-Source: ACHHUZ5/a1agGyzH+7UdKzBbR6rQoRlUf03pBxykVvP+gegu6G9JVVhddiMd/doQnEJC9JArEXS6+wuJll9KrHpX7NM=
X-Received: by 2002:adf:ce0f:0:b0:311:b44:2d74 with SMTP id
 p15-20020adfce0f000000b003110b442d74mr1119877wrn.0.1686750403225; Wed, 14 Jun
 2023 06:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230612232301.2572316-1-azeemshaikh38@gmail.com> <87fs6ufq5r.fsf@kernel.org>
In-Reply-To: <87fs6ufq5r.fsf@kernel.org>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 09:46:31 -0400
Message-ID: <CADmuW3U6PpAhiOW-w55LcbbtmMXp5Wiq57MqZTgq0gDqj4G5vg@mail.gmail.com>
Subject: Re: [PATCH] cfg80211: cfg80211: strlcpy withreturn
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 3:40=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Azeem Shaikh <azeemshaikh38@gmail.com> writes:
>
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since WIPHY_ASSIGN is only used by
> > TRACE macros and the return values are ignored.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> The title should be:
>
> wifi: cfg80211: replace strlcpy() with strlscpy()
>

Ack. Sent out a v2.

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
