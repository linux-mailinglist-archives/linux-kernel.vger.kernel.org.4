Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C36A188E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBXJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBXJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:13:07 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5366629B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:12:38 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id j14so20575110vse.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qoo0Vl6Dt6+rRFuuAIcMuZATYWf1GK6779hkAk6CE4=;
        b=ZjPNlKUyIo7tNRDIxYTYuF7YTMR/erUuudAm8uZtmcoRkOW3CV1paGAOl7X1VC65Kr
         Z6eSKAiYHLmTsaJ/J3gbRAba8BV+KEPVEP+qanXhg+mav/BY9GlOqJLPB/yvnNT7pkM4
         2ikpZ6yDaQdRtMuD914DMA/lDdtdfQh5O/zTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qoo0Vl6Dt6+rRFuuAIcMuZATYWf1GK6779hkAk6CE4=;
        b=EORhP7w+z7U15pZS30m6fNUG6NVElHuYx4ZWUXqszOTMUfkQayPHIWkfhILpUR/Zqj
         /NVYXw7Y0hEwXytRtakAuaeqkqyluKjaAsMcmhfwnzLxN85NTZKRGK7/b8qroeU+p1H/
         2t8M7+0+Kbp9mCJorDygr92FU/c7r8jGW/FAwnlzdgclu2fz53IERfGyZ0FB2o023AV5
         WRuuC+feoP5HHrOFuRmkTgtY4EunRqux5Lm+1ZoQkFCFCkPCLS/9kBIw+TOOClIAO+ZS
         8KToNoJnN/BrKoeIZaFI2zcNMept5UTQhI4IR4a5I0j/BTUugGhn9MXL6yrc/BsqIYXW
         74oQ==
X-Gm-Message-State: AO0yUKWIz2UfvjIJroA0Op85BcizqKz0bKXmhIAvPcRm5rtfV1gCNYJm
        aB+V4GDCeqcrRyVEG0wTj46ZL+GtCeNcu0FLe3nKVg==
X-Google-Smtp-Source: AK7set/kZM+FtzDiARLR/jfO3rdOy/faEqk4bCEdVebsQUHQkhnwfGQlKHeg2rZg9NqLac7Tpv7VJ2de/hYHIO2cTYE=
X-Received: by 2002:a05:6102:1592:b0:412:5424:e58e with SMTP id
 g18-20020a056102159200b004125424e58emr2312489vsv.0.1677229954275; Fri, 24 Feb
 2023 01:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com> <20230223145426.193590-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223145426.193590-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:12:23 +0800
Message-ID: <CAGXv+5HyqPLYqXBwwExRUXy0BhykX7K+gGGnGCZ1rAmJhm9Hyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: mediatek: cherry: Enable PCI-Express
 ports for WiFi
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Feb 23, 2023 at 10:55 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
> over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
> to enable enumerating this chip.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  7 ++++++

For pcie0 in tomato-r1, this is not used for WiFi. This was only used in
the earliest version for NVMe. It was subsequently removed. Please add it in
a separate patch.

>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++

For pcie1 in Cherry:

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
