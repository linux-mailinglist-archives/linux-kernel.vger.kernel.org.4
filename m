Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6064C804
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbiLNLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiLNLb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:31:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C46351;
        Wed, 14 Dec 2022 03:31:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u12so18945565wrr.11;
        Wed, 14 Dec 2022 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KC7bZibpl6bCUEysBptYk/+CoWih2Ghy8jjFwskOL9I=;
        b=YB9wlrm5MG9YgIRaqIqk13UQYfwrEtJsMLk7/xytR/Xyqe9yY0Awdb9FcZwvpDsfX6
         DBw60fT6R/yzmxHo5fWjCV22cbF1uVBauUkESqVaZxLFOZhTqF0RWNrJM4pKM0PJYXbb
         SYcBv8FEund/ZBxA6OCedObyGSCqJDgkJEpvWH/563W8UTMF15Or501jidgLSGwKr5S3
         f7bUwbi4nEveHpE0lMieFIhR/dXl3yRTztxVZINt4DGIRdi8ePa/uunkKwKwFGH0hPoY
         D+H2RVOjFxomxV+HMCJYsbDdL+Sf6Jb2YeaegmNzHLM2EfHxpmo2cwlYXuuHTBMTl1FZ
         tZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC7bZibpl6bCUEysBptYk/+CoWih2Ghy8jjFwskOL9I=;
        b=n1X8s+PMseaB67FE9LNv15qjWfsN5X97qx/dpvMU3BOhlOyr+cijRVuI68MCENYFt6
         F5mwjL8M1nL0E9ARsEsqTn+B+J+mUdeNI7ZQKpd+gSirtxd02Syb/zMWRUa2V4qVh0bJ
         vPmfPQanf4WGYAbglx4ga6hkD4pxo6n9M4bFsgJCtPLLfQzBRhGMByEr8XgriMmxVXQp
         g5lgwiQ0eHW4bFOua3xFGIjKDBUUegDiqbZ29040J83PTecOdMp8/R9PGA0MlE37Ai2a
         gwvX31T+c50QIMm6Dv4luEObvXAkGVdKH8Efk7lhfzrenjOqrnHMjHnQy7DZ+bpT9Cig
         Gdkw==
X-Gm-Message-State: ANoB5pnN8WUxugO1JiNzVltNsOVhHjcRQ1PTELL6toyCpS4xS27EwikE
        OQKJvBp5vOcDxgDt6IDbRa+VEH0E1kqO7hWSEnI=
X-Google-Smtp-Source: AA0mqf6GB9Li0YjAlBu+SkFzcrS/dkYltHtITkCFexcrCk7w5PT/K+RlTyVDR0+HvWaAhte9Ait+DvKDhFI4p7MdxHc=
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id
 h13-20020a5d504d000000b00242246c2f89mr24326068wrt.108.1671017483680; Wed, 14
 Dec 2022 03:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20221214110037.149387-1-cbranchereau@gmail.com>
In-Reply-To: <20221214110037.149387-1-cbranchereau@gmail.com>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Wed, 14 Dec 2022 12:31:12 +0100
Message-ID: <CAFsFa85+U0GJ14+O0zkw-7H83Kw6dhL2+K-8TQbe5GkNWL=PYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for the AUO A030JTN01 TFT LCD
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong cover title, should be "Add support for the orisetech ota5601" sorry...

On Wed, Dec 14, 2022 at 12:00 PM Christophe Branchereau
<cbranchereau@gmail.com> wrote:
>
> Changes since v1:
>  fixed the dt-bindings maintainer email adress
>
>  dropped backlight, port, power-supply and reset-gpios as they're
>  provided by panel-common.yaml as pointed by Krzysztof Kozlowski
>
>  changed reg: true to reg : maxItems: 1
>
> Christophe Branchereau (2):
>   drm/panel: add the orisetech ota5601a
>   dt-bindings: display/panel: Add the Focaltech gpt3
>
>  .../display/panel/focaltech,gpt3.yaml         |  56 +++
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-orisetech-ota5601a.c  | 351 ++++++++++++++++++
>  4 files changed, 417 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
>  create mode 100644 drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
>
> --
> 2.35.1
>
