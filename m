Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231F9681DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjA3WRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3WRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:17:46 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AE1B563;
        Mon, 30 Jan 2023 14:17:46 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso3106378otl.11;
        Mon, 30 Jan 2023 14:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxkc34nw9NakpfF2w3ZNxT+rUUgjADCyMtUMUVCKK2k=;
        b=rPddJsvljaOJ12UuCR0NLHXJ+JXUSyWBwxFRxgwUR7YuNtZMZrckChTjNBKGkIYfKP
         qo2EH6yXFYn4Pfd0LTHh0Hej/6wwyNDq+DKzDKcp7+6n1Sin5PJvEyMrhM3ABR498WWF
         1ItTFAhkm55czGm5kzoPrpmH4AsgHwP+fVb0HDzt0sfOnYgC/kT+X3QGCuFBEh3xPCGy
         Rib4l/nD3SmBpY0yp/DP/RkY+EsMD2PjbPKZ8Nc9LpZTiNjLQP1IyW0fqDTbaEZ5iRXE
         +W0EI1zoD/k+SFadT+G+UO5H9Hvs5i7o7Dmv6AI70dy67uj01N4zFO2suLr+NGCwnlDg
         Pd2Q==
X-Gm-Message-State: AFqh2kqOQTGoBxLU1XR5LkZzDXWDDDVhtgeuaycxLR9XT4W7lWJXn2HR
        76p9pJdvDXA0atx/uHI9Pw==
X-Google-Smtp-Source: AMrXdXv/tN1MqqC7568LA2s4569AU6e8d7ISb2XpF76WsCbozrLujaQajfsgpCmIFTa/VdU5T0Etjw==
X-Received: by 2002:a9d:5e84:0:b0:684:ccc3:1569 with SMTP id f4-20020a9d5e84000000b00684ccc31569mr11524701otl.0.1675117065580;
        Mon, 30 Jan 2023 14:17:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k96-20020a9d19e9000000b0068bb3a9e2b9sm4343048otk.77.2023.01.30.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:17:45 -0800 (PST)
Received: (nullmailer pid 3626287 invoked by uid 1000);
        Mon, 30 Jan 2023 22:17:44 -0000
Date:   Mon, 30 Jan 2023 16:17:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: phy: nop: Fix a typo ("specifiy")
Message-ID: <167511706397.3626248.6621009863447665163.robh@kernel.org>
References: <20230129124258.1295503-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129124258.1295503-1-j.neuschaefer@gmx.net>
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


On Sun, 29 Jan 2023 13:42:58 +0100, Jonathan Neuschäfer wrote:
> Spell it correctly as "specify".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
