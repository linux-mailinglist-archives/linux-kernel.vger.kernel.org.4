Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE167A03A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjAXRb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjAXRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:31:45 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C74ED08
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:31:41 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5063029246dso60633607b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAWZNKWNBnz2nm7fG3oJ2Ondshli1quuAhafNezlm2I=;
        b=vmOWgr9rkUwzXlseFVsT2j864QAGrD36dNV6+hb9Z7hRLYJ8B5WeRZdEpjer9y7ZXe
         y3QrwhGV4pSrb3uagpnMn9m7/R87CzSOQh1IMiI/Ze8ueXecFpmJdcSaN8I9jtsmCAcN
         xFYH9X4OMx83uCjY9yqRshrNksPwFYRMa4Rny8507wYI6TRGrzwtgTMuGK5om09FRo3V
         6GUQgPGuq8fDJDIGNIxBaQExAtH7HCjVd4U5z+9I7stqOeHP6HY3Rrp7zHrkLvvLyufq
         4YKtIX9+fDcRiCAKfOkz6LlWFxlJr9Mq0SgSh5ihV8KN0m2O18EeAPFxR8riEi+Popz0
         7gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAWZNKWNBnz2nm7fG3oJ2Ondshli1quuAhafNezlm2I=;
        b=2eOf16UT57A8XLGxo09H+YNWVmrfHXPq/AJ0clpODCIPN5JOt2B9cs9SzdRyCZb1we
         mKnH1aErsXTtdxUiaK24yP2xK2hxUrESjle1YqVH5STki/Vk7RMEnrkYo/sELmV1mN1v
         Xqsj7Jx2zoq7FQtx0wCLpFFdp8zwcSZORUxdIRkZHq/wBpDo/kziurJg2E896L31BqyM
         bIDQeWyhVOqpej2jeMJqffh2GJvhJ2AdAfOqNKiZUh88k+bDUVW9kz70UJthqjaq/ExW
         4QsxK5TprJVgi9QlCO9AUO/yJpldME2Hm+r9ZnX90K2Y+DJVjwcJnJn31yZt2ypcmmBv
         Fzig==
X-Gm-Message-State: AFqh2kowyvjiVBuG7Cj+GwG/5BsMf26yWoIo3GM5DLmv4Ma/2kWZd3qN
        g1afzZ/9FHRemtSOzeitxJu1yMAMrtRff1C1QQf6fA==
X-Google-Smtp-Source: AMrXdXsZAyRHAzMydmJt0v6Zl159VWuKM4IasufLzc1VlCjkIdzuHw0AHwiN22tOlj83E3v3X9dDNJNrvuw/U/DjuBY=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr3916907ywc.132.1674581500991; Tue, 24
 Jan 2023 09:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20230124141541.8290-1-quic_devipriy@quicinc.com> <20230124141541.8290-8-quic_devipriy@quicinc.com>
In-Reply-To: <20230124141541.8290-8-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Jan 2023 19:11:00 +0200
Message-ID: <CAA8EJpoHqpo=QWHwO=LEbT-Mk4gr7F1X4ecL0Y+kbG8Ow6cGiQ@mail.gmail.com>
Subject: Re: [PATCH V1 7/8] arm64: dts: qcom: Add ipq9574 SoC and AL02 board support
To:     devi priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
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

On Tue, 24 Jan 2023 at 16:17, devi priya <quic_devipriy@quicinc.com> wrote:
>
> From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>
> Add initial device tree support for Qualcomm IPQ9574 SoC
> and AL02 board
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>


I suspect that the order of sign-offs is incorrect here. Your sign-off
should be the last one, as you are the person sending the patch.


-- 
With best wishes
Dmitry
