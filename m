Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034845BCC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiISNBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiISNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:01:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D52A71D;
        Mon, 19 Sep 2022 06:01:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so7055666pja.5;
        Mon, 19 Sep 2022 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=YTtCUq1JvQDVmHZewtiGcwtU+Cnugfd0XFUBlZ4h+dM=;
        b=nTtnG4kLwdJgN5nnx71NP33ZtXfNGaMH5Sf36jxpkdceNHJSFxdq81xO/tRYuG4LGJ
         mb/8aVmnuYuvp/u/YLCCMllXaPrjYC/vPOD6Ty0cVxK3aSZEJqh46cTrr1Zp/Kpth4ad
         JIkeAk5W+PUAQG7rc1kuHU1cgy/LqBL7IAkql3oskMOgbU8VOT/03m4Sge2Fde+Waxfr
         BVDnxAPaItKIamVo0pBOdFAqGyStRDPsfaiH7mrLgZqXJwJlpmxl8Eakc221h6oI/tMg
         TB+vgXgf7qtAoaz4SNnkvuZa7Fmbq/lLIPdUECe9e7rfCCqBFJeVs5ib5TE6cWMMsKQa
         VNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YTtCUq1JvQDVmHZewtiGcwtU+Cnugfd0XFUBlZ4h+dM=;
        b=obTdtd/gxQh6tFJUtBs+PAogTTptM5NTm2LEcVX+K8goeWjMEtkC/DxhU8h0lIqA39
         GtYDOqv/pzPDb7Zxl0/glsRbg5Wy0DtadXDspCMqfj/Hc2SQvki0/fy7BCGLCdcCLV5a
         6z05OF5boALp9HlgVYQ0OZhO0MjCgrOT1ixkjqHpQ7i32pASUCUEDiC3C7XW454pyoP2
         wGa+Bhh0VrE5Q91rrF9TlVKUuqdwmkFOcdgcNArjKkDR4iN4Q0oDVnhz+XL1tcJC4NhQ
         +HmXCSOoal0ip7KGFXO/537wLyYLHQ6FUwVOHOk2KmOU0KtYh84oJKAuQOmV+kjd6xgY
         5wQw==
X-Gm-Message-State: ACrzQf1XQwUY5wNQSTXonp22FOsVbaViOSPmYr/i5XOOkd+EJ9SnkYjj
        HNxfb9PDGp8qmIbdHYA9hCo=
X-Google-Smtp-Source: AMsMyM6nlxWWPziGhWkhJYvA5lPF1xeTcrH8pY9f5FQmbbBwkyn9eNkd0jpT2MoLfpZ2dSaTVa/opg==
X-Received: by 2002:a17:902:f710:b0:178:a692:b1f7 with SMTP id h16-20020a170902f71000b00178a692b1f7mr2038867plo.112.1663592490659;
        Mon, 19 Sep 2022 06:01:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b00176cdd7e4c6sm20613367pln.50.2022.09.19.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:01:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:01:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 13/21] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-pre-scaler-x2" property
Message-ID: <20220919130129.GA3544643@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-14-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-14-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:41PM +0000, Eliav Farber wrote:
> Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
> the input voltage, so that it can be  presented to the VM for measurement
> within its range (the VM input range is limited to -0.1V to 1V).
> 
> The new "moortec,vm-pre-scaler-x2" property lists the channels that use
> the mr76006 pre-scaler.
> 
> The driver will use this list to multiply the voltage result by 2, to
> present to the user with the actual voltage input source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
