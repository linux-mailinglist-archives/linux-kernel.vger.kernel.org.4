Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB2658AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiL2J0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiL2JZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:25:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB631E4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:25:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs20so14802119wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXSUc7XHv0bfEy70PXNaXzaqNq55P4wATYmwSDCQdhk=;
        b=Et+i0j2afzPO3JhTA8HJQIrPEvHTdrXDaqp+dpFiljvG+8QtKK0r42j2+tej/IdsyZ
         0tf3JgPD+nWtYBmIb0HtevBgjJRkJ1GqX3bq4xyngYVPvWors+1UkrZIwZ4fhDJf77Kw
         hIq2uhedd6g0NKWlbqhr9WsUUc5AaBf3vpyO10qMFBpQCV7fyhxvcQrd7ZMemql22IuF
         iak0iXQtccX0Zb4DjZH3Q/ZtDoNK/tX9zadL8HJDs9hFd7V4g7JzmV8yWc5g7tHh8zlO
         oPaNfjlRRokMxXEqgELfDgd/auDyjZ7o9vbTadnPf5bGk5GrDl/wu7HAhzBsGnA/hMFL
         uByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXSUc7XHv0bfEy70PXNaXzaqNq55P4wATYmwSDCQdhk=;
        b=E0/0+AYTHlLdf8JOyJd0UGEg8cDX4gjkglP+D7qVN3q6jGDF35c/yXTpunKkwvKlXT
         omnq6n93vRMxB6uHa7S7Uz7QmgoO1TC53ew10Y1AC6tIZX+ftnqDDCicuSOVvxBsC9VX
         hzIMZSRVBrgsMhTwYY+jvD7FzHhFzmA8zbXKvu1kDmAeL8TSuGESFr1RzrLj4xMNKIRr
         6DnirmCx2Y2Ku8j5iJ0gmLWsAuBHH5n7G2L1GKTL7ogpbKtGzWjMfw4emuTy+diI8GEq
         KQApWN7BX/htIcdwgqREjmKMEXeKTLH00HbTuFGIBp2GGGntOyq+N0WiiPyPyelgB9o6
         FnNg==
X-Gm-Message-State: AFqh2kpz5RCM58+/TcKu9vi4+YHc/NX0zzLfU2vcjP5JzOpj4Qj+czn8
        JAy6mIN8DDJznjZmG6L5GL8=
X-Google-Smtp-Source: AMrXdXsxOfYI7KAZ0tpzFwM+5Jt3IQya/tuOYHwElEwqyK/BA3c0IOfooUCtG7n1diDhtbka6r5sag==
X-Received: by 2002:a5d:6588:0:b0:275:4c60:1a31 with SMTP id q8-20020a5d6588000000b002754c601a31mr13428560wru.14.1672305955109;
        Thu, 29 Dec 2022 01:25:55 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b00282194eaf7bsm7524106wrq.71.2022.12.29.01.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:25:54 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:25:47 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:466
 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.
Message-ID: <202212261100.ADnY9d8X-lkp@intel.com>
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
commit: ca081fff6ecc63c86a99918230cc9b947bebae8a drm/nouveau/gr/gf100-: generate golden context during first object alloc
config: s390-randconfig-m041-20221225
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:466 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.

vim +466 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c

27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  377  static int
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  378  gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_fifo_chan *fifoch,
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  379  		  const struct nvkm_oclass *oclass,
e3c71eb27419b6 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-01-14  380  		  struct nvkm_object **pobject)
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  381  {
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  382  	struct gf100_gr *gr = gf100_gr(base);
bfee3f3d97db88 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  383  	struct gf100_gr_data *data = gr->mmio_data;
bfee3f3d97db88 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  384  	struct gf100_gr_mmio *mmio = gr->mmio_list;
e3c71eb27419b6 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-01-14  385  	struct gf100_gr_chan *chan;
019e4d76c6e91b drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2017-11-01  386  	struct gf100_vmm_map_v0 args = { .priv = 1 };
227c95d90a3c50 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  387  	struct nvkm_device *device = gr->base.engine.subdev.device;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  388  	int ret, i;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  389  
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  390  	if (!(chan = kzalloc(sizeof(*chan), GFP_KERNEL)))
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  391  		return -ENOMEM;
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  392  	nvkm_object_ctor(&gf100_gr_chan, oclass, &chan->object);
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  393  	chan->gr = gr;
019e4d76c6e91b drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2017-11-01  394  	chan->vmm = nvkm_vmm_ref(fifoch->vmm);
27f3d6cf803249 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  395  	*pobject = &chan->object;
966a5b7daa15e1 drivers/gpu/drm/nouveau/nvc0_graph.c             Ben Skeggs 2010-11-24  396  
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  397  	/* Generate golden context image. */
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  398  	mutex_lock(&gr->fecs.mutex);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  399  	if (gr->data == NULL) {
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  400  		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  401  		if (ret) {
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  402  			nvkm_error(&base->engine.subdev, "failed to construct context\n");
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  403  			return ret;

Needs a mutex_unlock(&gr->fecs.mutex);

ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  404  		}
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  405  	}
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  406  	mutex_unlock(&gr->fecs.mutex);
ca081fff6ecc63 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2022-06-01  407  
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  408  	/* allocate memory for a "mmio list" buffer that's used by the HUB
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  409  	 * fuc to modify some per-context register settings on first load
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  410  	 * of the context.
ac1499d9573f4a drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-08-04  411  	 */
227c95d90a3c50 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  412  	ret = nvkm_memory_new(device, NVKM_MEM_TARGET_INST, 0x1000, 0x100,
227c95d90a3c50 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c   Ben Skeggs 2015-08-20  413  			      false, &chan->mmio);
73a60c0d218a29 drivers/gpu/drm/nouveau/core/engine/graph/nvc0.c Ben Skeggs 2012-07-13  414  	if (ret)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

