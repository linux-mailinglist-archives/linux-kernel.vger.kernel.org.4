Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76E6F0900
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbjD0QDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbjD0QDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:03:05 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971082D72;
        Thu, 27 Apr 2023 09:03:01 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5476f480388so1959588eaf.1;
        Thu, 27 Apr 2023 09:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611381; x=1685203381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7Ml/CEl+vawmEBLg4/nGkV2KEQ7MysOl/7DPHOKhyQ=;
        b=cL7XuXtx0xkp3VYiJ//7ZicBUnZ/YqoZ482nPrHkDqwddWuR5dWM4y20QJLEPhxiow
         aQ0EW9nn1nGe6WpFCxEtL75/W10yttrgfPKrlJ5Of8IeJMgIiIsHXxkw0IFKvomG/OBZ
         WFO3Hi+dn8DAFqa3qAWPV8iFsrO0EYUl0tVImTJV6LRLPtw5tS/CaybwroQs3+6Pe/Dq
         MIK2tDIi+kgoXtcJMtPXw3batigCG+Fy8niGb6Lc7qby8D7AM2qCsFkqFABbUSpZAf9v
         Nocp2/2MFSo+PC/R8Ch1lebBBwPWTa6i/Y/yH8obYsV/pBtOmU0xPYzD4RMpL4ToEw0w
         drTQ==
X-Gm-Message-State: AC+VfDwuAbURNZYib+3OgqZRP9dCvJQnvTkokmv0zmCtgp60ZLarKXxK
        hDXEnLNAkeqGiP74EZWZhQ==
X-Google-Smtp-Source: ACHHUZ6wGGX0WvQjJKHpJQX/fvwfaHH6y8cyCNRu1YdctGfGrkFQqOuNw54OykatDhpMB7kHhP57vg==
X-Received: by 2002:a4a:ee12:0:b0:547:79f9:c142 with SMTP id bd18-20020a4aee12000000b0054779f9c142mr1153106oob.0.1682611380706;
        Thu, 27 Apr 2023 09:03:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s26-20020a4ae55a000000b00549efd1fc72sm2823177oot.35.2023.04.27.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:03:00 -0700 (PDT)
Received: (nullmailer pid 3102572 invoked by uid 1000);
        Thu, 27 Apr 2023 16:02:59 -0000
Date:   Thu, 27 Apr 2023 11:02:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzn1: Change maintainer to
 Fabrizio Castro
Message-ID: <168261137808.3102373.9519633469308697614.robh@kernel.org>
References: <20230426100802.11860-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426100802.11860-1-chris.paterson2@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2023 11:08:02 +0100, Chris Paterson wrote:
> Gareth no longer works for Renesas.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .../devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

