Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163D732766
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbjFPGX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjFPGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D434F2D5E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CF960AEF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9D8C433C9;
        Fri, 16 Jun 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686896533;
        bh=Pzh3hW5JFUONnxcP1hd5+KawZ7rF6rKBp/CFZiMitnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJvtsUDj76rED5uBity4tQOwdKC+j6Pv5xwS58J7Jx1Dci6tufGMGFbT54pJg1OUj
         BXTBD6AW47mO0XxKEU2zd4i1Cuwc4DulfW4RKviliglaHfnPjJ7C8zvzpeu5GCsEXp
         a5VO1M2Eg9mrPyIJvEDqhkMVOo6qgdR1lA0+MwEg=
Date:   Fri, 16 Jun 2023 08:22:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com
Subject: Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Message-ID: <2023061647-upward-petty-7695@gregkh>
References: <20230616055913.2360-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:59:05PM +0800, Alison Wang wrote:
> This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.
> 
> Ethos-U Linux driver is to provide an example of how a rich operating
> system like Linux can dispatch inferences to an Arm Cortex-M subsystem,
> consisting of an Arm Cortex-M and an Arm Ethos-U NPU.

What is an "inference"?

Where are the userspace tools (if any) that are needed for this driver
to work properly?

thanks,

greg k-h
