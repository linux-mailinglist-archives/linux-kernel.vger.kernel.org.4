Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25B60B7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiJXTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiJXTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:36:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1AB20B109;
        Mon, 24 Oct 2022 11:06:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z30so6533639qkz.13;
        Mon, 24 Oct 2022 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uZ3VwfktP6MlXqcTSmXnIQiEYTG6oe41z15jnyDxAg=;
        b=hUQNLA+Bt+iC3EXWYW6u4ZiXQN+8gSkbnmx8T2s8gwIyjYMlb9xie2OOJHwqqdlE6g
         TPMX8YiSGrjcgbVnTCnFsXG5p9TyBfNZW9cG8k8CcqbzN2bmQnheWRACOBZ/d0Ypyji3
         rAeT3VRnZNw4YbeuVXZ3vEOKtNVMeNwXu/MjHy95n+2bxkdGNTOtyJszmv75cO39QUVX
         3tMEuxZT7eSOq8Es/EwqZssEHzAuhydL/i7aK2CmAmpvk3RmjxlZZXCchdX4A7oDcSBj
         OT7wE6byf63cJL5bI9VHwdG17EIHCSUqDNg2p48fauR7p1cAjQNOcc/NytgEWglrxAdz
         RDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uZ3VwfktP6MlXqcTSmXnIQiEYTG6oe41z15jnyDxAg=;
        b=bUP25NxnLhhgdkAEChATBRfSvbrFj+ptOJAywytSQ8l1vQfyP3dXWWybikCuk3DzqU
         i3WF41K8z/odAVa8QowcLt6aT1NhAvu+eVb2uc/QivF3FHB4dQjYXbC+OIu9r+2j31VF
         SBHOa90obRFXG71PYCOlTFPUkELB5EmAX5Q1bbp5vta9m3pP3I6HiemJgTxop1dT8ndV
         fywFPkaaOq+I4QB6RRgKVkB/EFKXZZusJUhFJhbzNlEJv8INeCJPcqiE06LiylGpInko
         nUm0+Q6gVo9kh1rkpngkKj9685txVp5aCuMfnGqOVNdUKqocIS8DFV9b1askCBLRn/Fr
         rUPg==
X-Gm-Message-State: ACrzQf2ddP56skGqBg9VG0k5XKDMnXCdC/2qXJqiQV8QZ7B2VyAyoRTV
        QWHBIO2MJSaQDIELVpp4WG4=
X-Google-Smtp-Source: AMsMyM6VD3e4iOCRwH+WEfJk7Le9i9P05UDL6cK9G/xPqVkJKTVIOyBY4IzI1tu67LqNtF/xB4eU0A==
X-Received: by 2002:a05:620a:24d5:b0:6ee:d4bb:e5ba with SMTP id m21-20020a05620a24d500b006eed4bbe5bamr23818286qkn.457.1666634695655;
        Mon, 24 Oct 2022 11:04:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e10-20020a05622a110a00b0039cb9ef50b5sm335003qty.26.2022.10.24.11.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:04:55 -0700 (PDT)
Message-ID: <9e15ffc5-fda9-b2c2-97f1-866c51bde113@gmail.com>
Date:   Mon, 24 Oct 2022 11:04:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221024105229.v3.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 10:54, Brian Norris wrote:
>   [[ NOTE: this is completely untested by the author, but included solely
>      because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
>      SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
>      drivers using CQHCI might benefit from a similar change, if they
>      also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
>      bug on at least MSM, Arasan, and Intel hardware. ]]
> 
> SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
> tracking that properly in software. When out of sync, we may trigger
> various timeouts.
> 
> It's not typical to perform resets while CQE is enabled, but this may
> occur in some suspend or error recovery scenarios.
> 
> Include this fix by way of the new sdhci_and_cqhci_reset() helper.
> 
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

