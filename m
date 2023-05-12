Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E181700683
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbjELLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjELLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:17:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38563C03
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:17:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so17932677a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683890253; x=1686482253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=la+fU2HN57fy5NqcmBRrWOV92Qmjel405DCY2wpFx28=;
        b=E+18OA3F+sv+u28eqJ5RrjkD0H3Ljp+M2m9qfcbcowLCGM1xQcgkPS7xUL1g3ah+LE
         lqopUC/1xyz8DTNv3zz88w3SZ6AZ0ASub/D2dO3asfCKKwsLIaB7cg0FhcqpXRHRxj1u
         02o18DTcoBRAsKjU8trfwgk8jKFXk7Yplq+w53Gu+Iq6UMo84vRGKVku3cQFfXStO5cW
         jx6MSX1GBRj02wWpZDC7D4kKxZoFH5W2Drwotv+3D2Tpe4UDtLg2fj+4XYDrns0pHnlH
         awyuGd5z85YL2P7bowHAPnd54Iubu+xm2MYwBdXnHr1n1BA5BafEVI0TeXE0hZO/kMbS
         aeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890253; x=1686482253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la+fU2HN57fy5NqcmBRrWOV92Qmjel405DCY2wpFx28=;
        b=h7le0w0HvJpVulUmlpJmhJu16vCdsFRJOqdA6cAssVfpDEsxxHbbpxHhOhqDFbQB9S
         9lbi5auOtqEgl9MM0NrfFYLQ27/MmQMldGH/IC1ruo6m9YtT1/vI12vgOvFlYyTnYsOQ
         4XOTYcPMQJtd1+wmNyInOCcx0rfuUhXojDcO97DjUD6I1EzITHCVBiW8bFrGknBKxe3A
         yefDBMvjjIAVcF+AOQHUjP29yS6VtXQeKogavtVuGyCf/mAopf50Aj4WC0T5a3co+8Un
         AleJkQYfkL6pulG9HgfPpXLfrucftdYVWce8YYNgAVAl/dyLm7Mv2JYqaqiZ3fvRg8G1
         Oa+Q==
X-Gm-Message-State: AC+VfDxzNgrdmtwz/59yUGCfQ1nI/I80KjrODnHK/ctLnUKiUGM99vnY
        Z/nuEYnkXkJgfABMr+HidoE=
X-Google-Smtp-Source: ACHHUZ6bLdDzkZAVBYeA6MEFOCmKTdw1OkPrN5E6YazdHNkS5hzuhb9xlav5E97kN7Wn8CSMVZg79Q==
X-Received: by 2002:a17:907:3e05:b0:94e:988d:acc5 with SMTP id hp5-20020a1709073e0500b0094e988dacc5mr23002155ejc.46.1683890252936;
        Fri, 12 May 2023 04:17:32 -0700 (PDT)
Received: from localhost (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id my11-20020a1709065a4b00b0096650f46004sm5262342ejc.56.2023.05.12.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:17:32 -0700 (PDT)
Date:   Fri, 12 May 2023 13:17:29 +0200
From:   Jakob Koschel <jkl820.git@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
Message-ID: <kxms6scr4unumfbj4ru4t5khxvx3654vucjgczwf7rgxgvmjo6@hvvd4rqioius>
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
 <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
 <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
 <12a57688-6e9a-a21d-41cb-978a274c8b2b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12a57688-6e9a-a21d-41cb-978a274c8b2b@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/12 12:26PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 12:19, Jakob Koschel wrote:
> > How strange, I just checked and my checkpatch doesn't complain.
> > 
> > I also redownloaded and double checked 
> > (b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com).
> > 
> > What's the exact issue you are seeing?
> 
>   ✓ [PATCH v2] w1: Replace usage of found with dedicated list iterator
> variable
>     + Link:
> https://lore.kernel.org/r/20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
>     + Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>   ---
>   ✗ No key: ed25519/jkl820.git@gmail.com
>   ✓ Signed: DKIM/gmail.com
> ---
> Total patches: 1
> ---
>  Base: using specified base-commit eeac8ede17557680855031c6f305ece2378af326
> Applying: w1: Replace usage of found with dedicated list iterator variable
> [Checking commit]  12b61e664c29 w1: Replace usage of found with
> dedicated list iterator variable
> [Checkpatch]
> CHECK: Alignment should match open parenthesis
> #70: FILE: drivers/w1/w1.c:849:
> +			if (iter->reg_num.family == id->family &&
> +					iter->reg_num.id == id->id &&

I tried a bunch of things but I can't see this message. I tried with 'checkpatch.pl' from different kernel commits.

I did:

  b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
  scripts/checkpatch.pl ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx

and always get:

  total: 0 errors, 0 warnings, 64 lines checked

  ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx has no obvious style problems and is ready for submission.

I'm out of ideas...

> 
> 
> 
> Best regards,
> Krzysztof
> 
