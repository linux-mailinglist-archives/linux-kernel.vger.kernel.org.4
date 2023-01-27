Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5958967DF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjA0IzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjA0Iy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:54:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A086C16F;
        Fri, 27 Jan 2023 00:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D54661A2A;
        Fri, 27 Jan 2023 08:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06C8C433D2;
        Fri, 27 Jan 2023 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674809695;
        bh=lB9w3CupJ1PsxfOhLwNQrL1keD+K3TROyKle0VM8Pk4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DOL/BUjcqDa9mBBOnyLaxzECdlrz9umxtfP/IGajHUAWcqeqShzZbcaDyyL9n7nCF
         s1RZ/SAXmzn1FnxYgBTkF4BCtnsDWAso7skeDcbbHSnfFwLPbnLw51W02PVxYEnbaw
         x/Kgk7jtnvcHWq0s42FnnZMKWr83r8Lzu7tKiiOn+VAa9GEv2ALtBYR8QNpFAd9HpY
         G82E+jzDVz1RLOp9k5GZF8pJWSBeoQbFIiWGkWCP1gyQnVrFbq1e371Xi/dus12KO8
         gIzKoeNfxckq5kNTb1aqTaoKttiuMDOGfyHChXGcLhiCBo8YETM4YOznjooFL6uGOY
         pEpbGHN0J7PKg==
Message-ID: <5c1d8862-4ee6-bd17-1a61-ec32689d0578@kernel.org>
Date:   Fri, 27 Jan 2023 09:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 31/35] Documentation: trace: correct spelling
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-32-rdunlap@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230127064005.1558-32-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 07:40, Randy Dunlap wrote:
> --- a/Documentation/trace/rv/runtime-verification.rst
> +++ b/Documentation/trace/rv/runtime-verification.rst
> @@ -31,7 +31,7 @@ In Linux terms, the runtime verification
>  *RV monitor* abstraction. A *RV monitor* includes a reference model of the
>  system, a set of instances of the monitor (per-cpu monitor, per-task monitor,
>  and so on), and the helper functions that glue the monitor to the system via
> -trace, as depicted bellow::
> +trace, as depicted below::
>  
>   Linux   +---- RV Monitor ----------------------------------+ Formal
>    Realm  |                                                  |  Realm

Do you mind making the rv part an independent patch?

Spiting it helps in the backport of the fix to stable/distro kernels.

-- Daniel
