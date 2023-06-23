Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808473C361
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjFWV5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFWV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:57:16 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324CD26AD;
        Fri, 23 Jun 2023 14:57:15 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3422b2554e1so4435445ab.1;
        Fri, 23 Jun 2023 14:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687557434; x=1690149434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfdlMJkoa4SrzUsc/lvDXncIHjzQ/uTbhcwby8Z+w8c=;
        b=SA5uzcSqliMEK/YR9I7vIwQS1GreR8Gq+B7vQGOY2QtwYRhuu19bzPCp2MlShTwIWK
         +hwA+qtNXQox3og/eNiqiq06OEv4/KBrCBaD+HVEmGQQHTnBvOi5bnxtiYEFlqPr5hRJ
         0Te9yu1GvrS5056wMRjUQo5w4XXQAFvKIM2O+Qp5i31smojmH0SV2V7sGUr4EyXcnF3V
         HjP4h3kqLITFWdvo3WwHAE7fgNx2isIDJUMbAK0GClVBtj1ojkMvTce0a37d2wzB8qQ5
         IzdgYiJ6TZDGf6aOy0/p5JtxkxiGOPll7cbVmxGsDJaTD5qDKKrceMyRiUTUpBYejXx+
         va8Q==
X-Gm-Message-State: AC+VfDxVTRgNCNo4SRRansZrSfxdmE3Iyj1bhDDiyLTfmyZSbDkW2aOS
        TLJYP4Cl09vzide6/MLztQ==
X-Google-Smtp-Source: ACHHUZ6dvF4FMpy79teGrp0bTWDiN9Iqy4rfyKrWRT8QGWAYY7dIBTwswOpioxETqKFqFe6TN+ZZ9w==
X-Received: by 2002:a92:dc85:0:b0:33e:7c8d:3cc with SMTP id c5-20020a92dc85000000b0033e7c8d03ccmr18268708iln.22.1687557434407;
        Fri, 23 Jun 2023 14:57:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l13-20020a92d8cd000000b0034124f13f87sm98704ilo.42.2023.06.23.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:57:13 -0700 (PDT)
Received: (nullmailer pid 1266682 invoked by uid 1000);
        Fri, 23 Jun 2023 21:57:11 -0000
Date:   Fri, 23 Jun 2023 15:57:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Message-ID: <20230623215711.GA1216324-robh@kernel.org>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
 <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
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

On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:
> Allow specifying the threshold for which the channels configured as
> digital input change state.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> Running dt_binding_check on this with a too small or large value in
> the example does give me an error, but the multipleOf does not seem to
> be enforced; the value 1234567 is not flagged. I don't know if that's
> expected (maybe I have too old versions of something).

Thanks for the report. Indeed, 'multipleOf' was not handled correctly. 
I'll push a fix to dtschema shortly.

Rob
