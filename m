Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D566B27B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAOQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjAOQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:13:20 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C13A72B8;
        Sun, 15 Jan 2023 08:13:18 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15b9c93848dso18764669fac.1;
        Sun, 15 Jan 2023 08:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKDWNfyaCCVlqTNLhcNrknSAUVDiMextrN4qIAT2sVw=;
        b=ciJQkbJebkxZGds0qPuqu3bQPB6g0z5hzjptry52/3kRDFyk0y6IMbAunHIfR9kEtk
         rPsS3L9o+fEdFYkJ+dsrG2UOw+Tp+vOkcSg0V6E0SUFigis4b8Zpf2dVp2dz5dBW7vWj
         XeN5d1Y/RJ93IYcXchAUhCMPunhGglcW5NIwUx+XrRDe2mdZfciSSRn/pn0fDMB9xcff
         Ml/c1i8u3nfBkvLRdp20lDLcnBfEUDvlh1Vje7Oa9qsT/u48+bdGGnNn2okOJCMmXVkJ
         RFrRegh8rAhzkA5YHxqOOHemVdhUX3ZfE38baPyNKa3dqeFzVvSAC/Co9mS9/DKqv2M+
         W3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKDWNfyaCCVlqTNLhcNrknSAUVDiMextrN4qIAT2sVw=;
        b=MXlgE+6qQdY/OZqBM+bHFyuy/iXsvxgG6ocmRqttTAf/FcxtI/ZQWpf3ZxNdkvZKGI
         ZOrwyV3RGkjTUuN8RJ/IgFbyFt54GNa43pI4hG2qNBfhgNUQSTGFe5gLQsilHd9CqAvo
         zSZpNg8MNpuUgxK1cFKAYDLEqvLEuGqLM8uF+c9eCD0Og/Cr2gCAF+HmYi5ezYBb9UkI
         KHnJq1XbkHG7wfJF8aMsK8FUbI+469GZJtk8dS8DELGBSgFDL8p17fJ5CHtMsCzJcRKH
         9rojEmaIx1KNBNly+q7DO2TQvxBzIGxj+P63iVgB+oqiTU9aLtku9tP8qVO8gqSWxh/g
         b24g==
X-Gm-Message-State: AFqh2krv3sWWgOwKWtncgRwuFz/CLIUBgEXkjMiUslfnb9ouGdRA4Iwz
        Ob1xmDuLta3Ee0MhqUp4lOSDu6Nt8U4=
X-Google-Smtp-Source: AMrXdXu6+ZKqabhHWDfj5mCvlJ1iBpEAASg1GQkQc07c9T86jozs80H1dDgkNScnxntjc7vCl0bp6g==
X-Received: by 2002:a05:6870:7908:b0:15b:9ab8:2cd4 with SMTP id hg8-20020a056870790800b0015b9ab82cd4mr13406252oab.44.1673799197884;
        Sun, 15 Jan 2023 08:13:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z36-20020a056870d6a400b00144bb1013e6sm13222236oap.4.2023.01.15.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:13:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:13:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: ibmpex: remove unnecessary (void*) conversions
Message-ID: <20230115161316.GA1246652@roeck-us.net>
References: <20230111043605.3726-1-xupengfei@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111043605.3726-1-xupengfei@nfschina.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:36:06PM +0800, XU pengfei wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>

Applied to hwmon-next.

Thanks,
Guenter
