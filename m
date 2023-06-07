Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253F7261A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbjFGNtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjFGNtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:49:15 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B41BC7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:49:13 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33dae9244a1so2574025ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686145753; x=1688737753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko6xuu8UoxrurbfacVb4Coj+CWHhAb4UfD8neO3dRrU=;
        b=lhs0DsNF8AZ4tMcx71zirvrG1WKCluOS6pk/yo1Nt5wCfE0Nf2vQ6fQyG+3v16awIv
         b/GVvwxFTFz8hX45UOq/hroACA6ZAhxBj4B/tJhWC5ePhQj1+Zwnwz6SP56nNJbqtG/U
         3nXMJEoAgayqVcOzjnscDxfgCh3TTOJxugz48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145753; x=1688737753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko6xuu8UoxrurbfacVb4Coj+CWHhAb4UfD8neO3dRrU=;
        b=J9u5Lt6XGU7PvU6i3Y8CG2KHht151xlxxBiLvzdJrW7ON5gKc8PLNmliLhOWPwKImr
         HcZKicegR/YuG2E1OUYc0W+SAuJlLVvGn1IYJTvnev0RoowI1d9wjfdyK8UcN39JnIUc
         uKHjGCjHsP4sXu0nm5v0UERKu35CHnsujbh2kokIdEQrcymaHRsPvOe3e/yghGaZMCYs
         wR8Wpd5tyC6DafXOiHBcWJ2hj031RnXD5AnvwUWtmdr5QtLdVjOZGe4GPErShdYAM1zM
         Uzo90eAV+tUtzTLt6syzIekvxj2zk6OxCMDtB/bOujzzuYt4Xl6DcSpnauLkzkL96Kp1
         YOpg==
X-Gm-Message-State: AC+VfDwRSLaKchIOGkfrsaEfCwkkLVAN6Le7iz7WK1MWerU29gZUUJhV
        X3Dr08IPeAbECtWokNo9OhLQgmf0OFIlz5vsFWg=
X-Google-Smtp-Source: ACHHUZ41PUwTsDpdieLScVAC7RAT7BHbjKJWb1ddgNv3L/VkQN8/G5SLsmfKo9qnrd5+Fd1haJyXXA==
X-Received: by 2002:a92:c010:0:b0:335:2dc6:da4c with SMTP id q16-20020a92c010000000b003352dc6da4cmr4520106ild.6.1686145752819;
        Wed, 07 Jun 2023 06:49:12 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id w15-20020a92d2cf000000b003350c8ae201sm3719305ilg.29.2023.06.07.06.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:49:12 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so134185ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:49:12 -0700 (PDT)
X-Received: by 2002:a05:6e02:2186:b0:33d:4e7a:3dac with SMTP id
 j6-20020a056e02218600b0033d4e7a3dacmr142983ila.3.1686145751615; Wed, 07 Jun
 2023 06:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230607102123.219862-1-laura.nao@collabora.com>
In-Reply-To: <20230607102123.219862-1-laura.nao@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 06:49:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvGGvH5ms0-v3aUuqg2Wurks69nCQ9ytcPuTAfua2kig@mail.gmail.com>
Message-ID: <CAD=FV=UvGGvH5ms0-v3aUuqg2Wurks69nCQ9ytcPuTAfua2kig@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B116XAB01.4 edp panel entry
To:     Laura Nao <laura.nao@collabora.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 3:23=E2=80=AFAM Laura Nao <laura.nao@collabora.com> =
wrote:
>
> Add a panel entry for the AUO B116XAB01.4 edp panel, found in the Acer
> Chromebook Spin 311 (CP311-3H) laptop.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index fbd114b4f0be..5f6297531347 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1867,6 +1867,7 @@ static const struct panel_delay delay_200_500_e200 =
=3D {
>  static const struct edp_panel_entry edp_panels[] =3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120X=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133U=
AN02.1"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116X=
AB01.4"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116X=
AK01.6"),

Panels should be sorted by their ID. 0x145c doesn't sort between
0x1e9b and 0x1ea5. Please send a v2 with this fixed.

-Doug
