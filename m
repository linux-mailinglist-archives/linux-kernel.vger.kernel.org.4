Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB26A1914
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBXJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBXJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:52:07 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3EA63DD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:52:01 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d20so13125548vsf.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9qFm6Se/EXdsfdDRuKKStMA9t1Y7+V3hdvzyTdE1k=;
        b=KaPyZwJldbAZMed7/XIR6NSqzh75fY6A0QtfIFNwMdS7G3vWxZ+J9HAdx4yhkYkidR
         h/9jJ3mzYkS18gADZ7h9khXny+iBQhpl4mfmKAUQ8cXLfusQoGCQ18F8bBh26NQZEFS4
         YPX0b3llm/Rty2OdOfzFDZJKQrssjQlkB6j+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy9qFm6Se/EXdsfdDRuKKStMA9t1Y7+V3hdvzyTdE1k=;
        b=ObKhZyAvUyYXokYNE5fQX4h21/ovZwHcTMgBbinAFCfi7q2tgtM1tKMOM+xQtM78oF
         jaMIcgLE8cWoXI52aUILLP0ytJfFg87vEbB9ZOYjvaTujEH8GXdvK8C6ALb52PCALXAp
         cMclRnSFkJcfAlkyedGTDZ06lZJo49OqXmRXl7NIKVrTffD4HZOOFzq9aTRbaFZ+NTxF
         nxokyh4rr3P+UhEkbbakcMfn85INkrpkcCD5SBw1gQbMyyCf9Gi8DrezFASHZt4EbLWC
         696E4veJJ/mu0ZiKxQUvyNLxFlBJARxZhrvVuf8iX5lnSrThcVx1/8Srq4Y/FbnpcJwR
         i1zg==
X-Gm-Message-State: AO0yUKXZEhQKvRq4LNGtu84YjNZUIfPJcNxrEcFPr0khD2PyFWELM9rF
        KQv+JJmEFER1TUebUsH+vxA5M3mIoyb8RDH7cLYXAQ==
X-Google-Smtp-Source: AK7set9sUlfcMOdriWx5llJESulwFsPBUjog+ETyhdNs8BStWZA6c/AggwcYCCE9Et4gzRvd61o1vXs/sQ8NzgT+VdQ=
X-Received: by 2002:a67:c584:0:b0:41f:641c:f775 with SMTP id
 h4-20020a67c584000000b0041f641cf775mr308152vsk.3.1677232320295; Fri, 24 Feb
 2023 01:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:51:49 +0800
Message-ID: <CAGXv+5Eh62NFNW1T7PYiQe+9KD8qX2WB7M3rwrYD=ca872y3WQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] arm64: dts: mt8183-pumpkin: Couple VGPU and
 VSRAM_GPU regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as they have a strict voltage output
> relation to satisfy in order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
