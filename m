Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D282716C24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjE3STi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjE3STa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:19:30 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B40F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:19:23 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7F1FB3EF11;
        Tue, 30 May 2023 20:19:21 +0200 (CEST)
Date:   Tue, 30 May 2023 20:19:20 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony
 Xperia XZ3
Message-ID: <iboet2dgdgxdailepqnq74yiwxhtxodgn4dss7seqzklxeco4f@scugkjmgz6m6>
References: <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <71675a02-0801-62dc-2673-4a0907636b21@linaro.org>
 <CAA8EJpq=HZqiBZ6bpUNH47VmASuH+Mi5OD5BHmg0TPwtsKHf8w@mail.gmail.com>
 <oxgtbj7qmsdvz5gl4bud64jedmhdmvphjfge7uy6uwulefqfsa@pleslv2zgwbp>
 <ebc3ff33-6e4f-b107-33c6-f35b03307058@linaro.org>
 <v3ac2ihqjce7vxcsjnm7ett2vc6wb4hb3bb6x4widd55eintw7@fgkyipbbl2ei>
 <d52b384f-9853-3921-d4f2-5aedb7ef4c61@linaro.org>
 <ao2w7eiuc4olqbycmdviqrpqbdpoltusixlllied7jbo5fucap@xv6xvgi43yio>
 <CAA8EJpqt_VCE+Nz8w5mRMrg_oN87xByk2NKy8v+9LLPjP-nLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqt_VCE+Nz8w5mRMrg_oN87xByk2NKy8v+9LLPjP-nLYw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-30 14:11:06, Dmitry Baryshkov wrote:
> On Tue, 30 May 2023 at 11:27, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > On 2023-05-30 01:39:10, Dmitry Baryshkov wrote:
> > > On 30/05/2023 01:37, Marijn Suijten wrote:
> > > > On 2023-05-30 01:18:40, Dmitry Baryshkov wrote:
> > > > <snip>
> > > >>>>>>> +    ret = mipi_dsi_dcs_set_display_on(dsi);
> > > >>>>>>> +    if (ret < 0) {
> > > >>>>>>> +        dev_err(dev, "Failed to turn display on: %d\n", ret);
> > > >>>>>>> +        return ret;
> > > >>>>>>> +    }
> > > >>>>>>
> > > >>>>>> My usual question: should the mipi_dsi_dcs_exit_sleep_mode() / mipi_dsi_dcs_set_display_on() be moved from prepare() to enable() part?
> > > >>>>>
> > > >>>>>
> > > >>>>> No, prepare is called before the video stream is started and when display is still in LPM mode and the mode hasn't been set.
> > > >>>>>
> > > >>>>
> > > >>>> Yes, that's my point. Shouldn't we enable the panel _after_ starting the stream?
> > > >>>
> > > >>> I have never investigated what it takes to split these functions, but
> > > >>> some of these panels do show some corruption at startup which may be
> > > >>> circumvented by powering the panel on after starting the video stream?
> > > >>>
> > > >>> I'm just not sure where to make the split: downstream does describe a
> > > >>> qcom,mdss-dsi-on-command and qcom,mdss-dsi-post-panel-on-command, where
> > > >>> the latter only contains set_display_on() (not exit_sleep_mode()).
> > > >>> It is documented like:
> > > >>>
> > > >>>       same as "qcom,mdss-dsi-on-command" except commands are sent after
> > > >>>       displaying an image."
> > > >>>
> > > >>> So this seems like the right way to split them up, I'll test this out on
> > > >>> all submitted panel drivers.
> > > >>
> > > >> Interesting enough, Neil suggested that sending all the commands during
> > > >> pre_enable() is the correct sequence (especially for VIDEO mode panels),
> > > >> since not all DSI hosts can send commands after switching to the VIDEO mode.
> > > >
> > > > Note that all these panels and Driver-ICs are command-mode, and/or
> > > > programmed to run in command-mode, so there shouldn't be any notion of a
> > > > VIDEO stream (any command-mode frame is just an "arbitrary command" as
> > > > far as I understood).
> > >
> > > Yes, from the data stream point of view. I was talking about the DSI
> > > host being able to send arbitrary commands or not after enabling the
> > > video/cmd stream.
> >
> > Is this a known limitation of SM8250 then?  Or is the brightness_set
> > issue more likely a "problem" with the panel that the downstream kernel
> > is "somehow" working around or aware of, and I just haven't found
> > how/where it deals with that?
> > (Alternatively we could be "doing it wrong" for other panels but it
> >  turns out to be working anyway)
> 
> Please excuse me for not being explicit enough. Qualcomm hardware
> doesn't have this problem. Thus I was completely unaware of it before
> talking to Neil.
> So, our hardware works in most of the cases.

Also excuse me for mocking the hardware here; it seems quite illogical
for it to not work on this specific device which is more likely a
failure in porting the panel DT to the driver than related to this
specific SoC. There's probably one of the hundred-or-so DT params
responsible for triggering a setting, delay, or other magic sequence
that gets the brightness toggle working.

- Marijn
