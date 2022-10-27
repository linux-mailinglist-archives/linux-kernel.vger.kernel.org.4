Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6A61043E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiJ0VRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiJ0VRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:17:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAB4DB30
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:17:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so2628717qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRQvysuBe8TVoFcKONkt4fixl1asw9dfB/TrCbR9sxc=;
        b=bmVXDFVqmevFW5WHnaEPNxLTUbJ1P+V3qgDRcO9JjTohZRUV00BP5mW+LDVHOr0wB9
         7yINXsD8erBAoAG1O1d11MzGGGpClCxeqaQkKdtNjzmbvkWRjRqZpe3vgCtuXR+aTXDl
         jtsGus9Gxa9YBH0kQlMfZKXXSVV4MvUE+OHU+N+oHWDEYbLluSmCaOgBpfMo7ofxIOa2
         tYOJUh+qIOBv6N6TlwvXtr4TsAMQhmv/QdKmN1TU+CnTu507baEZeTtbD3zmS0kC5SMR
         wa84PDUsJuDcom9wt6KlvpU9s+se0zfrVoC5OWDt6ZgCvH5zHnTF6EAsGhq/6fEUvXlE
         wS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRQvysuBe8TVoFcKONkt4fixl1asw9dfB/TrCbR9sxc=;
        b=pQnjs1FcO6OdXVSEaVG1V8Wg+x9p+tcn9/12irpG/LFeM3D9P00F3SS89skHkUbyk9
         puaatbn+ve/g7nXBmHTQ3VSjLBG15FhDsy11Ju926m7+oaDZvac67h5IDfY9Cf95L+SQ
         A6kdi688fopScRb5FTL3lj41rBthhSM5yaGDlEcFNTWP55ppSLSwEFwPl4lkLi77RNP7
         xzdkADf5MsenMMIFWByNa5lxv0MvzgCgTNPFcTkPGKgDLwUZH2RTVwka1ZVdsCqHdBWz
         dp6uFhSS7/vr3JOU5Wl7dEM/A0+XOigACCggI5MT8JFno1PjA9tWsDZRZ6cHLg3TXjx2
         FhLw==
X-Gm-Message-State: ACrzQf3lMgDMtewR6qV/oXG5kvIgkOgWRDEe/jDmzk1kyL1l+dIi1t9l
        eulmQ0f7RcD8G/4Xtgt7aV60CA==
X-Google-Smtp-Source: AMsMyM7hJKOzQC9qNXa48kxL0ciHQuYvZw7WE8Vk4IoYHkwS3XZ7H2hkK6EYE52qhBoGYA5yN67yzQ==
X-Received: by 2002:a05:6214:763:b0:4bb:92b0:3872 with SMTP id f3-20020a056214076300b004bb92b03872mr10648010qvz.42.1666905454093;
        Thu, 27 Oct 2022 14:17:34 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bj25-20020a05620a191900b006bb87c4833asm1670479qkb.109.2022.10.27.14.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:17:33 -0700 (PDT)
Message-ID: <d9e243cf-d90a-1f49-3f80-f792c29348e0@linaro.org>
Date:   Thu, 27 Oct 2022 17:17:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
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
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
 <20221027101159.942843-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027101159.942843-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 06:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per updated Reference Mannual, the TPM[1,3] LPIT[1,2] root clock entries
> are reserved. So drop them.

Reserved as firmware does not allow OS to use them? You are now
affecting the ABI, so "drop them" should be nicely explained.

Best regards,
Krzysztof

