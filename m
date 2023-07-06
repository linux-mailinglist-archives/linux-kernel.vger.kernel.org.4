Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4B74A721
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGFWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:35:28 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CD1703;
        Thu,  6 Jul 2023 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688682924; x=1689287724; i=spasswolf@web.de;
 bh=lDm9BYjHliSWNZlmoI0mXu6rvzYWfFi612qvmED6Dl8=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=r6vYt3ZWxwTrR0Cjd81z/+CG+IPDLKBqQUAVyXhqtJi9juzQxkAAJV1AsCkxLb6Gd6pYihu
 Gk8RB27X75u9xXZVEglAapn17C5tY4ZPmX2DQEUvjIPrxzoUVBm5UwQPdh8CqJp3lBcGlEPuj
 Kymk0ynOXV2mjVSZuCZ2HMKelqV8PFQvxuuy6x60f6WKedG9Lm8ENrD32SDTNuYQOuxV/444Q
 7iFqJUHMkB4HLFlIYBh5mOfoXbm44pUoIyZu643eUn5y5xrGCMPwsrrBZwItng6nD7d3SdYPz
 k/bLc94GQO/kfn8n1GiosDMWnTbPE6Nd8cMzZe9iQXZ7p6Bovhkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMzC-1q78EU2mpS-00Ay3U; Fri, 07
 Jul 2023 00:35:24 +0200
Message-ID: <1098fdd1d33248817907b7caacb6a783c4f0a538.camel@web.de>
Subject: Re: drm_bridges on fairphone-fp3 are enabled in the wrong order
From:   Bert Karwatzki <spasswolf@web.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 07 Jul 2023 00:35:23 +0200
In-Reply-To: <CAD=FV=W_WMo4NGMQMYeLGUc_jBM3X4hZAOe-YQw6exBioEtadw@mail.gmail.com>
References: <c27953274997a56f8e0522f9331e733ae92bf25b.camel@web.de>
         <CAD=FV=W_WMo4NGMQMYeLGUc_jBM3X4hZAOe-YQw6exBioEtadw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cNHpgmWoTzJpug6NgqELcGhatJ30fsV5g6Jk/iwXCqIAduHV+FF
 9kRtgWFdoxRyulRuoGW47ytZJVzGf20UTbVyBqO429PZVWAa7GsUEdjjOD5cHGcEoqpmgZh
 FvYf55K1YZmon9LmZk17UrJvyEORtiIuoY5V06Z2lwo7LlXacPhf9nN9Vhu3Shy59nsNFUB
 D9pmCcik2km4jd+jjdH4g==
UI-OutboundReport: notjunk:1;M01:P0:107Lf3KkzTc=;KGG1KrtZgcr1yBCBBOZa32xgulo
 WLua+kddpCRQpL0zrtInhmpiBb/F29DREpB1hdsx84muYbYtOJV8Fpk2bG1UJa63bMFvHPp7y
 lx7DX2oAxcfqOk+mz2JtiMRq5duOAQk7a1RJz/U8SHcGb5anQISR3Bw+HFZzxaq6HX6r2TqUY
 dlIJREbCoAP3+e/hke+3fLaf/jaDiZpHWhkvkdiygrpfIJjHYHsp1G65t0v8SPu3v2PeB+94i
 /hU5haJH44wHMPKmT3n7M9viE1OioxLEHTcMG8CA+bE+N8WHkNu+3jmQgoTtNcVlWwm4VsyGU
 wfPq52nzIIhBSpNp8pHn07kT1witZririFhuW1I8kBjD2DUDjnvJHVjR+hK0meSbNTZZO230C
 8sUPWcvkdxbwsgbObQeWix5hptVAe1GrrmYPxNRrMFwtZfPKlDWkVidFcw2gEbwu7o4DT992x
 pe+ENsGl2/UbFxy+/E8si2dgkE6jXoIM2quNQaQXAUsos5/cKoINbzYAFtW03EyZu+eDqB/lD
 xZVA3PylRlRY+vJN0k72veP4Zi/bTSLMv9HwNZ9eO0MmGN7SJ7haUhSMu1Ygct/MuXhOqjWBo
 /qMTUNfJQNs2SgxGjhTfBXu8a9F3qznmN7k9ReHStmwdos3Ta4mpys9svNX9HpMcO9ETkfuCJ
 D0VcUESqM6XYXEBAhAC4pAqqJCRVHHi7nCI6UwpE4yRspOKIjo60aRGDOHFTmhqvpis5lk72f
 e1F/5JfnZ12wJIm0ZL8/v+X7EsBDf9C/pkmT5CmVCF9X57IVQTHxv1KsZ01uvvbIaOqXxoYPC
 PQt7WcaHCcZ1PkUiYk1TfkHwQts8mIB/KrI5vFol8vJwEZUT8mHjru/ts9NZ4EHvLS2zdoR1i
 7jUXs2gyqael8LEXtM1F8OSuJ3buHTW7tR041/0LhRHDtRmlRFulv8HwCBdYilZdOkNxTgwDS
 DEqkkRxAigbZP0EglAymcfgM6NY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 06.07.2023 um 09:22 -0700 schrieb Doug Anderson:
