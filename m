Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1AF6E2B64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDNU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:59:11 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8744692
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:59:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fbee98814so118384687b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681505949; x=1684097949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dv49W7flESYqdL5B04Mpt11hCGR0GI4ibJum6v/68AA=;
        b=DAQMKvO4Dvj7K7kVGdHd40QPe8LxkMtDv4fYjPad43+OIVxl6QP4FZwvcyt7ttzBpu
         94ZxmEqJItp2xz2psZuOywuDIXXb6OBBfTEc/RsPket/UthY+AIZ7jgJE9brOKkMIE+F
         Iq1s7nZdLqCWWXk882Sd/9N3F1JQgUyUjC3vOxQ9r1yOANtdpOwUcN6f3nkpftSERYKv
         EcB2Xjur/rvGjNFur+so2FRjgJWD6phJAxygQ4l/TRovDhhl4cwJyr1z5jk+qhaCd5EH
         37BLW4pOyALVcoq75asla+0W+B62kMXilGC9Ipg+v+BXGjZIfq5hrYC+hHJ5j2ABGNl9
         2x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681505949; x=1684097949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dv49W7flESYqdL5B04Mpt11hCGR0GI4ibJum6v/68AA=;
        b=SrixYFKN4ui15OQ0vYg170vAB/6day6J523Hf629TQ3gIDnW0OBX6b3pWnDZdqzpy3
         DBVt8nbzkBigDOkrdptzauj8feBAC6h4GNW8Rrot7LwXCsqzbziOHP5c/uFPyKUY9Myj
         Ng5UAxr1Trr09oszIyG5VpeBYP3Sj9MaBYKid54q29TUBul+ePPK5Q7eFatnkVkgyfub
         2MdDfIYQmJxJba64zlTvq+u0lAVFskdMdFdFaqkyJfyrmpKZDMvIIoKtmVsZZ0Hk/SWF
         tLYuALawZ0mG3Q2XWBmcfeB/tpwBtzQxmeU5ZS2cvEYDj+YF3kTMdvsO10Ug1RlQYD04
         3n9w==
X-Gm-Message-State: AAQBX9ddh2OGG9OHYDQRYHg0rJlvWjVQ4FstFvun9VG+oUsGSK6pXZsX
        bKQdBjuENFJKAVvdH5YM1jJAWO4OJn3aEhXOLuLHFA==
X-Google-Smtp-Source: AKy350a5bm1gWE/tVYBg0HNvrT/FHvn65W/p5FJo+i+yMnXnVvF72WZP/WZnepe1irwvAj3QKtr8zmM0ybCRwSE/bsI=
X-Received: by 2002:a81:af62:0:b0:54c:bdc:ef18 with SMTP id
 x34-20020a81af62000000b0054c0bdcef18mr4596090ywj.5.1681505949142; Fri, 14 Apr
 2023 13:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <1681401401-15099-1-git-send-email-quic_khsieh@quicinc.com>
 <tgfbdk6q3uool365jqddibnbgq66clsmsm6tldxpm5toqghxpq@m2ic3oonv2s5>
 <aac210da-dec1-aab8-3f48-c33d9e7687d6@quicinc.com> <3oaangxh7gmie3cdd6rmujm7dd3hagsrnwiq3bascdtamvfn3a@bn6ou5hbsgxv>
 <c09725ff-771c-35d1-adc9-4bb1b7c1c334@quicinc.com>
