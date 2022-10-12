Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B95FCBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJLTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJLTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:45:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3220193;
        Wed, 12 Oct 2022 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gFAmAkOYwXyRxUyhMA4f3R3/S6aTfOsWKqz4Ft0mgyM=; b=VdvChzVYSaUvDGnKMSGcZftAyQ
        FUinifD4cMXYyTKb29dc92zTvbzoMym9AQge/w42B2bC4t9qnrlB3/UWw7M40mj+NLYig3YatS0qj
        hwogvTWxVCrTVi95yz0GK3qANBsW/X06v37WTWbiJWfl+clFiFKbFwKlLEDOzGWvAsRX3fdUyazci
        nIiC2XsGkZcNL8ABJ6ut5c/Yeeo1jeD9jLSe76lFxp5duq20ZvK1AWxP7YfpmoU7FvCi7NIjGA54T
        p7oPaU0Q36KdKpTgbZoudSiBMgoKAHR4AWhytpacf291UohUk0z9h2rN0obLXFG9tzmtA22tCuhml
        aySqdA1A==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oihfQ-000OOu-Fo; Wed, 12 Oct 2022 21:45:24 +0200
Message-ID: <a49365e3-3b4c-2f82-99dc-0114e4dc64a1@igalia.com>
Date:   Wed, 12 Oct 2022 16:45:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/5] pstore/ram: Move pmsg init earlier
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Paramjit Oberoi <pso@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-3-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-3-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> Since the ftrace area can vary in size based on CPU count, move pmsg
> initialization earlier so it will have a stable location.
> 
> Suggested-by: Paramjit Oberoi <pso@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed: Guilherme G. Piccoli <gpiccoli@igalia.com>

Since I'm not using pmsg my tests are of limited scope here, so better
to consider I just reviewed the patch heh
Cheers,


Guilherme
