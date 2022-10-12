Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298415FCA89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJLSYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:24:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153502633
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:24:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so27112414lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8EawSfGRFWzbyxxqHZ/CXnplUxOrrkRY1TiQySTK7A=;
        b=eeXAatAdr9oRMAO2qqcunj8ZEr+oAJ/Xv/9/Y5iz1U+D24htTr2K78DpHWm+gon7uy
         UpDKjmin0I2YYwX54XOtQR3LbsG4SFs3AnuE/0v81yGlZeI+FraVhrD+TkBg0VKhbY25
         p0SH/D0wh9+ykibzQbmWC0Ky24M2HUzt1B6fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8EawSfGRFWzbyxxqHZ/CXnplUxOrrkRY1TiQySTK7A=;
        b=kxgYwqB7d2x+aMUQ43xrhudtMsfJf4AJy6E46p9hdMOT7pGXXDF1hHGy0u2acedICP
         ys9aJPRcoWHRlpcppXGLR3LR5L+J/AQxi2jh7HfeP2Uz/8IwaRGLTIOTK7W/rJ9iwWhg
         4p8LmJmYap6REqvSXD5MG1gNrDWO4DD8OrC1J+5XHuOEmWrNMkoSnHv1f2bk3aOOal9w
         71Uw4zy7+1PnYZN7+xEamZ996dNneW+2dMYcX4uh+XOHtBzYR8Da40z2KvJ2yPm1Ck+Y
         WOD+JjrlzLRIQFYGOljFd3qnBIRDa51tA+XupV9WMN+ynmgK9zAofOZXgEp2Goa8qbeD
         b//Q==
X-Gm-Message-State: ACrzQf0AJWBuRACp9HN4sotqB9m6gDO+C3OOrkbQ4Kemm97tjn9NUGA8
        vviTNn3Dq+O6lxa8yaGAhvSetkg5BBMkeFCpj4ooyQ==
X-Google-Smtp-Source: AMsMyM7ctxGy1xfpOUr7onOXWKeqnUCIjPXxitKzTa8le/LjesknS63vkHu4WHzJwKdW/y1zALUhzudybYMIa4qyNWQ=
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id
 i3-20020a056512340300b0048c972750b0mr10355719lfr.309.1665599038342; Wed, 12
 Oct 2022 11:23:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Oct 2022 13:23:57 -0500
MIME-Version: 1.0
In-Reply-To: <1665569560-28943-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665569560-28943-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 12 Oct 2022 13:23:57 -0500
Message-ID: <CAE-0n52dsaTLQ7o6Z2PeFSv2_vTjvtujJ0JWCPE3uXxpKD0O4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        andersson@kernel.org, bgoswami@quicinc.com, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     Srinivasa Rao Mandadapu 
        <srivasam@qualcomm.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-10-12 03:12:40)
> From: Srinivasa Rao Mandadapu <srivasam@qualcomm.corp-partner.google.com>
>
> Update HDMI volatile registers list as DMA, Channel Selection registers
> , vbit control registers are being reflected by hardware DP port

No idea why a comma starts this line.

> disconnection.

Add a newline here?

> This update is required to fix no display and no sound issue
> observed after reconnecting TAMA/SANWA DP cables.
> Once DP cable is unplugged, DMA control registers are being reset by
> hardware, however at second plugin, new dma control values does not
> updated to the dma hardware registers since new register value and
> cached values at the time of first plugin are same.
>

Any Fixes tag?

> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@qualcomm.corp-partner.google.com>

Why not simply the quicinc email?
