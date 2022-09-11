Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF95B51AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIKWx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIKWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:53:54 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658620182
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:53:53 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-127d10b4f19so18965193fac.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date;
        bh=R0Xe62CKqg1FjucP7NunxjUjOTqqu84A+guaTpi+kNo=;
        b=FTd2AeTvIBSI1/fx7Ds0M+6SFsq4MZyXzV5o39QxPabwSFCeGLUkTTGfYkAsz9NBKT
         79xQYhfFhoxww/uFE7H/V7zpZbQQzLocezZu43dt4Dz9VU4E0/+30oFIXIz7+ja8cw1Q
         PVYCgERF2VAGgBYgtRN5VBOjxtiqQZOVh1fA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R0Xe62CKqg1FjucP7NunxjUjOTqqu84A+guaTpi+kNo=;
        b=RQ9BJLO6I+x4/nngz8htRbZ+VYGdg44C2RedSgIpI0HaRbpWkW2QaCCmjUK0LywWtk
         5NC3ej7rlSjbfH5IOfE2B/9SGaQPgxtEWgtpg+U8D0yBvxJR1uLwvdIl9dR2ytuPthjl
         FCpD3NqcR53IA8tDr1hvuopZc9BX725rzkGclCqfTySaBVfRdCXQef0fbU/9Y2c5GGZx
         mwGKwegVXA5Dh5XqhaJZXz/o6P+BgYzSjUwEqmmKnPy6oO525zt21IWgYVWN6q6wiBET
         88VoSsJasFw2zrWMHoeIz7w0ocmHSWiPrXWbVd3VXwEF3x/pff7rNvs5dd5ToakQJS6E
         aiSg==
X-Gm-Message-State: ACgBeo19n0KGXThdepAXDEYLTuXFw4uz1WQhKFw30BuwVTRsyIAmn8sS
        881xFCQFxqZX8ZZZOaE31K0doqgoCJPxclM+rGQdAQ==
X-Google-Smtp-Source: AA6agR7p7DOQVvWBuWdS4FNFDI/yWu78jAI8Lol3RU4hpSvR1XPiDf+9BNXPpiLd43jKteUzzh7vh3kywdcpj1xfsZo=
X-Received: by 2002:a05:6871:6a1:b0:127:3a21:7e00 with SMTP id
 l33-20020a05687106a100b001273a217e00mr10575784oao.44.1662936832620; Sun, 11
 Sep 2022 15:53:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Sep 2022 17:53:52 -0500
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-4-git-send-email-quic_srivasam@quicinc.com>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com> <1662643422-14909-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sun, 11 Sep 2022 17:53:52 -0500
Message-ID: <CAE-0n53_i89jvcUwFUDgnfx28sFt8+7r3_jWBWYvDf6MMhAnvQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] remoteproc: qcom: Add compatible name for SC7280 ADSP
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-09-08 06:23:37)
> Update adsp pil data and compatible name for loading ADSP
> binary on SC7280 based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
