Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50993746376
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGCTmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:42:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F56E5F;
        Mon,  3 Jul 2023 12:42:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992e22c09edso298011366b.2;
        Mon, 03 Jul 2023 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688413355; x=1691005355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHpbgFKpTD8xyMMsUKJDP7HTZGPJXYiLdAwhhyFxXzY=;
        b=dhUIdSVuPvke3OcqobcMYvUxlZOEnd7zXrHUiOCrzFwD1BnYRl+ejs1qZUqo+s2ivA
         Ldj6xb4nF1Gdu+uPMp1Rcagpn5ztvr5+f4rHr3kIjOVYw/PVHCM68wNi/tuTN1AkXZ4R
         yUWHREjXCIAoKSWiyylyt0SC7xDLqL5y59h624IxOqnKczAfQ0w/0ec8QcyWlDE8q+mG
         n89aaTlAex0IaFb9hChVxTATNNFBHX7iVXFjlCMMNYle7KpRj2ONcYjES1p2Z2yVjuhS
         ubt81BBtjMrcU/hSEdM0FFQJAHiDI8xY+JjcHQTdAUAAfjbgq1p7z0LQzupWtCjopxS/
         qkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413355; x=1691005355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHpbgFKpTD8xyMMsUKJDP7HTZGPJXYiLdAwhhyFxXzY=;
        b=J6KKXLJ3Re+rGPbrdBs47W+APye4tr34zJRcYU08kC9EHxwPTwUSB78TUQoQaHU3G1
         NEKLHnpvvQq1Ob71R/4HYJuYgZlPgHbOYmJPL8yZvGt7Q/W+SYVRzUty70Wd0xeTQgUJ
         8XAi8d5S9L/QEkHxRMpc9qHt1J0Vss377BkpKRcMHmnq344vOBfPVHG9gzlsQL2ApFGn
         VZZNFf2Ze9UORpfnTY7qkexagCcQ+oHLWKzA/HceiBrg8QRDwew/fKND6YgB3f8B16ri
         TFUBt4HYDyqZaw9Pa/fXMpuzgOK6pvlysez4KvVH0TbTym42e0KufckTspqtg9h697u5
         QJ3Q==
X-Gm-Message-State: ABy/qLbYfOzxw66xg76BmLXwCDLiEN/dOz6bz5XDT/s0Eup8Md1RZt3C
        qEgz8XUoysrrdvKbvaef9H+3bAYQ3aDEPNQg0q7JRbhwYQA=
X-Google-Smtp-Source: ACHHUZ5bc6b1LsZSjCtzxjl5rhDrJGvOmXYyTdGOEXruOouI2c8QbFGzhwvOKHtrOZ+AIBlJX+hBQ/tkr4Xx64GJJII=
X-Received: by 2002:a17:906:5fcf:b0:986:f586:b97 with SMTP id
 k15-20020a1709065fcf00b00986f5860b97mr7738475ejv.59.1688413355077; Mon, 03
 Jul 2023 12:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230630121059.28748-1-zelong.dong@amlogic.com> <20230630121059.28748-3-zelong.dong@amlogic.com>
In-Reply-To: <20230630121059.28748-3-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Jul 2023 21:42:24 +0200
Message-ID: <CAFBinCCpK_YWZqP-YX4hNdRHprckcSvVJ7e-Q3tzfPabWULTNA@mail.gmail.com>
Subject: Re: [PATCH 2/3] reset: reset-meson: add support for the Meson-C3 SoC
 Reset Controller
To:     zelong dong <zelong.dong@amlogic.com>
Cc:     narmstrong@baylibre.com, p.zabel@pengutronix.de,
        khilman@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
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

On Fri, Jun 30, 2023 at 2:11=E2=80=AFPM zelong dong <zelong.dong@amlogic.co=
m> wrote:
>
> From: Zelong Dong <zelong.dong@amlogic.com>
>
> Add a new compatible string to support for the reset controller
> on the C3 SoC. The count and offset for C3 Soc RESET registers are
> same as S4 Soc.
>
> Change-Id: I65113f6a90545cd46015abf60b4bcb63fa148267
with this Change-Id removed (as mentioned for other patches in this series)

> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
this patch gets my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
