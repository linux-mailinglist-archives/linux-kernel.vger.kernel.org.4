Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755286904BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBIK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBIK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:27:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A59968132;
        Thu,  9 Feb 2023 02:27:18 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7A0A66020BA;
        Thu,  9 Feb 2023 10:26:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675938399;
        bh=eHmPGXHNcPrTmMdQR0QDsjblTVBOeO8w5mDS6XIEA3U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VuOEMjMfqMpDKVUM6/ks3zjKObkU0jXs2lXmRc3TeIVqVZeglz7WfHD4lD7cKTOg0
         KAdg/X01ricApYBBMR6MxIGqM7pMDTxlY8hh2nCFXiPH/HHKzKRx1Iin1HBHZejmH1
         v31bD+G2zX1AIsBZLvmUAAwhLWzbGC6P+YV5y/ow0V3MPbnCc/ha28N9egpUW0Ec4i
         +SW3LTU8sIB/bHcjM4E4kpceaaK4R3lCJBm/o0W7UDky9z0gZsVl13lbydI1EWMfjF
         3KHfJsH3WMBgvspGKYf/WmLmaLEDtC4qGM43ZeBDR4qFPYplxQQTR6QKXWNPJ9o1/P
         PdMjR1aIdzZFw==
Message-ID: <a6601fb7-284b-f51a-25a5-09b7733fd5f6@collabora.com>
Date:   Thu, 9 Feb 2023 10:26:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 4/4] ASoC: cs35l41: Document CS35l41 shared boost
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230209083726.1337150-1-lucas.tanure@collabora.com>
 <20230209083726.1337150-5-lucas.tanure@collabora.com>
 <9b20bdb2-64e0-4888-e8df-fdf1b021c445@linaro.org>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <9b20bdb2-64e0-4888-e8df-fdf1b021c445@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-2023 08:53, Krzysztof Kozlowski wrote:
> On 09/02/2023 09:37, Lucas Tanure wrote:
>> Describe the properties used for shared boost configuration.
>> Based on David Rhodes shared boost patches.
> 
> No improvements in subject, I asked twice for it. What does the command,
> I gave you, print?
> 
Should be
ASoC: dt-bindings: cirrus,cs35l41: Document CS35l41 shared boost

ok?

>>
> With fixed subject:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

