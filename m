Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109B05BBC96
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIRIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIRIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:51:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9515FDB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:51:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a3so30172008lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=P4PnGxERGRhEZRIAngKEa+BFGt/GdNcv1e3EYyeDGB8=;
        b=xlD0f96Qrm53Ol1dT6kQZ5QxqrCRhL3Lx+Y0GJIZFr1TQIRVjNDqYm8rhTavxuUDDW
         XejtJXmOrEs3IaBMz/HyK665wIJ21i+RTmdNvp7nObt/k2pzrmQJejIHM9VOmDCrYMhu
         Sd2rsGbw9na3L3T9iuNbS9e01C6eKc591NNYdZhmK5Q85Cqrs7HXcQZrRsEHKGVvqAyu
         gKSBubjzKgbTaUlYWTARKSnAoElvT8dBwMOJOJsIWtO7xGBe07RHany3njkej/jFnvti
         3OkhDvQXpf1ZpX0N5Q5gMCS/ossIYhnTuUA2ga2AYtpYd2gMfgKESdYve8Ef+CUfjeZ1
         cQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P4PnGxERGRhEZRIAngKEa+BFGt/GdNcv1e3EYyeDGB8=;
        b=HID2H0mldS5+zSurv/z4oLqJK2qilNENxMGk9UKh0yNOXphrOToaRdLj6NXhRrJaIQ
         197OiTZxGL8mQz2ZAftzVgPjNQRu0JWI+5hEKiqmdEeSXU/Q+UaqU+nVg8M9D0iYhOmI
         B+fDPC7iKIKvIdLhb+AEHN6BpCOhkep+kJUYvuu53FKm5APQAKkyx0bDJfZDocSNhBjJ
         dUBjEp5MtsdGmKRyi+/XRg6582yDXgBeJ4frdJgLvBKESldmOuihrCW74Po5hfA9fs9s
         jm6LCc2cvfq2NLXlvY3Ei+pgUwD7fHEderzf6K3Aj84gdy4fruWtWPcFoZuLtaxu6pvN
         KCrQ==
X-Gm-Message-State: ACrzQf1HlUWfeOFySbqpM0Py/0LuIvCmKi0HLJ/kb6b4NUvcgDyliK/k
        I4xJFuhe2TMjalXRujVrp+g8/g==
X-Google-Smtp-Source: AMsMyM5Pl0FopM5e7i+mj3lfYZSAOv6dov5ze80Vy40DJn8kQwuRNvxTSSWy/kl29XlFYp+hSUVCmA==
X-Received: by 2002:a19:f80d:0:b0:49b:29a8:db54 with SMTP id a13-20020a19f80d000000b0049b29a8db54mr4115853lff.178.1663491072019;
        Sun, 18 Sep 2022 01:51:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id dt6-20020a0565122a8600b004976809d6a7sm4553134lfb.283.2022.09.18.01.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 01:51:11 -0700 (PDT)
Message-ID: <e89478b5-8495-a846-61ff-917bc4e08490@linaro.org>
Date:   Sun, 18 Sep 2022 09:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: timer: Add QEMU compatible strings
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        mark.rutland@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220916132959.1910374-1-jean-philippe@linaro.org>
 <0acc2a21-27c2-ec85-0335-263d70c24469@linaro.org>
 <87mtaxltwm.wl-maz@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87mtaxltwm.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2022 19:47, Marc Zyngier wrote:
> On Sat, 17 Sep 2022 17:51:20 +0100,
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/09/2022 14:30, Jean-Philippe Brucker wrote:
>>> QEMU uses both "arm,armv8-timer" and "arm,armv7-timer" as compatible
>>> string. Although it is unlikely that any guest relies on this, we can't
>>> be certain of that. Therefore, add these to the schema. Clean up the
>>> compatible list a little while at it.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> I guess you wanted to say QEMU uses "arm,armv8-timer" followed by
>> "arm,armv7-timer", because otherwise I would understand it that either
>> that or that. Anyway, is it a valid (virtualized) hardware? Is ARMv8
>> timer really, really compatible with ARMv7 one?
> 
> Yes. There isn't a shred of difference between the two in the earlier
> revisions of the ARMv8 architecture, and none of the differences
> introduced in later revisions are exposed to DT anyway.
> 
>> I don't think we should document invalid setups out-of-tree, just
>> because they are there, and something like this was also expressed by Rob:
>> https://lore.kernel.org/all/20220518163255.GE3302100-robh@kernel.org/
> 
> This is, on the contrary, something that is perfectly valid. For
> example, a system running a 32bit OS on a 64bit system is perfectly
> entitled to expose both (v8 because that's what the HW is, v7 because
> that's what the OS is the most likely to understand).
> 
> You may find it odd, but that:
> 
> - expresses something that is actually required
> 
> - is what I, as the original author of this binding, have always
>   considered valid
> 
> - has been valid for a long time (10+ years) before you decided it
>   suddenly wasn't
> 
> I understand that the "DT police" has high standards, but this has
> been around for much longer, and it isn't because the conversion to
> schema is imperfect that you can rewrite history.
> 
> As for the patch, I'd remove the QEMU reference and the deprecation.
> This format is perfectly allowed, and is in use in most VMMs out
> there. Yes, DT is an ABI.

Thanks for the explanation, actually enough was to say that it is
perfectly valid combination describing hardware. :)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
