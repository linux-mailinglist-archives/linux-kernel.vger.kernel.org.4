Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7046F19AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbjD1Ndr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbjD1Ndp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:33:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A42D65
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:33:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso6276745f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682688822; x=1685280822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKl2QXN/TOBQAoCAOBqwrjWHK7KbPJL/dw8lPZ3RGtI=;
        b=xLeBQIrC7o4aczohLPASe6lZ5dnbwR82k2+gkdXjyWAjUOX9+6aUfK8Uql+HFOTTVa
         RDuZl5IWobYrD2VBvg3u2krkhDX3bd9FWQcKtpNBSXINT1Aah4W7wvO5boFShS5kCoBY
         Hg6iblu0e1LwNzd/DMbjKN3PhzNfpVE+CtlHxIKX8xhpM9yVBuC6isOyi4jFltxhJ+yk
         NBj2evqX9+bg/qWiOVGUfN7nLUmYPaD/UO/uH4/rKRKCDT4pV9dyCd4tmTtjkVMvKcYN
         0dwKR9S190QzZJ2utoF/9hD2GndTUss7p23zR5o+EMFDDjPEcIL09g7e400aSJ2+DDwe
         WUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688822; x=1685280822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKl2QXN/TOBQAoCAOBqwrjWHK7KbPJL/dw8lPZ3RGtI=;
        b=d/1n7iBTumUINqKzFJNhGxfYM8gLeL57zD0TwXn1i+KESxbEuflY3c7ct5LpeiFUrp
         3U6TxGNpebjwBgCRWWeKGXExbhdffsRYaXH4dNqrIflKL+1YR2mWWs3QHHAJbq8S+vhh
         M7ksb3EKKdwZuSpR5Zy1/ozgDjjtD+yrTgW0QA48lV1TUOA2AsasrUCgm/fWwkg+f5bS
         dawtdu0N1LOiDS/kYh2SMWrJsXNj06sTMo7eXlqxjKsxrhvfrdiuHfIgWToZt26PmtEB
         A0zHl6kbsGhJ1LlcbFXT/IOEs4n7pIIAOx2h4hgHukETaJm7IdpRkmWODPVC3hsuybjp
         8YKQ==
X-Gm-Message-State: AC+VfDxvQNx4gOqPPgqEstMRKKunq+DWaoVj/BMEVEznfId2AIgdUyAV
        xIPPhGKirWsgB4IKso4WfsYlcA==
X-Google-Smtp-Source: ACHHUZ43L157CwSGw6Na5Q7NJGMnqU5gjHlGSRY1CebXuBJrA3YfFCo9C1/OO5x2rqksRdEF54TlBA==
X-Received: by 2002:a5d:6690:0:b0:2fa:6e37:3d97 with SMTP id l16-20020a5d6690000000b002fa6e373d97mr3908964wru.54.1682688821907;
        Fri, 28 Apr 2023 06:33:41 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm21068192wru.109.2023.04.28.06.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:33:41 -0700 (PDT)
Message-ID: <7ff135ab-9173-af63-5717-07d099eb9802@linaro.org>
Date:   Fri, 28 Apr 2023 15:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for Fastrhino R66S / R68S
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230428013738.30735-1-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230428013738.30735-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 03:37, Tianling Shen wrote:
> Add devicetree binding documentation for the
> Lunzn Fastrhino R66S and R68S boards.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

