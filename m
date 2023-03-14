Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B76B9800
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCNOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCNOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:30:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467DB75856
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:29:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn21so32670706edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678804181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElHjwIeT7npoxRMCw2nu+jmWqBva4+bKaapSz/mECSU=;
        b=TwVSJKTA35/n7SvFYUMIlB1ti+ObmERDISpugC0l5FukjPltxsLMTim+fYoqzITV48
         Trw+IaBTNH1Tc9uawQC+HZo+5oPJTqFty35G1Umuv/dmjPrqA7Eqneu1dZxeABPqSIRD
         0f2MjRjrXYt7GZEGmmhaPIVxnGU/zIf6NCHbYcuZXxOkybmaJvexGSBxykK//oLP3mPE
         5NK/nUYaWU/eyPRFiOcLoaP2qNqxVsCFrGcsGYdmIXXdLU2b9X7Pw9KMtNQM3D8xMqkt
         mJvuya1ZYDXNI2zXQb+o408sxCZy1cUeWmQTOZO9EjYw5CFdtzAhPMdhEg8f4Sqa6N5w
         Hc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678804181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElHjwIeT7npoxRMCw2nu+jmWqBva4+bKaapSz/mECSU=;
        b=lpgDvquFp0d+C68dFQPoxsJXmZR7BWuL1sUoXAMsbEwDDSjUksdAhHfX3va8lkT20Y
         Oc9YB3eAFsWcaHxmVxyl4f/4mrH10mXtgV5gzFHaX/ttTzV6Ls9UkUWp0sEOfDCveVC+
         BP20pfi6xNSYoToRcxR1BLAaJ67IfeeeIpv4Y/ECRXk3Z+n6tNPLLHUUMqx87HncpLko
         Aa9AnILwCbJoWKiYF8VsJV4texytQ1oyyjIKroVtoQG7hC+s7O/TjrrT/y+uXJ3F2Urz
         Qv8nd6bVc2deHkEPRR/PEWtR0JHbUaf0DL/xWMHmw0VgTB4R7gimS7k777cD7X5EMsJe
         oG7w==
X-Gm-Message-State: AO0yUKXOu6ZdpNbeHG6XlWb7Zi6FheQ9HyY/5yCPvOlH0YW3ggkvQcFj
        qLwcdZYnO1E29EpPrngU5U/w3g==
X-Google-Smtp-Source: AK7set8BTJKzs7H5rL6iH9MVtKlcHgRUHKBlpQX+UW1cWD83NcyG/8r94I7ANT1OFh2CKPgR9hQNTQ==
X-Received: by 2002:a05:6402:202e:b0:4fd:c862:b3b7 with SMTP id ay14-20020a056402202e00b004fdc862b3b7mr2490284edb.20.1678804181215;
        Tue, 14 Mar 2023 07:29:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id s23-20020a50ab17000000b004f1e91c9f87sm1147798edc.3.2023.03.14.07.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:29:40 -0700 (PDT)
Message-ID: <9756a5ae-a5f9-c2e0-1bb4-cdcc4373b891@linaro.org>
Date:   Tue, 14 Mar 2023 15:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 1/3] dt-bindings: PCI: dwc: Add rk3588 compatible
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
References: <20230314135555.44162-1-lucas.tanure@collabora.com>
 <20230314135555.44162-2-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314135555.44162-2-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 14:55, Lucas Tanure wrote:
> PCIe for RK3588 is the same as RK3568.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

