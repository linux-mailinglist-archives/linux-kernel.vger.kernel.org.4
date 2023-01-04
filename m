Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3D65CE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjADIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjADIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:08:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B91182E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:08:17 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jn22so35120333plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHSYb64FJ80mwIoAZyU1q1qJuQxSAJaJ02PPlkNgjuQ=;
        b=ffhf4eXWBt2PERbYvUEK1x5SCDboX5qm4ZnFS1MUIznIfh0hi6HFS1cGhMPpcqn46q
         gJTAOtVLEHIMycS1ovZo4M3lAwvmes3LqeR6X8sENg8I8jwXUbOcoPF9s/0fERfRcbgF
         +YgCX4VXifOyXB3f5b7hJ7H9d9mpdAtCwl0N2D1IagUHtdBuH+VIaKLkRB4shfRVY0Or
         +0K5CcCC9Kubeqdbo0nu0XhtSfy2t94TejRhzdLa6tpjL+7fP+xI9wudSfF2wOyntFjk
         SX9eet8KnAvD0d2U4vyEW0jUdDFfW2j0J6QKz5S6NvqNpRtxXjtvoxbU0WB5nK+gd1L6
         rAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHSYb64FJ80mwIoAZyU1q1qJuQxSAJaJ02PPlkNgjuQ=;
        b=ED1QOJLy8Gv5tYyoMQ9v+Jo669eFlMvN/ZCrGguTRNw7xZDbsSHOHuAaKJzuKu/c9X
         EVNDFedUady+e3UCYWbtwZ09E4qNexHWve0SL0wvs9Ww+o+DysH1D3Q1z3pcWRri69EE
         4Wa5dlOHOcfRxoTd6b/JL5cKbHQRJnO+tbmZUt+lf32QdMeueVehwtTrkdqLoLdRHpLO
         OHH8c6enQHjGjEenlJhzJpZCpuNa3OJv33TqbfEjIYGT3riEEPJ2epCbF3nzh3Tq376P
         YpKrezcXYzXFk/QgHbQo/uvDD+KFiueSDXDwfmjPWXWZl4VG7k7ARmrBhos3BIdJm+PM
         gxbA==
X-Gm-Message-State: AFqh2kou97TA4xfbME+rHy3w3ARh1YEk3Bo8h++8cXTV85Zk2uTyuzj+
        q/rTQCLheulKbMo5g6yCJmXciTVVz2W7fwMmqE7pXg==
X-Google-Smtp-Source: AMrXdXtnyMkEG9oI5Jwky77UHJWthj46fueW+qNo4Iva5YapgZ32fX41SgNYVa8pNq/7qlJ4XMhQpCLhznczijLFISc=
X-Received: by 2002:a17:902:db07:b0:192:ab97:633c with SMTP id
 m7-20020a170902db0700b00192ab97633cmr824235plx.69.1672819697110; Wed, 04 Jan
 2023 00:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20230103142120.15605-1-konrad.dybcio@linaro.org>
In-Reply-To: <20230103142120.15605-1-konrad.dybcio@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Wed, 4 Jan 2023 16:08:05 +0800
Message-ID: <CAAQ0ZWRRW7S6iFz0vJWPC1jRQ8iSvcXeWbNHE=mpHbZBe0hEDA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 3, 2023 at 10:21 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Due to what seems to be a copy-paste error, the _NRT master was
> identical to the _RT master, which should not be the case.. Fix it
> using the values available from the downstream kernel [1].
>
> [1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/scuba-bus.dtsi#127
> Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
