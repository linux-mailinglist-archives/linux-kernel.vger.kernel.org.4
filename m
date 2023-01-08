Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCDC661787
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjAHReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjAHReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:34:06 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A158D2E3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:34:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g4so6631434ybg.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V2jHf0CmVk76MT9CE9txPFL+dGiXtk/VfQ6Man6idzU=;
        b=FBfOHyyAOtW6jHCnwF3qHiQm/BcwUnSxN/cZLtSdFGSv0kPAUO1XkbKXwYTTxxNjEx
         DUNuc4679uvNWcQNzRFmjEO+CidPtTxQF20n9Sk4TY6AnWcW6QqXBuFUbtpSWwI/oUIU
         8fn/VSIdNtx701CsUiASPxvRXy/L0UgmERjYbMOB2SmgFjOYyIwcQyC4a3QOiF+HLXSy
         OpEQWZHCaUn69mbCBcuCTNw/Qcvr+IPpkYym21iFA+7UmZw14rFQfCKg4UKWLV/O+Aos
         M2/upW+Fi3cvXNxtW9H5Py61p9KbZLJog339nvFO1uY8IbfAjI8y3gzGIJiTwr8cJ+B4
         S1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2jHf0CmVk76MT9CE9txPFL+dGiXtk/VfQ6Man6idzU=;
        b=DjBP12C+9uwpxIDdolGt3GtC90i2TSIsS3RLhxJ9AOfcwCEP6W9kzPI+2VaDv/CUOJ
         spXx1shE4Xt/BRJQjA0O+4gok+/eOqgEwennckh91mdWjBUbJ52ROY9TpovaQ6FPJEPP
         gCW0eCxagblnAW/XejNNjY3TAcYrOAhJCMDyE+RX7FxTI51KrruF270ilmYvo5tNPvkT
         ajv6el2VS1Phf4pKwU0Kv4V6JeaqyVrMZAM2Lstfg8uP4l9c3liHKtS6gJ6D3SxJZtLK
         0a89qW8DyRMv/bAMxrB0m8QTw6/2wADmxi7KZs9sI+/Cxg/1HzfRlLz7yuf05ozToe6e
         mzDg==
X-Gm-Message-State: AFqh2kq27KgLnxjo9h7SJXAgQiQQvV70g5O91KEoHzIqqaxqSDTxw8He
        lvKw8GDf6V3Ch+8p7ywl4paYTDl7tw30E3Hj6CP3iw==
X-Google-Smtp-Source: AMrXdXtQHxR7HAQ9ptzSEaLNQMJH1O4aFrNClHq1bePjEEhFySDo4yqRifUBGoRCDk7HUQBhZUIj4kYwXeuAcJ6NN7Q=
X-Received: by 2002:a25:606:0:b0:709:9335:236e with SMTP id
 6-20020a250606000000b007099335236emr5564526ybg.288.1673199244264; Sun, 08 Jan
 2023 09:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20230108130440.670181-1-robimarko@gmail.com>
In-Reply-To: <20230108130440.670181-1-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 8 Jan 2023 19:33:53 +0200
Message-ID: <CAA8EJpqR9w2maBB_ABXk7ggxD34WKvQS+m79-ua-nN50H79nOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: ipq8074: populate fw_name for usb3phy-s
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Sun, 8 Jan 2023 at 15:04, Robert Marko <robimarko@gmail.com> wrote:
>
> Having only .name populated in parent_data for clocks which are only
> globally searchable currently will not work as the clk core won't copy
> that name if there is no .fw_name present as well.
>
> So, populate .fw_name for usb3phy clocks in parent_data as they were
> missed by me in ("clk: qcom: ipq8074: populate fw_name for all parents").
>
> Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Ah, excuse me, this is what I asked for in the other patch. We can
only hope to see these clocks added to the gcc DT node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
