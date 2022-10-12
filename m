Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABF5FCC35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJLUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJLUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:40:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8F33A3E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:40:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y5so27461120lfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxTkPgU3rNcIJM9AjTkJgUGwH+NeJHSORKyf6MDGTgQ=;
        b=JTfgKXZ2+cY1aNINlKTeM7v8/Mui5ZYvMOpsHVPRBGgXrtYhDyDfLREgP8AJH7jZgL
         bfxVtpy6Xb0Z9kqJXmEplRaOyP3Qgen746xU40JRJVoUPtEQ4BIg6/zs7iz3LZ+k7mi9
         4QNrcP4CHo7HO56HQDdETRcaOLv2eHnSagkYH6x8kUYoL5i37ttmMEp4qURZ+EHZU0w9
         7mSdQFb5Whs2FAPc3pmHWMoXyuJvrrnXBA9UgiWM58PokXKkz913TOTDTEa0srX/wP/n
         r8ekR3HEBHSBq/Kdk40bXtmmJ0ivCDDvyKgRQCxLWzI6DVp/5vKU8CLaAJnuL8AoMdN6
         hGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxTkPgU3rNcIJM9AjTkJgUGwH+NeJHSORKyf6MDGTgQ=;
        b=zSK/ZfI9h6IsCX+2a4MBRC56s4/0WfSUZr31jQcfJJ3STm/0wq83XTWYBNiPdnFQUY
         o/PnpaigOujP+sBDZcBIphNZKFeyjs8nP0141USaABJHcDJEZAnKHWSnrzmsp4E4e7G3
         zFBDBfB/yNSW8C3rtFrnrXVkoEJtuSgJAMNsXrU+oxwvloFCZWsA+tuvuZJ48qKMTWG5
         Y6lGpTVjyLoakasJnxOuKMMzLKEtKc6TLhBA16lQ5rW9wNq19e22b6Oi0CgGh5G0uR4B
         LOHV0v1+bKC5R30Jg58nWwIWe+38dpgUcplPobWfyW9QXT/6hSyzgq0rck2EnP3GzLfA
         lQVg==
X-Gm-Message-State: ACrzQf3xLbWU0gp6N1N8p8GC1FemEDmfTtKU32ksRRkqQ4YRQSPoFh9m
        lV0EtVpg3TI7h8BR9N7SsO4ZwA==
X-Google-Smtp-Source: AMsMyM7oPM/M/LdynQa845+2bMvdd0uoPnJOPiwohfV0wcsBTu8zbX0XE7yWGi9/xIHzdyCH+jPdWg==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr10574813lfr.339.1665607200092;
        Wed, 12 Oct 2022 13:40:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o18-20020a056512053200b004976809d6a7sm88787lfc.283.2022.10.12.13.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 13:39:59 -0700 (PDT)
Message-ID: <fb44197c-1128-ad7c-4f7d-6188b508038a@linaro.org>
Date:   Wed, 12 Oct 2022 23:39:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 07/14] phy: qcom-qmp-usb: drop unused in-layout
 configuration
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012081241.18273-1-johan+linaro@kernel.org>
 <20221012081241.18273-8-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012081241.18273-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:12, Johan Hovold wrote:
> The QMP USB PHY driver does not use the "in-layout" configuration macro
> to configure registers that are typically accessed using "regs_layout"
> arrays (e.g. QPHY_START_CTRL) so drop this unused feature.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

