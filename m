Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7806F0909
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbjD0QDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbjD0QD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:03:26 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67E10EF;
        Thu, 27 Apr 2023 09:03:23 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-18ef8e9aa00so1595921fac.1;
        Thu, 27 Apr 2023 09:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611403; x=1685203403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr1y9U6JqcjF7tgxauaZ4W4lRJfAulLF5+mGXID0LPk=;
        b=BEqtMBFXGTyDMab6QiwW4ZgUckaB5zBgwNhzty3Z2n4fElersKI4CqGgCGq5rJoIBI
         oSFsSwST6rgPOh9GVy2xOF6F2cpmOypLTJJbAdt7DuLQAKe6ftcuD3UPdRt0ZzKv7vnd
         WeoUGqeb3cB1wh/xFGzv2lIHOHZ4PkgTzJWc0Xv+GAKkFqtwkA35Trjc4GLXfyi20K+k
         zwFKUYse0llpepoYbTZzJIMHJ9HQ/gOatezbtEO+XsIkrTfSYFrWbJgTuAtH6PipMvF1
         eNy0AVXLxVinGYyCzrmVW2Vy9g74dJBwEn4RRwAdEscmiEVebb2D0igsR1D6EfVEnJmi
         XbDA==
X-Gm-Message-State: AC+VfDxovbZN7W11wrTYPNRHal9b/5lPoKySGu4twtnpq1Ey2FPB5IeX
        T1idsLYziKhrk1fkPLtJJA==
X-Google-Smtp-Source: ACHHUZ6rFf24poxiAqmc6FB/PYRptahfgxrPN6FmGKo2Hvr+MIKjFilva6ctFx+7+hhGBXDUE6LApw==
X-Received: by 2002:a05:6871:4c6:b0:177:b2ab:47d0 with SMTP id n6-20020a05687104c600b00177b2ab47d0mr850569oai.41.1682611402575;
        Thu, 27 Apr 2023 09:03:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ea37-20020a056870072500b00177be9585desm7896480oab.1.2023.04.27.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:03:22 -0700 (PDT)
Received: (nullmailer pid 3104041 invoked by uid 1000);
        Thu, 27 Apr 2023 16:03:20 -0000
Date:   Thu, 27 Apr 2023 11:03:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH] dt-bindings: clock: r9a06g032-sysctrl: Change maintainer
 to Fabrizio Castro
Message-ID: <168261139846.3103984.1328887664979311558.robh@kernel.org>
References: <20230426100925.12063-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426100925.12063-1-chris.paterson2@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2023 11:09:25 +0100, Chris Paterson wrote:
> Gareth no longer works for Renesas.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .../devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

