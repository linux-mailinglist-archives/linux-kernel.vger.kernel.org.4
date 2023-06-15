Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC3731B32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjFOOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345006AbjFOOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:22:32 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B0123;
        Thu, 15 Jun 2023 07:22:31 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77acb04309dso423962439f.2;
        Thu, 15 Jun 2023 07:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838950; x=1689430950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEg7EMnZMdlmWEdktxYKcuRJOAL//1Mi4Xx1RXCqPB0=;
        b=hOShtZhqyyPN66ZNDTaiyMzTQwoKebC5vtseDl7uVEreMLy+BgTd12VhEKrc8TVjR9
         ioVXfedZsKeXVWXZl0aUfGDBThIJkoUI5x1C77jfnutZMQANXp92ql7bwx18ZQGmz5Fk
         TzU+d7de8ELM4enAPWe3rvpRTIuQzcaenBnbIKQYnu2YuRJH2ibE2oPIF+/FXXG8hiBC
         wHAGMY/pd/0CfeGKR/tiNDTqQw9wYeQ6i6OmWwS1dJCLTMCYl/lY7TnLIbQh1GoX4mhs
         G9Sj6Eg6TlsJ9irrtZ5UUFfl3sK7CWnNgNxqIXLytiag+pa6boW/fvbQb1Y/mDiDjCe5
         6rzA==
X-Gm-Message-State: AC+VfDw0/fwSn65LW4eMgW/OW4FrS80LaiObg2yd1KmE3MzUyktK6Zu6
        wDSQVp8Nc4BOYl43pf0fYA==
X-Google-Smtp-Source: ACHHUZ6aX1hhzd2Y+OJphgLbAizbNGQb2xNYZnIgqpLsSCCWvmaouRkQgwloJd6hWqIOThDQYZEvlg==
X-Received: by 2002:a5e:aa07:0:b0:763:5cf8:65eb with SMTP id s7-20020a5eaa07000000b007635cf865ebmr19694779ioe.9.1686838949064;
        Thu, 15 Jun 2023 07:22:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6054431iol.38.2023.06.15.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:22:28 -0700 (PDT)
Received: (nullmailer pid 821661 invoked by uid 1000);
        Thu, 15 Jun 2023 14:22:26 -0000
Date:   Thu, 15 Jun 2023 08:22:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: eeprom: at25: add st,m95640 compatible
Message-ID: <168683894540.821593.10823616752943009880.robh@kernel.org>
References: <20230614201056.379080-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614201056.379080-1-linux@rasmusvillemoes.dk>
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


On Wed, 14 Jun 2023 22:10:56 +0200, Rasmus Villemoes wrote:
> The st,m95640 is a 64 Kbit SPI eeprom in the same family as the two
> existing st,m95* compatibles.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> 
> In case its relevant the data sheet is easily available from
> https://www.st.com/en/memories/m95640-w.html . It seems odd they chose
> right-pad with a 0, 640 instead of 064 (m02 means 2 Mbit, 256 means
> 256 Kbit, so there's some logic to that), but here we are.
> 
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

