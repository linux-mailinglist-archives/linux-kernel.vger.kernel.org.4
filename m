Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6566916C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJCmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBJCms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:42:48 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EB70956
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:42:44 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v5so1989407vkc.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52xSp5wmYAd5hFLJ9WZGw8pChWVD+OAjWtck6oN5dzs=;
        b=U1fCU9dL7zEQQUng1tf5EwsK3VWDYVsNNyBj39FW19d1Mr7MMWDk3X92i8GTR2E/v0
         47ufcXPTM+wllgKMkSh+S1EEpjBhwtLcJgqOur9mlxYBGhCpe05yzGcH6VqrQwTPoLAV
         Rt9ONCKI6fv1m3JL4fhZrhRxitGMBVxaGnuHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52xSp5wmYAd5hFLJ9WZGw8pChWVD+OAjWtck6oN5dzs=;
        b=vSnlupdQ+VrsOjgeucaYAAOwNdRSUbSWXVRUU/w+pG4ivFEvd1DXYcUoKINQ4D4qMa
         IBzy/Tyrtso/tcPjqXAdfSKmtKsj68lKQIWWS3dDiWnVH9tHJPInao3NdkPhpnIr14Px
         Aga6WbB+LJHXcoFSTwfDYTdIJh6VmhS4H/HvjnLrfz3W/H4uG8KpFv8/vpBqu4XD15wJ
         uJve81ZeiSRGRBHSrYnnMsWFWFVZzvrLOKFJzQD6wPT4F9I7LZ/ZDPLeISy1bT1SUcSw
         +/YeNa5FQtJYdhhNZhN4QW/ILPx9TgPxbsRaqpmYZCsJ3srFQ7rlmN6WB2WNwJVFcC4T
         5lxw==
X-Gm-Message-State: AO0yUKUSge89PptS13QfclxKUDaev3Z8zLLnQwUdJzr7OVs+7NPVDpfe
        yiYQ1TiVmmC/oMHwIz5Toict6TZ1X2Q01+CZIVBXSAmrdrNisxK2
X-Google-Smtp-Source: AK7set/pFESZTcCKGsksw48p4w49A2qXmUP7rMlB1Od7HUbkX1rQ/0T8voev8FHMMturLnSAI+My622kXRWl2w49i/E=
X-Received: by 2002:a1f:f242:0:b0:400:db86:64de with SMTP id
 q63-20020a1ff242000000b00400db8664demr2812373vkh.22.1675996964119; Thu, 09
 Feb 2023 18:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20230209160357.19307-1-matthias.bgg@kernel.org> <20230209160357.19307-3-matthias.bgg@kernel.org>
In-Reply-To: <20230209160357.19307-3-matthias.bgg@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Feb 2023 10:42:32 +0800
Message-ID: <CAGXv+5HjnP6DC9RV9MUSatyuD0S64K+=kafifFJqYgOhSWu02Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: mt8195: Align vppsys node to dtschema
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:04 AM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> As the node is a syscon, this has to be reflected in the compatible and
> the node name.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
