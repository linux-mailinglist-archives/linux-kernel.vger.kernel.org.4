Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580226C8804
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjCXWEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjCXWEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:04:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEC1E5F2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:04:25 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p203so3953193ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679695464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kaR8KoYOCyBpa3wXhO1e69P/3ERCtiHXhKvCkKv6lXM=;
        b=dr4L4d0WroGEG20/Bi+jk8wcIAbHjq36FQoGokCOOOUiXou4/rLD630Fa7NkGfiNHM
         F8aMEsCImFl07V1c1jf32cNJnvPiYG8wxgp84ZvL0plICJY8a+0D+eMRMiiQ7qPLMYZG
         8OvLaVnZWVPlHDhe/RMyvMMnTIkOwmxjotskiL1e7IoWSnitaQPJ3CXt1+cjoa83eB51
         RQxZT0MwiMFJPIvSY9Fq5uygOeLurQoYncUXyKo8GPrftd5C+0vfotJiuvLXEzeIaM2j
         wM5O4Or/bHXwjiczKLAIiYgu/VmwSAaP8xG/W5VqwN+trJ7XFJuaUg1V8dvGXLsnAr+E
         nvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaR8KoYOCyBpa3wXhO1e69P/3ERCtiHXhKvCkKv6lXM=;
        b=LjBOcDzgsmB4J5zRN6GjdO+XhVX21qbLbcjH/E5/WyBLPeDz401EFCVm0Am10M4h2b
         Otqn4havH3Xfym9GlYNRxmJnvLL5jtKkcXbYAZFa3396LVDMnJeGedLzcYkGFRt9l5IZ
         vQgPi7d/WVRzUAuAeLa7n+HERTD4uJ9/xGdP56HI2bZYgh1c5Z30a9/O2nFD5VAr+bnW
         QxdFJLCrqsf6gfIcSgQ6VLJ2JNSWs+Li0osdwLavaPeQ9rtqUetzGt9Sexp1Zz9lMwP7
         tuakANNDOzZvRadTdRQOc3YgDeXQQWO4udl0nyUf9PH4ttAG1fLlZQpQ0wf/5vy33cl5
         M1XA==
X-Gm-Message-State: AAQBX9cuRE9ZpJP0Xns5s5XfZfIWYTxGTEg5R71Xz0mmHca/4mAP3J8Y
        xoQbBCSHOLg4Cr2n0K2MAz1P80OuF7KxbsSSxvbmgg==
X-Google-Smtp-Source: AKy350Z4IyKzgCSsB9drN4aQZFXjzTnQ/z2hXzQ2JIAVjbZ9YcgBNEvzHIbBigw+DnHvLOMD13d24aAC6uV8Bn+RLdY=
X-Received: by 2002:a05:6902:168d:b0:b6c:2d28:b3e7 with SMTP id
 bx13-20020a056902168d00b00b6c2d28b3e7mr2295587ybb.9.1679695464535; Fri, 24
 Mar 2023 15:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-6-johan+linaro@kernel.org> <90264695-131e-46b7-46db-822b0aee9801@linaro.org>
 <ZBqypsYBMSr8HPxP@hovoldconsulting.com>
In-Reply-To: <ZBqypsYBMSr8HPxP@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Mar 2023 00:04:12 +0200
Message-ID: <CAA8EJprjkTdNT5P2_PTA-3wJqnQTgiwgOLWmrwCH0B94SZdvdw@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/msm: fix drm device leak on bind errors
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 09:46, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 21, 2023 at 04:54:51PM +0200, Dmitry Baryshkov wrote:
> > On 06/03/2023 12:07, Johan Hovold wrote:
> > > Make sure to free the DRM device also in case of early errors during
> > > bind().
> > >
> > > Fixes: 2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
> > > Cc: stable@vger.kernel.org      # 5.17
> > > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >
> > Can we migrate to devm_drm_dev_alloc instead() ? Will it make code
> > simpler and/or easier to handle?
>
> I'm just fixing the bugs here. Cleanups/rework like that can be done on
> top but should not be backported as it risks introducing new issues.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
