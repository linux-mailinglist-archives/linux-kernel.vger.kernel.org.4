Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3AE5E6A17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiIVR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiIVR60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:58:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AB106529
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so15992458lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=l478WV2PQrEPincbg/O4NBfPJTT4Q+S9mMJy9BBn9a8=;
        b=Hb3m1qSIZlO0ry2k89IBZPpA4nRFpA2iWKCH0ptaFKAtKTlVBkmUqVKJXpP1uv+iqL
         Bpq6iY0xoewsqqpOuNQ1dztfX9Yl+RYF8O90kcT08YahUow/vZyM6G/v15qqnQ/q+IBY
         45oKHp5p824FtfnHleaBBAMopHhquUHf1GzvjLWGdLr6xhDRqeq4x1+W+HLj3dPb80cV
         ppqTEihAApF2J0Y44kH+C+/WVn/DgWgSe281UAT/6CjabmQwEFw2EaGRfBuOnpCxZMq9
         7tPypK3EZQv40V7iAT2R9unbAK1YaHNi16SWZvrncLiJT6OC+zPUt7bWal7mZsLeFYl5
         9SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=l478WV2PQrEPincbg/O4NBfPJTT4Q+S9mMJy9BBn9a8=;
        b=TwAlKkkFhKPdlJ7K0TOvDbPEeEJ4c1Cie19fBVBYdiIRH25Q9DXDy0AlfDtggb6X/J
         g/8fm3U2bDFPeJBUZ4FnqH6RQaiwxLsjgLUg3KBuStuCjaEQewIZsDOQ9MqzkYpHVfqS
         zSpxYVlTprt9JrrIMLc2SKpykxy0PPm+yZ0krfAdw+nqGTWik8sU1nhmj0fGDd3emNMf
         US36z+mBrZ0lGhgZrkIkVFny82iGdch9L45PIvaNyRm+TkNTvkQF0Um3BYVGUI++rCJ0
         oWg2TTvXvEkAuBHGqhCECZF4u36tNJP06cxCfwlMfVwC5mEvr/dhUOxfsChPgQuSU8EO
         6Wbw==
X-Gm-Message-State: ACrzQf1NhwaJvDSmhcGLCkboZztgoYjGvlJXqjbozN2TtGthOH3xnj7X
        z4kSD7YO4BZSfEjxdcrQMD/5EA==
X-Google-Smtp-Source: AMsMyM5vNqMo+hkzshJzO0Qq1ZzNX6nDvB7bj8jVMr5fO2m3SsASi78YwcnbXvJGoN+FkfvM+77GoQ==
X-Received: by 2002:a05:6512:13a1:b0:48d:f14:9059 with SMTP id p33-20020a05651213a100b0048d0f149059mr1898038lfa.110.1663869499748;
        Thu, 22 Sep 2022 10:58:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 3-20020ac24823000000b0048cf43c3a85sm1032371lft.238.2022.09.22.10.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:58:19 -0700 (PDT)
Message-ID: <0d802f2a-5bed-28b3-7160-e1fceee34ae6@linaro.org>
Date:   Thu, 22 Sep 2022 20:58:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/17] phy: qcom-qmp-usb: drop init and exit wrappers
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-7-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> Drop the unnecessary PHY init and exit callback wrappers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 29 ++++---------------------
>   1 file changed, 4 insertions(+), 25 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

