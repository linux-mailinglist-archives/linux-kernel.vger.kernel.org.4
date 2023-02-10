Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515DF6916C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBJCme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBJCmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:42:32 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4F70949
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:42:31 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id y8so4324966vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jo90fT9adw4ITfAMKjbT+YaT323PiF40asmocQVPwZs=;
        b=CbFq9vhgLS1sRE+/bqsyALNQx2TMg+62Skowqei1rCDgiyfy8DRSr/pCnN4LTzHL0O
         l9ckKikPmnO1x+q0mbrcN8GQz3h2dALUhz27Y8xaz87EwdyGgmOlV/m+KDvwm3u8LdsT
         3WuGpSS2ALR90HVx0lEQTmDG3Ws3WtzR7qvvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jo90fT9adw4ITfAMKjbT+YaT323PiF40asmocQVPwZs=;
        b=ZRgsaaWOjpfBTBbP4JtUzUAw6Ua+BrzeaQOLoSyjF+2eIl8OXwgsqMIULggTgZwV7M
         tf9N2MIyjPfB8+i5v59L7/TGP+tZ0wo8sWD18LQvufHKwLU5M/H7rp2iAqOX16SN1/tF
         ikafr3zjyretFTpAe7ZoVHxvE/cIKphOVY4j5sAD078Sx2wsF+MECLOHgVL1UImT5wYw
         C8oje+EnxYrEvpTatO5x7ebDZ8kAlOgzHUWg5UcjhpuYQUV5ON/pvxwFbxw6jyGJiTtj
         7bc/NrnNQDkYRcHkak2fvZtEElxygsRUw1wWrFR2q1/0H52uf3UM1CKyghoi7vW/OX7j
         8DZw==
X-Gm-Message-State: AO0yUKUGEjZbJTj/CLdvE9+nbRP3l6dUEAC9nYWHc/kunrLiwvPGFEYd
        KEuTt57NU4/INCcIFzPJBo+vgYKplUGHziZcOxEfxg==
X-Google-Smtp-Source: AK7set8Q7Lk8HSrYlSHpANJRpQOSKPsQkJY82+BNpWbh3s+xkeDmu/ISTNHWmy67hfWHfHrGfG2EUe8RJ9JbcZwPGx0=
X-Received: by 2002:a05:6102:3d18:b0:3f7:93c4:9e56 with SMTP id
 i24-20020a0561023d1800b003f793c49e56mr3689418vsv.85.1675996950383; Thu, 09
 Feb 2023 18:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230209160357.19307-1-matthias.bgg@kernel.org> <20230209160357.19307-2-matthias.bgg@kernel.org>
In-Reply-To: <20230209160357.19307-2-matthias.bgg@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Feb 2023 10:42:19 +0800
Message-ID: <CAGXv+5Ek5E4XYyv9iM35o4sNRbfqVZMw6PqmeZHxzTps-SAq2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: mt8167: Align mmsys node name with dtschema
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
> The node name should be generic and mmsys expcets 'syscon'
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
