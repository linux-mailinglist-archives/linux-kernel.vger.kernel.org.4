Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BC5B9903
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIOKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:43:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF958DCE;
        Thu, 15 Sep 2022 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663238620; x=1694774620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLWgR64O2sMHHi4b8YpQoNd7rQDRs8Hs5xyjBuOfPko=;
  b=mdalCxHl3qLFn7p3gofcLV9SZQHcVV2Lj37cQCBRXdM+PyeSO5l/KtH8
   FqEspZKgB/6eod178qrPtSMM1XjMNOejny5gch+TF8Eib40d79vEe/f8H
   Dx/3sPwNALQT3T6Txc+MXCeNT/OL9afw/CXk8eOcberxBb3SA1McUl1vh
   CKnB4TrTtW3Quua4OZP6hJCKG5AITJqssQo1VGaHZk+ZlUiIoNteP/Pgv
   cFkRDDO2iI+wv5rQfV5CSRYdPnDMcY21qY0sUf82boejXqJOb1xinJgYh
   X5JpyZxlsQwI2c6TedYOfscI420xdz/I2WCGNfrXaHawjzP4oppS01MTy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362638027"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="362638027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 03:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="647779489"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2022 03:43:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1CE3F235; Thu, 15 Sep 2022 13:43:52 +0300 (EEST)
Date:   Thu, 15 Sep 2022 13:43:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] gpiolib: acpi: Add wake_capable variants of
 acpi_dev_gpio_irq_get
Message-ID: <YyMB6Nnp8A8HBeAZ@black.fi.intel.com>
References: <20220914235801.1731478-1-rrangel@chromium.org>
 <20220914155914.v3.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914155914.v3.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:57:53PM -0600, Raul E Rangel wrote:
> The ACPI spec defines the SharedAndWake and ExclusiveAndWake share type
> keywords. This is an indication that the GPIO IRQ can also be used as a
> wake source. This change exposes the wake_capable bit so drivers can
> correctly enable wake functionality instead of making an assumption.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
