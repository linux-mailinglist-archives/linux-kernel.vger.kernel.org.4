Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E160B48A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJXRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiJXRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:50:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A136784
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:27:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q196so8134171iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2WxXBEhE9lmDiSCmtp6HlQFdsUIOok3Tbt3p22NXFQ=;
        b=pIjNTn/Fw5wWPAnx2/iV0f7mAvnR9IX0NCgHKJpazCJnQ1lUaI1x7+jTaz8VYmauFw
         9RqxCpRkKWJd0rFVRquaxty4jObK9YVXOa8B/ART4GgclBBJOiCLUvD6UkecvNvTkile
         Ql1kTwcznQdIkkerX139c4qhw/erTM55HQ9pbOj9I0/RwJtwvlh3lN+18e4GyNGwyzp3
         mH33QTClrMl467lrxdZ7cG5i9eC+l3SJ70c+d4lOhzQSMVlJMYEvZ6E1qskDNlYxbBRW
         tYGZ4Ht2h0l8C7iXxxoaMskAXr8pI/BeMKNAHkC1ZTdhH8k524eluQdJ0zLMClj5sVRK
         tYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2WxXBEhE9lmDiSCmtp6HlQFdsUIOok3Tbt3p22NXFQ=;
        b=hNVo4AKSQBZy+yaojmg+VWn8YXnpOqGrlxvEI/Qpt+oOz5aAgPLesA3F+3oyguZlQF
         9sBxY1UauJSMiTwIUhv5c2asufSpwGDrDlsCXywJf/rVdTUvCP5tFlU52Sbhl96q98D+
         Q9dKBNxSS1xbiY8/1nq1af7ffU9IWM2KVt+jp0JSUbrrcmBA/OJePYxnCw6/lAdeP0mU
         fWtNtZKU+nemZATULfFKVngwDvtdQz0XOxhczFLE0j9WKiiJTvSRDli4LCAL7lJ6uya4
         qXLTdOb0ANximBGOp+mvuErn2QE0nh1qTakqmdYrL9+tkyK9V14ARaKjpJGFcEYTly05
         IxZQ==
X-Gm-Message-State: ACrzQf1at8t+yZ1uAQCGb+pEKSGjUXccyxm9cfJYiHR2VnMYt5olzcNU
        clKRs5O3SNPMqYBgFGefa1qIk/AS9diKWg==
X-Google-Smtp-Source: AMsMyM6zKtB0VLD6JglF4BT8OXGL92tkP9rpSuRx3jzlARvuiFn8HIW3TcUaeoMq28LG3WQoVTOaKw==
X-Received: by 2002:a05:622a:15d1:b0:39c:f1da:fe0e with SMTP id d17-20020a05622a15d100b0039cf1dafe0emr27027912qty.662.1666616007083;
        Mon, 24 Oct 2022 05:53:27 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y8-20020ac81288000000b00398a7c860c2sm12704392qti.4.2022.10.24.05.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:53:26 -0700 (PDT)
Message-ID: <78b09272-4184-b2d6-3849-a6e0e8a16255@linaro.org>
Date:   Mon, 24 Oct 2022 08:53:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 21/21] ASoC: samsung: remove unused drivers
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-21-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-21-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx SoC platform was completely removed, as were most of the
> s3c64xx based board files, leaving only the DT based machines as well
> as the MACH_WLF_CRAGG_6410 machine. All other board specific ASoC
> driver can can now be recycled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

