Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173E62CA65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKPUOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:14:48 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CA5EFA5;
        Wed, 16 Nov 2022 12:14:48 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13be3ef361dso21378933fac.12;
        Wed, 16 Nov 2022 12:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ph7xbRwQ12w4B2bLnrj1nDyxiOrSjkZHpdHKrcvb8U=;
        b=IXIHCBqDsNWF2Be+XoBNmsSvoaZb+MtYyX0hNZ1Xid3ABzLAjKUGZduETdA6bYyIRf
         tBpHqfI6FjVHGr51vQwG3TTASicz3xKCE/7VS3EtFUnIAgjGNLmzK0NSlw5HBAYkj0p0
         AFRB1vnMqvwlxHAcTAK9E+rFwPkWSHI1xPHWG/YIBpF4+A1/BfiU8ftjariNPsYQDBXc
         OHJKX21r9/s75EON28XD6pM+7hFnaE1MRs1A5IyXBPiPBIA4yVBygzI5NbFpId3vUnXr
         epVCkz+qmQ9n90+X9skRUheBQv4LD1Ca2ZEqYranXd35csZKgXnWTRye6vKorSTq3duD
         Zahw==
X-Gm-Message-State: ANoB5pmlBKbAidTdV303fjCth7Ek1MZjP5TmlAXRJaYGaLyZrZ1zcEB0
        u5I4nr0qvPp0+HHjgTJtDQ==
X-Google-Smtp-Source: AA0mqf4YOfbiS4pJcvZQNUafxV5P0YpAaVjonuMgilyjikzYklU6W87dLv1dKPzJav7GHumC0Ji9oA==
X-Received: by 2002:a05:6871:404e:b0:13b:a167:aeb2 with SMTP id ky14-20020a056871404e00b0013ba167aeb2mr2719609oab.191.1668629687508;
        Wed, 16 Nov 2022 12:14:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c13-20020a9d75cd000000b0066c3ca7b12csm6898892otl.61.2022.11.16.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:14:47 -0800 (PST)
Received: (nullmailer pid 815975 invoked by uid 1000);
        Wed, 16 Nov 2022 20:14:49 -0000
Date:   Wed, 16 Nov 2022 14:14:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: thermal-idle: Fix example paths
Message-ID: <166862968776.815892.2892622787261492597.robh@kernel.org>
References: <20221111162729.3381835-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111162729.3381835-1-robh@kernel.org>
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


On Fri, 11 Nov 2022 10:27:29 -0600, Rob Herring wrote:
> The reference by path (&{/cpus/cpu@101/thermal-idle}) in the example causes
> an error with new version of dtc:
> 
> FATAL ERROR: Can't generate fixup for reference to path &{/cpus/cpu@100/thermal-idle}
> 
> This is because the examples are built as an overlay and absolute paths
> are not valid as references must be by label. The path was also not
> resolvable because, by default, examples are placed under 'example-N'
> nodes.
> 
> As the example contains top-level nodes, the root node must be explicit for
> the example to be extracted as-is. This changes the indentation for the
> whole example, but the existing indentation is a mess of of random amounts.
> Clean this up to be 4 spaces everywhere.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> The dtc update is in my tree, so I'd prefer to take this via the DT
> tree.
> 
>  .../bindings/thermal/thermal-idle.yaml        | 154 +++++++++---------
>  1 file changed, 80 insertions(+), 74 deletions(-)
> 

Applied, thanks!
