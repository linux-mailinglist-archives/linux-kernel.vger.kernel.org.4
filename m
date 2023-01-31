Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4F683A99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAaXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:40:47 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E7F77F;
        Tue, 31 Jan 2023 15:40:42 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1631b928691so21474232fac.11;
        Tue, 31 Jan 2023 15:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLht+cV6v3V59oYZ+zm9MhRpf7R18xJ4uQrHG67u++I=;
        b=zlNVXWX0PH0FzziG9DeoPaRCCt41ni8BlMfvJKPIiJZJhfROIn1QxgRbW2ShXBFa+t
         BcSB5f8iZ4PHRdcDI9WQU4hohE7dh2YS9fkP9h4D2Zl1qhnUewRWiG8R960V6TIMj/RI
         ENATGq+ja25NpUjqoVZsCyVFeCZYD6Urd+hQ3Qida93iV86Z5QLYl3jLGo6Gf3Rxz65l
         KIq2Ozv+p570rFD5cOsbc1gF1kNTgqV5Opf1NH9IRsGnE+W5LW7vhOrhF2iu/63fX8Ss
         glwyGRKZj6WGd/O/ogI3gs8t9jFRqNzZPbUnH2rquPJJpkx1t7XzIoog8b9biNiv3mmk
         qDcQ==
X-Gm-Message-State: AO0yUKWsoBIlySfhZflBL0D0tIJ531a3h6YIq1hv1ONfQXELNmEJM+EK
        oFtp2TpBvA7BlAzdMfZPSK8xOaEdGA==
X-Google-Smtp-Source: AK7set9J8xKhfoC47bjJSd9BhnQwx97pqYlWUEN/OU2PKkSU8k4VzwVXMnVmY8DLrpKIFhnB/MvKKA==
X-Received: by 2002:a05:6870:4710:b0:15e:cfce:fcb9 with SMTP id b16-20020a056870471000b0015ecfcefcb9mr698749oaq.34.1675208441500;
        Tue, 31 Jan 2023 15:40:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a4acb8f000000b0049fd5c02d25sm4398963ooq.12.2023.01.31.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:40:41 -0800 (PST)
Received: (nullmailer pid 2162871 invoked by uid 1000);
        Tue, 31 Jan 2023 23:40:40 -0000
Date:   Tue, 31 Jan 2023 17:40:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <devicetree-spec@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reserved-memory: Refine 'size' and
 'alignment' types
Message-ID: <167520843972.2162817.14937783775593918446.robh@kernel.org>
References: <20230125221450.3058762-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221450.3058762-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 16:14:50 -0600, Rob Herring wrote:
> Both 'size' and 'alignment' are single values, but can be 32 or 64 bits.
> Use the precise types rather than the 2 32-bit cell encoding.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/reserved-memory/reserved-memory.yaml    | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!

