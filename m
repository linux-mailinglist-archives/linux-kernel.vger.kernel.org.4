Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF346CD7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjC2Knr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjC2Kni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:43:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5853C29;
        Wed, 29 Mar 2023 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680086617; x=1711622617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5W+blnKT1Yo9sFK/xzAQKVqqGYFjD25kZeGLG5VryJU=;
  b=N6MOu08pB4ARFwcJrL4lpT1Q2w8xlBjIO6WwGzKq/Of9aGb4FD2UPgRj
   mPHuJ5ZGBM5E8OPyXta6pOWl4QZLMJl8tvFIioLFrMxG0yIJJCFaXoX6O
   zfzPnixGAJaIOZfJovj2NCz9HKk45Sa0+LBFnXP8PNGTJSkMAzNzLP2En
   nuc3fqxuVp373mAgutZs1aXVyOZYbHLGhtRFaMGtGkcaXz7SHNiu1J3c7
   oc+pvFG6DMxgbEVN4S+XKLJ7zpZcA8aI3zseoQ/w3IM0O9U8He2CPRwC9
   tNMb1Ih/7sVnEwjcJ8iSsaqaKtvICJycr1DCQcT8SjKocSvEq/SMHLSlA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427117010"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="427117010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827845454"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="827845454"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 29 Mar 2023 03:43:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 29 Mar 2023 13:43:33 +0300
Date:   Wed, 29 Mar 2023 13:43:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, vigneshr@ti.com,
        srk@ti.com, r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: tps6598x: make interrupts optional
Message-ID: <ZCQWVfyVVecCYHDb@kuha.fi.intel.com>
References: <20230324131853.41102-1-rogerq@kernel.org>
 <20230324133741.43408-1-rogerq@kernel.org>
 <271f0be0-9cb2-0c74-c112-33020e9a7342@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271f0be0-9cb2-0c74-c112-33020e9a7342@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:05:33AM +0300, Roger Quadros wrote:
> Hi Heikki & Rob,
> 
> On 24/03/2023 15:37, Roger Quadros wrote:
> > The driver can poll for interrupt status so interrupts
> > can be optional. It is still recommended to use the
> > interrupt line. Polling should only be used for debug
> > and prototyping.
> > 
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > index 348a715d61f4..8c2db282735a 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > @@ -35,8 +35,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-names
> >  
> >  additionalProperties: true
> >  
> 
> We need this patch as well along with the driver changes [1]
> Could you please Ack. Thanks!

I can give my ack FWIW, but we should still wait for Rob.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
