Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72F97154C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjE3FNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjE3FND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:13:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A20E9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:13:02 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6af873d1d8bso1607379a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 22:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685423582; x=1688015582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik47P3Etu0ZN7dEwfdNxUGGecWtWJVtJjhAgZY4CeRc=;
        b=JrRIgBCXlGKvhc5UxmkVzZIpIZUdXfe367TgIFdXkccrdF2wTkNY6svU+2j5Ba9ozM
         FbkDNuYjyKhSvQYFEaNVtg8OfhZGctKUf0Wys+MbB9TrA3QZP1qQm81eY5UKRCrpIhPO
         xt5Sw+YUMtCnM5AevkG4e4q05bw1dQzxyAmDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685423582; x=1688015582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik47P3Etu0ZN7dEwfdNxUGGecWtWJVtJjhAgZY4CeRc=;
        b=eg01olOM5hKbj+ac06Q/Xz5IXqqAvBOfBQq/Rz57CSfi91kJFJ8YDQIqHfEDlatuH9
         jYvSZmqjPl324sqxtgI4jZc39LNQ+EmlSE5YP9IrX0eglQSygc4D+nwo7CeZ1ALMN6lL
         vQYo0ZAkD+GrV3VIQaFQllZSCB6GiH9Oel1bzlvEia5ENn/WJR0rmvL5kwXst3Eeo8rZ
         uBunZc+oz2qncZTY89Heeb33YAD656HplOORFetIk3qrSvIP5xCqzOCIQSCRFHl6Ps4V
         tEo0TCfhWjsieEwlWOdXkn7/v1yraWhMNZc9QpCJ1N8iMXKuiJTxWoluDDEbC++TlAbX
         /H9w==
X-Gm-Message-State: AC+VfDyqvuf5w2ZEJA5eI2+lPWycjQANdnILS697D+264rh9D2ssdiNF
        yCHIM7+bOt4Ia250MgvdyZqBWDhoJKquCx0L2k6P5Q==
X-Google-Smtp-Source: ACHHUZ6D3pnibJwrsrNe/P7w8YfHG9D5A4Pr78OnB3gLm1pFudeiYi7fn3Wi3/TlXT8sOlauUIcLPY87SO1MD2I+Mpo=
X-Received: by 2002:a05:6830:204b:b0:6b0:66f5:2817 with SMTP id
 f11-20020a056830204b00b006b066f52817mr518098otp.34.1685423581739; Mon, 29 May
 2023 22:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230220093343.3447381-1-hsinyi@chromium.org> <CAGXv+5E4_k1jKTnninYkuT6Tf=skB00AowHpM+hc8j_VFM-RfQ@mail.gmail.com>
In-Reply-To: <CAGXv+5E4_k1jKTnninYkuT6Tf=skB00AowHpM+hc8j_VFM-RfQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 30 May 2023 13:12:36 +0800
Message-ID: <CAJMQK-hnK69iVJhqW_8UtKHHLQ3608Cb74Jk_b+xHH0BBu4yVw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:25=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Mon, Feb 20, 2023 at 5:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

hi Matthias,

Kindly ping on the patch, thanks!
