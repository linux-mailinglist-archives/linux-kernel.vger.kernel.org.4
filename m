Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526B64DC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLON1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLON1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:27:14 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25112F016
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:27:10 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q186so5245080oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsIQaBLZ4y5c4SSVGkwIGpgdreDIGpJl4ZYxNL20OAk=;
        b=GOsTQBHZJfSwCc7at+84Wne8VfHzLv+KhrFgkNn9pHjXjff4Rgb6TilqzYC8jSwxss
         iweGLomFjCzQMNuFR7SgsaFblTsV7TUu+D/EjVl+fkifbNe0J0R5DMaOuYZIXouZjF+I
         koF3xPPAEFKiWoxsQkAf/8N8ZTiIzLsimMlHDMp497CjLY8MXMQ4Reg6L+bUT4m0nUF/
         ocm2ksXC1fJs3SH8T/9/MAtkg0w/hvUJr+eklmLnKxIsWHAFEgE+vArlEeVqUvSvZX1Q
         eskt1U45Rez2uJe85ksPzc73FRCJFi4Rrwgxt4Beobh+FimXD/kiMc/n8c4zrYtWez6Q
         6Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsIQaBLZ4y5c4SSVGkwIGpgdreDIGpJl4ZYxNL20OAk=;
        b=G6HGDZmdh99i6Ei/Gs8NgAQoczMVXuiiK5sFPFX9Jp+hZATY5byY69sKZIjOIZPSF8
         k1975GQqHXqmreUNPSfg10G8Xnvz7H/zbtTYKWYlAzQ2h812Bsmd8e/xOb/7vERZR4NG
         l21luiRlgkdN+sXy/V8Oxb2siefzkw/LSALwRQzKcttB/9vFmC1U8ixMJMj1kIAsJc4g
         LMVhjlALkftU4Z2M1dROk4qDJkFr+aGlMpwyNMjONQqWEvgdlANu94gXvrRZcVc04uiy
         fsW7Cvn5tQ4dpg35Q9330qXOOYhb1uQjMXzUJEb0R2dEhcFOpMozXx88anVr0yR9Md82
         MGTg==
X-Gm-Message-State: ANoB5pn8OhyZ/6SfyUICiuetcmUeUBYBt2uplQLXwLeEqOXkpwZG6kU+
        L+0/YRSdtHnoDK/0pg+aJIavvWEFlVOGrpkuQgQ=
X-Google-Smtp-Source: AA0mqf5ANCMNl2eZjVgVSbuVvv1FF+szBstOQkYO+AUUyOEfa0KeI7RIkJUhYM1mhLy4Q2jd3etfyB7Ix1Xb0/7xIWI=
X-Received: by 2002:aca:b02:0:b0:35b:fe2a:a93b with SMTP id
 2-20020aca0b02000000b0035bfe2aa93bmr315587oil.60.1671110829956; Thu, 15 Dec
 2022 05:27:09 -0800 (PST)
MIME-Version: 1.0
References: <Yz8rIxV7bVCcfZb0@kroah.com> <20221007013708.1946061-1-zyytlz.wz@163.com>
 <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com>
 <CAJedcCwxioxr+4TBTdrEjAZh97J3oroSHSgax+bxSNRXCBvkRg@mail.gmail.com>
 <CAPM=9twhAL+c8mOLmidY_tEhEKwCh-CTjfs5yryOk8oGjMxuug@mail.gmail.com>
 <167110126066.5360.11413014428644610672@jlahtine-mobl.ger.corp.intel.com> <da557524-02ff-2ac7-7960-6f710c2d41d6@intel.com>
In-Reply-To: <da557524-02ff-2ac7-7960-6f710c2d41d6@intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 15 Dec 2022 21:26:57 +0800
Message-ID: <CAJedcCxTMx1z2AWYdfzzsnDg_s22-o1enft44AmB9D+DHQsuvg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        "security@kernel.org" <security@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "1002992920@qq.com" <1002992920@qq.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

Thanks for your reply and suggestion about fix. I am a little bit busy now.
I will review the code as soon as possible. Also thanks
Joonas for the reminding. We'll try to think out the new fix.

Best regards,
Zheng Wang
