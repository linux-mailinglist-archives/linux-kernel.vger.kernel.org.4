Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8916E0CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDMLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDMLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:47:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702BDA5D0;
        Thu, 13 Apr 2023 04:47:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z8so20545148lfb.12;
        Thu, 13 Apr 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681386426; x=1683978426;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3v/g1+YK4ohjxNpY7X/EAjO3Cvna/Uxm2/iuGIHV0o=;
        b=Z+BPO5+eqiznWawGagxUVRp9ax2e9DRkcHqyZt5OsK+LNa2rKyorWho7ZWRYq1U3Uc
         aU8uJ9lNldPgMlP+nW9laXMGoA2zoGKA3Uv1Qe7wlS/eoevdGleUVHyeEpEEvR4egW/U
         Ziat+ldE5jUvwLztLtiep5+tjhBYIIhqe+YR1SlKydKyZWuvhFF9kpcEm4dEWY6RNkJk
         xMRPXV+rZwNvGhk+LnJz1NLwBG4Nyjy4QEhEYXJOWvLbY6oUNzyGQjGo4ttHUUi1qFlA
         yCQSnBwZV92iLLdygfLwUaKqIrxDcuDlIrfJaiZ1ZQKtcO8okuvVYiRXZoLjIbNNFrl4
         +krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386426; x=1683978426;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3v/g1+YK4ohjxNpY7X/EAjO3Cvna/Uxm2/iuGIHV0o=;
        b=St00qEdFqr5NmJB5R4MO1G9xi4hgALP0N6G9imKgj6U2k6iUMA7OBC6QXxm59tjFLy
         zJr3I+RXuvtS9Fv65j1vq+AHITIE60R9fVB7IxgXjzLqPRkpLeP5ZvDHbS5nRqBt6hfl
         rvdtdZG8YlnI53a7wqtFwCMW0TbEknQB/oCYIRUjseA5zlAYgmvBatpOEh4heHHL2+P4
         sGDMrBgHQskDA1r467SFnP7Y+v5A1EhdlRs0Ef2T+1TsV5T/BrbG7r+lj//BkfE87lcu
         FbHbzcvnfvuOWnO/O6/ZUuCfcOomAsgZUechV+TnpIEag9bpmFbp8Bn6PU2bxhnmaWu5
         d/zg==
X-Gm-Message-State: AAQBX9ded23EgKRcCA9UZnQR5PyZVjb0JOq6LKmlDVRAfDrr7FshUJf2
        MV0KaDeDgSjLBovb2TWMgRI=
X-Google-Smtp-Source: AKy350b83BiwhY/ARiBiqr7RAaIjdxIB4n41CUt1Vnh2IVdKu6EVHfUfM4Y6LsQWXnFGf+YQeWQFpg==
X-Received: by 2002:a05:6512:50f:b0:4eb:4002:a5ca with SMTP id o15-20020a056512050f00b004eb4002a5camr906727lfb.66.1681386425552;
        Thu, 13 Apr 2023 04:47:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fec000000b004ec55ac6cd1sm277523lfg.136.2023.04.13.04.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:47:05 -0700 (PDT)
Message-ID: <b259e7fc-130b-1158-00b6-934861a41aaa@gmail.com>
Date:   Thu, 13 Apr 2023 14:47:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED driver
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413110307.310944-1-andreas@kemnade.info>
 <20230413110307.310944-2-andreas@kemnade.info>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230413110307.310944-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 14:03, Andreas Kemnade wrote:
> Document ROHM BD2606MVV LED driver devicetree bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

