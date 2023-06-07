Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF17263C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbjFGPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbjFGPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:10:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DFC19A4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:10:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso46844755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686150614; x=1688742614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYJqhoKXaC4L3HtC31xSAXOYfzHEq2aTFT52lzn1B2s=;
        b=mgE9+GvQBRH3zIari05XcJlVmTNJTT/WUbO+P+8yk5mZJ1NBrSPBEOXQ1fV+0Vc+z4
         FPUIat5OAKcwPP0HGXiIwqKTAsBRB+eHcHmXNiRZnDSZUdFFFLhsBtxQ/DYh9wMA/4Tw
         fZIgoerToGJ5ro/BxTbuLPQ7XeYlX/hi/8OOuM2qmiLdNW9ifCeT39swFYeIHviabE1A
         HoMlzIFfiFvFXOIhKCLGLC6XtdfujU5nPTHEyhTmLKMdlQFRNG0IzGNhulsP5Wp07v5e
         VzuHaHS9mR4JYwb65WVjM+qqO6JWMUqLwr/2wUMXpVMlw7OyF6QnoUfV5yFVWVOMn2mx
         NZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150614; x=1688742614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYJqhoKXaC4L3HtC31xSAXOYfzHEq2aTFT52lzn1B2s=;
        b=LCeSuf43HX+EUmYP/1zMzm2fRVLOSbZOdn9xwBpPwBlkiAjD44zBaVct/BiTLIctYP
         WsQImY1zsudx+alqesZxPuFYoWh45D+wJKfjzIFdMzRjHGJu/nih5xVTgBZwXBC+Vj6s
         VsZLqh5bxWUUWvIAadVIycfrGYlBJzMWDzT1UuSWouG+yF4FUXEEKrypdy6Xd5hoCJgT
         Wp/+c1f8FApF8t3irO5hRk1QbIAkaYoP9dBNeN3kq+Q5m/O164uq4BflEPnVkU9NE7km
         87uq0TksHMeBQZ7al2YfLciZMBC/3SYJfNVOsuvRZQJ57H9RsuHg6MyOo0LGLmMQViHW
         ul6A==
X-Gm-Message-State: AC+VfDw9ZhiX9N3wTyswARg7n9cB+D72mxDabUQGgHZO/eJFvXTezEwH
        VhhaZgdnAu/av/fDUZaxsZ5nhg==
X-Google-Smtp-Source: ACHHUZ44Da3K0ioAg/XbvI0Vd3z82OxCYmqb10WD28MALYbP9uc5wTra1eZdRd4kj0dd6UlheM7nmg==
X-Received: by 2002:adf:dd06:0:b0:306:3ded:2bf1 with SMTP id a6-20020adfdd06000000b003063ded2bf1mr7476716wrm.60.1686150613947;
        Wed, 07 Jun 2023 08:10:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h9-20020a056000000900b002f9e04459desm16017306wrx.109.2023.06.07.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:10:12 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:10:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Trivial code cleanup patches
Message-ID: <c7cf6067-1940-45a9-8c8d-42475648017f@kadam.mountain>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:31:19PM +0530, Yogesh Hegde wrote:
> These patches remove variables in the struct rtllib_device that were 
> set only once throughout the driver. Instead of using these variables, 
> the patches modify the relevant code to directly call the corresponding 
> functions, eliminating unnecessary indirection and removing CamelCase.
> The patches are required to be applied in sequence.
> 
> Yogesh Hegde (5):
>   staging: rtl8192e: Remove variable SetWirelessMode
>   staging: rtl8192e: Remove variable SetBWModeHandler
>   staging: rtl8192e: Remove variable LeisurePSLeave
>   staging: rtl8192e: Remove variable InitialGainHandler
>   staging: rtl8192e: Remove DRV_NAME definition in rtllib_debug.h
> 

These all look good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

