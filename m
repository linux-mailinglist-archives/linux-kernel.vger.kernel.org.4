Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452670FFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjEXVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjEXVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:13:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D281A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:13:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33164ec77ccso47185ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684962786; x=1687554786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT9Y/dwgBpalMa3LjWqrqX13zFQiiWk7YoUb5Dh/rb0=;
        b=Pw2sY0kk+uA0lgLXJ4QrG1lbzK+hLwpi+0Liuc2siJTpaf2jce9WDPb8zfEZ94bP7O
         EwTcsnMR1S1aTzjAc6AGBjK/1BDaVBk7mKzM2Iy3nSK/ky+tUiWdnA/oNElEszT4sUv1
         XAImeI5oyKAzxe0XXyByLNaiKV4nWL9L105baHwfl4c09HRDi4o3+Zc/1qXLikY0KXXb
         iuZmHBZvyHJFN8iRb3bDm+GLyOlZj8GqrEMRz+IR9B78HzJJ6wuJ5hwIZc/hMBEN9jHO
         ZEIqBBXPvrj6UmgEjupNGYhVUHQwqWf1x+TDAmgl7ygxOyTQabqpmuVzkOerPMcH+VgS
         gJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962786; x=1687554786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT9Y/dwgBpalMa3LjWqrqX13zFQiiWk7YoUb5Dh/rb0=;
        b=hnBcjjVHYmcwZOjmqJ3Jy4PgjQGGsQMCk/E9MZe82EWu/jWySwXsyca34E+tgYANXG
         +/doMZEYyxzGNkDBxecpIUhsWZVCS76OgJHP/WA4mrjwBlU9YGHpNvCB0dlGcJCz2FLy
         mvCjFOlzZwvLmWhTN0g5lj1Sb8utOJkdW/joOJ99rvPamRCzCdFaXsdvbogqLgsl00LT
         L6VqiJjNPG2+enkl6CKPHq5qU6cc/L7EcJVPz+jafFRfcGj3wHnKk793X/LpIEj9X8Gz
         Re9raGfkGATQ0F/0NY47B+YiwJ7SRhKcsB/ZmnjeuVJwxDJcMtCViFE6a38VwahUndZR
         URsA==
X-Gm-Message-State: AC+VfDz4ZZ+/s1f+pkLmOeRWXPmbIj5xS8JuixvsqeJ40GpogTZBO9+d
        B05DcE1VQMNm0U1sEJRbOAWAsBvy4JD8O3ddIgbi/w==
X-Google-Smtp-Source: ACHHUZ5m6ZRnMjWwhSIGN0CAK0LQtBjTMOAsgHa9yk09PFD6/CRPJXTpFlgBJC6zrARysCmio+4jKLhu7Ni1uXqlG6c=
X-Received: by 2002:a05:6e02:17c8:b0:338:3b6a:4719 with SMTP id
 z8-20020a056e0217c800b003383b6a4719mr50834ilu.17.1684962786520; Wed, 24 May
 2023 14:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
 <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 24 May 2023 14:12:49 -0700
Message-ID: <CAD=FV=VDDWX_LXjwxgudS38HG=+-gei2Xya7XiqcxjUTy90maw@mail.gmail.com>
Subject: Re: [v2 2/4] dt-bindings: display: panel: Add compatible for Starry himax83102-j02
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     daniel@ffwll.ch, neil.armstrong@linaro.org, sam@ravnborg.org,
        airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, May 24, 2023 at 12:45=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The STARRY himax83102-j02 is a 10.51" WUXGA TFT LCD panel,
> which fits in nicely with the existing panel-boe-tv101wum-nl6
> driver. Hence, we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)

nit: bindings usually land first, so you should swap the order of
patch #1 and patch #2 in your series.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