> Hi,
>
> On Wed, Jul 5, 2023 at 12:51=E2=80=AFAM Bert Karwatzki <spasswolf@web.de=
> wrote:
> >
> > The fairphone-fp3 has a drm_panel attached to a dsi bridge. This are a=
dded
> > to
> > the bridge_chain in struct drm_encoder in the order dsi, panel. When t=
he
> > drm_atomic_bridge_chain_pre_enable these get enabled in the order pane=
l, dsi
> > because of the list_for_each_entry_reverse. But the drm_panel of the
> > fairphone-
> > fp3 is enabled using mipi_dsi_dcs_write_buffer which only works if the=
 dsi
> > is
> > enabled before the panel.
> > =C2=A0To work around this one can revert
> >
> > commit 9e15123eca7942caa8a3e1f58ec0df7d088df149
> > Author: Douglas Anderson <dianders@chromium.org>
> > Date:=C2=A0=C2=A0 Tue Jan 31 14:18:25 2023 -0800
> >
> > =C2=A0=C2=A0=C2=A0 drm/msm/dsi: Stop unconditionally powering up DSI h=
osts at modeset
> >
> > This leads to a working panel on startup. But when suspending one runs=
 again
> > into a similar problem. When the bridges are disabled the dsi is disab=
led
> > first
> > which leads to a failure in disabling the panel again because
> > mipi_dsi_dcs_write_buffer fails when the dsi is already switched of.
> > =C2=A0As a simple workarund for both problems I have found it works to=
 exchange
> > the
> > order of the bridge chain in drm_endcoder:
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > index 28b8012a21f2..990f7c68a27c 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > @@ -550,6 +555,8 @@ int msm_dsi_manager_ext_bridge_init(u8 id)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* swap bridges in list */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_swap(&encoder->bridge_chain=
, encoder->bridge_chain.next);
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The pipeline is ready, p=
ing encoders if necessary */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msm_dsi_manager_set_split_d=
isplay(id);
> >
> > But this does not look like a portable solution so I wonder if there i=
s a
> > better
> > way to do this.
> >
> > The linux kernel used here is a linux-next-20220630, with several out-=
of-
> > tree
> > patches which are needed for the msm8953 gpu and the display used in t=
he
> > fairphone-fp3 located here:
> > https://github.com/spasswolf/msm8953-linux.git=C2=A0in
> > branch msm8953_iommu_rebase_v2_wlan_modem_ipa_cpufreq_display_debug.
>
> Any chance that "pre_enable_prev_first" works for you? For the best
> summary I'm aware of this issue, see:
>
> https://lore.kernel.org/r/CAD=3DFV=3DX_xonf1Dz0BsNTKm4-zBm+ccKvPO+wEWFVM=
UVY_2=3Dh3Q@mail.gmail.com
>
> -Doug

Yes, this is exactly what I needed. To enable pre_enable_prev_first for th=
e
bridge one simply can set panel.prepare_prev_first=3Dtrue in the probe fun=
ction of
the panel driver.

Bert Karwatzki

