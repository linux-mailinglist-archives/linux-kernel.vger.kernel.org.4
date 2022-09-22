Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155B5E6A48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiIVSCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiIVSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:01:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA84201BD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:01:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so16007187lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SQsjptXiB4aAKkJGA4JvrvrTX5A+rS4iPy+kbkqaYt4=;
        b=XNexgVzoKQbxs7f8mLd3aLWyn4yWulmIrPkdqsYfcXQhRKM+3KPd2Hdrq1WBR4R5Xg
         zrlfzYXsc5zpTgV8qdqnP03YytaF+9awZtQpkUveHdEudjjSh4KXYJlIq8TmtHwmtOj8
         ZnFeyBYZZumVdjDjHFk/cm33/2wsuGxULvDk7N84tbWtrfBqcZmQxek5eMBGVN9y3jjm
         su/byh9DXtswkF8Rudt2mvX60To+c5cNzEnnuydDQhMk6lQ70c0PBiFfOLTCdTWaQPNC
         xOI5DhRpPk/y8Evsp6owktq/uW1+DlKMNQpdvXjfiFni6EmvU2PXgfpo5r0DXkVB9Qwj
         Gx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SQsjptXiB4aAKkJGA4JvrvrTX5A+rS4iPy+kbkqaYt4=;
        b=SuATcugyRKG4CQb7ULztnv6n5dcBokOgtrja7sMXTEQOO+jS0f/KFD2GQNitSO8ZHf
         TBkWjthF7/JiljjChUsiYIUBA4KercYjz8pMyKj4RmZyJi9C10V6hyxPLBFYF6eT2TVf
         OGVNv6bOc30tgMOuYgF9AFZk6+Aoj0pwB/6cUfeA/MtYp3l+rhjLjKLBs2+svxC0SqJt
         zmllqmR3PPk3NCpbNNxWYjsiX6nfzV1d/Zmk0I3DsF+OfufWmKtiXybDkb1ThKnlGfj/
         lqL2gydpw6oyAOZTzALdKicFcpJjWDp8cjJmltuxGlxy8qywaBfx5Fj5R7tR9oCG5RDD
         V5Ag==
X-Gm-Message-State: ACrzQf1C1irVSKzGobel2TTmaCalfItG8dZxSezgHRjhSaZK5HaKXTP+
        74GOdv//jZW50lZtA9iJp63pAA==
X-Google-Smtp-Source: AMsMyM45gElc+J2OV1D19Dbhnm6d1ds0hZYDuo51aqlKDBxYpL/dffzPv0H//JIBmrBjpa5Z0NG5Zg==
X-Received: by 2002:a05:6512:31cf:b0:496:f023:5471 with SMTP id j15-20020a05651231cf00b00496f0235471mr1743445lfe.133.1663869704001;
        Thu, 22 Sep 2022 11:01:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w20-20020a19c514000000b0048aee825e2esm1028756lfe.282.2022.09.22.11.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:01:43 -0700 (PDT)
Message-ID: <943c53f7-fb06-4285-be39-658c0db403be@linaro.org>
Date:   Thu, 22 Sep 2022 21:01:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/17] phy: qcom-qmp-combo: consolidate lane config
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
 <20220920073826.20811-15-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-15-johan+linaro@kernel.org>
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
> For legacy reasons, there are two configuration parameters that appear
> to describe the number of lanes a PHY has, even if "nlanes" was actually
> used for a different purpose.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 38 ++++++++---------------
>   1 file changed, 13 insertions(+), 25 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

