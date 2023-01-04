Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03E065CC13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjADDLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADDLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:11:36 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73643C4E;
        Tue,  3 Jan 2023 19:11:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so79439214eji.5;
        Tue, 03 Jan 2023 19:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJPVZN9YxMZipYcXK4sYIC65NdGrckKub6eogFORZ0=;
        b=A97pJA4D6VL8OWkyoYdPBp9sebjVHYMAnxnUTVBsC6Ed0xC1UH0Zj4w7N/y+PhSlKh
         TGOgvFPqKeMNjXO5IwH4yeRe6uO6uxD+HQb8Ej2KJJ16h7gfKCZIxzbPD3Dcv0dqjGmW
         JEAnljl0sqK6xECKMfMzjLHVbrr5COrqsc2RIm4Wpu14xqJ02elTeYgrs2hXPxO/G+8p
         ergo5dQ29VlCgUQ9uOz8lUuk/VBD7j0shcvYs7EpCK8p3Lv8YPhV0pA/PdclEBX3L6bj
         SAlp3+/v0WJBUKif5BHlyu3LfMVuiNYfOVJAK4tZX+qw7tQ847BSBWLDJ0Uz4Dr6HAqZ
         8yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdJPVZN9YxMZipYcXK4sYIC65NdGrckKub6eogFORZ0=;
        b=7anVfxDHrfknRrKPTz5KJocc1yj4XcegHBFEo+ickd8vP1sVzCL1c52Jmwvr/TIkX+
         9VLWKRvzHTxBEUrQYzAmZUYwzLKPcbkZPVrYAN+Bdkm00BN64CHgwWQA7hONbAtueUjP
         uFvdBDkQ4xIozLI8DdC7LJr2k/ajsrVMHCrFENrs2gS+6qS8UZv5irQHIexiLpVkq3lJ
         mMRFLQQ4f8l4OucZ5HNRl5lAh/jEMG8dx9xAgrtXIlNBdveaG2Szp4SxFOANkCpF4Cxf
         ppm5v5GlYjFrA7dJM4EaX6LZxxdC39AfVrLMRnxhVOmleXE4xDVpQ7sb0KFzHNwlC2fC
         QJ8w==
X-Gm-Message-State: AFqh2ko4qMdGYmEDk5enbVnW0VD+0czbkTKcNUid4bR9yRqzAlPlk2Dw
        57OazF57AET+YBZ/630HyzC2F7ILcWlbaFiPk3c=
X-Google-Smtp-Source: AMrXdXvLKbM8HoryTnEirOZc0Ad+7s7nlxw/El8voXxJbD53XvLEodH6oroLujJTW1Q+dJswl7vgb0AG6F5YvxBABSI=
X-Received: by 2002:a17:906:c299:b0:7ba:708f:2a03 with SMTP id
 r25-20020a170906c29900b007ba708f2a03mr3215853ejz.167.1672801893995; Tue, 03
 Jan 2023 19:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20230104021445.47484-1-quic_bqiang@quicinc.com>
 <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com> <7dac372b-167c-2dff-b207-6e32fd40c7bb@quicinc.com>
In-Reply-To: <7dac372b-167c-2dff-b207-6e32fd40c7bb@quicinc.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Tue, 3 Jan 2023 20:11:22 -0700
Message-ID: <CAOCk7NqNrxcXLsw3PRRdsiOrq5SB9DfxpuSH84-rB9-43fdpog@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
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

On Tue, Jan 3, 2023 at 7:57 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>
>
> On 1/4/2023 10:41 AM, Jeffrey Hugo wrote:
> > Why was this not sent to the MHI mailing list?
> I don't know the MHI mailing list address, could tell me that?

The relevant entry from MAINTAINERS -

MHI BUS
M: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
L: mhi@lists.linux.dev
L: linux-arm-msm@vger.kernel.org
S: Maintained
T: git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
F: Documentation/ABI/stable/sysfs-bus-mhi
F: Documentation/mhi/
F: drivers/bus/mhi/
F: include/linux/mhi.h

> >
> > On Tue, Jan 3, 2023 at 7:19 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
> >> Currently no log printed when SYS_ERR happens, this makes
> >> debug quite hard, so change log level to make it noisy.
> > You are going to need to explain this more.
> > There are two drivers in the upstream kernel that are MHI clients -
> > pci_generic and ath11k.
> > I'm assuming that you care about ath11k because you included that mail list.
> Yes, I am talking about ath11k.
> > In ath11k_mhi_op_status_cb() I see a warning message printed when the
> > syserr callback is triggered.
> > I see something similar in pci_generic.
> >
> > Looks like a log is printed when SYS_ERR happens in all possible
> > scenarios, so I don't understand the point of this change.
> > Particularly given that dev_dbg messages can be trivially enabled.
> >
> > -Jeff
>
> Well, this is not true in some cases. For example, we have met cases where
>
> WLAN HW/firmware is not working well, and only send a SYS_ERR event to MHI
>
> driver, however this event is not sent to ath11k host becuase of
> mhi_pm_sys_err_handler(),
>
> so we got no log at all.
>

With the 6.1 kernel?

mhi_pm_sys_err_handler() queues the st_worker.

mhi_pm_st_worker() , which is the st_worker function, calls
mhi_pm_sys_error_transition() in the DEV_ST_TRANSITION_SYS_ERR case
(we are processing a SYS_ERR).

Pretty much the first thing mhi_pm_sys_err_transition() does is this -

/* We must notify MHI control driver so it can clean up first */
mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);

Which calls the ath11k driver ath11k_mhi_op_status_cb() I mentioned earlier.

-Jeff
