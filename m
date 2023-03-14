Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587B36B91D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCNLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCNLkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:40:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9DF9C980;
        Tue, 14 Mar 2023 04:40:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so4769852pjt.2;
        Tue, 14 Mar 2023 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678794032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eH82WTYd39GPKAXdpbYy5VSkOFc2jW21usmU+S6UzaM=;
        b=WkXPZHabqVtCtmPiPhbTpbqbUbZAf7UDuh35/WLuHqxQ0p18Psv889vDS/yPUe1yI2
         ggWGepP5WBzmK50RVsxuLn/LTsnoSHRXI7VSThcnCfGf6CrdN6VXb0FYTdfyz9sg2fiv
         XDGhycxUNZa14Wmubkp+cdO+FLTGMlBF57CjDDyicxY6bry1eNQH364qoOasqilO3s2z
         4VFgfquWKyo05UDWSslDjvS/xrX5SD6SoSS5WKD86sJadAQd2YiGmnKTzgI9FLFhFPVA
         tbOYgkpNMEo5D5+ORWlpOT1V32oqmlKsQ88Mz6TxO3cxhWYOvxjRN9Nv3q6qM7s9Ly6v
         vqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678794032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH82WTYd39GPKAXdpbYy5VSkOFc2jW21usmU+S6UzaM=;
        b=VAgtv61ObpIUQNbHozUwrNeQQ9BGKBsgOT8wNnk9NTHiSUMZsQePCE5Hjb1apSwgnN
         YN0gFCm8vqNr20pPlK/Ta0aFZ6bk0hfJKfkM72YkPV3m3CjaxAyFGneEzCj7625ZggUL
         F2Fu7HUtpG3sDE0zYBMuQzbugPIWzF0uW/s5isN8TJFy7QhNuYxF7urMr49wX03CTU5/
         +0DI3Pu6EfKrGLu5Lc1Lkpow1798qQC8n7MHu5ibgVv/TyygKJNZdXjCCm2+Hm0MwADc
         lx4iUyolpw+pa4wo1NrihJW8T5OJhIdJgrFkUEqfs9Wv2yH4OsOowB+UzJ9YpmfWFTjr
         iOHA==
X-Gm-Message-State: AO0yUKVXMROPbqwSu3FKLAhCC9sC1L/aBYoyVDCB7LIeg5UGXSoB+xFC
        zt4J8lOrdFaCbGTjyKeqcCQ=
X-Google-Smtp-Source: AK7set9ftIWNNWDAHaADJAqiYdsj9tGVmw6svnfxG3uh7QWFxSecTPu9P+X9UtwpFti87PjPTHXSNg==
X-Received: by 2002:a17:902:f685:b0:19c:d49f:4296 with SMTP id l5-20020a170902f68500b0019cd49f4296mr45244363plg.67.1678794032284;
        Tue, 14 Mar 2023 04:40:32 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b0019cbd37a335sm1580589plb.93.2023.03.14.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:40:31 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:40:21 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZBBdJcvR6I6HZ4MS@Gentoo>
References: <20230311123231.20771-1-lujianhua000@gmail.com>
 <20230311123231.20771-2-lujianhua000@gmail.com>
 <904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org>
 <ZAx4KqXw+an555d4@Gentoo>
 <6c02557d-372d-05b1-2998-7c2cde99fac7@linaro.org>
 <ZA9xKlScy9/LS753@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9xKlScy9/LS753@ravnborg.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:53:30PM +0100, Sam Ravnborg wrote:
> On Mon, Mar 13, 2023 at 09:06:50AM +0100, Neil Armstrong wrote:
> > On 11/03/2023 13:46, Jianhua Lu wrote:
> > > On Sat, Mar 11, 2023 at 01:38:52PM +0100, Konrad Dybcio wrote:
> > > > 
> > > > 
> > > > On 11.03.2023 13:32, Jianhua Lu wrote:
> > > > > Add a driver for panels using the Novatek NT36523 display driver IC.
> > > > > 
> > > > > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > > > > ---
> > > > [...]
> > > > 
> > > > > +
> > > > > +static int nt36523_get_modes(struct drm_panel *panel,
> > > > > +			       struct drm_connector *connector)
> > > > > +{
> > > > > +	struct panel_info *pinfo = to_panel_info(panel);
> > > > > +	int i;
> > > > > +
> > > > > +	for (i = 0; i < pinfo->desc->num_modes; i++) {
> > > > > +		const struct drm_display_mode *m = &pinfo->desc->modes[i];
> > > > > +		struct drm_display_mode *mode;
> > > > > +
> > > > > +		mode = drm_mode_duplicate(connector->dev, m);
> > > > > +		if (!mode) {
> > > > > +			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> > > > > +				m->hdisplay, m->vdisplay, drm_mode_vrefresh(m));
> > > > > +			return -ENOMEM;
> > > > > +		}
> > > > > +
> > > > > +		mode->type = DRM_MODE_TYPE_DRIVER;
> > > > > +		if (pinfo->desc->num_modes == 1)
> > > > > +			mode->type |= DRM_MODE_TYPE_PREFERRED;
> > > > That's not quite correct, as that means "if you have more than one
> > > > defined panel mode (say 60Hz and 120 Hz), there will be no preferred one".
> > > This piece of code I see in the other panels, so I'm not sure if it is
> > > correct.
> Jianhua is correct that the same code exists in several places,
> and from a quick browse I consider all the cases bogus.
> 
> It would be fine if someone volunteered to fix all the panels so we
> avoid this bug to creep into more panel drivers.
I'm glad to send a patch to fix it soon.
> 
> 	Sam
