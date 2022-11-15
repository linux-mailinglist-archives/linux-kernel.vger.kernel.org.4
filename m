Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAD629F62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKOQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiKOQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:44:29 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602C1274E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:44:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id be13so25348920lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6MDTudeaDNBWLFtCxygDdf5wiboyzw894OPiiSIQMM=;
        b=Hu1stuBszFyfEikMGRREw8GkTMg4/jMjAkS8HM0aCn1Pg8pwp9GvlZy6cKhFetu10v
         gXNoiRimrks/UGckegepAthYuEUg+Rm/FhHMxl8DuAi1HLy1guBs1Dh/YgegXHIXU16X
         Fzw2PJD5KxTkyTkc0gwgQYZk1wpbTlpsp8nP18UVXO3BoGO/0I4zUQVLEMuttpz7tbPW
         aMkXanFphY0o3rLhy+espHWF5kVnsFnLusfgKDkcC60QcfZeSo8KepVqUBG7FnyU0ymn
         Db6pM0P2pcXn0Wlt0VuGuHd05FkenkTn5V964JoSB2O/fWtKWyxYsUFFFXCX6jo3XHNX
         lrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6MDTudeaDNBWLFtCxygDdf5wiboyzw894OPiiSIQMM=;
        b=JLjRmRxr3UZlVOeHDF2iCpigFlsHTpoGSteZCHFsCghe6ra3kZHn2UsXQ3UQcXCYWO
         gFIDZfs0gDudez4oMeT/s7rpnhwe6jIaMcCyjgNg2lqH69m8r7B34thsoJFLOXqh4vk+
         Vxwh7HXX0p5vi+CTM1kPUbSnVU4//UMsVR0qL60nmwIGM60cyZWUSwKmwKxwpRKHG2ue
         bjQvmFQahUBp9lBbtnrNckNiRSQWoULhWwWYVoiJVwFB4hex5fZzJ+Nb6Eo+MRvPmknd
         XsDtYPGsCFmGyvK3K2cvhqwxDEouNuK8mUIBQzXtDUjKi5NB1U26N88nCzTIS6z8gQMR
         ddsw==
X-Gm-Message-State: ANoB5pnz6iODTNwRbmg8Ip+JS3aNWOs5/hd+qW75CjBc/4AGfFm6P9S4
        0qX5Y+wzFrMpSdRMlDAS1+ssmA==
X-Google-Smtp-Source: AA0mqf5hHSaayh6XTIOJeav8sG5uVl7z5pI4d6VCS16r7C4ku9jeeQ+ehHOWzQZKeWDNgHgW7s6iWA==
X-Received: by 2002:ac2:5490:0:b0:493:1196:8ca1 with SMTP id t16-20020ac25490000000b0049311968ca1mr5674960lfk.303.1668530665724;
        Tue, 15 Nov 2022 08:44:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b41-20020a0565120ba900b004aa255e2e66sm2253141lfv.241.2022.11.15.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:44:25 -0800 (PST)
Message-ID: <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
Date:   Tue, 15 Nov 2022 17:44:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/11] dt-bindings: mailbox: qcom: Allow syscon on
 qcom,msm8976-apcs-kpss-global
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
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

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> MSM8976 supports SMSM, which needs this node to also be a syscon:
> move the compatible to allow that.
> 
> Fixes: bcc8d70f912d ("dt-bindings: mailbox: Add compatible for the MSM8976")

I am not sure if this is still a bug. Maybe just a missing feature?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
Best regards,
Krzysztof

