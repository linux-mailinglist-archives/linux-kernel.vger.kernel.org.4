Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D35BCD05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiISNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiISNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:23:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F565EF;
        Mon, 19 Sep 2022 06:23:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so6076614pjo.2;
        Mon, 19 Sep 2022 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=kQ9CIFj/0yA5lkn2VQDlB4wF9y682X7kblGc6IlYdLs=;
        b=imv1x9zOiNdwNVv/473fQF0caYYghCltiFB7sA/mgGmfR1SLiKl70TXO4tanHmHnL9
         AnanfVYlDZ/8rm9MY1XPvNT17aXszSuBv8OZFrQ+44X8brkDlR5d9zfKFrllpOobnYuA
         vBL22RTVvz39vJDbF0dqL5k8RLBXManxe/70NAcitMYrN1IkuOhlzEBBHHh8KqvqbLzQ
         y2PH48t5lchwqPhw5MPAkwpkfosAFgxBGMWKpVaMxaXBz2Ir5mvARhPwExYt8Khx8kXc
         tDCRo0lTpL6t9c8BhIeZkOq1sMj2dlJX8CUXJRkitUoyI/vdMbh3q8FRVO3NvyLbBxqk
         FihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kQ9CIFj/0yA5lkn2VQDlB4wF9y682X7kblGc6IlYdLs=;
        b=c2few8HAuB1dupy1YgNyRf5dInFwnBK7oJsublNx5rWwZG/cLqHcEhb68vrO99TG4P
         /CtKOLwgVGnZShC+mA7Fjv69DPpjtsajbQ1SKACGvbdeR6ooBlHzdl1dT+EzUVUN4Fed
         sognNiLgZDnSfHdIQ37n0OiFkHph/JU7qHpjoONgPagDsSyggZEVv65eSfjc/mkING+Q
         gWWCcJM/lVNb/rS5WyhB14b4qPwXr2kEr23ke2eEdKLKHtt8q+KYGZ8fTkZmHtIpPjBg
         oQY+Cr2FclnSJksOGEUDNaNkEUUETl8EeyTUC0yMQq2CJzSeFf6CwT3jeLH2dkOTt47W
         kfAQ==
X-Gm-Message-State: ACrzQf2yqkYeuyQRFPHBn7tMSAivTIzZilT8ka9PlciwupHtmx42eGcu
        EN09Rs/tmXOrqPpPAXfPIvg=
X-Google-Smtp-Source: AMsMyM7ijbL67A8VElHVkiZRyWUR+o5GTFIGUAbBML1zE5glrZRA6s3Rx4WkLnL7LLkW+zxErIfSjQ==
X-Received: by 2002:a17:903:18d:b0:178:28d1:4a13 with SMTP id z13-20020a170903018d00b0017828d14a13mr13007105plg.160.1663593782642;
        Mon, 19 Sep 2022 06:23:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b0017680faa1a8sm993820plh.112.2022.09.19.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:23:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:23:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 21/21] hwmon: (mr75203) fix coding style space errors
Message-ID: <20220919132301.GA3547636@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-22-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-22-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:49PM +0000, Eliav Farber wrote:
> Fix: "ERROR: space required before the open parenthesis '('"
> 
> All of the errors were introduced before this series of patches.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter
