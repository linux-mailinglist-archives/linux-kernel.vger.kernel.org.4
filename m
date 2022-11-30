Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733F63CC99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiK3Apq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3Apo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:45:44 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCB6DFEF;
        Tue, 29 Nov 2022 16:45:43 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso10263524otr.9;
        Tue, 29 Nov 2022 16:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlRj9L4gPlL7jJ8/7Pb5E6XtZMfbxof/0/XlLRIjlek=;
        b=4a2nOP/uGMFZgWJ7X4E6+AshspSZbsRFgmqKNWn0fyrcuVJ4FWHYCG8f63+YQroseM
         EQSbI8Pkja+Ina0yu4XGLOoi+t8olBNbzgnAs417SD3J+m3oZuEKQYd0xWrGEJYy8ODL
         TDHIM+d0aL2p1ZiusqhEVkUm8SrDTj25sWVQ1rGqqrYfa/4PnVysSZmPjihOuKq0kr+6
         esi2r3ru3Zn7t7LkwSfM3Bdb7olXhPtOl3Iu0pSgR6qoRdXlpfNKfzXlLaXJpaE2mCy5
         orxg4g9tag/mrvah27/UarBbwC6zFeWBpv4CKBFpgmgNB+O5wlSYsrJoVoXw16oCcXN8
         0pDg==
X-Gm-Message-State: ANoB5pnE0Xlt78U8lPVgu+frvKiAkUGe7Kbtib/rBh4H9REPS7UQ9u27
        hxTZ8kZz60rhxFb1teT4oA==
X-Google-Smtp-Source: AA0mqf52PnpB/uwrsJxq7yLUSVKTk6h9aJ8vMEKCQuSI1A/k9qjW6WtFfYOZzdFYnf0coJ+mbGzEzQ==
X-Received: by 2002:a9d:51cd:0:b0:665:d7e7:ca59 with SMTP id d13-20020a9d51cd000000b00665d7e7ca59mr20042198oth.348.1669769142725;
        Tue, 29 Nov 2022 16:45:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b38-20020a056870472600b00143ae7d4ccesm149216oaq.45.2022.11.29.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:45:42 -0800 (PST)
Received: (nullmailer pid 605002 invoked by uid 1000);
        Wed, 30 Nov 2022 00:45:41 -0000
Date:   Tue, 29 Nov 2022 18:45:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 04/20] of: property: add #nvmem-cell-cells property
Message-ID: <166976914091.604941.18302574495918409424.robh@kernel.org>
References: <20221123180151.2160033-1-michael@walle.cc>
 <20221123180151.2160033-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123180151.2160033-5-michael@walle.cc>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 19:01:35 +0100, Michael Walle wrote:
> Bindings describe the new '#nvmem-cell-cells' property. Now that the
> arguments count property is optional, we just add this property to the
> nvmem-cells.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> changes since v3:
>  - new patch
> 
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
