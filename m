Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E368893C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBBVuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBBVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:50:08 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BF1A95E;
        Thu,  2 Feb 2023 13:49:26 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id j21so2632758oie.4;
        Thu, 02 Feb 2023 13:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXW7/lUbSjpYWVlJlGqM54KI3OSQHsjjhBbib+nvF1g=;
        b=3RJNa7koinc7mEk3ppZBfApN6JOlzUaRZIAjEebEfqQNyCM3TY6zeGKo/qeiEu5F8t
         kpk/9O1CAybIN6q7LnhNALvQBzv1MoXtqPWjagTfCODulKJwiJOd+85wzJZGqOY/sxvl
         TNkCY+GHTg15Ifjut/H5MdEYXDQuhRJ1yZpyFNPwysiNlRSRcoKs5skUZ+ynNlxgRAPi
         y6B8GiSTTuUMKPSR30Jd2uq7o7g/lgNOt5vklPHrQptp47SP9UDeU0sYjJnawTK3/Bek
         sHxi5PG5QqhheWvXJ+wea5ASRQe+PmwYF9Xue6x6izw9istQjYeQ0d1eOqzhbZSYEUH0
         jYxA==
X-Gm-Message-State: AO0yUKWtGEwbDu2NJ6oZ5o9kRfqw3zlqDQ5i8KuyO1uRRUASDgqw0X7+
        ctTTT8LWJlIRvdEVz+3fEg==
X-Google-Smtp-Source: AK7set990Xxf5sx8jmyGReXFqOd7t3qi2d4ril4HjTaHWa86PG/UDSm2/3qj0/UOtZb8eORu+AVCUA==
X-Received: by 2002:a05:6808:20a:b0:35e:910d:10e6 with SMTP id l10-20020a056808020a00b0035e910d10e6mr3670327oie.9.1675374519648;
        Thu, 02 Feb 2023 13:48:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r24-20020a0568080ab800b003783caeaf61sm169035oij.13.2023.02.02.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:48:39 -0800 (PST)
Received: (nullmailer pid 2780551 invoked by uid 1000);
        Thu, 02 Feb 2023 21:48:38 -0000
Date:   Thu, 2 Feb 2023 15:48:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: usb: rockchip,dwc3: update inno usb2 phy
 binding name
Message-ID: <167537451786.2780496.5603789940127974377.robh@kernel.org>
References: <f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 14:59:35 +0100, Johan Jonker wrote:
> The binding for the inno usb2 phy was given a name in more a common format,
> so update the reference in rockchip,dwc3.yaml as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

