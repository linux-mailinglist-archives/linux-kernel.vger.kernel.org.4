Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B023611A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJ1STk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1STi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:19:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FCF55B1;
        Fri, 28 Oct 2022 11:19:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9B1A560C;
        Fri, 28 Oct 2022 18:19:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9B1A560C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666981169; bh=Oc5cMdKanGrG3AiQdbRR/5dfJXVOInrFY/Y/d7mf19w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O9z8oKHanbEgjMaZ5jB56/4e8hU4siOlE4MdLZQ7i/bC80VBFyv31JKvfCVXXJJRN
         n/tVLhiXBdKD9cotPj/qnf2f8sT/bFyEmJPpPH5ZWkiOzJrZ8oM7C/J8mI+WTmVNGS
         wVJW34Lp4U5tz+rYfWRMK6kE4svVrXdo1qxGDMhLmHVA1ZjhUpwe8d6Bm8zivPkdtl
         tTQvd8paOeAy58OKgeay6w2XvPgiyoF6Ofz7By961g2vTqoah197pDN5BQOM1InjGb
         QPv+7lS8NlkUlMICCM3ajsUDIDIEG7frKrDuApsbVSWtcSwnA2gbNk4BWArWgCPV+K
         AEBadMbq1Upjg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/sphinx: More depth in the rtd sidebar toc
In-Reply-To: <20221027104406.549734-1-daniel.vetter@ffwll.ch>
References: <20221027104406.549734-1-daniel.vetter@ffwll.ch>
Date:   Fri, 28 Oct 2022 12:19:29 -0600
Message-ID: <87tu3n6cb2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> We love to nest our documenation for good structure, but that means
> the table of contents needs to keep up or you can't navigate them.
>
> Realized this trying to find the drm property documentation, which
> with some shuffling around disappeared. Why I didn't realize we can do
> this earlier, no idea.
>
> Since the relevant parts of the toc are only loaded if you're in the
> right .html file there's no harm in going all the way to unlimited.
>
> Note that this has no impact on the classic theme (which doesn't have
> the sidebar) nor on the various :toctree: rendered inline in the
> output.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/conf.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 934727e23e0e..5dc141c66726 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -240,6 +240,10 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
>                  # Add color-specific RTD normal mode
>                  html_css_files.append('theme_rtd_colors.css')
>  
> +        html_theme_options = {
> +            'navigation_depth': -1,
> +        }
> +
>      except ImportError:
>          html_theme = 'classic'

So this patch isn't against docs-next, and applies to the RTD theme,
which is no longer the default.  I have no objection to it, but have you
looked at how your docs come out with the alabaster theme?

Thanks,

jon
