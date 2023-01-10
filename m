Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE723664243
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAJNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjAJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:49:23 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CA82F78D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:49:20 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4c15c4fc8ccso154424057b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44n3krIm8uSmD55/HyB5R1oD+31KNdGLUS6d9tW+5uQ=;
        b=vhotJ3I8QZ6o0V8YONaYaXj/HV/kecxNEMwtCEgE5GBsKWV9/ahydBnTXRAnAFB5vK
         8Bv6j4jmTFkIkqGKBBPhPgRL7BRLqCJOvxbslhuuqChHh8JOOx5pLG0chTHBkMvJPeKB
         qdOm+x5ISFro/dysaAH25bEr/7ioGKbFHDMGgXrqnyFn6KzeVadcw6Il64YiGxvXQFtN
         /aSz/JIfdGzF8RrcGELvdreEvNm0n2meScgUq5Qq+Tpw6xHF7XZMDlmFyKjWcdJua/0r
         2anEDx9JqN4Ia0rws2CoA8QRWKKpuHjh8Hi+8LKk54CBTcS0I0N50ZHMuD+mfOT77Gwg
         aFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44n3krIm8uSmD55/HyB5R1oD+31KNdGLUS6d9tW+5uQ=;
        b=FyZKBWQwxz1BTqqwttx4EkxwlKUiCJKlhxyXY7rXRZuEDrYcHQ9VstOrHcC4qyoq97
         LNc1+rB9g0lTUbzRK3hA4C3wt4xsq2bgyZwSvyYKB1Pw4lXe5Y1KWYLn1+yFYdbwYG5T
         x89vcuillLwIiTxHqOjWYSVUNd3CuFwQJejqMULt09ua96N9x6xJaqgcj3ctB0A+Jpkq
         lO+zQUWunotYLFjEJFV/3rOQ8FBiDnnaNOwG22dFJ1YRdweo44PLi6xXyr7KjAW2hzwc
         ca/7yPTHbeZFPJ+JZphR7IkaKSuiaVsY8mzgINyrpnmbhebha0uILID6znnXhgPjZ7JQ
         bdtA==
X-Gm-Message-State: AFqh2kpjUxCFJ+wzwIbvBlsrLAkAITLCDOUq+MKgPj/1rGzGw9OhxFS2
        8FuU/DFAc+nDb1UE0qxAgU5ucq2UEQJYA1sx32d4iQ==
X-Google-Smtp-Source: AMrXdXuYkD+ZZc5pD3tPvLUfmyEi/NTU0zo9Lq4D2HDlk7f1MnD0p57cz4H1Pn//2A9HF6YPoEBmOrcORSltK9HAqs4=
X-Received: by 2002:a05:690c:442:b0:3e9:59f3:200c with SMTP id
 bj2-20020a05690c044200b003e959f3200cmr1105726ywb.171.1673358560103; Tue, 10
 Jan 2023 05:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <20230109155801.51642-2-sebastian.reichel@collabora.com>
In-Reply-To: <20230109155801.51642-2-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Tue, 10 Jan 2023 19:19:09 +0530
Message-ID: <CA+VMnFzJwrvdY4CguWyhKZwjBqdq6bfkZdjJjsh8SLu6BcN5XQ@mail.gmail.com>
Subject: Re: [PATCHv8 1/7] dt-bindings: soc: rockchip: add initial rk3588
 syscon compatibles
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add IOC and PHP GRF syscon compatibles for RK3588.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: Jagan Teki <jagan@edgeble.ai>
