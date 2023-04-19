Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4C6E7A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjDSNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjDSNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:00:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931B610F5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:00:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id xd13so47507331ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681909229; x=1684501229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dThwFJ3vOyLSdO84BKW4BtLRpSB6koZPj9RWGNkgtXY=;
        b=QvZmq1Q+1t/+tLsZBBb6J1DrzPEcly1RE9wBj9LFhhTGMId2D+ecNSemi6CXd4tToK
         /hMdNXc/Y7ezrGZ4llNm3U2X90X/QkK0ZiwlqZ5bNly+CEGdkrtPJytsa5RmW9naW8bP
         lB6pkYTKNDYP9skIhlgNCLXANkwyrpk1+3jC3n8Jb1CM+RoUU5l7/wyao+NAebASV0dd
         UeZ5VLiHMPbK3Vy7LTT0kDiJgCqV4/6W2wlhrgjBeAnwrD6OIVn5PNrcIOgbrWov1RbR
         3HLkB523yivZBB8Oy1m8B1WbeVXHCq3V0OqjtQJo0jkgkyTDfepGcnoxhGh8Z9/LYFRv
         c9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681909229; x=1684501229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dThwFJ3vOyLSdO84BKW4BtLRpSB6koZPj9RWGNkgtXY=;
        b=HOoC+jn659UjqL0ThWgIxdPHbLjOxVmnJpwtYSC9EDav3Qgg+lPa5EtGs/f42f05UX
         U007ua4ZiWYpf0aWE+n1CWlqm/20eB0Rxroyl6gakZAYQ38jnelWFEpeHacF3k4EC2Yc
         NzBflG3kvwzTL2Xc6eG9q7j4kyE0mmh1I1UlrzEq+x7acGedqiulvNAWowUzueuHtAcK
         DzOBUNOpM6pgEH/PpDmZ4NtkZdCNPh9WkfUm81uiDsSUCHjU+g2Uy9lLwkQmG7n5ujtl
         63x7brYh3bS7z7hBbuaeXMCSdy4+gH78Vp5GV9KOTUqITXLpewL0Xvvjzc5DDc9dWPFL
         Kncw==
X-Gm-Message-State: AAQBX9fG7MTVyVQ8J4X/CllEcAHyaq4BUJhs+NKKxVzCaVywI5trNHqz
        mHvcRKzKzO7nJ4/wb82enfzT2w==
X-Google-Smtp-Source: AKy350Y3avrga7wYQ6qWnOwIM5ZJ/cqBvl3dUf9clZA8jk1B+/OquGf/33aNSegqMboFzKJ0eoemIg==
X-Received: by 2002:a17:906:6816:b0:951:786f:e3b3 with SMTP id k22-20020a170906681600b00951786fe3b3mr6106764ejr.34.1681909229046;
        Wed, 19 Apr 2023 06:00:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id dc26-20020a170906c7da00b0094f7844b0c9sm4277409ejb.97.2023.04.19.06.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:00:28 -0700 (PDT)
Message-ID: <bce33295-f116-6edb-bdb8-c912f86b3623@linaro.org>
Date:   Wed, 19 Apr 2023 15:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] *** firmware: imx: NXP Edgelock Enclave MUAP
 Driver ***
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 19:55, Pankaj Gupta wrote:
> v2 Changes:
> 
> - Fixed Kernel Test Bot issues.
> - Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"

Drop some weird *** from subject. There is no reason to make it extra,
extra bold font.

Best regards,
Krzysztof

