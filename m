Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62B735E99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFSUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:38:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F710CA;
        Mon, 19 Jun 2023 13:38:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-518b69d5b5dso5509582a12.1;
        Mon, 19 Jun 2023 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687207115; x=1689799115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtpLE5qHPtOxz3JvnqVEB0bNkepX8kdOysdckRMyYgg=;
        b=rvkLawxz9hc+T0TGLFdmddivEyr/FgkvAGyk3Nz/wHgxDuAu4DgeqxTMFeEaIi8z5J
         MCFO6egg5SHEO5wprUe4CJQBfLkWJCjxXD8pGOvb5LeT72XFiNgCQfv9c6y+CNYUJNSe
         O/IY8PLuUB2mOEfHzX4V3dLLibRmAy6bUrsyXNHwOwkeaPjRR6N5D/4AMTqPwGmBhjJM
         TfXisLpOdbIJgOYQEx9A7YycweOmNLrsbf4YJGEV42Cr3LC+V0lKwAxPPs5ED5Zv/PfL
         Y6nL9CqtzfVwoHdZ7tw2Pj6K1uV/gihO4RmpOy0nCS5HbnuyJHs3aaH3OZrkyhF6iH+D
         uBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687207115; x=1689799115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtpLE5qHPtOxz3JvnqVEB0bNkepX8kdOysdckRMyYgg=;
        b=kDuIbmtV4CMrwVcEb/bPzwquFZXiJV/CqnahZFrLT1zfrhALXCERzuZvZopsTpDYCo
         enLmw8y5KtKnkJvPjlUEmLuERKgpfh/i8sdSCx3sX9WFtEZC7fN/4YQwAGFJOkX36Xju
         qrigStA1poCi7o4TyM9R/Z4LTJ1VQVMy+edW12CpQESX+wJfnvUYDDyWMl3A7p+3UFcI
         j3g88aiDSTWA+iwYiR8ZszTXRJWma1WuLnROHIv5bfB8OoIbwXZkIJ+XGmzY79PsXy37
         o8eDLyeinkUFuK/PLbtXSttDxOc7TT/Lw7TdynhvPb8aEQsOlxDYvb5+xtfU4eNblGT7
         f24Q==
X-Gm-Message-State: AC+VfDyTHpAOWrqCou0Gvj6kKoqlQv4b8IpGxEgHNjJ/jljRCRJevp3T
        u/gSt/t6CVVRj38S/p1Lcbab7bsQkbxyQ50qUM0=
X-Google-Smtp-Source: ACHHUZ5656w+75CZwaycJ08wqwHTB7XWmi9eQwSvdSiUDoZni5WOjx/IqOE1/dpvNL7oM0FrDtWW3CMsfhXDuaV60vA=
X-Received: by 2002:a17:907:3f17:b0:969:93f2:259a with SMTP id
 hq23-20020a1709073f1700b0096993f2259amr10368612ejc.73.1687207115503; Mon, 19
 Jun 2023 13:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
 <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com>
In-Reply-To: <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 19 Jun 2023 22:38:24 +0200
Message-ID: <CAFBinCBsg8jPhpqSOr9w2JhwN5YjPeME1Uye7meSY8h=b_N4Qg@mail.gmail.com>
Subject: Re: wifi: rtw88: question about SDIO RX aggregation limiting
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
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

Hello Ping-Ke,

apologies for the long delay.

On Tue, Jun 13, 2023 at 4:20=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> The unit of BIT_RXDMA_AGG_PG_TH is 1k bytes, so I think you can
> set mmc_host->max_req_size/1024.
I tried this but I got a result that I don't understand.
I've been testing with three BIT_RXDMA_AGG_PG_TH values on a SoC that
can handle 255 * 1024 bytes. Each time I connected to the same AP and
downloaded a bigger file over http(s).
BIT_RXDMA_AGG_PG_TH: biggest observed rx_len in rtw_sdio_rxfifo_recv()
255: 20968
6: 5122
1: 1602

The biggest rx_len I have observed for BIT_RXDMA_AGG_PG_TH 1 looks suspicio=
us:
My understanding is that I shouldn't be seeing rx_len larger than
BIT_RXDMA_AGG_PG_TH * 1024.
BIT_RXDMA_AGG_PG_TH =3D 6 is within this limit but BIT_RXDMA_AGG_PG_TH =3D
1 isn't (I'm seeing 578 extra bytes in addition to the 1024 bytes that
I was expecting).
Do you have any idea where this is coming from? I'm worried that we
can still end up with the problem that Lukas described but seems to
not have hit in his testing with BIT_RXDMA_AGG_PG_TH =3D 6

> I wonder why 0x6 works on Amlogic SoCs. Could you or Lukas compare perfor=
mance
> between the settings of 0x1 and 0x6?
I can do this later this week but I'd like to understand the above
results first.


Best regards,
Martin
