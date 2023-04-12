Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCA6DF7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDLNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDLNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:50:53 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303710FA;
        Wed, 12 Apr 2023 06:50:52 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e9so7660226oig.7;
        Wed, 12 Apr 2023 06:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307451; x=1683899451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwAXpbEfRmXIDKyTi3ZF6YzD+QDSgDNiHTH3bIpWqzg=;
        b=znOXd/GLXOUsQqvBSpanxhKC4McwisSJIy0hhS/fWOiHTmvgn1YPd6l+mU+96+4hLQ
         97IqhSGHUyCUtm7F1HaOszxWRXNG6ubnji/3KW8vgqnqpGY8ussDHb4iuKonXt1Vp8uA
         CxFV7eEU93uLzZmiuyg4HlthaoBGIIrxRRl5IcJbmvoqRn1L8+cHzOWcKoNoIG0l0Tie
         22yY5Os1/94m7Camq3KwkYHTEO7MyPhX1gI0D0OeVGUWYEO5J7Xfl+PwJxCp6rfIMlLf
         cAUn+hC+qKu/Oi3A7/ZWYMpRiVAp7HBcBP5nXkQnTj3NVm4MJKpExYTlsvGZUpkduow5
         DPqQ==
X-Gm-Message-State: AAQBX9e3Ef6sQFJcIXFGkOc5LiqSRuSbXmDfcta5SmmmtBwWdrOv7QoR
        P4qsqcaoO+fuOCPHdpFNxg==
X-Google-Smtp-Source: AKy350bxKmOEWrJ6ncOQp1r20edwr0Xo47a81S5dea4KzWyycCb1UJas3zTPVl2emUvfB/wxNwjLTQ==
X-Received: by 2002:a05:6808:634a:b0:386:d629:81a1 with SMTP id eb10-20020a056808634a00b00386d62981a1mr3244814oib.35.1681307451399;
        Wed, 12 Apr 2023 06:50:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b0038998fa6c2bsm6749956oif.33.2023.04.12.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:50:51 -0700 (PDT)
Received: (nullmailer pid 2223659 invoked by uid 1000);
        Wed, 12 Apr 2023 13:50:50 -0000
Date:   Wed, 12 Apr 2023 08:50:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     - <xe-linux-external@cisco.com>,
        Marcin Wierzbicki <mawierzb@cisco.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Message-ID: <20230412135050.GA2219534-robh@kernel.org>
References: <20230405223028.1268141-2-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405223028.1268141-2-danielwa@cisco.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:30:27PM -0700, Daniel Walker wrote:
> Describe the compatible properties for the Cisco CrayAR SoC.
> 
> Cc: xe-linux-external@cisco.com
> Cc: Marcin Wierzbicki <mawierzb@cisco.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Daniel Walker <dwalker@fifo99.com>

checkpatch.pl complains that the author and Sob emails don't match.
