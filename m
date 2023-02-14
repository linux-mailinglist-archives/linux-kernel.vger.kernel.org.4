Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B083696C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjBNSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjBNSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:09:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E68A8;
        Tue, 14 Feb 2023 10:09:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dz21so6612561edb.13;
        Tue, 14 Feb 2023 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+nxhLmPT6t4AY10TSurP4vTyy21I9tRsQ7s0eYmz7A=;
        b=pxwExbQHI3IvXxpy4HLqrfnXfnbHU3154XSircVEIiX9lIQ56U6snohu4lPyv52BYY
         07O1AlehgwywDnckGWW2wySJT8UnKjKGGy2IHm/KIbxIZ9fRrlK5NFtVWnjvKU/uNo//
         wn5GndkkKnoILxPouX6EkWYXdfSMgUhGK00HornmStoEi3Znai3u7GGMbF17WzozwunB
         E1gx58CSJmLDoEYb3fqzdzenYaWHN7E9rYIMNg5XMBawSx4i2vYp+HDcIeJk6WtUVp0l
         UE3w5RPKm4Wsi3yZhwq6D16QNvKzAXE/6xF3FP/ubPzgehmMszrJZ1XF5HavR3P98VeM
         XlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+nxhLmPT6t4AY10TSurP4vTyy21I9tRsQ7s0eYmz7A=;
        b=eohrDRjcjDxfRDtrwcfTHbnVjNkvAwwDgIQNwjppCrHY5LYx+/vdBaAiS1kzNBKhAb
         oG/C5/nORXl4XWEEVAMw6ZiYRbqgBkBfZ7MANnVUG2RS5RLRMygFxhDnvrXYHFuBqDsS
         whOvzMyPWNQK2XNNoJVnaq896k6yzXe1PiyVkXrmgpsVv3yl3o8/5NCUB3RKuc02iKyh
         Iiuy2cAFn4Eh9HbwgC0DgoeU5/WK9dvyyfLRBwuRkfEkVlrx20zvzOpVFy4ryUWNFfRx
         Ui8nHV3toWWUk3tJbU9MMSBoQp5fHacuy67cbHXqlvblBZNog+YiU8SMX6Iw+taNnu5L
         1zJg==
X-Gm-Message-State: AO0yUKWx7qEUvkQgIc/NzOohsTMnBqVzVieEOFKNmC5zCZtV9RarPThF
        r8GfB2nJ/YrNnidxZ4TGyuU=
X-Google-Smtp-Source: AK7set/g2pCFum1SdyPR2iQChO9O6QLQMO/jCsZ359IiOTcRmu1s+3AuulXszCw2ypKWqrevymuTGg==
X-Received: by 2002:a50:8ad4:0:b0:4ac:6ad5:413d with SMTP id k20-20020a508ad4000000b004ac6ad5413dmr3750077edk.15.1676398168652;
        Tue, 14 Feb 2023 10:09:28 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d0d4000000b004acc1374849sm4067140edf.82.2023.02.14.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 10:09:28 -0800 (PST)
Message-ID: <fbc7cb4e-0424-f9c7-aa99-d8d9f7674175@gmail.com>
Date:   Tue, 14 Feb 2023 19:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm: dts: mt7623: disable home key on Bananapi BPI-R2
To:     Frank Wunderlich <frank-w@public-files.de>, arinc9.unal@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230212121354.44590-1-arinc.unal@arinc9.com>
 <C18B89E3-7B54-47B4-98B3-B2D74AB29A54@public-files.de>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <C18B89E3-7B54-47B4-98B3-B2D74AB29A54@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2023 13:33, Frank Wunderlich wrote:
> Am 12. Februar 2023 13:13:54 MEZ schrieb arinc9.unal@gmail.com:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> There's no home key on Bananapi BPI-R2. Disable it.
> 
>>
>> +&mt6323keys {
>> +	home {
>> +		status = "disabled";
>> +	};
>> +};
>>
> 
> Acked-by: Frank Wunderlich <frank-w@public-files.de>
> regards Frank


Applied, thanks!
