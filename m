Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E915EF804
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiI2OwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiI2OwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:52:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7909120BE2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:52:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 203so1828442ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cRiBROZUMZ4RO1YIJbO8on2J/l8wLjUeU2JeFbV/Dvg=;
        b=eFO3ZKn17a9Nj2KMJ8BZuiEauUPP79eUL5Y7Zv0Hzr0lDCsgTlwMY/0l73LiYi04rM
         gYaOIBg3gFAHROiXHTBzeXAP4tCXrJvo8yr5k+y2ZCxASsBbA/V3IDXSPTCK1kC8shhQ
         Dr7MjVdxXmZ2jRtmlOuJPM+M5WLuJ+4amXMd4hV3sLKoqyf5MkvHrHACqpSuKTbqm0Ln
         lemZ/qdspDaWj9mzKCY4lK/hx6svh6vslyL//6GwGuJjQuvMhSOn1AUJ+jmUQMQHpdWH
         NVn+6AQ/ce7DwhxKijlcZXDlK7SydJI1qw4WssR0RWd2aVl5niuGHyLWsLq+bbWaIyv1
         e/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cRiBROZUMZ4RO1YIJbO8on2J/l8wLjUeU2JeFbV/Dvg=;
        b=NXyUpJ7TO70IZgBeQqmwXyS3bmssn8j1KQ0WtZpNJdStkF7+5NK/l/qhqocM9twu/K
         palX9RMiYSxsoHdw1EHOWISasEbiiAP7XIUUZH4DPGX2ZCtTdkpC8344s67jAXOxH/79
         dItn/tFuDfCCeoaljLzIU1S/S2HdLHLTVVexBJlFkSt9nC3xbSWkISR7IAYIdXjGtL56
         NsRJZDib/lP53voSj/dfBf0TWgRNQaO/73UP5yDybaBqnCF7jjzZHj+mKT+cwFVPxM6h
         QsgKegEXMuXsa0Mx7sDkLTc4gGIhWTl0S7zzFm8yhU9qGpkhdU61fYiapejrXJpiAalC
         LD5g==
X-Gm-Message-State: ACrzQf3D1IM7VndYWI1iRaMpBO3Qw2RHPwe5uPBEuXBaJF8S4y4wvh2Z
        CXSdqR+w0DkgrBqKL9viIlihz8GUnKxoBzspDoA=
X-Google-Smtp-Source: AMsMyM4Pi401HcDMszsbINvIGNY9kue/h+QmEV05duXd1FVwVyf/RPxdSYURZclHgFbv9ejyeh+1r9ZeeoulZaxXy+A=
X-Received: by 2002:a25:730a:0:b0:6bc:dbd6:8278 with SMTP id
 o10-20020a25730a000000b006bcdbd68278mr223301ybc.155.1664463140548; Thu, 29
 Sep 2022 07:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XNk5Wtjju=DBOcJr46miBbaWT7jL+zjhWMp+xnz7k5K9A@mail.gmail.com>
 <87v8pa306x.wl-tiwai@suse.de> <CAFcO6XP2MpiAsF7YXYjgh7FMq+hyzFJjK8iBf=ccZ2B6BpNvOg@mail.gmail.com>
 <87leq6gglm.wl-tiwai@suse.de>
In-Reply-To: <87leq6gglm.wl-tiwai@suse.de>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Thu, 29 Sep 2022 22:52:10 +0800
Message-ID: <CAFcO6XNsqKCzNBiBF4eYyh+RCSGBp_5HSzxF0gw0kgfQ2FDAiQ@mail.gmail.com>
Subject: Re: A divide error bug in snd_pcm_write
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one fixes the problem.
https://lore.kernel.org/all/20220926135558.26580-2-tiwai@suse.de/

Regards,
 butt3rflyh4ck.

On Tue, Sep 27, 2022 at 2:01 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 26 Sep 2022 19:16:48 +0200,
> butt3rflyh4ck wrote:
> >
> > The latest kernel upstream.
> > Yes, but using mmap, you can map the runtime->status page, and then
> > copy the data through memcpy to overwrite the status->state data, or
> > even more, which is incredible.
>
> Ah, then that's exactly the case my latest patch set covers.
> Either the first patch or the second patch alone should work.
>   https://lore.kernel.org/r/20220926135558.26580-2-tiwai@suse.de
>   https://lore.kernel.org/r/20220926135558.26580-3-tiwai@suse.de
>
> Could you verify either of them fixes the problem?
>
>
> thanks,
>
> Takashi



-- 
Active Defense Lab of Venustech
