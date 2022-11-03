Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8B617F49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKCOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKCOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:19:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAFF193F1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:19:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c1so1426142lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQeJmfmldXG6hvj59+k+TbhmV1qXG3RlPlcNF3t/Ui4=;
        b=eIfFSn41vRIjqtDk+mjUsF7IHFNarF4VsRCOuE8POYhXnp6oyBT+6h9EQ1bjtm5BWh
         AZ+EbEpHlwSptAfm8e1snxWMK+7TlKekN7dEgqanRoSeyPN5aTtMofJ13dBGwQsr80Ez
         wBcE5Jn9tDj00EqMtqXabzEmRFMzQ0WOW9aavZ0tJ/f5n8H0HzJLt79JwtfTc76HeF36
         TKy1YClxtnIW6Dd/gNcrQBanCHacDuJsOzBzmTKY6dyC8+fNm1Zj1cWneI9kpuL25iyv
         PgnXfvXtdFp0Mbb5x//hk1sNCLRL4BpRs6BfgqjR3yNsSUQbyeYjSWa41lJ7Zjeq9GG/
         iakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQeJmfmldXG6hvj59+k+TbhmV1qXG3RlPlcNF3t/Ui4=;
        b=3gBYLAB6/XdrouFvnVNpVytlDu5Yx+eJDR6SDi0d1wFmk90cjjkCp8zm6e0IVEnPm+
         wol2qtyeGIrf/4EN9pIBZZHztFv9nWLBjZB7/qhH4ZT/UOiF5iazQqBcKWOxIX5p/hLS
         G+xIOPvd8XzK/S4xsSHmy1x/wuTx7u6mQDn6Eej5MdpdyMU8FGjfZwJV4SIza2TIr2tj
         0O7V+l0bE04R22ZsgOHtFPC4R2pL20qNDFroLw4rCKxu9cmxMB8hEYuyKjeL0Zod/FsD
         8LEW9yNXb+IjHCCJJ4r/VfuSyi7dv7a33ahSs4E9ItYUyKWKeOnHqNLhrn6tFP5FFFmP
         v1VQ==
X-Gm-Message-State: ACrzQf33jzF3h/lVAyap6KG3UrGeHCMHEugWpCUlMuN2oKgI1+P+N1r1
        Bc4ygCwrriwtac6S4mSa0kk1Wg==
X-Google-Smtp-Source: AMsMyM65B2GojMWZBZ7SW9Nj3gk8ZeKbb0JxUBUaGHgAfQk1+agMmGU6PEhntoiaifEbaTv7V4bKUQ==
X-Received: by 2002:ac2:4842:0:b0:4a0:53a0:51c with SMTP id 2-20020ac24842000000b004a053a0051cmr11288589lfy.202.1667485150143;
        Thu, 03 Nov 2022 07:19:10 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b24-20020a056512061800b0049876c1bb24sm144454lfe.225.2022.11.03.07.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:19:09 -0700 (PDT)
Message-ID: <b1aea0c6-1f62-57bd-3ea2-6e4334e1003e@linaro.org>
Date:   Thu, 3 Nov 2022 17:19:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 9/9] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc
 dsi-hdmi bridge
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, quic_kalyant@quicinc.com,
        swboyd@chromium.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-10-robert.foss@linaro.org>
 <bbce3d37-019b-a652-4f1d-18fb9493f7de@linaro.org>
In-Reply-To: <bbce3d37-019b-a652-4f1d-18fb9493f7de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 16:56, Dmitry Baryshkov wrote:
> On 28/10/2022 15:08, Robert Foss wrote:
>> The sm8350-hdk ships with the LT9611 UXC DSI/HDMI bridge chip.
>>
>> In order to toggle the board to enable the HDMI output,
>> switch #7 & #8 on the rightmost multi-switch package have
>> to be toggled to On.
> 
> Since this doesn't look like a default setup, it would probably make 
> sense to move this to new sm8350-hdk-hdmi.dts with the comment regarding 
> necessary switch changes at the top of the file.
> 

Please excuse me here. I checked the Lantronix site. It clearly names 
'Optional Display/Expansion board mates to DSI connectors'. So, you were 
correct, the HDMI should be in the base setup, while DSI panel should 
come as the extending DT file.


-- 
With best wishes
Dmitry

