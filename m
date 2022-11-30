Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547BF63E2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3VvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK3VvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:51:12 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A65AE36;
        Wed, 30 Nov 2022 13:51:12 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id m204so59183oib.6;
        Wed, 30 Nov 2022 13:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed0ydWV+6MGo0R7QavnrcUotFip+FDP5jOASQ/l4gg4=;
        b=wWTxSqzxGt4zue1i+dwEUcjJVFjggML7zPNrTA+ytu8XpGWWPLSQDYCm/gNH08A3xc
         jHD3PIFtcxtxi9Q6zKOSUnsdbFkUQ0xdR+N1Cq25gDfKVkVvZm2w26wZ4ODV7ketry38
         5RaBbICtx3vDIJgl1Etw6YK5DeiIMZp9hU/arO5C9YVensHVXbrGPi9w+xDThN7f9utW
         4LzFpXbVpnYClWHpNkzmLaoKhUUS293NqZgkmkRlBShPQUfiH6XE1adisE2HhUU1bV3y
         U+VccLMOA8hQ082qQT8K4+c1N5iv6YSVwxHHs86Il9PzxNBQ4I/1/Qynfje9gLtzOu3t
         rjCQ==
X-Gm-Message-State: ANoB5pkL73Ik8RFwg5yo7lWiYxevIrUPSBg8qKC47aTMI+l514XQesmI
        iDJKoSk2jEQXvoz4LFwfjw==
X-Google-Smtp-Source: AA0mqf7J8e2oXFovz2VgTSEz3/EdPmTWw6BjtL7XC784CxAbJ1Z+zs/qpUiq5LLxHKDpZyxShWaJRA==
X-Received: by 2002:a05:6808:14d1:b0:35b:92a4:fcae with SMTP id f17-20020a05680814d100b0035b92a4fcaemr13100578oiw.102.1669845071240;
        Wed, 30 Nov 2022 13:51:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 185-20020aca05c2000000b0035b7002af8csm1057826oif.56.2022.11.30.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:51:10 -0800 (PST)
Received: (nullmailer pid 2988879 invoked by uid 1000);
        Wed, 30 Nov 2022 21:51:09 -0000
Date:   Wed, 30 Nov 2022 15:51:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/18] dt-bindings: msm: dsi-controller-main: Rename
 qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl
Message-ID: <20221130215109.GA2986716-robh@kernel.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-4-bryan.odonoghue@linaro.org>
 <dc5df66c-2e2b-14f1-ce88-705d831f37d9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5df66c-2e2b-14f1-ce88-705d831f37d9@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 08:54:11PM +0200, Dmitry Baryshkov wrote:
> On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> > We will add in a number of compat strings to dsi-controller-main.yaml in
> > the format "qcom,socname-dsi-ctrl" convert the currently unused
> > qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl.
> > 
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> I'd say, as you are going to introduce new bindings using two compat
> strings, just leave this binding as is, marking it as deprecated.

But if it was unused, then it's okay to just change it.

Rob
