Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D2611D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJ1WIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJ1WIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:08:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239F224CCA6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:08:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh9so4342489qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFVbywhvRiGMFeEYzajNEmWxk/ylmxPmeI1imeal834=;
        b=NCtulz3u44DXr2b4aWBfJU3cCkxs7CvRLxE42DFVrD3FvL+6ssoKxe6QDoNCeYApeL
         DzfT7IlZRcHNwv8FrmV5kJHEAMxrOp//0j4Pt5P3VAcn/5ZL9df7qO7dPiZIfswIcJSe
         DqCy1ypcgdVjvqXfhuenrZMZ/RxS+koE5DpZuQfU8d6G4nh8Jzn/lykF+pcBV7/9q1Y9
         OULJyx3n2Y4ctlOD69iLu493/YwiNaE9imuqhrOP9GNflbJ3Z73OVIWCLykVMqgeEL0S
         SYGQ6ySEX9bYBAh9aJXZhurmLiy+hUi56mMnwwASXWzLG36Uln6TCDll/I3gzGFTVgpf
         msEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFVbywhvRiGMFeEYzajNEmWxk/ylmxPmeI1imeal834=;
        b=5Eu1ZdPpS/XfBec+a6CTrRmvcqfKir+qs7oOzNY49ahbQMftjEL6xyXwOFF1t+JO3/
         km0WpGKusmhHOIrNwj53MA7sjzdqbjNS/EFmyzGPSAGmFb6kOwPV5LMYbGgVlg6cW8I9
         aziiYG8TBeEnsGp+EbCQo0jxYGKSr/csjNm6QXLHGQ4QCFkecLKfoyCsSdJqKS0qJQt9
         sOA114e0cuf2tnoxNaQytaHdRYvZnFhFs+3KZa29Yvb7WK+U9UdnQiqG7uzJNyg5Xenf
         erJq1wLMFuxd2V3iWqN0rCi/N+7JYAuaWeDic0N0rabCTWOm/ZDfeN9ySUnWBVkxVXKF
         gt1w==
X-Gm-Message-State: ACrzQf0H/TEUYhKbxFc2ev+oqABy+SNbwgylIkTRu8mSSoAfBdLMwiqK
        rcDBs8t6XX4SDHR+nKZ3vbBfQw==
X-Google-Smtp-Source: AMsMyM5gZzXJzv1KbupXmMX9RD2HNxOi/wkqNceXmAYCJ7yTR5OU/XwNUOzVkCOg2a6fJOoeyystfg==
X-Received: by 2002:ac8:5d87:0:b0:39c:eb24:2e1a with SMTP id d7-20020ac85d87000000b0039ceb242e1amr1439585qtx.577.1666994881278;
        Fri, 28 Oct 2022 15:08:01 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id c2-20020a05622a024200b0038b684a1642sm3053506qtx.32.2022.10.28.15.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:08:00 -0700 (PDT)
Message-ID: <96ab729f-de17-cf6b-a218-e08fe4fc4a60@linaro.org>
Date:   Fri, 28 Oct 2022 18:07:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/6] dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
 <20221028095211.2598312-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028095211.2598312-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 05:52, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per updated Reference Mannual, the TPM[1,3] LPIT[1,2] root clock entries
> are reserved, it is because writing the CCM registers does nothing
> because the TPM[1,3] and LPIT[1,2] IPs source from bus clk, not from the
> TPM[1,3] LPIT[1,2] entries. And because there is no SW entity is using the
> entries since adding them, let's drop them.
> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

