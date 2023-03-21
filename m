Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122276C3B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCUUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCUUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:14:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219D5071F;
        Tue, 21 Mar 2023 13:14:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8B11E60502;
        Tue, 21 Mar 2023 21:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679429641; bh=TQEdItY2vyxAlOKBgsO2jX9jGV1XmxhFdm3ai7QRXXw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=E480oHfLw+FXqawLMtVmbocEqrzhsPzOKZLSOmjNdJ9u8MhMzwxY4/Qu/RY+dPeus
         jRYiH31Q/F/pq+RdIcriRehz+GyRP5KSi+T1+7XZMAsL/cuObOBjifl0q9kjqrZ/mr
         r2yEe3VX4IPHZ7Xeb3/M+eC1f1vfbtkBfpHRvP6Oh9W/CxcopXS+FADbSeO+QVR/Ya
         t1Z86sFwzPEE6k65yKAP4brq3LwJ49ij8mbJ1l7F4t+/+XIza8H2nkU/o5uOn+/elA
         sWoQL194PLcSsn6DiexSMqf+bEpkgid82usdsVv/CzNBZXGQYDfta88xdgjcubGK4y
         xDarDV3LiVx/g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wtGxC9Y8TI7z; Tue, 21 Mar 2023 21:13:59 +0100 (CET)
Received: from [192.168.1.4] (unknown [109.227.34.15])
        by domac.alu.hr (Postfix) with ESMTPSA id 19BA160500;
        Tue, 21 Mar 2023 21:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679429639; bh=TQEdItY2vyxAlOKBgsO2jX9jGV1XmxhFdm3ai7QRXXw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=YY8zlnyU0lpd5CLEnmwNF0sqSn9fZKKcg95ACK06K9KCVM7Ox4SMteXfQIjyBkZUT
         eagALcS2fBykwnhm8eI3i3+wOCFzFv2QG/c5IL6W7lUlytyNtL6B/IrxQEY0Y4P1ZZ
         eN6+DSlPvtxLBgqA8KBlN+FzM06HdP9hsG3XH1CDODHUWNn2j3bgj030rOzIBwslEg
         kvu6TRdTYDEGiTibCW9bbLPATU4AXTRLnL2t5SvW+rAT1WE8QozFK8iPRiktnbTTvz
         MlxWhPHc5HxX0aL7LoVnpiWNMGqHrDB33VW8zs2gOhPpTAKNUq+lVA6UFWBtzoGgKO
         O8pEVhiifqtug==
Message-ID: <7349a16f-6e7e-51d4-4686-ec7e688d891b@alu.unizg.hr>
Date:   Tue, 21 Mar 2023 21:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: BUG: scripts/kconfig/merge_config.sh: typo in variable name
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <17ab5a21-5512-5388-f9fa-c462b2ebd351@alu.unizg.hr>
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <17ab5a21-5512-5388-f9fa-c462b2ebd351@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/2023 2:04 PM, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> There is a typo in variable name in scripts/kconfig/merge_config.sh, with the
> script returning:
> 
> $ ./scripts/kconfig/merge_config.sh -y -m ../.config tools/testing/selftests/net/config
> ./scripts/kconfig/merge_config.sh: 148: ./scripts/kconfig/merge_config.sh: Previous: not found
> 
> Problem is probably best explained by this diff:
> 
> ---
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index 32620de473ad..902eb429b9db 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -145,7 +145,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>                  NEW_VAL=$(grep -w $CFG $MERGE_FILE)
>                  BUILTIN_FLAG=false
>                  if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
> -                       ${WARNOVVERIDE} Previous  value: $PREV_VAL
> +                       ${WARNOVERRIDE} Previous  value: $PREV_VAL
>                          ${WARNOVERRIDE} New value:       $NEW_VAL
>                          ${WARNOVERRIDE} -y passed, will not demote y to m
>                          ${WARNOVERRIDE}
> 
> Hope this helps.

P.S.

Later I thought of searching the committer of the patch that introduced the change,
so I Cc:ed Mark.

Best regards,
Mirsad

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