In-Reply-To: <c09725ff-771c-35d1-adc9-4bb1b7c1c334@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 14 Apr 2023 23:58:58 +0300
Message-ID: <CAA8EJppKXSGcOcYEc6UKz9Eh8JizSpdDNe+cdvfmFbuBJ9zPKw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: always program dsc active bits
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 21:55, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/14/2023 10:28 AM, Marijn Suijten wrote:
> > On 2023-04-14 08:41:37, Abhinav Kumar wrote:
> >>
> >> On 4/14/2023 12:48 AM, Marijn Suijten wrote:
> >>> Capitalize DSC in the title, as discussed in v1.
> >>>
> >>> On 2023-04-13 08:56:41, Kuogee Hsieh wrote:
> >>>> In current code, the DSC active bits are written only if cfg->dsc is set.
> >>>> However, for displays which are hot-pluggable, there can be a use-case
> >>>> of disconnecting a DSC supported sink and connecting a non-DSC sink.
> >>>>
> >>>> For those cases we need to clear DSC active bits during tear down.
> >>>>
> >>>> Changes in V2:
> >>>> 1) correct commit text as suggested
> >>>> 2) correct Fixes commit id
> >>>> 3) add FIXME comment
> >>>>
> >>>> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> >>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> >>>
> >>> By default git send-email should pick this up in the CC line...  but I
> >>> had to download this patch from lore once again.
> >>>
> >>
> >> Yes, I think what happened here is, he didnt git am the prev rev and
> >> make changes on top of that so git send-email didnt pick up. We should
> >> fix that process.
> >
> > The mail was sent so it must have gone through git send-email, unless a
> > different mail client was used to send the .patch file.  I think you are
> > confusing this with git am (which doesn't need to be used if editing a
> > commit on a local branch) and subsequently git format-patch, which takes
> > a commit from a git repository and turns it into a .patch file: neither
> > of these "converts" r-b's (and other tags) to cc, that's happening in
> > git send-email (see `--suppress-cc` documentation in `man
> > git-send-email`).
> >
>
> Yes, ofcourse git send-email was used to send the patch, not any other
> mail client.
>
> Yes i am also aware that send-email converts rb to CC.
>
> But if you keep working on the local branch, then you would have to
> manually add the r-bs. If you use am of the prev version and develop on
> that, it will automatically add the r-bs.

It looks like there is some misunderstanding here. I think Marijn
doesn't question his R-B (which was present), but tries to point out
that Kuogee might want to adjust his git-send-email invocation. By
default (and that's a good practice, which we should follow),
git-send-email will CC people mentioned in such tags. Marijn didn't
get this email. So, it seems, for some reason this Cc: _mail_ header
was suppressed. Probably git-send-email invocation should be changed
to prevent suppression of adding mentioned people to CC lists.

>
>
> > I can recommend b4: it has lots of useful features including
> > automatically picking up reviews and processing revisions.  It even
> > requires a changelog to be edited ;).  However, finding the right flags
> > and trusting it'll "do as ordered" is a bit daunting at first.
> >
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >>>> index bbdc95c..1651cd7 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >>>> @@ -541,10 +541,10 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> >>>>            if (cfg->merge_3d)
> >>>>                    DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
> >>>>                                  BIT(cfg->merge_3d - MERGE_3D_0));
> >>>> -  if (cfg->dsc) {
> >>>> -          DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> >>>> -          DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> >>>> -  }
> >>>> +
> >>>> +  /* FIXME: fix reset_intf_cfg to handle teardown of dsc */
> >>>
> >>> There's more wrong than just moving (not "fix"ing) this bit of code into
> >>> reset_intf_cfg.  And this will have to be re-wrapped in `if (cfg->dsc)`
> >>> again by reverting this patch.  Perhaps that can be explained, or link
> >>> to Abhinav's explanation to make it clear to readers what this FIXME
> >>> actually means?  Let's wait for Abhinav and Dmitry to confirm the
> >>> desired communication here.
> >>>
> >>> https://lore.kernel.org/linux-arm-msm/ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com/
> >>>
> >>
> >> Yes, I am fine with linking this explanation in the commit text and
> >> mentioning that till thats fixed, we need to go with this solution. The
> >> FIXME itself is fine, I will work on it and I remember this context well.
> >
> > Looks like it was removed entirely in v3, in favour of only describing
> > it in the patch body.  The wording seems a bit off but that's fine by me
> > if you're picking this up soon anyway.
> >
> > - Marijn



-- 
With best wishes
Dmitry
