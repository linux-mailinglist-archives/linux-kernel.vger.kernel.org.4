Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978387371BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFTQef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFTQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:34:20 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F21994;
        Tue, 20 Jun 2023 09:34:19 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-341d62e78d3so23300715ab.3;
        Tue, 20 Jun 2023 09:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278859; x=1689870859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYYM1B8WZ008PRRYsWGZJgntHIjgR8NgheJyM+29+wI=;
        b=atd5XzzxQMmTbssBWc2AruBUCVIWutwsThpf4lVqLqyxctDa0WKUWbEKerDdj/D3rX
         ocbLjSrFdQeWCMAGqGPGou5Jq29VmuwPeUo+0xdWd7GkD5M91MSYNqcGPJb0r5cVMXNS
         r2B832rLCl8MdKgwD1ZG7nutvI4APFGt5qTfbGLa2S6YNY0SG+PlbLWCeRWCjLaIKJ0f
         yXrXzNV3gxlVpV1XUpZ+MD1Pf875OmYh9geygU3SpOADw3CnKasvjRvER8XLCM77d0bo
         uS/+xm2CXUFZWzItz0R6nYgU8AUN8LKTVgrLUjZVz67tKC0tu8Wrf77ldP2MMWHHXvcD
         mRbA==
X-Gm-Message-State: AC+VfDwbGhZZBuU2E80NWmwrbc9j1O0PZFa+OW4ZaS3KpRg3fQW+bXXw
        x5iUUjejpAX5Rb2o195i+g==
X-Google-Smtp-Source: ACHHUZ6+t2UPXqAsSFQKWOOlowteotBbfJ5qQLgww4AsGzPCbj1xYEXbMQ3AlemNlkbQyMZkKSSZkg==
X-Received: by 2002:a92:cc0f:0:b0:33e:6d38:8f88 with SMTP id s15-20020a92cc0f000000b0033e6d388f88mr12570534ilp.2.1687278858875;
        Tue, 20 Jun 2023 09:34:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b18-20020a92dcd2000000b003312915e615sm704171ilr.28.2023.06.20.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:34:18 -0700 (PDT)
Received: (nullmailer pid 3784097 invoked by uid 1000);
        Tue, 20 Jun 2023 16:34:15 -0000
Date:   Tue, 20 Jun 2023 10:34:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
Message-ID: <168727885502.3784019.6096341617892638945.robh@kernel.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v2-1-26bc8fe1e90e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v2-1-26bc8fe1e90e@linaro.org>
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


On Thu, 15 Jun 2023 12:27:00 +0200, Neil Armstrong wrote:
> Document the Goodix GT9916 wich is part of the "Berlin" serie
> of Touchscreen controllers IC from Goodix.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/input/touchscreen/goodix,gt9916.yaml  | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

