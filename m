Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9576F8AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEEVVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjEEVVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:21:44 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47AD525D;
        Fri,  5 May 2023 14:21:43 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-546ef028d62so1366141eaf.1;
        Fri, 05 May 2023 14:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321703; x=1685913703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmvfJoO3DPRoE8yZJsRnRuiyE8hYJSo3Eta1+CMG32I=;
        b=LSDug3N+J5npyAJxpr9EXwurrlO9CT9/zDzdrnJKgjHNXdYYmeQ+FSRznSkOPdWO7w
         1L9dOG0c7O4S0vy9UdKwLg3E0tBqEll3x6HOARWvNC51mz3TqEud1st2NWVfSHuF63Y0
         Zb8/hPlMMP6Eazppp79IwAWcfeLujQeOjDXvGfYq2WcfbCbErCkGDByD/ZoO6y/fuhCM
         2iE4z1AEsrbdmSev/Z9E4qZPWIzMXqbPRJ9zLN4iQDiBZ8UGzKquZ/QNXKz63/gRWXF2
         LYmIn5WWtrnigEyE+A0LH0RVaVd3yp3qcXyiTI5tcIrGoQYGA6r5hRBFkgo3TlEI4z55
         azag==
X-Gm-Message-State: AC+VfDwlDcEKTt4kCad2PEKO9yPvf8msCQZzbuDH++pWm1GwSL9vP3Sl
        A0tq3sUwqdhvV2++zS3Sdw==
X-Google-Smtp-Source: ACHHUZ5zfya4zblErvE6sknC5VX9Wv2ZzvteximH2pvRuWKBo13VFNFgBi6y0z3YmBfQw9yXfjAv7w==
X-Received: by 2002:a4a:91dc:0:b0:545:62bf:fd6c with SMTP id e28-20020a4a91dc000000b0054562bffd6cmr1285690ooh.0.1683321702866;
        Fri, 05 May 2023 14:21:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c5-20020a4ad8c5000000b0054cbf3be7e1sm1421454oov.32.2023.05.05.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:21:42 -0700 (PDT)
Received: (nullmailer pid 3584547 invoked by uid 1000);
        Fri, 05 May 2023 21:21:41 -0000
Date:   Fri, 5 May 2023 16:21:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alison@she-devel.com, johan@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, achaiken@aurora.tech
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Message-ID: <20230505212141.GA3577765-robh@kernel.org>
References: <20230501170124.1218603-1-alison@she-devel.com>
 <20230501170124.1218603-3-alison@she-devel.com>
 <3b42d309-058b-575b-dd37-cd67678c4a75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b42d309-058b-575b-dd37-cd67678c4a75@linaro.org>
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

On Mon, May 01, 2023 at 07:42:21PM +0200, Krzysztof Kozlowski wrote:
> On 01/05/2023 19:01, alison@she-devel.com wrote:
> > From: Alison Chaiken <achaiken@aurora.tech>
> > 
> > Add support for the U-Blox Zed-F9P GNSS device.
> > 
> > Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> > ---
> 
> Something is not right here. Either your SoB is missing or you are one
> person but use entirely different addresses and names to send patches.
> Your From in the email does not have even the first and last name. Use
> the same address, that's the easiest.

Looks fine to me. The patch 'From' and SoB match. Sending from a 
different email is fine when the author/SoB email is disfunctional for 
patches.

Rob
