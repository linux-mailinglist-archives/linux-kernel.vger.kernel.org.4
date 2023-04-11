Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4E6DE4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDKT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:27:32 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A32D77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:27:23 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1842e278605so11080414fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241243; x=1683833243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1eAdp/I0aDJaClfj56jDn9XsLib7h19SWH5xa/8CVA=;
        b=KDcOCUiucD2It4b7Mdk3wmVs8A+HLJ29158+2mPNZJHIdkVzvI0Gog+QAE7zLOhzcZ
         jg4QsToJI+wEZti7bNue7X/xNygOCncMkzDOCvJ7VMbHJtBYFpuZW5yjVlQsZQvHYwEV
         RdAnqmC28qk6xUth4I6HfLWzHE9eDq+DnE1OIjViX/vCB2+q1Hdfi3x1zNhRIp5QZHBa
         hESZ+k30CNhGUXfepc3L8toKstlrCvpVnUhmXVU44pusim+lSUTcLRYVUDOMMtMsTnLj
         UUpFwB1Z07hIjqlNLNFAF1+slMAxVfL/LvHQaAljKbx0Mib69o/8Uk2OjHooNAXH8bWX
         GLwQ==
X-Gm-Message-State: AAQBX9e+JXkexVzJccGVIWA7XLc7FZpl5Ip6NmXEswU2KstNkz3HmULA
        JbgzORiAWYQSsHIIhzWDonsYy468Gg==
X-Google-Smtp-Source: AKy350a/XRGgYdvvMTdA5ZD0ypJ7psDsVIk0vml/++RBfuOgyoqPVElvgOjVClXLcPaJCW66pPS9CQ==
X-Received: by 2002:a05:6870:d0c1:b0:177:b6ce:1e5a with SMTP id k1-20020a056870d0c100b00177b6ce1e5amr9567020oaa.32.1681241243173;
        Tue, 11 Apr 2023 12:27:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yx21-20020a056871251500b001842bb0a01csm3514755oab.27.2023.04.11.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:27:22 -0700 (PDT)
Received: (nullmailer pid 3612258 invoked by uid 1000);
        Tue, 11 Apr 2023 19:27:22 -0000
Date:   Tue, 11 Apr 2023 14:27:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] bus: vexpress-config: Add explicit of_platform.h include
Message-ID: <20230411192722.GB2963980-robh@kernel.org>
References: <20230410232727.1562115-1-robh@kernel.org>
 <ZDVukW3cPlr_7sre@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVukW3cPlr_7sre@e110455-lin.cambridge.arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:28:33PM +0100, Liviu Dudau wrote:
> On Mon, Apr 10, 2023 at 06:27:26PM -0500, Rob Herring wrote:
> > vexpress-config uses of_platform_* functions which are declared in
> > of_platform.h. of_platform.h gets implicitly included by of_device.h,
> > but that is going to be removed soon. Nothing else depends on
> > of_device.h so it can be dropped.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> I'm expecting Sudeep will pick this one up through his tree, if not please
> let me know.

I have several other drivers/bus/ patches, so I can take this too. Maybe 
drivers/bus/ needs a maintainer...

Rob
