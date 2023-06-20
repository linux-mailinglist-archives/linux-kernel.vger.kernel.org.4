Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B98736F18
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjFTOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFTOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:49:33 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3311D;
        Tue, 20 Jun 2023 07:49:32 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-76c64da0e46so215563739f.0;
        Tue, 20 Jun 2023 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272571; x=1689864571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfGW8gXxXc4xOldKhUQqmMtTa1hUcNXAiWfRoW8/qv8=;
        b=YIPQCamYj4CFt0G6yucXfb0QuutVKhuT6ROD4QlC3llSqdttINuMNtTPUSrPegEjvB
         6wErrOBkLdJiJS0tmo3PD+c+9FNw7+tyRNC0xWlgUZwLO5Vg6CjU2u+WAxeHPGnWZncx
         cUIoZm7hFSJ3YZtvjr6kLIIxjtBX/Qa3T/IDSlSgsQSrNnU8ez6NVqb9JerbzMZnw5xA
         B1b+JSwc9p3XNO0Om4gO+JgyNTPLne2PcRgpCpX3NW9DLtQi0OtrbECSMdeaSBk9VW1f
         jeXd7okJ+GHoZGyxfuh4vazmO6V5MuqmCCg7HEFuCw+VekgHpN4gXmxSZ3FuSsdWKm7y
         yiJA==
X-Gm-Message-State: AC+VfDzDkMjskJrGyWS54pkRsWVimttp6Fl/H5sgdNRSE9LAT1DQqR7+
        NtFDpmmQzniHmx2AV9cfzA==
X-Google-Smtp-Source: ACHHUZ6HuhVgOMehTrCrc0BgkQnyUephcmWsY/z8kAL7h2yHvSPpPgz4eu3wa/QgAeDXBeMlwifExw==
X-Received: by 2002:a5d:91d6:0:b0:77a:c741:b749 with SMTP id k22-20020a5d91d6000000b0077ac741b749mr11549610ior.1.1687272571543;
        Tue, 20 Jun 2023 07:49:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c6-20020a02a406000000b004166c24e30dsm693185jal.32.2023.06.20.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:49:30 -0700 (PDT)
Received: (nullmailer pid 3574420 invoked by uid 1000);
        Tue, 20 Jun 2023 14:49:29 -0000
Date:   Tue, 20 Jun 2023 08:49:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-i3c@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Conor Culhane <conor.culhane@silvaco.com>
Subject: Re: [PATCH] dt-bindings: i3c: silvaco,i3c-master: drop unneeded
 quotes
Message-ID: <168727256801.3574342.4318996941129630484.robh@kernel.org>
References: <20230609140735.64855-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140735.64855-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 16:07:35 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

