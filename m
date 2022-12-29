Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B7658AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiL2JY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiL2JYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:24:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30CDF21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:24:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso10700127wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osLtJOc/4PM5X4uBlOLQKHlEYcjzPp8720JlY48ebIc=;
        b=fHcQQDQtGQAVcssMtTLRqFMbtspw8JwpnHg8lO8tJTvbHS+Vn5vGTmNgZTvmI1MntV
         /F+OME2MZnNvnKPTB3LYC0fs0slIT1CV3qtp1b+8oeGkQ41iWZHJeOt7rkmiMsLTXffB
         UAILq3M7H83ri4NinGUy2l2IIxIPxqF7iNuldhvOQomOVtpAhiQ4f8xu8ktZnBQrL1IZ
         rBROWaMBqpAyUGiK565VySK/57eGx5lcdVOa8if4M7gb0Izm6wLxzs6hHOzL7ttcoiSq
         Qq0X04+hLQgsBoYtPiJGT91EopX2ym+t3f2KdSmrWjieLaEqqVHX8FPIdLeMKjFTOZtK
         fv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osLtJOc/4PM5X4uBlOLQKHlEYcjzPp8720JlY48ebIc=;
        b=QDC+h1YKrxDYsFsK25OWUGtLlyyL9OsLl1zzvORxWvbScUTKvfIqW2OvDBCsNAv3bS
         h2QWmcclVjIyUMZxApmpwoIzSYibq6tUDAfVX0Fkmkz7jMCAlyJUTZqFu+/0ZnF4Y8ZM
         tD+L70rP/p7VtaQ1h8I7OURIedJvkZ06gwwwq4faESl8x3os7agP5nModM/FVkvjGjoo
         wP5Og4enlOVEcwsrpVU82AA1HCwC8ez7BtOiBcP9gbCds2WyeS95in+xPaWRM93ljnLO
         RiV4F+zDqgCRLowgQdXVQONQ+bGl43N71d+GfMWLG05+A89wSiXypJnN2Gq7wVuqafTT
         gHFw==
X-Gm-Message-State: AFqh2ko0tIILEnRrlL5cfaD0JxDXbvG3JobwSRL793MQjj3xibivA9jz
        j/WQf58xgxBfNPAu/EeXxXk=
X-Google-Smtp-Source: AMrXdXsypwyZC4j7d5EUZyhoYOxFhMCPePPMlU/YyWDot9po4OCgJUbdXHW7QXv54z+lGb2u6WCf4Q==
X-Received: by 2002:a05:600c:1d8e:b0:3d6:e23:76a2 with SMTP id p14-20020a05600c1d8e00b003d60e2376a2mr19263586wms.34.1672305893029;
        Thu, 29 Dec 2022 01:24:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c3b0400b003c6b7f5567csm46125259wms.0.2022.12.29.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:24:52 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:24:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c:282
 nvkm_chan_cctx_get() warn: inconsistent returns '&cgrp->mutex'.
Message-ID: <202212260844.AYAkoVok-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a85e2b0a1e1e6fb4ee51ae902730212b2de25c
commit: f48dd2936138882d7755cbbc5d9984015c75980c drm/nouveau/fifo: add new engine context tracking
config: s390-randconfig-m041-20221225
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c:282 nvkm_chan_cctx_get() warn: inconsistent returns '&cgrp->mutex'.

vim +282 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c

