Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D140614C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKAO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:28:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6074645E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:28:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t62so5238404oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCAHuauyqRDt6mVa8UX+cbOhcceVwq2lTH7wmX1Rf1A=;
        b=XrU1syuKyYTGj8ZOLCfiFGzue+8tq752jGzFu/UEAkyMV+LxqCyKb3a54opjuXMGEJ
         hOHALRVwfP7HchVP5CKoWo7CJRBpZ7nELeFZFM55MOPskt++SipNS0vhWnzN4/JJ6SAL
         Hpz2k/FgoUw25enqaEMjqjxU3JDkuc5gk9kbC1KvRNxrW3SruZjFtp8qcpRLLDJnsEd6
         Pos0rw5VJ7Rk9u+izPdjcC0gHU2UXaBJJsuXMw4MWG+Yr9iQeYFxp8yIpwid/JjfGs6v
         Sgr+rKtwRk9mbkBLtqQbpWcupPxY/8EUbEl1tIg2dbwNwkKnB6z6ZV+LGHdW/LmJ+rdy
         JGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCAHuauyqRDt6mVa8UX+cbOhcceVwq2lTH7wmX1Rf1A=;
        b=7axVrYJOBEUcrj1q6jipH1cg5NdgEMQv4f65tRQI4FyDK22a3Vf1XBXsEZfB/a1edO
         uehXlsfPTsrxZzLliGMfDm3JhBfXuIETzcsJ8+BiNrRe8IjqrLAg018PHsCQQitBvxeC
         IyY1KQEFkjHihsjAvan8V7zyi+MMTTLmSoZww3vet6zHB8yJLcFm6o8UlyepsEc+65NQ
         /nt3NoSrhW3cDAd/PoQdGyee10ZfDlPYy6OmZhcic1e+ed3PfDeoscUP7vRRWWqPRqnO
         T1U8LduIwZ+3QU13ykKLkNn9hFEXiQE1wCtl3G3KyP7U+FY6GuOeafemCQK1rVr6QBTm
         gxdg==
X-Gm-Message-State: ACrzQf1Ai5KSWaKluP3+8FLWti0pvWpf3evyVDSmBO80k4bSxxgEOYGl
        4bSzyynxaNx1CJTopM/p8lUoybKCFwJdfN3r6Pc=
X-Google-Smtp-Source: AMsMyM4GKr9xTNcrz7XVOWmlcFIN18yBdZKMUvERKx/D3jLESiQaKh9x/1yt0cosLbMODhmMDf/DnPomjMa7j8T9K1U=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr10191629oiw.96.1667312897992; Tue, 01
 Nov 2022 07:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221031114247.10309-1-jirislaby@kernel.org> <cb9f90d1-344e-c329-178e-3662c76eee7d@amd.com>
In-Reply-To: <cb9f90d1-344e-c329-178e-3662c76eee7d@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Nov 2022 10:28:06 -0400
Message-ID: <CADnq5_NAK_peOnu2vwxcN8s0Ee4MiMPkV4URxKSh5nsOFDY8XA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display (gcc13): fix enum mismatch
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Martin Liska <mliska@suse.cz>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 31, 2022 at 9:59 AM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
> On 2022-10-31 07:42, Jiri Slaby (SUSE) wrote:
> > rn_vbios_smu_set_dcn_low_power_state() produces a valid warning with
> > gcc-13:
> >   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c:2=
37:6: error: conflicting types for 'rn_vbios_smu_set_dcn_low_power_state' d=
ue to enum/integer mismatch; have 'void(struct clk_mgr_internal *, enum dcn=
_pwr_state)'
> >   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h:3=
6:6: note: previous declaration of 'rn_vbios_smu_set_dcn_low_power_state' w=
ith type 'void(struct clk_mgr_internal *, int)'
> >
> > I.e. the type of the 2nd parameter of
> > rn_vbios_smu_set_dcn_low_power_state() in the declaration is int, while
> > the definition spells enum dcn_pwr_state. Synchronize them to the
> > latter (and add a forward enum declaration).
> >
> > Cc: Martin Liska <mliska@suse.cz>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h   | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vb=
ios_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_s=
mu.h
> > index 3e5df27aa96f..1ce19d875358 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu=
.h
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu=
.h
> > @@ -26,6 +26,8 @@
> >  #ifndef DAL_DC_RN_CLK_MGR_VBIOS_SMU_H_
> >  #define DAL_DC_RN_CLK_MGR_VBIOS_SMU_H_
> >
> > +enum dcn_pwr_state;
> > +
> >  int rn_vbios_smu_get_smu_version(struct clk_mgr_internal *clk_mgr);
> >  int rn_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int req=
uested_dispclk_khz);
> >  int rn_vbios_smu_set_dprefclk(struct clk_mgr_internal *clk_mgr);
> > @@ -33,7 +35,7 @@ int rn_vbios_smu_set_hard_min_dcfclk(struct clk_mgr_i=
nternal *clk_mgr, int reque
> >  int rn_vbios_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *cl=
k_mgr, int requested_min_ds_dcfclk_khz);
> >  void rn_vbios_smu_set_phyclk(struct clk_mgr_internal *clk_mgr, int req=
uested_phyclk_khz);
> >  int rn_vbios_smu_set_dppclk(struct clk_mgr_internal *clk_mgr, int requ=
ested_dpp_khz);
> > -void rn_vbios_smu_set_dcn_low_power_state(struct clk_mgr_internal *clk=
_mgr, int display_count);
> > +void rn_vbios_smu_set_dcn_low_power_state(struct clk_mgr_internal *clk=
_mgr, enum dcn_pwr_state);
> >  void rn_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_inter=
nal *clk_mgr, bool enable);
> >  void rn_vbios_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
> >  int rn_vbios_smu_is_periodic_retraining_disabled(struct clk_mgr_intern=
al *clk_mgr);
>
