Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9366BEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAPNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjAPNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:09:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319F2202F;
        Mon, 16 Jan 2023 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673874448; x=1705410448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQR4PYqa4mE+bf4TUURtJBMGa6yXyz651NIX9P1G6Qs=;
  b=C5ZoJsr5KRd3uX1iFR1SyH7LS/BuvtBloLH0m9sQa3MqJ+LvK12Hs7Vc
   c1pdNX0h2AesB8knxS1ENDNqrMH+wl1JmHwWL/vfr+k/Tla8RijTbWBfy
   BwFTgx6jIW8XbC+tvzZJElj7u8TvXW3st/p4Y3cM9smkRk22yc0vscUP7
   zxz+TDpx9nuUzf5n7qrMjLeFtLIvZwVUxd5vJjPcZGo1RahNo3rjUNyOc
   JFIRi6s1DUj3TZMPjh9w0jzmjWCgJSE5x1topxJQOXCFkZAMCcL7Ewbe5
   cMlaVPmlZpAinY74L72CTn189rEYE2yZFW3dT4iBGeRGgloE/zmSq8mbz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="323157590"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="323157590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 05:07:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832831586"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="832831586"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 05:07:14 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3400E20165;
        Mon, 16 Jan 2023 15:07:11 +0200 (EET)
Date:   Mon, 16 Jan 2023 13:07:11 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v10 1/9] device property: Add remote endpoint to devcon
 matcher
Message-ID: <Y8VL/+My+s/PkG9L@paasikivi.fi.intel.com>
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-2-treapking@chromium.org>
 <Y8AL8nTcNcl6zX7H@paasikivi.fi.intel.com>
 <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaeN7KBi30M1fRWhTPgMbxF6=B+KuAS7Ny7+i9qCx+=49Q@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Thu, Jan 12, 2023 at 02:31:45PM -0800, Prashant Malani wrote:
> HI Sakari,
> 
> On Thu, Jan 12, 2023 at 5:32 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Pin-yen,
> >
> > On Thu, Jan 12, 2023 at 12:20:56PM +0800, Pin-yen Lin wrote:
> > > From: Prashant Malani <pmalani@chromium.org>
> > > +             /*
> > > +              * Some drivers may register devices for endpoints. Check
> > > +              * the remote-endpoints for matches in addition to the remote
> > > +              * port parent.
> > > +              */
> > > +             node = fwnode_graph_get_remote_endpoint(ep);
> > > +             if (fwnode_device_is_available(node)) {
> > > +                     ret = match(node, con_id, data);
> > > +                     if (ret) {
> > > +                             if (matches)
> > > +                                     matches[count] = ret;
> > > +                             count++;
> > > +                     }
> > > +             }
> >
> > Aren't you missing fwnode_handle-put(node) here??
> 
> It shouldn't be necessary. We aren't break-ing/continue-ing here,
> and fwnode_handle_put(node) is called latter in the loop [1][2]

It is, but node is overwritten just below this chunk --- before
fwnode_handle_put() is called on it.

> 
> BR,
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1256
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c#n1261

-- 
Regards,

Sakari Ailus
