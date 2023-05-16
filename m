Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B08705016
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjEPOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjEPOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A11FE3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9901163A58
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7210AC433D2;
        Tue, 16 May 2023 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684245599;
        bh=RgXUB8U9LXn46MjhwEIA4Tcw8LGTx3bvjUBiOiBdWtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU9lgSFE0CgUeEoV2RiiLXuj//7fUOLVHsZIboBuaF10dHQ8x3sHDq0+45y3M8YfA
         EPHQGYyALRn+EfVIoOfEPiP0It1LWQORSRWEEQiQ5SB2/glfuF3BLUvwINCPa2VsNo
         NmDodr14LZhbaLcyU2EHBc/QE09ZKNkWzwahw8gvH4QJ3lxyCciFgRnO5gOMK8osJm
         nq6xT+pZVajU2Acheh9PE9j8Nhf1qciFsEEANVeylt2jBFzr5DaQV9XcTijr/EjFbG
         8SNQd+LhxpUSI0b0mdeeMRMayImFcbnCSu+nYOMlwRP3Wzy+4HRFv8MuVff9WygS36
         2Y9S+SCuhxJJg==
Date:   Tue, 16 May 2023 06:59:56 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/7] x86: retbleed=stuff fixes
Message-ID: <20230516135956.35bnxekprirnv2fc@treble>
References: <20230116142533.905102512@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230116142533.905102512@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:25:33PM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> Patches to address the various callthunk fails reported by Joan.
> 
> The first two patches are new (and I've temporarily dropped the
> restore_processor_state sealing).
> 
> It is my understanding that AP bringup will always use the 16bit trampoline
> path, if this is not the case, please holler.

Ping?

-- 
Josh
