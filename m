Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82947131EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjE0CWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjE0CWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28612A;
        Fri, 26 May 2023 19:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B85D64FF3;
        Sat, 27 May 2023 02:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5B3C433EF;
        Sat, 27 May 2023 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685154156;
        bh=vDQHP/XT2oFMf+TOQJ2MrZQo5Zw3Av9pRLfJCl96WAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+0XUHGpzM0NFG39jsJ49VE5pvvz4wZX9szJPl0+lMj/vPby3JKZmAN/zI45tYazd
         +qpkEi+qY/Ma+7hVJbS6aS2kfNkTq204I/0+uEWnGXFOQyt8RgMCGOWSgdewcDXt9b
         M+xaQbwosOFCpqzC+G5YvMvYWkjKDvQ87FFHpQrUWuWQgmvv6b4S8JSKclTw3gKsyL
         aZqb7mUwIW0uRfHXIKpnLOvvuJkmfzZbn4EA0vFu5TgFTvqIsogKy0g25YBWcTNN97
         h892pzXlIjfEpReR23e/XspULDllHqDH7XX+pWQ0bIXIr9NXxlMmt1tWbhxLLqy486
         N0PJEjORnkFLQ==
Date:   Fri, 26 May 2023 20:23:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
Message-ID: <ZHFpoIoJbvmQwE/7@work>
References: <20230527020929.give.261-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527020929.give.261-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 07:09:33PM -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Fixed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
> ---
> v3:
>  - Switch to ERROR from WARN
>  - drop needless struct/union/enum prefix (joe)
>  - fix $fixed regs (joe)
> v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
> v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 30b0b4fdb3bf..5307c85b93d8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7430,6 +7430,21 @@ sub process {
>  			}
>  		}
>  
> +# check for array definition/declarations that should use flexible arrays instead
> +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> +		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> +			if ($1 == '0') {
> +				if (ERROR("ZERO_LENGTH_ARRAY",
> +					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> +				    $fix) {
> +					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> +				}
> +			} else {
> +				ERROR("ONE_ELEMENT_ARRAY",
> +				      "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
> +			}
> +		}
> +
>  # nested likely/unlikely calls
>  		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>  			WARN("LIKELY_MISUSE",
> -- 
> 2.34.1
> 
