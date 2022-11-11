Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5664625F77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiKKQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:27:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301977E4A;
        Fri, 11 Nov 2022 08:27:54 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d7so859154qkk.3;
        Fri, 11 Nov 2022 08:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwi5a4EeVLwNH8TsDU2iURs6gMBXFninZhcpZAryrJc=;
        b=RqiU2lUFVF40jBACbBIK0c2oUL9FbFGhEyio4P/E/NRsq39HNX9c5LdWmxy1SN5X1s
         ZKtePxySfD6aIh/7m9Rd0mdQPYgM8J89rmgKh7Rx7D3W6XTCpaFsAFBAKtnjct8xLR4J
         FQ5bk4YoIfRyGrkHPDyHs7OntpLqagoyZgKAxV2y8QrsMRDC8+ELRS7tn83/fzw7q2rB
         PkmKL6Qjd6envuJ9VoL1biQGw7Y/SFt6HDRpYiLybLX6U4usJmeEU2UzvVg3r6OaYDVf
         26o8eKiP7uwi8EhFhWpVjHJ/XcOIyKMqKT2FL0jUs1RQsO9wCayOSufpFhhHTsAUW6cd
         mn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwi5a4EeVLwNH8TsDU2iURs6gMBXFninZhcpZAryrJc=;
        b=YelZG+RHLUjCdUzjIbjnXEPi1lGnUyX2OdoLrmn7oRfdgvWTWlE5Oc4ydPe5ru1xSd
         ihpFUrxXcKMvS4AR+vgIoPSCPXnEUHYcHc4TdOsPXNx16K0JoYo6K0zyKpyU3RKi0WjB
         jaNAeVY6Np7ku030YqWSDJfPEldz9SiYOcygNzCxQgU5yke4/MVn9zMTIG+8Em0xBfDp
         wACcZVISWw4lP9uSXsAYIb9w0b4F8URWdf/6NLof3JG+0aPfNSnzR0u46NnKGr9ammLC
         JwHgj0Fq0qZx3hg6ELm3QhCb0C1M5JzQDL/SXuEVuZ24swa1nd15JwM1IwJlz8tABPwj
         iAEw==
X-Gm-Message-State: ANoB5pkpRBW0tjb2Ir3ImU7WyfxybI2yYthGyXnoeGMCqgp+VwpGSmeV
        LPg9M0poN3avJuznYarU+TxPVYjUiD0=
X-Google-Smtp-Source: AA0mqf5+GBU34baLMqJL/YUHL/7dCwSejX37aBGTALP3iOTFiuFxropjjSLiOTOwYRSHnmQVQNqhaw==
X-Received: by 2002:a05:620a:78d:b0:6fa:7d46:33ad with SMTP id 13-20020a05620a078d00b006fa7d4633admr1698559qka.278.1668184073616;
        Fri, 11 Nov 2022 08:27:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b006ce9e880c6fsm1589675qkc.111.2022.11.11.08.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:27:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 11 Nov 2022 08:27:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: Fix shunt sum critical calculation
Message-ID: <20221111162751.GA275294@roeck-us.net>
References: <20221108044508.23463-1-nmalwade@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108044508.23463-1-nmalwade@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:45:08PM +0800, Ninad Malwade wrote:
> The shunt sum critical limit register value should be left shifted
> by one bit as its LSB-0 is a reserved bit.
> 
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied.

Thanks,
Guenter
