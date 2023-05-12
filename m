Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD4700E20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbjELRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjELRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:52:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B226E89;
        Fri, 12 May 2023 10:52:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so15202879a12.3;
        Fri, 12 May 2023 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683913972; x=1686505972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z5HbnsTK18J0+qXZRdJVRc1SE6gpbbfgXJ/tjWlB7U=;
        b=jty0sa+qiVBl5OBRqSGPyQX8XtvTrVX31/CTJT9G4H0dNADmEd5XBqiBBuxfxwOj07
         CF/WDXpxQNfxWFAzSRhgJ0uQzAH6n4Irku64TGg4IxGZaF3oVKH1vKpiX2O1vsTTbA5j
         m/qme+Cjx9V1rG4QChsvbYG5dU6Kq/+3RU6Lmrmq270b+cwrhQxuqW1HqCmSOLhlrerJ
         wonZ59RTM2uHZtGjZ7pJowG0bvX9qY9Wp8e8jpESXBZCbTLuCB8KNdoBT/fWHFau1u9z
         40FKpOmu68z3/iRKQojCEodN/17NHG3psyJDu37MYCZb9onfdQM9A1UrxsIID7+PpxHU
         eq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683913972; x=1686505972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z5HbnsTK18J0+qXZRdJVRc1SE6gpbbfgXJ/tjWlB7U=;
        b=QMd9tNFzYZkYLpVW9EaYGNmQ9hOMMVpd8pKJ8k8jD+0LmsvSHfGX4vcrFlFVjFlTwf
         KQKwq2tMIAf29dQa/HsLM0whApXKPG3lDzPgxTeI7cwmQABsNPU5a5+SiZr/tL0a6CE4
         l+J9ws2uLnmRXNc+cTT4Zhe89Pd2BpcsBgPP1nmS7SI7WAHx1N4Lywx0+odsw/Uu3gxn
         mazgU+AeuNWIf7cGm2fR5i5BH7s3cQcGfAUcMotWTDGke2OiLgGjxl93ag+HGuzhogH1
         U9kWf9iQ3+moX/E9/PKb7q/LRngz76JkcHAYtS9Et/F1PJbC9CvwgL5fIglCVM4da8ab
         e8EA==
X-Gm-Message-State: AC+VfDyVj16XQEkP1Jl3ZpAqfX84YaQzydwPUm/q2LRaFWolkJcA6PJR
        5/ao8xVd9+DwOe88TwFl+Zg=
X-Google-Smtp-Source: ACHHUZ56Nh7GwRsgEU7BrtcKNxP6mA30n2Lp1bDbFoN+fPJbMW2/FQ70ahtIiWVgDXjjaIwqqpCnZQ==
X-Received: by 2002:a17:907:1b17:b0:94f:432f:243e with SMTP id mp23-20020a1709071b1700b0094f432f243emr22067959ejc.14.1683913971874;
        Fri, 12 May 2023 10:52:51 -0700 (PDT)
Received: from [192.168.8.101] (37-48-17-149.nat.epc.tmcz.cz. [37.48.17.149])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906379900b00965c529f103sm5575504ejc.86.2023.05.12.10.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 10:52:51 -0700 (PDT)
Message-ID: <8c7dcc39-d7c9-d81e-a7af-5cbf055082c7@gmail.com>
Date:   Fri, 12 May 2023 19:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, luto@kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@suse.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-12-chang.seok.bae@intel.com>
 <ZFWY6/VelArVYy1F@gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <ZFWY6/VelArVYy1F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 02:01, Eric Biggers wrote:
...
> This does not correctly describe what is going on.  Actually, this patchset
> registers the AES-KL XTS algorithm with the usual name "xts(aes)".  So, it can
> potentially be used by any AES-XTS user.  It seems that you're actually relying
> on the algorithm priorities to prioritize AES-NI, as you've assigned priority
> 200 to AES-KL, whereas AES-NI has priority 401.  Is that what you intend, and if
> so can you please update your explanation to properly explain this?
> 
> The alternative would be to use a unique algorithm name, such as
> "keylocker-xts(aes)".  I'm not sure that would be better, given that the
> algorithms are compatible.  However, that actually would seem to match the
> explanation you gave more closely, so perhaps that's what you actually intended?

Sorry to be late in-game, but as this is intended for LUKS/dm-crypt use,
I have a comment here:

LUKS2 will no longer support algorithms with the dash in the name for dm-crypt
(iow "aes-generic" or something like that will no longer work, and I am afraid
you will need aes-kl/keylocker-xts here to force to use AES-KL for dm-crypt).

One reason is described in https://gitlab.com/cryptsetup/cryptsetup/-/issues/809,
but the major problem is that cryptsetup used CIPHER-MODE-IV syntax (that mixes
badly with the dash in algorithm names). And we still rely on internal conversions
of common modes to that syntax (currently it worked only by a luck).

When I added the "capi" format for dm-crypt for algorithms specification,
I made a mistake in that it allows everything, including crypto driver
platform-specific names.
The intention was to keep the kernel to decide which crypto driver will be used.
So, this is perhaps fine for dm-crypt now but LUKS is a portable format, and a generic
algorithm (like AES) should not depend on a specific driver or CPU feature.

IOW, implement xts(aes) and let the user prioritize the driver (no changes
needed for LUKS header then, AES-KL is loaded automatically) or/and create a wrapper
(similar to paes, that we already support) that will force to use AES-KL
(...but without the dash in the name, please :)

If there is a problem with it, please create an issue for cryptsetup upstream
to discuss it there (before the kernel part is merged!), so we can find some
solution - I would like to avoid incompatibilities later.

Thanks,
Milan
