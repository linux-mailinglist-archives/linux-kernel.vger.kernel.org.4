Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC55EE60E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiI1Txo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiI1Txj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:53:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B747E805
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:53:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so21959270lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f32iAnhK8dWq1NLxgrzfOeCHrdaY0SUtEKuKkVc8uiY=;
        b=MgeMKPqliFU8iU7Tngy73QsK856WMpPZI+CCwvGKMp4fSFD+zS/2L6DZTIk4pMDMmc
         mTqR+JJ3XfU4OxJM/Zq1yZA0qOCTBLtH0/0ES55Q+utij/wMFsXCPqhG0cYIN15MUPC7
         Qbh2Z1Caw2MR2Naf7zUzHAhYGDFJtBnkVq0sy4lMXTZGSsudz+o17lPmRq8+njqiRie2
         5OpbtsNBAj3+Cu4RUhnzLDG1fOfpfcQecTWqtq5IZt7B+iZu6a4oVMDoQDt0ubq7Gx6z
         594qMXS1SSLvhMh9Xqoble30+0QMYIXP7dXGnOuKs9G2XQfT2vMkJZ+6OJDx36K6uEVD
         d6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f32iAnhK8dWq1NLxgrzfOeCHrdaY0SUtEKuKkVc8uiY=;
        b=2udheTcxLuTF+jeYNFzBgSNX/sy0ztpx6Mdflrsak60p5pnXR5/F6JhQlAWJm/g9ZW
         frY9j1bcO8DwTJiZgqJfpjBTutnibN3fuZPoOEfP7fvZNsWLNepab4BrbuF5lSgirS5U
         epscZSDP25OacD69iozvhTxxkTbYeDNUpYHt+meSPKvWEt5NFhemSjb2q24Nj1b48U+w
         7/Kv2KW6em5L/ekD7E7HKpG2W/apBtq9SUUPKuEaJnb0zAWwQcoQuLYhfZ8AJXHwQ1ZT
         ZNznXRXCfvW7x8PaJYUhJMSGZBFKRVjSkZN0PiK41h4k6vt9C0s40UfTbmm6dE7tDRAx
         zG8A==
X-Gm-Message-State: ACrzQf0B+SIur3CUeu7O4B6077nmJ1aDahXrz3+rIZTvairBZTdNifta
        EoT+4LLEC4SXdqx9To/uZAKztg==
X-Google-Smtp-Source: AMsMyM5PjatSKJPduwwFfr+NdKfw0CiSNUd+xTnNu8PaSOFbjlDLLr4/OhJ2ctdbm92DbiFYcr6iig==
X-Received: by 2002:a05:6512:2a92:b0:4a1:d2c9:c2d0 with SMTP id dt18-20020a0565122a9200b004a1d2c9c2d0mr7280104lfb.278.1664394816593;
        Wed, 28 Sep 2022 12:53:36 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u13-20020a05651220cd00b0049fbf5facf4sm562054lfr.75.2022.09.28.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:53:36 -0700 (PDT)
Message-ID: <8db2069b-d3d6-2cdb-4761-25789ed48618@linaro.org>
Date:   Wed, 28 Sep 2022 22:53:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 11/13] phy: qcom-qmp-ufs: clean up power-down handling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:28, Johan Hovold wrote:
> Always define the POWER_DOWN_CONTROL register instead of falling back to
> the v2 (and v4) offset during power on and power off.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

