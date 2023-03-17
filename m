Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C06BE7EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCQLWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQLWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:22:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BD35AF;
        Fri, 17 Mar 2023 04:21:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so4775274pjh.0;
        Fri, 17 Mar 2023 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxKX5ZJpiF04icvSHpZ1JZbirujoxDwuq90/M5FjSys=;
        b=YSJDOLaroYd5w6iQfw3pdh471hY8XPd5FvwTmVPnGRUkl28QMXCHqo/o7llbDurN6W
         jDPnDPltYLthgdu1rM3rv8u0PR9XOIz5HezA9EUENzU8JmPgPI8ozfmT79k0Zx3TlG6X
         /7QNPd73hFIQ6mKIUijKptnhjDagvipVHSkTgX0XKUiKTLuY0MGHz1BkKnPGYgm6lmFZ
         KtnO/pHVbVAJzPtRxOJ3sqzY08tSW8c2E29p19VL/TfoAhT1XLVPzein5X+te5WgdVNp
         Be4wfNIVTgP3xU69HvUNrNOm2v1m4xylYKTeL95Ryggxkn23nUUhIdWvpdF4L1/xqW8Z
         9JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxKX5ZJpiF04icvSHpZ1JZbirujoxDwuq90/M5FjSys=;
        b=H7MvIti2pcQWyfI3fvVeP2koA22HCCJSqAcV6FK2EtFWtlYvQf8CoVj19Crv7pizU9
         FBBzSwuI6c9dCiBOGAVivwQ3YYURRJwnIVl9nckggM5rhsIzyiMOkXaT5NdMeB7txGjI
         uJeSmeauabEKOFGsFREpW2ld9/SoUei897YMaAmvWbaGntwFt5bifQ8QzBPzgSS1ptZv
         3BNbKRLOVsg50ORiHPFt2sRB2ixnTqIzM64hcD6icDg3QPf1ENZr65lg+DMSxg2Qlc1h
         5sIk/1NNZL3juto7+gNtw6nxuyx0MsJiiqUqTptmmWyJurxXIwCsKNC/EIecBOF+FxXj
         XNNw==
X-Gm-Message-State: AO0yUKVWnoO4XYLn9xgrBZYxfaK7oyqddb0K6f9HZNxdeq74+iM+zqRX
        Lvz1pABcvNDU7sakk5gc8OQ=
X-Google-Smtp-Source: AK7set8ja1cWo1D6wJamqoAnRPQ12MFPwJrSryte3yXlsyCvRIdPaGtpd49G2n0EsAW3H9Yz1f497g==
X-Received: by 2002:a17:902:ea0f:b0:19e:8267:9590 with SMTP id s15-20020a170902ea0f00b0019e82679590mr7836526plg.41.1679052093980;
        Fri, 17 Mar 2023 04:21:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b0019a88c1cf63sm1328760plp.180.2023.03.17.04.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:21:33 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:21:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] Input: Use of_property_read_bool() for boolean properties
Message-ID: <ZBRNOgXAS8wC9xSH@google.com>
References: <20230310144708.1542751-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144708.1542751-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:08AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
