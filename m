Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E16EC281
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDWVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDWVg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:36:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF64E6D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 14:36:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so512207166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682285817; x=1684877817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+3ip4SFD8EZ4AogSeaajIrcWIDGjTnupCvB0Wex6sU=;
        b=BiFu6VDoYcTeU8wvs0mVHTjYbn12mqsHHm0FHm/LqRVi62qlw+bF6qVmX44l0LAtiL
         knNGqM1HGnzS24x0qHFzgmYGukcFYpJj4CnoSJYkY2tp4qyCIYuFb0CpsBL2/t+feJ1Q
         BeClrpyYt2MQ8BLLoxS8pjvFhnkBxpGOsOM/bP9Y1L5XDOlsEH/j1S0JlgMgFft+cg6O
         GIOFnyblmF2stvfBm2Bhmr5qjJRm4VL62pmbsJdsHi/vDbzkG9cX1OpG/VdQz5PneGRy
         zI9i4Ne3tweszm5HIi7mLfHGvCDIdq0spz9FnRLq5YiAwUb/rLjkCb+tXHQdHhK2682B
         TpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682285817; x=1684877817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+3ip4SFD8EZ4AogSeaajIrcWIDGjTnupCvB0Wex6sU=;
        b=fVzKLB13w5Zugn2WOC7EYzcAFAD0IQsNPQjX8AF60CqTxz3OT9mT6fo8eBssXe4jxy
         yLjvCoD8MZS68FJRV/mrpPOTmdqeSmgMPlGftdP2P3UCLdPubYTtINsGkj1McmGMRsRC
         zYvr5emsF3riMZ9kajVBXqujuytl7UhZjHT81V7a8GQMHXCBlKjvCS74PqbUK0ytR7zG
         IsPwKk5Ae9gUYo+OA1NFoa9sJdbFdVZMewvR5DRxF76JYnhRlv33eAncjrI78wYMjK3O
         8Mb3O8N3Lg15bwipBpQ8GykEdpJqERW+sFugbcOgOmnXTT2myyzW8qvqlYS90NWqTjhP
         dRBA==
X-Gm-Message-State: AAQBX9cmB5cttKhJbaQlbZes4pTkJ/6v44tyBg91xOEuta0mSkpDJE8m
        sjGiG8jvXmxCgv4hRCefnfK2XOn+Ps6MVmuQRznAIuiwYKM=
X-Google-Smtp-Source: AKy350YEV07e4rhC2sKUikbC3KSbrZ0KxnyPPhrSLqzhZHnP47SzVPucdMXG0LWYPJZq5gUmWL1XdW9YM7KyAkHFSBk=
X-Received: by 2002:a17:906:9b85:b0:94e:fe77:3f47 with SMTP id
 dd5-20020a1709069b8500b0094efe773f47mr9464495ejc.67.1682285816723; Sun, 23
 Apr 2023 14:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230423145300.3937831-1-trix@redhat.com>
In-Reply-To: <20230423145300.3937831-1-trix@redhat.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 23:36:46 +0200
Message-ID: <CAFBinCDQRwaTNLeHD973gD-g9aHOwnu+G+U2di7Tz17LPT2DXg@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: set variables meson_hdmi_* storage-class-specifier
 to static
To:     Tom Rix <trix@redhat.com>
Cc:     neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        khilman@baylibre.com, jbrunet@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sun, Apr 23, 2023 at 4:53=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> smatch has several simailar warnings to
s/simailar/similar/

> drivers/gpu/drm/meson/meson_venc.c:189:28: warning: symbol
>   'meson_hdmi_enci_mode_480i' was not declared. Should it be static?
>
> These variables are only used in their defining file so should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
With above typo fixed (or with a comment from the maintainers that
they can fix it while applying):
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
