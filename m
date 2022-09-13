Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A800B5B6B63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiIMKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiIMKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:06:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF42CE13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:06:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o23so9499270pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=O6jrbUF08fHuArITNYPw/8Ao4hr73JYQc0MlQbsmNQY=;
        b=QxyoBCnx7yP5GitsF5rMSqGHpRqTrh9DfjJxfZ3vRQKExvK5YeMTgMGSIgCNy4lQiO
         tNyaGbgNLJLNZvMcrTl0HwpXDohIZYmieynzMfSSBc3Y8pv06nAbszqjT2yqsVpQwUE2
         4OBmqm3wbn74bUFHVO/el8zj0ZJpGXfQgrHAvBtLoyUDMrmtmRA1qirAuRzpMgSAxvVu
         9pKc7V4d54vnwfZL86sG1kp2JumAuWycp9yUcjq+urn8kh5l0bRE4z2HQ/b/Am6JT+hV
         s6G5tBsb2K7ZLcbWn5uuKuOasJbgqHfTbJmXcNbUeinYZkadRMeNSMQ04j4cNjrl5E0R
         0wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=O6jrbUF08fHuArITNYPw/8Ao4hr73JYQc0MlQbsmNQY=;
        b=Lzcx9bW1tsZlSnTpIJzsiK88bEiPGx+sNu94bMa+SAxWx9vlTIl8Ws3jWHAq4tQcQb
         Nm4PYJZL8ZkCLpkDXLhzChd4lZvw6r9ON8eCX323TXpQe5V03TnBCrdDiQt4Bh73VnOb
         M5Vt2gJOesXEpAuAqes5AC2Yi4tLbdY65O7RiQg3+XYetI7bX9xMPCch7TfuxgW3+mU1
         nyzfzqxSNO2f5KL9OK8ird55LaUuCg0LB/X01YtLwE2S/NfqVLT/Jd+JLcRbIZR2De+w
         ytql/X4AyfDDrEDH2lbkGCM4rjXsiwhbXUfze3lL911gOpqIhbHolvR+8+8tsWBcBHEc
         DlDQ==
X-Gm-Message-State: ACgBeo0/tSoaRoj4MMT+sQttXKw1MZv9o3jCbbeUZkH5VTNkujEruM7X
        lxFlEutfUakEb/OuyDjXtl0IBw==
X-Google-Smtp-Source: AA6agR5Kue3wmcDkVJAEZCPMdOPQ/RjmSQvXDxnxQawgKyFmq2siVEJ05clsHsMzLUXWIwzFLIefUA==
X-Received: by 2002:a17:903:244a:b0:177:f32b:19ff with SMTP id l10-20020a170903244a00b00177f32b19ffmr25973360pls.103.1663063590363;
        Tue, 13 Sep 2022 03:06:30 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id a24-20020a17090acb9800b001fda0505eaasm6872766pju.1.2022.09.13.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:06:29 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:06:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Huang Yiwei <quic_hyiwei@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, djakov@kernel.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Add the missing MODULE_LICENSE
Message-ID: <YyBWIUjvnHqmeWCG@leoy-yangtze.lan>
References: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
 <YyAscuyA1pKmEDH1@leoy-huanghe.lan>
 <d47faa55-9b3e-022a-c074-080ddbe0658b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47faa55-9b3e-022a-c074-080ddbe0658b@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed to Bjorn's updated email.

On Tue, Sep 13, 2022 at 04:30:50PM +0800, Huang Yiwei wrote:
> Hi Leo,
> 
> On 9/13/2022 Tue 15:08, Leo Yan wrote:
> > Hi Yiwei,
> > 
> > On Tue, Sep 13, 2022 at 02:27:21PM +0800, Huang Yiwei wrote:
> > > Since icc-common.c can be compiled as module, add the missing
> > > MODULE_LICENSE to avoid compile errors.
> > 
> > Just curious how you can enable config INTERCONNECT_QCOM as "m"
> > (module)?
> > 
> > I checked the config INTERCONNECT_QCOM which is dependent on
> > INTERCONNECT, and INTERCONNECT has below dependency:
> > 
> >    - DRM_TEGRA [=n] && HAS_IOMEM [=y] && (ARCH_TEGRA [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && DRM [=m] && OF [=y]
> >    - TEGRA_MC [=n] && MEMORY [=y] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n] && COMMON_CLK [=y])
> > 
> > Seems to me, it's impossible to enable INTERCONNECT as "m" because the
> > dependency ARCH_TEGRA/OF/COMMON_CLK cannot be configured as "m".
> > 
> > Thanks,
> > Leo
> > 
> Found the problem, INTERCONNECT_QCOM is modified to tristate internally
> so we can compile it as a module, and the new added icc-common.c uses
> INTERCONNECT_QCOM config to compile, then cause the problem.

Thanks for confirmation, Yiwei.

> So shall we change INTERCONNECT_QCOM config to tristate?

I personally think modularization is the right thing to do; to avoid
misleading you, I would leave your question to interconnect
maintainers.

Thanks,
Leo
