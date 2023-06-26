Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D760573E4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjFZQ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFZQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:32 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C3010FB;
        Mon, 26 Jun 2023 09:25:31 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-783698a37beso21313739f.0;
        Mon, 26 Jun 2023 09:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796730; x=1690388730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2ckgd7YALVY0gj4r91am4l6rRn1hjm6LrXI7ICY11I=;
        b=GjXjtH/wyVqsD+azVuvxjQvbo3R2adXZG6pnxB30KqB+1RmK1sBEloLrKfHr627c+n
         VVutcyRIaKocbXZPrFkJLGsvdWwKffhpWpiFe8WX40+pxDQDi8qd/PutJc6cZdMs9IEz
         ELmBOg60QOAmjV0/dxWkRvns+Xhe8v4vngRnKxCQdyrxr8Ck43qLxrDqBcnPT5CwnnIx
         PsgBotaz1USHpI5+0MtKcrbPBmJtKED9W8e9kq9nW5dUez2erhzPyDxwyaC8isIyDsLe
         VmmiFjyAFQnFqhrtbzwcwJV9E+tUaHzK1ZfnhKJmfIv4TvJpD4SCdZUzPizfDpOxesCV
         iOGQ==
X-Gm-Message-State: AC+VfDwqQ+rii3h+WW8LcbVIha/bsKzokQGGd9XcihG+jXByylx2UgeS
        B4eRRhITyQ/ZjqvU4ZeUEQ==
X-Google-Smtp-Source: ACHHUZ6WQu16kCTLPl/RivVD2241FLhgGwPjFfbfvwFlSaV7gGpmzJSxVWPfumL0USZ98Qf6BL6Qng==
X-Received: by 2002:a5d:950a:0:b0:780:d0e4:8bca with SMTP id d10-20020a5d950a000000b00780d0e48bcamr19293893iom.7.1687796730673;
        Mon, 26 Jun 2023 09:25:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w30-20020a056602035e00b0077e3c4be469sm2338689iou.6.2023.06.26.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:30 -0700 (PDT)
Received: (nullmailer pid 3355102 invoked by uid 1000);
        Mon, 26 Jun 2023 16:25:28 -0000
Date:   Mon, 26 Jun 2023 10:25:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: auxdisplay: holtek: Add missing type for
 "linux,no-autorepeat"
Message-ID: <168779672721.3355039.10422929123874598290.robh@kernel.org>
References: <20230613201049.2824028-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201049.2824028-1-robh@kernel.org>
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


On Tue, 13 Jun 2023 14:10:49 -0600, Rob Herring wrote:
> "linux,no-autorepeat" is missing a type, add it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

