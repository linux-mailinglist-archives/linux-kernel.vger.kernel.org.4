Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47C6E4E54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDQQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:32:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4414499
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:32:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id xi5so65735905ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681749129; x=1684341129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpFVYtTRNaJ3hUkohTzL2uWr++x541bc2WUeCeSxjGE=;
        b=ZO65Wjqwt0P8XwsXHifnlmbknF+qdC6A0K1+bIsVY9QAHcdiTxTHUDoryPZxopGKOw
         lj4kqZyM6/n+GcpZhq+7yQ0s3awiUTIgpDaIqce43F2s65MmJ2TXjlPa7mbWfVJH42m1
         v4hNa11+hnjBjVGleDCWFRjjkKP2tiQtszLbHgVxE32uu5ORrrlWvUih2l/FfXH52s/I
         9rXILvHrA+tVBFkRKSrxIepQHg4Ii6wnqwkWRA0z0TBBSomY8O9tmfTw03+uM0t8sECs
         uBHF6Xw19E+p92RyaQDTzwLL41Xif8mSDEGxNRg9tUMuySfFPW6dLdg3z2mIdhCxGxOq
         16Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681749129; x=1684341129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpFVYtTRNaJ3hUkohTzL2uWr++x541bc2WUeCeSxjGE=;
        b=PLZWEE19z48QU6FFEvM+wH3LdV6OY4kX6/uuXD0PAs+7ddXAy4FFuXpyozKCJwQ350
         qX3295ucq0pO88wT3QvWDB+mCE2aDo02jM2r24k/8aBVXqV5SVZuKkUSmv8mSIo11fMW
         GKrcaAayUVvN1jeUbdTxG42SdvAthRXxjR4wkctk6VNs24wGxotDeqMUghbW1tYAbF4K
         4MjJ9fTdV4Qv3cUBRngJW9JqOXfRyhRzg6tkjaz8kg2uFMz7OsmU6Yc9v6ghXilZSSQ4
         gtnTFwkdaGVfyQ1ww33V1eH3KoyPTMfB2o/VoWOtahQd+9gqy41bdfUxruzmmDXYDvwp
         MJCA==
X-Gm-Message-State: AAQBX9cjBSdyE6zhdpqku7bfpeP+1lDQFxcX6MUN2Eh/Ok1/wBzlNrGL
        Bm/6rNfprN65GEz8D7Rzbe+CKvhYpBsu/agkQvUseg==
X-Google-Smtp-Source: AKy350YvsFWxlCwppQ/PTXS5dMMOM0LNnVhEBSs5u+zcG+wnR3E2Jz1MM2JXHCUsR9zpodQF6dPd6Q==
X-Received: by 2002:a17:906:670f:b0:94f:6c7:18ca with SMTP id a15-20020a170906670f00b0094f06c718camr6922332ejp.28.1681749129479;
        Mon, 17 Apr 2023 09:32:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id ta15-20020a1709078c0f00b0094fa472a7c4sm831351ejc.161.2023.04.17.09.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 09:32:09 -0700 (PDT)
Message-ID: <1cc83bad-55c2-46b5-ad70-cac160b842c1@linaro.org>
Date:   Mon, 17 Apr 2023 18:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
 <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
 <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 18:27, Mark Brown wrote:
> On Mon, Apr 17, 2023 at 06:00:59PM +0200, Krzysztof Kozlowski wrote:
>> On 17/04/2023 17:58, Mark Brown wrote:
> 
>>> You've replaced an unconditional dev_err() with dev_err_probe().
> 
>> Which is the core of this change... so what is here surprising? Yes,
>> that's functional change and I never wrote that dev_err_probe is equal
>> dev_err. It is similar but offers benefits and one difference - does not
>> print DEFER. Which is in general exactly what we want.
> 
> This may well be what you intended to do but it's not what the commit
> message says that the change is doing, unlike patch 1 this isn't an open
> coded dev_err_probe() that's being replaced.

But my patch 1 (and my other patches some time ago for wsa speakers)
does exactly the same as this one here in few other places - introduces
better message printing of EPROBE_DEFER. Only in one place it is equivalent.

If you prefer, I can mention the message/EPROBE_DEFER difference in
commit msgs.

Best regards,
Krzysztof

