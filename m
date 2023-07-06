Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8174A5E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGFV0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGFV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:26:32 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4071BD2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:26:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso1318204276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688678790; x=1691270790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vz33CppPYfXOTfLJgPcu9OJ5KBYg5KcTasjmg2ccFk=;
        b=yUdwWPBjmOtznyv9Iu0y+4e/c7Wrkmiu7RwzjoljlH5zctsBWeIGZbnfUaFrPJ3UmU
         JMWKi9Anv5wouvyIHvbf8T8qkIAJrMwTZgnmvsrwhJzI2v21WZ2nHiNF0Kpfgp97s9e5
         2/jmPgcM/KIyCR4puFUlEM2gMOm1YlJ8imux/hQc8/4C9jXhacUckoobZu5/deaaz6y5
         GPNk8/NA627GElidNNNf1scJKIALNLpQLedN4RgVKFny3FI0bgcYHqJkP3D0/zvuv34z
         BxK8Bf+EfwyhBEJvfMroxV3mwD3Y6N/kjHawfNORWGGmJmI9pDA/ztZG62+UIQGRvFf/
         pVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688678790; x=1691270790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vz33CppPYfXOTfLJgPcu9OJ5KBYg5KcTasjmg2ccFk=;
        b=dwWGSo60Tz56Lqq7SK4l4zQafqJDid+uQ/K7MMK4BnMn8LU3chxFz3kN956gN+ZNXj
         inTXUDyxyKplxgKUFJkPr5pdT2eQ3OVFohR3qZS89vaGDjXrsScO9+uTPejhDvNcX+Fw
         8g7lepk2NIRdIa4INsbeY7RZqgdpIwBtYfylr60y6/lUKicyMhhSPw/2TS+oT+J9BE3X
         RA8y+YTD0F2g9YeYt1exTG6c+6cqyEPr+XnB5vOxT/e6n+w9hR1/eEYlgVIXCzFXNKig
         5nYE9fEZVP/NFLBiWNOuWuyA7aF0jrDTRTdBrNJsoEFjkLU1nKp1elavaIQVszaT15Ou
         fvfw==
X-Gm-Message-State: ABy/qLa3yuIumA+zNyrOMYNOrwpwE8t3Fgm+swYhUI9ev4/ZjKqbFkvA
        xAIcbYNZgzKD6CArCxCv691RO7Hga+pji+VCO5qHm9BQSZX+MjCd
X-Google-Smtp-Source: APBJJlEP2wvr+Iyk5E1cmNurC6nLVcPhLGhfHUlpZ997tAXhtTCxv0xTrYKrRIwbCZ/sp9klyKZFRMt/AXGg5FY0XeQ=
X-Received: by 2002:a25:188a:0:b0:c12:29ac:1d36 with SMTP id
 132-20020a25188a000000b00c1229ac1d36mr2834480yby.7.1688678790356; Thu, 06 Jul
 2023 14:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
 <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com>
 <CACRpkdb_6n+CKUHYu5nAtCEKK_VwO2hGUUCHny56oSYt_vTfLw@mail.gmail.com> <CAD=FV=WwRiAzfV0Unk8ipnWJkTiDYraJHAwH+Oq5Q0=4TJ6ESA@mail.gmail.com>
In-Reply-To: <CAD=FV=WwRiAzfV0Unk8ipnWJkTiDYraJHAwH+Oq5Q0=4TJ6ESA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2023 23:26:19 +0200
Message-ID: <CACRpkdZ12GKSXXyT+qqtarPNFn4C6oHaE=ZisGaRYaBySvpFmA@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Doug Anderson <dianders@chromium.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        sam@ravnborg.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 9:26=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:

> Presumably if we wait a few days things will sort themselves out. If
> something needs to happen sooner then we'll have to get the drm-misc
> maintainers involved. Probably at this point it makes sense to wait?

Yeah there is certainly no hurry :D

Yours,
Linus Walleij
