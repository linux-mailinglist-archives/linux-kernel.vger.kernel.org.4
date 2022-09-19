Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C145BCC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiISM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:59:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE75A44F;
        Mon, 19 Sep 2022 05:59:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so1598669pjo.2;
        Mon, 19 Sep 2022 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=HxFzGiArRHheZlFQ/c+wm0kThIzmb2OPcQ9ELiQbIvE=;
        b=INqflAo20cva3R51TCFuCbxi17656nWLVFEjts0w4PQ+Boo9Wp0HfkRuCVDXVIoLW2
         AcT1NlRqLxfjrYJy/v8m28khVp2HGi/3cxow5dYyc6zBVLXl2tv8uC+2boAzr21LlRhO
         HTuc2xsoIVLWW/uPU7rGq2BX4MmbhW/+9tofXJbEBakErHE0Drin10C4H4TtncF+ZB66
         FpwzNohf/3XKB+ZueRtaIG8u4oWRU1lhumUs/dA3OEcz2buqynVlmpanYXCwpl8Rb0CN
         z9Ifptqc58V2UsYXKN8DjjTKbhrXKoGJ10rvAXHZS3LIpOSffX1inVJK9FIXhaQ2x84D
         jZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HxFzGiArRHheZlFQ/c+wm0kThIzmb2OPcQ9ELiQbIvE=;
        b=dqbijjqN01mpg72Fa9rtMllEQfkO/xfEgyDAtm4/X4T8IjfVhJuXzm4j2CFVexMWH9
         f3tQyFZSwYX8f0HVrz/wh+tnhDPzhsPla1Dl6Vfyk5Z6qEjsvVClxfsHyEyZ3iTycaUS
         FT37QMNNerGECBGJpAJv/7/8ysT4rgqjz7nNIffznljd/vRSsE5ldwiM3rDWaOECHs3v
         7YDoYUcFAphcAw+IfkhA+fFZNUJniRH4aK6T4pFMfEc1wbpFrNMGkVcoK40rdeg6QXNi
         P/bSxeNTZARiWLhLC7Is9/CZcTOnk/L+h6jLF/Mv2LEokVmUUGEKo70XfIAS/d8wYNZv
         Anyg==
X-Gm-Message-State: ACrzQf0/TGX2Peb0uJ1DpDNsYkrjLUQ1TYmqWeeM2cGSrmB5AbO2SrUS
        N9/7695tdgGl3KcoeV//tajc9vWa00y8wA==
X-Google-Smtp-Source: AMsMyM6J42vZz/TicI+QGfpUlGyTUBNh2h1DK4ga7i1wj+Moq12BZSDjGWG9i3vIk3iR+xp2WknSgg==
X-Received: by 2002:a17:902:ec90:b0:178:a0eb:bc7c with SMTP id x16-20020a170902ec9000b00178a0ebbc7cmr4565505plg.78.1663592341692;
        Mon, 19 Sep 2022 05:59:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10-20020a62640a000000b0053e6bda08e0sm20227763pfb.219.2022.09.19.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:59:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 05:59:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 10/21] dt-bindings: vendor-prefixes: add vendor prefix
 for Moortec
Message-ID: <20220919125900.GA3544266@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-11-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-11-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:38PM +0000, Eliav Farber wrote:
> Add device-tree vendor prefix for Moortec Semiconductor Ltd.
> Website: https://moortec.com/
> 
> Moortec were acquired by Synopsys so link above leads to:
> https://www.synopsys.com/solutions/silicon-lifecycle-management.html
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
