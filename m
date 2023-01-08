Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389AA661AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjAHXHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAHXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:07:20 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6BB497;
        Sun,  8 Jan 2023 15:07:18 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id fa5so1286348qtb.11;
        Sun, 08 Jan 2023 15:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbteDqJIhVmCaiLDoQ3IMvX57rarGIX4gmMNmG5hqcM=;
        b=cA3r7/bmHdSHc/zc0DmB5k3YEohowlxzY71e81ez6t2XWahs7EcUxVxVVuElmzW+NI
         wU/H7aL7/xq0lJXjmqud0E+QUlwqXUVVbpAuG20iUbri7zJGq7oiO3GcJM6wy2Ikd2gH
         HePkXVyGHgTlbz9PjsI0O6B5/iZnm5IVmXEa0kKq1TErXZMgyy+yFdPzxkZ/d88mokvA
         YVA1lV4v9gPQLWtaIHSI/jsXDoti0SV1I8xEgvcGHtuXDNfMqRoxrApL2NgJPcdS0mQS
         wb5au76DttriYDgdTMp22HMPlTLWkWvOuD/uAvcZkxDzLW1JF69tA/NyxzHFl5XATOsd
         BZeQ==
X-Gm-Message-State: AFqh2koIlFkbQOE1UKoxm51qzkhuRculpNfqutTkxRI6VTCzWT46xEZG
        y/LQZp8qpsMtme/J2kptvA==
X-Google-Smtp-Source: AMrXdXuv8pK22kcXsd7FAZ7bXcPlKilRcP/wec6CIN9Rz4pKkz1MQa6tr5l/emSDINREn1mm8+FFzA==
X-Received: by 2002:ac8:4e04:0:b0:3ab:5dc7:6bf0 with SMTP id c4-20020ac84e04000000b003ab5dc76bf0mr85406601qtw.36.1673219238061;
        Sun, 08 Jan 2023 15:07:18 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id h6-20020ac81386000000b003a7fef41526sm3735322qtj.77.2023.01.08.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 15:07:17 -0800 (PST)
Received: (nullmailer pid 405968 invoked by uid 1000);
        Sun, 08 Jan 2023 23:07:14 -0000
Date:   Sun, 8 Jan 2023 17:07:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Synquacer
 EXIU to DT schema
Message-ID: <167321912140.403302.13505561708995415952.robh@kernel.org>
References: <20221209171636.3351602-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209171636.3351602-1-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Dec 2022 11:16:36 -0600, Rob Herring wrote:
> Convert the Socionext Synquacer EXIU interrupt controller to DT schema
> format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../socionext,synquacer-exiu.txt              | 31 -----------
>  .../socionext,synquacer-exiu.yaml             | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml
> 

Applied, thanks!
