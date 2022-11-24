Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC146371BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXFYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXFYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:24:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF47BF824
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:24:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b11so523342pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 21:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUP7Am6dqKQpcjzJq6n2SpwU7duYqMrmSYTw//dN1jE=;
        b=Z0mxaK7mlfH8Yar65Mnq4TMvrw6J4J4efzZFOX/tgsJWxdp5QS350PG+K1obsGeTLs
         nwYWMfWQKWgPN0p16aOlnN9Xp6IuofS5E6iGDi753bhKMKHkUZYzSP1ZEh+OIrapb8c2
         qYI+knxRKQq07uf9uBlAYtLcSEoWCg8RkisveC+WiXsV8IycvUYvp6/a4u4Itt9clCph
         Eo+55y4Mf6Icq+oRHYI2i9YreOoYxyWmQ+KuBkjf7aqBthfIgAQgC1y3lPUd3qBJ1WjJ
         Z2F7ot0w8x/qX4yEaXZoXrScB6wy0vMRShosHjou+nIG5ZuFZQvQ7Lvh+Bp9eQ6hRnk6
         LDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUP7Am6dqKQpcjzJq6n2SpwU7duYqMrmSYTw//dN1jE=;
        b=VJtZpJjly5g1sHm/utAo7HMVdWZHzOEJRn96cUx7rwTktDi0E1/y5U+F7nF9FnzuU5
         lC6t7xEibnn+IpNPmpdODaccnk8XZDU779JqHucxEgA4oxokuwCx8IBQjtU7iub1BOab
         VDwraGNBKejxIOv8huc2YmgBeQlN2gXU1v27taMwjHOi2ImzdYHzgF+tAoCjMI1+kjai
         I1+eFxDk7sEoDRFM4GlxF8c/KcyoIPsQJF/zntI2BEgrTNowi7tJt9tTCEYj+BLZ+6KT
         nyVQ/7NVyl5LBvqhXQ8s0D0DWTum85cW/lqyZKOdatI1qpjky9HBLx1kTQCdifljAcf6
         n6VA==
X-Gm-Message-State: ANoB5pniL8KwLo8fbFGU4tsoSIIAFIUY8/Kk3MQByKYwlVIwRL9avCOW
        qaa76zJ4+bhumauOqqISVX2c
X-Google-Smtp-Source: AA0mqf4l9NPUP6hc/93wp2DgPah9wde9Y1AD7ULpN3RN77cOgH/3wyTWu9HsVxGuzHuTSSQ1wwGvHw==
X-Received: by 2002:a17:90a:898b:b0:218:bbfb:72e1 with SMTP id v11-20020a17090a898b00b00218bbfb72e1mr16563515pjn.64.1669267491235;
        Wed, 23 Nov 2022 21:24:51 -0800 (PST)
Received: from thinkpad ([59.92.97.13])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b00213c7cf21c0sm303574pjt.5.2022.11.23.21.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 21:24:50 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:54:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221124052443.GA5119@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
 <Y3sryFh84eK/sWKF@hovoldconsulting.com>
 <20221121083036.ppwfprrheuf7xl7c@vireshk-i7>
 <20221122132633.GB157542@thinkpad>
 <20221124042304.pk3rh7nfkanhlgsm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124042304.pk3rh7nfkanhlgsm@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:53:04AM +0530, Viresh Kumar wrote:
> On 22-11-22, 18:56, Manivannan Sadhasivam wrote:
> > If there is no .set_rate() callback implemented by the clock provider, it won't
> > hurt, right?
> 
> It shouldn't, I guess. Well, in that case, is the first patch even
> required ? Maybe we should keep it, this makes clear that we won't
> even call set_rate(), irrespective of the face that it is implemented
> or not.
> 

I don't think that detail is required to be made explicit. If someone cares,
they can easlily find out by glancing through the OPP code.

So IMO, we don't need patch 1/2.

> Also, the clk provider may not be part of this file later on, for
> other SoC versions, and it is better in that case too.
> 

We cannot predict what the HW guys will come up with ;) But as said above, I
don't think it is necessary to to make it explicit.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
