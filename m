Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21066D64CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjDDOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjDDOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:09:31 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A22720
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:09:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-545cb3c9898so540414727b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnWzTfCBouLvNFIttgdZiBeapl1jQzHQOa2b0uZW+Yw=;
        b=KMcOqCDLEz4aCPi34/DOPsImPsfw5ZeY0wTsPwjTfIBU/l8v/gfv0G0ZJWuJFgp33K
         CnCFkpUWUid4/EqWu0KpzJp+ofxgiC3yfhwMGkRWrKSwHMCo8Sht4RuLq2QKsImi27po
         bmLfnmR3tU2a8TrgFXHh0jEVeqHtp8jzeFZ8KjQJnFuZGaet0e3zNlqXcLLyGlug3HfB
         5kXM58LW/rqMa+R3QQrJyvjcdlZe21cOub/Rgop8wFGNfXn5lj83IxKTtH42SwuzKLPk
         mKljKuqg7i64XLV7v0JJ31P/xzsGAWbjF+KGl3neksq1QdFpll7etMjjVsEXE1Yd44zg
         gy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnWzTfCBouLvNFIttgdZiBeapl1jQzHQOa2b0uZW+Yw=;
        b=anriIrWq9RIZpmyp0s9F422Clgfo6x60mGJ9xsKG3BoC6v/Ki6//QAEFzVBP1eIsdq
         ogLDf1aC/RQK2qcll3wY5l7zyQaQY9LU5G6cXou0ARVXku/dL/Dr9X4kB3ytIKsxiZO4
         H90doLAULT654qWynaXh3qfFrok4UHKwqE3zwBq+kJkpy1PDWsIQaLlQUE2plyXf6aQR
         96efvVG6K7bqfltt1j/xrb8nBkBneL/BYxB1AJwizUMijcW7kEP1QWpaIZcV+/nIR6qh
         xxfSccC9ItM3JJyHRfQq2CP6TSTDDKr3yeTDakTyi1pLejQFkuTYzGDsCYw5blx0Nxwq
         JKRw==
X-Gm-Message-State: AAQBX9fC8VTbTrjZsx9gB/zsKH1NO9nUg3rVnoJrUWRuFaDGykoPkkAM
        A7Yhfi7EGIrf5h5TNncibA1zGxf8k95O++Pq5LbOtg==
X-Google-Smtp-Source: AKy350bjb0MQOtgKMwAdbyWuoYyDolSgx0NlXbHfkdfgHkYhgyRMawgx1pSPNraaVqhXKvD+86RrDJqLZvi3m6+Ja20=
X-Received: by 2002:a81:a88a:0:b0:549:17fe:17c5 with SMTP id
 f132-20020a81a88a000000b0054917fe17c5mr1525744ywh.9.1680617368899; Tue, 04
 Apr 2023 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230404004501.1913144-1-trix@redhat.com>
In-Reply-To: <20230404004501.1913144-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 16:09:17 +0200
Message-ID: <CACRpkdZh_+TfGZVpj57Y91KXuw=c8xNV1zfONMxYsKuTZKjxVA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mlxbf3: set varaiable mlxbf3_pmx_funcs
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 2:45=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:

> smatch reports
> drivers/pinctrl/pinctrl-mlxbf3.c:162:20: warning: symbol
>   'mlxbf3_pmx_funcs' was not declared. Should it be static?
>
> This variable is only used in one file so it should be static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Obviously correct so patch applied.

Yours,
Linus Walleij
