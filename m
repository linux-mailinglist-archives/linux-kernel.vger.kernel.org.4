Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90A63EF5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLALXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiLALWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:22:47 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD3A6CF9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:20:26 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id m4so1231457vsc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnfdBIDx/ThTuuxIdap1q8GCjjcmxAGw3qs8tBxtzrg=;
        b=PzeC+ibqlNyJld1Tn2f8jLjq06c8fOJ83yLHBjS3ztc1gV+KW568QeoVC5zvRzmX0H
         fj7Z4m3Vs+/NLYHJW536uNxE1amEp0ZTTHDaYw1smNplw56+kticLa76tmXi+jw69SMa
         IeMvXRHFAfISdZEZfm5rFA85J/irGzSsz/G3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnfdBIDx/ThTuuxIdap1q8GCjjcmxAGw3qs8tBxtzrg=;
        b=Gg52d0anyN7CKFQ4sLui4omV9whmDM9W+k1jrwofRZDvyDaFL41NvIKhLeQJhRQyMs
         EZFOJduSjfOvx9e7JSr9L9tkmVP7VIQlGICNkX8kB+mMrekZbq2BZfFamJoLZ6Z88VoO
         8MI+8bRCErEpIoZ1WMmZmi0D3nnDFS+lHRgoDAXtHoX+ZM54kDoXkcFLt+GvD3FKNgNf
         J1/Ry2Yib1krUcfdmq1kb1tnYPN7ChslSewFMhj2JUO1rXxqor25vLAiL7Sr1xdWSqmO
         BCL1vPbyBcMuJ9tS0Hg6IwqmB8mKrg2jnULYetn1V9HKfKuB7ReM9/ZQx6imLolsD6h/
         anfA==
X-Gm-Message-State: ANoB5plcc8DRkKeGVS+jMGuJBldXfvj4uNgB0W3tVLf90HBh/dnzeKXA
        Wo7Oid2T9eTK0BZXcu1mv7O2DsWPX//e2c6yxexB14tnLmw=
X-Google-Smtp-Source: AA0mqf6Yi1TtSo1SAdDFyuKjmdVnWtDNsOV+rHvgF7IEs6aMJ2+WtlCzJxwxybiATsjU5uxcy15K+4ZVnvezmP1ONH8=
X-Received: by 2002:a05:6102:e0c:b0:3b0:6da7:39ba with SMTP id
 o12-20020a0561020e0c00b003b06da739bamr24612364vst.26.1669893625753; Thu, 01
 Dec 2022 03:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20221111082912.14557-1-matthias.bgg@kernel.org> <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
In-Reply-To: <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 19:20:14 +0800
Message-ID: <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org
Cc:     matthias.bgg@gmail.com, nancy.lin@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
> > From: Matthias Brugger <matthias.bgg@gmail.com>
> >
> > For backward compatibility we add the deprecated compatible.
> >
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> ...And tested on MT8195 Cherry Chromebook.

This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
vdosys1) that both currently use the -mmsys compatible, which in the driver
maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
vdosys0, we also have duplicate clks being registered and duplicate DRM
pipelines. On my device vdosys1 ends up winning the duplicate clock race.

I suggest just reverting this. The display stuff won't be useful unless
the drivers are able to distinguish themselves from one another.

Regards
ChenYu
