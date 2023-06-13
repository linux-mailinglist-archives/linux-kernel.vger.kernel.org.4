Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EBC72E412
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjFMN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjFMN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:26:48 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E21AA;
        Tue, 13 Jun 2023 06:26:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-56ce61769b7so40482087b3.3;
        Tue, 13 Jun 2023 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686662806; x=1689254806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wvnsa4LaCwBU/cmhPsEn3q8zOJvBJxBe8cx4rTNnKI=;
        b=HgSwBp2I6aBOU/IiJgGo0pfsm6MEerBWlNLC8KF2yaQDAuFy4JRezhIzidE+wR1vJy
         B1pyszqIJzNlmATFwZQiHg4462iC5zmGaNA7z13ALLzH7h2O+thCPlWvSXPwEDf+1ErN
         PdX4zkQ4xJEvFjV2tQVGz/3wTbwbQ1sNRKxc3ntHbPxtNx8iwKQFpvp/+wDKTk3QIxYn
         QWJvAvoic1pDMb1gYlPhyrrZfZf5b1HibdPpHsrzL/EYZabGHRI50WNy826MfD+DtVi8
         PNLiJwkwlrnN+a6FT/iwFWJvWNgt9cRvigl9o1hy4hCUbi5aZLJ4falbr88C56slQ54G
         vnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662806; x=1689254806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wvnsa4LaCwBU/cmhPsEn3q8zOJvBJxBe8cx4rTNnKI=;
        b=bHbA4h2M0233/QgOG58fdStSK3167FADJkxJF9RwO81lrUOgrorxs/FXOSgtR7iMxR
         OnsGZiS5CEcSpMrmQzokNCbLgoM/aGczLFCwO5+fGAsg+Z2v3hlQebWDh+Uvx3IjmpFC
         zIZHfUaH64CnKWWsFEqcvQSX1drAxKvlqNWtksGsKTVfsa2T1hXcVJPJaftiflekJyXf
         I28qxilrmOCuTxvn35ktN6wIfq5V8Dg92o93V/xbDMKi2+8nhHEBV4UJDjsJk6Udknpa
         1wXIyUXP98OultOTq6jK9XN7XeC5gD7woWpIdy6GhodPKbG1c2SvIrwJN/mFbsrv6mJr
         d9Ag==
X-Gm-Message-State: AC+VfDwa6J6xiRlHO3VsrU6XiWhRvvxabIOVNPMhB0OcbiW6n2yoyP0i
        RcZ46ad/7duxetNrNr42KImlHyKnpMy7USFLfz1KRZoTweTzpw==
X-Google-Smtp-Source: ACHHUZ66PXNi0hvZZ1awpW13gJnL3DjlKuBBTt86e1ZCg2zaM6ceBLbbebFbgS1Ycwg7ZE74xPevIBEVPyQ2qp44vgY=
X-Received: by 2002:a81:6c58:0:b0:56d:65b:11e6 with SMTP id
 h85-20020a816c58000000b0056d065b11e6mr2107347ywc.8.1686662806503; Tue, 13 Jun
 2023 06:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230613093346.60781-1-kimseer.paller@analog.com> <20230613093346.60781-2-kimseer.paller@analog.com>
In-Reply-To: <20230613093346.60781-2-kimseer.paller@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jun 2023 16:26:10 +0300
Message-ID: <CAHp75VfcAevUrc5XgjYb4qB+ASzOSGif2tP=e5CRzpnBCUumPg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: max14001: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, Jun 13, 2023 at 12:34=E2=80=AFPM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

Same comments as I gave in previous email (for v4).

--=20
With Best Regards,
Andy Shevchenko
