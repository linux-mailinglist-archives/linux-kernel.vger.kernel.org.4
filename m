Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A569142F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBIXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjBIXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:02:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790725EBE3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:02:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so5503791lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=peCJVQecXiLHv3VXuncr9j6C4VPJqGmOwwEqDhMNFz8=;
        b=B5HUOCGpwgLUqbC4wEvg3NBmzQlrcVv8I7q8behP9ZS1KxrSrTKKwgxffb5SlEdj7/
         c6kCqKxnxVI9w4nSlTtToqohyq7q4A5zg0DZCMP3kdL23OYhqEaazuWYp4HA1apk6BRP
         PotAfLhGkN3x5CgikLrhCQ5k8VuZtWz4cnjL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peCJVQecXiLHv3VXuncr9j6C4VPJqGmOwwEqDhMNFz8=;
        b=XVrYaPOiZt+mP8uAyNjy7fvxygdBQ50djuXmivFV6MzbSQyyW/E22lbqh+g4JNbIVn
         +UYLTfoZEz2EP+GGH9yqJLY1sY28+azF4CJndoWoD5Shrokyodt7QT44v4FXE5lldbio
         jpix7Cs103fDH64FrkvodP7zL366QzIQNWWYmIYruqy9rCgvGur1llaKo0NKTTH0iId+
         Na2mMgUbwGvH8HGicsCu77A7JQ3YWmIxnfQuy6VoNRzlGVsZqOtdBbFL3KJ8ozfSuc+J
         PoUr0L4OXlzB45i0Xi1F+f5VUMC0qENJeYmhHgyCIlRX4MIU9DBKYZq35n1cygmncb3R
         E1oA==
X-Gm-Message-State: AO0yUKVqKv+wRxXzeNGJhDWZI7KYTPOjv95oVjRMqykxED9pmRvxDaon
        jmK8iIzdr5NsXg5dwjWVIluqotSSE5QIywvFa4mFlQ==
X-Google-Smtp-Source: AK7set9XzpuGNqRAqXswm7rG7nSvFG+aoMpYdg/hD1V1I6Z5i9A1s7NpUUjg4N7dzUIRNs9kGqMCjDgeIKJwkZ86bPs=
X-Received: by 2002:ac2:597a:0:b0:4d8:62ec:1ec0 with SMTP id
 h26-20020ac2597a000000b004d862ec1ec0mr1894709lfp.247.1675983756760; Thu, 09
 Feb 2023 15:02:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Feb 2023 18:02:36 -0500
MIME-Version: 1.0
In-Reply-To: <1675700201-12890-6-git-send-email-quic_srivasam@quicinc.com>
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com> <1675700201-12890-6-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 9 Feb 2023 18:02:36 -0500
Message-ID: <CAE-0n51Ov_0p0JW=4M6NsVzoKUBGaZDKAJtm+wHMMLMiNpDE1Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] arm64: dts: qcom: sc7280: Update lpass_tlmm node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        andersson@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_mohs@quicinc.com, quic_rjendra@quicinc.com,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-02-06 08:16:38)
> Update lpass_tlmm clock properties, as different clock sources
> are required in ADSP enabled platforms.
> Also update LPASS_MCC register region. This is required to avoid
> memory region conflicts due to overlapping lpass_efuse Q6 regmap
> region used in LPASS PIL node.

If efuse is overlapping, why isn't that made into an nvmem device that
can be used or not used depending on the configuration?
