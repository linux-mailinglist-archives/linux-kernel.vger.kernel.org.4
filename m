Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D50611A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJ1SWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1SWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:22:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3754241B0E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666981325; x=1698517325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WdtycWAj7ZZzF2NnGQ8L1k0yKjh4DNQY2nx3zhBw42o=;
  b=VTTxUG0uePQxTWA3J7RPHs9QsXaDbnb27fnmf6YA7Kd5zHvOV+nUsJZ1
   IaM3jgY58pqVa6r0GKTlBkNPhtDbZSA53uUsqWuO2NorLvPXLx+F4iJqe
   n+mI9SXFDaP0szbdO2f71eDE2W8Xl17HxzynbYQ44oqvfdiLMWmxm2F2z
   edMaol+K44GmDDuc71613j7vN4l8Q9TITcKJGlJAZNTg5MUoKuAhPcDZa
   3maDxHhxitRwMnhX/gY3QShaoBIwsvF0zXPxtQGNNDuZDc+5XfdpqfBMH
   L6fbbHqkTw1dvX+8Y4YE2SYZPn3r9C9IIEyhaZL+d2nmPgP5aIWeGD7mT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="307287231"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="307287231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:21:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="722145510"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="722145510"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:21:57 -0700
Date:   Fri, 28 Oct 2022 11:21:55 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: Outreachy first patch wiki modification proposal
Message-ID: <Y1wdw5GC8ZUhXFKj@aschofie-mobl2>
References: <CAHJEyKU8YhVLg2k4c6H_B9YJo=Va=V8ea+vkgDKH8aUZBou0wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHJEyKU8YhVLg2k4c6H_B9YJo=Va=V8ea+vkgDKH8aUZBou0wA@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:35:48AM +0100, Tanju Brunostar wrote:
> After setting up my mutt with Gmail, I tested it by sending an email
> but it did not go through. After some research, I realized that Gmail
> no longer allows less secure apps. The way around this is to set up
> two step verification, then generate and use "App password". I would
> like to add this to the wiki, as this will save others from the
> additional work. Please let me know if I can proceed.

Hi Tanju,

This is an Outreachy specific question.
Please resend it to the Outreachy list only.

Thanks,
Alison

> 
> Thanks,
> 
> Tanju
> 
