Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED16F71628D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjE3Nt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjE3NtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:49:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE6C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:49:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2565a9107d2so2594944a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1685454555; x=1688046555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7p73ODufu1/P74FptI7FRwaCItiP1sKbYRvV3n+M0V0=;
        b=PzarIwSIhRYrd8a9D1iPGmwviHC2XZt4+tfx7iv3dKbXBCvqRWGx9WoPv5WraiCSjm
         zgD8EF2ExxnBmzqJqpZ2xnxBOoQJjgm+v6OMnfUESSyJmbUZtTzVruClSMIw+5cXpChR
         k23PLH32rOaJYk7OJBiywbIPGc16TrY6HegpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685454555; x=1688046555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7p73ODufu1/P74FptI7FRwaCItiP1sKbYRvV3n+M0V0=;
        b=f5Gh74TKi/iDaKyCCQHUpR9lNyOfZ/nxfNDVNNTfmZ4n+uidXJDVBLI5p4T01pAgBI
         OabUf1LsOQutlolotOQK/ZadHEb/tdeQxPSZwggafMawMywe3caO+wgwh3uNgoZJcJhO
         zzgSG9IjClCfgpFJ69zcYn5doOMl0uwIeVeRK5PgjVqil4avrhJjDJBG5ZH8P7apcOj+
         qAT5RgK6oxAbRrFr8hlm858YqqgbIq93IOpCHPyELY01L8l2i/V52VJlL2GH2ErDyx7L
         LMR6EqL4onVtFQmLPTDc7/6uC3CdXvb2M+Lun75AtOMqhE65iTe7XCnZK8HmFXh410iz
         jIKw==
X-Gm-Message-State: AC+VfDwKgEikQ7s4AbG4eDVQJA8lBTWxKIfwtZAtIztsrKIv1162I96B
        dfTTO1DeeHZq3h739fTTyPyNbg==
X-Google-Smtp-Source: ACHHUZ4XSEbkBWzXynP47Hjpm8/ECtPpTXOj/WE0fHRVvYpYN5zxii/+M2F6b3VEOWryyJa4ue4xRw==
X-Received: by 2002:a17:90a:fe13:b0:255:a8fb:a72a with SMTP id ck19-20020a17090afe1300b00255a8fba72amr2573662pjb.32.1685454555527;
        Tue, 30 May 2023 06:49:15 -0700 (PDT)
Received: from 5e905162a5a7 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id nn6-20020a17090b38c600b002508f0ac3edsm4246116pjb.53.2023.05.30.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:49:14 -0700 (PDT)
Date:   Tue, 30 May 2023 13:49:07 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Imre Deak <imre.deak@intel.com>, Dave Airlie <airlied@redhat.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v4,01/14] drm/i915: Fix PIPEDMC disabling for a bigjoiner
 configuration
Message-ID: <20230530134907.GA8@5e905162a5a7>
References: <20230510103131.1618266-2-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510103131.1618266-2-imre.deak@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Imre/Dave,

Ref: [v4,01/14] drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration
     [git pull] drm fixes for 6.4-rc4
     drm-fixes-2023-05-26:
     drm fixes for 6.4-rc4

This patch has caused a regression between 6.4-rc3 and 6.4-rc4. Other
tested kernels include 6.3.4 work fine. Dropping the patch allows the decode
playback of media via Kodi. Without dropping the patch - the media
starts and stutters then ceases to play.

There is an additional issue that 6.4-rc4 audio playback is also failing
(where 6.4-rc3 was fine), I have not yet tracked this down.

This is all on:
DMI: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0087.2023.0306.1931 03/06/2023
12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
microcode: updated early: 0x429 -> 0x42a, date = 2023-02-14

Regards

Rudi

On Wed, May 10, 2023 at 01:31:18PM +0300, Imre Deak wrote:
> For a bigjoiner configuration display->crtc_disable() will be called
> first for the slave CRTCs and then for the master CRTC. However slave
> CRTCs will be actually disabled only after the master CRTC is disabled
> (from the encoder disable hooks called with the master CRTC state).
> Hence the slave PIPEDMCs can be disabled only after the master CRTC is
> disabled, make this so.
> 
> intel_encoders_post_pll_disable() must be called only for the master
> CRTC, as for the other two encoder disable hooks. While at it fix this
> up as well. This didn't cause a problem, since
> intel_encoders_post_pll_disable() will call the corresponding hook only
> for an encoder/connector connected to the given CRTC, however slave
> CRTCs will have no associated encoder/connector.
> 
> Fixes: 3af2ff0840be ("drm/i915: Enable a PIPEDMC whenever its corresponding pipe is enabled")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 1d5d42a408035..116fa52290b84 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -1702,9 +1702,17 @@ static void hsw_crtc_disable(struct intel_atomic_state *state,
>  
>  	intel_disable_shared_dpll(old_crtc_state);
>  
> -	intel_encoders_post_pll_disable(state, crtc);
> +	if (!intel_crtc_is_bigjoiner_slave(old_crtc_state)) {
> +		struct intel_crtc *slave_crtc;
> +
> +		intel_encoders_post_pll_disable(state, crtc);
>  
> -	intel_dmc_disable_pipe(i915, crtc->pipe);
> +		intel_dmc_disable_pipe(i915, crtc->pipe);
> +
> +		for_each_intel_crtc_in_pipe_mask(&i915->drm, slave_crtc,
> +						 intel_crtc_bigjoiner_slave_pipes(old_crtc_state))
> +			intel_dmc_disable_pipe(i915, slave_crtc->pipe);
> +	}
>  }
>  
>  static void i9xx_pfit_enable(const struct intel_crtc_state *crtc_state)
