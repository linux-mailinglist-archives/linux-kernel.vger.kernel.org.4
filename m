Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF46D67BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjDDPmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjDDPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:42:05 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDD4EFD;
        Tue,  4 Apr 2023 08:41:45 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id bm2so24534849oib.4;
        Tue, 04 Apr 2023 08:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNQOdzZ/V7NvMnW5O/EqRI3wlzCe7fljKi3y+C+9QXo=;
        b=xAxmfSN/Prxzvlyv0+9D+XV4OU7hMPcuw4hAQAJHCROG3akLPCJqcPDhKHbMX/oSxZ
         AYdJCklpY+8rX/4OiZCLiWZS4CGQl92magyhVNv7P4wfQOIzESQ5aw8vSiPoP8qIB2NH
         DhucXBmueklZTrx4cletyiOIV92wpGeYjprhzK4daVT+E5Rz3cgh5h/iaWPNBO0P8rzt
         MS4ATJyAboHsHgxmCyaGur2sbzG+kOuGBvJNETr00XaU8ibjcgF6pcGxD/rsdVi5yVHb
         Sugmtz6z5yaoMaXGmF0VnVUZFDrUWxM5MZRF4QzZne8c4mpgafbKHYQJ49BTqqmqoPBo
         HSgA==
X-Gm-Message-State: AAQBX9cR5XnxJ4Py7fKuv0SSBC0sHoCUWQGB5Vmd6OhTCRYwDRQ7bhrt
        PJ+/7kazU9FUiX/4Un8oJw==
X-Google-Smtp-Source: AKy350blqL+5JHsKCSL16VJrrTgOnLJqUvIw2dBKN9tnDOxf87QqwzhiV4Eyr08RM0Pm1kUPqkJTjA==
X-Received: by 2002:a05:6808:2785:b0:389:4a00:f672 with SMTP id es5-20020a056808278500b003894a00f672mr1321505oib.22.1680622888090;
        Tue, 04 Apr 2023 08:41:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g188-20020a4a5bc5000000b005252e5b6604sm5584615oob.36.2023.04.04.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:41:27 -0700 (PDT)
Received: (nullmailer pid 4038093 invoked by uid 1000);
        Tue, 04 Apr 2023 15:41:26 -0000
Date:   Tue, 4 Apr 2023 10:41:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, vincent.guittot@linaro.org,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: arm,scmi: Support
 mailboxes unidirectional channels
Message-ID: <168062288561.4038038.6938372058010065786.robh@kernel.org>
References: <20230404115026.2828149-1-cristian.marussi@arm.com>
 <20230404115026.2828149-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404115026.2828149-2-cristian.marussi@arm.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 12:50:25 +0100, Cristian Marussi wrote:
> SCMI defines two kinds of communication channels between the agent and the
> platform: one bidirectional 'a2p' channel used by the agent to send SCMI
> commands and synchronously receive the related replies, and an optional
> 'p2a' unidirectional channel used to asynchronously receive delayed
> responses and notifications emitted from the platform.
> 
> When configuring an SCMI transport based on mailboxes, the current binding
> supports only mailboxes providing bidirectional channels: in such a case
> one mailbox channel can be easily assigned to each SCMI channel as above
> described.
> 
> In case, instead, to have to deal with mailboxes providing only distinct
> unidirectional channels, it becomes necessary to extend the binding in
> order to be able to bind 2 distinct unidirectional mailbox channels to the
> same SCMI 'a2p' channel.
> 
> Bidirectional and unidirectional channels support for the SCMI mailbox
> transport can coexist by carefully considering the effective combination
> of defined 'mboxes' and 'shmem' descriptors.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> 
> v2 --> v3
> - coalesced oneOf entries using proper minItems
> - removed unidirectional channels example
> v1 --> v2
> - added mbox-names unidirectional definitions and example
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 48 +++++++++++++++----
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

