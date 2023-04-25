Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B696EE799
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjDYSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjDYSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:38:23 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F6146CC;
        Tue, 25 Apr 2023 11:38:22 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-541f21ef0d5so3318331eaf.0;
        Tue, 25 Apr 2023 11:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447902; x=1685039902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TSCz7QCmWjwuRcVpOo2qZlT76Hnne+7Du/Iuknn3Qg=;
        b=Ih7Pe7IcKkq9RldpZtWsKEmRXXjv9asO4nF5bhNGx/Z2ZRZQ71pNtR0RscYASISQxo
         6ddCUa/j9BGrE2Inpz5Ir5p5v8Nv74WCRRZjWmmx+iiTj/PeD27MOoSMmfEZ8UFX3y82
         BIPKILjJ9F01YlyithPzAHEIMKGVovaPMU4x/BHfrZutejTDPJ9KJ6jAvz1/qKSfB59X
         sEl4sjUVrB4tcmDv7j9GUJlVNJzoFd6XmDCIpmbIozBqrJNo0rWuQpMzGBcXzw3owHvr
         6brIvp3jMgq8fWeYv7FePeTUN1zWfzZo2Nrs/AQT4UCwBrsO/nIOqxJY6SFPYcHEzTjW
         jCkw==
X-Gm-Message-State: AAQBX9fa4aTfi929FhCQRwcPxvYKjTfWwinCDZNXZ7LCOAlMpJB8w+KM
        zsfaLPAfMQqPIhhsANnHsw==
X-Google-Smtp-Source: AKy350baxMv1XV1+Ib7RtbH+radYPwF8Djs2uNuSzsYTcwt0TF3nKAN8Iz8fVFAXUp+IQJyPzxBzYA==
X-Received: by 2002:a05:6808:1597:b0:388:fff3:61e6 with SMTP id t23-20020a056808159700b00388fff361e6mr10967697oiw.38.1682447901864;
        Tue, 25 Apr 2023 11:38:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m129-20020acabc87000000b0037d8c938d62sm5834891oif.50.2023.04.25.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:38:21 -0700 (PDT)
Received: (nullmailer pid 2061092 invoked by uid 1000);
        Tue, 25 Apr 2023 18:38:20 -0000
Date:   Tue, 25 Apr 2023 13:38:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     quic_wcheng@quicinc.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        kishon@kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v9 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Message-ID: <168244790024.2061037.14160381736561499893.robh@kernel.org>
References: <cover.1682092324.git.quic_varada@quicinc.com>
 <f9ba5b4f3dfd299ec7cefd038bc1d9ed5a817b8d.1682092324.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ba5b4f3dfd299ec7cefd038bc1d9ed5a817b8d.1682092324.git.quic_varada@quicinc.com>
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


On Fri, 21 Apr 2023 21:24:45 +0530, Varadarajan Narayanan wrote:
> * Document the IPQ9574 dwc3 compatible.
> 
> * Make power-domains as optional since IPQ9574 doesn't have GDSCs
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> ---
>  Changes in v9:
> 	- Place ipq9574 alongwith similar SoCs instead of new entry
> 	- Make power-domains as optional since IPQ9574 doesn't have GDSCs
>  Changes in v6:
> 	- Made power-domains as optional
> 	- Resolved all 'make dtbs_check' messages
> 
>  Changes in v5:
> 	- Restore removed constraints
> 
>  Changes in v4:
> 	- Update other relevant sections
> 	- Remove constraints not applicable to IPQ9574
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

