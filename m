Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC563DE28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiK3SeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiK3SeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:34:05 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDE24BF9;
        Wed, 30 Nov 2022 10:34:03 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id jr1so3609318qtb.7;
        Wed, 30 Nov 2022 10:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSephSpMMLyS6GN7D/yNJ77wfgPj8H/yF2e6L0lmOsc=;
        b=OHnZ2LOaj4D6fl61/+Rlfit1bTzNY1WXnBkJ7f6jmax27yDYmUS8gFyLaNem4oNaeR
         HGGf0MZypqZ1qQWAHWzwnskPuLttf5BsIVa/mKweuwkt/lSTW3zn1fcGYwrimuY8uQnW
         BNOQPsD6DO1bIs46w6nJksvRaEaGVikwyvLTy5js6nzXRwtODJzH0tR0nR/m9WlC3/l2
         6+InOtYWRqavLF8gyWxSvK0KLfZqJjv7iqs0KAEE+oFFX3kvhy3zrAKLrI9OjHW3Xf5g
         Cl1G/uQvBUt1jVl8rIPVEBEmj453umqjGCfR7CdBUPK0y7S/vZ1uSzFGSjp4zEP3Jix1
         zHYA==
X-Gm-Message-State: ANoB5pmHOBKQQpDX+7BNpRlnQnQuo/x06YoLNHgrojvgXKFX5Zn/f5wD
        ou6wFEK8OR7+eejCBvmGwJ+BAJhBjX18l+/Vfo4=
X-Google-Smtp-Source: AA0mqf4jqExznIzftIUudzBQv83qor16LP4gntamj8CEAmg2OtwLcqcuiwLxBpbfLMQYpJH2mnWCxgRGwH44i5cPT1I=
X-Received: by 2002:ac8:73c4:0:b0:3a5:a53d:a102 with SMTP id
 v4-20020ac873c4000000b003a5a53da102mr58446428qtp.153.1669833242643; Wed, 30
 Nov 2022 10:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20221107105657.19002-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221107105657.19002-1-lukas.bulwahn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:33:51 +0100
Message-ID: <CAJZ5v0jFO=6WLNZUe4vqUXxxWuhZuaq1Sifk7+094YFXUWp2wA@mail.gmail.com>
Subject: Re: [PATCH] notifier: repair slips in kernel-doc comments
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 11:57 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Invoking ./scripts/kernel-doc -none kernel/notifier.c warns:
>
>   kernel/notifier.c:71: warning: Excess function parameter 'returns' description in 'notifier_call_chain'
>   kernel/notifier.c:119: warning: Function parameter or member 'v' not described in 'notifier_call_chain_robust'
>
> These two warning are easy to fix, as they are just due to some minor slips
> that makes the comment not follow kernel-doc's syntactic expectation.
>
> Fix those minor slips in kernel-doc comments for make W=1 happiness.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rafael, please pick this minor non-urgent patch for your pm tree. Thanks.

Applied as 6.2 material, but I'm kind of wondering why you decided to
send this to me.

>
>  kernel/notifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 0d5bd62c480e..ab75637fd904 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -62,7 +62,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
>   *                     value of this parameter is -1.
>   *     @nr_calls:      Records the number of notifications sent. Don't care
>   *                     value of this field is NULL.
> - *     @returns:       notifier_call_chain returns the value returned by the
> + *     Return:         notifier_call_chain returns the value returned by the
>   *                     last notifier function called.
>   */
>  static int notifier_call_chain(struct notifier_block **nl,
> @@ -105,13 +105,13 @@ NOKPROBE_SYMBOL(notifier_call_chain);
>   * @val_up:    Value passed unmodified to the notifier function
>   * @val_down:  Value passed unmodified to the notifier function when recovering
>   *              from an error on @val_up
> - * @v          Pointer passed unmodified to the notifier function
> + * @v:         Pointer passed unmodified to the notifier function
>   *
>   * NOTE:       It is important the @nl chain doesn't change between the two
>   *             invocations of notifier_call_chain() such that we visit the
>   *             exact same notifier callbacks; this rules out any RCU usage.
>   *
> - * Returns:    the return value of the @val_up call.
> + * Return:     the return value of the @val_up call.
>   */
>  static int notifier_call_chain_robust(struct notifier_block **nl,
>                                      unsigned long val_up, unsigned long val_down,
> --
> 2.17.1
>
