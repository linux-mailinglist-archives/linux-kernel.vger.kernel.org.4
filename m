Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E771F36E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjFAUIf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjFAUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:08:30 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833C138;
        Thu,  1 Jun 2023 13:08:26 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 0618E1A04AF;
        Thu,  1 Jun 2023 20:08:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 557008000F;
        Thu,  1 Jun 2023 20:08:21 +0000 (UTC)
Message-ID: <ce30e9e307da06dfec01e6449c21800d76460fc5.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: Check for 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 01 Jun 2023 13:08:20 -0700
In-Reply-To: <20230601160746.up.948-kees@kernel.org>
References: <20230601160746.up.948-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: ppinc1qfgk6rr5spk1hxijkoh9hz6eh3
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 557008000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KLJzUsBEQcNiBmqKMM/zQEQZKptB1Y9c=
X-HE-Tag: 1685650101-708701
X-HE-Meta: U2FsdGVkX1+FHx8tGyJoZOe+OF3X0srvbxMiM5oPexh+a3IFh97yRybp4/rpMwgzvNMZP2LHrfvKspl7gxTM98d1xGMXaL4koff9bgNdI6Zrg+ZYt5s/9piPp++sEYhSxk+/K9JyHomHEx+OYkIi9FCwaVARSmev1i1UkH+bsTpS8dmPC14P2cERVZ3wy09egLfGJ+6QDh9AqDoZvO9GrmPWBXafO6eiuR5Hnv39MxgM+Jz5QTMEdsPiVS+rzn6Vew4enLgx2Af5q9BmJMhUmJk2UHuL59ZDpvXPqCW3ZovzouV7Pn44Qc6Tr1HFBN0fayhkbsYs5S1qC34LxnPToJt/sWsj66sUwRObP2KEWJaCXwyWff0ZhOPBYqi+wfJBoUB3cebPz8Zg9LF4yce4V34FRqc+NhVStzCs22SkKxOe7Dx6FJzi5CqkHxxr7GYmTZhB3VB8wGRH3OXbXy7TKj712A/wbaraIZV3T5vRUnZ+04BgmGX+UaYHXeawPwjwqFaBhKlq3ESLKi5Ktr64KkCW0eOHGYaIHEREE2olpmQdS/AieMDHWZ7Qf9iWcQ9Wkvv1bXpDltHZ2PWTMGK+ABFAvVD9wkZk
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 09:07 -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Fixed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org

Acked-by: Joe Perches <joe@perches.com>

> ---
> v5: - add __packed to outer struct regex too (joe)
> v4: https://lore.kernel.org/lkml/20230531004929.you.436-kees@kernel.org
> v3: https://lore.kernel.org/r/20230527020929.give.261-kees@kernel.org
> v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
> v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
> ---
>  scripts/checkpatch.pl | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 30b0b4fdb3bf..7bfa4d39d17f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7430,6 +7430,16 @@ sub process {
>  			}
>  		}
>  
> +# check for array definition/declarations that should use flexible arrays instead
> +		if ($sline =~ /^[\+ ]\s*\}(?:\s*__packed)?\s*;\s*$/ &&
> +		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> +			if (ERROR("FLEXIBLE_ARRAY",
> +				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
> +			    $1 == '0' && $fix) {
> +				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> +			}
> +		}
> +
>  # nested likely/unlikely calls
>  		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>  			WARN("LIKELY_MISUSE",

