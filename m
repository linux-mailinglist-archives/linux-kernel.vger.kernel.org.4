Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE350724A52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjFFRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFFRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:33:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C156010FF;
        Tue,  6 Jun 2023 10:33:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so33334361fa.3;
        Tue, 06 Jun 2023 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686072795; x=1688664795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NXKJbFz1nKDKoVlMVlm8aQEKkrV2KIiDCqPS9XhHh0=;
        b=ZEw9yUBSxHAopkpmwxzN8xEPjxgsPjv8z8etXX4uAkXqVTLnc7Zqs/nbxm4evTnPYx
         J+Omm0ydUBktRZTLrKqs9LiCkqeCWU3jPapWRXrILrv6PEaGJwrcLIhICnoq+JZQwdgm
         /2NLcUAAIqvEWVR7j+Sc6GZ9DSpn2l2kgBErJV+71vHOi9nZ7Z1AQNPoBTF4C/uA54l/
         WXZRJxlt38eemJkwDbL0qh1xoe/YdOtJc9APQDAKIouLkX+FzxMMXPv2xuMAyB/wo75h
         rLAQg4TkRrW68a7bN187GZBhQmMZjeHy/zG3Uahh8nok66OL4MBimuetJyEB0L2cxtMg
         1Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072795; x=1688664795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NXKJbFz1nKDKoVlMVlm8aQEKkrV2KIiDCqPS9XhHh0=;
        b=MqjeHcthCvAecb8OYQVCg40FlRlF5WGjtFQ/nGTlk9fnbBXVrLq1ZQA8VrE0SaKphS
         IBiR7WutCgwFvCM85R4iHovXcEVHMTimTdYfLY0Imkfrceiw6ordLIuSgebVKFK2o0h2
         K54aCa9qJLYPc5mzflW75ksP44vJjqTztMo88yChgB7Ag6Ig1kAP9oBOr9K0UNdFjJqp
         kMUMKt5ApJkCqKORHoMsV65sR5zmlqciXLx8zQaMajpsTcZg/anTG+VG2tpud3j49MuN
         4ZihUxT2ZBz9vAAtmdk6pnk9xyqRXmI5kfBvS8v3oivhAkHxpDHG41pZmhCmAoUQcNXi
         zUKQ==
X-Gm-Message-State: AC+VfDzAgAbyJYSrAuTAzvb/CnRGSen8XS3sw/eoMrvxoXuUcc6BCtZY
        eHtEw3OtXPDfM6PoBtUA2os=
X-Google-Smtp-Source: ACHHUZ6E4u1pwCQ4bGQbdToV6BQJplhi2ZNf72qvhp2dQ5/aVBqJv5anArQ6qcFH9gKG5ZLw8DKUBw==
X-Received: by 2002:a2e:994e:0:b0:2b1:eb62:ffc8 with SMTP id r14-20020a2e994e000000b002b1eb62ffc8mr1448240ljj.6.1686072794884;
        Tue, 06 Jun 2023 10:33:14 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id d14-20020a2e96ce000000b002a8a5afb87csm1941338ljj.20.2023.06.06.10.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:33:14 -0700 (PDT)
Date:   Tue, 6 Jun 2023 20:33:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abe Kohandel <abe.kohandel@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <20230606173312.wfrowqc7irecow2s@mobilestation>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <168606867693.49694.16483038401822255147.b4-ty@kernel.org>
 <20230606164040.s3ozznrkcclozugx@mobilestation>
 <7696b01e-c388-45f2-9694-e427dde84b2b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7696b01e-c388-45f2-9694-e427dde84b2b@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:47:40PM +0100, Mark Brown wrote:
> On Tue, Jun 06, 2023 at 07:40:40PM +0300, Serge Semin wrote:
> 
> > Mark, next time please wait at least for a few days before applying.
> > Give me a chance to review.)
> 
> It's a trivial quirk for a platform, it seemed more hassle to wait TBH.
> 
> > * In this case I have had a question regarding the in-code comment
> > which may have been needed to be fixed a bit.
> 

> That can always be fixed incrementally if there's issues.

Ok. I've sent my comment in that regards. Let's see what the author
responds.

-Serge(y)
