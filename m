Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BDA5F591E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJER2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJER2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:28:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D67E032;
        Wed,  5 Oct 2022 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664990899; x=1696526899;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=J0ixBjZgHg9dB/N4umo0rSQEKiaexvmJgnC4Ny9BMbc=;
  b=i5QePl049uDvhO+WYGbS60Rj+/B0N7MDREoCdMdZKMZGMYjvlV7BVJmT
   0TJBV1DWrBY6YSn8+gw4YM5QrxiC/qp7VRmEcaV3LG4YE620gfe6dGhoQ
   2IkvXs538rAgNG2VE3Zl3r1SFlqc5NE4d4CYM1ZJmTIX/jq2MWga4QNZv
   keJNEG831suP9aQbvcGgs1ELNs+HZQsQiR2d5XgmyExJhBhOtQpY7Qn7i
   WP46dLIBrxYpqPbNrIXViDE6f4EpsuEVZYDbDlEgF4KdEJWrZfjeaelF5
   b+xI7slZzfdS/dC0b476/SPxrqB13QFvaaQEfoVTmg6/uA2UYKSW3rQ4P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282934345"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282934345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 10:28:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602088845"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="602088845"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.39.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 10:28:15 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/5] docs: tweak some Alabaster style parameters
In-Reply-To: <20221004201222.281845-3-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221004201222.281845-3-corbet@lwn.net>
Date:   Wed, 05 Oct 2022 20:28:13 +0300
Message-ID: <87lepuqixe.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022, Jonathan Corbet <corbet@lwn.net> wrote:
> This is just the beginning: tighten up the layout a bit to improve the
> information density in the browser.  To that end, add a custom.css file to
> tweak Alabaster CSS settings.

Maybe it's just me, but on the wide 4K screen I have the page_width =
940px default is silly narrow.

BR,
Jani.



>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py                  |  1 +
>  Documentation/sphinx-static/custom.css | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 Documentation/sphinx-static/custom.css
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 629f4afeb0eb..b924b266a70f 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -345,6 +345,7 @@ if  html_theme == 'classic':
>  else:
>      html_theme_options = {
>          'description': get_cline_version(),
> +        'font_size': '14px',
>      }
>  
>  sys.stderr.write("Using %s theme\n" % html_theme)
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
> new file mode 100644
> index 000000000000..c465251e840a
> --- /dev/null
> +++ b/Documentation/sphinx-static/custom.css
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * CSS tweaks for the Alabaster theme
> + */
> +
> +/* Shrink the headers a bit */
> +div.body h1 { font-size: 180%; }
> +div.body h2 { font-size: 150%; }
> +div.body h3 { font-size: 130%; }
> +
> +/* Tighten up the layout slightly */
> +div.body { padding: 0 15px 0 10px; }

-- 
Jani Nikula, Intel Open Source Graphics Center
