Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC38C712927
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbjEZPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbjEZPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:08:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C0187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:08:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30a8dc89c33so547029f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685113728; x=1687705728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQDPpbfKxYac4dFfl3UOiv7iiv3UKto2YwW9RD/lJd4=;
        b=D8329d5gDBuupuw18ee7CiQedAqaHbalYu/5ad/0HLx8pzNJB/B/nXPqeXbg3zAn47
         UPrnWRMAm7bG90BMHhmY3n+VpBQQlENz9uTjY0+zpdv1cT8jbn49d562/eYMTZuYqhaE
         jYA1F+tj07JByXOexpqVnp32QWw6tjLsztNKTrHvXKu3Davn4xKVGIH1Y57SOpVjD20W
         OMAE1twiDb3hwtTTAn3q+ncHQjS6yUWcoP8TeAY32wV4CwfQ8TRSn904UgqFpjjw7VBD
         bzKazNedaXMHzxlBYF69bMm/ufjJ/1nFo4ejX/7ZVnMxqnyj/xDsr55nL9Aq142D8x7l
         6whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113728; x=1687705728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQDPpbfKxYac4dFfl3UOiv7iiv3UKto2YwW9RD/lJd4=;
        b=bg47rwqi4Z+OUiET3suVGYOcOtZqfEuw8f58sYUhLRZNyidyu+fdKXoFH3Qn8T1IIe
         aPt2XZvXu/f25538gaZPt+r6YHMlpN/4FGToR43jGH4aSIoIMHQJUdoisHMQ+qfRtsuq
         tnfvbt1sihFXOzk+HO+znHv3TDXTyl6Xt4s72NXNH4vNM1slQsz+f6b7bQu+5yu4W05n
         GRJbpw5Vl4Rl3zLxTcogOMys0j59MIUUxcGV7SZi9KkQVxX1GfkLxwX/niuW3GIcf57a
         mChnlSgTVWzGkfhe9Jw/Lo5E+BHO8uyAm6AHr7Ce83AVQYG55FG9UA9hmYBjrliSanw9
         soXA==
X-Gm-Message-State: AC+VfDzjcAtXrELMx8O3aU+X3zuHIAiNwa/tZoYXZfJMrc7RQfTozglz
        Neh9O8x+LGhIgtnyQRzQn7cU0A==
X-Google-Smtp-Source: ACHHUZ6Ur52z92yD9zQLf8/rpAwoOXof7X3dA6SmUIkLpPmI1FzD2sW7X7Z8flkFpqVtem4zLqfZ0w==
X-Received: by 2002:a5d:6ac4:0:b0:309:e24:57b0 with SMTP id u4-20020a5d6ac4000000b003090e2457b0mr1955408wrw.30.1685113728030;
        Fri, 26 May 2023 08:08:48 -0700 (PDT)
Received: from [10.1.4.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm9055828wmf.12.2023.05.26.08.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 08:08:47 -0700 (PDT)
Message-ID: <f605a653-ba94-7a8c-1bfa-4c18f5d25da7@baylibre.com>
Date:   Fri, 26 May 2023 17:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/7] drm/apu: allow platform driver to implement their own
 mmap function
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, jstephan@baylibre.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-6-abailon@baylibre.com>
 <032699a0-9a43-953a-60e9-59a515a26cef@linaro.org>
Content-Language: en-US
From:   Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <032699a0-9a43-953a-60e9-59a515a26cef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 21:45, Krzysztof Kozlowski wrote:
> On 17/05/2023 16:52, Alexandre Bailon wrote:
>> From: Julien Stephan <jstephan@baylibre.com>
>>
>> By default we will call drm_gem_mmap() unless the apu driver has
>> declared it's own mmap handler.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> 
> One does not have to review own code. We all assume that we send good
> code which we do not have to review by ourselves (by the author). We
> also assume we make mistakes, which we cannot find, thus other person's
> review is important.
I am sorry, I am the one who made the misstake.
I squashed this patch with another one I made, lost my signedof and left 
the reviewed by which indeed doesn't make any sense.

Best Regards,
Alexandre
> 
> Adding own review tag suggests you added them mechanically, so I doubt
> that they really happened.
> 
> Anyway, your SoB is missing.
> 
> Best regards,
> Krzysztof
> 
