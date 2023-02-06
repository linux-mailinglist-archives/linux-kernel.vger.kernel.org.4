Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2F568C2A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBFQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBFQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:12:32 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C72E826;
        Mon,  6 Feb 2023 08:12:01 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 14-20020a9d010e000000b0068bdddfa263so3331347otu.2;
        Mon, 06 Feb 2023 08:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZyIIxd0QDJe2eibkr6jP0ZOO/rzo/3V0A75/9lkRTg=;
        b=QpA8aijBXZl75q7e5DFuPLP+BzRNByvitOl8wDaJur31tALQGCjDD8snuU4Q5DxtEH
         kylK7icz2kyFNxnh9qSVuGMVL06G3vlOSyj/F9LwW+fEVRTRtzcZHE12TRtKRKZACxfE
         zDdp7muRgfc2thxswf6sy6sPmWWpn9//9gOhHX4ErqKhm9vyj0dmIJLf5dQnsxCbnNtY
         9CFBayAjzBFQJe6w1jW7DzhW+SE1wyxo51exhJxJ5rLGGYBwzl9dSwcWaC9hbZYgVJKP
         h2SoQg9Og5gVbu+ZZ2SpOKBsE7Bumc37IDTE3hTQITTmCv9UmvjjqeE0p7LdMT89Ree8
         migQ==
X-Gm-Message-State: AO0yUKUa3NhO5avvPfilTYcVCNXa+Y1PIIUXB7TalRT3iH5i+ctKBAc1
        Za8+mUD6d4WP/IL0uU6zUg==
X-Google-Smtp-Source: AK7set+iTHOenGkRMkTkO2+v1ukFLDnWlQnmJQtdoTqg8mRqe/aJlMy1yM4UmY7oA/jZzPvcV1HOPA==
X-Received: by 2002:a9d:4549:0:b0:68d:6a22:396c with SMTP id p9-20020a9d4549000000b0068d6a22396cmr67122oti.3.1675699900416;
        Mon, 06 Feb 2023 08:11:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m14-20020a9d6ace000000b0068bce0cd4e1sm5092762otq.9.2023.02.06.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:11:40 -0800 (PST)
Received: (nullmailer pid 162328 invoked by uid 1000);
        Mon, 06 Feb 2023 16:11:39 -0000
Date:   Mon, 6 Feb 2023 10:11:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>, linux-gpio@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Andreas Schwab <schwab@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: pinctrl: Add StarFive JH7110 aon
 pinctrl
Message-ID: <167569988090.161822.12197118549919509895.robh@kernel.org>
References: <20230203141801.59083-1-hal.feng@starfivetech.com>
 <20230203141801.59083-3-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203141801.59083-3-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 22:17:59 +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 123 ++++++++++++++++++
>  .../pinctrl/starfive,jh7110-pinctrl.h         |  22 ++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> 

With the issue noted fixed:

Reviewed-by: Rob Herring <robh@kernel.org>

