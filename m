Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B76FCA68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjEIPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:42:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94EA30E1
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:42:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ef34c49cb9so182251cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683646963; x=1686238963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fiW2eMPa3JcRn87r8tgH6+Zw6xv+kBmIa1Z3UxaYsE=;
        b=liBfYH3VMjZJNljdRzneVIXYxFCVvNhvCaa9K+zpTNyp3TSvfKZm2kJBKZdtZrhkHg
         Jzu9UQbL7+AMMU8OmlymvReEYlwlWi+hcC+p//agUPD59j6myTKw3isrlNBZ4UZ5hhQE
         66dz8XMYpwnRwahBw1CybEUexL+G77JhdxqKorjS+/gMGredPkW3UzWUdWqpnj77+NJZ
         ian4cHr+/pkGzTHwMSNr0si20dbCuQL58ABSBzdm1tMqqfDtEWkduMk6wZhowpMawwPp
         qL/nJlcXAwOmX1Bz8vH3PTllyMYcHUB2V0eupd+7qcEMs7ZqYQ4PIpl7fkRywe1cHKbP
         VdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646963; x=1686238963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fiW2eMPa3JcRn87r8tgH6+Zw6xv+kBmIa1Z3UxaYsE=;
        b=Dfve6BYj8vZxnFc7wVvcvaxzkBz/SdnBV2q+/jkHMLOwaWqQZCCC0HmLuwmBXITz8p
         Lu4XyjdgqLkIvHwQd10WTHEdKKVuaSuMSU0YR5gUN6V3csmH+0+Ran0pZgr8eNV6T8gu
         0Ez+fZODzZRs20tnLxXmyUOV4taTzucZbKfJRRsH1y+pO0mB0uMh9JtC7HqNYfvPdiTH
         KDc7YXZIId9CdG3LOiZJgS+h7Kett61gdyKkaBoHK7Rt1yQMJJ2PxsmIYBegyRV2g1dY
         FhQsScE/sDkMxHl01xdNF/BnjVjL4Vmi2sKpIGJ0MYRkX+2j1IFYxkOHMT4FMHg+Ay+p
         xG2Q==
X-Gm-Message-State: AC+VfDxfOEBVkRCGSxrAmhkK8YyJKuwKU0a/RKV+iWiCDtKFFPaFUN1X
        A0iFYOns7L5PAdws5SLSMSZn6oWEfmz4V71TgxgeWA==
X-Google-Smtp-Source: ACHHUZ7C7pgU55PCY9BaDVb25aW2mHoo+2xQgp1Pu4YxvFKZXAYbhIAieDk9gBa8KMPxOXLu2jAPL0tYarLvHr5kP50=
X-Received: by 2002:a05:622a:c7:b0:3ef:3083:a437 with SMTP id
 p7-20020a05622a00c700b003ef3083a437mr436622qtw.18.1683646962948; Tue, 09 May
 2023 08:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHwB_NLBLEUiu__fE9F=j0KFssq7Lxfz8WUnbR0C6yi=zsboJw@mail.gmail.com>
 <20230509025153.1321446-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230509025153.1321446-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 9 May 2023 08:42:30 -0700
Message-ID: <CAD=FV=Xp_OoxJH38skQswjK_AWwJ5P2OmgjnXLog9bAht0CL6A@mail.gmail.com>
Subject: Re: [v2] drm/panel: Modify innolux hj110iz panel inital code
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, hsinyi@google.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 8, 2023 at 7:52=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> There is a problem of screen shake on the old panel. So increase the
> panel GOP component pull-down circuit size in hardware, and update the
> initialization code at the same time. The new initialization code mainly
> modifles the following.
>
> a)adjusted for GOP timing. When Display sleep in, raise all GOP signals
> to VGHO and then drop to GND.
> b)Increased the Vertical back Porch and Vertical pulse width, so need to
> update vsync_end and vtotal and CLK in drm_display_mode.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> v2: Modify commit message
>
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 397 +++++++++++-------
>  1 file changed, 235 insertions(+), 162 deletions(-)

Every time I see the opaque changes to the pile of "DCS_CMD" arrays I
feel obliged to grumble a bit, but as I've said before I guess it's
OK-ish...

Thus, this patch seems fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Just to make sure there are no objections, I'll give this ~1 week and
then I'll land it to drm-misc-next.

-Doug
