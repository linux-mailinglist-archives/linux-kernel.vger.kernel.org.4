Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8D63FE05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiLBCOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLBCOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:14:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E488B392;
        Thu,  1 Dec 2022 18:14:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id k79so3616531pfd.7;
        Thu, 01 Dec 2022 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNVoFsm0p2fmF+8XIvCyUUB0uikNlFRO7bl1K7LYxsY=;
        b=EjXyetsIzJRIHvrJOub61wyRzOouXl+GPsP+Cnagu+T+FFqE0vn5Zx7VFx2oAiFYdH
         mCjw+v23+XVU+vi4oBlsfH34JCdgq3nevhoaSs9hllsACh1GlDyvDhROawwyQ3sDSFZe
         b9xyfXKoQ3+0q6eRqENvAncZaAlBuHJGqwf39Z9qR0bsVT5Y4vdwayOaNmEqQ18gGau0
         kCk+wBr0aB+4cKu2RdNRbZAKLezJZ5EFiXZ7O/eoxsXCGB1f5+nUEAEMiIMbZ//4zTfd
         J2Cq8YQS0i6AKYDAJkaM4PvGnKuhDza2gcrFsp+4NJIrso0Ec3DUw/bhzJs7Pf7RuyVb
         Ftcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNVoFsm0p2fmF+8XIvCyUUB0uikNlFRO7bl1K7LYxsY=;
        b=crguBHc1NGFyB51WZi530xi9+P52Ct6ZcfkSLWFQt0vRvLVSS8l8fyOqhafENUAqFC
         dXarRvlpj4PgjOW6S7DhNCtshCeG783WzrqbgpBARix1tuZQ5E01IJ2tT9vpX+S84lda
         l40SLrJQGyuiBzik0eiS9SNzRZw9Cs9x1pYURQPdNGPu89/iQZK6P+aLV0+yQ1Fm3JXG
         ryaGP3EacanvsxxItsSQGBPRwcWBybkjVpoXgO3LD1uM246fZtpDxAWlE/g9PiIJVjgp
         Z0aY3eLTdQaS0Z1XU56/aFk+uGMnfYijNSzG+Z6uSgfgxqSRw4FmIe2ExSDwDCC+vt3w
         Kn4Q==
X-Gm-Message-State: ANoB5pmhprhv6Jj7KyNMsD36K7ntzxW4rSxuC9SATGLTKbkNbvc/Ypo1
        PUbpIjtzbIe97TASAMYnfhk=
X-Google-Smtp-Source: AA0mqf6gz6A13yBGX1W5VBbvMdl3XinEw0aSx1UfmvWSa8VCPJeNADCW+6HFko9k7cS44X/8S1hbTA==
X-Received: by 2002:a05:6a02:108:b0:46b:3acb:77ab with SMTP id bg8-20020a056a02010800b0046b3acb77abmr42945327pgb.359.1669947254276;
        Thu, 01 Dec 2022 18:14:14 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0057507bbd704sm3911674pfl.5.2022.12.01.18.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 18:14:13 -0800 (PST)
Message-ID: <66b3fd78-31bc-c435-ccc8-c8682b3cacee@gmail.com>
Date:   Fri, 2 Dec 2022 09:14:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 3/3] Documentation: riscv: add a section about ISA
 string ordering in /proc/cpuinfo
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-4-conor@kernel.org> <Y4gZ/KZz9rdYj/0r@debian.me>
 <Y4hjIWHTuYcf90ja@wendy>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y4hjIWHTuYcf90ja@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 15:17, Conor Dooley wrote:
> On Thu, Dec 01, 2022 at 10:05:32AM +0700, Bagas Sanjaya wrote:
>> On Wed, Nov 30, 2022 at 11:41:26PM +0000, Conor Dooley wrote:
>>> +#. Single-letter extensions come first, in "canonical order", so
>>> +   "IMAFDQLCBKJTPVH".
>>
>> "..., that is ... ."
> 
> Hmm, that reads strangely to me. s/that/which/.
> 

OK.

>>
>>> +#. The first letter following the 'Z' conventionally indicates the most
>>> +   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
>>> +   If multiple 'Z' extensions are named, they should be ordered first by
>>> +   category, then alphabetically within a category.
>>> +
>>
>> Did you mean "most closely related alphabetical extension category in
>> canonical order"?
> 
> I am not 100% sure what you are suggesting a replacement of here. I
> think I may reword this as:
>   For additional standard extensions, the first letter following the 'Z'
>   conventionally indicates the most closely related alphabetical
>   extension category. If multiple 'Z' extensions are named, they will
>   be ordered first by category, in canonical order as listed above, then
>   alphabetically within a category.
> 

That LGTM.

>>> +An example string following the order is:
>>> +   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
>>> +
>>  
>> IMO literal code block should be better fit for the example above,
>> rather than definition list:
> 
> Uh, sure? I'm not sure what impact that has on the output, but I can
> switch to a pre-formatted block.
> 

Something like ``foo``?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

