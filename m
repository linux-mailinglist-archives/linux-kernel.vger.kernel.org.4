Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDA6C4F52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCVPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjCVPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:21:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32095F532;
        Wed, 22 Mar 2023 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ymz7yB6cbYqKNYSi++1QmEXQK8vFGrnnfNHKydr8KJU=; b=1LvptSAA5ASQ4t4tRAFgrNI812
        a7SPVmaFBSzq+y53wSdvvPIZmTXoDp08upRyxjvt6ug0zszVB9DHPCOIBbtS8XaWQFEwFHWrlGrkS
        G0HDKUPkKJsPq0x2CfLIDVWjIQh0LBwCm1XhXfDZH77VpttjNyoRrfVHDJZByh7Q3sqAL4svaJi0Y
        uFEqWDTCH6kPzfPCz2/IlaGGY+oi0LZgd0N0wVyzzenegAlAhiL4bgMbVgR9Cto0/9AcsdHbdTaNi
        YW4sWozBCM7d9SU+jP904ZFcahSgQmxgzepx800oQt8+CSwQa5E6WI5t6ntXxjfxBhFYAdfAm5Zca
        aXwRN0gg==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pf0Gp-00GUTZ-1E;
        Wed, 22 Mar 2023 15:20:59 +0000
Message-ID: <c93723aa-f01c-9f1e-c9c7-aa79f38390c1@infradead.org>
Date:   Wed, 22 Mar 2023 08:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mark Brown <broonie@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 01:51, Mirsad Goran Todorovac wrote:
> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
> syntax error in certain paths of the script execution.
> 

Fixes: 46dff8d7e381e ("scripts: merge_config: Add option to suppress warning on overrides")

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Cc: Mark Brown <broonie@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-of-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  scripts/kconfig/merge_config.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index 32620de473ad..902eb429b9db 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>  		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>  		BUILTIN_FLAG=false
>  		if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
> -			${WARNOVVERIDE} Previous  value: $PREV_VAL
> +			${WARNOVERRIDE} Previous  value: $PREV_VAL
>  			${WARNOVERRIDE} New value:       $NEW_VAL
>  			${WARNOVERRIDE} -y passed, will not demote y to m
>  			${WARNOVERRIDE}

-- 
~Randy
