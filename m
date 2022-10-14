Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF405FF514
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJNVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJNVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:11:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6111C7D5E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:11:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a6so7444611ljq.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jwfF09RX9SPB61+LJj7nv1vEfRoVd60VC+o2CeyfvU=;
        b=iHm36fzoSenUKyJ54SzKpNGU/JQ0oDueku+u2hzC1q/MCUUZTYHSLR/ZfvBB1C16lQ
         RzDHaiWQooj1MlWHUEIVEKXTGc77LVM8ONn6Ic/+4yxdRvQAPFnznHieKyhYsXAtLPnm
         xTlysvwOarVxtq/fOp2kw6uZF4CHGS+b2QRlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jwfF09RX9SPB61+LJj7nv1vEfRoVd60VC+o2CeyfvU=;
        b=TvyyYoxZOti4ViKN0OoHYNDWQKPVEdNtj7gqLaEC1PdA12wmLqYNAK3C0YaSmCM789
         6m0E0JLo+leYJMszt+Fed+ZWljTKg+UYptPZiloik9LFx1GKc2PcMwecO2q1HeH3Oh0R
         i3xBXv7zmYYw4B+9jNFx9Mk3MD33DjkM2ReshVprWBBalSq1UvtBIr3gG6sCYHJ+Fk1A
         p3bQPaQH3qusjaRyDssW3IvFT2Hm6LvjC1X2RUyH98roO3smIaAlIf34YDhoer/RK23C
         08jCa//PH9cyWnyWh307xMBKs4A6pNElb62JRykfchRy1w0ebDld1ZbH3Nmd5Q7U7qZx
         n0sg==
X-Gm-Message-State: ACrzQf0CGqpkGR8wvw8eVmBMyHC8Ipwjg+2UqAicmxN9lw7j9VnI0XXq
        lxcxPP1qHZqRbEJ4968oeeU6CLkvo7d0IVBy+Itsaw==
X-Google-Smtp-Source: AMsMyM6dAMgpCNreqELEnwCjhZUQh7Y6izlRrC/9R2k8ZvsYCFHyMOajVJ8CIsdxwJYjy9S2SJJo7cEKYi3hfFZxhEc=
X-Received: by 2002:a05:651c:1112:b0:26c:7323:3f2c with SMTP id
 e18-20020a05651c111200b0026c73233f2cmr2649758ljo.4.1665781895643; Fri, 14 Oct
 2022 14:11:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Oct 2022 14:11:35 -0700
MIME-Version: 1.0
In-Reply-To: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665637711-13300-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 14 Oct 2022 14:11:35 -0700
Message-ID: <CAE-0n53W3+MgRzpkV-9kBc6Pcvzta+ear3oxgMA-0rpNyJyJwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: mark HDMI TX registers as volatile
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        andersson@kernel.org, bgoswami@quicinc.com, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
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

Quoting Srinivasa Rao Mandadapu (2022-10-12 22:08:31)
> Update HDMI volatile registers list as DMA, Channel Selection registers,
> vbit control registers are being reflected by hardware DP port
> disconnection.
>
> This update is required to fix no display and no sound issue observed
> after reconnecting TAMA/SANWA DP cables.
> Once DP cable is unplugged, DMA control registers are being reset by
> hardware, however at second plugin, new dma control values does not
> updated to the dma hardware registers since new register value and
> cached values at the time of first plugin are same.
>
> Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reported-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

I found that another patch in this area hasn't been applied[1]. Is it
still relevant? We're still carrying it in the chromium tree. If it is
relevant can you please resend it.

[1] https://lore.kernel.org/all/1602596728-11783-1-git-send-email-srivasam@codeaurora.org/
