Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82E7628EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKOBPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiKOBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:15:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7913F28;
        Mon, 14 Nov 2022 17:15:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 62so3504941pgb.13;
        Mon, 14 Nov 2022 17:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2l244vQ2odgfLHHbiYYfd8nnMvI4XpJun/2IZ+TiinQ=;
        b=kZ2yMrVSyFXoNln0I29seNHdSHGoVg2YCAmsEPqNLumXN4gKV7JEwG/DMWAdGfzlmR
         QfPrhpXZGZa6u6ztpcs+Kh7poFap2LSHVfLWjgnCD1aUZPK+ziExmF53EoZRYm6sWPNs
         YsGVtS6nntN7YRaqqUxEo6NI+ToAP7WplbyOovfqRb335y4sksjBqUjPrh2RD1n+Z5is
         tD4IsAsHRPJTaS4KH3GNl3J356120e2OavLTYnjY8Vlvx4bZT9KXn4XR8SI9fybdhfpb
         wEOkjJnNKc7w857tombwgJworDIsW9rriT2u+bLuQpWEZQdI7A1Kav5gL1xo8yeRnvcf
         hIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l244vQ2odgfLHHbiYYfd8nnMvI4XpJun/2IZ+TiinQ=;
        b=lvFGcsd8k07UFKe58+UvGaewxCOoDMPC9u3c3aIY7GmPLNvKNBXwAwhI9Y6tsQy1JZ
         2cO9ZtvIBWO+l8YHuF49dXtGC00H75Ukv+i/gfS7Fxm67hLaVJK/x16GtGBXQrh3cmUz
         mcEFPhEX0uST5hzZgl6FkgKhkbhx42zHqp3ibt/ovq63bNhYpl7SHR/V5g97uJqLK8xe
         q4b5n88F8o9YDUBhELn+TSSNBjLtE4wyJ1tLkSX1izhpGG2i3Oyjw/R+/9juj2JaF5wv
         Jnjilu3EIqtzJwuvVzAkGd3Akq2H1fXsUBLFD2xlpaM1sz///uh98xktvZZvdUrhHjjI
         pxbA==
X-Gm-Message-State: ANoB5plQoeS45of0bExOEcjj0KdNE5iAuNf6lBsBala5V7e5n5BEYyiL
        EhltUPJfyw3/RUqUHxu885w=
X-Google-Smtp-Source: AA0mqf6rB2YSpD9sTq7FaUxlnWFJOv+oZ0za9/oWnrXzyJ11Zm2rvzAix0s62HGfm8bgSCgZ2//Ntw==
X-Received: by 2002:a65:620e:0:b0:43c:6413:322c with SMTP id d14-20020a65620e000000b0043c6413322cmr14068451pgv.472.1668474913368;
        Mon, 14 Nov 2022 17:15:13 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id b24-20020aa79518000000b0056afd55722asm7356431pfp.153.2022.11.14.17.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:15:11 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:15:08 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: input: touchscreen: msg2638:
 Document msg2138 support
Message-ID: <Y3LoHNoHTN+J3lW6@google.com>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
 <20221110171952.34207-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171952.34207-3-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:19:45PM +0100, Vincent Knecht wrote:
> Document msg2138 support by adding mstar,msg2138 compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
