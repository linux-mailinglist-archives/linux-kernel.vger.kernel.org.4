Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E65BF837
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIUHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIUHu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:50:28 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873C67440;
        Wed, 21 Sep 2022 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yDU7cULxVdpJ/UBJp8aYy02w14Tx6aVcHKBJ/fAjBHk=; b=1j1J0Nfa6b+RwDngJH/QJ9P1Dd
        8rUbvZzpqajDqRXZXukqpeO3bisSbhdTUWh3RndHaZGCB0jYWafxCOKyZkixUKMruSNt2o8iRv32U
        +KXZ/B1mA7tgg8E9w/zA50K8p4do+dvOl4HAZ+0vi8Y5RUBBQGlWsWtnWVPiPCVoNgjniAa5C3YM2
        y8KpvDE3p0637ZNGddh8z/vT1pfe46cpDil5aEIlr1XTJQXgkc7usijYJqTuxCvZze7vc5ezUMq7u
        qxpxpUKYMGXNN3ZYUendoIxt1ZePaSzQeOKCYn+KldbLH2qmpL+Sp+a80eRyefnZ4memqD7LOrwbE
        UgTlClQQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oauUq-0076Jh-I3; Wed, 21 Sep 2022 10:50:16 +0300
Message-ID: <de7f5e65-c939-558a-277d-01320f93eedc@kapsi.fi>
Date:   Wed, 21 Sep 2022 10:50:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 0/8] Support for NVDEC on Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
 <89d925ea-f550-6903-1c24-b320ae5a82c0@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <89d925ea-f550-6903-1c24-b320ae5a82c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 10:26, Krzysztof Kozlowski wrote:
> On 20/09/2022 10:11, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> v3:
>> * Updated patch 3 based on comments
>>
>> v2:
>> * Updated patches 1,3 based on comments
>> * Added Acked-by to patch 2
>>
>> Original message:
>>
>> Hi all,
>>
>> this series adds support for the HW video decoder, NVDEC,
>> on Tegra234 (Orin). The main change is a switch from Falcon
>> to RISC-V for the internal microcontroller, which brings along
>> a change in how the engine is booted. Otherwise it is backwards
>> compatible with earlier versions.
> 
> I asked you to describe the dependencies and patch merging strategy.
> It's still not here, so I assume there are no and I am taking patches
> relevant to me.
> 
> Best regards,
> Krzysztof

Sorry, I described it in the earlier email and forgot to add it to the 
cover letter..

Patch 8 does depend on patch 1 so it would be better to take the memory 
patch with it, or however works best from maintainership point of view 
(not my expertise).

thanks,
Mikko
