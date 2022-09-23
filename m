Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A785E7D55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiIWOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIWOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:39:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20E143289
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:39:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nb11so1144616ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=S5eZN2svmhOfsW6VEcUb5Ry7O5bFBRCb5lC2tn/7Tfo=;
        b=gkzAlIt/hpKoRZEZLqhfZ8OysZ9L7bILUx3sexHwwb/6XDB+pCPacUz+MJjhWKhuR8
         03WIYD6q3het0x2eUZOaFt4+8DLRxhO61dji69+3Me4MLavSly0qeRo0vqetAht869ok
         ifG9Ps6irane6AxqQ0QfJg90uACXU5trZG5FNLfEzHAvnDR/7MbC/Fiy3LIbWwjANhiM
         E2UJl7+e5iXNxOJG9pVXNlrbpNeiZUe/b5JBc4Ah587wHR6LrqOEcMd85sSJX+AHXzVH
         ylFVisJVdx3w/VxoxI7/ouKWTh3F9lVB7kokwRSC1DxQ36BVKR9k3+145PxEiaip0TUB
         rnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=S5eZN2svmhOfsW6VEcUb5Ry7O5bFBRCb5lC2tn/7Tfo=;
        b=gfZ/7FFz39yySALpvhmgQ4bS+sM41VOxwU+X5K4cumeN2s2+SECWHMCEDk+f8dV9E9
         YeTIr8+R710q5MmXAg+7JR7e2JFvYAWuhWdW1B501tjn0eSj2O9UrBWOwOc/VNq4WqSI
         UyTGzWbJlWnx0Y78XFWOMcKPcRmn7/2LRC2TaSp6AFJ2tvUfwlZex31FLSWmBbIIvCVe
         evh5P+4laWNIKttwkdES9fhtyLBHk7TsoTlm1JK3CrCzz35g35HkF8pHTmWvMO6n6hmE
         BSI+qNLR8oTeMvBN6uEGV+/gBrNUbnZSK2deiZfQI4uHGZpU16HaC/rJQTZLC8kwVMkO
         gTMQ==
X-Gm-Message-State: ACrzQf3EHe2y8JLcB0ue5idIDJqOXBDhAD+siLjRMOfUAJv9qi71yKXL
        z3GpUReW8SrKOR3xHAhm82PowA==
X-Google-Smtp-Source: AMsMyM5/0fjixHZUeDGkqTbJZktQlwbIg9e75ri3yi5AJ6I4VwtQ3bwL9pzvfhAltPu40POCkTiVNg==
X-Received: by 2002:a17:906:8469:b0:781:fc76:fbd7 with SMTP id hx9-20020a170906846900b00781fc76fbd7mr7457238ejc.486.1663943960828;
        Fri, 23 Sep 2022 07:39:20 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0078197a9421csm4117653ejg.85.2022.09.23.07.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:39:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 23 Sep 2022 16:39:18 +0200
Message-Id: <CN3UWLRBLVPF.VV4AX2X9TS34@otso>
Subject: Re: [PATCH v1 00/15] create power sequencing subsystem
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>
X-Mailer: aerc 0.12.0
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed Oct 6, 2021 at 5:53 AM CEST, Dmitry Baryshkov wrote:
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

What's the status of this series? With this I have gotten Bluetooth to
somewhat work on sm7225-fairphone-fp4, which is using WCN3990/WCN3988.

Is there another solution with a different patch series that could make
it work also?

The latest I could find regarding some new Bluetooth thing is the
following email from June 2022, but nothing seems to have happened since
then.
https://lore.kernel.org/linux-arm-msm/SJ0PR02MB7135746D204F13550E9BAE77F8B2=
9@SJ0PR02MB7135.namprd02.prod.outlook.com/

Regards
Luca

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

