Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1972E56F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbjFMOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbjFMOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:12:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4010FE;
        Tue, 13 Jun 2023 07:11:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30af56f5f52so3798847f8f.1;
        Tue, 13 Jun 2023 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686665498; x=1689257498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YTrJ+Te3mEYu4FIASWLgAG2xDCPqUruxk2W5WEUHHA=;
        b=i6oIRqkykFQzwuOvBxb6qZIcBlZ2d6Q/5DRiOjk6giQ4jHLWS7gsZx8Qp6D8cc0E47
         JWYecVEA5KRO8qW8+ugcnxHY40r9mJsSxm5CYUfKfV0Q1pfYY8I+OJ8ckUWmaDlNfQDl
         9IaTq/acmToOnYIRZtdCDpILoinmZ9U3q7iIgwxdBndEKQEp08t21YWu8EQ/ErAvVYBG
         RLZxNyulmYOgdhJh8kgK2M1ESyuLjzEkw0IQs0POZPUxTkS4jqQCeQzOsvhqPEtIy3fk
         QDxRIiCaFqF3oquUkQOXEgJqYxPVpw+MIaKIaJT/m+BsvGydaBHuojrAk5gO4VG6kG8X
         4W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665498; x=1689257498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YTrJ+Te3mEYu4FIASWLgAG2xDCPqUruxk2W5WEUHHA=;
        b=BWgCiYJShmpcOVJK8DLehTXBdD1vHQB+tQ9g6Oux8B6V/vXfakMKsI1S1WgHD2V6kr
         6Rmn5Bt5E89XiBdGa/wv5+j+Tnan456XDUU6EEdXXz0XeU+pXkPSnGFe7QXG1qftzMgS
         gAbf/1qukq3DIjwheFmtKfTZl7GbUwnRWkxZwGUOwqhxTIYjvpBYDyaJ0MQU5DDDB37u
         esqprhzAeE4SBDu1eCS7vUBGtuUz0UxRt/MaqN/AU1g5K5fCGVbED7EirbrihnpWNHtR
         EWvEMKc9PH2jUDeU5Ai5WG1/dyRc2song2t9nz8iXIJ9PW5vjbB5X79drgRo/gLF4X5x
         vwWA==
X-Gm-Message-State: AC+VfDzts1rmyOkuZ2bezIqvIFymeD40KdOGRITeHwJVsDnqt8nlThyl
        9DfmdxYdSNQizlFb0GPZKF9WS7Jh71mON3DJoq8=
X-Google-Smtp-Source: ACHHUZ6HJtQFIWy/NvPsomkdG9TpfAza2q/H2iM1saotn3Rv4pIY5RRCYqqraIW+JKieSgOnaH/kr7HaX+kpOB4ehx8=
X-Received: by 2002:a5d:4f87:0:b0:30d:af7c:5046 with SMTP id
 d7-20020a5d4f87000000b0030daf7c5046mr6347092wru.60.1686665497532; Tue, 13 Jun
 2023 07:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230613003458.3538812-1-azeemshaikh38@gmail.com> <168664533370.24637.14116409515016851485.kvalo@kernel.org>
In-Reply-To: <168664533370.24637.14116409515016851485.kvalo@kernel.org>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 13 Jun 2023 10:11:26 -0400
Message-ID: <CADmuW3XHVjULa9506RwowHoQ2TSB1XCofgQ0=nizpjPZvfBUjA@mail.gmail.com>
Subject: Re: [PATCH] net/mediatek: strlcpy withreturn
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Tue, Jun 13, 2023 at 4:35=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
>
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since DEV_ASSIGN is only used by
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
> wifi: mt7601u: replace strlcpy() with strscpy()
>
> I can fix that, no need to resend because of this.
>

Thanks Kalle!

> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20230613003458.=
3538812-1-azeemshaikh38@gmail.com/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>
