Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF8969F0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBVI4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBVI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:56:32 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15F35267;
        Wed, 22 Feb 2023 00:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pB5Qy6H1AhIW+S+MO2gVETFQyOAVmkGRdB/dvJDyZDU=; b=yFPXld4rvdDBkR/0AGehU7LhZw
        4oDXus3nhp1JozzKFM9rGvlttKFMLiGOUlgM07gSG+DEw/o21xcUgg1sBxF3LFvAmwYoFvswe914P
        sg3usOgRF5y5etSZw0E3bzwUVHAYY241Z8U9g9W0kA/KkvY+J91ClcvGKCKk+JjO+vbRgVo9KsG3/
        MjX3B/JCZqtfUFCs/+6aqrzO3lR4SSqwxvgETy+UK382d2HAVqzQvgm8pUsLhST8BqabNA8dviLXS
        mCzQtVemVRJiWpe4GciHhsaggLyzQGMJog8A1NEX3oPUX9uR5Gu7BGZUtjzMghY1iLpWzqyInLrs2
        c/pmcvkw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pUkvH-00Gon5-So; Wed, 22 Feb 2023 10:56:23 +0200
Message-ID: <50e64bd0-00cc-fd2f-b45e-e7268cd371b8@kapsi.fi>
Date:   Wed, 22 Feb 2023 10:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 1/5] ARM: tegra: Add labels to tegra30.dtsi
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230221175348.15681-1-clamor95@gmail.com>
 <20230221175348.15681-2-clamor95@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20230221175348.15681-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 19:53, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
> for cleaner device descriptions.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Hi!

Patches 1 and 2 are missing your Signed-off-by. But also, I'd only add 
labels as they are needed instead of adding them all in one go.

Mikko

