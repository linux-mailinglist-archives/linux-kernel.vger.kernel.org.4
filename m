Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8633617E06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiKCNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKCNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:38:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A913D1A;
        Thu,  3 Nov 2022 06:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B50BCB8279B;
        Thu,  3 Nov 2022 13:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21A4C433D6;
        Thu,  3 Nov 2022 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667482677;
        bh=gawcDZeowT9wB7PlFAyKqWpC3J+QyRN7jsvw+U1PKe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SADon+tXRKutSGiqv7FUfI74t7fF8iWGhJiVM7eKBa0mGEUAebJbRasd+PCA+zI2S
         NANoQmKIUm1bHpS8SECPC/j5au0qr862KimHq+Z/jqyL8HhClbj0AThftqS8HN+XW9
         oW3fJCbX0VzMtwrmzQnf3ImEezqN8uutotTeAewU=
Date:   Thu, 3 Nov 2022 22:38:37 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     appanad@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 4/4] drivers: misc: Add Support for TMR Inject IP
Message-ID: <Y2PEXawGI/JhyaGK@kroah.com>
References: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
 <20221103091500.3022212-5-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103091500.3022212-5-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:45:00PM +0530, Appana Durga Kedareswara rao wrote:
> The Triple Modular Redundancy(TMR) provides functional fault injection by
> changing selected MicroBlaze instructions, which provides the possibility
> to verify that the TMR subsystem error detection and fault recovery logic
> is working properly.
> 
> Usage:
> echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault
> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

The test robot did not report the lack of this driver in the kernel and
need to be mentioned here, sorry.

