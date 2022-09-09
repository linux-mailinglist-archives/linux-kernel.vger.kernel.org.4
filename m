Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D815B3149
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIIIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIIIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:03:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC102B56E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:03:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b35so1370701edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vOjU3Sx50mI6OvFxdnWf2QpE2WMcbB44Sw/sGSm3Ggs=;
        b=y9oMXc7htFjIhrdTkzBqxXB292ExqcFu1Rry7s+rbb/kUUVtIql08WhXyj/kk9rlOW
         0SU4zWTwveJ/vr4bHHroAfN38btJ3Yek4k9HdZmIh9nJXp8wAbjUdYqcL1hm0/PFAw2X
         R3RvSWpAcjm2czIJ9P11RP+nqsMFkMznFT9V1wflxz6kif09bLkUX2s7KKrIqjHEadUt
         44Oa0EYniVnEkWqg4irkkDrfcCE7dqcodVOwMgYS2XbvSeK536o36b2+jVafCES+maPu
         QWQxQawDj/W/7XGXz4ZpLfEFUXt/GKS0EVa7o8y2dDRXvuHU/DyyuiRnSmEkbPzxw2dL
         kgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vOjU3Sx50mI6OvFxdnWf2QpE2WMcbB44Sw/sGSm3Ggs=;
        b=b5wB/LfhNFqOsb1L16dCnYgXOPSSTfwYct03QDQNxVykGikeDfvtytE2sAVtgWDFiq
         7h8+7vsSgL3SR583bDx+pYmvK/ov7RMgRM+2HBA0U/imbf5/my5l5xTOoT8jH6bNhc/7
         JDfOjZQRF8Ng4iVIk1fR7CwAIbn6ArTAWxsU/wDjJs5OX7NGKqOjuqJTU9xd9wcEyBD9
         ERtwh6t5GbIWOdYs/RZ4NXKuz4CxwC8093cM0rI60VoIUO7if/8POPZMckWV9Mv3Exd0
         +zvRY6wSgssAn45bVa/opSRiD2MMzEWnJFEvmEqQeSaxwbOMpaALdKdPuQhZn+SIPWej
         pz0g==
X-Gm-Message-State: ACgBeo1A6gHGanesi1rzEZ8Z9idh2yuUL+KT36sUTlhQhnKuVX1ZjaI1
        GW+KQ063BdqvFfveyh0MR/bTRfgRVVuWVdzND0VVLA==
X-Google-Smtp-Source: AA6agR7v9fHzMpIS7wM/oqxDtpmHL2mM76TddZ9N9fjF4wetaOqzhQM3LdbVLssPFswV6uYvWqtYcZywPY8LWWlwTx4=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr10482056edr.32.1662710582411; Fri, 09
 Sep 2022 01:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220908142134.59068-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220908142134.59068-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Sep 2022 10:02:51 +0200
Message-ID: <CACRpkdYHWSc-kVUdr_YJ-YvMEc-LqrgDj0D62F2WKdA1H5Uvrw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: cy8c95x0: Use 'default' in all
 switch-cases (part 2)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 4:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Move the default values to the 'default' case in the switches.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

>         case CY8C95X0_DRV_PP_SLOW:
>         case CY8C95X0_DRV_HIZ:
>                 return true;
> +       default:
> +               return false;
>         }
> -
> -       return false;
>  }

Clearly this is better style, I wonder if we could teach checkpatch to
look for this? Or cocinelle?

Yours,
Linus Walleij
