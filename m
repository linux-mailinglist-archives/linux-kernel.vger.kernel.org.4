Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8386045A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJSMop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiJSMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:44:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89152C45B9;
        Wed, 19 Oct 2022 05:27:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so5291768wmb.2;
        Wed, 19 Oct 2022 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjMgaAxf3cPo2xvIkUaAZp9gtwOpwstMnjYfymEdluU=;
        b=lHRd+gEc+LSqVpsp8uIxS9SQlS1qxm2iebVX1RFuIFsGD93vZE8NzjjtXqigKMuCAs
         TMdD6RfEnpZzlPjOfO0kIobviHsyUreB+YYV9IvM7ItpOgJUck+T4eCNF0eisWGutjbb
         p977pnolgHK46CaXAboslqV212VEr0GOGcgHmYyb8CcqczF3AwjOBy5mNZQ9M1esXzUW
         cZnQ7XfHyVLYZEeNO11/RJzzN4llVVJVJldeg+qmNvdqt6Yk70qVuHInnr55iYeFsUGV
         EmaO76Fv5Sl0+GiBM7uIiZ8kciUGY2byKaUJzoR6v2+cVvVM0q1GBmhzMIP/ZGHFFf0v
         5RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjMgaAxf3cPo2xvIkUaAZp9gtwOpwstMnjYfymEdluU=;
        b=yjA//CzfWgBA8LEpcE/17SmySx66AF+4TWKadhXLdnOsyRt6SB2QLjStUysS/rYb8W
         BDnXONif87O+Va/U+IJDDwsDxLMTNrdcSHNiEp+RjN2u7ZEe1wCh+sZqCFIpuZEZB4Qv
         ZIBpD1LyhOgT4jI9fEdA1N0O/NCRcOxs4JWdCAi9ZheH1PJK6jo8e3xE6DY/hO3T4+sb
         I0M8TuPjWvtA723g3+Ahv6vsxwY0bWcx2y0l1iT1Y30DG3jF9BaY2SyKR7xwMpqLtvgf
         wTCIL7++2LUn0XukX0yk4175ptgTfeMRd+j+x1tlJPfyG8gb3D6m/+0sHaMIixzpwAq7
         vnXw==
X-Gm-Message-State: ACrzQf0Ayx+ScOQdjtnZ/STOMkjtwt65pfQwnU3uKfxNP2MTBulqUem9
        zTxmulu0LuhylxjaSnQAYvIyZUSL9T/uzBzI
X-Google-Smtp-Source: AMsMyM51YrNAH1KSaziPnTMUAlap8IppnhFeNYBSEJdvs5FCtBVan+R8OxTuChaFh0S9XP3661KujA==
X-Received: by 2002:a7b:c00d:0:b0:3b4:6331:2fc5 with SMTP id c13-20020a7bc00d000000b003b463312fc5mr25717274wmb.11.1666182348257;
        Wed, 19 Oct 2022 05:25:48 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id d1-20020adff2c1000000b0022ac1be009esm14068917wrp.16.2022.10.19.05.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:25:47 -0700 (PDT)
Message-ID: <cca499ac-6e6e-fa92-b7d1-9a2848c6645e@gmail.com>
Date:   Wed, 19 Oct 2022 13:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake
 "Sourc" -> "Source", "Routee" -> "Route"
To:     Paul Cercueil <paul@crapouillou.net>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221019071639.1003730-1-colin.i.king@gmail.com>
 <Y0/pSVbueZYXBsmA@sirena.org.uk> <S820KR.GPNPWZ8QG3PG3@crapouillou.net>
Content-Language: en-US
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <S820KR.GPNPWZ8QG3PG3@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 13:19, Paul Cercueil wrote:
> Hi Mark,
> 
> Le mer., oct. 19 2022 at 13:10:49 +0100, Mark Brown <broonie@kernel.org> 
> a écrit :
>> On Wed, Oct 19, 2022 at 08:16:39AM +0100, Colin Ian King wrote:
>>>  There are two spelling mistakes in codec routing description. Fix it.
>>
>> Bit disappionting that people didn't notice the errors during boot
>> there...
> 
> Well that's on you. You merged the patchset before anybody could review.
> 
> -Paul
> 
> 
Fortunately I spell check linux-next daily to catch these typos.

Colin
