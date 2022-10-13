Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA19C5FE363
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJMUfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJMUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:35:36 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51404D4A07;
        Thu, 13 Oct 2022 13:35:28 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j188so3025085oih.4;
        Thu, 13 Oct 2022 13:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+yYI+YkWGMsZNFt+MhjFu97fBBw4KO6BqLDbO0bxT8=;
        b=NUl5Ak4a95Fg0BJlqhMwC+C4miFcmwLqEzIhwCgab6iyi0IKt42/51EZd/Zk8yOiix
         gHLHGGu0msLbu8sfV9VyoTT37sjj02+4Ae9RMIBciskLa8zcOLK16u5BrFt5Nv6+0MIw
         3ob5hVxWK2pJsAWG34JHR62Glv/AoStNRNyAYObUaE8h2zbd+Eh0RyuYrS5n/gmLpGdu
         ltezqPy9k6aDCE3/WIwk1v43TNKbniATL6w1/osgpgUBRaerOWt0xAEbvVK6Ue3X+E9g
         0idncA/MEX1gS372VnAiwYAVYX2dxKU7bDziGfDMHgqLSHCrWIJfLh2Y06ibOZy3Y6uf
         ZDhg==
X-Gm-Message-State: ACrzQf3oiDDMijw7E94E6Zk46uze9cqqT72FtW8e3zLXVtVY1Wb2jggs
        DLSuGsIeBVsu0q0YN9xYGA==
X-Google-Smtp-Source: AMsMyM6osB5ziZBg2XIkk2WpQvAiOPVKrXDjYQRCfGWBA/VJh2nGEgfqyNrKu1upnPHQi4wzvDgKWw==
X-Received: by 2002:a05:6808:1496:b0:350:4640:5462 with SMTP id e22-20020a056808149600b0035046405462mr5556666oiw.47.1665693327535;
        Thu, 13 Oct 2022 13:35:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f10-20020a056830204a00b00661b019accbsm420062otp.3.2022.10.13.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:35:27 -0700 (PDT)
Received: (nullmailer pid 183993 invoked by uid 1000);
        Thu, 13 Oct 2022 20:35:28 -0000
Date:   Thu, 13 Oct 2022 15:35:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Document IPQ4018 boards
Message-ID: <166569332720.183944.3878915082187494148.robh@kernel.org>
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
 <20221013155418.47577-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013155418.47577-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 11:54:16 -0400, Krzysztof Kozlowski wrote:
> Add compatibles for existing boards with IPQ4018 SoC: ALFA Network
> AP120C-AC and 8devices Jalapeno.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