f48dd293613888 Ben Skeggs 2022-06-01  241  int
f48dd293613888 Ben Skeggs 2022-06-01  242  nvkm_chan_cctx_get(struct nvkm_chan *chan, struct nvkm_engn *engn, struct nvkm_cctx **pcctx,
f48dd293613888 Ben Skeggs 2022-06-01  243  		   struct nvkm_client *client)
f48dd293613888 Ben Skeggs 2022-06-01  244  {
f48dd293613888 Ben Skeggs 2022-06-01  245  	struct nvkm_cgrp *cgrp = chan->cgrp;
f48dd293613888 Ben Skeggs 2022-06-01  246  	struct nvkm_vctx *vctx;
f48dd293613888 Ben Skeggs 2022-06-01  247  	struct nvkm_cctx *cctx;
f48dd293613888 Ben Skeggs 2022-06-01  248  	int ret;
f48dd293613888 Ben Skeggs 2022-06-01  249  
f48dd293613888 Ben Skeggs 2022-06-01  250  	/* Look for an existing channel context for this engine+VEID. */
f48dd293613888 Ben Skeggs 2022-06-01  251  	mutex_lock(&cgrp->mutex);
f48dd293613888 Ben Skeggs 2022-06-01  252  	cctx = nvkm_list_find(cctx, &chan->cctxs, head,
f48dd293613888 Ben Skeggs 2022-06-01  253  			      cctx->vctx->ectx->engn == engn && cctx->vctx->vmm == chan->vmm);
f48dd293613888 Ben Skeggs 2022-06-01  254  	if (cctx) {
f48dd293613888 Ben Skeggs 2022-06-01  255  		refcount_inc(&cctx->refs);
f48dd293613888 Ben Skeggs 2022-06-01  256  		*pcctx = cctx;
f48dd293613888 Ben Skeggs 2022-06-01  257  		mutex_unlock(&chan->cgrp->mutex);

This code is correct, but smatch wants people to use "&cgrp->mutex"
constistently instead of "&chan->cgrp->mutex".

f48dd293613888 Ben Skeggs 2022-06-01  258  		return 0;
f48dd293613888 Ben Skeggs 2022-06-01  259  	}
f48dd293613888 Ben Skeggs 2022-06-01  260  
f48dd293613888 Ben Skeggs 2022-06-01  261  	/* Nope - create a fresh one.  But, sub-context first. */
f48dd293613888 Ben Skeggs 2022-06-01  262  	ret = nvkm_cgrp_vctx_get(cgrp, engn, chan, &vctx, client);
f48dd293613888 Ben Skeggs 2022-06-01  263  	if (ret) {
f48dd293613888 Ben Skeggs 2022-06-01  264  		CHAN_ERROR(chan, "vctx %d[%s]: %d", engn->id, engn->engine->subdev.name, ret);
f48dd293613888 Ben Skeggs 2022-06-01  265  		goto done;
f48dd293613888 Ben Skeggs 2022-06-01  266  	}
f48dd293613888 Ben Skeggs 2022-06-01  267  
f48dd293613888 Ben Skeggs 2022-06-01  268  	/* Now, create the channel context - to track engine binding. */
f48dd293613888 Ben Skeggs 2022-06-01  269  	CHAN_TRACE(chan, "ctor cctx %d[%s]", engn->id, engn->engine->subdev.name);
f48dd293613888 Ben Skeggs 2022-06-01  270  	if (!(cctx = *pcctx = kzalloc(sizeof(*cctx), GFP_KERNEL))) {
f48dd293613888 Ben Skeggs 2022-06-01  271  		nvkm_cgrp_vctx_put(cgrp, &vctx);
f48dd293613888 Ben Skeggs 2022-06-01  272  		ret = -ENOMEM;
f48dd293613888 Ben Skeggs 2022-06-01  273  		goto done;
f48dd293613888 Ben Skeggs 2022-06-01  274  	}
f48dd293613888 Ben Skeggs 2022-06-01  275  
f48dd293613888 Ben Skeggs 2022-06-01  276  	cctx->vctx = vctx;
f48dd293613888 Ben Skeggs 2022-06-01  277  	refcount_set(&cctx->refs, 1);
f48dd293613888 Ben Skeggs 2022-06-01  278  	refcount_set(&cctx->uses, 0);
f48dd293613888 Ben Skeggs 2022-06-01  279  	list_add_tail(&cctx->head, &chan->cctxs);
f48dd293613888 Ben Skeggs 2022-06-01  280  done:
f48dd293613888 Ben Skeggs 2022-06-01  281  	mutex_unlock(&cgrp->mutex);
f48dd293613888 Ben Skeggs 2022-06-01 @282  	return ret;
f48dd293613888 Ben Skeggs 2022-06-01  283  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

