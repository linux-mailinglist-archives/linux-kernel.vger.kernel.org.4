Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321136E0C87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDMLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDMLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:33:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F649769;
        Thu, 13 Apr 2023 04:33:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90E2C6603213;
        Thu, 13 Apr 2023 12:33:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681385581;
        bh=fne5vl1dtaJc7cfXmmcmLI+T79wzFSh9tR5IvtINcUY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ck2lwMMNcQmkEzK1WZ9PCnPNBITalhay8LToLlOmiz8aSIhpybVtJy1zOt4JPxMmS
         5+XMqV6JQCn6RfvoBbcw9mpBg02Sr2NdmJQ7IpOuezPiAF4zIIZ/jN999SaWm45Kil
         LxXZbIydwzdjxz9UceXfRre++xcwWVDds2I6xPvEiKU0c5MhK/RWSqGnxGaZlb4tab
         qXx4fNeqrwfIhMN8h3fKtPDs0b7To1ee7Vo7LxCuoFfV1cN2OqAnT0MK9/aEvt0LFu
         1nvFEA8xts/i+5IKNF3xTITa9sN2WyHwpj80KT7+RUOfqL7Ma3yslPyTVi3AO/MHO+
         g/a71KyMibHWQ==
Message-ID: <76c89ad1-a189-c907-590c-35ae6b7edd9e@collabora.com>
Date:   Thu, 13 Apr 2023 13:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
 <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 13:06, Pavel Machek ha scritto:
> Hi!
> 
>> Add basic code to turn on and off WLEDs and wire up MT6332 support
>> to take advantage of it.
>> This is a simple approach due to to the aforementioned PMIC supporting
>> only on/off status so, at the time of writing, it is impossible for me
>> to validate more advanced functionality due to lack of hardware.
> 
> 
>> @@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device *pdev)
>>   			goto put_child_node;
>>   		}
>>   
>> +		is_wled = of_property_read_bool(child, "mediatek,is-wled");
>> +
> 
> This needs documenting in the binding, no?

Yes, and I forgot to. Would it be okay if I send a supplementary patch out
of this series to document that since the bindings are already acked?

Regards,
Angelo

