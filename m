Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47D35BCCA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiISNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiISNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:11:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896315FE4;
        Mon, 19 Sep 2022 06:11:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h188so26701674pgc.12;
        Mon, 19 Sep 2022 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=oYdAyRVCB8IiQtsMexPF/KZiyEIejrHZQnzChkAD9Xk=;
        b=fL4889UXtvXQUkR8X8LJNh0I/r8tO2TzBZP86JK7zXbg/xPaTq2vJugwGeQ4x/bzka
         /qjXCUH2Ry+uZo6xNbkL/PWYJos2jcxJPKz9A8fNtu1eby7H1jTky4m41dpFwkuTyK6i
         1pQeEiWWX7SnewNCGBUd7iBPjkjaBB82VmDUV6WZCeIJyaLO9r+xADJuLVWgDPltyrP7
         /O3BYQEVYccCvPeG7HjBnEMxd9Fzu5KH3YtqzQyxRkutSsgy3u0U87RYQiXlvOYl/B8D
         a+frBgKgtvaj1R6Q2PMMZMks/3a436daSdzx8FSukifrOAaJAfH6padeQKEcRhDOuJhX
         VTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oYdAyRVCB8IiQtsMexPF/KZiyEIejrHZQnzChkAD9Xk=;
        b=lo1mcDfZbvObywvOg8Nj5Gg30Qn9mw7bN9RnCNmzH0szFd2b49qJ+4Dx9BC6B+orN8
         KKtxRXP6FCZaARHjpwA1G8dPQl2icdvSWmjnrs+jaSenjhrlY67uXiYWY2xzdxSF/dFa
         dr9G+zcZgBomcJ6DjGBemQDhoFTHkkkgER+SusGxdxghKaMhiy0QweajTcRLD02C5Mtb
         2I953saxDr9zwVopKHQzOKyzxaOH1t0SXAwVjvEP1LNpmqiIEBVqZNm0q/wKgX85C9Rz
         H8bvvanDhMjWdT+pm3OPkYSRDhoGwkZm4CRYBXgQht3OFiwal6mHBGYx5iC8p/hfv+4a
         9C0g==
X-Gm-Message-State: ACrzQf06CrFw66EZy1Bw8H1at4+RLGp5MsXK/UXUzsyLImpQRU5MJtD8
        rQlMkiX5ttKdArk3YC94fMo=
X-Google-Smtp-Source: AMsMyM4IqfVf1cdtB4Fk70f44o+IkdRtFuz3fCPZjAvkcbMP60kYfg+PoLj+Q16Gw9abKGjMHt+TwQ==
X-Received: by 2002:a05:6a00:22cf:b0:545:90f3:8b96 with SMTP id f15-20020a056a0022cf00b0054590f38b96mr18678836pfj.58.1663593091289;
        Mon, 19 Sep 2022 06:11:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b00177e263303dsm19688881plr.183.2022.09.19.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:11:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:11:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 15/21] hwmon: (mr75203) modify the temperature
 equation according to series 5 datasheet
Message-ID: <20220919131129.GA3545737@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-16-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-16-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:43PM +0000, Eliav Farber wrote:
> Modify the equation and coefficients used to convert the digital output
> to temperature according to series 5 of the Moortec Embedded Temperature
> Sensor (METS) datasheet:
> T = G + H * (n / cal5 - 0.5) + J * F
> 
> Where:
> *) G = 60, H = 200, cal5 = 4094, J = -0.1.
> *) F = frequency clock in MHz.
> *) n is the digital output.
> 
> In code, the G, H and J coefficients are multiplied by a factor of 1000
> to get the temperature in milli-Celsius.
> Final result is clamped in case it exceeds min/max thresholds.
> 
> Change is done since it is unclear where the current equation and
> coefficients came from.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter
