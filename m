Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AF6CA9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjC0QCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjC0QCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:02:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3565A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:01:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so38240476ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679932910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fa/r17s+alPGyyVImwqvDf9JaCdRCB5grSzax4q6pX0=;
        b=O68t/3kzy8ci27Zq3vdVjcRffpSKeP8C6pe9wLILYXUtQS6gAAgwmJuB8Rvxldljp2
         c0H2DY3/h9foj8UxOPpH3mLq+fvjilY1BlwBrDlAckkZsVj/eGwx7vAbJLmBgW7uZMjU
         zmuJM4n0TnTuNY42m+XkFpj1RNToB9abb4uLvQJDafGLB9n05GJfpA8gBgo+o8RAA2W3
         vqk6WSrbYFc1K6dSV05E3JrAVvFloS65yz22ZRsIO29ec5A16RvuEFXvJDzCX2wUil7a
         XNPRPETed6EG9KnJrGeqYqUyLvXXngkJBfr+U5mrJzlsmtKdMNBowZ4LxooZBUS42QgS
         T62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa/r17s+alPGyyVImwqvDf9JaCdRCB5grSzax4q6pX0=;
        b=AlZ4rVFkzZzOvGe5E7wgx+2v0v4uJebx4i8GEyzvu00FrV/l3+jzk4/1c6lig9m9QT
         1kDoFYvX84DrOTjwhCZQtJaDHr3axgFMnFjUBBgZltESk+8mDtECa+oXJW6zR6PStXny
         6GB/L/nsKCsyEqhY9QiK6JaAcXhNiv4pAlcvv04qF/LG3sk7n5VI9fW4gsBITn28lG1w
         Gm9gTF8RgrYaaBwjH0s3iWorX/H622yh/N3djRVzR8vRJ5Z0O04+ia5iTCmVWLRcP4d4
         k4YoWuTYxuAVOE1d4gt6qtg2bwyuzVUoJs4vs40ALnhKV/8AtKLQ1nm/ZfLHdba6+FZH
         55kA==
X-Gm-Message-State: AAQBX9fKr0fOuGmacO2UJUDmBTD5lt8O0blkuvYrDtOHNkNvGHnZ88vn
        oD1Wi3oEyvvxx4itqq4jwsNtW+ycbdSyvxazelM=
X-Google-Smtp-Source: AKy350b0TiR+o+4SVdQcTgcYhvX6iSBeAWArFCOeTjUbnLe8SG/U05eoHqO/TVJbZlkFAnG6RhtT0A==
X-Received: by 2002:a17:907:b60e:b0:93e:9fb9:183b with SMTP id vl14-20020a170907b60e00b0093e9fb9183bmr11190033ejc.73.1679932909984;
        Mon, 27 Mar 2023 09:01:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gt6-20020a170906f20600b0092a3b199db8sm14040327ejb.186.2023.03.27.09.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 09:01:49 -0700 (PDT)
Message-ID: <676afe98-c39d-47e9-8d06-3ac88bc7404f@linaro.org>
Date:   Mon, 27 Mar 2023 18:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] Documentation: sysfs: brcmstb-memc: Document new
 attributes
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230324165231.3468069-1-f.fainelli@gmail.com>
 <20230324165231.3468069-3-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324165231.3468069-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 17:52, Florian Fainelli wrote:
> Document the DDR rank, size, total size, width and type attributes.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../ABI/testing/sysfs-platform-brcmstb-memc   | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
> index 2f2b750ac2fd..bc969c02b85f 100644
> --- a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
> +++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
> @@ -1,3 +1,42 @@
> +What:		/sys/bus/platform/devices/*/ddr_rank
> +Date:		March 2023
> +KernelVersion:	6.3

We are now at v6.3, so this cannot go into current cycle. Date is also
not realistic. Target v6.4 and it's date from the crystal ball.

> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
> +Description:
> +		Displays whether the device is single or dual rank.
> +
> +What:		/sys/bus/platform/devices/*/ddr_size
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
> +Description:
> +		This field specifies the size of each DRAM device in the first
> +		(or only) rank

Why only first rank? Have in mind that one physical chip can have
multiple ranks and the interface should be ready for it. Otherwise soon
you will have to break it to support different sizes in different ranks.

> +
> +What:		/sys/bus/platform/devices/*/ddr_total_width
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
> +Description:
> +		This field specifies the total data width of all DRAM devices
> +		(in each rank)

Sorry, I do not understand. "Total" and "in each" are a bit
contradictory. Also misses units description. Is this

> +
> +What:		/sys/bus/platform/devices/*/ddr_type
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
> +Description:
> +		This field specifies DRAM technology type. Possible values:
> +		DDR2, DDR3, DDR4, GDDR5, GDDR5M, LPDDR4.
> +
> +What:		/sys/bus/platform/devices/*/ddr_width
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	Florian Fainelli <f.fainelli@gmail.com>
> +Description:
> +		This field specifies the data width of each DRAM device.

Width in which units? And width of what exactly? data-bus? Then bits and
make it maybe "ddr_width_bits" and print 8/16/32. Is it IO width (number
of DQ pins)? Then it could be also up to 128 in general.


Best regards,
Krzysztof

