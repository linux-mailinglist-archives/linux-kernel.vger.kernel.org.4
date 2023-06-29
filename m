Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D57420FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjF2HaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjF2HaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:30:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C8268A;
        Thu, 29 Jun 2023 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688023808; x=1719559808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZupkTMhjzPJVRJsKUBTHbm+BiJu2bzZf8FGMNMbgweQ=;
  b=eVq+qs5w8Dija9o0CXEPf4eakNfuyE8dGC39RFA7v/D4J+3oGdMhymOe
   oGDnnroHP9Py5kny1im4UY57S8baS0di1/gNCvCOl3Xylenyfq/QrYnQ2
   0d+eDubOPFmXSVYScdlrvzCEnpE4mmbxADJ+bVL/vZWaGQtHaqKtR7OOX
   QGtwgKlVhl6XuKDMTAOGDLhGP2L4Bn1t3sXMfTFrrgPk1HZeUXZvjFEks
   nSaIMp5BAp6QKqenLSiCWUab8Roil0zAju/7DJiSkc2B5/oH/ESv7ZBIU
   C0J+Xvv2k1eaSQJ3BFN4Gz6vcEJQu5K46ejZ3z1ORh4KUt5KTIZff5KR7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342380542"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="342380542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 00:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="717257606"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="717257606"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 00:30:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 709751207EB;
        Thu, 29 Jun 2023 10:30:01 +0300 (EEST)
Date:   Thu, 29 Jun 2023 07:30:01 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>,
        Hari Prasath <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan the OV7740 driver
Message-ID: <ZJ0y+ecxqHpdqsUi@kekkonen.localdomain>
References: <20230522134751.30489-1-nicolas.ferre@microchip.com>
 <ZGuJ7GqxDI0aZxK6@kekkonen.localdomain>
 <2b323110-428c-e2a0-9d2c-fbffd4524cf9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b323110-428c-e2a0-9d2c-fbffd4524cf9@microchip.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, Jun 28, 2023 at 10:59:16AM +0200, Nicolas Ferre wrote:
> Sakari,
> 
> On 22/05/2023 at 17:27, Sakari Ailus wrote:
> > Hi Nicolas,
> > 
> > On Mon, May 22, 2023 at 03:47:51PM +0200, nicolas.ferre@microchip.com wrote:
> > > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > 
> > > Wenyou's email is bouncing, remove him from this camera driver's entry
> > > and mark it as orphan.
> > > 
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > ---
> > > Wenyou, all,
> > > 
> > > If you want to take this driver, please don't hesitate to update this patch for
> > > a better maintenance. My only concern is the @microchip.com email address
> > > bouncing.
> 
> I'm sorry to insist, but bouncing email on our domain is becoming a real
> problem.
> I don't see this patch on Linux-next, so what can I do to make this move
> forward?
> 
> > What about the driver author (cc'd)?
> 
> I didn't hear about Songjun for a long time.

It's in my PR to Mauro here:

<URL:https://patchwork.linuxtv.org/project/linux-media/patch/ZJIVvXtDlP2OtS3X@valkosipuli.retiisi.eu/>

-- 
Sakari Ailus
