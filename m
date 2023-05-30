Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A6715CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjE3LL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjE3LLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:11:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B8115
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:11:19 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5664b14966bso29910337b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685445078; x=1688037078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Aw1Y+LNx+6x6rqkl3hDGtyQpbkH+fbTyufgVbhUx3g=;
        b=j/znRIUxKJksQNwddxQU58ISTnn7vK+X/i5ctJxZ9kV6Zy74Y7/Ykn1i3yLD1unHfB
         g1n31aO8w98GIWhpkbzZdHOXZnpLE2VSfzmvc/YNKfYQ+LBduA0dV7wxL+4vq+e3GzxM
         sAdSD89FDbS9Y4yyVzNrAZCaHYJpp5Q4IIQoIbini+Vow6/Aj3cpWNe0+W6ligWOPT2u
         ARA3eKBN3lrXEJPxQhCOpk/6dZoqf4VOoqMec7n/yDYe8vrRCOvF8UzCReBELiA6OU9O
         T1cqBbP8F832jq3ASijrL+IzrUy3RQNNoH6YoT9idANpQ6ukYRvvIxPv5UNVQ9n5LYH9
         Z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445078; x=1688037078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Aw1Y+LNx+6x6rqkl3hDGtyQpbkH+fbTyufgVbhUx3g=;
        b=NF6FKyCzMdVAUV31nBi6HG/JPGRCaga0f9ju2qVSP7PV6XjP8JlZxAflo8zlfCQSmZ
         7PGYBVIjAnspO64dASJUzga8Rw7et8bAyqO1WxJq0TeR/NZLhCxGwYm0uBOdascIX8EV
         RD4hIQ4DAJwb0IVRWoM+dwpxFUmz1yifVkpPIkIimSib4eriZdWrOqLbp86vNK1cwRmv
         epelVkqh+JiwSAB4yq0nTg1amqymgH5ZXelve1KaFGzXr/wINTgmeLp02jIm6osCAMk1
         u1KJeAapqxRCT9290KhwGoalKPONAK1QcJhTPi40/cJVg3+TlgCjHiabjxIa1JOs6DGA
         3DIw==
X-Gm-Message-State: AC+VfDws6eUOpayq6kFNjsyDLp5ed8QJ59MeRky6gG2wmcfatQTMb9RB
        GhV0/VNAWJuvQMZ8KOWrZuz/ze0UCNCX+b5zVJIiNw==
X-Google-Smtp-Source: ACHHUZ5W8uyQC5KcaoA8JpMcpez1cJAmTKelhw60cKwxaP/qh9Nq55tKrVcBkj3EzUU6ZABnGEZGlGc1VHQoEZDvPAA=
X-Received: by 2002:a0d:e212:0:b0:55d:a4fb:864a with SMTP id
 l18-20020a0de212000000b0055da4fb864amr1965071ywe.14.1685445078295; Tue, 30
 May 2023 04:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org> <71675a02-0801-62dc-2673-4a0907636b21@linaro.org>
 <CAA8EJpq=HZqiBZ6bpUNH47VmASuH+Mi5OD5BHmg0TPwtsKHf8w@mail.gmail.com>
 <oxgtbj7qmsdvz5gl4bud64jedmhdmvphjfge7uy6uwulefqfsa@pleslv2zgwbp>
 <ebc3ff33-6e4f-b107-33c6-f35b03307058@linaro.org> <v3ac2ihqjce7vxcsjnm7ett2vc6wb4hb3bb6x4widd55eintw7@fgkyipbbl2ei>
 <d52b384f-9853-3921-d4f2-5aedb7ef4c61@linaro.org> <ao2w7eiuc4olqbycmdviqrpqbdpoltusixlllied7jbo5fucap@xv6xvgi43yio>
In-Reply-To: <ao2w7eiuc4olqbycmdviqrpqbdpoltusixlllied7jbo5fucap@xv6xvgi43yio>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 30 May 2023 14:11:06 +0300
Message-ID: <CAA8EJpqt_VCE+Nz8w5mRMrg_oN87xByk2NKy8v+9LLPjP-nLYw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia XZ3
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     neil.armstrong@linaro.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 at 11:27, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-05-30 01:39:10, Dmitry Baryshkov wrote:
> > On 30/05/2023 01:37, Marijn Suijten wrote:
> > > On 2023-05-30 01:18:40, Dmitry Baryshkov wrote:
> > > <snip>
> > >>>>>>> +    ret = mipi_dsi_dcs_set_display_on(dsi);
> > >>>>>>> +    if (ret < 0) {
> > >>>>>>> +        dev_err(dev, "Failed to turn display on: %d\n", ret);
> > >>>>>>> +        return ret;
> > >>>>>>> +    }
> > >>>>>>
> > >>>>>> My usual question: should the mipi_dsi_dcs_exit_sleep_mode() / mipi_dsi_dcs_set_display_on() be moved from prepare() to enable() part?
> > >>>>>
> > >>>>>
> > >>>>> No, prepare is called before the video stream is started and when display is still in LPM mode and the mode hasn't been set.
> > >>>>>
> > >>>>
> > >>>> Yes, that's my point. Shouldn't we enable the panel _after_ starting the stream?
> > >>>
> > >>> I have never investigated what it takes to split these functions, but
> > >>> some of these panels do show some corruption at startup which may be
> > >>> circumvented by powering the panel on after starting the video stream?
> > >>>
> > >>> I'm just not sure where to make the split: downstream does describe a
> > >>> qcom,mdss-dsi-on-command and qcom,mdss-dsi-post-panel-on-command, where
> > >>> the latter only contains set_display_on() (not exit_sleep_mode()).
> > >>> It is documented like:
> > >>>
> > >>>       same as "qcom,mdss-dsi-on-command" except commands are sent after
> > >>>       displaying an image."
> > >>>
> > >>> So this seems like the right way to split them up, I'll test this out on
> > >>> all submitted panel drivers.
> > >>
> > >> Interesting enough, Neil suggested that sending all the commands during
> > >> pre_enable() is the correct sequence (especially for VIDEO mode panels),
> > >> since not all DSI hosts can send commands after switching to the VIDEO mode.
> > >
> > > Note that all these panels and Driver-ICs are command-mode, and/or
> > > programmed to run in command-mode, so there shouldn't be any notion of a
> > > VIDEO stream (any command-mode frame is just an "arbitrary command" as
> > > far as I understood).
> >
> > Yes, from the data stream point of view. I was talking about the DSI
> > host being able to send arbitrary commands or not after enabling the
> > video/cmd stream.
>
> Is this a known limitation of SM8250 then?  Or is the brightness_set
> issue more likely a "problem" with the panel that the downstream kernel
> is "somehow" working around or aware of, and I just haven't found
> how/where it deals with that?
> (Alternatively we could be "doing it wrong" for other panels but it
>  turns out to be working anyway)

Please excuse me for not being explicit enough. Qualcomm hardware
doesn't have this problem. Thus I was completely unaware of it before
talking to Neil.
So, our hardware works in most of the cases.

-- 
With best wishes
Dmitry
