Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3516BE61D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCQJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCQJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:59:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7ECA5E3;
        Fri, 17 Mar 2023 02:59:32 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A95F660309E;
        Fri, 17 Mar 2023 09:59:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679047171;
        bh=e/KIg4k8GoTPg3uxt66ysJDkUFF6y215cPiS3F7Sts0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YVYud1TuEBVXmXkXbL84ROVSh+8LrsQTp9qsY/suO+Mi2ohhnI2YrqfBzGSWxqZ3R
         NzAnEKiPbXJHeHOq1MSFLtlj37ZTtCQWzFsaKy3tZTgFLDy+mPxjENInrPX7gJHkc8
         TDovH0xsLRqc19bzi9A1g5LafgzL1/Ya0GWhG/g/dUw9I+ZUufmc3VA1HsPyZLgoRm
         CC4jb2MnVPSKJUA8MAfStC248ug82iwQGT+huw6WSr6kzA+7MagnRGk/AixlrGAZS5
         uo4fNU+QOW9if3no+vYTaNJixrIzEKtRiDk6xg5MKbXEX2Sl79TKml8dmtwAXQ8nqe
         0MzrDkENAOKDQ==
Message-ID: <d5881d9f-90cc-f7a2-72a3-0701348a03fe@collabora.com>
Date:   Fri, 17 Mar 2023 11:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: firmware: arm,scmi: Document
 assigned-clocks and assigned-clock-rates
To:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
 <20230316203417.GA3833267-robh@kernel.org>
 <20230316222619.r4jzk3lzdxzamr2s@bogus>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230316222619.r4jzk3lzdxzamr2s@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 00:26, Sudeep Holla wrote:
> On Thu, Mar 16, 2023 at 03:34:17PM -0500, Rob Herring wrote:
>> +Stephen
>>
>> On Wed, Mar 15, 2023 at 01:47:56PM +0200, Cristian Ciocaltea wrote:
>>> Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
>>> protocol child node properties") the following dtbs_check warning is
>>> shown:
>>>
>>>    rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are not allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)
>>
>> I think that's a somewhat questionable use of assigned-clock-rates. It
>> should be located with the consumer rather than the provider IMO. The
>> consumers of those 2 clocks are the CPU nodes.
>>
> 
> Agreed. We definitely don't use those in the scmi clk provider driver.
> So NACK for the generic SCMI binding change.

According to [1], "configuration of common clocks, which affect multiple 
consumer devices can be similarly specified in the clock provider node".

That would avoid duplicating assigned-clock-rates in the CPU nodes.

[1] 
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/clock/clock.yaml

Thanks,
Cristian
