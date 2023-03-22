Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AD6C4778
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCVKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCVKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:21:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7B5C9FE;
        Wed, 22 Mar 2023 03:21:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso18653919pjb.2;
        Wed, 22 Mar 2023 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679480490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JHk6WrdRBOaXZfvy3sfCH7b75YTuvdgFdO1JgqgHyhk=;
        b=ESLIyorCStnd6ZJLdkq6ShlIpDoTi1na7kkDyzFImBmWJXl514bkfA7+NlxO0FBoBj
         fHOVfb9wP5/XFQ7slclalePoikPRCrD+4uEdKbXmFkxdXuHC1RW827Ka78NvU5iIXgxD
         3EzrQouxwUi8eSVWiLvDcp3nCjH7Mdc/NLS0emVo9Dl1Nr5FtmMAf/L1IYLukoqBIEOp
         wRTsGWYkv9CGlXr0iaShOu/mFDt4jKgXKb7sao+rzQSbGvj7fbwpxrch82tSgQAr3SJk
         j8phLSWEpXcYPLvwslqbq9tbYfi6A1Q6+VH1yWJSEAhz6KptZ0YZhDORctOiDuu6gMyi
         lqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHk6WrdRBOaXZfvy3sfCH7b75YTuvdgFdO1JgqgHyhk=;
        b=nKMuhdzq60YDvLQWZFGLeyEH+noxU0du1ID8Bs7fbLMekY078uw8pqrKkGxLoomSPS
         wpT4q48t6dOW3PNjh5rRFT86NmKPFQdTm0EniNLXAVGaKRgn3S1ySsrmzoCxJBrraJbk
         RhXxz/lKWfKm032XvEM3h1Qex+tReghfvCc0w3OIxAm7WWDUeDQJrlY8of5OnV7K12/3
         +sfzxczsB4BYxr5swPNCIicrZiRJKh2XbProKUwOA8rzxPpd9Wt/fQoTARi6yKe+YG4K
         5nQfrXZrB07X3vxkE284zwuD5V/1KQFGBGV1oJPXycDyKEheb+x0ezmXo+RzsGiemkbl
         DnkQ==
X-Gm-Message-State: AO0yUKVellQy4vOFLof4W3Vv5iphB+AAdmvcMQFPGOi9eFX576cJ+eGt
        37wsn3wUJkZ2y7pxOC79sENkk8kDXrWxBKjw10o=
X-Google-Smtp-Source: AK7set+PZ4mznos49hq2OljDlTJRK/UrXGgXlPBhVsXZJlMLdmy24ZzPCXCYQpg7X+qYkMuhAAwcieb4L4j1EruC/Js=
X-Received: by 2002:a17:902:e812:b0:1a1:add5:c35b with SMTP id
 u18-20020a170902e81200b001a1add5c35bmr913153plg.10.1679480490265; Wed, 22 Mar
 2023 03:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <059bec3f-0c77-fc16-83a3-d78cf82d543f@linaro.org> <bb56bbb7-7b08-79f9-ad1b-a2de63eca5f6@quicinc.com>
In-Reply-To: <bb56bbb7-7b08-79f9-ad1b-a2de63eca5f6@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 22 Mar 2023 11:21:19 +0100
Message-ID: <CAOX2RU5H=fmxjAE+Er8n7qzrvUZmOpYwgqFox-RLc2C7BqJyjQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc driver
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 11:19, Manikanta Mylavarapu
<quic_mmanikan@quicinc.com> wrote:
>
>
>
> On 3/7/2023 9:09 PM, Krzysztof Kozlowski wrote:
> > Why exactly do you need a new driver for this instead of extending
> > existing PIL? I feel all this is growing because no one wants to touch
> > existing code and merge with it...
>
> Previously we raised patch to add secure-pil to existing rproc driver.
> Bjorn suggested to introduce a new secure-pil driver.
>
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1611984013-10201-3-git-send-email-gokulsri@codeaurora.org/
>
>
> Also IPQ5018, IPQ9574 soc's follows multipd model. So we decided to
> have new driver which consists 'secure-pil + multi pd' in one
> place.

Would it be possible to have IPQ8074 and IPQ6018 support in it as well?
Cause, those are supported by ath11k but remoteproc support is missing,
I have been upstreaming parts for IPQ8074 for years now and it is usable but
we are still missing remoteproc.

Regards,
Robert

>
> Thanks & Regards,
> Manikanta.
