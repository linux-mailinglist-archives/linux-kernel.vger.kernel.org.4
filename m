Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D772ECB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFMUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjFMUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:14:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94D1FF7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:14:15 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33d269dd56bso24799115ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686687255; x=1689279255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2QzvMaxKKcXVD0qMozXzcoNIIgE7sdAc8D96PpXuL8=;
        b=A1oOUnb4Olu5IMH7QupMQr44H69GW1JbpCg6vAg6/5voEOTibVudmKbpbcRwDgVKBd
         ETQcO9f1TWa6aUB3EWheAqWj+yYpyooZ652JUSAdxLb/Im84trswNa/48KhkiS1M7dDQ
         62yBkL3XXqy5HO+i1ROTFNuIWve7YorRAq9Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687255; x=1689279255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2QzvMaxKKcXVD0qMozXzcoNIIgE7sdAc8D96PpXuL8=;
        b=IbxfyG2nuhiBEw39/pkBxtAB9nXppY78ZstR1pQ/BvjXwHx836ygxwYqrcgmuF4xgh
         0oIaqrN/YUJwuAy/KpTrxdute/gPwbA2lyFTYmYXJ8X+yXySVrutqlUsZPhzmNk0nB/q
         lTMx87sTTXsa9qTrISoCjqTBkXFh4Z6eoxFAjbZu8CJaw1YfiXXnT3yQk+58mC041jXd
         k6yAZcATSTIDWAKujAmf1k5IT+qqKcFCUQrkS8p1kTnHuvYG/GaFyn7s1c6DpqEYny82
         05YalBN/Jl/j0xqwBVtTl3lgwdzPBJdlqAMTKjdCs12zGDcdw53i/dm+53QXVGYRC14j
         ux9w==
X-Gm-Message-State: AC+VfDwb0/ydxXZBtUYbgjramxSpkaK9FlADdgbg3qR1aa8gkM8fjz7t
        08VG0eQHgiluFejkrMRH8yEr3w==
X-Google-Smtp-Source: ACHHUZ4ahJNRFNCmtrxHJKk+YC64/R4UaTsuTYVQbGmdUyDw9dTXU/Qo5UjMe4YkkE1Daa+LPJKN3Q==
X-Received: by 2002:a92:d9cb:0:b0:33e:70b6:bf55 with SMTP id n11-20020a92d9cb000000b0033e70b6bf55mr11007662ilq.0.1686687255354;
        Tue, 13 Jun 2023 13:14:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:af6b:efdd:3bb1:3d27])
        by smtp.gmail.com with ESMTPSA id e6-20020a656886000000b00543ad78e3bdsm8870408pgt.16.2023.06.13.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:14:14 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:14:12 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: dt-bindings: pwm-regulator: Add missing type
 for "pwm-dutycycle-unit"
Message-ID: <ZIjOFE9JvfLFJ6FB@google.com>
References: <20230613200956.2822740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613200956.2822740-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:09:56PM -0600, Rob Herring wrote:
> "pwm-dutycycle-unit" is missing a type, add it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/regulator/pwm-regulator.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Brian Norris <briannorris@chromium.org>
