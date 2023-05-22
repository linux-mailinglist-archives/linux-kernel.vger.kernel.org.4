Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A170CA87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjEVUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjEVUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:13:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04093CF;
        Mon, 22 May 2023 13:13:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso68713a12.1;
        Mon, 22 May 2023 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684786417; x=1687378417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZNAvuoSua7WwcqydioYVqvGkj4SSXZS2il2MPGqL0M=;
        b=OhMQ4gNMZw7f/4lFXSoam6/8avsvMtG1EMKwbAGYEVs9iDjNQHcQN6gNNQBR4SJQ4O
         v9r7FBZTjB+179gs+wkfVthGcbpFc4sVVb6k+ReRb0HPesCP+bGJsGcKvNnd+t44zWBl
         ArWSoO0dnUOvwM8upDZBSev0dAkZcQK7bCgmlFrTSp4CF+ilNJFzZWo7mAVoQgaBA3sx
         UjE4L2Dv1Kr5sYUP+Vgjgjtd4Xn8HAo/JZu9KOIlT3x/dv+YQtWZyWOnZ/K/no/3h/bb
         D9t14DLURXvpmBfCIKN2oyjyX4KyX560jkST9SVD+7n0QcCeb8/VO3Kcu9Ct7QFGgpiq
         ehFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786417; x=1687378417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZNAvuoSua7WwcqydioYVqvGkj4SSXZS2il2MPGqL0M=;
        b=NEKmg9SYxZGwcgN4ctRnP9BUGpYSE2mUDP61XvCRUMBxa3H3NZm7UJwQ0vRrDophOb
         ApRFBrB7YWeqjPQ0PeZf77qsI3xqdlhQh5IaGC2Jk/KrFqncL2F3/8pcwcmI5xm/jbqB
         44GCBWJ+jtlAePSMHMi+3SqgBRMi9/X5zV2B6CGd55zW9/OKwhg188q72jUcXkU1hmyv
         AodnyZrDDuAVe/nxnf0pBPX474T+YOATg/gdMkgXAjN3ePqfVUGY6qeQwSuCL2kuuAep
         QlhQyO8sSp2o3NLx1yn5zwx5v/1AivTZEP6zHsjPH6da+nMhjnlnV6VWaCQyQUk3V+ai
         E0JA==
X-Gm-Message-State: AC+VfDy7yRIUFaw5yQ2F0KiYKITWtfFR4ZSVWzvMEi5jhZARc5mye24w
        ERS+0zFjm1qs2q66uIWP5YptkfqV4dRgXBl108bH89CK6Wc=
X-Google-Smtp-Source: ACHHUZ47dJhLso1KMARR9qtY2jRHlSSsf8sMqLKqnDK+v9DK7ypDGWN2y1WGJF8YCk8u7voVB8nV+4Nicg/rI2lPfeU=
X-Received: by 2002:a17:906:4788:b0:96f:57ba:4b56 with SMTP id
 cw8-20020a170906478800b0096f57ba4b56mr12944986ejc.20.1684786417236; Mon, 22
 May 2023 13:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
 <20230518161749.1311949-5-martin.blumenstingl@googlemail.com> <c52c11c712e24e1fb783c2ce1251aba5@realtek.com>
In-Reply-To: <c52c11c712e24e1fb783c2ce1251aba5@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 22 May 2023 22:13:26 +0200
Message-ID: <CAFBinCC+Lz7uGBAuK5gQ-2ngutcgNG5EN4TTdM5tdFQB5uXtqw@mail.gmail.com>
Subject: Re: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the
 SDIO based RTL8723DS chipset
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
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

On Mon, May 22, 2023 at 3:49=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Sent: Friday, May 19, 2023 12:18 AM
> > To: linux-wireless@vger.kernel.org
> > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; ulf.hansso=
n@linaro.org; kvalo@kernel.org;
> > tony0620emma@gmail.com; Peter Robinson <pbrobinson@gmail.com>; Ping-Ke =
Shih <pkshih@realtek.com>;
> > jernej.skrabec@gmail.com; Martin Blumenstingl <martin.blumenstingl@goog=
lemail.com>
> > Subject: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the =
SDIO based RTL8723DS chipset
> >
> > Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as well
> > as the existing RTL8723D chipset code.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> I'm so surprised that this small patchset can support an new chip. Nice j=
ob. :-)
Please also take it as feedback/learning for yourself and to your team
at Realtek:
In my opinion the rtw88 driver is a good piece of software and it
shows why it is the first choice that Jernej and I had in mind when
thinking about future RTL8723BS support.

> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Thank you!


Best regards,
Martin
