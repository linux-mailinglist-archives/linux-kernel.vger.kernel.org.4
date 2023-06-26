Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5E73E6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjFZRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFZRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:02 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BD2965;
        Mon, 26 Jun 2023 10:35:36 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3457a3ada84so15235535ab.1;
        Mon, 26 Jun 2023 10:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800936; x=1690392936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0oU7mb2qfcl9XqvNdYw43GkY7hT4T15jxtCNIJsOfk=;
        b=aspEeUrPmOuOGMklRPEBmS3yujLxYPs4Mwuk66H7FZLW8hUYzDg5obx3r5hX3dKEPH
         JoHL39j/9n7zutYlYIdXaKElivlVuDbt+zCYcxdWVnVrObPyu+h9xDMvUGzYoIHL19T0
         848IZYr7Dp5x6iaLEuuN/24RO0erMYeC8yWjvSF3gVTwOWyxnXag1DosvB+UMNz+A5JM
         DI65qT2ey4eflwalcUWExhiWmEJdq9wS+ihuZ4ndardZNFQPUn8NkRbPYf1jrygoVgwt
         NsBmNX7n1OIyXGFBo9u/USu+prnRflW6JyTloJkI4lFPPZ1rpDFeC4YsCwllVAUzHJql
         tQlQ==
X-Gm-Message-State: AC+VfDywyGAaO/+AbyUPeYNPrcdyvQqUku69rga8iVwP6ARb0tX+66N3
        a2ZrdXolBuCeUXS1E7ES5v9M/RustQ==
X-Google-Smtp-Source: ACHHUZ5nJIU69luq91v3w8PM05iYwzu4yi0b9NIo5hK5Isqeqj4QG468oM6Vph/L0U0gO8PuG1cP0Q==
X-Received: by 2002:a05:6602:19:b0:783:6526:a1a0 with SMTP id b25-20020a056602001900b007836526a1a0mr1713914ioa.15.1687800935788;
        Mon, 26 Jun 2023 10:35:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b007748f491918sm2321521iog.40.2023.06.26.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:35:35 -0700 (PDT)
Received: (nullmailer pid 3434595 invoked by uid 1000);
        Mon, 26 Jun 2023 17:35:33 -0000
Date:   Mon, 26 Jun 2023 11:35:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     amitrkcian2002@gmail.com, git@amd.com, devicetree@vger.kernel.org,
        vigneshr@ti.com, conor+dt@kernel.org, pratyush@kernel.org,
        tudor.ambarus@linaro.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, michael@walle.cc,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
Message-ID: <168780093273.3434534.11377624965513902271.robh@kernel.org>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
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


On Sun, 25 Jun 2023 15:32:50 +0530, Amit Kumar Mahapatra wrote:
> If the WP# signal of the flash device is either not connected or is wrongly
> tied to GND (that includes internal pull-downs), and the software sets the
> status register write disable (SRWD) bit in the status register then the
> status register permanently becomes read-only. To avoid this added a new
> boolean DT property "no-wp". If this property is set in the DT then the
> software avoids setting the SRWD during status register write operation.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> As the DT property name has changed so, removed Reviewed-by tag.
> @Cornor if possible, could you please review this updated patch.
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

