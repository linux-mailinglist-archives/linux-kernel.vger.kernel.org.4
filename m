Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2176B6FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCMHOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCMHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:14:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BD34C12;
        Mon, 13 Mar 2023 00:14:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h9so11556796ljq.2;
        Mon, 13 Mar 2023 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678691647;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAcFtKYc9siQS5A9dmQhcxRKsW53bmsCdA8lYrf/LRQ=;
        b=A9p+3Rj/SXsVX4aggaFlxvVDjDrz8CllxRoRT8UUjj5VOgWmiE8lGIUNoWf4eL70HP
         v19HVP6G6S2wu7PSg7qJD13y7aY+SrWdQMbpXVNPSeICyW6WkKN3aYawtFThjwg4Il52
         kpNdO6bA9jfq29cfOvP/S9CVnjgqNUctkGCDUI/GO0Asa42hLB0PC4KX3GXRKDFmcBAa
         TEsditN2wl4v1Jr3D/9mVFglJHgc0UtLEON9z5nWwvVjstbPM+hj9H+oddRm3EXLNSRF
         b3qPQsOuTKc2cYBWD3aNK2q9cyJs6faHq01pto0Z8920Hj0vq2QQz5N5OdzqABD+4enw
         FCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678691647;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAcFtKYc9siQS5A9dmQhcxRKsW53bmsCdA8lYrf/LRQ=;
        b=me6o+2ah4CMShNDYXR7GF776QBJGmKs6rSuk/fddAFhTQtCLBk4M8NlF/rsy4ArD3C
         0JNqx3Lj8HhexTiPBShHaofLNEQwjb6oNRfv/trQt8zLzey+gSsHqzw5hhW8ICv+SJSu
         w32y7RPmpTFQD9GAih614fazCL+eoaeubhhqmGwcF+w7aoi5ikehdHPKw30n6jhcM5N3
         GlSHbcBg8+mxs2sBGIW5ydB/EmIQpFhA+vMgNHe/ZKr+9T1RBT38i79+JXVYgUrmwWO7
         SQ6NDCa9JnXlRpM41ThkuW0cxbGcBE2s4//nDL3l8hyyNYf0ewGeECRcCEjcbPjZPhbR
         E8Rw==
X-Gm-Message-State: AO0yUKWHboiBxsYyT1HDaWGZexyvvVC2neRO9j0HqoEAdAB/SLSzEl0S
        sAjXvxSKH9zRTHvbVmgXy98=
X-Google-Smtp-Source: AK7set9v2UPU9b2G4if8z3XNz+Jt/KSUwjPPiVjsjpUoRP85qztXl+UPUnam/vqe2fcwEIaXaLH/SQ==
X-Received: by 2002:a2e:b8cb:0:b0:298:592e:113a with SMTP id s11-20020a2eb8cb000000b00298592e113amr9597537ljp.6.1678691646808;
        Mon, 13 Mar 2023 00:14:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id u1-20020a2eb801000000b00295965f7495sm906020ljo.0.2023.03.13.00.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:14:06 -0700 (PDT)
Message-ID: <a43c984f-2471-334b-094b-d51c77dea783@gmail.com>
Date:   Mon, 13 Mar 2023 09:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-4-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv1 03/11] power: supply: generic-adc-battery: convert to
 managed resources
In-Reply-To: <20230309225041.477440-4-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, All

To me this does look like a great simplification :)

On 3/10/23 00:50, Sebastian Reichel wrote:
> Convert driver to use managed resources to simplify driver code.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

