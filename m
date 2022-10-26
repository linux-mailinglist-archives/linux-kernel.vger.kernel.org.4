Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0C60E57F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiJZQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiJZQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:31:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C668E0EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:31:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n191so3995182iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZroYCfLP4kV6yI2SRRkLF4nBxcg+8GdvFiXm2KAN+0=;
        b=gCRfbxTztxyAglTagJ90CBhqnus+JgUzmKoYY9/0MsEP0wUYumGlms0kroMz2tdy+0
         dQ7pwGFr2FC+Lh9NYSXPBYWx4UU8Mc0j7g7zmepKBf/T6NaMqH5pF2xFsOJdfBydH0w5
         EPgU1WDnWu0/PTDgoPCBiO3R6FyU0a1LdvwLJMddT6qZtWWPn3KHjF1NZ6skR0mcjZSN
         LsIe9HA9Z7bTvXz3Oi+qV6PKu1fNrohSeUrtCEPTEXxCILDGbe0U81rP2Xapzv3OVKpD
         pftWQCvFA+6xejk6uMiNDVHpwXWQk6JJOa34wdV6Y3MkiWsomuo5PZpq/2u4/6z2X/8F
         m+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZroYCfLP4kV6yI2SRRkLF4nBxcg+8GdvFiXm2KAN+0=;
        b=gBNeG71FGAxVphb3UODhm+0K7TAkci3So6j3wB5h15gmBpjyUxN1BH8Eyo9SEIIDdi
         nPx7zuLoVXdF+RenkWip/bVtoleVIFgOlTiYQdBxxohoME7uKg5f55h/B6T8JgIhph9z
         8xY7JY36EYk8NxqgECPNO0YoFAMZCjOUHhJz75UvlAJKcbSzLWDyUJuFuHtzb1Ro7sW5
         GTApBbwud8hogXZaAK8HMoIaeqq1V/5ItZ++V2MOYmWf18EibQj33l4foryfm6Ji0erO
         k/RmVoPvB0KKttRc7rPJqaKy8kcTRoi8CH8YEYAd+gQNJtSISpoPjPxDO4+nGqOr37OL
         sO7A==
X-Gm-Message-State: ACrzQf3T35cA35QNdmJ1eAONtx8KSRy0bwoPocsJ2Ap82lCJXE40tLrv
        UMjL7VG8/i5YUzGduSreQQOyh7FZD7K84g==
X-Google-Smtp-Source: AMsMyM7zb0Ad8R3XGxlHoD3MmtUEhan1tNmdrsbjDd8I1m15K/nuONOXPqL7vgs0BM6lGAVY1R/VKg==
X-Received: by 2002:a05:622a:4cc:b0:39c:bfb1:8a45 with SMTP id q12-20020a05622a04cc00b0039cbfb18a45mr36998426qtx.647.1666801889584;
        Wed, 26 Oct 2022 09:31:29 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006b8e63dfffbsm4239476qkp.58.2022.10.26.09.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:31:28 -0700 (PDT)
Message-ID: <f3148a5a-2424-8589-684e-7d759bb08bb1@linaro.org>
Date:   Wed, 26 Oct 2022 12:31:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] slimbus: stream: add checks for invalid
 unprepare/disable usage
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 11:57, Krzysztof Kozlowski wrote:
> slim_disable_stream() and slim_stream_unprepare() are exported, so add
> sanity checks preventing unmatched/invalid calls.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Hi Srini,

This patchset is also waiting for a month without comments.

Best regards,
Krzysztof

