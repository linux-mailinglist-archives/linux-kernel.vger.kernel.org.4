Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360A5FB126
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJKLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:11:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537AD8D0F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:11:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso15667176pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyNu7ihVwa1kCmrsin+0WcnVl1ur8OzhltqOfbUTT10=;
        b=UZwIeeRg3uQhc+cpCzs6z0nQw2QZwvYVcjh3Tev6Nh1AaxET6iyPGP8LvCk7pGfNNO
         CWqx4NbFYdHi9MUlsJRCQzG47fLY3YozQb9exZzE5yn8D1Wq2HZSCyRL7nHPBv1r52w1
         KkCuYotEuqz/mv/klQcC8SUuxpd51/SjhC6Fi8XwDfmemRt+sDiQ48X+nnDTHoXRQw6f
         P0rBoCWkOT9k5qjy6h8dKhHD7NI2milNdGmYpnTOSju/+qlLaE51yISSZJeZhs+xML1u
         rjZWufVDRRbWpwRM/RxUzMPhDOkwdlkApaMv2pcm6VhtVpoyNBwiKy++7bIrIyWOvc8c
         CLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyNu7ihVwa1kCmrsin+0WcnVl1ur8OzhltqOfbUTT10=;
        b=cgU/kaChvDVxhWqugYdRmxpCP37rGYBWnzsTfbDciX+e5JNkJgkpWxDZRzkOe68l2D
         4ohbNLgNzCEuZs0NUeDpEiRgbf2jA0fnZwfXL13aHcyOC6HZkTL3lBoPtSCsP/FT7bqi
         cbmztUE50n9mTyktsty0A6jgaE70FfP/2+b1d2NxN/FJVeH38feUsem58hx+MPOQEvlz
         U8kLaEKk5bB6Woe9LaeCTt2FcfsBVTft+WAX2JAifX10qtTdMg296xOJRotriZbHAWbY
         9mACet9HgtiUx/i9KK66Pt1i68ncrkRJ1n/wVtpQn5lYsNbstgAdof+g4CVN97FDu/9W
         JwGQ==
X-Gm-Message-State: ACrzQf30i04SxFTjYo4m1DgQNfNZ9sVPhwDJyhnHvYg1CQPa4LO8/le0
        DMZw29QceDlKxvSfrwg2Ix9vzjJf/kG/Yc4BXQyDaw==
X-Google-Smtp-Source: AMsMyM7X9jF5KQTbREd1W8ZkKnNsDJAq+kh9AegZu7oAqTnFNWKJTzxtA4V3YI69PYMg7pEsV3hi+SDJhsdAHk7UZyc=
X-Received: by 2002:a17:90b:4b4b:b0:20a:926f:3c2e with SMTP id
 mi11-20020a17090b4b4b00b0020a926f3c2emr25763482pjb.87.1665486664825; Tue, 11
 Oct 2022 04:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220809223401.24599-1-mike.leach@linaro.org> <20220809223401.24599-4-mike.leach@linaro.org>
 <65e70db9-9f85-7285-0602-f2d29887550a@arm.com> <CAJ9a7Vgz+0xEQO-MvGUzbsr_LBh4pDep7JJtFoA+cAeiAERJFw@mail.gmail.com>
 <55170f1f-99f7-6e25-55d3-5d7247737afc@arm.com>
In-Reply-To: <55170f1f-99f7-6e25-55d3-5d7247737afc@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 11 Oct 2022 12:10:53 +0100
Message-ID: <CAJ9a7VgrJ3L6o9e0600G_JL6S_PXLsZcQDLPR_YGpSu4L=pOMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace
 ID API
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi suzuki,

On Fri, 7 Oct 2022 at 18:53, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/10/2022 14:54, Mike Leach wrote:
> > Hi Suzuki,
> >
> > On Mon, 3 Oct 2022 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 09/08/2022 23:33, Mike Leach wrote:
> >>> Updates the STM driver to use the trace ID allocation API.
> >>> This uses the _system_id calls to allocate an ID on device poll,
> >>> and release on device remove.
> >>>
> >>> The sysfs access to the STMTRACEIDR register has been changed from RW
> >>> to RO. Having this value as writable is not appropriate for the new
> >>> Trace ID scheme - and had potential to cause errors in the previous
> >>> scheme if values clashed with other sources.
> >>>
> >>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> >>> @@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
> >>>
> >>>    static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >>>    {
> >>> -     int ret;
> >>> +     int ret, trace_id;
> >>>        void __iomem *base;
> >>>        struct device *dev = &adev->dev;
> >>>        struct coresight_platform_data *pdata = NULL;
> >>> @@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
> >>>                goto stm_unregister;
> >>>        }
> >>>
> >>> +     trace_id = coresight_trace_id_get_system_id();
> >>> +     if (trace_id < 0) {
> >>
> >> The above API returns "INVALID_ID" and not a negative error status.
> >> I think it is better to fix the API to return:
> >>
> >>     ret < 0  - If there is any error
> >>              - Otherwise a positive integer
> >> And the users should be kept unaware of which ID is valid or invalid.
> >>
> >
> > coresight_trace_id_get_system_id() returns the ID if one can be
> > allocated or -EINVAL if not.
> >
> > Not sure what you are looking at here.
>
> Sorry, indeed I was mistaken there. It is the get_cpu_id() which
> returns the INVALID_ID on failure. Please could we make that
> consistent with this scheme ? i.e, < 0 on error.
>

That also returns -EINVAL, as both call the same underlying allocator.

However happy to add on the comments for the exported functions

Regards

Mike
> Also, please could we add a comment above the exported functions
> on their entry/exit criteria ? It is not clearly evident, unless
> we follow the code and figure out.
>
> Cheers
> Suzuki
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
