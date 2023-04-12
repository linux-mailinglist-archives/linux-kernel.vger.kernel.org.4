Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869856DFFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDLU2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDLU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:28:30 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740B1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:28:29 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BAC98203E9;
        Wed, 12 Apr 2023 22:28:27 +0200 (CEST)
Date:   Wed, 12 Apr 2023 22:28:26 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-elish-*: Fix panel compatibles
Message-ID: <ny5frsoomjj6vhc3g77ybzjowx4owkuua7j2vbcnrcxsanrdxi@cgdohwtde4x5>
References: <20230412-topic-elish_compat-v1-1-4e03f95d5410@linaro.org>
 <ec2rxutblwlm2wxm6e4zlu3v5d3f6l2eqxjafq2emky6t2kvgt@3u2lo4e53ixs>
 <66851ec3-b797-6b40-865c-ec375b5ded68@linaro.org>
 <e0320172-65e0-d58f-8960-6f11a328df20@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0320172-65e0-d58f-8960-6f11a328df20@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 22:23:25, Konrad Dybcio wrote:
[..]
> >>> foo b4 requires i put something here
> >>
> >> What?
> > git checkout linux-next/master
> > <craft a single patch>
> git checkout -b branchname
> > b4 prep -e $(cat localversion-next| cut -c 2-)

I think that could just be:

    b4 prep -n branchname

(in favour of prep -e _and_ checkout -b)

Might also need to pass `-f $(cut -c 2- localversion-next)` to get the
forkpoint right though.

> > b4 prep --edit-cover
> > /* you get a bunch of EDITMEs that b4 really insists you fill out */

And what if you remove the line entirely?

- Marijn
