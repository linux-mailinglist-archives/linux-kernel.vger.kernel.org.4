Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67272C830
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbjFLOXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbjFLOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:23:13 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A649EE;
        Mon, 12 Jun 2023 07:21:15 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33b1e83e204so20420435ab.1;
        Mon, 12 Jun 2023 07:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579630; x=1689171630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whh7sWJ9ut2fwP7TlcpZvfyKdlzSdzBic6PhUsBhS+I=;
        b=CFfMy+/TcuUTk1bUxhh2GO/Imgf/X8pHC9NkGIqKt1c8d5Le95EdsdlGrvzCrFtbJG
         rpal0TqSsCgI/9gDVbwWVkhBnF5pC2WWOHEO3qbm16ivjFHp1Ut1EPw+bAKvEgxCKttv
         e2dbOWynQSmqIl5HTgsbaeEZtBZ4ggauAXgFAI7toE4HFzpzpPtBgmqSn0wnl1vLKcg4
         cQoO7SfcgFWaj0Vyu9XumyGwISS2jTOQqJFG2iPSZvMTAmbDxjD3fOyRWljuO5rbnwBm
         /+1TTXLF3f1g44ZfnS6LPHSwgVmQNF4dhqnC72QkuWarA9xBlNSZ+x9QpUt0E1qOY8Rg
         TSEQ==
X-Gm-Message-State: AC+VfDyISAWvUbWpctMWkkknIkF4SQ3uNSV/f+DqA+bG8N4p2EfdTUdx
        EWAxb4xmSohV6P4kylRLNg==
X-Google-Smtp-Source: ACHHUZ7qwLunntDzQ5PKXk7uRAQydjBkyu3/I0+83hO2rXblPogzhivy95UlQZPD7jO7Q7Xphn+OSg==
X-Received: by 2002:a92:c504:0:b0:33c:5182:6d04 with SMTP id r4-20020a92c504000000b0033c51826d04mr7371198ilg.7.1686579630005;
        Mon, 12 Jun 2023 07:20:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t15-20020a92dc0f000000b0032e28db67dcsm3133764iln.84.2023.06.12.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:20:29 -0700 (PDT)
Received: (nullmailer pid 4187175 invoked by uid 1000);
        Mon, 12 Jun 2023 14:20:27 -0000
Date:   Mon, 12 Jun 2023 08:20:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Message-ID: <20230612142027.GA4185135-robh@kernel.org>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-3-linux@rasmusvillemoes.dk>
 <168657279982.4044345.9896354759743085279.robh@kernel.org>
 <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
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

On Mon, Jun 12, 2023 at 02:36:03PM +0200, Rasmus Villemoes wrote:
> On 12/06/2023 14.26, Rob Herring wrote:
> > 
> > On Mon, 12 Jun 2023 13:30:52 +0200, Rasmus Villemoes wrote:
> >> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
> >> intersil,isl12022.yaml file, in preparation for adding more bindings.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
> >>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
> >>  2 files changed, 42 insertions(+), 2 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml: 'maintainers' is a required property
> > 	hint: Metaschema for devicetree binding documentation
> > 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 
> Hm ok. Can/should I copy the value from the trivial-rtc.yaml? Alexandre,
> would that be ok with you?

Alexandre agreed, but in general the maintainer here should be someone 
that has the h/w and/or cares about it, not subsystem maintainers.

Rob
