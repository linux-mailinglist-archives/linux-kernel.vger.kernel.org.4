Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B146B8B74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCNGoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCNGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:44:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B395D456
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:44:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k10so57680389edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywYOZ5xavYpSTwwK3MKmIMTU02VHQ/B9GtHWgy6KTX8=;
        b=uXHuxUk4Ph5GaJtGImjU5sOLPpUpmyg+IeXbihQoUaQvNqXPZZ/sm4Q2Vxj6ib+3/2
         1fva5zlyckAvafDJSuPIDw4St4PqkNptcTg4nFNZi2/UoQNCCQ3lMykAClp4djHY2/Fi
         1lp4qsiP44ansKGJjjON4ooAibBFH027xwBgnU9EDCPCSg9Hb8br9zVPx+TGJ6iUAhf5
         quMWLMl3P+NGzQqETsicJKBo70LvQBFTp5zVUhG9laNfPWbwxob1W68n3PMaSpgZFXNJ
         M0D4UIbfYpYe0HKOe3RZTPpme1zJ5nmlfKF6tFr83YteoKtKE2W2hkMDiE676jPR9iN4
         qY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywYOZ5xavYpSTwwK3MKmIMTU02VHQ/B9GtHWgy6KTX8=;
        b=WHaICavJsTMEgrg71nKjliN55wdsYxSyoQsqFXBJPlMBmkPLXVIHou0oM0rzO38WkQ
         c+25P88jRKnhNftv4meG0OYIHJiNE6pnb+qDhJHA6IxXLPsk6FXfOgsjgnGWgMo8rant
         4wQUVJW9PPNJYB10w+E7/3iCpO6zHtDkFXVC+PP2ybG2ICbsNOv5RFJMy9qY0+KmSX3S
         epuRgCsSai++ihwxJnOrMHpsGMV+hY8WMpbKRGhZP+cbdU84J/XytdOyActWOV0L4MCE
         0Qe2HiI6b/IyOngyJ3ZS49vP9Qnz+lanmrVdzcvKe4dcDc4srlJ6u7hOFIxkBnP4ZYHX
         3piw==
X-Gm-Message-State: AO0yUKWN9t2TbgO/2WwLFmd/PTPFNAHO2fubSqJt9cq6aaqGQCTGgQyr
        NuoxdXBc1fqSnFKR/5igJGOoTA==
X-Google-Smtp-Source: AK7set/lGrzwqGMnZcc9hOtrqzElAVLxHouwR7z35GXn+LIVsVf8yT4Tu11j95hcquGFYNTL6/qGJQ==
X-Received: by 2002:aa7:dbca:0:b0:4af:7bdc:188e with SMTP id v10-20020aa7dbca000000b004af7bdc188emr14135915edt.16.1678776246217;
        Mon, 13 Mar 2023 23:44:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id y97-20020a50bb6a000000b004c19f1891fasm521575ede.59.2023.03.13.23.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:44:05 -0700 (PDT)
Message-ID: <ed293caf-e787-a29e-f1c5-bdcaf1aa483a@linaro.org>
Date:   Tue, 14 Mar 2023 07:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for ID table
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
 <08e98d1d-e79b-fe7e-0d59-827f72277fc5@linaro.org>
 <9bf3dd37-71c2-4118-a8da-40e656b42d10@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9bf3dd37-71c2-4118-a8da-40e656b42d10@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 20:22, Mark Brown wrote:
> On Mon, Mar 13, 2023 at 07:39:45PM +0100, Krzysztof Kozlowski wrote:
>> On 13/03/2023 14:55, Mark Brown wrote:
>>> On Fri, Mar 10, 2023 at 11:28:42PM +0100, Krzysztof Kozlowski wrote:
> 
>>>>   drivers/spi/spi-armada-3700.c:807:34: error: ‘a3700_spi_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
>>> It would be much better to fix of_match_ptr() and/or the module stuff
>>> that also references the match table here.
> 
>> Why? The recommendation is in general not to use of_match_ptr, because
>> there are little benefits but it disables matching via PRP0001. Jonathan
>> in parallel thread explicitly said of_match_ptr should disappear and he
>> is not accepting any new code with it. And in general he is right.
> 
> If that's the case then why are you adding maybe unused annotations for
> half the drivers rather than removing their of_match_ptr() usages?
> There doesn't seem to be any logic here, it's just randomly making
> changes as far as I can tell.

These are not random but depend on whether OF is the only matching
method or one of few. Although for IIO all of my patches would be
dropping the of_match_ptr... For some cases in other patchsets I added
__maybe_unused also because of_match_node(), when the table is not used
in driver of_match_table.

> 
> The PRP0001 stuff isn't an issue, of_match_ptr() can just be changed to
> do the right thing for CONFIG_ACPI.

That's actually interesting idea, kind of obvious so I wonder why it
wasn't done like this in the first place in 886ca88be6b3 ("ACPI / bus:
Respect PRP0001 when retrieving device match data"). Maybe not to
populate OF device ID tables for the ACPI systems which do not care
about PRP0001?


>  It doesn't buy us huge amounts but
> it also costs us very little and may be useful in future.  When there's
> missing annotations it's not causing issues for practical configurations
> as far as I can tell, and if the macro were updated for CONFIG_ACPI it'd
> be even less of an issue.

Best regards,
Krzysztof

