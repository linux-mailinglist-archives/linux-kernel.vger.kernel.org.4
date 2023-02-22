Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947BA69F832
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBVPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjBVPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:37:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAC2E806
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:37:38 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30E473F4A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677080242;
        bh=8JWkkKuY/mBsg2CPf/80E/i9Tneo0oqJt3Gz/3GLDP0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=W6JsaxrrKqSy2vwHXxTliRjOCidyVFfMr9JkWWaizxLNWk5hq5nWa8hwhdX+hL8qQ
         MpssmPbmaHUe/I8Fj8ik/ue37VEnDEOooTh70dxVnNjrmIgVpkqjbjI/o503qP9JX2
         oetHfD0s5VtLv7eS5CNgVeDP5cm9ZMxGPiw3iNB2SvURSxmECPMz+vE8SgJSlKkve9
         yMl98aLj+k5cdKVQzBRPIx56kP7mkRbuLnD2IQSccc1HMp1TdGUc+b4fNsV/E3a58C
         DEXIOjohCtMjtpmCaJ524KXd8BY+oKd0ErFfYjdNrb9m8pnSfegtt/p+4je8wZhxFB
         46c6fBaTZx/Ew==
Received: by mail-ed1-f70.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso8805923edh.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JWkkKuY/mBsg2CPf/80E/i9Tneo0oqJt3Gz/3GLDP0=;
        b=4gF3xP5sSeRXRuj3SB4ZIfiDStCtSv/Gl6LZXJJ2P8dqPMunJHGH344gy7guO2Lz5+
         98t8QyVZ3HxRqRA6CAxut4mR90JdXVVJNkeWhXboEUE++0q7IVe9w7pHbtDnlvzQgd+Q
         p0SVG+HEb6MFyNL3ls2mK8tEwt4dlu8RN4EuNPyhlUOcnslc3z1y4K6Nl6W7EYOEjURz
         edpJIBaxYfm5RULe8+ftoSbgKB/0W5sghh0+HWH5uLmfPYfpWWV+z9XaD3HRJEYXvVX+
         6sUAsBO9ljzmbFH2MoqG04cc9SuPBSX7umu9+s8n9gokRvoU//ov8Mpm1hDffwfazieb
         CWDA==
X-Gm-Message-State: AO0yUKW3Mifj2YL824Y+EVBv0geixn7QJlVH7SN4kJBqhjg9DFlfmyGC
        2t1U0ANsj4i4z9DXagcyR6UOmV8h4m7boSBCcmRZ1+a3YVzumY/lXKzQpj5D+thhhN3G9fPK5Uc
        sB4wA2vq76yN0TRtBkQXFkOplWhgnzyNvKoNAX0/6Mg==
X-Received: by 2002:aa7:d88f:0:b0:4ac:cb71:42c with SMTP id u15-20020aa7d88f000000b004accb71042cmr9373002edq.37.1677080241837;
        Wed, 22 Feb 2023 07:37:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8nplrbIbgKrRBuUUF6Neaqb+KCYt+AJHeHCvX+8WacNd7VJXttTkv6+JQA5aVbfqHpGQxCeA==
X-Received: by 2002:aa7:d88f:0:b0:4ac:cb71:42c with SMTP id u15-20020aa7d88f000000b004accb71042cmr9372978edq.37.1677080241536;
        Wed, 22 Feb 2023 07:37:21 -0800 (PST)
Received: from localhost (host-79-44-179-55.retail.telecomitalia.it. [79.44.179.55])
        by smtp.gmail.com with ESMTPSA id co10-20020a0564020c0a00b004aab66d34c7sm4286713edb.7.2023.02.22.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:37:21 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:37:20 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: fix shift-out-of-bounds in
 spi_nor_set_erase_type()
Message-ID: <Y/Y2sEZ5Ojos9fpg@righiandr-XPS-13-7390>
References: <20230221111346.34268-1-andrea.righi@canonical.com>
 <d87efbd8-5290-b462-beb3-c2d3be267ade@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87efbd8-5290-b462-beb3-c2d3be267ade@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 02:50:42PM +0000, Tudor Ambarus wrote:
> Hi!
> 
> This should be fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=f0f0cfdc3a024e21161714f2e05f0df3b84d42ad

Ah yes, this should definitely fix it.

It'd still like to do a check like is_power_of_2(size) in
spi_nor_set_erase_type(), to make sure we don't silently set size to
something non-standard, but I can send another patch for that, so for
now you can ignore this patch.

> 
> Which base did you use?

I used the latest git from Linus' repository that doesn't have this
commit yet.

Thanks,
-Andrea

> 
> Cheers,
> ta
> 
> On 2/21/23 11:13, Andrea Righi wrote:
> > It seems that according to JEDEC JESD216B Standard erase size needs to
> > be a power of 2, but sometimes we set the size to 0 (e.g., in
> > spi_nor_parse_4bait()) causing UBSAN warnings like the following:
> > 
> >    UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2026:24
> >    shift exponent 4294967295 is too large for 32-bit type 'int'
> >    Hardware name: Dell Inc. XPS 13 9300/077Y9N, BIOS 1.11.0 03/22/2022
> >    Call Trace:
> >     <TASK>
> >     show_stack+0x4e/0x61
> >     dump_stack_lvl+0x4a/0x6f
> >     dump_stack+0x10/0x18
> >     ubsan_epilogue+0x9/0x3a
> >     __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
> >     spi_nor_set_erase_type.cold+0x16/0x1e [spi_nor]
> >     spi_nor_parse_4bait+0x270/0x380 [spi_nor]
> >     spi_nor_parse_sfdp+0x47f/0x610 [spi_nor]
> > 
> > Fix by checking if size is a power when setting struct
> > spi_nor_erase_type, otherwise consider size, mask and shift as invalid.
> > 
> > Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
> > Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >   drivers/mtd/spi-nor/core.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index d67c926bca8b..3c5b5bf9cbd1 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2019,11 +2019,17 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
> >   void spi_nor_set_erase_type(struct spi_nor_erase_type *erase, u32 size,
> >   			    u8 opcode)
> >   {
> > -	erase->size = size;
> >   	erase->opcode = opcode;
> >   	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> > -	erase->size_shift = ffs(erase->size) - 1;
> > -	erase->size_mask = (1 << erase->size_shift) - 1;
> > +	if (likely(is_power_of_2(size))) {
> > +		erase->size = size;
> > +		erase->size_shift = ffs(erase->size) - 1;
> > +		erase->size_mask = (1 << erase->size_shift) - 1;
> > +	} else {
> > +		erase->size = 0u;
> > +		erase->size_shift = ~0u;
> > +		erase->size_mask = ~0u;
> > +	}
> >   }
> >   /**
