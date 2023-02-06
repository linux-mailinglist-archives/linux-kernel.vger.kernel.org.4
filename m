Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7868C691
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBFTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBFTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:15:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8E1F91F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:15:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso11550980wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iniev9+D6uZ6XQ9DZUsmrgSWAz/CkGjwKUBOylv7Xs8=;
        b=R8VnzjK0B/jAiGqqdhjoUnYsKIn08raxB+gye5CjA9WdNYJamW+KnOJze8NWgxUSVJ
         wZ8BbBFyCPXzjs19eYqKohofsVLZE40Dorf1tMrHzzbvgdLRVl99CnFdYUSo1n8IU4+1
         t6k+9Q4yc+EQb/cK72RgbqNcAKHI7ocHdXGKbdWDFyJRCiGN8xpIZJU0afJCUi8HQ5Lb
         nd5ilMooPqj/Grz5siAjCCuE+DTcQg2KcHmThu4HuYluOAMiYRrVO/5fBskro3g0Jeg7
         Mw1ifVgO+86CStcsYwo5MOPr5Rqdb1leO56SQbtsREyzCVwi2/pHy4RAyxueGTOd5Dws
         PAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iniev9+D6uZ6XQ9DZUsmrgSWAz/CkGjwKUBOylv7Xs8=;
        b=LjD2NvLoJ5ioOhLrtF8L533uEo32ZhciU2jQHDEIAaBygB+BAzZ1bdFPX8eGbLmkBI
         bnDwZhmF8+cM6GCTle5gLdYOAdcxR3BD7P8qdBSPb2UPRqh04f92K6ymg66qq0euJqyw
         aAMc/W52TkIW/6C1c3YX52p4rmfmKooF+Hmg6aQ6rp8RQf8f6tggSIjezb1NGBVPLDuP
         BW+XFjNVZyilO0cejeAGfIhHIHAgX3vSSeV2lgj1zzFfHgdn6k0ZHdUUnSwSTY22p3VM
         2cpgikKOemY7MdFrw9NzFtGw1jyBE3QFvse9kI3OzEwC1mlj9t/JPs3iUZKvEMUvk9wb
         qI4A==
X-Gm-Message-State: AO0yUKX5X4nV39kDJc7AHqQIHn+evkrbDNqkJx3tsGM9YiC/xTW+hJa8
        y31oFjoYQuLobe0Y6JPcKNy+xQ==
X-Google-Smtp-Source: AK7set+rmvAq7Kd2BDYlA+s7058vt+eFcngnsEXUb/HDb4/Z+Y+NjPnMTQe5zWfnu1+fv/8E3WiVjQ==
X-Received: by 2002:a05:600c:4485:b0:3e0:185:e93a with SMTP id e5-20020a05600c448500b003e00185e93amr725830wmo.25.1675710900467;
        Mon, 06 Feb 2023 11:15:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c16c400b003df245cd853sm11443197wmn.44.2023.02.06.11.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:15:00 -0800 (PST)
Message-ID: <349c949b-bcf4-e31d-b4cf-51953d0e325d@linaro.org>
Date:   Mon, 6 Feb 2023 20:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: meson: convert axg fifo to
 schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-5-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg audio FIFOs to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-fifo.txt       |  34 ------
>  .../bindings/sound/amlogic,axg-fifo.yaml      | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

