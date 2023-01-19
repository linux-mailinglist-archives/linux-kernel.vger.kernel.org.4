Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4833674675
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjASW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjASWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:54:48 -0500
X-Greylist: delayed 1804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 14:37:44 PST
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 730BD274BF;
        Thu, 19 Jan 2023 14:37:36 -0800 (PST)
Received: from [192.168.20.3] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 65D081403B8;
        Thu, 19 Jan 2023 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1674164550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSfJvkA8qQyd90Fkn4T/rhPgWpZURUCYqaG0v5R3RU0=;
        b=qa8xeREzk6YR2I5fkmVBjzmGpI4UWdZWWJj8pjXZuuvRW4Kq9MreLg3lySmQztFycriBTq
        savt0hyq2evuc6CvQL0KD1Xu1mrCP7/eZKofZhlmfKYyPqmK0mwjHtm0KqsFoG6nLk8Kfc
        CNA3UZaAGzdalPUuAA1rC1YLxrIsQQ4=
Message-ID: <e079e820-2df0-3c95-10ef-527020b97f5d@postmarketos.org>
Date:   Fri, 20 Jan 2023 00:42:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8226: add clocks and
 clock-names to gcc node
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119190534.317041-1-rayyan@ansari.sh>
 <20230119190534.317041-3-rayyan@ansari.sh>
Content-Language: ru
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20230119190534.317041-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2023-01-19 22:05, Rayyan Ansari wrote:
> Add the XO and Sleep Clock sources to the GCC node.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>   arch/arm/boot/dts/qcom-msm8226.dtsi | 6 ++++++

Should the same be done for msm8974 dtsi as well?
