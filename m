Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573485FE2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJMTu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJMTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:50:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DA60CB9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:50:17 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id u2so1519777ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJtUgMyknP4m6ys7U3PstctWgnf/qk6Z7L91/ntX78Y=;
        b=WwkyeeUjwcHXf2Vy1OXp7GfUN1jTId+7Svgh+SNa0GwV2l4+49ATkI9Y+pXz3w4dZZ
         bKI1zGvMjRq0Hu9tRXndWR2X84VisTSzl32ySRyuVa5936+YEcBi7pcTvYyVOMa0PAo3
         PGBGwYeWRwafPuJGf8JxofTX1gUQENo4G/MYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJtUgMyknP4m6ys7U3PstctWgnf/qk6Z7L91/ntX78Y=;
        b=c9C0QHil7IZt3kBAnATL6+3L6en8+9yzTgOkuPwITEfNCnQX7VfM3+OzatWqwL2Aux
         fqspmVumcT0Quqr6rEBIHCuHXnlw7O8fVv/U/bO2mOk6KHkShYQGzJ1SxonqOsBi68Ou
         ce0QtSnOKp0iGMr3jF+GZt0vSskYMCbnK/zmS1YOPckU6Inoq7DoBobfC/H6n/b3XTM1
         mPawoL8YYfIIxqXF9fwzO+Go/egL2im6SI51x7GX2gUXBfijlrbNRck1J1TSywuc1Z7m
         lQ7YUTSuGrUHra+v5DcbigCPw5/IE0Lj+T3Qyn4EqM5aWiqGOn+Vl71n3rO454qXlP9Z
         wn5A==
X-Gm-Message-State: ACrzQf0BN6vBF5r9IyHXIhqenScu2c86zJnlUJmQ3jIoy8NuRZD1mk0p
        NqcGner+Dv13O9ppNDKPcIeojw==
X-Google-Smtp-Source: AMsMyM7lvMIch7u+CSSvr4aiO2Kb9grrpoWlHGADoAvjJtjDhqNPId/axnO4uvfzhHRdAFDnCZvtVw==
X-Received: by 2002:a05:6e02:1bc4:b0:2fc:2d47:9abf with SMTP id x4-20020a056e021bc400b002fc2d479abfmr809263ilv.246.1665690617052;
        Thu, 13 Oct 2022 12:50:17 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id q27-20020a02b05b000000b00363c852c779sm308754jah.61.2022.10.13.12.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 12:50:16 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:50:13 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 00/15] create power sequencing subsystem
Message-ID: <Y0hr9XTGAg8Q6K6y@google.com>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Do you still plan to refresh this series?

I know there have been multiple attempts to get something similar
landed in the past 10 year or so. Your series didn't seem to get
much pushback from maintainers, might be worth sending a refresh :)

Thanks

Matthias

On Wed, Oct 06, 2021 at 06:53:52AM +0300, Dmitry Baryshkov wrote:
> This is a proposed power sequencer subsystem. This is a
> generification of the MMC pwrseq code. The subsystem tries to abstract
> the idea of complex power-up/power-down/reset of the devices.
> 
> The primary set of devices that promted me to create this patchset is
> the Qualcomm BT+WiFi family of chips. They reside on serial+platform
> or serial + SDIO interfaces (older generations) or on serial+PCIe (newer
> generations).  They require a set of external voltage regulators to be
> powered on and (some of them) have separate WiFi and Bluetooth enable
> GPIOs.
> 
> The major drawback for now is the lack of proper PCIe integration
> At this moment support for PCIe is hacked up to be able to test the
> PCIe part of qca6390. Proper PCIe support would require automatically
> powering up the devices before the scan basing on the proper device
> structure in the device tree. This two last patches are noted as WIP and
> are included into the patchset for the purpose of testing WiFi on newer
> chips (like qca6390/qca6391).
> 
> Changes since RFC v2:
>  - Add documentation for the pwrseq code. Document data structures,
>    macros and exported functions.
>  - Export of_pwrseq_xlate_onecell()
>  - Add separate pwrseq_set_drvdata() function to follow the typical API
>    design
>  - Remove pwrseq_get_optional()/devm_pwrseq_get_optional()
>  - Moved code to handle old mmc-pwrseq binding to the MMC patch
>  - Split of_pwrseq_xlate_onecell() support to a separate patch
> 
> Changes since RFC v1:
>  - Provider pwrseq fallback support
>  - Implement fallback support in pwrseq_qca.
>  - Mmove susclk handling to pwrseq_qca.
>  - Significantly simplify hci_qca.c changes, by dropping all legacy
>    code. Now hci_qca uses only pwrseq calls to power up/down bluetooth
>    parts of the chip.
> 
> 
> 
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
