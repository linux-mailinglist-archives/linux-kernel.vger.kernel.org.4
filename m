Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8872DDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjFMJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjFMJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:37:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0572C3;
        Tue, 13 Jun 2023 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686649042; x=1718185042;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sK4SMOaK62ydzdde+segKUntckMsJWrxYGQGbFSDWmo=;
  b=LZabzckD+RYtDG+d15qftD3dl4KHnBZBBFiUJeUwqypEhebGScvCNR6T
   zyGT80UM/MCGgVGJT6dqjx62Vh7hAiXQ51RQo+dtmBrM441AC6cTuUKee
   yUeF371VTHFneThpvaJI2eSVq9VXjI0YRALe7lq03OaQ76znmXpI5wpob
   BSBj94oeZ+T8QdQ7kSFV2YcRgbxYvZd0RN6k3Teuri0aAfzLqi7ajqsof
   /C7SySGXqCAewagkaY/rZNsm3/q9wQYNYzzC0/PRq96AltH3Jw/iSYkyr
   z2fbtQNGVXpginnN5laKSho4Zv90e6JJV/+SaCOu2xHOI6pr/Cotlzozz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337916456"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="337916456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824325090"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="824325090"
Received: from abujor-mobl.ger.corp.intel.com ([10.249.44.113])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:36:50 -0700
Date:   Tue, 13 Jun 2023 12:36:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <20230612025355.547871-2-ychuang570808@gmail.com>
Message-ID: <6af0e528-096-391-43db-c07659e46e9@linux.intel.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com> <20230612025355.547871-2-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1313138601-1686648986=:2099"
Content-ID: <205652a6-becb-10ae-b038-af463b408a16@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1313138601-1686648986=:2099
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <006fe4-6e79-c630-fb6f-8b81dee31dff@linux.intel.com>

On Mon, 12 Jun 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> It supports full-duplex communication, FIFO control, and
> hardware flow control.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-1313138601-1686648986=:2099--
