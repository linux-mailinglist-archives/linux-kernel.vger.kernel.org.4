Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588786C7817
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCXGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCXGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:43:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8154EC6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:43:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so3936646edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679640222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgbEes8ceG/tgVaAXlVTgP+CsmCv+C77+gH5pG0psKU=;
        b=IVLY4ihYnrndXdYOkJDh+BcgYmhsm8NV81lXqqFK+2D/qIjD5oSO8COFkDO9Rp2NET
         NxrQe0JWjOWFPByQZyryFugPTiR4WfnkaNb5+ttulTNUah5C6TCRUCH2FgdtQLi3ITyV
         N6YrR9CDjxNZeQ5Upg5GRGMxUJetIzygEWo96dQuZRhO60P9ZyfGK16JI4gxclMn4SUZ
         8fByWAWY7OaLJ9yT8krVUlNIezGuPzdr1JyDSLzizOwfrW8VpV/ovNo9so1mvBw+qvU8
         6D6kjOZkGxZ+TWn4+501ubpVbYtzhby9PweeDFgS466GU5yIF4pmls7aBJROCyRqzRAU
         4CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgbEes8ceG/tgVaAXlVTgP+CsmCv+C77+gH5pG0psKU=;
        b=UWy60C8Unr0V6JHEoS1vTLiyTx1nRakJkE2hjH7dhdY2djbMi/ECLCXzakWi03genH
         PArpud46JXEGP7u98hVj+v6KXk7YB2cX66XDZpGphtu/LuF9qGAy/5cfEGEB53u3ENPs
         X1LBB3GtGfq1qrL8T179iI7Rek9swH9cvjhw1+02TYpDvdgu84FiWlsQ6TC6CEmIK4Dc
         EpEbo+dmXP9tATlasjWQdA1AihdmDmfS0oQFu4j9Xd1655JqtPoUK/ajSBxcFR3tqLQ/
         4oQQNGrqdqkHdwBZts6wqiXcDDZ3f/B5I4CWNjM45JbwI2a8VWk91GwNpO9gPEwtymW7
         YO4A==
X-Gm-Message-State: AAQBX9eohgQEO8nzTyQfH1beu8IHtHC4tNZswjLWHvD1CJbIT0Rg1cX2
        4EybXazQOB5zWEWhhSHnnz/ebQ==
X-Google-Smtp-Source: AKy350bupkWhK9wHoFfP9guobvfEexGlu6Qt6let3DJABjnFlfznwyic3HUOKnPkz25A7qQOzT8sEg==
X-Received: by 2002:a17:906:507:b0:907:9bda:93b9 with SMTP id j7-20020a170906050700b009079bda93b9mr1549066eja.17.1679640222055;
        Thu, 23 Mar 2023 23:43:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bu6-20020a170906a14600b00933c52c2a0esm7236006ejb.173.2023.03.23.23.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:43:41 -0700 (PDT)
Message-ID: <4b448582-fe11-7f24-36ac-16fd8a22c139@linaro.org>
Date:   Fri, 24 Mar 2023 06:43:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, johan+linaro@kernel.org,
        steev@kali.org, dmitry.baryshkov@linaro.org
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <5dc11c47-bae6-2f4e-4ffd-58c4f462fd68@linux.intel.com>
 <101cfc2d-59d7-4f37-9dd1-e83d1b803bc5@sirena.org.uk>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <101cfc2d-59d7-4f37-9dd1-e83d1b803bc5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 24/03/2023 00:14, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 01:11:11PM -0500, Pierre-Louis Bossart wrote:
> 
>>> The trigger is run in atomic context, can you really write safely to a
>>> SoundWire device there?
> 
>> Mark, I've seen that comment from you several times, and I wonder if I
>> am missing something: the triggers for SoundWire managers and dailinks
>> are typically nonatomic - at least for the Cadence-based solution the
>> trigger is based on a bank switch that may happen with a delay and with
>> a wait_for_completion(). Sending a command over the SoundWire channel is
>> also typically not atomic, there's usually a wait_for_completion() as well.
> 
> Ah, you're setting the nonatomic flag on your links to disable the
> locking.  The default for trigger operations is to run them with local
> interrupts disabled.  It looks like at least some of the Qualcomm stuff
> does that too.
Yes, by default dailinks are marked as nonatomic in Qualcomm case aswell.

--srini
