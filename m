Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82325BCC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiISNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiISM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:59:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762A13E30;
        Mon, 19 Sep 2022 05:59:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so7051812pjk.4;
        Mon, 19 Sep 2022 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=YNt8+foQS2chAjHo564jIXESLiHgQodRvfR3j4Rul4g=;
        b=j0mPp7Kt1lEaMM9Bm+HY2+p5RqTuaPR/E/d3OVCJf2xwAvIL2Ghh4GCxcla/y2Qe8r
         oJ0Szlc815o96mvdt+suyYdPLntQLH/y0sl9bJSaXdsz1FFxgCaJ64oxkWXwHTWping/
         B8pEr1MeZ6IO+9T0t3gzbB+p2rMnT0KwPhxMKc2pgPHFpJkhvyqMFz4O2QFIjmJuHemE
         avnieyzOg8QbIiNhZQLaKej/6ZoG7k3Xv0/3CGEpd+ciQs3oDlGHpg3Xri8AZ2+4tIHc
         tdiih/VNFyRYeT1RHcf6/sHQJwEOp0r0AKzZr1uSx+fmC3i+0blez4tt677EuIv5VkfY
         IZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YNt8+foQS2chAjHo564jIXESLiHgQodRvfR3j4Rul4g=;
        b=NtJasOGH2ThqJiM6nwgOVDz0OnAGgSgyAcVLERI+BzqHHZP1T3YgHr1ls3wKkPCtmI
         RTFgQjeK44Mzvfuaespx6CWE7dvBIG2Ov81NSglQ1DopI7MemLL9GzKBXeH8oD8wZonS
         p6ZjmRdfrc0at4Id3E8vRiJvGaLHbXs/ujMV0RElc75VDbztAHSAoY3yANJ1sNOBg83k
         +v3kVjaScaAFURL55SreHhs4fKGDHVaROuMuS7lXZU5kOq9v+XCBgjzBIhLKUBNeDOaD
         b/m8ULumQLhQWYGFGMHpxz03QwnFe3lIojt3mPUt7lyb27npRHRtqQB+zXNThhXNjOEG
         5rJg==
X-Gm-Message-State: ACrzQf1fbW0EKGAJtX0A6i3hdlebdo1oVpEXzJwm7x2q6wqDelplQfxg
        kuz7QPyK2MPV91lwLiR/gfE=
X-Google-Smtp-Source: AMsMyM7MP5sjmEzVC1Cc0kWzkleQUW+biJmsPH4YxKYx/ozfY/4J7332LuLB2vp1lBb5kJ7SIJTEig==
X-Received: by 2002:a17:903:2441:b0:178:4f51:1f78 with SMTP id l1-20020a170903244100b001784f511f78mr12726133pls.82.1663592396125;
        Mon, 19 Sep 2022 05:59:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2-20020a620402000000b0053788e9f865sm20229438pfe.21.2022.09.19.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:59:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 05:59:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 11/21] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-active-channels" property
Message-ID: <20220919125954.GA3544363@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-12-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-12-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:39PM +0000, Eliav Farber wrote:
> Add optional "moortec,vm-active-channels" property to define the number
> of active channels per VM.
> 
> This shall be useful to avoid exposing sysfs for reading inputs that are
> not connected to any voltage source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
