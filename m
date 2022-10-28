Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97824610CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ1JJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1JJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94011C5E2E;
        Fri, 28 Oct 2022 02:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864C3626E0;
        Fri, 28 Oct 2022 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74511C433C1;
        Fri, 28 Oct 2022 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666948159;
        bh=RGBB2Ds6KvaSSk72Wmt9bi6lszvk4rGShRFwuTuN3Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxE2s0teOXd6UQ/qF2kxUnkr+k1Tk6mQXi6Yd/eNkrHM6WQaNGV3VeHywTdyG0paI
         qCDyBEJMURiAppT/ExTc3q6eBKczDd05PVj7noyKFvqRP7y6GazVKNbVdGnL2//X9Z
         34XsdbCbdhSsV9Y0z8GOXrSo1vRek2PU5EJjf90k=
Date:   Fri, 28 Oct 2022 11:09:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     appanad@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RESEND PATCH v5 0/4] drivers: misc: Add support for TMR Manager
 and Inject IPs
Message-ID: <Y1ucPco2aRbQWfK1@kroah.com>
References: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:31:02PM +0530, Appana Durga Kedareswara rao wrote:
> This patch series adds support for TMR Manager and TMR Inject IPs.
> The TMR Manager is responsible for handling the TMR subsystem state,
> including fault detection and error recovery. The core is triplicated
> in each of the sub-blocks in the TMR subsystem, and provides majority
> voting of its internal state.
> The TMR Inject core provides functional fault injection by changing
> selected MicroBlaze instructions, which provides the possibility to
> verify that the TMR subsystem error detection and fault recovery logic
> is working properly.
> 
> For more details about TMR Manager and Inject IPs please refer PG268[1].
> 
> [1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268
> 
> Appana Durga Kedareswara rao (4):
>   dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
>     Manager
>   drivers: misc: Add Support for TMR Manager
>   dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
>   drivers: misc: Add Support for TMR Inject IP

Why is this a RESEND?

What happened to the first v5 series?

confused,

greg k-h
