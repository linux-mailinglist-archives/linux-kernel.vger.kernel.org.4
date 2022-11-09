Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AC6227B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKIJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:56:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8F19C1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:56:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g24so16632473plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OrF8dH4eiZS9L3s0WZftm0o/EO5zf8rOLBRrHL6Sgk=;
        b=UfQdVdb9j523nu0DU9BEjD0S3rH/cUK+pofD3d0h9hFKs3F/K4EXQUmtY8f7+WETW9
         gequo3sOKgP+CBEUrvC+X3MWGADLF51b7Y/4Yc4lho8Fp8itkrBGXFjV99s0eK5UelIL
         rzgdgQo6K2dE/RUl8WKEl5VnArr+cfVSZVylY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OrF8dH4eiZS9L3s0WZftm0o/EO5zf8rOLBRrHL6Sgk=;
        b=GYA7+L3JjOORF4YLOcnCBHcp2/g7jrNQx3PaOQ2QhUvEpinpjlvjFEJDFtlRwgugxH
         5kZzv/SZDJju3h8VlOWW9bwKP425SDMq1xx4EFHKvTtP0izeYctkue9UqEnobTIgBrEe
         9bPpyUeMVUFI2i0hZyDZv9RFaONzTgYnJmESmcXvreVl2tREtauKXm65aHTblbSNPEdu
         8T8zWpaMErMBl0CZQnpVfXCy8TADaotucRVNM7NyUAyE5Gp8MAZuODzwD0UZ9wkntkVj
         xLrk45HzDA1VW1pwppFIWuzxCOSTCvyfvfUMyslLGTz0EuvLfNLpPuJdmVgb4ZeANX+J
         0aXg==
X-Gm-Message-State: ANoB5pnjbw8P6TFmLo8ceIsspGfTOd2gNGWMScAqOO8Ghhc8z7Jqv4oL
        bHc3vr93z/QEdeSlO7Oj7AvTHw==
X-Google-Smtp-Source: AA0mqf6PiYdLhpF666M7VNwWUnrYO42eGbuAHrm0em6JnnekdoRCAbfsdilmDvZDDSmatRzbcqDUbA==
X-Received: by 2002:a17:902:9f98:b0:188:6593:17fb with SMTP id g24-20020a1709029f9800b00188659317fbmr28111548plq.173.1667987783369;
        Wed, 09 Nov 2022 01:56:23 -0800 (PST)
Received: from b0ad8707f47a ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b001783f964fe3sm8582947pln.113.2022.11.09.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:56:22 -0800 (PST)
Date:   Wed, 9 Nov 2022 09:56:15 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Subject: Re: [PATCH 5.10 000/117] 5.10.154-rc2 review
Message-ID: <20221109095615.GA947857@b0ad8707f47a>
References: <20221109082223.141145957@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109082223.141145957@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:26:53AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.154 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Nov 2022 08:21:58 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.154-rc2 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
