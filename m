Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC463219B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiKUMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKUMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:08:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBA45095
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:08:31 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d20so14215824ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/Wf7Ihyn7IRm224a6elGwJlmdiu5nLebRBT6EL2QY=;
        b=YtArTj74J8IWD8ozryoyr8jgBtCtYTisL83R4ZTuWeI4lKKYPZWjpNHRgmVCqmHEU8
         p/S6DnN82lh6h9zMitXTzE6sz7RqV9bREiwkZ/AjGuyseg1VyPDdf6s0vnri41vWzwU+
         6A9shmNbl00ggyoXbkvzTVcgESEmHFSvzWc1c8/j7FdJqvoK+qwNKPa0xUBgObbJT8mI
         YzndDbvMZGWpeuGtPUnptnefQgoJc2iyMwCc49WAjKDtUTdtbK5JgwHX8I8kWVXN16VU
         hCsWQ1NPfKmjjUyVN585BSWARIbiHJBJbuypt7k2RJZDS6TNB7x6z1/SYOasdF7aaogu
         To1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/Wf7Ihyn7IRm224a6elGwJlmdiu5nLebRBT6EL2QY=;
        b=aUUgE/F9ipDoySkra4J0A05H4UA/Mp6f1U4D59sAuhyxdOebSQFDm9q4l4bzBRgKsP
         pmN8vMumRVAQ2S6h+7pbw3mAB70CgGdeVxH/ovIqpJOYRUi/7EYEiEpZWHGfIztJAJbu
         aGdrTuXhPpYkrNe8XNdAR9A8KS+FGEmNzGgupQ2DW/NP6rKl2hLec15N5mwPaAxiXslW
         QcCLWKpYAuRiexS50u17gX6kThY0TavPzhRaU07zjgKrspA9fVlJ6f+PcejAcfZkK1BK
         np4WGz20JlrwgIcOgD6e0QzrCwBEIYqScfIorKxOOYy1qrBeCV6yfMEhO/gm8EHqGFmv
         HKVw==
X-Gm-Message-State: ANoB5plDCtdxlN6N6n8jqcEzPfAyrgq7MayQR95eoOYKP29xdk2WqCPR
        DBpi7xkBiH64TK7NN6VaKySO+Q==
X-Google-Smtp-Source: AA0mqf7nzlJ13PlkibFVu8sbGpZadx0YW7VJA9cwKVJLyjBcjoYZRkY5LsNsaHcWs6OROfJdyXkxKw==
X-Received: by 2002:a2e:a911:0:b0:277:44b2:6b9c with SMTP id j17-20020a2ea911000000b0027744b26b9cmr5272068ljq.26.1669032509403;
        Mon, 21 Nov 2022 04:08:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h7-20020a056512220700b0049ae3ed42e8sm1992278lfu.180.2022.11.21.04.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:08:28 -0800 (PST)
Message-ID: <dd6acba0-fa3a-1dae-b383-d70cc08dd114@linaro.org>
Date:   Mon, 21 Nov 2022 13:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] phy: tesla-pcie: Add PCIe PHY driver support for FSD
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20221121105210.68596-1-shradha.t@samsung.com>
 <CGME20221121104736epcas5p36c12ff0b575af77f8cf99811b055b339@epcas5p3.samsung.com>
 <20221121105210.68596-5-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105210.68596-5-shradha.t@samsung.com>
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

On 21/11/2022 11:52, Shradha Todi wrote:
> This patch adds PHY driver support for PCIe controller
> found in Tesla FSD SoC.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  drivers/phy/samsung/Kconfig          |  10 +
>  drivers/phy/samsung/Makefile         |   1 +
>  drivers/phy/samsung/phy-tesla-pcie.c | 397 +++++++++++++++++++++++++++
>  3 files changed, 408 insertions(+)
>  create mode 100644 drivers/phy/samsung/phy-tesla-pcie.c
> 

Same comment as for PCI. It's the third driver for Samsung Exynos PCIe
PHY and every time you will say "but it is different".

No, work on unified approach not 3 different drivers.

Best regards,
Krzysztof

