Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B716C45FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCVJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCVJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:15:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5598474C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8885ECE1C65
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39D7C433EF;
        Wed, 22 Mar 2023 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679476508;
        bh=D8DRK+QZE59dhFQsf9xzQhrYLsVzAAAWenD0VA+bkEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8ixtqtdTFeK0aVNTLd3B0RRs7Jm8MCJUWaI2ZxnyaAo/aPNGWKT7jxfv4F2ej3wt
         mTUNQRMY9c1W4+AQEMuFtxUf/7/4vrHSVI3sNzu27COv+XYho6wiDIoBa+eG3PfxBR
         XWLPAOTNYUjRnVyGADJWOExrCZPo14oedpZ5qAQg=
Date:   Wed, 22 Mar 2023 10:15:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] staging: rtl8192e: Remove unused macro
 queue_delayed_work_rsl and queu..
Message-ID: <ZBrHGTQakbMDbAX8@kroah.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
 <4f08897d188c61fc2e611afbf9f2de2ba18cffef.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f08897d188c61fc2e611afbf9f2de2ba18cffef.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 08:13:32PM +0100, Philipp Hortmann wrote:
> Remove unused macro queue_delayed_work_rsl and queue_work_rsl.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Your subject line here looks odd, with the abbreviation.  Same for the
other commits in this series, please spell the last word out, it's fine
to be a little bit longer to make things more obvious what is going on
(i.e. I have no idea what "f." is in a subject line...)

thanks,

greg k-h
