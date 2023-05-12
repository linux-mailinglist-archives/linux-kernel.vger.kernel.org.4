Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA17006CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbjELL2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbjELL2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:28:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D264205
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:28:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so88404633a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683890911; x=1686482911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51x210IeXgIkFfP24z5JthBwRgvFz0wV1+RFmFkz5QM=;
        b=igjSUaU8ToJ9GnIPFo9cxQNaCG4ULiOkiWJb5QAfTNb6vbudvDKADv+BgpGJVM1mCS
         ukoiBV3Tw8dB3vPYFudCquL4Sa3rE7wg8z9pb+/IQmVe3lgLO2Srm+TP3DlxUUNcgQC0
         jEwkNpjU7ZgsPJ9/w4w0bZZ6we9IDFXFWMjr90Z2EC4V4KkPh9OYss70d/I9zd/i4iCZ
         G6dv9y/Q2M2RHBARNOy7hlWa9bUPWi0r7ia+WlYwDax45MicIwMKibXrk6e3AEdclpzm
         qAfxPLeipp+dF94P0+p3YCscKaJIVfGxRErvv1f52+KFGImpkQo3GlJWl8Gj7KeA2Rj4
         +0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890911; x=1686482911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51x210IeXgIkFfP24z5JthBwRgvFz0wV1+RFmFkz5QM=;
        b=jrUxMd23EaEX2t/tCjtdVGaMwC8ilrx8vMm2HSEUSlQcOcLk1oTu7lR/UxRo2OTTR/
         kvRJ4b9CNYKXkkREZz7EtHk2GMzK3PRPn8iQBgZ/l8xZUf0PEsazoWbzL/9MtVBS8WRH
         hDeg5kjIv83j9Uy2yJv1hiTNzPHpq9FerV06j2LEJaSH/glgeiraq5UDlSLZPzmUAJp3
         HIHhMpgPz+vyvYy5KILf4b8xEZwh1Hhqk5YcHlpcdwStLB1RbXdiXwUhZasyoCKefTCG
         pqMfK+UGmJ2dSa7iZkJJf+hEP9HScLVTbFaAoJjVMsvupt/dv+hfLunYauDNmJqHaNoo
         FaCg==
X-Gm-Message-State: AC+VfDz7tMhgTTQy7dzDkwQVj1alent56CzadrXc+9ZTa7eOl4/5VF+D
        +9GINgVT2S9h2kQfMlYrXng=
X-Google-Smtp-Source: ACHHUZ5C8bgyXMgFuSG2nqHT8Zh35cACaSO0yH1uIKnP8ffae3HxnHJRhwt3CfWo2U/sd625o7Uyxg==
X-Received: by 2002:a17:907:720b:b0:94e:ec0f:5f70 with SMTP id dr11-20020a170907720b00b0094eec0f5f70mr23858934ejc.10.1683890911056;
        Fri, 12 May 2023 04:28:31 -0700 (PDT)
Received: from localhost (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id bz1-20020a1709070aa100b00969e316d8dbsm5012491ejc.225.2023.05.12.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:28:30 -0700 (PDT)
Date:   Fri, 12 May 2023 13:28:27 +0200
From:   Jakob Koschel <jkl820.git@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] w1: Replace usage of found with dedicated list
 iterator variable
Message-ID: <jx7ffvrmukyonpbg2fy3u2xlfesgezolmjvny4rbvrfqdu7fcz@fvex3hhpuz25>
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
 <c626e464-64e2-3cdb-7cf3-c76770feb1f0@linaro.org>
 <xxs6zv5j7s6zmko5b5idhynzotx4nnyjktj35sdvelr6ha4aeh@w52ylfmwguva>
 <12a57688-6e9a-a21d-41cb-978a274c8b2b@kernel.org>
 <kxms6scr4unumfbj4ru4t5khxvx3654vucjgczwf7rgxgvmjo6@hvvd4rqioius>
 <bba885a3-0969-92f7-ee5b-eeaca4e40b3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba885a3-0969-92f7-ee5b-eeaca4e40b3e@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/12 01:23PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 13:17, Jakob Koschel wrote:
> > On 23/05/12 12:26PM, Krzysztof Kozlowski wrote:
> >> On 12/05/2023 12:19, Jakob Koschel wrote:
> >>> How strange, I just checked and my checkpatch doesn't complain.
> >>>
> >>> I also redownloaded and double checked 
> >>> (b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com).
> >>>
> >>> What's the exact issue you are seeing?
> >>
> >>   ✓ [PATCH v2] w1: Replace usage of found with dedicated list iterator
> >> variable
> >>     + Link:
> >> https://lore.kernel.org/r/20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
> >>     + Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>   ---
> >>   ✗ No key: ed25519/jkl820.git@gmail.com
> >>   ✓ Signed: DKIM/gmail.com
> >> ---
> >> Total patches: 1
> >> ---
> >>  Base: using specified base-commit eeac8ede17557680855031c6f305ece2378af326
> >> Applying: w1: Replace usage of found with dedicated list iterator variable
> >> [Checking commit]  12b61e664c29 w1: Replace usage of found with
> >> dedicated list iterator variable
> >> [Checkpatch]
> >> CHECK: Alignment should match open parenthesis
> >> #70: FILE: drivers/w1/w1.c:849:
> >> +			if (iter->reg_num.family == id->family &&
> >> +					iter->reg_num.id == id->id &&
> > 
> > I tried a bunch of things but I can't see this message. I tried with 'checkpatch.pl' from different kernel commits.
> > 
> > I did:
> > 
> >   b4 am 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com
> >   scripts/checkpatch.pl ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx
> > 
> > and always get:
> > 
> >   total: 0 errors, 0 warnings, 64 lines checked
> > 
> >   ./v2_20230510_jkl820_git_w1_replace_usage_of_found_with_dedicated_list_iterator_variable.mbx has no obvious style problems and is ready for submission.
> > 
> 
> First - the missing indentation is visible with bare eyes, you can also
> fix it without checking in checkpatch.

Ah the original code was already wrong and I just kept that way.
Since I'm not frequently contributing and didn't have an error to work with I also didn't know what the correct
way should be.

> 
> It seems you are not running checkpatch with --strict. If you want to
> see the exact error - run with strict.

Thanks, I wasn't aware there is a strict version I should be using.
Good to know for the future.

Not that I can reproduce, I'll fix and send send v3. Sorry about the mess.

> 
> Best regards,
> Krzysztof
> 
