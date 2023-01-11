Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3B666578
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAKVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjAKVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:19:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DF6317
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:19:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so25493782lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv2a1NqKo5aZA53tRjiZ0Ie1voogHfFfahY4ZwIQhHM=;
        b=g41EMSDqpmA2PVl35TdVoQieEn9RXxLBsba8XhY33RIx97XHiCTrABe7GsZVKLqnee
         4DKyj9VMgcbmQkUaYvOsZbERNL84+qvNqLvDhxMLbYkqEBVMB/syYg1LsSd84f7Xq5I/
         Auq8FAc7ODW9BgcnI5Rt8SuvsY+JKjQvMhDjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv2a1NqKo5aZA53tRjiZ0Ie1voogHfFfahY4ZwIQhHM=;
        b=cdCF8AdN21Tp251TC+/+cqDzYg8S2LV5OIiSY94SEXLwrtfsfQdj7iVVWbyho/lNDj
         NqAHC8MbXEqLhJxhkfYmBFuiyWqI1VHAOpXxy825QgtL+MRzI1/O8kig+IW6ju8MjFGb
         ehyJCrtJAeoxsz8nKbcYpiXoIUnRQYsXl/u4oVc7OAYUpH3RjxdfGTxXGer3Ehg8gfwd
         z5TS/qBL6uTRGGjetFxxAD6AHSspoHzQ5VpOnT1qCEICf7OnfS2v+6VIBY1RUaGzFakW
         dsPREsP2D1kaOc3e6npUn6nGlIzbrnj/qN0e5n4mumfMc+hp0P1q2uGbu5RCWAEYPVUX
         fA5A==
X-Gm-Message-State: AFqh2kq2guK5sDNmzf5Kdoueuy8E3TSStuWEzvYongqsBkFmxHHtE8Od
        DkrBwVb4znIfNyQOuxOo9B9UwWIe3gsgcd8131asQg==
X-Google-Smtp-Source: AMrXdXu1qo8ydiSXNkr1gjUsIvDH+a+2FznMvvYgUDkJX3Tg9MLCiUuN3WSQ+haee1cIOmrRtPXxP5rU3apLNHYFPww=
X-Received: by 2002:ac2:5dc4:0:b0:4b6:e4c6:b751 with SMTP id
 x4-20020ac25dc4000000b004b6e4c6b751mr3249961lfq.309.1673471942140; Wed, 11
 Jan 2023 13:19:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jan 2023 13:19:01 -0800
MIME-Version: 1.0
In-Reply-To: <1672849297-3116-2-git-send-email-quic_srivasam@quicinc.com>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com> <1672849297-3116-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 Jan 2023 13:19:01 -0800
Message-ID: <CAE-0n50bLN_E+yXvwN3QX-ETewqDm5YuCePMfyKRE5sAeqyR9Q@mail.gmail.com>
Subject: Re: [RESEND v3 1/4] dt-bindings: clock: qcom,sc7280-lpasscc: Add
 qcom,adsp-pil-mode property
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:34)
> When this property is set, the remoteproc is used to boot the
> LPASS and therefore qdsp6ss clocks would be used to bring LPASS
> out of reset, hence they are directly controlled by the remoteproc.
>
> This is a cleanup done to handle overlap of regmap of lpasscc
> and adsp remoteproc blocks.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
