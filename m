Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750575E9453
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIYQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiIYQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:19:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D372233;
        Sun, 25 Sep 2022 09:19:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k10so7434598lfm.4;
        Sun, 25 Sep 2022 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=J9KMqJi/q6W4clyZw0NlrkwRki9TMO0lxNcnvx1Dx7M=;
        b=DSAJvMB5y7LrdMIgz2mEY5jZTvcYCFvJqeOmULmTDrFFtElW0jkSccyqTuaYDQHVA4
         jmJsWaKuoTEiQ5B71N4r6DHehQO4cf3se6jlQcU8VuOI71EJu9Zk5SwFRIE/SEyemsiF
         5tqdTPOd7QGho3eAGH6iuUFhFd2Lah9OWeLjsBm47AZwPck3xy+80e315dbPgaHK0NCh
         3nb+pK6mLbl5yH5AScwXh2/WbReQXoBDCGwECEGlNvv0E/DmpyAsiMvQ9v25HaFpmQ1A
         t0CdcPTqXWWodO83QxXbagw/+c5cfgZFo+f/YQTHKaQ9+MIWA2rKWTYTN2SNj6OfUREU
         5HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=J9KMqJi/q6W4clyZw0NlrkwRki9TMO0lxNcnvx1Dx7M=;
        b=uHwPIsautUpwbO1M+g0kJeZJqewYEK539kDy+X5Pc8b6PzuGuH6e/sU+Yt+qdqNrsE
         uo3Aq7nekPXP5DB/SCS5ONuB1y0asKuqMQ5Zk87DhcV6J7Xuvkema7J7p7QuEOotdkm2
         iL9fpXFHPGcK53k2GuiHzllrsaOKS8//c0Gw/n9whSJYL+D9nyICrab5aUm2NdvtFFzf
         wXdqzGiB6tSp2vzTTmFjyXHRRnPEv6I6YShwIjPyFjY8TVa5D88562ywrJ5N0JkrZy6j
         Ubwft4pQxuHlUwoh464WxtBWKe9wqRZz341zkn47VKHbAwYRqLYKXT5jMfzHkN/nYuxw
         VqNg==
X-Gm-Message-State: ACrzQf3R9JnmMrovff8Au6ibbgRvDvb68cqj+w3NScnhV/E+/XZ585He
        g2LmqX6DD94uxlfVHP3vIik=
X-Google-Smtp-Source: AMsMyM4VQ4kfS/T8BAv5BTaYjOoI6VwKUlODD/pVTfaN8Ipg3GLRgOBNVr58j3q1TI/QIOB4wslv5Q==
X-Received: by 2002:a05:6512:3e13:b0:499:1829:5181 with SMTP id i19-20020a0565123e1300b0049918295181mr7363944lfv.71.1664122769424;
        Sun, 25 Sep 2022 09:19:29 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c3-20020a05651221a300b0048b08e25979sm2248212lft.199.2022.09.25.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 09:19:28 -0700 (PDT)
Date:   Sun, 25 Sep 2022 19:19:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 09/23] ata: libahci_platform: Parse ports-implemented
 property in resources getter
Message-ID: <20220925161926.hc6txrf7yklqen7s@mobilestation>
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
 <20220909193621.17380-10-Sergey.Semin@baikalelectronics.ru>
 <20220919215014.GA336081@roeck-us.net>
 <7872df9d-db4e-0617-84eb-e47394774322@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7872df9d-db4e-0617-84eb-e47394774322@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:55:59AM +0900, Damien Le Moal wrote:
> On 9/20/22 06:50, Guenter Roeck wrote:
> > On Fri, Sep 09, 2022 at 10:36:07PM +0300, Serge Semin wrote:
> >> The ports-implemented property is mainly used on the OF-based platforms
> >> with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
> >> the same of_property_read_u32()-based pattern has already been implemented
> >> in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
> >> drivers let's move the property read procedure to the generic
> >> ahci_platform_get_resources() method. Thus we'll have the forced ports
> >> mapping feature supported for each OF-based platform which requires that,
> >> and stop re-implementing the same pattern in there a bit simplifying the
> >> code.
> >>
> >> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >> ---
> >>  drivers/ata/ahci_mtk.c         | 2 --
> >>  drivers/ata/ahci_platform.c    | 3 ---
> >>  drivers/ata/ahci_st.c          | 3 ---
> >>  drivers/ata/libahci_platform.c | 3 +++
> >>  4 files changed, 3 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
> >> index 1f6c85fde983..c056378e3e72 100644
> >> --- a/drivers/ata/ahci_mtk.c
> >> +++ b/drivers/ata/ahci_mtk.c
> >> @@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
> >>  				   SYS_CFG_SATA_EN);
> >>  	}
> >>  
> >> -	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
> >> -
> >>  	return 0;
> >>  }
> >>  
> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >> index 28a8de5b48b9..9b56490ecbc3 100644
> >> --- a/drivers/ata/ahci_platform.c
> >> +++ b/drivers/ata/ahci_platform.c
> >> @@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
> >>  	if (rc)
> >>  		return rc;
> >>  
> >> -	of_property_read_u32(dev->of_node,
> >> -			     "ports-implemented", &hpriv->force_port_map);
> >> -
> >>  	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> >>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> >>  
> >> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> >> index 7526653c843b..068621099c00 100644
> >> --- a/drivers/ata/ahci_st.c
> >> +++ b/drivers/ata/ahci_st.c
> >> @@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
> >>  
> >>  	st_ahci_configure_oob(hpriv->mmio);
> >>  
> >> -	of_property_read_u32(dev->of_node,
> >> -			     "ports-implemented", &hpriv->force_port_map);
> >> -
> > 
> > With arm:allmodconfig, this results in:
> > 
> >   CC [M]  drivers/ata/ahci_st.o
> > drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> > drivers/ata/ahci_st.c:147:24: error: unused variable 'dev' [-Werror=unused-variable]
> >   147 |         struct device *dev = &pdev->dev;
> > 
> > Guenter
> 

> Just pushed a fix for this in ata tree for-next and for-6.1 branches. The
> problem should be resolved with the next linux-next merge.

Once again thanks for sending the fix for my mistake.

Regards,
-Sergey

> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
