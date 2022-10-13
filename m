Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC55FDDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJMP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:58:52 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E83EE8AA;
        Thu, 13 Oct 2022 08:58:47 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id n83so2175436oif.11;
        Thu, 13 Oct 2022 08:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss+Jh5JtGloc7s5Wbx0ajnNwFMxqRKR8S3W84woq5d0=;
        b=huS9p0nXQYIDA04DhHN43jASeJMXxjUBHsvF1las77K1M6XrgHb6IsaS2gzd88VKBN
         Tp44E6D24lq3mX9/a9l3Bwzb/QBGcfdUANBknnfNhddjNnfxgAoncgXt83BwEveHO+5o
         E5Z8AG0qjXj4nOJqLb6A+oriBPOeFimo5Ts1Zbl2/Vb2cGlEx1maDl1gARwhfpPd9iXV
         RL6QobzoRw4tG/h/mBfo7cE78PkZ1k1c66vBkQUOjanHyECvhtp3U3G1xQncQVARmmIL
         yk67ffPSBdLFJOI8/WvBdmC6A/o0uJITTAGFG8sCfyNexpudzHCEe3FqPVdsIzIsX/n/
         0LjQ==
X-Gm-Message-State: ACrzQf2OXDI9oQYQf5iTDoTZnobGsFYuCvNV7ekaDt1+hlNnKDm80Buq
        q1l+AfqiRDSvht4BQii3Iw==
X-Google-Smtp-Source: AMsMyM5iCHO0JebPra0Jg+Q6DZjAoX1inRqvj5SNPFERV5Md/M86KaJltPptRbNuIxKEmiNyrhO1Tg==
X-Received: by 2002:a05:6808:f05:b0:354:b362:c5be with SMTP id m5-20020a0568080f0500b00354b362c5bemr228112oiw.136.1665676726181;
        Thu, 13 Oct 2022 08:58:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e15-20020a4ada0f000000b0047f94375092sm2213226oou.40.2022.10.13.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:58:45 -0700 (PDT)
Received: (nullmailer pid 388475 invoked by uid 1000);
        Thu, 13 Oct 2022 15:58:47 -0000
Date:   Thu, 13 Oct 2022 10:58:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: of: collapse overlay entry into main
 device tree entry
Message-ID: <166567671481.388208.3399174487542913808.robh@kernel.org>
References: <20221012220548.4163865-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012220548.4163865-1-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 17:05:48 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Pantelis has not been active in recent years so no need to maintain
> a separate entry for device tree overlays.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Based on Linus' top of tree, 676cb4957396 d0d51a97063d,
> Wed Oct 12 11:16:58 2022 -0700
> 
>  MAINTAINERS | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 

Applied, thanks!
