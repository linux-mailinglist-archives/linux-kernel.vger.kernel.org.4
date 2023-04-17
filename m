Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B76E4BED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDQOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDQOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:54:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D926EBB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m14so8676699ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743266; x=1684335266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCLJYKkdZxZvbI7eE0QQ/0jCg51WhHA8Mmj4rIg827c=;
        b=gSdxnk59aux9Ks7t+xTDiNlOocn2reV6xOQDmdlSTJ43vxmrppndG6NLbFaRjAqblF
         QdXA/0y52JznSDRWedK0EUpxoJogE+Yb990EzRImzifDmxUUa5DHEvyYOoQjeXmXzSrF
         U/C6pbOQIJlFenz9HL9MVrIw+gAt2ewhkKYy1bQ+p3aZ7cDg4AZOPdWLvNJwa+4C9m3e
         N5uRQKuVmGONeNLd+zPpLCXn4Oad95sUKufBoWPRfZ5RHVBPZ8+p/EHhGXE1cUTD0EO+
         MhAtZcLnKt8ewEZse9phadvXm0570iM3fdcDVjk1ZrjGfaB72jdYZnLU9yXy6EWKb1tH
         J15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743266; x=1684335266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCLJYKkdZxZvbI7eE0QQ/0jCg51WhHA8Mmj4rIg827c=;
        b=I+Us+1OLy5YylL9IDWoND8SXE4tbwgwb2Df2hRJM/HYDBMEtiskeh4agMYPCxUlZyn
         Y+iarljCcPaJ+XzJPDdgWI3sBk2rE7pTFeeymazerTGw1hR4SJMXT6Y0Jhk2nSLrApS4
         EewBScg7VlG9fTB0QLg8YBQPD45XLf+WcTZaFMuEJxYF3NynU3Ho9eTe/cgWHgbVFUqr
         PFZkU4ehctXZhtCj3AfotpLZKQreivGGkI3QYBCTWfmvOVV6HOfVMyNniYMvSZVPVE7D
         AvFWFvNY6oh+kYqqQ2RKP9XviEOXo8Pu4ogSXWdg/7WXiNgJq4miFZUnCcnBLnQvfGcb
         mNYg==
X-Gm-Message-State: AAQBX9e6gFkOxtTeIrzHi2sDgxk4TkyYVH+kpnBq8aS9psKucsGAon4x
        ujqGrO5N8aDBku7iONBrr25Z7sLh74/UVYHYbdQ97g==
X-Google-Smtp-Source: AKy350aRfdxFGvawukgX7i/LFvrRsMe0l7qZMZiU+wDAWzqRJaSyyPr+2CaHJzCh1RfFqYONRoPpitwVxufbScucEh8=
X-Received: by 2002:a25:ca83:0:b0:b8f:6944:afeb with SMTP id
 a125-20020a25ca83000000b00b8f6944afebmr6538932ybg.3.1681743266074; Mon, 17
 Apr 2023 07:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:53:50 +0200
Message-ID: <CAPDyKFp9vX+P2eqW+MAB8RbhNgP+ZhYRuWcow4AWrL-psLnbmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mmc: sdhci-of-arasan: Add eMMC5.1 support for
 Xilinx Versal Net
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 12:26, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> Add eMMC5.1 support for Xilinx Versal Net platform which has PHY within
> the Host Controller space.
> Also, add Xilinx Versal Net compatible for eMMC5.1 in DT binding.
>
> changes in v3:
> -> Split the 2/2 patch into two, created separate patch(3/3) to skip the
> clock delay setting for 400KHz as suggested by Adrian Hunter.
>
> changes in v2:
> -> 1/2 - Removed v5.1 from compatible string as suggested by Krzysztof.
>
> Sai Krishna Potthuri (2):
>   dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
>   mmc: sdhci-of-arasan: Skip setting clock delay for 400KHz
>
> Swati Agarwal (1):
>   mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net
>     platform
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |   5 +
>  drivers/mmc/host/sdhci-of-arasan.c            | 237 +++++++++++++++++-
>  2 files changed, 241 insertions(+), 1 deletion(-)
>

Applied for next, thanks!

Kind regards
Uffe
