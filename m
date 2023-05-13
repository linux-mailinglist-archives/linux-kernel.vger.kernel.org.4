Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92642701898
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEMRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEMRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:44:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055026B7
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:44:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso19754950a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683999847; x=1686591847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxTtUDm+8ou584/2PmcOCqqyTDmWQsU6koZsih9S3hg=;
        b=R8lGQJnI7Afv0qArQE6/5ZvAS1i21ub75gRJjfxko3JuJ/Yk5oH5GrZZfiwz2rsTLD
         rHrgV3+RU3/lZLspsIhEDA1EptnimLODZEnk8Z61Lj4/IkP+2Jj0r+gCclwvTlmDN6ye
         R/Z+IiUWSuufXhg0krKiKfT/nI/T9x23Otrvo6fHvDxrQ9f8e9YV7jR2rKWLfPeCcuzS
         Fe5XQQZpS2DjlO+yh5Nm7gVtxlfi9z0ebYeJ/+D9l2+Oc8oSSAQgjLz1kqSNrLjXMoK9
         QCePyYRJwCtn88IPHiKpdOAd2RXYASHf34NrIZetXS4fpuMt7S07IZX0rp+dH1aNLbYQ
         UoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999847; x=1686591847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxTtUDm+8ou584/2PmcOCqqyTDmWQsU6koZsih9S3hg=;
        b=BD929gtohx8u3zBbL+2VG5GyvIXTxvEPHqzZLGTNMKoGCXJN7xW47W+bEk6pcFIuMQ
         2FVjXVdSJnL5qJ1G3wzu9lOAeSB52UTqNiRlb2eAMp400gGeqEa6DgJ1aD5n4WIltR20
         XcWLT1ARI8sW5mGMVnKwzjy56PkMy0h/K8N7zVScJK26EoTwU5mUB08uJvUdV8iuhgJZ
         BKZiUzT2vBK0y0rn+GLUttQiwRE3F7WHTpGkK1cLY8VQy+4snQJyQLkCOdYpZA5synDl
         TpOBIROo3K0n6uykovcsqLQEKlUvZk56jFH1Z85O9ta9PRRzYBHEC1/KjIYF2ca1wAF+
         2uTw==
X-Gm-Message-State: AC+VfDwk9xC9NU7udqXvjO/0Wg4y/swdNKZU0dGuS6vtxrh72ULL3a0l
        VOupc/fAL555WSyMgtj920WRnw==
X-Google-Smtp-Source: ACHHUZ5+CR3tsAYzZ5F0kEiOibJ7/J4feyJFCr7T+QZfec2o9eYeSCN3VwhP6J2BjYwUAyDXTNLikw==
X-Received: by 2002:a05:6402:181:b0:50b:d18c:620a with SMTP id r1-20020a056402018100b0050bd18c620amr21929621edv.25.1683999847561;
        Sat, 13 May 2023 10:44:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bc2d:23f8:43c2:2aed? ([2a02:810d:15c0:828:bc2d:23f8:43c2:2aed])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00506987c5c71sm5220723eds.70.2023.05.13.10.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 10:44:07 -0700 (PDT)
Message-ID: <ec5dee0f-7579-3425-6f7e-1ac123c380f4@linaro.org>
Date:   Sat, 13 May 2023 19:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] dt-bindings: vendor-prefixes: Add Emtop
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
 <20230513113133.1913736-4-himanshu.bhavani@siliconsignals.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230513113133.1913736-4-himanshu.bhavani@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 13:31, Himanshu Bhavani wrote:
> Add vendor prefix for Emtop Embedded Solutions
> (https://www.emtop-tech.com/)
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

