Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5C63DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK3Rh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiK3Rhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:37:53 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A826128
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:37:52 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z131so2190793iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AgLyglTy78H8l7Z4AxRK05yTQEkaLjb7Bn22b4HTzc=;
        b=YJC0tOFUZMS8H4ltGhIVqvYsynpZFOxg8+jRx+MReUb+4okBBBg/gtFViYgLUiF7Hf
         NhTOE7Ux7q3q9KtdHQxpVcrilQeP8UO1wdZES8/yobRI61/rw03x4m8AMwHfnh7dGia+
         02xQmbGLIjGH1368W5I0zwQAWo4VZoWxNZTvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AgLyglTy78H8l7Z4AxRK05yTQEkaLjb7Bn22b4HTzc=;
        b=VyrqZnIwnmaqi3mw5RtK/y6XgCWqHnykT+ndBAAuxEb9iXSrYJ74ZC/znO2yDi+W8W
         Z0UutyIXgLDlMjrQHYTIxk/1KCQqkZPTlSfKk5jNLdIpwO0yZWK+oJCH+0HGKHzd8c9i
         Qbrx4nf2QJo1D7QKmzIzQ8I8DBCeijTBWDILl4CO0z49KLY8n+qxgfqlXEq3MZVWam1H
         42r99Yw7g78wbksP3lMohmEnacD4bEPNyxtwSvV28HHQMOT/cZMzpPnodTJEz7ad//sH
         /RqEMOBmeaJ5iJfqZWR3ugZlF9at6udceKkf3DqPk2PZsa6lvqLH4Tr8O52HadF5m7N5
         oM6Q==
X-Gm-Message-State: ANoB5pmqiph4WYhSs98mGwA0+7OZUaZCvTLDaAlJw3k/YDB5SdEns5V7
        Y8jDWZm1gwXbgwu+3K1VNdcQWQ==
X-Google-Smtp-Source: AA0mqf7HN4pq8PK1PkoJZAkmkGjrYX6lovaSencpUD57mriJRYzI9s5ni+O5RvyuyC7IRJWDA8blXA==
X-Received: by 2002:a05:6638:2408:b0:389:5377:d86f with SMTP id z8-20020a056638240800b003895377d86fmr14939614jat.142.1669829871458;
        Wed, 30 Nov 2022 09:37:51 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id j4-20020a02a684000000b00373aa370dc4sm756712jam.137.2022.11.30.09.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:37:50 -0800 (PST)
Date:   Wed, 30 Nov 2022 17:37:50 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4eU7ra4w3Fm+wLM@google.com>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4eN4utrDnEnKu/8@google.com>
 <Y4eP2yFKsmxzyX/4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4eP2yFKsmxzyX/4@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:16:11PM +0000, Mark Brown wrote:
> On Wed, Nov 30, 2022 at 05:07:46PM +0000, Matthias Kaehlcke wrote:
> > On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> 
> > > Add __maybe_unused tag for system PM ops suspend and resume.
> > > This is required to fix allmodconfig compilation issue.
> > > Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")
> 
> > This is incorrect, it should be '2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add
> > system suspend/resume PM ops")'. I see you fixed that in v2, but this patch
> > has already been applied ...
> 
> with the fixes tag already updated as I was applying it.

The tag of the applied patch is incorrect too, which is actually what I noticed:

Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")

This patch is for sc7180, so it should be:

Fixes: 2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops")

> > Mark, I appreciate you being responsive and picking patches quickly, it might
> > help though to leave 'external' reviewers at least some time to provide their
> > feedback :)
> 
> There's a balance with hanging on for utterly trivial patches to get
> reviewed, especially in areas where reviews aren't relaible or
> consistent.

I understand it's a balance and I certainly can't claim to be a regular reviewer
of audio patches.
