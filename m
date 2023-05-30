Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9D71594A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjE3JBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjE3JBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:01:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313BF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:01:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b02085bf8dso21040785ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685437267; x=1688029267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV3wsCw/FpDpcDnxILFQglJVr4jgnkG2dwwOQEyMFLo=;
        b=lLTGv4U2yc4jzgDmQmuni5WzYscIBSU1MfpO+7SOCbRatT6kY1ZPj2ohePOk2uhYbA
         nOjjECEoVsIPxT18/+8i+yG7wYeqhrwGN+ZcEBa7/3rKkl+AMtitseVqJBtKk2qwfMba
         gZXxtPysv+k++eyUG9CfVlkFflhRlf2vsBOqpLDxXLorAInq33nxHsM05JcSy3zMJfbX
         iKfej4vLYlMgvQ+XAFjJH8Nxu7z7F/ypjG4TK/qgWZX9rYid6UswjqmNDKYrIJh5dnJg
         tl6N4qNHYXtPbULh7O/bA1CLp68xUQBmSrRtEs/77AhE2MHi8AJHKVb85Js9Fv/cjuO2
         r1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685437267; x=1688029267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV3wsCw/FpDpcDnxILFQglJVr4jgnkG2dwwOQEyMFLo=;
        b=dPrOAQoTlNkoFhiQgT9/gBES/5EKScHjoYpBrQ4VDwMJbpI2udj/oHRa4lnsX+ej+A
         JlliLQVFgypPArq//biZUL6KSjgbZ5BfI8LxIwH3jnmYtbt8gQqNaFIe7fdZ+NoUNrJK
         krWwnPHmpWnFBlZOjLyTyb4eKVu4oftVoUtedQWawwX8Iqt0j28C5YLzRVisnZHEmnxL
         JBoE+0lDdI9jxcmt9+GDLQRXm07H5QGgL+eAz6mwf6OwWS2HlJUkuwQYLmFr7YqUCn2V
         +PfTwMvRM3MeoDhxM9iU7uyimjDDqXA9Q6MDHwpInG509goaLKPMAq1JuiXCTSRRNFU/
         pw4A==
X-Gm-Message-State: AC+VfDwzfTECatkYbOPhyZjnjIikyS3bw7c+w5x5ZdIsriz3Ll1+H6AH
        wXCvfHRbR4esrg0dZ4HJ2vyw9jTUbEmrnRznhPUlJuZp6Ww=
X-Google-Smtp-Source: ACHHUZ6SixVI4KMeby83xSx6tSmQBXeDdy4GwBitnN9sH9m1a64BxVXboWuJN5UGHmjhB1FGDc8lipBMmVueZ5Y1x3I=
X-Received: by 2002:a17:902:6903:b0:1b0:42ac:74ef with SMTP id
 j3-20020a170902690300b001b042ac74efmr1472419plk.57.1685437266747; Tue, 30 May
 2023 02:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083546.4831-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20230530083546.4831-1-vaibhavgupta40@gmail.com>
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date:   Tue, 30 May 2023 11:00:30 +0200
Message-ID: <CAP+cEOPWWeUqOvbTi8ukFJYewhLuC+UtD0zSKMJ-0k29yinBQg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Vaibhav Gupta is the new ipack maintainer
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net
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

Please ignore this, by mistake I used `--reply-to` instead of `--in-reply-t=
o`

--Vaibhav

On Tue, May 30, 2023 at 10:35=E2=80=AFAM Vaibhav Gupta <vaibhavgupta40@gmai=
l.com> wrote:
>
> From: "Samuel Iglesias Gons=C3=A1lvez" <siglesias@igalia.com>
>
> I have no longer access to the HW, nor time to properly maintain it.
>
> Adding Vaibhav as maintainer as he currently has access to the HW, he
> is working at CERN (user of these drivers) and he is maintaining them
> internally there.
>
> Signed-off-by: Samuel Iglesias Gons=C3=A1lvez <siglesias@igalia.com>
> Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 207a65905f5e..49e384399ee3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10106,7 +10106,7 @@ S:      Maintained
>  F:     Documentation/process/kernel-docs.rst
>
>  INDUSTRY PACK SUBSYSTEM (IPACK)
> -M:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> +M:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
>  M:     Jens Taprogge <jens.taprogge@taprogge.org>
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  L:     industrypack-devel@lists.sourceforge.net
> --
> 2.34.1
>
