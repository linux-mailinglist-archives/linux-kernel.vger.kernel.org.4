Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC34F6D17B3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCaGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCaGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:44:34 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D593FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:44:29 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id c1so18340886vsk.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680245068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWfVdAaT5bqBLuvVbOuWkJn2HiJtSGwDr94VHpojYsg=;
        b=BfRk0Yy5991YG/5P+GG3VGVIVfs4eq9KjGIEaqor2VTRbZvDK3ijPKhcp2+dGHKCTr
         4LJRsJg6d+79W0jKhnlVJLMOLWYTS6G2sVCaPiAPIkb8iaH9p+26SuTdaHHiK/gdrFEu
         oUPHQ4Kwqk67Aem8jzNJOL2xtcMZ/lNTGb+VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWfVdAaT5bqBLuvVbOuWkJn2HiJtSGwDr94VHpojYsg=;
        b=OwuoxqivnYb7e6EP8vz0Ax8YPjDEqaYP1kDmE0iZBk1Ff86FhrwzIZ2/eoVU3q10Eu
         S64z3PI5QIYF0uagqrmZqR+HYQTKtiwUek5fZiEbO/s8sDSY9FQN/gknPOec5NydI5us
         9nKuh5YP7fnmOlB8vsHDx8CjBeUOxA8oaWOsDf8Zi1BSb84T08bllGsA66WsCF+zUa3D
         KzeraNb2VgwDjKc37lm8YIkupkpwsx6WnfEQYsBARizRRlarq+KTdKIUbzO3FlGdsvG1
         Stv3L/GyiOzRIOZSNHOWpoH7NSNZC2MamAI/itPAL4rg/N69LdRKKqZPmNWDh4+6I1SD
         klcg==
X-Gm-Message-State: AAQBX9dU+2Bhxc+sH0THocWVwo/u0AaVZ0C9ZJSzj1uVgpryepdals7i
        pPKvoXNbWVAv2VdkQoY8cQXNmG7gaGXIOcT3Syp1ZQ==
X-Google-Smtp-Source: AKy350bbcCA/ZjagnuewyGDlO1QmAU/PfBDh9GKuOIQVSkzqdQjA3UIC7YYzhrUF5aEqR3+77hMCXF5P9g2iWg9vj80=
X-Received: by 2002:a67:d493:0:b0:426:a319:a226 with SMTP id
 g19-20020a67d493000000b00426a319a226mr10079472vsj.7.1680245068610; Thu, 30
 Mar 2023 23:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
 <20230223145426.193590-5-angelogioacchino.delregno@collabora.com> <CAGXv+5H7ADKUu1bsGrF5F-EgJBM6WW0N+AFw=m+hH_00QGHDew@mail.gmail.com>
In-Reply-To: <CAGXv+5H7ADKUu1bsGrF5F-EgJBM6WW0N+AFw=m+hH_00QGHDew@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 31 Mar 2023 14:44:17 +0800
Message-ID: <CAGXv+5GnbP+hEy_J+vNsQgwr6qK5oQpDCaszqOkWmrcKfupAgw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: mediatek: cherry: Add configuration
 for display backlight
To:     matthias.bgg@gmail.com
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:52=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Thu, Feb 23, 2023 at 10:56 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Configure the hardware PWM for the integrated display's backlight:
> > all Cherry devices enable the backlight with GPIO82 and manage the
> > PWM via MediaTek disp-pwm on GPIO97.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> with some additional patches to enable the internal display.

Matthias, could you pick up patches 3 and 4 from this series? They are
independent of the other two patches. Having them picked up would reduce
the number of patches that have to get carried for testing and resent.


Thanks
ChenYu
