Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826C66EE61B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjDYQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjDYQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:50:55 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E95273D;
        Tue, 25 Apr 2023 09:50:54 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6a5f765d595so4157177a34.0;
        Tue, 25 Apr 2023 09:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441454; x=1685033454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM47zhOsF1/IbJx3o5BnKl5EtWeuDb+Ro0wO4CeVO4c=;
        b=jagS96hlA93E7f9Eqhuw+hHRcbTN7ZMtO47ez+MsBwotXwBCY3AAENoMyxM/e0ltKn
         qFu5tKXdHUgPdc6jITWN583RkMBpgbedtH1wy7zkI3s7pXIU6fIx4sIWQlpnnHsIe9Ct
         ebCT/73NtGZIEqB5qWTb/38ewLSWC+dp1+m8L3Q2pLilzF4tC1LvB5A4n9HO9zQBGYGv
         rmCWPTkTf6vsH/Dc6x1NblIiKM7XVO7UjhjFpGEu83nGDNjrFxt/3HI6OOCKB26BxZ1G
         cEgyORbCV66cFIoNvWshB13wAZCexCMzlLBN96rsKc8yJNlQqqTe9aj5tXFRSJ27vwl8
         4lrQ==
X-Gm-Message-State: AC+VfDxL06dDZ9xcrbJMZFbV/OyAunjwzNlDiOBN7Nf9e8x5YTeUx2dp
        tXbZzbFnhvQwI1JB7tTwKw==
X-Google-Smtp-Source: ACHHUZ6zhJeYlsqSASLjLttFU8sWVqv0DhQPFw6fcaE2+/8upI9WIfE7uBNTZuKDE34SoFUjCU6pDA==
X-Received: by 2002:a9d:6f04:0:b0:6a7:befd:43a1 with SMTP id n4-20020a9d6f04000000b006a7befd43a1mr686002otq.2.1682441453899;
        Tue, 25 Apr 2023 09:50:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d6d99000000b006a632c6af05sm4861323otp.54.2023.04.25.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:50:53 -0700 (PDT)
Received: (nullmailer pid 1928661 invoked by uid 1000);
        Tue, 25 Apr 2023 16:50:52 -0000
Date:   Tue, 25 Apr 2023 11:50:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: firmware: arm,scmi: support for
 parameter in smc/hvc call
Message-ID: <168244145233.1928607.12928515102198250927.robh@kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
 <20230418185659.29745-2-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418185659.29745-2-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Apr 2023 11:56:58 -0700, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with smc-id only. The parameters are
> all set to zeros. This patch defines a new compatible string that can
> be used to pass shmem address(4KB-page, offset) as two parameters in
> SMC/HVC doorbell.
> 
> This is useful when multiple scmi instances are used with common smc-id.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

